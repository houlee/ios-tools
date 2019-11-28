//
//  LotteryPreferenceCell.h
//  caibo
//
//  Created by  on 12-2-16.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryPreferenceView.h"
typedef enum {
    CustomStyleOne,
    CustomStyleTwo
}CustomStyle;
@interface LotteryPreferenceCell : UITableViewCell

{
    CustomStyle customStyle;
    
    LotteryPreferenceView *preferenceOneView;
    LotteryPreferenceView *preferenceTwoView;
}

@property (nonatomic, assign)CustomStyle customStyle;
@property (nonatomic, retain)LotteryPreferenceView *preferenceOneView;
@property (nonatomic, retain)LotteryPreferenceView *preferenceTwoView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier customStyle:(CustomStyle)custom;
- (void)initWithCustomOne;
- (void)initWithCustomTwo;

@end
