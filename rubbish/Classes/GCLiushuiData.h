//
//  GCLiushuiData.h
//  caibo
//
//  Created by  on 12-5-22.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface GCLiushuiData : NSObject{
    NSInteger  xiaoxiID;//消息id
    NSString * sysTime;//系统时间
    NSInteger  coutpage;//总页数
    NSInteger  currpage;//当前页
    NSInteger jilushu;//返回记录数
    
    NSMutableArray * allarray;
}
@property (nonatomic, retain) NSMutableArray * allarray;
@property (nonatomic, retain)NSString * sysTime;
@property (nonatomic, assign)NSInteger xiaoxiID,coutpage, currpage , jilushu;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end

@interface GCLiushuiDataInfo : NSObject {
    NSString * caozuodate;//操作时间
    NSString * benmoney;//本次操作金额
    NSString * houyue;//交易后金额
    NSString * bencijiang;//本次操作奖励帐户金额
    NSString * bencijyue;//操作后奖励帐户余额
    NSString * leixing;//操作类型
    NSString * erleixing;//二级类型
    NSString * ermingcheng;//二级类型名称
    NSString * beizhu;//备注
    NSString * dingdanhao;//订单号
    NSString * shoushumoney;
    // 是否是一年中的第一天
    BOOL oneBool;
}
@property (nonatomic, retain)NSString * caozuodate,* benmoney,* houyue,* bencijiang,* bencijyue,* leixing,* erleixing,* ermingcheng,* beizhu,* dingdanhao, * shoushumoney;
@property (nonatomic,assign)BOOL oneBool;
@end

