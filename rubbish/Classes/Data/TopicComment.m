//
//  TopicComment.m
//  caibo
//
//  Created by jeff.pluto on 11-6-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TopicComment.h"
#import "NSStringExtra.h"
#import "SBJSON.h"
#import "Info.h"

@implementation TopicComment

@synthesize arrayList, userId, content, nickName, createtime, ycid, replyid, nick_name_ref, louceng, vip;


-(NSMutableArray *) arrayWithParse:(NSString*)jsonString {
    if(nil == jsonString)
		return NULL;
    
    if (nil == arrayList) {
        arrayList = [[NSMutableArray alloc] init];
    }
    
    SBJSON *json = [SBJSON new];
	NSArray *array = (NSArray *)[json objectWithString:jsonString error:nil];
    NSMutableArray *bufferArray = [[NSMutableArray alloc] init];
	if (nil != array) {
        int count = (int)[array count];
        if (count != 0) {
            for (int i = 0; i < count; i++) {
                NSDictionary *dictArray = [array objectAtIndex:i];
                TopicComment *comment = [self paserWithDictionary:dictArray];
				if (comment.userId) {
					[bufferArray addObject:comment];
				}
            }
            self.arrayList = bufferArray;
        }
	}
    
    [json release];
    [bufferArray release];
    
	return arrayList;
    
}

- (BOOL) isMe : (NSString *) name {
    if ([name isEqualToString:[[Info getInstance] nickName]]) {
        return YES;
    }
    return NO;
}

- (id) paserWithDictionary:(NSDictionary *)dic {
    TopicComment *mComment = [[[TopicComment alloc] init] autorelease];
    if(dic){
        mComment.userId = [dic valueForKey:@"id"];
        mComment.nickName = [dic valueForKey:@"nick_name"];
        
        mComment.createtime = [dic valueForKey:@"timeformate"];
		
        NSString *text = [dic valueForKey:@"content"];
        mComment.content = [text flattenPartHTML:text];
        mComment.vip = [dic valueForKey:@"vip"];
        mComment.ycid = [dic valueForKey:@"ycid"];
        mComment.replyid = [dic valueForKey:@"replyid"];
        mComment.nick_name_ref = [dic valueForKey:@"nick_name_ref"];
        if ([dic valueForKey:@"rownum"]) {
            mComment.louceng = [NSString stringWithFormat:@"%@楼",[dic valueForKey:@"rownum"]];
        }
        
        
        
        if ([self isMe:mComment.nickName]) {
            if ([mComment.replyid isEqualToString:@"0"]) {// 我回复微博
                mComment.nickName = @"我";
            } else {
                if ([self isMe:mComment.nick_name_ref]) {// 我回复我
                    mComment.nickName = @"我 回复 我";
                } else if ([mComment.nick_name_ref length]){// 我回复他人
                    mComment.nickName = [@"我 回复 " stringByAppendingString: mComment.nick_name_ref];
                }
				else{
					mComment.nickName = @"我";
				}
            }
        } else {// 他人发布的评论
            if (![mComment.replyid isEqualToString:@"0"]) {// 他人回复评论
                // 判断他人是否是回复的我的评论
                if ([self isMe:mComment.nick_name_ref]) {
                    mComment.nickName = [[mComment.nickName stringByAppendingString:@" 回复 "] stringByAppendingString:@"我"];
                } else {
                    // 他人回复他人评论
					if (nick_name_ref) {
						mComment.nickName = [[mComment.nickName stringByAppendingString:@" 回复 "] stringByAppendingString:mComment.nick_name_ref];
					}
                }
            } else {
                // 他人回复微博
            }
        }
        
	}
    return mComment;
}

- (void) dealloc {
    [louceng release];
    [userId release];
	[arrayList release];
    [nickName release];
	[createtime release];
    [content release];
    [ycid release];
    [replyid release];
    [nick_name_ref release];
	[super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    