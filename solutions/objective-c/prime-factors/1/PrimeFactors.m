#import <Foundation/Foundation.h>
#import "PrimeFactors.h"
@implementation PrimeFactors
+ (NSMutableArray*)factorsForInteger:(long)integer {
    NSMutableArray* factors = [[NSMutableArray alloc] init];
    long currentInteger = integer;
    for (long i = 2; i<=sqrt(currentInteger); i++) {
        if (currentInteger % i == 0) {
            [factors addObject:[NSNumber numberWithLong:i]];
            currentInteger = currentInteger/i;
            i = i-1;
        }
    }
    
    if (currentInteger > 1) {
        [factors addObject:[NSNumber numberWithLong:currentInteger]];
    }
    return factors;
}
@end
