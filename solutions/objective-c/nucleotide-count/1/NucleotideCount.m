#import <Foundation/Foundation.h>
#import "NucleotideCount.h"
@implementation NucleotideCount
- (id)initWithStrand:(NSString*)strand {
    if (self = [super init]) {
        NSCharacterSet *ATCG = [NSCharacterSet characterSetWithCharactersInString:@"ATCG"];
        NSCharacterSet *invalidChars = [ATCG invertedSet];
        NSRange searchRange = NSMakeRange(0, strand.length);
        NSRange foundRange = [strand rangeOfCharacterFromSet:invalidChars
                                                     options:0
                                                       range:searchRange];
        
        if (foundRange.location != NSNotFound) {
            NSException* myException = [NSException
                    exceptionWithName:@"WrongStrandException"
                    reason:@"Wrong input!"
                    userInfo:nil];
            @throw myException;
        }
        
        Nucleotides* initial = [[Nucleotides alloc] initWithObjectsAndKeys:@0, @"A", @0, @"T", @0, @"C", @0, @"G", nil];
        
        NSUInteger length = [strand length];
        unichar buffer[length+1];
        [strand getCharacters:buffer range:NSMakeRange(0, length)];
        for(int i = 0; i < length; i++) {
            NSString* letter = [NSString stringWithCharacters: &buffer[i] length: 1];
            NSNumber* current = [initial objectForKey:letter];
            if (current != nil) {
                [initial setObject:[NSNumber numberWithInt:[current intValue]+1] forKey:letter];
            }
        }
        [self setNucleotides:initial];
    }
    return self;
}
- (Nucleotides*)nucleotideCounts {
    return self.nucleotides;
}
- (NSNumber*)count:(NSString*)letter {
    return [self.nucleotides objectForKey:letter];
}
@end
