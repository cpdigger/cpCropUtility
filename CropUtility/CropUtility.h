//
//  CropUtility.h
//  CropUtility
//
//  Created by cp on 30.08.12.
//  Copyright (c) 2012 CP CORPORATE PLANNING. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CropUtility : NSObject

- (id) init;

/*
 Attach the crop tool to the given view (normally an UIImageView)
 */
- (void)attachToView:(UIView *)view  withRect:(CGRect) rectangle;

/*
 Detach the crop tool from the previous attached view 
 */
- (void)detachFromView;

/*
    the rectangle that was selected during the crop 
 */
@property (nonatomic, readonly) CGRect cropRectangle;

/*
 check if the crop tool is currently attached
 */
@property (nonatomic, readonly) BOOL isAttached;

@end
