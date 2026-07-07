#import <Foundation/Foundation.h>
#import "AtbashCipher.h"
@implementation AtbashCipher
+ (NSString*)encode:(NSString*)string {
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString* cipher = @"";
    NSDictionary* atbash = @{
        @"a": @"z",
        @"b": @"y",
        @"c": @"x",
        @"d": @"w",
        @"e": @"v",
        @"f": @"u",
        @"g": @"t",
        @"h": @"s",
        @"i": @"r",
        @"j": @"q",
        @"k": @"p",
        @"l": @"o",
        @"m": @"n",
        @"n": @"m",
        @"o": @"l",
        @"p": @"k",
        @"q": @"j",
        @"r": @"i",
        @"s": @"h",
        @"t": @"g",
        @"u": @"f",
        @"v": @"e",
        @"w": @"d",
        @"x": @"c",
        @"y": @"b",
        @"z": @"a"
    };
    NSUInteger length = [string length];
    unichar buffer[length+1];
    [string getCharacters:buffer range:NSMakeRange(0, length)];
    for(int i = 1; i <= length; i++) {
        NSString* character = [[NSString stringWithCharacters: &buffer[i-1] length: 1] lowercaseString];
        NSString* cipherChar = [atbash objectForKey:character];
        NSString* trimmedCipher = [cipher stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        BOOL isDigit = [character rangeOfCharacterFromSet:notDigits].location == NSNotFound;
        BOOL shouldAppendWhitespace = [trimmedCipher length] > 0 && [trimmedCipher length] % 5 == 0;
        
        if (cipherChar != nil || isDigit ) {
            if (shouldAppendWhitespace) {
                cipher = [cipher stringByAppendingString:@" "];
            }
            NSString* characterToAppend = isDigit ? character : cipherChar;
            cipher = [cipher stringByAppendingString:characterToAppend];
        }
    }
    return cipher;
}
@end
