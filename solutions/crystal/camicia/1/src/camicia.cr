class Camicia
  PAYMENT = {"J" => 1, "Q" => 2, "K" => 3, "A" => 4}

  def initialize(player_a : Array(String), player_b : Array(String))
    @player_a = player_a
    @player_b = player_b
  end

  private def next_player(player : Symbol) : Symbol
    player == :a ? :b : :a
  end

  private def normalize_deck(deck : Array(String)) : String
    deck.map { |card| PAYMENT.has_key?(card) ? card : "N" }.join(",")
  end

  def simulate_game
    player_a = @player_a.dup
    player_b = @player_b.dup
    pile = [] of String
    states = Set(String).new
    tricks = 0
    moves = 0
    payment_due = 0
    current_player = :a
    collector = nil.as(Symbol?)

    loop do
      if pile.empty? && payment_due == 0
        state = "#{current_player}|#{normalize_deck(player_a)}|#{normalize_deck(player_b)}"
        if states.includes?(state)
          return {status: "loop", moves: moves, tricks: tricks}
        end
        states.add(state)
      end

      current_deck = current_player == :a ? player_a : player_b
      opponent_deck = current_player == :a ? player_b : player_a

      if current_deck.empty?
        if !pile.empty?
          opponent_deck.concat(pile)
          pile.clear
          tricks += 1
        end
        return {status: "finished", moves: moves, tricks: tricks}
      end

      played = current_deck.shift
      pile << played
      moves += 1

      if PAYMENT[played]?
        payment_due = PAYMENT[played]
        collector = current_player
        current_player = next_player(current_player)
      elsif payment_due > 0
        payment_due -= 1

        if payment_due == 0
          winner = collector.not_nil!
          winner_deck = winner == :a ? player_a : player_b
          winner_deck.concat(pile)
          pile.clear
          tricks += 1

          if player_a.empty? || player_b.empty?
            return {status: "finished", moves: moves, tricks: tricks}
          end

          collector = nil
          current_player = winner
        end
      else
        current_player = next_player(current_player)
      end
    end
  end
end