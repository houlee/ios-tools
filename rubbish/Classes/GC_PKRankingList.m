//
//  GC_PKRankingList.m
//  caibo
//
//  Created by cp365dev6 on 15/3/5.
//
//

#import "GC_PKRankingList.h"

@implementation GC_PKRankingList

@synthesize sysTimeString;
@synthesize curCount,returnId;
@synthesize listData;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if ((self = [super init])) {
        
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        if (drs) {
            self.returnId= [drs readShort];
            NSLog(@"返回消息id %d", (int)returnId);
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) {
                self.sysTimeString = [drs readComposString1];
                self.curCount = [drs readShort];
                NSLog(@"系统时间%@",self.sysTimeString);
                NSLog(@"当前页条数%d",(int)self.curCount);
                if (curCount > 0) {
                    self.listData = [NSMutableArray arrayWithCapacity:curCount];
                    for (int i = 0; i < curCount; i++) {
                        
                        PKMyRankingList *pkx = [[PKMyRankingList alloc]init];
                        //@synthesize userIma, userNicheng, winMoney, getScore, userIma, moreData;
                        
                        pkx.userName = [drs readComposString1];
                        pkx.userNicheng = [drs readComposString1];
                        pkx.winMoney = [drs readComposString1];
                        pkx.getScore = [drs readComposString1];
                        pkx.userIma = [drs readComposString1];
                        pkx.moreData = [drs readComposString1];
                        [self.listData addObject:pkx];
                        
                        
                        NSLog(@"用户姓名 %@",pkx.userName);
                        NSLog(@"用户昵称 %@",pkx.userNicheng);
                        NSLog(@"虚拟盈利 %@",pkx.winMoney);
                        NSLog(@"获得积分 %@",pkx.getScore);
                        NSLog(@"头像 %@",pkx.userIma);
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

@implementation PKMyRankingList

@synthesize userName, userNicheng, winMoney, getScore, userIma, moreData;

-(void)dealloc
{
    self.userName = nil;
    self.userNicheng = nil;
    self.winMoney = nil;
    self.getScore = nil;
    self.userIma = nil;
    self.moreData = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    