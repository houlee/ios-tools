//
//  SysAnnCell.h
//  caibo
//
//  Created by GongHe on 14-1-16.
//
//

#import <UIKit/UIKit.h>
#import "YtTopic.h"
#import "ImageStoreReceiver.h"

@interface SysAnnCell : UITableViewCell
{
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
@property (nonatomic,retain)UIImageView * xian;
@property (nonatomic,retain)UIImageView *infoImage;
@property (nonatomic,retain)UILabel *newsLabel;
@property (nonatomic,retain)UILabel *timeLabel;


@end
