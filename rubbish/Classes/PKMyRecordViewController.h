//
//  PKMyRecordViewController.h
//  caibo
//
//  Created by cp365dev6 on 15/1/23.
//
//

#import "CPViewController.h"
#import "Info.h"
#import "CP_CanOpenTableView.h"
#import "PKTableViewCell.h"
#import "NetURL.h"
#import "JSON.h"
#import "PKMyRecordTableViewCell.h"
#import "GC_PKMyRecordList.h"
#import "PKDetailViewController.h"
#import "UpLoadView.h"
#import "CBRefreshTableHeaderView.h"
#import "MoreLoadCell.h"


@interface PKMyRecordViewController : CPViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,CBRefreshTableHeaderDelegate>
{
    UILabel *userNmaeLab;
    UILabel *payMoneyLab;
    UILabel *getMoneyLab;
    ColorView *gainMoneyLab;
    UIView *wujiluView;
    
    UITableView *myTableView;
    
    ASIHTTPRequest *httpRequest;
    GC_BetRecord *allRecord;
    NSMutableArray *dateArray;
    NSMutableArray *zongArray;
//    UpLoadView *loadView;
    CBRefreshTableHeaderView *mRefreshView;
    BOOL isLoading;
    MoreLoadCell *listMoreCell;
    
    NSInteger requestPage;
    NSInteger requestTotalPage;
    NSMutableArray *moreArym;
    UIView *headView2;
}
@property (nonatomic, retain) ASIHTTPRequest *httpRequest;
@property (nonatomic, retain) GC_BetRecord *allRecord;
@property (nonatomic, copy) NSString *totalPay,*totalGet,*totalScore,*userName,*userNickName;
@property (nonatomic, retain) CBRefreshTableHeaderView *mRefreshView;
@end
