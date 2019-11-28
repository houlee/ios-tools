//
//  MatchVCModel.h
//  Experts
//
//  Created by hudong yule on 15/11/9.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchVCModel : NSObject


//@property(nonatomic,copy)NSString * methodName;//方法名
//@property(nonatomic,copy)NSString * serviceName;//服务名称
//@property(nonatomic,copy)NSString * resultCode;//结果代码
//@property(nonatomic,copy)NSString * resultDesc;//结果描述


+(instancetype)MatchVCModelWithDic:(NSDictionary *)dict;
-(instancetype)initWithDic:(NSDictionary *)dict;

@property(nonatomic,copy)NSString * asian_sp;//亚盘胜负赔率
@property(nonatomic,copy)NSString * ccId;
@property(nonatomic,copy)NSString * guestNameSimply;//客队名称
@property(nonatomic,copy)NSString * guestRankNumber;//客队排名
@property(nonatomic,copy)NSString * hostNameSimply;//主队名称
@property(nonatomic,copy)NSString * hostRankNumber;//主队排名
@property(nonatomic,copy)NSString * leagueId;//
@property(nonatomic,copy)NSString * leagueNameSimply;//联赛名称
@property(nonatomic,copy)NSString * matchId;
@property(nonatomic,copy)NSString * matchStatus;//
@property(nonatomic,copy)NSString * matchDate;//赛事时间
@property(nonatomic,copy)NSString * matchTime;//比赛时间
@property(nonatomic,copy)NSString * planCount;//方案总数
@property(nonatomic,copy)NSString * playId;//比赛id
@property(nonatomic,copy)NSString * rangQiu;//
@property(nonatomic,copy)NSString * rangQiuSp;//
@property(nonatomic,copy)NSString * rq;//
@property(nonatomic,assign)NSInteger shengPingFu;//
@property(nonatomic,copy)NSString * source;//
@property(nonatomic,copy)NSString * spfSp;//

@end

@interface MatchDetailVCMdl : NSObject

+(instancetype)MatchDetialMdlWithDic:(NSDictionary *)dict;
-(instancetype)initWithDic:(NSDictionary *)dict;

@property(nonatomic,copy)NSString * CCId;
@property(nonatomic,copy)NSString * guestNameSimply;//客队名称
@property(nonatomic,copy)NSString * guestRankNumber;//客队排名
@property(nonatomic,copy)NSString * hostNameSimply;//主队名称
@property(nonatomic,copy)NSString * hostRankNumber;//主队排名
@property(nonatomic,copy)NSString * infoSource;
@property(nonatomic,copy)NSString * leagueNameSimply;//联赛名称
@property(nonatomic,copy)NSString * matchId;
@property(nonatomic,copy)NSString * matchTime;//比赛时间
@property(nonatomic,copy)NSString * match_STATUS;
@property(nonatomic,copy)NSString * match_DATA;//赛事时间
@property(nonatomic,copy)NSString * play_ID;//比赛id
@property(nonatomic,copy)NSString * rang_QIU;//判断是会否支持让球胜平负---现在用不判断，默认全部支持
@property(nonatomic,copy)NSString * rang_QIU_SP;
@property(nonatomic,copy)NSString * rq;//让球数
@property(nonatomic,assign)NSInteger sheng_PING_FU;//判断是会否支持胜平负
@property(nonatomic,copy)NSString * spf_SP;
@property(nonatomic,copy)NSString * league_id;//联赛ID

//篮球
@property(nonatomic,copy)NSString * daxiao_fen;//是否
@property(nonatomic,copy)NSString * daxiao_sp;//赔率
@property(nonatomic,copy)NSString * daxiao_comityball;//让分
@property(nonatomic,copy)NSString * rangfen_sf;//是否支持
@property(nonatomic,copy)NSString * rangfen_sp;//赔率
@property(nonatomic,copy)NSString * rangfen_comityball;//让分

@end


