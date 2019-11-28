//
//  PointExchangeJieXi.h
//  caibo
//
//  Created by cp365dev on 14-6-3.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface PointExchangeJieXi : NSObject
{
    int exchangeState; //积分兑换彩金状态
    NSString *exchangeMess; //积分兑换彩金返回信息
    NSInteger returnId;			// 返回消息id
    NSString *systemTime;		// 系统时间
    
}
@property (nonatomic, copy) NSString *exchangeMess;
@property (nonatomic) int exchangeState;
@property (nonatomic)NSInteger returnId;
@property (nonatomic,copy)NSString *systemTime;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
@end
