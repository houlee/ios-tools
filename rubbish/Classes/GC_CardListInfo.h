//
//  GC_CardListInfo.h
//  caibo
//
//  Created by cp365dev on 14-8-7.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface GC_CardListInfo : NSObject
{
    NSInteger returnID;  //返回id
    NSString *systemTime;//系统时间
    NSString *yueMoney; //余额
    NSString *canTiKMoney; //可提款金额
    NSString *jiangLiMoney; //奖励金额
    NSString *cardMess;   // 银行卡信息
    
}

@property (nonatomic) NSInteger returnID;
@property (nonatomic, copy) NSString *systemTime;//系统时间
@property (nonatomic, copy) NSString *yueMoney; //余额
@property (nonatomic, copy) NSString *canTiKMoney; //可提款金额
@property (nonatomic, copy) NSString *jiangLiMoney;//奖励金额
@property (nonatomic, copy) NSString *cardMess;   // 银行卡信息

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;


@end
