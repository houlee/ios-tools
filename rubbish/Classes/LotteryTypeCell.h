//
//  LotteryTypeCell.h
//  caibo
//
//  Created by  on 12-2-6.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LotteryTypeCell : UITableViewCell
{
    UILabel *typeName;
    UIButton *customSelectButton;
}
@property (nonatomic, retain)UILabel *typeName;
@property (nonatomic, retain)UIButton *customSelectButton;

- (void)initTypeLabel;
- (void)initSelectButton;
@end
