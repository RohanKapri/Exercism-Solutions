// Define a module named 'robot'.
module robot;

// Import necessary modules from the D standard library.
import std.regex; // For regular expression operations, if needed for validation or other purposes.
import std.stdio: writefln; // For standard input and output operations, like printing to the console.
import std.random: uniform; // For generating random numbers, crucial for creating unique robot names.
import std.format; // For formatting strings, useful in constructing robot names.

// Define the Robot class.
class Robot {
    // Static variable to count the number of times a name generation results in a collision (duplicate name).
    static long collisons = 0;
    
    // Static associative array to keep track of names already assigned to robots.
    static bool[string] oldNames;
    
    // Static method that generates a random robot name.
    static string genRandom() {
        // Use the format function to construct a name consisting of two random letters and a three-digit number.
        return format("%s%s%03d",
                      cast(char)uniform('A','Z'+1), // Random uppercase letter
                      cast(char)uniform('A','Z'+1), // Another random uppercase letter
                      uniform(0,1000)); // Random three-digit number
    }
    
    // Static method that generates a unique robot name.
    static string generateName() {
        while(true) {
            string ret = genRandom(); // Generate a random name.
            // Check if the generated name is already used.
            if(ret !in oldNames) {
                // If not, add it to the list of used names and return it.
                oldNames[ret] = true;
                return ret;
            }
            // If the name is already used, the loop continues to generate a new name.
        }
    }

    // Instance variable to store the robot's name.
    string name;
    
    // Constructor for the Robot class.
    this() {
        // Assign a unique name to the robot upon creation.
        name = generateName;
    }
    
    // Method to reset (reassign) the robot's name.
    void reset() { 
        // Generate and assign a new unique name to the robot.
        name = generateName; 
    }
}

unittest
{

    // test for properly formatted name
    {
        auto pattern = regex(`^[A-Z]{2}\d{3}`);
        auto theRobot = new Robot();

        // test the regex pattern
        assert(matchAll("VAV224", pattern).empty);
        assert(matchAll("V221", pattern).empty);
        assert(matchAll("190", pattern).empty);
        assert(matchAll("12345", pattern).empty);
        assert(matchAll("SB1", pattern).empty);
        assert(matchAll("TT", pattern).empty);

        writefln("Robot name: %s", theRobot.name);

        // test that the name respects the pattern
        // that is: "2 uppercase letters followed by 3 digits"
        assert(!matchAll(theRobot.name, pattern).empty);
    }

    immutable int allTestsEnabled = 0;

    static if (allTestsEnabled)
    {
        // test name stickiness
        {
            auto theRobot = new Robot();
            auto name = theRobot.name;

            writefln("Robot name: %s", theRobot.name);
            assert(name == theRobot.name);
        }

        // test different names for different Robots
        {
            auto erTwoDeeTwo = new Robot();
            auto beeBeeEight = new Robot();

            writefln("Robot name: %s", erTwoDeeTwo.name);
            writefln("Robot name: %s", beeBeeEight.name);
            assert(erTwoDeeTwo.name != beeBeeEight.name);
        }

        // test name reset
        {
            auto theRobot = new Robot();
            auto nameOne = theRobot.name;
            theRobot.reset();
            auto nameTwo = theRobot.name;

            writefln("Robot name: %s", nameOne);
            writefln("Robot name: %s", nameTwo);
            assert(nameOne != nameTwo);
        }

        // collision test
        {
            foreach (i; 1 .. 10000)
            {
                auto theRobot = new Robot();
            }

            writefln("Collisons: %s that is %s%%", Robot.collisons,
                    (Robot.collisons / 10000.0f) * 100);
        }
    }

}