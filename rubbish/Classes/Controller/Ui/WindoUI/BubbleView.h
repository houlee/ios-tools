//
//  BubbleView.h
//  caibo
//
//  Created by jeff.pluto on 11-8-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BubbleView : UIView {
	NSUInteger direction;
	UIView *contentView;
    
    int kRadius; // 圆角
    int kAngle;  // 箭头
    int kSpace;  // 箭头所指方向到屏幕的距离
}

@property(nonatomic, assign) NSUInteger direction;
@property(nonatomic, retain) UIView *contentView;

- (void) addContentView:(CGRect)frame;
- (void) setSpace : (int) space;

@end