//
//  ExpertDetail.h
//  Experts
//
//  Created by v1pin on 15/11/13.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpertDetail : NSObject

@end

/**
 * 竞彩专家详情
 */

@interface ExpertBaseInfo : NSObject

@property(nonatomic,copy)NSString *expertsCodeArray;//专家类型
@property(nonatomic,copy)NSString *expertsIntroduction;//专家简介
@property(nonatomic,copy)NSDictionary *expertsLeastFiveHitInfo;//最近五场的命中情况
@property(nonatomic,copy)NSString *expertsLevelValue;//星级
@property(nonatomic,copy)NSString *expertsName;//专家账号
@property(nonatomic,copy)NSString *expertsNickName;//专家昵称
@property(nonatomic,copy)NSString *expertsStatus;//专家状态
@property(nonatomic,copy)NSString *headPortrait;//头像
@property(nonatomic,copy)NSString *lottertCodeArray;//能发布的彩种编码
@property(nonatomic,copy)NSString *mobile;//手机号
@property(nonatomic,copy)NSString *source;//专家来源
@property(nonatomic,assign)NSInteger focusStatus;//关注标记(1、是,0、否)
@property(nonatomic,copy)NSString *totalRecommend;
@property(nonatomic,copy)NSString *weekRate;
@property(nonatomic,copy)NSString *monthRate;
@property(nonatomic,copy)NSString *hitRateWeekRank;
@property(nonatomic,copy)NSString *hitRateMonthRank;
@property(nonatomic,copy)NSString *rewardRateWeekRank;
@property(nonatomic,copy)NSString *rewardRateMonthRank;
@property(nonatomic,copy)NSString *heatWeekRank;
@property(nonatomic,copy)NSString *heatMonthRank;
@property(nonatomic,copy)NSArray *leagueMatch;


+(instancetype)expertBaseInfoWithDic:(NSDictionary *)dict;

-(instancetype)initWithDic:(NSDictionary *)dict;


@end

@interface HistoryPlanList : NSObject

@property(nonatomic,copy)NSString *erAgintOrderId;//方案id
@property(nonatomic,copy)NSString *isHit;//推荐结果
@property(nonatomic,copy)NSString *passType;//过关方式
@property(nonatomic,copy)NSString *recommendExplain;//推荐说明
@property(nonatomic,copy)NSString *recommendTime;//方案推荐时间
@property(nonatomic,copy)NSArray *matchs;//比赛情况

+(instancetype)historyPlanListWithDic:(NSDictionary *)dict;

-(instancetype)initWithDic:(NSDictionary *)dict;


@end

@interface LeastTenInfo : NSObject

@property(nonatomic,copy)NSString *tenDishitNum;//未中数量
@property(nonatomic,copy)NSString *tenHitNum;//命中数量
@property(nonatomic,copy)NSString *tenHitRate;//命中百分比
@property(nonatomic,copy)NSString *tenTotalNum;//发布方案总数

+(instancetype)leastTenInfoWithDic:(NSDictionary *)dict;

-(instancetype)initWithDic:(NSDictionary *)dict;


@end

@interface NewPlanList : NSObject

@property(nonatomic,copy)NSString *closeStatus;//方案结期状态
@property(nonatomic,copy)NSString *closeTime;//方案结期时间
@property(nonatomic,copy)NSString *discount;//折扣
@property(nonatomic,copy)NSString *discountPrice;//折后价
@property(nonatomic,copy)NSString *erAgintOrderId;//方案id
@property(nonatomic,copy)NSString *lotteryClassCode;//彩种编码
@property(nonatomic,copy)NSArray *matchs;//
@property(nonatomic,copy)NSString *paidStatus;//支付情况
@property(nonatomic,copy)NSString *passType;//过关方式
@property(nonatomic,copy)NSString *price;//单价
@property(nonatomic,copy)NSString *recommendExplain;//推荐说明
@property(nonatomic,copy)NSString *recommendTitle;//推荐标题
@property(nonatomic,copy)NSString *userName;//登录人账号
@property(nonatomic,assign)NSInteger free_status;//是否支持不中退款

@property(nonatomic,copy)NSString *goldDiscountPrice;//折后价金币

+(instancetype)newPlanListWithDic:(NSDictionary *)dict;

-(instancetype)initWithDic:(NSDictionary *)dict;

@end

/**
 * 数字彩专家详情
 */

//双色球最新方案
@interface NewPlanListShuZiCai : NSObject

