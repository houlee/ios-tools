//
//  PKBetCell.h
//  PKDome
//
//  Created by  on 12-4-16.
//  Copyright (c) 2012年 vodone. All rights reserved.
//
//pk投注cell
#import <UIKit/UIKit.h>
#import "GC_BetData.h"
#import "GC_FootballMatch.h"
#import "CP_CanOpenCell.h"

@protocol PKBetCellDelegate <NSObject>
@optional
- (void)openCell:(CP_CanOpenCell *)cell;
- (void)returnCellInfo:(NSInteger)index buttonBoll1:(BOOL)select1 buttonBoll:(BOOL)select2 buttonBoll:(BOOL)select3 dan:(BOOL)booldan;
- (void)returncellrownum:(NSInteger)num;
- (void)returnBoolDan:(BOOL)danbool row:(NSInteger)num;
- (void)returnCellContentOffsetString:(NSIndexPath *)index remove:(BOOL)yn;
@end

@interface GC_BetCell : CP_CanOpenCell<UIScrollViewDelegate>{
    
    UILabel * eventLabel;//德甲或德乙什么的

    UILabel * timeLabel;//时间
  
    UILabel * butLabel1;//第一个按钮上的小数字
    UILabel * butLabel2;//第二个按钮上的小数字
    UILabel * butLabel3;//第三个按钮上的小数字
    UIView * view;//返回给cell的值
    GC_BetData * pkbetdata;//数据接口
//    UILabel * datal1;//button上显示3
//    UILabel * datal2;//button上显示1
//    UILabel * datal3;//button上显示0
    NSInteger count;//存储第几个cell
    BOOL selection1;//判断第一个按钮是否被触发
    BOOL selection2;//判断第二个按钮是否被触发
    BOOL selection3;//判断第三个按钮是否被触发
    id<PKBetCellDelegate>delegate;
    UIButton * button1;
    UIButton * button2;
    UIButton * button3;
    NSInteger row;
    UILabel * bifenLabel;

    UIButton * xibutton;
    NSString * playid;
    GC_MatchInfo * matcinfo;
    UIImageView * bgimagevv;
    UILabel * xizi;
    UILabel * homeduiLabel;
    UILabel * keduiLabel;

    NSInteger donghua;
    UIButton * dan;
    UIImageView * danimge;
    UILabel * danzi;
    BOOL boldan;
    BOOL dbool;
    BOOL nengyong;
    BOOL dandan;//胆
    NSInteger cout;
    BOOL panduan;//判断胆是否被选中
    BOOL renjiubool;
    UILabel * changhaola;
    UIImageView * headimage;
    BOOL wangqibool;//是否是往期 如果yes的话 就是往期 默认不是往期
    UIButton * zhegaiview;
    UIImageView * winImage1;
    UIImageView * winImage2;
    UIImageView * winImage3;
    UIImageView * vsImage;
    BOOL danTuoBool;//胆拖的bool
    UIImageView * XIDANImageView;
    UILabel * teamLabel;
    UIButton * xidanButton;
    UILabel * butTitle;
    UIImageView * changhaoImage;
    UIImageView * seletChanghaoImage;
}
@property (nonatomic, assign)BOOL panduan, renjiubool, wangqibool;
@property (nonatomic, retain)UILabel * homeduiLabel,* keduiLabel;
@property (nonatomic, retain)GC_MatchInfo * matcinfo;
@property (nonatomic, retain)NSString * playid;
@property (nonatomic)NSInteger row;
@property (nonatomic, assign)id<PKBetCellDelegate>delegate;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, retain)UIView * view;
@property (nonatomic, retain)UILabel * eventLabel;

@property (nonatomic, retain)UILabel * timeLabel;

@property (nonatomic, retain)UILabel * butLabel1;
@property (nonatomic, retain)UILabel * butLabel2;
@property (nonatomic, retain)UILabel * butLabel3, * butTitle;
@property (nonatomic, retain)GC_BetData * pkbetdata;
@property (nonatomic)BOOL  selection1;
@property (nonatomic)BOOL  selection2;
@property (nonatomic)BOOL  selection3;
@property (nonatomic)BOOL dandan;
@property (nonatomic)BOOL nengyong;
@property (nonatomic)NSInteger cout;
@property (nonatomic, retain)UIImageView * XIDANImageView;
@property (nonatomic)BOOL boldan, danTuoBool;
- (UIView *)tableViewCell;
- (void)returncellrownum:(NSInteger)num;
- (void)returnBoolDan:(BOOL)danbool row:(NSInteger)num;
- (void)returnCellInfo:(NSInteger)index buttonBoll1:(BOOL)select1 buttonBoll:(BOOL)select2 buttonBoll:(BOOL)select3 dan:(BOOL)booldan;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)type chaodan:(BOOL)chaodan;
- (void)hidenXieBtn;
@end
