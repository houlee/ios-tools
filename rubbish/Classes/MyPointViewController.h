//
//  MyPointViewController.h
//  caibo
//
//  Created by cp365dev on 14-5-12.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "MoreLoadCell.h"
#import "ASIHTTPRequest.h"
#import "GC_WinningInfoList.h"
#import "ColorView.h"
#import "GC_YHMInfoParser.h"
#import "GC_MyPrizeInfo.h"
@interface MyPointViewController : CPViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView *myTableView;
    UITableView *youhuimaTableView;
    UITableView *jiangpinTableView;
    
    MoreLoadCell *moreCell;
    MoreLoadCell *youhuimamoreCell;
    MoreLoadCell *jiangpinmoreCell;

    
    ASIHTTPRequest *myRequest_;
    ASIHTTPRequest *prizeRequest_;
    ASIHTTPRequest *YHMRequest_;
    
    GC_WinningInfoList *winingList;
    GC_YHMInfoParser *YHMInfoList;
    GC_MyPrizeInfo *prizeInfoList;
    
    ColorView *huode;
    ColorView *xiaohao;
    
    int nowPage;//积分当前页
    int yhmNowPage;//优惠码当前页
    int jpbPage;
    
    
    UIImageView *qiehuan;
    
    
    UIScrollView *myScrollView;
    
    BOOL hadReqYHM;
    BOOL hadReqJPB;
    
    UILabel *myYouhuima;
    UIImageView *xian2;
    
    UILabel *myJiangpin;
    UIImageView *myJiangpinXian;
    
    
}
@property (nonatomic, retain) ASIHTTPRequest *myRequest,*prizeRequest,*YHMRequest;
@property (nonatomic, retain) GC_WinningInfoList *winingList;
@property (nonatomic, retain) GC_YHMInfoParser *YHMInfoList;
@property (nonatomic, retain) GC_MyPrizeInfo *prizeInfoList;
@end
