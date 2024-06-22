-- Import Quipper library
import Quipper

-- Define Oracle data type
data Oracle = Oracle {
    qubit_num :: Int,
    function :: ([Qubit], Qubit) -> Circ ([Qubit], Qubit)
}

-- Deutsch-Jozsa circuit function
deutsch_jozsa_circuit :: Oracle -> Circ [Bit]
deutsch_jozsa_circuit oracle = do
    -- Initialize qubits
    top_qubits <- qinit (replicate (qubit_num oracle) False)
    bottom_qubit <- qinit True
    label (top_qubits, bottom_qubit) ("|0>","|1>")

    -- Apply Hadamard gate to all qubits
    mapUnary hadamard top_qubits
    hadamard_at bottom_qubit

    -- Call the oracle function
    function oracle (top_qubits, bottom_qubit)

    -- Apply Hadamard again to the top qubits
    mapUnary hadamard top_qubits

    -- Measure the bottom qubit and discard it
    bottom_bit <- measure bottom_qubit
    cdiscard bottom_bit

    -- Measure the top qubits
    top_bits <- measure top_qubits
    return top_bits

-- Main function
main :: IO ()
main = print_simple ASCII (deutsch_jozsa_circuit balanced_oracle)

-- Balanced Oracle definition
balanced_oracle :: Oracle
balanced_oracle = Oracle {
    qubit_num = 2,
    function = balanced_oracle_function
}

-- Balanced oracle function
balanced_oracle_function :: ([Qubit], Qubit) -> Circ ([Qubit], Qubit)
balanced_oracle_function ([x, y], out) = do
    -- Apply controlled-not gates
    qnot_at out `controlled` x
    qnot_at out `controlled` y
    return ([x, y], out)
balanced_oracle_function _ = error "undefined"  -- Fallback case for error handling
