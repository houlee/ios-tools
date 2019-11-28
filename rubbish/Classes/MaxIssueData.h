//
//  MaxIssueData.h
//  caibo
//
//  Created by houchenguang on 13-2-25.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface MaxIssueData : NSObject{
    NSInteger sysid;
    NSString * systime;
    NSString * lotterId;
    NSInteger maxcount;
    NSString * yuliustring;
}

@property (nonatomic, retain)NSString * systime, * lotterId, *yuliustring;
@property (nonatomic, assign)NSInteger sysid, maxcount;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
