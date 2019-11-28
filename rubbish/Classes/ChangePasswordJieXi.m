//
//  ChangePasswordJieXi.m
//  caibo
//
//  Created by zhang on 1/19/13.
//
//

#import "ChangePasswordJieXi.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation ChangePasswordJieXi
@synthesize returnId,returnPasswordValue;
@synthesize systemTime;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request {

    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.returnId = [drs readShort];
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
		{
			
            self.systemTime = [drs readComposString1];
            self.returnPasswordValue = [drs readByte];
        }
        [drs release];
    }
    return self;

}

- (void)dealloc {

    [systemTime release];
    
    [super dealloc];
    
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    