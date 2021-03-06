//
//  DigitalDetailCell.m
//  Experts
//
//  Created by hudong yule on 15/10/30.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "DigitalDetailCell.h"

@implementation DigitalDetailCell

+(instancetype)digitalDetailCellWithTableView:(UITableView *)tableView index:(NSIndexPath *)index
{
    static NSString * digitalDetailCellId=@"digitalDetail";
    DigitalDetailCell * cell=[tableView cellForRowAtIndexPath:index];
    if (cell==nil) {
        cell=[[DigitalDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:digitalDetailCellId];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //添加cell上的子控件
        
        //双色球、大乐透
        UILabel * digitalType=[[UILabel alloc]initWithFrame:CGRectMake(15, 15, 40, 20)];
        //        digitalType.text=@"双色球";
        digitalType.font=FONTTHIRTY;
        digitalType.textColor=[UIColor blackColor];
        digitalType.alpha=0.87;
        [self addSubview:digitalType];
        self.digitalType=digitalType;
        
        //2015期
        UILabel *qiOfNumber=[[UILabel alloc]init];
        //        qiOfNumber.text=@"20152015期";
        qiOfNumber.font=FONTTWENTY_FOUR;
        qiOfNumber.textColor=[UIColor blackColor];
        qiOfNumber.alpha=0.87;
        [self addSubview:qiOfNumber];
        self.qiOfNumber=qiOfNumber;
        
        //查看方案详情按钮
        UIButton * planDetailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        planDetailBtn.frame=CGRectMake(15, CGRectGetMaxY(qiOfNumber.frame)+15, MyWidth-30, 35);
        [planDetailBtn setTitleColor:RGB(255., 255., 255.) forState:UIControlStateNormal];
        [planDetailBtn setTitleColor:RGB(255., 255., 255.) forState:UIControlStateSelected];
        [planDetailBtn setTitleColor:RGB(255., 255., 255.) forState:UIControlStateHighlighted];
        [planDetailBtn setBackgroundImage:[UIImage imageNamed:@"方案详情按钮"] forState:UIControlStateNormal];
        [planDetailBtn setBackgroundImage:[UIImage imageNamed:@"方案详情按钮"] forState:UIControlStateHighlighted];
        planDetailBtn.titleLabel.font=FONTTWENTY_EIGHT;
        planDetailBtn.tag=self.tag;
        [planDetailBtn addTarget:self action:@selector(planDetailBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:planDetailBtn];
        self.planDetailBtn=planDetailBtn;
        
        
        //不中退款背景
        UIImage* correctImage=[UIImage imageNamed:@"不中退款背景"];
        _refundImageView=[[UIImageView alloc]initWithFrame:CGRectMake(MyWidth-correctImage.size.width-15,self.qiOfNumber.frame.origin.y+20,correctImage.size.width, correctImage.size.height)];
        _refundImageView.image = correctImage;
        [self.contentView addSubview:_refundImageView];
        
        
        _refundLabel=[[UILabel alloc]initWithFrame:CGRectMake(_refundImageView.frame.origin.x+5,_refundImageView.frame.origin.y, correctImage.size.width-10,correctImage.size.height)];
        [self.contentView addSubview:_refundLabel];
        _refundLabel.text=@"不中退款";
        _refundLabel.textAlignment=NSTextAlignmentCenter;
        _refundLabel.font=FONTTWENTY_FOUR;
        _refundLabel.textColor=RGB(255.,59.,48.);
        
        
        //黑线
        UIView * Line=[[UIView alloc]initWithFrame:CGRectMake(0,97.400, MyWidth, 0.5)];
        [self addSubview:Line];
        Line.backgroundColor=[UIColor blackColor];
        Line.alpha=0.1;
    }
    return self;
}

-(void)setCellLotteryType:(NSString *)lotryTepy erIsu:(NSString *)erIsu pricePlan:(NSString *)pricePlan source:(NSInteger)source
{
    //双色球
    self.digitalType.text=lotryTepy;
    CGSize cellUIsize=[PublicMethod setNameFontSize:self.digitalType.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    self.digitalType.frame=CGRectMake(15, 15, cellUIsize.width,cellUIsize.height);
    
    //多少期
    self.qiOfNumber.text=[NSString stringWithFormat:@"%@期",erIsu];
    cellUIsize=[PublicMethod setNameFontSize:self.qiOfNumber.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.qiOfNumber.frame=CGRectMake(CGRectGetMaxX(self.digitalType.frame)+15,CGRectGetMaxY(self.digitalType.frame)-cellUIsize.height, cellUIsize.width,cellUIsize.height);
    self.qiOfNumber.adjustsFontSizeToFitWidth = YES;
    
    
    if (source==0) {
        self.refundImageView.hidden=YES;
        self.refundLabel.hidden=YES;
    }else{
        self.refundImageView.hidden=NO;
        self.refundLabel.hidden=NO;
    }
    
    
    
    NSString *depictPrcie=@"";
    if([pricePlan floatValue]==0.00){
        depictPrcie=@"查看方案详情(免费)";
    }else
        depictPrcie=[NSString stringWithFormat:@"查看方案详情(%@元)",pricePlan];
//#ifdef CRAZYSPORTS
//    int jinbibeishu = 10;//金币和钱比例
//    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"]) {
//        jinbibeishu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"] intValue];
//    }
//    depictPrcie=[NSString stringWithFormat:@"查看方案详情(%.0f金币)",[pricePlan floatValue] * jinbibeishu];
//#endif
    ;

    
    [self.planDetailBtn setTitle:depictPrcie forState:UIControlStateNormal];
    self.planDetailBtn.frame=CGRectMake(15, CGRectGetMaxY(self.digitalType.frame)+15, MyWidth-30, 35);
    
    NSLog(@"planDetailBtn高度：%f",CGRectGetMaxY(self.planDetailBtn.frame)+15);
}

/**
 *  查看方案详情按钮响应函数
 */
-(void)planDetailBtnOnClick:(UIButton *)btn
{
    [_delegate digitalDetailCellPlanDetail:btn];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    