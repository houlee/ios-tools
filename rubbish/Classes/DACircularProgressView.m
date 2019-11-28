//
//  DACircularProgressView.m
//  DACircularProgress
//
//  Created by Daniel Amitay on 2/6/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "DACircularProgressView.h"

#define DEGREES_2_RADIANS(x) (0.0174532925 * (x))

@implementation DACircularProgressView

@synthesize trackTintColor = _trackTintColor;
@synthesize progressTintColor =_progressTintColor;
@synthesize progress = _progress;
@synthesize imageviewd2;
@synthesize imageviewd;
@synthesize circularProgressType;

- (id)init
{
//    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
   
    
    [super drawRect:rect];
    CGPoint centerPoint = CGPointMake(rect.size.height / 2, rect.size.width / 2);
    CGFloat radius = MIN(rect.size.height, rect.size.width) / 2;
    
    CGFloat pathWidth = radius * 0.33f;
    NSLog(@"pathwidth = %f", pathWidth);
    
    CGFloat radians = DEGREES_2_RADIANS((self.progress*359.9)-90);
    CGFloat xOffset = radius*(1 + 0.90*cosf(radians));
    CGFloat yOffset = radius*(1 + 0.90*sinf(radians));
    CGPoint endPoint = CGPointMake(xOffset, yOffset);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor * ccc = [UIColor clearColor];
    if (circularProgressType == CircularProgressHorse) {
        ccc = [UIColor whiteColor];
    }
    [ccc setFill];
    CGMutablePathRef trackPath = CGPathCreateMutable();
    CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(270), DEGREES_2_RADIANS(-90), NO);
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(context, trackPath);
    CGContextFillPath(context);
    CGPathRelease(trackPath);
    
    
    
//    [self.progressTintColor setFill];
   
    float a = 0;
    if (self.progress <= 0.5 && self.progress > 0) {
       
        CGFloat radians2 = DEGREES_2_RADIANS((self.progress*359.9)-90);
        UIColor * cc = [UIColor colorWithPatternImage:[UIImage imageNamed:@"quanbeijing.png"]];
        if (circularProgressType == CircularProgressHorse) {
            cc = [UIColor clearColor];
        }
        [cc setFill];
        CGMutablePathRef progressPath = CGPathCreateMutable();
        CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
        CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(270), radians2, NO);
        CGPathCloseSubpath(progressPath);
        CGContextAddPath(context, progressPath);
        CGContextFillPath(context);
        CGPathRelease(progressPath);
    }else if(self.progress > 0.5){
        
        a = 0.5;
        CGFloat radians2 = DEGREES_2_RADIANS((a*359.9)-90);
        UIColor * cc = [UIColor colorWithPatternImage:[UIImage imageNamed:@"quanbeijing.png"]]; //先绘制一半
        if (circularProgressType == CircularProgressHorse) {
            cc = [UIColor clearColor];
        }
        [cc setFill];
        
//        // 创建颜色数组
//        NSMutableArray *colors = [NSMutableArray array];
//        for (NSInteger hue = 0; hue <= 360; hue +=10) {
//            // [colors addObject:(id)[UIColor colorWithRed:255.0/255.0*360/hue green:172.0/255.0 blue:0 alpha:1.0]];
//            [colors addObject:(id)[UIColor colorWithHue:1.0*hue/360.0 saturation:1.0 brightness:1.0 alpha:1.0].CGColor];
//            [[colors objectAtIndex:hue] setFill];
//        }
//        
//        // 1-->0.973   0.674-->0.286   0.015686627
        
        
        
        
        CGMutablePathRef progressPath = CGPathCreateMutable();
        CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
        CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(270), radians2, NO);
        CGPathCloseSubpath(progressPath);
        CGContextAddPath(context, progressPath);
        CGContextFillPath(context);
        CGPathRelease(progressPath);
        
