module react;

import std.algorithm;
import std.format;

// Defines a reactive system that can handle dependencies between cells.
class Reactor(T) {
    // Static associative array to track dependencies between ComputeCells and their dependent objects.
    static ComputeCell[][Object] dependOn;
    
    // Static method to propagate changes through the dependency graph.
    static void update(Object ptr) {
        ComputeCell[] effected; // Stores compute cells affected by the update.
        Object[] ptrs = [ptr]; // Queue for breadth-first search through dependencies.
        size_t i = 0;
        // Breadth-first search to find all affected compute cells.
        while(i < ptrs.length) {
            if(auto dp = ptrs[i] in dependOn) {
                effected ~= dp[0]; // Add affected cells to the list.
                // Enqueue all direct dependencies of the current cell.
                foreach(x; dp[0]) {
                    ptrs ~= cast(Object) x;
                }
            }
            i++;
        }
        // Update all affected compute cells and call their callbacks.
        foreach(cc; effected.sort!((a,b)=>(cast(void*)a) < (cast(void*)b)).uniq) {
            foreach(j,cb; cc.callbacks) {
                cb(cc.value());
            }
        }
    }
    
    // Represents a cell with a settable value.
    class InputCell {
        T val_; // The current value of the cell.
        // Returns the current value.
        T value() { return val_; }
        // Constructor to initialize the cell with a value.
        this(T x) { val_ = x; }
        // Sets the value of the cell and triggers an update in the reactor.
        void value(T x) {
            val_ = x;
            update(this); // Notify the reactor of the change.
        }
    }
    
    // Represents a cell whose value is computed based on other cells.
    class ComputeCell {
        // Function to compute the cell's value.
        T delegate() doIt;
        // List of callbacks to be called when the cell's value changes.
        void delegate(T)[] callbacks;
        
        // Computes and returns the cell's current value.
        T value() { return doIt(); }
        
        // Constructor that sets up dependencies and the computation function.
        this(A...)(A a) {
            // Register this compute cell as a dependent of its input cells.
            static foreach(x;a[0..$-1]) {
                dependOn[cast(Object)x] ~= this;
            }
            // Define the computation function using a mixin for flexibility.
            doIt = (){
                mixin((){
                    string ret = "return a[$-1](";
                    static foreach(i,x; a[0..$-1]) {
                        static if(i!=0) { ret ~= ","; }
                        ret~= format("a[%s].value",i);
                    }
                    ret ~= ");";
                    return ret;
                    }()
                );
            };
        }
        
        // Adds a callback to be called when the cell's value changes.
        void delegate() addCallback(void delegate(T) d){
            T prev = value; // Current value, to detect changes.
            bool cancelled = false; // Flag to cancel the callback.
            // Add the callback to the list.
            callbacks ~= (val){
                T cur = value; // Recompute the value.
                // Call the callback if the value has changed and it's not cancelled.
                if(!cancelled && cur != prev) {
                    prev=cur;
                    d(cur);
                }
            };
            // Return a delegate that cancels the callback when called.
            return (){ cancelled = true; };
        }
    }
}

