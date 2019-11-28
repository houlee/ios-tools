//
//  解析微博评论接口
//  caibo
//
//  Created by jeff.pluto on 11-6-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TopicComment : NSObject {
    NSMutableArray *arrayList;
    NSString *userId;
    NSString *nickName;
    NSString *createtime;
    NSString *content;
    NSString *replyid;
    NSString *nick_name_ref;
    NSString *ycid;// 该评论ID
    NSString * louceng;
    NSString * vip;
}

@property(nonatomic,retain) NSMutableArray *arrayList;
@property(nonatomic,retain) NSString *userId, *nickName, *createtime, *content, *ycid, *replyid, *nick_name_ref, * louceng, *vip;

//-(NSMutableArray*) initWithParse:(NSString*)responseString;
-(NSMutableArray*) arrayWithParse:(NSString*)responseString;
-(id) paserWithDictionary:(NSDictionary*)dic;

@end