//
//  JingCaiDuizhenChaXun.h
//  Lottery
//
//  Created by Jacob Chiang on 12-1-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
/***
 *
 *4.109	竞彩对阵查询（新）（1449）
 ********/

#import <Foundation/Foundation.h>
#import "GC_DataReadStream.h"
#import "ASIHTTPRequest.h"
@interface GC_JingCaiDuizhenChaXun : NSObject{
    NSMutableArray *listData;
    NSInteger count;
    NSInteger returnId;
    NSString * sysTimeString;
    NSString * dateString;
    NSInteger updata;
    NSString * beginTime;//开始出票时间
    NSString * beginInfo;//内容
}
@property(nonatomic,retain)  NSMutableArray *listData;
@property (nonatomic, assign)NSInteger count, returnId, updata;
@property (nonatomic, retain)NSString * sysTimeString, * dateString, * beginTime, * beginInfo;

- (id)initWithResponseData:(NSData *)responseData WithRequest:(ASIHTTPRequest *)request;

@end
