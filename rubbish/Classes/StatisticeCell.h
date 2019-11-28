//
//  StatisticeData.h
//  PKDome
//
//  Created by  on 12-4-11.
//  Copyright (c) 2012年 vodone. All rights reserved.
//**********************
//第 多少 期的中奖信息的cell 过关统计
//**********************
#import <UIKit/UIKit.h>

#import "StatisticeCell.h"
#import "StatisticsData.h"

@interface StatisticeCell : UITableViewCell{

    UILabel * useLabel;//用户名
    UILabel * moneyLabel;//奖金
    UILabel * numberLabel;//注数
    UILabel * rightLabel;//全对注数
    UILabel * fieldNumLabel;//场次
    UILabel * allNumLabel;//全部的数字
    UIView * cellView;//cell的view
    UIImageView * imageView;//背景图片
    StatisticsData * statisticeData;//数据接口

}

@property (nonatomic, retain)UILabel * useLabel;
@property (nonatomic, retain)UILabel * moneyLabel;
@property (nonatomic, retain)UILabel * numberLabel;
@property (nonatomic, retain)UILabel * rightLabel;
@property (nonatomic, retain)UILabel * fieldNumLabel;
@property (nonatomic, retain)UILabel * allNumLabel;
@property (nonatomic, retain)UIView * cellView;
@property (nonatomic, retain)UIImageView * imageView;
@property (nonatomic, retain)StatisticsData * statisticeData;

- (UIView *)tabelCellView;
@end
