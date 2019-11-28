//
//  RejectedCell.h
//  caibo
//
//  Created by v1pin on 15/12/16.
//
//

#import <UIKit/UIKit.h>

@protocol RejectedCellDelegate <NSObject>

@optional

- (void)deleteRejectCell:(UITapGestureRecognizer *)tap;
- (void)clickDetailCell:(UITapGestureRecognizer *)tap;

@end

@interface RejectedCell : UITableViewCell<RejectedCellDelegate>
{
    UILabel * _dataWeek;  //--星期日期
    UIButton * _contestType;  //--比赛的类型：如 英超 意甲；
    UILabel * _contestTime;   //--开赛的时间
    UILabel * _contestName; // --比赛的队名
    UIImageView * _statusImg; // 推荐是否中
    
    UILabel * _contestStatus; // -- 比赛状态
    UILabel * _contestPrice;  // -- 比赛的价格
    
    UIScrollView *cellScroll;//cell上的滚动条
    
}

@property (nonatomic,weak) id<RejectedCellDelegate> rejectDelegate;

@property (nonatomic,strong)UILabel *deletelab;
@property (nonatomic,strong)UIView *mainView;//内容画布

//已发方案（最新推荐）
-(void)rejectDataWeek:(NSString *)dataWeek contestType:(NSString *)contestType contestTime:(NSString *)contestTime contestName:(NSString *)contestName statusImg:(NSString *)statusImg;

//已发方案（历史战绩）
-(void)rejectDataWeek:(NSString *)dataWeek contestType:(NSString *)contestType contestTime:(NSString *)contestTime contestName:(NSString *)contestName contestStatus:(NSString *)contestStatus contestPrice:(NSString *)contestPrice;

@end
