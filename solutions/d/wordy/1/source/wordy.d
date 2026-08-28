module wordy;

import std.regex;
import std.conv;
import std.exception;
import std.array;

long answer(immutable string question)
{
    // Check if the question starts with "What is" and ends with "?"
    if (question.length < 8 || question[0..7] != "What is" || question[$-1] != '?')
        throw new Exception("Invalid question format");
    
    auto body = question[7..$-1].idup; // Remove "What is" and "?", make it mutable
    
    // Match the first number
    auto numPattern = regex(`^ *(-?\d+)`);
    auto match = body.matchFirst(numPattern);
    enforce(!match.empty, new Exception("Invalid question format"));
    
    long result = to!long(match.captures[1]);
    body = match.post; // Get the rest of the string
    
    // Pattern to match an operation and a number  
    // Allow multiple spaces between operations
    auto opPattern = regex(`^ +(plus|minus|multiplied by|divided by) +(-?\d+)`);
    
    // Continue parsing operations
    while (body.length > 0)
    {
        // Try to match an operation and number
        auto opMatch = body.matchFirst(opPattern);
        if (opMatch.empty)
        {
            // If there's still content left that doesn't match, it's invalid
            // Check if there's only whitespace left
            bool onlyWhitespace = true;
            foreach (char c; body)
            {
                if (c != ' ' && c != '\t')
                {
                    onlyWhitespace = false;
                    break;
                }
            }
            if (!onlyWhitespace)
                throw new Exception("Invalid question format");
            break;
        }
        
        auto op = opMatch.captures[1];
        auto numStr = opMatch.captures[2];
        
        long num = to!long(numStr);
        
        // Perform the corresponding arithmetic operation
        switch (op)
        {
            case "plus":
                result += num;
                break;
            case "minus":
                result -= num;
                break;
            case "multiplied by":
                result *= num;
                break;
            case "divided by":
                enforce(num != 0, new Exception("Division by zero"));
                result /= num;
                break;
            default:
                throw new Exception("Unsupported operation");
        }
        
        body = opMatch.post; // Get the rest of the string
    }

    return result;
}

unittest
{
    import std.exception : assertThrown;

    immutable int allTestsEnabled = 0;

    // Just a number
    {
        immutable question = "What is 5?";
        assert(answer(question) == 5);
    }

    static if (allTestsEnabled)
    {
        // Just a zero
        {
            immutable question = "What is 0?";
            assert(answer(question) == 0);
        }

        // Just a negative number
        {
            immutable question = "What is -123?";
            assert(answer(question) == -123);
        }

        // Addition
        {
            immutable question = "What is 1 plus 1?";
            assert(answer(question) == 2);
        }

        // Addition with a left hand zero
        {
            immutable question = "What is 0 plus 2?";
            assert(answer(question) == 2);
        }

        // Addition with a right hand zero
        {
            immutable question = "What is 3 plus 0?";
            assert(answer(question) == 3);
        }

        // More addition
        {
            immutable question = "What is 53 plus 2?";
            assert(answer(question) == 55);
        }

        // Addition with negative numbers
        {
            immutable question = "What is -1 plus -10?";
            assert(answer(question) == -11);
        }

        // Large addition
        {
            immutable question = "What is 123 plus 45678?";
            assert(answer(question) == 45801);
        }

        // Subtraction
        {
            immutable question = "What is 4 minus -12?";
            assert(answer(question) == 16);
        }

        // Multiplication
        {
            immutable question = "What is -3 multiplied by 25?";
            assert(answer(question) == -75);
        }

        // Division
        {
            immutable question = "What is 33 divided by -3?";
            assert(answer(question) == -11);
        }

        // Multiple additions
        {
            immutable question = "What is 1 plus 1 plus 1?";
            assert(answer(question) == 3);
        }

        // Addition and subtraction
        {
            immutable question = "What is 1 plus 5 minus -2?";
            assert(answer(question) == 8);
        }

        // Multiple subtraction
        {
            immutable question = "What is 20 minus 4 minus 13?";
            assert(answer(question) == 3);
        }

        // Subtraction then addition
        {
            immutable question = "What is 17 minus 6 plus 3?";
            assert(answer(question) == 14);
        }

        // Multiple multiplication
        {
            immutable question = "What is 2 multiplied by -2 multiplied by 3?";
            assert(answer(question) == -12);
        }

        // Addition and multiplication
        {
            immutable question = "What is -3 plus 7 multiplied by -2?";
            assert(answer(question) == -8);
        }

        // Multiple division
        {
            immutable question = "What is -12 divided by 2 divided by -3?";
            assert(answer(question) == 2);
        }

        // Unknown operation
        {
            immutable question = "What is 52 cubed?";
            assertThrown(answer(question));
        }

        // Non math question
        {
            immutable question = "Who is the President of the United States?";
            assertThrown(answer(question));
        }

        // Reject problem missing an operand
        {
            immutable question = "What is 1 plus?";
            assertThrown(answer(question));
        }

        // Reject problem with no operands or operators
        {
            immutable question = "What is?";
            assertThrown(answer(question));
        }

        // Reject two operations in a row
        {
            immutable question = "What is 1 plus plus 2?";
            assertThrown(answer(question));
        }

        // Reject two numbers in a row
        {
            immutable question = "What is 1 plus 2 1?";
            assertThrown(answer(question));
        }

        // Reject postfix notation
        {
            immutable question = "What is 1 2 plus?";
            assertThrown(answer(question));
        }

        // Reject prefix notation
        {
            immutable question = "What is plus 1 2?";
            assertThrown(answer(question));
        }

        // Large number multiplication and addition
        {
            immutable question = "What is 342668567865 multiplied by 348 plus 6576456942334?";
            assert(answer(question) == 125825118559354L);
        }

        // Large number division and subtraction
        {
            immutable question = "What is 6548074074001254 divided by 654 minus 9876543210001?";
            assert(answer(question) == 135802468900L);
        }
    }
}
         