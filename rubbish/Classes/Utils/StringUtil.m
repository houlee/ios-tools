//
//  StringUtil.m
//  caibo
//
//  Created by jeff.pluto on 11-6-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "StringUtil.h"

static UIFont *font;

@implementation StringUtil

+ (UIFont *) getFont {
    if (font == nil) {
        font = [UIFont systemFontOfSize:18];
    }
    return font;
}

+ (CGFloat) stringWidth:(NSString *)txt {
    return [txt sizeWithFont:[StringUtil getFont]].width;
}

+ (CGFloat) stringHeight:(NSString *)txt {
    return [txt sizeWithFont:[StringUtil getFont]].height;
}

+ (int) charWidth:(char)c {
    return 1;
}

+ (int) calcCharCount:(NSString *)txt offset:(int)offset width:(int)width {
    int strWidth = 0;
    int num = 0;
    int stringLen = (int)[txt length];
    while (offset + num < stringLen && (width < 0 || strWidth < width)) {
        char c = [txt characterAtIndex:(offset + num)];
        int w = [[NSString stringWithFormat:@"%c", c] sizeWithFont:[StringUtil getFont]].width;
        
        strWidth += w;
        if(strWidth <= width) {
            num ++;
        } else {
            break;
        }
        if (c == '\n' || c == '\r') {
            break;
        }
    }
    return num;
}

/**
 * 按照指定长度切割字符串
 * @param txt
 * @param width
 * @return
 */
+ (NSMutableArray *) splitStringArray:(NSString *)txt width:(int)width result:(NSMutableArray *)rlt{
    if(rlt == nil){
        rlt = [[[NSMutableArray alloc] init] autorelease];
    }
    
    int w = [txt sizeWithFont:[StringUtil getFont]].width;
    if(w <= width){
        [rlt addObject:txt];
        return rlt;
    } else {
        int offset = 0, num = 0;
        NSString *str = nil;
        while (offset + num < [txt length]) {
            num = [StringUtil calcCharCount:txt offset:offset width:width];
            if(num > 0) {
                str = [txt substringWithRange:NSMakeRange(offset, offset + num)];
                [rlt addObject:str];
            } else {
                break;
            }
            offset += num;
            num = 0;
        }
    }
    return rlt;
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    