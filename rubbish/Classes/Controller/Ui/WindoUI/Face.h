//
//  Face.h
//  caibo
//
//  Created by jeff.pluto on 11-7-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CBClickFaceDelegate;

@interface Face : UIImageView <UIScrollViewDelegate> {
    id _delegate;
    
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    BOOL pageControlUsed;
    NSMutableArray *viewControllers;
    
    UIButton *addLinkM;
    UIButton *addTopic;
}

@property (readonly) UIScrollView *scrollView;
@property (readonly) UIPageControl *pageControl;
@property (readonly) UIButton *addLinkM;
@property (readonly) UIButton *addTopic;

@property (nonatomic,assign) id<CBClickFaceDelegate> delegate;

- (void) showFaceSystem : (CGPoint) p;
- (void) dismissFaceSystem;

@end

@protocol CBClickFaceDelegate
@end