//
//  Communication_AidAppDelegate.h
//  Communication_Aid
//
//  Created by Victoria Lee on 12-05-22.
//

#import <UIKit/UIKit.h>

@class TextInputViewController;
@class ProfileViewController;

@interface Communication_AidAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	TextInputViewController* textInputViewController;
    ProfileViewController* profileViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) TextInputViewController *textInputViewController;
@property (nonatomic, retain) ProfileViewController* profileViewController;

-(void) copyFileFromBundleToDocs : (NSString*) fileName;

@end

