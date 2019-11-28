//
//  CP_UIAlertView.h
//  iphone_control
//
//  Created by yaofuyu on 12-12-5.
//  Copyright (c) 2012年 yaofuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreLoadCell.h"
#import "ASIHTTPRequest.h"
#import "GC_WinningInfoList.h"
#define SWITCH_ON [[[NSUserDefaults standardUserDefaults] objectForKey:@"YiLouSwitch"] isEqualToString:@"1"]


typedef enum {
    ordinaryType,
    passWordType,
    twoTextType,
    switchType,
    explainType,
    jieQiType,
    howGetFlag,//如何获得国旗
    tableType,  //带有列表的AlertView
    exChangeSure,//积分兑换彩金确认
    robCaiJinType,//抢彩金提示框
    textAndImage,//文字+图片（例防沉迷提示框）
    autoRemoveType,//自动消失
    segementType,
    ChongzhiSuccType,//充值成功提示
    ExchangePointFailType,//兑换积分异常提示
    ChongzhiFailType,//充值“处理中”提示
    basketballChuPiaoType,
    horseRaceType,//赛马弹窗
    chongzhidiyici,
    longBtnTitle,//长按钮title
    textViewType,//输入
    checkUpdateType,
    purchasePaln,//购买方案
    checkMarkType,
    explanationType,
    
}AlertViewType;

@class CP_UISegement;
@class GC_UIkeyView;

@interface CP_UIAlertView : UIView <UITextViewDelegate, UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    id delegate;
    NSString *title;
    NSString *message;
    NSMutableArray *customButtons;//按钮数组
    BOOL shouldRemoveWhenOtherAppear;
    AlertViewType alertTpye;
    UITextField * myTextField;
    UILabel *textLabel;

    
    MoreLoadCell *moreCell;
    
    UITableView *myTableView;
    int curPage;
    int pageCount;
    NSMutableArray *pageArray;//每页显示的获奖人名单
    NSMutableArray *allFlagWinningList;//所有的获奖人名单
    
    NSString *exChangeSureFirstCell;
    NSString *exChangeSureSecondCell;
    NSString *exChangeSureThirdCell;

    BOOL isShowingKeyboard;
    GC_UIkeyView * gckeyView;
    UIButton * alertBgButton;
    float oY;
    
    UIImageView * checkMarkImageView;//检查更新对勾
    
    UIButton * checkMarkButton;//检查更新对勾按钮
    BOOL dontDismiss;
    
    NSMutableAttributedString * attributedMessage;
    UILabel * messageLabel;
    UITextView * msgTextView;
}

@property (nonatomic, retain) UILabel * messageLabel;

@property (nonatomic, retain) NSMutableAttributedString * attributedMessage;

@property (nonatomic, assign)BOOL dontDismiss;

@property (nonatomic, retain)UIButton * checkMarkButton;
@property (nonatomic, retain)UIButton * alertBgButton;
@property (nonatomic,assign)id delegate;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *message;
@property (nonatomic,retain)NSMutableArray *customButtons;
@property (nonatomic)BOOL shouldRemoveWhenOtherAppear;
@property (nonatomic, assign)AlertViewType alertTpye;
@property (nonatomic, retain)UITextField * myTextField;

@property (nonatomic, retain)UITableView *myTableView;
@property (nonatomic, copy)NSString *exChangeSureFirstCell;
@property (nonatomic, copy)NSString *exChangeSureSecondCell;
@property (nonatomic, copy)NSString *exChangeSureThirdCell;
@property (nonatomic, retain) NSMutableArray *allFlagWinningList;
@property (nonatomic, retain) NSMutableArray *pageArray;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, retain) GC_UIkeyView * gckeyView;
@property (nonatomic, assign)BOOL isShowingKeyboard;

@property (nonatomic, retain) CP_UISegement * alertSegement;
@property (nonatomic,copy)NSString *agreeTitle;

@property (nonatomic, retain) UITextView * msgTextView;
@property (nonatomic,retain)NSDictionary *userInfo;
@property (nonatomic)NSTextAlignment textAlignment;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id )delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (void)show;

-(void)showKeyboard:(UIButton *)button;


-(void)loadWinningListWith:(NSArray *)_arr;


- (void)clickTap:(UITapGestureRecognizer *)clickTap;

@end

@protocol CP_UIAlertViewDelegate

@optional
- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message;

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

//世界杯国旗获奖列表加载下一页
- (void)CP_alertView:(CP_UIAlertView *)alertView againRequestWithPage:(int)page;
- (void)CP_alertView:(CP_UIAlertView *)alertView clickPuchsPlanDealTap:(UITapGestureRecognizer *)sender;

@end
