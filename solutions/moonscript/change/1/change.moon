
change = (amount, denominations) ->
  C = {[0]: 0}
  S = {}
  for p = 1, amount
	min = math.maxinteger
	local coin
	for i = 1, #denominations
	  if denominations[i] <= p
		if C[p - denominations[i]] < min
		  min = 1 + C[p - denominations[i]]
		  coin = i
	C[p] = min
	S[p] = coin
  return S
get_change = (first_coin, denominations, amount) ->
  result = {}
  while amount > 0
    coin = denominations[first_coin[amount]]
    assert coin, "can't make target with given coins"
    table.insert result, 1, coin
    amount -= coin
  result
{
  make_change: (target_amount, denominations) ->
    assert target_amount >= 0, "target can't be negative"
    first_coin = change target_amount, denominations
    get_change first_coin, denominations, target_amount
}
