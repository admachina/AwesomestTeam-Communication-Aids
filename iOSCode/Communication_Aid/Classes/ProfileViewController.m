//
//  ProfileViewController.m
//  Communication_Aid
//
//  Created by Victor Tong on 2013-02-24.
//
//

#import "ProfileViewController.h"
#import <sqlite3.h>
#import "Profile.h"


@implementation ProfileViewController

@synthesize profiles;
@synthesize textInputViewController;

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.profiles = nil;
    }
    return self;
}*/


- (id)initWithTextInputView:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil textInputViewController:(TextInputViewController *)newTextInputViewController
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        profiles = nil;
        textInputViewController = newTextInputViewController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self repopulateProfiles];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.profiles count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    static NSString* MyIdentifier = @"ID";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
    }
    
    Profile* profile = (Profile*)[profiles objectAtIndex:indexPath.row];
    
    [cell setText:profile.name];
    
    return cell;
}

-(void) tableView:(UITableView*) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Make it initialize the TextInputViewController properly with the profile information.
    
    [self.view addSubview:[textInputViewController view]];
}

- (void) repopulateProfiles
{
    // Setup sqlite db
    sqlite3* sqliteDb;
    NSString* sqlitePath = [[NSBundle mainBundle] pathForResource:@"profiles"ofType:@"sqlite"];
    if (sqlite3_open([sqlitePath UTF8String], &sqliteDb) != SQLITE_OK) {
        NSLog(@"Failed to open database!");
    } else {
        self.profiles = [[NSMutableArray alloc] init];
        
        // Read sqlite file and store data
        NSString *query = @"SELECT profiles.profile_id, profiles.name, profiles.difficulty, profile_tree.tree_path FROM profiles INNER JOIN profile_tree ON profiles.profile_id = profile_tree.profile_id ORDER BY profiles.profile_id ASC";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(sqliteDb, [query UTF8String], -1, &statement, nil)
            == SQLITE_OK) {
            Profile *info = nil;
            while (sqlite3_step(statement) == SQLITE_ROW) {
                int profileId = sqlite3_column_int(statement, 0);
                char *nameChars = (char *) sqlite3_column_text(statement, 1);
                char *difficultyChars = (char *) sqlite3_column_text(statement, 2);
                char *treePathChars = (char *) sqlite3_column_text(statement, 3);
                NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
                NSString *difficultyStr = [[NSString alloc] initWithUTF8String:difficultyChars];
                NSString *treepath = [[NSString alloc] initWithUTF8String:treePathChars];
                NSMutableArray* treepaths = [[NSMutableArray alloc] init];
                
                Difficulty difficulty = [Profile getDifficultyForString:difficultyStr];
                if (difficulty == INVALID) {
                    NSLog(@"%@, %@", @"Failed to process string", difficultyStr);
                    continue;
                }
                
                if (info != nil && [info profile_id] == profileId) {
                    // Do nothing. Reuse the same info
                    assert([info.name isEqualToString:name]);
                    assert(info.difficulty == difficulty);
                } else {
                info = [[Profile alloc]
                        initWithId:profileId name:name treepaths:treepaths difficulty:difficulty];
                }
                [info addToTreePaths:treepath];
                [self.profiles addObject:info];
                [name release];
                [treepath release];
                [treepaths release];
                [info release];
                [difficultyStr release];
            }
            sqlite3_finalize(statement);
        }
        
        // Close db
        sqlite3_close(sqliteDb);
    }
    
}

@end
