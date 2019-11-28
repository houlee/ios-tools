//
//  YinLianBackInfo.h
//  caibo
//
//  Created by cp365dev on 14-8-7.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface GC_YinLianBackInfo : NSObject
{
    NSInteger returnID;  //返回id
    NSString *systemTime;//系统时间
    NSInteger code;
    
}

@property (nonatomic) NSInteger returnID;
@property (nonatomic, copy) NSString *systemTime;//系统时间
@property (nonatomic) NSInteger code;


- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;


@end

