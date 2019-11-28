//
//  ChatView.m
//  caibo
//
//  Created by Yinrongbin on 11-12-30.
//  Copyright (c) 2011年 vodone. All rights reserved.
//

#import "ColorView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSStringExtra.h"

#define kWidth 18
#define kHeight 18
#define kStartPoint 1

#define kMar 2

#define kYMar 2

@implementation ColorView
@synthesize emojis = _emojis;
@synthesize text = _text;
@synthesize font = _font;
@synthesize textColor = _textColor;
@synthesize changeColor = _changeColor;
@synthesize colorfont =_colorfont;
@synthesize pianyiHeight = _pianyiHeight;
@synthesize jianjuHeight = _jianjuHeight;
@synthesize wordWith = _wordWith;
@synthesize textAlignment;
@synthesize huanString = _huanString;
@synthesize pianyiy, textSumWith;
@synthesize isN;

-(void)dealloc
{
    [_emojis release];
    [_text release];
	[_font release];
	[_textColor release];
	[_changeColor release];
	[_colorfont release];
    [_huanString release];
    [super dealloc];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        textAlignment = NSTextAlignmentLeft;
        _pianyiHeight = 0;
        _jianjuHeight = 0;
        _wordWith = 0;
        _huanString = nil;
        
    }
    return self;
}


// 要显示的内容标题传入数组中
-(void)parserSendText:(NSString *)text withAry:(NSMutableArray *)mary
{
    NSRange rangeLeft = [text rangeOfString:@"<"];
    NSRange rangeRight = [text rangeOfString:@">"];

	if (rangeLeft.location != NSNotFound&&rangeRight.location != NSNotFound)
	{
        NSString * temstr = [text stringByReplacingOccurrencesOfString:@">" withString:@"<"];
        NSArray * comarr = [temstr componentsSeparatedByString:@"<"];
        [mary addObjectsFromArray:comarr];
	}
	else {
		[mary addObject:text];
	}

    
}


// 传入显示的内容
-(void)setText:(NSString *)string
{    
    
    [string retain];
    [_text release];
    _text = nil;
    _text = string;
    
    if(self.emojis)
        self.emojis = nil;
	
	NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:100];
	[self parserSendText:string withAry:mutableArray];
    self.emojis = mutableArray;
    [mutableArray release];
    
    self.textSumWith = 0;
	
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
	if (!_font) {
		self.font = [UIFont systemFontOfSize:12.0f];
	}
    
    CGFloat x = kMar;
    CGFloat y = _jianjuHeight;

    if (_colorfont) {
        float big = [_colorfont pointSize] - [_font pointSize];
        if (big <0) {
            big = -big;
        }
        y = big;
    }
    
   
    
    
    
    if (_pianyiHeight) {
        y = _pianyiHeight;
    }
    CGSize size;
    
    
    // emojis是一个可变数组
    if (self.emojis) 
	{
        
        for (int i = 0; i < [self.emojis count]; i++) 
		{
            NSString *emoji = [self.emojis objectAtIndex:i];
            if (i % 2 != 0)
			{
                NSString * imageName = emoji;
                NSString * image = imageName;
                
                if (image) {
                    for (int i = 0; i < [emoji length]; i++) 
					{
                        NSString *tem = [emoji substringWithRange:NSMakeRange(i, kStartPoint)];
                        size = [tem sizeWithFont:_font constrainedToSize:CGSizeMake(self.frame.size.width, 2000)];
						if (_colorfont) {
							size = [tem sizeWithFont:_colorfont constrainedToSize:CGSizeMake(self.frame.size.width, 2000)];
						}
                        self.textSumWith += size.width;
                        
                        if (x >= self.frame.size.width-size.width)
						{
                            x = kMar;
                            y += size.height +_jianjuHeight;
						}
						if (self.changeColor) {
							[self.changeColor set];
						}
						else {
							[[UIColor redColor] set];
						}
                        if (_colorfont) {
                            float big = [_colorfont pointSize] - [_font pointSize];
                            if (_pianyiHeight) {
                                big = _pianyiHeight;
                            }
                            [tem drawInRect:CGRectMake(x , y -big + pianyiy, size.width, size.height) withFont:_colorfont lineBreakMode:UILineBreakModeWordWrap alignment:self.textAlignment];
						}
						else {
                            [tem drawInRect:CGRectMake(x, y, size.width, size.height) withFont:_font lineBreakMode:UILineBreakModeWordWrap alignment:self.textAlignment];
						}
                        
                        x += size.width;
					}
					
                    
                } 
                else {
                    for (int i = 0; i < [emoji length]; i++) 
					{
                        NSString *tem = [emoji substringWithRange:NSMakeRange(i, kStartPoint)];
                        size = [tem sizeWithFont:_font constrainedToSize:CGSizeMake(self.frame.size.width, 2000)];
                        self.textSumWith += size.width;
                        if ([_huanString isEqualToString:tem]) {
                            x = kMar;
                            y += size.height + _jianjuHeight;
                        }
                        else {
                            if (x >= self.frame.size.width-size.width)
                            {
                                x = kMar;
                                y += size.height + _jianjuHeight;
                            }
                            if (self.textColor) {
                                [self.textColor set];
                            }
                            else {
                                [[UIColor blackColor] set];
                            }
                            //  [tem drawInRect:CGRectMake(x, y, size.width, size.height) withFont:_font];
                            [tem drawInRect:CGRectMake(x, y, size.width, size.height) withFont:_font lineBreakMode:UILineBreakModeWordWrap alignment:self.textAlignment];
                            x += size.width;
                        }
					}
                    
                }
				
			}
            else
			{
                for (int i = 0; i < [emoji length]; i++) 
				{
                    NSString *tem = [emoji substringWithRange:NSMakeRange(i, kStartPoint)];
                    size = [tem sizeWithFont:_font constrainedToSize:CGSizeMake(self.frame.size.width, 2000)];
                    if (_wordWith) {
                        size.width = _wordWith;
                    }
                    self.textSumWith += size.width;
                    if ([_huanString isEqualToString:tem]) {
                        x = kMar;
                        y += size.height + _jianjuHeight;
                    }
                    else {
                        if (x >= self.frame.size.width-size.width)
                        {
                            x = kMar;
                            y += size.height + _jianjuHeight;
                        }
                        if (self.textColor) {
                            [self.textColor set];
                        }
                        else {
                            [[UIColor blackColor] set];
                        }
                        if (isN == YES) {
                            if ([tem isEqualToString:@"\n"]) {
                                x = 0;
                                if (_jianjuHeight == 0) {
                                    y += self.font.lineHeight;
                                }else{
                                    y += size.height + _jianjuHeight;
                                }
                            }
                        }
                        
                        [tem drawInRect:CGRectMake(x, y, size.width, size.height) withFont:_font lineBreakMode:UILineBreakModeWordWrap alignment:self.textAlignment];
                        x += size.width;
                    }
				}
                
			}
            
		}
        
        
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