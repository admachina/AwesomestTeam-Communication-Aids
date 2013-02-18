//
//  CalibrationViewController.m
//  Communication_Aid
//
//  Created by Victoria Lee on 12-12-22.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import "CalibrationViewController.h"

@interface CalibrationViewController ()

@end

@implementation CalibrationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;  // don't want view to autorotate
}

@end
