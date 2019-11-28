//
//  ChatView.m
//  caibo
//
//  Created by Yinrongbin on 11-12-30.
//  Copyright (c) 2011年 vodone. All rights reserved.
//

#import "ChatView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSStringExtra.h"

#define kWidth 18
#define kHeight 18
#define kStartPoint 1

#define kMar 2

#define kYMar 2

@implementation ChatView
@synthesize emojis = _emojis;
@synthesize textColor = _textColor;
@synthesize text = _text;
@synthesize changeColor = _changeColor;
@synthesize kaijbool;
-(void)dealloc
{
    [_emojis release];
    [_text release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)parserSendText:(NSString *)text withAry:(NSMutableArray *)mary
{
    if (!text) {
        return;
    }
    NSRange rangeLeft = [text rangeOfString:@"["];
    NSRange rangeRight = [text rangeOfString:@"]"];
    //  if([text hasPrefix:@"["]&&[text hasPrefix:@"]"]) //判断是否为一个完整的表情
	if (rangeLeft.location != NSNotFound&&rangeRight.location != NSNotFound) 
	{
        if (rangeLeft.location > 0) // 说明文字在先           
		{
            NSString *temStr = [text substringToIndex:rangeLeft.location]; //截取文本
			
            NSLog(@"文字 %@",temStr);
            [mary addObject:temStr];//添加文本
            text = [text substringFromIndex:rangeLeft.location];
            [self parserSendText:text withAry:mary];
			//temStr = [text substringFromIndex:rangeLeft.location];
//            if (rangeLeft.location > rangeRight.location) {
//                temStr = [text substringFromIndex:rangeLeft.location -1];
////                rangeLeft = [temStr rangeOfString:@"["];
////                rangeRight = [temStr rangeOfString:@"]"];
////                temStr = [temStr substringWithRange:NSMakeRange(rangeLeft.location, (rangeRight.location - rangeLeft.location +1))];// 截取表情
//                text = [text substringFromIndex:rangeLeft.location];
//            }
//            else {
//                temStr = [text substringWithRange:NSMakeRange(rangeLeft.location, (rangeRight.location - rangeLeft.location +1))];// 截取表情
//            }
//            
//            if ([temStr length]>1) {
//                NSRange left2 = [[temStr substringFromIndex:1] rangeOfString:@"["];
//                if (left2.location == NSNotFound) {
//                    NSLog(@"表情 %@",temStr);
//                    [mary addObject:temStr]; //添加表情
//                    NSString *newString = [text substringFromIndex:rangeLeft.location + (rangeRight.location - rangeLeft.location +1 )];  // 获得新的字符串
//                    NSLog(@"newString %@",newString);
//                    [self parserSendText:newString withAry:mary];
//                }
//                else {
//                    [self parserSendText:temStr withAry:mary];
//                }
//            }
//            else {
//                [mary addObject:temStr];
//            }
            
		}
        else
		{
            NSString *temStr = [text substringWithRange:NSMakeRange(rangeLeft.location, (rangeRight.location - rangeLeft.location +1))]; // 截取表情
			if ([temStr length]>2) {
				NSRange left2 = [[temStr substringFromIndex:1] rangeOfString:@"["];
				if (left2.location !=NSNotFound) {
					//NSString *temStr = [text substringToIndex:left2.location];
					[mary addObject:@"["];
					temStr = [text substringFromIndex:1];
					[self parserSendText:temStr withAry:mary];
				}
				else if (![temStr isEqualToString:@""])
				{
					//NSLog(@"temStr ------>%@",temStr);
					[mary addObject:temStr];
					temStr = [text substringFromIndex:rangeLeft.location + (rangeRight.location - rangeLeft.location +1)]; // 获得新的字符串
					//NSLog(@"newString ---->>>%@",temStr);
					[self parserSendText:temStr withAry:mary];
				}
				else
				{
					return;
				}
			}
			else {
                [mary addObject:temStr];

				temStr = [text substringFromIndex:rangeRight.location+1]; // 获得新的字符串
				[self parserSendText:temStr withAry:mary];
				return;
			}

			
		}
        
	}
    else //  在字符串中，没发现有表情符号
	{
        if (![text isEqualToString:@""])
            [mary addObject:text];
	}
    
}

-(void)setText:(NSString *)string
{    
    /*
     if (_text == string)
     {
     return;
     }
     else
     {
     _text = nil;
     _text = string;
     }
     */
    
    [_text release];
    _text = nil;
    _text = [string retain];
    
    
    if(self.emojis)
        self.emojis = nil;
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:100];
    [self parserSendText:string withAry:mutableArray];
    self.emojis = mutableArray;
    [mutableArray release];
    
    
     // Drawing code
//     UIFont *emojiFont = [UIFont systemFontOfSize:14.0f];
//     UIFont *font = [UIFont systemFontOfSize:14.0f];
//     
//     CGFloat x = kMar;
//     CGFloat y = 0;
//     CGSize size;
//     if (self.emojis) 
//     {
//     for (int i = 0; i < [self.emojis count]; i++) 
//     {
//     NSString *emoji = [self.emojis objectAtIndex:i];
//     if ([emoji hasPrefix:@"["] && [emoji hasSuffix:@"]"])
//     {
//     NSString *imageName = [emoji substringWithRange:NSMakeRange(kStartPoint, emoji.length - 2)]; // 截取图片名字
//     size = [imageName sizeWithFont:emojiFont constrainedToSize:CGSizeMake(self.frame.size.width, 2000)];
//     //NSLog(@"size.width %f",size.width);
//     if (x >= self.frame.size.width-size.height)
//     {
//     x = kMar;
//     y += size.height + 2;
//     }
//     
//     x += kWidth;
//     }
//     else
//     {
//     for (int i = 0; i < [emoji length]; i++) 
//     {
//     NSString *tem = [emoji substringWithRange:NSMakeRange(i, kStartPoint)];
//     size = [tem sizeWithFont:font constrainedToSize:CGSizeMake(self.frame.size.width, 2000)];
//     if (x >= self.frame.size.width-size.width)
//     {
//     x = kMar;
//     y += size.height + 2;
//     }
//     
//     x += size.width;
//     }
//     
//     }
//     
//     }
//     
//     //y += size.height;
//     
//     }
//     
//     NSLog(@"------->>>> y %f ",y);
//     CGRect rect = self.frame;
//     rect.size.height = y;
//     self.frame = rect;
     
     [self setNeedsDisplay];
     
}

