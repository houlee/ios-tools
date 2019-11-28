//
//  FansList.h
//  caibo
//
//  Created by jacob on 11-5-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


// 2.18 我的粉丝列表
#import <Foundation/Foundation.h>


@interface FansList : NSObject {
	
	NSMutableArray *arrayList;
	
	NSString *userId;
	
	NSString *state;
	
	NSString *image;

	NSString *nick_name;

	NSString *vip;
	
	NSString *date_created;
	
	NSString *mobile;
	
	NSString *activation;
	
	NSString *true_name;
	
	NSString *attention;
	
	NSString *usertype;
	
	NSString *sex;
	
	NSString *big_image;
	
	NSString *mid_image;
	
	NSString *sma_image;
	
	NSString *audi;
	NSString *fans;
	NSString *topicsize;
	
	NSString *last_updated;
	
	NSString *is_relation;
	
	
	
	NSString *aNewTopic;
	
	// 处理后的数据
	
	NSString *mnewTopic;

	

}

@property(nonatomic ,retain)NSMutableArray *arrayList;

@property (nonatomic,retain)NSString *userId,*state,*image,*nick_name,*vip,*user_name,*date_created,*mobile,*activation,

*true_name,*attention,*usertype,*sex,*big_image,*mid_image,*sma_image,*audi,*fans,*topicsize,

*last_updated,*is_relation;

@property(nonatomic,retain)NSString *aNewTopic;

@property(nonatomic,retain)NSString *mnewTopic;




-(id)initWithParse:(NSString*)responseString;
-(id) paserWithDictionary:(NSDictionary*)dic;

@end
