//
//  GoalNotice.m
//  caibo
//
//  Created by user on 11-8-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GoalNotice.h"
#import "SBJSON.h"


@implementation GoalNotice

@synthesize goalNoticeStatus;


- (id) initWithParse:(NSString *)jsonString
{
	if(nil == jsonString){
		
		return nil;
	}
	self = [super init];
    SBJSON *json = [[SBJSON alloc] init];
	
	NSDictionary *dictArray = [json objectWithString: jsonString];
	
	if(dictArray)
	{
        self.goalNoticeStatus = [dictArray valueForKey:@"result"];
	}
	
    [json release];
	
	return self;
}



- (void)dealloc
{
	[goalNoticeStatus release];
	
	[super dealloc];
}



@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    