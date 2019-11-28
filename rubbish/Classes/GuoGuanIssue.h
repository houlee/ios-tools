//
//  GuoGuanIssue.h
//  caibo
//
//  Created by  on 12-6-15.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface GuoGuanIssue : NSObject{
    NSInteger returnid;
    NSString * systime;
    NSInteger issuelen;
    NSMutableArray *details; // detail列表
}
@property (nonatomic, retain)NSMutableArray *details; // detail列表
@property (nonatomic, retain)NSString * systime;
@property (nonatomic, assign)NSInteger returnid;
@property (nonatomic, assign)NSInteger issuelen;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
@end

@interface GuoGuanIssueDetail : NSObject {
    NSString * startTime;
    NSString * status;
    NSString * issue;
    NSString * openTime;
    NSString * endTime;

}
@property(nonatomic, copy) NSString * startTime, * status, * issue, * openTime, * endTime;
@end