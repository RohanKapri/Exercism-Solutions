enum BowlingError: Error {
    case negativePins
    case tooManyPinsInFrame
    case gameInProgress
    case gameIsOver
}

class Bowling {
    private static let totalFrames = 10
    private static let totalPins = 10
    private static let minimumRollsForCompleteGame = 12
    private static let maximumRollsInRegularGame = 20

    private var rolls: [Int]
    
    init(_ rolls: [Int]) {
        self.rolls = rolls
    }
    
    func roll(pins: Int) throws {
        guard pins >= 0 else {
            throw BowlingError.negativePins
        }

        guard !isGameOver() else {
            throw BowlingError.gameIsOver
        }

        guard !tooManyPinsInFrame(pins) else {
            throw BowlingError.tooManyPinsInFrame
        }

        rolls.append(pins)
    }
    
    func score() throws -> Int {
        guard !isGameInProgress() else {
            throw BowlingError.gameInProgress
        }
        
        var score = 0
        var frameIndex = 0
        for _ in 0..<Self.totalFrames {
            if isStrike(frameIndex) {
                score += scoreStrike(frameIndex)
                frameIndex += 1
            } else if isSpare(frameIndex) {
                score += scoreSpare(frameIndex)
                frameIndex += 2
            } else {
                score += scoreFrame(frameIndex)
                frameIndex += 2
            }
        }
        
        return score
    }
    
    private func tooManyPinsInFrame(_ pins: Int) -> Bool {
        if pins > Self.totalPins {
            return true
        }
        
        if isFramePinCountExceeding(pins: pins) {
            return true
        }
        
        if isTenthFrameBonusExceeding(pins: pins) {
            return true
        }
        
        return false
    }
    
    private func isFramePinCountExceeding(pins: Int) -> Bool {
        !rolls.count.isMultiple(of: 2) && !isLastFrameStrike() && sumWithPreviousRoll(current: pins) > Self.totalPins
    }
    
    private func isTenthFrameBonusExceeding(pins: Int) -> Bool {
        rolls.count.isMultiple(of: 2) && !isLastFrameStrike() && isSecondToLastFrameStrike() && sumWithPreviousRoll(current: pins) > Self.totalPins
    }
    
    private func sumWithPreviousRoll(current pins: Int) -> Int {
        pins + rolls[rolls.count - 1]
    }
    
    private func isGameOver() -> Bool {
        if rolls.count < Self.maximumRollsInRegularGame {
            return false
        }
        
        if hasPendingStrikeBonus() {
            return false
        }
        
        if hasPendingSpareBonus() {
            return false
        }
        
        return true
    }
    
    private func isGameInProgress() -> Bool {
        if rolls.count < Self.minimumRollsForCompleteGame {
            return true
        }
        
        if hasPendingStrikeInFinalFrame() {
            return true
        }
        
        if hasPendingStrikeBonus() {
            return true
        }
        
        if hasPendingSpareBonus() {
            return true
        }
        
        return false
    }
    
    private func hasPendingStrikeInFinalFrame() -> Bool {
        rolls.count == Self.maximumRollsInRegularGame - 1 && isLastFrameStrike()
    }
    
    private func hasPendingStrikeBonus() -> Bool {
        rolls.count == Self.maximumRollsInRegularGame && isSecondToLastFrameStrike()
    }
    
    private func hasPendingSpareBonus() -> Bool {
        rolls.count == Self.maximumRollsInRegularGame && isLastFrameSpare()
    }
    
    private func isLastFrameStrike() -> Bool {
        isStrike(rolls.count - 1)
    }
    
    private func isSecondToLastFrameStrike() -> Bool {
        isStrike(rolls.count - 2)
    }
    
    private func isLastFrameSpare() -> Bool {
        isSpare(rolls.count - 2)
    }
    
    private func isStrike(_ index: Int) -> Bool {
        rolls[index] == Self.totalPins
    }
    
    private func isSpare(_ index: Int) -> Bool {
        rolls[index] + rolls[index + 1] == Self.totalPins
    }
    
    private func scoreStrike(_ index: Int) -> Int {
        Self.totalPins + rolls[index + 1] + rolls[index + 2]
    }
    
    private func scoreSpare(_ index: Int) -> Int {
        Self.totalPins + rolls[index + 2]
    }
    
    private func scoreFrame(_ index: Int) -> Int {
        rolls[index] + rolls[index + 1]
    }
}