//
//  DetailHeaderView.h
//  Experts
//
//  Created by hudong yule on 15/10/30.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMGBtn.h"

@protocol DetailHeaderViewDelegate <NSObject>

-(void)showManayBtnOnClick:(CGFloat)introductionLabHeight andFlags:(BOOL)flags;

-(void)digitalNavBtnOnClickWithBtnTag:(NSInteger)btnTag;

-(void)showContent:(SMGBtn *)btn;

-(void)focusOrNo:(UITapGestureRecognizer *)tap;

@end

@interface DetailHeaderView : UIView

@property(nonatomic,strong)UIImageView * headerImageView;//头像
@property(nonatomic,strong)UILabel *nikeName;//nikeName

@property(nonatomic,strong)UIImageView *focusImgV;
@property(nonatomic,strong)UILabel *focusLab;

//@property(nonatomic,strong)UIImageView * correctImageView;//几中几
//@property(nonatomic,strong)UILabel *correctCountLab;//几中几的label

@property(nonatomic,strong)UILabel *tolRecNoLab;//总推荐数
@property(nonatomic,strong)UILabel *weekWinRateLab;//周胜率
@property(nonatomic,strong)UILabel *mouthWinRateLab;//月胜率

@property(nonatomic,strong)UILabel *introductionLab;//简介

@property(nonatomic,strong)SMGBtn *accessoryBtn;//展开与收起箭头

@property(nonatomic,strong)UIView * headerBottomBg;//最新推荐的黑色背景
@property(nonatomic,strong)UIImageView * _shuTiaoImageView;//小竖条
@property(nonatomic,strong)UILabel * recommandPlan;//最新推荐汉字
@property(nonatomic,strong)UIImageView *shuTiaoImageView;

@property(nonatomic,strong)UIButton * showManayBtn;
//@property(nonatomic,strong)UIImage *showManayImage;

@property(nonatomic,assign)CGFloat introductionLabHeight;
@property(nonatomic,assign)CGFloat newRecommandHeight;

////是否点击了显示更多按钮的标志位
@property(nonatomic,assign)BOOL showManayFlags;
//简介是否多于2行
@property(nonatomic,assign)BOOL isDuoYuTwo;
//进来的是数字彩还是竞彩标志位
@property(nonatomic,assign)BOOL SMGOrDigitalFlags;
@property(nonatomic,strong)UIView * viewOfDigital;
@property(nonatomic,strong)NSArray * btnTitleArray;

@property(nonatomic,weak)id<DetailHeaderViewDelegate> delegate;

-(DetailHeaderView *)DetailHeaderViewWithArray:(NSArray *)dataArray andShowManayFalgs:(BOOL)showManayFlags andDigitalNavBtnTag:(NSInteger)btnTag headStr:(NSString *)headStr superNick:(NSString *)superNick superIntro:(NSString *)superIntro superLevelValue:(NSString *)superLevelValue exsource:(NSString *)exsource smgBtn:(BOOL)smgBtn totalRecNo:(NSString *)totalRecNo weekWinRate:(NSString *)weekWinRate monthWinRate:(NSString *)monthWinRate isfocusOrNo:(NSInteger)isfocusOrNo source:(NSString *)source isSdOrZj:(BOOL)isSdOrZj;//去掉几中几

//-(DetailHeaderView *)DetailHeaderViewWithArray:(NSArray *)dataArray andShowManayFalgs:(BOOL)showManayFlags andDigitalNavBtnTag:(NSInteger)btnTag headStr:(NSString *)headStr superNick:(NSString *)superNick superIntro:(NSString *)superIntro superLevelValue:(NSString *)superLevelValue superOdd:(NSString *)superOdd exsource:(NSString *)exsource smgBtn:(BOOL)smgBtn totalRecNo:(NSString *)totalRecNo weekWinRate:(NSString *)weekWinRate monthWinRate:(NSString *)monthWinRate;

@end
