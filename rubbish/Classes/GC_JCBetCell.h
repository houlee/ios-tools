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


@protocol GCJCCellDelegate <NSObject>

- (void)openCell:(CP_CanOpenCell *)cell;

- (void)returnCellInfo:(NSIndexPath *)index buttonBoll1:(BOOL)select1 buttonBoll:(BOOL)select2 buttonBoll:(BOOL)select3 dan:(BOOL)booldan;
- (void)returncellrownum:(NSIndexPath *)num cell:(CP_CanOpenCell *)cell;
@optional
- (void)returnCellContentOffsetString:(NSIndexPath *)index remove:(BOOL)yn;
- (void)duckImageCell:(CP_CanOpenCell *)cell;

- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan;
- (void)returncellrownumbifen:(NSIndexPath *)num CP_CanOpenCell:(CP_CanOpenCell *)hunCell;

- (void)pressWorldCupLogoDelegate;
@end

typedef enum {
    matchEnumShengFuCell,
    matchEnumRangFenShengFucell,
    matchEnumDaXiaoFenCell,
    matchEnumQiTaCell
    
}MatchLanQiuCell;



@interface GC_JCBetCell : CP_CanOpenCell<UIScrollViewDelegate>{
    UILabel * vslabel;
    UILabel * eventLabel;//德甲或德乙什么的
  
    UILabel * timeLabel;//时间

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
    id<GCJCCellDelegate>delegate;
    UIButton * button1;
    UIButton * button2;
    UIButton * button3;
    NSIndexPath * row;
   
//    UIImageView * buttonImage;//button按钮图片
//    UIImageView * buttonImage2;//button按钮图片
//    UIImageView * buttonImage3;//button按钮图片
//
  
  
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
    UILabel * changhaola;
    BOOL danguanbool;
    MatchLanQiuCell lanqiucell;
    BOOL chaobool;
    
    UIImageView * headimage;
    UILabel * lanqiurangfen;
    BOOL wangqibool;//是否是往期 如果yes的话 就是往期 默认不是往期
    UIButton * zhegaiview;
    UIImageView * winImage1;
    UIImageView * winImage2;
    UIImageView * winImage3;
    UIImageView * vsImage;
    UILabel * sfclqRangFenLabel;
    NSString * typeCell;//cell的风格
    BOOL buttonBool;//是否是按钮点击 如果是则执行动画
    UIImageView * changhaoImage;
    UIImageView * XIDANImageView;
    UIButton * xidanButton;
    UILabel * bifenLabel;
    UILabel * butTitle;//按钮上的 析 胆  字
    NSInteger jiluX;//记录x轴的位置
    UIImageView * duckImageOne;//鸭子图片 1
    UIImageView * duckImageTwo;//鸭子图片 2
    UIImageView * duckImageThree;//鸭子图片 3
    BOOL wangqiTwoBool;//真正的往期 为了区分之前的； 包含当前期的结束

    
    UIImageView * yearImageView;//年 图片
    UIImageView * homeBannerImageView;//主队国旗
    UIImageView * guestBannerImageView;//客队国旗
    UIButton * worldCupLogo;//世界杯 logo
    UIImageView * seletChanghaoImage;
    UILabel * teamLabel;
    UIImageView * onePluralImage;
    BOOL hhChaBool;//胜平负混合过关标志；
    NSMutableArray * typeButtonArray;
}
@property (nonatomic, retain) UIImageView * duckImageOne, * duckImageTwo, * duckImageThree, * XIDANImageView;
@property (nonatomic, assign)BOOL panduan, wangqibool;
@property (nonatomic, retain)UILabel * homeduiLabel,* keduiLabel,* rangqiulabel;
@property (nonatomic)BOOL dandan, buttonBool;
@property (nonatomic)BOOL nengyong, wangqiTwoBool;
@property (nonatomic)NSInteger cout;
@property (nonatomic, retain)GC_MatchInfo * matcinfo;
@property (nonatomic, retain)NSString * playid, * typeCell;

@property (nonatomic, retain)NSIndexPath * row;
@property (nonatomic, assign)id<GCJCCellDelegate>delegate;
@property (nonatomic, retain)NSIndexPath * count;
@property (nonatomic, retain)UIView * view;
@property (nonatomic, retain)UILabel * eventLabel,  * butTitle;

@property (nonatomic, retain)UILabel * timeLabel;

@property (nonatomic, retain)UILabel * butLabel1;
@property (nonatomic, retain)UILabel * butLabel2;
@property (nonatomic, retain)UILabel * butLabel3;
@property (nonatomic, retain)GC_BetData * pkbetdata;
@property (nonatomic)BOOL  selection1;
@property (nonatomic)BOOL  selection2;
@property (nonatomic)BOOL  selection3, hhChaBool;
@property (nonatomic)BOOL boldan, danguanbool;
@property (nonatomic, assign)MatchLanQiuCell lanqiucell;
@property (nonatomic)NSInteger donghua;

@property (nonatomic, retain)NSMutableArray * typeButtonArray;


- (UIView *)tableViewCell;
- (void)returncellrownum:(NSIndexPath *)num cell:(CP_CanOpenCell *)cell;
- (void)returnCellInfo:(NSIndexPath *)index buttonBoll1:(BOOL)select1 buttonBoll:(BOOL)select2 buttonBoll:(BOOL)select3 dan:(BOOL)booldan;
- (void)returnBoolDan:(BOOL)danbool row:(NSIndexPath *)num;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier matchLanQiu:(MatchLanQiuCell)lanqiu caodan:(BOOL)caobool;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier matchLanQiu:(MatchLanQiuCell)lanqiu caodan:(BOOL)caobool cellType:(NSString *)type;

@end

