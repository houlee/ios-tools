//
//  ExpertRankListViewController.h
//  caibo
//
//  Created by cp365dev6 on 2016/11/27.
//
//

#import "CPViewController.h"
#import "UpLoadView.h"
#import "caiboAppDelegate.h"

typedef enum {
    
    expertMingzhongType,
    expertHuibaoType,
    expertChuanguanType,
    
}ExpertRankType;

@interface ExpertRankListViewController : CPViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
    UIImageView *segmentIma;
    NSMutableArray *dataArym;
    
    NSInteger cellPage1;
    NSInteger cellPage2;
    NSInteger cellPage3;
    NSInteger segmentTag;
    
    UpLoadView * _loadView;
    
    NSString *erAgintOrderId;
    CGFloat disPrice;
}
@property (nonatomic, assign) ExpertRankType expertType;
@end
