//
//  StatePopupView.h
//  caibo
//
//  Created by Kiefer on 11-6-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StatePopupView :  UIView
{
    UIActivityIndicatorView *progressIV;
    UILabel *lbText;
}

// 单例
+ (StatePopupView*)getInstance;
// 弹出状态框显示
- (void)showInView:(UIView*)view Text:(NSString*)text;
// 弹出状态框消失
- (void)dismiss;

@end
