#import <Foundation/Foundation.h>
#import "Strain.h"
@implementation NSArray (Strain)
- (NSArray *)discard:(BOOL (^)(id  _Nonnull arrayElement))iteratorBlock {
    return [self keep:NO where:iteratorBlock];
}
- (NSArray *)keep:(BOOL)shouldKeep where:(BOOL (^)(id  _Nonnull arrayElement))iteratorBlock {
    NSMutableArray *outputArray = [[NSMutableArray alloc] init];
    for (id element in self) {
        if (iteratorBlock(element) == shouldKeep) {
            [outputArray addObject:element];
        }
    }
    return outputArray;
}
@end