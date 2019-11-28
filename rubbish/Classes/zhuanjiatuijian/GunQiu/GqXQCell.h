//
//  GqXQCell.h
//  caibo
//
//  Created by zhoujunwang on 16/5/27.
//
//

#import <UIKit/UIKit.h>
#import "SepratorLineView.h"
#import "GqMdl.h"

@interface GqXQCell : UITableViewCell{
    UIView  *topView;
    UIImageView *headImage;
    UIImageView *rvImgv;
    UILabel *labName;
    UIImageView *djImgV;
    UILabel *djLab;
    UIView *topViewLine;
    
    UIView  *gamePlanView;
    UILabel *gameNolab;//星期
    UIImageView *legImgView;//联赛背景
    UILabel *workNameLab;//联赛名称
    UILabel *gameTimeLab;//比赛时间
    UIView  *firSecLine;
    UILabel *scrlab;//比分
    UILabel *startNameLab;
    UILabel *endNameLab;
    UILabel *timeLab;//比赛进行时间
    UIView  *secSecLine;
    
    //滚球
    UIView *gqBgView;
    ChartFormView *gqCharView;
    UILabel *gqplab;
    UILabel *gqzlab;
    UILabel *gqklab;
    UIButton *gqsBtn;
    
    //推荐理由
    UIView *recResnView;
    UILabel *recLab;
    UILabel *contentLab;
    
    //方案创建时间
    UILabel *planCTlab;
}

- (void)creatCell;

- (void)setGqMdl:(GqXQMdl *)gqXQMdl;

@end
