//
//  ExpertMainListModel.h
//  caibo
//
//  Created by cp365dev6 on 2016/11/25.
//
//

#import <Foundation/Foundation.h>

@interface ExpertMainListModel : NSObject

//pageInfo
@property(nonatomic,copy)NSString * startRow;//
@property(nonatomic,copy)NSString * pageSize;//
@property(nonatomic,copy)NSString * nowPage;//
@property(nonatomic,copy)NSString * totalPage;//
@property(nonatomic,copy)NSString * totalCount;//

//data
@property(nonatomic,copy)NSString * HIT_NUM;//命中数
@property(nonatomic,copy)NSString * EXPERTS_NAME;//专家账号
@property(nonatomic,assign)float PRICE;//方案价格
@property(nonatomic,copy)NSString * EXPERTS_CLASS_CODE;//专家类型
@property(nonatomic,copy)NSString * HEAD_PORTRAIT;//头像
@property(nonatomic,assign)NSInteger SOURCE;//来源
@property(nonatomic,copy)NSString * ER_ISSUE;//期次号
@property(nonatomic,copy)NSString * DIS_HIT_NUM;//未命中数
@property(nonatomic,copy)NSString * EXPERTS_NICK_NAME;//专家昵称
@property(nonatomic,assign)float DISCOUNT;//折扣
@property(nonatomic,copy)NSString * ER_AGINT_ORDER_ID;//方案号
@property(nonatomic,assign)NSInteger FREE_STATUS;//是否参加不中退款  0 不参加不中退款 1 参加不中退款
@property(nonatomic,copy)NSString * LOTTEY_CLASS_CODE;//彩种  001双色球 002：3D,108排列三，113大乐透
@property(nonatomic,copy)NSString * ISSTAR;//是否是明星专家 0： 不是  1： 是
@property(nonatomic,copy)NSString * STAR;//专家星级
@property(nonatomic,copy)NSString * NEW_STAR;//转换后的专家星级
@property(nonatomic,copy)NSString * PLAY_ID1;//赛程编号
@property(nonatomic,copy)NSString * HOME_NAME1;//主队名称
@property(nonatomic,copy)NSString * AWAY_NAME1;//客队名称
@property(nonatomic,copy)NSString * MATCH_TIME1;//比赛时间
@property(nonatomic,copy)NSString * MATCH_DATE1;//比赛日期
@property(nonatomic,copy)NSString * MATCH_STATUS1;//比赛状态(0:未开,1:上半场,2:中场,3:下半场,4,加时,-11:待定,-12:腰斩,-13:中断,-14:推迟,-1:完场,-10取消)
@property(nonatomic,copy)NSString * MATCHES_ID1;//场次编号
@property(nonatomic,copy)NSString * LEAGUE_NAME1;//赛事名称
@property(nonatomic,copy)NSString * PLAY_ID2;//赛程编号
@property(nonatomic,copy)NSString * HOME_NAME2;//主队名称
@property(nonatomic,copy)NSString * AWAY_NAME2;//客队名称
@property(nonatomic,copy)NSString * MATCH_TIME2;//比赛时间
@property(nonatomic,copy)NSString * MATCH_DATE2;//比赛日期
@property(nonatomic,copy)NSString * MATCH_STATUS2;//比赛状态(0:未开,1:上半场,2:中场,3:下半场,4,加时,-11:待定,-12:腰斩,-13:中断,-14:推迟,-1:完场,-10取消)
@property(nonatomic,copy)NSString * MATCHES_ID2;//场次编号
@property(nonatomic,copy)NSString * LEAGUE_NAME2;//赛事名称

@property(nonatomic,copy)NSString * MATCH_DATA_TIME1;//比赛时间  1-1 1:1
@property(nonatomic,copy)NSString * MATCH_DATA_TIME2;//比赛时间  1-1 1:1

@property(nonatomic,copy)NSString * GOLDDISCOUNTPRICE;//金币折后价格
@property(nonatomic,copy)NSString * GOLDPIRCE;//金币价格
@property(nonatomic,copy)NSString * ALL_HIT_NUM;//专家最近5次发布的方案总数
@property(nonatomic,copy)NSString * RANKRATE;//命中率


@property(nonatomic,copy)NSString * RECOMMEND_COMMENT;//金牌点评
@property(nonatomic,copy)NSString * RECOMMEND_TITLE;//推荐标题

@property(nonatomic,copy)NSString * recommendComment;//推荐评语




@property(nonatomic,copy)NSString * CLOSE_TIME;//
@property(nonatomic,assign)float  DISCOUNTPRICE;//折后价格

@property(nonatomic,copy)NSString * IS_NEW;//是否是新方案
@property(nonatomic,copy)NSString * LEVEL_VALUE;//等级   经验值
@property(nonatomic,copy)NSString * RECOMMEND_EXPLAIN;//
@property(nonatomic,copy)NSString * RN;//


//@property(nonatomic,copy)NSString * ISBANGDAN;//是否是榜单  自己加的

+(instancetype)expertListWithDic:(NSDictionary *)dict;

-(instancetype)initWithDic:(NSDictionary *)dict;

@end
