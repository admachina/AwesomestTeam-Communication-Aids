    //
//  TextInputViewController.m
//  Communication_Aid
//
//  Created by Victoria Lee on 12-05-22.
//

#import "TextInputViewController.h"
#import "TreeNavigator.h"
#import "EditingView.h"

@implementation TextInputViewController

@synthesize textView;
@synthesize charButtonLeft;
@synthesize charButtonUp;
@synthesize charButtonRight;
@synthesize charButtonDown;
@synthesize messageText;
@synthesize fliteController;

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
        fliteController = [[FliteController alloc] init]; // OpenEars instructions say to use this style of lazy accessor to instantiate the object
        
        // set parameters
        self.fliteController.duration_stretch = 1.2;    // Change the speed
//        self.fliteController.target_mean = 1.2;       // Change the pitch
//        self.fliteController.target_stddev = 1.5;     // Change the variance
    }
    return fliteController;
}


- (id)initWithNavigator:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil navigator:(TreeNavigator *)navigator
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    internalNavigator = navigator;
    [self view];
    [textView setTextInputViewController:self];
    [textView becomeFirstResponder];
    charButtonLeft.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    charButtonRight.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    charButtonUp.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    charButtonDown.titleLabel.adjustsFontSizeToFitWidth = TRUE;
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void) keyPress:(char) c
{
    if (c == 'q')
    {
        [self setText:charButtonLeft];
    }
    else if (c == 'e')
    {
        [self setText:charButtonUp];
    }
    else if (c == 'c')
    {
        [self setText:charButtonRight];
    }
    else if (c == 'z')
    {
        [self setText:charButtonDown];
    }
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
//		NSString* newMessage = [NSString stringWithFormat:@"%@%@", textView.text, newChar];
        [textView addText:[NSString stringWithFormat:@"%@", newChar]];
        [self.fliteController say:[textView textStore] withVoice:@"cmu_us_awb8k"];
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
//    [self setTextView:nil];
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
//    [textView release];
    [super dealloc];
}


@end
