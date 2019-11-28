//
//  HeMaiCanYuJieXI.h
//  caibo
//
//  Created by 姚福玉 姚福玉 on 12-8-31.
//  Copyright (c) 2012年 第一视频. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface HeMaiCanYuJieXI : NSObject {
    NSInteger returnId;			// 返回消息id
    NSString *systemTime;		// 系统时间
    NSInteger totleNum;         //以认购人数
    NSInteger curPage;          //当前页
    NSInteger curCount;         //当前页人数
    NSMutableArray *canyurenArray;    //参与数组
}
@property(nonatomic,retain)NSMutableArray *canyurenArray;
@property(nonatomic)NSInteger totleNum,curPage,curCount,returnId;
@property(nonatomic,copy)NSString *systemTime;
- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end

@interface CanYuRen : NSObject {
    NSString *nickName;     //用户昵称
    NSString *name;         //用户名
    NSString *money;        //参与金额
    NSString *buyFen;       //参与份数；
    NSString *time;         //参与时间；
    NSString *other;        //预备字段；
}

@property (nonatomic,copy)NSString *nickName,*name,*money,*buyFen,*time,*other;
@end
