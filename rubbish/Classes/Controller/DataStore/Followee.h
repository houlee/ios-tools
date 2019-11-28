//
//  Followee.h
//  caibo
//
//  Created by jeff.pluto on 11-6-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statement.h"
#import "UserInfo.h"

@interface Followee : NSObject 
{
    uint32_t    mTag;
    NSString *userId;
    NSString *name;
    NSString *imageUrl;
    NSString *vip;
    NSString *fansCount;
    NSString *time;
	NSString *is_relation;
}

@property(nonatomic, assign) uint32_t  mTag;
@property(nonatomic, retain) NSString* userId;
@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) NSString* vip;
@property(nonatomic, retain) NSString* imageUrl;
@property(nonatomic, retain) NSString* fansCount;
@property(nonatomic, retain) NSString* time;
@property(nonatomic, retain) NSString* is_relation;

+ (void)insertDB: (UserInfo *) list;
+ (void)updateDB:(UserInfo *) list;
+ (void)deleteFromDB:(UserInfo *) list;

+ (Followee *)followeeWithStatement: (Statement *) stmt;

@end