//
//  BuyLottery.h
//  Lottery
//
//  Created by  on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface GC_BuyLottery : NSObject
{
    NSInteger returnId; // 返回消息id
    NSString *systemTime; // 系统时间
    NSInteger returnValue; // 返回代码  返回值 ：1 保存成功，0 保存失败
    NSString *totalMoney; // 账户总金额
    NSString *betInfoID; // 投注信息id
    NSString *bettingMoney; // 投注金额
    /*******
     投注结果：
     0	操作成功！											
     1	用户未登录！											
     2	余额不足，请充值！											
     3	期次不存在	！											
     4	不是当前期								
     5	期次已截期										
     6	方案已满											
     7	发生异常											
     8	扣款失败(可能是余额不足或者账号被锁定等)
     *******/
    NSString * lotterytype;
    NSInteger  betresult;
    NSString * betResultInfo;
    NSString *number;
    NSString *curIssure;
    NSString *issure;
    NSString * msgString;//投注结果信息
    NSString *lotteryId;//彩种编号，手动设置非服务器返回
    NSString *kaijiangTime;//开奖时间
    NSString *paijiangTime;//派奖时间
    
}

@property(nonatomic) NSInteger returnId, returnValue, betresult;
@property(nonatomic, copy) NSString *systemTime, *totalMoney, *betInfoID, *bettingMoney, *lotterytype, * betResultInfo, *number ,*curIssure,*issure, * msgString ,*lotteryId,*kaijiangTime,*paijiangTime;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
- (id)initWithResponseData:(NSData *)_responseData isYueyu:(BOOL)isyueyu WithRequest:(ASIHTTPRequest *)request;//越狱仅限数字彩
- (id)initWithResponseData:(NSData *)_responseData isHemaiYueyu:(BOOL)isyueyu WithRequest:(ASIHTTPRequest *)request;
- (id)initWithResponseData:(NSData *)_responseData newWithRequest:(ASIHTTPRequest *)request;
- (id)initWithResponseData:(NSData *)_responseData newNotYYWithRequest:(ASIHTTPRequest *)request;
@end
