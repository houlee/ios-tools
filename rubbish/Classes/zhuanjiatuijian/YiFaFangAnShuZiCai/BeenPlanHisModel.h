//
//  BeenPlanHisModel.h
//  Experts
//
//  Created by V1pin on 15/11/10.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeenPlanHisModel : NSObject
@property(nonatomic,strong)NSString * matchesId;//"周四005",  --场次id
@property(nonatomic,strong)NSString * matchesId2;//"周四005",  --场次id
@property(nonatomic,strong)NSString * leagueName;// "瑞典甲",--联赛名称
@property(nonatomic,strong)NSString * leagueName2;// "瑞典甲",--联赛名称
@property(nonatomic,strong)NSString * homeScore;//主队进球数
@property(nonatomic,strong)NSString * homeScore2;//主队进球数
@property(nonatomic,strong)NSString * awayScore;//,--客队进球数
@property(nonatomic,strong)NSString * awayScore2;//,--客队进球数
@property(nonatomic,strong)NSString * matchTime;//2015-11-06 00:45:00",--比赛时间
@property(nonatomic,strong)NSString * matchTime2;//2015-11-06 00:45:00",--比赛时间
@property(nonatomic,strong)NSString * hitStatus;// --方案推荐命中情况0:初始值,1:命中,2:未命中,3:取消
@property(nonatomic,strong)NSString * asian_result_status;//亚盘推荐命中情况0:初始值;1:命中;2:未命中;3:取消;4:走盘

@property(nonatomic,strong)NSString * homeName;//主队进球数
@property(nonatomic,strong)NSString * homeName2;//主队进球数
@property(nonatomic,strong)NSString * awayName;//,--客队进球数
@property(nonatomic,strong)NSString * awayName2;//,--客队进球数
@property(nonatomic,strong)NSString * erAgintOrderId; //--方案ID
@property(nonatomic,strong)NSString * asian_sp; //--方案ID

@property(nonatomic,strong)NSString * goldDiscountPrice; //折后金币
@property(nonatomic,strong)NSString * lotteryClassCode; //
@property(nonatomic,strong)NSString * FREE_STATUS; //

//篮球
@property(nonatomic,strong)NSString * playTypeCode; //27让分胜负  29大小分
@property(nonatomic,strong)NSString * rqs; //

@end
