//
//  BigHunTouCell.h
//  caibo
//
//  Created by houchenguang on 14-7-9.
//
//

#import <UIKit/UIKit.h>
#import "GC_BetData.h"
#import "GC_FootballMatch.h"
#import "CP_CanOpenCell.h"
#import "HTbasketballBoxView.h"
#import "BigHunTouBox.h"
#import "ScoreBallView.h"
@protocol BigHunTouDelegate <NSObject>
- (void)openCell:(CP_CanOpenCell *)cell;
- (void)returnCellContentOffsetString:(NSIndexPath *)index remove:(BOOL)yn;
- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan;
@end



@interface BigHunTouCell : CP_CanOpenCell<UIScrollViewDelegate, BHTbasketballDelegate, BigHunTouBoxDelegate, ScoreBallDelegate>{
    
    UILabel * eventLabel;//德甲或德乙什么的
    
    UILabel * timeLabel;//时间
    UILabel * teamLabel;//哪个队对哪个队
    UILabel * butLabel1;//第一个按钮上的小数字
    UILabel * butLabel2;//第二个按钮上的小数字
    UILabel * butLabel3;//第三个按钮上的小数字
    UILabel * butLabel4;//第三个按钮上的小数字
    UILabel * butLabel5;//第三个按钮上的小数字
    
    
    
    UIView * view;//返回给cell的值
    GC_BetData * pkbetdata;//数据接口
    
    NSIndexPath * count;//存储第几个cell
//    BOOL selection1;//判断第一个按钮是否被触发
//    BOOL selection2;//判断第二个按钮是否被触发
//    BOOL selection3;//判断第三个按钮是否被触发
    id<BigHunTouDelegate>delegate;
    UIButton * button1;
    UIButton * button2;
    UIButton * button3;
    UIButton * button4;
    UIButton * button5;
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
//    UILabel * rangqiulabel;
    BOOL panduan;//判断胆是否被选中
    //    UIImageView  * sjImageView;//升降图片
    //    UIImageView  * sjImageView2;
    //    UIImageView  * sjImageView3;
    NSInteger donghua;
    UILabel * changhaola;
    UIImageView * headimage;
    BOOL wangqibool;//是否是往期 如果yes的话 就是往期 默认不是往期
//    UIButton * zhegaiview;
    UIImageView * winImage1;
    UIImageView * winImage2;
    UIImageView * winImage3;
    UIImageView * vsImage;
    UIImageView * XIDANImageView;
    UIButton * xidanButton;
    UILabel * butTitle;
    UIImageView * changhaoImage;
    

    UILabel * bifenLabel;
    UIImageView * seletChanghaoImage;
     NSMutableArray * typeButtonArray;
    NSInteger hunType; // 1是篮球混投  2是足球混投
    HTbasketballBoxView * ballBox;
    ScoreBallView * scoreBall;
    
}
@property (nonatomic, assign)BOOL panduan, wangqibool;
@property (nonatomic, retain)UILabel * homeduiLabel,* keduiLabel,* rangqiulabel;
@property (nonatomic)BOOL dandan;
@property (nonatomic)BOOL nengyong;
@property (nonatomic)NSInteger cout, hunType;
@property (nonatomic, retain)GC_MatchInfo * matcinfo;
@property (nonatomic, retain)NSString * playid;

@property (nonatomic, retain)NSIndexPath * row;
@property (nonatomic, assign)id<BigHunTouDelegate>delegate;
@property (nonatomic, assign)NSIndexPath * count;
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
@property (nonatomic)BOOL  selection3;
@property (nonatomic)BOOL boldan;
@property (nonatomic, retain)UILabel * butTitle;
@property (nonatomic, retain)UIImageView * XIDANImageView;
@property (nonatomic, retain) NSMutableArray * typeButtonArray;

- (UIView *)tableViewCell;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)type chaodan:(BOOL)chaodan cellType:(NSInteger)typeCell;
@end