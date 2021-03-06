//
//  ChatBubbleCell.m
//  caibo
//
//  Created by jacob on 11-7-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChatBubbleCell.h"
#import "ColorUtils.h"

@implementation ChatBubbleCell

@synthesize chatview;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
		isUserSelf = NO;
		
		ChatBubbleView *chatView = [[ChatBubbleView alloc] initWithFrame:CGRectZero];
		
		self.chatview = chatView;
		
		[self.contentView addSubview:chatView];
		
		[chatView release];
		
		
    }
	self.backgroundColor = [UIColor clearColor];
	[self setAccessoryType:UITableViewCellAccessoryNone];
    return self;
}

-(void)fetchProfileImage:(NSString *)url{
	
	[super fetchProfileImage:url];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


// 传入需要 绘制的数据
-(void)setInfoText:(NSString*)messageText{
	
	if (messageText) {
		
		self.chatview.message = messageText;
		
		CGRect mBounds =[self setTextBounds:messageText setFontSize:FONT_MIDDLE];
		
		
		
		[self.chatview setTextBounds:mBounds];
		
	}else {
		
		self.chatview.message =nil;
	}


}

// 判断是否是 己方
-(void)setUserself:(BOOL)isuserSelf{
	
	isUserSelf = isuserSelf;
	
}


// 计算数据的 矩形 大小
-(CGRect)setTextBounds:(NSString*) stext setFontSize:(CGFloat)fontSize{
	
	CGRect textbounds;
	
	if(stext){
		
				
		CGSize maxSize = CGSizeMake(220, 2000);
		
		CGSize textSize =[stext sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeCharacterWrap];	
		
		textbounds = CGRectMake(0, 0, textSize.width, textSize.height);
		
		textBounds = textbounds;
		
	}
	
	return textbounds;
		
}



-(CGFloat)cellHeigth{
	
	CGFloat cellheigth;
	
	if (textBounds.size.height>35) {
	
		cellheigth = textBounds.size.height+TEXT_HEIRTH;
		
	}else {
		
		cellheigth =32+TEXT_HEIRTH;
		
	}

	
	return cellheigth;
	
	
	
}

-(void)layoutSubviews{
	
 [super layoutSubviews];
	
  self.backgroundColor = [UIColor clearColor];
	
	CGFloat cellheigth =[self cellHeigth];
		
	if (isUserSelf) {
		
		[self.chatview setType:BUBBLE_TYPE_GREEN];
		
		chatview.frame = CGRectMake(LEFT, TOP, 260, cellheigth+20);
		
		imageButton.frame =CGRectMake(self.frame.size.width-LEFT-IMAGE_WIDTH, 48, IMAGE_WIDTH, IMAGE_HEIGTH);
		
	}else {
		
	    [self.chatview setType:BUBBLE_TYPE_GRAY];
		
		chatview.frame = CGRectMake(IMAGE_WIDTH+LEFT*3, TOP, 260, cellheigth+20);
		
		imageButton.frame =CGRectMake(LEFT, 48, IMAGE_WIDTH, IMAGE_HEIGTH);
	}
	
	self.chatview.backgroundColor = [UIColor clearColor];
	
	
}

- (void)dealloc {
	
	[chatview release];
	chatview =nil;
    [super dealloc];
}



@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    