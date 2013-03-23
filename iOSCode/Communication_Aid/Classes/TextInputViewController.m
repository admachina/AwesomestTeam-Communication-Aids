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
#import "FileUploader.h"
#import "ProfileViewController.h"
#import "DictionaryParser.h"

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
@synthesize calibrateJoystickButton;
@synthesize joystick_cross_2_states;
@synthesize joystick_cross_4_states;
@synthesize messageText;
@synthesize fliteController;
@synthesize slt;
@synthesize emailView;
@synthesize emailBody;
@synthesize profile;
@synthesize parentViewController;

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
//    calibViewController = [[CalibrationViewController alloc] initWithNibName:@"CalibrationViewController" bundle:nibBundleOrNil];
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
    
    DictionaryParser* parser = [[DictionaryParser alloc] init];
//    emailAddressTree = [parser parse:@"email_dictionary.txt" :@"Letters"];
    emailAddressTree = [[SelectionTree alloc]init : @"" : @""];
//    SelectionTree* emailAddressLetters = [parser parse:@"letters.txt" :@"Letters"];
//    [emailAddressTree addNode:emailAddressLetters];
    [emailAddressTree addNode:[parser parse:@"letters.txt" :@"Letters"]];
    [emailAddressTree addNode:[parser parse:@"numbers.txt" :@"Numbers"]];
    [emailAddressTree addNode:[parser parse:@"punctuation.txt" :@"Punctuation"]];
    [emailAddressTree addNode:[[SelectionTree alloc] init:@"Cancel Email" :@"Cancel Email"]];
    [emailAddressTree setRoot:true];
//    [emailAddressTree addNode:[[SelectionTree alloc] init:@"a" :@"a"]];
//    [emailAddressTree addNode:[[SelectionTree alloc] init:@"S" :@"c"]];
//    [emailAddressTree addNode:[[SelectionTree alloc] init:@"DONE" :@"DONE"]];
//    [emailAddressTree addNode:[[SelectionTree alloc] init:@"E" :@"E"]];
//    [emailAddressTree addNode:[[SelectionTree alloc] init:@"F" :@"F"]];
//    [emailAddressTree addNode:[[SelectionTree alloc] init:@"G" :@"G"]];
//    [emailAddressTree addNode:[[SelectionTree alloc] init:@"L" :@"L"]];
//    SelectionTree* next = [emailAddressTree addNode:[[SelectionTree alloc] init:@"More" :@""]];
//    [next addNode:[[SelectionTree alloc] init:@"1" :@"1"]];
//    [next addNode:[[SelectionTree alloc] init:@"2" :@"2"]];
//    [next addNode:[[SelectionTree alloc] init:@"3" :@"3"]];
//    [next addNode:[[SelectionTree alloc] init:@"4" :@"4"]];
//    [next addNode:[[SelectionTree alloc] init:@"5" :@"5"]];
//    [next addNode:[[SelectionTree alloc] init:@"6" :@"6"]];
//    [next addNode:[[SelectionTree alloc] init:@"7" :@"7"]];
//    SelectionTree* next2 = [next addNode:[[SelectionTree alloc] init:@"More" :@""]];
//    [next2 addNode:[[SelectionTree alloc] init:@"11" :@"11"]];
//    [next2 addNode:[[SelectionTree alloc] init:@"22" :@"23"]];
//    [next2 addNode:[[SelectionTree alloc] init:@"33" :@"33"]];
//    [next2 addNode:[[SelectionTree alloc] init:@"44" :@"44"]];
//    [next2 addNode:[[SelectionTree alloc] init:@"55" :@"55"]];
//    [next2 addNode:[[SelectionTree alloc] init:@"66" :@"66"]];
//    [next2 addNode:[[SelectionTree alloc] init:@"77" :@"77"]];
    return self;
}

