// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

namespace Microsoft.Quantum.Canon {

    newtype ResultStack = (Int,  Int, Result[]);

    function StackCapacity(stack : ResultStack) : Int {
        let (size, pos, data) = stack;
        return size;
    }

    function StackLength(stack : ResultStack) : Int {
        let (size, pos, data) = stack;
        return pos;
    }

    function StackPop(stack : ResultStack) : (ResultStack) {
        let (size, pos, data) = stack;
        if (pos == 0) {
            fail "Cannot pop an empty stack.";
        }
        return ResultStack(size, pos - 1, data);
    }

    function StackPush(stack : ResultStack, datum : Result) : ResultStack {
        let (size, pos, data) = stack;
        if (pos == size) {
            // TODO: grow stack.
            fail "Stack is full.";
        }
        
        // FIXME: implies an O(n) copy!
        //        This could be fixed by using a native C♯ operation to
        //        wrap ImmutableStack<T>.
        // See also: https://msdn.microsoft.com/en-us/library/dn467197(v=vs.111).aspx
        mutable newData = data;
        set newData[pos] = datum;
        
        return ResultStack(size, pos + 1, newData);
    }

    function StackPeek(stack : ResultStack) : Result {
        let (size, pos, data) = stack;
        if (pos == 0) {
            fail "Cannot peek at an empty stack.";
        }
        return data[pos - 1];
    }

    function StackNew(size : Int) : ResultStack {
        return ResultStack(size, 0, new Result[size]);
    }

}