//
//  GC_AddBankCardInfo.m
//  caibo
//
//  Created by cp365dev on 14-8-7.
//
//

#import "GC_AddBankCardInfo.h"
#import "ASIHTTPRequest.h"
#import "GC_RspError.h"
@implementation GC_AddBankCardInfo
@synthesize returnID;
@synthesize code;
@synthesize systime;
@synthesize message;


- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
    if(self = [super init])
    {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        
        self.returnID = [drs readShort];
        NSLog(@"返回消息id %ld",(long)returnID);
        
        if(![GC_RspError parserError:drs returnId:returnID WithRequest:request])
        {
            self.systime = [drs readComposString1];
            self.code = [drs readByte];
            self.message = [drs readComposString1];
            
            NSLog(@"返回状态 : %ld  返回信息 : %@",(long)code,message);
        }
        
        [drs release];
    }
    
    return self;
}

-(void)dealloc
{
    
    systime = nil;
    message = nil;
    [super dealloc];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    