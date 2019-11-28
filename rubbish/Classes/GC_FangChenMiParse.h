//
//  GC_FangChenMiParse.h
//  caibo
//
//  Created by cp365dev on 14-9-17.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface GC_FangChenMiParse : NSObject
{
    NSInteger returnID;  //消息id
    NSString *systemTime; // 系统时间
    NSString *code;      //是否弹窗
    NSString *alertText;  //弹窗提示内容
    NSInteger alertNum;   //第几次弹窗
}

@property (nonatomic, copy) NSString *systemTime;
@property (nonatomic, copy) NSString *alertText;
@property (nonatomic) NSInteger returnID;
@property (nonatomic) NSInteger alertNum;
@property (nonatomic, copy) NSString *code;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
