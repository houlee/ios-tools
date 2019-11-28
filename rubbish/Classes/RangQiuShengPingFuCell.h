//
//  RangQiuShengPingFuCell.h
//  caibo 让球胜平负
//
//  Created by yao on 12-5-8.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RangQiuShengPingFuCell : UITableViewCell {
	UILabel *numLabel;
	UILabel *saishiLabel;
	UILabel *duizhenLabel;
	UILabel *rangLabel;
	UILabel *shengLabel;
	UILabel *pingLabel;
	UILabel *fuLabel;
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
	UIView *shuxianView6;
	
	UIView *hengxianView1;
	UIView *hengxianView2;

}

- (void) LoadData:(NSDictionary *)dic IsFirst:(BOOL)isfirst LotteryId:(NSString *)lotteryId;

@end
