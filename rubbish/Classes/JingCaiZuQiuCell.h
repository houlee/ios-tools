//
//  JingCaiZuQiuCell.h
//  caibo
//
//  Created by yao on 12-5-7.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JingCaiZuQiuCell : UITableViewCell {
	UILabel *numLabel;
	UILabel *saishiLabel;
	UILabel *duizhenLabel;
	UILabel *touzhuLabel;
	UILabel *rangLabel;
	UILabel *danLabel;
	UILabel *beginLabel;
	UILabel *endLabel;
	UILabel *beginInfoLabel;
	UILabel *endInfoLabel;
	
	UIView *shuxianView1;
	UIView *shuxianView2;
	UIView *shuxianView3;
	UIView *shuxianView4;
	UIView *shuxianView5;
	
	UIView *hengxianView1;
	UIView *hengxianView2;
}
- (void) LoadData:(NSDictionary *)dic IsFirst:(BOOL)isfirst LotteryId:(NSString *)lotteryId;

- (void)setLabelColor:(UIColor *)_color;
@end
