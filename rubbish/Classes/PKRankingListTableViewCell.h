//
//  PKRankingListTableViewCell.h
//  caibo
//
//  Created by GongHe on 15-1-19.
//
//

#import <UIKit/UIKit.h>
#import "DownLoadImageView.h"


@interface PKRankingListTableViewCell : UITableViewCell
{
    UIImageView * medalImageView;//奖牌图片
    //    UIImageView * userImageView;//用户头像
    UILabel * userNameLabel;//用户名
    UILabel * earningsLabel;//收益
    UILabel * winningsLabel;//奖金
    UILabel * mingciLab;//名次
    DownLoadImageView *userImageView;//用户头像
}

@property (nonatomic, retain)UIImageView * medalImageView;
@property (nonatomic, retain)DownLoadImageView * userImageView;
@property (nonatomic, retain)UILabel * userNameLabel;
@property (nonatomic, retain)UILabel * earningsLabel;
@property (nonatomic, retain)UILabel * winningsLabel;
@property (nonatomic, retain)UILabel * mingciLab;

@end
