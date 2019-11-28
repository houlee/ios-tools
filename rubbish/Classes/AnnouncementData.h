//
//  AnnouncementData.h
//  caibo
//
//  Created by  on 12-5-4.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnouncementData : NSObject{
    NSString * user;//用户名
    NSString * imagestr;//图片地址
    //NSString * imageUser;
    NSString * money;//钱数
    NSString * level1;//徽章1等级
    NSString * level2;//徽章2等级
    NSString * level3;//徽章3等级
    NSString * level4;
    NSString * level5;
    NSString * level6;
    NSString * userID;//用户id
    NSInteger num;
    NSString * headna;
	NSString *userName;
    NSString * orderid;
    NSString * lotteryname;
    NSString * privacy;
}
@property (nonatomic, retain)NSString * headna;
@property (nonatomic, assign)NSInteger num;
@property (nonatomic, retain)NSString * user;
@property (nonatomic, retain)NSString * imagestr;
@property (nonatomic, retain)NSString * money;
@property (nonatomic, retain)NSString * level1;
@property (nonatomic, retain)NSString * level2;
@property (nonatomic, retain)NSString * level3;
@property (nonatomic, retain)NSString * level4;
@property (nonatomic, retain)NSString * level5;
@property (nonatomic, retain)NSString * level6;
@property (nonatomic, retain)NSString * userID;
@property (nonatomic, retain)NSString *userName, * orderid, * lotteryname;
@property (nonatomic, retain)NSString * privacy;

@end
