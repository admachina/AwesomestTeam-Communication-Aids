//
//  EditingView.h
//  TextEditing
//
//  Created by Jeffrey Sambells on 10-04-21.
//  Copyright 2010 TropicalPixels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIKeyInputExampleView : UIView <UIKeyInput> {
    NSMutableString *textStore;
    SEL insertTextMethod;
    UIViewController* viewController;
}

@property (nonatomic, retain) NSMutableString *textStore;
@property SEL insertTextMethod;
@property (nonatomic, assign) UIViewController *viewController;

- (void) addText:(NSString*) text;
@end