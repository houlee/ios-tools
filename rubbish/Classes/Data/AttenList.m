//
//  AttenList.m
//  caibo
//
//  Created by jeff.pluto on 11-6-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AttenList.h"
#import "SBJSON.h"
#import "UserInfo.h"
#import "BlackUser.h"
#import "NSStringExtra.h"

@implementation AttenList

@synthesize arrayList;

@synthesize sex,audi,fans,state,date_created,city,nick_name,vip,userId,province,
big_image,aNewTopic,attention,activation,topicsize,image,mid_image,signatures,usertype,mobile,is_relation,user_name,
source,true_name,last_updated,sma_image,mnewTopic;

// 关注列表解析
- (NSMutableArray*)arrayWithParse:(NSString *)str {
    NSLog(@"str = %@", str);
    if(str) {
        SBJSON *json = [[SBJSON alloc] init];
        NSArray *array = [json objectWithString:str];
        if (array) {
            NSMutableArray *bufferArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < [array count]; i++) {
                NSDictionary *dic = [array objectAtIndex:i];
                NSLog(@"dic  = %@", dic);
                UserInfo *userInfo = [[UserInfo alloc] initWithParse:nil DIC:dic];
                [bufferArray addObject:userInfo];
                [userInfo release];
            }
            self.arrayList = bufferArray;
            [bufferArray release];
        }
        [json release];
    }
	return arrayList;
}

// 重写 关注 列表解析
-(id)initWithparse:(NSString*)responseString{
	
	if(responseString ==nil)
		return NULL;	
	if((self=[super init])){		
		SBJSON *jsonParse = [[SBJSON alloc]init];
		NSArray *arry = [jsonParse objectWithString:responseString];
		if(arry){
            NSMutableArray *dateList =  [[NSMutableArray alloc] init];
			for (int i = 0; i < [arry count]; i++) {				
				NSDictionary *dic = [arry objectAtIndex:i];					
				AttenList *list = [self paserWithDictionary:dic];				
				[dateList insertObject:list atIndex:i];
			}
            self.arrayList = dateList;
			[dateList release];
		}
		[jsonParse release];
	}
	
	return self;
}


-(id) paserWithDictionary:(NSDictionary*)dic{
	
	if (dic) {
		AttenList *list = [[[AttenList alloc] init] autorelease];
		list.userId = [[dic valueForKey:@"id"] stringValue];
		list.state = [[dic valueForKey:@"state"] stringValue];
		list.image = [dic valueForKey:@"image"];
		list.signatures = [dic valueForKey:@"signatures"];
		list.nick_name = [dic valueForKey:@"nick_name"];
		list.vip = [dic valueForKey:@"vip"];
		list.date_created = [dic valueForKey:@"date_created"];
		list.mobile = [dic valueForKey:@"mobile"];
		list.activation = [[dic valueForKey:@"activation"] stringValue];
		list.attention = [[dic valueForKey:@"attention"] stringValue];
		list.usertype = [dic valueForKey:@"usertype"];
		list.sex = [dic valueForKey:@"sex"];
		list.big_image = [dic valueForKey:@"big_image"];
		list.mid_image = [dic valueForKey:@"mid_image"];
		list.sma_image = [dic valueForKey:@"sma_image"];
		list.audi = [[dic valueForKey:@"audi"] stringValue];
		list.fans = [[dic valueForKey:@"fans"] stringValue];
		list.topicsize = [[dic valueForKey:@"topicsize"] stringValue];
		list.last_updated = [dic valueForKey:@"last_updated"];
		list.city = [[dic valueForKey:@"city"] stringValue];
		list.province = [[dic valueForKey:@"province"] stringValue];
				
		list.aNewTopic = [dic valueForKey:@"aNewTopic"];
		if (list.aNewTopic) 
		{
			list.mnewTopic = [list.aNewTopic flattenPartHTML:list.aNewTopic];
		}
		
		list.is_relation = [dic valueForKey:@"is_relation"];
		list.user_name = [dic valueForKey:@"user_name"];
		list.source = [dic valueForKey:@"source"];
		list.true_name = [dic valueForKey:@"true_name"];
		
		return list;
	}
	return NULL;
}

- (void) dealloc 
{
	[arrayList release];// 重写 关注列表解析
	[sex release];
	[audi release];
	[fans release];
	[state release];
	[date_created release];
	[city release];
	[nick_name release];
	[vip release];
	[userId release];
	[province release];
	[big_image release];
	[aNewTopic release];
	[attention release];
	[activation release];
	[topicsize release];
	[image release];
	[mid_image release];
	[signatures release];
	[usertype release];
	[mobile release];
	[is_relation release];
	[user_name release];
	[source release];
	[true_name release];
	[last_updated release];
	[sma_image release];
	[mnewTopic release];
	
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    