//
//  ChatBubbleView.h
//  caibo
//
//  Created by jacob on 11-7-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BUBBLE_TYPE_GRAY,
    BUBBLE_TYPE_GREEN,
} BubbleType;

@interface ChatBubbleView : UIView {
	
	NSString *message;
	
	NSString *time;
	
	BubbleType type;
	
	CGRect textBounds;

}

@property(nonatomic,retain)NSString *message;

@property(nonatomic,retain)NSString *time;

-(void)setTextBounds:(CGRect)textbounds;

-(void)setType:(BubbleType)mtype;

-(CGFloat)cellHeigth;



@end
