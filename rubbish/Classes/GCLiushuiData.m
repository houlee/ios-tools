//
//  GCLiushuiData.m
//  caibo
//
//  Created by  on 12-5-22.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GCLiushuiData.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@implementation GCLiushuiData
@synthesize sysTime;
@synthesize xiaoxiID, coutpage, currpage, jilushu;
@synthesize allarray;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request
{
	if ((self = [super init])) {
         GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:_responseData];
        self.xiaoxiID = [drs readShort];
        if (![GC_RspError parserError:drs returnId:xiaoxiID WithRequest:request])
            {
            
            
            self.sysTime = [drs readComposString1];
            self.coutpage = [drs readShort];
            self.currpage = [drs readShort];
            self.jilushu = [drs readByte];
            
            if (jilushu > 0) {
                self.allarray = [NSMutableArray arrayWithCapacity:self.jilushu];
               
                
 //               NSString *priorYear  = @"";
                
                for (int i = 0; i < self.jilushu; i++) {
                    
                    GCLiushuiDataInfo * fdInfor = [[GCLiushuiDataInfo alloc] init];
                    fdInfor.caozuodate = [drs readComposString1];
                    
                    fdInfor.benmoney = [drs readComposString1];
                    fdInfor.houyue = [drs readComposString1];
                    fdInfor.bencijiang = [drs   readComposString1];
                    fdInfor.bencijyue = [drs readComposString1];
                    fdInfor.leixing = [drs readComposString1];
                    fdInfor.erleixing = [drs readComposString1];
                    fdInfor.ermingcheng = [drs readComposString1];
                    fdInfor.beizhu = [drs readComposString1];
                    fdInfor.dingdanhao = [drs readComposString1];
               
                    
                    NSLog(@"xiaoxiID = %d", (int)self.xiaoxiID);
                    NSLog(@"xitongshijian = %@", self.sysTime);
                    NSLog(@"zongyeshu = %d", (int)self.coutpage);
                    NSLog(@"dangqianye = %d", (int)self.currpage);
                    NSLog(@"jiulushu = %d", (int)self.jilushu);
                    
                    
                    NSLog(@"caozuoshijian = %@", fdInfor.caozuodate);
                    NSLog(@"bencicaozuojine = %@", fdInfor.benmoney);
                    NSLog(@"jiaoyihoujine = %@", fdInfor.houyue);
                    NSLog(@"bencicaozuojianglizhaohujine = %@",fdInfor.bencijiang);
                    NSLog(@"caozuohoujianlizhaohuyue = %@", fdInfor.bencijyue);
                    NSLog(@"caozuoleixing = %@", fdInfor.leixing);
                    NSLog(@"erjileixing = %@", fdInfor.erleixing);
                    NSLog(@"erjileixingmingcheng = %@", fdInfor.ermingcheng);
                    NSLog(@"beizhu = %@", fdInfor.beizhu);
                    NSLog(@"dingdanhao = %@",fdInfor.dingdanhao);
                    
                    
                    
//                    // 比较前一个日期和当前日期
//                   
                    if ([fdInfor.leixing isEqualToString:@"1"]) {
                        fdInfor.shoushumoney = [NSString stringWithFormat:@"+%@", fdInfor.benmoney];
                    }else if([fdInfor.leixing isEqualToString:@"2"] || [fdInfor.erleixing isEqualToString:@"6"]){
                        fdInfor.shoushumoney = [NSString stringWithFormat:@"-%@", fdInfor.benmoney];
                    
                    }else{
                        fdInfor.shoushumoney =  fdInfor.benmoney;
                    }
                    
                    
                    if ([fdInfor.erleixing isEqualToString:@"20"]) {
                        fdInfor.shoushumoney = [NSString stringWithFormat:@"+%@", fdInfor.bencijiang]; 
                    }
                    
                    
                    // 解析出来的数据都加入了 self.allarray里面   fdInfor数据模型类
                    [self.allarray addObject:fdInfor];
                    [fdInfor release];
                }
                

                
                
              
    
                
                
            }
            
            
            }
        
        [drs release];
    }
    return self;
}


- (void)dealloc
{
	[sysTime release];
    //[allarray release];
	[super dealloc];
}

@end


@implementation GCLiushuiDataInfo

@synthesize caozuodate,benmoney,houyue,bencijiang,bencijyue,leixing,erleixing,ermingcheng,beizhu,dingdanhao,shoushumoney, oneBool;

- (void)dealloc{

    [shoushumoney release];
    [caozuodate release];
    [benmoney release];
    [houyue release];
    [bencijiang release];
    [bencijyue release];
    [leixing release];
    [erleixing release];
//    [erleixing release];
    [ermingcheng release];
    [beizhu release];
    [dingdanhao release];
    [super dealloc];
}

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    