//
//  PublicMethod.m
//  Experts
//
//  Created by mac on 15/10/29.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PublicMethod.h"
#import "SharedMethod.h"

@implementation PublicMethod
//算出字体大小
+(CGSize)setNameFontSize:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=7) {
       return [SharedMethod getSizeByText:text font:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
//        NSDictionary * atts=@{NSFontAttributeName:font};
//        return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:atts context:nil].size;
    }
    return [text sizeWithFont:font forWidth:maxSize.width lineBreakMode:NSLineBreakByWordWrapping];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    