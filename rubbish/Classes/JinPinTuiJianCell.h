//
//  JinPinTuiJianCell.h
//  caibo
//
//  Created by zhang on 1/9/13.
//
//

#import <UIKit/UIKit.h>
#import "YtTopic.h"
#import "ImageStoreReceiver.h"
#import "JinPinTuiJianData.h"
#import "DownLoadImageView.h"

@interface JinPinTuiJianCell : UITableViewCell{

    DownLoadImageView *LogoImage;//推荐程序Logo图片
    UILabel *AppName;//推荐程序名称
    UILabel *AppSize;//推荐程序大小
    UILabel *AppInfo;//推荐程序介绍
    
    JinPinTuiJianData * jpdata;
}
@property(nonatomic,retain)DownLoadImageView *LogoImage;
@property(nonatomic,retain)UILabel *AppName;
@property(nonatomic,retain)UILabel *AppSize;
@property(nonatomic,retain)UILabel *AppInfo;

@property (nonatomic, retain)JinPinTuiJianData *jpdata;


@end
