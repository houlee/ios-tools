//
//  zhuiHaoData.m
//  caibo
//
//  Created by houchenguang on 13-12-12.
//
//

#import "zhuiHaoData.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation zhuiHaoData
@synthesize sysId, sysTime, currPage, recordCount, infoList, sumPage,lotteryName,  lotteryID, playName, playID,zhuihaoMoney, yiFuAmount, betTime, zhuiHaoType, awardType, awardAmount, yiZhuiIssue, zhuiHaoIssue, zhuiHaoJiLu, awarIssue, shengyu, zhuiHaoTypeString;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request type:(NSInteger)type
{
	if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.sysId = [drs readShort];
        NSLog(@"返回消息id %li", (long)self.sysId);
        if (![GC_RspError parserError:drs returnId:sysId WithRequest:request])
		{
			
            if (type == 0) {
                self.sysTime = [drs readComposString1];
                self.sumPage = [drs readShort];
                self.currPage = [drs readByte];
                self.recordCount = [drs readByte];
                NSLog(@"消息id %ld", (long)self.sysId);
                NSLog(@"系统时间 %@", self.sysTime);
                NSLog(@"总页数 %ld", (long)self.sumPage);
                NSLog(@"当前页 %ld", (long)self.currPage);
                NSLog(@"信息数 %ld", (long)self.recordCount);
                self.infoList = [NSMutableArray arrayWithCapacity:self.recordCount];
                for (int i = 0; i < self.recordCount; i++) {
                    
                    zhuiHaoDataInfo * zhui = [[zhuiHaoDataInfo alloc] init];
                    zhui.betDate = [drs readComposString1];
                    zhui.lotteryName = [drs readComposString1];
                    zhui.lotteryNumber = [drs readComposString1];
                    zhui.playName = [drs readComposString1];
                    zhui.playNumber = [drs readComposString1];
                    zhui.betAmount = [drs readComposString1];
                    zhui.lotteryIssue = [drs readComposString1];
                    zhui.zhuiHaoSet = [drs readByte];
                    zhui.stopAmount = [drs readComposString1];
                    zhui.zhuiHaoID = [drs readComposString1];
                    zhui.awardIssue = [drs readByte];
                    zhui.yiZhuiIssue = [drs readByte];
                    zhui.zhuiHaoIssue = [drs readByte];
                    zhui.awardAmount = [drs readComposString1];
                    zhui.yuliu = [drs readComposString1];
                    
                    
                    NSLog(@"投注时间 %@", zhui.betDate);
                    NSLog(@"彩种名称 %@", zhui.lotteryName);
                    NSLog(@"彩种编号 %@", zhui.lotteryNumber);
                    NSLog(@"玩法名称 %@", zhui.playName);
                    NSLog(@"玩法编号 %@", zhui.playNumber);
                    NSLog(@"投注金额 %@",zhui.betAmount);
                    NSLog(@"期号 %@", zhui.lotteryIssue);
                    NSLog(@"追号设置 %ld", (long)zhui.zhuiHaoSet);
                    NSLog(@"停追金额 %@", zhui.stopAmount);
                    NSLog(@"追号方案编号 %@", zhui.zhuiHaoID);
                    NSLog(@"中奖期数 %ld", (long)zhui.awardIssue);
                    NSLog(@"已追期数 %ld", (long)zhui.yiZhuiIssue);
                    NSLog(@"追号期数 %ld", (long)zhui.zhuiHaoIssue);
                    NSLog(@"中奖金额 %@", zhui.awardAmount);
                    NSLog(@"预留字段 %@", zhui.yuliu);
                    
                    [self.infoList addObject:zhui];
                    [zhui release];
                    
                }
            }else{
            
                self.sysTime = [drs readComposString1];
                self.lotteryName = [drs readComposString1];
                self.lotteryID = [drs readComposString1];
                self.playName = [drs readComposString1];
                self.playID = [drs readComposString1];
                self.zhuihaoMoney = [drs readComposString1];
                self.yiFuAmount = [drs readComposString1];
                self.betTime = [drs readComposString1];
                self.zhuiHaoType = [drs readComposString1];
                NSArray * typeArray = [self.zhuiHaoType componentsSeparatedByString:@"-"];
                if ([typeArray count] == 2) {
                    self.zhuiHaoType = [typeArray objectAtIndex:0];
                    self.zhuiHaoTypeString = [typeArray objectAtIndex:1];
                }
               

                self.awardType = [drs readComposString1];
                NSArray * typeArray2 = [self.awardType componentsSeparatedByString:@"-"];
                if ([typeArray2 count] >= 1) {
                    self.awardType = [typeArray2 objectAtIndex:0];
                }else{
                    self.awardType = [typeArray2 objectAtIndex:0];
                }
                
                
                
                self.awardAmount = [drs readComposString1];
                self.awarIssue = [drs readByte];
                self.yiZhuiIssue = [drs readByte];
                self.zhuiHaoIssue = [drs readByte];
                self.zhuiHaoJiLu = [drs readByte];
                self.shengyu = [drs readByte];
                self.currPage = [drs readByte];
                
                NSLog(@"系统时间 %@", self.sysTime);
                NSLog(@"彩种名称 %@", self.lotteryName);
                NSLog(@"彩种编号 %@", self.lotteryID);
                NSLog(@"玩法名称 %@", self.playName);
                NSLog(@"玩法编号 %@", self.playID);
                NSLog(@"追号方案金额 %@",self.zhuihaoMoney);
                NSLog(@"已付金额 %@", self.yiFuAmount);
                NSLog(@"投注时间 %@", self.betTime);
                NSLog(@"追号状态 %@", self.zhuiHaoType);
                NSLog(@"中奖状态 %@", self.awardType);
                NSLog(@"中奖金额 %@", self.awardAmount);
                NSLog(@"中奖期数 %ld", (long)self.awarIssue);
                NSLog(@"已追期数 %ld", (long)self.yiZhuiIssue);
                NSLog(@"追号期数 %ld", (long)self.zhuiHaoIssue);
                NSLog(@"显示追号记录数 %ld", (long)self.zhuiHaoJiLu);
                NSLog(@"剩余追号记录数 %ld", (long)self.shengyu);
                NSLog(@"当前页码 %ld", (long)self.currPage);
                
               
                
                
                self.infoList = [NSMutableArray arrayWithCapacity:self.zhuiHaoJiLu];
                for (int i = 0; i < self.zhuiHaoJiLu; i++) {
                
                    zhuiHaoDataInfo * zhui = [[zhuiHaoDataInfo alloc] init];
                    zhui.lotteryIssue = [drs readComposString1];
                    zhui.awardType = [drs readComposString1];
                    NSArray * typeArray1 = [zhui.awardType componentsSeparatedByString:@"-"];
                    if ([typeArray1 count] >= 1) {
                        zhui.awardType = [typeArray1 objectAtIndex:0];
                    }else{
                        zhui.awardType = @"";
                    }
                    
                    
                    zhui.awardAmount = [drs readComposString1];
                    zhui.zhuiHaoID = [drs readComposString1];
                    zhui.fanganMoney = [drs readComposString1];
                    zhui.secrecyType = [drs readComposString1];
                    NSArray * typeArray2 = [ zhui.secrecyType componentsSeparatedByString:@"-"];
                    if ([typeArray2 count] >= 1) {
                        zhui.secrecyType = [typeArray2 objectAtIndex:0];
                    }else{
                        zhui.secrecyType = @"";
                    }
                    
                    
                    
                    zhui.fanganType = [drs readComposString1];
                    NSArray * typeArray3 = [ zhui.fanganType componentsSeparatedByString:@"-"];
                    if ([typeArray3 count] == 2) {
                        zhui.fanganType  = [typeArray3 objectAtIndex:0];
                        zhui.fangantypeString = [typeArray3 objectAtIndex:1];
                    }
                    zhui.yuliu = [drs readComposString1];
                    NSLog(@"期号 %@", zhui.lotteryIssue);
                    NSLog(@"中奖状态 %@", zhui.awardType);
                    NSLog(@"中奖金额 %@", zhui.awardAmount);
                    NSLog(@"方案编号 %@", zhui.zhuiHaoID);
                    NSLog(@"方案金额 %@", zhui.fanganMoney);
                    NSLog(@"保密类型 %@", zhui.secrecyType);
                    NSLog(@"方案状态 %@", zhui.fanganType);
                    [self.infoList addObject:zhui];
                    [zhui release];
                    
                }
            
            }
            
            
            
		}
		[drs release];
    }
    return self;
}

