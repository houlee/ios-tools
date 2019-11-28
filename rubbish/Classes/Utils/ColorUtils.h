//
//  ColorUtils.h
//  caibo
//
//  Created by jacob on 11-6-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

#define FONT_BIGER  16.0

#define FONT_BIG 15.0

#define FONT_MIDDLE 14.0

#define FONT_SMALL 13.0

#define FONT_SMALLER 12.0

#define FONT_SMALLER_MID 11.0

#define FONT_SMALLEST 10.0



@interface UIColor (UIColorUtils)


+(UIColor*)cellBackgroundColor;

// navigationBar nickname color
+(UIColor*)nickNameOfnavigationBarColor;

// 列表 中 用户明颜色
+(UIColor*)nickNameColor;

// 列表 彩博 正文  和 彩博详情 正文
+(UIColor*)messageTextColor;

// home cell 时间
+(UIColor*)TimeTextColor;

// home cell 原帖 内容
+(UIColor*)originalTopicTextColor;

// homecell 来自
+(UIColor*)fromTextColor;

// homecell 转发和评论
+(UIColor*)replyAndCommentInHomeCellColor;

// 微博详情 nickName 
+(UIColor *)messageDetailNickNameColor;

// 微博详情 链接 和 用户名链接
+(UIColor*)messageDetailLinkColor;

// 微博详细   原帖正文颜色
+(UIColor*) originalTopicTextOfmessageDetailColor;

// 私信一对一 背景
+(UIColor*)usersMailListBgColor;
//私信一对一 时间颜色
+(UIColor*)userMailListTimeColor;




@end
