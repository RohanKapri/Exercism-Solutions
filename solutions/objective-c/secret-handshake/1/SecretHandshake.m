#import <Foundation/Foundation.h>
#import "SecretHandshake.h"
@implementation SecretHandshake
- (id)initWithNumber:(int)number {
    if (self = [super init]) {
        NSString *binary = [self getLastFiveDigits:[self decToBinary:number]];
        NSMutableArray *commands = [[NSMutableArray alloc] init];
        NSDictionary *commandDict = @{@1: @"jump", @2: @"close your eyes", @3: @"double blink", @4: @"wink" };
        NSUInteger length = [binary length];
        unichar buffer[length+1];
        [binary getCharacters:buffer range:NSMakeRange(0, length)];
        BOOL shouldReverse = NO;
        
        for(int i = (int)length - 1; i >= 0; i--) {
            NSString* digit = [NSString stringWithCharacters: &buffer[i] length: 1];
            BOOL shouldAct = [digit isEqual:@"1"];
            if (i == 0 && shouldAct) {
                shouldReverse = YES;
            } else if (shouldAct) {
                [commands addObject:[commandDict objectForKey:[NSNumber numberWithInt:i]]];
            }
        }
        
        if (shouldReverse) {
            [self setCommands:[[commands reverseObjectEnumerator] allObjects]];
        } else {
            [self setCommands:commands];
        }
    }
    return self;
}
- (NSString *)getLastFiveDigits:(NSString *)binary {
    NSUInteger length = [binary length];
    if (length == 5) {
        return binary;
    } else if (length > 5) {
        return [binary substringWithRange:NSMakeRange(length-5, 5)];
    } else {
        NSString *formattedBinary = [binary copy];
        for (int i = (int)length; i < 5; i++) {
            formattedBinary = [@"0" stringByAppendingString:formattedBinary];
        }
        
        return formattedBinary;
    }
 }
- (NSString *)decToBinary:(NSUInteger)decInt {
    NSString *string = @"" ;
    NSUInteger x = decInt ;
    do {
        string = [[NSString stringWithFormat: @"%lu", x&1] stringByAppendingString:string];
    } while (x >>= 1);
    return [self getLastFiveDigits:string];
}
@end
