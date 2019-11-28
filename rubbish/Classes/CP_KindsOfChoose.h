//
//  CP_KindsOfChoose.h
//  iphone_control
//
//  Created by yaofuyu on 12-12-6.
//  Copyright (c) 2012年 yaofuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorView.h"
#import "CP_XZButton.h"
#import "footButtonData.h"
typedef enum
{
    CP_KindsOfChooseTypeShuZi,    //数字彩(由屏幕顶端逐渐出现,无取消确定按钮)
    CP_KindsOfChooseTypeShuZiWithTitle,
	CP_KindsOfChooseTypeKongZhi,
    CP_KindsOfChooseTypeRandSetting,
    
    CP_KindsOfChooseTypeChuan,  //串法
    
    CP_KindsOfChooseTypePKIssue,  //串法
    
}CP_KindsOfChooseType;

typedef enum
{
    jingcaizuqiuwf,
    jingcailanqiuwf,
    beidan,
    normalType,
   jingcaipinglun,
}WanFanAll;

@interface CP_KindsOfChoose : UIView {
    CP_KindsOfChooseType kindsType;
    NSArray *chuanArray;
    NSString *title;
    id delegate;
    NSMutableArray *customButtons;//按钮数组
    UIScrollView *backScrollView;
    ColorView *changciView;
    NSString *changCiNum;//场次数量
    NSMutableArray *dataArray;
    NSMutableArray * chuantype;
    NSInteger chuancount;
    NSMutableArray * kongzhiType;//控制状态
    NSMutableArray * duoXuanArr;//多选状态
    BOOL duoXuanBool;
    BOOL tishibool;//北单玩法只能选一个
    WanFanAll jingcaiBool;//竞彩玩法
    BOOL huntouselect;
    //北单胜负、、、、、、、、、、、、、、、、、、、、、、、、、、、、
    BOOL bdsfBool;//北单胜负玩法赛事筛选
    BOOL macthBool;//北单的赛事是否显示
    BOOL zhuanjiaBool;
    BOOL bdwfBool;//北单玩法选择
    UIImageView *infoImage;
    UIImageView *backImageV;
    //    NSInteger bjdcType;//北单其他玩法 玩法选择
    //    NSMutableArray * sfIssueArray;
    //    NSString * sfissueString;//北单胜负的期号
    //    NSString * qtissueString;//北单其他玩法的期号
    //    NSMutableArray * issueTypeArray;//北单其他玩法的期号数组
    BOOL is3D;
    BOOL bfycBool;//八方预测 定制弹框
    UILabel *titleLable;//标题 "玩法选择"
    
    BOOL isClearBtnCanPress; //透明部分是否可点击
    BOOL isKuaiLePuKe;  //快乐扑克
    BOOL isHaveTitle;  //带title的下拉选择框
    BOOL doubleBool;

    NSMutableArray *everyTitleBtnCount;
    
    NSMutableArray *titleArray;
    
    NSInteger kongzhi_Type;
    BOOL onlyDG;//只单关
    BOOL isSaiShiShaixuan;//竞彩赛事筛选,为了与玩法选择区分开
    
    BOOL allButtonBool;//赛事筛选全部的按钮
    BOOL fiveButtonBool;//仅五大联赛按钮
    
}

@property (nonatomic, retain)footButtonData * footData;
@property (nonatomic, assign)BOOL duoXuanBool, tishibool, zhuanjiaBool, bdsfBool, bdwfBool, bfycBool, is3D, doubleBool;
@property (nonatomic, retain)NSMutableArray * chuantype;
@property (nonatomic,assign)id delegate;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,retain)NSArray *chuanArray;
@property (nonatomic,retain)NSMutableArray *customButtons;
@property (nonatomic,retain)UIScrollView *backScrollView;
@property (nonatomic,retain)ColorView *changciView;
@property (nonatomic,copy)NSString *changCiNum;
@property (nonatomic, assign)WanFanAll jingcaiBool;
@property (nonatomic,retain)UIImageView *backImageV;
@property (nonatomic, assign)BOOL isClearBtnCanPress, onlyDG, allButtonBool, fiveButtonBool;
//@property (nonatomic, assign)NSInteger bjdcType;

@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isKuaiLePuKe;
@property (nonatomic,assign)BOOL isHaveTitle;
@property (nonatomic, retain) NSMutableArray *everyTitleBtnCount;
@property (nonatomic, assign) NSInteger kongzhi_Type;
@property (nonatomic, assign) BOOL isSaiShiShaixuan;


- (id)initWithTitle:(NSString *)_title PKNameArray:(NSArray *)_chuanArray PKArray:(NSMutableArray *)chuan;

//数字彩
- (id)initWithTitle:(NSString *)_title ShuziNameArray:(NSArray *)_chuanArray shuziArray:(NSMutableArray *)chuan;

- (id)initWithTitle:(NSString *)_title ShuziNameWithTitleArray:(NSArray *)_chuanArray shuziArray:(NSMutableArray *)chuan;


//- (id)initWithTitle:(NSString *)_title ShuziNameArray:(NSArray *)_chuanArray;

//串法
-(id)initWithTitle:(NSString *)_title withChuanNameArray:(NSArray *)_chuanNameArray andChuanArray:(NSArray *)_chuanArray;
- (id)initWithTitle:(NSString *)title ChuanNameArray:(NSArray *)chuanArray cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;



- (id)initWithTitle:(NSString *)_title ChangCiTitle:(NSString *)_changtiTitle DataInfo:(NSMutableArray *)_dataArray kongtype:(NSMutableArray *)kongarr;

- (id)initWithTitle:(NSString *)_title ChangCiTitle:(NSString *)_changtiTitle DataInfo:(NSMutableArray *)_dataArray cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;


- (id)initWithTitle:(NSString *)_title RandDataInfo:(NSMutableArray *)_dataArray cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;//随机期次设置

//数字彩

- (void)show;

-(void)disMissWithPressOtherFrame;

- (id)initWithTitle:(NSString *)_title ChangCiTitle:(NSString *)_changtiTitle DataInfo:(NSMutableArray *)_dataArray kongtype:(NSMutableArray *)kongarr titleName:(footButtonData *)footdata;

@end

@protocol CP_KindsOfChooseDelegate

@optional


- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt;






//赛事筛选(记忆全选、仅五大联赛、专家推荐按下状态)
- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnKongZhiType:(NSInteger)_type;







- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView chooseButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry;

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView chuanButtonIndex:(NSInteger)buttonIndex button:(CP_XZButton*)sender;
- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView chuanButtonIndex:(NSInteger)buttonIndex typeArrya:(NSMutableArray *)sender;
- (void)shengfuFuncReturn:(BOOL)yesorno chooseView:(CP_KindsOfChoose *)chooseView kongzhiType:(NSMutableArray *)kong name:(NSString *)name;

- (void)disMissWithPressOtherFrame:(CP_KindsOfChoose *)chooseView;

- (void)CP_KindsOfChooseViewAlreadyShowed:(CP_KindsOfChoose *)chooseView;

-(void)chooseViewDidRemovedFromSuperView:(CP_KindsOfChoose *)chooseView;

@end
