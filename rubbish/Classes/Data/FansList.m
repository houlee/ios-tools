//
//  FansList.m
//  caibo
//
//  Created by jacob on 11-5-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FansList.h"
#import"SBJSON.h"
#import"NSStringExtra.h"


@implementation FansList

@synthesize arrayList;

@synthesize userId,state,image,nick_name,vip,user_name,date_created,mobile,activation,

true_name,attention,usertype,sex,big_image,mid_image,sma_image,audi,fans,topicsize,

last_updated,is_relation;

@synthesize aNewTopic;

@synthesize mnewTopic;



-(id)initWithParse:(NSString*)responseString
{
	
	
	if(responseString ==nil)
		
		return NULL;
	
	if(self =[super init]){
		
		SBJSON *jsonParse = [[SBJSON alloc]init];
		
		NSArray *arry = [jsonParse objectWithString:responseString];
		
		
		if(arry){
			
			NSMutableArray *dateList =  [[NSMutableArray alloc] init];
			
			NSLog(@"array cont is %lu",(unsigned long)[arry count]);
			
			for (int i = 0; i < [arry count]; i++) {
				
				NSDictionary *dic = [arry objectAtIndex:i];	
				
				FansList *fansList = [self paserWithDictionary:dic];
				
				[dateList insertObject:fansList atIndex:i];
				
				
			}
			
			self.arrayList = dateList;
			
			[dateList release];
			
			
		}
		
		[jsonParse release];
		
		
	}
	
	return self;
	
	

}
-(id) paserWithDictionary:(NSDictionary*)dic
{
	
	if(dic){
		
		
		
		FansList *fansList = [[[FansList alloc] init]autorelease];
		
		fansList.sex = [dic valueForKey:@"sex"];
		
		fansList.audi = [NSString stringWithFormat:@"%d",[[dic valueForKey:@"audi"] intValue]];
		
		fansList.fans = [NSString stringWithFormat:@"%d",[[dic valueForKey:@"fans"] intValue]];
		
		fansList.state = [NSString stringWithFormat:@"%d",[[dic valueForKey:@"state"] intValue]];
		
		
		fansList.nick_name = [dic valueForKey:@"nick_name"];
		
		fansList.vip = [dic valueForKey:@"vip"];
		
		fansList.userId = [NSString stringWithFormat:@"%d",[[dic valueForKey:@"id"] intValue]];

		fansList.big_image = [dic valueForKey:@"big_image"];
		
		fansList.aNewTopic = [dic valueForKey:@"aNewTopic"];
		
		if (fansList.aNewTopic) {
			
			fansList.mnewTopic = [fansList.aNewTopic flattenPartHTML:fansList.aNewTopic];
			
		}
		
		fansList.attention = [NSString stringWithFormat:@"%d",[[dic valueForKey:@"attention"] intValue]];
		
		fansList.activation = [NSString stringWithFormat:@"%d",[[dic valueForKey:@"activation"] intValue]];

		fansList.topicsize = [NSString stringWithFormat:@"%d",[[dic valueForKey:@"topicsize"] intValue]];

		fansList.image = [dic valueForKey:@"image"];

		
		fansList.mid_image = [dic valueForKey:@"mid_image"];
		
		
		if(![fansList.mid_image hasPrefix:@"http"]){
			
			NSMutableString *senderImage = [[NSMutableString alloc] init];
			
			[senderImage appendString:@"http://t.diyicai.com/"];
			
			[senderImage appendString:fansList.mid_image];
			
			fansList.mid_image = senderImage;
			
			[senderImage release];
			
		}
		
		
		
		fansList.usertype = [dic valueForKey:@"usertype"];
		
		
		fansList.is_relation = [dic valueForKey:@"is_relation"];
		
		fansList.user_name = [dic valueForKey:@"user_name"];

		
		fansList.true_name = [dic valueForKey:@"true_name"];
		
		
		fansList.date_created = [dic valueForKey:@"date_created"];

		
		fansList.sma_image = [dic valueForKey:@"sma_image"];
		
		fansList.mobile = [dic valueForKey:@"mobile"];

		
		fansList.last_updated = [dic valueForKey:@"last_updated"];
				

		return fansList;
	}
	
	
	return NULL;
}

-(void)dealloc{
	[arrayList release];
	[userId release];
	[state release];	
	[image release];	
	[nick_name release];
	[vip release];
	[user_name release];
	[date_created release];	
	[mobile release];
	[activation release];
	[true_name release];	
	[attention release];
	[usertype release];	
	[sex release];
	[big_image release];
	[mid_image release];
	[sma_image release];
	[audi release];
	[fans release];
	[topicsize release];	
	[last_updated release];	
	[is_relation release];
	
	[aNewTopic release];

	[mnewTopic release];
	[super dealloc];

}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    