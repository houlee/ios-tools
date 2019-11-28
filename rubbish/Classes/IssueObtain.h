//
//  IssueObtain.h
//  caibo
//
//  Created by houchenguang on 12-11-6.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface IssueObtain : NSObject{

    NSInteger xiaoxiid;
    NSString * systime;
    NSString * lotteryId;
    NSString * issuestring;
    
}
@property (nonatomic, retain)NSString * issuestring, * systime , *lotteryId;
@property (nonatomic, assign)NSInteger xiaoxiid;

- (id)initWithResponseData:(NSData *)responseData WithRequest:(ASIHTTPRequest *)request;
@end
