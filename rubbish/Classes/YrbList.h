//
//  YrbList.h
//  caibo
//
//  Created by  on 12-2-15.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YrbColumn : NSObject
{
    NSString *columnName;
    BOOL isMarked;
    int columnId;
}

@property (nonatomic, copy)NSString *columnName;
@property (nonatomic, assign)BOOL isMarked;
@property (nonatomic, assign)int columnId;
- (id)initWithDictionary:(NSDictionary *)aDictionary;
@end

@interface YrbListBase : NSObject
{
    NSString *listName;
    int listId;
    NSMutableArray *columnArray;
}

@property (nonatomic, copy)NSString *listName;
@property (nonatomic, assign)int listId;
@property (nonatomic, retain)NSMutableArray *columnArray;

@end

@interface YrbList : YrbListBase
{
    BOOL opened;
    NSMutableArray *indexPaths;
}

@property (nonatomic, assign)BOOL opened;
@property (nonatomic, retain)NSMutableArray *indexPaths;
- (id)initWithDictionary:(NSDictionary *)aDictionary;
@end
