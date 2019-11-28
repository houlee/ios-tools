//
//  JJYHTouCell.h
//  caibo
//
//  Created by yaofuyu on 13-7-11.
//
//

#import <UIKit/UIKit.h>
#import "JiangJinYouHuaJX.h"
#import "ColorView.h"
#import "GC_ShengfuInfoViewController.h"

@interface JJYHTouCell : UITableViewCell
{
    UILabel * eventLabel;//德甲或德乙什么的
    
    UILabel * timeLabel;//时间
    
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    UIButton *btn5;
    UIButton *btn6;
    
    UILabel * butLabel1;//第一个按钮上的小数字
    UILabel * butLabel2;//第二个按钮上的小数字
    UILabel * butLabel3;//第三个按钮上的小数字
    UILabel * butLabel4;//第一个按钮上的小数字
    UILabel * butLabel5;//第二个按钮上的小数字
    UILabel * butLabel6;//第三个按钮上的小数字
    UIImageView * view;//返回给cell的值
    GC_YHTouInfo * pkbetdata;//数据接口
    UILabel * datal1;//button上显示3
    UILabel * datal2;//button上显示1
    UILabel * datal3;//button上显示0
    NSInteger count;//存储第几个cell
    UIImageView * headimage;
    UILabel * homeduiLabel;
    UILabel * keduiLabel;
    UILabel * changhaola;
    
    UILabel *rangLabel;
    
    UIImageView *xiaImageV;
    Caifenzhong caizhong;
    UIImageView * chImage;
    BOOL zhuihouBool;
}

@property (nonatomic, assign)NSInteger count;
@property (nonatomic)Caifenzhong caizhong;
@property (nonatomic,retain)GC_YHTouInfo * pkbetdata;
@property (nonatomic, assign)BOOL zhuihouBool;
@end
