//
//  RankingListTableViewCell.h
//  caibo
//
//  Created by houchenguang on 14-3-13.
//
//

#import <UIKit/UIKit.h>
#import "AnnouncementData.h"
#import "ImageStoreReceiver.h"
#import "DownLoadImageView.h"

@interface RankingListTableViewCell : UITableViewCell{
    UIView * view;//返回的view
    DownLoadImageView * headImage;//头像
    UILabel * userName;//用户名
    UILabel * moneyLabel;//钱数
    UIImageView * level1;//等级
    UIImageView * level2;
    UIImageView * level3;
    UIImageView * level4;
    UIImageView * level5;
    UIImageView * level6;
    UILabel * levLabel1;//等级数字
    UILabel * levLabel2;
    UILabel * levLabel3;
    UILabel * levLabel4;
    UILabel * levLabel5;
    UILabel * levLabel6;
    AnnouncementData * annou;
    ImageStoreReceiver * receiver;
    NSString * imageUrl;
    UIImageView * baimage;
    UIImageView * moneyimage;
    UILabel * yuanlabel;
    UILabel * wanfaLabel;
    
    UIImageView * gradeImage;
    UILabel * gradeLabel;
    NSIndexPath * indexPathCell;
    
    
}
@property (nonatomic, assign)BOOL imagebool, headbool, ishemai, isdiyi;
@property (nonatomic, retain)UIImageView * baimage;
@property (nonatomic, retain)UILabel * helabel;
@property (nonatomic, retain)NSString * imageUrl;
@property (nonatomic, retain)AnnouncementData * annou;
@property (nonatomic, retain)ImageStoreReceiver * receiver;
@property (nonatomic, retain)NSIndexPath * indexPathCell;


@end
