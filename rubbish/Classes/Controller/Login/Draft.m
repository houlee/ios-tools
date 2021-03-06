//
//  Draft.m
//  caibo
//
//  Created by jeff.pluto on 11-7-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Draft.h"
#import "Statement.h"
#import "DataBase.h"

@implementation Draft

@synthesize text;
@synthesize mDate;
@synthesize mImage;

// 从数据库获取草稿箱列表
+ (NSMutableArray*) getDraftVec
{    
    static Statement *stmt;
    
    NSMutableArray *vec = [[[NSMutableArray alloc] init] autorelease];
    
    stmt = [DataBase statementWithQuery:"select * from DraftBox"]; // 默认asc升序
    while ([stmt step] == SQLITE_ROW) 
    {
        Draft *draft = [Draft initWithStmt:stmt];
        if (draft) {
            [vec addObject:draft];
        }
    }
    [stmt reset];
    
    return vec;
}

// 初始化一个草稿
+ (Draft*)initWithStmt:(Statement*)stmt
{
    Draft *draft = [[[Draft alloc] init] autorelease];
    draft.text = [stmt getString:0];
    draft.mImage = [UIImage imageWithData:[stmt getData:1]];
    draft.mDate = [stmt getString:2];
    return draft;
}

// 插入草稿
+ (void)insertDraft:(NSString *)text ImageData:(NSData *)imageData {
    Statement *stmt = [DataBase statementWithQuery:"insert into DraftBox values(?, ?, DATETIME('now'))"];
    
    [stmt bindString: text forIndex:1];
    [stmt bindData: imageData forIndex:2];
    
    if ([stmt step] != SQLITE_DONE) 
    {
        
    }
    [stmt reset];
}

// 删除草稿
+ (void)deleteDraft:(NSString*)date 
{
    Statement *stmt = [DataBase statementWithQuery:"DELETE FROM DraftBox WHERE Date = ?; VACUUM;"];
    [stmt bindString:date forIndex:1];
    
    if ([stmt step] != SQLITE_DONE) 
    {
        NSLog(@"Error : 删除未成功!");
    }
}

// 根据草稿时间替换数据
+ (void) replaceDraft:(NSString *)text ImageData:(NSData *)imageDate Date:(NSString *)date {
    Statement *stmt = [DataBase statementWithQuery:"REPLACE INTO DraftBox VALUES(?, ?, ?)"];
    
    [stmt bindString:text forIndex:1];
    [stmt bindData:imageDate forIndex:2];
    [stmt bindString:date forIndex:3];
    
    if ([stmt step] != SQLITE_DONE) 
    {
        
    }
    [stmt reset];
}

+ (int) getDraftCount {
    Statement *stmt = [DataBase statementWithQuery:"select * from DraftBox"];
    int count = 0;
    while ([stmt step] == SQLITE_ROW) {
        count++;
    }
    [stmt reset];
    return count;
}

// 清空DraftBox表中数据
+ (void)clearDraftBox
{
    Statement *stmt = [DataBase statementWithQuery:"DELETE FROM DraftBox;VACUUM;"];
    if ([stmt step] != SQLITE_DONE) 
    {
        NSLog(@"Error : 删除未成功!");
    }
}

- (void)dealloc {
    [text release];
    [mImage release];
    [mDate release];
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    