//        a = self.progress - 0.5;
        CGFloat radians3 = DEGREES_2_RADIANS((self.progress*359.9)-90);
        UIColor * ccc = [UIColor colorWithPatternImage:[UIImage imageNamed:@"quanbeijing2.png"]];//绘制后一半
        if (circularProgressType == CircularProgressHorse) {
            ccc = [UIColor clearColor];
        }
        [ccc setFill];
        CGMutablePathRef progressPath2 = CGPathCreateMutable();
        CGPathMoveToPoint(progressPath2, NULL, centerPoint.x, centerPoint.y);
        CGPathAddArc(progressPath2, NULL, centerPoint.x, centerPoint.y, radius,DEGREES_2_RADIANS((0.4968*359.9)-90), radians3, NO);
        CGPathCloseSubpath(progressPath2);
        CGContextAddPath(context, progressPath2);
        CGContextFillPath(context);
        CGPathRelease(progressPath2);
        
    }
    
    
    
    
   
    

    
    [[UIColor blueColor] setFill];
    //第一个圆点
    
//    imageviewd = [[UIImageView alloc] initWithFrame:CGRectMake(centerPoint.x - pathWidth/2, 0, 7, 7)];
//    imageviewd.backgroundColor = [UIColor clearColor];
//    imageviewd.image = [UIImage imageNamed:@"quandian.png"];
//    [self addSubview:imageviewd];
//    [imageviewd release];
    
//    UIColor * ccc = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2222.png"]];
//    [ccc setFill];
//    CGContextAddEllipseInRect(context, CGRectMake(centerPoint.x - pathWidth/2, 0, pathWidth, pathWidth));
//    CGContextFillPath(context);
    if (circularProgressType != CircularProgressHorse) {
        UIImage *image = [UIImage imageNamed:@"quandian.png"];
        [image drawInRect:CGRectMake(centerPoint.x - pathWidth/2, 0, 5, 5)];
    }
    
    //第二个圆点
//    imageviewd2 = [[UIImageView alloc] initWithFrame:CGRectMake(endPoint.x - pathWidth/2, endPoint.y - pathWidth/2, 7, 7)];
//    imageviewd2.backgroundColor = [UIColor clearColor];
//    imageviewd2.image = [UIImage imageNamed:@"quandian.png"];
//    [self addSubview:imageviewd2];
//    [imageviewd2 release];
    if (circularProgressType != CircularProgressHorse) {
        UIImage *image2 = [UIImage imageNamed:@"quandian.png"];
        [image2 drawInRect:CGRectMake(endPoint.x - pathWidth/2+1, endPoint.y - pathWidth/4, 5, 5)];
    }
    
//    UIColor * cccc = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2222.png"]];
//    [cccc setFill];
//
//    CGContextAddEllipseInRect(context, CGRectMake(endPoint.x - pathWidth/2, endPoint.y - pathWidth/2, pathWidth, pathWidth));
//    CGContextFillPath(context);
    
    CGContextSetBlendMode(context, kCGBlendModeClear);;
    // ***
    CGFloat innerRadius = radius * 0.85;
    if (circularProgressType == CircularProgressHorse) {
        innerRadius = 0;
    }
	CGPoint newCenterPoint = CGPointMake(centerPoint.x - innerRadius, centerPoint.y - innerRadius);    
	CGContextAddEllipseInRect(context, CGRectMake(newCenterPoint.x, newCenterPoint.y, innerRadius*2, innerRadius*2));
	CGContextFillPath(context);
}

#pragma mark - Property Methods

- (UIColor *)trackTintColor
{
    if (!_trackTintColor)
    {
        _trackTintColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
        //_trackTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"quanhui.png"]];
    }
    return _trackTintColor;
}

- (UIColor *)progressTintColor
{
    if (!_progressTintColor)
    {
        _progressTintColor = [UIColor whiteColor];
    }
    return _progressTintColor;
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)dealloc{
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    