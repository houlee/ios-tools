//
//  BallCell.h
//  Experts
//
//  Created by mac on 15/10/28.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDetailMdl.h"

@interface BallCell : UITableViewCell

@property (nonatomic,strong)UIView *lefView;//左线
@property (nonatomic,strong)UIView *rigView;//右线
@property (nonatomic,strong)UIView *topView;//上线
@property (nonatomic,strong)UIView *midView;//中线
@property (nonatomic,strong)UIView *lowView;//底线
@property (nonatomic,strong)UILabel *ballNameLab;//球名字
@property (nonatomic,strong)UILabel *countNameLab;//球码名字
@property (nonatomic,strong)UIView *bigView;//白色背景图

@end

@interface BetCell : UITableViewCell
{
    CGSize remmodSize;
}

@property (nonatomic,strong)UIView *firstView;//推荐理由白色
@property (nonatomic,strong)UILabel *remmodLab;//字体推荐理由
@property (nonatomic,strong)UILabel *remContentLab;//推荐理由内容
@property (nonatomic,strong)UIButton *goBetBtn;//去投注

- (void)setDataModel:(GameDetailMdl *)compModel;

@end

@interface HeadCell : UITableViewCell

@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UIImageView *headImage;
@property (nonatomic,strong)UIImageView *redVImage;
@property (nonatomic,strong)UILabel *labName;
@property (nonatomic,strong)UIImageView *djImgV;
@property (nonatomic,strong)UILabel *djLab;
@property (nonatomic,strong)UIView *divdLine;
@property (nonatomic,strong)UILabel *ballNameLab;//球名字
@property (nonatomic,strong)UILabel *ballTimeLab;//球时间

- (void)setDataModel:(GameDetailMdl *)compModel lotterystr:(NSString *)differentLotteryStr time:(NSString *)timeStr;

@end
