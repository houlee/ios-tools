//
//  GC_FangChenMiParse.m
//  caibo
//
//  Created by cp365dev on 14-9-17.
//
//

#import "GC_FangChenMiParse.h"
#import "ASIHTTPRequest.h"
#import "GC_RspError.h"
@implementation GC_FangChenMiParse

@synthesize alertNum;
@synthesize alertText;
@synthesize returnID;
@synthesize systemTime;
@synthesize code;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    
    if(self = [super init])
    {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        
        self.returnID = [drs readShort];
        NSLog(@"返回消息id %d",(int)returnID);
        
        if(![GC_RspError parserError:drs returnId:returnID WithRequest:request])
        {
            self.systemTime = [drs readComposString1];
            self.code = [drs readComposString1];
            self.alertText = [drs readComposString2];
            self.alertNum = [drs readByte];
            NSLog(@"是否弹窗  :%@  弹窗文字: %@ 第几次弹窗:%d",code,alertText,(int)alertNum);
        }
        
        [drs release];
    }
    
    return self;
}

-(void)dealloc
{
    
    alertText = nil;
    systemTime = nil;
    code = nil;
    [super dealloc];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    