//
//  GC_LianDongYouShiData.h
//  caibo
//
//  Created by GongHe on 14-4-21.
//
//

#import <Foundation/Foundation.h>
@class ASIHTTPRequest;
@interface GC_LianDongYouShiData : NSObject
{
    NSInteger returnId;
    NSString * sysTime;//系统时间
    NSInteger returnMessage;//返回信息      0成功，5充值信息提交失败
    NSString * orderNumber;//订单号
    NSInteger payType;//支付类型      1只支持信用卡     8只支持借记卡    9支持信用卡和借记卡
    NSString * showMessage;//返回提示信息
    NSString * merCustId;//商户号
    NSString * realName;//真实姓名
    NSString * idCard;//身份证号码
}

@property (nonatomic, assign)NSInteger returnId, returnMessage, payType;
@property (nonatomic, retain)NSString * sysTime, * orderNumber, * showMessage, * merCustId, * realName, * idCard;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
