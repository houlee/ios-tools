//
//  ChongZhiData.h
//  caibo
//
//  Created by  on 12-5-31.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface ChongZhiData : NSObject{
    NSInteger xiaoxiid;
    NSString * systime;
    NSString * sessionid;

}
@property (nonatomic, retain)NSString * systime, * sessionid;
@property (nonatomic, assign)NSInteger xiaoxiid;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
@end