- (id)initWithNavigator:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil navigator:(TreeNavigator *)navigator profile:(Profile*)aProfile emailBody:(NSString*)in_emailBody parentTextInputViewController:(TextInputViewController*)parentVC calibViewController:(CalibrationViewController*)calibVC
{
    self = [self initWithNavigator:nibNameOrNil bundle:nibBundleOrNil navigator:navigator profile:aProfile];
    [self setEmailBody:in_emailBody];
    [self setParentTextInputViewController:parentVC];
    [self setCalibViewController:calibVC];
    [textView addText:@"Email address: "];
    [calibrateJoystickButton setHidden:TRUE];
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
    
    if ([[[button titleLabel] text] compare:@"Go Back"] == NSOrderedSame ||
        [[[button titleLabel] text] compare:@"Go back"] == NSOrderedSame)
    {
        [button setTitle:@"GO BACK" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor colorWithRed:232.0/256.0 green:0.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:232.0/256.0 green:0.0 blue:0.0 alpha:1.0] forState:UIControlStateHighlighted];
    }
    else if (!isLeaf)
    {
        if ([[[button titleLabel] text] compare:@"More"] == NSOrderedSame ||
            [[[button titleLabel] text] compare:@"More..."] == NSOrderedSame)
        {
            [button setTitle:@"MORE" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0] forState:UIControlStateHighlighted];
        }
        else
        {
        
        [button setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:41.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        }
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

    [textView becomeFirstResponder];
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
        if ([newChar compare:@"space"] == NSOrderedSame)
        {
            [textView addText:[NSString stringWithFormat:@"%@", @" "]];
        }
        else if ([newChar compare:@"backspace"] == NSOrderedSame)
        {
//            NSString* current_text = [textView textStore];
//            if (( [current_text length] < 15 || [[current_text substringWithRange:NSMakeRange(0, 15)] compare:@"Email Address: "] != NSOrderedSame) ||
//                ([[current_text substringWithRange:NSMakeRange(0, 15)] compare:@"Email Address: "] == NSOrderedSame && [current_text length] > 15))
//            {
                [textView deleteBackward];
//            }
//            NSString* current_text = [textView textStore];
//            if ([current_text length] > 0)
//            {
//                [textView addText:[ current_text substringWithRange:NSMakeRange(0, [current_text length] - 1)]];
//            }
        }
        else if ([newChar compare:@"DONE"] == NSOrderedSame)
        {
            NSString* subject = @"Communication Aid Email";
            //body will be all text entered so far.
            NSMutableString* bodyText = [NSMutableString stringWithString:emailBody != nil ? emailBody : @""];

            NSString* email_address = [[textView textStore] substringWithRange:NSMakeRange(15, [[textView textStore] length] - 15)];
            [self sendEmail :subject body: bodyText recipient:email_address];
        }
        else if ([newChar compare:@"Cancel Email"] == NSOrderedSame)
        {
            [[self view] removeFromSuperview];
            [self resignFirstResponder];
            [[[self parentTextInputViewController] textView ]becomeFirstResponder];
        }
        else
        {
            [textView addText:[NSString stringWithFormat:@"%@", newChar]];
        }
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
    [self setCalibrateJoystickButton:nil];
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
    [calibrateJoystickButton release];
    [super dealloc];
}

//handles option if it recognizes them,
// returns true if handled, false if not
- (Boolean)handleIfAnOptionCall:(NSString *)string {

    if( [string compare: @"#!Email"] == NSOrderedSame  ){
        // Open another text input view controller for entering email address
        TreeNavigator* navigator = [[TreeNavigator alloc] initWithTree:emailAddressTree];
        TextInputViewController* emailAddressViewController = [[TextInputViewController alloc] initWithNavigator:@"TextInputViewController" bundle:[NSBundle mainBundle] navigator:navigator profile:profile emailBody:[textView textStore] parentTextInputViewController:self calibViewController:calibViewController];
        
        
        [self.view addSubview:[emailAddressViewController view]];
//        [self resignFirstResponder];
        [[emailAddressViewController textView] becomeFirstResponder];
//        //subject will be static for now
//        NSString* subject = @"Communication Aid Email"; 
//        //body will be all text entered so far.
//        NSMutableString* bodyText = [textView textStore];
//
//        [self sendEmail :subject body: bodyText];
        
    } else if ( [string compare: @"#!Speak" ] == NSOrderedSame) {
        
        //[self calibrateJoystick: (id)NULL];
        [self.fliteController say:[textView textStore] withVoice:self.slt];
    } else if ( [string compare:@"#!Export" ] == NSOrderedSame ) {
        
        [self exportData];
        
    } else if ( [string compare:@"#!Profile"] == NSOrderedSame ) {
        [[self view] removeFromSuperview];
/*
 ProfileViewController* aProfileViewController = [[ProfileViewController alloc] initWithTextInputView:@"ProfileViewController" bundle:[NSBundle mainBundle]];
        
        [self setProfileViewController:aProfileViewController];
        [aProfileViewController release];

        [window setRootViewController:profileViewController];
 */
    } else {
        return false;
    }

    return true;
}

-(void) sendEmail:(NSString *)subject body:(NSMutableString *)body recipient:(NSString*)recipient{
    //EmailViewController* evc = [[EmailViewController alloc ]init];
    [self.view addSubview:[emailView view]];
    [emailView setTextInputViewController:self];
    [emailView actionEmailComposer:subject body:body recipient:recipient];
//    [[emailView view] removeFromSuperview];
//    [textView becomeFirstResponder];
    //[self.view addSubview:[emailView view]];
    //[evc actionEmailComposer: subject : body];
    //[evc dealloc];
}

-(void) exportData  {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Connecting to server..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alertView show];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(alertView.bounds.size.width * 0.5f, alertView.bounds.size.height * 0.5f+5.0f);
    //spinner.center = CGPointMake(160, 240);
    spinner.hidesWhenStopped = YES;
    //[self.view addSubview:spinner];
    [spinner startAnimating];
    [alertView addSubview:spinner];
    [spinner release];
    
    FileUploader *uploader = [[FileUploader alloc] initWithData:@"FileUploader" bundle:[NSBundle mainBundle] data:[textView textStore] therapistName:@"therapist1" fileNameOnServer:@"somenewfile.txt"];
    dispatch_queue_t uploadQueue = dispatch_queue_create("uploader", NULL);
    dispatch_async(uploadQueue, ^{// do our long running process here
        //[NSThread sleepForTimeInterval:3];
        
        //CFWriteStreamRef writeStream =
        while (![uploader isDone]) {
            // busy wait
        }
        
        // do any UI stuff on the main UI thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [spinner stopAnimating];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        });
    });
    dispatch_release(uploadQueue);
    [uploader release];
    
}
@end
