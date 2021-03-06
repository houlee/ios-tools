//
//  GC_PKRaceList.m
//  caibo
//
//  Created by cp365dev6 on 15/3/6.
//
//

#import "GC_PKRaceList.h"

@implementation GC_PKRaceList

@synthesize listData;
@synthesize count,returnId;
@synthesize sysTimeString;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{
    
    if ((self = [super init])) {
        
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        if (drs) {
            self.returnId= [drs readShort];
            NSLog(@"返回消息id %d", (int)returnId);
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) {
                self.sysTimeString = [drs readComposString1];
                self.count = [drs readShort];
                NSLog(@"系统时间%@",self.sysTimeString);
                NSLog(@"赛程数%ld",(long)self.count);
                if (count > 0) {
                    self.listData = [NSMutableArray arrayWithCapacity:count];
                    for (int i = 0; i < count; i++) {
                        
                        PKXiangxiList *pkx = [[PKXiangxiList alloc]init];
                        
                        pkx.raceID = [drs readComposString1];
                        pkx.raceNum = [drs readComposString1];
                        pkx.zhuDui = [drs readComposString1];
                        pkx.keDui = [drs readComposString1];
                        pkx.zhuBifen = [drs readComposString1];
                        pkx.keBifen = [drs readComposString1];
                        pkx.statue = [drs readComposString1];
                        pkx.spType = [drs readComposString1];
                        pkx.shengPei = [drs readComposString1];
                        pkx.pingPei = [drs readComposString1];
                        pkx.fuPei = [drs readComposString1];
                        pkx.raceName = [drs readComposString1];
                        pkx.raceTime = [drs readComposString1];
                        pkx.moreData = [drs readComposString1];
                        [self.listData addObject:pkx];
                        
                        
                        NSLog(@"赛程 %@",pkx.raceID);
                        NSLog(@"场次 %@",pkx.raceNum);
                        NSLog(@"主队名 %@",pkx.zhuDui);
                        NSLog(@"客队名 %@",pkx.keDui);
                        NSLog(@"主队比分 %@",pkx.zhuBifen);
                        NSLog(@"客队比分 %@",pkx.keBifen);
                        NSLog(@"比赛状态 %@",pkx.statue);
                        NSLog(@"赔率类型 %@",pkx.spType);
                        NSLog(@"胜赔率 %@",pkx.shengPei);
                        NSLog(@"平赔率 %@",pkx.pingPei);
                        NSLog(@"负赔率 %@",pkx.fuPei);
                        NSLog(@"赛事名称 %@",pkx.raceName);
                        NSLog(@"比赛时间 %@",pkx.raceTime);
                        NSLog(@"预留字段 %@",pkx.moreData);
                        
                        [pkx release];
                    }
                }
            }
        }
        [drs release];
        
    }
    
    
    return self;
}
-(void)dealloc
{
    sysTimeString = nil;
    [super dealloc];
}
@end

@implementation PKXiangxiList

@synthesize raceID,raceNum,zhuDui,keDui,zhuBifen,keBifen,statue,spType,shengPei,pingPei,fuPei,raceName,raceTime,moreData;

-(void)dealloc
{
    self.raceID = nil;
    self.raceNum = nil;
    self.zhuDui = nil;
    self.keDui = nil;
    self.zhuBifen = nil;
    self.keBifen = nil;
    self.statue = nil;
    self.spType = nil;
    self.shengPei = nil;
    self.pingPei = nil;
    self.fuPei = nil;
    self.raceName = nil;
    self.raceTime = nil;
    self.moreData = nil;
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    