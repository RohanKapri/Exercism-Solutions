#import <Foundation/Foundation.h>
#import "NthPrime.h"
@implementation NthPrime
+ (int)primeNum:(int)primeNum {
    if (primeNum == 0) return 0;
    if (primeNum == 1) return 2;
    int nthPrime = 2;
    int number = 3;
    
    while (primeNum > nthPrime) {
        int currentNumber = number + 2;
        if ([[self class] isPrime:currentNumber]) {
            nthPrime++;
        }
        number = currentNumber;
    }
    return number;
}
+ (BOOL)isPrime:(int)number {
    if (number <= 1) return NO;
    if (number == 2) return YES;
    if (number % 2 == 0) return NO;
    int boundary = (int)floor(sqrt(number));
          
    for (int i = 3; i <= boundary; i += 2)
        if (number % i == 0)
            return NO;
    
    return YES;
}
@end
