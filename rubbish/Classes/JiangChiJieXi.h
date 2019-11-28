//
//  JiangChiJieXi.h
//  caibo
//
//  Created by 姚福玉 姚福玉 on 12-8-3.
//  Copyright (c) 2012年 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface JiangChiJieXi : NSObject {
    NSInteger returnId;			// 返回消息id
    NSString *systemTime;		// 系统时间
    NSString *lottoryID;        // 彩种
    NSString *issure;           // 期次
    NSString *JiangChi;         // 奖池滚存
    NSString *other;            // 预备字段
}
@property (nonatomic,copy)NSString *systemTime,*lottoryID,*issure,*JiangChi,*other;
@property (nonatomic)NSInteger returnId;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end
