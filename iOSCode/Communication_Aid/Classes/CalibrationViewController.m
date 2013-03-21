//
//  CalibrationViewController.m
//  Communication_Aid
//
//  Created by Victoria Lee on 12-12-22.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "TextInputViewController.h"
#import "CalibrationViewController.h"
#import "EditingView.h"

@implementation CalibrationViewController

@synthesize textInputViewController=_textInputViewController;
@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;
@synthesize upButton = _upButton;
@synthesize downButton = _downButton;
@synthesize leftKeyChar = _leftKeyChar;
@synthesize rightKeyChar = _rightKeyChar;
@synthesize upKeyChar = _upKeyChar;
@synthesize downKeyChar = _downKeyChar;
@synthesize cancelButton = _cancelButton;
@synthesize backButton = _backButton;
@synthesize instructionLabel = _instructionLabel;
@synthesize keyInputView = _keyInputView;

- (void)disableAllJoystickButtons
{
    [_leftButton setEnabled:FALSE];
    [_rightButton setEnabled:FALSE];
    [_upButton setEnabled:FALSE];
    [_downButton setEnabled:FALSE];
}

- (void)enableAllJoystickButtons
{
    [_leftButton setEnabled:TRUE];
    [_rightButton setEnabled:TRUE];
    [_upButton setEnabled:TRUE];
    [_downButton setEnabled:TRUE];
    
    [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_upButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_downButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
}

- (void)waitForDirectionSelection
{
    [_keyInputView setInsertTextMethod:NULL];
    [_cancelButton setHidden:TRUE];
    [_backButton setHidden:FALSE];
    [self enableAllJoystickButtons];
    [_instructionLabel setText:@"Tap button to calibrate joystick direction"];
}

- (void)setLeftKeyChar:(char)leftKeyChar
{
    _leftKeyChar = leftKeyChar;
    [self waitForDirectionSelection];
}

- (void)setRightKeyChar:(char)rightKeyChar
{
    _rightKeyChar = rightKeyChar;
    [self waitForDirectionSelection];
}

- (void)setUpKeyChar:(char)upKeyChar
{
    _upKeyChar = upKeyChar;
    [self waitForDirectionSelection];
}

- (void)setDownKeyChar:(char)downKeyChar
{
    _downKeyChar = downKeyChar;
    [self waitForDirectionSelection];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _leftKeyChar = 'q';
        _upKeyChar = 'e';
        _rightKeyChar = 'c';
        _downKeyChar = 'z';
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_keyInputView setViewController:self];
}

- (void)viewDidUnload
{
    [self setKeyInputView:nil];
    [self setInstructionLabel:nil];
    [self setLeftButton:nil];
    [self setUpButton:nil];
    [self setRightButton:nil];
    [self setDownButton:nil];
    [self setCancelButton:nil];
    [self setBackButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;  // don't want view to autorotate
}

- (void)dealloc {
    [_keyInputView release];
    [_instructionLabel release];
    [_leftButton release];
    [_upButton release];
    [_rightButton release];
    [_downButton release];
    [_cancelButton release];
    [_backButton release];
    [super dealloc];
}

- (void)waitForCalibrationInput
{
    [_keyInputView becomeFirstResponder];
    [_cancelButton setHidden:FALSE];
    [_backButton setHidden:TRUE];
    [self disableAllJoystickButtons];
}

- (IBAction)calibrateLeft:(id)sender {
    [_instructionLabel setText:@"Move joystick left"];
    [_keyInputView setInsertTextMethod:@selector(setLeftKeyChar:)];
    [_leftButton setTitleColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0] forState:UIControlStateDisabled];
    [self waitForCalibrationInput];
}

- (IBAction)calibrateUp:(id)sender {
    [_instructionLabel setText:@"Move joystick up"];
    [_keyInputView setInsertTextMethod:@selector(setUpKeyChar:)];
    [_upButton setTitleColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0] forState:UIControlStateDisabled];
    [self waitForCalibrationInput];
}

- (IBAction)calibrateRight:(id)sender {
    [_instructionLabel setText:@"Move joystick right"];
    [_keyInputView setInsertTextMethod:@selector(setRightKeyChar:)];
    [_rightButton setTitleColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0] forState:UIControlStateDisabled];
    [self waitForCalibrationInput];
}

- (IBAction)calibrateDown:(id)sender {
    [_instructionLabel setText:@"Move joystick down"];
    [_keyInputView setInsertTextMethod:@selector(setDownKeyChar:)];
    [_downButton setTitleColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0] forState:UIControlStateDisabled];
    [self waitForCalibrationInput];
}

- (IBAction)goBack:(id)sender {
    [_textInputViewController exitJoystickCalibration];
}

- (IBAction)cancelCalibrating:(id)sender {
    [self waitForDirectionSelection];
}
@end
