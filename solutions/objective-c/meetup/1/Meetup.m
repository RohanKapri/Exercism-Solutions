#import <Foundation/Foundation.h>
#import "Meetup.h"
@implementation Meetup
- (id)initWithYear:(int)year andMonth:(int)month {
    if (self = [super init]) {
        NSString *dateString = [NSString stringWithFormat:@"%d-%d-01", year, month];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        [self setDate:[format dateFromString:dateString]];
    }
    return self;
}
- (NSDate *)dayForDayOfWeek:(DayOfWeek)day andOptions:(MeetupOption)option {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[self date]];
    [comps setMonth:[comps month]+1];
    [comps setDay:0];
    NSDate *tDateMonth = [gregorian dateFromComponents:comps];
    
    long lastDayOfMonth = [[gregorian components:NSCalendarUnitDay fromDate:tDateMonth] day];
    int firstWeekdayOfMonth = (int)comps.weekday;
    int firstCorrectWeekday = [self getFirstWeekday:day firstDayOfMonth:firstWeekdayOfMonth];
    
    NSDateComponents *compsForMeetupDate = [gregorian components:NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[self date]];
    int meetupDay = [self getMeetupDay:firstCorrectWeekday monthLength:(int)lastDayOfMonth option:option];
    [compsForMeetupDate setDay:meetupDay];
    NSDate *meetupDate = [gregorian dateFromComponents:compsForMeetupDate];
    return meetupDate;
}
- (int)getFirstWeekday:(DayOfWeek)target firstDayOfMonth:(int)firstDay {
    int offset = target - firstDay + 2;
    if (offset < 1) {
        offset = offset + 7;
    }
    return offset;
}
- (int)getMeetupDay:(int)firstWeekday monthLength:(int)lastDay option:(MeetupOption)option {
    int week = 7;
    switch (option) {
        case MeetupOptionsTeenth:
            return firstWeekday + week > 10 ? firstWeekday + week : firstWeekday + 2 * week;
        case MeetupOptionsFirst:
            return firstWeekday;
        case MeetupOptionsSecond:
            return firstWeekday + week;
        case MeetupOptionsThird:
            return firstWeekday + 2 * week;
        case MeetupOptionsFourth:
            return firstWeekday + 3 * week;
        default:
            return [self getLastMeetupDay:firstWeekday monthLength:lastDay];
    }
}
- (int)getLastMeetupDay:(int)firstWeekday monthLength:(int)lastDay {
    int day = firstWeekday;
    for (int i = firstWeekday + 7; i <= lastDay; i += 7) {
        day = i;
    }
    return day;
}
@end
