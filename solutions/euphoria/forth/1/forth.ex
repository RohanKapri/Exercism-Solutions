include std/sequence.e
include std/text.e
include std/convert.e
include std/math.e
include std/map.e

sequence stack

function exec_forth(sequence words, map user_words)
  integer is_recording = 0
  sequence name = ""
  sequence fn = {}
  for j = 1 to length(words) do
    sequence word = words[j]
    if is_recording and equal(name, "") then
      if integer(to_number(word, -1)) then
        return "illegal operation"
      end if
      name = word
    elsif equal(word, ";") then
      put(user_words, name, {fn, copy(user_words)})
      is_recording = 0
      name = ""
      fn = {}
    elsif is_recording then
      fn &= {word}
    elsif integer(to_number(word, -1)) then
      stack &= {to_number(word)}
    elsif has(user_words, word) then
      sequence user_word = get(user_words, word)
      object res = exec_forth(user_word[1], user_word[2])
      if not equal(res, "") then
        return res
      end if
    elsif equal(word, ":") then
      is_recording = 1
    elsif equal(word, "+") then
      if length(stack) = 0 then return "empty stack"
      elsif length(stack) = 1 then return "only one value on the stack"
      end if
      stack = stack[1..$-2] & {stack[$-1] + stack[$]}
    elsif equal(word, "-") then
      if length(stack) = 0 then return "empty stack"
      elsif length(stack) = 1 then return "only one value on the stack"
      end if
      stack = stack[1..$-2] & {stack[$-1] - stack[$]}
    elsif equal(word, "*") then
      if length(stack) = 0 then return "empty stack"
      elsif length(stack) = 1 then return "only one value on the stack"
      end if
      stack = stack[1..$-2] & {stack[$-1] * stack[$]}
    elsif equal(word, "/") then
      if length(stack) = 0 then return "empty stack"
      elsif length(stack) = 1 then return "only one value on the stack"
      elsif stack[$] = 0 then return "divide by zero"
      end if
      stack = stack[1..$-2] & {floor(stack[$-1] / stack[$])}
    elsif equal(word, "dup") then
      if length(stack) = 0 then return "empty stack"
      end if
      stack &= {stack[$]}
    elsif equal(word, "drop") then
      if length(stack) = 0 then return "empty stack"
      end if
      stack = stack[1..$-1]
    elsif equal(word, "swap") then
      if length(stack) = 0 then return "empty stack"
      elsif length(stack) = 1 then return "only one value on the stack"
      end if
      stack = stack[1..$-2] & {stack[$], stack[$-1]}
    elsif equal(word, "over") then
      if length(stack) = 0 then return "empty stack"
      elsif length(stack) = 1 then return "only one value on the stack"
      end if
      stack &= {stack[$-1]}
    else
      return "undefined operation"
    end if
  end for
  return ""
end function

public function evaluate(sequence instructions)
  if not sequence(instructions[1]) then
    instructions = {instructions}
  end if
  stack = {}
  map user_words = new()
  for i = 1 to length(instructions) do
    sequence words = split(lower(instructions[i]))
    object res = exec_forth(words, user_words)
    if not equal(res, "") then
      return res
    end if
  end for
  return stack
end function