//
//  ActivateInfoData.m
//  caibo
//
//  Created by houchenguang on 14-4-22.
//
//

#import "ActivateInfoData.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation ActivateInfoData
@synthesize sysId, sysTime, total, yesterday, history, myriad, award, dateYear, yieldRateArray;

- (void)dealloc{
    [sysTime release];
    [total release];
    [yesterday release];
    [history release];
    [myriad release];
    [award release];
    
    [yieldRateArray release];
    [super dealloc];
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
	if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.sysId = [drs readShort];
        NSLog(@"返回消息id %d", (int)self.sysId);
        if (![GC_RspError parserError:drs returnId:sysId WithRequest:request])
		{
			
            self.sysTime = [drs readComposString1];
            self.total = [drs readComposString1];
            self.yesterday = [drs readComposString1];
            self.history = [drs readComposString1];
            self.myriad = [drs readComposString1];
            self.award = [drs readComposString1];
            self.dateYear = [drs readByte];
            
            NSMutableArray * yieldArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i < self.dateYear; i++) {
                [yieldArray addObject:[drs readComposString1]];
            }
            self.yieldRateArray = yieldArray;
            [yieldArray release];
            
            NSLog(@"系统时间 %@", self.sysTime);
            NSLog(@"总资产(元) %@", self.total);
            NSLog(@"昨日收益(元) %@", self.yesterday);
            NSLog(@"历史累计收益(元) %@", self.history);
            NSLog(@"彩金奖励总计(元) %@", self.award);
            NSLog(@"万份收益(元) %@", self.myriad);
            NSLog(@"几日年化收益 %d", (int)self.dateYear);
            NSLog(@"年化收益率 %@", self.yieldRateArray);
            
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