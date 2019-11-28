//
//  JingPinTuiJianViewController.h
//  caibo
//
//  Created by zhang on 1/9/13.
//
//

#import <UIKit/UIKit.h>
#import "MoreLoadCell.h"
#import "CBRefreshTableHeaderView.h"
#import "ASIHTTPRequest.h"
#import "CPViewController.h"

@interface JingPinTuiJianViewController : CPViewController<UITableViewDelegate,UITableViewDataSource,CBRefreshTableHeaderDelegate>{

    UITableView *myTableView;
    NSMutableArray *JPdataArray;
    MoreLoadCell *moreCell;
    
    CBRefreshTableHeaderView *mRefreshView;
    NSInteger page;
    BOOL isLoading;
    BOOL isAllRefresh;
    
    ASIHTTPRequest *httprequest;

}
@property (nonatomic, retain)MoreLoadCell *moreCell;
@property (nonatomic, retain)CBRefreshTableHeaderView *mRefreshView;
@property (nonatomic, retain)ASIHTTPRequest *httprequest;

- (void)requestHttpApp;

@end
