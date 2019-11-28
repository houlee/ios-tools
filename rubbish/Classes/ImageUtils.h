//
//  ImageUtils.h
//  caibo
//
//  Created by jeff.pluto on 11-7-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageExtra.h"

@interface UIImage (UIImageUtils)
- (UIImage*)scaleAndRotateImage:(float)maxResolution;
// Convolution Oprations
- (UIImage *)gaussianBlur;
@end