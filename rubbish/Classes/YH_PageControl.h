//
//  YH_PageControl.h
//  CIPG_ShowDemo
//
//  Created by yao on 11-3-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YH_PageControl : UIPageControl
{
    float dotWidth;//点的宽度
    float dotHeight;
    float spacing;//点的间距
    NSString * dotNormalImage;
    NSString * dotSelectImage;
}

@property (nonatomic, assign)float dotWidth;
@property (nonatomic, assign)float dotHeight;
@property (nonatomic, assign)float spacing;
@property (nonatomic, retain) NSString * dotNormalImage;
@property (nonatomic, retain) NSString * dotSelectImage;

@end
