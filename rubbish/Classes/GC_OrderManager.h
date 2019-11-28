//
//  GC_OrderManager.h
//  caibo
//
//  Created by cp365dev on 14/12/25.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface GC_OrderManager : NSObject{
    NSInteger returnId;             //返回消息id
    NSString *systemTime;           //系统时间
    NSString *isSucc;               //是否到账——0是 1否
    NSString *message;              //提示信息
    NSString *money;                //到账金额
}

@property (nonatomic) NSInteger returnId;

@property (nonatomic, copy) NSString *systemTime,*isSucc,*message,*money;


- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;


@end
