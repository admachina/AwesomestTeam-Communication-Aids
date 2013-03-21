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
    [_button1 setEnabled:FALSE];
    [_button2 setEnabled:FALSE];
    [_button3 setEnabled:FALSE];
    [_button4 setEnabled:FALSE];
    [_button5 setEnabled:FALSE];
    [_button6 setEnabled:FALSE];
    [_button7 setEnabled:FALSE];
    [_button8 setEnabled:FALSE];
    
    [_leftButton setTitle:@"" forState:UIControlStateDisabled];
    [_rightButton setTitle:@"" forState:UIControlStateDisabled];
    [_upButton setTitle:@"" forState:UIControlStateDisabled];
    [_downButton setTitle:@"" forState:UIControlStateDisabled];
    [_button1 setTitle:@"" forState:UIControlStateDisabled];
    [_button2 setTitle:@"" forState:UIControlStateDisabled];
    [_button3 setTitle:@"" forState:UIControlStateDisabled];
    [_button4 setTitle:@"" forState:UIControlStateDisabled];
    [_button5 setTitle:@"" forState:UIControlStateDisabled];
    [_button6 setTitle:@"" forState:UIControlStateDisabled];
    [_button7 setTitle:@"" forState:UIControlStateDisabled];
    [_button8 setTitle:@"" forState:UIControlStateDisabled];
}

