//
//  FolloweeCellView.m
//  caibo
//
//  Created by jeff.pluto on 11-6-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FolloweeCellView.h"
#import "StringUtil.h"
#import "ProfileImageCell.h"

@implementation FolloweeCellView

@synthesize followee;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void)drawRect:(CGRect)rect {
    int mTag = followee.mTag;
    NSString *name = followee.name;
    if (mTag == AttenList) {// @联系人
//        [name drawInRect:CGRectMake(LEFT +13, 18, CELL_WIDTH, 24) withFont:[UIFont boldSystemFontOfSize:18]];
        [name drawInRect:CGRectMake(LEFT, 8, CELL_WIDTH, 24) withFont:[UIFont boldSystemFontOfSize:18]];
    } else if(mTag == ListYtTheme) {// 插入话题
        NSMutableString *textBuffer = [[NSMutableString alloc] init];
        [textBuffer appendString:@"#"];
        [textBuffer appendString:name];
        [textBuffer appendString:@"#"];
        
        [textBuffer drawInRect:CGRectMake(0, 22, CELL_WIDTH, 24) withFont:[StringUtil getFont]];
        [textBuffer release];
    } else if (mTag == SearchListYtTheme) {// 搜索插入话题无结果
        NSMutableString *textBuffer = [[NSMutableString alloc] init];
        if (![name isEqualToString:@"热门话题"]) {
            [[UIColor blueColor] set];
            [textBuffer appendString:@"#"];
            [textBuffer appendString:name];
            [textBuffer appendString:@"#"];
        } else {
            [textBuffer appendString:name];
        }
        
        [textBuffer drawAtPoint:CGPointMake(5, (50 - [StringUtil stringHeight:name]) / 2) withFont:[StringUtil getFont]];
        [textBuffer release];
    }
    else if (mTag == SearchAttenList) {// 搜索@联系人无结果
        if ([name isEqualToString:@"在网络上搜索"]) {
            [name drawAtPoint:CGPointMake(5, (50 - [StringUtil stringHeight:name]) / 2) withFont:[StringUtil getFont]];
        } else {
            [[@"@" stringByAppendingString: name] drawAtPoint:CGPointMake(5, (50 - [StringUtil stringHeight:name]) / 2) withFont:[StringUtil getFont]];
        }
    }
    else if (mTag == SearchMailList) {// 写私信搜索联系人无结果
        [name drawAtPoint:CGPointMake(10, (60 - [StringUtil stringHeight:name]) / 2) withFont:[StringUtil getFont]];
    } else if (mTag == SearchUser) {
        
        if (name) {
            [name drawInRect:CGRectMake(LEFT+15, 12, CELL_WIDTH, 24) withFont:[UIFont systemFontOfSize:20]];
        }
        NSString *fans = followee.fansCount;
        if (fans) {
            fans = [@"粉丝：" stringByAppendingString: fans];
            [fans drawInRect:CGRectMake(LEFT+15, 36, CELL_WIDTH, 24) withFont:[UIFont systemFontOfSize:15]];
        }
    } else if (mTag == FansAttenPrivater) {
        if (name) {
            [name drawInRect:CGRectMake(LEFT, 8, CELL_WIDTH, 24) withFont:[UIFont systemFontOfSize:16]];
        }
        
        if (followee.fansCount) {
            [[UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1] set];
            [followee.fansCount drawInRect:CGRectMake(LEFT, 30, CELL_WIDTH, 24) withFont:[UIFont systemFontOfSize:14]];
        }
        
        if (followee.time && [followee.time length]) {
            [[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1] set];
            int w = [followee.time sizeWithFont:[UIFont systemFontOfSize:13]].width;
            [followee.time drawInRect:CGRectMake(CELL_WIDTH - w+35, 5, 100, 24) withFont:[UIFont systemFontOfSize:12]];
        }
        
        
    }
    
    else if (mTag == SiXin) {
        if (name) {
            [name drawInRect:CGRectMake(LEFT, 2, CELL_WIDTH, 24) withFont:[UIFont systemFontOfSize:16]];
        }
        
        if (followee.fansCount) {
            [[UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1] set];
            
#ifdef isCaiPiaoForIPad
             [followee.fansCount drawInRect:CGRectMake(LEFT, 30, CELL_WIDTH_PAD, 24) withFont:[UIFont systemFontOfSize:14]];
#else
            [followee.fansCount drawInRect:CGRectMake(LEFT, 30, CELL_WIDTH, 24) withFont:[UIFont systemFontOfSize:14]];
            
#endif
        }
        
        if (followee.time && [followee.time length]) {
            [[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1] set];
            int w = [followee.time sizeWithFont:[UIFont systemFontOfSize:13]].width;
#ifdef isCaiPiaoForIPad
            [followee.time drawInRect:CGRectMake(CELL_WIDTH_PAD - w+48, 5, 100, 24) withFont:[UIFont systemFontOfSize:12]];
#else
//            [followee.time drawInRect:CGRectMake(CELL_WIDTH - w+48, 5, 100, 24) withFont:[UIFont systemFontOfSize:12]];
            [followee.time drawInRect:CGRectMake(CELL_WIDTH - w+48+10, 4, 100, 24) withFont:[UIFont systemFontOfSize:12]];
#endif
            
        }
        
        
    }
    
}

- (void)dealloc {
    [followee release];
    [super dealloc];
}


@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    