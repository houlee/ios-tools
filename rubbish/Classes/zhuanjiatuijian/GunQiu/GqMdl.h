//
//  GqMdl.h
//  caibo
//
//  Created by zhoujunwang on 16/5/27.
//
//

#import <Foundation/Foundation.h>

@interface GqXQMdl : NSObject

@property (nonatomic,strong)NSString *expertName;
@property (nonatomic,strong)NSString *expertNickName;
@property (nonatomic,strong)NSString *headPortrait;
@property (nonatomic,strong)NSString *leagueName;
@property (nonatomic,strong)NSString *homeName;
@property (nonatomic,strong)NSString *awayName;
@property (nonatomic,strong)NSString *oddsBeforeHomeWin;
@property (nonatomic,strong)NSString *oddsBeforeAwayWin;
@property (nonatomic,strong)NSString *hostRqBefore;
@property (nonatomic,strong)NSString *oddsNewHomeWin;
@property (nonatomic,strong)NSString *oddsNewAwayWin;
@property (nonatomic,strong)NSString *hostRqNew;
@property (nonatomic,strong)NSString *oddsReleaseHomeWin;
@property (nonatomic,strong)NSString *oddsReleaseAwayWin;
@property (nonatomic,strong)NSString *hostRqRelease;
@property (nonatomic,strong)NSString *dayOfWeek;
@property (nonatomic,strong)NSString *matchTime;
@property (nonatomic,strong)NSString *releaseTime;
@property (nonatomic,strong)NSString *recommendContent;
@property (nonatomic,strong)NSString *recommendExplain;
@property (nonatomic,strong)NSMutableDictionary *dicNo;

+(instancetype)gqXQMdlWithDic:(NSDictionary *)dict;
-(instancetype)initWithDic:(NSDictionary *)dict;

@end

@interface GqMatchInfoMdl : NSObject

@property (nonatomic,strong)NSString *AWAY_NAME;
@property (nonatomic,strong)NSString *AWAY_SCORE;
@property (nonatomic,strong)NSString *DAY_WEEK;
@property (nonatomic,strong)NSString *HAS_BEEN_MINUTES;
@property (nonatomic,strong)NSString *HOME_NAME;
@property (nonatomic,strong)NSString *HOME_SCORE;
@property (nonatomic,strong)NSString *LEAGUE_NAME;
@property (nonatomic,strong)NSString *MATCH_TIME;
@property (nonatomic,strong)NSString *PLAY_ID;
@property (nonatomic,strong)NSString *RECOMMEND_COUNT;
@property (nonatomic,strong)NSMutableDictionary *dicNo;

+(instancetype)gqMatchInfoMdlWithDic:(NSDictionary *)dict;
-(instancetype)initWithDic:(NSDictionary *)dict;

@end

@interface GqMatchRecMdl : NSObject

@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *expertName;
@property (nonatomic,strong)NSString *expertNickName;
@property (nonatomic,strong)NSString *headPortrait;
@property (nonatomic,strong)NSString *expertClassCode;
@property (nonatomic,strong)NSString *lotteryClassCode;
@property (nonatomic,strong)NSString *erAgintOrderId;
@property (nonatomic,strong)NSString *amount;
@property (nonatomic,strong)NSString *homeName;
@property (nonatomic,strong)NSString *awayName;
@property (nonatomic,strong)NSString *oddsBeforeHomeWin;
@property (nonatomic,strong)NSString *oddsBeforeAwayWin;
@property (nonatomic,strong)NSString *hostRqBefore;
@property (nonatomic,strong)NSString *oddsNewHomeWin;
@property (nonatomic,strong)NSString *oddsNewAwayWin;
@property (nonatomic,strong)NSString *hostRqNew;
@property (nonatomic,strong)NSString *dayOfWeek;
@property (nonatomic,strong)NSString *matchTime;
@property (nonatomic,strong)NSString *releaseTime;
@property (nonatomic,strong)NSString *hitCount;
@property (nonatomic,strong)NSMutableDictionary *dicNo;

+(instancetype)gqMatchRecMdlWithDic:(NSDictionary *)dict;
-(instancetype)initWithDic:(NSDictionary *)dict;

@end

@interface GqYgRecMdl : NSObject

@property (nonatomic,strong)NSString *USER_NAME;
@property (nonatomic,strong)NSString *EXPERTS_NAME;
@property (nonatomic,strong)NSString *EXPERTS_CLASS_CODE;
@property (nonatomic,strong)NSString *LOTTEY_CLASS_CODE;
@property (nonatomic,strong)NSString *ER_AGINT_ORDER_ID;
@property (nonatomic,strong)NSString *HOME_NAME;
@property (nonatomic,strong)NSString *AWAY_NAME;
@property (nonatomic,strong)NSString *MATCH_TIME;
@property (nonatomic,strong)NSString *LEAGUE_NAME;
@property (nonatomic,strong)NSString *EXPERTS_NICK_NAME;
@property (nonatomic,strong)NSString *HEAD_PORTRAIT;
@property (nonatomic,strong)NSString *STATUS;
@property (nonatomic,strong)NSMutableDictionary *dicNo;

+(instancetype)gqYgRecMdlWithDic:(NSDictionary *)dict;
-(instancetype)initWithDic:(NSDictionary *)dict;

@end


