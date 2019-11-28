//
//  QQPaySDK.h
//  QQPaySDK
//
//  Created by tenpay on 13-9-17.
//  Copyright (c) 2013年 tenpay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQPaySDK : NSObject

//检查当前系统环境是否可以支持使用QQPay
+(Boolean)isQQPayWork;




//准备跳转到手机QQ进行支付,该接口已经过期，请使用 startSafeQQPay
//tokenId -- 订单号，通过向财付通后台下单得到
//appName -- schema响应名称，具体意义参考SDK文档
//appId   -- 默认为空，如果不为空，则代替appName,具体意义参考SDK文档
+(Boolean)startQQPay:(NSString*)tokenId appName:(NSString*)appName appId:(NSString*)appId;



//准备跳转到手机QQ进行支付
//token_id -- 订单号，通过向财付通后台下单得到
//bargainor_id -- 商户号ID，财付通分配，需要申请
//app_name -- schema响应名称，具体意义参考SDK文档
//appid   -- 财付通分配给该app的一个标识，需要申请,具体意义参考SDK文档
//sign  --对当前支付请求的签名串，具体意义参考SDK文档
+(Boolean)startSafeQQPay:(NSString*)token_id bargainor_id:(NSString*)bargainor_id app_name:(NSString*)app_name appid:(NSString*)appid sign:(NSString*)sign;


@end
