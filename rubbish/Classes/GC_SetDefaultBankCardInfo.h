//
//  GC_SetDefaultBankCardInfo.h
//  caibo
//
//  Created by cp365dev on 14-8-7.
//
//

#import <Foundation/Foundation.h>
#import "ASIHttpRequest.h"
@interface GC_SetDefaultBankCardInfo : NSObject
{
    NSInteger returnID;
    NSString *systime;
    NSInteger code;
    NSString *message;
}

@property (nonatomic) NSInteger returnID;
@property (nonatomic, copy) NSString *systime;
@property (nonatomic) NSInteger code;
@property (nonatomic, copy) NSString *message;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
