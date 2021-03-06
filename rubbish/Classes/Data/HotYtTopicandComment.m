//
//  HotYtTopicandComment.m
//  caibo
//
//  Created by jacob on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HotYtTopicandComment.h"
#import "SBJSON.h"
#import "NSStringExtra.h"

@implementation HotYtTopicandComment


@synthesize Id,nick_name,vip,count_zt,count_sc,count_pl,rec_title,rec_content,sma_image,mid_image,date_created,source,site,
userId,orignal_id,fw_topic_id,attach_small,image,attach_type,isCc,timeformate,topicid,attach, content_ref, nick_name_ref, count_zf_ref, count_pl_ref;

@synthesize arryList;

@synthesize mrec_content;

-(id)initWithParse:(NSString*)responseString{
	
	if(responseString ==nil)
		return NULL;
	
	if((self=[super init])) {
		SBJSON *jsonParse = [[SBJSON alloc] init];
		NSArray *arry = [jsonParse objectWithString:responseString];
		if (arry) {
            NSMutableArray *dateList = [[NSMutableArray alloc] init];
			for (int i = 0; i < [arry count]; i++) {
				NSDictionary *dic = [arry objectAtIndex:i];	
				HotYtTopicandComment *ytTopic = [self paserWithDictionary:dic];
				[dateList insertObject:ytTopic atIndex:i];
			}
			self.arryList = dateList;
			[dateList release];
		}
		[jsonParse release];
	}
	return self;
}

-(id) paserWithDictionary:(NSDictionary*)dic {
	
	HotYtTopicandComment *list = [[[HotYtTopicandComment alloc] init] autorelease];
	
	if (dic) {
		list.Id = [dic valueForKey:@"id"];
		list.nick_name = [dic valueForKey:@"nick_name"];
		list.nick_name = [list.nick_name nickName:list.userId];
		list.vip = [dic valueForKey:@"vip"];
		list.count_zt = [NSString stringWithFormat:@"%d",[[dic valueForKey:@"count_zf"] intValue]];
		list.count_sc = [dic valueForKey:@"count_sc"];
		list.count_pl = [NSString stringWithFormat:@"%d",[[dic valueForKey:@"count_pl"] intValue]];
		list.rec_title = [dic valueForKey:@"rec_title"];
		list.rec_content = [dic valueForKey:@"rec_content"];
		if (list.rec_content) {
			list.mrec_content = [list.rec_content flattenPartHTML:list.rec_content];	
		}
		list.sma_image = [dic valueForKey:@"sma_image"];
		list.mid_image = [dic valueForKey:@"mid_image"];
		
		if(![list.mid_image hasPrefix:@"http"]){
			NSMutableString *senderImage = [[NSMutableString alloc] init];
			[senderImage appendString:@"http://t.diyicai.com/"];
			[senderImage appendString:list.mid_image];			
			list.mid_image = senderImage;

			[senderImage release];
		}
		list.date_created = [dic valueForKey:@"date_created"];
		list.source = [dic valueForKey:@"source"];
		list.site = [dic valueForKey:@"site"];
		list.userId = [dic valueForKey:@"userid"];
		list.orignal_id = [dic valueForKey:@"orignal_id"];
		list.fw_topic_id = [dic valueForKey:@"fw_topic_id"];
		list.attach_small = [dic valueForKey:@"attach_small"];
		list.image = [dic valueForKey:@"image"];
		list.attach_type = [dic valueForKey:@"attach_type"];
        
        list.topicid = [dic valueForKey:@"topicid"];
        list.isCc = [dic valueForKey:@"isCc"];
        list.timeformate = [dic valueForKey:@"timeformate"];
        list.attach = [dic valueForKey:@"attach"];
        list.content_ref = [dic valueForKey:@"content_ref"];
        list.nick_name_ref = [dic valueForKey:@"nick_name_ref"];
        list.count_zf_ref = [dic valueForKey:@"count_zf_ref"];
        list.count_pl_ref = [dic valueForKey:@"count_pl_ref"];
	}
	return list;
}

-(void)dealloc{
	[arryList release];
	[Id release];
	[nick_name release];
	[vip release];
	[count_pl release];
	[count_zt release];
	[count_sc release];
	[rec_title release];
	[rec_content release];
	[sma_image release];
	[mid_image release];
	[date_created release];
	[source release];
	[site release];
	[userId release];
	[orignal_id release];
	[fw_topic_id release];
	[attach_type release];
	[attach_small release];
	[image release];
	[mrec_content release];
    
    [topicid release];
    [isCc release];
    [attach release];
    [timeformate release];
    [content_ref release];
    [nick_name_ref release];
    [count_pl_ref release];
    [count_zf_ref release];

    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    