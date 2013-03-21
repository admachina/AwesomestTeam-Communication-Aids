//
//  CalibrationViewController.h
//  Communication_Aid
//
//  Created by Victoria Lee on 12-12-22.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIKeyInputExampleView;
@class TextInputViewController;

@interface CalibrationViewController : UIViewController {
}

@property (retain, nonatomic) IBOutlet UILabel *instructionLabel;
@property (retain, nonatomic) IBOutlet UIKeyInputExampleView *keyInputView;
@property (retain, nonatomic) IBOutlet UIButton *leftButton;
@property (retain, nonatomic) IBOutlet UIButton *upButton;
@property (retain, nonatomic) IBOutlet UIButton *rightButton;
@property (retain, nonatomic) IBOutlet UIButton *downButton;
@property (retain, nonatomic) IBOutlet UIButton *cancelButton;
@property (retain, nonatomic) IBOutlet UIButton *backButton;
@property (retain, nonatomic) IBOutlet UIButton *button1;
@property (retain, nonatomic) IBOutlet UIButton *button2;
@property (retain, nonatomic) IBOutlet UIButton *button3;
@property (retain, nonatomic) IBOutlet UIButton *button4;
@property (retain, nonatomic) IBOutlet UIButton *button5;
@property (retain, nonatomic) IBOutlet UIButton *button6;
@property (retain, nonatomic) IBOutlet UIButton *button7;
@property (retain, nonatomic) IBOutlet UIButton *button8;
@property (retain, nonatomic) IBOutlet UIImageView *joystick_cross_4_states;
@property (retain, nonatomic) IBOutlet UIImageView *joystick_cross_2_states;

@property (nonatomic) char leftKeyChar;
@property (nonatomic) char rightKeyChar;
@property (nonatomic) char upKeyChar;
@property (nonatomic) char downKeyChar;
@property (nonatomic) char keyChar1;
@property (nonatomic) char keyChar2;
@property (nonatomic) char keyChar3;
@property (nonatomic) char keyChar4;
@property (nonatomic) char keyChar5;
@property (nonatomic) char keyChar6;
@property (nonatomic) char keyChar7;
@property (nonatomic) char keyChar8;

@property (nonatomic) int num_inputs;

@property (nonatomic, assign) TextInputViewController *textInputViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil num_inputs:(int)num_inputs;
- (IBAction)calibrateLeft:(id)sender;
- (IBAction)calibrateUp:(id)sender;
- (IBAction)calibrateRight:(id)sender;
- (IBAction)calibrateDown:(id)sender;
- (IBAction)calibrate1:(id)sender;
- (IBAction)calibrate2:(id)sender;
- (IBAction)calibrate3:(id)sender;
- (IBAction)calibrate4:(id)sender;
- (IBAction)calibrate5:(id)sender;
- (IBAction)calibrate6:(id)sender;
- (IBAction)calibrate7:(id)sender;
- (IBAction)calibrate8:(id)sender;
- (IBAction)goBack:(id)sender;
- (IBAction)cancelCalibrating:(id)sender;

@end
