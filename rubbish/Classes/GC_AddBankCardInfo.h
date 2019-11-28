//
//  GC_AddBankCardInfo.h
//  caibo
//
//  Created by cp365dev on 14-8-7.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface GC_AddBankCardInfo : NSObject
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
