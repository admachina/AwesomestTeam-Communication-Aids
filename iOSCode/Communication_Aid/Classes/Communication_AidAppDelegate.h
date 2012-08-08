//
//  Communication_AidAppDelegate.h
//  Communication_Aid
//
//  Created by Victoria Lee on 12-05-22.
//

#import <UIKit/UIKit.h>

@class TextInputViewController;

@interface Communication_AidAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	TextInputViewController* textInputViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) TextInputViewController *textInputViewController;

-(void) copyFileFromBundleToDocs : (NSString*) fileName;

@end

