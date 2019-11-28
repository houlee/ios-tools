//
//  XiangQingCell.h
//  caibo
//
//  Created by  on 12-5-25.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiangQingCell : UITableViewCell{
    UIImageView * cellbgimage;
    UIView * cellview;
    UILabel * dengLabel;
    UILabel * zhushuLabel;
    UILabel * jiangjinLabel;
    UIImageView * lineimage;
}
@property (nonatomic, retain)UIImageView * cellbgimage;
@property (nonatomic, retain)UIView * cellview;
@property (nonatomic, retain)UILabel * dengLabel;
@property (nonatomic, retain)UILabel * zhushuLabel;
@property (nonatomic, retain)UILabel * jiangjinLabel;
@property (nonatomic, retain)UIImageView * lineimage;
- (UIView *)returnTableViewCellView;
@end
