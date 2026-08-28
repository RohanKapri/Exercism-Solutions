#import <Foundation/Foundation.h>
#import "SpaceAge.h"
@implementation SpaceAge
- (id)initWithSeconds:(double)seconds {
    if (self = [super init]) {
        self.seconds = seconds;
        self.yearOnEarth = 31557600;
    }
    return self;
}
-(double)onMercury {
    return (self.seconds / self.yearOnEarth / 0.2408467);
}
-(double)onVenus {
    return (self.seconds / self.yearOnEarth / 0.61519726);
}
-(double)onEarth {
    return (self.seconds / self.yearOnEarth);
}
-(double)onMars {
    return (self.seconds / self.yearOnEarth / 1.8808158);
}
-(double)onJupiter {
    return (self.seconds / self.yearOnEarth / 11.862615);
}
-(double)onSaturn {
    return (self.seconds / self.yearOnEarth / 29.447498);
}
-(double)onUranus {
    return (self.seconds / self.yearOnEarth / 84.016846);
}
-(double)onNeptune {
    return (self.seconds / self.yearOnEarth / 164.79132);
}
@end
