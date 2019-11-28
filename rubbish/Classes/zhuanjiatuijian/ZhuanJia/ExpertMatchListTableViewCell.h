//
//  ExpertMatchListTableViewCell.h
//  caibo
//
//  Created by cp365dev6 on 2016/11/22.
//
//

#import <UIKit/UIKit.h>
#import "MatchVCModel.h"

@interface ExpertMatchListTableViewCell : UITableViewCell
{
    CGSize size;
}
@property (nonatomic, strong) UILabel *matchLab;//联赛名字
@property (nonatomic, strong) UILabel *teamLab;//赛队名字
@property (nonatomic, strong) UILabel *dateLab;//时间
@property (nonatomic, strong) UIButton *recommendBtn;//推荐数
@property (nonatomic, strong) UILabel *shengLab;//胜
@property (nonatomic, strong) UILabel *pingLab;//平
@property (nonatomic, strong) UILabel *fuLab;//负

-(void)loadAppointInfo:(MatchVCModel *)matchModel;
@end
