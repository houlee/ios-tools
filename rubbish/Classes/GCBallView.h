//
//  GCBallView.h
//  caibo
//
//  Created by yao on 12-5-16.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorView.h"

typedef enum 
{
    GCBallViewColorRed,
	GCBallViewColorBlue,
    GCBallViewColorBig,
    GCBallViewColorKuaiSan,
    GCBallViewColorKuaiSan2,
    GCBallViewColorKuaiSanErTong,
    GCBallViewColorKuaiSanSanTong,//三同号单选
    GCBallViewColorKuaiSanSanTongTong,//三同号通选
    GCBallViewColorKuaiSanSanLian,//三连号
    GCBallViewColorKuaiSanHezhi,//快三和值
    GCBallViewColorKuaiSanWanFa,//快三玩法
    GCBallViewColorKuaiSanHezhiDX,//快三和值下边大小单双
    GCBallViewColorTuiJian,//推荐号
    GCBallViewKuaiLePukePutong,//快乐扑克普通牌
    GCBallViewKuaiLePuKeTonghua,//快乐扑克同花
    GCBallViewYuShe,//预设方案
    GCBallViewHappyTenQuan,//快乐十分全数 大数 单数
    GCBallViewHorseRace,//赛马
}GCBallViewColorType;

@protocol GCBallViewDelegate

@optional
- (void)ballSelectChange:(UIButton *)imageView;

@end


@interface GCBallView : UIButton {
	UILabel *numLabel;
    UILabel *numLabel2;
    UILabel *numLabel3;
	UIImageView *bigImageVIew;
//    UIImageView *huaImageView;
	UILabel *bigLabel;
	id gcballDelegate;
	BOOL isRed;
    GCBallViewColorType colorType;
    BOOL isBlack;//默认字体为黑色；
    UILabel *ylLable;//遗漏期数；
    CGRect nomorFrame;
    BOOL isXQBall;//是开奖详情
    BOOL isChongfu;// 胆拖胆码被选择后
//    UIImageView *selectdownImage;
//    UIImageView *duihaoImageView;
    
    NSString * maxYiLouTag;
}

@property (nonatomic,retain)NSString * maxYiLouTag;

@property (nonatomic,retain)UILabel *numLabel,*ylLable,*numLabel2,* numLabel3;
@property (nonatomic,assign)id<GCBallViewDelegate> gcballDelegate;
@property (nonatomic)BOOL isBlack;
- (void) changeTo:(GCBallViewColorType)newcolorType;
- (void)changetolight;
- (void)chanetoNomore;

@property (nonatomic)CGRect nomorFrame;
- (id)initWithFrame:(CGRect)frame
				Num:(NSString *)num 
		  ColorType:(GCBallViewColorType)ColorType;

@end
