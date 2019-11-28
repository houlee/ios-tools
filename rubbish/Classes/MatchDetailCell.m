//
//  MatchDetailCell.m
//  caibo
//
//  Created by user on 11-8-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MatchDetailCell.h"
#import "QuartzCore/QuartzCore.h"


@implementation MatchDetailCell

@synthesize leagueNameLabel, matchTimeLabel;
@synthesize asianHomeLabel, asianRangqiuLabel, asianAwayLabel;
@synthesize eurWinLabel, eurDrawLabel, eurLostLabel;
@synthesize oddsWinLabel, oddsDrawLabel, oddsLostLabel;
@synthesize homeLabel, awayLabel, scoreHostLabel, awayHostLabel;
@synthesize homeType, homeNameLabel, homeMinsLabel, awayType, awayNameLabel, awayMinsLabel;
@synthesize leftScrollView, rightScrollView;

//初始化表单
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
	
	if (self) {
		
		if ([reuseIdentifier isEqual: @"leagueTimeCell"]) {
			
			[self insertLeagueTimeCell];
		}
		else if([reuseIdentifier isEqual: @"asianEurCell"]){
			
			[self insertAsianEurCell];
		}
		else if([reuseIdentifier isEqual: @"homeAndAwayCell"]){
			
			[self insertHomeAndAwayCell];
		}
		else if([reuseIdentifier isEqual: @"homeAndAwayListCell"]){
			
			[self insertHomeAndAwayListCell];
		}
		else if([reuseIdentifier isEqual: @"typeCell"]){
			
			[self insertTypeCell];
		}
        else if([reuseIdentifier isEqual: @"asianEurCellWithOdds"]){
            [self insertAsianEurCellWithOdds];
        }
        else if([reuseIdentifier isEqual: @"homeAndAwayListCellWithOdds"]){
            [self insertHomeAndAwayListCellWithOdds];
        }

	}
	
	return self;
}


//插入联赛名称和开赛时间视图单元
- (id)insertLeagueTimeCell
{
	UIColor *color = [UIColor colorWithRed:(154)/255.0 green:(167)/255.0 blue:(186)/255.0 alpha:1];
	
	UILabel *lnLabel = [self LabelWithFrame: CGRectMake(8, 8, 100, 16) fontSize: 14 color: color];
	lnLabel.textAlignment = NSTextAlignmentCenter;
	self.leagueNameLabel = lnLabel;
	[self.contentView addSubview: self.leagueNameLabel];
	
	UILabel *mtLabel = [self LabelWithFrame: CGRectMake(110, 8, 64, 16) fontSize: 14 color: color];
	mtLabel.text = @"开赛时间: ";
	[self.contentView addSubview: mtLabel];
	
	UILabel *tLabel = [self LabelWithFrame: CGRectMake(175, 8, 125, 16) fontSize: 13 color: color];
	self.matchTimeLabel = tLabel;
	[self.contentView addSubview: self.matchTimeLabel];

	[self.contentView setBackgroundColor: color];
		
	return self;
}


