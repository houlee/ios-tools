//
//  HongRenBangCell.h
//  caibo
//
//  Created by houchenguang on 13-3-8.
//
//

#import <UIKit/UIKit.h>
#import "AnnouncementData.h"
#import "ImageStoreReceiver.h"
#import "DownLoadImageView.h"

@interface HongRenBangCell : UITableViewCell{
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
    NSInteger headnum;
   
    UIImageView * baimage;

    UIImageView * moneyimage;
  
    BOOL imagebool;
    BOOL headbool;
    UILabel * yuanlabel;
    BOOL ishemai;
    BOOL isdiyi;
}
@property (nonatomic, assign)BOOL imagebool, headbool, ishemai, isdiyi;
@property (nonatomic, retain)UIImageView * baimage;
@property (nonatomic, retain)UILabel * helabel;
@property (nonatomic, assign) NSInteger headnum;
@property (nonatomic, retain)NSString * imageUrl;
@property (nonatomic, retain)AnnouncementData * annou;
@property (nonatomic, retain)ImageStoreReceiver * receiver;


@end



