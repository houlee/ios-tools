//
//  PKRankingListViewController.h
//  caibo
//
//  Created by GongHe on 15-1-19.
//
//

#import "CPViewController.h"
#import "ASIHTTPRequest.h"
#import "GC_PKRankingList.h"
#import "CP_Actionsheet.h"
#import "PKMyRecordViewController.h"
#import "TwitterMessageViewController.h"
#import "ProfileViewController.h"
#import "CBRefreshTableHeaderView.h"
#import "UpLoadView.h"

@interface PKRankingListViewController : CPViewController<UITableViewDataSource,UITableViewDelegate,CP_ActionsheetDelegate,CBRefreshTableHeaderDelegate,ASIHTTPRequestDelegate>
{
    NSMutableArray * dayDataArray;
    NSMutableArray * weekDataArray;
    NSMutableArray * selectDataArray;
    
    UIView * blueLine;
    
    UITableView * rankingListTableView;
    
    ASIHTTPRequest *myRequest;
    ASIHTTPRequest *myRequest1;

    NSInteger dayCurCount;
    NSInteger weekCurCount;
    NSInteger curCount;
    CBRefreshTableHeaderView *mRefreshView;
//    UpLoadView *loadView;
    BOOL isLoading;
    BOOL rightSelected;
    UIView *wujiluView;
}
@property (nonatomic, retain) ASIHTTPRequest *myRequest,*myRequest1;;
@property (nonatomic, copy) NSString *userName,*userNic_name,*issue,*PKUserId;
@property (nonatomic, retain) CBRefreshTableHeaderView *mRefreshView;

@end
