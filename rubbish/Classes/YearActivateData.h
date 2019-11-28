//
//  YearActivateData.h
//  caibo
//
//  Created by houchenguang on 14-4-22.
//
//

#import <Foundation/Foundation.h>
#import "GC_BetRecord.h"
#import "ASIHTTPRequest.h"

@interface YearActivateData : NSObject{

    NSInteger sysId;//充值返回消息id
    NSString * sysTime;//系统时间
    NSString * sevenData;//7日年化收益率
    NSString * activity;//活动彩金赠送
    NSString * dateString;//日期
    NSString * typeString;//销售状态 1是已经售罄 2正常
}

@property (assign)NSInteger sysId;
@property (nonatomic, retain)NSString * sysTime, * sevenData, * activity, *  dateString, * typeString;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;
@end
