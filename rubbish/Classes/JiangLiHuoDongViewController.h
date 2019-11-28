//
//  JiangLiHuoDongViewController.h
//  caibo
//
//  Created by zhang on 11/1/12.
//
//

#import <UIKit/UIKit.h>
#import "MoreLoadCell.h"
#import "ASIHTTPRequest.h"
#import "CBRefreshTableHeaderView.h"
#import "CPViewController.h"
#import "UpLoadView.h"

@interface JiangLiHuoDongViewController : CPViewController<UITableViewDelegate,UITableViewDataSource,CBRefreshTableHeaderDelegate,UIWebViewDelegate>{

    UITableView *myTableView;
    NSMutableArray *JLdataArray;
    NSMutableArray *upArray;
    MoreLoadCell *moreCell;
    
    ASIHTTPRequest *httprequest;
    NSInteger page;
    BOOL isLoading;
    BOOL isAllRefresh;
    CBRefreshTableHeaderView *mRefreshView;
    
    UpLoadView *loadview;
}
@property (nonatomic, retain)MoreLoadCell *moreCell;
@property (nonatomic, retain)ASIHTTPRequest *httprequest;
@property (nonatomic, retain)CBRefreshTableHeaderView *mRefreshView;

- (void)requestHttpNews;

@end
