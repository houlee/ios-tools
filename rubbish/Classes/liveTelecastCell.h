//
//  liveTelecastCell.h
//  caibo
//
//  Created by houchenguang on 13-6-26.
//
//

#import <UIKit/UIKit.h>
#import "liveTelecastData.h"

@protocol liveTelecastDelegate <NSObject>

- (void)liveTelecastCellReturn:(NSIndexPath *)index uiButton:(UIButton *)sender;

@end

typedef enum{
    
    liveTypeCell,
    myAttentionTypeCell,
    endTypeCell,
    
    
} scoreTypeCell;

@interface liveTelecastCell : UITableViewCell{
    
    UIImageView * cellbgImage;
   
    UILabel * matchNum;//场号
    UILabel * leagueMatches;//联赛
    UILabel * endTime;//结束时间
    UILabel * homeTeam;//主队
    UILabel * concedePoints;//让球
    UILabel * vsLabel;//vs
    UILabel * guestTeam;//客队
    
    UIImageView * xingImge;//星星
    
    
    UILabel * homeUpLabel;//主队下面的label
    UILabel * guestUpLabel;//客队下面的label
    UILabel * vsUpLabel;// vs下面的label
    //红黄牌根据数据显示 控件不动
    UIImageView * homeRed;//主队红牌黄牌
    UIImageView * homeYellow;//客队黄牌红牌
    
    UILabel * homeOneLabel;//主队第一个牌子上的数字
    UILabel * homeTwoLabel;//主队第二个牌子上的数字
    
    UIImageView * guestRed;//客队红牌黄牌
    UIImageView * guestYellow;//客队黄牌红牌
 
    UILabel * guestOneLabel;//客队第一个牌子上的数字
    UILabel * guestTwoLabel;//客队第二个牌子上的数字
    
    UIImageView * pptvImge;//pptv标志
    
    liveTelecastData * liveData;//数据
    NSIndexPath * indexPath;
    id<liveTelecastDelegate>delegate;
    UIButton * collectButton;
    scoreTypeCell typeCell;
    
    
}

@property (nonatomic, assign)scoreTypeCell typeCell;
@property (nonatomic, assign)id<liveTelecastDelegate>delegate;
@property(nonatomic , retain)NSIndexPath * indexPath;
@property (nonatomic, retain)liveTelecastData * liveData;


- (void)liveTelecastCellReturn:(NSIndexPath *)index uiButton:(UIButton *)sender;

@end
