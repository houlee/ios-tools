//
//  GCGuoGuanCell.h
//  caibo
//
//  Created by  on 12-6-15.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCGuoGuanData.h"
#import "ColorView.h"

@protocol GCGuoGuanDelegate <NSObject>

@optional
- (void)returnGuoGanInfo:(GCGuoGuanDataDetail *)ggdata indexr:(NSIndexPath *)indexrow;


@end

@interface GCGuoGuanCell : UITableViewCell{
    UIImageView * bgCellImage;
    UIImageView * lockImage;
    UILabel * userName;
//    UIImageView * level1;//等级
//    UIImageView * level2;
//    UIImageView * level3;
//    UIImageView * level4;
//    UIImageView * level5;
//    UIImageView * level6;
    UILabel * levLabel1;//等级数字
    UILabel * levLabel2;
    UILabel * levLabel3;
    UILabel * levLabel4;
    UILabel * levLabel5;
    UILabel * levLabel6;
    id<GCGuoGuanDelegate>delegate;
   
    ColorView * zhongLabel;//中几场文字
    
    ColorView * allrightLab;
    ColorView * wrongLabel;
    GCGuoGuanDataDetail * guoGuanData;
    NSIndexPath * rowcount;
    BOOL panduanme;
    UIImageView * nageiamge;
    UIImageView * jiantou;
    UIView *cellLine;
    UIView *cellLine2;
    

}
@property (nonatomic, retain)UIView *cellLine;
@property (nonatomic, retain)UIView *cellLine2;
@property (nonatomic, retain)NSIndexPath * rowcount;
@property (nonatomic, retain)GCGuoGuanDataDetail * guoGuanData;
@property (nonatomic, assign)id<GCGuoGuanDelegate>delegate;
@property (nonatomic, assign)BOOL panduanme;
@property (nonatomic, retain)UILabel *userName;

- (UIView *)returnTabelViewCell;
- (void)returnGuoGanInfo:(GCGuoGuanDataDetail *)ggdata indexr:(NSIndexPath *)indexrow;
@end
