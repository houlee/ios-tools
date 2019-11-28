//
//  用户表
//  caibo
//
//  Created by jeff.pluto on 11-6-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statement.h"
#import "Info.h"

@interface User : NSObject 
{
    NSString *user_id;
    NSString *login_name;
    NSString *nick_name;
    NSString *password;
    NSString *date_time;
}

@property (nonatomic, retain) NSString *user_id;
@property (nonatomic, retain) NSString *login_name;
@property (nonatomic, retain) NSString *nick_name;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *date_time;

+ (void)insertDB: (Info *) user;
+ (void)updateDB:(Info *) user;
+ (void)deleteFromDB:(NSString *) userId;

// 从数据库获取最后登录的账户
+ (User*)getLastUser;

+ (User*)userWithStatement: (Statement *) stmt;

// 清空users表中数据
+ (void)clearTableUsers;

@end