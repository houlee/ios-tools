//
//  ShiPinCell.h
//  caibo
//
//  Created by  on 12-5-31.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShiPinData.h"

@interface ShiPinCell : UITableViewCell{
    UILabel * timeLabel;
    UILabel * infoLabel;
    UIImageView * zhiboImagle;
    ShiPinData * shipindata;
}
@property (nonatomic, retain)ShiPinData * shipindata;
@property(nonatomic, retain)UILabel * timeLabel,* infoLabel;
@property (nonatomic, retain)UIImageView * zhiboImagle;
- (UIView *)returnTableViewCellView;
@end
