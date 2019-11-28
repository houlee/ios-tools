//
//  ResultForSuccOrFail.m
//  caibo
//
//  Created by jacob on 11-5-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Result.h"
#import "SBJSON.h"


@implementation Result


@synthesize result;

@synthesize commentId;


-(id)initWithParse:(NSString*)responseString{
	
	if(responseString ==nil)
		return NULL;
	
	if((self =[super init])){
		
		SBJSON *jsonParse = [[SBJSON alloc]init];
		
		NSDictionary *dic = [jsonParse objectWithString:responseString];
		
		self.result = [dic valueForKey:@"result"];
		
		// 2.51 评论回复 
		if ([result isEqualToString:@"succ"]) {
			
			self.commentId = [dic valueForKey:@"commentId"];
			
			
		}
		
		[jsonParse release];
	}
	
	return self;

}





-(void)dealloc{

	[result release];
	
	[commentId release];
	
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    