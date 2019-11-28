//
//  ChartDefine.h
//  caibo
//
//  Created by GongHe on 14-3-21.
//
//

#import <Foundation/Foundation.h>

#define YiLOU_COUNT @"30"

#define TITLE_FONT [UIFont systemFontOfSize:13]

#define LOTTERY_FONT [UIFont systemFontOfSize:13]

#define LOTTERY_FONT_B [UIFont boldSystemFontOfSize:13]

#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7

#define RADIUS 10//球半径

#define DRAW_WHITE [[UIColor whiteColor] setFill]//白色

#define DRAW_RED [[UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1] setFill]//红色
#define DRAW_YELLOW [[UIColor colorWithRed:255/255.0 green:200/255.0 blue:50/255.0 alpha:1] setFill]//黄色
#define DRAW_BLUE [[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1] setFill]//蓝色

#define DRAW_RED_LINE CGContextSetRGBStrokeColor(context, 255/255.0, 59/255.0, 48/255.0, 1.0)//红线
#define DRAW_YELLOW_LINE CGContextSetRGBStrokeColor(context, 255/255.0, 200/255.0, 50/255.0, 1.0)//黄线
#define DRAW_BLUE_LINE CGContextSetRGBStrokeColor(context, 19/255.0, 163/255.0, 255/255.0, 1.0)//蓝线

#define DRAW_GREEN [[UIColor colorWithRed:133/255.0 green:205/255.0 blue:105/255.0 alpha:1] setFill]//绿色
#define DRAW_BLACK [[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1] setFill]//浅黑
#define DRAW_YILOU [[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1] setFill]//遗漏
#define DRAW_PURPLE [[UIColor colorWithRed:204/255.0 green:16/255.0 blue:192/255.0 alpha:1] setFill]//紫色

#define DRAW_LOTTERY_GRAY [[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1] setFill]//开奖号灰色
#define DRAW_LOTTERY_K [[UIColor colorWithRed:125/255.0 green:232/255.0 blue:209/255.0 alpha:1] setFill]//快三开奖号


#define CHART_BG [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1]//走势图背景
#define CHART_BG_K [UIColor colorWithRed:31/255.0 green:118/255.0 blue:89/255.0 alpha:1]//走势图背景

#define DRAW_TITLEBG [[UIColor colorWithRed:170/255.0 green:164/255.0 blue:147/255.0 alpha:1] setFill];//顶部标题背景
#define DRAW_TITLEBG_K [[UIColor colorWithRed:25/255.0 green:127/255.0 blue:101/255.0 alpha:1] setFill];//顶部标题背景


#define DRAW_TITLEBG_L [[UIColor colorWithRed:236/255.0 green:232/255.0 blue:225/255.0 alpha:1] setFill];//期 开奖号 和值 背景
#define DRAW_TITLEBG_R [[UIColor colorWithRed:236/255.0 green:232/255.0 blue:225/255.0 alpha:1] setFill];//右侧数字背景

#define DRAW_TITLECOLOR [[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1] setFill];//期 开奖号 和值 数字
#define DRAW_TITLECOLOR_K [[UIColor colorWithRed:99/255.0 green:187/255.0 blue:166/255.0 alpha:1] setFill];//快三标题颜色

#define DRAW_ISSUE [[UIColor colorWithRed:211/255.0 green:185/255.0 blue:141/255.0 alpha:1] setFill]//期号颜色
#define DRAW_ISSUE_K [[UIColor colorWithRed:70/255.0 green:172/255.0 blue:149/255.0 alpha:1] setFill]//期号颜色


#define DRAW_ISSUE_NEW [[UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1] setFill]//最新一期颜色
#define DRAW_ISSUE_NEW_K [[UIColor colorWithRed:217/255.0 green:61/255.0 blue:53/255.0 alpha:1] setFill]//快三最新一期颜色


#define DRAW_LEFTBG_ODD_ISSUE [[UIColor colorWithRed:241/255.0 green:239/255.0 blue:227/255.0 alpha:1] setFill]//左侧期号奇数行颜色
#define DRAW_LEFTBG_EVEN_ISSUE [[UIColor colorWithRed:247/255.0 green:246/255.0 blue:237/255.0 alpha:1] setFill]//左侧期号偶数行颜色

