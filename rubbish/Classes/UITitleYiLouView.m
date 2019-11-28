//
//  UITitleYiLouView.m
//  caibo
//
//  Created by houchenguang on 14-3-21.
//
//

#import "UITitleYiLouView.h"
#import "ChartTitleScrollView.h"
#import "ChartDefine.h"

@implementation UITitleYiLouView
@synthesize chartFormatData, delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    [chartFormatData release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame chartFormatData:(ChartFormatData *)formatData
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setNeedsDisplay];
        
        self.chartFormatData = formatData;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, chartFormatData.issueHeight + 0.5*2);

        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    CGRect issueRect = CGRectMake(0.5, 0.5, chartFormatData.issueWidth, chartFormatData.issueHeight);
    float myLottoryWidth = chartFormatData.lottoryWidth;
    float myHeWidth = chartFormatData.heWidth;
    if (chartFormatData.lottoryDisplayType == DisplayRight) {
        myLottoryWidth = 0;
        myHeWidth = 0;
    }
    if (!chartFormatData.isKuaiSan) {
        DRAW_TITLEBG;
        CGContextFillRect(context, self.bounds);//顶部第二层
        
        DRAW_TITLEBG_L;
        
        CGContextFillRect(context, issueRect);
        
        DRAW_TITLECOLOR;
    }else{
        DRAW_TITLEBG_K;
        CGContextFillRect(context, self.bounds);//顶部第二层
        
        DRAW_TITLEBG_LK;
        
        CGContextFillRect(context, issueRect);
        
        DRAW_TITLECOLOR_K;
    }

