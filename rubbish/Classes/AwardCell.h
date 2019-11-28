//
//  AwardCell.h
//  PKDome
//
//  Created by  on 12-4-11.
//  Copyright (c) 2012年 vodone. All rights reserved.
//
////M1中奖排行cell类
#import <UIKit/UIKit.h>
#import "AwardData.h"
#import "BudgeButton.h"
#import "DataUtils.h"
#import "ImageDownloader.h"
#import "ImageStoreReceiver.h"
#import "caiboAppDelegate.h"

@interface AwardCell : UITableViewCell{
    UIImageView * backImage;//背景图
    UIImageView * imageView;//头像
    UILabel * useLable;//用户名
    UILabel * dateLable;//开奖日期
    UILabel * moneyLable;//奖金
    UILabel * yuanLable;//固定的一个元字
    AwardData * awardData;//cell数据类接口
    NSInteger row;//行数
    NSString * imageUrl;
    ImageStoreReceiver * receiver;
}
@property (nonatomic, retain)ImageStoreReceiver * receiver;
@property (nonatomic, retain)NSString * imageUrl;
@property (nonatomic, retain)UIImageView * backImage;
@property (nonatomic)NSInteger row;
@property (nonatomic, retain)UIImageView * imageView;
@property (nonatomic, retain)UILabel * useLable;
@property (nonatomic, retain)UILabel * dateLable;
@property (nonatomic, retain)UILabel * moneyLable;
@property (nonatomic, retain)UILabel * yuanLable;
@property (nonatomic, retain)AwardData * awardData;


-(void)viewCell;

@end
