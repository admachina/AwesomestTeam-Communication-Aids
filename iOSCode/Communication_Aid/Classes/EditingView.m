//
//  EditingView.m
//  TextEditing
//
//  Created by Jeffrey Sambells on 10-04-21.
//  Copyright 2010 TropicalPixels. All rights reserved.
//

#include "EditingView.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/CALayer.h>

@implementation UIKeyInputExampleView

@synthesize textStore;
@synthesize insertTextMethod;
@synthesize viewController;
@synthesize font;

- (id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) {
        // Initialization code
        self.textStore = [NSMutableString string];
//        [self.textStore appendString:@"Touch screen to edit."];
        caretView = [[SimpleCaretView alloc] initWithFrame:CGRectZero];
        
        font = [UIFont fontWithName:@"Helvetica" size:60.0f];
        CTFontRef ctFont = CTFontCreateWithName((CFStringRef) self.font.fontName, self.font.pointSize, NULL);
        attributes = [[NSDictionary dictionaryWithObject:(id)ctFont forKey:(NSString *)kCTFontAttributeName] retain];
        [self updateCursor];
//        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        self.textStore = [NSMutableString string];
        [self.textStore appendString:@"Touch screen to edit."];
        caretView = [[SimpleCaretView alloc] initWithFrame:CGRectZero];
        
        font = [UIFont fontWithName:@"Helvetica" size:60.0f];
        CTFontRef ctFont = CTFontCreateWithName((CFStringRef) self.font.fontName, self.font.pointSize, NULL);
        attributes = [[NSDictionary dictionaryWithObject:(id)ctFont forKey:(NSString *)kCTFontAttributeName] retain];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)dealloc {
    [textStore dealloc];
    [caretView release];
    [super dealloc];
}

- (void) addText:(NSString*) text
{
    if (self.textStore == nil)
        self.textStore = [NSMutableString string];
    [self.textStore appendString:text];
    [self updateCursor];
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
    [self.textStore drawInRect:rectForText withFont:font];
    
    // If there is no selection range (always true for this sample), find the
	// insert point rect and create a caretView to draw the caret at this position
    caretView.frame = [self caretRectForIndex:textStore.length textRect:rectForText];
    if (!caretView.superview) {
        [self addSubview:caretView];
        //        [self setNeedsDisplay];
    }
    // Set up a timer to "blink" the caret
    [caretView delayBlink];
}

#pragma mark -
#pragma mark UIKeyInput Protocol Methods

- (void) updateCursor
{
//    // If there is no selection range (always true for this sample), find the
//	// insert point rect and create a caretView to draw the caret at this position
//    caretView.frame = [self caretRectForIndex:textStore.length-1];
//    if (!caretView.superview) {
//        [self addSubview:caretView];
////        [self setNeedsDisplay];
//    }
//    // Set up a timer to "blink" the caret
//    [caretView delayBlink];
}

- (BOOL)hasText {
    if (textStore.length > 0) {
        return YES;
    }
    return NO;
}

- (void)insertText:(NSString *)theText {
    if ([theText length] == 1 && insertTextMethod != NULL)
    {
        [viewController performSelector:insertTextMethod withObject:[theText characterAtIndex:0]];
        [self updateCursor];
        [self setNeedsDisplay];
    }
    //    [self.textStore appendString:theText];
}

- (void) deleteBackward {
    if (self.textStore.length > 0)
    {
        NSRange theRange = NSMakeRange(self.textStore.length-1, 1);
        [self.textStore deleteCharactersInRange:theRange];
        [self updateCursor];
        [self setNeedsDisplay];
    }
}

// Public method to determine the CGRect for the insertion point or selection, used
// when creating or updating our SimpleCaretView instance
- (CGRect)caretRectForIndex:(int)index textRect:(CGRect)textRect
{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.textStore attributes:attributes];
    
    CTFramesetterRef _framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:textRect];
    CTFrameRef _frame = CTFramesetterCreateFrame(_framesetter, CFRangeMake(0, 0), [path CGPath], NULL);
    
    NSArray *lines = (NSArray *) CTFrameGetLines(_frame);
    
    // Special case, no text
    if (textStore.length == 0) {
        CGPoint origin = CGPointMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + 20);
		// Note: using fabs() for typically negative descender from fonts
        return CGRectMake(origin.x, origin.y - fabs(self.font.descender), 3, self.font.ascender + fabs(self.font.descender));
    }
    
    // Special case, insertion point at final position in text after newline
    if (index == textStore.length && [textStore characterAtIndex:(index - 1)] == '\n') {
        CTLineRef line = (CTLineRef) [lines lastObject];
        CFRange range = CTLineGetStringRange(line);
        CGFloat xPos = CTLineGetOffsetForStringIndex(line, range.location, NULL);
        CGPoint origin;
        CGFloat ascent, descent;
        CTLineGetTypographicBounds(line, &ascent, &descent, NULL);
        CTFrameGetLineOrigins(_frame, CFRangeMake(lines.count - 1, 0), &origin);
		// Place point after last line, including any font leading spacing if applicable
        origin.y -= self.font.leading;
        return CGRectMake(xPos, origin.y - descent, 3, ascent + descent);
    }
    
    // Regular case, caret somewhere within our text content range
    for (int i = 0; i < [lines count]; i++) {
        CTLineRef line = (CTLineRef) [lines objectAtIndex:i];
        CFRange range = CTLineGetStringRange(line);
        NSInteger localIndex = index - range.location;
        if (localIndex >= 0 && localIndex <= range.length) {
			// index is in the range for this line
            CGFloat xPos = CTLineGetOffsetForStringIndex(line, index, NULL) + 20;
            CGPoint origin;
            CGFloat ascent, descent;
            CTLineGetTypographicBounds(line, &ascent, &descent, NULL);
            CTFrameGetLineOrigins(_frame, CFRangeMake(i, 0), &origin);
            origin.y = textRect.size.height - origin.y - 20;
			// Make a small "caret" rect at the index position
            return CGRectMake(xPos, origin.y - descent, 3, ascent + descent);
        }
    }
    
    return CGRectNull;
}

@end

@implementation SimpleCaretView

static const NSTimeInterval InitialBlinkDelay = 0.7;
static const NSTimeInterval BlinkRate = 0.5;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor colorWithRed:0.25 green:0.50 blue:1.0 alpha:1.0];
    }
    return self;
}

// Helper method to toggle hidden state of caret view
- (void)blink
{
    self.hidden = !self.hidden;
}

// UIView didMoveToSuperview override to set up blink timers after caret view created in superview
- (void)didMoveToSuperview
{
    self.hidden = NO;
    
    if (self.superview) {
        _blinkTimer = [[NSTimer scheduledTimerWithTimeInterval:BlinkRate target:self selector:@selector(blink) userInfo:nil repeats:YES] retain];
        [self delayBlink];
    } else {
        [_blinkTimer invalidate];
        [_blinkTimer release];
        _blinkTimer = nil;
    }
}

- (void)dealloc
{
    [_blinkTimer invalidate];
    [_blinkTimer release];
    [super dealloc];
}

// Helper method to set an initial blink delay
- (void)delayBlink
{
    self.hidden = NO;
    
    [_blinkTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:InitialBlinkDelay]];
}

@end

