defmodule LineUp do
  @doc """
  Formats a full ticket sentence for the given name and number, including
  the person's name, the ordinal form of the number, and fixed descriptive text.
  """
  @spec format(name :: String.t(), number :: pos_integer()) :: String.t()
  def format(name, number) do
    "#{name}, you are the #{ordinal(number)} customer we serve today. Thank you!"
  end

  defp ordinal(number) do
    suffix =
      cond do
        rem(number, 100) in [11, 12, 13] ->
          "th"

        rem(number, 10) == 1 ->
          "st"

        rem(number, 10) == 2 ->
          "nd"

        rem(number, 10) == 3 ->
          "rd"

        true ->
          "th"
      end

    "#{number}#{suffix}"
  end
end