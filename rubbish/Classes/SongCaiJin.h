//
//  SongCaiJin.h
//  caibo
//
//  Created by houchenguang on 12-12-21.
//
//

#import <Foundation/Foundation.h>
#import "GC_DataReadStream.h"
#import "ASIHTTPRequest.h"
@interface SongCaiJin : NSObject{

    NSInteger sysid;
    NSString * code;
    NSString * msg;
    NSString * systime;
    NSString * succeed;//1为完善成功
}
@property (nonatomic, retain)NSString * code, * msg, * systime, * succeed;
@property (nonatomic, assign)NSInteger sysid;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
@end
