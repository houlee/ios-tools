//
//  PKJoinRaceViewController.h
//  caibo
//
//  Created by cp365dev6 on 15/1/22.
//
//

#import "CPViewController.h"
#import "Info.h"
#import "CP_CanOpenTableView.h"
#import "PKTableViewCell.h"
#import "NetURL.h"
#import "JSON.h"
#import "GC_BJDanChangChuanFa.h"
#import "CP_KindsOfChoose.h"
#import "GC_JCalgorithm.h"
#import "GC_HttpService.h"
#import "GC_JingCaiDuizhenChaXun.h"
#import "GC_JingCaiDuizhenResult.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"
#import "GC_PKRaceList.h"
#import "JiFenBetInfo.h"
#import "UpLoadView.h"
#import "SharedMethod.h"
#import "ChartDefine.h"
#import "PKDetailViewController.h"
#import "JiFenBuyLotteryData.h"

@interface PKJoinRaceViewController : CPViewController<UITableViewDelegate,UITableViewDataSource,PK_NewTableCellDelegate,CP_KindsOfChooseDelegate>

{
    CP_CanOpenTableView * myTableView;
    UIView * tabView;
    UILabel * oneLabel;
    UILabel * twoLabel;
    UIButton * chuanButton1;
    UILabel *labelch;
    int one;
    int two;
    
    ASIHTTPRequest * request;
    NSMutableArray * dataArray;//保存数据的数组
    NSMutableDictionary * zhushuDic;
    
    NSMutableArray *cellarray;
    NSMutableArray * chuantype;
    
    int buf[160];
    NSInteger addchuan;
    
    NSMutableArray * betArray;//可买期的数组
    NSMutableArray *chuanfaAry;
    NSString *chuanfaStr;
    NSInteger zhu;
    NSString *betConStr;
    NSString *betPeilvStr;
    NSString *date;
    
    UpLoadView *loadView;
    NSMutableArray *chuanfaArym;
    UILabel *titleLabel;
    UIImageView *sanjiaoImageView;
    UIView *titleView;
    
    CP_KindsOfChoose *alert2;
    BOOL titleBtnIsCanPress;
    BOOL isShowing;
    NSMutableArray *qiciArray;
    NSMutableArray *qiciXuanzeArym;
    UIView *wujiluView;
    UIButton *castButton;
    
}
@property (nonatomic, retain)NSMutableArray * betArray;
@property (nonatomic, retain)NSMutableArray * dataArray;
@property (nonatomic, retain)ASIHTTPRequest * request;
@property(nonatomic,retain)  NSMutableArray *resultList;

@property (nonatomic, assign)NSInteger count, returnId, updata;
@property (nonatomic, retain)NSString * sysTimeString, * dateString, * beginTime, * beginInfo, * statue, * message,*touzhuCode,*chuanfaStr,*betConStr,*betPeilvStr,*date;
@property(nonatomic,retain)  NSMutableArray *listData;

- (void)tabBarView;
@end
