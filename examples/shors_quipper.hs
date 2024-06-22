-- Import the core Quipper module and Quantum Fourier Transform module
import Quipper
import Quipper.Libraries.QFT

-- Define the Oracle data type
data Oracle = Oracle {
    top_num :: Int,
    bottom_num :: Int,
    function :: ([Qubit], [Qubit]) -> Circ ([Qubit], [Qubit])
}

-- Shor's algorithm circuit
shor_circuit :: Oracle -> Circ [Bit]
shor_circuit oracle = do
    -- Create the ancillae
    top_qubit <- qinit (replicate (top_num oracle) False)
    bottom_qubit <- qinit (replicate (bottom_num oracle) False)
    label (top_qubit, bottom_qubit) ("top_qubit", "bottom_qubit")

    -- Apply Hadamard gate to top qubits
    mapUnary hadamard top_qubit

    -- Call the oracle
    function oracle (top_qubit, bottom_qubit)

    -- Measure and discard bottom qubits
    bottom_qubit <- measure bottom_qubit
    cdiscard bottom_qubit

    -- Apply Quantum Fourier Transform
    top_qubit <- qft_big_endian top_qubit

    -- Measure top qubits and return results
    measure top_qubit

-- Main function
main :: IO ()
main = print_simple ASCII (shor_circuit mod15_base7_oracle)

-- Define the mod15_base7_oracle
mod15_base7_oracle :: Oracle
mod15_base7_oracle = Oracle {
    top_num = 3,
    bottom_num = 4,
    function = mod15_base7_function
}

-- Function for the mod15_base7_oracle
mod15_base7_function :: ([Qubit], [Qubit]) -> Circ ([Qubit], [Qubit])
mod15_base7_function (top_qubit, bottom_qubit) = do
    let x1 = top_qubit !! 1
    let x2 = top_qubit !! 2
    let y0 = bottom_qubit !! 0
    let y1 = bottom_qubit !! 1
    let y2 = bottom_qubit !! 2
    let y3 = bottom_qubit !! 3

    -- Apply quantum gates according to the oracle specification
    qnot_at y1 `controlled` x2
    qnot_at y2 `controlled` x2
    qnot_at y2 `controlled` y0
    qnot_at y0 `controlled` [x1, y2]
    qnot_at y2 `controlled` y0
    qnot_at y1 `controlled` y3
    qnot_at y3 `controlled` [x1, y1]
    qnot_at y1 `controlled` y3

    return (top_qubit, bottom_qubit)
