//
//  Profile.h
//  Communication_Aid
//
//  Created by Victor Tong on 2013-02-24.
//
//

#import <Foundation/Foundation.h>


typedef enum {
    INVALID = 0, 
    EASY = 1,
    MEDIUM = 2,
    HARD = 3
} Difficulty;

@interface Profile : NSObject {
    int profile_id;
    NSString* name;
    NSMutableArray* treepath;
    Difficulty difficulty;
}

@property(nonatomic) int profile_id;
@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) NSMutableArray* treepaths;

@property(nonatomic) Difficulty difficulty;

- (id)initWithId:(int)profile_id name:(NSString *)name treepaths:(NSMutableArray *)treepaths difficulty:(Difficulty)difficulty;

+ (Difficulty)getDifficultyForString:(NSString*)str;


- (void)addToTreePaths:(NSString *)path;

@end
