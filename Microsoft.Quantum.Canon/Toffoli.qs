// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

namespace Microsoft.Quantum.Canon {
    open Microsoft.Quantum.Primitive;

    /// <summary>
    /// Implementation of the Toffoli gate up to phases over the Clifford+T gate set, according to Nielsen and Chuang, Exercise 4.26
    /// </summary>
    /// <param name = "qs"> A quantum register of three qubits [qs[0]; qs[1]; qs[2]] to which the Margolus gate is applied, so 
    ///    that qs[0] is the target qubit and qs[1] and qs[2] are the control qbits.
    /// <remarks>  The Margolus gate corresponds to the Toffoli gate $|a, b, c\rangle \mapsto |a, b, c \oplus ab\rangle$, up to a relative phase. 
    ///     [ Nielsen & Chuang, CUP 2000, Ex. 4.26, http://doi.org/10.1017/CBO9780511976667 ]
    /// </remarks>

    operation PhaseToffoli2 (qs : Qubit[]) : () {
        body {
            AssertIntEqual( Length(qs), 3, "Margolus gate takes three qubits as an input");
            RFrac(PauliY, -1, 3, qs[0]);
            (Controlled X)([qs[1]], qs[0]);
            RFrac(PauliY, -1, 3, qs[0]);
            (Controlled X)([qs[2]], qs[0]);
            RFrac(PauliY, 1, 3, qs[0]);
            (Controlled X)([qs[1]], qs[0]);
            RFrac(PauliY, 1, 3, qs[0]);
        }

        adjoint auto 
        // note that there might be a better way to control this operation than via "controlled auto"
        controlled auto
        adjoint controlled auto
    }

    /// <summary>
    /// Implementation of the 3 qubit phase Toffoli gate, according to Selinger
    /// </summary>
    /// <param name = "qs"> A quantum register of three qubits [qs[0]; qs[1]; qs[2]] to which the phase Toffoli gate is applied, so 
    ///    that qs[0] is the target qubit and qs[1] and qs[2] are the control qbits.
    /// <remarks>  The phase Toffoli corresponds to the Toffoli gate $|a, b, c\rangle \mapsto |a, b, c \oplus ab\rangle$, up to a relative phase. 
    ///     [ P. Selinger, Phys. Rev. A 87: 042302 (2013), http://doi.org/10.1103/PhysRevA.87.042302 ]
    /// </remarks>

    // The Clifford circuit that is the first part of the phase qubit circuit
    operation PhaseToffoliOuterCircuit (qs:Qubit[]) : () {
        body { 
            AssertIntEqual( Length(qs), 4, "4 qubits are expected");
            H(qs[1]);
            (Controlled X)([qs[3]], qs[0]);
            (Controlled X)([qs[1]], qs[2]);
            (Controlled X)([qs[1]], qs[3]);
            (Controlled X)([qs[2]], qs[0]);
        }
        
        adjoint auto    
        controlled auto
        adjoint controlled auto
    }

    // The middle layer of the circuit that implements 4 T gates in parallel
    operation PhaseToffoliInnerCircuit (qs:Qubit[]) : () {
        body { 
            AssertIntEqual( Length(qs), 4, "4 qubits are expected");
            // FIXME: Write as ApplyToEach / Iter.
            for (i in 0..1) { T(qs[i]); }
            for (i in 2..3) { (Adjoint T)(qs[i]); }
        }

        adjoint auto    
        controlled auto
        adjoint controlled auto
    }

    // The actual circuit to implement a Toffoli gate up to phases in T-depth 1, using 4 ancilla qubits
    operation PhaseToffoli1 (qs : Qubit[]) : () {
        body {
            AssertIntEqual( Length(qs), 3, "Toffoli gate takes three qubits as an input");
            using(ancillas = Qubit[1]) {
                WithCA(
                    PhaseToffoliOuterCircuit,
                    PhaseToffoliInnerCircuit,
                    ancillas + qs
                );
            }
        }
        adjoint auto
        controlled auto
        adjoint controlled auto
    }
        
