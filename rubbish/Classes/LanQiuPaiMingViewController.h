//
//  LanQiuPaiMingViewController.h
//  caibo
//
//  Created by yaofuyu on 13-12-13.
//
//

#import "CPViewController.h"
#import "ASIHTTPRequest.h"

@interface LanQiuPaiMingViewController : CPViewController {
    NSString *hostId;
    NSString *guestId;
    NSString *playId;
    BOOL isNBA;
    BOOL isDongbu;//是nba东部
    UITableView *myTableView;
    UITableView *myTableView2;
    ASIHTTPRequest *mrequest;
    NSDictionary *dataDic;
    UIScrollView *rootScroll;
}
@property (nonatomic,copy)NSString *hostId,*guestId,*playId;
@property (nonatomic)BOOL isNBA;
@property (nonatomic,retain)ASIHTTPRequest *mrequest;
@property (nonatomic,retain)NSDictionary *dataDic;

@end
