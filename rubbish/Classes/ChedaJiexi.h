//
//  ChedaJiexi.h
//  caibo
//
//  Created by yaofuyu on 13-5-31.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface ChedaJiexi : NSObject {
    NSInteger returnId;			// 返回消息id
    
    NSString * code;//	1为成功。2，撤单失败。
    
    
    NSString *systemTime;          // 系统时间
    NSString * msgString;//1，	为成功。2，撤单失败。
    
}
@property(nonatomic)NSInteger returnId;
@property(nonatomic,copy)NSString *systemTime, *msgString, *code;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
