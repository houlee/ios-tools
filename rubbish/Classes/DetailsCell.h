//
//  DetailsCell.h
//  PKDome
//
//  Created by  on 12-4-11.
//  Copyright (c) 2012年 vodone. All rights reserved.
//
//方案详情cell类
#import <UIKit/UIKit.h>
#import "DetailsData.h"

@interface DetailsCell : UITableViewCell{
    UILabel * eventLabel;//赛事
    UILabel * againstLabel;//对阵
    UILabel * resultLabel;//彩果
    UILabel * betLabel1;//投注
    UILabel * betLabel2;//投注
    UILabel * betLabel3;//投注
    UIView * view;//返回给cell的view
    DetailsData * detailsData;//cell的数据接口
}

@property (nonatomic, retain)UILabel * eventLabel;
@property (nonatomic, retain)UILabel * againstLabel;
@property (nonatomic, retain)UILabel * resultLabel;
@property (nonatomic, retain)UILabel * betLabel1;
@property (nonatomic, retain)UILabel * betLabel2;
@property (nonatomic, retain)UILabel * betLabel3;
@property (nonatomic, retain)UIView * view;
@property (nonatomic, retain)DetailsData * detailsData;

- (UIView *)tableCellView;

@end
