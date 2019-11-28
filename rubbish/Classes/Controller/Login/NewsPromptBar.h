//
//  NewsPromptBar.h
//  caibo
//
//  Created by Kiefer on 11-7-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsPromptBar : UIView 
{
    UIView *mView;
    UILabel *textLb;
}

@property(nonatomic, retain) UILabel *textLb;

// 有新微博提示栏
+ (NewsPromptBar*)getInstance;
// 下降
- (void)viewOpen;
// 上升
- (void)viewClose;

- (void)showInView:(UIView*)view;

- (void)dimissInView;

- (void)add;

- (void)remove;



@end
