//
//  JiangLIJieXi.h
//  caibo
//
//  Created by yaofuyu on 13-2-26.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface JiangLIJieXi : NSObject {
    NSInteger returnId;			// 返回消息id
    NSString *code;         // code
    NSString *msg;          // 错误消息
    NSString *other;          // 预留字段
}
@property(nonatomic)NSInteger returnId;
@property(nonatomic,copy)NSString *other,*code ,*msg;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