- (void)dealloc{
    
//    lotteryName, * lotteryID, * playName, * playID, *zhuihaoMoney, *yiFuAmount, *betTime, * zhuiHaoType, * awardType, * awardAmount;
    [zhuiHaoTypeString release];
    [lotteryName release];
    [lotteryID release];
    [playName release];
    [playID release];
    [zhuihaoMoney release];
    [yiFuAmount release];
    [betTime release];
    [zhuiHaoType release];
    [awardType release];
    [sysTime release];
    [infoList release];
    [super dealloc];
}
@end


@implementation zhuiHaoDataInfo

@synthesize  betDate, lotteryName, lotteryNumber, playName, playNumber, betAmount, lotteryIssue, zhuiHaoSet, stopAmount, zhuiHaoID,  awardIssue,  yiZhuiIssue, zhuiHaoIssue, awardAmount, yuliu, secrecyType, fanganType, fanganMoney, awardType,fangantypeString;

- (void)dealloc{
    [fangantypeString release];
    [awardType release];
    [secrecyType release];
    [fanganType release];
    [betDate release];
    [lotteryName release];
    [lotteryNumber release];
    [playName release];
    [playNumber release];
    [betAmount release];
    [lotteryIssue release];
   
    [stopAmount release];
    [zhuiHaoID release];
    [fanganMoney release];
    [awardAmount release];
    [yuliu release];
    
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    