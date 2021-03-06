//
//  ChatBubbleView.m
//  caibo
//
//  Created by jacob on 11-7-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChatBubbleView.h"

#import "ColorUtils.h"
#import "ProfileImageCell.h"


static UIImage* sGreenBubble = nil;
static UIImage* sGrayBubble = nil;

@interface ChatBubbleView(Private)
+ (UIImage*)greenBubble;
+ (UIImage*)grayBubble;
@end



@implementation ChatBubbleView

@synthesize message;

@synthesize time;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		self.message = @"";
		
		self.time = @"2011-07-05";
        // Initialization code.
    }
    return self;
}



// 传入 数据的 矩形大小 用来 绘制 界面
-(void)setTextBounds:(CGRect)textbounds{
	
	if (textbounds.size.height) {
		
		textBounds= textbounds;
		
	}else {
		textBounds = CGRectZero;
		
	}
	
}

-(CGFloat)cellHeigth{

	CGFloat cellheigth;
	
	if (textBounds.size.height>35) {
		
		cellheigth = textBounds.size.height+10;
		
	}else {
		
		cellheigth =32;
		
	}
	
	return cellheigth;
}


// 设置 图标样式
-(void)setType:(BubbleType)mtype{
	
	type =mtype;
	
	[self setNeedsDisplay];

}


-(void)setMessage:(NSString *)text{
	
	if(self.message !=text){
		
		[message release];
		
		message = [text retain];
	}
	
	[super setNeedsDisplay];


}


- (void)drawRect:(CGRect)rect {
	
	
	UIColor *timeColor = [UIColor userMailListTimeColor];
	 
    UIImage *bubble = nil;
	
	CGFloat cellheigth = [self cellHeigth];
	
	CGRect bubbleRect=CGRectMake(0, TEXT_HEIRTH, textBounds.size.width+40, cellheigth);
	
	if (type==BUBBLE_TYPE_GRAY) {
		
	  bubble = [ChatBubbleView grayBubble];
		
				
	}else if (type==BUBBLE_TYPE_GREEN) {
		
	  bubble = [ChatBubbleView greenBubble];
		
		
	  bubbleRect.origin.x =self.frame.size.width-bubbleRect.size.width;
		
		
	}
	
	[bubble drawInRect:bubbleRect];	
	
	
	if (type==BUBBLE_TYPE_GRAY) {
		bubbleRect.origin.x +=15;
		
	}else if (type==BUBBLE_TYPE_GREEN) {
		
		bubbleRect.origin.x +=10;
	}
	
	bubbleRect.origin.y += 5;
	bubbleRect.size.width-= 15;
	bubbleRect.size.height = cellheigth;
    
    if (type==BUBBLE_TYPE_GRAY) {
        
        [[UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1] set];
    }else if (type==BUBBLE_TYPE_GREEN) {
         [[UIColor whiteColor] set];
        
    }
	
	[message drawInRect:bubbleRect withFont:[UIFont systemFontOfSize:FONT_MIDDLE]];
	
	[timeColor set];
    if (type==BUBBLE_TYPE_GRAY) {
        
        [time drawInRect:CGRectMake(64, 0, 100, TEXT_HEIRTH) withFont:[UIFont systemFontOfSize:10]];
    }else if (type==BUBBLE_TYPE_GREEN) {
        [time drawInRect:CGRectMake(115, 0, 100, TEXT_HEIRTH) withFont:[UIFont systemFontOfSize:10]];
        
    }
	
	
	
	
}


+ (UIImage*)greenBubble
{
    if (sGreenBubble == nil) {
        UIImage *i = UIImageGetImageFromName(@"greenbubble.png");
        sGreenBubble = [[i stretchableImageWithLeftCapWidth:17 topCapHeight:23] retain];
    }
    return sGreenBubble;
}

+ (UIImage*)grayBubble
{
    if (sGrayBubble == nil) {
        UIImage *i = UIImageGetImageFromName(@"graybubble.png");
        sGrayBubble = [[i stretchableImageWithLeftCapWidth:17 topCapHeight:23] retain];
    }
    return sGrayBubble;
}



- (void)dealloc {
//    [super dealloc];
	[message release];
	[time release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    