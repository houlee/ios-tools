//
//  MatchDetail.m
//  caibo
//
//  Created by user on 11-8-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MatchDetail.h"
#import "SBJSON.h"


@implementation MatchDetail

@synthesize marray, homeMsgListArray, awayMsgListArray;

@synthesize home, away, leagueName, matchTime, asianHome, asianRangqiu, asianAway, eurWin, eurDraw, eurLost,oddsWin,oddsDraw,oddsLost;
@synthesize scoreHost, awayHost, homeMsgList, homeType, homeName, homeMins, awayMsgList, awayType, awayName, awayMins, lotteryId, isGoalNotice;


- (id) initWithParse:(NSString *)jsonString 
{
    if(nil == jsonString){
		
		return nil;
	}
	self = [super init];
    SBJSON *json = [[SBJSON alloc] init];
	NSDictionary *dictArray = [json objectWithString: jsonString];
	if(dictArray)
	{
        self.home = [dictArray valueForKey:@"home"];
		self.away = [dictArray valueForKey:@"away"];
		
		self.leagueName = [dictArray valueForKey:@"leagueName"];
		self.matchTime = [dictArray valueForKey:@"matchTime"];
		
		self.asianHome = [dictArray valueForKey:@"asianHome"];
		self.asianRangqiu = [dictArray valueForKey:@"asianRangqiu"];
		self.asianAway = [dictArray valueForKey:@"asianAway"];
		
		self.eurWin = [dictArray valueForKey:@"eurWin"];
		self.eurDraw = [dictArray valueForKey:@"eurDraw"];
		self.eurLost = [dictArray valueForKey:@"eurLost"];
		
        self.oddsWin = [dictArray valueForKey:@"spWin"];
        self.oddsDraw = [dictArray valueForKey:@"spEqual"];
        self.oddsLost = [dictArray valueForKey:@"spLose"];

		self.scoreHost = [dictArray valueForKey:@"scoreHost"];
		self.awayHost = [dictArray valueForKey:@"awayHost"];
		
		//主队比赛事件状态
		NSArray *homeArray = [dictArray valueForKey:@"homeMsgList"];
		if ([homeArray count])
		{
			NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
			for (int i = 0; i < [homeArray count]; i++)
			{
				NSDictionary *dicHomeMsgList = [homeArray objectAtIndex:i];
				MatchDetail *homeMatchDetail = [self homePaserWithDictionary: dicHomeMsgList]; 
				[mutableArray insertObject: homeMatchDetail atIndex: i];
			}
			self.homeMsgListArray = mutableArray;
			[mutableArray release];
		}
		
		//客队比赛事件状态
        NSArray *awayArray = [dictArray valueForKey:@"awayMsgList"];
		if ([awayArray count])
		{
			NSMutableArray *aMutableArray = [[NSMutableArray alloc] init];
			for (int j = 0; j < [awayArray count]; j++)
			{
				NSDictionary *dicAwayMsgList = [awayArray objectAtIndex:j];
				MatchDetail *awayMatchDetail = [self awayPaserWithDictionary: dicAwayMsgList]; 
				[aMutableArray insertObject: awayMatchDetail atIndex: j];
			}
			self.awayMsgListArray = aMutableArray;
			[aMutableArray release];
		}
    
		self.lotteryId = [dictArray valueForKey:@"lotteryId"];
		self.isGoalNotice = [[dictArray valueForKey:@"isGoalNotice"] intValue];
	}
	
	[json release];
	
	return self;
}


//主队存入字典数据解析
- (id) homePaserWithDictionary:(NSDictionary *)dic 
{
	MatchDetail *hDetail = [[[MatchDetail alloc] init] autorelease];
    if(dic)
	{
        hDetail.homeType = [[dic valueForKey:@"type"] intValue];
		hDetail.homeName = [dic valueForKey:@"name"];
		hDetail.homeMins = [dic valueForKey:@"mins"];
	}
    
    return hDetail;
}


//客队存入字典数据解析
- (id) awayPaserWithDictionary:(NSDictionary *)dic 
{
	MatchDetail *aDetail = [[[MatchDetail alloc] init] autorelease];
    if(dic)
	{
        aDetail.awayType = [[dic valueForKey:@"type"] intValue];
		aDetail.awayName = [dic valueForKey:@"name"];
		aDetail.awayMins = [dic valueForKey:@"mins"];
	}
	
    return aDetail;
}



- (void)dealloc
{
	[marray release];
	[homeMsgListArray release];
	[awayMsgListArray release];
	
	[home release];
	[away release];
	[leagueName release];
	[matchTime release];
	[asianHome release];
	[asianRangqiu release];
	[asianAway release];
	[eurWin release];
	[eurDraw release];
	[eurLost release];
    [oddsWin release];
    [oddsDraw release];
    [oddsLost release];
	[scoreHost release];
	[awayHost release];
	
	[homeMsgList release];
	[homeName release];
	[homeMins release];
	[awayMsgList release];
	[awayName release];
	[awayMins release];
	
	[lotteryId release]; 

	[super dealloc];
}




@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    