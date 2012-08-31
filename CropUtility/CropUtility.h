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
- (void)attachToView:(UIView *)view  withRect:(CGRect) rectangle;
- (void)detachFromView;

@property (nonatomic, readonly) CGRect cropRectangle;
@property (nonatomic, readonly) BOOL isAttached;

@end
