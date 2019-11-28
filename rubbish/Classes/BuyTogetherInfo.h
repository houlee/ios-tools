//
//  BuyTogetherInfo.h
//  Lottery
//
//  Created by Joy Chiang on 11-12-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface BuyTogetherInfo : NSObject {
    NSInteger returnID;
    NSInteger pageCount;
    NSInteger currentPageNumber;
    NSInteger recordCount;
    NSString *systemTime;
    
    NSMutableArray *schemeArray;
}

@property(nonatomic, assign) NSInteger returnID, pageCount, currentPageNumber, recordCount;
@property(nonatomic, copy) NSString *systemTime;
@property(nonatomic, retain) NSMutableArray *schemeArray;

- (id)initWithResponseData:(NSData *)responseData WithRequest:(ASIHTTPRequest *)request;

@end