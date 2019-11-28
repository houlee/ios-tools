//
//  JiFenBuyLotteryData.h
//  caibo
//
//  Created by GongHe on 15-3-11.
//
//

#import <Foundation/Foundation.h>

@class ASIHTTPRequest;

@interface JiFenBuyLotteryData : NSObject
{
    int returnId; // 返回消息id
    NSString * systemTime;//系统时间
    NSString * returnValue;//投注状态码
    NSString * message;//提示信息
    NSString * fangAnCode;//方案编号
}

@property(nonatomic, assign)int returnId;
@property(nonatomic, retain)NSString * systemTime;
@property(nonatomic, retain)NSString * returnValue;
@property(nonatomic, retain)NSString * message;
@property(nonatomic, retain)NSString * fangAnCode;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
