//
//  ActivateInfoData.h
//  caibo
//
//  Created by houchenguang on 14-4-22.
//
//

#import <Foundation/Foundation.h>
#import "GC_BetRecord.h"
#import "ASIHTTPRequest.h"

@interface ActivateInfoData : NSObject{
    
    NSInteger sysId;//充值返回消息id
    NSString * sysTime;//系统时间
    NSString * total;//总资产(元)
    NSString * yesterday;//昨日收益(元)
    NSString * history;//历史累计收益(元)
    NSString * myriad;//万份收益(元)
    NSString * award;//彩金奖励总计(元)
    NSInteger  dateYear;//几日年化收益
    NSMutableArray * yieldRateArray;//年化收益率
}

@property (nonatomic, retain)NSString * sysTime, * total, * yesterday, * history, * myriad, * award;
@property (nonatomic, assign)NSInteger sysId, dateYear;
@property (nonatomic, retain)NSMutableArray * yieldRateArray;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
