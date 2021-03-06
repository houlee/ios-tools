//
//  BlackUser.m
//  caibo
//
//  Created by Kiefer on 11-7-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BlackUser.h"

#import "Info.h"
#import "JSON.h"

@implementation BlackUser

@synthesize userName;
@synthesize image;
@synthesize nickName;
@synthesize userId;

// 黑名单列表解析
+ (NSMutableArray*)parserWithString:(NSString *)str
{
    NSMutableArray *vec = [[[NSMutableArray alloc] init] autorelease];
    if (str) 
    {
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSDictionary *dic = [jsonParse objectWithString:str];
        if(dic)
        { 
//            NSInteger pageCount = [[dic valueForKey:@"pageCount"] intValue];
//            NSLog(@"pageCount = %d", pageCount);
//            NSString *pageNum = [dic valueForKey:@"pageNum"];
//            NSLog(@"pageNum = %@", pageNum);
            NSArray *dictArray = [dic valueForKey:@"retList"];
            for (NSDictionary *dict in dictArray) 
            {
                BlackUser *blackUser = [[BlackUser alloc] initWithDic:dict];
                [vec addObject:blackUser];
                [blackUser release];
            }
        }
        [jsonParse release];
    }
	return vec;
}

// 初始化 （NSDictionary）
- (id)initWithDic:(NSDictionary*)dic
{
	if((self = [super init]))
    {
		if(dic)
        {
            self.userName = [dic valueForKey:@"userName"];
            self.image = [dic valueForKey:@"image"];
            self.image = [Info strFormatWithUrl:self.image];
            self.nickName = [dic valueForKey:@"nick_name"];
            self.userId = [[dic valueForKey:@"userId"] stringValue];
		}
	}
	return self;
}

- (void)dealloc
{
    [userName release];
    [image release];
    [nickName release];
    [userId release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    