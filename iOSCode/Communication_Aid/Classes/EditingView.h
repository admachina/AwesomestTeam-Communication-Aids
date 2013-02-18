//
//  EditingView.h
//  TextEditing
//
//  Created by Jeffrey Sambells on 10-04-21.
//  Copyright 2010 TropicalPixels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextInputViewController.h"

@interface UIKeyInputExampleView : UIView <UIKeyInput> {
    NSMutableString *textStore;
    TextInputViewController* textInputViewController;
}

@property (nonatomic, retain) NSMutableString *textStore;
@property (nonatomic, retain) TextInputViewController *textInputViewController;

- (void) addText:(NSString*) text;
@end