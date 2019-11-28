//
//  GouCaiCell.h
//  caibo
//
//  Created by yao on 12-5-15.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GC_IssueInfo.h"
#import "CP_CanOpenCell.h"
#import "DownLoadImageView.h"
#import "ColorView.h"

@class GouCaiCell;
@protocol GouCaiCellDelegate
@optional
- (void)isTimeEnd:(NSInteger)type lottery:(NSString *)lotteryString;
- (void)openCell:(GouCaiCell *)cell;
@end


@interface GouCaiCell : CP_CanOpenCell {
	DownLoadImageView *iconImageView;
	ColorView *nameLabel;
	UIImageView *jiezhiImage;
	UILabel *timeLabel;
//	UILabel *dajishiLabel;
    ColorView *dajishiLabel;
	NSTimer *myTimer;
	long seconds;
	NSInteger mycellType;
	id gouCaiCellDelegate;
	IssueRecord *myrecord;
	BOOL isEnable;
    NSInteger pianyitime;
    UIImageView *jiantouImage;
    NSString * jieqidate;//截止时间
    UIImageView *HuoDongimage;
    UILabel *huodongLabel;
    UIImageView *openImage;
}
@property (nonatomic, retain)DownLoadImageView *iconImageView;
@property (nonatomic,retain)UIImageView *openImage;
@property (nonatomic,retain)ColorView *nameLabel;
@property (nonatomic,retain)NSTimer *myTimer;
@property (nonatomic,assign)id<GouCaiCellDelegate> gouCaiCellDelegate;
@property (nonatomic,retain)IssueRecord *myrecord;
@property (nonatomic,assign)BOOL isEnable;
@property (nonatomic)NSInteger pianyitime;
@property (nonatomic, retain)NSString * jieqidate;
//--------------------------------扁平化 by sichuanlin

@property (nonatomic,retain)UIImageView *shaiziIma1;
@property (nonatomic,retain)UIImageView *shaiziIma2;
@property (nonatomic,retain)UIImageView *shaiziIma3;
@property (nonatomic,retain)UIImageView *jinbiIma;
@property (nonatomic,retain)UILabel *jinrikaijiangLabel;

@property (nonatomic, retain) UIImageView *cellbgImage;

- (void)LoadData:(IssueRecord *)record;
- (void)LoadData:(IssueRecord *)record Type:(NSInteger)type;
- (void)LoadIconImage:(NSString *)imageName;

@end
