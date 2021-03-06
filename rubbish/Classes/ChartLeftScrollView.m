//
//  ChartLeftScrollView.m
//  caibo
//
//  Created by GongHe on 14-3-18.
//
//

#import "ChartLeftScrollView.h"
#import "LeftChartView.h"
#import "ChartFormatData.h"

@implementation ChartLeftScrollView

- (id)initWithFrame:(CGRect)frame chartFormatData:(ChartFormatData *)formatData
{
    self = [super initWithFrame:frame];
    if (self) {
        LeftChartView * leftChartView = [[[LeftChartView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5+(formatData.linesHeight * formatData.allArray.count) + 0.5 * formatData.allArray.count) chartFormatData:formatData] autorelease];
        [self addSubview:leftChartView];
        
        self.contentSize = CGSizeMake(leftChartView.frame.size.width, leftChartView.frame.size.height);
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