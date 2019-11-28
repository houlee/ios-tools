//
//  BDScoreCell.h
//  caibo
//
//  Created by houchenguang on 14-3-6.
//
//

#import <UIKit/UIKit.h>
#import "CP_CanOpenCell.h"
#import "GC_BetData.h"
#import "BallBoxView.h"
#import "ScoreBallView.h"

@protocol BDScoreCellDelegate <NSObject>
- (void)openCell:(CP_CanOpenCell *)cell;
- (void)returnCellContentOffsetString:(NSIndexPath *)index remove:(BOOL)yn;
- (void)returnbifenCellInfo:(NSIndexPath *)index shuzu:(NSMutableArray *)bufshuzu dan:(BOOL)booldan;
@end


@interface BDScoreCell : CP_CanOpenCell<UIScrollViewDelegate, BallBoxViewDelegate, ScoreBallDelegate>{
    
//    UIButton * zhegaiview;
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
    id<BDScoreCellDelegate> delegate;
    NSIndexPath * row;
    NSMutableArray * typeButtonArray;
    BOOL boldan;
    UIImageView * seletChanghaoImage;
    BallBoxView * ballBox;
    UILabel * showScore;
    UIImageView * moreImage;
    BOOL jcbool;
    ScoreBallView * scoreBall;
    UIImageView * onePluralImage;
    BOOL danguanbool;
}
@property (nonatomic, assign)BOOL panduan, wangqibool, jcbool, danguanbool;
@property (nonatomic, retain)UILabel * butTitle;
@property (nonatomic, retain)GC_BetData * betData;
@property (nonatomic, assign)id<BDScoreCellDelegate>delegate;
@property (nonatomic, retain)NSIndexPath * row;
@property (nonatomic, retain)UIImageView * XIDANImageView;
@property (nonatomic, retain)NSMutableArray *typeButtonArray;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)type chaodan:(BOOL)chaodan;
@end
