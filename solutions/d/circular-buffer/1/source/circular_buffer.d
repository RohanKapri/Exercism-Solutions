module circular;

import std.exception; // Import if you want to use assertThrown for exception testing

class Buffer(T) {
    private T[] buffer;
    private int start = 0;
    private int end = 0;
    private bool full = false;

    this(ulong size) {
        if (size > size_t.max) throw new Exception("Buffer size too large");
        buffer.length = cast(int)size;
    }

    void push(T item) {
        if (full) {
            throw new Exception("Full buffer should throw exception if new element pushed!");
        }
        buffer[end] = item;
        // Cast buffer.length to int explicitly
        end = (end + 1) % cast(int)buffer.length;
        full = end == start;
    }

    T pop() {
        if (isEmpty()) {
            throw new Exception("Empty buffer should throw exception if popped!");
        }
        auto item = buffer[start];
        // Cast buffer.length to int explicitly
        start = (start + 1) % cast(int)buffer.length;
        full = false;
        return item;
    }

    void forcePush(T item) {
        if (full) {
            // Directly overwrite the oldest item (at 'start') when the buffer is full
            buffer[start] = item;
            start = (start + 1) % cast(int)buffer.length; // Move start forward to the next oldest item
            end = (end + 1) % cast(int)buffer.length; // Keep end in sync, as we're overwriting
        } else {
            // If the buffer is not full, just use the normal push method
            push(item);
        }
    }

    void clear() {
        start = 0;
        end = 0;
        full = false;
    }

    private bool isEmpty() {
        return start == end && !full;
    }
}

unittest
{
    import std.exception : assertThrown;

    immutable int allTestsEnabled = 0;

    // Reading empty buffer should fail"
    {
        auto myBuffer = new Buffer!(int)(1UL);
        assertThrown(myBuffer.pop(), "Empty buffer should throw exception if popped!");
    }

    static if (allTestsEnabled)
    {

        // Can read an item just written
        {
            auto myBuffer = new Buffer!(char)(1);
            myBuffer.push('1');
            assert(myBuffer.pop() == '1');
        }

        // Each item may only be read once"
        {
            auto myBuffer = new Buffer!(char)(1);
            myBuffer.push('1');
            assert(myBuffer.pop() == '1');
            assertThrown(myBuffer.pop(), "Empty buffer should throw exception if popped!");
        }

        // Items are read in the order they are written
        {
            auto myBuffer = new Buffer!(char)(2);
            myBuffer.push('1');
            myBuffer.push('2');
            assert(myBuffer.pop() == '1');
            assert(myBuffer.pop() == '2');
        }

        // Full buffer can't be written to
        {
            auto myBuffer = new Buffer!(char)(1);
            myBuffer.push('1');
            assertThrown(myBuffer.push('2'),
                    "Full buffer should throw exception if new element pushed!");
        }

        // A read frees up capacity for another write
        {
            auto myBuffer = new Buffer!(char)(1);
            myBuffer.push('1');
            assert(myBuffer.pop() == '1');
            myBuffer.push('2');
            assert(myBuffer.pop() == '2');
        }

        // Read position is maintained even across multiple writes
        {
            auto myBuffer = new Buffer!(char)(3);
            myBuffer.push('1');
            myBuffer.push('2');
            assert(myBuffer.pop() == '1');
            myBuffer.push('3');
            assert(myBuffer.pop() == '2');
            assert(myBuffer.pop() == '3');
        }

        // Items cleared out of buffer can't be read
        {
            auto myBuffer = new Buffer!(char)(1);
            myBuffer.push('1');
            myBuffer.clear();
            assertThrown(myBuffer.pop(), "Empty buffer should throw exception if popped!");
        }

        // Clear frees up capacity for another write
        {
            auto myBuffer = new Buffer!(char)(1);
            myBuffer.push('1');
            myBuffer.clear();
            myBuffer.push('2');
            assert(myBuffer.pop() == '2');
        }

        // Clear does nothing on empty buffer
        {
            auto myBuffer = new Buffer!(char)(1);
            myBuffer.clear();
            myBuffer.push('1');
            assert(myBuffer.pop() == '1');
        }

        // Overwrite acts like write on non-full buffer
        {
            auto myBuffer = new Buffer!(char)(2);
            myBuffer.push('1');
            myBuffer.forcePush('2');
            assert(myBuffer.pop() == '1');
            assert(myBuffer.pop() == '2');
        }

        // Overwrite replaces the oldest item on full buffer
        {
            auto myBuffer = new Buffer!(char)(2);
            myBuffer.push('1');
            myBuffer.push('2');
            myBuffer.forcePush('3');
            assert(myBuffer.pop() == '2');
            assert(myBuffer.pop() == '3');
        }

        // Overwrite replaces the oldest item remaining in buffer following a read
        {
            auto myBuffer = new Buffer!(char)(3);
            myBuffer.push('1');
            myBuffer.push('2');
            myBuffer.push('3');
            assert(myBuffer.pop() == '1');
            myBuffer.push('4');
            myBuffer.forcePush('5');
            assert(myBuffer.pop() == '3');
            assert(myBuffer.pop() == '4');
            assert(myBuffer.pop() == '5');
        }

        // Initial clear does not affect wrapping around
        {
            auto myBuffer = new Buffer!(char)(2);
            myBuffer.clear();
            myBuffer.push('1');
            myBuffer.push('2');
            myBuffer.forcePush('3');
            myBuffer.forcePush('4');
            assert(myBuffer.pop() == '3');
            assert(myBuffer.pop() == '4');
            assertThrown(myBuffer.pop(), "Empty buffer should throw exception if popped!");
        }

    }

}