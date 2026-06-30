include std/sequence.e

sequence dirs   = {"north", "east", "south", "west"}
sequence coords = {{0, 1},  {1, 0}, {0, -1}, {-1, 0}}

public function move(sequence robot, sequence commands)
  for i = 1 to length(commands) do
    if commands[i] = 'R' then
      robot[3] = dirs[remainder(find(robot[3], dirs), 4) + 1]
    elsif commands[i] = 'L' then
      robot[3] = dirs[remainder(find(robot[3], dirs) + 2, 4) + 1]
    elsif commands[i] = 'A' then
      robot[1..2] += coords[find(robot[3], dirs)]
    end if
  end for
  return robot
end function