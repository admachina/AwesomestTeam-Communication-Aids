//
//  ProfileViewController.h
//  Communication_Aid
//
//  Created by Victor Tong on 2013-02-24.
//
//

#import <UIKit/UIKit.h>
#import "TextInputViewController.h"

@interface ProfileViewController : UITableViewController {
    NSMutableArray* profiles;
    TextInputViewController* textInputViewController;
}

@property(nonatomic, retain) NSMutableArray* profiles;
@property(nonatomic, retain) TextInputViewController* textInputViewController;

- (id)initWithTextInputView:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil textInputViewController:(TextInputViewController *)newTextInputViewController;
- (void) repopulateProfiles;


@end
