//
//  GC_LianLianYinTongData.h
//  caibo
//
//  Created by yaofuyu on 14-3-13.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface GC_LianLianYinTongData : NSObject{
    
    NSInteger returnId;
    NSString * sysTime;//系统时间
    NSInteger returnMessage;//返回信息
    NSString * returnContent;//返回内容  银联流水号
    NSString * Other;  //预留信息，变成用户id
    NSString * realInfo;//实名信息
    /*注意：
     返回值：
     0充值信息提交成功
     1充值金额不能小于1元
     2用户名不能为空
     3 渠道不能为空
     100充值信息提交失败
     */
    
    
}
@property (nonatomic, assign)NSInteger returnMessage, returnId;

@property (nonatomic, retain)NSString * sysTime, * returnContent, *Other ,*realInfo;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
