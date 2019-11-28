//
//  CheckNewMsg.h
//  caibo
//
//  Created by jacob on 11-7-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/***
 *2.57未读的 推送 消息数
 *
 **/

#import <Foundation/Foundation.h>


@interface CheckNewMsg : NSObject {
	
	NSString *zxdt;// 最新动态数
	
	NSString* zxkj;//最新开奖数
	
	NSString* zjsc;//专家说
	
	NSString* gfzz;//官方组织
	
	NSString *dlttj;//大乐透推荐
	
	NSString* mrcb;//名人彩博数
	
	NSString* atme;//@我
	
	NSString* pl;//评论箱
	
	NSString* sx;//私信数
	
	NSString* gzrft;//关注 发帖
	
	NSString *gz;//新粉丝 人数
	
	NSString *xttz;
	NSString *tx;//提醒
	NSString *zj;//中奖
    NSString * kefucountstr;

}

@property(nonatomic,retain)NSString*zxdt,*zxkj,*zjsc,*gfzz,*mrcb,*atme,*pl,*sx,*gzrft,*gz,*xttz,*dlttj,*tx,*zj, *kefucountstr;

-(id)initWithParse:(NSString*)responseString;


@end
