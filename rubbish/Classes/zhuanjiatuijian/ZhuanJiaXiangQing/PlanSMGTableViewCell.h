//
//  PlanSMGTableViewCell.h
//  234567
//
//  Created by V1pin on 15/10/26.
//  Copyright © 2015年 晗晗哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanSMGTableViewCell : UITableViewCell
{
    UILabel * _dataWeek;  //--星期日期
    UIButton * _contestType;  //--比赛的类型：如 英超 意甲；
    UILabel * _contestTime;   //--开赛的时间
    UILabel * _contestName; // --比赛的队名
    UIImageView * _statusImg; // 推荐是否中
    
    UILabel * _contestStatus; // -- 比赛状态
    UILabel * _contestPrice;  // -- 比赛的价格
}

//已发方案（最新推荐）
-(void)dataWeek:(NSString *)dataWeek contestType:(NSString *)contestType contestTime:(NSString *)contestTime contestName:(NSString *)contestName statusImg:(NSString *)statusImg;

//已发方案（历史战绩）
-(void)dataWeek:(NSString *)dataWeek contestType:(NSString *)contestType contestTime:(NSString *)contestTime contestName:(NSString *)contestName contestStatus:(NSString *)contestStatus contestPrice:(NSString *)contestPrice;

@end
