#import <Foundation/Foundation.h>
#import "Anagram.h"
@implementation Anagram
- (id)initWithString:(NSString *)string {
    if (self = [super init]) {
        [self setString:string];
    }
    return self;
}
- (NSArray<NSString *> *)match:(NSArray<NSString *> *)inputArray {
    NSMutableArray *matches = [[NSMutableArray alloc] init];
    for (NSString *word in inputArray) {
        NSMutableArray *target = [[NSMutableArray alloc] initWithArray:[self getLetterArray:[self string]]];
        NSArray<NSString *> * currentWord = [self getLetterArray:word];
        if ([target count] != [currentWord count] || [word isEqualTo:[self string]]) {
            continue;
        }
        NSLog(@"%@", target);
        for (NSString *letter in currentWord) {
            if ([target containsObject:letter]) {
                [target removeObjectAtIndex:[target indexOfObject:letter]];
            } else {
                break;
            }
        }
        if ([target count] == 0) {
            [matches addObject:word];
        }
    }
    return matches;
}
- (NSArray<NSString *> *)getLetterArray:(NSString *)word {
    NSUInteger length = [word length];
    unichar buffer[length+1];
    [word getCharacters:buffer range:NSMakeRange(0, length)];
    NSMutableArray *allLetters = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < length; i++) {
        NSString* letter = [NSString stringWithCharacters: &buffer[i] length: 1];
        [allLetters addObject:[letter lowercaseString]];
    }
    return allLetters;
}
@end