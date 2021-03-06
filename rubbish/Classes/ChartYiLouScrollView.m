//
//  ChartYiLouScrollView.m
//  caibo
//
//  Created by GongHe on 14-3-19.
//
//

#import "ChartYiLouScrollView.h"
#import "ChartFormatData.h"
#import "ChartYiLouView.h"

@implementation ChartYiLouScrollView

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

        ChartYiLouView * chartYiLouView = [[[ChartYiLouView alloc] initWithFrame:CGRectMake(0, 0, formatData.linesWidth * count + 0.5 * (count - 1) + myLottoryWidth + myHeWidth + 0.5 * displayRightCount, 0.5 + (formatData.linesHeight * formatData.allArray.count) + 0.5 * formatData.allArray.count) chartFormatData:formatData] autorelease];
        [self addSubview:chartYiLouView];
        
        self.contentSize = CGSizeMake(chartYiLouView.frame.size.width, chartYiLouView.frame.size.height);
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