import Quipper

-- declare modified Oracle data type
data Oracle = Oracle {
  -- declare the length of a string
  qubit_num :: Int,
  -- declare oracle function f(x)
  function :: ([Qubit], Qubit) -> Circ ([Qubit], Qubit)
}

-- declare deutsch_jozsa_circuit function
deutsch_jozsa_circuit :: Oracle -> Circ [Bit]
deutsch_jozsa_circuit oracle = do
  -- initialize string of qubits
  top_qubits <- qinit (replicate (qubit_num oracle) False)
  bottom_qubit <- qinit True
  label (top_qubits, bottom_qubit) ("|0⟩","|1⟩")
  -- do the first hadamard
  mapUnary hadamard top_qubits
  hadamard_at bottom_qubit
  comment "before oracle"
  -- call oracle
  function oracle (top_qubits, bottom_qubit)
  comment "after oracle"
  -- do the last hadamard
  mapUnary hadamard top_qubits
  -- measure qubits
  (top_qubits, bottom_qubit) <- measure (top_qubits, bottom_qubit)
  -- discard unnecessary output and return result
  cdiscard bottom_qubit
  return top_qubits

-- main function
main = print_generic Preview (deutsch_jozsa_circuit empty_oracle)
where
  -- declare empty_oracle’s data type
  empty_oracle :: Oracle
  empty_oracle = Oracle {
    qubit_num = 5,
    function = empty_oracle_function
  }

-- initialize empty_oracle’s function f(x)
empty_oracle_function:: ([Qubit],Qubit) -> Circ ([Qubit],Qubit)
empty_oracle_function (ins,out) = named_gate "Oracle" (ins,out)
