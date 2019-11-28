//
//  CheDanData.h
//  caibo
//
//  Created by houchenguang on 13-12-13.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "GC_BetRecord.h"

@interface CheDanData : NSObject{

    NSInteger sysid;
    NSString * systime;
    NSString * msgchedan;
    NSInteger chedan;

}
@property (nonatomic, retain)NSString *systime, * msgchedan;
@property (nonatomic, assign)NSInteger sysid, chedan;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