//插入亚盘和欧盘数据单元
- (id)insertAsianEurCell
{
	UIColor *color = [UIColor clearColor];
	
	//亚盘
	UILabel *aLabel = [self LabelWithFrame: CGRectMake(24, 8, 66, 16) fontSize: 14 color: color];
	aLabel.text = @"亚盘数据";
	[self.contentView addSubview: aLabel];

	
	UILabel *ahLabel = [self LabelWithFrame: CGRectMake(115, 8, 40, 16) fontSize: 14 color: color];
	self.asianHomeLabel = ahLabel;
	[self.contentView addSubview: self.asianHomeLabel];
	
	UILabel *arLabel = [self LabelWithFrame: CGRectMake(155, 8, 90, 16) fontSize: 14 color: color];
	arLabel.textAlignment = NSTextAlignmentCenter;
	self.asianRangqiuLabel = arLabel;
	[self.contentView addSubview: self.asianRangqiuLabel];
	
	UILabel *aaLabel = [self LabelWithFrame: CGRectMake(255, 8, 40, 16) fontSize: 14 color: color];
	self.asianAwayLabel = aaLabel;
	[self.contentView addSubview: self.asianAwayLabel];
	
	
	//欧盘
	UILabel *eLabel = [self LabelWithFrame: CGRectMake(24, 38, 66, 16) fontSize: 14 color: color];
	eLabel.text = @"欧赔数据";
	[self.contentView addSubview: eLabel];
	
	UILabel *ewLabel = [self LabelWithFrame: CGRectMake(115, 38, 40, 16) fontSize: 14 color: color];
	self.eurWinLabel = ewLabel;
	[self.contentView addSubview: self.eurWinLabel];
	
	UILabel *edLabel = [self LabelWithFrame: CGRectMake(155, 38, 90, 16) fontSize: 14 color: color];
	edLabel.textAlignment = NSTextAlignmentCenter;
	self.eurDrawLabel = edLabel;
	[self.contentView addSubview: self.eurDrawLabel];
	
	UILabel *elLabel = [self LabelWithFrame: CGRectMake(255, 38, 40, 16) fontSize: 14 color: color];
	self.eurLostLabel = elLabel;
	[self.contentView addSubview: self.eurLostLabel];

	return self;
}

- (id)insertAsianEurCellWithOdds
{
	UIColor *color = [UIColor clearColor];
	
	//亚盘
	UILabel *aLabel = [self LabelWithFrame: CGRectMake(24, 8, 66, 16) fontSize: 14 color: color];
	aLabel.text = @"亚盘数据";
	[self.contentView addSubview: aLabel];
	
	UILabel *ahLabel = [self LabelWithFrame: CGRectMake(115, 8, 40, 16) fontSize: 14 color: color];
	self.asianHomeLabel = ahLabel;
	[self.contentView addSubview: self.asianHomeLabel];
	
	UILabel *arLabel = [self LabelWithFrame: CGRectMake(155, 8, 90, 16) fontSize: 14 color: color];
	arLabel.textAlignment = NSTextAlignmentCenter;
	self.asianRangqiuLabel = arLabel;
	[self.contentView addSubview: self.asianRangqiuLabel];
	
	UILabel *aaLabel = [self LabelWithFrame: CGRectMake(255, 8, 40, 16) fontSize: 14 color: color];
	self.asianAwayLabel = aaLabel;
	[self.contentView addSubview: self.asianAwayLabel];
	
	
	//欧盘
	UILabel *eLabel = [self LabelWithFrame: CGRectMake(24, 38, 66, 16) fontSize: 14 color: color];
	eLabel.text = @"欧赔数据";
	[self.contentView addSubview: eLabel];
	
	UILabel *ewLabel = [self LabelWithFrame: CGRectMake(115, 38, 40, 16) fontSize: 14 color: color];
	self.eurWinLabel = ewLabel;
	[self.contentView addSubview: self.eurWinLabel];
	
	UILabel *edLabel = [self LabelWithFrame: CGRectMake(155, 38, 90, 16) fontSize: 14 color: color];
	edLabel.textAlignment = NSTextAlignmentCenter;
	self.eurDrawLabel = edLabel;
	[self.contentView addSubview: self.eurDrawLabel];
	
	UILabel *elLabel = [self LabelWithFrame: CGRectMake(255, 38, 40, 16) fontSize: 14 color: color];
	self.eurLostLabel = elLabel;
	[self.contentView addSubview: self.eurLostLabel];
	
    //
    UILabel *oLabel = [self LabelWithFrame: CGRectMake(24, 68, 75, 16) fontSize: 14 color: color];
    oLabel.text = @"竞彩胜平负";
    [self.contentView addSubview: oLabel];
    
    UILabel *owLabel = [self LabelWithFrame: CGRectMake(115, 68, 40, 16) fontSize: 14 color: color];
    self.oddsWinLabel = owLabel;
    [self.contentView addSubview: self.oddsWinLabel];
    
    UILabel *odLabel = [self LabelWithFrame: CGRectMake(155, 68, 90, 16) fontSize: 14 color: color];
    odLabel.textAlignment = NSTextAlignmentCenter;
    self.oddsDrawLabel = odLabel;
    [self.contentView addSubview: self.oddsDrawLabel];
    
    UILabel *olLabel = [self LabelWithFrame: CGRectMake(255, 68, 40, 16) fontSize: 14 color: color];
    self.oddsLostLabel = olLabel;
    [self.contentView addSubview: self.oddsLostLabel];
	return self;
}

