//
//  LotteryNum.m
//  caibo
//
//  Created by cp365dev on 14-5-12.
//
//

#import "LotteryNum.h"
#import "GC_RspError.h"


@implementation LotteryNum

@synthesize cishu,returnId;
@synthesize systemTime;
@synthesize jifen;
@synthesize xiaohao_once;
@synthesize isCanExchange;
@synthesize allPrize;
@synthesize allPrizeArray;
@synthesize allTypeArray;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request {
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        NSLog(@"返回消息id %ld",(long) self.returnId);
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
		{
			self.systemTime = [drs readComposString1];
            self.cishu = [drs readByte];
            self.jifen = [drs readComposString1];
            self.xiaohao_once = [drs readComposString1];
            self.isCanExchange = [drs readComposString1];
            self.allPrize = [drs readComposString2];
            NSLog(@"抽奖次数: %ld",(long)self.cishu);
            NSLog(@"积分: %@",self.jifen);
            NSLog(@"抽奖一次消耗积分: %@",self.xiaohao_once);
            NSLog(@"是否可兑换彩金: %@",self.isCanExchange);
            NSLog(@"奖品清单: %@",self.allPrize);
            if(self.allPrize && ![self.allPrize isEqualToString:@"null"] && self.allPrize.length){
            
                NSMutableArray *array = [NSMutableArray arrayWithArray:[self.allPrize componentsSeparatedByString:@"&"]];
                
                //服务器返回少于8条数据，其余用“谢谢参与”补齐
                if(array.count < 8){
                
                    for(int i =0;i<8-[array count];i++){
                    
                        [array addObject:[NSString stringWithFormat:@"%d-谢谢参与",(int)[array count]+1]];
                    }
                }
                
                self.allPrizeArray = [NSMutableArray arrayWithCapacity:array.count];
                self.allTypeArray = [NSMutableArray arrayWithCapacity:array.count];

                
                for(int i = 0;i<8;i++){
                
                    NSString *prize = [[[array objectAtIndex:i] componentsSeparatedByString:@"-"] objectAtIndex:1];
                    NSString *type = [[[array objectAtIndex:i] componentsSeparatedByString:@"-"] objectAtIndex:0];
                    [self.allPrizeArray addObject:prize];
                    [self.allTypeArray addObject:type];
                }
            }

        }
        [drs release];
    }
    return self;
}

-(void)dealloc
{
    self.allPrize = nil;
    self.systemTime = nil;
    self.jifen = nil;
    self.xiaohao_once = nil;
    self.isCanExchange = nil;
    [super dealloc];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    