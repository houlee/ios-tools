//
//  UserInfo.m
//  caibo
//
//  Created by jacob on 11-5-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserInfo.h"
#import "SBJSON.h"
#import "NSStringExtra.h"
#import "GC_HttpService.h"

@implementation UserInfo

@synthesize userId, state, image, signatures, nick_name, vip, date_created, mobile, activation,attention, usertype, sex, big_image, mid_image, sma_image, audi, fans, topicsize,themesize, favoritesize, last_updated, city, province, address,userName,authentication,unionStatus,unionId,partnerid, isbindmobile,id_number,flag,needFlag,cupType,sysTime,activeStartTime,activeEndTime,isOpen,userActiveStatus;
@synthesize instruction, last_topic_id, aNewTopic, is_relation, user_name, source, email, true_name,arrayList,blacksize;
@synthesize mnewTopic, accesstoken;


// 初始化 （NSString||NSDictionary）
- (id)initWithParse:(NSString*)str DIC:(NSDictionary*)dic
{
    
	if(!str && !dic)
		return nil;
    
	if((self = [super init]))
        {
		SBJSON *jsonParse = [[SBJSON alloc] init];
        NSDictionary *dic2 =nil;
        if (!dic) 
            {
            dic2 = [jsonParse objectWithString:str];
            NSLog(@"dic2 = %@", dic2);
				if ([[dic2 objectForKey:@"code"] intValue] == 1) {
					[jsonParse release];
                    return nil;
                }
            if ([dic2 objectForKey:@"userInfo"]) {
                self.accesstoken = [dic2 valueForKey:@"accesstoken"];
                dic = [dic2 objectForKey:@"userInfo"];
                
            }
            else {
                dic = dic2;
                dic2 = nil;
            }
            
            }
        if(dic)
            {   
                self.userId = [[dic valueForKey:@"id"] stringValue];
                NSLog(@"user id = %@", self.userId);
                self.state = [[dic valueForKey:@"state"] stringValue];
                self.image = [dic valueForKey:@"image"];
                self.signatures = [dic valueForKey:@"signatures"];
                self.nick_name = [dic valueForKey:@"nick_name"];
                self.vip = [dic valueForKey:@"vip"];
                self.userName = [dic objectForKey:@"user_name"];
                self.date_created = [dic valueForKey:@"date_created"];
                self.mobile = [dic valueForKey:@"mobile"];
                self.activation = [[dic valueForKey:@"activation"] stringValue];
                self.attention = [[dic valueForKey:@"attention"] stringValue];
                self.usertype = [dic valueForKey:@"usertype"];
                self.sex = [dic valueForKey:@"sex"];
                self.big_image = [dic valueForKey:@"big_image"];
                self.mid_image = [dic valueForKey:@"mid_image"];
                self.sma_image = [dic valueForKey:@"sma_image"];
                self.audi = [[dic valueForKey:@"audi"] stringValue];
                self.fans = [[dic valueForKey:@"fans"] stringValue];
                self.topicsize = [[dic valueForKey:@"topicsize"] stringValue];
                self.themesize = [[dic valueForKey:@"themesize"] stringValue];
                self.favoritesize = [[dic valueForKey:@"favoritesize"] stringValue];
                self.blacksize = [[dic valueForKey:@"blacksize"] stringValue];
                self.last_updated = [dic valueForKey:@"last_updated"];
                self.city = [[dic valueForKey:@"city"] stringValue];
                self.province = [[dic valueForKey:@"province"] stringValue];
                self.address = [dic valueForKey:@"address"];
                self.last_topic_id = [[dic valueForKey:@"last_topic_id"] stringValue];
                self.instruction = [dic valueForKey:@"instruction"];
                
                self.authentication =[NSString stringWithFormat:@"%d", [[dic valueForKey:@"authentication"] intValue]];
                NSLog(@"authentication = %@", self.authentication);
                self.aNewTopic = [dic valueForKey:@"aNewTopic"];
                
                self.isbindmobile = [NSString stringWithFormat:@"%@",[dic valueForKey:@"isbindmobile"]];
                NSLog(@"isbindmobile = %@", self.isbindmobile);
                
                if (aNewTopic) 
                    {
                    self.mnewTopic = [aNewTopic flattenPartHTML:aNewTopic];
                    }
                
                self.is_relation = [dic valueForKey:@"is_relation"];
                self.user_name = [dic valueForKey:@"user_name"];
                self.source = [dic valueForKey:@"source"];
                self.email = [dic valueForKey:@"email"];
                self.true_name = [dic valueForKey:@"true_name"];
                self.unionStatus = [dic valueForKey:@"unionStatus"];
                NSLog(@"self.unionstatus = %@", self.unionStatus);
                self.id_number = [dic valueForKey:@"id_number"];
                
                if ([dic2 valueForKey:@"sessionId"]) {
                    NSLog(@"sessionId = %@",[dic2 valueForKey:@"sessionId"]);
//                    [GC_HttpService sharedInstance].sessionId = [dic2 valueForKey:@"sessionId"];
                }
                
                self.flag = [dic valueForKey:@"flag"];
                self.needFlag = [dic valueForKey:@"needFlag"];
                self.cupType = [dic valueForKey:@"cupType"];
                self.sysTime = [dic valueForKey:@"sysTime"];
                self.activeStartTime = [dic valueForKey:@"activeStartTime"];
                self.activeEndTime = [dic valueForKey:@"activeEndTime"];
                self.isOpen = [dic valueForKey:@"isOpen"];
                self.userActiveStatus = [dic valueForKey:@"userActiveStatus"];
            }
		[jsonParse release];
        }
	return self;
}

