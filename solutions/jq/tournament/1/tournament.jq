def other_result: {loss: "win", win: "loss"}.[.] // .;

def parse_matches:
  def update_team($team; $result):
      .[$team] //= {mp: 0, win: 0, draw: 0, loss: 0, points: 0}
    | .[$team].mp += 1
    | .[$team].[$result] += 1 # win, draw or loss
    |   if $result == "win"  then .[$team].points += 3
      elif $result == "draw" then .[$team].points += 1
      end
  ;

    reduce .[] / ";" as [$teamA, $teamB, $result]
      ({}; . + update_team($teamA; $result)
         | . + update_team($teamB; $result | other_result))
  | to_entries   # convert object of teams to array of teams objects
  | map({team: .key, tally: .value})
  | sort_by(.team)
  | reverse
  | sort_by(.tally.points)
  | reverse
;

def print_score:
  def fl($width): tostring | . + (" " * ($width - length));
  def fr($width): tostring | (" " * ($width - length) + .);

  "Team                           | MP |  W |  D |  L |  P",
  (   .[]
    | "\(.team | fl(31))|\(.tally.mp | fr(3)) |\(.tally.win | fr(3)) |\(.tally.draw | fr(3)) |\(.tally.loss | fr(3)) |\(.tally.points | fr(3))"
  )
;

.matches
| parse_matches
| print_score