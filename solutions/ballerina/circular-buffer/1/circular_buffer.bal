class CircularBuffer {
    private int[] buffer;
    private int head = 0;
    private int tail = 0;
    private int size = 0;
    private int capacity;

    function init(int capacity) {
        self.buffer = [];
        self.capacity = capacity;
    }

    function read() returns int|error {
        if self.size == 0 {
            return error("Empty buffer");
        } else {
            int value = self.buffer[self.head];
            self.head = (self.head + 1) % self.capacity;
            self.size -= 1;
            return value;
        }
    }

    function write(int value) returns error? {
        if self.size == self.capacity {
            return error("Full buffer");
        } else {
            if self.size < self.capacity {
                self.buffer[self.tail] = value;
                self.tail = (self.tail + 1) % self.capacity;
                self.size += 1;
            }
        }
    }

    function overwrite(int value) returns error? {
        if self.size < self.capacity {
            return self.write(value);
        } else {
            self.buffer[self.head] = value;
            self.head = (self.head + 1) % self.capacity;
            self.tail = (self.tail + 1) % self.capacity; // Move tail since we are overwriting
        }
    }

    function clear() {
        self.head = 0;
        self.tail = 0;
        self.size = 0;
        self.buffer = [];
    }
}