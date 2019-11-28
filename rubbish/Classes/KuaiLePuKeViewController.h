//
//  KuaiLePuKeViewController.h
//  caibo
//
//  Created by yaofuyu on 14-3-18.
//
//

#import "CPViewController.h"
#import "GCBallView.h"
#import "GC_LotteryType.h"
#import "ASIHTTPRequest.h"
#import "ColorView.h"
#import "GouCaiShuZiInfoViewController.h"
#import "WangqiKaJiangList.h"
#import "CP_ThreeLevelNavigationView.h"
#import "CP_KindsOfChoose.h"
#import "GC_IssueInfo.h"

@interface KuaiLePuKeViewController : CPViewController<GCBallViewDelegate,ASIHTTPRequestDelegate,CP_ThreeLevelNavDelegate,CP_KindsOfChooseDelegate,UITableViewDataSource,UITableViewDelegate> {
    UIScrollView *backScrollView;
    UIImageView *bgImageView2;
    UILabel *titleLabel;
    LotteryTYPE lotterytype;
    NSArray * wanArray;
    UILabel *zhushuLabel;//注数
    UILabel *jineLabel;
	NSString *issue;
	UIButton *senBtn;
    GouCaiShuZiInfoViewController *infoViewController;
    ModeTYPE modetype;
    ColorView *sqkaijiang;
    ASIHTTPRequest *myRequest;
    ASIHTTPRequest *qihaoReQuest;
    ASIHTTPRequest *yilouRequest;//遗漏请求
    UIButton *randBtn;
    BOOL isAppear;
    UIToolbar *pickerTool;
    
    UILabel *timeLabel;
	UILabel *mytimeLabel2;
	UILabel *mytimeLabel3;
    NSInteger seconds;
    NSTimer *myTimer;
    
    UIView *editeView;
    
    UIImageView * xiimageview;
    BOOL isKaiJiang;//是否开奖
    NSDictionary *yilouDic;//遗漏值字典
    
//    ColorView *shuomingLabel;//说明图
    UIImageView *shaizi1View;
    UIImageView *shaizi2View;
    UIImageView *shaizi3View;
    
    UIImageView *timeImage;//时间背景
    
    IssueRecord *myIssrecord;
    NSInteger yanchiTime;
    
    
    NSDictionary * wanDictionary;//玩法选择内容
    
    BOOL changePage;//区分是nav按钮取消玩法选择还是普通点击按钮
    BOOL showing;//标题按钮是否正在下移
    NSInteger wanFaType;
    
    UIView * expectationView;//预计奖金
    NSMutableString * expectationStr;//选中的所有奖金
    CP_ThreeLevelNavigationView    *tln;
    CFRunLoopRef entRunLoopRef;//倒计时用的runloop
    
    UIImageView * typeTitleImageView;
    
    BOOL isShowing;
    CP_KindsOfChoose *alert2;
    BOOL titleBtnIsCanPress;//标题按钮是否可点击 防止动画未完成的多余点击

    ColorView * topWanfaLabel;
    
    UIButton *qingbutton;
    
    BOOL hasYiLou;
    BOOL canRefreshYiLou;
    UIImageView * sanjiaoImageView;

}
@property (nonatomic)LotteryTYPE lotterytype;
@property (nonatomic)ModeTYPE modetype;
@property (nonatomic,retain)ASIHTTPRequest *myRequest,*qihaoReQuest,*yilouRequest;
@property (nonatomic,copy)NSString *issue;
@property (nonatomic,retain)NSTimer *myTimer;
@property (nonatomic,retain)NSDictionary *yilouDic;
@property (nonatomic,retain)IssueRecord *myIssrecord;



@end
