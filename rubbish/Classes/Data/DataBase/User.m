//
//  User.m
//  caibo
//
//  Created by jeff.pluto on 11-6-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "User.h"
#import "DataBase.h"

@implementation User

@synthesize user_id, password, nick_name, date_time, login_name;

// 从数据库获取最后登录的账户
+ (User*) getLastUser 
{    
    Statement *stmt = [DataBase statementWithQuery:"SELECT * FROM users ORDER BY date_time DESC"];
    
    int result = [stmt step];
    if (result != SQLITE_ROW) 
    {
        [stmt reset];
        return nil;
    }
    
    User *user = [User userWithStatement:stmt];
    [stmt reset];
    
    return user;
}

+ (User *) userWithStatement:(Statement*)stmt 
{
    User *user      = [[[User alloc] init] autorelease];
    user.user_id    = [stmt getString:0];
    user.login_name = [stmt getString:1];
    user.nick_name  = [stmt getString:2];
    user.password   = [stmt getString:3];
    user.date_time  = [stmt getString:4];
    
    return user;
}

+ (void) insertDB:(Info *)info 
{
	if ([info.userId length] == 0||[info.login_name length] == 0||[info.nickName length] == 0||[info.password length] == 0) {
		return;
	}
    static Statement *stmt = nil;
    if (stmt == nil) 
    {
        stmt = [DataBase statementWithQuery:"REPLACE INTO users VALUES(?, ?, ?, ?, DATETIME('now'))"];
        [stmt retain];
    }
    
    [stmt bindString:info.userId       forIndex:1];
    [stmt bindString:info.login_name   forIndex:2];
    [stmt bindString:info.nickName     forIndex:3];
    [stmt bindString:info.password     forIndex:4];
    
    if ([stmt step] != SQLITE_DONE) 
    {
        
    }
    [stmt reset];
}

+ (void) updateDB:(Info *)user 
{
    
}

+ (void) deleteFromDB:(NSString *)userId 
{
    Statement *stmt = [DataBase statementWithQuery:"DELETE FROM users WHERE user_id = ?; VACUUM;"];
    
    [stmt bindString:userId forIndex:1];
    
    if ([stmt step] != SQLITE_DONE) 
    {
        NSLog(@"Error : 删除未成功!");
    }
}

// 清空users表中数据
+ (void)clearTableUsers
{
    Statement *stmt = [DataBase statementWithQuery:"DELETE FROM users;VACUUM;"];
    if ([stmt step] != SQLITE_DONE) 
    {
        NSLog(@"Error : 删除未成功!");
    }
}

- (void)dealloc {
    [user_id release];
    [login_name release];
    [password release];
    [nick_name release];
    [date_time release];
   	[super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    