//
//  BetRecordJiangLi.h
//  caibo
//
//  Created by zhang on 2/26/13.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@class GC_BetRecord;

@interface BetRecordJiangLi : NSObject {
    
	NSInteger returnId;			// 返回消息id
    NSString *systemTime;		// 系统时间
	NSString *lotteryId;		// 彩种
	NSInteger isSelf;			//是否是本人，1是是
	NSInteger totalPage;		// 总页数
	NSInteger curPage;			// 当前页
	NSInteger reRecordNum;		// 返回记录数
	NSString *ZhanghuAmount;	// 账户余额；
	NSString *jiangLiAmount;	// 奖励金额
	NSString *dongjieAmount;	// 冻结金额
	
	NSMutableArray *brInforArray;
}

@property (nonatomic, assign) NSInteger isSelf,returnId, totalPage, curPage, reRecordNum;
@property (nonatomic, copy) NSString *systemTime, *lotteryId,*ZhanghuAmount,*jiangLiAmount,*dongjieAmount;
@property (nonatomic, retain) NSMutableArray *brInforArray;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
- (GC_BetRecord *)changeToGC_betRecord;

@end