//
//  YearActivateData.m
//  caibo
//
//  Created by houchenguang on 14-4-22.
//
//

#import "YearActivateData.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation YearActivateData
@synthesize sysTime, activity, dateString, sevenData, sysId, typeString;

- (void)dealloc{
    [typeString release];
    [sysTime release];
    [activity release];
    [dateString release];
    [sevenData release];
    [super dealloc];
}

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
	if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.sysId = [drs readShort];
        NSLog(@"返回消息id %li", (long)self.sysId);
        if (![GC_RspError parserError:drs returnId:sysId WithRequest:request])
		{
			
            self.sysTime = [drs readComposString1];
            self.sevenData = [drs readComposString1];
            self.activity = [drs readComposString1];
            self.dateString = [drs readComposString1];
            self.typeString = [drs readComposString1];
            NSLog(@"系统时间 %@", self.sysTime);
            NSLog(@"7日年化收益率 %@", self.sevenData);
            NSLog(@"活动彩金赠送 %@", self.activity);
            NSLog(@"日期 %@", self.dateString);
            NSLog(@"销售状态 %@", self.typeString);
          
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