//
//  GC_PKRankingList.h
//  caibo
//
//  Created by cp365dev6 on 15/3/5.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"

@interface GC_PKRankingList : NSObject

@property(nonatomic,retain)  NSMutableArray *listData;
@property (nonatomic, assign)NSInteger curCount,returnId;
@property (nonatomic, retain)NSString * sysTimeString;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end


@interface PKMyRankingList : NSObject
{
    
}
@property (nonatomic, retain)NSString * userName, * userNicheng, * winMoney, * getScore, * userIma, * moreData;
@end