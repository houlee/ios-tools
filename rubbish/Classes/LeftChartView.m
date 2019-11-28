//
//  LeftChartView.m
//  caibo
//
//  Created by GongHe on 14-3-18.
//
//

#import "LeftChartView.h"
#import "ChartFormatData.h"
#import "YiLouChartData.h"
#import "ChartFormatData.h"
#import "ChartDefine.h"
#import "SharedMethod.h"

@implementation LeftChartView

- (id)initWithFrame:(CGRect)frame chartFormatData:(ChartFormatData *)formatData
{
    self = [super initWithFrame:frame];
    if (self) {
        chartFormatData = formatData;
        myLottoryWidth = chartFormatData.lottoryWidth;
        myHeWidth = chartFormatData.heWidth;
        if (chartFormatData.lottoryDisplayType == DisplayRight) {
            myLottoryWidth = 0;
            myHeWidth = 0;
        }
        if (chartFormatData.isKuaiSan) {
            self.backgroundColor = CHART_BG_K;
        }else{
            self.backgroundColor = CHART_BG;
        }
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < chartFormatData.allArray.count; i++) {
        YiLouChartData * chartData = [chartFormatData.allArray objectAtIndex:i];
        for (int j = 0; j < 3; j++) {
            if (chartFormatData.isKuaiSan) {
                if (i % 2 == 0) {
                    if (j == 0) {
                        DRAW_LEFTBG_ODD_ISSUE_K;
                    }else{
                        DRAW_LEFTBG_ODD_K;
                    }
                }else{
                    if (j == 0) {
                        DRAW_LEFTBG_EVEN_ISSUE_K;
                    }else{
                        DRAW_LEFTBG_EVEN_K;
                    }
                }
            }else{
                if (i % 2 == 0) {
                    if (j % 2 == 0) {
                        DRAW_LEFTBG_ODD_ISSUE;
                    }else{
                        DRAW_LEFTBG_ODD;
                    }
                }else{
                    if (j % 2 == 0) {
                        DRAW_LEFTBG_EVEN_ISSUE;
                    }else{
                        DRAW_LEFTBG_EVEN;
                    }
                }
            }
            
            if (j < 3) {
                if (j == 0) {
                    CGRect issueRect = CGRectMake(0.5, 0.5+(chartFormatData.linesHeight*i)+(0.5*i), chartFormatData.issueWidth, chartFormatData.linesHeight);
                    
                    CGContextFillRect(context, issueRect);
                    
                    //重绘期号
                    if (chartData) {
                        if (chartFormatData.isKuaiSan) {
                            if (i == chartFormatData.allArray.count - 1) {
                                DRAW_ISSUE_NEW_K;
                            }else{
                                DRAW_ISSUE_K;
                            }
                        }
                        else if (i == chartFormatData.allArray.count - 1) {
                            DRAW_ISSUE_NEW;
                        }
                        else{
                            DRAW_ISSUE;
                        }
                        
                        CGSize  issueSize = [chartData.issueNumber sizeWithFont:LOTTERY_FONT constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        [chartData.issueNumber drawInRect:CGRectMake(issueRect.origin.x, (issueRect.size.height - issueSize.height)/2 + (chartFormatData.linesHeight*i)+(0.5*i), issueRect.size.width, issueSize.height) withFont:LOTTERY_FONT lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
                    }
                }else if (j == 1){//重绘开奖号 字体颜色的变化
                    if (myLottoryWidth) {
                        CGRect lotteryRect = CGRectMake(0.5 + chartFormatData.issueWidth + 0.5, 0.5+(chartFormatData.linesHeight*i)+(0.5*i), myLottoryWidth, chartFormatData.linesHeight);
                        
                        CGContextFillRect(context, lotteryRect);
                        
                        if (chartData) {
//                            heght = (chartFormatData.linesHeight*i)+(0.5*i)+5;
                            heght = lotteryRect.size.height/2 + (chartFormatData.linesHeight*i)+(0.5*i);
                            
                            NSDictionary * sortInfo = [SharedMethod getSortedArrayInfoByArray:chartData.lotteryNumArr];
                            [self drawKaiJiangWithStrArr:chartData.lotteryNumArr sameCount:[sortInfo valueForKey:@"sameCount"] sameNumber:[sortInfo valueForKey:@"sameNumber"]];
                        }
                    }
                }else if (j == 2){
                    if (myHeWidth) {
                        CGRect andRect = CGRectMake(0.5 + chartFormatData.issueWidth + myLottoryWidth + 0.5*j, 0.5+(chartFormatData.linesHeight*i)+(0.5*i), myHeWidth, chartFormatData.linesHeight);

                        CGContextFillRect(context, andRect);
                        
                        if (chartData) {
                            if (chartFormatData.isKuaiSan) {
                                DRAW_LOTTERY_K;
                            }else{
                                [[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1] setFill];
                            }
                            CGSize  andSize = [chartData.andValues sizeWithFont:LOTTERY_FONT constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
                            
                            [chartData.andValues drawInRect:CGRectMake(andRect.origin.x, (andRect.size.height - andSize.height)/2 + (chartFormatData.linesHeight*i)+(0.5*i), andRect.size.width, andSize.height) withFont:LOTTERY_FONT lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];//重绘和值
                        }
                    }
                }
            }
        }
//        if (chartFormatData.isKuaiSan) {
//            DRAW_LINE;
//            CGContextFillRect(context, CGRectMake(0, chartFormatData.linesHeight * i + 0.5 * i, self.frame.size.width, 0.5));
//            
//            if (i == chartFormatData.allArray.count - 1) {
//                CGContextFillRect(context, CGRectMake(0, chartFormatData.linesHeight * (i + 1) + 0.5 * (i + 1), self.frame.size.width, 0.5));
//            }
//        }
    }
//    if (chartFormatData.isKuaiSan) {
//        DRAW_LINE;
//        CGContextFillRect(context, CGRectMake(0, 0, 0.5, self.frame.size.height));
//        CGContextFillRect(context, CGRectMake(0.5 + chartFormatData.issueWidth, 0, 0.5, self.frame.size.height));
//        if (myLottoryWidth) {
//            CGContextFillRect(context, CGRectMake(0.5 + chartFormatData.issueWidth + 0.5 + myLottoryWidth, 0, 0.5, self.frame.size.height));
//        }
//        if (myHeWidth) {
//            CGContextFillRect(context, CGRectMake(0.5 + chartFormatData.issueWidth + 0.5 + myLottoryWidth + 0.5 + myHeWidth, 0, 0.5, self.frame.size.height));
//        }
//    }
    
//    UIImage * newImage = UIImageGetImageFromName(@"newylimage.png");
//    [newImage drawInRect:CGRectMake(21, self.frame.size.height - 25.5, 7, 7)];
//    CGRect newRect = CGRectMake(0.5 + chartFormatData.issueWidth - 7, self.frame.size.height - 0.5 - chartFormatData.linesHeight, 7, 7);
//    
//    [[UIColor redColor] setFill];
//    CGContextFillRect(context, newRect);
//    
//    [[UIColor whiteColor] setFill];
//    CGSize  newSize = [@"N" sizeWithFont:[UIFont boldSystemFontOfSize:7] constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
//    
//    [@"N" drawInRect:CGRectMake(newRect.origin.x, newRect.origin.y + (newRect.size.height - newSize.height)/2, newRect.size.width, newSize.height) withFont:[UIFont boldSystemFontOfSize:7] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
}

-(void)drawKaiJiangWithStrArr:(NSArray *)strArr sameCount:(NSString *)count sameNumber:(NSString *)sameNumber
{
    float numberSizeW = 0;
    NSString * dotStr = @" ";
    if (chartFormatData.isKuaiSan) {
        dotStr = @"  ";
    }
    UIFont * dotFont = LOTTERY_FONT;
    UIFont * numFont = LOTTERY_FONT;

    if (!chartFormatData.isKuaiSan && chartFormatData.lotteryType < 18) {
        dotFont = [UIFont systemFontOfSize:5];
    }
    CGSize dotSize = [dotStr sizeWithFont:dotFont constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];

    int a = (int)strArr.count * 2 - 1;
    if (chartFormatData.lotteryType == ElevenQianOne || chartFormatData.lotteryType == ElevenQianTwo || chartFormatData.lotteryType == ElevenQianThree) {
        a = 5;
    }

    NSString * numberString = @"";
    NSString * dotString = @"";
    for (int i = 0; i < (a + 1)/2; i++) {
        if ([[strArr objectAtIndex:i] integerValue] < 10 && !chartFormatData.isKuaiSan && chartFormatData.lotteryType < 18) {
            numberString = [numberString stringByAppendingString:[NSString stringWithFormat:@"0%d",(int)[[strArr objectAtIndex:i] integerValue]]];
        }else{
            numberString = [numberString stringByAppendingString:[strArr objectAtIndex:i]];
        }

        if (i != (a + 1)/2 - 1) {
            dotString = [dotString stringByAppendingString:dotStr];
        }
    }
    CGSize allDotSize = [dotString sizeWithFont:dotFont constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize numSize = [numberString sizeWithFont:numFont constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    float X = chartFormatData.issueWidth + 0.5 + (myLottoryWidth - (numSize.width + allDotSize.width))/2;
    
    for (int i = 0; i < a; i++) {
        if (i%2 == 0) {
            if (chartFormatData.lottoryColor == ThreeColor && [count intValue] == 1 && [[strArr objectAtIndex:i/2] isEqualToString:sameNumber]) {
                DRAW_YELLOW_TK;
            }else if (chartFormatData.lottoryColor == ThreeColor && [count intValue] == 2) {
                DRAW_BLUE_TK;
            }else if (chartFormatData.lottoryColor == WhiteColor) {
                DRAW_WHITE;
            }else if (chartFormatData.lottoryColor == FirstColor && i/2 == 0) {
                    DRAW_RED;
            }else if (chartFormatData.lottoryColor == SecondColor && i/2 == 1) {
                    DRAW_YELLOW;
            }else if (chartFormatData.lottoryColor == ThirdColor && i/2 == 2) {
                    DRAW_BLUE;
            }else if (chartFormatData.lottoryColor == KuaiSanLottoryColor) {
                DRAW_LOTTERY_K;
            }
            else{
                if (chartFormatData.isKuaiSan) {
                    DRAW_LOTTERY_K;
                }else{
                    DRAW_LOTTERY_GRAY;
                }
            }
            
            NSString * numStr = @" ";
            if ([[strArr objectAtIndex:i/2] integerValue] < 10 && !chartFormatData.isKuaiSan && chartFormatData.lotteryType < 18) {
                numStr = [NSString stringWithFormat:@"0%d",(int)[[strArr objectAtIndex:i/2] intValue]];
            }else{
                numStr = [strArr objectAtIndex:i/2];
            }
            CGSize numberSize = [numStr sizeWithFont:numFont constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];

            [numStr drawInRect:CGRectMake(X + numberSizeW + dotSize.width * (i/2), heght  - numberSize.height/2, numberSize.width, numberSize.height) withFont:numFont lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
            
            numberSizeW += numberSize.width;
        }
        else{
            DRAW_LOTTERY_GRAY;
            [dotStr drawInRect:CGRectMake(X + numberSizeW + dotSize.width * (i/2), heght - 12/2, dotSize.width, 12) withFont:dotFont lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        }
    }
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    