import Quipper
import Control.Monad

-- Modified Oracle data type
data Oracle = Oracle {
  qubit_num :: Int,
  function :: ([Qubit], Qubit) -> Circ ([Qubit], Qubit)
}

-- Bernstein-Vazirani Circuit
bernstein_vazirani_circuit :: Oracle -> Circ [Bit]
bernstein_vazirani_circuit oracle = do
  top_qubits <- qinit (replicate (qubit_num oracle) False)
  bottom_qubit <- qinit True
--  label (top_qubits, bottom_qubit) ("|0⟩","|1⟩")
  mapUnary hadamard top_qubits
  hadamard_at bottom_qubit
--  comment "before oracle"
  function oracle (top_qubits, bottom_qubit)
--  comment "after oracle"
  mapUnary hadamard top_qubits
  (top_qubits, bottom_qubit) <- measure (top_qubits, bottom_qubit)
  cdiscard bottom_qubit
  return top_qubits

-- Bernstein-Vazirani Oracle
bv_oracle :: Oracle
bv_oracle = Oracle {
  qubit_num = length secret_string,
  function = bv_oracle_function
}

-- Secret string for the BV algorithm
secret_string :: [Bool]
secret_string = [True, False, True]

-- BV Oracle function
bv_oracle_function :: ([Qubit], Qubit) -> Circ ([Qubit], Qubit)
bv_oracle_function (ins, out) = do
  sequence_ $ zipWith (\qubit bit -> if bit then qnot_at out `controlled` qubit else return ()) ins secret_string
  return (ins, out)

-- Main function
main = do
  print_generic ASCII (bernstein_vazirani_circuit bv_oracle)

