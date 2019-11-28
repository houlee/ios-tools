//
//  GCBallView.m
//  caibo
//
//  Created by yao on 12-5-16.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "GCBallView.h"
#import "caiboAppDelegate.h"
#import "SharedMethod.h"

#define ORIGIN_X(view) (view.frame.origin.x + view.frame.size.width)
#define ORIGIN_Y(view) (view.frame.origin.y + view.frame.size.height)

#define KUAISAN_FONT [UIFont fontWithName:@"TRENDS" size:21]
#define KUAISAN_FONT_WITH(Size) [UIFont fontWithName:@"TRENDS" size:Size]

#define NUMBER_LABEL_X 1.5
#define NUMBER_LABEL_Y 2.5

#define NUMBER_LABEL_Y_TONGHAO 3.5

#define YILOU_LABEL_Y_TONGHAO 3

@implementation GCBallView

@synthesize numLabel,ylLable;
@synthesize gcballDelegate;
@synthesize isBlack;
@synthesize numLabel2;
@synthesize nomorFrame;
@synthesize numLabel3;
@synthesize maxYiLouTag;
//@synthesize huaImageView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        isXQBall = NO;
        isChongfu = NO;
        // Initialization code.
        isBlack = NO;
		numLabel = [[UILabel alloc] initWithFrame:self.bounds];
		numLabel.backgroundColor =[UIColor clearColor];
		numLabel.center = CGPointMake(numLabel.center.x-0.5, numLabel.center.y-1);
		numLabel.userInteractionEnabled = NO;
		numLabel.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
		numLabel.font = [UIFont systemFontOfSize:16];
		[self addSubview:numLabel];
        numLabel.textAlignment = NSTextAlignmentCenter;
        ylLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 8)];
		ylLable.backgroundColor =[UIColor clearColor];
		ylLable.center = CGPointMake(frame.size.width/2, frame.size.height+9);
		ylLable.userInteractionEnabled = NO;
        ylLable.textAlignment = NSTextAlignmentCenter;
//		ylLable.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        ylLable.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
		ylLable.font = [UIFont systemFontOfSize:10];
        ylLable.tag = 999;
		[self addSubview:ylLable];
		self.userInteractionEnabled = YES;
		
    }
    return self;
}

- (void) changeTo:(GCBallViewColorType)newcolorType {
    if (colorType != GCBallViewColorRed && colorType != GCBallViewColorBlue) {
        return;
    }
    colorType = newcolorType;
    isXQBall = YES;
    switch (colorType) {
        case GCBallViewColorRed:
        {
            isRed = YES;
            //--------------------------------------------bianpinghua by sichuanlin
            //				[self setBackgroundImage:UIImageGetImageFromName(@"TZQ960.png") forState:UIControlStateNormal];
            //				[self setBackgroundImage:UIImageGetImageFromName(@"TZQH960.png") forState:UIControlStateSelected];
            [self setBackgroundImage:UIImageGetImageFromName(@"kaijianghuiqiu.png") forState:UIControlStateNormal];
            [self setBackgroundImage:UIImageGetImageFromName(@"faxqhongqiu.png") forState:UIControlStateSelected];
            
            //                numLabel.textColor = [UIColor colorWithRed:213/255.0 green:0/255.0 blue:0/255.0 alpha:1];
            numLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            
        }
            break;
        case GCBallViewColorBlue:
        {
            isRed =NO;
            //				[self setBackgroundImage:UIImageGetImageFromName(@"TZQ960.png") forState:UIControlStateNormal];
            //				[self setBackgroundImage:UIImageGetImageFromName(@"TZQL960.png") forState:UIControlStateSelected];
            [self setBackgroundImage:UIImageGetImageFromName(@"kaijianghuiqiu.png") forState:UIControlStateNormal];
            [self setBackgroundImage:UIImageGetImageFromName(@"faxqlanqiu.png") forState:UIControlStateSelected];
            
            //                numLabel.textColor = [UIColor colorWithRed:0/255.0 green:105/255.0 blue:213/255.0 alpha:1];
            numLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            
        }
            break;
        default: {
            break;
        }
    }
    
}

- (id)initWithFrame:(CGRect)frame Num:(NSString *)num ColorType:(GCBallViewColorType)ColorType {
	self = [self initWithFrame:frame];
	if (self) {
		numLabel.text = num;
        colorType = ColorType;
		switch (ColorType) {
			case GCBallViewColorRed:
			{
				isRed = YES;
//--------------------------------------------bianpinghua by sichuanlin
//				[self setBackgroundImage:UIImageGetImageFromName(@"TZQ960.png") forState:UIControlStateNormal];
//				[self setBackgroundImage:UIImageGetImageFromName(@"TZQH960.png") forState:UIControlStateSelected];
                [self setBackgroundImage:UIImageGetImageFromName(@"shuzibai.png") forState:UIControlStateNormal];
                [self setBackgroundImage:UIImageGetImageFromName(@"shuzihong.png") forState:UIControlStateSelected];
                
//                numLabel.textColor = [UIColor colorWithRed:213/255.0 green:0/255.0 blue:0/255.0 alpha:1];
                numLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];

			}
				break;
			case GCBallViewColorBlue:
			{
				isRed =NO;
//				[self setBackgroundImage:UIImageGetImageFromName(@"TZQ960.png") forState:UIControlStateNormal];
//				[self setBackgroundImage:UIImageGetImageFromName(@"TZQL960.png") forState:UIControlStateSelected];
                [self setBackgroundImage:UIImageGetImageFromName(@"shuzibai.png") forState:UIControlStateNormal];
                [self setBackgroundImage:UIImageGetImageFromName(@"shuzilan.png") forState:UIControlStateSelected];
                
//                numLabel.textColor = [UIColor colorWithRed:0/255.0 green:105/255.0 blue:213/255.0 alpha:1];
                numLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];

			}
				break;
            case GCBallViewColorBig:{
                numLabel.font = [UIFont systemFontOfSize:18];
//                [self setBackgroundImage:UIImageGetImageFromName(@"TZQ960.png") forState:UIControlStateNormal];
//				[self setBackgroundImage:UIImageGetImageFromName(@"TZQH960.png") forState:UIControlStateSelected];
                [self setBackgroundImage:UIImageGetImageFromName(@"shuzibai.png") forState:UIControlStateNormal];
                [self setBackgroundImage:UIImageGetImageFromName(@"shuzihong.png") forState:UIControlStateSelected];
                
                break;
            }
            case GCBallViewColorKuaiSan:{
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateSelected];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateHighlighted];
                self.adjustsImageWhenHighlighted = NO;
                
                numLabel.frame = CGRectMake(NUMBER_LABEL_X, NUMBER_LABEL_Y, self.bounds.size.width, self.bounds.size.height/2);
                numLabel.font = KUAISAN_FONT_WITH(14);
                numLabel.backgroundColor = [UIColor clearColor];
                numLabel.textColor = [UIColor whiteColor];
                
                ylLable.frame = CGRectMake(0, self.bounds.size.height/2 + 3, self.bounds.size.width, self.bounds.size.height/2 - 6);
                ylLable.backgroundColor = [UIColor clearColor];
