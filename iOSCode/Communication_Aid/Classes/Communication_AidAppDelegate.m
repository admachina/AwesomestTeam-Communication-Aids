//
//  Communication_AidAppDelegate.m
//  Communication_Aid
//
//  Created by Victoria Lee on 12-05-22.
//

#import "Communication_AidAppDelegate.h"
#import "TextInputViewController.h"
#import "DictionaryParser.h"
#import "SelectionTree.h"
#import "TreeNavigator.h"
#import "XMLTreeCreator.h"

@implementation Communication_AidAppDelegate

@synthesize window;
@synthesize textInputViewController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    // Init data
    NSString* configFileName = @"fakeFilePath";
    NSString* basicTreeFile = @"dictionary.txt";
    NSString* coreWordsTreeFile = @"coreWordsDict.txt";
    
    [self copyFileFromBundleToDocs : basicTreeFile];
    [self copyFileFromBundleToDocs : coreWordsTreeFile];
    [self copyFileFromBundleToDocs:@"defaultTree.xml"];
    
    //SelectionTree* tree = [XMLTreeCreator createTree:@"defaultTree.xml"];
    DictionaryParser* parser = [[DictionaryParser alloc] init];
    SelectionTree* basicTree = [parser parse:basicTreeFile:@"Basic"];
    SelectionTree* coreWordsTree = [parser parse:coreWordsTreeFile:@"Core"];
    
    SelectionTree* mainMenu = [[SelectionTree alloc] init];
    [mainMenu setRoot:TRUE];
    
    [mainMenu addNode:basicTree];
    [mainMenu addNode:coreWordsTree];
    
    //Test code
    /*SelectionTree* tree = [[SelectionTree alloc]init : @"" : @""];
    [tree setRoot:true];
    [tree addNode:[[SelectionTree alloc] init:@"A" :@"A"]];
    [tree addNode:[[SelectionTree alloc] init:@"S" :@"S"]];
    [tree addNode:[[SelectionTree alloc] init:@"D" :@"D"]];
    SelectionTree* next = [tree addNode:[[SelectionTree alloc] init:@"more" :@""]];
    [next addNode:[[SelectionTree alloc] init:@"J" :@"J"]];
    [next addNode:[[SelectionTree alloc] init:@"K" :@"K"]];
    [next addNode:[[SelectionTree alloc] init:@"L" :@"L"]];*/
    //End test code
    TreeNavigator* navigator = [[TreeNavigator alloc] initWithTree:mainMenu];
    
    // Init view
    TextInputViewController *aTextInputViewController = [[TextInputViewController alloc] initWithNavigator:@"TextInputViewController" bundle:[NSBundle mainBundle] navigator:navigator];
	[self setTextInputViewController:aTextInputViewController];
	[aTextInputViewController release];
	UIView *controllersView = [textInputViewController view];
	[window addSubview:controllersView];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)copyFileFromBundleToDocs:(NSString*)fileName {
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSLog(@"documentsDir:%@",documentsDir);
    
    NSError *error = nil;
    
    if ([filemgr fileExistsAtPath: [documentsDir stringByAppendingPathComponent:fileName] ] == YES) {
        
        NSLog (@"File exists, done");
        
    } else {
        
        NSLog (@"File not found, copying next.");
        
        if([filemgr copyItemAtPath:[[NSBundle mainBundle] pathForResource:fileName ofType:@""] toPath:[documentsDir stringByAppendingPathComponent:fileName] error:&error]){
            
            NSLog(@"File successfully copied to:%@",documentsDir);
            
        } else {
            
            NSLog(@"Error description - %@ \n", [error localizedDescription]);
            NSLog(@"Error reason - %@", [error localizedFailureReason]);
            
        }
        
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[textInputViewController release];
    [window release];
    [super dealloc];
}


@end
