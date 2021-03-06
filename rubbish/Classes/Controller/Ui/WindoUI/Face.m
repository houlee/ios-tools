//
//  Face.m
//  caibo
//
//  Created by jeff.pluto on 11-7-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Face.h"
#import "FaceSystem.h"
#import "caiboAppDelegate.h"


@implementation Face

@synthesize scrollView,pageControl,addTopic,addLinkM;
@synthesize delegate = _delegate;

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setUserInteractionEnabled:YES];
        [self setImage:UIImageGetImageFromName(@"kbd_facebackground.png")];
        
        viewControllers = [[NSMutableArray alloc] init];
        for (unsigned i = 0; i < 3; i++) {
            [viewControllers addObject:[NSNull null]];
        }
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 138)];
#ifdef isCaiPiaoForIPad
        scrollView.frame = CGRectMake(35, 0, 320, 138);
#endif
        [scrollView setDelegate:self];
        scrollView.scrollsToTop = NO;
        [scrollView setPagingEnabled:YES];
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, scrollView.frame.size.height);
        scrollView.backgroundColor = [UIColor clearColor];
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 138, 320, 30)];
        [pageControl setNumberOfPages:3];
        [pageControl setCurrentPage:0];
        [pageControl addTarget:self action:@selector(changePage:) forControlEvents:(UIControlEventValueChanged)];
        pageControl.backgroundColor = [UIColor clearColor];
        
        // 底部插入话题和@联系人按钮
        addLinkM = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [addLinkM setTag:1];
        [addLinkM setFrame:CGRectMake(57, 7, 70, 34)];
        [addLinkM setImage:UIImageGetImageFromName(@"addLinkMan.png") forState:(UIControlStateNormal)];
        [addLinkM setBackgroundImage:UIImageGetImageFromName(@"gray_btn_bg.png") forState:UIControlStateNormal];
        
        addTopic = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [addTopic setTag:0];
        [addTopic setFrame:CGRectMake(194, 7, 70, 34)];
        [addTopic setImage:UIImageGetImageFromName(@"addTopic.png") forState:(UIControlStateNormal)];
        [addTopic setBackgroundImage:UIImageGetImageFromName(@"gray_btn_bg.png") forState:UIControlStateNormal];
        
        UIImageView *back = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"gray_btn_bg.png")];
        [back setFrame:CGRectMake(0, 168, 320, 49)];
        [back setUserInteractionEnabled:YES];
        [back addSubview:addLinkM];
        [back addSubview:addTopic];
        
        [self addSubview:scrollView];
        [self addSubview:pageControl];
        [self addSubview:back];
        
//#ifdef isCaiPiaoForIPad
//        scrollView.frame = CGRectMake(0, 0, 390, 138);
//        pageControl.frame = CGRectMake(0, 138, 390, 30);
//#endif
        
        [back release];
    }
    return self;
}

- (void)loadFaceSystemViewWithPage:(int)page {
    if (page < 0) return;
    if (page >2) return;
    
    // 从内存中获取已加载过的视图，不重新构建
    FaceSystem *faceSystem = [viewControllers objectAtIndex:page];
    if ((NSNull *)faceSystem == [NSNull null]) {
        faceSystem = [[FaceSystem alloc] initWithPageNumber:page row:3 col:8];
        [faceSystem setController:_delegate];
        [viewControllers replaceObjectAtIndex:page withObject:faceSystem];
        [faceSystem release];
    }
    
    if (nil == faceSystem.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        faceSystem.frame = frame;
        [scrollView addSubview:faceSystem];
    }
}

// 滑动表情
- (void) scrollViewDidScroll:(UIScrollView *)sender {
    if (pageControlUsed) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    [self loadFaceSystemViewWithPage:page - 1];
    [self loadFaceSystemViewWithPage:page];
    [self loadFaceSystemViewWithPage:page + 1];
}

// 显示表情
- (void) showFaceSystem:(CGPoint)p {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [self setCenter:p];// 289;
    [UIView commitAnimations];
    
    [self loadFaceSystemViewWithPage:0];
}

// 关闭表情
- (void) dismissFaceSystem {
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    
#ifdef isCaiPiaoForIPad
    [self setCenter:CGPointMake(195, app.window.frame.size.height+44)];
#else
    [self setCenter:CGPointMake(160, app.window.frame.size.height+44)];
#endif
    
    
    
    [UIView commitAnimations];
}

- (IBAction)changePage:(id)sender {
    int page = (int)pageControl.currentPage;
    
    [self loadFaceSystemViewWithPage:page - 1];
    [self loadFaceSystemViewWithPage:page];
    [self loadFaceSystemViewWithPage:page + 1];
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
}

- (void) dealloc {
    [scrollView release];
    [pageControl release];
    [viewControllers release];
    
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    