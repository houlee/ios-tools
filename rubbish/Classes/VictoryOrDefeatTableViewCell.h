//
//  VictoryOrDefeatTableViewCell.h
//  caibo
//
//  Created by houchenguang on 14-5-7.
//
//

#import <UIKit/UIKit.h>
#import "GC_BetData.h"
#import "GC_FootballMatch.h"
#import "CP_CanOpenCell.h"

@protocol VictoryOrDefeatDelegate <NSObject>
- (void)openCell:(CP_CanOpenCell *)cell;
- (void)returnCellInfo:(NSIndexPath *)index buttonBoll1:(BOOL)select1 buttonBoll:(BOOL)select2 buttonBoll:(BOOL)select3 dan:(BOOL)booldan;
- (void)returncellrownum:(NSIndexPath *)num;
- (void)returnCellContentOffsetString:(NSIndexPath *)index remove:(BOOL)yn;
//- (void)returnBoolDan:(BOOL)danbool row:(NSIndexPath *)num;
@end
@interface VictoryOrDefeatTableViewCell : CP_CanOpenCell<UIScrollViewDelegate>{
    UILabel * eventLabel;//德甲或德乙什么的
    
    UILabel * timeLabel;//时间
    UILabel * teamLabel;//哪个队对哪个队
    UILabel * butLabel1;//第一个按钮上的小数字
    UILabel * butLabel2;//第二个按钮上的小数字
//    UILabel * butLabel3;//第三个按钮上的小数字
    UIView * view;//返回给cell的值
    GC_BetData * pkbetdata;//数据接口
    
    NSIndexPath * count;//存储第几个cell
    BOOL selection1;//判断第一个按钮是否被触发
    BOOL selection2;//判断第二个按钮是否被触发
    BOOL selection3;//判断第三个按钮是否被触发
    id<VictoryOrDefeatDelegate>delegate;
    UIButton * button1;
    UIButton * button2;
//    UIButton * button3;
    NSIndexPath * row;
    //    UIButton * xibutton;
    NSString * playid;
    GC_MatchInfo * matcinfo;
    //    UIImageView * bgimagevv;
    //    UILabel * xizi;
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
    //    UIImageView  * sjImageView;//升降图片
    //    UIImageView  * sjImageView2;
    //    UIImageView  * sjImageView3;
    NSInteger donghua;
    UILabel * changhaola;
    UIImageView * headimage;
    BOOL wangqibool;//是否是往期 如果yes的话 就是往期 默认不是往期
    UIButton * zhegaiview;
    UIImageView * winImage1;
    UIImageView * winImage2;
//    UIImageView * winImage3;
    UIImageView * vsImage;
    UIImageView * XIDANImageView;
    UIButton * xidanButton;
    UILabel * butTitle;
    UIImageView * changhaoImage;
    
//    UILabel * datal1;
//    UILabel * datal2;
//    UILabel * datal3;
    UIImageView * datalImage1;
    UIImageView * datalImage2;
    
    UILabel * bifenLabel;
    UIImageView * seletChanghaoImage;
    UIImageView * matchLogoImage;
}
@property (nonatomic, assign)BOOL panduan, wangqibool;
@property (nonatomic, retain)UILabel * homeduiLabel,* keduiLabel,* rangqiulabel;
@property (nonatomic)BOOL dandan;
@property (nonatomic)BOOL nengyong;
@property (nonatomic)NSInteger cout;
@property (nonatomic, retain)GC_MatchInfo * matcinfo;
@property (nonatomic, retain)NSString * playid;

@property (nonatomic, retain)NSIndexPath * row;
@property (nonatomic, assign)id<VictoryOrDefeatDelegate>delegate;
@property (nonatomic, assign)NSIndexPath * count;
@property (nonatomic, retain)UIView * view;
@property (nonatomic, retain)UILabel * eventLabel;

@property (nonatomic, retain)UILabel * timeLabel;
@property (nonatomic, retain)UILabel * teamLabel;
@property (nonatomic, retain)UILabel * butLabel1;
@property (nonatomic, retain)UILabel * butLabel2;
//@property (nonatomic, retain)UILabel * butLabel3;
@property (nonatomic, retain)GC_BetData * pkbetdata;
@property (nonatomic)BOOL  selection1;
@property (nonatomic)BOOL  selection2;
@property (nonatomic)BOOL  selection3;
@property (nonatomic)BOOL boldan;
@property (nonatomic, retain)UILabel * butTitle;
@property (nonatomic, retain)UIImageView * XIDANImageView;
- (UIView *)tableViewCell;
- (void)returncellrownum:(NSIndexPath *)num;
- (void)returnCellInfo:(NSIndexPath *)index buttonBoll1:(BOOL)select1 buttonBoll:(BOOL)select2 buttonBoll:(BOOL)select3 dan:(BOOL)booldan;
- (void)returnBoolDan:(BOOL)danbool row:(NSIndexPath *)num;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)type chaodan:(BOOL)chaodan;
@end