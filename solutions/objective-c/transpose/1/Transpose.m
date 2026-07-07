#import <Foundation/Foundation.h>
#import "Transpose.h"
@implementation Transpose
+ (NSArray *)transpose:(NSArray *)array {
    NSUInteger columns = [[self class] findLongest:array];
    NSUInteger rows = [array count];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < columns; i++) {
        NSMutableArray *newRow = [[NSMutableArray alloc] init];
        for (int j = 0; j < rows; j++) {
            if ([[array objectAtIndex:j] length] > i) {
                unichar ch = [[array objectAtIndex:j] characterAtIndex:i];
                [newRow addObject:[NSString stringWithFormat:@"%c", ch]];
            } else {
                [newRow addObject:@" "];
            }
        }
        [result addObject:[newRow componentsJoinedByString:@""]];
    }
    return result;
}
+ (NSUInteger)findLongest:(NSArray *)array {
    NSUInteger longest = 0;
    for (NSString *str in array) {
        if ([str length] > longest) {
            longest = [str length];
        }
    }
    return longest;
}
@end
