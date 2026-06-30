#import <Foundation/Foundation.h>
#import "Pangram.h"
@implementation Pangram
+ (int)isPangram:(NSString *)string {
    NSMutableSet *letters = [[NSMutableSet alloc] init];
    NSCharacterSet *validLetters = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    for (int i = 0; i < [string length]; i++) {
        unichar c = [string characterAtIndex:i];
        if ([validLetters characterIsMember:c]) {
            NSString *s = [[NSString stringWithFormat:@"%c", c] lowercaseString];
            [letters addObject:s];
        }
    }
    return [letters count] == 26;
}
@end