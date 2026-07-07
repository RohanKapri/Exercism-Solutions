#import <Foundation/Foundation.h>
#import "GradeSchool.h"
typedef NSMutableDictionary<NSNumber *, NSMutableArray<NSString *>*> Grades;
@implementation GradeSchool
- (id)init {
    if (self = [super init]) {
        [self setDb:[[Grades alloc]init ]];
    }
    return self;
}
- (void)addStudentWithName:(NSString *)name andGrade:(NSNumber *)grade {
    Grades *dbCopy = [[NSMutableDictionary alloc]initWithDictionary:self.db];
    NSMutableArray *values = [[NSMutableArray alloc]initWithArray:[self.db objectForKey:grade]];
    
    [values addObject:name];
    [dbCopy setObject:values forKey:grade];
    [self setDb:dbCopy];
}
- (NSArray<NSString*>*)studentsInGrade:(NSNumber*)grade {
    return [self.db objectForKey:grade] != nil ? [self.db objectForKey:grade] : @[];
}
- (Grades*)sort {
    NSArray* keys = [[self.db allKeys] sortedArrayUsingSelector: @selector(compare:)];
    Grades* sortedGrades = [[Grades alloc] init];
    
    for (NSNumber* grade in keys) {
        NSArray<NSString *> * sortedArray = [[self.db objectForKey:grade] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        [sortedGrades setObject:[sortedArray copy] forKey:grade];
    }
    
    return sortedGrades;
}
@end