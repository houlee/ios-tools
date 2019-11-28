//
//  GC_JingCaiCell.h
//  caibo
//
//  Created by cp365dev on 14-7-8.
//
//

#import <UIKit/UIKit.h>
#import "GC_shengfudata.h"
#import "ColorView.h"
#import "ChampionData.h"

typedef enum{
    gc_qitacelltype,
    gc_guanjuncelltype,
    gc_guanyajuncelltype,
    
    
} GC_InfoCellType;

@interface GC_JingCaiCell : UITableViewCell
{
    
    UILabel * qianlabel;  //赛事简称
    UILabel * leftlabel;  //主队
    UILabel * vslabel;     //VS
    UILabel * rightlabel;  //客队
    UILabel * rangqiuLabel;  //+1-1 是否让球
    
    UIImageView *danImage;  //是否胆投
    UILabel *resultLabel;    //彩果
    

    UIImageView *upXian;  //线
    
    GC_shengfudata * data;  //
    BOOL zuihoubool;
    UIImageView * cellimageview;

    NSInteger row;
    BOOL huntouBool;
    ChampionData * championData;

}
@property (nonatomic, assign)GC_InfoCellType cellType;
@property (nonatomic)BOOL zuihoubool,huntouBool;
@property (nonatomic, retain)GC_shengfudata * data;
@property (nonatomic, assign)NSInteger row;



- (UIView *)returntabelviewcell;

@end
