//
//  EidteBaoMiJieXie.h
//  caibo
//
//  Created by yaofuyu on 13-1-20.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface EidteBaoMiJieXie : NSObject {
    NSInteger returnId;			// 返回消息id
    NSString *systemTime;		// 系统时间
    NSString *code;         // code
    NSString *msg;          // 错误消息
    NSString *other;          // 预留字段
}
@property(nonatomic)NSInteger returnId;
@property(nonatomic,copy)NSString *systemTime,*other,*code ,*msg;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
