//
//  YuJiJinE.h
//  caibo
//
//  Created by  on 12-6-7.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface YuJiJinE : NSObject{
    NSInteger sysid;
    NSString * systime;
    NSString * maxmoney;
    NSString * minmoney;
}
@property (nonatomic, assign)NSInteger sysid;
@property (nonatomic, retain)NSString * systime;
@property (nonatomic, retain)NSString * maxmoney;
@property (nonatomic, retain)NSString * minmoney;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
@end
