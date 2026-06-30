
#import <Foundation/Foundation.h>
#import "CollatzConjecture.h"
@implementation CollatzConjecture
+ (long)stepsForNumber:(int)number {
    int iterations = 0;
    int current = number;
    if (number < 1) return NSNotFound;
    
    while (current > 1) {
        iterations++;
        if (current % 2 != 0) {
            current = current * 3 + 1;
        } else {
            current = current / 2;
        }
    }
    return iterations;
}
@end