//
//  DownGoodVoiceJieXie.h
//  caibo
//
//  Created by yaofuyu on 13-1-18.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface DownGoodVoiceJieXie : NSObject {
    NSInteger returnId;			// 返回消息id
    NSString *systemTime;		// 系统时间
    NSString *orderid;         // 方案号
    NSInteger timeLong;          // 时长
    NSString *other;          // 预留字段
    NSData *goodVoiceData;
    NSString *username;         //发起人；
}
@property(nonatomic)NSInteger returnId,timeLong;
@property(nonatomic,copy)NSString *systemTime,*other,*orderid,*username;
@property (nonatomic,retain)NSData *goodVoiceData;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
