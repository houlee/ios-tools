//
//  MatchInfo.m
//  caibo
//
//  Created by user on 11-8-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MatchInfo.h"
#import "SBJSON.h"
#import "YDUtil.h"

@implementation MatchInfo

@synthesize home;
@synthesize away;
@synthesize rangqiu; 
@synthesize matchTime;
@synthesize asianHome;
@synthesize asianRangqiu;
@synthesize asianAway;
@synthesize eurWin;
@synthesize eurDraw;
@synthesize eurLost;
@synthesize isAttention;
@synthesize leagueName;
@synthesize lotteryId;
@synthesize status;
@synthesize caiguo;
@synthesize issue;
@synthesize lotteryNumber;
@synthesize isGoalNotice;
@synthesize scoreHost;
@synthesize awayHost;
@synthesize matchId;
@synthesize start;
@synthesize curIssue;
@synthesize matchList;
@synthesize oldList;
@synthesize aNewList;
@synthesize noStartList;
@synthesize isColorNeedChange;
@synthesize isScoreHostChange;
@synthesize isAwayHostChange;
@synthesize pos;
@synthesize section_id;
@synthesize changci;
@synthesize isstart;

// 初始化 （NSDictionary）
- (id)initWithDictionary:(NSDictionary*)dic
{
	if ((self = [super init])) 
    {
		self.home = [dic valueForKey:@"home"];
		self.away = [dic valueForKey:@"away"];
		self.rangqiu = [dic valueForKey:@"rangqiu"];
		self.matchTime = [dic valueForKey:@"matchTime"];
		self.asianHome = [dic valueForKey:@"asianHome"];
		self.asianRangqiu = [dic valueForKey:@"asianRangqiu"];
		self.asianAway = [dic valueForKey:@"asianAway"];
		self.eurWin = [dic valueForKey:@"eurWin"];
		self.eurDraw = [dic valueForKey:@"eurDraw"];
		self.eurLost = [dic valueForKey:@"eurLost"];
		self.isAttention = [dic valueForKey:@"isAttention"];
        
        self.leagueName = [dic valueForKey:@"leagueName"];
        self.lotteryId = [dic valueForKey:@"lotteryId"];
        self.status = [dic valueForKey:@"status"];
        self.caiguo = [dic valueForKey:@"caiguo"];
        self.issue = [dic valueForKey:@"issue"];
        self.scoreHost = [dic valueForKey:@"scoreHost"];
        self.awayHost = [dic valueForKey:@"awayHost"];
        self.matchId = [dic valueForKey:@"matchId"];
        self.start = [dic valueForKey:@"start"];
        self.isstart = [dic valueForKey:@"isstart"];
        self.pos = [dic valueForKey:@"pos"];
		self.isGoalNotice = [[dic valueForKey:@"isGoalNotice"] boolValue];
		self.lotteryNumber = [dic valueForKey:@"lotteryNumber"];
        self.section_id = [dic valueForKey:@"section_id"];
        self.changci = [dic valueForKey:@"xh"];
	}
	return self;
}

- (void)dealloc
{
    [home release]; 
    [away release]; 
    [rangqiu release];
    [matchTime release]; 
    [asianHome release];
    [asianRangqiu release]; 
    [asianAway release]; 
    [eurWin release]; 
    [eurDraw release]; 
    [eurLost release]; 
    [isAttention release]; 
    
    [leagueName release];
    [lotteryId release];
    [status release];
    [caiguo release];
    [issue release];
    [scoreHost release];
    [awayHost release];
    [matchId release];
    [start release];
    
    [curIssue release];
    [matchList release];
    //自动刷新
    [oldList release];
    [aNewList release];
    [noStartList release];
    [pos release];
    [section_id release];
    
    [changci release];
    self.isstart = nil;
    
	[super dealloc];
}



// 比赛列表解析 2.82
+ (NSMutableArray*)parserWithString:(NSString *)str
{
    NSMutableArray *vec = [[[NSMutableArray alloc] init] autorelease];
    if (str) 
    {
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSDictionary *dic = [jsonParse objectWithString:str];
        for (NSDictionary *dict in dic) 
        {
            MatchInfo *matchInfo = [[MatchInfo alloc] initWithDictionary:dict];
            [vec addObject:matchInfo];
            [matchInfo release];
        }
        [jsonParse release];
    }
	return vec;
}

