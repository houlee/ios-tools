//
//  ChartFormatData.h
//  caibo
//
//  Created by GongHe on 14-3-18.
//
//

#import <Foundation/Foundation.h>
#import "ChartDefine.h"

@interface ChartFormatData : NSObject
{
    NSArray * allArray;//
    float issueWidth;//期号 宽
    float issueHeight;//期号 高
    float lottoryWidth;//开奖号 宽
    float heWidth;//和值 宽
    int numberOfLines;//列数
    float linesWidth;//右侧 列宽
    float linesHeight;//右侧 列高
    
    NSArray * linesTitleArray;//右侧 标题
    float titleHeight;//标题高度
    NSArray * differentTitleHeightArray;//标题有的有有的没有
    NSArray * rightTitleArray;//标题
    NSString * rightTitleProportion;//标题比例
    LotteryType lottoryType;//彩票类型
    LineColor lineColor;//画线颜色
    DrawType drawType;//圆还是方
    DisplayYiLou displayYiLou;//遗漏值展现方式
    LottoryColor lottoryColor;//开奖号变色方式
    BOOL isKuaiSan;//区分快三
    BOOL isEleven;//区分11选五
    
    NSArray * differentColorTypeArray;//不同颜色数组
    NSArray * differentYiLouTypeArray;//不同遗漏显示颜色数组  DisplayYiLou
    
    LottoryDisplayType lottoryDisplayType;//开奖号和左边一起还是和右边一起
}

@property (nonatomic, retain)NSArray * allArray;

@property (nonatomic, assign)float issueWidth;
@property (nonatomic, assign)float issueHeight;
@property (nonatomic, assign)float lottoryWidth;
@property (nonatomic, assign)float heWidth;
@property (nonatomic, assign)int numberOfLines;
@property (nonatomic, assign)float linesWidth;
@property (nonatomic, assign)float linesHeight;
@property (nonatomic, retain)NSArray * linesTitleArray;
@property (nonatomic, assign)float titleHeight;
@property (nonatomic, retain)NSArray * rightTitleArray;
@property (nonatomic, retain)NSString * rightTitleProportion;
@property (nonatomic, assign)LineColor lineColor;
@property (nonatomic, assign)DrawType drawType;
@property (nonatomic, assign)LotteryType lotteryType;
@property (nonatomic, assign)DisplayYiLou displayYiLou;
@property (nonatomic, assign)LottoryColor lottoryColor;
@property (nonatomic, assign)BOOL isKuaiSan;
@property (nonatomic, assign)BOOL isEleven;
@property (nonatomic, retain)NSArray * differentTitleHeightArray;

@property (nonatomic, retain)NSArray * differentColorTypeArray;
@property (nonatomic, retain)NSArray * differentYiLouTypeArray;

@property (nonatomic, assign)LottoryDisplayType lottoryDisplayType;

-(id)initWithAllArray:(NSArray *)allArr lottoryType:(LotteryType)lottoryT isEleven:(BOOL)isEleven;

-(id)initWithAllArray:(NSArray *)allArr lottoryType:(LotteryType)lottoryT kuaiSanType:(int)type;

-(id)initWithAllArray:(NSArray *)allArr lottoryType:(LotteryType)lottoryT;

-(id)initWithAllArray:(NSArray *)allArr lottoryType:(LotteryType)lottoryT lottoryDisplayType:(LottoryDisplayType)lottoryDisplayT;


- (id)initWithAllArray:(NSArray *)allArr issueWidth:(float)issueW issueHeight:(float)issueH lottoryWidth:(float)lottoryW heWidth:(float)heW numberOfLines:(int)numOfLines linesWidth:(float)linesW linesHeight:(float)linesH titleHeight:(float)titleH linesTitleArray:(NSArray *)linesTitleArr rightTitleArray:(NSArray *)rightTitleA rightTitleProportion:(NSString *)rightTitleP lottoryType:(LotteryType)lottoryT lineColor:(LineColor)lineC drawType:(DrawType)drawT displayYiLou:(DisplayYiLou)displayY lottoryColor:(LottoryColor)lottoryC lottoryDisplayType:(LottoryDisplayType)lottoryDisplayT;

@end
