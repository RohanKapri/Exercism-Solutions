#import <Foundation/Foundation.h>
#import "WordCount.h"
@implementation WordCount
- (id)initWithString:(NSString *)string {
    if (self = [super init]) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        NSCharacterSet *splitCharacterSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSArray *words = [string componentsSeparatedByCharactersInSet:splitCharacterSet];
        for (NSString *word in words) {
            NSString *lowercase = [word lowercaseString];
            if ([dict objectForKey:lowercase]) {
                int val = [[dict objectForKey:lowercase] intValue] + 1;
                [dict setObject:[NSNumber numberWithInt:val] forKey:lowercase];
            } else if ([lowercase isNotEqualTo:@""]) {
                [dict setObject:@1 forKey:lowercase];
            }
        }
        [self setCount:dict];
    }
    return self;
}
@end
