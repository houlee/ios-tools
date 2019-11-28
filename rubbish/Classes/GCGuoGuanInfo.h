//
//  GCGuoGuanInfo.h
//  caibo
//
//  Created by houchenguang on 12-8-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface GCGuoGuanInfo : NSObject{
    NSInteger sysid;
    NSString * systime;
    NSString * lottid;
    NSString * issue;
    NSString * quanguo;
    NSString * caiguo;
    NSString * yubei;
}
@property (nonatomic, assign)NSInteger sysid;
@property (nonatomic, retain)NSString * systime, * lottid, * issue, * quanguo, * caiguo, * yubei;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
@end
