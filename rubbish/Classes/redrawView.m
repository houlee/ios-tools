//
//  redrawView.m
//  CPgaopin
//
//  Created by houchenguang on 13-11-18.
//
//

#import "redrawView.h"
#import "caiboAppDelegate.h"
#import "ChartLeftScrollView.h"

#import "ChartDefine.h"
#import "LeftChartView.h"
#import "ChartYiLouView.h"
#import "ChartYiLouScrollView.h"

@implementation redrawView
@synthesize allArray;
@synthesize chartFormatData, delegate;

- (void)dealloc{
    [chartFormatData release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame chartFormatData:(ChartFormatData *)formatData
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setNeedsDisplay];
        
        self.chartFormatData = formatData;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;

    }
    return self;
}

- (void)drawRect:(CGRect)rect
{

//    CGContextRef context=UIGraphicsGetCurrentContext();
    
    float myLottoryWidth = chartFormatData.lottoryWidth;
    float myHeWidth = chartFormatData.heWidth;
    if (chartFormatData.lottoryDisplayType == DisplayRight) {
        myLottoryWidth = 0;
        myHeWidth = 0;
    }
//
//    if (!chartFormatData.isKuaiSan) {
//        [[UIColor blackColor] setFill];
//        CGContextFillRect(context, self.bounds);//背景色
//    }
    
    int a = 0;//间隔数量
    
    if (myLottoryWidth == 0) {
        a += 1;
    }
    
    if (myHeWidth == 0) {
        a += 1;
    }
    
    int count = 0;
    if (chartFormatData.linesTitleArray.count) {
        count = (int)[chartFormatData.linesTitleArray count];
    }else{
        count = chartFormatData.numberOfLines;
    }
    
    if (!chartFormatData.linesWidth) {
        chartFormatData.linesWidth = (self.frame.size.width - (0.5 + chartFormatData.issueWidth + myLottoryWidth + myHeWidth + 0.5 * (3 - a) + 0.5 * count))/count;
    }
    
    if (chartFormatData.isEleven) {
        
        LeftChartView * leftChartView = [[[LeftChartView alloc] initWithFrame:CGRectMake(0, 0 , 0.5 + chartFormatData.issueWidth + myLottoryWidth + myHeWidth + 0.5 * (3 - a), 0.5+(chartFormatData.linesHeight * chartFormatData.allArray.count) + 0.5 * chartFormatData.allArray.count + 0.5) chartFormatData:chartFormatData] autorelease];
        [self addSubview:leftChartView];

        ChartYiLouView * chartYiLouView = [[[ChartYiLouView alloc] initWithFrame:CGRectMake(leftChartView.frame.origin.x+leftChartView.frame.size.width, leftChartView.frame.origin.y, self.frame.size.width - leftChartView.frame.size.width, 0.5+(chartFormatData.linesHeight * chartFormatData.allArray.count) + 0.5 * chartFormatData.allArray.count + 0.5) chartFormatData:chartFormatData] autorelease];
        [self addSubview:chartYiLouView];
    }else{
        ChartLeftScrollView * leftScrollView = [[ChartLeftScrollView alloc] initWithFrame:CGRectMake(0, 0 , 0.5 + chartFormatData.issueWidth + myLottoryWidth + myHeWidth + 0.5 * (3 - a), self.frame.size.height) chartFormatData:chartFormatData];
        leftScrollView.backgroundColor = [UIColor clearColor];
        leftScrollView.delegate = self;
        leftScrollView.tag = 1102;
        [self addSubview:leftScrollView];
        
        ChartYiLouScrollView * yiLouScrollView = [[ChartYiLouScrollView alloc] initWithFrame:CGRectMake(ORIGIN_X(leftScrollView), leftScrollView.frame.origin.y, self.frame.size.width - ORIGIN_X(leftScrollView), leftScrollView.frame.size.height) chartFormatData:chartFormatData];
        yiLouScrollView.tag = 1103;
        yiLouScrollView.delegate = self;
        yiLouScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:yiLouScrollView];
    }
}

-(void)reduction
{
    ChartLeftScrollView * left = (ChartLeftScrollView *)[self viewWithTag:1102];
    left.contentOffset = CGPointMake(0, left.contentSize.height - left.frame.size.height);

    ChartYiLouScrollView * yiLou = (ChartYiLouScrollView *)[self viewWithTag:1103];
    yiLou.contentOffset = CGPointMake(0, yiLou.contentSize.height - yiLou.frame.size.height);
}

- (void)returnScrollViewContOffSet:(CGPoint)point {

    if (delegate&&[delegate respondsToSelector:@selector(returnScrollViewContOffSet:)]) {
        [delegate returnScrollViewContOffSet:point ];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIScrollView * myScrollViewNum = (UIScrollView *)[self viewWithTag:1101];
    UIScrollView * myScrollViewIssue = (UIScrollView *)[self viewWithTag:1102];
    ChartYiLouScrollView * myScrollViewAll = (ChartYiLouScrollView *)[self viewWithTag:1103];
    
    if (scrollView.tag == 1101){
        myScrollViewIssue.contentOffset = CGPointMake(myScrollViewIssue.contentOffset.x, myScrollViewAll.contentOffset.y);
        myScrollViewAll.contentOffset = CGPointMake(scrollView.contentOffset.x, myScrollViewAll.contentOffset.y);
        
    }else if (scrollView.tag == 1102){
        myScrollViewNum.contentOffset = CGPointMake(myScrollViewAll.contentOffset.x, myScrollViewNum.contentOffset.y);
        myScrollViewAll.contentOffset = CGPointMake(myScrollViewAll.contentOffset.x, scrollView.contentOffset.y);
    }else if (scrollView.tag == 1103){
        myScrollViewNum.contentOffset = CGPointMake(scrollView.contentOffset.x, myScrollViewNum.contentOffset.y);
        myScrollViewIssue.contentOffset = CGPointMake(myScrollViewIssue.contentOffset.x, scrollView.contentOffset.y);
        if (self.hidden == NO) {
            [self returnScrollViewContOffSet:myScrollViewAll.contentOffset];
        }
        
    }
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    