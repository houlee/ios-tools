//
//  ChartTitleView.m
//  caibo
//
//  Created by GongHe on 14-3-19.
//
//

#import "ChartTitleView.h"
#import "ChartFormatData.h"
#import "ChartDefine.h"

@implementation ChartTitleView

- (id)initWithFrame:(CGRect)frame chartFormatData:(ChartFormatData *)formatData
{
    self = [super initWithFrame:frame];
    if (self) {
        chartFormatData = formatData;
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    int count = 0;
    if (chartFormatData.linesTitleArray.count) {
        count = (int)[chartFormatData.linesTitleArray count];
    }else{
        count = chartFormatData.numberOfLines;
    }

    float myLottoryWidth = 0;
    float myHeWidth = 0;
    if (chartFormatData.lottoryDisplayType == DisplayRight) {
        myLottoryWidth = chartFormatData.lottoryWidth;
        myHeWidth = chartFormatData.heWidth;
    }
    
    int displayRightCount = 0;
    for (int i = 0; i < count; i++) {
        if (i == 0 && chartFormatData.lottoryDisplayType == DisplayRight && myLottoryWidth) {
            CGRect lottoryRect = CGRectMake(0, 0.5, myLottoryWidth, chartFormatData.issueHeight);
            if (!chartFormatData.isKuaiSan) {
                DRAW_TITLEBG_L;
                CGContextFillRect(context, lottoryRect);
                
                DRAW_TITLECOLOR;
            }else{
                DRAW_TITLEBG_LK;
                CGContextFillRect(context, lottoryRect);
                
                DRAW_TITLECOLOR_K;
            }
            
            CGSize  lottorySize = [@"开奖号" sizeWithFont:TITLE_FONT constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
            
            [@"开奖号" drawInRect:CGRectMake(lottoryRect.origin.x, (lottoryRect.size.height - lottorySize.height)/2, lottoryRect.size.width, lottorySize.height) withFont:TITLE_FONT lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
            
//            if (chartFormatData.isKuaiSan) {
//                DRAW_LINE;
//                CGContextFillRect(context, CGRectMake(lottoryRect.origin.x + lottoryRect.size.width, 0, 0.5, lottoryRect.size.height));
//            }
            displayRightCount++;
        }
        if (i == 1 && chartFormatData.lottoryDisplayType == DisplayRight && myHeWidth) {
            CGRect heRect = CGRectMake(0.5 + myLottoryWidth + 0.5, 0.5, myHeWidth, chartFormatData.issueHeight);
            if (!chartFormatData.isKuaiSan) {
                DRAW_TITLEBG_L;
                CGContextFillRect(context, heRect);
                
                DRAW_TITLECOLOR;
            }else{
                DRAW_TITLEBG_LK;
                CGContextFillRect(context, heRect);
                
                DRAW_TITLECOLOR_K;
            }
            
            CGSize  heSize = [@"和值" sizeWithFont:TITLE_FONT constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
            
            [@"和值" drawInRect:CGRectMake(heRect.origin.x, (heRect.size.height - heSize.height)/2, heRect.size.width, heSize.height) withFont:TITLE_FONT lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
            
//            if (chartFormatData.isKuaiSan) {
//                DRAW_LINE;
//                CGContextFillRect(context, CGRectMake(heRect.origin.x + heRect.size.width, 0, 0.5, heRect.size.height));
//            }
        }
        
        CGRect numRect;
        if (chartFormatData.differentTitleHeightArray.count && [[chartFormatData.differentTitleHeightArray objectAtIndex:i] integerValue] == 0) {
            numRect = CGRectMake(myLottoryWidth + myHeWidth + 0.5 * displayRightCount + chartFormatData.linesWidth * i + 0.5 * i, 0.5 + chartFormatData.titleHeight + 0.5, chartFormatData.linesWidth, chartFormatData.issueHeight - chartFormatData.titleHeight - 0.5);
        }else{
            numRect = CGRectMake(myLottoryWidth + myHeWidth + 0.5 * displayRightCount + chartFormatData.linesWidth * i + 0.5 * i, 0.5, chartFormatData.linesWidth, self.frame.size.height - 0.5 * 2);
        }
        
        int a = 1;
        if (chartFormatData.isKuaiSan == YES) {
            if (chartFormatData.lotteryType != KuaiSanSanBu) {
                a = 3;
            }
        }
        if (chartFormatData.lotteryType == threeDOne || chartFormatData.lotteryType == threeDTwo || chartFormatData.lotteryType == threeDThree || chartFormatData.lotteryType == threeDBasic) {
            a = 0;
        }
        NSString * titleString = @"";
        if (chartFormatData.linesTitleArray.count) {
            titleString = [chartFormatData.linesTitleArray objectAtIndex:i];
        }else{
            titleString = [NSString stringWithFormat:@"%d", i + a];
        }
        CGSize  numSize = [titleString sizeWithFont:TITLE_FONT constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
        
        if (chartFormatData.isKuaiSan) {
            DRAW_TITLEBG_RK;
            CGContextFillRect(context, numRect);
            
            DRAW_TITLECOLOR_K;
        }else{
            DRAW_TITLEBG_R;
            CGContextFillRect(context, numRect);

            DRAW_TITLECOLOR;
        }

        [titleString drawInRect:CGRectMake(0.5 + numRect.origin.x, (numRect.size.height - numSize.height)/2 + numRect.origin.y, chartFormatData.linesWidth, numSize.height) withFont:TITLE_FONT lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
        
//        if (chartFormatData.isKuaiSan && i != 0) {
//            DRAW_LINE;
//            CGContextFillRect(context, CGRectMake(chartFormatData.linesWidth * i  + 0.5 * (i - 1), 0, 0.5, self.frame.size.height));
//        }
    }
//    if (chartFormatData.isKuaiSan) {
//        DRAW_LINE;
//        CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, 0.5));
//        CGContextFillRect(context, CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5));
//    }
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    