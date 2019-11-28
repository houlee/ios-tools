//
//  ChangePasswordJieXi.h
//  caibo
//
//  Created by zhang on 1/19/13.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface ChangePasswordJieXi : NSObject {

    NSInteger returnId;//返回消息id
    NSString *systemTime;//系统时间
    NSInteger returnPasswordValue;//修改密码返回值
}
@property (nonatomic)NSInteger returnId,returnPasswordValue;
@property (nonatomic,copy)NSString *systemTime;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
@end
