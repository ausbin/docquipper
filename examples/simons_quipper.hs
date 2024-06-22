import Quipper
import Quipper.Libraries.Synthesis
import Quantum.Synthesis.Matrix
import Quantum.Synthesis.Ring
-- declare oracle data type
data Oracle = Oracle {
    qubit_num :: Int,
    function :: ([Qubit], [Qubit]) -> Circ ([Qubit], [Qubit])
}
-- declare simon_circuit function
simon_circuit :: Oracle -> Circ ([Bit], [Bit])
simon_circuit oracle = do
--create the ancillaes
    top_qubits <- qinit (replicate (qubit_num oracle) False)
    bottom_qubits <- qinit (replicate (qubit_num oracle) True)
    label (top_qubits, bottom_qubits) ("top |0>", "bottom |1>")
    -- apply first hadamard gate
    mapUnary hadamard top_qubits
    mapUnary hadamard bottom_qubits
    -- call the oracle
    (function oracle) (top_qubits, bottom_qubits)
    -- apply hadamard gate again
    mapUnary hadamard top_qubits
    -- measure qubits
    (top_qubits, bottom_qubits) <- measure(top_qubits, bottom_qubits)
    -- return the result
    return (top_qubits,bottom_qubits)
-- declare steps function
steps :: (Oracle -> Circ ([Bit], [Bit])) -> Oracle -> Circ (Maybe ([Bit], [Bit]))
steps simon_algorithm oracle = do
    comment " Simon’s algorithm"
    -- set value for n
    let n = toEnum (qubit_num oracle) :: Int
    -- call simon_circuit n-1 times
    for 1 (n-1) 1 $ \i -> do
        comment "start"
        -- call simon_circuit function
        ret <- simon_algorithm oracle
        -- return the result
        return ret
        comment "finish"
    endfor
    return Nothing
-- declare main function
matrix16x16 ::  (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->
                (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->
                (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->
                (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->
                (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->
                (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->
                (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->
                (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->
                (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->
                (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->
                (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->
                (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->
                (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->
                (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->
                (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->
                (a, a, a, a, a, a, a, a, a, a, a, a, a, a, a, a)->Matrix Sixteen Sixteen a

matrix16x16 (a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15)
            (b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15)
            (c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15)
            (d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15)
            (e0, e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15)
            (f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15)
            (g0, g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, g11, g12, g13, g14, g15)
            (h0, h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12, h13, h14, h15)
            (i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15)
            (j0, j1, j2, j3, j4, j5, j6, j7, j8, j9, j10, j11, j12, j13, j14, j15)
            (k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14, k15)
            (l0, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15)
            (m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15)
            (n0, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15)
            (o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15)
            (p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15) = matrix [[a0, b0, c0, d0, e0, f0, g0, h0, i0, j0, k0, l0, m0, n0, o0, p0],
                                                                                            [a1, b1, c1, d1, e1, f1, g1, h1, i1, j1, k1, l1, m1, n1, o1, p1],
                                                                                            [a2, b2, c2, d2, e2, f2, g2, h2, i2, j2, k2, l2, m2, n2, o2, p2],
                                                                                            [a3, b3, c3, d3, e3, f3, g3, h3, i3, j3, k3, l3, m3, n3, o3, p3],
                                                                                            [a4, b4, c4, d4, e4, f4, g4, h4, i4, j4, k4, l4, m4, n4, o4, p4],
                                                                                            [a5, b5, c5, d5, e5, f5, g5, h5, i5, j5, k5, l5, m5, n5, o5, p5],
                                                                                            [a6, b6, c6, d6, e6, f6, g6, h6, i6, j6, k6, l6, m6, n6, o6, p6],
                                                                                            [a7, b7, c7, d7, e7, f7, g7, h7, i7, j7, k7, l7, m7, n7, o7, p7],
                                                                                            [a8, b8, c8, d8, e8, f8, g8, h8, i8, j8, k8, l8, m8, n8, o8, p8],
                                                                                            [a9, b9, c9, d9, e9, f9, g9, h9, i9, j9, k9, l9, m9, n9, o9, p9],
                                                                                            [a10,b10,c10,d10,e10,f10,g10,h10,i10,j10,k10,l10,m10,n10,o10,p10],
                                                                                            [a11,b11,c11,d11,e11,f11,g11,h11,i11,j11,k11,l11,m11,n11,o11,p11],
                                                                                            [a12,b12,c12,d12,e12,f12,g12,h12,i12,j12,k12,l12,m12,n12,o12,p12],
                                                                                            [a13,b13,c13,d13,e13,f13,g13,h13,i13,j13,k13,l13,m13,n13,o13,p13],
                                                                                            [a14,b14,c14,d14,e14,f14,g14,h14,i14,j14,k14,l14,m14,n14,o14,p14],
                                                                                            [a15,b15,c15,d15,e15,f15,g15,h15,i15,j15,k15,l15,m15,n15,o15,p15]]

main = print_simple ASCII (steps simon_circuit sample_oracle)
    where
    -- declare sample_oracle’s data type
    operator :: Matrix Sixteen Sixteen DOmega
    operator = matrix16x16  ( 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 )
                            ( 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 )
                            ( 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 )
                            ( 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 )
                            ( 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 )
                            ( 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 )
                            ( 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 )
                            ( 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 )
                            ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 )
                            ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 )
                            ( 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 )
                            ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 )
                            ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 )
                            ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 )
                            ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 )
                            ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 )
    sample_oracle :: Oracle
    sample_oracle = Oracle{
        qubit_num = 2,
        function = sample_function
    }
    -- initialize empty_oracle’s function
    sample_function:: ([Qubit],[Qubit]) -> Circ ([Qubit],[Qubit])
    sample_function (controlled_qubit, target_qubit) = do
        let element = controlled_qubit ++ target_qubit
        -- call the unitary matrix
        exact_synthesis operator element
        return (controlled_qubit, target_qubit)
    -- initialize 16 by 16 unitary matrix
-- The natural number 16 as a type
type Sixteen = Succ (Succ (Succ (Succ (Succ (Succ Ten)))))