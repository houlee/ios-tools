//
//  GC_PKDetailData.h
//  caibo
//
//  Created by cp365dev6 on 15/3/9.
//
//

#import <Foundation/Foundation.h>
#import "GC_DataReadStream.h"
#import "ASIHTTPRequest.h"
#import "GC_RspError.h"

typedef enum {
    PKDetailPK,
    PKDetailHorse,
}PKDetailType;

@interface GC_PKDetailData : NSObject

@property(nonatomic,retain)  NSMutableArray *listData,*betContentArym;
@property (nonatomic, assign)NSInteger curCount,returnId;
@property (nonatomic, retain)NSString * sysTimeString, * userName, * qici, * passType, * betType, * zhuShu, * beiShu, * xuanzeChangci, * betMoney, * getMoney, * winMoney, * orderNum, * orderTime, * statue, * caizhong, * wanfa, * touzhuType, * touzhuContent, * kaijiangNum, * kaijiangTime, * yuliuData;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request type:(PKDetailType)type;

@end


@interface PKDetailData : NSObject
{
    
}
@property (nonatomic, retain)NSString * changci, * zhuName, * keName, * raceTime, * zhuBifen, * keBifen, * raceResult, * betContent, * shengPei, * pingPei, * fuPei, * moreData;
@end
