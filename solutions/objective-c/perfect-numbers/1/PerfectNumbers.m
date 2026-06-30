#import <Foundation/Foundation.h>
#import "PerfectNumbers.h"
@implementation NumberClassifier
- (id)initWithNumber:(int)number {
    if (self = [super init]) {
        [self setNumber:[NSNumber numberWithInt:number]];
    }
    return self;
}
- (NumberClassification)classification {
    int currentSum = 0;
    int number = [self.number intValue];
    for (int i = 1; i <= number / 2; i++ ) {
        if (number % i == 0) {
            currentSum += i;
        }
    }
    
    if (currentSum == number) {
        return NumberClassificationPerfect;
    } else if (currentSum > number) {
        return NumberClassificationAbundant;
    } else {
        return NumberClassificationDeficient;
    }
    
    return currentSum;
}
@end
