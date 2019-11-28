//
//  LotteryPreferenceView.h
//  caibo
//
//  Created by  on 12-2-16.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LotteryPreferenceViewDelegate;
@interface LotteryPreferenceView : UIView
{
    UILabel *nameLabel;
    UIButton *markButton;
    
    BOOL marked;
    
    id <LotteryPreferenceViewDelegate> delegate;
    
    NSInteger section;
}

@property (nonatomic, retain)UILabel *nameLabel;
@property (nonatomic, retain)UIButton *markButton;
@property (nonatomic, assign)BOOL marked;
@property (nonatomic, assign)id <LotteryPreferenceViewDelegate> delegate;
@property (nonatomic, assign)NSInteger section;

- (id)initWithFrame:(CGRect)frame;
@end

@protocol LotteryPreferenceViewDelegate <NSObject>
@optional
-(void)lotteryPreferenceView:(LotteryPreferenceView*)preferenceView marked:(BOOL)isMarked title:(NSString *)aTitle section:(NSInteger)aSection;

@end