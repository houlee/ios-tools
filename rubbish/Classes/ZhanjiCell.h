//
//  ZhanjiCell.h
//  caibo
//
//  Created by yao on 12-5-3.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineScrollView.h"

@interface ZhanjiCell : UITableViewCell<UIScrollViewDelegate> {
	UIView *titileBackView;
	UILabel *nameLabel;//队伍名称
	UILabel *scoreLabel;//比分
	UILabel *OpponentLabel;//对手
	UILabel *rowLabel;//轮次；
	UILabel *resultLabel;//胜平负
	LineScrollView *myScrol;//滑动scrollView；
	UIView *footBackView;//底部背景；
	UILabel *titlLabel;//战绩走势图文字
	NSInteger ID;// 战队ID；
	
	UIView *titileBackView2;
	UILabel *nameLabel2;//队伍名称
	UILabel *scoreLabel2;//比分
	UILabel *OpponentLabel2;//对手
	UILabel *rowLabel2;//轮次；
	UILabel *resultLabel2;//胜平负
	LineScrollView *myScrol2;//滑动scrollView；
	UIView *footBackView2;//底部背景；
	UILabel *titlLabel2;//战绩走势图文字
	NSInteger ID2;// 战队ID；
}

- (void)LoadData:(NSArray *)array IsHome:(BOOL) ishome WithID:(NSInteger)Id With:(NSString *)name;
- (void)LoadData:(NSArray *)array 
		   Array:(NSArray *)array2 
		  IsHome:(BOOL) ishome 
		  WithID:(NSInteger)Id 
		 WithID2:(NSInteger)Id2 
		WithName:(NSString *)name
	   WithName2:(NSString *)name2;

@end
