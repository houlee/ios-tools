//
//  GameDetailMdl.h
//  Experts
//
//  Created by mac on 15/11/10.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameDetailMdl : NSObject

@property (nonatomic,strong)NSDictionary *expertInfo;//专家基本信息Model
@property (nonatomic,strong)NSDictionary *planInfo;//有关赛事Model

@end

@interface CompExpInfoMdl : NSObject

@property (nonatomic,strong)NSString *expertsCodeArray;
@property (nonatomic,strong)NSString *expertsIntroduction;
@property (nonatomic,strong)NSString *expertsLevelValue;
@property (nonatomic,strong)NSString *expertsName;
@property (nonatomic,strong)NSString *expertsNickName;
@property (nonatomic,strong)NSString *expertsStatus;
@property (nonatomic,strong)NSString *headPortrait;
@property (nonatomic,strong)NSString *lottertCodeArray;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *source;

@end

@interface CompPlanInfoMdl : NSObject

@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *recommendExplain;
@property (nonatomic,strong)NSString *recommendTitle;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *passType;
@property (nonatomic,strong)NSString *paidStatus;
@property (nonatomic,strong)NSString *lotteryClassCode;//(彩种：-201、竞彩，202、亚盘)
@property (nonatomic,strong)NSString *erAgintOrderId;
@property (nonatomic,strong)NSString *discountPrice;
@property (nonatomic,strong)NSString *discount;
@property (nonatomic,strong)NSString *closeTime;
@property (nonatomic,strong)NSString *closeStatus;
@property (nonatomic,strong)NSString *erIssue;
@property (nonatomic,strong)NSString *orderStatus;
@property (nonatomic,strong)NSString *deny_reason;
@property (nonatomic,strong)NSString *matchResult;//实际比赛结果
@property (nonatomic,strong)NSArray *contentInfo;
@property (nonatomic,assign)NSInteger free_status;
@property (nonatomic,strong)NSString *infoSource;//公司名称

@end

@interface CompMdl : NSObject

@property (nonatomic,strong)NSString *awayName;//客队名称
@property (nonatomic,strong)NSString *homeName;//主队名称
@property (nonatomic,strong)NSString *leagueName;//联赛名称
@property (nonatomic,strong)NSString *matchDate;//赛事时间
@property (nonatomic,strong)NSString *matchTime;//比赛时间
@property (nonatomic,strong)NSString *matchesName;//比赛名称
@property (nonatomic,strong)NSString *matchesId;//场次
@property (nonatomic,strong)NSString *playTypeCode;//玩法
@property (nonatomic,strong)NSString *recommendContent;//推荐内容
@property (nonatomic,strong)NSString *rqs;
@property (nonatomic,strong)NSString *rqOdds;//让球各赔率
@property (nonatomic,strong)NSString *odds;//赔率
@property (nonatomic,strong)NSString *playId;//比赛ID
@property (nonatomic,strong)NSString *matchStatus;//赛事状态
@property (nonatomic,strong)NSString *matchResult;//赛事结果
@property (nonatomic,strong)NSString *match_id;//比赛ID

@property (nonatomic,strong)NSString *awayName2;//客队名称
@property (nonatomic,strong)NSString *homeName2;//主队名称
@property (nonatomic,strong)NSString *leagueName2;//联赛名称

@property (nonatomic,strong)NSString *matchTime2;//比赛时间
@property (nonatomic,strong)NSString *matchesName2;//比赛名称
@property (nonatomic,strong)NSString *matchesId2;//场次
@property (nonatomic,strong)NSString *playTypeCode2;//玩法
@property (nonatomic,strong)NSString *recommendContent2;//推荐内容
@property (nonatomic,strong)NSString *rqs2;
@property (nonatomic,strong)NSString *rqOdds2;//让球各赔率
@property (nonatomic,strong)NSString *odds2;//赔率
@property (nonatomic,strong)NSString *playId2;//比赛ID
@property (nonatomic,strong)NSString *match_id2;//场次
@property (nonatomic,strong)NSString *matchDate2;//赛事时间
@property (nonatomic,strong)NSString *matchStatus2;//赛事状态
@property (nonatomic,strong)NSString *matchResult2;//赛事结果

@end

