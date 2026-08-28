{
  transform: (legacy) ->
    {ltr\lower!, tonumber(score) for score, list in pairs(legacy) for ltr in *list}
}