-(NSString *)text
{
    return _text;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // font 14 每个表情的宽为24
    // font 12 每个表情的宽为21
    // font 11 没个表情的宽为19
    // font 10 每个表情的宽为 17
    
    // Drawing code
    //UIFont *emojiFont = [UIFont systemFontOfSize:11.0f];
    if (kaijbool) {
        [[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1] set];
    }
    else if (_textColor) {
        [_textColor set];
    }
    UIFont *emojiFont = [UIFont systemFontOfSize:14.0f];
    UIFont *font = [UIFont systemFontOfSize:14.0f];
    
    CGFloat x = kMar;
    CGFloat y = 0;
    CGSize size;
    if (self.emojis) 
    {
        
        for (int i = 0; i < [self.emojis count]; i++) 
        {
            
            NSString *emoji = [self.emojis objectAtIndex:i];
            if ([emoji hasPrefix:@"["] && [emoji hasSuffix:@"]"]&&[emoji length]>2)
            {
                NSString *imageName = [emoji substringWithRange:NSMakeRange(kStartPoint, emoji.length - 2)]; // 截取图片名字
            NSLog(@"imageName = %@", imageName);
            
                //NSLog(@" yyyyyyy %f",y);
                //                imageName = [imageName stringToFace];
				imageName = [imageName stringToFace];
            
            
            if ([imageName hasPrefix:@"蓝 "]) {
                imageName = [imageName stringByReplacingOccurrencesOfString:@"蓝 " withString:@""];
                
                if ([imageName isAllNumber]) {
                    
                        strstring = imageName;
                    
                    
               
               
                    imageName = @"cpthree_blueB.png";
                }else{
                    imageName = nil;
                }
                
            }else if ([imageName hasPrefix:@"F"]){
                NSLog(@"ima = %@", imageName);
                imageName = [NSString stringWithFormat:@"%@.png",[imageName uppercaseString]];
                
                }else if([imageName hasPrefix:@"胆 "]){
                    
                    imageName = [imageName stringByReplacingOccurrencesOfString:@"胆 " withString:@""];
                    
                    if ([imageName isAllNumber]) {
                        strstring = imageName;
                        imageName = @"cpthree_puzBall.png";//等待图片胆
                    }else{
                        imageName = @"";
                    }
                    
                    
                    
                }else if([imageName hasPrefix:@"飞盘 "]){
                
                    imageName = [imageName stringByReplacingOccurrencesOfString:@"飞盘 " withString:@""];
                    
                    if ([imageName isAllNumber]) {
                        strstring = imageName;
                    
                    
                    imageName = @"cpthree_yelBall.png";//等待图片飞盘
                    }else{
                        imageName = @"";
                    }
                }
                else if ([imageName hasPrefix:@"@"]||[imageName hasPrefix:@"#"]) {
                    for (int i = 1; i < [emoji length] -1; i++)
                    {
                        if (_changeColor) {
                            [_changeColor set];
                        }
                        NSString *tem = [emoji substringWithRange:NSMakeRange(i, kStartPoint)];
                        size = [tem sizeWithFont:font constrainedToSize:CGSizeMake(self.frame.size.width, 2000)];
                        //NSLog(@"----------->>>>> size.width %f size.height %f",size.width,size.height);
                        if (x >= self.frame.size.width-size.width)
                        {
                            x = kMar;
                            y += size.height;
                        }
                        
                        [tem drawInRect:CGRectMake(x, y, size.width, size.height) withFont:font];
                        
                        x += size.width;
                        //NSLog(@"x %f y %f",x,y);
                    }
                    //imageName = @"";
                    continue;
                }
                else {
                NSLog(@"str = %@", imageName);
                    if ([imageName isAllNumber]) {
                        strstring = imageName;
                    
                
                
                        imageName = @"cpthree_redB.png";
                    }else{
                        imageName = @"";
                    }
            }
//                if ([imageName intValue] <100) {
//                    
//                    if ([imageName length] > 0) {
//                        strstring = imageName;
//                        NSLog(@"str = %@", strstring);
//                        imageName = @"ball_red.png";
//                    }            
//                    
//
//            }
            UIImage *image;
            if ([imageName length] == 0||imageName == nil) {
                image = nil;
            }else{
                image = UIImageGetImageFromName(imageName);
            }
                
            NSLog(@"image = %@", imageName);
            
            NSLog(@"name = %@ , image = %@", strstring, imageName);
                if (image) {
                    size = [imageName sizeWithFont:emojiFont constrainedToSize:CGSizeMake(self.frame.size.width, 1999)];
                    
                    NSLog(@"size.width %f size.height %f",size.width,size.height);
                    NSLog(@"x = %f, self.size = %f", x, self.frame.size.width);
                    if (x >= self.frame.size.width-size.height)
                    {
                        x = kMar;
                        y += size.height;
                    }
                    
                    
                    
                    [image drawInRect:CGRectMake(x, y, kWidth, kHeight)];
                    if (strstring != nil) {
                        NSLog(@"strstr  = %@", strstring);
                        [strstring drawInRect:CGRectMake(x, y, kWidth, kHeight) withFont:[UIFont systemFontOfSize:12] lineBreakMode:UILineBreakModeWordWrap alignment:NSTextAlignmentCenter];
                    }
                    
                    strstring = nil;
                    
                        
                    
                    
                    x += kWidth;
                    
                } 
                else {
                    if (kaijbool) {
                        [[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1] set];
                    }
                    else if (_textColor) {
                        //如果是带链接的评论
                        if([self.emojis count] >=2 && [emoji hasPrefix:@"[http://caipiao365.com"])
                            [[UIColor colorWithRed:16/255.0 green:124/255.0 blue:163/255.0 alpha:1] set];
                        else
                        [_textColor set];
                    }
                    for (int i = 0; i < [emoji length]; i++) 
                    {
                        NSString *tem = [emoji substringWithRange:NSMakeRange(i, kStartPoint)];
                        size = [tem sizeWithFont:font constrainedToSize:CGSizeMake(self.frame.size.width, 2000)];
                        //NSLog(@"----------->>>>> size.width %f size.height %f",size.width,size.height);
                        if (x >= self.frame.size.width-size.width)
                        {
                            x = kMar;
                            y += size.height;
                        }
                        
                        [tem drawInRect:CGRectMake(x, y, size.width, size.height) withFont:font];
                        
                        x += size.width;
                        //NSLog(@"x %f y %f",x,y);
                    }
                    
                }
				
            }
            else
            {
                if (kaijbool) {
                    [[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1] set];
                }
                else if (_textColor) {

                    [_textColor set];
                }
                for (int i = 0; i < [emoji length]; i++)
                {
                    NSString *tem = [emoji substringWithRange:NSMakeRange(i, kStartPoint)];
                    size = [tem sizeWithFont:font constrainedToSize:CGSizeMake(self.frame.size.width, 2000)];
                    //NSLog(@"----------->>>>> size.width %f size.height %f",size.width,size.height);
                    if (x >= self.frame.size.width-size.width)
                    {
                        x = kMar;
                        y += size.height;
                    }
                    
                    [tem drawInRect:CGRectMake(x, y, size.width, size.height) withFont:font];
                    
                    x += size.width;
                    //NSLog(@"x %f y %f",x,y);
                }
                
            }
        }
        
        //NSLog(@"------->>>> y %f",y += 20);
        
    }
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    