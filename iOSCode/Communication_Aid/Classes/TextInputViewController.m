    //
//  TextInputViewController.m
//  Communication_Aid
//
//  Created by Victoria Lee on 12-05-22.
//

#import "TextInputViewController.h"
#import "CalibrationViewController.h"
#import "TreeNavigator.h"
#import "EditingView.h"
#import "EmailViewController.h"

@implementation TextInputViewController

@synthesize textView;
@synthesize calibViewController;
@synthesize charButtonLeft;
@synthesize charButtonUp;
@synthesize charButtonRight;
@synthesize charButtonDown;
@synthesize charButton1;
@synthesize charButton2;
@synthesize charButton3;
@synthesize charButton4;
@synthesize charButton5;
@synthesize charButton6;
@synthesize charButton7;
@synthesize charButton8;
@synthesize joystick_cross_2_states;
@synthesize joystick_cross_4_states;
@synthesize messageText;
@synthesize fliteController;
@synthesize slt;
@synthesize emailView;
@synthesize profile;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (FliteController *)fliteController {
	if (fliteController == nil) {
		fliteController = [[FliteController alloc] init];
	}
	return fliteController;
}

- (Slt *)slt {
	if (slt == nil) {
		slt = [[Slt alloc] init];
	}
	return slt;
}


- (id)initWithNavigator:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil navigator:(TreeNavigator *)navigator profile:(Profile*)aProfile
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    profile = [aProfile retain];
    int num_inputs = [profile dimensions];
    calibViewController = [[CalibrationViewController alloc] initWithNibName:@"CalibrationViewController" bundle:nibBundleOrNil num_inputs:num_inputs];
    calibViewController = [[CalibrationViewController alloc] initWithNibName:@"CalibrationViewController" bundle:nibBundleOrNil];
    emailView = [[EmailViewController alloc] init];
    internalNavigator = navigator;
    [self view];
    
    buttons = [[NSMutableArray alloc] init];
    
    if (num_inputs == 2)
    {
        [buttons addObject:charButtonUp];
        [buttons addObject:charButtonDown];
        [joystick_cross_2_states setHidden:FALSE];
    }
    else if (num_inputs == 4)
    {
        [buttons addObject:charButtonLeft];
        [buttons addObject:charButtonUp];
        [buttons addObject:charButtonRight];
        [buttons addObject:charButtonDown];
        [joystick_cross_4_states setHidden:FALSE];
    }
    else if (num_inputs > 4 && num_inputs < 9)
    {
        [buttons addObject:charButton1];
        [buttons addObject:charButton2];
        [buttons addObject:charButton3];
        [buttons addObject:charButton4];
        [buttons addObject:charButton5];
        if (num_inputs >= 6)
            [buttons addObject:charButton6];
        if (num_inputs >= 7)
            [buttons addObject:charButton7];
        if (num_inputs >= 8)
            [buttons addObject:charButton8];
    }
    
    for (UIButton* button in buttons)
    {
        [button setHidden:FALSE];
    }
    
    // Set up initial view
    SelectionTree* treeRoot = [navigator currentTree];
    for (int i=0; i < [buttons count]; i++) { // Must be set up diferently for multiple sizes
        [self setButtonColour: [buttons objectAtIndex : i] isLeaf:[[treeRoot next:i] isLeaf] ? @"yes" : @"no"];
        [[buttons objectAtIndex :i] setTitle:[[treeRoot next:i] displayValue] forState:UIControlStateNormal];
//        switch (i) {
//            case 0:
//                [self setButtonColour:[buttons] isLeaf:[[treeRoot next:i] isLeaf] ? @"yes" : @"no"];
//                [charButtonLeft setTitle:[[treeRoot next:i] displayValue] forState:UIControlStateNormal];
//                break;
//                
//            case 1:
//                [self setButtonColour:charButtonUp isLeaf:[[treeRoot next:i] isLeaf] ? @"yes" : @"no"];
//                [charButtonUp setTitle:[[treeRoot next:i] displayValue] forState:UIControlStateNormal];
//                break;
//                
//            case 2:
//                [self setButtonColour:charButtonRight isLeaf:[[treeRoot next:i] isLeaf] ? @"yes" : @"no"];
//                [charButtonRight setTitle:[[treeRoot next:i] displayValue] forState:UIControlStateNormal];
//                break;
//                
//            case 3:
//                [self setButtonColour:charButtonDown isLeaf:[[treeRoot next:i] isLeaf] ? @"yes" : @"no"];
//                [charButtonDown setTitle:[[treeRoot next:i] displayValue] forState:UIControlStateNormal];
//                break;
//                
//            default:
//                break;
//        }
    }
    
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // additional setup on custom editing text view in nib
    [textView setInsertTextMethod:@selector(keyPress:)];
    [textView setViewController:self];
    [textView becomeFirstResponder];
    
    charButtonLeft.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    charButtonRight.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    charButtonUp.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    charButtonDown.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    charButton1.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    charButton2.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    charButton3.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    charButton4.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    charButton5.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    charButton6.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    charButton7.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    charButton8.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    
    [calibViewController setTextInputViewController:self];
}
/*
- (void) setProfile:(Profile*)profile {
    [profile retain];
    if (self.profile != nil) {
        [self.profile release];
    }
    self.profile = profile;
    
    // TODO: Reinitialize screen
}*/

