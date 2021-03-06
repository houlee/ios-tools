//
//  GC_PKDetailData.m
//  caibo
//
//  Created by cp365dev6 on 15/3/9.
//
//

#import "GC_PKDetailData.h"

@implementation GC_PKDetailData

@synthesize listData,betContentArym;
@synthesize curCount,returnId;
@synthesize sysTimeString, userName, qici, passType, betType, zhuShu, beiShu, xuanzeChangci, betMoney, getMoney, winMoney, orderNum, orderTime, statue,caizhong,wanfa,touzhuType,touzhuContent,kaijiangNum,kaijiangTime,yuliuData;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])){
        [self initWithResponseData:_responseData WithRequest:request type:PKDetailPK];
    }
    return self;
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request type:(PKDetailType)type
{
    self = [super init];
    if (self) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        if (drs) {
            self.returnId= [drs readShort];
            NSLog(@"返回消息id %d", (int)returnId);
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) {
                self.sysTimeString = [drs readComposString1];
                self.userName = [drs readComposString1];
                self.qici = [drs readComposString1];
                self.passType = [drs readComposString1];
                self.betType = [drs readComposString1];
                self.zhuShu = [drs readComposString1];
                self.beiShu = [drs readComposString1];
                self.xuanzeChangci = [drs readComposString1];
                self.betMoney = [drs readComposString1];
                self.getMoney = [drs readComposString1];
                self.winMoney = [drs readComposString1];
                self.orderNum = [drs readComposString1];
                self.orderTime = [drs readComposString1];
                self.statue = [drs readComposString1];
                self.caizhong = [drs readComposString1];
                self.wanfa = [drs readComposString1];
                self.touzhuType = [drs readComposString1];
                self.touzhuContent = [drs readComposString1];
                self.kaijiangNum = [drs readComposString1];
                self.kaijiangTime = [drs readComposString1];
                self.yuliuData = [drs readComposString1];
                self.curCount = [drs readShort];
                
                NSLog(@"系统时间 %@",self.sysTimeString);
                NSLog(@"用户名 %@",self.userName);
                NSLog(@"期次 %@",self.qici);
                NSLog(@"过关方式 %@",self.passType);
                NSLog(@"投注类选 %@",self.betType);
                NSLog(@"注数 %@",self.zhuShu);
                NSLog(@"倍数 %@",self.beiShu);
                NSLog(@"选择场次 %@",self.xuanzeChangci);
                NSLog(@"投注金额 %@",self.betMoney);
                NSLog(@"奖金 %@",self.getMoney);
                NSLog(@"盈利 %@",self.winMoney);
                NSLog(@"订单编号 %@",self.orderNum);
                NSLog(@"下单时间 %@",self.orderTime);
                NSLog(@"中奖状态 %@",self.statue);
                NSLog(@"菜种 %@",self.caizhong);
                NSLog(@"玩法 %@",self.wanfa);
                NSLog(@"投注方式 %@",self.touzhuType);
                NSLog(@"投注内容 %@",self.touzhuContent);
                NSLog(@"开奖号码 %@",self.kaijiangNum);
                NSLog(@"开奖时间 %@",self.kaijiangTime);
                NSLog(@"预留字段 %@",self.yuliuData);
                NSLog(@"当前页条数 %ld",(long)self.curCount);
                if (curCount > 0 && type != PKDetailHorse) {
                    self.listData = [NSMutableArray arrayWithCapacity:curCount];
                    self.betContentArym = [NSMutableArray arrayWithCapacity:curCount];
                    for (int i = 0; i < curCount; i++) {
                        
                        PKDetailData *pkx = [[PKDetailData alloc]init];
                        
                        pkx.changci = [drs readComposString1];
                        pkx.zhuName = [drs readComposString1];
                        pkx.keName = [drs readComposString1];
                        pkx.raceTime = [drs readComposString1];
                        pkx.zhuBifen = [drs readComposString1];
                        pkx.keBifen = [drs readComposString1];
                        pkx.raceResult = [drs readComposString1];
                        pkx.betContent = [drs readComposString1];
                        pkx.shengPei = [drs readComposString1];
                        pkx.pingPei = [drs readComposString1];
                        pkx.fuPei = [drs readComposString1];
                        pkx.moreData = [drs readComposString1];
                        [self.betContentArym addObject:pkx.betContent];
                        [self.listData addObject:pkx];
                        
                        
                        NSLog(@"场次 %@",pkx.changci);
                        NSLog(@"主队名 %@",pkx.zhuName);
                        NSLog(@"客队名 %@",pkx.keName);
                        NSLog(@"比赛时间 %@",pkx.raceTime);
                        NSLog(@"主队比分 %@",pkx.zhuBifen);
                        NSLog(@"客队比分 %@",pkx.keBifen);
                        NSLog(@"赛果 %@",pkx.raceResult);
                        NSLog(@"投注内容 %@",pkx.betContent);
                        NSLog(@"胜赔率 %@",pkx.shengPei);
                        NSLog(@"平赔率 %@",pkx.pingPei);
                        NSLog(@"负赔率 %@",pkx.fuPei);
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

@end

@implementation PKDetailData

@synthesize changci, zhuName, keName, raceTime, zhuBifen, keBifen, raceResult, betContent, shengPei, pingPei, fuPei, moreData;

-(void)dealloc
{
    self.changci = nil;
    self.zhuName = nil;
    self.keName = nil;
    self.raceTime = nil;
    self.zhuBifen = nil;
    self.keBifen = nil;
    self.raceResult = nil;
    self.betContent = nil;
    self.shengPei = nil;
    self.pingPei = nil;
    self.fuPei = nil;
    self.moreData = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    