    /// <summary>
    /// Implementation of the 3 qubit Toffoli gate over the Clifford+T gate set, in T-depth 6, according to Nielsen and Chuang
    /// </summary>
    /// <param name = "qs"> A quantum register of three qubits [qs[0]; qs[1]; qs[2]] to which the Toffoli gate is applied, so 
    ///    that qs[0] is the target qubit and qs[1] and qs[2] are the control qbits.
    /// <remarks>  The Toffoli gate corresponds to the operation $|a, b, c\rangle \mapsto |a, b, c \oplus ab\rangle$. The circuit 
    ///     corresponding to this implementation uses 7 T gates, 5 CNOT gates, 2 Hadamard gates, and 1 S gate and has T-depth 6. 
    ///     [ Nielsen & Chuang, CUP 2000, Fig. 4.9, http://doi.org/10.1017/CBO9780511976667 ]
    /// </remarks>

    operation Toffoli1 (qs : Qubit[]) : () {
        body {
            AssertIntEqual( Length(qs), 3, "Toffoli gate takes three qubits as an input");
            H(qs[0]);
            (Controlled X)([qs[1]], qs[0]);
            (Adjoint T)(qs[0]);
            (Controlled X)([qs[2]], qs[0]);
            T(qs[0]);
            (Controlled X)([qs[1]], qs[0]);
            (Adjoint T)(qs[0]);
            (Controlled X)([qs[2]], qs[0]);
            T(qs[0]);
            (Adjoint T)(qs[1]);
            (Controlled X)([qs[2]], qs[1]);
            H(qs[0]);
            (Adjoint T)(qs[1]);
            (Controlled X)([qs[2]], qs[1]);
            T(qs[2]);
            S(qs[1]);
        }

        adjoint self
        // note that there might be a better way to control this operation than via "controlled auto"
        controlled auto
        adjoint controlled auto
    }

    /// <summary>
    /// Implementation of the 3 qubit Toffoli gate over the Clifford+T gate set, in T-depth 3, according to Amy et al 
    /// </summary>
    /// <param name = "qs"> A quantum register of three qubits [qs[0]; qs[1]; qs[2]] to which the Toffoli gate is applied, so 
    ///    that qs[0] is the target qubit and qs[1] and qs[2] are the control qbits.
    /// <remarks>  The Toffoli gate corresponds to the operation $|a, b, c\rangle \mapsto |a, b, c \oplus ab\rangle$. The circuit 
    ///     corresponding to this implementation uses 7 T gates, 7 CNOT gates, 2 Hadamard gates and has T-depth 3.  
    ///     [ M. Amy, D. Maslov, M. Mosca, M. Roetteler, IEEE Trans. CAD, 32(6): 818-830 (2013), http://doi.org/10.1109/TCAD.2013.2244643 ]
    /// </remarks>

    operation Toffoli2 (qs : Qubit[]) : () {
        body {
            AssertIntEqual( Length(qs), 3, "Toffoli gate takes three qubits as an input");
            H(qs[0]);
            (Controlled X)([qs[1]], qs[0]);
            (Adjoint T)(qs[0]);
            (Controlled X)([qs[2]], qs[0]);
            T(qs[0]);
            (Controlled X)([qs[1]], qs[0]);
            (Adjoint T)(qs[0]);
            (Controlled X)([qs[2]], qs[0]);
            T(qs[0]);
            (Adjoint T)(qs[1]);
            (Controlled X)([qs[2]], qs[1]);
            H(qs[0]);
            (Adjoint T)(qs[1]);
            (Controlled X)([qs[2]], qs[1]);
            T(qs[2]);
            S(qs[1]);
        }
        
        adjoint self
        // note that there might be a better way to control this operation than via "controlled auto"
        controlled auto
        adjoint controlled auto
    }