- (void) keyPress:(char) c
{
    int num_buttons = [buttons count];
    if (num_buttons == 2)
    {
        if (c == [calibViewController upKeyChar])
        {
            [self setText:[buttons objectAtIndex :0]];
        }
        else if (c == [calibViewController downKeyChar])
        {
            [self setText:[buttons objectAtIndex :1]];
        }
    }
    else if (num_buttons == 4)
    {
        if (c == [calibViewController leftKeyChar])
        {
            [self setText:[buttons objectAtIndex :0]];
        }
        else if (c == [calibViewController upKeyChar])
        {
            [self setText:[buttons objectAtIndex :1]];
        }
        else if (c == [calibViewController rightKeyChar])
        {
            [self setText:[buttons objectAtIndex :2]];
        }
        else if (c == [calibViewController downKeyChar])
        {
            [self setText:[buttons objectAtIndex :3]];
        }
    }
    else if (num_buttons > 4 && num_buttons < 9)
    {
        if (c == [calibViewController keyChar1])
        {
            [self setText:[buttons objectAtIndex :0]];
        }
        else if (c == [calibViewController keyChar2])
        {
            [self setText:[buttons objectAtIndex :1]];
        }
        else if (c == [calibViewController keyChar3])
        {
            [self setText:[buttons objectAtIndex :2]];
        }
        else if (c == [calibViewController keyChar4])
        {
            [self setText:[buttons objectAtIndex :3]];
        }
        else if (c == [calibViewController keyChar5])
        {
            [self setText:[buttons objectAtIndex :4]];
        }
        else if (num_buttons >= 6 && c == [calibViewController keyChar6])
        {
            [self setText:[buttons objectAtIndex :5]];
        }
        else if (num_buttons >= 7 && c == [calibViewController keyChar7])
        {
            [self setText:[buttons objectAtIndex :6]];
        }
        else if (num_buttons >= 8 && c == [calibViewController keyChar8])
        {
            [self setText:[buttons objectAtIndex :7]];
        }
    }
}

- (IBAction)calibrateJoystick:(id)sender {
    [self.view addSubview:[calibViewController view]];
}

- (void) exitJoystickCalibration
{
    [[calibViewController view] removeFromSuperview];
    [textView becomeFirstResponder];
}

- (void) setButtonColour:(UIButton*) button isLeaf:(NSString*)isLeafStr
{
    bool isLeaf = [isLeafStr compare:@"yes"] == NSOrderedSame;
    
    if ([[[charButtonDown titleLabel] text] compare:@"Go Back"] == NSOrderedSame)
    {
        [charButtonDown setTitle:@"GO BACK" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor colorWithRed:232.0/256.0 green:0.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:232.0/256.0 green:0.0 blue:0.0 alpha:1.0] forState:UIControlStateHighlighted];
    }
    else if (!isLeaf)
    {
        if ([[[charButtonDown titleLabel] text] compare:@"More"] == NSOrderedSame)
        {
            [charButtonDown setTitle:@"MORE" forState:UIControlStateNormal];
        }
        
        [button setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    }
    else
    {
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    }
}

