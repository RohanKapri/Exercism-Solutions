-module(flower_field).

-export([annotate/1]).

%% @doc Annotates a Flower Field garden with adjacent flower counts.
annotate([]) -> [];
annotate([""]) -> [""];
annotate(Garden) ->
    Rows = length(Garden),
    Cols = length(hd(Garden)),
    
    %% Convert list of strings into a 2D array or use indexed lookups.
    %% Since lists of strings are common in Erlang, we can find the flower counts
    %% for each position (R, C) from 1 to Rows and 1 to Cols.
    lists:seq(1, Rows) |> lists:map(fun(R) ->
        lists:seq(1, Cols) |> lists:map(fun(C) ->
            case element_at(Garden, R, C) of
                $* -> $*;
                _ ->
                    Count = count_adjacent_flowers(Garden, R, C, Rows, Cols),
                    case Count of
                        0 -> $\s;
                        _ -> $0 + Count
                    end
            end
        end)
    end).

%% Helper to get character at row R, column C (1-indexed)
element_at(Garden, R, C) ->
    RowStr = lists:nth(R, Garden),
    lists:nth(C, RowStr).

%% Count adjacent flowers around (R, C)
count_adjacent_flowers(Garden, R, C, Rows, Cols) ->
    Offsets = [
        {-1, -1}, {-1, 0}, {-1, 1},
        {0, -1},           {0, 1},
        {1, -1},  {1, 0},  {1, 1}
    ],
    lists:foldl(fun({DR, DC}, Acc) ->
        NR = R + DR,
        NC = C + DC,
        if
            NR >= 1, NR =< Rows, NC >= 1, NC =< Cols ->
                case element_at(Garden, NR, NC) of
                    $* -> Acc + 1;
                    _ -> Acc
                end;
            true ->
                Acc
        end
    end, 0, Offsets).

    

    