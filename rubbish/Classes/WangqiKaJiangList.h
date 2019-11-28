//
//  WangqiKaJiangList.h
//  caibo
//
//  Created by yao on 12-7-4.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface WangqiKaJiangList : NSObject {
	NSInteger returnId;			// 返回消息id
    NSString *systemTime;		// 系统时间
	NSInteger reRecordNum;		// 返回记录数
	NSInteger allNum;
	NSString *lottry;//彩种；
	NSMutableArray *brInforArray; //开奖号码数组

}
@property (nonatomic, assign) NSInteger returnId,reRecordNum,allNum;
@property (nonatomic, copy) NSString *systemTime,*lottry;
@property (nonatomic, retain) NSMutableArray *brInforArray;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end

//合买信息格式定义
@interface KaiJiangInfo : NSObject {
	
	
	NSString *issue;              //期号
	NSString *num;			//开奖号码
	NSString  *kaijiangTime; //开奖时间；
}

@property (nonatomic, copy)NSString *issue, *num,*kaijiangTime;

@end;
