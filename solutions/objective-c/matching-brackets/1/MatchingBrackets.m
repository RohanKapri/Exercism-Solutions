#import <Foundation/Foundation.h>
#import "MatchingBrackets.h"
@implementation MatchingBracketsExample
+ (BOOL)validateBracketPairingAndNestingInString:(NSString *)string {
    NSMutableArray *opened = [[NSMutableArray alloc] init];
    NSCharacterSet *openingBrackets = [NSCharacterSet
                            characterSetWithCharactersInString:@"({["];
    NSCharacterSet *closingBrackets = [NSCharacterSet
                            characterSetWithCharactersInString:@")}]"];
    NSDictionary *openingCharacters = @{@")": @"(", @"}": @"{",@"]": @"["};
    
    for (int i = 0; i < [string length]; i++) {
        NSString *character = [NSString stringWithFormat: @"%C", [string characterAtIndex:i]];
        if ([openingBrackets characterIsMember:[string characterAtIndex:i]]) {
            [opened addObject:character];
        } else if ([closingBrackets characterIsMember:[string characterAtIndex:i]] && [[opened lastObject] isEqualTo:[openingCharacters objectForKey:character]]) {
            [opened removeLastObject];
        } else if ([closingBrackets characterIsMember:[string characterAtIndex:i]] && [[opened lastObject] isNotEqualTo:[openingCharacters objectForKey:character]]) {
            return NO;
        }
    }
    
    return [opened count] == 0;
}
@end
