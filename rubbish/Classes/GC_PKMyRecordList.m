//
//  GC_PKMyRecordList.m
//  caibo
//
//  Created by cp365dev6 on 15/3/6.
//
//

#import "GC_PKMyRecordList.h"

@implementation GC_PKMyRecordList

@synthesize recordListArym;
@synthesize systemTime,totalPay,totalGet,totalScore;
@synthesize numCount,pageCount,returnId;
@synthesize listData;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        NSLog(@"返回消息id %i", (int)self.returnId);
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
        {
            self.systemTime = [drs readComposString1];
            self.totalPay = [drs readComposString1];
            self.totalGet = [drs readComposString1];
            self.totalScore = [drs readComposString1];
            self.numCount = [drs readShort];
            self.pageCount = [drs readShort];
            
            NSLog(@"系统时间 %@",self.systemTime);
            NSLog(@"总消费 %@",self.totalPay);
            NSLog(@"总中奖金额 %@",self.totalGet);
            NSLog(@"总积分 %@",self.totalScore);
            NSLog(@"当前页条数 %ld",(long)self.numCount);
            NSLog(@"总页数 %ld",(long)self.pageCount);
            
            if (numCount > 0) {
                self.listData = [NSMutableArray arrayWithCapacity:numCount];
                for (int i = 0; i < numCount; i++) {
                    
                    PKMyRecordList *pkx = [[PKMyRecordList alloc]init];
                    
                    pkx.fanganNum = [drs readComposString1];
                    pkx.createTime = [drs readComposString1];
                    pkx.qici = [drs readComposString1];
                    pkx.betContent = [drs readComposString1];
                    pkx.passType = [drs readComposString1];
                    pkx.betMoney = [drs readComposString1];
                    pkx.getMoney = [drs readComposString1];
                    pkx.getScore = [drs readComposString1];
                    pkx.winMoney = [drs readComposString1];
                    pkx.statue = [drs readComposString1];
                    pkx.caizhong = [drs readComposString1];
                    pkx.wanfa = [drs readComposString1];
                    pkx.touzhuType = [drs readComposString1];
                    pkx.moreData = [drs readComposString1];
                    [self.listData addObject:pkx];
                    
                    
                    NSLog(@"方案编号 %@",pkx.fanganNum);
                    NSLog(@"创建时间 %@",pkx.createTime);
                    NSLog(@"期次 %@",pkx.qici);
                    NSLog(@"投注内容 %@",pkx.betContent);
                    NSLog(@"过关方式 %@",pkx.passType);
                    NSLog(@"投注金额 %@",pkx.betMoney);
                    NSLog(@"中奖金额 %@",pkx.getMoney);
                    NSLog(@"获得积分 %@",pkx.getScore);
                    NSLog(@"虚拟收益 %@",pkx.winMoney);
                    NSLog(@"中奖状态 %@",pkx.statue);
                    NSLog(@"彩种 %@",pkx.caizhong);
                    NSLog(@"玩法 %@",pkx.wanfa);
                    NSLog(@"投注方式 %@",pkx.touzhuType);
                    NSLog(@"预留字段 %@",pkx.moreData);
                    
                    [pkx release];
                }
            }
            
            
        }
        [drs release];
    }
    return self;
}
-(void)dealloc
{
    self.systemTime = nil;
    [super dealloc];
}

@end


@implementation PKMyRecordList

@synthesize fanganNum, createTime, qici, betContent, passType, betMoney, getMoney, getScore, winMoney, statue, caizhong, wanfa, touzhuType, moreData;

-(void)dealloc
{
    self.fanganNum = nil;
    self.createTime = nil;
    self.qici = nil;
    self.betContent = nil;
    self.passType = nil;
    self.betMoney = nil;
    self.getMoney = nil;
    self.getScore = nil;
    self.winMoney = nil;
    self.statue = nil;
    self.caizhong = nil;
    self.wanfa = nil;
    self.touzhuType = nil;
    self.moreData = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    