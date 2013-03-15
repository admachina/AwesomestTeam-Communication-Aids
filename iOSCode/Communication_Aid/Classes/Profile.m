//
//  Profile.m
//  Communication_Aid
//
//  Created by Victor Tong on 2013-02-24.
//
//

#import "Profile.h"

@implementation Profile

- (id)initWithId:(int)profile_id name:(NSString *)name treepaths:(NSMutableArray *)treepaths difficulty:(Difficulty)difficulty;{
    if ((self = [super init])) {
        self.profile_id = profile_id;
        self.name = name;
        self.treepaths = treepaths;
        self.difficulty = difficulty;
    }
    return self;
}

- (void) dealloc {
    self.name = nil;
    self.treepaths = nil;
    // TODO: Free treepaths memory?
    [super dealloc];
}


- (void)addToTreePaths:(NSString *)path {
    [self.treepaths addObject:path];
}

+ (Difficulty)getDifficultyForString:(NSString*)str {
    if ([str isEqualToString:@"easy"]) {
        return EASY;
    } else if ([str isEqualToString:@"medium"]) {
        return MEDIUM;
    } else if ([str isEqualToString:@"hard"]) {
        return HARD;
    }
    return INVALID;
}


@end
