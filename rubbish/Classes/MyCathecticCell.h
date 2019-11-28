//
//  MyCathecticCell.h
//  PKDome
//
//  Created by  on 12-4-11.
//  Copyright (c) 2012年 vodone. All rights reserved.
//***************
//我的投注的cell
//**************
#import <UIKit/UIKit.h>
#import "StatisticsData.h"
#import "ColorView.h"

typedef enum {
	PKMatchTypeRankcell,//中奖排行
	PKMatchTypeBettingRecordscell,//投注记录
	PKMatchTypeCrosscell,//过关统计
    PKMatchTypeBettingMecell
}PKMatch;

@interface MyCathecticCell : UITableViewCell{
    UILabel * timeNumLabel;//期号
    UILabel * moneyLabel;//奖金
    UILabel * numberLabel;//注数
    UILabel * rightLabel;//全对注数
    UILabel * rightFieldLabel;//正确场次
    UILabel * timeLabel;//投注时间
    ColorView * allNumLabel;//全部的数字
    UIView * view;//返回给cell的view
    StatisticsData * statisticsData;//数据的接口
    UILabel * useLabel;//用户名
    PKMatch pkmatch;
    UIImageView * line1;
    UIImageView * line2;
    UIImageView * line3;
    UIImageView * line4;
    UIImageView * line5;
    UIImageView * line6;
}

@property (nonatomic, assign)PKMatch pkmatch;
@property (nonatomic, retain)UILabel * timeNumLabel;
@property (nonatomic, retain)UILabel * moneyLabel;
@property (nonatomic, retain)UILabel * numberLabel;
@property (nonatomic, retain)UILabel * rightFieldLabel;
@property (nonatomic, retain)UILabel * rightLabel;
@property (nonatomic, retain)UILabel * timeLabel;
@property (nonatomic, retain)ColorView * allNumLabel;
@property (nonatomic, retain)UIView * view;
@property (nonatomic, retain)StatisticsData * statisticsData;
@property (nonatomic, retain)UILabel *useLabel;

- (UIView *)tabelCellView;

@end
