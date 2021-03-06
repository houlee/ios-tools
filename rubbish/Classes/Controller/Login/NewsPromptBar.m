//
//  NewsPromptBar.m
//  caibo
//
//  Created by Kiefer on 11-7-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NewsPromptBar.h"
#import "YDUtil.h"
#import "datafile.h"

@implementation NewsPromptBar

@synthesize textLb;

static NewsPromptBar *mNewsPromptBar;

+ (NewsPromptBar*)getInstance
{
    @synchronized(mNewsPromptBar)
    {
        if (!mNewsPromptBar) 
        {
            mNewsPromptBar = [[NewsPromptBar alloc] initWithFrame:CGRectMake(0, -100, 320, 0)];
        }
        return mNewsPromptBar;
    }
    return nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [bg setImage:UIImageGetImageFromName(@"news_bg.png")];
        [self addSubview:bg];
        [bg release];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, (44-27)/2, 35, 27)];
        [icon setImage:UIImageGetImageFromName(@"news_icon.png")];
        [self addSubview:icon];
        [icon release];
        
        textLb = [[UILabel alloc] initWithFrame:CGRectMake(55, (44-30)/2, 200, 30)];
        [textLb setBackgroundColor:[UIColor clearColor]]; 
        [textLb setFont:[UIFont systemFontOfSize:14]];
        [textLb setTextColor:[UIColor whiteColor]];
        [self addSubview:textLb];
    }
    return self;
}

- (void)showInView:(UIView*)view
{    
    mView = view;
    
    [NSTimer scheduledTimerWithTimeInterval: 1
                                     target: self
                                   selector: @selector(add)
                                   userInfo: nil
                                    repeats: NO];
}

- (void)dimissInView
{
    [NSTimer scheduledTimerWithTimeInterval: 2
                                     target: self
                                   selector: @selector(viewClose)
                                   userInfo: nil
                                    repeats: NO];
}

- (void)add
{
    [mView addSubview:mNewsPromptBar];
    
    [NSTimer scheduledTimerWithTimeInterval: 0.5
                                     target: self
                                   selector: @selector(viewOpen)
                                   userInfo: nil
                                    repeats: NO];
}

- (void)remove
{
    [mNewsPromptBar removeFromSuperview];
}

- (void)viewOpen
{
	NSString *sound =[datafile getDataByKey:KEY_SWITCH_TONE];
	
	if (!sound||[sound isEqualToString:SWITCH_TONE_ON]) {
		
		[YDUtil playSound:@"msgcome"];
	}

    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:1];
    [mNewsPromptBar setFrame:CGRectMake(0, 0, 320, 44)];
    [UIView commitAnimations];
    
   // [self dimissInView];
}

- (void)viewClose
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1];
    [mNewsPromptBar setFrame:CGRectMake(0, -100, 320, 0)];
    [UIView commitAnimations];
    
    [NSTimer scheduledTimerWithTimeInterval: 1
                                     target: self
                                   selector: @selector(remove)
                                   userInfo: nil
                                    repeats: NO];
}

- (void)dealloc
{
    [mNewsPromptBar release];
    [textLb release];
    
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    