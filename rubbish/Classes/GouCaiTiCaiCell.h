//
//  GouCaiTiCaiCell.h
//  caibo
//
//  Created by yao on 12-5-25.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShuangSeQiuInfoViewController.h"
#import "MatchInfo.h"

@interface GouCaiTiCaiCell : UITableViewCell {
	UIImageView *backImage;
    UIImageView *backImage1;
    UIImageView *danImage;
    UIImageView *danImage2;
    UIImageView *rightImage;
    UIImageView *rightImage2;
    UIImageView *playImage;//玩法图片
    
	UILabel *label1;//场次
	UILabel *label2;//时间
	UILabel *label3;//左队
	UILabel *label4;//左队赔率
	UILabel *label5;//平
	UILabel *label6;//平赔率
	UILabel *label7;//右队
	UILabel *label8;//右队赔率
    UILabel *label9;//比分
    UILabel *label10;//投注
    UILabel *label11;//彩果
    UILabel *label12;//场次2
    UILabel *label13;//投注2；
    
    UILabel *label14;//联赛名
    
    //分割线
    UIView *line1;
    UIView *line2;
    UIView *line3;
    UIView *line4;
    UIView *line5;
    UIView *line6;
	BOOL isReload;
    NSString *wanfa;//玩法id
    NSString *chuanfa;//串发
    NSString *playId; //playId 
    BOOL isJJYH;
    MatchInfo *myMatchInfo;
    UIButton *shishiBtn;
    
    UIView *danguanView;
}

- (void)LoadData:(NSString *)info Info:(NSString *)info2 LottoryType:(TiCaiType)type;
- (void)LoadMatchInfo:(MatchInfo *)matchInfo;//更新时时比分
@property (nonatomic,copy)NSString *wanfa;
@property (nonatomic,copy)NSString *chuanfa;
@property (nonatomic,copy)NSString *playId;
@property (nonatomic)BOOL isJJYH;
@property (nonatomic,retain)MatchInfo *myMatchInfo;
@property (nonatomic,retain)UIButton *shishiBtn;

@end
