module matching_brackets;

pure bool isPaired(immutable string input)
{
    char[] stack;

    foreach (c; input)
    {
        switch (c)
        {
            case '(':
            case '[':
            case '{':
                stack ~= c;
                break;

            case ')':
                if (stack.length == 0 || stack[$ - 1] != '(')
                    return false;
                stack.length--;
                break;

            case ']':
                if (stack.length == 0 || stack[$ - 1] != '[')
                    return false;
                stack.length--;
                break;

            case '}':
                if (stack.length == 0 || stack[$ - 1] != '{')
                    return false;
                stack.length--;
                break;

            default:
                // Ignore all other characters
                break;
        }
    }

    return stack.length == 0;
}

unittest
{
    immutable int allTestsEnabled = 0;

    assert(isPaired("[]"));
}