//
//  EveryDayForecastCell.h
//  caibo
//
//  Created by GongHe on 14-1-16.
//
//

#import <UIKit/UIKit.h>

enum{
    WhiteRed,
    Red,
    WhiteBlue,
    Blue
}displayColor;

@interface EveryDayForecastCell : UITableViewCell
{
    UILabel * lotteryNameLabel;
    UIImageView * bgImageView;
    UILabel * issueLabel;
}

@property(nonatomic,retain)UIImageView * bgImageView;//背景
@property(nonatomic,retain)UILabel * lotteryNameLabel;//彩种名称
@property(nonatomic,retain)UILabel * issueLabel;//期次

@end
