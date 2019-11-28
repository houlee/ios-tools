//
//  HotYtTopicandComment.h
//  caibo
//
//  Created by jacob on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


/*
 *2.34－  热门转发
 *2.35 －热门评论
 */

#import <Foundation/Foundation.h>


@interface HotYtTopicandComment : NSObject {
	
	NSMutableArray *arryList;
	NSString *Id;
	NSString *nick_name;
	NSString *vip;
    NSString *topicid;
	NSString *count_zt;
	NSString *count_sc;
	NSString *count_pl;
	NSString *rec_title;
	NSString *rec_content;
	NSString *sma_image;
	NSString *mid_image;
	NSString *date_created;
	NSString *source;
	NSString *site;
	NSString *userId;
	NSString *orignal_id;
	NSString *fw_topic_id;
	NSString *attach_small;
	NSString *image;
	NSString *attach_type;
	//处理后的数据
	NSString *mrec_content;
    NSString *isCc;
    NSString *timeformate;
    NSString *attach;
    NSString *content_ref;
    NSString *nick_name_ref;
    NSString *count_zf_ref;
    NSString *count_pl_ref;
}


@property(nonatomic,retain)NSMutableArray *arryList;

@property(nonatomic,retain)NSString *Id,*nick_name,*vip,*count_zt,*count_sc,*count_pl,*rec_title,*rec_content,*sma_image,*mid_image,*date_created,*source,*site,
*userId,*orignal_id,*fw_topic_id,*attach_small,*image,*attach_type, *topicid, *isCc, *timeformate,*attach, *content_ref,*nick_name_ref,*count_zf_ref,*count_pl_ref;


@property(nonatomic,retain)NSString *mrec_content;

-(id)initWithParse:(NSString*)responseString;
-(id) paserWithDictionary:(NSDictionary*)dic;


@end