// 比赛列表解析 2.88
- (id)initParserWithString:(NSString *)str
{
    if ((self = [super init])) 
    {
        if (str) 
        {
            SBJSON *jsonParse = [[SBJSON alloc] init];
            NSDictionary *dic = [jsonParse objectWithString:str];
            if (dic) 
            {
                self.curIssue = [dic valueForKey:@"issue"];
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                self.matchList = arr;
                [arr release];
                if ([[dic valueForKey:@"matchList"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dict = [dic valueForKey:@"matchList"];
                    for (NSDictionary *dictt in dict)
                    {
                        MatchInfo *match = [[MatchInfo alloc] initWithDictionary:dictt];
                        [self.matchList addObject:match];
                        [match release];
                    }
                }
                else if ([[dic valueForKey:@"matchList"] isKindOfClass:[NSArray class]]){
                    NSArray *dict = [dic valueForKey:@"matchList"];
                    for (NSDictionary *dictt in dict)
                    {
                        MatchInfo *match = [[MatchInfo alloc] initWithDictionary:dictt];
                        [self.matchList addObject:match];
                        [match release];
                    }
                    
                    }

            }
            [jsonParse release];
        }
    }
    return self;
}

// 比赛列表解析 2.93 2.94
- (id)initParserWithString2:(NSString *)str
{
    if ((self = [super init])) 
    {
        if (str) 
        {
            SBJSON *jsonParse = [[SBJSON alloc] init];
            NSDictionary *dic = [jsonParse objectWithString:str];
            if (dic) 
            {
                NSMutableArray *arr_old = [[NSMutableArray alloc] init];
                self.oldList = arr_old;
                [arr_old release];
                NSDictionary *dict_old = [dic valueForKey:@"oldList"];
                for (NSDictionary *dictt in dict_old) 
                {
                    MatchInfo *match = [[MatchInfo alloc] initWithDictionary:dictt];
                    [self.oldList addObject:match];
                    [match release];
                }
                NSMutableArray *arr_noStart = [[NSMutableArray alloc] init];
                self.noStartList = arr_noStart;
                [arr_noStart release];
                NSDictionary *dict_noStart = [dic valueForKey:@"noStartList"];
                for (NSDictionary *dictt in dict_noStart) 
                {
                    MatchInfo *match = [[MatchInfo alloc] initWithDictionary:dictt];
                    match.isColorNeedChange = YES;
                    [self.noStartList addObject:match];
                    [match release];
                }
                NSMutableArray *arr_new = [[NSMutableArray alloc] init];
                self.aNewList = arr_new;
                [arr_new release];
                NSDictionary *dict_new = [dic valueForKey:@"aNewList"];
                for (NSDictionary *dictt in dict_new) 
                {
                    MatchInfo *match = [[MatchInfo alloc] initWithDictionary:dictt];
                    match.isColorNeedChange = YES;
                    [self.aNewList addObject:match];
                    [match release];
                }
            }
            [jsonParse release];
        }
    }
    return self;
}

// 足彩列表
+ (NSMutableArray*)getZcVecByArray:(NSArray*)vec
{
    NSMutableArray *zcVec = [[[NSMutableArray alloc] init] autorelease];
    if(vec)
    {
        for (MatchInfo *match in vec) 
        {
            if ([match.lotteryId isEqualToString:@"300"]||
                [match.lotteryId isEqualToString:@"302"]||
                [match.lotteryId isEqualToString:@"303"]) 
            {
                [zcVec addObject:match];
            }
        }
    }
    return zcVec;
}

// 竞彩列表
+ (NSMutableArray*)getJcVecByArray:(NSArray*)vec
{
    NSMutableArray *jcVec = [[[NSMutableArray alloc] init] autorelease];
    if (vec) 
    {
        for (MatchInfo *match in vec) 
        {
            if ([match.lotteryId isEqualToString:@"201"]) 
            {
                [jcVec addObject:match];
            }
        }
    }
    return jcVec;
}

// 北单列表
+ (NSMutableArray*)getBdVecByArray:(NSArray*)vec
{
    NSMutableArray *bdVec = [[[NSMutableArray alloc] init] autorelease];
    if (vec) 
    {
        for (MatchInfo *match in vec) 
        {
            if ([match.lotteryId isEqualToString:@"400"]) 
            {
                [bdVec addObject:match];
            }
        }
    }
    return bdVec;
}

+ (NSMutableArray*)getTitleVec:(NSArray*)vec
{
    NSMutableArray *titleVec = [[[NSMutableArray alloc] init] autorelease];
    NSArray *zcArr = [MatchInfo getZcVecByArray:vec];
    NSArray *jcArr = [MatchInfo getJcVecByArray:vec];
    NSArray *bdArr = [MatchInfo getBdVecByArray:vec];
    if (zcArr && [zcArr count] > 0) 
    {
        [titleVec addObject:@"足彩"];
    }
    if (jcArr && [jcArr count] > 0) 
    {
        [titleVec addObject:@"竞彩"];
    }
    if (bdArr && [bdArr count] > 0) 
    {
        [titleVec addObject:@"北单"];
    }

    return titleVec;
}

+ (NSMutableArray*)getMatchArrVec:(NSArray*)vec
{
    NSMutableArray *arrVec = [[[NSMutableArray alloc] init] autorelease];
    NSArray *zcArr = [MatchInfo getZcVecByArray:vec];
    NSArray *jcArr = [MatchInfo getJcVecByArray:vec];
    NSArray *bdArr = [MatchInfo getBdVecByArray:vec];
    
    if (zcArr && [zcArr count] > 0) 
    {
        [arrVec addObject:zcArr];
    }
    if (jcArr && [jcArr count] > 0) 
    {
        [arrVec addObject:jcArr];
    }
    if (bdArr && [bdArr count] > 0) 
    {
        [arrVec addObject:bdArr];
    }
    
    return arrVec;
}

+ (NSMutableArray*)getMatchArrayByStart:(NSArray*)vec start:(NSString*)s
{
    NSMutableArray *newVec = [[[NSMutableArray alloc] init] autorelease];
    if(vec)
    {
        for (MatchInfo *match in vec) 
        {
            if ([match.start isEqualToString:s]) 
            {
                [newVec addObject:match];
            }
        }
    }
    return newVec;
}

+ (NSMutableArray*)getMatchIdsFromArray:(NSArray*)vec
{
    NSMutableArray *matchIdVec = [[[NSMutableArray alloc] init] autorelease];
    if(vec && [vec count] > 0)
    {
        for (MatchInfo *match in vec) 
        {
            [matchIdVec addObject:match.matchId]; 
        }
    }
    return matchIdVec;
}

+ (NSMutableArray*)getNewVecByOrder:(NSArray*)vec oldList:(NSArray*)oldArr aNewList:(NSArray*)newArr
{
    NSMutableArray *arrVec = [[[NSMutableArray alloc] init] autorelease];
    
    NSArray *zcArr = [MatchInfo getZcVecByArray:vec];
    NSArray *oldArr_zc = [MatchInfo getZcVecByArray:oldArr];
    NSArray *newArr_zc = [MatchInfo getZcVecByArray:newArr];
    NSArray *newZcArr = [MatchInfo getNewVecByOrder:zcArr oldList:oldArr_zc noStartList:nil aNewList:newArr_zc];
    
    NSArray *jcArr = [MatchInfo getJcVecByArray:vec];
    NSArray *oldArr_jc = [MatchInfo getJcVecByArray:oldArr];
    NSArray *newArr_jc = [MatchInfo getJcVecByArray:newArr];
    NSArray *newJcArr = [MatchInfo getNewVecByOrder:jcArr oldList:oldArr_jc noStartList:nil aNewList:newArr_jc];
    
    NSArray *bdArr = [MatchInfo getBdVecByArray:vec];
    NSArray *oldArr_bd = [MatchInfo getBdVecByArray:oldArr];
    NSArray *newArr_bd = [MatchInfo getBdVecByArray:newArr];
    NSArray *newBdArr = [MatchInfo getNewVecByOrder:bdArr oldList:oldArr_bd noStartList:nil aNewList:newArr_bd];
    
    if (newZcArr && [newZcArr count] > 0) 
    {
        [arrVec addObject:newZcArr];
    }
    if (newJcArr && [newJcArr count] > 0) 
    {
        [arrVec addObject:newJcArr];
    }
    if (newBdArr && [newBdArr count] > 0) 
    {
        [arrVec addObject:newBdArr];
    }
        
    return arrVec;
}

// 对自动更新的数据 进行分组排序
+ (NSMutableArray*)getNewVecByOrder:(NSArray*)vec oldList:(NSArray*)oldArr noStartList:(NSArray*)noStartArr aNewList:(NSArray*)newArr
{
    NSMutableArray *newVec = [[[NSMutableArray alloc] init] autorelease];
    if (vec && [vec count] > 0) 
    {
        NSMutableArray *keys = [MatchInfo getMatchIdsFromArray:vec];
        NSArray *oldKeys = [MatchInfo getMatchIdsFromArray:oldArr];
        NSArray *noStartKeys = [MatchInfo getMatchIdsFromArray:noStartArr];
        NSArray *newKeys = [MatchInfo getMatchIdsFromArray:newArr];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjects:vec forKeys:keys];
        for (int i = 0; i < [oldKeys count] && [oldKeys count] > 0; i++) 
        {
            NSString *oldKey = [oldKeys objectAtIndex:i];
            if (oldKey) {
                MatchInfo *oldMatch = [oldArr objectAtIndex:i];
                MatchInfo *match =  [dic objectForKey:oldKey];
                [MatchInfo replaceMatch:match NewMatch:oldMatch];
                [dic setObject:match forKey:oldKey];
                if ([oldKey isEqualToString:@"2"])
                {
                    [keys removeObject:oldKey];
                    [keys insertObject:oldKey atIndex:0];
                }
            }
        }
        for (int i = 0; i < [noStartKeys count] && [noStartKeys count] > 0; i++) 
        {
            NSString *noStartKey = [noStartKeys objectAtIndex:i];
            MatchInfo *start12Match = [noStartArr objectAtIndex:i];
            if ([noStartKey isEqualToString:@"2"]) 
            {
                if(start12Match){
                    [dic setObject:start12Match forKey:noStartKey];

                }
                [keys removeObject:noStartKey];
                [keys insertObject:noStartKey atIndex:0];
            }
        }
        if (keys && [keys count] > 0 && newKeys && [newKeys count] > 0) 
        {
            [keys removeObjectsInArray:newKeys];
        }
        for (int i = 0; i < [newKeys count] && [newKeys count] > 0; i++) 
        {
            NSString *newKey = [newKeys objectAtIndex:i];
            MatchInfo *newMatch = [newArr objectAtIndex:i];
            [dic setObject:newMatch forKey:newKey];
            [keys insertObject:newKey atIndex:0];
        }
        
        NSArray *arr = [dic objectsForKeys:keys notFoundMarker:@""];
        NSArray *start1 = [MatchInfo getMatchArrayByStart:arr start:@"1"];
        NSArray *start2 = [MatchInfo getMatchArrayByStart:arr start:@"2"];
        NSArray *start0 = [MatchInfo getMatchArrayByStart:arr start:@"0"];
        [newVec addObjectsFromArray:start1];
        [newVec addObjectsFromArray:start2];
        [newVec addObjectsFromArray:start0];
        
        [dic release];
    }
    return newVec;
}

// 2.93 关注列表数据更新接口 matchListParam参数
+ (NSString*)getMatchListParam:(NSArray*)vec
{
    NSString *str = @"matchListParam=";
    if (vec && [vec count] > 0) 
    {
        NSArray *zcArr = [MatchInfo getZcVecByArray:vec];
        NSArray *zcArrStart1 = [MatchInfo getMatchArrayByStart:zcArr start:@"1"];
        
        NSArray *jcArr = [MatchInfo getJcVecByArray:vec];
        NSArray *jcArrStart1 = [MatchInfo getMatchArrayByStart:jcArr start:@"1"];
        NSArray *bdArr = [MatchInfo getBdVecByArray:vec];
        NSArray *bdArrStart1 = [MatchInfo getMatchArrayByStart:bdArr start:@"1"];
        NSMutableDictionary *jsonDic = [[NSMutableDictionary alloc] init];
        if (zcArrStart1 && [zcArrStart1 count] > 0) 
        {
            NSMutableArray *dicArr = [[NSMutableArray alloc] init];
            for (MatchInfo *match in zcArrStart1) 
            {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setValue:match.issue forKey:@"issue"];
                [dic setValue:match.matchId forKey:@"matchId"];
                [dicArr addObject:dic];
                [dic release];
            }
            [jsonDic setObject:dicArr forKey:@"300"];
            [dicArr release];
        }
        if (jcArrStart1 && [jcArrStart1 count] > 0) 
        {
            NSMutableArray *dicArr = [[NSMutableArray alloc] init];
            for (MatchInfo *match in jcArrStart1) 
            {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setValue:match.issue forKey:@"issue"];
                [dic setValue:match.matchId forKey:@"matchId"];
                [dicArr addObject:dic];
                [dic release];
            }
            [jsonDic setObject:dicArr forKey:@"201"];
            [dicArr release];
        }
        if (bdArrStart1 && [bdArrStart1 count] > 0) 
        {
            NSMutableArray *dicArr = [[NSMutableArray alloc] init];
            for (MatchInfo *match in bdArrStart1) 
            {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setValue:match.issue forKey:@"issue"];
                [dic setValue:match.matchId forKey:@"matchId"];
                [dicArr addObject:dic];
                [dic release];
            }
            [jsonDic setObject:dicArr forKey:@"400"];
            [dicArr release];
        }        
        SBJSON *jsonWriter = [[SBJSON alloc] init];
        str = [str stringByAppendingString:[jsonWriter stringWithObject:jsonDic]];
        [jsonDic release];
        [jsonWriter release];
    }
    return str;
}

