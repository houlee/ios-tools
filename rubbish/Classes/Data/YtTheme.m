//
//  YtTheme.m
//  caibo
//
//  Created by jeff.pluto on 11-6-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "YtTheme.h"
#import "SBJSON.h"

@implementation YtTheme

@synthesize arrayList;
@synthesize createtime, ytThemeId, order_num, name, isCc;
@synthesize ytname;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return  self;
}

- (NSArray*) arrayWithParse:(NSString *)jsonString 
{
    if(nil == jsonString)
		return NULL;
    
//    if (nil == arrayList) 
//    {
//        arrayList = [NSMutableArray array];
//    }
    
    SBJSON *json = [[SBJSON alloc] init];
	NSArray *array = [json objectWithString:jsonString];
	if (array) {
        NSMutableArray *bufferArray = [[NSMutableArray alloc] init];
        int count = (int)[array count];
        if (count != 0) 
        {
            for (int i = 0; i < count; i++) 
            {
                NSDictionary *dictArray = [array objectAtIndex:i];
                YtTheme *theme = [self paserWithDictionary:dictArray];
                [bufferArray addObject:theme];
            }
        }
        self.arrayList = bufferArray;
        [bufferArray release];
	}
    [json release];
    
	return arrayList;
}

- (id) paserWithDictionary:(NSDictionary *)dic 
{
    YtTheme *list = [[[YtTheme alloc] init] autorelease];    
    if(dic){
        list.createtime = [dic valueForKey:@"createtime"];
        list.ytThemeId = [dic valueForKey:@"id"];
        list.order_num = [dic valueForKey:@"order_num"];
        list.name = [dic valueForKey:@"name"];
		if (list.name) 
        {
			NSMutableString *titles = [[NSMutableString alloc] init];
			[titles appendString:@"#"];
			[titles appendFormat:@"%@",list.name];
			[titles appendString:@"#"];
			list.ytname = titles;
			[titles release];
		}
	}
    return list;
}

-(void)dealloc 
{
	[arrayList release];
    
    [createtime release];
    [ytThemeId release];
	[order_num release];
	[name release];
    [isCc release];
	[ytname release];

    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    