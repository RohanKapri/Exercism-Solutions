#import <Foundation/Foundation.h>
#import "RunLengthEncoding.h"
@implementation RunLengthEncoding
+ (NSString *)decode:(NSString *)string {
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSString *iterationsString = @"";
    NSString *decoded = @"";
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    for (int i = 0; i < [string length]; i++) {
        unichar current = [string characterAtIndex:i];
        if ([numbers characterIsMember:current]) {
            iterationsString = [iterationsString stringByAppendingString:[NSString stringWithFormat: @"%C", current]];
        } else if ([iterationsString isEqualTo:@""]) {
            decoded = [decoded stringByAppendingString:[NSString stringWithFormat: @"%C", current]];
        } else {
            int iterations = [[formatter numberFromString:iterationsString] intValue];
            for (int i = 0; i < iterations; i++) {
                decoded = [decoded stringByAppendingString:[NSString stringWithFormat: @"%C", current]];
            }
            iterationsString = @"";
        }
    }
    return decoded;
}
+ (NSString *)encode:(NSString *)string {
    NSString *encoded = @"";
    int count = 1;
    unichar lastChar = [string characterAtIndex:0];
    for (int i = 1; i < [string length]; i++) {
        BOOL isLastIteration = i + 1 == [string length];
        unichar current = [string characterAtIndex:i];
        if (current == lastChar) {
            count++;
        } else if (current != lastChar) {
            if (count == 1) {
                encoded = [encoded stringByAppendingFormat:@"%c", lastChar];
            } else {
                encoded = [encoded stringByAppendingFormat:@"%d%c", count, lastChar];
                count = 1;
            }
            lastChar = current;
        }
        if (isLastIteration) {
            if (count == 1) {
                encoded = [encoded stringByAppendingFormat:@"%c", lastChar];
            } else {
                encoded = [encoded stringByAppendingFormat:@"%d%c", count, lastChar];
                count = 1;
            }
            lastChar = current;
        }
    }
    return encoded;
}
@end
