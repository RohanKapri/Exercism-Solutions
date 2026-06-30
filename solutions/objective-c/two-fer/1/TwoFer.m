
#import <Foundation/Foundation.h>
#import "TwoFer.h"
@implementation TwoFer
+ (nonnull NSString *)twoFerWithName:(nullable NSString *)name {
    if (name != nil) {
        return [NSString stringWithFormat:@"One for %@, one for me.", name];
    } else {
        return @"One for you, one for me.";
    }
}
@end