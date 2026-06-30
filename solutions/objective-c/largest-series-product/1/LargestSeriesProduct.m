#import <Foundation/Foundation.h>
#import "LargestSeriesProduct.h"
@implementation LargestSeriesProduct
- (id)initWithNumberString:(NSString *)string {
    if (self = [super init]) {
        [self setNumberString:string];
    }
    return self;
}
- (long)largestProduct:(int)product {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    long largest = 0;
    
    for (int i = 0; i <= [[self numberString] length] - product; i++) {
        NSRange range = NSMakeRange(i, product);
        NSString *substring = [[self numberString] substringWithRange:range];
        long sum = [[f numberFromString:[NSString stringWithFormat: @"%C", [substring characterAtIndex:0]]] intValue];
        for (int j = 1; j < [substring length]; j++) {
            if ([[NSCharacterSet letterCharacterSet] characterIsMember:[substring characterAtIndex:j]]) {
                NSException* myException = [NSException
                        exceptionWithName:@"NotADigitException"
                        reason:@"The character is not a digit"
                        userInfo:nil];
                @throw myException;
            }
            sum *= [[f numberFromString:[NSString stringWithFormat: @"%C", [substring characterAtIndex:j]]] intValue];
        }
        largest = sum > largest ? sum : largest;
    }
    return largest;
}
@end
