#import <Foundation/Foundation.h>
#import "Raindrops.h"
@implementation Raindrops
- (id)initWithNumber:(int)number {
    if (self = [super init]) {
        [self setNumber:[NSNumber numberWithInt:number]];
    }
    return self;
}
- (NSString*)sounds {
    NSArray* factors = [[NSArray alloc] initWithObjects:@3,@5,@7, nil];
    NSDictionary* soundsForFactor = [[NSDictionary alloc] initWithObjectsAndKeys:@"Pling",@3,@"Plang",@5, @"Plong",@7, nil];
    
    NSString *soundString = @"";
    for (NSNumber* factor in factors) {
        if ([self.number intValue] % [factor intValue] == 0) {
            soundString = [soundString stringByAppendingString:[soundsForFactor objectForKey:factor]];
        }
    }
    
    return [soundString length] > 0 ? soundString : [self.number stringValue];
}
@end
