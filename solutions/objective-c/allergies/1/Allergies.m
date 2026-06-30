#import <Foundation/Foundation.h>
#import "Allergies.h"
@implementation Allergies
- (id)initWithScore:(int)score {
    if (self = [super init]) {
        [self setScore:score];
    }
    return self;
}
- (BOOL)hasAllergy:(Allergen)allergen {
    NSArray *values = @[@128, @64, @32, @16, @8, @4, @2, @1];
    NSMutableDictionary *alleries = [[NSMutableDictionary alloc] initWithDictionary:@{@128: @(AllergenCats), @64: @(AllergenPollen), @32: @(AllergenChocolate), @16: @(AllergenTomatoes), @8: @(AllergenStrawberries), @4:@(AllergenShellfish), @2: @(AllergenPeanuts), @1: @(AllergenEggs)}];
    int currentValue = [self score];
    if (currentValue > 255) {
        return NO;
    }
    for (NSNumber *key in values) {
        Allergen value = [[alleries objectForKey:key] intValue];
        if ([key intValue] <= currentValue) {
            if (value == allergen ) {
                return YES;
            }
            currentValue -= [key intValue];
        }
    }
    return NO;
}
@end
