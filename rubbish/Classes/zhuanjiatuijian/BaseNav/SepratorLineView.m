//
//  SepratorLineView.m
//
//  Created by v1pin on 15/5/25.
//  Copyright (c) 2015年 v1. All rights reserved.
//

#import "SepratorLineView.h"

@implementation SepratorLineView

- (void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, self.bounds.size.width, 0);
    CGContextSetLineWidth(ctx, 0.5);
    CGContextStrokePath(ctx);
    
    [self setBackgroundColor:SEPARATORCOLOR];
}

@end


@implementation ChartFormView

- (void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx,0,0,0,0.1);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, 290, 0);
    CGContextAddLineToPoint(ctx, 290, 30);
    CGContextAddLineToPoint(ctx, 0, 30);
    CGContextAddLineToPoint(ctx, 0, 0);
    CGContextMoveToPoint(ctx, 290/3, 0.5);
    CGContextAddLineToPoint(ctx, 290/3, 29.5);
    CGContextMoveToPoint(ctx, 580/3, 0.5);
    CGContextAddLineToPoint(ctx, 580/3, 29.5);
    
    CGContextSetLineWidth(ctx, 0.5);
    CGContextStrokePath(ctx);
    //[SEPARATORCOLOR setStroke];
    [self setBackgroundColor:[UIColor clearColor]];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    