//
//  StringUtil.h
//  caibo
//
//  Created by jeff.pluto on 11-6-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSStringExtra.h"

@interface StringUtil : NSObject {
}
+ (UIFont *) getFont;
+ (CGFloat) stringWidth : (NSString *) txt;
+ (CGFloat) stringHeight : (NSString *) txt;
+ (int) charWidth : (char) c;

/**
 *计算字符串总共有几个字符
 */
+ (int) calcCharCount : (NSString *) txt offset : (int) offset width : (int) width;

/**
 * 按照指定长度切割字符串
 * @param txt
 * @param width
 * @return
 */
+ (NSMutableArray *) splitStringArray : (NSString *) txt width : (int) width result : (NSMutableArray *) rlt;

@end