#define DRAW_LEFTBG_ODD_ISSUE_K [[UIColor colorWithRed:6/255.0 green:80/255.0 blue:56/255.0 alpha:1] setFill]//快三左侧期号奇数行颜色
#define DRAW_LEFTBG_EVEN_ISSUE_K [[UIColor colorWithRed:7/255.0 green:87/255.0 blue:61/255.0 alpha:1] setFill]//快三左侧期号偶数行颜色

#define DRAW_LEFTBG_ODD [[UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1] setFill]//左侧奇数行颜色
#define DRAW_LEFTBG_EVEN [[UIColor whiteColor] setFill]//左侧偶数行颜色
#define DRAW_LEFTBG_ODD_K [[UIColor colorWithRed:7/255.0 green:95/255.0 blue:66/255.0 alpha:1] setFill]//快三左侧奇数行颜色
#define DRAW_LEFTBG_EVEN_K [[UIColor colorWithRed:8/255.0 green:104/255.0 blue:72/255.0 alpha:1] setFill]//快三左侧偶数行颜色

#define DRAW_RED_LINE_K CGContextSetRGBStrokeColor(context, 217/255.0, 61/255.0, 53/255.0, 1.0)//快三红线
#define DRAW_RED_BK [[UIColor colorWithRed:217/255.0 green:61/255.0 blue:53/255.0 alpha:1] setFill]//快三球红色
#define DRAW_RED_SK [[UIColor colorWithRed:217/255.0 green:61/255.0 blue:53/255.0 alpha:1] setFill]//快三方红色

#define DRAW_YELLOW_TK [[UIColor colorWithRed:255/255.0 green:200/255.0 blue:50/255.0 alpha:1] setFill]//快三字黄色
#define DRAW_YELLOW_BK [[UIColor colorWithRed:255/255.0 green:200/255.0 blue:50/255.0 alpha:1] setFill]//快三球黄色
#define DRAW_YELLOW_SK [[UIColor colorWithRed:255/255.0 green:200/255.0 blue:50/255.0 alpha:1] setFill]//快三方黄色

#define DRAW_BLUE_TK [[UIColor colorWithRed:41/255.0 green:137/255.0 blue:255/255.0 alpha:1] setFill]//快三字蓝色
#define DRAW_BLUE_BK [[UIColor colorWithRed:41/255.0 green:137/255.0 blue:255/255.0 alpha:1] setFill]//快三球蓝色
#define DRAW_BLUE_SK [[UIColor colorWithRed:41/255.0 green:137/255.0 blue:255/255.0 alpha:1] setFill]//快三方蓝色

#define DRAW_GREEN_SK [[UIColor colorWithRed:34/255.0 green:156/255.0 blue:53/255.0 alpha:1] setFill]//快三方绿色

#define DRAW_PURPLE_SK [[UIColor colorWithRed:196/255.0 green:34/255.0 blue:242/255.0 alpha:1] setFill]//快三方紫色


#define DRAW_BLACK_K(Alpha) [[UIColor colorWithRed:0 green:0 blue:0 alpha:Alpha] setFill]//快三黑色方格背景


#define DRAW_TITLEBG_LK [[UIColor colorWithRed:5/255.0 green:68/255.0 blue:49/255.0 alpha:1] setFill]//快三左侧标题背景
#define DRAW_TITLEBG_RK [[UIColor colorWithRed:6/255.0 green:80/255.0 blue:56/255.0 alpha:1] setFill]//快三右侧标题背景

#define DRAW_YILOU_BG [[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1] setFill];//背景遗漏值颜色
#define DRAW_YILOU_LAST [[UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1] setFill];//最后一行遗漏值颜色
#define DRAW_YILOU_LAST_K [[UIColor colorWithRed:125/255.0 green:232/255.0 blue:209/255.0 alpha:1] setFill];//最后一行遗漏值颜色

