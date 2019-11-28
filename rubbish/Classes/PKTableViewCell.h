//
//  PKTableViewCell.h
//  caibo
//
//  Created by cp365dev6 on 15/1/19.
//
//

#import "CP_CanOpenCell.h"
#import "GC_BetData.h"
#import "GC_FootballMatch.h"
#import "GC_PKRaceList.h"

@protocol PK_NewTableCellDelegate <NSObject>
@optional
- (void)returnCellInfo:(NSInteger)index buttonBoll1:(BOOL)select1 buttonBoll:(BOOL)select2 buttonBoll:(BOOL)select3 dan:(BOOL)booldan;
@end

@interface PKTableViewCell : CP_CanOpenCell
{
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
    NSInteger count;//存储第几个cell
    BOOL selection1;//判断第一个按钮是否被触发
    BOOL selection2;//判断第二个按钮是否被触发
    BOOL selection3;//判断第三个按钮是否被触发
    id<PK_NewTableCellDelegate>delegate;
    UIButton * button1;
    UIButton * button2;
    UIButton * button3;
    NSInteger row;
    
    UIButton * xibutton;
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
    UILabel * changhaola;
    UIImageView * headimage;
    BOOL wangqibool;//是否是往期 如果yes的话 就是往期 默认不是往期
    UIButton * zhegaiview;
    UIImageView * winImage1;
    UIImageView * winImage2;
    UIImageView * winImage3;
    UIImageView * vsImage;
    BOOL danTuoBool;//胆拖的bool
}
@property (nonatomic, assign)BOOL panduan, wangqibool, isNewUser;
@property (nonatomic, retain)UILabel * homeduiLabel,* keduiLabel;
@property (nonatomic)NSInteger row;
@property (nonatomic, assign)id<PK_NewTableCellDelegate>delegate;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, retain)UIView * view;
@property (nonatomic, retain)UILabel * eventLabel;

@property (nonatomic, retain)UILabel * timeLabel;

@property (nonatomic, retain)UILabel * butLabel1;
@property (nonatomic, retain)UILabel * butLabel2;
@property (nonatomic, retain)UILabel * butLabel3;
@property (nonatomic, retain)GC_BetData * pkbetdata;
@property (nonatomic)BOOL  selection1;
@property (nonatomic)BOOL  selection2;
@property (nonatomic)BOOL  selection3;
@property (nonatomic)BOOL dandan;
@property (nonatomic)BOOL nengyong;
@property (nonatomic)NSInteger cout;
- (UIView *)tableViewCell;
- (void)returnCellInfo:(NSInteger)index buttonBoll1:(BOOL)select1 buttonBoll:(BOOL)select2 buttonBoll:(BOOL)select3 dan:(BOOL)booldan;
- (void)hidenXieBtn;

@end
