//
//  GC_YHMInfoParser.h
//  caibo
//
//  Created by cp365dev on 15/1/22.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface GC_YHMInfoParser : NSObject
{
    
    NSInteger returnId;  //返回系统消息ID
    NSString *systemTime;   //系统时间
    NSInteger curCount;    //当前页条数
    NSInteger allCount;   //优惠码总条数
    NSMutableArray *YHMInfoArray; //优惠码信息
}
@property (nonatomic) NSInteger returnId;
@property (nonatomic,copy) NSString *systemTime;
@property (nonatomic,retain) NSMutableArray *YHMInfoArray;
@property (nonatomic) NSInteger allCount;
@property (nonatomic) NSInteger curCount;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end


@interface YHMInfo : NSObject
{
    NSString *YHM_Type;  //优惠码状态
    NSString *YHM_mes;   //优惠码信息
    NSString *YHM_time;  //优惠码有效期
    NSString *YHM_code;  //优惠码code
    NSString *YHM_chong;//充值金额
    NSString *YHM_yhmJE;//优惠码金额
    NSString *YHM_yuliu; //预留字段
}
@property (nonatomic,copy) NSString *YHM_Type,*YHM_mes,*YHM_time,*YHM_code,*YHM_yuliu,*YHM_chong,*YHM_yhmJE;
@end