//
//  GC_CardListInfo.m
//  caibo
//
//  Created by cp365dev on 14-8-7.
//
//

#import "GC_CardListInfo.h"
#import "GC_RspError.h"
#import "GC_DataReadStream.h"
@implementation GC_CardListInfo
@synthesize systemTime;
@synthesize yueMoney;
@synthesize cardMess;
@synthesize canTiKMoney;
@synthesize returnID;
@synthesize jiangLiMoney;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if(self = [super init])
    {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:request.responseData];
        self.returnID = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnID WithRequest:request])
        {
            self.systemTime = [drs readComposString1];
            self.yueMoney = [drs readComposString1];
            self.canTiKMoney = [drs readComposString1];
            self.jiangLiMoney = [drs readComposString1];
            self.cardMess = [drs readComposString2];
            
            NSLog(@"系统时间: %@  用户余额 :%@  可提款金额 :%@  奖励金额 :%@  银行卡信息 :%@",systemTime,yueMoney,canTiKMoney,jiangLiMoney,cardMess);
            
        }
        
        [drs release];
    }
    return self;
}
-(void)dealloc
{
    
    yueMoney = nil;
    canTiKMoney = nil;
    cardMess = nil;
    systemTime = nil;
    jiangLiMoney =nil;
    [super dealloc];
    
    
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    