// 2.94 彩种列表数据更新接口 matchIds参数
+ (NSString*)getMatchIds:(NSArray*)vec
{
    NSString *str = @"matchIds=";
    NSArray *vecStart1 = [MatchInfo getMatchArrayByStart:vec start:@"1"];
    if(vecStart1 && [vecStart1 count] > 0)
    {
        for (int i = (int)[vecStart1 count] - 1; i >= 0; i--)
        {
            MatchInfo *match = [vecStart1 objectAtIndex:i];
            str = [str stringByAppendingString:match.matchId];
            if (i != 0) 
            {
                str = [str stringByAppendingString:@","];
            }
        }
    }
    return str;
}

// 2.94 彩种列表数据更新接口 notStartMatchs参数
+ (NSString*)getNotStartMatchs:(NSArray*)vec
{
    NSString *str = @"notStartMatchs=";
    NSArray *vecStart1 = [MatchInfo getMatchArrayByStart:vec start:@"0"];
    if(vecStart1 && [vecStart1 count] > 0)
    {
        for (int i = (int)[vecStart1 count] - 1; i >= 0; i--)
        {
            MatchInfo *match = [vecStart1 objectAtIndex:i];
            str = [str stringByAppendingString:match.matchId];
            if (i != 0) 
            {
                str = [str stringByAppendingString:@","];
            }
        }
    }
    return str;
}

