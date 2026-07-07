#import <Foundation/Foundation.h>
#import "RobotName.h"
@implementation Robot
- (id)init {
    if (self = [super init]) {
        [self setName:[self getNewName]];
    }
    return self;
}
- (void)reset {
    [self setName:[self getNewName]];
}
- (NSString*)getNewName {
    NSString* name = @"";
    NSArray *latinCapitalLetters = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    int lowerBound = 0;
    for (int i = 0; i < 5; i++) {
        if (i < 2) {
            int upperBound = (int)[latinCapitalLetters count];
            int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
        
            name = [name stringByAppendingString:[latinCapitalLetters objectAtIndex:rndValue]];
        } else {
            int upperBound = 9;
            int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
            
            name = [name stringByAppendingString:[NSString stringWithFormat:@"%i", rndValue]];
        }
    }
    return name;
}
@end
