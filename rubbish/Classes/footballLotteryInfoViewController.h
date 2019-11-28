//
//  footballLotteryInfoViewController.h
//  caibo
//
//  Created by houchenguang on 13-6-19.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "footballLotteryCell.h"
#import "ASIHTTPRequest.h"
#import "footButtonData.h"
#import "CP_ThreeLevelNavigationView.h"
#import "CP_KindsOfChoose.h"

typedef enum{
    
    jingcaishengpingfu,
    jingcairangqiushengpingfu,
    jingcaibifen,
    jingcaizongjinqiu,
    jincaibanquanchang,
    jingcaishengfencha,
    jingcaidaxiaofen,
    jingcairangqiushengfu,
    jingcaishengfu,
    beidanrangqiushengpingfu,
    beidanshangxiapandanshuang,
    beidanbanquanshengpingfu,
    beidanbifen,
    beidanzongjinqiu
    
    
}footBallType;

typedef enum{
    
    jingcaizuqiu,
    jingcailanqiu,
    beijingdanchang
    
    
} lotteryAllType;

@interface footballLotteryInfoViewController : CPViewController<UITableViewDataSource, UITableViewDelegate, footBallDelegate, CP_ThreeLevelNavDelegate, CP_KindsOfChooseDelegate>{
    
    footBallType fbType;
    UITableView * myTableView;
    ASIHTTPRequest * mRequest;
    NSMutableArray * dataArray;//保存筛选完的数据
    NSString * selectButton; //记录选择哪个button;
    int buffer[50];
    lotteryAllType lotteryAll;
    NSMutableArray * allDataArray;//保存所有数据
    NSMutableArray * saiShiArray;//保存所有赛事
    CP_ThreeLevelNavigationView * tln;
    NSMutableArray * duoXuanArr;
    NSMutableArray * kongzhiType;
    NSMutableArray * issueArray;//所有期号请求保存
    NSString * issueString;//传入的期号
    NSMutableArray * dateStringArray;//保存转化后的时间
    UIImageView * upimageview;
    UILabel * tishiLabel;
    BOOL oneBool;
    NSMutableArray * issueDictArray;//期号所有信息
}

@property (nonatomic, retain)ASIHTTPRequest * mRequest;
@property (nonatomic, retain)NSString * selectButton;
@property (nonatomic, retain) NSString * issueString;//传入的期号
@property (nonatomic, assign)lotteryAllType lotteryAll;

@end
