//
//  数据库
//  caibo
//
//  Created by jeff.pluto on 11-6-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Statement.h"

@interface DataBase : NSObject 
{
    
}

+ (sqlite3*)getDatabase;
+ (void)createTable;

// 清除图片缓存
+ (BOOL) deleteImageCache;
// 清理微博数据缓存
+ (BOOL) deleteMessageCache;
+ (BOOL)deleteImageCacheFormeData:(NSInteger)page;

+ (void)closeDatabase;

+ (Statement *)statementWithQuery:(const char*)sql;

@end