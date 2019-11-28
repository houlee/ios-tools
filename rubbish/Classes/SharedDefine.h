//
//  SharedDefine.h
//  caibo
//
//  Created by GongHe on 14-10-23.
//
//

#import <Foundation/Foundation.h>

#define ORIGIN_X(view) (view.frame.origin.x + view.frame.size.width)
#define ORIGIN_Y(view) (view.frame.origin.y + view.frame.size.height)

#define YILOU_NORMALCOLOR [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1]
#define YILOU_MAXCOLOR [UIColor redColor]

//彩种id
#define LOTTERY_ID_NEIMENG @"012"//内蒙古快三
#define LOTTERY_ID_JIANGSU @"013"//江苏快三
#define LOTTERY_ID_HUBEI @"019"//湖北快三
#define LOTTERY_ID_JILIN @"018"//吉林快三
#define LOTTERY_ID_ANHUI @"020"//安徽快三

#define LOTTERY_ID_JIANGXI_11 @"107"//江西11选5
#define LOTTERY_ID_SHANDONG_11 @"119"//山东11选5
#define LOTTERY_ID_GUANGDONG_11 @"121"//广东11选5
#define LOTTERY_ID_HEBEI_11 @"123"//河北11选5
#define LOTTERY_ID_SHANXI_11 @"124"//陕西11选5

#define Lottery_Name_Horse @"11选5赛马场"

//数字彩

#define SANJIAO_DURATION 0.3 //购彩上边三角转动时间

#define SWITCH_ON [[[NSUserDefaults standardUserDefaults] objectForKey:@"YiLouSwitch"] isEqualToString:@"1"]  //判断遗漏值是否显示 1为显示

#define BETSVIEW_TITLE_FONT [UIFont systemFontOfSize:14] //标题大小
#define BETSVIEW_TITLE_COLOR [UIColor whiteColor]       //标题颜色

#define BETSVIEW_TITLE_IMAGENAME_RED @"LeftTitleRed.png"        //红色标题图片
#define BETSVIEW_TITLE_IMAGENAME_BLUE @"LeftTitleRed.png"        //蓝色标题图片


#define BETSVIEW_DESCRIPTION_FONT [UIFont systemFontOfSize:12] //描述大小
#define BETSVIEW_DESCRIPTION_COLOR [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0] //描述颜色

#define BETSVIEW_BALLVIEW_WIDTH 35 //号码按钮宽
#define BETSVIEW_BALLVIEW_X 14 //号码按钮距离左端长度
#define BETSVIEW_BALLVIEW_Y 35 //号码按钮距离顶端长度

#define BETSVIEW_BALLVIEW_SPACE(columns) ((self.frame.size.width - BETSVIEW_BALLVIEW_X * 2 - columns * BETSVIEW_BALLVIEW_WIDTH)/(columns - 1)) //号码按钮间距（列数）

#define BETSVIEW_BALLVIEW_SPACE_HIDDEN 5 //号码按钮隐藏遗漏值时得间距


typedef enum {
    betsView_titleImageTag = 101,//标题图片
    betsView_titleLabelTag = 100,//标题
    betsView_descriptionLabelTag = 110,//描述
    betsView_yiLouImageTag = 111,//遗漏值图片
    betsView_louLabelTag = 112,//遗漏文字
    TrashCanTag = 333,//垃圾桶
    
    weiBo_GuangChang_ZhengWenTag = 1001,
    weiBo_GuangChang_YuanTieTag = 1011,
    weiBo_GuangChang_YuanTieButtonTag = 1012,
    weiBo_GuangChang_YuanTieFAXQTag = 1013,
}SpecialTag;


//////微博
#define WEIBO_BG_COLOR [SharedMethod getColorByHexString:@"f2f2f2"] //微博广场顶上6个

#define WEIBO_GUANGCHANG_TOPNEWS_HEIGHT 45 //微博广场顶上6个

#define WEIBO_CELL_SPACE 10 //cell顶上的间距

#define WEIBO_LINESPACE 5 //微博每部分间距

#define WEIBO_USERIMAGE_X 12//用户头像起始x
#define WEIBO_USERIMAGE_WIDTH 40//用户头像宽
#define WEIBO_USERIMAGE_FRAME CGRectMake(WEIBO_USERIMAGE_X, WEIBO_CELL_SPACE + 12, WEIBO_USERIMAGE_WIDTH, WEIBO_USERIMAGE_WIDTH)    //用户头像大小

#define WEIBO_USERNAME_X WEIBO_USERIMAGE_X + WEIBO_USERIMAGE_WIDTH + 15 //用户名 起始X
#define WEIBO_USERNAME_Y 15 //用户名 起始Y
#define WEIBO_USERNAME_HEIGHT 21 //用户名 高度
#define WEIBO_USERNAME_FONT [UIFont boldSystemFontOfSize:15]//用户名字体
#define WEIBO_DRAW_USERNAME [[UIColor blackColor] set] //用户名颜色


#define WEIBO_TIME_FONT [UIFont systemFontOfSize:10] //微博更新时间 字体大小
#define WEIBO_TIME_Y WEIBO_USERNAME_Y + WEIBO_USERNAME_HEIGHT + WEIBO_LINESPACE //微博更新时间 起始Y
#define WEIBO_TIME_HEIGHT 20 //微博更新时间 高度
#define WEIBO_TIME_COLOR [[UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:2] set]//微博更新颜色

#define WEIBO_ZHENGWEN_X WEIBO_USERIMAGE_X //微博正文 起始X
#define WEIBO_ZHENGWEN_Y WEIBO_TIME_Y + WEIBO_TIME_HEIGHT + WEIBO_LINESPACE//微博正文 起始Y
#define WEIBO_ZHENGWEN_WIDTH 320 - WEIBO_ZHENGWEN_X * 2 //微博正文 宽
#define WEIBO_ZHENGWEN_FONT [UIFont systemFontOfSize:14] //微博正文字体大小

#define WEIBO_YUANTIE_TOP 10 //微博原帖内容距离原帖背景顶端的距离
#define WEIBO_YUANTIE_BGCOLOR [SharedMethod getColorByHexString:@"f2f2f2"] //微博原帖背景颜色

#define WEIBO_IMAGE_MAX 157 //微博图片最大值

#define WEIBO_ZHUANFA_COLOR [[SharedMethod getColorByHexString:@"929292"] set] //微博转发颜色
#define WEIBO_ZHUANFA_FONT [UIFont systemFontOfSize:15] //微博转发字体

#define WEIBO_BOTTOMBUTTON_HEIGHT 40 //微博底部按钮高度
#define WEIBO_BOTTOMBUTTON_WIDTH 107 //微博底部按钮高度

#define WEIBO_YUCE_CELL_HEIGHT 90 //微博 预测 cell高度
#define WEIBO_YUCE_CELL_HEIGHT_1 63 //微博 预测 双色球 大乐透 3d cell高度


@interface SharedDefine : NSObject

@end