- (void)enableAllJoystickButtons
{
    [_leftButton setEnabled:TRUE];
    [_rightButton setEnabled:TRUE];
    [_upButton setEnabled:TRUE];
    [_downButton setEnabled:TRUE];
    [_button1 setEnabled:TRUE];
    [_button2 setEnabled:TRUE];
    [_button3 setEnabled:TRUE];
    [_button4 setEnabled:TRUE];
    [_button5 setEnabled:TRUE];
    [_button6 setEnabled:TRUE];
    [_button7 setEnabled:TRUE];
    [_button8 setEnabled:TRUE];
    
    [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_upButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_downButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_button3 setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_button4 setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_button5 setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_button6 setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_button7 setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_button8 setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
}

- (void)waitForDirectionSelection
{
    [_keyInputView setInsertTextMethod:NULL];
    [_cancelButton setHidden:TRUE];
    [_backButton setHidden:FALSE];
    [self enableAllJoystickButtons];
    if (_num_inputs <= 4)
        [_instructionLabel setText:@"Tap button to calibrate joystick direction"];
    else
        [_instructionLabel setText:@"Tap button to calibrate signal"];
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

- (void)setKeyChar1:(char)keyChar1
{
    _keyChar1 = keyChar1;
    [self waitForDirectionSelection];
}

- (void)setKeyChar2:(char)keyChar2
{
    _keyChar2 = keyChar2;
    [self waitForDirectionSelection];
}

- (void)setKeyChar3:(char)keyChar3
{
    _keyChar3 = keyChar3;
    [self waitForDirectionSelection];
}

- (void)setKeyChar4:(char)keyChar4
{
    _keyChar4 = keyChar4;
    [self waitForDirectionSelection];
}

- (void)setKeyChar5:(char)keyChar5
{
    _keyChar5 = keyChar5;
    [self waitForDirectionSelection];
}

- (void)setKeyChar6:(char)keyChar6
{
    _keyChar6 = keyChar6;
    [self waitForDirectionSelection];
}

- (void)setKeyChar7:(char)keyChar7
{
    _keyChar7 = keyChar7;
    [self waitForDirectionSelection];
}

- (void)setKeyChar8:(char)keyChar8
{
    _keyChar8 = keyChar8;
    [self waitForDirectionSelection];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil num_inputs:(int)num_inputs
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _leftKeyChar = 'q';
        _upKeyChar = 'e';
        _rightKeyChar = 'c';
        _downKeyChar = 'z';
        _keyChar1 = 'y';
        _keyChar2 = 'u';
        _keyChar3 = 'i';
        _keyChar4 = 'o';
        _keyChar5 = 'h';
        _keyChar6 = 'j';
        _keyChar7 = 'k';
        _keyChar8 = 'l';
        
        _num_inputs = num_inputs;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (_num_inputs == 2)
    {
        [_upButton setHidden:FALSE];
        [_downButton setHidden:FALSE];
        [_joystick_cross_2_states setHidden:FALSE];
    }
    else if (_num_inputs == 4)
    {
        [_upButton setHidden:FALSE];
        [_downButton setHidden:FALSE];
        [_leftButton setHidden:FALSE];
        [_rightButton setHidden:FALSE];
        [_joystick_cross_4_states setHidden:FALSE];
    }
    else if (_num_inputs > 4 && _num_inputs < 9)
    {
        [_instructionLabel setText:@"Tap button to calibrate signal"];
        [_button1 setHidden:FALSE];
        [_button2 setHidden:FALSE];
        [_button3 setHidden:FALSE];
        [_button4 setHidden:FALSE];
        [_button5 setHidden:FALSE];
        if (_num_inputs >= 6)
            [_button6 setHidden:FALSE];
        if (_num_inputs >= 7)
            [_button7 setHidden:FALSE];
        if (_num_inputs >= 8)
            [_button8 setHidden:FALSE];
    }
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
    [self setButton1:nil];
    [self setButton2:nil];
    [self setButton3:nil];
    [self setButton4:nil];
    [self setButton5:nil];
    [self setButton6:nil];
    [self setButton7:nil];
    [self setButton8:nil];
    [self setCancelButton:nil];
    [self setBackButton:nil];
    [self setJoystick_cross_4_states:nil];
    [self setJoystick_cross_2_states:nil];
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
    [_button1 release];
    [_button2 release];
    [_button3 release];
    [_button4 release];
    [_button5 release];
    [_button6 release];
    [_button7 release];
    [_button8 release];
    [_joystick_cross_4_states release];
    [_joystick_cross_2_states release];
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
    [self waitForCalibrationInput];
    [_leftButton setTitle:@"left" forState:UIControlStateDisabled];
    [_instructionLabel setText:@"Release joystick. Move joystick left."];
    [_keyInputView setInsertTextMethod:@selector(setLeftKeyChar:)];
    [_leftButton setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateDisabled];
}

- (IBAction)calibrateUp:(id)sender {
    [self waitForCalibrationInput];
    [_upButton setTitle:@"up" forState:UIControlStateDisabled];
    [_instructionLabel setText:@"Release joystick. Move joystick up."];
    [_keyInputView setInsertTextMethod:@selector(setUpKeyChar:)];
    [_upButton setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateDisabled];
}

- (IBAction)calibrateRight:(id)sender {
    [self waitForCalibrationInput];
    [_rightButton setTitle:@"right" forState:UIControlStateDisabled];
    [_instructionLabel setText:@"Release joystick. Move joystick right."];
    [_keyInputView setInsertTextMethod:@selector(setRightKeyChar:)];
    [_rightButton setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateDisabled];
}

- (IBAction)calibrateDown:(id)sender {
    [self waitForCalibrationInput];
    [_downButton setTitle:@"down" forState:UIControlStateDisabled];
    [_instructionLabel setText:@"Release joystick. Move joystick down."];
    [_keyInputView setInsertTextMethod:@selector(setDownKeyChar:)];
    [_downButton setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateDisabled];
}

- (IBAction)calibrate1:(id)sender {
    [self waitForCalibrationInput];
    [_button1 setTitle:@"1" forState:UIControlStateDisabled];
    [_instructionLabel setText:@"Enter signal for button 1."];
    [_keyInputView setInsertTextMethod:@selector(setKeyChar1:)];
    [_button1 setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateDisabled];
}

- (IBAction)calibrate2:(id)sender {
    [self waitForCalibrationInput];
    [_button2 setTitle:@"2" forState:UIControlStateDisabled];
    [_instructionLabel setText:@"Enter signal for button 2."];
    [_keyInputView setInsertTextMethod:@selector(setKeyChar2:)];
    [_button2 setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateDisabled];
}

- (IBAction)calibrate3:(id)sender {
    [self waitForCalibrationInput];
    [_button3 setTitle:@"3" forState:UIControlStateDisabled];
    [_instructionLabel setText:@"Enter signal for button 3."];
    [_keyInputView setInsertTextMethod:@selector(setKeyChar3:)];
    [_button3 setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateDisabled];
}

- (IBAction)calibrate4:(id)sender {
    [self waitForCalibrationInput];
    [_button4 setTitle:@"4" forState:UIControlStateDisabled];
    [_instructionLabel setText:@"Enter signal for button 4."];
    [_keyInputView setInsertTextMethod:@selector(setKeyChar4:)];
    [_button4 setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateDisabled];
}

- (IBAction)calibrate5:(id)sender {
    [self waitForCalibrationInput];
    [_button5 setTitle:@"5" forState:UIControlStateDisabled];
    [_instructionLabel setText:@"Enter signal for button 5."];
    [_keyInputView setInsertTextMethod:@selector(setKeyChar5:)];
    [_button5 setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateDisabled];
}

- (IBAction)calibrate6:(id)sender {
    [self waitForCalibrationInput];
    [_button6 setTitle:@"6" forState:UIControlStateDisabled];
    [_instructionLabel setText:@"Enter signal for button 6."];
    [_keyInputView setInsertTextMethod:@selector(setKeyChar6:)];
    [_button6 setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateDisabled];
}

- (IBAction)calibrate7:(id)sender {
    [self waitForCalibrationInput];
    [_button7 setTitle:@"7" forState:UIControlStateDisabled];
    [_instructionLabel setText:@"Enter signal for button 7."];
    [_keyInputView setInsertTextMethod:@selector(setKeyChar7:)];
    [_button7 setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateDisabled];
}

- (IBAction)calibrate8:(id)sender {
    [self waitForCalibrationInput];
    [_button8 setTitle:@"8" forState:UIControlStateDisabled];
    [_instructionLabel setText:@"Enter signal for button 8."];
    [_keyInputView setInsertTextMethod:@selector(setKeyChar8:)];
    [_button8 setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateDisabled];
}

- (IBAction)goBack:(id)sender {
    [_textInputViewController exitJoystickCalibration];
}

- (IBAction)cancelCalibrating:(id)sender {
    [self waitForDirectionSelection];
}

@end
