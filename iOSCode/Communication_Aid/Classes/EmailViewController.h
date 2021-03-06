//
//  EmailViewController.h
//  Communication_Aid
//
//  Created by Victoria Lee on 13-03-20.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//
// borrowed from :http://iphonedevsdk.com/forum/tutorial-discussion/43633-quick-tutorial-on-how-to-add-mfmailcomposeviewcontroller.html


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@class TextInputViewController;

@interface EmailViewController : UIViewController <MFMailComposeViewControllerDelegate>{
}

@property (nonatomic, assign) TextInputViewController *textInputViewController;
- (IBAction)actionEmailComposer: (NSString*) subject body: (NSMutableString*) body recipient:(NSString*)recipient;

@end
