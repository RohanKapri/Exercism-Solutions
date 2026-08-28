#import <Foundation/Foundation.h>
#import "PascalsTriangle.h"
@implementation PascalsTriangle
- (id)initWithNumberOfRows:(int)rows {
    if (self = [super init]) {
        NSMutableArray *triangle = [[NSMutableArray alloc] initWithObjects:@[@1], nil];
        for (int i = 1; i < rows; i++) {
            NSArray *lastRow = [triangle lastObject];
            NSMutableArray *currentRow = [[NSMutableArray alloc] initWithObjects:@1, nil];
            
            for (int j = 0; j < [lastRow count]; j++) {
                if (j == [lastRow count] - 1) {
                    [currentRow addObject:@1];
                } else {
                    NSNumber *lastVal = [lastRow objectAtIndex:j];
                    NSNumber *previousVal = [lastRow objectAtIndex:j+1];
                    int value = [lastVal intValue] + [previousVal intValue];
                    [currentRow addObject:[NSNumber numberWithInt:value]];
                    previousVal = lastVal;
                }
            }
            [triangle addObject:currentRow];
        }
        [self setRows:triangle];
    }
    return self;
}
@end
