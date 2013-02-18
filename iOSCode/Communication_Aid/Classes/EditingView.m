//
//  EditingView.m
//  TextEditing
//
//  Created by Jeffrey Sambells on 10-04-21.
//  Copyright 2010 TropicalPixels. All rights reserved.
//

#include "EditingView.h"

@implementation UIKeyInputExampleView

@synthesize textStore;
@synthesize textInputViewController;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        self.textStore = [NSMutableString string];
        [self.textStore appendString:@"Touch screen to edit."];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)dealloc {
    [textStore dealloc];
    [super dealloc];
}

- (void) addText:(NSString*) text
{
    if (self.textStore == nil)
        self.textStore = [NSMutableString string];
    [self.textStore appendString:text];
    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark Respond to touch and become first responder.

- (BOOL)canBecomeFirstResponder { return YES; }

-(void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    [self becomeFirstResponder];
} 

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
    CGRect rectForText = CGRectInset(rect, 20.0, 20.0);
    UIRectFrame(rect);
    [self.textStore drawInRect:rectForText withFont:[UIFont fontWithName:@"Helvetica" size:60.0f]];
}

#pragma mark -
#pragma mark UIKeyInput Protocol Methods

- (BOOL)hasText {
    if (textStore.length > 0) {
        return YES;
    }
    return NO;
}

- (void)insertText:(NSString *)theText {
    if ([theText length] == 1)
        [textInputViewController keyPress:[theText characterAtIndex:0]];
    
    //    [self.textStore appendString:theText];
    //    [self setNeedsDisplay];
}

- (void)deleteBackward {
    //    NSRange theRange = NSMakeRange(self.textStore.length-1, 1);
    //    [self.textStore deleteCharactersInRange:theRange];
    //    [self setNeedsDisplay];
}

@end