//插入主队和客队进球数
- (id)insertHomeAndAwayCell
{
	UIColor *color = [UIColor colorWithRed:(197)/255.0 green:(200)/255.0 blue:(207)/255.0 alpha:1];
	
	UILabel *hLabel = [self LabelWithFrame: CGRectMake(24, 6, 104, 16) fontSize: 14 color: color];
	self.homeLabel = hLabel;
	[self.contentView addSubview: self.homeLabel];
	
	UILabel *shLabel = [self LabelWithFrame: CGRectMake(132, 6, 16, 16) fontSize: 14 color: color];
	shLabel.textAlignment = NSTextAlignmentRight;
	self.scoreHostLabel = shLabel;
	[self.contentView addSubview: self.scoreHostLabel];

	UILabel *yLabel = [self LabelWithFrame: CGRectMake(149, 6, 6, 16) fontSize: 15 color: color];
	yLabel.text = @"-";
	[self.contentView addSubview: yLabel];
	
	UILabel *ahLabel = [self LabelWithFrame: CGRectMake(156, 6, 16, 16) fontSize: 14 color: color];
	self.awayHostLabel = ahLabel;
	[self.contentView addSubview: self.awayHostLabel];
	
	UILabel *aLabel = [self LabelWithFrame: CGRectMake(174, 6, 112, 16) fontSize: 14 color: color];
	aLabel.textAlignment = NSTextAlignmentCenter;
	self.awayLabel = aLabel;
	[self.contentView addSubview: self.awayLabel];
	
	[self.contentView setBackgroundColor: color];
	
	return self;
}


//插入类型
- (id)insertTypeCell
{
	UIColor *color = [UIColor colorWithRed:(211)/255.0 green:(214)/255.0 blue:(240)/255.0 alpha:1];
	
	//0 进球
	UIImageView *jqImageView = [self ImageWithFrame: CGRectMake(6, 6, 16, 16) image:UIImageGetImageFromName(IMAGE_JINQIU)];
	[self.contentView addSubview: jqImageView];
	
	UILabel *jqLabel = [self LabelWithFrame: CGRectMake(22, 8, 37, 16) fontSize: 13 color: color];
	jqLabel.text = @": 进球";
	[self.contentView addSubview: jqLabel];
	
	//1 点球
	UIImageView *dqImageView = [self ImageWithFrame: CGRectMake(66, 6, 16, 16) image:UIImageGetImageFromName(IMAGE_DIANQIU)];
	[self.contentView addSubview: dqImageView];
	
	UILabel *dqLabel = [self LabelWithFrame: CGRectMake(82, 8, 37, 16) fontSize: 13 color: color];
	dqLabel.text = @": 点球";
	[self.contentView addSubview: dqLabel];
	
	//2 乌龙
	UIImageView *wlImageView = [self ImageWithFrame: CGRectMake(125, 6, 16, 16) image:UIImageGetImageFromName(IMAGE_WULONG)];
	[self.contentView addSubview: wlImageView];
	
	UILabel *wlLabel = [self LabelWithFrame: CGRectMake(140, 8, 37, 16) fontSize: 13 color: color];
	wlLabel.text = @": 乌龙";
	[self.contentView addSubview: wlLabel];
	
	//3 黄牌
	UIImageView *hpImageView = [self ImageWithFrame: CGRectMake(184, 6, 16, 16) image:UIImageGetImageFromName(IMAGE_HUANGPAI)];
	[self.contentView addSubview: hpImageView];
	
	UILabel *hpLabel = [self LabelWithFrame: CGRectMake(200, 8, 37, 16) fontSize: 13 color: color];
	hpLabel.text = @": 黄牌";
	[self.contentView addSubview: hpLabel];
	
	//4 红牌
	UIImageView *hopImageView = [self ImageWithFrame: CGRectMake(244, 6, 16, 16) image:UIImageGetImageFromName(IMAGE_HONGPAI)];
	[self.contentView addSubview: hopImageView];
	
	UILabel *hopLabel = [self LabelWithFrame: CGRectMake(260, 8, 37, 16) fontSize: 13 color: color];
	hopLabel.text = @": 红牌";
	[self.contentView addSubview: hopLabel];
	
	[self.contentView setBackgroundColor: color];
	
	return self;
}


