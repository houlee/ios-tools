//
//  JiangCaiMatch.h
//  Lottery
//
//  Created by Jacob Chiang on 12-1-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/**
 *4.91	竞彩单场赛事列表（新）（1430）
 */

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface GC_JiangCaiMatch : NSObject{
    NSString *systemTime;
    NSMutableArray *matchList;
}

@property(nonatomic,retain) NSString *systemTime;
@property(nonatomic,retain)NSMutableArray *matchList;
- (id)initWithResponseData:(NSData *)responseData WithRequest:(ASIHTTPRequest *)request;

@end
