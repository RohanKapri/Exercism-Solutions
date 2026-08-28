
#import <Foundation/Foundation.h>
#import "Hamming.h"
@implementation Hamming
+ (int)compute:(NSString*)compute against:(NSString*)against {
    NSUInteger lenCompute = [compute length];
    NSUInteger lenAgainst = [against length];
    unichar bufferCompute[lenCompute+1];
    unichar bufferAgainst[lenAgainst+1];
    [compute getCharacters:bufferCompute range:NSMakeRange(0, lenCompute)];
    [against getCharacters:bufferAgainst range:NSMakeRange(0, lenAgainst)];
    int diff = abs((int)lenAgainst - (int)lenCompute);
    int iterations = (int)lenAgainst > (int)lenCompute ? (int)lenCompute : (int)lenAgainst;
    
    for(int i = 0; i < iterations; i++) {
        NSLog(@"1: %d", diff);
        if (bufferCompute[i] != bufferAgainst[i]) {
            diff++;
        }
    }
    
    return diff;
}
@end
