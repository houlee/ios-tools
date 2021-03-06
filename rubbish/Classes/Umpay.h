//
//  Umpay.h
//  UmpaySDK
//
//  Created by Wang Haijun on 12-1-19.
//  Copyright (c) 2012年 Umpay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UmpayElements.h"
@protocol UmpayDelegate <NSObject>

@required

- (void)onPayResult:(NSString*)orderId resultCode:(NSString*)resultCode resultMessage:(NSString*)resultMessage;


@end


@interface Umpay : NSObject

//支付
+ (BOOL)pay:(NSString *)tradeNo merCustId:(NSString*)merCustId shortBankName:(NSString*)shortBankName cardType:(NSString*)cardType payDic:(UmpayElements*)payDic rootViewController:(UIViewController*)rootViewController delegate:(id<UmpayDelegate>)delegate;
//签约
+ (BOOL)sign:(NSString *)merId merCustId:(NSString*)merCustId signInfo:(NSString*)signInfo shortBankName:(NSString*)shortBankName cardType:(NSString*)cardType payDic:(UmpayElements*)payDic  rootViewController:(UIViewController*)rootViewController delegate:(id<UmpayDelegate>)delegate;


@end
