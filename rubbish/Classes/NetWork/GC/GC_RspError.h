//
//  RspError.h
//  Lottery
//
//  Created by Kiefer on 11-12-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GC_DataReadStream.h"
#import "ASIHTTPRequest.h"

@class GC_DataReadStream;
@interface GC_RspError : NSObject <UIAlertViewDelegate>
{
    
}

+ (BOOL)parserError:(GC_DataReadStream *)_drs returnId:(NSInteger)_returnId WithRequest:request;

@end
