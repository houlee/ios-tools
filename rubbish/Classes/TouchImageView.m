//
//  TouchImageView.m
//  Walker
//
//  Created by yao on 11-5-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TouchImageView.h"

@implementation TouchImageView

@synthesize imageToucheDelegate;
@synthesize ImageURL;
@synthesize shoudTellFinish;
@synthesize isSelect;

- (id)init {
	self = [super init];
	if (self) {
		
		self.userInteractionEnabled = YES;
		shoudTellFinish = NO;
//		btn = [[UIButton alloc] init];
//		[self addSubview:btn];
//		[btn addTarget:self action:@selector(clike) forControlEvents:UIControlEventTouchUpInside];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		touchOutside = YES;
		shoudTellFinish = NO;
		self.userInteractionEnabled = YES;
//		btn = [[UIButton alloc] initWithFrame:frame];
//		btn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//		[btn addTarget:self action:@selector(clike) forControlEvents:UIControlEventTouchUpInside];
//		[self addSubview:btn];
	}
	return self;
}

- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
//	btn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)clike {
	isSelect = !isSelect;
	[imageToucheDelegate touchImageView:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	touchOutside = NO;
	//UIView *v = [[UIView alloc] initWithFrame:CGRectMake(-3, -3, self.frame.size.width + 6, self.frame.size.height +6)];
	UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	v.userInteractionEnabled = NO;
	v.backgroundColor = [UIColor grayColor];
	v.alpha = 0.4;
	v.tag = 200;
	[self addSubview:v];
	[v release];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesCancelled:touches withEvent:event];
	touchOutside = YES;
	UIView *v = [self viewWithTag:200];
	[v removeFromSuperview];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint currentLocation = [touch locationInView:self];
	if (currentLocation.x > self.frame.size.width || currentLocation.x < 0 || currentLocation.y > self.frame.size.height || currentLocation.y < 0) {
		[self touchesCancelled:touches withEvent:event];
		touchOutside = YES;
	}
	else if (touchOutside == YES){
		[self touchesBegan:touches withEvent:event];
	}

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//[super touchesEnded:touches withEvent:event];
	if (!touchOutside) {
		UITouch *touch = [touches anyObject];
		UIImageView *imageView = (UIImageView *)[touch view];
		isSelect = !isSelect;
		[imageToucheDelegate touchImageView:imageView];
		UIView *v = [self viewWithTag:200];
		[v removeFromSuperview];		
	}
}

- (void)dealloc {
	[btn release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    