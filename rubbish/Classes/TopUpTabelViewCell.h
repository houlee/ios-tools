//
//  TopUpTabelViewCell.h
//  caibo
//
//  Created by GongHe on 13-10-25.
//
//

#import <UIKit/UIKit.h>
#import "DownLoadImageView.h"

@interface TopUpTabelViewCell : UITableViewCell
{
    NSArray * arr;
    UIImageView * BGImageView;
    DownLoadImageView * logoImgeView;
    UILabel * titleLabel,* titleLabel1,* detailLabel;
}
@property(nonatomic,retain)NSArray * arr;
@property(nonatomic,retain)UIImageView * BGImageView;
@property(nonatomic,retain)DownLoadImageView * logoImgeView;
@property(nonatomic,retain)UILabel * titleLabel,* titleLabel1,* detailLabel;
@end
