//
//  IssueObtain.m
//  caibo
//
//  Created by houchenguang on 12-11-6.
//
//

#import "IssueObtain.h"
#import "SchemeInfo.h"
#import "GC_RspError.h"

@implementation IssueObtain 
@synthesize systime, issuestring, xiaoxiid, lotteryId;
   

- (id)initWithResponseData:(NSData *)responseData WithRequest:(ASIHTTPRequest *)request{
    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:responseData];
        self.xiaoxiid = [drs readShort];
        
       
        if (![GC_RspError parserError:drs returnId:xiaoxiid WithRequest:request]) {
            self.systime = [drs readComposString1];
            
            self.lotteryId = [drs readComposString1];
            self.issuestring = [drs readComposString2];
            
           
            
            NSLog(@"系统时间:%@", systime);
            NSLog(@"彩种:%@", self.lotteryId);
            NSLog(@"追号日期:%@", self.issuestring);
          
        }
        
        [drs release];
    }
    return self;

}


- (void)dealloc{
    [systime release];
    [issuestring release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    