//
//  TextInputViewController.h
//  Communication_Aid
//
//  Created by Victoria Lee on 12-05-22.
//

#import <UIKit/UIKit.h>
#include "TreeNavigator.h"

@interface TextInputViewController : UIViewController <UITextViewDelegate> {
	UITextView* textView;
	UIButton* charButtonLeft;
	UIButton* charButtonUp;
	UIButton* charButtonRight;
	UIButton* charButtonDown;
	NSString* messageText;
    TreeNavigator* internalNavigator;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIButton *charButtonLeft;
@property (nonatomic, retain) IBOutlet UIButton *charButtonUp;
@property (nonatomic, retain) IBOutlet UIButton *charButtonRight;
@property (nonatomic, retain) IBOutlet UIButton *charButtonDown;
@property (nonatomic, copy) NSString* messageText;
- (id)initWithNavigator:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil navigator:(TreeNavigator *)navigator;
- (IBAction)setText:(id)sender;
@end
