//
//  UIImageExtra.h
//  caibo
//
//  Created by jeff.pluto on 11-6-2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (UIImageExtra) 

- (UIImage *)rescaleImageToSize:(CGSize)size;
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;// 按照比例缩放图片

- (UIImage *)addImageReflection:(CGFloat)reflectionFraction;

+ (UIImage *) createRoundedRectImage:(UIImage*)image size:(CGSize)size;//图片切圆角

+ (CGSize)imageWithThumbnail:(UIImage *)image size:(CGSize)size;//返回缩略图的尺寸 第一个参数是原图片 第二个是要缩略的最小的宽高 如果小于指定的宽高则返回原图
- (UIImage*)scaleAndRotateImage:(float)maxResolution;//图片旋转

-(UIImage *)getWeiBoImage;//微博广场图片自适应

@end