//
//  DIZhiJieXi.h
//  caibo
//
//  Created by cp365dev on 14-5-31.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface DIZhiJieXi : NSObject {
    NSInteger returnId;			// 返回消息id
    NSString *systemTime;		// 系统时间
    NSString *lingquStuse;      // 领取状态
}
@property (nonatomic,copy)NSString *systemTime,*lingquStuse;
@property (nonatomic)NSInteger returnId;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end