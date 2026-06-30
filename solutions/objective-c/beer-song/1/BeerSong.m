#import <Foundation/Foundation.h>
#import "BeerSong.h"
@implementation BeerSongExample
- (id)initWithNumberOfBeerBottles:(int)numberOfBottles {
    if (self = [super init]) {
        [self setNumberOfBottles:numberOfBottles];
    }
    return self;
}
- (NSString *)singBeerSong {
    NSString *song = @"";
    for (int i = [self numberOfBottles]; i >= 0; i--) {
        if (i == 0) {
            song = [song stringByAppendingString:@"No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall."];
        } else if (i == 1) {
            song = [song stringByAppendingString:@"1 bottle of beer on the wall, 1 bottle of beer.\nTake one down and pass it around, no more bottles of beer on the wall.\n\n"];
        } else if (i == 2) {
            song = [song stringByAppendingString:@"2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n\n"];
        } else {
            song = [song stringByAppendingFormat:@"%d bottles of beer on the wall, %d bottles of beer.\nTake one down and pass it around, %d bottles of beer on the wall.\n\n", i, i, i-1];
        }
    }
    return song;
}
@end