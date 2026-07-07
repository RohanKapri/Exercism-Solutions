#import <Foundation/Foundation.h>
#import "Sieve.h"
@implementation Sieve
+ (NSArray *)primesUpTo:(int)number {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    Sieve *s = [[Sieve alloc] init];
    for(int i = 2; i<=number; i++) {
        if ([s isPrime:i]) {
            [array addObject:[NSNumber numberWithInt:i]];
        }
    };
    
    return array;
}
- (BOOL)isPrime:(int)number {
    if (number == 1) return NO;
    if (number == 2) return YES;
    int limit = sqrt(number);
    for (int i = 2; i <= limit; i++) {
        if (number % i == 0) {
            return NO;
        }
    }
    return YES;
}
@end
