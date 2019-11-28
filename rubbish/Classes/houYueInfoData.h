//
//  houYueInfoData.h
//  caibo
//
//  Created by houchenguang on 12-8-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"


@interface houYueInfoData : NSObject{
    NSInteger sysid;
    NSString * systime;
    NSString * jilushu;
    NSMutableArray * listData;

}
@property (nonatomic)NSInteger sysid;
@property (nonatomic, retain)NSString * systime,* jilushu;
@property (nonatomic, retain)NSMutableArray * listData;

- (id)initWithResponseData:(NSData *)responseData WithRequest:(ASIHTTPRequest *)request;

@end

@interface houYueInfoDataResult : NSObject{
    NSString * jiaoyitime;
    NSString * username;
    NSString * jiaoyitype;
    NSString * shejimoney;
    NSString * yuliujiduan;
    
    
}

@property (nonatomic, retain)NSString * jiaoyitime,* username,* jiaoyitype,* shejimoney,* yuliujiduan;


@end