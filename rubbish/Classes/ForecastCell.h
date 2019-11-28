//
//  ForecastCell.h
//  caibo
//
//  Created by  on 12-5-3.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForecastData.h"

@interface ForecastCell : UITableViewCell{
    UIView * viewcell;
    UILabel * nameLabel;
    UILabel * numLabel;
    ForecastData * data;
}
@property (nonatomic, retain)ForecastData * data;
@property (nonatomic, retain)UILabel * numLabel;
- (UIView *)returnviewcell;

@end
