//
//  MatchDetailCell.h
//  caibo
//
//  Created by user on 11-8-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IMAGE_JINQIU @"icon_jinqiu.png"
#define IMAGE_DIANQIU @"icon_dianqiu.png"
#define IMAGE_WULONG @"icon_wulong.png"
#define IMAGE_HUANGPAI @"icon_huangpai.png"
#define IMAGE_HONGPAI @"icon_hongpai.png"

@interface MatchDetailCell : UITableViewCell {

	UILabel *leagueNameLabel;          //联赛名
	UILabel *matchTimeLabel;           //开赛时间
	
	UILabel *asianHomeLabel;           //亚盘主队
	UILabel *asianRangqiuLabel;        //亚盘让球
	UILabel *asianAwayLabel;           //亚盘客队
	
	UILabel *eurWinLabel;              //欧盘主胜
	UILabel *eurDrawLabel;             //欧盘平
	UILabel *eurLostLabel;             //欧盘客胜
	
    UILabel *oddsLabel;              
	UILabel *oddsDrawLabel;             
	UILabel *oddsLostLabel;            

	UILabel *homeLabel;                //主队
	UILabel *awayLabel;                //客队
	UILabel *scoreHostLabel;           //主队进球数
	UILabel *awayHostLabel;            //客队进球数
	
	NSInteger homeType;                //比赛中主队球员所判类型
	UILabel *homeNameLabel;            //主队球员姓名
	UILabel *homeMinsLabel;            //主队球员被判时时间
	NSInteger awayType;                //比赛中客队球员所判类型
	UILabel *awayNameLabel;            //客队球员姓名
	UILabel *awayMinsLabel;            //客队球员被判时时间
	
	UIScrollView *leftScrollView;
	UIScrollView *rightScrollView;
}
@property (nonatomic, retain) UILabel *leagueNameLabel;
@property (nonatomic, retain) UILabel *matchTimeLabel;

@property (nonatomic, retain) UILabel *asianHomeLabel;
@property (nonatomic, retain) UILabel *asianRangqiuLabel;
@property (nonatomic, retain) UILabel *asianAwayLabel;

@property (nonatomic, retain) UILabel *eurWinLabel;
@property (nonatomic, retain) UILabel *eurDrawLabel;
@property (nonatomic, retain) UILabel *eurLostLabel;

@property (nonatomic, retain) UILabel *oddsWinLabel;
@property (nonatomic, retain) UILabel *oddsDrawLabel;
@property (nonatomic, retain) UILabel *oddsLostLabel;

@property (nonatomic, retain) UILabel *homeLabel;
@property (nonatomic, retain) UILabel *awayLabel;
@property (nonatomic, retain) UILabel *scoreHostLabel;
@property (nonatomic, retain) UILabel *awayHostLabel;

@property (nonatomic, assign) NSInteger homeType;
@property (nonatomic, retain) UILabel *homeNameLabel;
@property (nonatomic, retain) UILabel *homeMinsLabel;
@property (nonatomic, assign) NSInteger awayType;
@property (nonatomic, retain) UILabel *awayNameLabel;
@property (nonatomic, retain) UILabel *awayMinsLabel;

@property (nonatomic, retain) UIScrollView *leftScrollView;
@property (nonatomic, retain) UIScrollView *rightScrollView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

//插入联赛名称和开赛时间视图单元
- (id)insertLeagueTimeCell;

//插入亚盘和欧盘数据
- (id)insertAsianEurCell;

//插入主队和客队进球数
- (id)insertHomeAndAwayCell;

//插入主队和客队比赛事件列表
- (id)insertHomeAndAwayListCell;
- (id)insertHomeAndAwayListCellWithOdds;
- (id)insertAsianEurCellWithOdds;
//插入类型
- (id)insertTypeCell;

//初始化标签
- (UILabel *)LabelWithFrame: (CGRect)rect fontSize: (NSInteger)size color: (UIColor *)color;

//初始化图片
- (UIImageView *)ImageWithFrame: (CGRect)rect image: (UIImage *)image;


@end
