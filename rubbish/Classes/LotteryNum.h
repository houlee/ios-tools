//
//  LotteryNum.h
//  caibo
//
//  Created by cp365dev on 14-5-12.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface LotteryNum : NSObject
{
    NSInteger returnId;			// 返回消息id
    NSString *systemTime;		// 系统时间
    NSInteger cishu;            // 可抽奖次数
    NSString *jifen;            // 用户积分
    NSString *xiaohao_once;     // 抽奖一次消耗积分
    NSString *isCanExchange;    // 是否可兑换彩金 0不可兑换 1可兑换
    NSString *allPrize;         // 抽奖奖品清单
    NSMutableArray *allPrizeArray;//对应奖品清单数组
    NSMutableArray *allTypeArray; //对应奖品标志位数组
}


@property(nonatomic)NSInteger cishu,returnId;
@property(nonatomic,copy)NSString *systemTime,*jifen,*xiaohao_once,*isCanExchange,*allPrize;
@property(nonatomic, retain) NSMutableArray *allPrizeArray,*allTypeArray;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;


@end
