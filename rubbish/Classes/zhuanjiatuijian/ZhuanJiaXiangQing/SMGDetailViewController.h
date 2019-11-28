//
//  SMGDetailViewController.h
//  Experts
//
//  Created by hudong yule on 15/10/30.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "V1PinBaseViewContrllor.h"
#import "ExpertDetail.h"
#import "ExpertJingjiModel.h"

typedef void (^selPlanBlock)();//选择套餐
typedef void (^selPlanPurchaseBlock)();//购买套餐

@interface SMGDetailViewController : V1PinBaseViewContrllor

@property(nonatomic,copy)selPlanBlock selPlanBlock;
@property(nonatomic,copy)selPlanPurchaseBlock selPlanPurchaseBlock;

@property(nonatomic,strong)NSString *selTag;//神单计划code
@property(nonatomic,strong)NSString *selPurchaseTag;//神单计划code

@property(nonatomic, assign)BOOL isSdOrNo;//来自神单还是专家推荐

- (void)selPlanBlock:(selPlanBlock)block;
- (void)selPlanPurchaseBlock:(selPlanBlock)block;

//是否点击了头部中的显示更多按钮的标志位
@property(nonatomic,assign)BOOL headerOfSectionOneShowBtnFlags;
@property(nonatomic,assign)CGFloat introductionLabHeight;

//记录数字彩详情界面点击digitalNavBtn的tag,不记录的话整个tableView上下滑动时会刷新第一部分的头部（刷新就相当于重建），造成digitalNavBtn的选中效果仍是创建时的第一个
@property(nonatomic,assign)NSInteger digitalNavBtnTag;
//点击3D和排列三按钮更换下面的footView的标志位
@property(nonatomic,assign)BOOL btn3DAndPaiClickFlags;

//数字彩还是竞彩标志位
@property(nonatomic,assign)BOOL segmentOnClickIndexFlags;

@property(nonatomic,strong)ExpertBaseInfo *exBaseInfo;//基本信息（竞彩、数字彩）

@property(nonatomic,strong)NSArray *npList;//最新推荐（竞彩、数字彩）
@property(nonatomic,strong)NSArray *leastTenPlanArr;//最近10场命中情况（竞彩、数字彩）

//竞彩
@property(nonatomic,strong)NSArray *historyPlanArr;//历史方案（竞彩）
@property(nonatomic,strong)LeastTenInfo *leastTenInfo;//近10场命中情况（竞彩）

//数字彩
@property(nonatomic,strong)NSArray *SSQ_NP_ARR;//双色球最新方案
@property(nonatomic,strong)NSArray *DLT_NP_ARR;//大乐透最新方案
@property(nonatomic,strong)NSArray *FC3D_NP_ARR;//3D最新方案
@property(nonatomic,strong)NSArray *PL3_NP_ARR;//排列三最新方案

@property(nonatomic,strong)NSArray *SSQ_LTP_ARR;//双色球最近10场命中情况
@property(nonatomic,strong)NSArray *DLT_LTP_ARR;//大乐透最近10场命中情况
@property(nonatomic,strong)NSArray *FC3D_LTP_ARR;//3D最近10场命中情况
@property(nonatomic,strong)NSArray *PL3_LTP_ARR;//排列三最近10场命中情况

@property(nonatomic,assign)NSInteger lotryType;//彩种标记（101：双色球，102：大乐透，103：3D，104：排列3）

@property(nonatomic,assign)NSString *planIDStr;//方案id
@property(nonatomic,strong)NSString *jcyplryType;//彩种标记（-201：竞彩，202：亚盘）

@end
