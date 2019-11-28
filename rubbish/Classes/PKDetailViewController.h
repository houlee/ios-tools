//
//  PKDetailViewController.h
//  caibo
//
//  Created by cp365dev6 on 15/2/4.
//
//

#import "CPViewController.h"
#import "PKDetailTableViewCell.h"
#import "Info.h"
#import "ColorView.h"
#import "GC_BetData.h"
#import "ASIHTTPRequest.h"
#import "GC_HttpService.h"
#import "GC_PKDetailData.h"
#import "UpLoadView.h"
#import "caiboAppDelegate.h"
#import "CBRefreshTableHeaderView.h"

@interface PKDetailViewController : CPViewController<UITableViewDataSource,UITableViewDelegate,CBRefreshTableHeaderDelegate>
{
    UITableView *myTableView;
    UIView *headerView;
    UIView *footerView;
    UIView *firstView;
    UIView *secondView;
    UILabel *statueLab;
    UILabel *zhongjiangLab;
    UILabel *yuanLab;
    UIView *zhongjiangView;
    UIView *buzhongView;
    UILabel *chongtiLab;
    UILabel *kaijiangLab;
    
    NSMutableArray *dataArray;
    NSMutableArray *userDataArray;
    NSMutableArray *xinshouArraym;
    
    BOOL isZhongjiang;
    BOOL isKaijiang;
    BOOL zhusheng;
    BOOL ping;
    BOOL kesheng;
    
    NSString *bifen;
    NSMutableArray *bifenArym;
    NSInteger bifenNum;
    NSMutableArray *peilvArym;
    NSString *peilv;
    UILabel *jisuanLab;
    
    ASIHTTPRequest *httpRequest;
    UILabel *orderNumLab;
    UILabel *timeLab;
    UILabel *staLab;
    ColorView *payLab;
    UILabel *zhushuLab;
    
//    UpLoadView *loadView;
    CBRefreshTableHeaderView *mRefreshView;
    BOOL isLoading;
    UILabel *chuanfaLab;
    NSInteger caiChangci;
    BOOL isErchuan;
    BOOL isSanchuan;
    BOOL first;
    BOOL second;
    BOOL third;
    NSMutableArray *newUserResultArym;
    
}
@property (nonatomic, retain)NSMutableArray *newUserDataArym,*betContentArym,*chuanfaArym;
@property (nonatomic, assign)int zhushu;
@property (nonatomic) BOOL isNewUser;
@property (nonatomic, copy)NSString * code;
@property (nonatomic, retain) CBRefreshTableHeaderView *mRefreshView;
@property (nonatomic,  retain) ASIHTTPRequest *httpRequest;
@end
