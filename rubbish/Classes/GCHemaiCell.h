//
//  GCHemaiCell.h
//  caibo
//
//  Created by  on 12-6-26.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchemeInfo.h"
#import "DACircularProgressView.h"

@interface GCHemaiCell : UITableViewCell{

    UILabel * baifenLabel;
    UILabel *baiFenHaoLabel;
    UILabel * moneyLabel;
    UILabel * userName;
    UIImageView * level1;//等级
    UIImageView * level2;
    UIImageView * level3;
    UIImageView * level4;
    UIImageView * level5;
    UIImageView * level6;
    UILabel * levLabel1;//等级数字
    UILabel * levLabel2;
    UILabel * levLabel3;
    UILabel * levLabel4;
    UILabel * levLabel5;
    UILabel * levLabel6;
    UILabel * yuanLabel;
    UILabel * allMoney;
   // ColorView * colorView;
    UILabel * shenglabel;
    UILabel * numLabel;
    UILabel * fenlabel;
    UIImageView * baoimage;
    UILabel * baoCount;
    UILabel * baoLabel;
    SchemeInfo * schem;
    UIImageView * haoshengyinimage;
    DACircularProgressView *progressView;
    
    UIImageView *zhidingImage;
    CGSize expectedSize1;
}

@property (nonatomic, retain)SchemeInfo * schem;
- (UIView *)returnTableViewCell;

@end
