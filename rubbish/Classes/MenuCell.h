//
//  MenuCell.h
//  iphone_control
//
//  Created by houchenguang on 12-12-5.
//  Copyright (c) 2012年 yaofuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell{
    
    UIImageView * headImage;
    UILabel * titleLabel;
    UIImageView * bgimage;
    UIImageView * line;
}

@property (nonatomic, retain)UIImageView * headImage;
@property (nonatomic, retain)UILabel * titleLabel;
@property (nonatomic, retain)UIImageView * bgimage;
@property (nonatomic, retain)UIImageView * line;

@end
