//
//  CropUtility.m
//  CropUtility
//
//  Created by cp on 30.08.12.
//  Copyright (c) 2012 CP CORPORATE PLANNING. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "CropUtility.h"

@interface CropUtility ()

@property (nonatomic, strong) UIButton *buttonUpperLeft;
@property (nonatomic, strong) UIButton *buttonLowerLeft;
@property (nonatomic, strong) UIButton *buttonUpperRight;
@property (nonatomic, strong) UIButton *buttonLowerRight;
@property (nonatomic, strong) CALayer *gridLayer;

@end

@implementation CropUtility

@synthesize buttonUpperLeft;
@synthesize buttonLowerLeft;
@synthesize buttonUpperRight;
@synthesize buttonLowerRight;
@synthesize gridLayer;
@synthesize isAttached = _isAttached;

- (id) init {
    self = [super init];
    if(self)
    {
        UIImage *btnImage = [UIImage imageNamed:@"Resource.bundle/bluebullet.png"];
        buttonUpperLeft = [self createButtonWithImage:btnImage];
        buttonLowerLeft = [self createButtonWithImage:btnImage];
        buttonUpperRight = [self createButtonWithImage:btnImage];
        buttonLowerRight = [self createButtonWithImage:btnImage];
        
        gridLayer = [CALayer layer];
    }
    return self;
}

- (void)attachToView:(UIView *)view  withRect:(CGRect) rectangle {
    
    buttonUpperLeft.center = CGPointMake(rectangle.origin.x,rectangle.origin.y);
    buttonLowerLeft.center = CGPointMake(rectangle.origin.x,rectangle.origin.y+rectangle.size.height);
    buttonUpperRight.center = CGPointMake(rectangle.origin.x+rectangle.size.width, rectangle.origin.y);
    buttonLowerRight.center = CGPointMake(rectangle.origin.x+rectangle.size.width, rectangle.origin.y+rectangle.size.height);
    
    gridLayer.delegate = self;
    gridLayer.frame = view.frame;
    [view.layer addSublayer:gridLayer];
    
    
    [view addSubview:buttonUpperLeft];
    [view addSubview:buttonLowerLeft];
    [view addSubview:buttonUpperRight];
    [view addSubview:buttonLowerRight];
    
    [gridLayer setNeedsDisplay];
    
    _isAttached = YES;
}

- (void)detachFromView {
    gridLayer.delegate = nil;
    [gridLayer removeFromSuperlayer];
    
    [buttonUpperLeft removeFromSuperview];
    [buttonLowerLeft removeFromSuperview];
    [buttonUpperRight removeFromSuperview];
    [buttonLowerRight removeFromSuperview];
    
    _isAttached = NO;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context
{
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, CGColorCreateCopyWithAlpha([UIColor blackColor].CGColor, 0.5));
    
    CGRect rect = [self cropRectangle];
    
    CGFloat y = rect.origin.y;
    CGFloat x = rect.origin.x;
    CGFloat w = layer.bounds.size.width;
    
    
    CGContextFillRect(context, CGRectMake(0,0, w, y));
    CGContextFillRect(context, CGRectMake(0,y+rect.size.height, w,
                                          layer.bounds.size.height-y+rect.size.height));
    
    CGContextFillRect(context, CGRectMake(0, y, x, rect.size.height));
    CGContextFillRect(context, CGRectMake(x+rect.size.width, y, layer.bounds.size.width-x+rect.size.width, rect.size.height));
    
    CGContextSetStrokeColorWithColor(context,[UIColor whiteColor].CGColor);
    CGContextStrokeRect(context, rect);
    
    CGPoint lines[4];
    
    lines[0] = CGPointMake(x + (rect.size.width/2),y );
    lines[1] = CGPointMake(x + (rect.size.width/2), y + (rect.size.height));
    
    lines[2] = CGPointMake(x, y + (rect.size.height/2));
    lines[3] = CGPointMake(x + rect.size.width, y + (rect.size.height/2));
    
    CGContextStrokeLineSegments(context, lines, 4);
    
    
    CGContextRestoreGState(context);
}

- (UIButton *)createButtonWithImage:(UIImage *)image {
    
    UIButton *result = [UIButton buttonWithType:UIButtonTypeCustom];
    result.frame = CGRectMake(0, 0, 48, 48);
    [result setImage:image forState:UIControlStateNormal];
    
    // add drag listener
    [result addTarget:self
               action:@selector(wasDragged:withEvent:)
     forControlEvents:UIControlEventTouchDragInside];
    
    return result;
}

- (void)wasDragged:(UIButton *)button withEvent:(UIEvent *)event
{
	// get the touch
	UITouch *touch = [[event touchesForView:button] anyObject];
    
	// get delta
	CGPoint previousLocation = [touch previousLocationInView:button];
	CGPoint location = [touch locationInView:button];
	CGFloat delta_x = location.x - previousLocation.x;
	CGFloat delta_y = location.y - previousLocation.y;
    
	// move button
	CGPoint nextLocation = CGPointMake(button.center.x + delta_x,
                                       button.center.y + delta_y);
    
    //NSLog(@"x=%f ; y=%f", nextLocation.x, nextLocation.y);
    if(nextLocation.x >= 5 && nextLocation.y >= 5 &&
       nextLocation.x <= button.superview.bounds.size.width - 5 &&
       nextLocation.y <= button.superview.bounds.size.height - 5)
    {
        button.center = nextLocation;
        
        if(button == self.buttonUpperLeft)
        {
            self.buttonUpperRight.center = CGPointMake(self.buttonUpperRight.center.x, self.buttonUpperRight.center.y + delta_y);
            self.buttonLowerLeft.center = CGPointMake(self.buttonLowerLeft.center.x + delta_x, self.buttonLowerLeft.center.y);
        }
        else if(button == self.buttonUpperRight)
        {
            self.buttonUpperLeft.center = CGPointMake(self.buttonUpperLeft.center.x, self.buttonUpperLeft.center.y + delta_y);
            self.buttonLowerRight.center = CGPointMake(self.buttonLowerRight.center.x + delta_x, self.buttonLowerRight.center.y);
        }
        else if(button == self.buttonLowerRight)
        {
            self.buttonLowerLeft.center = CGPointMake(self.buttonLowerLeft.center.x, self.buttonLowerLeft.center.y + delta_y);
            self.buttonUpperRight.center = CGPointMake(self.buttonUpperRight.center.x + delta_x, self.buttonUpperRight.center.y);
        }
        else if(button == self.buttonLowerLeft)
        {
            self.buttonLowerRight.center = CGPointMake(self.buttonLowerRight.center.x, self.buttonLowerRight.center.y + delta_y);
            self.buttonUpperLeft.center = CGPointMake(self.buttonUpperLeft.center.x + delta_x, self.buttonUpperLeft.center.y);
        }
        
        [gridLayer setNeedsDisplay];
    }
}

- (CGRect) cropRectangle {
    
    CGFloat left = MIN(self.buttonUpperLeft.center.x, self.buttonLowerRight.center.x);
    CGFloat right = MAX(self.buttonUpperLeft.center.x, self.buttonLowerRight.center.x);
    
    CGFloat top = MIN(self.buttonUpperLeft.center.y, self.buttonLowerRight.center.y);
    CGFloat bottom = MAX(self.buttonUpperLeft.center.y, self.buttonLowerRight.center.y);
    
    return CGRectMake(left, top, right - left, bottom - top);
}

@end
