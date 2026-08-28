local function simulate_game(player_a, player_b)
  local payment = { J = 1, Q = 2, K = 3, A = 4 }

  local pile = {}
  local states = {}
  local tricks = 0
  local cards = 0
  local payment_due = 0
  local players = { player_a, player_b }

  local function normalize_deck(deck)
    local result = {}
    for _, card in ipairs(deck) do
      result[#result + 1] = payment[card] and card or 'N'
    end
    return table.concat(result, ',')
  end

  local function state_key()
    return normalize_deck(player_a) .. '|' .. normalize_deck(player_b) .. '|' .. payment_due
  end

  while true do
    local player, opponent = table.unpack(players)

    if #player == 0 then
      if #pile > 0 then
        for _, card in ipairs(pile) do
          opponent[#opponent + 1] = card
        end
        pile = {}
        tricks = tricks + 1
      end
      return { status = 'finished', cards = cards, tricks = tricks }
    end

    if #pile == 0 then
      local key = state_key()
      if states[key] then
        return { status = 'loop', cards = cards, tricks = tricks }
      end
      states[key] = true
    end

    local played = table.remove(player, 1)
    pile[#pile + 1] = played
    cards = cards + 1

    if payment[played] then
      payment_due = payment[played]
      players = { opponent, player }
    elseif payment_due > 0 then
      payment_due = payment_due - 1
      if payment_due == 0 then
        for _, card in ipairs(pile) do
          opponent[#opponent + 1] = card
        end
        pile = {}
        tricks = tricks + 1
        players = { opponent, player }

        if #player == 0 then
          return { status = 'finished', cards = cards, tricks = tricks }
        end
      end
    else
      players = { opponent, player }
    end
  end
end

return { simulate_game = simulate_game }