//
//  GouCaiShuZiInfoViewController.h
//  caibo
//
//  Created by yao on 12-5-16.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GC_BetInfo.h"
#import "GC_HttpService.h"
#import "ASIHTTPRequest.h"
#import "ShuangSeQiuCell.h"
#import "ShiYiXuanWuCell.h"
#import "CalculateViewController.h"
#import "CPViewController.h"
#import "CP_PTButton.h"
#import "ColorView.h"
#import "CPZhanKaiView.h"
#import "CP_NumberKeyboardView.h"
#import "CP_SWButton.h"
#import "CP_UIAlertView.h"
#import "CP_UISegement.h"
#import "GC_UIkeyView.h"
#import "GC_BuyLottery.h"

typedef enum
{
	GouCaiShuZiInfoTypeShuangSeqiu,
	GouCaiShuZiInfoTypeShiXuanWu,
    GouCaiShuZiInfoTypeDaleTou,
    GouCaiShuZiInfoTypeFuCai3D,
    GouCaiShuZiInfoTypePaiLie5,
    GouCaiShuZiInfoTypeQiXingCai,
    GouCaiShuZiInfoType22Xuan5,
    GouCaiShuZiInfoTypeQiLeCai,
    
	GouCaiShuZiInfoTypeShiShiCai,
    GouCaiShuZiInfoTypePaiLie3,
    GouCaiShuZiInfoTypeHappyTen,
    GouCaiShuZiInfoTypeKuaiSan,
    GouCaiShuZiInfoTypeKuaiLePuke,
    GouCaiShuZiInfoTypeGDShiXuanWu,
    GouCaiShuZiInfoTypeCQShiShiCai,
    GouCaiShuZiInfoTypeJXShiXuanWu,
    GouCaiShuZiInfoTypeHBShiXuanWu,
    GouCaiShuZiInfoTypeShanXiShiXuanWu,
}GouCaiShuZiInfoType;


@interface GouCaiShuZiInfoViewController : CPViewController<CP_UIAlertViewDelegate,CP_NumberDelegate,UITableViewDataSource,UITableViewDelegate,
ASIHTTPRequestDelegate,ShuangSeQiuCellDelegate,UITextFieldDelegate,ShiYiXuanWuCellDelegate, calculateDelegate,CPZhanKaiViewDelegate,GC_UIkeyViewDelegate> {
	NSMutableArray *dataArray;
	UITableView *myTableView;
	GC_BetInfo *betInfo;
	int multiple/*倍投*/, maxMultiple/*最大倍投*/;
	UITextField *multipleTF;
    UIButton *multiBtn;
    //	UITextField *zhuiText;
	ASIHTTPRequest *httpRequest;
 	NSInteger zhuihaoCount;
    
	UIButton *baoMiBtn;
	UIButton *gongKaiBtn;
	UIButton *jieZhiBtn;
    UIButton *yinshenBtn;
    
    UIImageView *baoMiImage;
    UIImageView *gongKaiImage;
    UIImageView *jieZhiImage;
    UIImageView *yinshenImage;
    
    UILabel *zhuiLable;
	ASIHTTPRequest *ahttpRequest;
    ASIHTTPRequest *counthttpRequest;//请求账户金额
	ColorView *nameLabel;
	ColorView *moneyLabel;
	ColorView *zhanghuLabel;
	UIView *zhuiView;
	BOOL isTingZhui;
    //	UITextField *alertext;
    NSString * passWord;
	UIButton *sendBtn;
	
	GouCaiShuZiInfoType goucaishuziinfotype;//类型
	
	BOOL isHeMai;
	CP_SWButton *hemaiSwitch;
    UILabel * buttonLabel1;
    BOOL canBack;           //返回键
    BOOL isGoBuy;           //去购买了；
    UIButton *btn4;//追号设置
    UISwitch *sw;
    NSMutableArray * issuearr;
    BOOL  toushifou;
    UILabel *label4;
    UIImageView * textbgimage;
    CP_PTButton * addbutton;
    CP_PTButton * jianbutton;
    CP_PTButton *baomiButton;
//    CP_UISegement *mySegment;
//    UIView *editeView;
    
    BOOL fanhuibool;
    NSString *sysIssure;
    BOOL dobackbool;//标示进计算页面
    BOOL tankuangbool;//如果提示从新输入密码
    UIButton *zhuijiaSwitch;
    UIWindow* tempWindow;
    ASIHTTPRequest * maxrequst;
    NSInteger maxIssueCount;
    CPZhanKaiView *infoBackImage;
    UIImageView * btn4bg;//追号按钮上的图片
    NSInteger zhuiTextStr;//追多少期
    NSInteger textcount;//键盘中间传递值保存
    BOOL same;//判断倍数是否全部相同
    
    BOOL isShowFangChenMi;//当前次投注是否显示防沉迷提示
    
    ColorView *danzhuLab;
    GC_UIkeyView * gckeyView;
    
    GC_BuyLottery *buyResult;
    
}

- (void)clearBetArray;
- (void)passWordOpenUrl;
@property (nonatomic, retain) GC_BuyLottery *buyResult;
@property (nonatomic, assign)NSInteger maxIssueCount;
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,assign)GouCaiShuZiInfoType goucaishuziinfotype;//类型
@property (nonatomic,assign)LotteryTYPE lotteryType;
@property (nonatomic, assign) ModeTYPE modeType;
@property (nonatomic, retain)GC_BetInfo *betInfo;
@property (nonatomic,retain)ASIHTTPRequest *httpRequest;
@property (nonatomic,retain)ASIHTTPRequest *ahttpRequest;
@property (nonatomic,retain)ASIHTTPRequest *counthttpRequest, * maxrequst;
@property (nonatomic,assign)BOOL isHeMai;
@property (nonatomic)BOOL canBack;
@property (nonatomic,copy)NSString *sysIssure, * passWord , *danzhujiangjin;

@property (nonatomic,retain) NSMutableArray * issuearr;

@end
