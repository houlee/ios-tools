//
//  FootListTableViewCell.h
//  caibo
//
//  Created by houchenguang on 14-5-23.
//
//

#import <UIKit/UIKit.h>

typedef enum{
    
    homeCellType,
    guestCellType,
    historyCellType,

} CellListType;

@interface FootListTableViewCell : UITableViewCell{

    CellListType listType;
    UIButton * macthButton;//联赛名背景 按钮
    UILabel * macthLabel;//联赛名
    UIButton * teamButton;//队名背景按钮
    UILabel * homeLabel;//主队名
    UILabel * guestLabel;//客队名
    UILabel * scoreLabel;//比分
    UIImageView * coldImage;//冷
    UIImageView * oneLineImage;//左边cell的横线
    UILabel * shengLabel;//左边胜赔率
    UILabel * pingLabel;//左边平赔率
    UILabel * fuLabel;//左边负赔率
    UILabel * leftScoreLabel;//左边比分
    UILabel * timeLabel;//左边时间
    UIImageView * oneColdImage;//左边冷
    UIImageView * twoColdImage;//左边冷
    UIImageView * threeColdImage;//左边冷
    id delegate;
    NSIndexPath * footIndexPath;
    NSMutableDictionary * analyzeDictionary;//分析中心数据
    NSString * teamID;
    NSString * keyString;
    UIImageView * shulineImage;
    UIImageView * jiaImageView;
    UIImageView * macthJiaImageView;
    
}
@property (nonatomic, assign)CellListType listType;
@property (nonatomic, assign)id delegate;
@property (nonatomic, retain)NSIndexPath * footIndexPath;
@property (nonatomic, retain)NSMutableDictionary * analyzeDictionary;//分析中心数据
@property (nonatomic, retain)NSString * teamID, * keyString;
@property (nonatomic, retain)UILabel * macthLabel;


@end

@protocol FootListDelegate <NSObject>
@optional
- (void)FootListTableViewCell:(FootListTableViewCell *)cell macthTouch:(BOOL)macthBool teamButtonTouch:(BOOL)teamBool indexPath:(NSIndexPath *)indexPath dict:(NSDictionary *)dataDict;//macthBool为YES 触发赛事对阵  teamBool为YES  触发对阵弹框
@end

