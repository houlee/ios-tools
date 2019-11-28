//
//  HappyTenViewController.h
//  caibo
//
//  Created by yaofuyu on 13-4-9.
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
#import "GC_IssueInfo.h"
#import "UpLoadView.h"
#import "redrawView.h"
#import "UITitleYiLouView.h"
//#import "CPBangDanView.h"

typedef enum {
    NeiMengKuaiSan,//内蒙古快三
    JiangSuKuaiSan,//江苏快三
    HuBeiKuaiSan,//湖北快三
    JiLinKuaiSan,//吉林快三
    AnHuiKuaiSan,//安徽快三

}KuaiSanType;

@interface KuaiSanViewController : CPViewController<GCBallViewDelegate,ASIHTTPRequestDelegate,UIPickerViewAccessibilityDelegate,CP_ThreeLevelNavDelegate,CP_KindsOfChooseDelegate,UITableViewDataSource,UITableViewDelegate, redrawViewDelegate, UITitleYiLouViewDelegate> {
    UIScrollView *backScrollView;
    UIImageView *bgImageView2;
    UILabel *titleLabel;
    LotteryTYPE lotterytype;
//    ColorView *colorLabel;
//    ColorView *zhuShuAndJinE;
    NSArray * wanArray;
    UILabel *zhushuLabel;//注数
    UILabel *jineLabel;
	NSString *issue;
	UIButton *senBtn;
    GouCaiShuZiInfoViewController *infoViewController;
    ModeTYPE modetype;
    UILabel *sqkaijiang;
    ASIHTTPRequest *myRequest;
    ASIHTTPRequest *qihaoReQuest;
    ASIHTTPRequest *yilouRequest;//遗漏请求
    UILabel *yaolabel;
    UIButton *randBtn;
    BOOL isAppear;
    UIToolbar *pickerTool;
//    WangqiKaJiangList *wangQi;
    
    UILabel *timeLabel;
	UILabel *mytimeLabel2;
	UILabel *mytimeLabel3;
    int seconds;
    NSTimer *myTimer;
    
    UIView *editeView;
//    UITableView *mytableView;//往期开奖
    
    UIImageView * xiimageview;
    BOOL isKaiJiang;//是否开奖
//    ColorView *accuntLabel;
    NSDictionary *yilouDic;//遗漏值字典
    
    ColorView *shuomingLabel;//说明图
    UIImageView *shaizi1View;
    UIImageView *shaizi2View;
    UIImageView *shaizi3View;
    
    //  大小单双
    GCBallView *daBall;//
    GCBallView *xiaoBall;//
    GCBallView *danBall;//
    GCBallView *shuangBall;//
//    UIImageView *timeImage;//时间背景
    
    IssueRecord *myIssrecord;
    UIButton * tuiJianBtn;
    NSInteger yanchiTime;
    
    UIButton * qingbutton;//清按钮
//    CP_PTButton *wanInfo;//玩法说明按钮
    
    UIImageView * shakeImageView;//摇一摇图片
    UIButton * blackButton;//玩法选择黑色背景
    UIImageView * selectImageView;//玩法选择背景
    float selectImageViewHeight;//玩法选择背景高度
    NSDictionary * wanDictionary;//玩法选择内容

    BOOL changePage;//区分是nav按钮取消玩法选择还是普通点击按钮
//    CPBangDanView *bang;//榜单
    BOOL showing;//标题按钮是否正在下移
    NSInteger wanFaType;
    
    UIView * expectationView;//预计奖金
    NSMutableString * expectationStr;//选中的所有奖金
    ASIHTTPRequest * httpRequest;
    UpLoadView * loadview;
    NSMutableArray * yiLouDataArray;
    
    redrawView * redrawHZ;
    redrawView * redrawSTH;
    redrawView * redrawETH;
    redrawView * redrawSLH;
    redrawView * redrawSBT;
    redrawView * redrawEBT;
    
    UITitleYiLouView * redrawTitleHZ;
    UITitleYiLouView * redrawTitleSTH;
    UITitleYiLouView * redrawTitleETH;
    UITitleYiLouView * redrawTitleSLH;
    UITitleYiLouView * redrawTitleSBT;
    UITitleYiLouView * redrawTitleEBT;
    CP_ThreeLevelNavigationView    *tln;
    
    CFRunLoopRef entRunLoopRef;//倒计时用的runloop
    
    BOOL kaijianging;
    UIImageView * topImageView;
    
    int changeWinOrigin;
    
    UILabel * topNumberLabel;
    
    KuaiSanType myKuaiSanType;
    NSString * myLotteryID;
    
    BOOL hasYiLou;
    BOOL canRefreshYiLou;
    
    
    UIImageView * yuSheImageView;
    
    UIImageView * sanjiaoImageView;
}
@property (nonatomic)LotteryTYPE lotterytype;
@property (nonatomic)ModeTYPE modetype;
@property (nonatomic,retain)ASIHTTPRequest *myRequest,*qihaoReQuest,*yilouRequest;
//@property (nonatomic,retain)WangqiKaJiangList *wangQi;
@property (nonatomic,retain)WangQiZhongJiang *zhongJiang;
@property (nonatomic,copy)NSString *issue;
@property (nonatomic,retain)NSTimer *myTimer;
@property (nonatomic,retain)NSDictionary *yilouDic;
@property (nonatomic,retain)IssueRecord *myIssrecord;
@property (nonatomic, retain)ASIHTTPRequest * httpRequest;
@property (nonatomic, retain)NSMutableArray * yiLouDataArray;

- (id)initWithType:(KuaiSanType)type;


@end
