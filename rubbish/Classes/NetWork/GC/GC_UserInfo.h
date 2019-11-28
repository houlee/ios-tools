//
//  UserInfo.h
//  Lottery
//
//  Created by Teng Kiefer on 12-2-26.
//  Copyright (c) 2012年 windo-soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GC_AccountManage.h"
#import "GC_PersonalData.h"

@interface GC_UserInfo : NSObject <UIAlertViewDelegate>

@property(nonatomic, retain) GC_PersonalData *personalData; //个人资料
@property(nonatomic, retain) GC_AccountManage *accountManage; //账户全览
@property(nonatomic, assign, readonly) CGFloat accountBalance; //账户余额
@property(nonatomic, assign) BOOL is3000_1; //未登录异常
@property(nonatomic, assign) BOOL isNeedUpdateData; //需要更新数据

+ (GC_UserInfo *)sharedInstance;

- (void)showNotloginAlertView;
- (NSString *)curLocalDate;
- (NSString *)get_system_today_time;

@end