#define DRAW_YILOU_BK [[UIColor colorWithRed:164/255.0 green:196/255.0 blue:181/255.0 alpha:1] setFill];//快三背景上的遗漏值颜色

#define DRAW_LINE [[UIColor colorWithRed:135/255.0 green:176/255.0 blue:147/255.0 alpha:1] setFill]//快三分割线

#define NEW_PAGECONTROL_HEIGHT 4

#define DEFAULT_ISSUE_WIDTH 30.5//默认期宽度
#define DEFAULT_ISSUE_HEIGHT 37//默认期高度
#define DEFAULT_HEAD_HEIGHT DEFAULT_ISSUE_WIDTH + DEFAULT_ISSUE_HEIGHT + 1//默认走势图头部高度
#define DEFAULT_LOTTORY_WIDTH_ELEVEN 61//十一选五开奖号宽

#define DEFAULT_TOPVIEW_HEIGHT_SHUANG 40//双色球顶部选择部分的高度
#define DEFAULT_TOPVIEW_TEXT_COLOR [UIColor colorWithRed:114/255.0 green:114/255.0 blue:114/255.0 alpha:1]//双色球顶部字颜色
#define DEFAULT_TOPVIEW_TEXT_COLOR_1 [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1]//双色球顶部字选中颜色


#define TOPVIEW_HEIGHT 37//购彩页面顶部有开奖号显示部分的高度

#define REDRAW_FRAME(ChartFormatData) (ChartFormatData.linesHeight * ChartFormatData.allArray.count + 0.5 * (ChartFormatData.allArray.count - 1))//默认期高度

typedef enum {
    KuaiSanHeZhi,//快三和值
    KuaiSanErBu,//二不同号
    KuaiSanErTong,//二同号
    KuaiSanSanBu,//三不同号
    KuaiSanSanLian,//三连号
    KuaiSanSanTong,//三同号
    
    ElevenBasic,//十一选五基本
    ElevenDaXiao,//大小比
    ElevenJiOu,//奇偶比
    ElevenZhiHe,//和值
    ElevenQianOne,//第一位
    ElevenQianTwo,//第二位
    ElevenQianThree,//第三位
    
    LeTouQian,//大乐透红
    LeTouHou,//蓝
    LeTouData,//全部
    
    ShuangSeRed,//双色球红
    ShuangSeBlue,//蓝
    ShuangSeData,//全部
    
    threeDOne,//3d百位
    threeDTwo,//十位
    threeDThree,//个位
    threeDBasic,//基本
    threeDType,//数据、类型
    threeDDaXiaoJiOu,//大小比、奇偶比
    
    HappyTen,//快乐十分
    
}LotteryType;

typedef enum {
    RedCircle,//红球
    YellowCircle,//黄球
    BlueCircle,//蓝球
    TwoColorCircle,//两种不同颜色  双色球大乐透
    ThreeColorCircle,//三种不同颜色
    
    YellowSquare,//方
    RedSquare,//方
    BlueSquare,//方
    GreenSquare,//方
    PurpleSquare,
    
    BlueKSquare,//方
    PurpleKSquare,//方
    FourColorSquare,//方
    DifferentColorSquare,
    
    Nothing,
}DrawType;

typedef enum {
    NoLine,//没线
    RedLine,//红线
    YellowLine,//黄线
    BlueLine,//蓝线
}LineColor;

typedef enum {
    All  = 1,//全部显示遗漏
    Last = 2,//最后一行显示遗漏
    DifferentYiLou = 3,//有的显示有的不显示
}DisplayYiLou;//不传 没遗漏

typedef enum {
    NoColor,//黑色
    ThreeColor,//三种不同颜色
    WhiteColor,//白色
    FirstColor,//第一个变色
    SecondColor,//第二个变色
    ThirdColor,//第三个变色
    KuaiSanLottoryColor,//快三开奖号
}LottoryColor;

typedef enum {
    DisplayLeft,//和左边一起显示
    DisplayRight,//和右边一起显示
}LottoryDisplayType;

@interface ChartDefine : NSObject

@end
