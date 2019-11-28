//
//  NewsViewController.h
//  caibo
//
//  Created by  on 12-7-2.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBRefreshTableHeaderView.h"
#import "MoreLoadCell.h"
#import "ASIHTTPRequest.h"
#import "DownLoadImageView.h"
#import "CPViewController.h"

@class LunBoView;
@interface NewsViewController : CPViewController<UITableViewDelegate, UITableViewDataSource, CBRefreshTableHeaderDelegate>{
    
    UITableView * myTableView;
    BOOL isLoading;
    BOOL isAllRefresh;
	CBRefreshTableHeaderView *mRefreshView;
	MoreLoadCell *moreCell;
    NSMutableArray * topicDataArry;
    NSMutableArray * upArray;
    ASIHTTPRequest * httprequest;
//    UIView * lunview;
    NSInteger dijige;
    int ddd;
    BOOL onebool;//防止返回按钮多次点击导致nav=null无法返回
    UILabel * lunnewsla;
    UIButton * buttimage1;
    UIButton * buttimage2;
    UIButton * buttimage3;
    UIButton * buttimage4;
    UIButton * buttimage5;
    CGFloat pointx;
    int pointsta;
    CGFloat dianx;
    BOOL poinbool;
    NSTimer * imagetimer;
    int tingtime;
    int wuting;
    int page;
    
    LunBoView * lunBoView;//顶部轮播图
    
    NSString * blogType;
    
    NSMutableArray * cellReadArray;
}
@property (nonatomic, retain)CBRefreshTableHeaderView *mRefreshView;
@property (nonatomic,retain)MoreLoadCell *moreCell;
@property (nonatomic, retain)ASIHTTPRequest * httprequest;

-(id)initWithBlogtype:(NSString *)blogtype;//微博广场上边几行点进去的列表

//网络请求
- (void)requestHttpNews;
//轮播
//- (void)lunBuoImage;
//
//- (void)leftimageyidong;
//
//- (void)iamgeTime;
@end
