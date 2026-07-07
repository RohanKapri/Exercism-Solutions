#import <Foundation/Foundation.h>
#import "AllYourBase.h"
@implementation AllYourBase
+ (NumberArray *)outputDigitsForInputBase:(int)inputBase inputDigits:(NumberArray *)inputDigits outputBase:(int)outputBase {
    NSException* wrongNumberException = [NSException
            exceptionWithName:@"WrongNumberException"
            reason:@"WrongNumber"
            userInfo:nil];
    if (outputBase < 2 || inputBase < 2) {
        @throw wrongNumberException;
    }
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    int inputCount = (int)[inputDigits count];
    int decimal = 0;
    NSMutableArray *output = [[NSMutableArray alloc] init];
    NSMutableArray *decimalArray = inputBase == 10 ? [[NSMutableArray alloc]initWithArray:inputDigits] : [[NSMutableArray alloc] init];
    
    if (inputBase != 10) {
        for (int i = 0; i < inputCount; i++) {
            int power = inputCount - i - 1;
            int value = [[inputDigits objectAtIndex:i] intValue];
            if (value >= inputBase || value < 0) {
                @throw wrongNumberException;
            }
            double numberToAdd = value * pow(inputBase, power);
            decimal += numberToAdd;
        }
    } else {
        NSString *concat = @"";
        for (NSNumber *digit in decimalArray) {
            concat = [concat stringByAppendingString:[digit stringValue]];
        }
        decimal = [[f numberFromString:concat] intValue];
    }
    
    NSUInteger length = [[[NSNumber numberWithInt:decimal] stringValue] length];
    unichar buffer[length+1];
    [[[NSNumber numberWithInt:decimal] stringValue] getCharacters:buffer range:NSMakeRange(0, length)];
    for(int i = 1; i <= length; i++) {
        NSNumber *character = [f numberFromString:[NSString stringWithCharacters: &buffer[i-1] length: 1]];
        [decimalArray addObject:character];
    }
    
    while (decimal > 0) {
        int remainder = decimal % outputBase;
        NSNumber *numberToAdd = [NSNumber numberWithInt:remainder];
        [output insertObject:numberToAdd atIndex:0];
        decimal = floor(decimal / outputBase);
    }
    
    return output;
}
@end
