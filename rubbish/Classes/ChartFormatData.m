//
//  ChartFormatData.m
//  caibo
//
//  Created by GongHe on 14-3-18.
//
//

#import "ChartFormatData.h"

@implementation ChartFormatData
@synthesize numberOfLines;
@synthesize issueWidth,issueHeight,lottoryWidth,heWidth,linesWidth,linesHeight,titleHeight;
@synthesize allArray;
@synthesize linesTitleArray;
@synthesize rightTitleArray;
@synthesize lineColor;
@synthesize drawType;
@synthesize lotteryType;
@synthesize displayYiLou;
@synthesize lottoryColor;
@synthesize isKuaiSan,isEleven;
@synthesize rightTitleProportion;
@synthesize differentColorTypeArray;
@synthesize differentYiLouTypeArray;
@synthesize differentTitleHeightArray;
@synthesize lottoryDisplayType;

- (void)dealloc
{
    [allArray release];
    [linesTitleArray release];
    [rightTitleArray release];
    [super dealloc];
}

-(id)initWithAllArray:(NSArray *)allArr lottoryType:(LotteryType)lottoryT kuaiSanType:(int)type
{
    if (!type) {
        self = [self initWithAllArray:allArr issueWidth:21 issueHeight:23 lottoryWidth:61 heWidth:0 numberOfLines:0 linesWidth:0 linesHeight:23 titleHeight:0 linesTitleArray:nil rightTitleArray:nil rightTitleProportion:nil lottoryType:lottoryT lineColor:NoLine drawType:RedCircle displayYiLou:Last lottoryColor:KuaiSanLottoryColor lottoryDisplayType:DisplayLeft];
    }else{
        self = [self initWithAllArray:allArr issueWidth:21 issueHeight:23 lottoryWidth:61 heWidth:35.5 numberOfLines:0 linesWidth:0 linesHeight:23 titleHeight:0 linesTitleArray:nil rightTitleArray:nil rightTitleProportion:nil lottoryType:lottoryT lineColor:RedLine drawType:RedCircle displayYiLou:Last lottoryColor:KuaiSanLottoryColor lottoryDisplayType:DisplayLeft];
        
    }
    self.isKuaiSan = YES;
    return self;
}

-(id)initWithAllArray:(NSArray *)allArr lottoryType:(LotteryType)lottoryT isEleven:(BOOL)isEleven
{
    self = [self initWithAllArray:allArr issueWidth:21 issueHeight:DEFAULT_ISSUE_HEIGHT lottoryWidth:0 heWidth:0 numberOfLines:0 linesWidth:0 linesHeight:21 titleHeight:0 linesTitleArray:nil rightTitleArray:nil rightTitleProportion:nil lottoryType:lottoryT lineColor:NoLine drawType:RedCircle displayYiLou:Last lottoryColor:NoColor lottoryDisplayType:DisplayLeft];
    self.isEleven = YES;
    return self;
}

-(id)initWithAllArray:(NSArray *)allArr lottoryType:(LotteryType)lottoryT lottoryDisplayType:(LottoryDisplayType)lottoryDisplayT
{
    self = [self initWithAllArray:allArr issueWidth:DEFAULT_ISSUE_WIDTH issueHeight:DEFAULT_ISSUE_HEIGHT lottoryWidth:0 heWidth:0 numberOfLines:0 linesWidth:0 linesHeight:21 titleHeight:0 linesTitleArray:nil rightTitleArray:nil rightTitleProportion:nil lottoryType:lottoryT lineColor:NoLine drawType:RedCircle displayYiLou:Last lottoryColor:NoColor lottoryDisplayType:lottoryDisplayT];
    return self;
}


-(id)initWithAllArray:(NSArray *)allArr lottoryType:(LotteryType)lottoryT
{
    self = [self initWithAllArray:allArr issueWidth:DEFAULT_ISSUE_WIDTH issueHeight:DEFAULT_ISSUE_HEIGHT lottoryWidth:0 heWidth:0 numberOfLines:0 linesWidth:0 linesHeight:21 titleHeight:0 linesTitleArray:nil rightTitleArray:nil rightTitleProportion:nil lottoryType:lottoryT lineColor:NoLine drawType:RedCircle displayYiLou:Last lottoryColor:NoColor lottoryDisplayType:DisplayLeft];
    return self;
}

- (id)initWithAllArray:(NSArray *)allArr issueWidth:(float)issueW issueHeight:(float)issueH lottoryWidth:(float)lottoryW heWidth:(float)heW numberOfLines:(int)numOfLines linesWidth:(float)linesW linesHeight:(float)linesH titleHeight:(float)titleH linesTitleArray:(NSArray *)linesTitleArr rightTitleArray:(NSArray *)rightTitleA rightTitleProportion:(NSString *)rightTitleP lottoryType:(LotteryType)lottoryT lineColor:(LineColor)lineC drawType:(DrawType)drawT displayYiLou:(DisplayYiLou)displayY lottoryColor:(LottoryColor)lottoryC lottoryDisplayType:(LottoryDisplayType)lottoryDisplayT
{
    self = [super init];
    if (self) {
        self.allArray = allArr;
        self.issueWidth = issueW;
        self.issueHeight = issueH;
        self.lottoryWidth = lottoryW;
        self.heWidth = heW;
        self.numberOfLines = numOfLines;
        self.linesWidth = linesW;
        self.linesHeight = linesH;
        self.titleHeight = titleH;
        self.linesTitleArray = linesTitleArr;
        self.rightTitleArray = rightTitleA;
        self.rightTitleProportion = rightTitleP;
        self.lotteryType = lottoryT;
        self.lineColor = lineC;
        self.drawType = drawT;
        self.displayYiLou = displayY;
        self.lottoryColor = lottoryC;
        self.lottoryDisplayType = lottoryDisplayT;
    }
    return self;
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    