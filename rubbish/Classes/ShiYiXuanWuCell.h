//
//  ShiYiXuanWuCell.h
//  caibo
//
//  Created by yao on 12-6-18.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CP_PTButton.h"

@protocol ShiYiXuanWuCellDelegate

- (void)deleteCell:(UITableViewCell *)shuangseCell;

@end

@interface ShiYiXuanWuCell : UITableViewCell {
	UILabel *numLabel;//投注内容；
	UILabel *zhuLabel;//注数金额；
	UILabel *wanfaLabel;//彩种玩法
	CP_PTButton *shanchuBtn;
	UIButton *jianBtn;
	id shiyixuanwuCellDelegate;
	UIImageView *backImage;
//    UIImageView *shanchuIma;
//    CP_PTButton *shanchuButton;
    UIImageView *lineIma;
}

- (void)LoadData:(NSDictionary *)dic;
@property (nonatomic,assign)id<ShiYiXuanWuCellDelegate> shiyixuanwuCellDelegate;

@end
