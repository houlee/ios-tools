//
//  Advertisement.h
//  Lottery
//
//  Created by Teng Kiefer on 12-2-23.
//  Copyright (c) 2012年 windo-soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface GC_Advertisement : NSObject
{
    // 0 – 入口广告 1 – 滚动广告 2 – 弹出广告
    short returnId;
	NSString *systemTime; // 系统时间
    Byte isUpdate; // 是否需要更新
    int version; // 广告版本
	Byte rollnumber; // 滚动文字广告数目
	Byte popnumber; // 页面弹出广告数目
    Byte marketingnumber; // 营销广告数目
}

@property(nonatomic, assign) short returnId;
@property(nonatomic, assign) Byte isUpdate, rollnumber, popnumber, marketingnumber;
@property(nonatomic, assign) int version;
@property(nonatomic, copy) NSString *systemTime;

- (id)initWithResponseData:(NSData *)_responseData WithRequest:(ASIHTTPRequest *)request;

@end

// 入口广告
@interface EntryAD : NSObject 
{
    int adId; // 广告id
    NSString *adText; // 广告文字
    NSString *adPicAddress; // 广告图片链接地址
    NSString *effectDate; // 生效日期
	NSString *endDate; // 截止日期
}

@property(nonatomic, assign) int adId;
@property(nonatomic, copy) NSString *adText, *adPicAddress, *effectDate, *endDate;

@end

// 滚动文字广告、营销文字广告
@interface RollAD : NSObject 
{
    int adId; // 广告id
    NSString *adTitle; // 公告标题
    NSString *adText; // 公告内容
    NSString *effectDate; // 生效日期
	NSString *endDate; // 截止日期
}

@property(nonatomic, assign) int adId;
@property(nonatomic, copy) NSString *adTitle, *adText, *effectDate, *endDate;

@end

// 页面弹出广告
@interface PopupAD : NSObject 
{
    int adId; // 广告id
    Byte adPopupStyle; // 广告弹出方式
    NSString *adPicAddress; // 广告图片链接地址
    NSString *effectDate; // 生效日期
	NSString *endDate; // 截止日期
    NSString *adLocation; // 广告位置
    NSString *leftbutton; // 左键功能
    short leftgoal; // 左键目标
	NSString *rightbutton; // 右键功能
	short rightgoal; // 右键目标
}

@property(nonatomic, assign) int adId;
@property(nonatomic, assign) Byte adPopupStyle;
@property(nonatomic, assign) short leftgoal, rightgoal;
@property(nonatomic, copy) NSString *adPicAddress, *effectDate, *endDate, *adLocation, *leftbutton, *rightbutton;

@end
