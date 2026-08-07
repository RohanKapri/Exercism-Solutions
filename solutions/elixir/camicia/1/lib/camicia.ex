defmodule Camicia do
  @doc """
    Simulate a card game between two players.
    Each player has a deck of cards represented as a list of strings.
    Returns a tuple with the result of the game:
    - `{:finished, cards, tricks}` if the game finishes with a winner
    - `{:loop, cards, tricks}` if the game enters a loop
    `cards` is the number of cards played.
    `tricks` is the number of central piles collected.

    ## Examples

      iex> Camicia.simulate(["2"], ["3"])
      {:finished, 2, 1}

      iex> Camicia.simulate(["J", "2", "3"], ["4", "J", "5"])
      {:loop, 8, 3}
  """

  alias __MODULE__.Game

  @face_values %{"J" => 1, "Q" => 2, "K" => 3, "A" => 4}

  defmodule Game do
    defstruct player_a: [],
              player_b: [],
              pile: [],
              turn: :player_a,
              penalty: 0,
              cards: 0,
              tricks: 0,
              state: :running,
              history: MapSet.new()
  end

  @spec simulate(list(String.t()), list(String.t())) ::
          {:finished | :loop, non_neg_integer(), non_neg_integer()}
  def simulate(player_a, player_b) do
    Stream.unfold(%Game{player_a: player_a, player_b: player_b}, fn
      nil ->
        nil

      game ->
        if game.state == :running do
          {game, move(game)}
        else
          {game, nil}
        end
    end)
    |> Enum.to_list()
    # |> tap(&IO.inspect/1)
    |> List.last()
    |> then(fn %Game{state: state, cards: cards, tricks: tricks} ->
      {state, cards, tricks}
    end)
  end

  defp opponent(:player_a), do: :player_b
  defp opponent(:player_b), do: :player_a

  defp move(%Game{pile: [], history: history} = game) do
    hands = {
      game.player_a |> Enum.map(&format_card/1),
      game.player_b |> Enum.map(&format_card/1)
    }

    if MapSet.member?(history, hands) do
      %{game | state: :loop}
    else
      new_history = MapSet.put(history, hands)
      new_game = do_move(game)
      %{new_game | history: new_history}
    end
  end

  defp move(game), do: do_move(game)

  defp do_move(%Game{turn: player} = game) do
    hand = Map.get(game, player)
    opponent_player = opponent(player)

    # If current player has no cards → opponent collects the pile and game ends
    if hand == [] do
      struct(game, %{
        opponent_player => Map.get(game, opponent_player) ++ Enum.reverse(game.pile),
        pile: [],
        tricks: game.tricks + 1,
        state: :finished
      })
    else
      [card | rest] = hand
      new_pile = [card | game.pile]

      # --- Case 1: face card played (starts or flips a penalty)
      if Map.has_key?(@face_values, card) do
        struct(game, %{
          player => rest,
          pile: new_pile,
          turn: opponent_player,
          penalty: @face_values[card],
          cards: game.cards + 1
        })

        # --- Case 2: number card played
      else
        cond do
          # Paying a penalty
          game.penalty > 0 ->
            remaining = game.penalty - 1

            if remaining == 0 do
              # Payment completed → opponent (the one who played last face) collects pile
              new_opponent_hand =
                Map.get(game, opponent_player) ++ Enum.reverse(new_pile)

              # Game may end if collector now has all cards
              new_state = if rest == [], do: :finished, else: :running

              struct(game, %{
                player => rest,
                opponent_player => new_opponent_hand,
                pile: [],
                turn: opponent_player,
                penalty: 0,
                cards: game.cards + 1,
                tricks: game.tricks + 1,
                state: new_state
              })
            else
              # Still paying
              struct(game, %{
                player => rest,
                pile: new_pile,
                turn: player,
                penalty: remaining,
                cards: game.cards + 1
              })
            end

          # --- Normal play (no penalty active)
          game.penalty == 0 ->
            struct(game, %{
              player => rest,
              pile: new_pile,
              turn: opponent_player,
              cards: game.cards + 1
            })
        end
      end
    end
  end

  defp format_card(card) when card in ~w(J Q K A), do: card
  defp format_card(_), do: "-"
end