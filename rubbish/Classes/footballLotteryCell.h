//
//  footballLotteryCell.h
//  caibo
//
//  Created by houchenguang on 13-6-19.
//
//

#import <UIKit/UIKit.h>
#import "footballLotterData.h"
#import "CP_KindsOfChoose.h"

typedef enum{
    
    jingcaishengpingfucell,
    jingcairangqiushengpingfucell,
    jingcaibifencell,
    jingcaizongjinqiucell,
    jincaibanquanchangcell,
    jingcaishengfenchacell,
    jingcaidaxiaofencell,
    jingcairangqiushengfucell,
    jingcaishengfucell,
    beidanrangqiushengpingfucell,
    beidanshangxiapandanshuangcell,
    beidanbanquanshengpingfucell,
    beidanbifencell,
    beidanzongjinqiucell
    
    
}footBallTypeCell;

typedef enum{
    
    jingcaizuqiuType,
    jingcailanqiuType,
    beijingdanchangType,
    
    
} lotteryTypex;

@protocol footBallDelegate <NSObject>

- (void)selectButtonReturn:(UIButton *)sender mutableArray:(NSMutableArray *)array index:(NSIndexPath *)index;

@end


@interface footballLotteryCell : UITableViewCell<CP_KindsOfChooseDelegate>{
    
    footBallTypeCell fbTypeCell;//玩法的类型
    footballLotterData * footBallData;//cell数据对象
    lotteryTypex lottery;//大彩种  彩种
    
    UILabel * weekLabel;//周几
    UILabel * matchNum;//场号
    UILabel * leagueMatches;//联赛名
    UILabel * endTime;//结束时间
    UILabel * homeTeam;//主队
    UILabel * guestTeam;//客队
    UILabel * concedePoints;//让球
    UILabel * score;//比分
    UIImageView * cellbgImage;//cell背景图
    NSString * selectButton;//选中第几个button 1 2 3 4 5
    id<footBallDelegate>delegate;
    NSMutableArray * kongzhiType;
    NSMutableArray * caiguoArray;//彩果数组
    NSMutableArray * allPeiArray;//保存选中按钮里的所有对象
    NSInteger buttonTag;//保存点的那个按钮的tag值
    NSMutableArray * saveButton;//保存每个按钮；
    NSIndexPath * selectIndexPath;//第几断 第几行
}

@property (nonatomic, retain)NSIndexPath *selectIndexPath;
@property   (nonatomic, retain)NSMutableArray * saveButton;
@property (nonatomic, assign)footBallTypeCell fbTypeCell;
@property (nonatomic, assign)lotteryTypex lottery;
@property (nonatomic, retain)footballLotterData * footBallData;
@property (nonatomic, assign)id<footBallDelegate>delegate;
@property (nonatomic, retain)NSString * selectButton;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier lotterType:(lotteryTypex)lotype;

- (void)selectButtonReturn:(UIButton *)sender mutableArray:(NSMutableArray *)array index:(NSIndexPath *)index;
@end
