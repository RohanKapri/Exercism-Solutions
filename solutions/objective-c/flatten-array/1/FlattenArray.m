
#import <Foundation/Foundation.h>
#import "FlattenArray.h"
@implementation FlattenArrayExample
+ (NSArray *)flattenArray:(NSArray *)array; {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (id item in array) {
        if ([item isKindOfClass:[NSArray class]]) {
            [arr addObjectsFromArray:[self flattenArray:item]];
        } else if ([item isKindOfClass:[NSNull class]] == NO) {
            [arr addObject:item];
        }
    }
    return [NSArray arrayWithArray:arr];
}
@end
