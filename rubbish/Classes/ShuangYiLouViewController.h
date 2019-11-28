//
//  ShuangYiLouViewController.h
//  caibo
//
//  Created by yao on 12-5-19.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@class GouCaiShuZiInfoViewController;
@interface ShuangYiLouViewController : UIViewController<UIAlertViewDelegate ,ASIHTTPRequestDelegate, UIScrollViewDelegate> {
	NSString *item;
    UIScrollView * scrollView;
    UIPageControl *pageControl;
    UIView * numView;
    NSInteger numpage;
    UIImageView * huaDongImage;
    NSMutableArray * yiLouShu;//遗漏数
    NSMutableArray * issueArray;//期数
    UIImageView * qiuimageview;
    int buf[50];
    NSMutableDictionary * qiuGeShu;
    NSMutableArray * arrbutton;
    int cout;
    int coutqiushu;
    UIScrollView * qiuscrollView;
    int bluecout;
    UIView * currView;
    BOOL blueRed;
    UIPageControl * pagecon;
    NSMutableArray * paixuarray;
    BOOL jianqiu;
    GouCaiShuZiInfoViewController * goucai;
    UIBarButtonItem *rightItem;
    UIButton * leftButton;
    UIButton * rightButton;
    ASIHTTPRequest *httpRequest;
    NSString * issString;
}
@property (nonatomic, retain)ASIHTTPRequest *httpRequest;
- (void)renturnNumView;
@property (nonatomic,copy)NSString *item, * issString;
- (void)shuangSeQiuImageView:(NSInteger)sender;
@end
