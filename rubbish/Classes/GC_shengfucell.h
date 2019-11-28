//
//  GC_shengfucell.h
//  caibo
//
//  Created by  on 12-5-17.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GC_shengfudata.h"
#import "ColorView.h"
#import "ChampionData.h"

typedef enum{
    qitacelltype,
    guanjuncelltype,
    guanyajuncelltype,
    
    
} InfoCellType;

@interface GC_shengfucell : UITableViewCell{
    UIView * view;
    UILabel * leftlabel;
    UILabel * cuLabel;
    UIImageView * rightimage;
    GC_shengfudata * data;
    BOOL fenzhong;
    BOOL zuihoubool;
    UIImageView * bgimage;
    UIImageView * cellimageview;
    UILabel * qianlabel;
    UILabel * youlabel;
    UIImageView * line1;
    UIImageView * line2;
    UIImageView * line3;
    UIImageView * line4;
    UIImageView * danimageview;
    NSInteger row;
    BOOL huntouBool;
    UILabel * rangqiuLabel;
    ColorView * changciView;
    ChampionData * championData;
 
}
@property (nonatomic, assign)InfoCellType cellType;
@property (nonatomic)BOOL fenzhong, zuihoubool,huntouBool;
@property (nonatomic, retain)GC_shengfudata * data;
@property (nonatomic, assign)NSInteger row;



- (UIView *)returntabelviewcell;
@end
