//
//  UserGroupList.m
//  caibo
//
//  Created by jacob on 11-6-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserGroupList.h"
#import "SBJSON.h"


@implementation UserGroupList


@synthesize arryList;

@synthesize pageCount,groupId,userid,name,createTime,pageNum;

-(id)initWithParse:(NSString*)responseString{
	
	if(responseString==nil)
		
		return NULL;
	
	if(self=[super init]){
	
		SBJSON *jsonParse  = [[SBJSON alloc]init];
		
		NSDictionary *dic = [jsonParse objectWithString:responseString];
		
		if(dic){
			
			NSLog(@"dic is %@",dic);
		     
			self.pageCount = [dic objectForKey:@"pageCount"];
			
			self.pageNum = [dic objectForKey:@"pageNum"];
			
			
			NSArray *arryretList = (NSArray*)[dic objectForKey:@"retList"];
			
			if(arryretList){
				
				NSMutableArray *dateList =  [[NSMutableArray alloc] init];
				
				for (int i = 0; i < [arryretList count]; i++) {
					
					
					NSDictionary *retdic = [arryretList objectAtIndex:i];
					
					
					UserGroupList *glist = [self paserWithDictionary:retdic];
						
					
					[dateList insertObject:glist atIndex:i];
					
				
				}
				
				self.arryList  = dateList;
				
				[dateList release];
			
			
			}
			
		
		
		}
		
		[jsonParse release];
	
	}
	
	
	
	return self;


}


-(id) paserWithDictionary:(NSDictionary*)dic{
	UserGroupList *glist = [[[UserGroupList alloc] init] autorelease];
    if (dic) {
	
		glist.groupId = [dic objectForKey:@"id"];
		
		glist.userid = [dic objectForKey:@"userid"];
		
		glist.name = [dic objectForKey:@"name"];
		
		glist.createTime = [dic objectForKey:@"createtime"];
		
	}
	
	return glist;
}

-(void)dealloc{
	
	[groupId release];
	
	[userid release];
	
	[name release];
	
	[createTime release];
	
	[arryList release];
	
	[pageNum release];
	[pageCount release];
	[super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    