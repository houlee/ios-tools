//
//  HeaderLabel.m
//  LabelTest
//
//  Created by cp365dev on 14-5-6.
//  Copyright (c) 2014年 cp365dev. All rights reserved.
//

#import "HeaderLabel.h"

@implementation HeaderLabel
@synthesize Horizontal;

- (id)initWithFrame:(CGRect)frame andLabel1Text:(NSString *)text1 andLabelWed:(int)onwFrame andLabel2Text:(NSString *)text2 andLabel2Wed:(int)twoFrame andLabelText3:(NSString *)text3 andLabel3Wed:(int)thrFrame andLaelText4:(NSString *)texr4 andLabel4Frame:(int)fouFrame isJiangJiDouble:(BOOL)isDouble

{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
//        int geshu = 3;
//        if(texr4)
//            geshu = 4;
        UILabel *jiangji = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, onwFrame,frame.size.height)];
        jiangji.backgroundColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
        jiangji.text = [NSString stringWithString:text1];
        jiangji.lineBreakMode = NSLineBreakByWordWrapping;
        jiangji.numberOfLines = 0;
        jiangji.textColor = [UIColor whiteColor];
        jiangji.font = [UIFont boldSystemFontOfSize:13];
        jiangji.textAlignment = NSTextAlignmentCenter;
        [self addSubview:jiangji];
        [jiangji release];
        
        UILabel *tiaojian = [[UILabel alloc] initWithFrame:CGRectMake(jiangji.frame.origin.x+jiangji.frame.size.width, 0, twoFrame, frame.size.height)];
        // tiaojian.backgroundColor = [UIColor colorWithRed:13.0/255.0 green:160.0/255.0 blue:197.0/255.0 alpha:1];
        tiaojian.backgroundColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
        tiaojian.text = [NSString stringWithString:text2];
        tiaojian.textColor = [UIColor whiteColor];
        tiaojian.font = [UIFont boldSystemFontOfSize:13];
        tiaojian.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tiaojian];
        [tiaojian release];
        
        UILabel *shuoming = [[UILabel alloc] initWithFrame:CGRectMake(tiaojian.frame.origin.x+tiaojian.frame.size.width, 0, thrFrame, frame.size.height)];
        // shuoming.backgroundColor = [UIColor colorWithRed:13.0/255.0 green:160.0/255.0 blue:197.0/255.0 alpha:1];
        shuoming.backgroundColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
        shuoming.text = [NSString stringWithString:text3];
        shuoming.textColor = [UIColor whiteColor];
        shuoming.font = [UIFont boldSystemFontOfSize:13];
        shuoming.textAlignment = NSTextAlignmentCenter;
        [self addSubview:shuoming];
        [shuoming release];
        
        if(texr4)
        {
            UILabel *jiangjin = [[UILabel alloc] initWithFrame:CGRectMake(shuoming.frame.origin.x+shuoming.frame.size.width, 0, fouFrame, frame.size.height)];
            jiangjin.backgroundColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
            jiangjin.text = [NSString stringWithString:texr4];
            jiangjin.textColor = [UIColor whiteColor];
            jiangjin.font = [UIFont boldSystemFontOfSize:13];
            jiangjin.textAlignment = NSTextAlignmentCenter;
            [self addSubview:jiangjin];
            [jiangjin release];
        }

    }
    
    
    return self;
}
//-(void)addView
//{
//    UILabel *jiangji = [[UILabel alloc] initWithFrame:CGRectMake(12, 20, 296/4, 30)];
//    jiangji.backgroundColor = [UIColor colorWithRed:13.0/255.0 green:160.0/255.0 blue:197.0/255.0 alpha:1];
//    jiangji.text = @"奖级";
//    [self addSubview:jiangji];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    