//
//  houYueInfoData.m
//  caibo
//
//  Created by houchenguang on 12-8-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "houYueInfoData.h"
#import "GC_RspError.h"
#import "GC_JingCaiDuizhenResult.h"

@implementation houYueInfoData
@synthesize sysid, systime, jilushu, listData;

- (void)dealloc{
    [systime release];
    [jilushu release];
    [listData release];
    [super dealloc];
}

- (id)initWithResponseData:(NSData *)responseData WithRequest:(ASIHTTPRequest *)request{
    if (self = [super init]) {
        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:responseData];
        if (drs) {
            NSInteger returnId= [drs readShort]; 
            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) {
                
                self.systime = [drs readComposString1];
                NSLog(@"系统时间 %@", systime);
                NSString * count = [drs readComposString1];//huozhe shi string
                NSLog(@"活跃列表数目 %d", [count intValue]);
                
                
                if ([count intValue] > 0) {
                    self.listData = [NSMutableArray arrayWithCapacity:[count intValue]];
                    for (int i = 0; i < [count intValue]; i++) {
                        
                        houYueInfoDataResult *result  = [[houYueInfoDataResult alloc] init];
                        result.jiaoyitime = [drs readComposString1];
                        result.username = [drs readComposString1];
                        result.jiaoyitype = [drs readComposString1];
                        result.shejimoney = [drs readComposString1];
                        result.yuliujiduan = [drs readComposString1];
                        [self.listData addObject:result];
                        
                        NSLog(@"交易时间 = %@", result.jiaoyitime);
                        NSLog(@"用户名 = %@", result.username);
                        NSLog(@"交易类型 = %@", result.jiaoyitype);
                        NSLog(@"金额 = %@", result.shejimoney);
                        NSLog(@"预留字段 = %@", result.yuliujiduan);
                        
                        [result release];
                    }  
                }           
            
            }
        
        }
        
        [drs release];
        
    }
    return self;
}


@end


@implementation houYueInfoDataResult
@synthesize jiaoyitime, username, jiaoyitype, shejimoney, yuliujiduan;

- (void)dealloc{
    [jiaoyitype release];
    [yuliujiduan release];
    [shejimoney release];
    [username release];
    [jiaoyitime release];
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    