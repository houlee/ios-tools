//
//  newHomeViewController.h
//  caibo
//
//  Created by  on 12-5-2.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "caiboAppDelegate.h"
#import "ASIHTTPRequest.h"
#import "GC_VersionCheck.h"
#import "StatePopupView.h"
#import "KFButton.h"
#import "CP_TabBarViewController.h"
#import "CP_UIAlertView.h"
#import "CPViewController.h"
#import "GCScrollView.h"
#import "PKRaceViewController.h"
#import "CP_PrizeView.h"
#import "MyWebViewController.h"
//@protocol newHomeDelegate <NSObject>
//
//@optional
//- (void)returnSiXinData:(NSInteger)countData;
//
//@end

@interface newHomeViewController : CPViewController<UITableViewDataSource, UITableViewDelegate, CP_TabBarConDelegate, CP_UIAlertViewDelegate,UITextFieldDelegate,GCScrollViewDelegate,CP_PrizeViewDelegate,MyWebViewDelegate>{
//    id<newHomeDelegate>delegate;
//    UIImageView * jdnewImage;
   
    NSInteger guanzhustr;
    NSInteger pinglustr;
    NSInteger atmestr;
    NSInteger sxstr;
    NSInteger gzrftstr;
    ASIHTTPRequest * httpRequest;
    GC_VersionCheck * versionCheck;
    ASIHTTPRequest * chekrequest;
    ASIHTTPRequest * huoyuerequest;
    UIButton * interaction;
	UIButton * set;
//    UIButton * zhucezlBtn;
    UIButton * lottery;
    UIButton * frutti;
    UIButton * buy;
    UIButton * seed;
//    UIButton * bfsp;
    UIButton * pkbut;
//    UIButton * about;
    UIView * lunxianview;
    UILabel * huoYueLabelOne;
    UILabel * huoYueLabelTwo;
    NSDate * jiangetime;
    NSTimer * luntime;
    UIView * shishiview;
    UIButton * bgbutton ;
    UITableView * mytableviw;
    NSInteger rowind;
    UIButton *  huoqu;
    StatePopupView * statepop;
    BOOL oneBool;//标示第一次创建这个页面
    NSInteger kfcount;
    CP_TabBarViewController * tab;

     NSInteger counttag;
     NSInteger counhaoyou;
    int  selectedTab;
    int con;
    NSString * urlVersion;
    
//    UITextField *textF;
    ASIHTTPRequest *requestUserInfo;
    BOOL isTixian;
    UIImageView * imageviewbg;
    NSInteger goucaicount;//记录当前选择第几个
    NSString * passWord;
//    CP_TabBarViewController *tabarvc;
    
    float zoom;
    
    UIButton * eventsButton;
//    UIButton * soccerButton;
//    UIButton * shuangSeButton;
    
    GCScrollView *mainScrollView;
//    UIView * newMainView;
    UIButton * lcButton;
    UIButton * wsxxButton;
}
//@property (nonatomic, assign)id<newHomeDelegate>delegate;
//- (void)returnview:(UIView *)view;
@property (nonatomic, retain)NSString * passWord;
@property (nonatomic, assign)BOOL oneBool;
@property (nonatomic, retain)NSString * urlVersion;
@property (nonatomic, retain)ASIHTTPRequest * chekrequest;
@property (nonatomic, retain)ASIHTTPRequest * httpRequest, * huoyuerequest,*requestUserInfo, * getWCDateRequest;
@property (nonatomic, retain) GC_VersionCheck * versionCheck;
- (void)huoYueHttp;
-(void)pressGonglue:(UIButton *)sender;
- (void)goAbout:(UIButton *)sender;
- (void)pressbfsp:(UIButton *)sender;
- (void)pressOldPkbut:(UIButton *)sender;

@end
