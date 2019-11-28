//
//  DataUtils.m
//  caibo
//
//  Created by jacob on 11-6-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataUtils.h"


@implementation DataUtils

// 计算 cell 高度
+(CGFloat)CellHeigth:(NSString*)messageText messageFontSize:(CGFloat)mFontSize originText:(NSString*)originText originTextFontSize:(CGFloat)oFontSize
{
	CGSize maxSize = CGSizeMake(220, 2000);
	CGFloat cellHeigth=0,messageHeigth= 0,originTextHeigth =0 ;
	
	if(messageText)
    {
		CGSize textSize =[messageText sizeWithFont:[UIFont systemFontOfSize:mFontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeCharacterWrap];
		messageHeigth = textSize.height;
		
	}
	
 
	if(originText)
    {
 
		CGSize textSize =[originText sizeWithFont:[UIFont systemFontOfSize:oFontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeCharacterWrap];	
		originTextHeigth = textSize.height;
 
		cellHeigth = messageHeigth+originTextHeigth + 20*4;
	}
    else
    {
 
		cellHeigth = messageHeigth+20*3;
 
	}
	
	return cellHeigth + 10.0;
}

+(CGFloat)textWidth:(NSString*)text Fontsize:(CGFloat)mFontSize{
	
	CGSize maxSize = CGSizeMake(100, 2000);

	CGFloat textWidth = 0;
	
	if (text) {
		
		CGSize textSize =[text sizeWithFont:[UIFont systemFontOfSize:mFontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeCharacterWrap];
		
		textWidth = textSize.width;

	}

	return textWidth;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    