//
//  Profile.m
//  Communication_Aid
//
//  Created by Victor Tong on 2013-02-24.
//
//

#import "Profile.h"

@implementation Profile


@synthesize profile_id;
@synthesize name;
@synthesize difficulty;
@synthesize dimensions;
@synthesize treepath;

- (id)initWithId:(int)profile_id name:(NSString *)name treepath:(NSMutableArray *)treepath difficulty:(Difficulty)difficulty dimensions:(int)dimensions {
    if ((self = [super init])) {
        self.profile_id = profile_id;
        self.name = name;
        self.treepath = treepath;
        self.difficulty = difficulty;
        self.dimensions = dimensions;
    }
    return self;
}

- (void) dealloc {
    self.name = nil;
    self.treepath = nil;
    // TODO: Free treepaths memory?
    [super dealloc];
}


- (void)addToTreePaths:(NSString *)path {
    [self.treepath addObject:path];
}

+ (Difficulty)getDifficultyForString:(NSString*)str {
    if ([str caseInsensitiveCompare:@"easy"] == NSOrderedSame) {
        return EASY;
    } else if ([str caseInsensitiveCompare:@"medium"] == NSOrderedSame) {
        return MEDIUM;
    } else if ([str caseInsensitiveCompare:@"hard"] == NSOrderedSame) {
        return HARD;
    }
    return INVALID;
}


@end