    /// <summary>
    /// Implementation of the 3 qubit Toffoli gate over the Clifford+T gate set, in T-depth 1, according to Selinger  
    /// </summary>
    /// <param name = "qs"> A quantum register of three qubits [qs[0]; qs[1]; qs[2]] to which the Toffoli gate is applied, so 
    ///    that qs[0] is the target qubit and qs[1] and qs[2] are the control qbits.
    /// <remarks>  The Toffoli gate corresponds to the operation $|a, b, c\rangle \mapsto |a, b, c \oplus ab\rangle$. The circuit 
    ///     corresponding to this implementation uses 7 T gates, 7 CNOT gates, 2 Hadamard gates and has T-depth 3.  
    ///     [ P. Selinger, Phys. Rev. A 87: 042302 (2013), http://doi.org/10.1103/PhysRevA.87.042302 ]
    /// </remarks>

    // The Clifford circuit that creates all linear Boolean functions of the input variables a, b, c 
    operation DepthOneToffoliOuterCircuit (qs:Qubit[]) : () {
        body { 
            AssertIntEqual( Length(qs), 7, "7 qubits are expected");
            H(qs[4]);
            (Controlled X)([qs[5]], qs[1]);
            (Controlled X)([qs[6]], qs[3]);
            (Controlled X)([qs[5]], qs[2]);
            (Controlled X)([qs[4]], qs[1]);
            (Controlled X)([qs[3]], qs[0]);
            (Controlled X)([qs[6]], qs[2]);
            (Controlled X)([qs[4]], qs[0]);
            (Controlled X)([qs[1]], qs[3]);
        }
        
        adjoint auto    
        controlled auto
        adjoint controlled auto
    }

    // The middle layer of the circuit that implements 7 T gates in parallel
    operation DepthOneToffoliInnerCircuit (qs:Qubit[]) : () {
        body { 
            AssertIntEqual( Length(qs), 7, "7 qubits are expected");
            for (i in 0..2) { (Adjoint T)(qs[i]); }
            for (i in 3..6) { T(qs[i]); }
        }

        adjoint auto    
        controlled auto
        adjoint controlled auto
    }

    // The actual circuit to implement a Toffoli gate in T-depth 1, using 4 ancilla qubits
    operation Toffoli3 (qs : Qubit[]) : () {
        body {
            AssertIntEqual( Length(qs), 3, "Toffoli gate takes three qubits as an input");
            using(ancillas = Qubit[4]) {
                WithCA(
                    DepthOneToffoliOuterCircuit, 
                    DepthOneToffoliInnerCircuit, 
                    ancillas + qs
                );
            }
        }
        adjoint auto
        controlled auto
        adjoint controlled auto
    }

    /// <summary>
    /// Implementation of the 3 qubit Toffoli gate over the Clifford+T gate set, with 4 T-gates, according to Jones
    /// </summary>
    /// <param name = "qs"> A quantum register of three qubits [qs[0]; qs[1]; qs[2]] to which the Toffoli gate is applied, so 
    ///    that qs[0] is the target qubit and qs[1] and qs[2] are the control qbits.
    /// <remarks>  The Toffoli gate corresponds to the operation $|a, b, c\rangle \mapsto |a, b, c \oplus ab\rangle$. The circuit 
    ///     corresponding to this implementation uses 4 T gates, XXX7 CNOT gates, 2 Hadamard gates and has T-depth 3.  
    ///     [ N. C. Jones, Phys. Rev. A 87: 022328 (2013), http://doi.org/10.1103/PhysRevA.87.022328 ]
    /// </remarks>
    operation Toffoli4 (qs : Qubit[]) : () {
        body {
            AssertIntEqual( Length(qs), 3, "Toffoli gate takes three qubits as an input");
            using(ancillas = Qubit[1]) {
                PhaseToffoli1([ancillas[0]; qs[1]; qs[2]]);
                S(ancillas[0]);
                (Controlled X)([ancillas[0]], qs[0]);
                H(ancillas[0]);
                if ( M(ancillas[0]) == One ) { 
                    (Controlled Z)([qs[2]], qs[1]);
                }
            }
        }
    }

