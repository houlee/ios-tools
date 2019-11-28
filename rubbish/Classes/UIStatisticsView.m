//
//  UIStatisticsView.m
//  caibo
//
//  Created by houchenguang on 14-4-23.
//
//

#import "UIStatisticsView.h"

@implementation UIStatisticsView
@synthesize dataArray, maxString, minString;

- (void)setInfoData:(ActivateInfoData *)_infoData{

    if (infoData != _infoData) {
        [infoData release];
        infoData = [_infoData retain];
    }
    
    NSMutableArray * allArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0;  i < [infoData.yieldRateArray count]; i++) {
        if ([[infoData.yieldRateArray objectAtIndex:i] rangeOfString:@"|"].location != NSNotFound) {
            NSArray * dateText = [[infoData.yieldRateArray objectAtIndex:i] componentsSeparatedByString:@"|"];
            if ([dateText count] >= 2) {
                
                [allArray addObject:[dateText objectAtIndex:1]];
            }
        
        }
    }
    self.dataArray = allArray;
    [allArray release];
    
    [self setNeedsDisplay];
    
}

- (ActivateInfoData *)infoData{
    return infoData;
}

- (void)dealloc{
    [maxString release];
    [minString release];
    [dataArray release];
    [infoData release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        self.minString = @"";
        self.maxString = @"";
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)textShow:(CGFloat)xy whith:(int)i{//绘制下面的日期

    if ([[infoData.yieldRateArray objectAtIndex:i] rangeOfString:@"|"].location != NSNotFound) {
        
        NSArray * dateText = [[infoData.yieldRateArray objectAtIndex:i] componentsSeparatedByString:@"|"];
        
        [[UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1] set];
        [[dateText objectAtIndex:0] drawInRect:CGRectMake(xy - 30,124,60,0) withFont:[UIFont systemFontOfSize:9] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
        
    }

}

- (void)poinArrayFunc:(NSMutableArray *)allPoinArray whithX:(CGFloat)xy poinString:(NSString *)poinString{

    if ([poinString floatValue] == [minString floatValue]) {
        [allPoinArray addObject:[NSString stringWithFormat:@"%f 90", xy]];
    }else if([poinString floatValue] == [maxString floatValue]){
        [allPoinArray addObject:[NSString stringWithFormat:@"%f 10", xy]];
    }else{
        CGFloat count = [maxString floatValue] - [minString floatValue];
        CGFloat hight = [poinString floatValue] - [minString floatValue];
        CGFloat bfb = hight/count;
        
        
        [allPoinArray addObject:[NSString stringWithFormat:@"%f %f", xy, 10+80 - 80.00*bfb]];
        
    }


}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    if ([infoData.yieldRateArray count] > 0) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextBeginPath(context);
        
        CGContextSetLineWidth(context, 1.0);   //下面的横线
        CGContextSetRGBStrokeColor(context, 230/255.0, 230/255.0, 230/255.0, 1.0);
        CGContextMoveToPoint(context, 0, 120);
        CGContextAddLineToPoint(context, 320, 120);
        CGContextStrokePath(context);
        
        
       
        
        for (int i = 0; i < [self.dataArray count]; i++) {
            if (i == 0) {
                self.minString = [self.dataArray objectAtIndex:i];
                self.maxString = [self.dataArray objectAtIndex:i];
            }else{
                if ([self.minString floatValue] > [[self.dataArray objectAtIndex:i] floatValue]) {
                    self.minString = [self.dataArray objectAtIndex:i];
                }
                if ([self.maxString floatValue] < [[self.dataArray objectAtIndex:i] floatValue]) {
                    self.maxString = [self.dataArray objectAtIndex:i];
                }
            }
           
            
            
        }
        
        NSMutableArray * poinArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (int i = 0; i < [infoData.yieldRateArray count]; i++) {
            
            CGContextSetLineWidth(context, 1.0);   //竖线
            CGContextSetRGBStrokeColor(context, 230/255.0, 230/255.0, 230/255.0, 1.0);
//            CGContextSetRGBStrokeColor(context, 255/255.0, 196/255.0, 38/255.0, 1.0);
            NSString * poinString = [self.dataArray objectAtIndex:i];
            
            
           
            
            if ([infoData.yieldRateArray count] > 2) {
                
                if (i == 0) {
                    
                    CGContextMoveToPoint(context, 24, 0);
                    CGContextAddLineToPoint(context, 24, 120);
                     CGContextStrokePath(context);
                    [self textShow:24 whith:i];
                    
                    [self poinArrayFunc:poinArray whithX:24 poinString:poinString];
                    
                }else if (i == [infoData.yieldRateArray count] - 1){
                
                    CGContextMoveToPoint(context, 272+24, 0);
                    CGContextAddLineToPoint(context, 272+24, 120);
                     CGContextStrokePath(context);
                    [self textShow:24+272 whith:i];
                    [self poinArrayFunc:poinArray whithX:24+272 poinString:poinString];
                }else{
                
                    CGFloat width = 272/([infoData.yieldRateArray count] - 1);
                    
                    CGContextMoveToPoint(context, 24+width*i, 0);
                    CGContextAddLineToPoint(context, 24+width*i, 120);
                     CGContextStrokePath(context);
                    [self textShow:24+width*i whith:i];
                    
                    [self poinArrayFunc:poinArray whithX:24+width*i poinString:poinString];
                }
                
               
            }else{
                CGFloat width = 272/([infoData.yieldRateArray count]+1);
                
                CGContextMoveToPoint(context, 24+width*(i+1), 0);
                CGContextAddLineToPoint(context, 24+width*(i+1), 120);
                 CGContextStrokePath(context);
                [self textShow:24+width*(i+1) whith:i];
                
                [self poinArrayFunc:poinArray whithX:24+width*(i+1) poinString:poinString];
            }
            
           
            
            
            
            
            
        }
        
        
        
        CGContextSetLineWidth(context, 2.0);//连接线
        CGContextSetRGBStrokeColor(context, 255/255.0, 196/255.0, 38/255.0, 1.0);
        
        for (int i = 0; i < [poinArray count]; i++) {
            
            NSString * poinstr = [poinArray objectAtIndex:i];
            NSArray * array = [poinstr componentsSeparatedByString:@" "];
            if ([array count] >= 2) {
                CGFloat hight =  [[array objectAtIndex:1] floatValue];
                
                if (i == 0) {
                    CGContextMoveToPoint(context, [[array objectAtIndex:0] floatValue], hight);
                }else{
                    CGContextAddLineToPoint(context, [[array objectAtIndex:0] floatValue], hight);
                }
            }
            
            
            
        }
        CGContextStrokePath(context);
       
        
        for (int i = 0; i < [poinArray count]; i++) { // 画圈
            NSString * poinstr = [poinArray objectAtIndex:i];
            NSArray * array = [poinstr componentsSeparatedByString:@" "];
            if ([array count] >= 2) {
                CGFloat hight =  [[array objectAtIndex:1] floatValue];
                UIImageView * quanImage = [[UIImageView alloc] initWithFrame:CGRectMake([[array objectAtIndex:0] floatValue] - 4, hight - 3.5, 8, 8)];
                quanImage.backgroundColor = [UIColor clearColor];
                if (i == [poinArray count]-1) {
                    quanImage.image = UIImageGetImageFromName(@"tongjiquan_1.png");
                    quanImage.frame = CGRectMake([[array objectAtIndex:0] floatValue] - 6, hight - 5.5, 12, 12);
                    
                }else{
                    quanImage.image = UIImageGetImageFromName(@"tongjiquan.png");
                    quanImage.frame = CGRectMake([[array objectAtIndex:0] floatValue] - 4, hight - 3.5, 8, 8);
                }
                [self addSubview:quanImage];
                [quanImage release];
                
                
                if (i == [poinArray count]-1) {
                    UIImageView * bigImage = [[UIImageView alloc] initWithFrame:CGRectMake([[array objectAtIndex:0] floatValue] - 4 - 41+ 10, hight - 3.5 - 22-2 , 41, 22)];
                    bigImage.image = UIImageGetImageFromName(@"tongjizuihou.png");
                    bigImage.backgroundColor = [UIColor clearColor];
                    [self addSubview:bigImage];
                    [bigImage release];
                    
                    UILabel * zzcLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 41, 18)];
                    zzcLabel.textColor = [UIColor whiteColor];
                    zzcLabel.textAlignment = NSTextAlignmentCenter;
                    zzcLabel.font = [UIFont boldSystemFontOfSize:12];
                    zzcLabel.backgroundColor = [UIColor clearColor];
                    zzcLabel.text = [self.dataArray lastObject];
                    [bigImage addSubview:zzcLabel];
                    [zzcLabel release];
                }
               
            }
    
        }
        
         [poinArray release];
        
    }
    
    
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    