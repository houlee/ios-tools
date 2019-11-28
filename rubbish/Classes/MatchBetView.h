//
//  MatchBetView.h
//  caibo
//
//  Created by houchenguang on 14-5-20.
//
//

#import <UIKit/UIKit.h>
#import "GC_BetData.h"
#import "BFYCBoxView.h"
typedef enum{

    jcHunheguoguanType,
    jcShengpingfuType,
    jcZongjinqiuType,
    jcBanchangshengpingfuType,
    jcBifenType,
    jcHunheerxuanyiType,
    sfcshengpingfuType,
    
    bdRangqiushengpingfuType,
    bdJinqiushuType,
    bdShangxiadanshuangType,
    bdBifenType,
    bdBanquanchangType,
    bdShengfuguoguanType,
    
    zhonglichangType,
    jiaohuanType,
    jieqiType,
    
} MatchButtonType;

@protocol MatchBetViewDelegate <NSObject>
@optional
- (void)matchBetViewButtonTag:(NSInteger)tag;//1是分析中心 2是赔率中心
- (void)matchAlertButton;
- (void)matchBetViewWithBetData:(GC_BetData *)_betData withType:(NSInteger)type;//上面选择彩果的回调 type 1 是按钮胜平负的那种 2是弹框数字的那种
@end

@interface MatchBetView : UIView<BFYCBoxViewDelegate>{

    MatchButtonType buttonType;
//    UIButton * peilvButton;
    NSMutableArray * selectArray;
    UILabel * homeLabel;
    UILabel * guestLabel;
    id<MatchBetViewDelegate>delegate;
    GC_BetData * betData;
    NSMutableArray * typeButtonArray;
    UILabel * touLabel;
//    UILabel * peilvLabel;
    UILabel * competitionLabel;
    UILabel * timeLabel;
    UILabel * homeNumber;
    UILabel * guestNumber;
    
    

}

@property (nonatomic, assign)MatchButtonType buttonType;
@property (nonatomic, retain)UILabel *guestLabel, * homeLabel;
@property (nonatomic, assign)id<MatchBetViewDelegate>delegate;
//@property (nonatomic, retain)UIButton * peilvButton;
@property (nonatomic, retain)GC_BetData * betData;
@property (nonatomic, retain)NSMutableArray * typeButtonArray;
//@property (nonatomic, retain)UILabel * peilvLabel;
@property (nonatomic, retain)UILabel * competitionLabel, * timeLabel, * homeNumber, * guestNumber;




@end


