//
//  ChampionData.m
//  caibo
//
//  Created by houchenguang on 14-5-29.
//
//

#import "ChampionData.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation ChampionData

@synthesize returnId,systemTime, endTime, matchName, teamInfo, teamNum, endNum, matchNo, timeRemaining, matchId, odds;
@synthesize typeArray;
- (void)dealloc{
    [typeArray release];
    [systemTime release];
    [endTime release];
    [matchName release];
    [teamInfo release];
    [teamNum release];
    [endNum release];
    [matchNo release];
    [timeRemaining release];
    [matchId release];
    [odds release];
    [super dealloc];
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
        {
            self.systemTime = [drs readComposString1];
            self.endTime = [drs readComposString1];
            self.matchName = [drs readComposString1];
            self.teamInfo = [drs readComposString2];
            self.teamNum = [drs readComposString2];
            self.endNum = [drs readComposString2];
            self.matchNo = [drs readComposString1];
            self.timeRemaining = [drs readComposString1];
            self.matchId = [drs readComposString1];
            self.odds = [drs readComposString2];
            
            NSLog(@"系统时间 %@", self.systemTime);
            NSLog(@"截止时间 %@", self.endTime);
            NSLog(@"赛事名称 %@", self.matchName);
            NSLog(@"各球队信息列表 %@", self.teamInfo);
            NSLog(@"各个球队序号 %@", self.teamNum);
            NSLog(@"停售场 %@", self.endNum);
            NSLog(@"matchNo %@", self.matchNo);
            NSLog(@"剩余时间 %@", self.timeRemaining);
            NSLog(@"matchId %@", self.matchId);
            NSLog(@"赔率 %@", self.odds);
            
           typeArray = [[NSMutableArray alloc] initWithCapacity:0];
            NSArray * teamArray = [self.teamInfo componentsSeparatedByString:@","];
            for (int i = 0; i < [teamArray count]; i++) {
                [typeArray addObject:@"0"];
            }
           
           
            
        }
        [drs release];
    }
    return self;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    