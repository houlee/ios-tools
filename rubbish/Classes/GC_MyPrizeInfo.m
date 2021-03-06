//
//  GC_MyPrizeInfo.m
//  caibo
//
//  Created by cp365dev on 15/1/22.
//
//

#import "GC_MyPrizeInfo.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GC_MyPrizeInfo
@synthesize returnId;
@synthesize systemTime;
@synthesize prizeArray;
@synthesize prizeCount;
@synthesize pageCount;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request{

    if ((self = [super init])) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        if (drs) {
            self.returnId = [drs readShort];
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request])
            {
                self.systemTime = [drs readComposString1];
                self.prizeCount = [drs readByte];
                self.pageCount = [drs readByte];

                NSLog(@"奖品包数量 :%d",(int)self.prizeCount);
                
                if(self.pageCount){
                    
                    self.prizeArray = [NSMutableArray arrayWithCapacity:self.pageCount];

                }
                for(int i = 0;i<self.pageCount;i++){
                
                    PrizeInfo *prize = [[PrizeInfo alloc] init];
                    prize.prize_info = [drs readComposString1];
                    prize.get_type = [drs readComposString1];
                    prize.prize_time = [drs readComposString1];
                    prize.prize_type = [drs readComposString1];

                    
                    NSLog(@"奖品内容 %@",prize.prize_info);
                    
                    NSArray *array = [prize.prize_info componentsSeparatedByString:@" "];
                    if(array && [array count]==2){
                    
                        prize.prize_info_type = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
                        NSMutableString *testPrizeCount = [NSMutableString stringWithFormat:@"%@",[array objectAtIndex:1]];
                        if([testPrizeCount hasSuffix:@"元"]){
                        
                            prize.prize_info_count = [testPrizeCount stringByReplacingOccurrencesOfString:@"元" withString:@""];
                            prize.prize_info_count1 = @"元";
                        }
                        else{
                        
                            prize.prize_info_count =  [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
                        }
                    }
                    
                    
                    NSLog(@"获得类型 %@",prize.get_type);
                    NSLog(@"获取时间 %@",prize.prize_time);
                    NSLog(@"奖品类型 %@",prize.prize_type);


                    [self.prizeArray addObject:prize];
                    [prize release];
                }
            }
        }
        [drs release];
    }
    
    
    return self;
}
-(void)dealloc{

    systemTime = nil;
    [super dealloc];
}

@end


@implementation PrizeInfo
@synthesize prize_info;
@synthesize prize_time;
@synthesize prize_type;
@synthesize get_type;
@synthesize prize_info_count;
@synthesize prize_info_type;
@synthesize prize_info_count1;
-(void)dealloc{

    self.prize_info_count1 = nil;
    self.prize_info_type = nil;
    self.prize_info_count = nil;
    self.prize_type = nil;
    self.prize_time = nil;
    self.prize_info = nil;
    self.get_type = nil;
    [super dealloc];

}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    