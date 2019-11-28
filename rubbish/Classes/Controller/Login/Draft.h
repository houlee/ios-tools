//
//  Draft.h
//  caibo
//
//  Created by jeff.pluto on 11-7-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Statement;
@interface Draft : NSObject 
{
    NSString *text;
    UIImage *mImage;
    NSString *mDate;
}

@property(nonatomic, retain) NSString *text;
@property(nonatomic, retain) UIImage *mImage;
@property(nonatomic, retain) NSString *mDate;

// 从数据库获取草稿箱列表
+ (NSMutableArray*) getDraftVec;
// 初始化一个草稿
+ (Draft *)initWithStmt:(Statement*)stmt;
// 插入草稿
+ (void)insertDraft:(NSString*)text ImageData : (NSData *)imageData;
// 删除草稿
+ (void)deleteDraft:(NSString*)date;
// 清空DraftBox表中数据
+ (void)clearDraftBox;

// 根据草稿时间替换数据
+ (void) replaceDraft : (NSString *) text ImageData : (NSData *)imageDate Date : (NSString *) date;
// 获得草稿总数
+ (int) getDraftCount;

@end
