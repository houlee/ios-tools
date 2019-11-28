//
//  ExpertPublishedTableViewCell.h
//  caibo
//
//  Created by cp365dev6 on 2016/12/1.
//
//

#import <UIKit/UIKit.h>
#import "BeenPlanSMGModel.h"
#import "BeenPlanHisModel.h"
#import "BuyPlanModel.h"

@interface ExpertPublishedTableViewCell : UITableViewCell
{
    CGSize size;
}
@property (nonatomic, strong) UIImageView *pointIma1;//比赛前面的小黄点
@property (nonatomic, strong) UIImageView *pointIma2;//比赛前面的小黄点
@property (nonatomic, strong) UILabel *teamNameLab1;//比赛1
@property (nonatomic, strong) UILabel *teamNameLab2;//比赛2    二串一用到
@property (nonatomic, strong) UILabel *matchTimeLab1;//联赛名字  比赛时间
@property (nonatomic, strong) UILabel *matchTimeLab2;//联赛名字  比赛时间
@property (nonatomic, strong) UIImageView *statueIma;//
@property (nonatomic, strong) UILabel *coinLab;//金币
@property (nonatomic, strong) UIImageView *lineIma;//
@property (nonatomic, strong) UIButton *tuiBtn;//

-(void)loadAppointInfo:(BeenPlanSMGModel *)data isErchuanyi:(BOOL)isErchuanyi;//竞彩    已发
-(void)loadAppointHistoryInfo:(BeenPlanHisModel *)data isErchuanyi:(BOOL)isErchuanyi;//二串一    已发

-(void)loadBuyAppointInfo:(BuyPlanModel *)data isErchuanyi:(BOOL)isErchuanyi;//已购

@end
