//
//  ShenFuCaiCell.h
//  caibo//胜负彩展示
//
//  Created by yao on 12-5-8.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShenFuCaiCell : UITableViewCell {
	UILabel *numLabel;
	UILabel *saishiLabel;
	UILabel *duizhenLabel;
	UILabel *shengLabel;
	UILabel *pingLabel;
	UILabel *fuLabel;
	
	UIView *shuxianView1;
	UIView *shuxianView2;
	UIView *shuxianView3;
	UIView *shuxianView4;
	UIView *shuxianView5;
	
	UIView *hengxianView;
}

- (void)LoadData:(NSDictionary *)dic;
- (void)setLabelColor:(UIColor *)_color;

@end
