#import <Foundation/Foundation.h>
#import "Triangle.h"
@implementation Triangle
+ (TriangleKind)kindForSides:(float)a :(float)b :(float)c {
    Triangle *triangle = [[Triangle alloc] init];
    if (![triangle isTriangle:a :b :c]) {
        NSException* notTriangleException = [NSException
                exceptionWithName:@"NotTriangleException"
                reason:@"Not a triangle"
                userInfo:nil];
        @throw notTriangleException;
    }
    
    NSSet *set = [[NSSet alloc] initWithObjects:[NSNumber numberWithFloat:a], [NSNumber numberWithFloat:b], [NSNumber numberWithFloat:c], nil];
    
    if ([set count] == 1) {
        return TriangleKindEquilateral;
    } else if ([set count] == 2) {
        return TriangleKindIsosceles;
    } else {
        return TriangleKindScalene;
    }
    
}
- (BOOL)isTriangle:(float)a :(float)b :(float)c {
    if (a <=0 || b <= 0 || c <= 0) {
        return NO;
    }
    if (a + b >= c && b + c >= a && a + c >= b) {
        return YES;
    } else {
        return NO;
    }
}
@end