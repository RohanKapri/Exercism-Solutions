#import <Foundation/Foundation.h>
#import "Bob.h"
@implementation Bob
-(BOOL) hasLetter:(NSString *)string {
    return [string rangeOfCharacterFromSet: [NSCharacterSet letterCharacterSet]].location != NSNotFound;
}
- (NSString *)hey:(NSString *)input {
    BOOL isEmptyString = [[input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0;
    NSCharacterSet *alphabetSet = [NSCharacterSet letterCharacterSet];
    BOOL isAllUppercase = [input.uppercaseString isEqualToString:input] && [self hasLetter:input];
    if(isEmptyString) {
        return @"Fine. Be that way!";
    } else if(isAllUppercase) {
        return @"Whoa, chill out!";
    } else if( [input hasSuffix:@"?"]) {
        return @"Sure.";
    } else {
        return @"Whatever.";
    }
}
@end
