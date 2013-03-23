//
//  EditingView.h
//  TextEditing
//
//  Created by Jeffrey Sambells on 10-04-21.
//  Copyright 2010 TropicalPixels. All rights reserved.
//

#import <UIKit/UIKit.h>

// SimpleCaretView draws a basic text "caret", used as an insertion point
// cursor in SimpleCoreTextView
@interface SimpleCaretView : UIView {
    NSTimer *_blinkTimer;
}

- (void)delayBlink;

@end

@interface UIKeyInputExampleView : UIView <UIKeyInput> {
    NSMutableString *textStore;
    SEL insertTextMethod;
    UIViewController* viewController;
    
    NSDictionary* attributes;
    UIFont* font;
    SimpleCaretView* caretView;
}

@property (nonatomic, retain) NSMutableString *textStore;
@property SEL insertTextMethod;
@property (nonatomic, assign) UIViewController *viewController;
@property (nonatomic, copy) UIFont *font;

- (void) addText:(NSString*) text;
- (void) deleteBackward;
- (CGRect)caretRectForIndex:(int)index textRect:(CGRect)textRect;
@end

