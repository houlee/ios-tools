//
//  GCLiushuiCell.h
//  caibo
//
//  Created by  on 12-5-23.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCLiushuiData.h"
#import "GC_FreezeDetail.h"
#import "GC_Withdrawals.h"
#import "GCRechangeRecord.h"
typedef enum {
    XianJinLiuShuiallcell,
    XianJinLiuShuichongzhicell,
    XianJinLiuShuidongjiecell,
    XianJinLiuShuitixiancell
}XianJinLiuShuicell;

@interface GCLiushuiCell : UITableViewCell{
    UILabel * dateLabel;
    UILabel * timeLabel;
    UILabel * surplusLabel;
    UIImageView * wjxImageView;
    UIImageView * moneyImageView;
    UIImageView *liuShuiDateMark;
    
    
    UIView *verticalLine2;
    UIView *verticalLine;
    UIView *view;
    UIView *xianView;
    UIView *xianView2;

    UILabel * moneyLabel;
    UILabel * typeLabel;
    UILabel * yuan;
    UILabel *yearLabel;

    
    
    GCLiushuiDataInfo * info;
    FreezeDetailInfor * freeinfo;
    WithdrawalsInfor *withinfo;
    RechargeInfor * rechinfo;
    
    NSString *moneyText;
    
    CGSize moneyRA;
    CGSize moneyRF;
    CGSize moneyRW;
    CGSize moneyRR;
    
  
    
}

//@property (nonatomic, retain)UILabel *dateLabel;
//@property (nonatomic, retain)UILabel *timeLabel;
//@property (nonatomic, retain)UILabel *surplusLabel;
@property (nonatomic, retain)UILabel *yearLabel;
//@property (nonatomic, retain)UIImageView *wjxImageView;
//@property (nonatomic, retain)UIImageView *moneyImageView;
@property (nonatomic, retain)UIImageView *arrowImageView;
//
//@property (nonatomic, retain)UIImageView *liuShuiDateMark;
//@property (nonatomic, retain)UIView *verticalLine;
//@property (nonatomic, assign)NSInteger yearFirst;


//@property (nonatomic, retain)UILabel *moneyLabel;
//@property (nonatomic, retain)UILabel *typeLabel;
//@property (nonatomic, retain)UILabel *yuan;
@property (nonatomic, retain)WithdrawalsInfor *withinfo;
@property (nonatomic, retain)RechargeInfor * rechinfo;
@property (nonatomic, retain)GCLiushuiDataInfo * info;
@property (nonatomic, retain)FreezeDetailInfor * freeinfo;
@property (nonatomic, retain)UIView *view;
@property (nonatomic, retain)UIView *verticalLine2;
@property (nonatomic, retain)UIView *xianView;
@property (nonatomic, retain)UIView *xianView2;

- (UIView *)returnTableViewCellView;
@end
