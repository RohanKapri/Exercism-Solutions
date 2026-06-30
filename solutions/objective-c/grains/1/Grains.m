#import <Foundation/Foundation.h>
#import "Grains.h"
@implementation Grains
- (unsigned long long)grainsAtSquareNumber:(int)number {
    if (number > 64 || number < 1) {
        return -1;
    }
    unsigned long long grains = 1;
    for (int i = 1; i <= number; i++) {
        if (i == 1) {
            grains = 1;
        } else {
            grains *= 2;
        }
    }
    return grains;
}
- (unsigned long long)grainsAtBoard {
    return [self grainsAtSquareNumber:64] * 2 - 1;
}
@end
