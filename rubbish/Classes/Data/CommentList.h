//
//  CommentList.h
//  caibo
//
//  Created by jacob on 11-5-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


// 2.8 获取评论 解析接口
#import <Foundation/Foundation.h>
@class YtTopic;

@interface CommentList : NSObject {
	
	NSMutableArray *arrayList;
	
	
	NSString *userId;
	
	
	// 原帖 内容
	NSString *content;
	
	NSString *nick_name;
	
	NSString *vip;
	
	NSString *topicid;
	
	NSString *timeformate;
	
	// 评论 内容 
	NSString *content_text;
	
	
	NSString *mid_image;
	
	NSString *date_created;
	
	NSString *sma_image;
	
	NSString *attach_type;
	
	NSString *ycid;
	
	NSString *orignal_id;
	
	//  数据处理后的
	
	NSString *mcontent;
	NSString *mcontent_text;
    NSString *colorcontent;
    NSString *colormcontent_text;
	
	
	// 新增参数
	
	NSString *sma_image_ref;
	
	NSString *comcount;
	
	NSString *mid_image_ref;
	
	NSString *date_created_ref;
	
	NSString *id_ref;
	
	NSString *replyid;
	
	NSString *nick_name_ref;
	
	NSString *content_ref;
	
    BOOL isauto;

    NSString * count_dz;//点赞数量
    NSString * praisestate;//是否已经点赞
}
@property(nonatomic ,retain)NSMutableArray *arrayList;

@property(nonatomic,retain)NSString *userId,*content,*colormcontent,*colormcontent_text,*nick_name,*vip,*topicid,*timeformate,*content_text,*mid_image,*date_created,*sma_image,*attach_type, * count_dz, * praisestate;

@property(nonatomic,retain)NSString *ycid;

@property(nonatomic,retain)NSString *orignal_id;

@property(nonatomic,retain)NSString *mcontent,*mcontent_text;

@property(nonatomic,retain)NSString *sma_image_ref,*comcount,*mid_image_ref,*date_created_ref,*id_ref,*replyid,*nick_name_ref,*content_ref;

@property (nonatomic,assign) BOOL isauto;

-(id)initWithParse:(NSString*)responseString;
-(id) paserWithDictionary:(NSDictionary*)dic;


@end
