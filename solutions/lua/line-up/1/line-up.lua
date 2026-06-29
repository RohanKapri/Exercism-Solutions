return {
  format = function(name, number)
    local suffix do
      suffix = 'th'

      if number // 10 % 10 ~= 1 then
        if number % 10 == 1 then
          suffix = 'st'
        elseif number % 10 == 2 then
          suffix = 'nd'
        elseif number % 10 == 3 then
          suffix = 'rd'
        end
      end
    end

    return ('%s, you are the %d%s customer we serve today. Thank you!'):format(
      name,
      number,
      suffix
    )
  end
}