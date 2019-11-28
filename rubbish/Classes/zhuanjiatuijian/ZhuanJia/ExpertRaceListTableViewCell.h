//
//  ExpertRaceListTableViewCell.h
//  caibo
//
//  Created by cp365dev6 on 2016/12/8.
//
//

#import <UIKit/UIKit.h>
#import "MatchVCModel.h"

@interface ExpertRaceListTableViewCell : UITableViewCell
{
    CGSize size;
}
@property (nonatomic, strong) UILabel *raceTimeLab;//时间
@property (nonatomic, strong) UILabel *homeTeamLab;//主队
@property (nonatomic, strong) UILabel *visitineTeamLab;//客队
@property (nonatomic, strong) UIImageView *VSimage;//
@property (nonatomic, strong) UILabel *recommendLab;//推荐数

-(void)loadAppointInfo:(MatchVCModel *)matchModel;
@end
