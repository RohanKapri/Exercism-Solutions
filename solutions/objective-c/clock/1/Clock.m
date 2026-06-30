#import <Foundation/Foundation.h>
#import "Clock.h"
@implementation Clock
+ (NSString*)clockWithHours:(int)hour {
    int displayHour = hour < 0 ? abs(abs(hour % 24) - 24) : hour % 24;
    return [[self class] clockWithHours:displayHour minutes:0];
}
+ (id)clockWithHours:(int)hour minutes:(int)minutes {
    Clock* clock = [[Clock alloc] init];
    
    int remainderHours = minutes < 0 ? floor(minutes / 60) - 1 : floor(minutes / 60);
    int hoursWithCountedMinutes = hour + remainderHours;
    int displayHour = hoursWithCountedMinutes < 0 ? abs(abs(hoursWithCountedMinutes % 24) - 24) : hoursWithCountedMinutes % 24;
    int displayMinutes = minutes < 0 ? abs(abs(minutes % 60) - 60) : minutes % 60;
    
    clock.hours = displayHour;
    clock.minutes = displayMinutes;
    return clock;
}
- (NSString*)format:(int)hour minutes:(int)minutes {
    NSString* hourFormat = hour >= 10 ? @"%d" : @"0%d";
    NSString* minutesFormat = minutes >= 10 ? @"%d" : @"0%d";
    
    NSString* basicFormat = [NSString stringWithFormat:@"%@:%@", hourFormat, minutesFormat];
    
    return [NSString stringWithFormat:basicFormat, hour, minutes];
}
- (id)addMinutes:(int)minutes {
   return [[self class] clockWithHours:self.hours
                               minutes:self.minutes + minutes];
}
- (id)subtractMinutes:(int)minutes {
   return [self addMinutes:-minutes];
}
- (NSString *)description {
    return [self format:self.hours minutes:self.minutes];
}
@end