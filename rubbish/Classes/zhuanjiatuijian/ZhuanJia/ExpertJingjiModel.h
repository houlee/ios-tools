//
//  ExpertJingjiModel.h
//  Experts
//
//  Created by v1pin on 15/11/11.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpertJingjiModel : NSObject

@property(nonatomic,copy)NSString * ALL_HIT_NUM;//专家最近5次发布的方案总数
@property(nonatomic,copy)NSString * AWAY_NAME;//客队名称
@property(nonatomic,copy)NSString * DIS_HIT_NUM;//未命中数
@property(nonatomic,copy)NSString * ER_AGINT_ORDER_ID;//方案号
@property(nonatomic,copy)NSString * ER_ISSUE;//期次号
@property(nonatomic,copy)NSString * EXPERTS_CLASS_CODE;//专家类型
@property(nonatomic,copy)NSString * EXPERTS_NAME;//专家账号
@property(nonatomic,copy)NSString * EXPERTS_NICK_NAME;//专家昵称
@property(nonatomic,assign)NSInteger FREE_STATUS;//是否参加不中退款
@property(nonatomic,copy)NSString * HEAD_PORTRAIT;//头像
@property(nonatomic,copy)NSString * HIT_NUM;//命中数
@property(nonatomic,copy)NSString * HOME_NAME;//主队名称
@property(nonatomic,copy)NSString * IS_NEW;//是否有新的方案
@property(nonatomic,copy)NSString * LEAGUE_NAME;//赛事名称
@property(nonatomic,copy)NSString * LEVEL_VALUE;//经验值
@property(nonatomic,copy)NSString * LOTTEY_CLASS_CODE;//彩种
@property(nonatomic,copy)NSString * MATCHES_ID;//场次编号
@property(nonatomic,copy)NSString * MATCH_STATUS;//比赛状态
@property(nonatomic,copy)NSString * MATCH_TIME;//比赛时间
@property(nonatomic,copy)NSString * PLAY_ID;//赛程编号
@property(nonatomic,assign)float PRICE;//方案价格
@property(nonatomic,assign)NSInteger SOURCE;//来源
@property(nonatomic,assign)NSInteger STAR;//专家星级
@property(nonatomic,assign)float DISCOUNT;//折扣

//二串一
@property(nonatomic,copy)NSString * PLAY_ID2;//赛程编号
@property(nonatomic,copy)NSString * HOME_NAME2;//主队名称
@property(nonatomic,copy)NSString * AWAY_NAME2;//客队名称
@property(nonatomic,copy)NSString * MATCH_TIME2;//比赛时间
@property(nonatomic,copy)NSString * MATCH_STATUS2;//比赛状态(0:未开,1:上半场,2:中场,3:下半场,4,加时,-11:待定,-12:腰斩,-13:中断,-14:推迟,-1:完场,-10取消)
@property(nonatomic,copy)NSString * MATCHES_ID2;//场次编号
@property(nonatomic,copy)NSString * LEAGUE_NAME2;//赛事名称

@property(nonatomic,copy)NSString * MATCH_DATE2;//比赛日期
@property(nonatomic,copy)NSString * MATCH_DATA_TIME2;//比赛时间  1-1 1:1
//
//篮球
@property(nonatomic,copy)NSString * PLAY_TYPE_CODE;//27让分胜负  29大小分
@property(nonatomic,copy)NSString * HOSTRQ;//
@property(nonatomic,assign)CGFloat  GOLDDISCOUNTPRICE;//金币  这是约彩的接口   疯狂体育的篮球走的这个接口getMasterPlanList


//数字彩
@property(nonatomic,copy)NSString * END_TIME;//本期结束时间
@property(nonatomic,assign)NSInteger STATUS;//期次状态

//搜索页面--专家
@property(nonatomic,copy)NSString * EXPERTS_INTRODUCTION;//专家描述
@property(nonatomic,copy)NSString * EXPERTS_STATUS;//专家状态
@property(nonatomic,copy)NSString * MOBILE;//电话
@property(nonatomic,copy)NSString * REAL_NAME;//真实姓名
@property(nonatomic,copy)NSString * RN;//行号
@property(nonatomic,copy)NSString * SOURCE_EXPERTS_ID;//专家编号
@property(nonatomic,copy)NSString * USER_IDCARD;//身份证号

//专家定制
@property(nonatomic,assign)NSInteger HAS_FOCUS;

//首页关注专家
@property(nonatomic,assign)NSInteger NEW_RECOMMEND_NUM;//新推荐方案数
@property(nonatomic,copy)NSString * EXPERTS_CODE_ARRAY;//专家类型

@property(nonatomic,copy)NSString * MATCH_DATE;//比赛时间

//好多资深专家
@property(nonatomic,copy)NSString * labelName;//TV名嘴
@property(nonatomic,copy)NSString * labelPic;//TV名嘴标识图片
@property(nonatomic,copy)NSString * expertsName;//专家账号923063250
@property(nonatomic,copy)NSString * expertsNickName;//专家昵称
@property(nonatomic,copy)NSString * headPortrait;//专家头像地址
@property(nonatomic,copy)NSString * expertsClassCode;//专家类型@"001"
@property(nonatomic,copy)NSString * lotteryClassCode;//"-201",--彩种(单关-201，亚盘202 数字彩目前部分采种是传空)
@property(nonatomic,copy)NSString * totalNum;//近20场
@property(nonatomic,copy)NSString * hitNum;// 命中15场

+(instancetype)expertJingjiWithDic:(NSDictionary *)dict;

-(instancetype)initWithDic:(NSDictionary *)dict;

@end
