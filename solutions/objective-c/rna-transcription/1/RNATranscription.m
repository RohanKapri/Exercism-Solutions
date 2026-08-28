#import <Foundation/Foundation.h>
#import "RNATranscription.h"
@implementation RNATranscription
- (NSString*)rnaFromDNAStrand:(NSString*)strand {
        NSString* rna = @"";
        NSDictionary* rnaForStrand = [[NSDictionary alloc] initWithObjectsAndKeys:@"C",@"G",@"G",@"C", @"A",@"T",@"U",@"A", nil];
        NSUInteger length = [strand length];
        unichar buffer[length+1];
        [strand getCharacters:buffer range:NSMakeRange(0, length)];
        for(int i = 0; i < length; i++) {
            NSString* letter = [rnaForStrand objectForKey:[NSString stringWithCharacters: &buffer[i] length: 1]];
            if (letter == nil) {
                return nil;
            }
            rna = [rna stringByAppendingString:letter];
        }
        return rna;
}
@end
