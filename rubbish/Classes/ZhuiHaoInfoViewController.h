//
//  ZhuiHaoInfoViewController.h
//  caibo
//
//  Created by houchenguang on 13-12-13.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "CPZhanKaiView.h"
#import "zhuiHaoData.h"
#import "ASIHTTPRequest.h"
#import "MoreLoadCell.h"
#import "UpLoadView.h"
#import "ColorView.h"
#import "CP_PTButton.h"
#import "CheDanZhuiViewController.h"
#import "ShuangSeQiuInfoViewController.h"

@protocol ZhuiHaoInfoViewDelegate <NSObject>

- (void)returnTypeAnswer:(NSInteger)answer;

@end

@interface ZhuiHaoInfoViewController : CPViewController<ShuangSeQiuInfoDelegate,CheDanZhuiDelegate,CPZhanKaiViewDelegate, UITableViewDataSource, UITableViewDelegate>{

    ASIHTTPRequest * httpRequest;
    NSString * schemeID;//方案id 进这个页面时传进来
    zhuiHaoData * zhuihaodata;
    UITableView * myTableView;
    MoreLoadCell *moreCell;
    UpLoadView * loadview;
    UIImageView * awardView;
    CPZhanKaiView *zhanKaiView;//展开
    ColorView *changciView;//总共多少钱
    ColorView *changciView2;//已经负了多少钱
    CP_PTButton *Btn;//剩余多少 按钮
    UILabel * percentage;//几分之几
    ColorView *zhuiView;//追多少期 已经追多少期
    UILabel * timeLabelText;//投注时间
    UILabel * typeLabel;//状态
    UILabel * NOLabelText;//方案编号
//    ColorView * awardLabel;//中奖金额
    UILabel * zhongjiangLabel;//中奖label
    UILabel * yuanLable;//元字
    UILabel * awardMoney;//中奖金额
    id<ZhuiHaoInfoViewDelegate>delegate;
    NSInteger typeAnswer;
    UILabel *surplusLabel;// 剩余
}

@property (nonatomic, retain)NSString * schemeID;
@property (nonatomic, retain)ASIHTTPRequest * httpRequest;
@property (nonatomic, retain)zhuiHaoData * zhuihaodata;
@property (nonatomic,retain)MoreLoadCell *moreCell;
@property (nonatomic, retain)id<ZhuiHaoInfoViewDelegate>delegate;

@end
