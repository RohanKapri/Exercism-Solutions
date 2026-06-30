#import <Foundation/Foundation.h>
#import "Acronym.h"
@implementation Acronym
+ (NSString *)abbreviate:(NSString *)string {
    NSString *acronym = @"";
    NSCharacterSet* notLetters = [[NSCharacterSet letterCharacterSet] invertedSet];
    NSArray *split = [string componentsSeparatedByCharactersInSet:notLetters];
    
    for (NSString *word in split) {
        if ([word length]) {
            NSUInteger length = [word length];
            unichar buffer[length+1];
            [word getCharacters:buffer range:NSMakeRange(0, length)];
            unichar firstLetter = [word characterAtIndex:0];
            NSString* firstCharacter = [NSString stringWithCharacters:&firstLetter length:1];
            acronym = [acronym stringByAppendingString:[firstCharacter uppercaseString]];
            
            NSString *previous = firstCharacter;
            for(int i = 1; i < length; i++) {
                NSString* character = [NSString stringWithCharacters: &buffer[i] length: 1];
                if ([character isEqualTo:[character uppercaseString]] && [previous isEqualTo:[previous lowercaseString]]) {
                    acronym = [acronym stringByAppendingString:[character uppercaseString]];
                }
                previous = character;
            }
  
        }
    }
    return acronym;
}
@end
