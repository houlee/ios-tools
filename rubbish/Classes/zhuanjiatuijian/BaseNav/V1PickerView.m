//
//  V1PickerView.m
//
//  Created by v1pin on 15/5/28.
//  Copyright (c) 2015年 v1. All rights reserved.
//

#import "V1PickerView.h"
#import "SharedMethod.h"

@implementation V1PickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        
        _titLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, MyWidth, 50)];
        _titLab.text=@"";
        _titLab.textColor=V2FONTLACK_COLOR;
        _titLab.textAlignment=NSTextAlignmentCenter;
        _titLab.font=FONTTHITY_EITBLOD;
        _titLab.textAlignment=NSTextAlignmentCenter;
        _titLab.backgroundColor = [UIColor colorWithRed:0.1 green:0.64 blue:1 alpha:1];
#ifdef CRAZYSPORTS
        _titLab.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
#endif
        [self addSubview:_titLab];
        
        UILabel *cancelLab=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
        cancelLab.text=@"取消";
        cancelLab.textColor=[UIColor whiteColor];
        cancelLab.font=FONTTHITY_EIT;
        cancelLab.textAlignment=NSTextAlignmentCenter;
        cancelLab.adjustsFontSizeToFitWidth=YES;
        cancelLab.backgroundColor=[UIColor clearColor];
        [self addSubview:cancelLab];
        
        UITapGestureRecognizer *cancelTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel:)];
        cancelLab.userInteractionEnabled=YES;
        [cancelLab addGestureRecognizer:cancelTap];
        
        UILabel *sureLab=[[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-70, 10, 60, 30)];
        sureLab.text=@"确定";
        sureLab.textAlignment=NSTextAlignmentCenter;
        sureLab.textColor=[UIColor whiteColor];
        sureLab.font=FONTTHITY_EIT;
        [self addSubview:sureLab];
        sureLab.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *sureTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sure:)];
        sureLab.userInteractionEnabled=YES;
        [sureLab addGestureRecognizer:sureTap];
        
        _pickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, MyWidth, self.frame.size.height-50)];
        [self addSubview:_pickerView];
    }
    return self;
}

- (void)cancel:(id)sender{
    if(!self.selectedWithSure){
        [UIView animateWithDuration:0.5 animations:^{
            [self setFrame:CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, 0)];
            [self removeFromSuperview];
        }];
    }
    [_delegate cancle:sender];
}

- (void)sure:(id)sender{
    
    
    if(self.selectedWithSure){
        self.selectedWithSure(@"");
    }
    [_delegate sure:sender];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    