#import <Foundation/Foundation.h>
#import "Isogram.h"
@implementation Isogram
+ (BOOL)isIsogram:(NSString*)string {
    NSString *lowercaseString = [string lowercaseString];
    NSUInteger length = [lowercaseString length];
    unichar buffer[length+1];
    [lowercaseString getCharacters:buffer range:NSMakeRange(0, length)];
    NSMutableArray* allLetters = [[NSMutableArray alloc] init];
    NSMutableSet* setOfLetters = [[NSMutableSet alloc] init];
    for(int i = 0; i < length; i++) {
        NSString* letter = [NSString stringWithCharacters: &buffer[i] length: 1];
        BOOL isLetter = [[NSCharacterSet letterCharacterSet] characterIsMember: buffer[i]];
        if (isLetter) {
            [allLetters addObject:letter];
            [setOfLetters addObject:letter];
        }
    }
    
    return [allLetters count] == [setOfLetters count];
}
@end
