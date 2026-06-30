#import <Foundation/Foundation.h>
#include <math.h>
#import "DifferenceOfSquares.h"
@implementation DifferenceOfSquares
- (id)initWithMax:(int)max {
    if (self = [super init]) {
        maxValue = max;
    }
    return self;
}
-(int)squareOfSum {
    int value = 0;
    for (int i = 1; i <= maxValue; i++) {
        value = i + value;
    }
    return pow(value, 2);
}
-(int)sumOfSquares {
    int value = 0;
    for (int i = 1; i <= maxValue; i++) {
        value = pow(i, 2) + value;
    }
    return value;
}
-(int)differenceOfSquares {
    return [self squareOfSum] - [self sumOfSquares];
}
@end