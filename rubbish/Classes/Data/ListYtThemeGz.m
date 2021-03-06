//
//  listYtThemeGz.m
//  caibo
//
//  Created by jacob on 11-6-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ListYtThemeGz.h"
#import "SBJSON.h"

@implementation ListYtThemeGz

@synthesize arryList;
@synthesize result;
@synthesize msg;
@synthesize themeId;
@synthesize name;

- (id)initWithParse:(NSString*)responseString
{	
	if(responseString ==nil)
		return nil;
    
	if((self = [super init]))
    {
		SBJSON *jsonParse = [[SBJSON alloc] init];
		if ([responseString hasPrefix:@"{"]) 
        {
			NSDictionary *mdic = [jsonParse objectWithString:responseString];
			self.result = [mdic objectForKey:@"result"];
			self.msg = [mdic objectForKey:@"msg"];
		}
        else 
        {
			NSArray *arry = [jsonParse objectWithString:responseString];
			NSMutableArray *dateList =  [[NSMutableArray alloc] init];	
			for (int i = 0; i < [arry count]; i++) 
            {
				NSDictionary *dic = [arry objectAtIndex:i];
				ListYtThemeGz *list = [self paserWithDictionary:dic];  
				[dateList insertObject:list atIndex:i];	
			}
			self.arryList = dateList;
			[dateList release];
		}
        [jsonParse release];
	}
	return self;
}


-(id) paserWithDictionary:(NSDictionary*)dic
{	
	if (dic) 
    {
		ListYtThemeGz *list = [[[ListYtThemeGz alloc]init] autorelease];
        list.themeId = [dic valueForKey:@"id"];
		list.name = [dic valueForKey:@"name"];
		if (list.name) 
        {
			NSMutableString *titles = [[NSMutableString alloc] init];
			[titles appendString:@"#"];
			[titles appendFormat:@"%@", list.name];
			[titles appendString:@"#"];
			list.name = titles;
			[titles release];
		}
		return list;
	}
	return nil;
}

-(void)dealloc
{	
	[arryList release];
	[result release];
	[msg release];
    [themeId release];
	[name release];

    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    