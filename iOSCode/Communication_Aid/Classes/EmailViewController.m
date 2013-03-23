//
//  EmailViewController.m
//  Communication_Aid
//
//  Created by Victoria Lee on 13-03-20.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//
// borrowed from :http://iphonedevsdk.com/forum/tutorial-discussion/43633-quick-tutorial-on-how-to-add-mfmailcomposeviewcontroller.html

#import "EmailViewController.h"
#import "TextInputViewController.h"

@implementation EmailViewController

@synthesize textInputViewController;

-(IBAction)actionEmailComposer:(NSString *)subject body:(NSMutableString *)body recipient:(NSString*)recipient{

    if ([MFMailComposeViewController canSendMail]) {
    
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject: subject];
         [mailViewController setMessageBody:body isHTML:NO];
        [mailViewController setToRecipients:[NSArray arrayWithObject:recipient]];
          
          [self presentModalViewController:mailViewController animated:YES];
    //[self becomeFirstResponder];
          [mailViewController release];
          
          //}
        
    
    }     else {
              
            NSLog(@"Device is unable to send email in its current state.");
              
     }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {

    [self dismissModalViewControllerAnimated:YES];
    [[self view] removeFromSuperview];
    [self resignFirstResponder];
    [[textInputViewController view] removeFromSuperview];
    [textInputViewController resignFirstResponder];
    [[[textInputViewController parentTextInputViewController] textView ]becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    
}

- (void)dealloc {
    
    [super dealloc];
    
}

@end

