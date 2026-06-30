#import <Foundation/Foundation.h>
#import "CryptoSquare.h"
@implementation CryptoSquare
- (id)initWithText:(NSString *)text {
    if (self = [super init]) {
        [self setText:text];
        [self encode];
    }
    return self;
}
- (void)encode {
    NSString *normalized = [self normalizePlaintext];
    int width = ceil(sqrt((double)[normalized length]));
    NSArray *cuts = [self cutText:[self text]];
    NSMutableArray *encodedArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < width; i++) {
        NSString *encoded = @"";
        for (int j = 0; j < [cuts count]; j++) {
            NSLog(@"%f", pow(j + 1, 2) + i);
            if ((pow(j + 1, 2) + i) <= [normalized length]) {
                NSString *cut = [cuts objectAtIndex:j];
                encoded = [encoded stringByAppendingString:[NSString stringWithFormat: @"%C", [cut characterAtIndex:i]]];
            }
        }
        [encodedArray addObject:encoded];
    }
    
    [self setPlaintextSegments:cuts];
    [self setCipherText:[encodedArray componentsJoinedByString:@""]];
    [self setNumberOfColumns:ceil((double)[normalized length] / width)];
    [self setNormalizedCipherText:[encodedArray componentsJoinedByString:@" "]];
}
- (NSString *)normalizePlaintext {
    return [self normalizePlaintext:[self text]];
}
- (NSString *)normalizePlaintext:(NSString *)text {
    return [[[text componentsSeparatedByCharactersInSet:
                                 [[NSCharacterSet alphanumericCharacterSet] invertedSet]] componentsJoinedByString:@""] lowercaseString];
}
- (NSArray *)cutText:(NSString *)text {
    NSString *normalized = [self normalizePlaintext:text];
    int width = ceil(sqrt((double)[normalized length]));
    int height = ceil((double)[normalized length] / width);
    
    NSMutableArray *cuts = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < height; i++) {
        NSUInteger length = (i * width) + width > [normalized length] ? [normalized length] - (i * width) : width;
        
        NSRange range = NSMakeRange(i * width, length);
        [cuts addObject:[normalized substringWithRange:range]];
    }
    
    return cuts;
}
@end
