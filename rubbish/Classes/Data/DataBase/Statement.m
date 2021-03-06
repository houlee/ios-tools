//
//  Statement.m
//  caibo
//
//  Created by jeff.pluto on 11-6-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Statement.h"

@implementation Statement

- (id) initWithDB:(sqlite3*)db query:(const char*)sql 
{
    self = [super init];
    
    // 除了select外其他的都用sqlite3_exec，select用sqlite3_prepare_v2
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) != SQLITE_OK) 
    {
        NSLog(@"Error : Statement fail...");
    }
    return self;
}

+ (id)statementWithDB:(sqlite3*)db query:(const char*)sql 
{
    return [[[Statement alloc] initWithDB:db query:sql] autorelease];
}

- (int)step 
{
    return sqlite3_step(stmt);
}

- (void)reset 
{
    sqlite3_reset(stmt);
}

//
// 获取数据
//
- (NSString*)getString:(int)index 
{
    return [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, index)];    
}

- (int)getInt32:(int)index 
{
    return (int)sqlite3_column_int(stmt, index);
}

- (long long)getInt64:(int)index 
{
    return (long long)sqlite3_column_int(stmt, index);
}

- (NSData*)getData:(int)index 
{
    int length = sqlite3_column_bytes(stmt, index);
    return [NSData dataWithBytes:sqlite3_column_blob(stmt, index) length:length];    
}

//
// 绑定数据
//
- (void)bindString:(NSString*)value forIndex:(int)index 
{
    sqlite3_bind_text(stmt, index, [value UTF8String], -1, SQLITE_TRANSIENT);
}

- (void)bindInt32:(int)value forIndex:(int)index 
{
    sqlite3_bind_int(stmt, index, value);
}

- (void)bindInt64:(long long)value forIndex:(int)index 
{
    sqlite3_bind_int64(stmt, index, value);
}

- (void)bindData:(NSData*)value forIndex:(int)index 
{
    sqlite3_bind_blob(stmt, index, value.bytes, (int)value.length, SQLITE_TRANSIENT);
}

- (void)dealloc 
{
//    [super dealloc];
    sqlite3_finalize(stmt);
    
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    