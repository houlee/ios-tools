//
//  SwitchCell.h
//  iphone_control
//
//  Created by houchenguang on 12-12-5.
//  Copyright (c) 2012年 yaofuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CP_SWButton.h"
@protocol CPSwitchDelegate <NSObject>

- (void)switchReturnYesOrNo:(NSString *)yesorno section:(NSInteger)section row:(NSInteger)row;//返回第几段 第几行的开关的状态

@end
@interface SwitchCell : UITableViewCell{
 
    UILabel * titleLabel;
    UIImageView * bgimage;
    UIImageView * line;
    UIView * line2;
    CP_SWButton * switchyn;
    id<CPSwitchDelegate>delegate;
    NSInteger _section;
    NSInteger _row;
}

@property (nonatomic, retain)UILabel * titleLabel;
@property (nonatomic, retain)UIImageView * bgimage;
@property (nonatomic, retain)UIImageView * line;
@property (nonatomic, retain)UIView *line2;
@property (nonatomic, retain)CP_SWButton * switchyn;
@property (nonatomic, assign)id<CPSwitchDelegate>delegate;
@property (nonatomic, assign)NSInteger _section;
@property (nonatomic, assign)NSInteger _row;

- (void)switchReturnYesOrNo:(NSString *)yesorno section:(NSInteger)section row:(NSInteger)row;

@end
