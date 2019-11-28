//
//  BeenPlanNumModel.h
//  Experts
//
//  Created by V1pin on 15/11/10.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeenPlanNumModel : NSObject

@property(nonatomic,strong)NSString * lotteryClassCode;//--彩种
@property(nonatomic,strong)NSString * erIssue;// "--期数
@property(nonatomic,strong)NSString * createTime;//--创建时间
@property(nonatomic,strong)NSString * orderStatus;//,--方案状态0初始状态1审核中2审核通过3审核未通
@property(nonatomic,strong)NSString * closeStatus;//--方案结期状态0初始状态1未结期2截止购买3已结
@property(nonatomic,strong)NSString * hitStatus;// --方案推荐命中情况0:初始值,1:命中,2:未命中,3:取消

@property(nonatomic,strong)NSString * price;//-单价
@property(nonatomic,strong)NSString * discount;//,-折扣
@property(nonatomic,strong)NSString * erAgintOrderId; //--方案ID


@end