    /// <summary>
    /// Implementation of the 3 qubit Fredkin gate using Toffoli and CNOT gates
    /// </summary>
    /// <param name = "qs"> A quantum register of three qubits [qs[0]; qs[1]; qs[2]] to which the Fredkin gate is applied, so 
    ///    that qs[2] is the control qubit and qubits qs[0] and qs[1] are swapped if and only if qs[2] is equal to 1. 
    /// <remarks>  The Fredkin gate corresponds to the operation that maps $|0, x, y\rangle \mapsto |0, x, y\rangle$ and 
    ///     $|1, x, y\rangle \mapsto |1, y, x\rangle$. The circuit uses 7 T gates, 9 CNOT gates, 2 Hadamard gates and has T-depth 3.  
    ///     [ M. Amy, D. Maslov, M. Mosca, M. Roetteler, IEEE Trans. CAD, 32(6): 818-830 (2013), http://doi.org/10.1109/TCAD.2013.2244643 ]
    /// </remarks>
    operation Fredkin1 (qs : Qubit[]) : () {
        body {
            AssertIntEqual( Length(qs), 3, "Fredkin gate takes three qubits as an input");
            (Controlled X)([qs[0]], qs[1]);
            (Controlled X)([qs[1]; qs[2]], qs[0]);
            (Controlled X)([qs[0]], qs[1]);
        }
        adjoint self
        controlled(controls) {
            (Controlled X)([qs[0]], qs[1]);
            (Controlled X)(controls + [qs[1]; qs[2]], qs[0]);
            (Controlled X)([qs[0]], qs[1]);
        }
        adjoint controlled(controls) {
            (Controlled X)([qs[0]], qs[1]);
            (Controlled X)(controls + [qs[1]; qs[2]], qs[0]);
            (Controlled X)([qs[0]], qs[1]);
        }
    }

    /// <summary>
    /// Implementation of the 3 qubit Fredkin gate over the Clifford+T gate set, according to Amy et al 
    /// </summary>
    /// <param name = "qs"> A quantum register of three qubits [qs[0]; qs[1]; qs[2]] to which the Fredkin gate is applied, so 
    ///    that qs[2] is the control qubit and qubits qs[0] and qs[1] are swapped if and only if qs[2] is equal to 1. 
    /// <remarks>  The Fredkin gate corresponds to the operation that maps $|0, x, y\rangle \mapsto |0, x, y\rangle$ and 
    ///     $|1, x, y\rangle \mapsto |1, y, x\rangle$. The circuit uses 7 T gates, 8 CNOT gates, 2 Hadamard gates and has T-depth 4.  
    ///     [ M. Amy, D. Maslov, M. Mosca, M. Roetteler, IEEE Trans. CAD, 32(6): 818-830 (2013), http://doi.org/10.1109/TCAD.2013.2244643 ]
    /// </remarks>
    operation Fredkin2 (qs : Qubit[]) : () {
        body {
            AssertIntEqual( Length(qs), 3, "Fredkin gate takes three qubits as an input");
            (Controlled X)([qs[0]], qs[1]);
            // layer 0
            H(qs[0]);
            (Controlled X)([qs[2]], qs[1]);
            // layer 1
            T(qs[0]);
            (Adjoint T)(qs[1]);
            T(qs[2]);
            // layer 2 
            (Controlled X)([qs[0]], qs[1]);
            // layer 3
            (Controlled X)([qs[2]], qs[0]);
            T(qs[1]);
            // layer 4
            (Controlled X)([qs[2]], qs[1]);
            (Adjoint T)(qs[0]);
            // layer 5
            (Adjoint T)(qs[1]);
            (Controlled X)([qs[2]], qs[0]);
            // layer 6
            (Controlled X)([qs[0]], qs[1]);
            // layer 7
            T(qs[1]);
            H(qs[0]);
            // layer 8
            (Controlled X)([qs[0]], qs[1]);
        }

        adjoint auto
        // note that there might be a better way to control this operation than via "controlled auto"
        controlled auto
        adjoint controlled auto
    }

}