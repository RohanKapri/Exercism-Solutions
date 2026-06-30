#import <Foundation/Foundation.h>
#import "BinarySearch.h"
@implementation BinarySearch
- (id)initWithArray:(NSArray *)array {
    if (self = [super init]) {
        NSArray *sorted = [[NSArray alloc] initWithArray:[array sortedArrayUsingSelector: @selector(compare:)]];
        
        if (![sorted isEqualToArray:array]) {
            return nil;
        } else {
            [self setList:array];
        }
    }
    return self;
}
- (NSUInteger)searchFor:(int)number {
    int startIndex = 0;
    int endIndex = (int)[[self list] count] - 1;
    
    while (startIndex <= endIndex) {
        int middleIndex = startIndex + floor((endIndex - startIndex + 1) / 2);
        int value = [[[self list] objectAtIndex:middleIndex] intValue];
        if (value == number) {
            return middleIndex;
        }
        
        if (value > number) {
            endIndex = middleIndex - 1;
        } else {
            startIndex = middleIndex + 1;
        }
    }
    return NSNotFound;
}
- (NSUInteger)middle {
    if ([[self list] count] % 2 != 0) {
        return [[self list] count] / 2;
    } else {
        return -1;
    }
}
@end