- (IBAction)setText:(id)sender {
	NSString* newChar = nil;
    NSMutableArray* newButtonsArray = [[NSMutableArray alloc] init];
    NSMutableArray* leafArray = [[NSMutableArray alloc] init];

    for (int i = 0; i < [buttons count]; i++)
    {
        if (sender == [buttons objectAtIndex :i])
        {
            newChar = [internalNavigator choose:i valuesToDisplay:newButtonsArray leafArray:leafArray];
            break;
        }
    }
//	if (sender == charButtonLeft)
//    {
//        newChar = [internalNavigator choose:0 valuesToDisplay:newButtonsArray leafArray:leafArray];
//    }
//	else if (sender == charButtonUp)
//    {
//		newChar = [internalNavigator choose:1 valuesToDisplay:newButtonsArray leafArray:leafArray];
//    }
//	else if (sender == charButtonRight)
//    {
//		newChar = [internalNavigator choose:2 valuesToDisplay:newButtonsArray leafArray:leafArray];
//    }
//	else if (sender == charButtonDown)
//    {
//		newChar = [internalNavigator choose:3 valuesToDisplay:newButtonsArray leafArray:leafArray];
//    }
	/*else
		// throw exception
	 */
    
    if(newChar == NULL)
    {
        return;
    }
    
    //TODO: here we should check for options text and delegate accordingly
    
    //if an option do not output text
    // also handle any required actions.
    if( [self handleIfAnOptionCall :newChar] ) {
        
    } else 
	
	if (newChar != nil && [newChar length] > 0)
	{
        [textView addText:[NSString stringWithFormat:@"%@", newChar]];
//        [self.fliteController say:[textView textStore] withVoice:self.slt];
	}
    
    for (int i=0; i < [buttons count]; i++) { // Must be set up diferently for multiple sizes
        if(i >= [newButtonsArray count])
        {
            [newButtonsArray addObject:@""];
        }
        
        if(i >= [leafArray count])
        {
            [leafArray addObject:@"yes"];
        }
        
        [[buttons objectAtIndex :i] setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
        [self setButtonColour:[buttons objectAtIndex :i] isLeaf:[leafArray objectAtIndex:i]];
        
//        switch (i) {
//            case 0:
//                [charButtonLeft setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
//                [self setButtonColour:charButtonLeft isLeaf:[leafArray objectAtIndex:i]];
//                break;
//                
//            case 1:
//                [charButtonUp setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
//                [self setButtonColour:charButtonUp isLeaf:[leafArray objectAtIndex:i]];
//                break;
//                
//            case 2:
//                [charButtonRight setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
//                [self setButtonColour:charButtonRight isLeaf:[leafArray objectAtIndex:i]];
//                break;
//                
//            case 3:
//                [charButtonDown setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
//                [self setButtonColour:charButtonDown isLeaf:[leafArray objectAtIndex:i]];
//                break;
//                
//            default:
//                break;
//        }
    }
    
//    if ([[[charButtonUp titleLabel] text] compare:@"Core"] == NSOrderedSame &&
//        [[textView textStore] length] > 0)
//    {
//        [self.fliteController say:[textView textStore] withVoice:self.slt];
//    }
    
    [textView becomeFirstResponder];
    
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return NO;  // don't want view to autorotate
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [textView release];
    textView = nil;
    [self setCharButton1:nil];
    [self setCharButton2:nil];
    [self setCharButton3:nil];
    [self setCharButton4:nil];
    [self setCharButton5:nil];
    [self setCharButton6:nil];
    [self setCharButton8:nil];
    [self setCharButton7:nil];
    [self setCharButton8:nil];
    [self setJoystick_cross_2_states:nil];
    [self setJoystick_cross_4_states:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [fliteController release];
	[textView dealloc];
	[charButtonLeft dealloc];
	[charButtonUp dealloc];
	[charButtonRight dealloc];
	[charButtonDown dealloc];
    [buttons dealloc];
	[messageText dealloc];
    [charButton1 release];
    [charButton2 release];
    [charButton3 release];
    [charButton4 release];
    [charButton5 release];
    [charButton6 release];
    [charButton8 release];
    [charButton7 release];
    [charButton8 release];
    [joystick_cross_2_states release];
    [joystick_cross_4_states release];
    [super dealloc];
}

//handles option if it recognizes them,
// returns true if handled, false if not
- (Boolean)handleIfAnOptionCall:(NSString *)string {

    if( [string compare: @"#!Email"] == NSOrderedSame  ){
        //subject will be static for now
        NSString* subject = @"Communication Aid Email"; 
        //body will be all text entered so far.
        NSMutableString* bodyText = [textView textStore];

        [self sendEmail :subject : bodyText];
        
    } else if ( [string compare: @"#!Calibrate" ] == NSOrderedSame) {
        
        [self calibrateJoystick: (id)NULL];
    } else {
        return false;
    }

    return true;
}

-(void) sendEmail:(NSString *)subject :(NSMutableString *)body {
    //EmailViewController* evc = [[EmailViewController alloc ]init];
    [emailView actionEmailComposer:subject: body];
    //[self.view addSubview:[emailView view]];
    //[evc actionEmailComposer: subject : body];
    //[evc dealloc];
}

@end
