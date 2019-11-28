//
//  ClassicViewController.h
//  caibo
//
//  Created by cp365dev on 14-6-24.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "ASIHTTPRequest.h"
#import "MoreLoadCell.h"
#import "CBRefreshTableHeaderView.h"
@interface ClassicViewController : CPViewController<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate>
{
    ASIHTTPRequest *autoRequest;
    UITableView *mTableView;
    NSMutableArray *quesArray;
    NSMutableArray *upArray;
//    MoreLoadCell *moreCell;
//    CBRefreshTableHeaderView *mRefreshView;
    
    ASIHTTPRequest *newsRequest;
    NSString *questionType;
//    BOOL isAllRefresh;
//    BOOL isLoading;
    
}
@property (nonatomic, retain) ASIHTTPRequest *autoRequest, *newsRequest;
@property (nonatomic, retain) UITableView *mTableView;
@property (nonatomic, copy) NSString *questionType;
//@property (nonatomic, retain) MoreLoadCell *moreCell;
//@property (nonatomic, retain) CBRefreshTableHeaderView *mRefreshView;
@end
