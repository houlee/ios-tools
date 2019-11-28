//
//  UIImageViewTap.h
//  Momento
//
//  Created by Michael Waterfall on 04/11/2009.
//  Copyright 2009 d3i. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GifView.h"

@protocol UIImageViewTapDelegate;

@interface UIImageViewTap : UIImageView {
	id <UIImageViewTapDelegate> tapDelegate;
	NSString *imageURL;
	GifView *myGifView;
	UIImage *myImage;
}
@property (nonatomic,copy)NSString *imageURL;

- (void)getImageAgain;
- (void)setImage:(UIImage *)_image;
- (void)setFrame:(CGRect)_frame;
@property (nonatomic, assign) id <UIImageViewTapDelegate> tapDelegate;
- (void)handleSingleTap:(UITouch *)touch;
- (void)handleDoubleTap:(UITouch *)touch;
- (void)handleTripleTap:(UITouch *)touch;
@end

@protocol UIImageViewTapDelegate <NSObject>
@optional
- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView tripleTapDetected:(UITouch *)touch;
@end