//
//  ExpCusView.m
//  Experts
//
//  Created by v1pin on 15/10/30.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "ExpCusView.h"

@implementation ExpCusView

- (void)creatView{
    _potratView=[[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-20, 16, 40, 40)];
    _potratView.clipsToBounds=YES;
    _potratView.layer.masksToBounds=YES;
    _potratView.layer.cornerRadius=20;
    _potratView.tag=self.tag;
//    _potratView.contentMode=UIViewContentModeScaleAspectFill;
    [self addSubview:_potratView];
    
    _charatLab =[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_potratView.frame)+14, self.frame.size.width, 20)];
    _charatLab.textAlignment=NSTextAlignmentCenter;
    _charatLab.textColor=[UIColor blackColor];
    _charatLab.font=[UIFont systemFontOfSize:11.5];
    _charatLab.tag=self.tag;
    [self addSubview:_charatLab];
    
    _markView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_potratView.frame)+24, CGRectGetMinY(_potratView.frame)+24, 16, 16)];
    _markView.layer.borderColor=[[UIColor clearColor] CGColor];
    _markView.layer.cornerRadius=8;
    _markView.layer.masksToBounds=YES;
    _markView.layer.borderWidth=1.0f;
    _markView.image=[UIImage imageNamed:@"V_red"];
    _markView.contentMode=UIViewContentModeScaleAspectFill;
    _markView.hidden=YES;
    [self addSubview:_markView];
    
//    UIImageView *markView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_potratView.frame)+24, CGRectGetMinY(_potratView.frame)+24, 16, 16)];
//    markView.layer.cornerRadius=5;
//    markView.layer.masksToBounds=YES;
//    markView.image=[UIImage imageNamed:@"V_red"];
//    [self addSubview:markView];
//    _markImgView=markView;
    
    
    UIView *sepHorizon=[[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height)];
    sepHorizon.backgroundColor=SEPARATORCOLOR;
    [self addSubview:sepHorizon];
    
    UIView *sepVertical=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width-1, 0.5)];
    sepVertical.backgroundColor=SEPARATORCOLOR;
    [self addSubview:sepVertical];
    
}
- (void)setPortImg:(NSString *)img charaName:(NSString *)name hasFocus:(NSInteger)hasFocus{
    NSURL *url=[NSURL URLWithString:img];
    [_potratView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageContinueInBackground|SDWebImageRetryFailed];
    _charatLab.text=name;
    if (hasFocus==0) {
        _markView.hidden=NO;
    }else if(hasFocus==1){
        _markView.hidden=YES;
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    