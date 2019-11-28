//
//  ExpertMainListTableViewCell.h
//  caibo
//
//  Created by cp365dev6 on 2016/11/22.
//
//

#import <UIKit/UIKit.h>
#import "ExpertMainListModel.h"
#import "SuperiorMdl.h"
#import "ExpertJingjiModel.h"

typedef void(^CoinButtonAction)(UIButton *button);

@interface ExpertMainListTableViewCell : UITableViewCell
{
    CGSize size;
}
@property (nonatomic, strong) UIImageView *headIma;//
@property (nonatomic, strong) UIImageView *rankingIma;//排名标识图 1 2 3
@property (nonatomic, strong) UIImageView *levelIma;//级别图段位图
@property (nonatomic, strong) UILabel *nameLab;//
@property (nonatomic, strong) UILabel *hitRateLab;//命中率
@property (nonatomic, strong) UILabel *levelLab;//级别段位
@property (nonatomic, strong) UIButton *recordBtn;//几中几
@property (nonatomic, strong) UIImageView *pointIma1;//比赛前面的小黄点
@property (nonatomic, strong) UIImageView *pointIma2;//比赛前面的小黄点
@property (nonatomic, strong) UILabel *teamNameLab1;//比赛1
@property (nonatomic, strong) UILabel *teamNameLab2;//比赛2    二串一用到
@property (nonatomic, strong) UIButton *liansaiBtn1;//联赛
@property (nonatomic, strong) UIButton *liansaiBtn2;//联赛
@property (nonatomic, strong) UILabel *matchTimeLab1;//比赛时间
@property (nonatomic, strong) UILabel *matchTimeLab2;//比赛时间
@property (nonatomic, strong) UILabel *commentLab;//推荐评语
@property (nonatomic, strong) UIButton *coinBtn;//金币
@property (nonatomic, strong) UIImageView *starIma;//皇冠图  明星有
@property (nonatomic, strong) UIButton *tuidanBtn;//是否可退单标识
@property (nonatomic, assign) BOOL isZhuanjia;//yes专家    no榜单
@property (nonatomic, strong) UIImageView *lineIma;
@property (nonatomic, copy) CoinButtonAction buttonAction;

@property(nonatomic,strong)UIImageView *rankImgView;//会员等级
@property(nonatomic,strong)UILabel *rankLab;//会员等级


-(void)loadAppointInfo:(ExpertMainListModel *)data;
-(void)loadProgramListInfo:(SuperiorMdl *)data;
-(void)loadYuecaiExpertListInfo:(ExpertJingjiModel *)data;//约彩专家首页列表
-(void)loadYuecaiRankListInfo:(ExpertMainListModel *)data;//约彩排行榜二串一

-(void)loadCSBasketExpertListInfo:(ExpertJingjiModel *)data;//疯狂体育首页篮彩

@end
