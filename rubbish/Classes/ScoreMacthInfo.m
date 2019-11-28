//
//  ScoreMacthInfo.m
//  caibo
//
//  Created by yaofuyu on 13-7-3.
//
//

#import "ScoreMacthInfo.h"
#import "JSON.h"

@implementation ScoreMacthInfo
@synthesize eventArray;

@synthesize home, away, leagueName, matchTime, asianHome, asianRangqiu, asianAway, eurWin, eurDraw, eurLost,status;
@synthesize scoreHost, awayHost, lotteryId, isGoalNotice,HostTeamFlag,GuestTeamFlag,spWin,spEqual,spLose,totleScroe,fencha,yushezongfen,actiontxt,state,refreshtime;
@synthesize asianDic,over_downDic,europeDic,asian_changeDic,over_down_changeDic,europe_changeDic;


//足球解析
- (id)initWithParse: (NSString*)jsonString {
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
		
        
		self.scoreHost = [dictArray valueForKey:@"scoreHost"];
		self.awayHost = [dictArray valueForKey:@"awayHost"];
        self.GuestTeamFlag = [dictArray valueForKey:@"GuestTeamFlag"];
        self.HostTeamFlag = [dictArray valueForKey:@"HostTeamFlag"];
		
		//比赛事件状态
		NSArray *homeArray = [dictArray valueForKey:@"MsgList"];
		if ([homeArray count])
		{
			NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
			for (int i = 0; i < [homeArray count]; i++)
			{
				NSDictionary *dicHomeMsgList = [homeArray objectAtIndex:i];
				MacthEvent *MatchDetail = [[MacthEvent alloc] initWithDic:dicHomeMsgList];
				[mutableArray insertObject: MatchDetail atIndex: i];
                [MatchDetail release];
			}
			self.eventArray = mutableArray;
			[mutableArray release];
		}
		
		self.lotteryId = [dictArray valueForKey:@"lotteryId"];
        self.status = [dictArray valueForKey:@"status"];
		self.isGoalNotice = [[dictArray valueForKey:@"isGoalNotice"] intValue];
        self.spWin = [dictArray valueForKey:@"spWin"];
        self.spEqual = [dictArray valueForKey:@"spEqual"];
        self.spLose = [dictArray valueForKey:@"spLose"];
        
	}
	
	[json release];
	
	return self;
}

+ (void)replaceOlde:(ScoreMacthInfo *)oldInfo WithNew:(ScoreMacthInfo *)newInfo {
    if (newInfo.eventArray) {
        oldInfo.eventArray = newInfo.eventArray;
    }
    if (newInfo.matchTime) {
        oldInfo.matchTime = newInfo.matchTime;
    }
    if (newInfo.scoreHost) {
        oldInfo.scoreHost = newInfo.scoreHost;
    }
    if (newInfo.status) {
        oldInfo.status = newInfo.status;
    }
    if (newInfo.state) {
        oldInfo.state = newInfo.state;
    }
    if (newInfo.awayHost) {
       oldInfo.awayHost = newInfo.awayHost;
    }
    if (newInfo.refreshtime) {
        oldInfo.refreshtime = newInfo.refreshtime;
    }
    if (newInfo.actiontxt) {
        oldInfo.actiontxt = newInfo.actiontxt;
    }
    if (newInfo.totleScroe) {
        oldInfo.totleScroe = newInfo.totleScroe;
    }
    if (newInfo.fencha) {
        oldInfo.fencha = newInfo.fencha;
    }
    if (newInfo.spWin) {
        oldInfo.spWin = newInfo.spWin;
    }
    if (newInfo.spLose) {
        oldInfo.spLose = newInfo.spLose;
    }
    if (newInfo.yushezongfen) {
        oldInfo.yushezongfen = newInfo.yushezongfen;
    }
        

    
    
}

