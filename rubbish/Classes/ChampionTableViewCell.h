//
//  ChampionTableViewCell.h
//  caibo
//
//  Created by houchenguang on 14-5-29.
//
//

#import <UIKit/UIKit.h>
#import "ChampionData.h"
typedef enum{
    championCellTypeShow,
    championSecondPlaceCellShow,

} ChampionCellType;

@interface ChampionTableViewCell : UITableViewCell{

//    UIImageView * headimage;//上半拉的图片
    UILabel * endTypeLabel;//截止 开售 状态label
    UILabel * teamLabel;//队名
    UIButton * matchButton;//下面的按钮
    UILabel * oddsLabel;//按钮上的赔率
    UIImageView * changhaoImage;//场号的背景
    UILabel * numLabel;//场号
    ChampionCellType cellType;
    ChampionData * championData;
    NSIndexPath * cellIndexPath;
    UILabel * keduiLabel;
//    UILabel * bifenLabel;
    id delegate;
    UIImageView * homeImageView;
    UIImageView * keduiImageView;
}

@property (nonatomic, assign)ChampionCellType cellType;
@property (nonatomic, retain)ChampionData * championData;
@property (nonatomic, retain)NSIndexPath * cellIndexPath;
@property (nonatomic, assign)id delegate;
@end


@protocol ChampionTableViewCellDelegate <NSObject>
@optional
- (void)championTableViewCell:(ChampionTableViewCell *)cell withData:(ChampionData *)data indexPath:(NSIndexPath *)indexPath selectBool:(BOOL)yesOrNo;
@end
