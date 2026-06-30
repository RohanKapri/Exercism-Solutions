module robot_simulator;

class RobotSimulator
{
    int x;
    int y;
    string direction;

    this(int x, int y, string direction)
    {
        this.x = x;
        this.y = y;
        this.direction = direction;
    }

    void move(string commands)
    {
        foreach (cmd; commands)
        {
            switch (cmd)
            {
                case 'R':
                    final switch (direction)
                    {
                        case "north": direction = "east";  break;
                        case "east":  direction = "south"; break;
                        case "south": direction = "west";  break;
                        case "west":  direction = "north"; break;
                    }
                    break;

                case 'L':
                    final switch (direction)
                    {
                        case "north": direction = "west";  break;
                        case "west":  direction = "south"; break;
                        case "south": direction = "east";  break;
                        case "east":  direction = "north"; break;
                    }
                    break;

                case 'A':
                    final switch (direction)
                    {
                        case "north": ++y; break;
                        case "south": --y; break;
                        case "east":  ++x; break;
                        case "west":  --x; break;
                    }
                    break;

                default:
                    break;
            }
        }
    }
}