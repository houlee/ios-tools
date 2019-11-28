//
//  HunTouCell.h
//  caibo
//
//  Created by houchenguang on 13-9-23.
//
//

#import <UIKit/UIKit.h>
#import "GC_BetData.h"
#import "CP_CanOpenCell.h"

@protocol HunTouCellDelegate <NSObject>
- (void)openCellHunTou:(CP_CanOpenCell *)cell;
- (void)xiDanReturn:(CP_CanOpenCell *)hunCell type:(NSInteger)type buttonType:(NSInteger)countType;//type 1 是展开 2是收起 3是无动作
- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan;
- (void)returncellrownumbifen:(NSIndexPath *)num CP_CanOpenCell:(CP_CanOpenCell *)hunCell;


@optional
- (void)returnCellContentOffsetString:(NSIndexPath *)index remove:(BOOL)yn;
- (void)duckImageCellHunTou:(CP_CanOpenCell *)cell;
@end

@interface HunTouCell : CP_CanOpenCell<UIScrollViewDelegate>{

    GC_BetData * pkbetdata;//数据接口
    
    UIImageView * headImage;
    UILabel * changhaola;//场号
    NSIndexPath * row;//第几行 第几列
     NSIndexPath * count;//存储第几个cell
    id<HunTouCellDelegate> delegate;
    UILabel * eventLabel;//德甲或德乙什么的
    UILabel * timeLabel;//时间
    UILabel * homeduiLabel;
    UILabel * keduiLabel;
//    UIButton * xiButton;//析胆按钮
    NSInteger xidancount;
    UIImageView * matchImage;
    BOOL wangqibool;//是否是往期
    BOOL dan;//是否设胆
    UIImageView * changhaoImage;
//     UIImageView * bgimagevv;
    NSInteger donghua;
    UIImageView * XIDANImageView;
    BOOL buttonBool;
    bool boldan;
    UILabel * bifenLabel;//彩果比分
    UIImageView * vsImage;//vs图片
    UIButton * zhegaiview;
    UILabel * butTitle;
    UILabel * datal1;
    UILabel * datal2;
    UILabel * datal3;
    UIImageView * duckImageOne;//鸭子图片 1
    UIImageView * duckImageTwo;//鸭子图片 2
    BOOL wangqiTwoBool;//真正的往期 为了区分之前的； 包含当前期的结束 
    UIImageView * duckImageThree;//鸭子图片 3
    UIImageView * seletChanghaoImage;
    NSMutableArray * typeButtonArray;
    UIImageView * onePluralImage;
    UIImageView * twoPluralImage;
}

@property (nonatomic, retain) GC_BetData * pkbetdata;//数据接口
@property (nonatomic, retain) NSIndexPath * count;//存储第几个cell
@property (nonatomic, retain) NSIndexPath * row;
@property (nonatomic, assign) id<HunTouCellDelegate> delegate;
@property (nonatomic, assign) BOOL wangqibool, dan,buttonBool, wangqiTwoBool;
@property (nonatomic, retain)UILabel * butTitle;
@property (nonatomic, retain)UIImageView * duckImageOne, * duckImageThree,* duckImageTwo, * XIDANImageView;
@property (nonatomic, retain)NSMutableArray *typeButtonArray;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier chaodan:(BOOL)chaobol;
- (UIView *)tableViewCellView;
- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan;
- (void)returncellrownumbifen:(NSIndexPath *)num CP_CanOpenCell:(CP_CanOpenCell *)hunCell;
@end
