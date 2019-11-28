//
//  YLHomeViewController.h
//  caibo
//
//  Created by houchenguang on 15/3/9.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "StatePopupView.h"
#import "CP_TabBarViewController.h"
#import "ASIHTTPRequest.h"
#import "MyWebViewController.h"
@interface YLHomeViewController : CPViewController<UIScrollViewDelegate,CP_TabBarConDelegate,MyWebViewDelegate>{

    UIView * bigView;
    UIImageView * upImageView;
    StatePopupView * statepop;
    UIButton * goButton;
    NSInteger counhaoyou;
    CP_TabBarViewController * tab;


    UIButton * zcButton;
    NSString * passWord;
    ASIHTTPRequest * requestUserInfo;
    int con;
    NSInteger counttag;
    int  selectedTab;


}

@property (nonatomic, retain)NSString * passWord;
@property (nonatomic, retain)ASIHTTPRequest * requestUserInfo;

- (void)homeAnimationFunc;
- (void)yanchidiao;
- (void)pressbfsp;
- (void)goWeibo;
- (void)goGonglue;
- (void)goYule;

@end
