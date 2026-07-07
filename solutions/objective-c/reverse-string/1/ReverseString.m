#import <Foundation/Foundation.h>
#import "ReverseString.h"
@implementation NSString (Reverse)
- (NSString *)reverseString {
    NSMutableString *reversedString = [NSMutableString string];
    NSInteger charIndex = [self length];
    while (charIndex > 0) {
        charIndex--;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reversedString appendString:[self substringWithRange:subStrRange]];
    }
    return reversedString;
}
@end
