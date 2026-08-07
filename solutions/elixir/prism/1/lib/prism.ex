defmodule Prism do
  @doc """
  Finds the sequence of prisms that the laser will hit.
  """

  @type start :: %{angle: number(), x: number(), y: number()}
  @type prism :: %{id: integer(), angle: number(), x: number(), y: number()}

  @spec find_sequence(prisms :: [prism()], start :: start()) :: [integer()]
  def find_sequence(prisms, start) do
    find_sequence_req(prisms, start, {[], Map.get(start, :angle)})
  end

  @epsilon 0.003

  defp find_sequence_req(prisms, start, {acc, _angle}) do
    next = find_next(prisms, start)

    if next do
      id = Map.get(next, :id)
      find_sequence_req(prisms, next, {[id | acc], Map.get(next, :angle)})
    else
      Enum.reverse(acc)
    end
  end

  defp find_next(prisms, start) do
    next =
      prisms
      |> Enum.filter(&hit_prism?(&1, start))
      |> Enum.min(fn p1, p2 -> lt(dist(start, p1), dist(start, p2)) end, fn -> nil end)

    if next do
      Map.update!(next, :angle, fn a -> Map.get(start, :angle) + a end)
    else
      nil
    end
  end

  defp hit_prism?(%{id: id}, %{id: id}), do: false

  defp hit_prism?(prism, start) do
    %{angle: _a, x: x, y: y} = prism
    %{angle: a, x: x0, y: y0} = start

    a_norm_180 = normalize_for_tan_deg(a)
    delta_y = y - y0
    delta_x = x - x0

    is_on_line =
      if eqe(delta_x, 0) do
        eqe(abs(a_norm_180), 90.0)
      else
        a_rad = a_norm_180 * :math.pi() / 180.0

        at = :math.atan(delta_y / delta_x)
        eqe(a_rad, at)
      end

    if is_on_line do
      a_norm = normalize_angle(a)

      cond do
        eqe(a_norm, 360.0) or (geq(a_norm, 0.0) and lt(a_norm, 90.0)) ->
          lt(x0, x) and leq(y0, y)

        geq(a_norm, 90.0) and lt(a_norm, 180.0) ->
          geq(x0, x) and lt(y0, y)

        geq(a_norm, 180.0) and lt(a_norm, 270.0) ->
          gt(x0, x) and geq(y0, y)

        geq(a_norm, 270.0) and lt(a_norm, 360.0) ->
          leq(x0, x) and gt(y0, y)
      end
    else
      false
    end
  end

  defp normalize_angle(a, base \\ 360.0)
  defp normalize_angle(a, base) when a < 0, do: normalize_neg_angle(a, base)
  defp normalize_angle(a, base), do: normalize_pos_angle(a, base)
  defp normalize_pos_angle(a, base) when a >= 0 and a < base, do: a

  defp normalize_pos_angle(a, base) when a >= 0 do
    normalize_pos_angle(a - base, base)
  end

  defp normalize_neg_angle(a, _base) when a >= 0, do: a

  defp normalize_neg_angle(a, base) when a < 0 do
    normalize_neg_angle(a + base, base)
  end

  defp eqe(x0, x1, eps \\ @epsilon), do: abs(x0 - x1) < eps
  defp leq(x0, x1), do: eqe(x0, x1) or x0 < x1
  defp lt(x0, x1), do: !eqe(x0, x1) and x0 < x1
  defp geq(x0, x1), do: eqe(x0, x1) or x0 > x1
  defp gt(x0, x1), do: !eqe(x0, x1) and x0 > x1

  defp dist(%{x: x0, y: y0}, %{x: x1, y: y1}),
    do: :math.sqrt(:math.pow(x1 - x0, 2) + :math.pow(y1 - y0, 2))

  defp normalize_for_tan_deg(x) do
    y = normalize_angle(x, 180.0)
    y = if y <= -90.0, do: y + 180.0, else: y
    if y > 90.0, do: y - 180.0, else: y
  end
end