//
//  BeenPlanSMGModel.h
//  Experts
//
//  Created by V1pin on 15/11/10.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeenPlanSMGModel : NSObject
@property(nonatomic,strong)NSString * discountPrice; //-折后价格
@property(nonatomic,strong)NSString * closeStatus; //---方案结期状态0初始状态1未结期2截止购买3已结
@property(nonatomic,strong)NSString * orderStatus; //---方案状态0初始状态1审核中2审核通过3审核未通
@property(nonatomic,strong)NSString * leagueName; //- --联赛名称
@property(nonatomic,strong)NSString * leagueName2; //- --联赛名称
@property(nonatomic,strong)NSString * matchesName; //-天狼星  VS  法尔肯堡",
@property(nonatomic,strong)NSString * matchesName2; //-天狼星  VS  法尔肯堡",
@property(nonatomic,strong)NSString * matchesId; //-周四005",--场次id
@property(nonatomic,strong)NSString * matchesId2; //-周四005",--场次id
@property(nonatomic,strong)NSString * matchTime; //-2015-11-06 00:45:00"--比赛时间
@property(nonatomic,strong)NSString * matchTime2; //-2015-11-06 00:45:00"--比赛时间
@property(nonatomic,strong)NSString * erAgintOrderId; //--方案ID

@property(nonatomic,strong)NSString * goldDiscountPrice; //折后金币
@property(nonatomic,strong)NSString * lotteryClassCode; //
@property(nonatomic,strong)NSString * FREE_STATUS; //
//篮球
@property(nonatomic,strong)NSString * playTypeCode; //27让分胜负  29大小分
@property(nonatomic,strong)NSString * rqs; //
@property(nonatomic,strong)NSString * homeName; //客队
@property(nonatomic,strong)NSString * awayName; //主队
@end
