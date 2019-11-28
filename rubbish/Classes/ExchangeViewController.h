//
//  ExchangeViewController.h
//  caibo
//
//  Created by cp365dev on 14-5-12.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "ColorView.h"
#import "ASIHTTPRequest.h"
#import "CP_UIAlertView.h"
#import "GC_WinningInfoList.h"
#import "CP_TabBarViewController.h"
@interface ExchangeViewController : CPViewController<ASIHTTPRequestDelegate,CP_UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,CP_TabBarConDelegate>
{
    UIButton *exchangeBtn1;
    UIButton *exchangeBtn2;
    UIButton *exchangeBtn3;
    
    ColorView *peopleLabel1;
    ColorView *peopleLabel2;
    ColorView *peopleLabel3;
    
    UILabel *suoxujifen1;
    UILabel *suoxujifen2;
    UILabel *suoxujifen3;
    
    
    UILabel *jifen;
    ASIHTTPRequest *myRequest;
    ASIHTTPRequest *myRequest2;
    NSString *exChangePoint;
    
    GC_WinningInfoList *winningList;
    GC_WinningInfoList *winningList1;
    
    UIButton *exchangecaijinbao;
    UIButton *exchangeyouhuima;
    
    UIScrollView *myScrollView;
    UITableView *tableview1;
    UITableView *tableview2;
    UIImageView *duihuanbackImage;
    
    BOOL cjbRequestFinish; //进入页面首次请求成功不再请求
    BOOL yhmReqeustFinish;
    
    CanExChangeYHMList *yhmList;
    CanExChangeCaiJinList *caijinList;
    
    int hadSussYHM; //兑换成功的优惠码  手动加1
    int hadSussCJ; 
    
    
}
@property (nonatomic, retain) ASIHTTPRequest *myRequest;
@property (nonatomic, retain) ASIHTTPRequest *myRequest2;
@property (nonatomic, copy) NSString *exChangePoint;
@property (nonatomic, retain) GC_WinningInfoList *winningList;
@property (nonatomic, retain) GC_WinningInfoList *winningList1;

@property (nonatomic, retain) CanExChangeYHMList *yhmList;
@property (nonatomic, retain) CanExChangeCaiJinList *caijinList;
@end