@property(nonatomic,copy)NSString *closeStatus;//方案结期状态
@property(nonatomic,copy)NSString *closeTime;//方案结期时间
@property(nonatomic,copy)NSString *discount;//折扣系数
@property(nonatomic,copy)NSString *discountPrice;//折后价格
@property(nonatomic,copy)NSString *erAgintOrderId;//方案ID
@property(nonatomic,copy)NSString *erIssue;//期次
@property(nonatomic,copy)NSString *lotteryClassCode;//彩种编码
@property(nonatomic,copy)NSString *paidStatus;//支付状态
@property(nonatomic,copy)NSString *price;//单价
@property(nonatomic,copy)NSString *recommendExplain;//方案说明
@property(nonatomic,copy)NSString *userName;//登陆人ID
@property(nonatomic,assign)NSInteger free_status;//是否支持不中退款

+(instancetype)newPlanListShuZiCaiWithDic:(NSDictionary *)dict;

-(instancetype)initWithDic:(NSDictionary *)dict;


@end

//双色球最近10场命中情况

@interface LeastTenPlanListShuangSeQiu : NSObject

@property(nonatomic,copy)NSString *erIssue;//期次
@property(nonatomic,copy)NSString *HONG_QIU_20_MA;
@property(nonatomic,copy)NSString *HONG_QIU_12_MA;
@property(nonatomic,copy)NSString *HONG_QIU_3_DAN;
@property(nonatomic,copy)NSString *HONG_QIU_DU_DAN;
@property(nonatomic,copy)NSString *HONG_QIU_SHA_6_MA;
@property(nonatomic,copy)NSString *LONG_TOU;
@property(nonatomic,copy)NSString *FENG_WEI;
@property(nonatomic,copy)NSString *LAN_QIU_3_MA;
@property(nonatomic,copy)NSString *LAN_QIU_SHA_3_MA;

+(instancetype)leastTenPlanListShuangSeQiuWithDic:(NSDictionary *)dict;

-(instancetype)initWithDic:(NSDictionary *)dict;

@end

//大乐透最近10场命中情况

@interface LeastTenPlanListDaLeTou : NSObject

@property(nonatomic,copy)NSString *erIssue;//期次
@property(nonatomic,copy)NSString *QIAN_QU_20_MA;
@property(nonatomic,copy)NSString *QIAN_QU_10_MA;
@property(nonatomic,copy)NSString *QIAN_QU_3_DAN;
@property(nonatomic,copy)NSString *QIAN_QU_DU_DAN;
@property(nonatomic,copy)NSString *QIAN_QU_SHA_6_MA;
@property(nonatomic,copy)NSString *LONG_TOU;
@property(nonatomic,copy)NSString *FENG_WEI;
@property(nonatomic,copy)NSString *HOU_QU_3_MA;
@property(nonatomic,copy)NSString *HOU_QU_SHA_6_MA;

+(instancetype)leastTenPlanListDaLeTouWithDic:(NSDictionary *)dict;

-(instancetype)initWithDic:(NSDictionary *)dict;

@end

//3D、排列三最近10场命中情况

@interface LeastTenPlanList_3D_PaiLie3 : NSObject

@property(nonatomic,copy)NSString *erIssue;//期次
@property(nonatomic,copy)NSString *DU_DAN;
@property(nonatomic,copy)NSString *SHUANG_DAN;
@property(nonatomic,copy)NSString *SAN_DAN;
@property(nonatomic,copy)NSString *SHA_1_MA;
@property(nonatomic,copy)NSString *WU_MA_ZU_XUAN;
@property(nonatomic,copy)NSString *LIU_MA_ZU_XUAN;
@property(nonatomic,copy)NSString *SAN_KUA_DU;
@property(nonatomic,copy)NSString *WU_MA_DING_WEI;
@property(nonatomic,copy)NSString *HE_ZHI;
@property(nonatomic,copy)NSString *BAO_XING;

+(instancetype)leastTenPlanList_3D_PaiLie3WithDic:(NSDictionary *)dict;

-(instancetype)initWithDic:(NSDictionary *)dict;

@end

@interface DgqOlympicMdl : NSObject

@property(nonatomic,copy)NSString *leagueName;
@property(nonatomic,copy)NSString *playInfo;
@property(nonatomic,copy)NSString *ccid;
@property(nonatomic,copy)NSString *matchTime;
@property(nonatomic,copy)NSString *playId;

+(instancetype)dgqOlympicMdlWithDic:(NSDictionary *)dict;

-(instancetype)initWithDic:(NSDictionary *)dict;

@end



