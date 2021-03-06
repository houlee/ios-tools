//
//  JiangJinYouHuaJX.m
//  caibo
//
//  Created by yaofuyu on 13-7-9.
//
//

#import "JiangJinYouHuaJX.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation JiangJinYouHuaJX

@synthesize systemTime,YHKey,minMoney,maxMoney,randNum,YHStueNum,YHMsg,betArray,chaiArray;
@synthesize  returnId,betLenght,chaiLenght;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request {
    self = [super init];
    if (self) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        NSLog(@"返回消息id %li", (long)self.returnId);
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
        {
            self.systemTime = [drs readComposString1];
            self.YHKey = [drs readComposString2];
            self.minMoney = [drs readComposString1];
            self.maxMoney = [drs readComposString1];
            self.randNum = [drs readComposString1];
            self.YHStueNum = [drs readComposString1];
            self.YHMsg = [drs readComposString1];
            NSLog(@"系统时间：%@",self.systemTime);
            NSLog(@"优化值：%@",self.YHKey);
            NSLog(@"最小奖金：%@",self.minMoney);
            NSLog(@"最大奖金：%@",self.maxMoney);
            NSLog(@"随机数：%@",self.randNum);
            NSLog(@"优化信息ID：%@",self.YHStueNum);
            NSLog(@"优化信息：%@",self.YHMsg);
            self.betLenght = [drs readByte];
            if (self.betLenght > 0) {
                self.betArray = [NSMutableArray arrayWithCapacity:0];
				for (int i = 0; i < self.betLenght; i++) {
					NSString *betNumber = [drs readComposString2];
					NSLog(@"投注内容 %@", betNumber);
                    if (betNumber) {
                        GC_YHTouInfo *info = [[GC_YHTouInfo alloc] init];
                        NSArray *parameters = [betNumber componentsSeparatedByString:@"||"];
                        if ([parameters count] > 0) {
                            info.identifier = [parameters objectAtIndex:0];
                            if ([parameters count] > 1) {
                                info.leagueName = [parameters objectAtIndex:1];
                            }else{
                                info.leagueName = @"";
                            }
                            if ([parameters count] > 2) {
                                info.leagueID = [parameters objectAtIndex:2];
                            }else{
                                info.leagueID = @"";
                            }
                            
                            if ([parameters count] > 3) {
                                info.home = [parameters objectAtIndex:3];
                            }else{
                                info.home = @"";
                            }
                            if ([parameters count] > 4) {
                                info.away = [parameters objectAtIndex:4];
                            }else{
                                info.away = @"";
                            }
                            NSString *time = @"";
                            if ([parameters count] > 5) {
                                time = [parameters objectAtIndex:5];
                            }
                            NSArray *array = [time componentsSeparatedByString:@" "];
                            if ([array count] > 0) {
                                info.endTime = [NSString stringWithFormat:@"%@ 截止",[array lastObject]];
                            }else{
                                info.endTime = @"";
                            }
                            if ([parameters count] > 6) {
                                info.eurPei = [parameters objectAtIndex:6];
                            }else {
                                info.eurPei = @"";
                            }
                            if ([parameters count] > 7) {
                                info.assignCount = [parameters objectAtIndex:7];
                            }else{
                                info.assignCount = @"";
                            }
                            if ([parameters count] > 8) {
                                info.playID = [parameters objectAtIndex:8];
                            }else{
                                info.playID = @"";
                            }
                            
                            [self.betArray addObject:info];
                            
                        }
                        [info release];
                    }
					
				}
            }
            self.chaiLenght = [drs readShort];
            if (self.chaiLenght > 0) {
                self.chaiArray = [NSMutableArray arrayWithCapacity:0];
				for (int i = 0; i < self.chaiLenght; i++) {
					NSString *betNumber = [drs readComposString2];
					NSLog(@"拆分内容 %@", betNumber);
                    if (betNumber) {
                        GC_YHChaiInfo *info = [[GC_YHChaiInfo alloc] init];
                        NSArray *parameters = [betNumber componentsSeparatedByString:@"||"];
                        if ([parameters count] > 0) {
                            info.identifier = [parameters objectAtIndex:0];
                            if ([parameters count] > 1) {
                                info.betInfo = [parameters objectAtIndex:1];
                            }else{
                                info.betInfo = @"";
                            }
                            if ([parameters count] > 2) {
                                info.betNum = [parameters objectAtIndex:2];
                            }else{
                                info.betNum = @"";
                            }
                            if ([parameters count] > 3) {
                                info.danJiang = [parameters objectAtIndex:3];
                            }else{
                                info.danJiang = @"";
                            }
                            
                            if ([parameters count] > 4) {
                                info.zongJiang = [parameters objectAtIndex:4];
                            }else{
                                info.zongJiang = @"";
                            }
                            [self.chaiArray addObject:info];
                            
                        }
                        [info release];
                    }
					
				}
            }
        }
        [drs release];
    }
    return self;
}

- (void)dealloc {
    self.systemTime = nil;
    self.YHKey = nil;
    self.minMoney = nil;
    self.maxMoney = nil;
    self.randNum = nil;
    self.YHStueNum = nil;
    self.YHMsg = nil;
    self.betArray = nil;
    self.chaiArray = nil;
    [super dealloc];
}

@end

@implementation GC_YHTouInfo

@synthesize identifier, leagueName, leagueID,home, away, endTime, assignCount, eurPei, playID;

- (void)dealloc
{
    [identifier release];
    [leagueName release];
    [leagueID release];
    [home release];
    [away release];
    [endTime release];
    [assignCount release];
    [eurPei release];
	[super dealloc];
}

@end

@implementation GC_YHChaiInfo

@synthesize identifier, betInfo, betNum,danJiang, zongJiang;

- (void)dealloc
{
    [identifier release];
    [betInfo release];
    [betNum release];
    [danJiang release];
    [zongJiang release];
	[super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    