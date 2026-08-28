#import <Foundation/Foundation.h>
#import "Series.h"
@implementation Series
- (id)initWithNumberString:(NSString *)numberString {
    if (self = [super init]) {
        [self setNumberString:numberString];
    }
    return self;
}
- (NSArray *)slicesWithSize:(int)sliceSize {
    NSMutableArray *slices = [[NSMutableArray alloc] init];
    int iterations = (int)[[self numberString] length] - sliceSize;
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    if (iterations < 0) {
        return nil;
    }
    
    for (int i = 0; i <= iterations; i++) {
        NSString *substring = [[self numberString] substringWithRange:NSMakeRange(i, sliceSize)];
        NSMutableArray *substringArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [substring length]; i++) {
            NSString *ch = [substring substringWithRange:NSMakeRange(i, 1)];
            [substringArray addObject:[f numberFromString:ch]];
        }
        [slices addObject:substringArray];
    }
    
    return slices;
 }
@end
