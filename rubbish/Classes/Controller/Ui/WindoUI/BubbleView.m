//
//  BubbleView.m
//  caibo
//
//  Created by jeff.pluto on 11-8-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BubbleView.h"

@implementation BubbleView

@synthesize direction,contentView;

- (id) init {
    if ((self = [super init])) {
        kRadius = 5;
        kAngle  = 10;
        kSpace  = kAngle * 5.5;
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor clearColor];
        
        kRadius = 5;
        kAngle  = 10;
        kSpace  = kAngle * 5.5;
    }
	return self;
}

- (void) setSpace:(int)space {
    kSpace = space;
    [self setNeedsDisplay];
}

-(void)addContentView:(CGRect)frame {
    if (contentView) {
        [self addSubview:contentView];
    }
}

-(void)drawBubbleAsLeft:(CGContextRef)c rect:(CGRect)rect {
	CGFloat minX = CGRectGetMinX(rect) + kSpace, maxX = CGRectGetMaxX(rect);
	CGFloat minY = CGRectGetMinY(rect), midY = CGRectGetMidY(rect), maxY = CGRectGetMaxY(rect);
    
	CGContextMoveToPoint(c, minX, maxY);
	CGContextAddArcToPoint(c, maxX, maxY, maxX, minY, kRadius);
	CGContextAddArcToPoint(c, maxX, minY, minX, minY, kRadius);
	CGContextAddArcToPoint(c, minX, minY, minX, midY, kRadius);
	CGContextAddLineToPoint(c, minX, minY + 20 - kAngle);
	CGContextAddLineToPoint(c, minX - kAngle, minY + 20);
	CGContextAddLineToPoint(c, minX, minY + 20 + kAngle);
	CGContextAddArcToPoint(c, minX, maxY, maxX, maxY, kRadius);
}

-(void)drawBubbleAsRight:(CGContextRef)c rect:(CGRect)rect {
	CGFloat minX = CGRectGetMinX(rect), maxX = CGRectGetMaxX(rect) - kSpace;
	CGFloat minY = CGRectGetMinY(rect), midY = CGRectGetMidY(rect), maxY = CGRectGetMaxY(rect);
    
	CGContextMoveToPoint(c, minX, minY);
	CGContextAddArcToPoint(c, maxX, minY, maxX, midY, kRadius);
	CGContextAddLineToPoint(c, maxX, minY + 20 - kAngle);
	CGContextAddLineToPoint(c, maxX + kAngle, minY + 20);
	CGContextAddLineToPoint(c, maxX, minY + 20 + kAngle);
	CGContextAddArcToPoint(c, maxX, maxY, minX, maxY, kRadius);
	CGContextAddArcToPoint(c, minX, maxY, minX, minY, kRadius);
	CGContextAddArcToPoint(c, minX, minY, maxX, minY, kRadius);
}
- (void)drawRect:(CGRect)rect {
	CGFloat minx = CGRectGetMinX(rect);
	CGFloat miny = CGRectGetMinY(rect);
    
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(c, [UIColor colorWithRed:239 / 255.0 green:242 / 255.0 blue:247 / 255.0 alpha:1.0].CGColor);
	
	CGContextMoveToPoint(c, minx, miny);
	
	if (self.direction == 1) {
		[self drawBubbleAsLeft:c rect:rect];
	} else {
		[self drawBubbleAsRight:c rect:rect];
	}
    
	CGSize size = CGSizeMake (1,  1);
	if(self.direction == 1) {
		size = CGSizeMake(-1, -1);
	}
	CGContextSetShadowWithColor(c, size, 0.5, [UIColor grayColor].CGColor);
	
	CGContextFillPath(c);
	
	[self addContentView:rect];
}

- (void)dealloc {
	[contentView release];
    
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    