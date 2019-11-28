//
//  HorseRaceTableViewCell.h
//  caibo
//
//  Created by GongHe on 15-1-21.
//
//

#import <UIKit/UIKit.h>

@protocol HorseRaceTableViewCellDelegate <NSObject>

-(void)deleteLotteryNumberWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface HorseRaceTableViewCell : UITableViewCell
{
    UILabel * titleLabel;//标题
    UILabel * descriptionLabel;//描述
    UIView * line;//底部分割线
    UIView * lotteryNumView;//放红球的
    UILabel * fenLabel;//积分
    id <HorseRaceTableViewCellDelegate>delegate;
    NSIndexPath * myIndexPath;
}

@property (nonatomic, retain)UILabel * titleLabel;
@property (nonatomic, retain)UILabel * descriptionLabel;
@property (nonatomic, retain)UIView * line;
@property (nonatomic, retain)UIView * lotteryNumView;
@property (nonatomic, retain)UILabel * fenLabel;
@property (nonatomic, retain)NSIndexPath * myIndexPath;

@property (nonatomic, assign)id <HorseRaceTableViewCellDelegate>delegate;

-(void)setLotteryNumberByString:(NSString *)lotteryNum;

@end
