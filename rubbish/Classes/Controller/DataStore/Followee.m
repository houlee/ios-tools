//
//  Followee.m
//  caibo
//
//  Created by jeff.pluto on 11-6-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Followee.h"
#import "DataBase.h"

@implementation Followee

@synthesize mTag;
@synthesize userId;
@synthesize name;
@synthesize vip;
@synthesize imageUrl;
@synthesize fansCount;
@synthesize time;
@synthesize is_relation;

+ (Followee *)followeeWithStatement: (Statement *) stmt 
{
    Followee *followee       = [[[Followee alloc] init] autorelease];
    followee.userId          = [stmt getString:0];
    followee.name            = [stmt getString:1];
    followee.imageUrl        = [stmt getString:2];
    
    return followee;
}

+ (void) insertDB: (UserInfo *) list 
{    
    static Statement *stmt = nil;
    if (stmt == nil) {
        stmt = [DataBase statementWithQuery:"REPLACE INTO followees VALUES(?, ?, ?)"];
        [stmt retain];
    }
    
    [stmt bindString:list.userId           forIndex:1];
    [stmt bindString:list.nick_name        forIndex:2];
    [stmt bindString:list.mid_image        forIndex:3];
    
    if ([stmt step] != SQLITE_DONE) {
    }
    [stmt reset];
}

+ (void) updateDB:(UserInfo *)list 
{
    
}

+ (void) deleteFromDB:(UserInfo*)list 
{
    Statement *stmt = [DataBase statementWithQuery:"DELETE FROM followees WHERE user_id = ?"];
    
    [stmt bindString:list.userId forIndex:1];
    
    if ([stmt step] != SQLITE_DONE) {
        NSLog(@"Error : 删除未成功!");
    }
}

- (void)dealloc {
    [userId release];
    [name release];
	[vip release];
    [imageUrl release];
    [fansCount release];
    [time release];
    [is_relation release];
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    