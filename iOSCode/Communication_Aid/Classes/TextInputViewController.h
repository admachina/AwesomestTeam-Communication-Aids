//
//  TextInputViewController.h
//  Communication_Aid
//
//  Created by Victoria Lee on 12-05-22.
//

#import <UIKit/UIKit.h>
#include "TreeNavigator.h"
#import <Slt/Slt.h>
#import <OpenEars/FliteController.h>
#import "EmailViewController.h"

@class UIKeyInputExampleView;
@class CalibrationViewController;

@interface TextInputViewController : UIViewController <UITextViewDelegate> {
    UIKeyInputExampleView* textView;
    CalibrationViewController *calibViewController;
	UIButton* charButtonLeft;
	UIButton* charButtonUp;
	UIButton* charButtonRight;
	UIButton* charButtonDown;
	NSString* messageText;
    TreeNavigator* internalNavigator;
    FliteController *fliteController;
    Slt *slt;
}

@property (nonatomic, retain) IBOutlet UIKeyInputExampleView *textView;
@property (nonatomic, retain) CalibrationViewController *calibViewController;
@property (nonatomic, retain) EmailViewController* emailView;
@property (nonatomic, retain) IBOutlet UIButton *charButtonLeft;
@property (nonatomic, retain) IBOutlet UIButton *charButtonUp;
@property (nonatomic, retain) IBOutlet UIButton *charButtonRight;
@property (nonatomic, retain) IBOutlet UIButton *charButtonDown;
@property (nonatomic, copy) NSString* messageText;
@property (nonatomic, retain) FliteController *fliteController;
@property (strong, nonatomic) Slt *slt;

- (id)initWithNavigator:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil navigator:(TreeNavigator *)navigator;
- (IBAction)setText:(id)sender;
- (void) keyPress:(char) c;
- (IBAction)calibrateJoystick:(id)sender;
- (void) exitJoystickCalibration;

- (Boolean) handleIfAnOptionCall :(NSString*) string ;
//here are the possible option calls' handlers:

//email with subject and body
- (void) sendEmail: ( NSString*) subject: (NSMutableString*) body;


@end
