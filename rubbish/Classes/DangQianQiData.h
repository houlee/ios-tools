//
//  DangQianQiData.h
//  caibo
//
//  Created by houchenguang on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface DangQianQiData : NSObject{
     NSInteger xxid;
    NSString * systime;
    NSString * returnVal;
    NSString * yuliu;
}
@property (nonatomic, assign)NSInteger xxid;
@property (nonatomic, retain)NSString * systime, * returnVal, * yuliu;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
@end
