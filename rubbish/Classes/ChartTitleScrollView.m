//
//  ChartTitleScrollView.m
//  caibo
//
//  Created by GongHe on 14-3-19.
//
//

#import "ChartTitleScrollView.h"
#import "ChartFormatData.h"
#import "ChartTitleView.h"

@implementation ChartTitleScrollView

- (id)initWithFrame:(CGRect)frame chartFormatData:(ChartFormatData *)formatData
{
    self = [super initWithFrame:frame];
    if (self) {
        int count = 0;
        if (formatData.linesTitleArray.count) {
            count = (int)[formatData.linesTitleArray count];
        }else{
            count = formatData.numberOfLines;
        }
        
        float myLottoryWidth = 0;
        float myHeWidth = 0;
        if (formatData.lottoryDisplayType == DisplayRight) {
            myLottoryWidth = formatData.lottoryWidth;
            myHeWidth = formatData.heWidth;
        }
        int displayRightCount = 0;
        if (myLottoryWidth) {
            displayRightCount++;
        }
        if (myHeWidth) {
            displayRightCount++;
        }

        ChartTitleView * chartTitleView = [[[ChartTitleView alloc] initWithFrame:CGRectMake(0, 0, formatData.linesWidth * count + 0.5 * (count - 1) + myLottoryWidth + myHeWidth + 0.5 * displayRightCount, self.frame.size.height) chartFormatData:formatData] autorelease];
        chartTitleView.backgroundColor = [UIColor clearColor];
        [self addSubview:chartTitleView];
        
        if (!formatData.linesWidth) {
            self.contentSize = CGSizeMake(self.frame.size.width, chartTitleView.frame.size.height);
        }else{
            self.contentSize = CGSizeMake(chartTitleView.frame.size.width, chartTitleView.frame.size.height);
        }
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.contentOffset = CGPointMake(0, self.contentSize.height - self.frame.size.height);
    }
    return self;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    