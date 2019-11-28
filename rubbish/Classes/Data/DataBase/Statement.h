//
//  Statement.h
//  caibo
//
//  Created by jeff.pluto on 11-6-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <sqlite3.h>

@interface Statement : NSObject
{
    sqlite3_stmt *stmt;
}

+ (id)statementWithDB:(sqlite3 *)db query:(const char*)sql;
- (id)initWithDB:(sqlite3 *)db query:(const char*)sql;

- (int)step;
- (void)reset;

// 获取数据
- (NSString*)getString:(int)index;
- (int)getInt32:(int)index;
- (long long)getInt64:(int)index;
- (NSData*)getData:(int)index;

// 数据绑定
- (void)bindString:(NSString*)value forIndex:(int)index;
- (void)bindInt32:(int)value forIndex:(int)index;
- (void)bindInt64:(long long)value forIndex:(int)index;
- (void)bindData:(NSData*)data forIndex:(int)index;

@end