//                ylLable.font = [UIFont systemFontOfSize:11];
                ylLable.textColor = [UIColor colorWithRed:235/255.0 green:255/255.0 blue:224/255.0 alpha:1];
            }
                break;
            case GCBallViewColorKuaiSan2:{
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateSelected];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateHighlighted];
                self.adjustsImageWhenHighlighted = NO;
                
                numLabel.frame = CGRectMake(NUMBER_LABEL_X, NUMBER_LABEL_Y, self.bounds.size.width, self.bounds.size.height/2);
                numLabel.font = KUAISAN_FONT_WITH(14);
                numLabel.backgroundColor = [UIColor clearColor];
                numLabel.textColor = [UIColor whiteColor];
                
                ylLable.frame = CGRectMake(0, self.bounds.size.height/2 + 3, self.bounds.size.width, self.bounds.size.height/2 - 6);
                ylLable.backgroundColor = [UIColor clearColor];
                ylLable.textColor = [UIColor colorWithRed:235/255.0 green:255/255.0 blue:224/255.0 alpha:1];

                
            }
                break;
                
            case GCBallViewColorKuaiSanErTong:{
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateSelected];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateHighlighted];
                self.adjustsImageWhenHighlighted = NO;
                
                numLabel.frame = CGRectMake(NUMBER_LABEL_X, NUMBER_LABEL_Y_TONGHAO, self.bounds.size.width, self.bounds.size.height/2);
                numLabel.font = KUAISAN_FONT;
                numLabel.backgroundColor = [UIColor clearColor];
                numLabel.textColor = [UIColor whiteColor];
                
                ylLable.frame = CGRectMake(0, ORIGIN_Y(numLabel) + YILOU_LABEL_Y_TONGHAO, self.bounds.size.width, self.bounds.size.height/2 - 6);
                ylLable.backgroundColor = [UIColor clearColor];
//                ylLable.font = [UIFont systemFontOfSize:11];
                ylLable.textColor = [UIColor colorWithRed:235/255.0 green:255/255.0 blue:224/255.0 alpha:1];
                
//                numLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height /3.0, self.bounds.size.width, self.bounds.size.height/3.0)];
//                numLabel2.backgroundColor =[UIColor clearColor];
//                numLabel2.userInteractionEnabled = NO;
//                numLabel2.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
//                numLabel2.font = [UIFont systemFontOfSize:16];
//                [self addSubview:numLabel2];
//                numLabel2.text = numLabel.text;
//                numLabel2.textAlignment = NSTextAlignmentCenter;
//                
//                numLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height * 2/3.0 -1, self.bounds.size.width, self.bounds.size.height/3.0)];
//                numLabel3.backgroundColor =[UIColor clearColor];
//                numLabel3.userInteractionEnabled = NO;
//                numLabel3.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
//                numLabel3.font = [UIFont systemFontOfSize:16];
//                [self addSubview:numLabel3];
//                numLabel3.text = @"*";
//                numLabel3.textAlignment = NSTextAlignmentCenter;
//                numLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height / 3.0);
//                [self setBackgroundImage:UIImageGetImageFromName(@"kuaisanball5.png") forState:UIControlStateNormal];
//				[self setBackgroundImage:UIImageGetImageFromName(@"kuaisanball6.png") forState:UIControlStateSelected];
            }
                break;
            case GCBallViewColorKuaiSanSanTong:{
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateSelected];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateHighlighted];
                self.adjustsImageWhenHighlighted = NO;
                
                numLabel.frame = CGRectMake(NUMBER_LABEL_X, NUMBER_LABEL_Y_TONGHAO, self.bounds.size.width, self.bounds.size.height/2);
                numLabel.font = KUAISAN_FONT;
                numLabel.backgroundColor = [UIColor clearColor];
                numLabel.textColor = [UIColor whiteColor];
                
                ylLable.frame = CGRectMake(0, ORIGIN_Y(numLabel) + YILOU_LABEL_Y_TONGHAO, self.bounds.size.width, self.bounds.size.height/2 - 6);
                ylLable.backgroundColor = [UIColor clearColor];
//                ylLable.font = [UIFont systemFontOfSize:11];
                ylLable.textColor = [UIColor colorWithRed:235/255.0 green:255/255.0 blue:224/255.0 alpha:1];
                
                
