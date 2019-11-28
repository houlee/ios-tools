//
//  PopularizeData.h
//  caibo
//
//  Created by houchenguang on 13-8-12.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface PopularizeData : NSObject{

    NSInteger sysid;
    NSString * sysTime;
    NSString * returnType;//返回状态码
    NSString * returnMsg;//返回信息
    NSString * setyn;//是否设置
    NSString * yuliu;
}
@property(nonatomic, retain)NSString * sysTime,* returnType,* returnMsg,* setyn,* yuliu;
@property (nonatomic, assign)NSInteger sysid;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
@end