- (NSArray*) arrayWithParse:(NSString *)jsonString {
    if(nil == jsonString)
		return NULL;
    
//    if (nil == arrayList) {
//        arrayList = [[NSArray alloc] init];
//    }
    
    SBJSON *json = [SBJSON new];
	NSArray *array = (NSArray *)[json objectWithString:jsonString error:nil];
    NSMutableArray *bufferArray = [[NSMutableArray alloc] init];
	if (nil != array) {
        int count = (int)[array count];
        if (count != 0) {
            for (int i = 0; i < count; i++) {
                NSDictionary *dictArray = [array objectAtIndex:i];
                [bufferArray addObject:[self paserWithDictionary:dictArray]];
            }
            self.arrayList = bufferArray;
        }
	}
    
    [json release];
    [bufferArray release];
    
	return arrayList;
}

- (id) paserWithDictionary:(NSDictionary *)dic {
    UserInfo *user = [[[UserInfo alloc] init] autorelease];
    if(dic){
        user.userId = [dic valueForKey:@"id"];
        user.nick_name = [dic valueForKey:@"nick_name"];
		user.vip = [dic valueForKey:@"vip"];
        user.big_image = [dic valueForKey:@"big_image"];
        user.mid_image = [dic valueForKey:@"mid_image"];
        user.sma_image = [dic valueForKey:@"sma_image"];
	}
    return user;
}

- (void)dealloc
{
    [accesstoken release];
    [isbindmobile release];
    [arrayList release];
	[userId release];
    [state release];
    [image release];
    [signatures release];
    [nick_name release];
	[vip release];
    [date_created release]; 
    [mobile release];
    [activation release];
    [attention release];
    [usertype release];
    [sex release];
    [big_image release]; 
    [mid_image release]; 
    [sma_image release]; 
    [audi release]; 
    [fans release];
    [topicsize release];
    [themesize release];
    [favoritesize release]; 
    [blacksize release];
    [last_updated release];
    [city release];
    [province release]; 
    [address release];
    [last_topic_id release];
    [aNewTopic release];
    [is_relation release];
    [user_name release];
    [source release];
    [email release];
    [true_name release];
	[userName release];
	[mnewTopic release];
    [authentication release];
	[unionStatus release];
	[unionId release];
	[partnerid release];
    self.id_number = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    