//                numLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height /3.0 - 1, self.bounds.size.width, self.bounds.size.height/3.0)];
//                numLabel2.backgroundColor =[UIColor clearColor];
//                numLabel2.userInteractionEnabled = NO;
//                numLabel2.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
//                numLabel2.font = [UIFont systemFontOfSize:16];
//                [self addSubview:numLabel2];
//                numLabel2.text = numLabel.text;
//                numLabel2.textAlignment = NSTextAlignmentCenter;
//                
//                numLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height * 2/3.0 - 3, self.bounds.size.width, self.bounds.size.height/3.0)];
//                numLabel3.backgroundColor =[UIColor clearColor];
//                numLabel3.userInteractionEnabled = NO;
//                numLabel3.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
//                numLabel3.font = [UIFont systemFontOfSize:16];
//                [self addSubview:numLabel3];
//                numLabel3.text = numLabel.text;
//                numLabel3.textAlignment = NSTextAlignmentCenter;
//                numLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height / 3.0);
//                [self setBackgroundImage:UIImageGetImageFromName(@"kuaisanball5.png") forState:UIControlStateNormal];
//				[self setBackgroundImage:UIImageGetImageFromName(@"kuaisanball6.png") forState:UIControlStateSelected];
            }
                break;
            case GCBallViewColorKuaiSanSanTongTong:{
                self.adjustsImageWhenHighlighted = NO;
                
                UILabel *Label = [[UILabel alloc] initWithFrame:CGRectMake(6, 15, 55, 22)];
                Label.backgroundColor =[UIColor clearColor];
                Label.font = KUAISAN_FONT;
                [self addSubview:Label];
                Label.text = [SharedMethod changeFontWithString:@"111"];
                Label.textAlignment = NSTextAlignmentCenter;
                [Label release];
                
                UILabel *Label2 = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(Label) + 8, Label.frame.origin.y, Label.frame.size.width, Label.frame.size.height)];
                Label2.backgroundColor =[UIColor clearColor];
                Label2.font = KUAISAN_FONT;
                [self addSubview:Label2];
                Label2.text = [SharedMethod changeFontWithString:@"222"];
                Label2.textAlignment = NSTextAlignmentCenter;
                [Label2 release];
                
                UILabel *Label3 = [[UILabel alloc] initWithFrame:CGRectMake(Label.frame.origin.x, ORIGIN_Y(Label) + 18, Label.frame.size.width, Label.frame.size.height)];
                Label3.backgroundColor =[UIColor clearColor];
                Label3.font = KUAISAN_FONT;
                [self addSubview:Label3];
                Label3.text = [SharedMethod changeFontWithString:@"333"];
                Label3.textAlignment = NSTextAlignmentCenter;
                [Label3 release];
                
                UILabel *Label4 = [[UILabel alloc] initWithFrame:CGRectMake(Label2.frame.origin.x, ORIGIN_Y(Label2) + 18, Label.frame.size.width, Label.frame.size.height)];
                Label4.backgroundColor =[UIColor clearColor];
                Label4.font = KUAISAN_FONT;
                [self addSubview:Label4];
                Label4.text = [SharedMethod changeFontWithString:@"444"];
                Label4.textAlignment = NSTextAlignmentCenter;
                [Label4 release];
                
                UILabel *Label5 = [[UILabel alloc] initWithFrame:CGRectMake(Label3.frame.origin.x, ORIGIN_Y(Label3) + 18, Label.frame.size.width, Label.frame.size.height)];
                Label5.backgroundColor =[UIColor clearColor];
                Label5.font = KUAISAN_FONT;
                [self addSubview:Label5];
                Label5.text = [SharedMethod changeFontWithString:@"555"];
                Label5.textAlignment = NSTextAlignmentCenter;
                [Label5 release];
                
                UILabel *Label6 = [[UILabel alloc] initWithFrame:CGRectMake(Label4.frame.origin.x, ORIGIN_Y(Label4) + 18, Label.frame.size.width, Label.frame.size.height)];
                Label6.backgroundColor =[UIColor clearColor];
                Label6.font = KUAISAN_FONT;
                [self addSubview:Label6];
                Label6.text = [SharedMethod changeFontWithString:@"666"];
                Label6.textAlignment = NSTextAlignmentCenter;
                [Label6 release];

                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateSelected];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateHighlighted];
                
                ylLable.frame = CGRectMake(self.frame.size.width/2, self.frame.size.height - 23, self.frame.size.width/2, 20);
                ylLable.textAlignment = 0;
                
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                    numLabel.frame = CGRectMake(ylLable.frame.origin.x - 18, ylLable.frame.origin.y , 18, ylLable.frame.size.height);
                }else{
                    numLabel.frame = CGRectMake(ylLable.frame.origin.x - 18, ylLable.frame.origin.y + 0.5, 18, ylLable.frame.size.height);
                }
            }
                break;
            case GCBallViewColorKuaiSanSanLian:{
                self.adjustsImageWhenHighlighted = NO;

//                numLabel.text = @"123";
//                numLabel.font = KUAISAN_FONT;
//                numLabel.frame = CGRectMake(18.5, 15, 30, 20);
                
                UILabel *Label = [[UILabel alloc] initWithFrame:CGRectMake(6, 15, 55, 22)];
                Label.backgroundColor =[UIColor clearColor];
                Label.font = KUAISAN_FONT;
                [self addSubview:Label];
                Label.text = [SharedMethod changeFontWithString:@"123"];
                Label.textAlignment = NSTextAlignmentCenter;
                [Label release];
                
                UILabel *Label2 = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(Label) + 8, Label.frame.origin.y, Label.frame.size.width, Label.frame.size.height)];
                Label2.backgroundColor =[UIColor clearColor];
                Label2.font = KUAISAN_FONT;
                [self addSubview:Label2];
                Label2.text = [SharedMethod changeFontWithString:@"234"];
                Label2.textAlignment = NSTextAlignmentCenter;
                [Label2 release];
                
                UILabel *Label3 = [[UILabel alloc] initWithFrame:CGRectMake(Label.frame.origin.x, ORIGIN_Y(Label) + 18, Label.frame.size.width, Label.frame.size.height)];
                Label3.backgroundColor =[UIColor clearColor];
                Label3.font = KUAISAN_FONT;
                [self addSubview:Label3];
                Label3.text = [SharedMethod changeFontWithString:@"345"];
                Label3.textAlignment = NSTextAlignmentCenter;
                [Label3 release];
                
                UILabel *Label4 = [[UILabel alloc] initWithFrame:CGRectMake(Label2.frame.origin.x, ORIGIN_Y(Label2) + 18, Label.frame.size.width, Label.frame.size.height)];
                Label4.backgroundColor =[UIColor clearColor];
                Label4.font = KUAISAN_FONT;
                [self addSubview:Label4];
                Label4.text = [SharedMethod changeFontWithString:@"456"];
                Label4.textAlignment = NSTextAlignmentCenter;
                [Label4 release];

                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateSelected];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateHighlighted];
                
                ylLable.frame = CGRectMake(self.frame.size.width/2, self.frame.size.height - 23, self.frame.size.width/2, 20);
                ylLable.textAlignment = 0;
                
                numLabel.frame = CGRectMake(ylLable.frame.origin.x - 18, ylLable.frame.origin.y + 1, 18, ylLable.frame.size.height);
            }
                break;
            case GCBallViewColorKuaiSanHezhi:
                {
                    numLabel.textColor = [UIColor whiteColor];
                    numLabel.font = KUAISAN_FONT_WITH(17);
                    numLabel.frame = CGRectMake(NUMBER_LABEL_X, 0, self.bounds.size.width, self.bounds.size.height / 2.0 - 7);
                    
                    numLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(numLabel), 98, 12)];
                    numLabel2.backgroundColor =[UIColor clearColor];
                    numLabel2.userInteractionEnabled = NO;
                    numLabel2.font = [UIFont systemFontOfSize:11];
                    numLabel2.textColor = [UIColor colorWithRed:116/255.0 green:216/255.0 blue:194/255.0 alpha:1];
                    [self addSubview:numLabel2];
                    numLabel2.textAlignment = NSTextAlignmentCenter;
                    self.backgroundColor = [UIColor clearColor];
                    
                    ylLable.textColor = [UIColor whiteColor];
                    ylLable.frame = CGRectMake(0, ORIGIN_Y(numLabel2) + 2.5, 98, 17);
                    
                    [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                    [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateSelected];
                    [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateHighlighted];
                    self.adjustsImageWhenHighlighted = NO;

                }
                break;
            case GCBallViewColorKuaiSanWanFa:
            {
                numLabel.textColor = [UIColor whiteColor];
                numLabel.font = [UIFont systemFontOfSize:17];
                numLabel.frame = CGRectMake(NUMBER_LABEL_X, 0, self.bounds.size.width, self.bounds.size.height / 2.0 - 7);
                
                numLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(numLabel), 98, 12)];
                numLabel2.backgroundColor =[UIColor clearColor];
                numLabel2.userInteractionEnabled = NO;
                numLabel2.font = [UIFont systemFontOfSize:11];
                numLabel2.textColor = [UIColor colorWithRed:116/255.0 green:216/255.0 blue:194/255.0 alpha:1];
                [self addSubview:numLabel2];
                numLabel2.textAlignment = NSTextAlignmentCenter;
                self.backgroundColor = [UIColor clearColor];
                
                ylLable.textColor = [UIColor whiteColor];
                ylLable.frame = CGRectMake(0, ORIGIN_Y(numLabel2) + 2.5, 98, 17);
                
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateSelected];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateHighlighted];
                self.adjustsImageWhenHighlighted = NO;
                
            }
                break;
            case GCBallViewColorKuaiSanHezhiDX:
            {
                numLabel.textColor = [UIColor whiteColor];
                numLabel.font = [UIFont systemFontOfSize:17];
                numLabel.frame = CGRectMake(7, 8.5, 25, 20);
                
                numLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(22, 10.5, 48, 20)];
                numLabel2.backgroundColor =[UIColor clearColor];
                numLabel2.userInteractionEnabled = NO;
                numLabel2.font = [UIFont systemFontOfSize:13];
                numLabel2.textColor = [UIColor whiteColor];
                [self addSubview:numLabel2];
                numLabel2.textAlignment = NSTextAlignmentCenter;
                self.backgroundColor = [UIColor clearColor];
                