+ (void)replaceMatch:(MatchInfo*)match NewMatch:(MatchInfo*)newMatch WithSound:(BOOL) sound {
    if (sound) {
        [MatchInfo replaceMatch:match NewMatch:newMatch];
    }
    else {
        match.caiguo = newMatch.caiguo;
        match.status = newMatch.status;
        match.matchId = newMatch.matchId;
        match.isstart = newMatch.isstart;
        
        if (![match.start isEqualToString:newMatch.start] ||
            ![match.scoreHost isEqualToString:newMatch.scoreHost] ||
            ![match.awayHost isEqualToString:newMatch.awayHost])
        {
            match.isColorNeedChange = YES;
            if (![match.scoreHost isEqualToString:newMatch.scoreHost])
            {
                match.isScoreHostChange = YES;
            }
            if (![match.awayHost isEqualToString:newMatch.awayHost])
            {
                match.isAwayHostChange = YES;
            }
        }
        match.start = newMatch.start;
        match.scoreHost = newMatch.scoreHost;
        match.awayHost = newMatch.awayHost;
    }
}

// 旧的比赛中部分属性值变化更新
+ (void)replaceMatch:(MatchInfo*)match NewMatch:(MatchInfo*)newMatch
{    
    match.caiguo = newMatch.caiguo;
    match.status = newMatch.status;
    match.matchId = newMatch.matchId;
    
    if (![match.start isEqualToString:newMatch.start] ||
        ![match.scoreHost isEqualToString:newMatch.scoreHost] || 
        ![match.awayHost isEqualToString:newMatch.awayHost])
    {
        match.isColorNeedChange = YES;
        if (![match.scoreHost isEqualToString:newMatch.scoreHost]) 
        {
            match.isScoreHostChange = YES;
			[YDUtil playSound:@"goal"];
        }
        if (![match.awayHost isEqualToString:newMatch.awayHost]) 
        {
            match.isAwayHostChange = YES;
			[YDUtil playSound:@"goal"];
        }
    }
    match.start = newMatch.start;
    match.scoreHost = newMatch.scoreHost;
    match.awayHost = newMatch.awayHost;
}



@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    