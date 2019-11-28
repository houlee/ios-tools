//
//  22Xuan5ViewController.h
//  caibo
//
//  Created by yaofuyu on 12-9-18.
//
//

#import <UIKit/UIKit.h>
#import "GouCaiShuZiInfoViewController.h"
#import "GCBallView.h"
#import "ASIHTTPRequest.h"
#import "GC_IssueInfo.h"
#import "CPViewController.h"
#import "CP_ThreeLevelNavigationView.h"
#import "WangqiKaJiangList.h"
#import "ColorView.h"

@interface _22Xuan5ViewController : CPViewController<GCBallViewDelegate,ASIHTTPRequestDelegate,CP_ThreeLevelNavDelegate> {
    GouCaiShuZiInfoViewController *infoViewController;
	NSString *selectNumber;	
	
	UILabel *zhushuLabel;
	UILabel *jineLabel;
	
	UIButton *senBtn;
	NSString *item;
	BOOL isHeMai;
	ASIHTTPRequest *myHttpRequest;
    IssueRecord *myissueRecord;
    UILabel *sqkaijiang;
    CP_ThreeLevelNavigationView *tln;
    ASIHTTPRequest *qihaoReQuest;
    WangqiKaJiangList *wangQi;
    ColorView *endTimelable;
}

@property (nonatomic,copy)NSString *selectNumber;
@property (nonatomic,copy)NSString *item;
@property (nonatomic,assign)BOOL isHeMai;
@property (nonatomic,retain)ASIHTTPRequest *myHttpRequest;
@property (nonatomic,retain) IssueRecord *myissueRecord;
@property (nonatomic,retain)WangqiKaJiangList *wangQi;
@property (nonatomic,retain)ASIHTTPRequest *qihaoReQuest;

@end
