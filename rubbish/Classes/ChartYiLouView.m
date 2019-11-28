//
//  ChartYiLouView.m
//  caibo
//
//  Created by GongHe on 14-3-19.
//
//

#import "ChartYiLouView.h"
#import "YiLouChartData.h"
#import "ChartFormatData.h"
#import "CoordinateData.h"
#import "ChartDefine.h"
#import "SharedMethod.h"

@implementation ChartYiLouView

- (id)initWithFrame:(CGRect)frame chartFormatData:(ChartFormatData *)formatData
{
    self = [super initWithFrame:frame];
    if (self) {
        chartFormatData = formatData;
        
        myLottoryWidth = 0;
        myHeWidth = 0;
        if (chartFormatData.lottoryDisplayType == DisplayRight) {
            myLottoryWidth = chartFormatData.lottoryWidth;
            myHeWidth = chartFormatData.heWidth;
        }
        
        [self setNeedsDisplay];
        if (chartFormatData.isKuaiSan) {
            self.backgroundColor = CHART_BG_K;
        }else{
            self.backgroundColor = CHART_BG;
        }
        firstNumber = 1;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSMutableArray * coordinateArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    context = UIGraphicsGetCurrentContext();
    
    int count = 0;
    if (chartFormatData.linesTitleArray.count) {
        count = (int)[chartFormatData.linesTitleArray count];
    }else{
        count = chartFormatData.numberOfLines;
    }
    
    int displayRightCount = 0;
    if (myLottoryWidth) {
        displayRightCount++;
    }
    if (myHeWidth) {
        displayRightCount++;
    }
    
    int a = 0;
    for (int i = 0; i < chartFormatData.allArray.count; i++) {
        iii = i;
        YiLouChartData * chartData = [chartFormatData.allArray objectAtIndex:i];
        sameNumber = chartData.sameNumber;
        if (chartFormatData.lotteryType == KuaiSanHeZhi) {
            yiLouArray = chartData.andValuesArr;
            firstNumber = 3;
        }else if (chartFormatData.lotteryType == KuaiSanErBu) {
            yiLouArray = chartData.k3ErBuTongArr;
        }else if (chartFormatData.lotteryType == KuaiSanErTong) {
            yiLouArray = chartData.k3ErTongArr;
        }else if (chartFormatData.lotteryType == KuaiSanSanLian) {
            yiLouArray = chartData.k3SanLianArr;
        }else if (chartFormatData.lotteryType == KuaiSanSanTong) {
            yiLouArray = chartData.k3SanTongArr;
        }else if (chartFormatData.lotteryType == KuaiSanSanBu) {
            yiLouArray = chartData.k3SanBuTongArr;
        }
        
        else if (chartFormatData.lotteryType == ElevenBasic) {
            yiLouArray = chartData.n115YiLouArray;
//            a = 1;
        }else if (chartFormatData.lotteryType == ElevenDaXiao) {
            yiLouArray = chartData.daXiaoArray;
            chartFormatData.drawType = GreenSquare;
        }else if (chartFormatData.lotteryType == ElevenJiOu) {
            yiLouArray = chartData.jiOuArray;
            chartFormatData.drawType = YellowSquare;
        }else if (chartFormatData.lotteryType == ElevenZhiHe) {
            yiLouArray = chartData.zhiHeArray;
            chartFormatData.drawType = BlueSquare;
        }else if (chartFormatData.lotteryType == ElevenQianOne){
            yiLouArray = chartData.n115QianOneArr;
            chartFormatData.lineColor = RedLine;
            yiLouSmall = YES;
        }else if (chartFormatData.lotteryType == ElevenQianTwo){
            yiLouArray = chartData.n115QianTwoArr;
            chartFormatData.lineColor = YellowLine;
            chartFormatData.drawType = YellowCircle;
            yiLouSmall = YES;
        }else if (chartFormatData.lotteryType == ElevenQianThree){
            yiLouArray = chartData.n115QianThreeArr;
            chartFormatData.lineColor = BlueLine;
            chartFormatData.drawType = BlueCircle;
            yiLouSmall = YES;
        }
        
        else if (chartFormatData.lotteryType == ShuangSeRed || chartFormatData.lotteryType == LeTouQian){
            yiLouArray = chartData.redYiLou;
            sameNumber = chartData.redSame;
        }else if (chartFormatData.lotteryType == ShuangSeBlue || chartFormatData.lotteryType == LeTouHou){
            yiLouArray = chartData.blueYiLou;
            sameNumber = chartData.blueSame;
        }else if (chartFormatData.lotteryType == ShuangSeData || chartFormatData.lotteryType == LeTouData){
            yiLouArray = chartData.dataArray;
        }
        
        else if (chartFormatData.lotteryType == threeDOne) {
            yiLouArray = chartData.threeDOneArr;
            firstNumber = 0;
        }
        else if (chartFormatData.lotteryType == threeDTwo) {
            yiLouArray = chartData.threeDTwoArr;
            firstNumber = 0;
        }
        else if (chartFormatData.lotteryType == threeDThree) {
            yiLouArray = chartData.threeDThreeArr;
            firstNumber = 0;
        }
        else if (chartFormatData.lotteryType == threeDBasic) {
            yiLouArray = chartData.threeDBasicArr;
            firstNumber = 0;
        }
        else if (chartFormatData.lotteryType == threeDType) {
            yiLouArray = chartData.threeDTypeArr;
        }
        else if (chartFormatData.lotteryType == threeDDaXiaoJiOu) {
            yiLouArray = chartData.threeDDaXiaoJiOuArray;
        }
        
        else if (chartFormatData.lotteryType == HappyTen) {
            yiLouArray = chartData.happyYiLouArray;
        }
        
        for (int j = 0; j < count; j++) {
            jjj = j;
            
            if (chartFormatData.isKuaiSan) {
                if (i % 2 == 0) {
                    DRAW_LEFTBG_ODD_K;
                }else{
                    DRAW_LEFTBG_EVEN_K;
                }
            }else{
                if (i % 2 == 0) {
                    DRAW_LEFTBG_ODD;
                }else{
                    DRAW_LEFTBG_EVEN;
                }
            }
            
            squareRect = CGRectMake(myLottoryWidth + myHeWidth + 0.5 * displayRightCount + 0.5 * j + chartFormatData.linesWidth * j, 0.5+(chartFormatData.linesHeight*i)+(0.5*i), chartFormatData.linesWidth, chartFormatData.linesHeight);
            if (chartFormatData.drawType > 4 && yiLouArray.count) {
                if ([[yiLouArray objectAtIndex:j + a] intValue] == 0) {
                    if ([[yiLouArray objectAtIndex:j + a] isKindOfClass:[NSString class]] && [[yiLouArray objectAtIndex:j + a] isEqualToString:@""]) {
                        CGContextFillRect(context, squareRect);
                    }else{
                        if (chartFormatData.drawType == DifferentColorSquare && chartFormatData.differentColorTypeArray.count && j < chartFormatData.differentColorTypeArray.count) {
                            [self drawWithColor:[[chartFormatData.differentColorTypeArray objectAtIndex:jjj] intValue]];
                        }else{
                            [self drawWithColor:chartFormatData.drawType];
                        }
                    }
                }else{
                    CGContextFillRect(context, squareRect);//补充当前填充颜色的rect  最高色
                }
            }else{
                CGContextFillRect(context, squareRect);//补充当前填充颜色的rect  最高色
            }
            
            if (j == 0 && chartFormatData.lottoryDisplayType == DisplayRight){//重绘开奖号 字体颜色的变化
                if (myLottoryWidth) {
                    CGRect lotteryRect = CGRectMake(0, 0.5 + chartFormatData.linesHeight * i + 0.5 * i, myLottoryWidth, chartFormatData.linesHeight);
                    
                    CGContextFillRect(context, lotteryRect);
                    
                    if (chartData) {
                        heght = lotteryRect.size.height/2 + (chartFormatData.linesHeight*i)+(0.5*i);
                        
                        NSDictionary * sortInfo = [SharedMethod getSortedArrayInfoByArray:chartData.lotteryNumArr];
                        [self drawKaiJiangWithStrArr:chartData.lotteryNumArr sameCount:[sortInfo valueForKey:@"sameCount"] sameNumber:[sortInfo valueForKey:@"sameNumber"]];
                    }
                }
            }
            
            if (yiLouArray.count && chartFormatData.differentYiLouTypeArray.count) {
                if (chartFormatData.isKuaiSan) {
                    DRAW_YILOU_BK;
                }else{
                    if ([[chartFormatData.differentYiLouTypeArray objectAtIndex:j] integerValue] == Last && i == chartFormatData.allArray.count - 1 && [[yiLouArray objectAtIndex:j + a] intValue]) {
                        DRAW_YILOU_LAST;
                    }else{
                        DRAW_YILOU_BG;
                    }
                }
//                UIFont * yiLouFont;
                if (yiLouSmall) {
//                    yiLouFont = [UIFont systemFontOfSize:12];
                }else{
//                    yiLouFont = LOTTERY_FONT;
                }
                if (([[chartFormatData.differentYiLouTypeArray objectAtIndex:j] integerValue] == Last && i == chartFormatData.allArray.count - 1 && [[yiLouArray objectAtIndex:j + a] intValue]) || [[chartFormatData.differentYiLouTypeArray objectAtIndex:j] integerValue] == All) {
                    CGSize  yiLouSize = [[[yiLouArray objectAtIndex:j + a] description] sizeWithFont:LOTTERY_FONT constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    [[[yiLouArray objectAtIndex:j + a] description] drawInRect:CGRectMake(squareRect.origin.x, (squareRect.size.height - yiLouSize.height)/2 + (chartFormatData.linesHeight*i)+(0.5*i), squareRect.size.width, yiLouSize.height) withFont:LOTTERY_FONT lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
                }
            }
            else if (yiLouArray.count && ([[yiLouArray objectAtIndex:j + a] intValue] || chartFormatData.displayYiLou == All)) {
                if (chartFormatData.isKuaiSan) {
                    DRAW_YILOU_LAST_K;
                }else{
                    if (chartFormatData.displayYiLou == All) {
                        DRAW_YILOU_BG;
                    }else{
                        DRAW_YILOU_LAST;
                    }
                }
                UIFont * yiLouFont;
                if (yiLouSmall) {
                    yiLouFont = [UIFont systemFontOfSize:12];
                }else{
                    yiLouFont = LOTTERY_FONT;
                }
                if ((chartFormatData.displayYiLou == Last && i == chartFormatData.allArray.count - 1) || chartFormatData.displayYiLou == All) {
                    
                    CGSize  yiLouSize = [[[yiLouArray objectAtIndex:j + a] description] sizeWithFont:yiLouFont constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];

                    [[[yiLouArray objectAtIndex:j + a] description] drawInRect:CGRectMake(squareRect.origin.x, (squareRect.size.height - yiLouSize.height)/2 + (chartFormatData.linesHeight*i)+(0.5*i), squareRect.size.width, yiLouSize.height) withFont:yiLouFont lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
                }
            }
            
            if (chartFormatData.lineColor && yiLouArray.count) {
                if ([[yiLouArray objectAtIndex:j + a] intValue] == 0) {
                    
                    CoordinateData * data = [[CoordinateData alloc] init];
                    data.x = chartFormatData.linesWidth * j + 0.5 * j + chartFormatData.linesWidth/2;
                    data.y = chartFormatData.linesHeight *i + 0.5 * i + chartFormatData.linesHeight/2;
                    data.dataNumber = [NSString stringWithFormat:@"%d", j+firstNumber];
                    data.sameNumber = sameNumber;
                    [coordinateArray addObject:data];
                    [data release];
                    
                }
            }else{
                if (chartData && yiLouArray.count) {
                    if ([[yiLouArray objectAtIndex:j + a] intValue] == 0 && chartFormatData.drawType <= 4 && chartFormatData.displayYiLou != All) {
                            NSArray * sameNumberArr;
                            if (chartFormatData.drawType == TwoColorCircle || chartFormatData.lotteryType == threeDBasic || chartFormatData.lotteryType == threeDType || chartFormatData.lotteryType == threeDDaXiaoJiOu || chartFormatData.isKuaiSan) {
                                NSArray * sameNumberArr1 =  [sameNumber componentsSeparatedByString:@"|"];
                                if (sameNumberArr1.count > j) {
                                    sameNumberArr = [[sameNumberArr1 objectAtIndex:j] componentsSeparatedByString:@"#"];
                                }
                                
                            }else{
                                sameNumberArr = [sameNumber componentsSeparatedByString:@"#"];
                            }
                            if ([sameNumberArr count] == 2 && chartFormatData.drawType > 2) {
                                if ((j + 1) == [[sameNumberArr objectAtIndex:0] intValue]) {//2个相同的话
                                    if ([[sameNumberArr objectAtIndex:1] intValue] == 2) {
                                        if (chartFormatData.drawType == TwoColorCircle) {
                                            [self drawWithColor:RedCircle];
                                        }else{
                                            [self drawWithColor:YellowCircle];
                                        }
                                    }else if ([[sameNumberArr objectAtIndex:1] intValue] == 3) {//3个相同的话
                                        if (chartFormatData.drawType == TwoColorCircle) {
                                            [self drawWithColor:YellowCircle];
                                        }else{
                                            [self drawWithColor:BlueCircle];
                                        }
                                    }else{
                                        [self drawWithColor:RedCircle];
                                    }
                                }else{
                                    [self drawWithColor:RedCircle];
                                }
                            }else {
                                if (chartFormatData.drawType != ThreeColorCircle) {
                                    if (chartFormatData.differentColorTypeArray) {
                                        [self drawWithColor:[[chartFormatData.differentColorTypeArray objectAtIndex:j] intValue]];
                                    }else{
                                        [self drawWithColor:chartFormatData.drawType];
                                    }
                                }else{
                                    [self drawWithColor:RedCircle];
                                }
                            }
                        }
//                    }
                }
            }
        }
//        if (chartFormatData.isKuaiSan) {
//            DRAW_LINE;
//            CGContextFillRect(context, CGRectMake(0, chartFormatData.linesHeight * i + 0.5 * i, self.frame.size.width, 0.5));
//            if (i != 0) {
//                CGContextFillRect(context, CGRectMake(chartFormatData.linesWidth * i  + 0.5 * (i - 1), 0, 0.5, self.frame.size.height));
//            }
//            
//            if (i == chartFormatData.allArray.count - 1) {
//                CGContextFillRect(context, CGRectMake(0, chartFormatData.linesHeight * (i + 1) + 0.5 * (i + 1), self.frame.size.width, 0.5));
//            }
//        }
    }
    
    if (chartFormatData.lineColor) {
        //画线
        CGContextSetLineCap(context, kCGLineCapRound);//设置线的样式
        //设置线条粗细宽度
        CGContextSetLineWidth(context, 1);
        //设置颜色
        if (chartFormatData.lineColor == BlueLine) {
            DRAW_BLUE_LINE;
        }else if (chartFormatData.lineColor == YellowLine) {
            DRAW_YELLOW_LINE;
        }else{
            if (chartFormatData.isKuaiSan) {
                DRAW_RED_LINE_K;
            }else{
                DRAW_RED_LINE;
            }
        }
        //开始一个起始路径
        CGContextBeginPath(context);
        //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
        if ([coordinateArray count] > 1) {
            CoordinateData * data = [coordinateArray objectAtIndex:0];
            CGContextMoveToPoint(context, data.x, data.y);
        }
        for (int i = 1; i < [coordinateArray count]; i++) {
            //设置下一个坐标点
            CoordinateData * data = [coordinateArray objectAtIndex:i];
            CGContextAddLineToPoint(context, data.x, data.y);
        }
        
        //连接上面定义的坐标点
        CGContextStrokePath(context);
        
        for (int i = 0; i < [coordinateArray count]; i++) {//画圆和文字
            //设置下一个坐标点
            CoordinateData * data = [coordinateArray objectAtIndex:i];
            if (chartFormatData.drawType  <= 4 && chartFormatData.drawType == ThreeColorCircle) {
                NSArray * sameNumberArr = [data.sameNumber componentsSeparatedByString:@"#"];
                if ([sameNumberArr count] == 2) {
                    if ([[sameNumberArr objectAtIndex:1] intValue] == 2) {
                        DRAW_YELLOW;
                    }else if ([[sameNumberArr objectAtIndex:1] intValue] == 3) {//3个相同的话
                        DRAW_BLUE;
                    }else{
                        DRAW_RED;
                    }
                }else {
                    DRAW_RED;
                }
            }else if (chartFormatData.drawType == BlueCircle) {
                DRAW_BLUE;
            }else if (chartFormatData.drawType == YellowCircle) {
                DRAW_YELLOW;
            }else{
                DRAW_RED;
            }
            
            CGContextAddArc(context, data.x,  data.y+0.5, RADIUS, 0, 6, 0);
            CGContextFillPath(context);
            
            CGSize  dataNumberSize = [data.dataNumber sizeWithFont:[UIFont boldSystemFontOfSize:13] constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            DRAW_WHITE;
            [data.dataNumber drawInRect:CGRectMake(data.x - dataNumberSize.width/2, data.y - dataNumberSize.height/2, dataNumberSize.width, dataNumberSize.height) withFont:[UIFont boldSystemFontOfSize:13] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
        }
    }
    [coordinateArray release];
}

//画圈或方
-(void)drawWithColor:(DrawType)type
{
    if (chartFormatData.isKuaiSan) {
        if (type == YellowSquare) {
            DRAW_YELLOW_SK;
        }else if (type == BlueSquare) {
            DRAW_BLUE_SK;
        }else if (type == RedSquare) {
            DRAW_RED_SK;
        }else if (type == GreenSquare) {
            DRAW_GREEN_SK;
        }else if (type == BlueKSquare) {
            DRAW_BLUE_SK;
        }else if (type == PurpleKSquare) {
            DRAW_PURPLE_SK;
        }else if (type == FourColorSquare) {
            if (jjj == 0) {
                DRAW_BLUE_SK;
            }else if (jjj == 1) {
                DRAW_RED_SK;
            }else if (jjj == 2) {
                DRAW_YELLOW_SK;
            }else{
                DRAW_GREEN_SK;
            }
        }else if (type == RedCircle) {
            DRAW_RED_BK;
        }else if (type == BlueCircle) {
            DRAW_BLUE_BK;
        }else if (type == YellowCircle) {
            DRAW_YELLOW_BK;
        }
    }else{
    if (type == YellowSquare) {
        DRAW_YELLOW;
    }else if (type == BlueSquare) {
        DRAW_BLUE;
    }else if (type == RedSquare) {
        DRAW_RED;
    }else if (type == GreenSquare) {
        DRAW_GREEN;
    }else if (type == BlueKSquare) {
        DRAW_BLUE_BK;
    }else if (type == PurpleKSquare) {
        DRAW_PURPLE_SK;
    }else if (type == FourColorSquare) {
        if (jjj == 0) {
            DRAW_BLUE_SK;
        }else if (jjj == 1) {
            DRAW_RED_SK;
        }else if (jjj == 2) {
            DRAW_YELLOW_SK;
        }else{
            DRAW_GREEN_SK;
        }
    }else if (type == RedCircle) {
        DRAW_RED;
    }else if (type == BlueCircle) {
        DRAW_BLUE;
    }else if (type == YellowCircle) {
        DRAW_YELLOW;
    }else if (type == PurpleSquare) {
        DRAW_PURPLE;
    }
    }
    
    UIFont * textFont = LOTTERY_FONT;
    NSString * text = @"";
    if (chartFormatData.drawType  <= 4) {
        CGContextAddArc(context, squareRect.origin.x + chartFormatData.linesWidth/2, squareRect.origin.y + chartFormatData.linesHeight/2, RADIUS, 0, 6, 0);
        CGContextFillPath(context);
        text = [NSString stringWithFormat:@"%d", jjj + firstNumber];
        textFont = LOTTERY_FONT_B;
    }else if (chartFormatData.drawType >3 && chartFormatData.linesTitleArray.count){
        CGContextFillRect(context, squareRect);
        if (chartFormatData.differentColorTypeArray.count && jjj >= chartFormatData.differentColorTypeArray.count)
        {
            text = [yiLouArray objectAtIndex:jjj];
        }else{
            text = [chartFormatData.linesTitleArray objectAtIndex:jjj];
        }
    }else{
        CGContextFillRect(context, squareRect);
        text = [NSString stringWithFormat:@"%d", jjj + firstNumber];
    }
    
    CGSize  textSize = [text sizeWithFont:textFont constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];

    DRAW_YILOU;
    [text drawInRect:CGRectMake(squareRect.origin.x, (squareRect.size.height - textSize.height)/2 + (chartFormatData.linesHeight*iii)+(0.5*iii), squareRect.size.width, textSize.height) withFont:textFont lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
}

-(void)drawKaiJiangWithStrArr:(NSArray *)strArr sameCount:(NSString *)count sameNumber:(NSString *)sameNumber1
{
    float numberSizeW = 0;
    NSString * dotStr = @" ";
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
            numberString = [numberString stringByAppendingString:[NSString stringWithFormat:@"0%ld",(long)[[strArr objectAtIndex:i] integerValue]]];
        }else{
            numberString = [numberString stringByAppendingString:[strArr objectAtIndex:i]];
        }
        
        if (i != (a + 1)/2 - 1) {
            dotString = [dotString stringByAppendingString:dotStr];
        }
    }
    CGSize allDotSize = [dotString sizeWithFont:dotFont constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize numSize = [numberString sizeWithFont:numFont constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    float X = (myLottoryWidth - (numSize.width + allDotSize.width))/2;
    if (chartFormatData.lotteryType == HappyTen) {
        X -= 3;
    }
    for (int i = 0; i < a; i++) {
        if (i%2 == 0) {
            if (chartFormatData.lottoryColor == ThreeColor && [count intValue] == 1 && [[strArr objectAtIndex:i/2] isEqualToString:sameNumber1]) {
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
            }else{
                if (chartFormatData.isKuaiSan) {
                    DRAW_LOTTERY_K;
                }else{
                    DRAW_LOTTERY_GRAY;
                }
            }
            
            NSString * numStr = @" ";
            if ([[strArr objectAtIndex:i/2] integerValue] < 10 && !chartFormatData.isKuaiSan && chartFormatData.lotteryType < 18) {
                numStr = [NSString stringWithFormat:@"0%ld",(long)[[strArr objectAtIndex:i/2] integerValue]];
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