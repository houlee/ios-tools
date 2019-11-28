//
//  DrawalRecordViewController.h
//  caibo
//
//  Created by cp365dev on 14-8-11.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "ASIHTTPRequest.h"
#import "MoreLoadCell.h"
#import "GC_Withdrawals.h"
@interface DrawalRecordViewController : CPViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
{
    UITableView *myTableView;
        
    ASIHTTPRequest *httpRequest;
    
    int nowPage;
    
    MoreLoadCell *moreCell;
    
    GC_Withdrawals * drawalinfo;
}

@property (nonatomic, retain) ASIHTTPRequest *httpRequest;

@property (nonatomic, retain) NSMutableArray *tableArray;

@property (nonatomic, retain) GC_Withdrawals *drawalinfo;
@end
