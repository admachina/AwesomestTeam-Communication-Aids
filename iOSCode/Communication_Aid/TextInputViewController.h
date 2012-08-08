//
//  TextInputViewController.h
//  Communication_Aid
//
//  Created by Victoria Lee on 12-05-22.
//

#import <UIKit/UIKit.h>
#include "TreeNavigator.h"
#import <OpenEars/FliteController.h>

@interface TextInputViewController : UIViewController <UITextViewDelegate> {
	UITextView* textView;
	UIButton* charButtonLeft;
	UIButton* charButtonUp;
	UIButton* charButtonRight;
	UIButton* charButtonDown;
	NSString* messageText;
    TreeNavigator* internalNavigator;
    FliteController *fliteController; 
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIButton *charButtonLeft;
@property (nonatomic, retain) IBOutlet UIButton *charButtonUp;
@property (nonatomic, retain) IBOutlet UIButton *charButtonRight;
@property (nonatomic, retain) IBOutlet UIButton *charButtonDown;
@property (nonatomic, copy) NSString* messageText;
@property (nonatomic, retain) FliteController *fliteController; 

- (id)initWithNavigator:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil navigator:(TreeNavigator *)navigator;
- (IBAction)setText:(id)sender;
@end
