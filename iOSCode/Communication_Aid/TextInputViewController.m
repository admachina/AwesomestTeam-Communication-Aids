    //
//  TextInputViewController.m
//  Communication_Aid
//
//  Created by Victoria Lee on 12-05-22.
//

#import "TextInputViewController.h"
#import "TreeNavigator.h"

@implementation TextInputViewController

@synthesize textView;
@synthesize charButtonLeft;
@synthesize charButtonUp;
@synthesize charButtonRight;
@synthesize charButtonDown;
@synthesize messageText;

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

- (id)initWithNavigator:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil navigator:(TreeNavigator *)navigator
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    internalNavigator = navigator;
    return self;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (IBAction)setText:(id)sender {
	NSString* newChar = nil;
    NSMutableArray* newButtonsArray = [[NSMutableArray alloc] init];
	if (sender == charButtonLeft)
        newChar = [internalNavigator choose:0 :newButtonsArray];
	else if (sender == charButtonUp)
		newChar = [internalNavigator choose:0 :newButtonsArray];
	else if (sender == charButtonRight)
		newChar = [internalNavigator choose:0 :newButtonsArray];
	else if (sender == charButtonDown)
		newChar = [internalNavigator choose:0 :newButtonsArray];
	/*else
		// throw exception
	 */
	
	if (newChar != nil && [newChar length] > 0)
	{
		NSString* newMessage = [NSString stringWithFormat:@"%@%@", textView.text, newChar];
		textView.text = newMessage;
	}
    
    for (int i=0; i < 4 && i < [newButtonsArray count]; i++) { // Must be set up diferently for multiple sizes
        switch (i) {
            case 0:
                [charButtonLeft setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
                break;
                
            case 1:
                [charButtonLeft setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
                break;
                
            case 2:
                [charButtonLeft setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
                break;
                
            case 3:
                [charButtonLeft setTitle:[newButtonsArray objectAtIndex:i] forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
    }
	
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[textView dealloc];
	[charButtonLeft dealloc];
	[charButtonUp dealloc];
	[charButtonRight dealloc];
	[charButtonDown dealloc];
	[messageText dealloc];
    [super dealloc];
}


@end
