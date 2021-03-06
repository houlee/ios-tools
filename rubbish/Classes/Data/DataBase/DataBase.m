//
//  DataBase.m
//  caibo
//
//  Created by jeff.pluto on 11-6-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DataBase.h"
#import "YDDebugTool.h"
#import "NSDate-Helper.h"

#define CAIBO_DATABASE_NAME @"caibo.sqlite3"

static sqlite3 *mDataBase;

@implementation DataBase

// 清除图片缓存
+ (BOOL) deleteImageCache 
{
    [DataBase getDatabase];
    char *errmsg;
    if (sqlite3_exec(mDataBase, "DELETE FROM images; VACUUM;", NULL, NULL, &errmsg) != SQLITE_OK) 
    {
        NSLog(@"Error: 清除图片缓存失败. (%s)", errmsg);
        return NO;
    }
    return YES;
}

+ (void)deleteImageCacheForURL:(NSString *)url {
    Statement *stmt = [DataBase statementWithQuery:"DELETE FROM images WHERE url = ?; VACUUM;"];
    
    [stmt bindString:url forIndex:1];
    
    if ([stmt step] != SQLITE_DONE)
    {
        NSLog(@"Error : 删除未成功!");
    }
}

// 清除七天前图片

+ (BOOL)deleteImageCacheFormeData:(NSInteger)page{
//    NSDate * buf = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*day];
//    static Statement* stmt = nil;
    Statement *stmt =  [DataBase statementWithQuery:"SELECT * FROM images"];
    double imageCout = 0;
    while ([stmt step] == SQLITE_ROW) {
        imageCout ++;
    }
    [stmt step];
     [stmt reset];
    if (imageCout > page *3) {
        [DataBase deleteImageCache];
    }
//    [stmt reset];
//    for (int i = 0; i < [array count]; i++) {
//        [DataBase deleteImageCacheForURL:[array objectAtIndex:i]];
//        
//    }
//    return YES;
//    if (stmt == nil) {
//        const char *sqlchar = [[NSString stringWithFormat:@"DELETE FROM images WHERE updated_at <= ?"] UTF8String];
//        [stmt bindString:[NSString stringWithFormat:@"TO_DATE('?','yyyy-MM-dd')"] forIndex:1];
//        [stmt bindString:[buf stringWithFormat:@"yyyy-MM-dd"] forIndex:1];
//        stmt = [DataBase statementWithQuery:sqlchar];
//        [stmt retain];
//    }
//    
//    [stmt step];
//
//    [stmt reset];
    return YES;
}

// 清理微博数据缓存
+ (BOOL) deleteMessageCache 
{
    [DataBase getDatabase];
    char *errmsg;
    if (sqlite3_exec(mDataBase, "DELETE FROM messages; VACUUM;", NULL, NULL, &errmsg) != SQLITE_OK) 
    {
        NSLog(@"Error: 清理微博数据缓存失败. (%s)", errmsg);
        return NO;
    }
    return YES;
}

// 打开数据库
+ (sqlite3 *)open:(NSString*)dbName 
{
    sqlite3 *mDBTemp;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:dbName];
    if (sqlite3_open([path UTF8String], &mDBTemp) != SQLITE_OK) 
    {
        NSLog(@"Error : 打开数据库失败...(%s)", sqlite3_errmsg(mDBTemp));
        sqlite3_close(mDBTemp);
        return nil;
    }
    return mDBTemp;
}

// 当前数据库
+ (sqlite3 *)getDatabase 
{
    if (!mDataBase) 
    {
        mDataBase = [self open:CAIBO_DATABASE_NAME];
    }

    [DataBase createTable];
    return mDataBase;
}

// 创建表
+ (void)createTable 
{
    if (!mDataBase) 
    {
        mDataBase = [self open:CAIBO_DATABASE_NAME];
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *mainPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:CAIBO_DATABASE_NAME];
    
    if ([fileManager fileExistsAtPath:mainPath]) 
    {
        NSString *migrateSQL = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"create.sql"];
        NSData *sqldata = [ fileManager contentsAtPath:migrateSQL];
        NSString *query = [[[NSString alloc] initWithData:sqldata encoding:NSUTF8StringEncoding] autorelease];
        
        // 查找本地SQL语句表
        if ([fileManager fileExistsAtPath:migrateSQL]) 
        {
            char *errmsg;
            if (sqlite3_exec(mDataBase, [query UTF8String], NULL, NULL, &errmsg) == SQLITE_OK)
            {
                NSLog(@"创建表成功!");
            }
            else 
            {
                NSLog(@"Create Table Result : %s", errmsg);
            }
        }
    }
}

// 关闭数据库
+ (void)closeDatabase
{
    if (mDataBase) 
    {
        sqlite3_close(mDataBase);
    }
}

// 执行SQL语句
+ (Statement *)statementWithQuery:(const char *)sql 
{
    Statement *stmt = [Statement statementWithDB:mDataBase query:sql];
    return stmt;
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    