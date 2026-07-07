const std = @import("std");
const mem = std.mem;

pub fn format(allocator: mem.Allocator, name: []const u8, number: u10) ![]u8 {
    const mask = 0x3;
    const ord = switch(number) {
        4...14 => "th",
        else => |value| blk: {
            const result = switch(value & mask) {
                1 => "st",
                2 => "nd",
                3 => "rd",
                else => "th",
            };
            break :blk result;
        }
    };
    const fmt = "{s}, you are the {d}{s} customer we serve today. Thank you!";
    return try std.fmt.allocPrint(allocator, fmt, .{name, number, ord});
}