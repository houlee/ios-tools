//
//  QIleCaiViewController.h
//  caibo
//
//  Created by yaofuyu on 12-9-18.
//
//

#import <UIKit/UIKit.h>
#import "GouCaiShuZiInfoViewController.h"
#import "GC_IssueInfo.h"
#import "GCBallView.h"
#import "ASIHTTPRequest.h"
#import "CPViewController.h"
#import "CP_ThreeLevelNavigationView.h"
#import "ColorView.h"
#import "JiangChiJieXi.h"
#import "ASIHTTPRequest.h"
#import "CP_KindsOfChoose.h"
#import "WangqiKaJiangList.h"
#import "GifButton.h"
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7

typedef enum
{
    QileCaiTypePuTong,
	QileCaiTypeDantuo
}QileCaiType;

@interface QIleCaiViewController : CPViewController <GCBallViewDelegate,ASIHTTPRequestDelegate,CP_ThreeLevelNavDelegate,CP_KindsOfChooseDelegate,GifButtonDelegate> {
    UIScrollView *backScrollView;
    UIView *backView;
    QileCaiType qilecaiType;
    NSArray *wanArray;
    UILabel *titleLabel;
    GouCaiShuZiInfoViewController *infoViewController;
    UIView *bgview;
    IssueRecord *myissueRecord;
    
    UILabel *zhushuLabel;
    UILabel *jineLabel;
    UIButton *senBtn;
    
    BOOL isHemai;
    ASIHTTPRequest *myRequest;
    CP_ThreeLevelNavigationView *tln;
    ColorView *jiangchiMoney;
    JiangChiJieXi *jiangchi;
    
    ASIHTTPRequest *myHttpRequest;
    NSInteger redNum;
    ASIHTTPRequest *qihaoReQuest;
    WangqiKaJiangList *wangQi;
    
    ColorView *endTimelable1;//截期时间
    ColorView *endTimelable2;//截期时间
    
    
    BOOL isShowing;
    CP_KindsOfChoose *alert2;
    BOOL titleBtnIsCanPress;//标题按钮是否可点击 防止动画未完成的多余点击
    UIImageView * sanjiaoImageView;

}

@property (nonatomic,retain)IssueRecord *myissueRecord;
@property (nonatomic,assign)BOOL isHemai;
@property (nonatomic,retain)ASIHTTPRequest *myRequest;
@property (nonatomic)QileCaiType qilecaiType;
@property (nonatomic,retain)JiangChiJieXi *jiangchi;
@property (nonatomic,retain)ASIHTTPRequest *myHttpRequest;
@property (nonatomic,retain)WangqiKaJiangList *wangQi;
@property (nonatomic,retain)ASIHTTPRequest *qihaoReQuest;
- (NSString *)seletNumber;


@end