//                self.layer.masksToBounds = YES;
//                self.layer.cornerRadius = 2;
                
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateSelected];
                [self setBackgroundImage:[UIImageGetImageFromName(@"kuaisanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateHighlighted];
                self.adjustsImageWhenHighlighted = NO;
                
            }
                break;

            case GCBallViewColorTuiJian:
                {
                    numLabel.font = [UIFont systemFontOfSize:15];
                    [self setBackgroundImage:[UIImageGetImageFromName(@"dikuang6.png") stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
                    [self setBackgroundImage:[UIImageGetImageFromName(@"dikuang7.png") stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateSelected];
                    [self setBackgroundImage:[UIImageGetImageFromName(@"dikuang6.png") stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateDisabled];
                    
                    ylLable.frame = CGRectMake(0, self.frame.size.height + 8, self.frame.size.width, 17);
                }
                break;
            case GCBallViewKuaiLePukePutong:
            {
                numLabel.font = [UIFont fontWithName:@"TRENDS" size:13];
//                numLabel.textColor = [UIColor colorWithRed:78/255.0 green:118/255.0 blue:127/255.0 alpha:1.0];
                numLabel.textColor = [UIColor blackColor];
                self.nomorFrame = frame;
                if ([numLabel.text isEqualToString:@"包"]) {
                    [self setBackgroundImage:UIImageGetImageFromName(@"pukeputongbaoxuan_1.png") forState:UIControlStateSelected];
                    [self setBackgroundImage:UIImageGetImageFromName(@"pukeputongbaoxuan.png") forState:UIControlStateNormal];
//                    numLabel.text = nil;
                }
                else {
                    [self setBackgroundImage:UIImageGetImageFromName(@"pukeSelect.png") forState:UIControlStateSelected];
                    [self setBackgroundImage:UIImageGetImageFromName(@"pukeNomor.png") forState:UIControlStateNormal];
                }
                ylLable.frame = CGRectMake(0, 60, 37.5, 10);
            }
                break;
            case GCBallViewKuaiLePuKeTonghua:
                {
                    numLabel.textColor = [UIColor colorWithRed:78/255.0 green:118/255.0 blue:127/255.0 alpha:1.0];
                numLabel.font = [UIFont fontWithName:@"TRENDS" size:13];
                self.nomorFrame = frame;
                if ([numLabel.text isEqualToString:@"包"]) {
                    [self setBackgroundImage:UIImageGetImageFromName(@"pukebaoxuan_1.png") forState:UIControlStateSelected];
                    [self setBackgroundImage:UIImageGetImageFromName(@"pukebaoxuan.png") forState:UIControlStateNormal];
                }
                else if ([numLabel.text isEqualToString:@"hei"]) {
                    [self setBackgroundImage:UIImageGetImageFromName(@"pukeheidan_1.png") forState:UIControlStateSelected];
                    [self setBackgroundImage:UIImageGetImageFromName(@"pukeheidan.png") forState:UIControlStateNormal];
                }
                else if ([numLabel.text isEqualToString:@"hong"]) {
                    [self setBackgroundImage:UIImageGetImageFromName(@"pukehongdan_1.png") forState:UIControlStateSelected];
                    [self setBackgroundImage:UIImageGetImageFromName(@"pukehongdan.png") forState:UIControlStateNormal];
                }
                else if ([numLabel.text isEqualToString:@"hua"]) {
                    [self setBackgroundImage:UIImageGetImageFromName(@"pukehuadan_1.png") forState:UIControlStateSelected];
                    [self setBackgroundImage:UIImageGetImageFromName(@"pukehuadan.png") forState:UIControlStateNormal];
                }
                else if ([numLabel.text isEqualToString:@"pian"]) {
                    [self setBackgroundImage:UIImageGetImageFromName(@"pukepiandan_1.png") forState:UIControlStateSelected];
                    [self setBackgroundImage:UIImageGetImageFromName(@"pukepiandan.png") forState:UIControlStateNormal];
                }
                numLabel.text = nil;
                ylLable.frame = CGRectMake(0, 102, 75, 10);
            }
                break;
            case GCBallViewYuShe:
            {
                numLabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
                numLabel.font = [UIFont systemFontOfSize:15];
                numLabel.frame = CGRectMake(0, 5, self.bounds.size.width, self.bounds.size.height / 2.0 - 7);
                
                ylLable.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
                ylLable.frame = CGRectMake(0, ORIGIN_Y(numLabel) + 2, self.frame.size.width, 17);
                
                [self setBackgroundImage:[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                [self setBackgroundImage:[UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateHighlighted];

                self.adjustsImageWhenHighlighted = NO;
                
            }
                break;
            case GCBallViewHappyTenQuan:
            {
                numLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
                numLabel.font = [UIFont fontWithName:@"TRENDS" size:17];
                numLabel.frame = CGRectMake(0, 5, self.bounds.size.width/2, self.bounds.size.height/2 - 1);
                numLabel.textAlignment = 2;
                
                numLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(numLabel), numLabel.frame.origin.y, self.bounds.size.width/2, numLabel.frame.size.height)];
                numLabel3.text = [SharedMethod changeFontWithString:@"个"];
                numLabel3.backgroundColor =[UIColor clearColor];
                numLabel3.userInteractionEnabled = NO;
                numLabel3.font = [UIFont fontWithName:@"TRENDS" size:15];
                numLabel3.textColor = numLabel.textColor;
                numLabel3.textAlignment = 0;
                [self addSubview:numLabel3];
                
                numLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(numLabel) + 3, self.frame.size.width, 12)];
                numLabel2.backgroundColor =[UIColor clearColor];
                numLabel2.userInteractionEnabled = NO;
                numLabel2.font = [UIFont systemFontOfSize:11];
                numLabel2.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1];
                [self addSubview:numLabel2];
                numLabel2.textAlignment = NSTextAlignmentCenter;
                
                ylLable.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1];
                ylLable.frame = CGRectMake(0, self.frame.size.height + 7, self.frame.size.width, 17);
                
                [self setBackgroundImage:[UIImageGetImageFromName(@"HappyTenQuanButton.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
                [self setBackgroundImage:[UIImageGetImageFromName(@"HappyTenQuanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateSelected];
                [self setBackgroundImage:[UIImageGetImageFromName(@"HappyTenQuanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateHighlighted];
                
                self.adjustsImageWhenHighlighted = NO;
                
            }
                break;
            case GCBallViewHorseRace:
            {
                
                [self setBackgroundImage:UIImageGetImageFromName(@"HorseBetButton.png") forState:UIControlStateNormal];
                [self setBackgroundImage:UIImageGetImageFromName(@"HorseBetButton_1.png") forState:UIControlStateSelected];
                
                numLabel.backgroundColor = [UIColor clearColor];
                numLabel.frame = CGRectMake(frame.size.width - 55, frame.size.height - 34, 50, 25);
                numLabel.font = [UIFont systemFontOfSize:28];
                numLabel.textColor = [SharedMethod getColorByHexString:@"5da335"];
                
                ylLable.frame = CGRectMake(0, frame.size.height - 24, frame.size.width, 20);
                ylLable.layer.masksToBounds = YES;
                
                ColorView * yiLouColorView = [[[ColorView alloc] initWithFrame:CGRectMake(6, 0, ylLable.frame.size.width - 22, ylLable.frame.size.height)] autorelease];
                yiLouColorView.textColor = [SharedMethod getColorByHexString:@"5da335"];
                yiLouColorView.changeColor = [SharedMethod getColorByHexString:@"5da335"];
                yiLouColorView.font = [UIFont systemFontOfSize:9];
                yiLouColorView.colorfont = [UIFont systemFontOfSize:12];
                yiLouColorView.backgroundColor = [UIColor clearColor];
                yiLouColorView.tag = 100000;
                yiLouColorView.pianyiy = 1;
                [ylLable addSubview:yiLouColorView];
                
                ColorView * yiLouColorView1 = [[[ColorView alloc] initWithFrame:CGRectMake(6, ORIGIN_Y(yiLouColorView), ylLable.frame.size.width - 22, ylLable.frame.size.height)] autorelease];
                yiLouColorView1.textColor = [SharedMethod getColorByHexString:@"5da335"];
                yiLouColorView1.changeColor = [SharedMethod getColorByHexString:@"5da335"];
                yiLouColorView1.font = [UIFont systemFontOfSize:9];
                yiLouColorView1.colorfont = [UIFont systemFontOfSize:12];
                yiLouColorView1.backgroundColor = [UIColor clearColor];
                yiLouColorView1.tag = 200000;
                yiLouColorView1.pianyiy = 1;
                [ylLable addSubview:yiLouColorView1];
                
                ColorView * yiLouColorView2 = [[[ColorView alloc] initWithFrame:CGRectMake(6, ORIGIN_Y(yiLouColorView1), ylLable.frame.size.width - 22, ylLable.frame.size.height)] autorelease];
                yiLouColorView2.textColor = [SharedMethod getColorByHexString:@"5da335"];
                yiLouColorView2.changeColor = [SharedMethod getColorByHexString:@"5da335"];
                yiLouColorView2.font = [UIFont systemFontOfSize:9];
                yiLouColorView2.colorfont = [UIFont systemFontOfSize:12];
                yiLouColorView2.backgroundColor = [UIColor clearColor];
                yiLouColorView2.tag = 300000;
                yiLouColorView2.pianyiy = 1;
                [ylLable addSubview:yiLouColorView2];

            }
                break;
			default:
				break;
		}
		[self addTarget:self action:@selector(TouchUpInside) forControlEvents:UIControlEventTouchUpInside];
		[self addTarget:self action:@selector(TouchDown) forControlEvents:UIControlEventTouchDown];
		[self addTarget:self action:@selector(TouchCancel) forControlEvents:UIControlEventTouchCancel];
		[self addTarget:self action:@selector(TouchDragExit) forControlEvents:UIControlEventTouchDragExit];
	}
	return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)setIsBlack:(BOOL)_isBlack {
    isBlack = _isBlack;
    if (_isBlack) {
        if (!self.selected) {
            numLabel.textColor = [UIColor blackColor];
            numLabel2.textColor = numLabel.textColor;
            numLabel3.textColor = numLabel.textColor;
        }
    }
}

- (void)changetolight {
    
    if (colorType == GCBallViewColorRed || colorType == GCBallViewColorBlue) {
        isChongfu = YES;
        [self setBackgroundImage:UIImageGetImageFromName(@"kaijianghuiqiu.png") forState:UIControlStateNormal];
    }
    
}

- (void)chanetoNomore {
    if (colorType == GCBallViewColorRed || colorType == GCBallViewColorBlue) {
    isChongfu = NO;
    [self setBackgroundImage:UIImageGetImageFromName(@"shuzibai.png") forState:UIControlStateNormal];
    }
    
}

- (void)setSelected:(BOOL)select {
	[super setSelected:select];
    if (isXQBall) {
        numLabel.textColor = [UIColor whiteColor];
        return;
    }
	if (self.selected) {
        if (colorType >= GCBallViewColorKuaiSan && colorType <= GCBallViewColorKuaiSanHezhi) {
            if (numLabel.bounds.size.width >= self.bounds.size.width) {
                numLabel.textColor = [UIColor yellowColor];
//                numLabel2.textColor  = [UIColor yellowColor];
            }
        }
        else if (colorType == GCBallViewKuaiLePukePutong) {
            self.frame = CGRectMake(self.nomorFrame.origin.x, self.nomorFrame.origin.y - 6, self.nomorFrame.size.width, self.nomorFrame.size.height);
            ylLable.frame = CGRectMake(ylLable.frame.origin.x, self.bounds.size.height + 14, ylLable.bounds.size.width, ylLable.bounds.size.height);
        }else if (colorType == GCBallViewKuaiLePuKeTonghua) {
            self.frame = CGRectMake(self.nomorFrame.origin.x, self.nomorFrame.origin.y - 6, self.nomorFrame.size.width, self.nomorFrame.size.height);
            ylLable.frame = CGRectMake(ylLable.frame.origin.x, self.bounds.size.height + 9, ylLable.bounds.size.width, ylLable.bounds.size.height);
        }
        else if (colorType == GCBallViewYuShe) {
            numLabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
            ylLable.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
        }
        else if (colorType == GCBallViewColorKuaiSanWanFa) {
            numLabel.textColor = [UIColor yellowColor];
            numLabel2.textColor = [UIColor yellowColor];
        }
        else if (colorType == GCBallViewHorseRace) {
            [self setBackgroundImage:UIImageGetImageFromName(@"HorseBetButton_1.png") forState:UIControlStateNormal];

            [self HorseSelected];
        }
        else {
            numLabel.textColor = [UIColor whiteColor];
            numLabel2.textColor = numLabel.textColor;
            numLabel3.textColor = numLabel.textColor;
        }
		
		//numLabel.font = [UIFont boldSystemFontOfSize:16];
	}
	else {
        if (isBlack) {
            numLabel.textColor = [UIColor blackColor];
            numLabel2.textColor = numLabel.textColor;
            numLabel3.textColor = numLabel.textColor;
        }
        else if (colorType == GCBallViewColorRed) {
//            numLabel.textColor = [UIColor colorWithRed:213/255.0 green:0/255.0 blue:0/255.0 alpha:1];
            numLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];

        }
        else if (colorType == GCBallViewColorBlue) {
//            numLabel.textColor = [UIColor colorWithRed:0/255.0 green:105/255.0 blue:213/255.0 alpha:1];
            numLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];

        }
        else if (colorType == GCBallViewColorKuaiSan) {
            numLabel.textColor = [UIColor whiteColor];
        }
        else if (colorType == GCBallViewColorKuaiSan2) {
            numLabel.textColor = [UIColor whiteColor];
            numLabel2.textColor = numLabel.textColor;
        }
        else if (colorType == GCBallViewColorKuaiSanErTong) {
            numLabel.textColor = [UIColor whiteColor];
            numLabel2.textColor = numLabel.textColor;
            numLabel3.textColor = numLabel.textColor;
        }
        else if (colorType == GCBallViewColorKuaiSanSanTong) {
            numLabel.textColor = [UIColor whiteColor];
            numLabel2.textColor = numLabel.textColor;
            numLabel3.textColor = numLabel.textColor;
        }
        else if (colorType == GCBallViewColorKuaiSanHezhi) {
            numLabel.textColor = [UIColor whiteColor];
//            numLabel2.textColor = [UIColor colorWithRed:116/255.0 green:216/255.0 blue:194/255.0 alpha:1];
        }
        else if (colorType == GCBallViewColorKuaiSanWanFa) {
            numLabel.textColor = [UIColor whiteColor];
            numLabel2.textColor = [UIColor colorWithRed:116/255.0 green:216/255.0 blue:194/255.0 alpha:1];
        }
        else if (colorType == GCBallViewColorKuaiSanHezhiDX) {
            numLabel.textColor = [UIColor whiteColor];
            numLabel2.textColor = [UIColor whiteColor];
        }
        else if (colorType == GCBallViewColorKuaiSanSanTongTong) {
//            numLabel.textColor = [UIColor whiteColor];
            for (UILabel * label in self.subviews) {
                if ([label isKindOfClass:[UILabel class]] && label.tag != 999) {
                    label.textColor = [UIColor whiteColor];
                }
            }
        }else if (colorType == GCBallViewColorKuaiSanSanLian) {
            for (UILabel * label in self.subviews) {
                if ([label isKindOfClass:[UILabel class]] && label.tag != 999) {
                    label.textColor = [UIColor whiteColor];
                }
            }
        }
        else if (colorType == GCBallViewKuaiLePukePutong) {
            self.frame = self.nomorFrame;
            ylLable.frame = CGRectMake(ylLable.frame.origin.x, self.bounds.size.height + 8, ylLable.bounds.size.width, ylLable.bounds.size.height);
        }else if (colorType == GCBallViewKuaiLePuKeTonghua) {
            self.frame = self.nomorFrame;
            ylLable.frame = CGRectMake(ylLable.frame.origin.x, self.bounds.size.height + 3, ylLable.bounds.size.width, ylLable.bounds.size.height);
        }
        else if (colorType == GCBallViewYuShe) {
            numLabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
            ylLable.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
        }
        else if (colorType == GCBallViewHappyTenQuan) {
            numLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
            numLabel3.textColor = numLabel.textColor;
            numLabel2.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1];
            [self setBackgroundImage:[UIImageGetImageFromName(@"HappyTenQuanButton.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
        }
        else if (colorType == GCBallViewHorseRace) {
            [self setBackgroundImage:UIImageGetImageFromName(@"HorseBetButton.png") forState:UIControlStateNormal];
            
            [self HorseNormal];
        }
        else {
                numLabel.textColor = [UIColor colorWithRed:213/255.0 green:0/255.0 blue:0/255.0 alpha:1];
            }
		
		//numLabel.font = [UIFont systemFontOfSize:16];
	}
}

-(void)HorseNormal
{
    numLabel.textColor = [SharedMethod getColorByHexString:@"5da335"];
    
    ColorView * yiLouColorView = (ColorView *)[ylLable viewWithTag:100000];
    ColorView * yiLouColorView1 = (ColorView *)[ylLable viewWithTag:200000];
    ColorView * yiLouColorView2 = (ColorView *)[ylLable viewWithTag:300000];
    
    yiLouColorView.textColor = [SharedMethod getColorByHexString:@"5da335"];
    yiLouColorView1.textColor = [SharedMethod getColorByHexString:@"5da335"];
    yiLouColorView2.textColor = [SharedMethod getColorByHexString:@"5da335"];
    
    yiLouColorView.changeColor = [SharedMethod getColorByHexString:@"5da335"];
    yiLouColorView1.changeColor = [SharedMethod getColorByHexString:@"5da335"];
    yiLouColorView2.changeColor = [SharedMethod getColorByHexString:@"5da335"];
    
    yiLouColorView.text = yiLouColorView.text;
    yiLouColorView1.text = yiLouColorView1.text;
    yiLouColorView2.text = yiLouColorView2.text;

    if (maxYiLouTag) {
        NSArray * maxTagArr = [maxYiLouTag componentsSeparatedByString:@";"];
        for (int i = 0; i < maxTagArr.count; i++) {
            ColorView * maxYiLouColorView = (ColorView *)[ylLable viewWithTag:[[maxTagArr objectAtIndex:i] intValue]];
            maxYiLouColorView.changeColor = [SharedMethod getColorByHexString:@"ffb129"];
            maxYiLouColorView.textColor = [SharedMethod getColorByHexString:@"ffb129"];
        }
    }
}

-(void)HorseSelected
{
    numLabel.textColor = [SharedMethod getColorByHexString:@"f2ff60"];
    
    ColorView * yiLouColorView = (ColorView *)[ylLable viewWithTag:100000];
    ColorView * yiLouColorView1 = (ColorView *)[ylLable viewWithTag:200000];
    ColorView * yiLouColorView2 = (ColorView *)[ylLable viewWithTag:300000];
    
    yiLouColorView.textColor = [SharedMethod getColorByHexString:@"dcefb7"];
    yiLouColorView1.textColor = [SharedMethod getColorByHexString:@"dcefb7"];
    yiLouColorView2.textColor = [SharedMethod getColorByHexString:@"dcefb7"];
    
    yiLouColorView.changeColor = [SharedMethod getColorByHexString:@"dcefb7"];
    yiLouColorView1.changeColor = [SharedMethod getColorByHexString:@"dcefb7"];
    yiLouColorView2.changeColor = [SharedMethod getColorByHexString:@"dcefb7"];
    
    yiLouColorView.text = yiLouColorView.text;
    yiLouColorView1.text = yiLouColorView1.text;
    yiLouColorView2.text = yiLouColorView2.text;
}


- (void)TouchDragExit {
	self.selected = NO;
	bigImageVIew.hidden = YES;
}

- (void)TouchCancel {
	self.selected = NO;
	bigImageVIew.hidden = YES;
    if (colorType == GCBallViewHorseRace) {
        if ([gcballDelegate respondsToSelector:@selector(ballSelectChange:)]) {
            
            [gcballDelegate ballSelectChange:self];
        }
    }
}

- (void)TouchDown {
//    if (colorType == GCBallViewColorBig || colorType >= GCBallViewColorKuaiSan2) {
//        return;
//    }
    if (isChongfu) {
        return;
    }
    if (self.selected == NO) {
        if (colorType == GCBallViewColorKuaiSanSanTongTong || colorType == GCBallViewColorKuaiSanSanLian) {
            for (UILabel * label in self.subviews) {
                if ([label isKindOfClass:[UILabel class]] && label.tag != 999) {
                    label.textColor = [UIColor yellowColor];
                }
            }
        }
        else if (colorType == GCBallViewYuShe) {
            numLabel.textColor = [UIColor whiteColor];
            ylLable.textColor = [UIColor whiteColor];
        }
        else if (colorType == GCBallViewHappyTenQuan) {
            numLabel.textColor = [UIColor whiteColor];
            numLabel3.textColor = numLabel.textColor;
            numLabel2.textColor = numLabel.textColor;
            [self setBackgroundImage:[UIImageGetImageFromName(@"HappyTenQuanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImageGetImageFromName(@"HappyTenQuanButton_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5]forState:UIControlStateHighlighted];
        }
        else if (colorType == GCBallViewColorKuaiSanWanFa) {
            numLabel.textColor = [UIColor yellowColor];
            numLabel2.textColor = [UIColor yellowColor];
        }
        else if (colorType == GCBallViewHorseRace) {
            [self setBackgroundImage:UIImageGetImageFromName(@"HorseBetButton.png") forState:UIControlStateNormal];

            [self HorseNormal];
        }
    }
    else{
        if (colorType == GCBallViewColorKuaiSanSanTongTong || colorType == GCBallViewColorKuaiSanSanLian) {
            for (UILabel * label in self.subviews) {
                if ([label isKindOfClass:[UILabel class]] && label.tag != 999) {
                    label.textColor = [UIColor whiteColor];
                }
            }
        }
        else if (colorType == GCBallViewYuShe) {
            numLabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
            ylLable.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
        }
        else if (colorType == GCBallViewHappyTenQuan) {
            numLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
            numLabel3.textColor = numLabel.textColor;
            numLabel2.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1];
            [self setBackgroundImage:[UIImageGetImageFromName(@"HappyTenQuanButton.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImageGetImageFromName(@"HappyTenQuanButton.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
        }
        else if (colorType == GCBallViewHorseRace) {
            [self setBackgroundImage:UIImageGetImageFromName(@"HorseBetButton_1.png") forState:UIControlStateNormal];

            [self HorseSelected];
        }
    }
	if (!bigImageVIew && colorType != GCBallViewHorseRace) {
		bigImageVIew = [[UIImageView alloc] init];
        bigImageVIew.frame = CGRectMake(-20, -78, 76, 117);
		

		bigImageVIew.userInteractionEnabled= NO;
		
		
		//bigImageVIew.center = CGPointMake(self.center.x, self.center.y - 27);
		bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, 76, 40)];
        bigLabel.font = [UIFont boldSystemFontOfSize:30];
        if (colorType == GCBallViewColorRed) {
//-----------------------------------------bianpinghua by sichuanlin
//			bigImageVIew.image = UIImageGetImageFromName(@"TZAH960.png");
            bigImageVIew.image = UIImageGetImageFromName(@"dadahongqiu.png");
            
		}
		else if (colorType == GCBallViewColorBlue) {
//			bigImageVIew.image = UIImageGetImageFromName(@"TZAL960.png");
            bigImageVIew.image = UIImageGetImageFromName(@"dashuzilan.png");
            
		}
        else if (colorType == GCBallViewColorBig) {
//            bigImageVIew.image = UIImageGetImageFromName(@"TZAH960.png");
            bigImageVIew.image = UIImageGetImageFromName(@"dadahongqiu.png");
            
            bigImageVIew.frame = CGRectMake(-16, -82, 80, 130);
            bigLabel.frame = CGRectMake(0, 15, 80, 50);
            bigLabel.font = [UIFont boldSystemFontOfSize:40];
        }
//        else if (colorType == GCBallViewColorKuaiSan) {
//            bigImageVIew.image = UIImageGetImageFromName(@"kuaisanballSelect.png");
//        }
        else {
            bigImageVIew.hidden = YES;
            bigLabel.hidden = YES;
        }
		bigLabel.backgroundColor =[UIColor clearColor];
		bigLabel.userInteractionEnabled = NO;
		bigLabel.textColor = [UIColor whiteColor];
		
		bigLabel.text = numLabel.text;
//		bigLabel.shadowColor = [UIColor blackColor];
//		[bigLabel setShadowOffset:CGSizeMake(1, 1)];
		[bigImageVIew addSubview:bigLabel];
		bigLabel.textAlignment = NSTextAlignmentCenter;
        [[[caiboAppDelegate getAppDelegate] window] addSubview:bigImageVIew];
		
	}
	else {
		bigImageVIew.hidden = NO;
	}
    
    CGPoint point = [self convertPoint:CGPointMake(-20, -78) toView:[[caiboAppDelegate getAppDelegate] window]];
    
    bigImageVIew.frame = CGRectMake(point.x, point.y, 76, 117);
}

- (void)hidenBigImage {
    bigImageVIew.hidden = YES;
}


- (void)TouchUpInside {
	self.selected = !self.selected;
    [self performSelector:@selector(hidenBigImage) withObject:nil afterDelay:0.2];
	if ([gcballDelegate respondsToSelector:@selector(ballSelectChange:)]) {

		[gcballDelegate ballSelectChange:self];
	}
}

- (void)dealloc {
    [bigImageVIew removeFromSuperview];
	[numLabel release];
    [numLabel2 release];
    [numLabel3 release];
    [ylLable release];
	[bigImageVIew release];
	[bigLabel release];
    [maxYiLouTag release];
    
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    