#import <Foundation/Foundation.h>
#import "RomanNumerals.h"
@implementation RomanNumerals
+ (NSString *)romanNumeralsForValue:(int)value {
    double remaining = value;
    NSMutableArray *chunks = [[NSMutableArray alloc] init];
    while (remaining > 0) {
        if (remaining > 1000) {
            double thousands = floor(remaining/1000) * 1000;
            [chunks addObject:[NSNumber numberWithDouble:thousands]];
            remaining -= thousands;
        } else if (remaining > 100) {
            double hundreds = floor(remaining/100) * 100;
            [chunks addObject:[NSNumber numberWithDouble:hundreds]];
            remaining -= hundreds;
        } else if (remaining > 10) {
            double tens = floor(remaining/10) * 10;
            [chunks addObject:[NSNumber numberWithDouble:tens]];
            remaining -= tens;
        } else {
            [chunks addObject:[NSNumber numberWithDouble:remaining]];
            remaining = 0;
        }
    }
    NSDictionary *romanNumbers = @{
        @1: @"I", @2: @"II", @3: @"III", @4: @"IV", @5: @"V",
        @6: @"VI", @7: @"VII", @8: @"VIII", @9: @"IX",
        @10: @"X", @20: @"XX", @30: @"XXX", @40: @"XL",
        @50: @"L", @60: @"LX", @70: @"LXX", @80: @"LXXX",
        @90: @"XC", @100: @"C", @200: @"CC", @300: @"CCC",
        @400: @"CD", @500: @"D", @600: @"DC", @700: @"DCC",
        @800: @"DCCC", @900: @"CM", @1000: @"M", @2000: @"MM", @3000: @"MMM"
    };
    NSString *romanNumber = @"";
    for (NSNumber *num in chunks) {
        romanNumber = [romanNumber stringByAppendingString:[romanNumbers objectForKey:num]];
    }
    return romanNumber;
}
@end
