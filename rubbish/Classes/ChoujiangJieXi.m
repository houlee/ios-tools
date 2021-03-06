//
//  ChoujiangJieXi.m
//  caibo
//
//  Created by cp365dev on 14-5-12.
//
//

#import "ChoujiangJieXi.h"

#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation ChoujiangJieXi

@synthesize returnId,jiangpinleixing,cishu;
@synthesize systemTime,ZhongJiaState,ZhongJiaMsg,JiangPinID,AllName,jifen;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request {
    
    self = [super init];
    if (self) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
        {
            self.systemTime = [drs readComposString1];
            self.ZhongJiaState = [drs readComposString1];
            self.ZhongJiaMsg = [drs readComposString1];
            self.JiangPinID = [drs readComposString1];
            self.AllName = [drs readComposString1];
            self.jiangpinleixing = [drs readByte];
            self.jifen = [drs readComposString1];
            self.cishu = [drs readByte];
            
            NSLog(@"systemTime   :%@",self.systemTime);
            NSLog(@"ZhongJiaState:%@",self.ZhongJiaState);
            NSLog(@"ZhongJiaMsg  :%@",self.ZhongJiaMsg);
            NSLog(@"JiangPinID   :%@",self.JiangPinID);
            NSLog(@"AllName      :%@",self.AllName);
            NSLog(@"积分          :%@",self.jifen);
            
        }
        [drs release];
    }
    
    return self;
}

- (void)dealloc {
    self.systemTime = nil;
    self.ZhongJiaState = nil;
    self.ZhongJiaMsg = nil;
    self.JiangPinID = nil;
    self.AllName = nil;
    self.jifen = nil;
    [super dealloc];
}



@end



int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    