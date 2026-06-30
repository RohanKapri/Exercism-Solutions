#import <Foundation/Foundation.h>
#import "SumOfMultiples.h"
@implementation SumOfMultiples
+ (NSNumber *)toLimit:(NSNumber *)limit inMultiples:(NSArray *)multiples {
    NSMutableSet *set = [[NSMutableSet alloc] init];
    for (NSNumber *num in multiples) {
        NSInteger input = [num integerValue];
        if (input > 0) {
            for (int i = 1; (input * i) < [limit integerValue]; i++) {
                [set addObject:[NSNumber numberWithInteger:input * i]];
            }
        }
    }
    int sum = 0;
    for (NSNumber *num in set) {
        sum = sum + [num intValue];
    }
    return [NSNumber numberWithInt:sum];
}
@end
