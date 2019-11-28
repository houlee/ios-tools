//
//  ChatBubbleCell.h
//  caibo
//
//  Created by jacob on 11-7-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProfileImageCell.h"

#import "ChatBubbleView.h"

@interface ChatBubbleCell : ProfileImageCell {
	
	BOOL isUserSelf;
	
	ChatBubbleView *chatview;
	
	CGRect textBounds;

}

@property (nonatomic,retain)ChatBubbleView *chatview;

-(void)setUserself:(BOOL)isuserSelf;

-(void)setInfoText:(NSString*)messageText;

-(CGFloat)cellHeigth;

// 计算数据的 矩形大小
-(CGRect)setTextBounds:(NSString*) stext setFontSize:(CGFloat)fontSize;


@end
