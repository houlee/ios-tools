//
//  JingCaiDuizhenResult.m
//  Lottery
//
//  Created by Jacob Chiang on 12-1-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GC_JingCaiDuizhenResult.h"

@implementation GC_JingCaiDuizhenResult

@synthesize num, match,homeTeam,homeTeamNum,vistorTeam,vistorTeamNum,time,deathLineTime,odds,europeOdds,rangQiu,score,state,lotteryResult,matchId;
@synthesize oddsList;
@synthesize selectedDic;
@synthesize afterInoderList;
@synthesize danState;
@synthesize bicaiid;
@synthesize datetime;
@synthesize nyrstr;
@synthesize bdzhouji;
@synthesize aomenoupei, zhongzu,macthType, macthTime, zlcString, timeSort, onePlural, hhonePlural, pluralString;

-(void)dealloc{
    [pluralString release];
    [hhonePlural release];
    [onePlural release];
    [timeSort release];
    [zlcString release];
    [macthType release];
    [macthTime release];
    [zhongzu release];
    [aomenoupei release];
    [bdzhouji release];
    [nyrstr release];
    [datetime release];
    [bicaiid release];
    [num release];
    [match release];
    [homeTeam release];
    [homeTeamNum release];
    [vistorTeam release];
    [vistorTeamNum release];
    [time release];
    [deathLineTime release];
    [odds release];
    [europeOdds release];
    [rangQiu release];
    [score release];
    [state release];
    [lotteryResult release];
    [oddsList release];
    [matchId release];
    [selectedDic release];
    [afterInoderList release];
    [super dealloc];
}

- (id)initWithResult:(NSString*)result{
    self =[super init];
    if (self) {
        if (result==nil)
            return nil;
        NSArray *arry = (NSArray*)[result componentsSeparatedByString:@"||"];
        NSLog(@"result = %@", result);
        if (arry&&[arry count]>0) {
            self.danState = 1;// 初始化为 “未设胆”状态
            NSMutableDictionary  *_dic = [NSMutableDictionary dictionary];
            self.selectedDic = _dic;
            
            NSMutableArray *_afterInoderList = [NSMutableArray array];
            self.afterInoderList  = _afterInoderList;

            self.num = [arry objectAtIndex:0];
            self.match = [arry objectAtIndex:1];
            self.matchId = [arry objectAtIndex:2];
            self.homeTeam = [arry objectAtIndex:3];
            self.homeTeamNum = [arry objectAtIndex:4];
            self.vistorTeam = [arry objectAtIndex:5];
            self.vistorTeamNum = [arry objectAtIndex:6];
            self.time = [arry objectAtIndex:7];
            self.deathLineTime = [arry objectAtIndex:8];
            self.datetime = [arry objectAtIndex:8];
            self.nyrstr = [arry objectAtIndex:8];
            
           
            if (deathLineTime&&deathLineTime.length>5) {
                self.deathLineTime = [deathLineTime substringFromIndex:5];
            }
            
            self.odds = [arry objectAtIndex:9];
            if (odds) {
              NSArray *_oddsList= (NSArray*)[odds componentsSeparatedByString:@" "];   
                self.oddsList =_oddsList;
            }
            
            self.europeOdds = [arry objectAtIndex:10];
            self.rangQiu = [arry objectAtIndex:11];
            self.score = [arry objectAtIndex:12];
            
//            if (score&&![score isEqualToString:@"-"]) {
//                NSArray *scores = [score componentsSeparatedByString:@","];
//                if (scores.count>0) {
//                 self.score = [NSString stringWithFormat:@"%@-%@ %@-%@",[scores objectAtIndex:0],[scores objectAtIndex:1],[scores objectAtIndex:2],[scores objectAtIndex:3]];
//                }
//            }
            
            self.state = [arry objectAtIndex:13];
            self.lotteryResult = [arry objectAtIndex:14];
            if ([arry count] >= 17) {
//                 self.bicaiid = [arry objectAtIndex:[arry count]-2];
                self.bdzhouji = [arry objectAtIndex:16];
                  self.aomenoupei = [arry objectAtIndex:16];
//                NSLog(@"zhouji = %@", self.bdzhouji);
            }else{
//                 self.bicaiid = [arry objectAtIndex:[arry count]-1];
            }
            self.bicaiid = [arry objectAtIndex:15];
            
          
            if ([arry count] > 17) {
                self.zhongzu = [arry objectAtIndex:17];//北单 这一位是标示是什么类型的比赛
            }
            
            if ([arry count] > 18) {
                self.macthType = [arry objectAtIndex:18];//北单这一位是中立场
            }
            if ([arry count] > 19) {
                self.macthTime = [arry objectAtIndex:19];//北单这一位是时间排序
            }
            if ([arry count] >= 21) {
                self.zlcString = [arry objectAtIndex:20];
            }
            if ([arry count] >= 22) {
                self.timeSort = [arry objectAtIndex:21];
            }
            self.onePlural = @"";
            if ([arry count] >= 23) {
//                self.onePlural = [arry objectAtIndex:22];
                
                
                NSArray * pluralArray = [[arry objectAtIndex:22] componentsSeparatedByString:@","];
                
                for (int i = 0; i < [pluralArray count]; i++) {
                    
                    self.onePlural = [NSString stringWithFormat:@" %@,%@", [pluralArray objectAtIndex:i], self.onePlural];
                    
                }
                NSLog(@"onep = %@", self.onePlural);
                
            }
            self.hhonePlural = @"";
            if ([arry count] >= 24) {
                self.hhonePlural = [arry objectAtIndex:23];
                
                NSArray * pluralArray = [[arry objectAtIndex:23] componentsSeparatedByString:@","];
                
                for (int i = 0; i < [pluralArray count]; i++) {
                    
                    self.pluralString = [NSString stringWithFormat:@" %@,%@", [pluralArray objectAtIndex:i], self.pluralString];
                    
                }
                NSLog(@"onep = %@", self.pluralString);
            }
        }
    }

 return  self;
}

-(NSString*)reusltString:(NSArray*)keys{
    NSMutableString *result = [NSMutableString string];
    for(int i=0;i<selectedDic.count;i++){
        NSNumber *keynum = (NSNumber*)[keys objectAtIndex:i];
        NSString *value = [selectedDic objectForKey:keynum];
        [result appendString:value];
        if (i!=selectedDic.count -1) {
            [result appendString:@","];
        }
        
    }
    return result;
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    