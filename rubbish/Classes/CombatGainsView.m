//
//  CombatGainsView.m
//  caibo
//
//  Created by houchenguang on 14-5-22.
//
//

#import "CombatGainsView.h"

@implementation CombatGainsView
@synthesize homeOrguest;

- (NSDictionary *)analyzeDictionary{
    return analyzeDictionary;
}

- (void)setAnalyzeDictionary:(NSDictionary *)_analyzeDictionary{

    if (analyzeDictionary != _analyzeDictionary) {
        [analyzeDictionary release];
        analyzeDictionary = [_analyzeDictionary retain];
    }
    
    [self setNeedsDisplay];
    

    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc{
    [super dealloc];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    if (homeOrguest > 0) {
        //获得处理的上下文
        CGContextRef context = UIGraphicsGetCurrentContext();
        //设置线条样式
        CGContextSetLineCap(context, kCGLineCapSquare);
        //设置线条粗细宽度
        CGContextSetLineWidth(context, 0.5);
        
        //设置颜色
        CGContextSetRGBStrokeColor(context, 214/255.0, 215/255.0, 215/255.0, 1.0);
        //开始一个起始路径
        CGContextBeginPath(context);
        
        
        CGFloat width = self.frame.size.width / 21.0;
        CGFloat hight = (self.frame.size.height - 14) / 4.0;
        
        for (int i = 0; i < 20; i++) {
            
            
            
            //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
            CGContextMoveToPoint(context, width *(i+1), 0); //////  画竖线
            //设置下一个坐标点
            CGContextAddLineToPoint(context, width *(i+1), self.frame.size.height - 14);
            //连接上面定义的坐标点
            CGContextStrokePath(context);
            
            if (i < 4) {      ///////////////////////////////////// 画横线
                //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
                CGContextMoveToPoint(context, 0, hight *(i+1));
                //设置下一个坐标点
                CGContextAddLineToPoint(context,  self.frame.size.width, hight *(i+1));
                //连接上面定义的坐标点
                CGContextStrokePath(context);
            }
            
            

        }
       
        CGContextSetLineWidth(context, 1);
        CGContextMoveToPoint(context, 0, 0); //////  画竖线//画第一条长竖线线
        CGContextAddLineToPoint(context, 0, self.frame.size.height );
        CGContextStrokePath(context);
        
        CGContextMoveToPoint(context, 0, self.frame.size.height );//画最下面的长横线线
        CGContextAddLineToPoint(context,  self.frame.size.width, self.frame.size.height );
        CGContextStrokePath(context);
        
        
        if (analyzeDictionary &&[analyzeDictionary count] > 0) {
            NSArray * homeArray = nil;
            if (homeOrguest == 1) {
                homeArray = [analyzeDictionary objectForKey:@"hostLeaguePlay"];
            }else{
                homeArray = [analyzeDictionary objectForKey:@"guestLeaguePlay"];
            }
            
            if (homeArray && [homeArray count] > 0) {
                
                if (homeOrguest == 1) {
                    CGContextSetRGBStrokeColor(context, 6/255.0, 96/255.0, 211/255.0, 1);
                }else{
                    CGContextSetRGBStrokeColor(context, 249/255.0, 135/255.0, 14/255.0, 1);
                    
                }
                CGContextSetLineCap(context, kCGLineCapRound);//设置线的样式
                //设置线条粗细宽度
                CGContextSetLineWidth(context, 1);

                
                
                // 3.渲染显示到view上面  
//                CGContextStrokePath(context);
                
                for (int i = 0; i < [homeArray count]; i++) {//标记彩果
                    
                    float x = width * 20;
                    float y = hight;
                    
                    NSDictionary * resultDict = [homeArray objectAtIndex:i];
                    NSString * result = [resultDict objectForKey:@"result"];
                    if ([result isEqualToString:@"胜"]) {
                        y = hight*1;
                    }else if ([result isEqualToString:@"平"]){
                        y = hight*2;
                    }else if ([result isEqualToString:@"负"]){
                         y = hight*3;
                    }
                    
                    if (i == 0) {
                        
                        NSString * isHost = [resultDict objectForKey:@"isHost"];
                        
                        if ([isHost intValue] == 1) {
                            if (homeOrguest == 1) {
                                
                                [UIImageGetImageFromName(@"shangdayuan.png") drawInRect:CGRectMake(x-(width*i)- 6, y - 6, 12, 12)];
                                
                                
                            }else{
                                [UIImageGetImageFromName(@"xiadayuan.png") drawInRect:CGRectMake(x-(width*i)- 6, y - 6, 12, 12)];
                            }
                        }else{
                            if (homeOrguest == 1) {
                                
                                [UIImageGetImageFromName(@"shangdayuanfang.png") drawInRect:CGRectMake(x-(width*i)- 6, y - 6, 12, 12)];
                                
                                
                            }else{
                                [UIImageGetImageFromName(@"xiadayuanfang.png") drawInRect:CGRectMake(x-(width*i)- 6, y - 6, 12, 12)];
                            }
                            
                        }
                        
                       
                        
                        
                        CGContextMoveToPoint(context, x-(width*i), y);
                        
                    }else{
                        
                        NSString * isHost = [resultDict objectForKey:@"isHost"];
                        
                        if ([isHost intValue] == 1) {
                            if (homeOrguest == 1) {
                                [UIImageGetImageFromName(@"shangxiaoyuan.png") drawInRect:CGRectMake(x-(width*i) - 4, y - 4, 8, 8)];
                            }else{
                                [UIImageGetImageFromName(@"xiaxiaoyuan.png") drawInRect:CGRectMake(x-(width*i) - 4, y - 4, 8, 8)];
                            }
                        }else{
                        
                            if (homeOrguest == 1) {
                                [UIImageGetImageFromName(@"shangxiaoyuanfang.png") drawInRect:CGRectMake(x-(width*i) - 4, y - 4, 8, 8)];
                            }else{
                                [UIImageGetImageFromName(@"xiaxiaoyuanfang.png") drawInRect:CGRectMake(x-(width*i) - 4, y - 4, 8, 8)];
                            }
                        }
                        
                        

                         CGContextAddLineToPoint(context, x-(width*i), y);
                    }
                    
                }
                
                
                
                CGContextStrokePath(context);
                
                
                for (int i = 0; i < [homeArray count]; i++) {///标记多少场次
                    NSDictionary * resultDict = [homeArray objectAtIndex:i];
                    NSString * bottom = [resultDict objectForKey:@"bottom"];
                    float x = width * 20;
                    [bottom drawInRect:CGRectMake(x-(width*i) - 10,61,20,14) withFont:[UIFont systemFontOfSize:9] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];//重绘和值
                }
                
                
            }
            
        }
    }
   
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    