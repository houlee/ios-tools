//
//  GC_VersionCheck.h
//  caibo
//
//  Created by  on 12-6-5.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface GC_VersionCheck : NSObject {
    NSInteger returnId;    // 返回消息id
    NSString *systemTime;  // 系统时间
    NSInteger reVer;       // 版本检测返回值
    NSInteger lastVerNum;  // 最新版本号
    NSString *updateAddr;  // 最新版更新地址
}

@property (nonatomic, copy) NSString *systemTime, *updateAddr;
@property (nonatomic, assign) NSInteger returnId, reVer, lastVerNum;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
