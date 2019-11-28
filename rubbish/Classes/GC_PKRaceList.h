//
//  GC_PKRaceList.h
//  caibo
//
//  Created by cp365dev6 on 15/3/6.
//
//

#import <Foundation/Foundation.h>
#import "GC_DataReadStream.h"
#import "ASIHTTPRequest.h"
#import "GC_RspError.h"

@interface GC_PKRaceList : NSObject

@property(nonatomic,retain)  NSMutableArray *listData;
@property (nonatomic, assign)NSInteger count, returnId;
@property (nonatomic, retain)NSString * sysTimeString;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
@end

@interface PKXiangxiList : NSObject
{
    
}
@property (nonatomic, retain)NSString * raceID, * raceNum, * zhuDui, * keDui, * zhuBifen, * keBifen, * statue, * spType, * shengPei, * pingPei, * fuPei, * raceName, * raceTime, * moreData;
@end