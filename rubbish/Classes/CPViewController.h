//
//  CPViewController.h
//  caibo
//
//  Created by yaofuyu on 12-12-12.
//
//

#import <UIKit/UIKit.h>
#import "CPNavigationItem.h"
//#import "ShuZiBottomView.h"
//#import "JingCaiBottomView.h"
//#import "BetInfoBottomView.h"
#import "Info.h"
#import "MJRefresh.h"

//#import "UINumberScrollView.h"
//#define ORIGIN_X(view) (view.frame.origin.x + view.frame.size.width)
//#define ORIGIN_Y(view) (view.frame.origin.y + view.frame.size.height)

typedef enum{
    
    shuangseqiuType,
    daletouType,
    shiyixuanwuType,
    kuaisanType,
    kuaileshifenType,
    kuailePukeType,
} CPLotteryNameType;


@interface CPViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    CPNavigationItem *_CP_navigation;
    UIView *_mainView;
    BOOL isRealNavigationBarHidden;
    BOOL isBackScrollView;//底层是否是ScrollView默认是NO
    UIScrollView *_cpbackScrollView;
    UITableView *_cpTableView;
    NSMutableArray *_cpissArray;//往期开奖数据
    CGFloat isIOS7Pianyi;
    BOOL isBianPing;//扁平化
    
    BOOL isVerticalBackScrollView;//底层是否是上下滑动的ScrollView默认是NO
//    UIScrollView * cpVerticalBackScrollView;
//    UIImageView * cpTopImageView;//上下滑动的scrollview顶上的部分
    UIImageView * cpHistoryBGImageView;//划开后开奖历史
//    UIImageView * cpBottomImageView;//下边机选那部分
    
    BOOL isKuaiSan;//判断是否快三
//    BOOL isHigher;//除快三外的cpTopImageView是长还是短
    UIScrollView * cpLowermostScrollView;//最底下的
    BOOL showYiLou;//yes的话 显示 no为不显示 第一次会自动创建
    UIView * yiLouView;//遗漏图的view
    UIView * headYiLouView;//遗漏图的head view
    CPLotteryNameType cpLotteryName;//传彩种类型
    CGFloat headHight;//遗漏图title的高度
    CGFloat yiLouViewHight;//遗漏图除了title的高度
//    CGFloat excursionHight;//偏移的高度 如果遗漏图整体加起来不够一屏幕的时候 得传这个偏移值
    
//    ShuZiBottomView * shuZiBottomView;
//    JingCaiBottomView * jingCaiBottomView;
//    BetInfoBottomView * betInfoBottomView;
}

//@property (nonatomic,retain)UIView *realView;
@property (nonatomic,retain)CPNavigationItem *CP_navigation;
@property (nonatomic,retain)IBOutlet UIView *mainView;
@property (nonatomic)BOOL isRealNavigationBarHidden,isBianPing;
@property (nonatomic,retain)UIScrollView *cpbackScrollView;
@property (nonatomic,retain)NSMutableArray *cpissArray;
@property (nonatomic,readonly)CGFloat isIOS7Pianyi;

//@property (nonatomic,retain)UIImageView * cpBottomImageView;
@property (nonatomic,retain)UIImageView * cpHistoryBGImageView;
//@property (nonatomic,retain)UIImageView * cpTopImageView;

//@property (nonatomic,retain)UIScrollView *cpVerticalBackScrollView;
@property (nonatomic,assign)BOOL isKuaiSan;
@property (nonatomic,assign)BOOL isHigher;
@property (nonatomic,retain)UIScrollView * cpLowermostScrollView;

@property (nonatomic, assign)BOOL showYiLou;
@property (nonatomic, retain)UIView * headYiLouView;
@property (nonatomic, retain)UIView * yiLouView;
@property (nonatomic, assign)CPLotteryNameType cpLotteryName;
@property (nonatomic, assign)CGFloat headHight, yiLouViewHight;

//@property (nonatomic, retain) ShuZiBottomView * shuZiBottomView;
//@property (nonatomic, retain) JingCaiBottomView * jingCaiBottomView;
//@property (nonatomic, retain) BetInfoBottomView * betInfoBottomView;

@property (nonatomic, assign) BOOL independentLeftBarButtonItem;

-(void)addHistoryWithArray:(NSArray *)historyArray;
- (void)loadInitFunc;
- (void)changeOYTitle;
- (void)changeCSTitileColor;
-(void)addShuZiBottomView;
-(void)addJingCaiBottomView;
-(void)addBetInfoBottomView;

@end
