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

@implementation Communication_AidAppDelegate

@synthesize window;
@synthesize textInputViewController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    // Init data
    NSString* configFileName = @"fakeFilePath";
    NSString* dictionaryFileName = @"fakeFilePath2";
    
    DictionaryParser* parser = [[DictionaryParser alloc] initWithName:configFileName];
    SelectionTree* tree = [parser parse:dictionaryFileName];
    
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
    TreeNavigator* navigator = [[TreeNavigator alloc] initWithTree:tree];
    
    // Init view
    TextInputViewController *aTextInputViewController = [[TextInputViewController alloc] initWithNavigator:@"TextInputViewController" bundle:[NSBundle mainBundle] navigator:navigator];
	[self setTextInputViewController:aTextInputViewController];
	[aTextInputViewController release];
	UIView *controllersView = [textInputViewController view];
	[window addSubview:controllersView];
    [self.window makeKeyAndVisible];
    
    return YES;
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
