//
//  YrbSectionHeaderView.h
//  caibo
//
//  Created by  on 12-2-15.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YrbSectionHeaderViewDelegate;
@interface YrbSectionHeaderView : UIView

{
    UILabel *titleLabel;
    UIButton *disclosureButton;
    NSInteger section;
    id<YrbSectionHeaderViewDelegate> delegate;
    BOOL opened;
}

@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UIButton *disclosureButton;
@property (nonatomic, assign)NSInteger section;
@property (nonatomic, assign)id<YrbSectionHeaderViewDelegate> delegate;
@property (nonatomic, assign)BOOL opened;

- (id)initWithFrame:(CGRect)frame title:(NSString *)aTitle delegate:(id)aDelegate section:(NSInteger)aSection open:(BOOL)isOpened;
@end

@protocol YrbSectionHeaderViewDelegate <NSObject>

@optional
-(void)sectionHeaderView:(YrbSectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section;

-(void)sectionHeaderView:(YrbSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section;
@end

