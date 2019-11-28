//
//  GCXianJinLiuShuiController.h
//  caibo
//
//  Created by  on 12-5-23.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "GC_AccountManage.h"
#import "CBRefreshTableHeaderView.h"
#import "MoreLoadCell.h"
#import "GC_BetRecord.h"
#import "CPViewController.h"

typedef enum {
    XianJinLiuShuialla,
    XianJinLiuShuichongzhia,
    XianJinLiuShuidongjiea,
    XianJinLiuShuitixiana
    
}XianJinLiuShuia;
@interface GCXianJinLiuShuiController : CPViewController<UITableViewDelegate,
UITableViewDataSource,ASIHTTPRequestDelegate,CBRefreshTableHeaderDelegate> {
    ASIHTTPRequest *httpRequest;
    NSMutableArray * allArray;
    NSMutableArray * czArray;
    NSMutableArray * djArray;
    NSMutableArray * txArry;
    XianJinLiuShuia xjlsType;
    CBRefreshTableHeaderView *mRefreshView;
    MoreLoadCell *moreCellall;
    MoreLoadCell * morecellchong;
    MoreLoadCell * morecelldong;
    MoreLoadCell * morecellti;
    BOOL xjbAll;
    BOOL xjbCZ;
    BOOL xjbDJ;
    BOOL xjbTX;
    BOOL isLoading;
    BOOL mark;
    UIView * bgviewdown;
    UITableView *myTableView;
    UILabel * xuanLabel;
    NSInteger *liuShuiIndex;
    
    BOOL isDrawal;
}
@property (nonatomic, retain) ASIHTTPRequest *httpRequest;
@property (nonatomic,retain)MoreLoadCell *moreCellall, *morecellchong, *morecelldong, *morecellti;
@property (nonatomic,retain)CBRefreshTableHeaderView *mRefreshView;
@property (nonatomic,assign) NSInteger *liuShuiIndex;
@property (nonatomic, assign) BOOL isDrawal;
-(void)changeType:(UIButton *)sender;


- (void)xianjinAllRequest;
- (void)xianjinDongJieRequest;
- (void)xianjinChongZhiRequest;
- (void)xianjinTiXianRequest;
@end
