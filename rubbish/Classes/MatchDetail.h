//
//  MatchDetail.h
//  caibo
//
//  Created by user on 11-8-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MatchDetail : NSObject {

	NSMutableArray *marray;
	
	NSString *home;                //主队
	NSString *away;                //客队
	
	NSString *leagueName;          //联赛名
	NSString *matchTime;           //开赛时间
	
	NSString *asianHome;           //亚盘主队
	NSString *asianRangqiu;        //亚盘让球
	NSString *asianAway;           //亚盘客队
	
	NSString *eurWin;              //欧盘主胜
	NSString *eurDraw;             //欧盘平
	NSString *eurLost;             //欧盘客胜
	
    NSString *oddsWin;              
	NSString *oddsDraw;             
	NSString *oddsLost;             

	NSString *scoreHost;           //主队进球数
	NSString *awayHost;            //客队进球数
	
	NSArray *homeMsgListArray;
	NSString *homeMsgList;         //主队的比赛事件
	NSInteger homeType;            //比赛中主队球员所判类型
	NSString *homeName;            //主队球员姓名
	NSString *homeMins;            //主队球员被判时时间
	
	NSArray *awayMsgListArray;
	NSString *awayMsgList;         //客队的比赛事件
	NSInteger awayType;            //比赛中客队球员所判类型
	NSString *awayName;            //客队球员姓名
	NSString *awayMins;            //客队球员被判时时间
	
	NSString *lotteryId;           //彩种类型
	NSInteger isGoalNotice;        //是否进球通知

}

@property (nonatomic, retain) NSMutableArray *marray;
@property (nonatomic, retain) NSString *leagueName, *matchTime;
@property (nonatomic, retain) NSString *asianHome, *asianRangqiu, *asianAway;
@property (nonatomic, retain) NSString *eurWin, *eurDraw, *eurLost;
@property (nonatomic, retain) NSString *oddsWin, *oddsDraw, *oddsLost;
@property (nonatomic, retain) NSString *home, *away, *scoreHost, *awayHost;

@property (nonatomic, retain) NSArray *homeMsgListArray;
@property (nonatomic, retain) NSArray *awayMsgListArray;

@property (nonatomic, retain) NSString *homeMsgList;
@property (nonatomic, assign) NSInteger homeType;
@property (nonatomic, retain) NSString *homeName;
@property (nonatomic, retain) NSString *homeMins;

@property (nonatomic, retain) NSString *awayMsgList;
@property (nonatomic, assign) NSInteger awayType;
@property (nonatomic, retain) NSString *awayName;
@property (nonatomic, retain) NSString *awayMins;

@property (nonatomic, retain) NSString *lotteryId;
@property (nonatomic, assign) NSInteger isGoalNotice;

//解析赛事详情
- (id)initWithParse: (NSString*)responseString;

- (id) homePaserWithDictionary:(NSDictionary *)dic;

- (id) awayPaserWithDictionary:(NSDictionary *)dic;

@end
