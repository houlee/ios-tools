//
//  GC_ZhiFuBaoData.h
//  caibo
//
//  Created by yaofuyu on 13-6-20.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface GC_ZhiFuBaoData : NSObject {
    NSInteger returnId;
    NSString * sysTime;//系统时间
    NSString *name;//用户名
    NSString *money;//充值金额
    NSString * zhifubaoNum;//支付宝流水号
    NSString *zhifuBaoContent;//支付宝提交内容
}
@property (nonatomic, assign)NSInteger returnId;

@property (nonatomic, retain)NSString * sysTime, *name,*money,* zhifubaoNum, *zhifuBaoContent;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
