import Foundation

enum Result: String {
  case win
  case loss
  case draw
}

struct TeamStats {
  var matchesPlayed: Int = 0
  var matchesWon: Int = 0
  var matchesDrawn: Int = 0
  var matchesLost: Int = 0
  var points: Int = 0
}

class Tournament {
  // Write your code for the 'Tournament' exercise in this file.
  var teams = [String:TeamStats]()

  init() { }

  private func formatTally(_ team: String, _ stats: TeamStats) -> String {
    let namePart = team.padding(toLength: 30, withPad: " ", startingAt: 0)
    return String(format: "%@ | %2d | %2d | %2d | %2d | %2d", 
                  namePart, 
                  stats.matchesPlayed, 
                  stats.matchesWon, 
                  stats.matchesDrawn, 
                  stats.matchesLost, 
                  stats.points)
  }

  func tally() -> [String] {
    let header: String = "Team                           | MP |  W |  D |  L |  P"
    let sortedTeams = self.teams.sorted {
      if $0.value.points != $1.value.points {
        return $0.value.points > $1.value.points
      }
      return $0.key < $1.key
    }

    var result: [String] = [header]
    for (team, stats) in sortedTeams {
      let formattedTally: String = formatTally(team, stats)
      result.append(formattedTally)
    }
    return result
  }

  func addMatch(_ match: String) {
    let parts = match.components(separatedBy: ";")
    let t1 = parts[0]
    let t2 = parts[1]
    
    var stats1 = self.teams[t1, default: TeamStats()]
    var stats2 = self.teams[t2, default: TeamStats()]

    switch (Result(rawValue: parts[2])) {
      case .win:
        stats1.matchesWon += 1
        stats1.points += 3
        stats2.matchesLost += 1
      case .loss:
        stats2.matchesWon += 1
        stats2.points += 3
        stats1.matchesLost += 1
      case .draw:
        stats1.matchesDrawn += 1
        stats1.points += 1
        stats2.matchesDrawn += 1
        stats2.points += 1
      default: break
    }

    stats1.matchesPlayed += 1
    stats2.matchesPlayed += 1

    self.teams[t1] = stats1
    self.teams[t2] = stats2
  }
}