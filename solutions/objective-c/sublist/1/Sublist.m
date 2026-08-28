#import <Foundation/Foundation.h>
#import "Sublist.h"
@implementation SublistExample
+ (SublistKind)classifierForFirstList:(NSArray *)firstList andSecondList:(NSArray *)secondList {
    if ([firstList count] == [secondList count]) {
        int count = (int)[firstList count];
        for (int i = 0; i < count; i++) {
            if ([[firstList objectAtIndex:i] isNotEqualTo:[secondList objectAtIndex:i]]) {
                return SublistKindUnequal;
            }
        }
        return SublistKindEqual;
    }
    BOOL isFirstArrayBigger = [firstList count] > [secondList count];
    NSArray *biggerArray = isFirstArrayBigger ? firstList : secondList;
    NSArray *smallerArray = isFirstArrayBigger ? secondList : firstList;
    int iterations = (int)[biggerArray count] - (int)[smallerArray count] + 1;
        
    if ((int)[smallerArray count] == 0) {
        return isFirstArrayBigger ? SublistKindSuperlist : SublistKindSublist;
    }
    
    for (int i = 0; i < iterations; i++) {
        if ([[biggerArray objectAtIndex:i] isEqualTo:[smallerArray objectAtIndex:0]]) {
            for (int j = 1; j <= (int)[smallerArray count]; j++) {
                if (j == (int)[smallerArray count]) {
                    return isFirstArrayBigger ? SublistKindSuperlist : SublistKindSublist;
                }
                if ([[biggerArray objectAtIndex:i + j] isNotEqualTo:[smallerArray objectAtIndex:j]]) {
                    break;
                }
            }
        }
    }
    return SublistKindUnequal;
}
@end
