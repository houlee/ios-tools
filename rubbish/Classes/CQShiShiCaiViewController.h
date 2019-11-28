//
//  CQShiShiCaiViewController.h
//  caibo
//
//  Created by yaofuyu on 14-4-29.
//
//

#import "CPViewController.h"
#import "GCBallView.h"
#import "GC_LotteryType.h"
#import "ASIHTTPRequest.h"
#import "ColorView.h"
#import "GouCaiShuZiInfoViewController.h"
#import "WangqiKaJiangList.h"
#import "CPViewController.h"
#import "WangQiZhongJiang.h"
#import "CP_ThreeLevelNavigationView.h"
#import "CP_KindsOfChoose.h"
#import "GifButton.h"
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7

@interface CQShiShiCaiViewController : CPViewController<GCBallViewDelegate,ASIHTTPRequestDelegate,UIPickerViewAccessibilityDelegate,CP_ThreeLevelNavDelegate,CP_KindsOfChooseDelegate,GifButtonDelegate,CP_UIAlertViewDelegate> {
    UIScrollView *backScrollView;
    UIImageView *bgImageView2;
    UILabel *titleLabel;
    LotteryTYPE lotterytype;
    ColorView *colorLabel;
    NSArray * wanArray;
    UILabel *infoLable;
    UILabel *zhushuLabel;//注数
    UILabel *jineLabel;
	NSString *issue;
	UIButton *senBtn;
    GouCaiShuZiInfoViewController *infoViewController;
    ModeTYPE modetype;
    ColorView *sqkaijiang;
    ASIHTTPRequest *myRequest;
    ASIHTTPRequest *qihaoReQuest;
    UILabel *yaolabel;
    UIImageView *yaoImage;
    UIButton *randBtn;
    BOOL isAppear;
    UIToolbar *pickerTool;
    //    WangqiKaJiangList *wangQi;
    
    UILabel *timeLabel;
	UILabel *mytimeLabel2;
	UILabel *mytimeLabel3;
    int seconds;
    NSTimer *myTimer;
    
    ColorView *zaixianLabel;
	ColorView *ranLabel;
    UILabel *ranNameLabel;
	UIImageView *imageruan;
    NSTimer *runTimer;
	NSInteger runCount;
    WangQiZhongJiang *zhongJiang;
    UIView *editeView;
    //    UITableView *mytableView;//往期开奖
    BOOL isKaiJiang;//是否开奖
    NSInteger yanchiTime;//截至和开奖便宜秒数
    
    UILabel * descriptionLabel;//玩法说明
    
    NSString * myIssrecord;//存的期数
    ASIHTTPRequest *yilouRequest;//遗漏值请求
    NSDictionary *yilouDic;//遗漏值
    
    NSArray * yiLouTypeArr;//遗漏名称
    CP_ThreeLevelNavigationView *tln;
    CFRunLoopRef entRunLoopRef;//倒计时用的runloop
    
    BOOL isShowing;
    CP_KindsOfChoose *alert2;
    BOOL titleBtnIsCanPress;//标题按钮是否可点击 防止动画未完成的多余点击

    BOOL hasYiLou;
    BOOL canRefreshYiLou;
    UIImageView * sanjiaoImageView;
}
@property (nonatomic)LotteryTYPE lotterytype;
@property (nonatomic)ModeTYPE modetype;
@property (nonatomic,retain)ASIHTTPRequest *myRequest,*qihaoReQuest;
//@property (nonatomic,retain)WangqiKaJiangList *wangQi;
@property (nonatomic,retain)WangQiZhongJiang *zhongJiang;
@property (nonatomic,copy)NSString *issue;
@property (nonatomic,retain)NSTimer *myTimer,*runTimer;

@property (nonatomic,retain)ASIHTTPRequest *yilouRequest;
@property (nonatomic,retain)NSDictionary *yilouDic;
@property (nonatomic,retain)NSString * myIssrecord;

@end