//
//  AnnouncementViewController.h
//  caibo
//
//  Created by GongHe on 14-1-16.
//
//

#import "CPViewController.h"
#import "CBRefreshTableHeaderView.h"
#import "ASIHTTPRequest.h"
#import "DownLoadImageView.h"
#import "CPViewController.h"

@interface AnnouncementViewController : CPViewController<UITableViewDelegate, UITableViewDataSource, CBRefreshTableHeaderDelegate>
{
    UITableView * myTableView;
    BOOL isLoading;
    BOOL isAllRefresh;
	CBRefreshTableHeaderView *mRefreshView;
    NSMutableArray * topicDataArry;
    NSMutableArray * upArray;
    ASIHTTPRequest * httprequest;
}
@property (nonatomic, retain)CBRefreshTableHeaderView *mRefreshView;
@property (nonatomic, retain)ASIHTTPRequest * httprequest;
//网络请求
- (void)requestHttpNews;

@end
