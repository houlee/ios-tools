//
//  MyConcernM.h
//  caibo
//
//  Created by zhoujunwang on 16/1/20.
//
//

#import <Foundation/Foundation.h>

@interface MyConcernM : NSObject

+(instancetype)MyConcernMWithDic:(NSDictionary *)dict;
-(instancetype)initWithDic:(NSDictionary *)dict;


@property(nonatomic,copy)NSString * HIT_NUM;//
@property(nonatomic,copy)NSString * EXPERTS_NAME;//
@property(nonatomic,assign)float PRICE;//
@property(nonatomic,copy)NSString * EXPERTS_CLASS_CODE;//
@property(nonatomic,assign)NSInteger STAR;//
@property(nonatomic,copy)NSString * ALL_HIT_NUM;//
@property(nonatomic,copy)NSString * STATUS;//
@property(nonatomic,copy)NSString * HEAD_PORTRAIT;//
@property(nonatomic,assign)NSInteger SOURCE;//
@property(nonatomic,copy)NSString * ER_ISSUE;//
@property(nonatomic,copy)NSString * DIS_HIT_NUM;//
@property(nonatomic,copy)NSString * EXPERTS_NICK_NAME;//
@property(nonatomic,copy)NSString * END_TIME;//
@property(nonatomic,copy)NSString * IS_NEW;//
@property(nonatomic,assign)float DISCOUNT;//
@property(nonatomic,copy)NSString * ER_AGINT_ORDER_ID;//
@property(nonatomic,copy)NSString * LOTTEY_CLASS_CODE;//
@property(nonatomic,copy)NSString * LEVEL_VALUE;//
@property(nonatomic,copy)NSString * PLAY_ID;//
@property(nonatomic,copy)NSString * HOME_NAME;//
@property(nonatomic,copy)NSString * AWAY_NAME;//
@property(nonatomic,copy)NSString * MATCH_TIME;//
@property(nonatomic,copy)NSString * MATCH_STATUS;//
@property(nonatomic,copy)NSString * MATCHES_ID;//
@property(nonatomic,copy)NSString * LEAGUE_NAME;//
@property(nonatomic,assign)NSInteger FREE_STATUS;//

//篮球
@property(nonatomic,copy)NSString * PLAY_TYPE_CODE;//
@property(nonatomic,copy)NSString * HOSTRQ;//

//2串1
@property(nonatomic,copy)NSString * PLAY_ID2;//赛程编号
@property(nonatomic,copy)NSString * HOME_NAME2;//主队名称
@property(nonatomic,copy)NSString * AWAY_NAME2;//客队名称
@property(nonatomic,copy)NSString * MATCH_TIME2;//比赛时间
@property(nonatomic,copy)NSString * MATCH_STATUS2;//比赛状态(0:未开,1:上半场,2:中场,3:下半场,4,加时,-11:待定,-12:腰斩,-13:中断,-14:推迟,-1:完场,-10取消)
@property(nonatomic,copy)NSString * MATCHES_ID2;//场次编号
@property(nonatomic,copy)NSString * LEAGUE_NAME2;//赛事名称

@property(nonatomic,copy)NSString * MATCH_DATE2;//比赛日期
@property(nonatomic,copy)NSString * MATCH_DATA_TIME2;//比赛时间  1-1 1:1


@end
