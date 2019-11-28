//
//  ExpertDetailListTableViewCell.h
//  caibo
//
//  Created by cp365dev6 on 2016/11/30.
//
//

#import <UIKit/UIKit.h>
#import "ExpertDetail.h"

typedef void(^DidSelectLookButtonAction)(NSString *message);

@interface ExpertDetailListTableViewCell : UITableViewCell
{
    CGSize size;
}
@property (nonatomic, strong) UIImageView *pointIma1;//比赛前面的小黄点
@property (nonatomic, strong) UIImageView *pointIma2;//比赛前面的小黄点
@property (nonatomic, strong) UILabel *teamNameLab1;//比赛1
@property (nonatomic, strong) UILabel *teamNameLab2;//比赛2    二串一用到
@property (nonatomic, strong) UILabel *matchTimeLab1;//联赛名字  比赛时间
@property (nonatomic, strong) UILabel *matchTimeLab2;//联赛名字  比赛时间
@property (nonatomic, strong) UILabel *commentLab;//推荐评语
@property (nonatomic, strong) UIButton *lookBtn;//查看详情
@property (nonatomic, strong) UIImageView *statueIma;//
@property (nonatomic, strong) UIImageView *lineIma;//

@property (nonatomic, copy) DidSelectLookButtonAction lookButtonAction;

-(void)loadAppointInfo:(NewPlanList *)data;
-(void)loadAppointHistoryInfo:(HistoryPlanList *)data;

@end
