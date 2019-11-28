//
//  OneDoubleCell.h
//  caibo
//
//  Created by houchenguang on 14-3-6.
//
//

#import <UIKit/UIKit.h>
#import "CP_CanOpenCell.h"
#import "GC_BetData.h"

@protocol OneDoubleCellDelegate <NSObject>
- (void)openCell:(CP_CanOpenCell *)cell;
- (void)returnCellContentOffsetString:(NSIndexPath *)index remove:(BOOL)yn;
- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan;
@end


@interface OneDoubleCell : CP_CanOpenCell<UIScrollViewDelegate>{
    UIButton * zhegaiview;
    BOOL panduan;//判断胆是否被选中
    BOOL wangqibool;//是否是往期 如果yes的话 就是往期 默认不是往期
    UIView * view;
    UIImageView * headimage;
    UILabel * changhaola;
    UILabel * eventLabel;
    UILabel * timeLabel;
    UILabel * homeduiLabel;
    UILabel * rangqiulabel;
    UIImageView * vsImage;
    UILabel * keduiLabel;
    UIImageView * changhaoImage;
    UILabel * bifenLabel;
    UIImageView* XIDANImageView;
    UILabel * butTitle;
    GC_BetData * betData;
    id<OneDoubleCellDelegate> delegate;
    NSIndexPath * row;
    NSMutableArray * typeButtonArray;
    bool boldan;
    UIImageView * seletChanghaoImage;
}
@property (nonatomic, assign)BOOL panduan, wangqibool;
@property (nonatomic, retain)UILabel * butTitle;
@property (nonatomic, retain)GC_BetData * betData;
@property (nonatomic, assign)id<OneDoubleCellDelegate>delegate;
@property (nonatomic, retain)NSIndexPath * row;
@property (nonatomic, retain)UIImageView * XIDANImageView;
@property (nonatomic, retain)NSMutableArray *typeButtonArray;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)type chaodan:(BOOL)chaodan;
@end
