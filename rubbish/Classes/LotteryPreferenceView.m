//
//  LotteryPreferenceView.m
//  caibo
//
//  Created by  on 12-2-16.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "LotteryPreferenceView.h"
#import <QuartzCore/QuartzCore.h>
#import "ColorUtils.h"
@implementation LotteryPreferenceView
@synthesize nameLabel,markButton,marked,delegate,section;
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleAction:)];
        [self addGestureRecognizer:tapGesture];
        [tapGesture release];

    //    self.layer.masksToBounds = YES;
//        self.layer.cornerRadius = 5;
//        self.layer.borderWidth = 2;
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		imageView.image = [UIImageGetImageFromName(@"xihaoCell.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
		[self addSubview:imageView];
		imageView.tag =1001;
		[imageView release];
        
        CGRect labelRect = self.bounds;
        labelRect.origin.x += 20;
        labelRect.size.width -= 25;
        
        UILabel *tmpLabel = [[UILabel alloc]initWithFrame:labelRect];
        [tmpLabel setFont:[UIFont systemFontOfSize:15]];
        [tmpLabel setTextAlignment:NSTextAlignmentLeft];
        [tmpLabel setTextColor:[UIColor blackColor]];
        [tmpLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:tmpLabel];
        self.nameLabel = tmpLabel;
        [tmpLabel release];
        
        UIButton *tmpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tmpButton setFrame:CGRectMake(5, 7, 15, 15)];
        [tmpButton setImage:UIImageGetImageFromName(@"huangguan-wx.png") forState:UIControlStateNormal];
        [tmpButton setImage:UIImageGetImageFromName(@"huangguan-yx.png") forState:UIControlStateSelected];
        [self addSubview:tmpButton];
        self.markButton = tmpButton;
    }
    return self;
}
- (void)dealloc
{
    [nameLabel release];
    [markButton release];
    
    [super dealloc];
}

- (void)setMarked:(BOOL)mark {
	marked = mark;
	UIImageView *imageV = (UIImageView *)[self viewWithTag:1001];
	if (mark) {
		imageV.image = [UIImageGetImageFromName(@"xihaoXuanZhong.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
	}
	else {
		imageV.image = [UIImageGetImageFromName(@"xihaoCell.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
	}

}

- (void)toggleAction:(id)sender
{
    self.markButton.selected = !self.markButton.selected;
    if (self.markButton.selected) {
        self.marked = YES;
		
    }else
        {
        self.marked = NO;
        }
    if ([self.delegate respondsToSelector:@selector(lotteryPreferenceView:marked:title:section:)]) {
        [self.delegate lotteryPreferenceView:self marked:self.marked title:self.nameLabel.text section:self.section];
    }
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    