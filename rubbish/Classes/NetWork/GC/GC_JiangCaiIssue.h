//
//  JiangCaiIssue.h
//  Lottery
//
//  Created by Jacob Chiang on 12-1-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
/**
 * 获取竞彩，北单期数（新）（1448） *
 **/

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface GC_JiangCaiIssue : NSObject{
    NSString *systemTime;
    NSInteger lotteryId;
    NSArray *issueData;

}
@property(nonatomic,retain)NSString *systemTime;
@property(nonatomic,assign)   NSInteger lotteryId;
@property(nonatomic,retain) NSArray *issueData;

- (id)initWithResponseData:(NSData *)responseData WithRequest:(ASIHTTPRequest *)request;


@end
