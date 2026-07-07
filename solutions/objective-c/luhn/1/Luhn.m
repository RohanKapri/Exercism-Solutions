#import <Foundation/Foundation.h>
#import "Luhn.h"
@implementation Luhn
- (id)initWithString:(NSString *)string {
    if (self = [super init]) {
        NSCharacterSet *numbers = [NSCharacterSet
                                characterSetWithCharactersInString:@"0123456789"];
        NSMutableArray *stringArray = [[NSMutableArray alloc] init];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        
        for (int i = 0; i < [string length]; i++) {
            if ([numbers characterIsMember:[string characterAtIndex:i]]) {
                [stringArray insertObject:[NSString stringWithFormat: @"%C", [string characterAtIndex:i]] atIndex:0];
            } else if (![[NSCharacterSet whitespaceCharacterSet] characterIsMember:[string characterAtIndex:i]]) {
                [self setIsValid:NO];
                return self;
            }
        }
                
        if ([stringArray count] < 2) {
            [self setIsValid:NO];
            return self;
        }
        
        int sum = 0;
        
        for (int i = 0; i < [stringArray count]; i++) {
            if (i % 2 == 0) {
                sum += [[formatter numberFromString:[stringArray objectAtIndex:i]] intValue];
            } else {
                int num = [[formatter numberFromString:[stringArray objectAtIndex:i]] intValue] * 2;
                if (num > 9) {
                    NSString *stringNumber = [[NSNumber numberWithInt:num] stringValue];
                    int first = [[formatter numberFromString:[NSString stringWithFormat: @"%C", [stringNumber characterAtIndex:0]]] intValue];
                    int second = [[formatter numberFromString:[NSString stringWithFormat: @"%C", [stringNumber characterAtIndex:1]]] intValue];
                    sum = sum + first + second;
                } else {
                    sum += num;
                }
            }
        }
        [self setIsValid:sum % 10 == 0];
    }
    return self;
}
@end
