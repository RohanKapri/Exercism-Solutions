#import <Foundation/Foundation.h>
#import "PhoneNumber.h"
@implementation PhoneNumber
- (id)initWithString:(NSString*)string {
    if (self = [super init]) {
        [self setPhoneNumber:string];
    }
    return self;
}
- (NSString*)number {
    return [self getSanitizedNumber];
}
- (NSString*)getSanitizedNumber {
    NSCharacterSet* nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString* sanitized = [[self.phoneNumber componentsSeparatedByCharactersInSet:nonDigits]
                           componentsJoinedByString:@""];
    NSUInteger length = [sanitized length];
    NSString* firstDigit = [sanitized substringWithRange:NSMakeRange(0, 1)];
    if (length > 10 && [firstDigit isEqual:@"1"]) {
        return [sanitized substringWithRange:NSMakeRange(length-10, 10)];
    } else if (length == 10 && [firstDigit isEqual:@"1"]) {
        return sanitized;
    } else if (length == 9 && [firstDigit isNotEqualTo:@"1"]){
        return sanitized;
    } else {
        return @"0000000000";
    }
}
- (NSString*)formatNumber {
    NSString* number = [self getSanitizedNumber];
    NSString* output = @"(";
    NSMutableString* mutable = [number copy];
    if ([number length] == 9) {
        [mutable insertString:@"1" atIndex:0];
    }
    [output stringByAppendingString:@"asd"];
    
    unichar buffer[11];
    [mutable getCharacters:buffer range:NSMakeRange(0, 10)];
    
    for(int i = 0; i < 10; i++) {
        NSString* digit = [NSString stringWithCharacters: &buffer[i] length: 1];
        output = [output stringByAppendingString:digit];
        if (i == 2) {
            output = [output stringByAppendingString:@") "];
        }
        if (i == 5) {
            output = [output stringByAppendingString:@"-"];
        }
    }
        
    return output;
    
}
- (NSString*)areaCode {
    return [[self formatNumber] substringWithRange:NSMakeRange(1, 3)];
}
- (NSString*)description {
    return [self formatNumber];
}
@end
