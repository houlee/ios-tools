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
#import "CP_UIAlertView.h"

typedef enum {
    matchEnumBiFenGuoguanCell,
    matchEnumZongJinQiuCell,
    matchEnumBanQuanChangCell,
    matchEnumBiFenDanGuanCell,
    matchEnumZongJinQiuDanGuanCell,
    matchEnumBanQuanChangDanGuanCell,
    matchEnumShengFenChaDanDuanCell,
    matchEnumShengFenChaGuoGuanCell,
    matchEnumHunTouGuoGuanCell,
    matchEnumLanqiuHunTouCell,
}MatchEnumCell;


@protocol GC_BiFenCellDelegate <NSObject>
- (void)openCellbifen:(CP_CanOpenCell *)cell;
- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan;
- (void)returncellrownumbifen:(NSIndexPath *)num;
//- (void)returnBoolDanbifen:(BOOL)danbool row:(NSIndexPath *)num;
@end

@interface GC_BiFenCell : CP_CanOpenCell<CP_UIAlertViewDelegate>{
    
    UILabel * eventLabel;//德甲或德乙什么的

    UILabel * timeLabel;//时间
    UILabel * teamLabel;//哪个队对哪个队
    UILabel * butLabel1;//第一个按钮上的小数字
    UILabel * butLabel2;//第二个按钮上的小数字
    UILabel * butLabel3;//第三个按钮上的小数字
    UIView * view;//返回给cell的值
    GC_BetData * pkbetdata;//数据接口
    UILabel * datal1;//button上显示3
    UILabel * datal2;//button上显示1
    UILabel * datal3;//button上显示0
    NSIndexPath * count;//存储第几个cell
    BOOL selection1;//判断第一个按钮是否被触发
    BOOL selection2;//判断第二个按钮是否被触发
    BOOL selection3;//判断第三个按钮是否被触发
    id<GC_BiFenCellDelegate>delegate;
    UIButton * button1;
    UIButton * button2;
    UIButton * button3;
    NSIndexPath * row;
   
    UIImageView * buttonImage;//button按钮图片
    UIImageView * buttonImage2;//button按钮图片
    UIImageView * buttonImage3;//button按钮图片


    UIButton * xibutton;
    NSString * playid;
    GC_MatchInfo * matcinfo;
    UIImageView * bgimagevv;
    UILabel * xizi;
    UIButton * dan;
    UIImageView * danimge;
    UILabel * danzi;
    BOOL boldan;
    BOOL boldan2;
    BOOL boldan3;
    NSInteger cout;
    BOOL dbool;
    BOOL nengyong;
    BOOL dandan;//胆
    
    UILabel * homeduiLabel;
    UILabel * keduiLabel;
    UILabel * rangqiulabel;
    BOOL panduan;//判断胆是否被选中
    NSInteger donghua;
    NSTimer * opentimer;
    UIButton * bifenbutton;
    UIView * bgview;
    
    int buffer[31];
    UILabel * bifenlabel;
    BOOL chaodanbool;
    UILabel * changhaola;
    MatchEnumCell matchenumcell;
    BOOL chaobool;//判断是否是单关抄单
     UIImageView * headimage;
    BOOL wangqibool;//是否是往期 如果yes的话 就是往期 默认不是往期
    UIButton * zhegaiview;
    UIImageView * jiantou ;
    UIImageView * vsImage;
    UIImageView *infoImageView;
    NSInteger saveButtonTag;//保存点击要切换的button的tag值
    UIButton * xidanButton;//析胆按钮
    UIImageView * cgbgImage;//选中彩果背景图
}
@property (nonatomic, assign)BOOL wangqibool;
@property (nonatomic, retain)UIButton * xibutton;
@property (nonatomic, assign)MatchEnumCell matchenumcell;
@property (nonatomic, assign)id<GC_BiFenCellDelegate>delegate;
@property (nonatomic, assign)BOOL panduan;
@property (nonatomic, retain)UILabel * homeduiLabel,* keduiLabel,* rangqiulabel;
@property (nonatomic)BOOL dandan;
@property (nonatomic)BOOL nengyong;
@property (nonatomic)NSInteger cout;
@property (nonatomic, retain)GC_MatchInfo * matcinfo;
@property (nonatomic, retain)NSString * playid;

@property (nonatomic, retain)NSIndexPath * row;

@property (nonatomic, retain)NSIndexPath * count;
@property (nonatomic, retain)UIView * view;
@property (nonatomic, retain)UILabel * eventLabel;

@property (nonatomic, retain)UILabel * timeLabel;
@property (nonatomic, retain)UILabel * teamLabel;
@property (nonatomic, retain)UILabel * butLabel1;
@property (nonatomic, retain)UILabel * butLabel2;
@property (nonatomic, retain)UILabel * butLabel3;
@property (nonatomic, retain)GC_BetData * pkbetdata;
@property (nonatomic)BOOL  selection1;
@property (nonatomic)BOOL  selection2;
@property (nonatomic)BOOL  selection3, chaodanbool;
@property (nonatomic)BOOL boldan;
@property (nonatomic)NSInteger donghua;

- (UIView *)tableViewCell;
- (void)returncellrownumbifen:(NSIndexPath *)num;
- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan;
- (void)returnBoolDanbifen:(BOOL)danbool row:(NSIndexPath *)num;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier chaodan:(BOOL)chaobol;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier chaodan:(BOOL)chaobol matchenumType:(MatchEnumCell)type;
@end
