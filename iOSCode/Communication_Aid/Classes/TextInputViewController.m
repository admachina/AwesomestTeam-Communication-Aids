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
                [self setButtonColour:charButtonLeft isLeaf:[[treeRoot next:i] isLeaf] ? @"yes" : @"no"];
                [charButtonLeft setTitle:[[treeRoot next:i] displayValue] forState:UIControlStateNormal];
                break;
                
            case 1:
                [self setButtonColour:charButtonUp isLeaf:[[treeRoot next:i] isLeaf] ? @"yes" : @"no"];
                [charButtonUp setTitle:[[treeRoot next:i] displayValue] forState:UIControlStateNormal];
                break;
                
            case 2:
                [self setButtonColour:charButtonRight isLeaf:[[treeRoot next:i] isLeaf] ? @"yes" : @"no"];
                [charButtonRight setTitle:[[treeRoot next:i] displayValue] forState:UIControlStateNormal];
                break;
                
            case 3:
                [self setButtonColour:charButtonDown isLeaf:[[treeRoot next:i] isLeaf] ? @"yes" : @"no"];
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

	if (sender == charButtonLeft)
    {
        newChar = [internalNavigator choose:0 valuesToDisplay:newButtonsArray leafArray:leafArray];
    }
	else if (sender == charButtonUp)
    {
		newChar = [internalNavigator choose:1 valuesToDisplay:newButtonsArray leafArray:leafArray];
    }
	else if (sender == charButtonRight)
    {
		newChar = [internalNavigator choose:2 valuesToDisplay:newButtonsArray leafArray:leafArray];
    }
	else if (sender == charButtonDown)
    {
		newChar = [internalNavigator choose:3 valuesToDisplay:newButtonsArray leafArray:leafArray];
    }
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
        if(i >= [newButtonsArray count])
        {
            [newButtonsArray addObject:@""];
        }
        
        if(i >= [leafArray count])
        {
            [leafArray addObject:@"yes"];
        }
        
        switch (i) {
            case 0:
                [charButtonLeft setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
                [self setButtonColour:charButtonLeft isLeaf:[leafArray objectAtIndex:i]];
                break;
                
            case 1:
                [charButtonUp setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
                [self setButtonColour:charButtonUp isLeaf:[leafArray objectAtIndex:i]];
                break;
                
            case 2:
                [charButtonRight setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
                [self setButtonColour:charButtonRight isLeaf:[leafArray objectAtIndex:i]];
                break;
                
            case 3:
                [charButtonDown setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
                [self setButtonColour:charButtonDown isLeaf:[leafArray objectAtIndex:i]];
                break;
                
            default:
                break;
        }
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
