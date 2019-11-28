//
//  UserInfo.h
//  caibo
//
//  Created by jacob on 11-5-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


// 2.6 获取用户信息 解析类

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject 
{
	NSString *userId;
	NSString *state; 
	NSString *image;
    NSString *signatures;    // 个性签名
	NSString *nick_name;     // 昵称
	NSString *vip;
    NSString *date_created;
	NSString *mobile; 
	NSString *activation;
	NSString *usertype;
	NSString *sex;           // 性别
	NSString *big_image;
	NSString *mid_image; 
	NSString *sma_image;
	NSString *audi; 
    NSString *attention;     // 关注数
	NSString *fans;          // 粉丝数
	NSString *topicsize;     // 微博数
	NSString *themesize;     // 话题数
	NSString *favoritesize;  // 收藏数
    NSString *blacksize;
	NSString *last_updated;
	NSString *city;
    NSString *province;
    NSString *address;
    NSString *last_topic_id;
    NSString *aNewTopic;
    NSString *is_relation;
    NSString *user_name;
    NSString *source;
    NSString *email;
    NSString *true_name;
	NSString *instruction;
	NSString *authentication;
	
    NSString * isbindmobile;//是否手机绑定
    
	NSString *userName;//userName //买彩票用户名
    NSString *id_number;//身份证号；
	
	//处理 后数据
	
    NSString *mnewTopic;
	
	
	NSArray *arrayList;
	NSString *unionStatus;
	NSString *unionId;//第三方ID;
	NSString *partnerid;//第三方300表示新浪微博，301表示腾讯，311表示qq登录
     NSString * accesstoken;//加密秘钥
	
    NSString * flag;//当前已有的国旗数
    NSString * needFlag;//升级所需的国旗数
    NSString * cupType;//奖杯等级  (1,2,3)对应铜杯、银杯、金杯 0，是暂无奖杯
    NSString * sysTime;//系统当前时间
    NSString * activeStartTime;//活动开始时间
    NSString * activeEndTime;//活动结束时间
    NSString * isOpen;//活动是否开启 0，活动未开启；1，活动开启
    NSString * userActiveStatus;//用户报名状态 0，未报名；1，报名成功
}

@property (nonatomic,retain) NSArray *arrayList;
@property (nonatomic, retain) NSString *userId, *state, *image, *signatures, 
*nick_name, *vip, *date_created, *mobile, *activation, *attention, *usertype, 
*sex, *big_image, *mid_image, *sma_image, *audi, *fans, *topicsize, *themesize, 
*favoritesize, *last_updated, *city, *province, *address, *last_topic_id, *aNewTopic, 
*is_relation, *user_name, *source, *email, *true_name, *blacksize, *instruction,
*userName,*authentication,*unionStatus,*unionId,*partnerid, * isbindmobile,*id_number, * accesstoken, * flag, *needFlag, * cupType, *sysTime, * activeStartTime, * activeEndTime, * isOpen, * userActiveStatus;

@property(nonatomic,retain)NSString *mnewTopic;
// 初始化 （NSString||NSDictionary）
-(id)initWithParse:(NSString*)responseString DIC:(NSDictionary*)dic;

- (NSArray*) arrayWithParse:(NSString *)jsonString;
-(id) paserWithDictionary:(NSDictionary*)dic;

@end