unittest
{
    const int allTestsEnabled = 0;

    {
        // input cells have a value
        Reactor!(int) r;
        auto input = r.new InputCell(10);

        assert(input.value == 10);
    }
    static if (allTestsEnabled)
    {
        {
            // an input cell's value can be set
            Reactor!(int) r;
            auto input = r.new InputCell(4);

            input.value = 20;
            assert(input.value == 20);
        }
        {
            // compute cells calculate initial value
            Reactor!(int) r;
            auto input = r.new InputCell(1);
            auto output = r.new ComputeCell(input, (int x) => x + 1);

            assert(output.value == 2);
        }
        {
            // compute cells take inputs in the right order
            Reactor!(int) r;
            auto one = r.new InputCell(1);
            auto two = r.new InputCell(2);
            auto output = r.new ComputeCell(one, two, (int x, int y) => x + y * 10);

            assert(output.value == 21);
        }
        {
            // compute cells update value when dependencies are changed
            Reactor!(int) r;
            auto input = r.new InputCell(1);
            auto output = r.new ComputeCell(input, (int x) => x + 1);

            input.value = 3;
            assert(output.value == 4);
        }
        {
            // compute cells can depend on other compute cells
            Reactor!(int) r;
            auto input = r.new InputCell(1);
            auto timesTwo = r.new ComputeCell(input, (int x) => x * 2);
            auto timesThirty = r.new ComputeCell(input, (int x) => x * 30);
            auto output = r.new ComputeCell(timesTwo, timesThirty, (int x, int y) => x + y);

            assert(output.value == 32);
            input.value = 3;
            assert(output.value == 96);
        }
        {
            // compute cells fire callbacks
            Reactor!(int) r;
            auto input = r.new InputCell(1);
            auto output = r.new ComputeCell(input, (int x) => x + 1);
            int[] vals;

            output.addCallback((int x) { vals ~= [x]; return; });

            input.value = 3;
            assert(vals.length == 1);
            assert(vals[0] == 4);
        }
        {
            // compute cells only fire on change
            Reactor!(int) r;
            auto input = r.new InputCell(1);
            auto output = r.new ComputeCell(input, (int x) => x < 3 ? 111 : 222);
            int[] vals;

            output.addCallback((int x) { vals ~= [x]; return; });

            input.value = 2;
            assert(vals.length == 0);
            input.value = 3;
            assert(vals.length == 1);
            assert(vals[0] == 222);
        }
        {
            // callbacks can be added and removed
            Reactor!(int) r;
            auto input = r.new InputCell(11);
            auto output = r.new ComputeCell(input, (int x) => x + 1);
            int[] vals1;
            int[] vals2;
            int[] vals3;

            void delegate() cancel1 = output.addCallback((int x) {
                vals1 ~= [x];
                return;
            });
            output.addCallback((int x) { vals2 ~= [x]; return; });

            input.value = 31;

            cancel1();
            output.addCallback((int x) { vals3 ~= [x]; return; });

            input.value = 41;

            assert(vals1.length == 1);
            assert(vals1[0] == 32);
            assert(vals2.length == 2);
            assert(vals2[0] == 32);
            assert(vals2[1] == 42);
            assert(vals3.length == 1);
            assert(vals3[0] == 42);
        }
        {
            // removing a callback multiple times doesn't interfere with other callbacks
            Reactor!(int) r;
            auto input = r.new InputCell(1);
            auto output = r.new ComputeCell(input, (int x) => x + 1);
            int[] vals1;
            int[] vals2;

            void delegate() cancel1 = output.addCallback((int x) {
                vals1 ~= [x];
                return;
            });
            output.addCallback((int x) { vals2 ~= [x]; return; });

            foreach (i; 0 .. 10)
            {
                cancel1();
            }

            input.value = 2;

            assert(vals1.length == 0);
            assert(vals2.length == 1);
            assert(vals2[0] == 3);
        }
        {
            // callbacks should only be called once even if multiple dependencies change
            Reactor!(int) r;
            auto input = r.new InputCell(1);
            auto plusOne = r.new ComputeCell(input, (int x) => x + 1);
            auto minusOne1 = r.new ComputeCell(input, (int x) => x - 1);
            auto minusOne2 = r.new ComputeCell(minusOne1, (int x) => x - 1);
            auto output = r.new ComputeCell(plusOne, minusOne2, (int x, int y) => x * y);
            int[] vals;

            output.addCallback((int x) { vals ~= [x]; return; });

            input.value = 4;

            assert(vals.length == 1);
            assert(vals[0] == 10);
        }
        {
            // callbacks should not be called if dependencies change but output value doesn't change
            Reactor!(int) r;
            auto input = r.new InputCell(1);
            auto plusOne = r.new ComputeCell(input, (int x) => x + 1);
            auto minusOne = r.new ComputeCell(input, (int x) => x - 1);
            auto alwaysTwo = r.new ComputeCell(plusOne, minusOne, (int x, int y) => x - y);
            int[] vals;

            alwaysTwo.addCallback((int x) { vals ~= [x]; return; });

            foreach (i; 0 .. 10)
            {
                input.value = i;
            }

            assert(vals.length == 0);
        }
        {
            // This is a digital logic circuit called an adder:
            // https://en.wikipedia.org/wiki/Adder_(electronics)
            Reactor!(bool) r;
            auto a = r.new InputCell(false);
            auto b = r.new InputCell(false);
            auto carryIn = r.new InputCell(false);

            auto aXorB = r.new ComputeCell(a, b, (bool x, bool y) => x != y);
            auto sum = r.new ComputeCell(aXorB, carryIn, (bool x, bool y) => x != y);

            auto aXorBAndCin = r.new ComputeCell(aXorB, carryIn, (bool x, bool y) => x && y);
            auto aAndB = r.new ComputeCell(a, b, (bool x, bool y) => x && y);
            auto carryOut = r.new ComputeCell(aXorBAndCin, aAndB, (bool x, bool y) => x || y);

            bool[5][] tests = [
                //            inputs,     expected
                //   a,     b,   cin,  cout,   sum
                [false, false, false, false, false],
                [false, false, true, false, true],
                [false, true, false, false, true], [
                    false, true, true, true, false
                ], [true, false, false, false, true],
                [true, false, true, true, false], [
                    true, true, false, true, false
                ], [true, true, true, true, true],
            ];

            foreach (test; tests)
            {
                a.value = test[0];
                b.value = test[1];
                carryIn.value = test[2];

                assert(carryOut.value == test[3]);
                assert(sum.value == test[4]);
            }
        }
    }

}