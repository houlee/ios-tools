//
//  WangQiZhongJiang.h
//  caibo
//
//  Created by yao on 12-7-4.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface WangQiZhongJiang : NSObject {
	NSInteger returnId;			// 返回消息id
    NSString *systemTime;		// 系统时间
	NSString *lottry;			//彩种
	NSInteger reRecordNum;		// 返回记录数
	NSInteger AllNum;			//投注总数
	NSMutableArray *brInforArray; //开奖号码数组
}

@property (nonatomic, assign) NSInteger returnId,reRecordNum,AllNum;
@property (nonatomic, copy) NSString *systemTime,*lottry;
@property (nonatomic, retain) NSMutableArray *brInforArray;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
