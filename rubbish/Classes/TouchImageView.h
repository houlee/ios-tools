//
//  TouchImageView.h
//  Walker
//
//  Created by yao on 11-5-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol imageTouchDelegate

@optional

- (void)touchImageView:(UIImageView *)_imageView;//点击图片
@end

@interface TouchImageView : UIImageView {
	id imageToucheDelegate;
	UIButton *btn;
	BOOL touchOutside;
	NSString *ImageURL;
	BOOL shoudTellFinish;
	BOOL isSelect;
}

- (id)init;
- (id)initWithFrame:(CGRect)frame ;

@property (nonatomic,assign)id<imageTouchDelegate> imageToucheDelegate;
@property (nonatomic,copy)NSString *ImageURL;
@property (nonatomic)BOOL shoudTellFinish;
@property (nonatomic)BOOL isSelect;

@end
