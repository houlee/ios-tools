//
//  Pai3ViewController.h
//  caibo
//
//  Created by zhang on 11/7/12.
//
//

#import <UIKit/UIKit.h>
#import "GCBallView.h"
#import "ASIHTTPRequest.h"
#import "GC_LotteryType.h"
#import "ASIHTTPRequest.h"
#import "GC_IssueInfo.h"
#import "GouCaiShuZiInfoViewController.h"
#import "ColorView.h"
#import "CPViewController.h"
#import "CP_ThreeLevelNavigationView.h"
#import "CP_KindsOfChoose.h"
#import "WangqiKaJiangList.h"
#import "UITitleYiLouView.h"
#import "redrawView.h"
#import "GifButton.h"

@class UpLoadView;
@class New_PageControl;

@interface Pai3ViewController : CPViewController<GCBallViewDelegate,ASIHTTPRequestDelegate,CP_ThreeLevelNavDelegate,CP_KindsOfChooseDelegate,redrawViewDelegate, UITitleYiLouViewDelegate,UIScrollViewDelegate,GifButtonDelegate,CP_UIAlertViewDelegate>{

    IssueRecord *myissueRecord;
    UILabel *titleLabel;
    ColorView *sqkaijiang;
    UILabel *infoLable;
    UILabel *zhushuLabel;
    UILabel *jineLabel;
    UIButton *senBtn;
    ColorView *jiangjinLable;
    ModeTYPE modetype;
    NSMutableArray *wanArray;
    BOOL isHeMai;
    
    GouCaiShuZiInfoViewController *infoViewController;
    ASIHTTPRequest *myRequest;
    
    CP_ThreeLevelNavigationView *tln;
    ColorView *colorLabel;
    
    ASIHTTPRequest *qihaoReQuest;
    WangqiKaJiangList *wangQi;
    ColorView *endTimelable;
    
    UIScrollView * normalScrollView;
    
    NSMutableArray * controlArray;
    
    UIView * sqkaijiangView;
    UIImageView *yaoImage;
    
    ASIHTTPRequest * allYiLouRequest;
    
    UpLoadView * loadview;
    NSMutableArray * yiLouDataArray;
    NSDictionary *yilouDic;
    
    UIScrollView * titleScrollView;
    UIScrollView * pai3ScrollView;
    
    UIScrollView * titleScrollView1;
    UIScrollView * pai3ScrollView1;
    
    New_PageControl * myPageControl;
    New_PageControl * myPageControl1;

    NSString * myIssrecord;//存的期数
    ASIHTTPRequest *yilouRequest;//遗漏值请求
    
    float sqkaijiangY;
    float firstViewY;

    NSArray * redTitleArray;
    NSArray * redDescArray;
    
    BOOL isShowing;
    CP_KindsOfChoose *alert2;
    BOOL titleBtnIsCanPress;//标题按钮是否可点击 防止动画未完成的多余点击
    UIImageView * sanjiaoImageView;
}
@property (nonatomic,retain) IssueRecord *myissueRecord;
@property (nonatomic,assign)BOOL isHeMai;
@property (nonatomic,assign)LotteryTYPE lotteryType;
@property (nonatomic)ModeTYPE modetype;
@property (nonatomic,retain)ASIHTTPRequest *myRequest;
@property (nonatomic,retain)WangqiKaJiangList *wangQi;
@property (nonatomic,retain)ASIHTTPRequest *qihaoReQuest;
@property (nonatomic,retain)ASIHTTPRequest * allYiLouRequest;
@property (nonatomic,retain)NSDictionary *yilouDic;
@property (nonatomic,retain)ASIHTTPRequest *yilouRequest;

@property (nonatomic, retain)NSMutableArray * yiLouDataArray;

- (id)initWithModetype:(ModeTYPE *)type;

@end
