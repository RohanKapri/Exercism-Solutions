#import <Foundation/Foundation.h>
#import "Leap.h"
@implementation Leap
- (id)initWithCalendarYear:(NSNumber *)year {
    if (self = [super init]) {
        BOOL divisibleByFour = [year intValue] % 4 == 0;
        BOOL divisibleByHundred = [year intValue] % 100 == 0;
        BOOL divisibleByFourHundred = [year intValue] % 400 == 0;
        if (divisibleByFourHundred || (divisibleByFour && !divisibleByHundred)) {
            self.isLeapYear = YES;
        } else {
            self.isLeapYear = NO;
        }
    }
    return self;
}
@end