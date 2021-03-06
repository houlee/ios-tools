//
//  GC_YHMInfoParser.m
//  caibo
//
//  Created by cp365dev on 15/1/22.
//
//

#import "GC_YHMInfoParser.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"
@implementation GC_YHMInfoParser
@synthesize returnId;
@synthesize systemTime;
@synthesize allCount;
@synthesize YHMInfoArray;
@synthesize curCount;
-(void)dealloc{

    
    systemTime = nil;
    [super dealloc];
}
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{

    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        if (drs) {
            self.returnId = [drs readShort];
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
            {
                self.systemTime = [drs readComposString1];
                self.curCount = [drs readShort];
                self.allCount = [drs readShort];
                NSLog(@"优惠码当前页条数 %ld",(long)self.curCount);
                NSLog(@"优惠码条数 %ld",(long)self.allCount);
                
                if(self.curCount){
                
                    self.YHMInfoArray = [NSMutableArray arrayWithCapacity:self.curCount];

                }
                for(int i = 0;i<self.curCount;i++){
                
                    YHMInfo *info = [[YHMInfo alloc] init];
                    info.YHM_Type = [drs readComposString1];
                    info.YHM_mes = [drs readComposString1];
                    info.YHM_time = [drs readComposString1];
                    info.YHM_code = [drs readComposString1];
                    info.YHM_chong = [drs readComposString1];
                    info.YHM_yhmJE = [drs readComposString1];
                    info.YHM_yuliu = [drs readComposString1];
                    NSLog(@"优惠码状态 %@",info.YHM_Type);
                    NSLog(@"优惠码信息 %@",info.YHM_mes);
                    NSLog(@"优惠码有效期 %@",info.YHM_time);
                    NSLog(@"优惠码code %@",info.YHM_code);
                    NSLog(@"充值金额: %@",info.YHM_chong);
                    NSLog(@"优惠码金额: %@",info.YHM_yhmJE);

                    [self.YHMInfoArray addObject:info];
                    [info release];
                    
                }
               

            }
        }
        [drs release];
    }
    

    
    return self;
}
@end


@implementation YHMInfo

@synthesize YHM_code;
@synthesize YHM_mes;
@synthesize YHM_time;
@synthesize YHM_Type;
@synthesize YHM_yuliu;
@synthesize YHM_chong;
@synthesize YHM_yhmJE;

-(void)dealloc{

    YHM_yhmJE = nil;
    YHM_chong = nil;
    YHM_yuliu = nil;
    YHM_Type = nil;
    YHM_time = nil;
    YHM_mes = nil;
    YHM_code = nil;
    [super dealloc];

}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    