//
//  scoreLiveTelecastViewController.h
//  caibo
//
//  Created by houchenguang on 13-6-26.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "liveTelecastCell.h"
#import "ASIHTTPRequest.h"
#import "CP_LieBiaoView.h"
#import "CP_KindsOfChoose.h"
#import "CBRefreshTableHeaderView.h"
#import "UpLoadView.h"

#import "ProgressBar.h"
typedef enum{
    
    liveType,
    myAttentionType,
    endType,
    
    
} scoreType;

typedef enum{
    
    jingcaibifenType,
    beidanbifenType,
    zucaibifenType,
    
    
} lotterBifenType;

@interface scoreLiveTelecastViewController : CPViewController<CBRefreshTableHeaderDelegate,CP_KindsOfChooseDelegate,PrograssBarBtnDelegate,UITableViewDataSource, UITableViewDelegate, CP_lieBiaoDelegate, liveTelecastDelegate>{

    UITableView * myTableView;
    scoreType allType;
    int buffer[50];
    ASIHTTPRequest * mRequest;
    NSMutableArray * issueArray;//所有期号保存数组
    NSMutableArray * dataArray;//对阵所有数据 数组包数组
    UILabel * titleLabel;
    UILabel * sanjiaolabel;
    NSString * issueString;//期号
    NSIndexPath * selectIndex;
    UIButton *btn;
    UILabel *beginLabel;
    NSMutableArray * kongzhiType;
    
    UIView * noAttView;
    // 刷新控件
    CBRefreshTableHeaderView *refreshHeaderView;
    BOOL isLoading;
//    UpLoadView * loadview;
    NSTimer * luntime;
    NSMutableArray * arrayType;//title状态
    NSInteger attentionCount;//记录第一次
    lotterBifenType bifenType;
    BOOL bifenzhibo;
}
@property (nonatomic, assign)BOOL bifenzhibo;
@property (nonatomic,retain)CBRefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, retain)NSIndexPath * selectIndex;
@property (nonatomic, assign)scoreType allType;
@property (nonatomic, retain)ASIHTTPRequest * mRequest;
@property (nonatomic, retain)NSString * issueString;
@property (nonatomic, assign)lotterBifenType bifenType;

@end
