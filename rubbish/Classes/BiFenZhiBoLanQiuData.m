//
//  BiFenZhiBoLanQiuData.m
//  caibo
//
//  Created by yaofuyu on 13-10-23.
//
//

#import "BiFenZhiBoLanQiuData.h"
#import "SBJSON.h"
#import "YDUtil.h"

@implementation BiFenZhiBoLanQiuData
@synthesize matchStartTime,guestName,status,state,liansainame,playId,hostflg,matchNo,Hostscore,guestflg,Guestscore,bcbf,hostName,curIssue,refreshtime;
@synthesize matchList;
@synthesize isColorNeedChange,isScoreHostChange,isAwayHostChange;


- (id)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        isColorNeedChange = NO;
        isAwayHostChange = NO;
        isScoreHostChange = NO;
        self.matchStartTime = [dic objectForKey:@"matchStartTime"];
        self.guestName = [dic objectForKey:@"guestName"];
        self.status = [dic objectForKey:@"status"];
        self.state = [dic objectForKey:@"state"];
        self.liansainame = [dic objectForKey:@"liansainame"];
        self.playId = [dic objectForKey:@"playId"];
        self.hostflg = [dic objectForKey:@"hostflg"];
        self.matchNo = [dic objectForKey:@"matchNo"];
        self.Hostscore = [dic objectForKey:@"Hostscore"];
        self.guestflg = [dic objectForKey:@"guestflg"];
        self.Guestscore = [dic objectForKey:@"Guestscore"];
        self.bcbf = [dic objectForKey:@"bcbf"];
        self.hostName = [dic objectForKey:@"hostName"];
        if ([dic valueForKey:@"issue"]) {
            self.curIssue = [dic valueForKey:@"issue"];
        }
        
    }
    return self;
}

- (id)initParserWithString:(NSString *)str
{
    if ((self = [super init]))
    {
        if (str)
        {
            SBJSON *jsonParse = [[SBJSON alloc] init];
            NSDictionary *dic = [jsonParse objectWithString:str];
            if (dic && [dic isKindOfClass:[NSDictionary class]])
            {
                self.curIssue = [dic valueForKey:@"issue"];
                self.refreshtime = [dic valueForKey:@"refreshtime"];
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                self.matchList = arr;
                [arr release];
                if ([[dic valueForKey:@"matchList"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dict = [dic valueForKey:@"matchList"];
                    for (NSDictionary *dictt in dict)
                    {
                        BiFenZhiBoLanQiuData *match = [[BiFenZhiBoLanQiuData alloc] initWithDic:dictt];
                        if (!match.curIssue) {
                            match.curIssue = self.curIssue;
                        }
                        [self.matchList addObject:match];
                        [match release];
                    }
                }
                else if ([[dic valueForKey:@"matchList"] isKindOfClass:[NSArray class]]){
                    NSArray *dict = [dic valueForKey:@"matchList"];
                    for (NSDictionary *dictt in dict)
                    {
                        BiFenZhiBoLanQiuData *match = [[BiFenZhiBoLanQiuData alloc] initWithDic:dictt];
                        if (!match.curIssue) {
                            match.curIssue = self.curIssue;
                        }
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

// 旧的比赛中部分属性值变化更新
+ (void)replaceMatch:(BiFenZhiBoLanQiuData*)match NewMatch:(BiFenZhiBoLanQiuData*)newMatch
{
    match.status = newMatch.status;
    match.matchNo = newMatch.matchNo;
    
    if (![match.state isEqualToString:newMatch.state] ||
        ![match.Hostscore isEqualToString:newMatch.Hostscore] ||
        ![match.Guestscore isEqualToString:newMatch.Guestscore])
    {
        match.isColorNeedChange = YES;
        if (![match.Hostscore isEqualToString:newMatch.Hostscore])
        {
            match.isScoreHostChange = YES;
        }
        if (![match.Guestscore isEqualToString:newMatch.Guestscore])
        {
            match.isAwayHostChange = YES;
        }
    }
    match.bcbf = newMatch.bcbf;
    match.state = newMatch.state;
    match.Hostscore = newMatch.Hostscore;
    match.Guestscore = newMatch.Guestscore;
}

- (void)dealloc {
    self.matchStartTime = nil;
    self.guestName = nil;
    self.status = nil;
    self.state = nil;
    self.liansainame = nil;
    self.playId = nil;
    self.hostflg = nil;
    self.matchNo = nil;
    self.Hostscore = nil;
    self.guestflg = nil;
    self.Guestscore = nil;
    self.bcbf = nil;
    self.hostName = nil;
    self.curIssue = nil;
    self.matchList = nil;
    self.refreshtime = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    