//
//  HeartInfo.h
//  Lottery
//
//  Created by Teng Kiefer on 12-2-8.
//  Copyright (c) 2012年 windo-soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface GC_HeartInfo : NSObject
{
    NSInteger returnId; // 返回消息id
    NSString *systemTime; // 系统时间
    NSString *sessionId; // Session id
}

@property(nonatomic, assign) NSInteger returnId;
@property(nonatomic, copy) NSString *systemTime, *sessionId;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
