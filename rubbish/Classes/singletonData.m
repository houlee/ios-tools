//
//  singletonData.m
//  caibo
//
//  Created by houchenguang on 13-7-2.
//
//

#import "singletonData.h"

@implementation singletonData
static singletonData * singletonInfo;
@synthesize allDataArray, selectTile;
@synthesize myAllDataArray, endAllDataArray, myTitle, endTitle, liveTitle;
@synthesize liveIssue, endIssue, myIssue, allIussueArray, endIussueArray;
+ (id)getInstance
{
    @synchronized(singletonInfo)
    {
        if (!singletonInfo)
        {
            singletonInfo = [[singletonData alloc] init];
        }
        return singletonInfo;
    }
    return nil;
}

- (id)init{

    if((self = [super init]))
    { //这里可以设置变量初始值
        self.selectTile = 0;
        self.myTitle = 0;
        self.liveTitle = 0;
        self.endTitle = 0;
        liveIssue = @"";
        myIssue = @"";
        endIssue = @"";
	}
	return self;

}


- (void)dealloc{
    [endIussueArray release];
    [allIussueArray release];
    [liveIssue release];
    [myIssue release];
    [endIssue release];
    [myAllDataArray release];
    [endAllDataArray release];
    [allDataArray release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    