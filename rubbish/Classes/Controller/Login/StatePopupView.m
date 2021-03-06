//
//  StatePopupView.m
//  caibo
//
//  Created by Kiefer on 11-6-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "StatePopupView.h"
#import <QuartzCore/QuartzCore.h>
#import "caiboAppDelegate.h"

@implementation StatePopupView

static StatePopupView *mStatePV = nil;

+ (StatePopupView*)getInstance
{
    @synchronized(mStatePV)
    {
        if (!mStatePV) 
        {
            mStatePV = [[self alloc] init];
        }
        return mStatePV;
    }
    return nil;
}

// 视图初始化
- (id)init
{
    self = [super init];
    if (self) 
    {
        CGRect mainSF = [[UIScreen mainScreen] applicationFrame];
        [self setFrame:mainSF];
     
        [self setBackgroundColor:[UIColor clearColor]];
        
        CGPoint cp = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        UIView *view = [[UIView alloc] init];
        [view setBounds:CGRectMake(0, 0, mainSF.size.width/2, 160)];
        [view setCenter:cp];
        [view.layer setMasksToBounds:YES]; // 设置圆角边框
        [view.layer setCornerRadius:5];
        [view.layer setBorderWidth:1.5];
        [view.layer setBorderColor:[UIColor grayColor].CGColor];
        [view setBackgroundColor:[UIColor blackColor]];
        [view setAlpha:0.4];
        [self addSubview:view];
        [view release];
        
        progressIV = [[UIActivityIndicatorView alloc] init];
        [progressIV setBounds:CGRectMake(0, 0, 32, 32)];
        [progressIV setCenter:CGPointMake(self.frame.size.width/2, cp.y - 30)];
        [progressIV setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
        [progressIV startAnimating];
        [self addSubview:progressIV];
        [progressIV release];
        
        lbText = [[UILabel alloc] init];
        [lbText setBounds:CGRectMake(0, 0, 140, 30)];
        [lbText setCenter:CGPointMake(self.bounds.size.width/2, cp.y + 30)];
        [lbText setBackgroundColor:[UIColor clearColor]];
        [lbText setFont:[UIFont systemFontOfSize:16]];
        [lbText setTextColor:[UIColor whiteColor]];
        [lbText setTextAlignment:(NSTextAlignmentCenter)];
        [self addSubview:lbText];
        [lbText release];
    }
    return self;
}

// 弹出状态框显示
- (void)showInView:(UIView*)view Text:(NSString*)text
{
    [lbText setText:text];
    [view addSubview:mStatePV];
}

// 弹出状态框消失
- (void)dismiss
{
    [mStatePV removeFromSuperview];
}

// 内存释放
- (void)dealloc
{
    mStatePV = nil;
    
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    