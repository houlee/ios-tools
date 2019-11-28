//
//  AttenList.h
//  caibo
//
//  Created by jeff.pluto on 11-6-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttenList : NSObject 
{
	// 重写 关注 列表解析
	NSMutableArray *arrayList;
	NSString *sex;
	NSString *audi; 
	NSString *fans;
	NSString *state; 
	NSString *date_created;
	NSString *city;
	NSString *nick_name;
	NSString *vip;
	NSString *userId;
	NSString *province;
	NSString *big_image;
	NSString *aNewTopic;
	NSString *attention;     // 关注数
	NSString *activation;
	NSString *topicsize;     // 微博数
	NSString *image;
	NSString *mid_image; 
    NSString *signatures;    // 个性签名
	NSString *usertype;
	NSString *mobile; 
    NSString *is_relation;
    NSString *user_name;
    NSString *source;
    NSString *true_name;
	NSString *last_updated;
	NSString *sma_image;
    NSString *mnewTopic;
}

@property(nonatomic,retain)NSMutableArray *arrayList;

@property(nonatomic,retain)NSString *sex,*audi,*fans,*state,*date_created,*city,*nick_name,*vip,*userId,*province,
*big_image,*aNewTopic,*attention,*activation,*topicsize,*image,*mid_image,*signatures,*usertype,*mobile,*is_relation,*user_name,

*source,*true_name,*last_updated,*sma_image,*mnewTopic;

// 关注列表解析
- (NSMutableArray*)arrayWithParse:(NSString *)jsonString;

// 重写 关注 列表解析
-(id)initWithparse:(NSString*)responseString;
-(id) paserWithDictionary:(NSDictionary*)dic;


@end