- (id)initWithLanQiuParse: (NSString*)jsonString {
    if(nil == jsonString){
		
		return nil;
	}
	self = [super init];
    SBJSON *json = [[SBJSON alloc] init];
	NSDictionary *dictArray = [json objectWithString: jsonString];
	if(dictArray)
	{
        self.home = [dictArray valueForKey:@"hostName"];
		self.away = [dictArray valueForKey:@"guestName"];
		
		self.leagueName = [dictArray valueForKey:@"liansainame"];
		self.matchTime = [dictArray valueForKey:@"matchStartTime"];
        
        NSArray *spA = [[dictArray valueForKey:@"sp"] componentsSeparatedByString:@","];
        if ([spA count] >= 2) {
            self.spWin = [spA objectAtIndex:1];
            self.spLose = [spA objectAtIndex:0];
        }
		
        
		self.scoreHost = [dictArray valueForKey:@"Hostscore"];
		self.awayHost = [dictArray valueForKey:@"Guestscore"];
        self.GuestTeamFlag = [dictArray valueForKey:@"guestflg"];
        self.HostTeamFlag = [dictArray valueForKey:@"hostflg"];
		
		//比赛事件状态
		NSDictionary *action = [dictArray valueForKey:@"action"];
        self.totleScroe = [action valueForKey:@"zongfen"];
        self.fencha = [action valueForKey:@"fencha"];
        self.yushezongfen = [action valueForKey:@"yszf"];
        self.actiontxt = [action valueForKey:@"actiontxt"];
        NSArray *keyArray = [NSArray arrayWithObjects:@"firstscore",@"secondscore",@"thirdscore",@"fourthscore",@"addtimescore1",@"addtimescore2",@"addtimescore3",nil];
        NSArray *nameArray = [NSArray arrayWithObjects:@"第1节",@"第2节",@"第3节",@"第4节",@"加时赛1",@"加时赛2",@"加时赛3", nil];
		if ([keyArray count])
		{
			NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
            NSInteger count = 0;
			for (int i = 0; i < [keyArray count]; i++)
			{
                
				NSString *scroe = [action objectForKey:[keyArray objectAtIndex:i]];
                if (scroe ) {
                    MacthEvent *MatchDetail = [[MacthEvent alloc] init];
                    MatchDetail.scroe =scroe;
                    MatchDetail.name = [nameArray objectAtIndex:i];
                    
                    [mutableArray insertObject: MatchDetail atIndex: count];
                    [MatchDetail release];
                    count++;
                }
                
			}
			self.eventArray = mutableArray;
			[mutableArray release];
		}
		self.state = [dictArray valueForKey:@"state"];
		self.lotteryId = [dictArray valueForKey:@"lotteryId"];
        self.status = [dictArray valueForKey:@"status"];
        self.asianDic = [dictArray valueForKey:@"asian"];
        self.europeDic = [dictArray valueForKey:@"europe"];
        self.over_downDic = [dictArray valueForKey:@"over_down"];
        self.asian_changeDic = [dictArray valueForKey:@"asian_change"];
        self.europe_changeDic = [dictArray valueForKey:@"europe_change"];
        self.over_down_changeDic = [dictArray valueForKey:@"over_down_change"];
        self.refreshtime = [dictArray valueForKey:@"refreshtime"];
        }
	
	[json release];
	
	return self;
}

- (void)dealloc {
    self.leagueName = nil;
    self.matchTime = nil;
    self.asianHome = nil;
    self.asianRangqiu = nil;
    self.asianAway = nil;
    self.eurWin = nil;
    self.eurDraw = nil;
    self.eurLost = nil;
    self.home = nil;
    self.away = nil;
    self.scoreHost = nil;
    self.awayHost = nil;
    self.status = nil;
    self.eventArray = nil;
    self.lotteryId  = nil;
    self.GuestTeamFlag = nil;
    self.HostTeamFlag= nil;
    self.spWin = nil;
    self.spEqual = nil;
    self.spLose = nil;
    self.yushezongfen= nil;
    self.fencha = nil;
    self.totleScroe = nil;
    self.actiontxt = nil;
    self.asianDic = nil;
    self.over_downDic = nil;
    self.europeDic = nil;
    self.asian_changeDic = nil;
    self.over_down_changeDic = nil;
    self.europe_changeDic = nil;
    self.state = nil;
    self.refreshtime = nil;
    [super dealloc];
}

@end

@implementation MacthEvent
@synthesize teamType,eventType,name,mins,scroe;

- (id)initWithDic:(NSDictionary *)dic {
    self = [super init];
    self.teamType = [[dic objectForKey:@"teamType"] integerValue];
    self.eventType = [[dic objectForKey:@"type"] integerValue];
    self.name = [dic objectForKey:@"name"];
    self.mins = [dic objectForKey:@"mins"];
    return self;
}

- (void)dealloc {
    
    self.name = nil;
    self.mins = nil;
    self.scroe = nil;
    [super dealloc];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    