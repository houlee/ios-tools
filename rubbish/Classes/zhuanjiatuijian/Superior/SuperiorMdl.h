//
//  SuperiorMdl.h
//  Experts
//
//  Created by hudong yule on 15/11/10.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuperiorMdl : NSObject

@property(nonatomic,copy)NSString * mobile;
@property(nonatomic,copy)NSString * expertsName;
@property(nonatomic,copy)NSString * expertsNickName;//昵称

@property(nonatomic,copy)NSString * headPortrait;//头像
@property(nonatomic,copy)NSString * expertsIntroduction;
@property(nonatomic,assign)NSInteger source;
@property(nonatomic,assign)NSInteger free_status;

@property(nonatomic,copy)NSString * expertsStatus;
@property(nonatomic,copy)NSString * expertsCodeArray;
@property(nonatomic,copy)NSString * lottertCodeArray;

@property(nonatomic,assign)NSInteger expertsLevelValue;
@property(nonatomic,copy)NSMutableDictionary * SiperiorExpertsLeastFiveHitInfo;
@property(nonatomic,copy)NSString * CCId;
@property(nonatomic,copy)NSString * leagueNameSimply;
@property(nonatomic,copy)NSString * hostNameSimply;
@property(nonatomic,copy)NSString * hostRankNumber;
@property(nonatomic,copy)NSString * guestNameSimply;
@property(nonatomic,copy)NSString * guestRankNumber;
@property(nonatomic,copy)NSString * matchTime;
@property(nonatomic,copy)NSString * erAgintOrderId;
@property(nonatomic,assign)float price;
@property(nonatomic,assign)float discount;
@property(nonatomic,assign)float discountPrice;

@property(nonatomic,copy)NSString * isStar;//是否是明星
@property(nonatomic,copy)NSString * newstar;//转换后的专家星级
@property(nonatomic,copy)NSString * recommend_title;//
@property(nonatomic,copy)NSString * recommend_comment;//金牌点评
@property(nonatomic,copy)NSString * goldPirce;//金币
@property(nonatomic,copy)NSString * goldDiscountPrice;//折后金币

//篮球
@property(nonatomic,copy)NSString * playTypeCode;//27让分胜负; 29大小分
@property(nonatomic,copy)NSString * rqs;//让分
@property(nonatomic,copy)NSString * odds;//赔率


+(instancetype)superMdlWithDic:(NSDictionary *)dict;
-(instancetype)initWithDic:(NSDictionary *)dict;

@end

/**
 *  宁哥的竞彩模型
 */
@interface SuperiorMdlNingSMG : NSObject

@property(nonatomic,copy)NSString * HIT_NUM;//命中数
@property(nonatomic,copy)NSString * EXPERTS_NAME;//专家帐号
@property(nonatomic,copy)NSString * PRICE;//方案价格

@property(nonatomic,copy)NSString * EXPERTS_CLASS_CODE;//专家类型
@property(nonatomic,copy)NSString * STAR;//专家星级
@property(nonatomic,copy)NSString * ALL_HIT_NUM;//专家最近5次发布的方案总数

@property(nonatomic,copy)NSString * STATUS;//期次状态(0:预约,1:当前期,2:暂停,3:已结期)
@property(nonatomic,copy)NSString * HEAD_PORTRAIT;//头像
@property(nonatomic,copy)NSString * SOURCE;//来源(0:网站专家,1:用户专家,9:足球报)

@property(nonatomic,copy)NSString * ER_ISSUE;//期次号
@property(nonatomic,copy)NSString * DIS_HIT_NUM;//未命中数
@property(nonatomic,copy)NSString * EXPERTS_NICK_NAME;//专家昵称
@property(nonatomic,copy)NSString * END_TIME;//本期结束时间
@property(nonatomic,copy)NSString * IS_NEW;//是否是新的方案
@property(nonatomic,copy)NSString * DISCOUNT;//折扣
@property(nonatomic,copy)NSString * ER_AGINT_ORDER_ID;//方案号
@property(nonatomic,copy)NSString * LOTTEY_CLASS_CODE;//彩种 001双色球 002：3D,108排列三，113大乐透
@property(nonatomic,copy)NSString * RN;//行号
@property(nonatomic,copy)NSString * LEVEL_VALUE;//经验值

+(instancetype)superMdlNingSMGWithDic:(NSDictionary *)dict;
-(instancetype)initWithDic:(NSDictionary *)dict;

@end

