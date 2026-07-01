reverse = (str) ->
  result = ""
  for _, code_point in utf8.codes str
    result = (utf8.char code_point) .. result
  result
  
return reverse