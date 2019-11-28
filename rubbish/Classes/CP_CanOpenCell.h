//
//  CP_CanOpenCell.h
//  iphone_control
//
//  Created by yaofuyu on 12-12-4.
//  Copyright (c) 2012年 yaofuyu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CP_CanOpenCell : UITableViewCell {
    id cp_canopencelldelegate;
    UIScrollView *butonScrollView;
    BOOL isShow;
    UIImageView *backImageView;
    UILabel *nameLable;
    CGFloat btnFontSize;
    UIColor *btnTitleColor;

    CGFloat xzhi;
    CGFloat ypianyi;

    UIImageView *otherImageView;//额外按钮背景；
    CGFloat normalHight;
    CGFloat selectHight;
    UIImageView * xialabianImge;//下拉边的图片
    
    UIButton * shouQiButton;//收起图片按钮
    NSString * cellType;//标示cell的样式
    NSArray * allTitleArray;//标题的数组
    
}

@property (nonatomic, retain)NSArray * allTitleArray;
@property (nonatomic,assign)id cp_canopencelldelegate;
@property (nonatomic,readonly)BOOL isShow;
@property (nonatomic,retain)UIScrollView *butonScrollView;
@property (nonatomic,retain)UILabel *nameLable;
@property (nonatomic,retain)UIImageView *backImageView;
@property (nonatomic,retain)UIImageView *otherImageView, * xialabianImge;
@property (nonatomic,retain)UIColor *btnTitleColor;
@property (nonatomic)CGFloat btnFontSize;

@property (nonatomic, assign)CGFloat xzhi,ypianyi;

@property (nonatomic)CGFloat normalHight;
@property (nonatomic)CGFloat selectHight;
@property (nonatomic, retain)UIButton * shouQiButton;
@property (nonatomic, retain)NSString * cellType;
- (void)btnClicle:(UIButton *)sender;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)type;

- (void)setButonImageArray:(NSArray *)imageArray TitileArray:(NSArray *)titleArray;
- (void)showButonScollWithAnime:(BOOL)anime;
- (void)showButonScollWithFrame:(CGRect)frame WithAnime:(BOOL)anime;
- (void)hidenButonScollWithAnime:(BOOL)anime;
- (void)setButonImageArray:(NSArray *)imageArray TitileArray:(NSArray *)titleArray newType:(NSInteger)type;//type = 1 是带收起 0是不带 2是混合二选一 3总进球 4 大小单双 6胜负过关 7大混投
@end

@protocol CP_CanOpenCellDelegate

@optional
- (void)CP_CanOpenSelect:(CP_CanOpenCell *)cell WithSelectButonIndex:(NSInteger)Index;

@end


