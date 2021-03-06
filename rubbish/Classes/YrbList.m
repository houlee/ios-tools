//
//  YrbList.m
//  caibo
//
//  Created by  on 12-2-15.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "YrbList.h"

@implementation YrbColumn
@synthesize columnId,columnName,isMarked;
- (void)dealloc
{
    [columnName release];
    [super dealloc];
}
- (id)initWithDictionary:(NSDictionary *)aDictionary
{
    if(aDictionary == nil)
        {
        return nil;
        }
    if (self = [super init]) {
        self.isMarked = [[aDictionary objectForKey:@"isMarked"]boolValue];
        self.columnName = [aDictionary objectForKey:@"columnName"];
        self.columnId = [[aDictionary objectForKey:@"columnId"]intValue];
    }
    return (self);
}
@end

@implementation YrbListBase
@synthesize listId,listName,columnArray;

- (void)dealloc
{
    [listName release];
    [columnArray release];
    [super dealloc];
}

@end

@implementation YrbList
@synthesize opened,indexPaths;

- (id)initWithDictionary:(NSDictionary *)aDictionary
{
    if (aDictionary == nil) {
        return nil;
    }
    if (self = [super init]) {
        self.listId = [[aDictionary objectForKey:@"listId"]intValue];
        self.listName = [aDictionary objectForKey:@"listName"];
        self.opened = [[aDictionary objectForKey:@"opened"]boolValue];
        NSArray *array = [aDictionary objectForKey:@"columnArray"];
        NSMutableArray *dataList = [[NSMutableArray alloc]init];
        for (int i = 0; i < [array count]; i++) {
            YrbColumn *column = [[YrbColumn alloc]initWithDictionary:[array objectAtIndex:i]];
            [dataList insertObject:column atIndex:i];
            [column release];
        }
        self.columnArray = dataList;
        [dataList release];
        self.indexPaths = nil;
    }
    return (self);
}
- (void)dealloc
{
    [indexPaths release];
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    