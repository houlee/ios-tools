//
//  NSStringExtra.h
//  caibo
//
//  Created by jacob on 11-6-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YtTopic;

@interface NSString (NSStringExtra)

//字符串转换为:距离目前时间的间隔
//- (NSString*)dateStringToTimeInterval;

//字符串转换为TimeInterval
- (NSString *)stringToDateTimeInterval;

// html 除去 tag
- (NSString *)flattenHTML:(NSString *)html;

//带颜色；
-(NSString*)flattenColorPartHTML:(NSString*)html;
// html处理表情和 关注等 tag
- (NSString*)flattenPartHTML:(NSString*)html;

- (BOOL)isUserself;

- (NSString*)nickName:(NSString*)userID;

- (NSString *)stringToFace;

- (NSString*)faceTestChange;

//将lotteryId转换为名称
- (NSString *)lotteryIdChange;

// 判断字符串全是数字
- (BOOL)isAllNumber;
// 判断是否含有符号
- (BOOL)isContainSign;
// 判断是否含有大写字母
- (BOOL)isContainCapital;
// 判断密码是否符合要求
- (BOOL)isConform;
//判断全汉字
- (BOOL)isMatchWithRegexString:(NSString *)regexString;
//判断手机号
- (BOOL)isPhoneNumber;
- (BOOL)isallaz;

//中英文字符串长度
- (NSInteger)zifuLong;
//GC_
- (NSMutableArray*)SplitStringByChar:(NSString *)splitchar;
- (NSString *)concat:(NSString *)obj1 obj2:(NSInteger)obj2;

//判断15位身份证

- (BOOL)shenfenzheng15;

//MD5加密
- (NSString *) stringFromMD5;

//url地址解析
-(NSString *)urlParseWithString:(NSString *)_url;

@end
