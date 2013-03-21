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
#include "Profile.h"
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
    UIButton* charButton1;
	UIButton* charButton2;
	UIButton* charButton3;
	UIButton* charButton4;
    UIButton* charButton5;
	UIButton* charButton6;
	UIButton* charButton7;
	UIButton* charButton8;
	NSString* messageText;
    TreeNavigator* internalNavigator;
    FliteController *fliteController;
    Slt *slt;
    Profile* profile;
    NSMutableArray* buttons;
}

@property (nonatomic, retain) IBOutlet UIKeyInputExampleView *textView;
@property (nonatomic, retain) CalibrationViewController *calibViewController;
@property (nonatomic, retain) EmailViewController* emailView;
@property (nonatomic, retain) IBOutlet UIButton *charButtonLeft;
@property (nonatomic, retain) IBOutlet UIButton *charButtonUp;
@property (nonatomic, retain) IBOutlet UIButton *charButtonRight;
@property (nonatomic, retain) IBOutlet UIButton *charButtonDown;
@property (retain, nonatomic) IBOutlet UIButton *charButton1;
@property (retain, nonatomic) IBOutlet UIButton *charButton2;
@property (retain, nonatomic) IBOutlet UIButton *charButton3;
@property (retain, nonatomic) IBOutlet UIButton *charButton4;
@property (retain, nonatomic) IBOutlet UIButton *charButton5;
@property (retain, nonatomic) IBOutlet UIButton *charButton6;
@property (retain, nonatomic) IBOutlet UIButton *charButton7;
@property (retain, nonatomic) IBOutlet UIButton *charButton8;
@property (retain, nonatomic) IBOutlet UIImageView *joystick_cross_2_states;
@property (retain, nonatomic) IBOutlet UIImageView *joystick_cross_4_states;

@property (nonatomic, copy) NSString* messageText;
@property (nonatomic, retain) FliteController *fliteController;
@property (strong, nonatomic) Slt *slt;
@property (nonatomic, retain) Profile * profile;

- (id)initWithNavigator:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil navigator:(TreeNavigator *)navigator profile:(Profile*)profile;
- (IBAction)setText:(id)sender;
- (void) keyPress:(char) c;
- (IBAction)calibrateJoystick:(id)sender;
- (void) exitJoystickCalibration;
//- (void) setProfile:(Profile*)profile;

- (Boolean) handleIfAnOptionCall :(NSString*) string ;
//here are the possible option calls' handlers:

//email with subject and body
- (void) sendEmail: ( NSString*) subject: (NSMutableString*) body;


@end
