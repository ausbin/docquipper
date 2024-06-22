-- Import Quipper library
import Quipper

-- Define the Oracle data type
data Oracle = Oracle {
    qubit_num :: Int,
    function :: ([Qubit], Qubit) -> Circ ([Qubit], Qubit)
}

-- Phase inversion function
phase_inversion :: (([Qubit], Qubit) -> Circ ([Qubit], Qubit)) -> ([Qubit], Qubit) -> Circ ([Qubit], Qubit)
phase_inversion oracle (top_qubits, bottom_qubit) = do
    -- Apply the oracle function to the qubits
    oracle (top_qubits, bottom_qubit)
    return (top_qubits, bottom_qubit)

-- Inversion about mean function
inversion_about_mean :: ([Qubit], Qubit) -> Circ ([Qubit], Qubit)
inversion_about_mean (top_qubits, bottom_qubit) = do
    -- Apply X gate to top qubits
    mapUnary gate_X top_qubits

    -- Separate target and control qubits
    let target_qubit = last top_qubits
    let controlled_qubits = init top_qubits

    -- Apply Hadamard and conditional phase shift operations
    hadamard_at target_qubit
    qnot_at target_qubit `controlled` controlled_qubits
    hadamard_at target_qubit

    -- Apply X gate again to top qubits
    mapUnary gate_X top_qubits
    return (top_qubits, bottom_qubit)

-- Grover search circuit
grover_search_circuit :: Oracle -> Circ ([Bit])
grover_search_circuit oracle = do
    -- Initialize qubits
    let n = qubit_num oracle
    let index = floor (sqrt (2 ** fromIntegral n))
    top <- qinit (replicate n False)
    bottom <- qinit True

    -- Apply Hadamard gate to all qubits
    mapUnary hadamard top
    hadamard_at bottom

    -- Grover's iteration loop
    for 1 index 1 $ \_ -> do
        -- Phase inversion
        (top, bottom) <- phase_inversion (function oracle) (top, bottom)

        -- Inversion about mean
        (top, bottom) <- inversion_about_mean (top, bottom)
        return ()

    -- Measure the qubits and return result
    hadamard_at bottom
    (top, bottom) <- measure (top, bottom)
    cdiscard bottom
    return top

-- Define the oracle for the specific case (x0 = 5)
oracle_five :: Oracle
oracle_five = Oracle {
    qubit_num = 3,
    function = oracle_five_function
}

-- Oracle function definition
oracle_five_function :: ([Qubit], Qubit) -> Circ ([Qubit], Qubit)
oracle_five_function (controlled_qubit, target_qubit) = do
    qnot_at target_qubit `controlled` (controlled_qubit .==. [True, False, True])
    return (controlled_qubit, target_qubit)

-- Main function to run the Grover's algorithm
main :: IO ()
main = print_simple ASCII (grover_search_circuit oracle_five)
