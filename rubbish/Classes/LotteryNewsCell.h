//
//  LotteryNewsCell.h
//  caibo
//
//  Created by yao on 11-12-6.
//  Copyright 2011 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YtTopic.h"
#import "ImageStoreReceiver.h"

@interface LotteryNewsCell : UITableViewCell {
	UIImageView *infoImage;//新闻图片
	UILabel *newsLabel;
	UILabel *timeLabel;
	ImageStoreReceiver *receiver;
	YtTopic *mStatus;
//    UILabel * plshu;
//    UIImageView * imagepl;
    UIImageView * xian;
}

- (void)LoadData:(YtTopic *)_data;
- (void)xianHidden;
@property (nonatomic,retain)YtTopic *mStatus;

@property (nonatomic,retain)UIImageView *infoImage;
@property (nonatomic,retain)UILabel *newsLabel;
@property (nonatomic,retain)UILabel *timeLabel;

@end
