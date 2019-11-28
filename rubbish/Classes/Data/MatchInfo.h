//
//  MatchInfo.h
//  caibo
//
//  Created by user on 11-8-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MatchInfo : NSObject 
{
	NSString *home; //主队
	NSString *away; //客队
	NSString *rangqiu; //让球数
	NSString *matchTime; //开赛时间
	NSString *asianHome;//亚盘主队
	NSString *asianRangqiu; //亚盘让球
	NSString *asianAway; //亚盘客队
	NSString *eurWin; //欧盘主胜
	NSString *eurDraw; //欧盘平
	NSString *eurLost; //欧盘客胜
	NSString *isAttention; //是否被关注、0未关注 1关注
    
    NSString *leagueName; //联赛名称
    NSString *lotteryId; //彩种id
    NSString *status; //状态
    NSString *caiguo; //彩果
    NSString *issue; //彩期
    NSString *scoreHost; //主队得分
    NSString *awayHost; //客队得分
    NSString *matchId; //
    NSString *start; // 2011 8 23 新加参数 判断比分颜色 0未开始 1比赛中 2已结束
    NSString *isstart; //方案详情比分直播开始状态 0未开始，1，将要开始，2开始
    NSString *curIssue; // 当前彩期
	NSString *lotteryNumber; //投注信息；
	BOOL isGoalNotice;  //是否推送通知
    NSMutableArray *matchList; // 比赛列表
    NSMutableArray *oldList;
    NSMutableArray *aNewList;
    NSMutableArray *noStartList;
    BOOL isColorNeedChange;
    BOOL isScoreHostChange;
    BOOL isAwayHostChange;
    NSString *section_id;
    NSString *pos;
    NSString *changci;
}

@property (nonatomic, retain) NSString *home;
@property (nonatomic, retain) NSString *away;
@property (nonatomic, retain) NSString *rangqiu;
@property (nonatomic, retain) NSString *matchTime;
@property (nonatomic, retain) NSString *asianHome;
@property (nonatomic, retain) NSString *asianRangqiu;
@property (nonatomic, retain) NSString *asianAway;
@property (nonatomic, retain) NSString *eurWin;
@property (nonatomic, retain) NSString *eurDraw;
@property (nonatomic, retain) NSString *eurLost;
@property (nonatomic, retain) NSString *isAttention;

@property (nonatomic, retain) NSString *leagueName;
@property (nonatomic, retain) NSString *lotteryId;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *caiguo;
@property (nonatomic, retain) NSString *issue;
@property (nonatomic, retain) NSString *lotteryNumber;
@property (nonatomic, assign) BOOL isGoalNotice;
@property (nonatomic, retain) NSString *scoreHost;
@property (nonatomic, retain) NSString *awayHost;
@property (nonatomic, retain) NSString *matchId;
@property (nonatomic, retain) NSString *start;
@property (nonatomic, retain) NSString *isstart;

@property (nonatomic, retain) NSString *curIssue;
@property (nonatomic, retain) NSMutableArray *matchList;
@property (nonatomic, retain) NSMutableArray *oldList;
@property (nonatomic, retain) NSMutableArray *aNewList;
@property (nonatomic, retain) NSMutableArray *noStartList;
@property (nonatomic, assign) BOOL isColorNeedChange;
@property (nonatomic, assign) BOOL isScoreHostChange;
@property (nonatomic, assign) BOOL isAwayHostChange;
@property (nonatomic, retain) NSString *pos;
@property (nonatomic,retain)NSString *section_id;
@property (nonatomic, retain) NSString *changci;

+ (NSMutableArray*)parserWithString:(NSString *)str;
- (id)initWithDictionary:(NSDictionary*)dic;
- (id)initParserWithString:(NSString *)str;// 比赛列表解析 2.93 2.94
- (id)initParserWithString2:(NSString *)str;
//
+ (NSMutableArray*)getTitleVec:(NSArray*)vec;
+ (NSMutableArray*)getMatchArrVec:(NSArray*)vec;
+ (NSMutableArray*)getMatchIdsFromArray:(NSArray*)vec;
+ (NSString*)getMatchListParam:(NSArray*)vec;
+ (NSString*)getMatchIds:(NSArray*)vec;
+ (NSString*)getNotStartMatchs:(NSArray*)vec;
// 旧的比赛中部分属性值变化更新
+ (void)replaceMatch:(MatchInfo*)match NewMatch:(MatchInfo*)newMatch;
+ (void)replaceMatch:(MatchInfo*)match NewMatch:(MatchInfo*)newMatch WithSound:(BOOL) sound;


+ (NSMutableArray*)getNewVecByOrder:(NSArray*)vec oldList:(NSArray*)oldArr noStartList:(NSArray*)noStartArr aNewList:(NSArray*)newArr;
+ (NSMutableArray*)getNewVecByOrder:(NSArray*)vec oldList:(NSArray*)oldArr aNewList:(NSArray*)newArr;

@end
