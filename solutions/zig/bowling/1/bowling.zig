const std = @import("std");

pub const Error = error{ GameOver, PinCountExceeded, GameIncomplete };

pub const Game = struct {
    // This struct, as well as its fields and methods, needs to be implemented.

    rolls : [21]u4,
    roll_i: usize,
    curr_frame : [3]u4,
    frame_i: usize,
    frame: usize,
    
    /// Initializes a Game.
    pub fn init() Game {
        return .{
            .rolls = .{0} ** 21,
            .roll_i = 0,
            .curr_frame = .{0} ** 3,
            .frame_i = 0,
            .frame = 0
        };
    }

    /// Records a roll that knocks down `pins` pins.
    pub fn roll(self: *Game, pins: u4) Error!void {
        var total: usize = 0;
        for (0..self.frame_i) |i| { total += self.curr_frame[i]; }

        if (self.frame>=10) return Error.GameOver;
        if (pins>10 - total % 10) return Error.PinCountExceeded;

        self.rolls[self.roll_i] = pins; self.roll_i+=1;
        self.curr_frame[self.frame_i] = pins; self.frame_i+=1;
        total += pins;
        if (self.frame_i == 3 or (self.frame < 9 and (self.frame_i == 2 or total == 10)) 
            or (self.frame >= 9 and self.frame_i == 2 and total < 10)) {
            self.frame += 1;
            self.frame_i = 0;
        }
    }

    /// Returns the score of a complete game.
    pub fn score(self: Game) Error!u32 {
        if (self.frame<10) return Error.GameIncomplete;

        var total: u32 = 0;
        var n : usize = 0;
        for (0..10) |_| {
            var frame_total: u32 = self.rolls[n];
            frame_total += self.rolls[n + 1];
            total += frame_total;
            if (self.rolls[n] == 10 or frame_total == 10) {
                total +=  self.rolls[n + 2];
            }
            if (self.rolls[n] == 10) {
                n+=1;
            } else {
                n+=2;
            }
        }
        return total;
    }
};