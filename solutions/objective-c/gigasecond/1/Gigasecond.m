#import <Foundation/Foundation.h>
#import "Gigasecond.h"
@implementation Gigasecond
- (id)initWithStartDate:(NSDate *)date {
    if (self = [super init]) {
        startDate = date;
        gigasecond = 1000000000;
    }
    return self;
}
- (NSDate *)gigasecondDate {
    return [startDate dateByAddingTimeInterval:gigasecond];
}
@end