//插入主队和客队比赛事件列表
- (id)insertHomeAndAwayListCell
{
	UIScrollView *lScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, -0.5, 152.0, 180)];
	lScrollView.layer.masksToBounds = YES;
	lScrollView.layer.borderWidth = 0.5;
	lScrollView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	self.leftScrollView = lScrollView;
	[self.contentView addSubview: self.leftScrollView];
	[lScrollView release];
	
	UIScrollView *rScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(152, -0.5, 152.0, 180)];
	rScrollView.layer.masksToBounds = YES;
	rScrollView.layer.borderWidth = 0.5;
	rScrollView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	self.rightScrollView = rScrollView;
	[self.contentView addSubview: self.rightScrollView];
	[rScrollView release];
	
	return self;
}

- (id)insertHomeAndAwayListCellWithOdds
{
	UIScrollView *lScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, -0.5, 152.0, 148)];
	lScrollView.layer.masksToBounds = YES;
	lScrollView.layer.borderWidth = 0.5;
	lScrollView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	self.leftScrollView = lScrollView;
	[self.contentView addSubview: self.leftScrollView];
	[lScrollView release];
	
	UIScrollView *rScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(152, -0.5, 152.0, 148)];
	rScrollView.layer.masksToBounds = YES;
	rScrollView.layer.borderWidth = 0.5;
	rScrollView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	self.rightScrollView = rScrollView;
	[self.contentView addSubview: self.rightScrollView];
	[rScrollView release];
	
	return self;
}


//初始化标签
- (UILabel *)LabelWithFrame: (CGRect)rect fontSize: (NSInteger)size color: (UIColor *)color
{
	UILabel *label = [[[UILabel alloc] init] autorelease];
	
	label.frame = rect;
	
	[label setBackgroundColor: color];
	
	label.font = [UIFont fontWithName: @"Helvetica" size: size];
	
	label.textAlignment = NSTextAlignmentLeft;
	
	return label;

}


//初始化图片
- (UIImageView *)ImageWithFrame: (CGRect)rect image: (UIImage *)image
{
	UIImageView *imageView = [[[UIImageView alloc] initWithFrame: rect] autorelease];
	
	[imageView setImage: image];
	
	return imageView;
}



- (void)dealloc 
{	
	[leagueNameLabel release];
	[matchTimeLabel release];
	
	[asianHomeLabel release];
	[asianRangqiuLabel release];
	[asianAwayLabel release];
	
	[eurWinLabel release];
	[eurDrawLabel release];
	[eurLostLabel release];
	
    [oddsWinLabel release];
    [oddsDrawLabel release];
    [oddsLostLabel release];
    
	[homeLabel release];
	[awayLabel release];
	[scoreHostLabel release];
	[awayHostLabel release];
	
	[homeNameLabel release];
	[homeMinsLabel release];
	[awayNameLabel release];
	[awayMinsLabel release];
	
	[leftScrollView release];
	[rightScrollView release];
	
    [super dealloc];
}



@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    