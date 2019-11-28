//
//  GC_PKMyRecordList.h
//  caibo
//
//  Created by cp365dev6 on 15/3/6.
//
//

#import <Foundation/Foundation.h>
#import "GC_DataReadStream.h"
#import "ASIHTTPRequest.h"
#import "GC_RspError.h"

@interface GC_PKMyRecordList : NSObject

@property (nonatomic, assign) NSInteger numCount,pageCount,returnId;
@property (nonatomic, copy) NSString *systemTime,*totalPay,*totalGet,*totalScore;
@property (nonatomic, retain) NSMutableArray *recordListArym;
@property(nonatomic,retain)  NSMutableArray *listData;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
@end


@interface PKMyRecordList : NSObject
{
    
}
@property (nonatomic, retain)NSString * fanganNum, * createTime, * qici, * betContent, * passType, * betMoney, * getMoney, * getScore, * winMoney, * statue, * moreData, * caizhong, * wanfa, * touzhuType;
@end
