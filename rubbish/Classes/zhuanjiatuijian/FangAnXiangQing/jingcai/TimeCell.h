//
//  TimeCell.h
//  Experts
//
//  Created by mac on 15/10/27.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SepratorLineView.h"
#import "GameDetailMdl.h"

@protocol TimeCellDelegate <NSObject>

@optional
- (void)betClick:(UIButton *)btn;

@end

@interface TimeCell : UITableViewCell<TimeCellDelegate>
{
    UIView  *topView;
    UIImageView *headImage;
    UIImageView *redVImage;
    UILabel *labName;
    UIImageView *djImgV;
    UILabel *djLab;
    UIView *topViewLine;
    
    UIView  *gamePlanView;
    UILabel *gameNolab;
    UIImageView *backImageView;
    UILabel *workNameLab;
    UILabel *gameTimeLab;
    UIView  *firSecLine;
    UILabel *VSLab;
    UILabel *startNameLab;
    UILabel *endNameLab;
    UIView  *secSecLine;
    UILabel *letGameLab;
    UIButton *countStartLab;
    UIButton *countMidLab;
    UIButton *countEndLab;
    
    UIView  *gamePlanView2;
    UILabel *gameNolab2;
    UIImageView *backImageView2;
    UILabel *workNameLab2;
    UILabel *gameTimeLab2;
    UIView  *firSecLine2;
    UILabel *VSLab2;
    UILabel *startNameLab2;
    UILabel *endNameLab2;
    UIView  *secSecLine2;
    UILabel *letGameLab2;
    UIButton *countStartLab2;
    UIButton *countMidLab2;
    UIButton *countEndLab2;
    
    //滚球
    UIView *gqBgView;
    ChartFormView *gqCharView;
    UILabel *gqplab;
    UILabel *gqzlab;
    UILabel *gqklab;
    UIButton *gqsBtn;
    
    //推荐理由
    UIView *recResnView;
    UILabel *recLab;
    UILabel *contentLab;
    
    //未通过理由
    UIView *thirdView;
    UILabel *refTitLab;
    UILabel *refContentLab;
    
    UIButton *betBtn;
}

@property(nonatomic,weak) id<TimeCellDelegate> timeCellDelegate;

- (void)creatCell;

- (void)setDataModel:(GameDetailMdl *)compModel lotryTy:(NSString *)lotryType isSd:(NSString *)isSd;

@end
