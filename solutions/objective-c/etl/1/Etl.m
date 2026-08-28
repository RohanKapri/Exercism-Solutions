#import <Foundation/Foundation.h>
#import "Etl.h"
@implementation Etl
+ (NSNumber *)transform:( NSDictionary<NSNumber*, NSArray<NSString *>*> *)dict {
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
    for(NSNumber *key in dict) {
        NSArray<NSString *> *array = [dict objectForKey:key];
        for (NSString *string in array) {
            [newDict setObject:key forKey:[string lowercaseString]];
        }
    }
    return newDict;
}
@end
