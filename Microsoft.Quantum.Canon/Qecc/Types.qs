// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

namespace Microsoft.Quantum.Canon {

    newtype LogicalRegister = Qubit[];
    newtype Syndrome = Result[];
    newtype RecoveryFn = (Syndrome -> Pauli[]);
    // Design notes:
    //     These two types do not return (), such that instances of these types
    //     will not support autofunctors. This is inconvienent, but I think it's
    //     important to allow the generalization that physical and logical registers
    //     may have different numbers of qubits.

    /// <summary>
    ///     Represents an operation which encodes a physical register into a
    ///     logical register, using the provided scratch qubits.
    ///
    ///     The first argument is taken to be the physical register that will
    ///     be encoded, while the second argument is taken to be the scratch
    ///     register that will be used.
    /// </summary>
    newtype EncodeOp = ((Qubit[], Qubit[]) => LogicalRegister);
    /// <summary>
    ///     Represents an operation which decodes an encoded register into a
    ///     physical register and the scratch qubits used to record a syndrome.
    ///     
    ///     The argument to a DecodeOp is the same as the return from an
    ///     EncodeOp, and vice versa.
    /// </summary>
    newtype DecodeOp = (LogicalRegister => (Qubit[], Qubit[]));
    newtype SyndromeMeasOp = (LogicalRegister => Syndrome);

    newtype QECC = (EncodeOp, DecodeOp, SyndromeMeasOp);
    newtype CSS = (EncodeOp, DecodeOp, SyndromeMeasOp, SyndromeMeasOp);

}