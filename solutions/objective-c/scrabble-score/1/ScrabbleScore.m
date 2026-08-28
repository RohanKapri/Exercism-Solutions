#import <Foundation/Foundation.h>
#import "ScrabbleScore.h"
@implementation ScrabbleScore
- (id)initWithWord:(NSString*)word {
    if (self = [super init]) {
        [self setWord:word];
    }
    return self;
}
- (int)score {
    return [self countPointsForWord:self.word];
}
+ (int)score:(NSString*)word {
    ScrabbleScore *scrabble = [[ScrabbleScore alloc] initWithWord:word];
    return [scrabble score];
}
- (int)countPointsForWord:(NSString*)word {
    int count = 0;
    NSDictionary *valuesForLetters = @{
        @"A": @1, @"E": @1, @"I": @1, @"O": @1,
        @"U": @1, @"L": @1, @"N": @1, @"R": @1,
        @"S": @1, @"T": @1, @"D": @2, @"G": @2,
        @"B": @3, @"C": @3, @"M": @3, @"P": @3,
        @"F": @4, @"H": @4, @"V": @4, @"W": @4,
        @"Y": @4, @"K": @5, @"J": @8, @"X": @8,
        @"Q": @10, @"Z": @10
    };
    NSString *uppercaseString = [word uppercaseString];
    NSUInteger length = [uppercaseString length];
    unichar buffer[length+1];
    [uppercaseString getCharacters:buffer range:NSMakeRange(0, length)];
    for(int i = 0; i < length; i++) {
        NSString* letter = [NSString stringWithCharacters: &buffer[i] length: 1];
        NSNumber* value = [valuesForLetters objectForKey:letter];
        if (value != nil) {
            count = count + [value intValue];
        }
    }
    
    return count;
}
@end