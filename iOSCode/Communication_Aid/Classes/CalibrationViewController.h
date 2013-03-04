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

@property (nonatomic) char leftKeyChar;
@property (nonatomic) char rightKeyChar;
@property (nonatomic) char upKeyChar;
@property (nonatomic) char downKeyChar;
@property (nonatomic, assign) TextInputViewController *textInputViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (IBAction)calibrateLeft:(id)sender;
- (IBAction)calibrateUp:(id)sender;
- (IBAction)calibrateRight:(id)sender;
- (IBAction)calibrateDown:(id)sender;
- (IBAction)goBack:(id)sender;
- (IBAction)cancelCalibrating:(id)sender;

@end
