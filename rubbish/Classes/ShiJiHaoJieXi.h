//
//  ShiJiHaoJieXi.h
//  caibo
//
//  Created by yaofuyu on 12-11-9.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface ShiJiHaoJieXi : NSObject {
    NSInteger returnId;			// 返回消息id
    NSString *systemTime;		// 系统时间
    NSString *shiJiNum;         // 试机号
    NSString *other;          // 预留字段
}
@property(nonatomic)NSInteger returnId;
@property(nonatomic,copy)NSString *systemTime,*other,*shiJiNum;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
