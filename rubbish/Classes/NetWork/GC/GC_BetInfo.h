//
//  BetInfo.h
//  Lottery
//
//  Created by Teng Kiefer on 12-2-16.
//  Copyright (c) 2012年 windo-soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GC_LotteryType.h"

//0:公开,1:保密,2:截止后公开,3:仅对跟单者公开，4:隐藏
//修改时sharedMethod里也要改
typedef enum {
	BaoMiTypeGongKai,
	BaoMiTypeBaoMi,
	BaoMiTypeJieZhi,
    BaoMiTypeGenDan,
    BaoMiTypeYinShen
}BaoMiType;

@interface GC_BetInfo : NSObject
{
    LotteryTYPE lotteryType; //彩种
	BaoMiType baomiType;
    NSString *lotteryId; //彩种编号
    NSString *issue; //期号
    ModeTYPE modeType; //玩法
    NSString *betNumber; //投注号码
    int bets; //注数
    int price; //方案金额（单倍）
    short multiple; //投注倍数
    int totalParts; //总份数
    int rengouParts; //认购份数
    int baodiParts; //保底份数
    int tichengPercentage; //提成比例	
    int secrecyType; //保密类型
    NSString *endTime; //方案截止日期
    NSString *schemeTitle; //方案标题
    NSString *schemeDescription; //方案描述
    
    int prices; //方案金额
    int zhuihaoType; //是否追停
    int payMoney; //支付金额
    NSMutableArray *betlist; //追号列表
    NSString * caizhong;//彩种
    NSString * wanfa;//玩法
    NSString * stopMoney;//中奖多少金额后停追
    short beishu;//倍数 新
    NSString * lastMatch;//最后一场 场号
}

//- (GC_BetInfo *)copySelf;

@property (nonatomic)short beishu,multiple;
@property (nonatomic, copy)NSString * stopMoney;
@property (nonatomic, copy)NSString * caizhong, *wanfa;
@property (nonatomic, copy) NSString *lotteryId, *issue, *betNumber, *endTime, *schemeTitle, *schemeDescription;
@property (nonatomic, assign) LotteryTYPE lotteryType;
@property (nonatomic, assign) ModeTYPE modeType;
@property (nonatomic, assign) BaoMiType baomiType;
@property (nonatomic, assign) int prices, zhuihaoType, payMoney;
@property (nonatomic, retain) NSMutableArray *betlist;
@property (nonatomic, assign) int bets, price, totalParts, rengouParts, baodiParts, tichengPercentage, secrecyType;
@property (nonatomic, retain)NSString * lastMatch;
@end
