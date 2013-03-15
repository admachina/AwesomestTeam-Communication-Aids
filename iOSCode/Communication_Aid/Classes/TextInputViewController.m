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

@implementation TextInputViewController

@synthesize textView;
@synthesize calibViewController;
@synthesize charButtonLeft;
@synthesize charButtonUp;
@synthesize charButtonRight;
@synthesize charButtonDown;
@synthesize messageText;
@synthesize fliteController;
@synthesize slt;

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


- (id)initWithNavigator:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil navigator:(TreeNavigator *)navigator
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    calibViewController = [[CalibrationViewController alloc] initWithNibName:@"CalibrationViewController" bundle:nibBundleOrNil];
    internalNavigator = navigator;
    [self view];
    
    // Set up initial view
    SelectionTree* treeRoot = [navigator currentTree];
    for (int i=0; i < 4; i++) { // Must be set up diferently for multiple sizes
        switch (i) {
            case 0:
                [charButtonLeft setTitle:[[treeRoot next:i] displayValue] forState:UIControlStateNormal];
                break;
                
            case 1:
                [charButtonUp setTitle:[[treeRoot next:i] displayValue] forState:UIControlStateNormal];
                break;
                
            case 2:
                [charButtonRight setTitle:[[treeRoot next:i] displayValue] forState:UIControlStateNormal];
                break;
                
            case 3:
                [charButtonDown setTitle:[[treeRoot next:i] displayValue] forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
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
    
    [calibViewController setTextInputViewController:self];
}


- (void) keyPress:(char) c
{
    if (c == [calibViewController leftKeyChar])
    {
        [self setText:charButtonLeft];
    }
    else if (c == [calibViewController upKeyChar])
    {
        [self setText:charButtonUp];
    }
    else if (c == [calibViewController rightKeyChar])
    {
        [self setText:charButtonRight];
    }
    else if (c == [calibViewController downKeyChar])
    {
        [self setText:charButtonDown];
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

- (IBAction)setText:(id)sender {
	NSString* newChar = nil;
    NSMutableArray* newButtonsArray = [[NSMutableArray alloc] init];
	if (sender == charButtonLeft)
        newChar = [internalNavigator choose:0 :newButtonsArray];
	else if (sender == charButtonUp)
		newChar = [internalNavigator choose:1 :newButtonsArray];
	else if (sender == charButtonRight)
		newChar = [internalNavigator choose:2 :newButtonsArray];
	else if (sender == charButtonDown)
		newChar = [internalNavigator choose:3 :newButtonsArray];
	/*else
		// throw exception
	 */
    
    if(newChar == NULL)
    {
        return;
    }
    
	
	if (newChar != nil && [newChar length] > 0)
	{
        [textView addText:[NSString stringWithFormat:@"%@", newChar]];
//        [self.fliteController say:[textView textStore] withVoice:self.slt];
	}
    
    for (int i=0; i < 4; i++) { // Must be set up diferently for multiple sizes
        if(i < [newButtonsArray count])
        {
            [newButtonsArray addObject:@""];
        }
        
        switch (i) {
            case 0:
                [charButtonLeft setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
                break;
                
            case 1:
                [charButtonUp setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
                break;
                
            case 2:
                [charButtonRight setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
                break;
                
            case 3:
                [charButtonDown setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
    }

    if ([[[charButtonDown titleLabel] text] compare:@"More"] == NSOrderedSame)
    {
        [charButtonDown setTitleColor:[UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
        [charButtonDown setTitleColor:[UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:1.0] forState:UIControlStateHighlighted];
    }
    else if ([[[charButtonDown titleLabel] text] compare:@"Go Back"] == NSOrderedSame)
    {
        [charButtonDown setTitleColor:[UIColor colorWithRed:224.0/256.0 green:0.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
        [charButtonDown setTitleColor:[UIColor colorWithRed:224.0/256.0 green:0.0 blue:0.0 alpha:1.0] forState:UIControlStateHighlighted];
    }
    else
    {
        [charButtonDown setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [charButtonDown setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    }
    
    if ([[[charButtonUp titleLabel] text] compare:@"Core"] == NSOrderedSame &&
        [[textView textStore] length] > 0)
    {
        [self.fliteController say:[textView textStore] withVoice:self.slt];
    }
    
    [textView becomeFirstResponder];
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [textView release];
    textView = nil;
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
	[messageText dealloc];
    [super dealloc];
}


@end