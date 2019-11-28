//
//  AccountDrawalViewController.h
//  caibo
//
//  Created by cp365dev on 14-8-6.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "ASIHTTPRequest.h"
@interface AccountDrawalViewController : CPViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
{
    UITableView *myTableView;
    
    
    ASIHTTPRequest *yinLianRequest;
    
    BOOL isYinLianBack;
    
    NSString *password;
    
    BOOL isNotPer;//未完善信息
    
    ASIHTTPRequest *httpRequest;
}

@property (nonatomic, retain) ASIHTTPRequest *yinLianRequest,*httpRequest;

@property (nonatomic ,copy)NSString *password;

@property (nonatomic) BOOL isNotPer;
@end
