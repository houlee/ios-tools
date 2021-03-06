//
//  MagnifierView.m
//  caibo
//
//  Created by jeff.pluto on 11-6-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MagnifierView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MagnifierView

@synthesize viewToMagnify, touchPoint;

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:CGRectMake(0, 0, 60, 60)])) {
        self.backgroundColor = [UIColor clearColor];
		self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
		self.layer.borderWidth = 2;
		self.layer.cornerRadius = 30;
		self.layer.masksToBounds = YES;
	}
	return self;
}

// 设置放大镜显示的位置
- (void)setTouchPoint:(CGPoint)pt {
	touchPoint = pt;
	self.center = CGPointMake(pt.x, pt.y - 50);
}

// 画出需要放大的图像内容
- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, self.frame.size.width * 0.5, self.frame.size.height * 0.5);
	CGContextScaleCTM(context, 1.3, 1.3);// 放大１.３倍
	CGContextTranslateCTM(context, -1 * (touchPoint.x), -1 * (touchPoint.y));
	[self.viewToMagnify.layer renderInContext:context];
}

- (void)dealloc {
	[viewToMagnify release];
	[super dealloc];
}


@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    