//    CGSize  issueSize = [@"⒂" sizeWithFont:[UIFont fontWithName:@"TRENDS" size:15] constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize  issueSize = [@"期" sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
    
    [@"期" drawInRect:CGRectMake(issueRect.origin.x, (issueRect.size.height - issueSize.height)/2, issueRect.size.width, issueSize.height) withFont:[UIFont fontWithName:@"TRENDS" size:15] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
//    if (chartFormatData.isKuaiSan) {
//        DRAW_LINE;
//        CGContextFillRect(context, CGRectMake(0, 0, 0.5, chartFormatData.issueHeight));
//        CGContextFillRect(context, CGRectMake(0.5 + chartFormatData.issueWidth, 0, 0.5, chartFormatData.issueHeight));
//    }
    
    int a = 0;//间隔数量
    
    if (myLottoryWidth) {
        CGRect lottoryRect = CGRectMake(0.5 + chartFormatData.issueWidth + 0.5, 0.5, myLottoryWidth, chartFormatData.issueHeight);
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
        
//        if (chartFormatData.isKuaiSan) {
//            DRAW_LINE;
//            CGContextFillRect(context, CGRectMake(lottoryRect.origin.x + lottoryRect.size.width, 0, 0.5, lottoryRect.size.height));
//        }
    }else{
        a += 1;
    }
    
    if (myHeWidth) {
        CGRect heRect = CGRectMake(0.5 + chartFormatData.issueWidth + myLottoryWidth + 0.5 * 2, 0.5, myHeWidth, chartFormatData.issueHeight);
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
        
//        if (chartFormatData.isKuaiSan) {
//            DRAW_LINE;
//            CGContextFillRect(context, CGRectMake(heRect.origin.x + heRect.size.width, 0, 0.5, heRect.size.height));
//        }
    }else{
        a += 1;
    }
    
//    if (chartFormatData.isKuaiSan) {
//        DRAW_LINE;
//        CGContextFillRect(context, CGRectMake(0, 0, 0.5 + chartFormatData.issueWidth + myLottoryWidth + myHeWidth + 0.5 * (3 - a), 0.5));
//        
//        CGContextFillRect(context, CGRectMake(0, self.frame.size.height - 0.5, 0.5 + chartFormatData.issueWidth + myLottoryWidth + myHeWidth + 0.5 * (3 - a), 0.5));
//    }

    int count = 0;
    if (chartFormatData.linesTitleArray.count) {
        count = (int)[chartFormatData.linesTitleArray count];
    }else{
        count = chartFormatData.numberOfLines;
    }
    
    if (!chartFormatData.linesWidth) {
        chartFormatData.linesWidth = (self.frame.size.width - (0.5 + chartFormatData.issueWidth + myLottoryWidth + myHeWidth + 0.5 * (3 - a) + 0.5 * (count - 1)))/count;
    }
    
    ChartTitleScrollView * chartTitleScrollView;
    CGRect titleRect = CGRectMake(0.5 + chartFormatData.issueWidth + myLottoryWidth + myHeWidth + 0.5 * (3 - a), 0.5, self.frame.size.width - (0.5 + chartFormatData.issueWidth + myLottoryWidth + myHeWidth + 0.5 * (3 - a)), chartFormatData.titleHeight);
    
    NSArray * titleProportionArray = [chartFormatData.rightTitleProportion componentsSeparatedByString:@":"];
    if (chartFormatData.titleHeight && chartFormatData.rightTitleArray.count) {
        
        float titleWidth = (titleRect.size.width - 0.5 * (chartFormatData.rightTitleArray.count - 1))/chartFormatData.rightTitleArray.count;
        
        float titleW = 0;

        for (int i = 0; i < chartFormatData.rightTitleArray.count; i++) {
            if ([[chartFormatData.rightTitleArray objectAtIndex:i] length]) {
                if (titleProportionArray.count) {
                    titleWidth = chartFormatData.linesWidth * [[titleProportionArray objectAtIndex:i] integerValue] + 0.5 * ([[titleProportionArray objectAtIndex:i] integerValue] - 1);
                }
                DRAW_TITLEBG_R;
                CGContextFillRect(context, CGRectMake(titleRect.origin.x + titleW + 0.5 * i, titleRect.origin.y, titleWidth, titleRect.size.height));//补充当前填充颜色的rect  中间色  30.5
                CGSize  titleSize = [[chartFormatData.rightTitleArray objectAtIndex:i] sizeWithFont:TITLE_FONT constrainedToSize:CGSizeMake(100, 100) lineBreakMode:NSLineBreakByWordWrapping];
                
                DRAW_TITLECOLOR;
                [[chartFormatData.rightTitleArray objectAtIndex:i] drawInRect:CGRectMake(titleRect.origin.x + titleW + 0.5 * i, (titleRect.size.height - titleSize.height)/2 + 1, titleWidth, titleSize.height) withFont:TITLE_FONT lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
                
                titleW += titleWidth;
            }
        }
        if (!chartFormatData.differentTitleHeightArray.count) {
            chartTitleScrollView = [[[ChartTitleScrollView alloc] initWithFrame:CGRectMake(titleRect.origin.x, 0.5 + chartFormatData.titleHeight, titleRect.size.width, chartFormatData.issueHeight - chartFormatData.titleHeight + 0.5) chartFormatData:chartFormatData] autorelease];
        }else{
            chartTitleScrollView = [[[ChartTitleScrollView alloc] initWithFrame:CGRectMake(titleRect.origin.x, 0, titleRect.size.width, chartFormatData.issueHeight + 0.5 *2) chartFormatData:chartFormatData] autorelease];
        }
    }else{
        chartTitleScrollView = [[[ChartTitleScrollView alloc] initWithFrame:CGRectMake(titleRect.origin.x, 0, titleRect.size.width, chartFormatData.issueHeight + 0.5 *2) chartFormatData:chartFormatData] autorelease];
    }
    chartTitleScrollView.tag = 1101;
    chartTitleScrollView.delegate = self;
    chartTitleScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:chartTitleScrollView];
    
    
}

- (void)returnTitleScrollViewContOffSet:(CGPoint)point{
    if (delegate&&[delegate respondsToSelector:@selector(returnTitleScrollViewContOffSet:)]) {
        [delegate returnTitleScrollViewContOffSet:point];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    ChartTitleScrollView * chartTitleScrollView = (ChartTitleScrollView *)[self viewWithTag:1101];
    if (scrollView == chartTitleScrollView) {
        if (self.hidden == NO) {
             [self returnTitleScrollViewContOffSet:chartTitleScrollView.contentOffset];
        }
       
    }
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    