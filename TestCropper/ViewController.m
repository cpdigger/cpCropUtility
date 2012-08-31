//
//  ViewController.m
//  TestCropper
//
//  Created by cp on 29.08.12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "ViewController.h"

#import <CropUtility/CropUtility.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet CropUtility *tool;

@end

@implementation ViewController
@synthesize imageView;
@synthesize tool;


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setTool:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)doCrop:(id)sender {
    
    if(![tool isAttached])
    {
        [tool attachToView:self.imageView withRect:CGRectMake(100,100,50,100)];
    }
    else
    {
        CGRect rect = [tool cropRectangle];
        NSLog(@"x=%f ; y=%f; width=%f; height=%f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
        [tool detachFromView];
    }
}

@end
