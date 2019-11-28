//
//  GuoGuanViewController.h
//  caibo
//
//  Created by houchenguang on 13-3-8.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "ASIHTTPRequest.h"
#import "MoreLoadCell.h"
#import "CP_TabBarViewController.h"
#import "GCGuoGuanData.h"
#import "GCGuoGuanCell.h"
#import "CP_LieBiaoView.h"
typedef enum {
    
    shengFuCaiType,
    renXuanJiuType,
    WoDeGuoGuanType
}GuoGuanType;

typedef enum{
    renjiu,
    shengfu,

}renJiuOrShengFu;

@interface GuoGuanViewController : CPViewController<CP_lieBiaoDelegate,GCGuoGuanDelegate,CP_TabBarConDelegate,UIActionSheetDelegate,UITableViewDataSource, UITableViewDelegate>{

    UITableView * myTabelview;
    ASIHTTPRequest * httpRequest;
    BOOL panduan;
    BOOL mehe;
    NSMutableArray * issueArray;//期号数组
    NSMutableArray * allArray;
     NSString * issuestring;//保存期号
    MoreLoadCell *moreCell;
    UILabel * issueLabel;
    CP_TabBarViewController * tabc;
    GCGuoGuanDataDetail *gcgginfo;
    ASIHTTPRequest * useridRequest;
    int issuecount;
    GuoGuanType ggType;
    UIView * caiguola;
    UILabel * xiaoliangla;
    UILabel * xiaoshoula;
    UILabel * yuanla;
    renJiuOrShengFu renorsheng;
}
@property(nonatomic, retain)ASIHTTPRequest * httpRequest, *useridRequest;
@property (nonatomic,retain)MoreLoadCell *moreCell;
@property (nonatomic, assign)GuoGuanType ggType;
@property (nonatomic, assign)renJiuOrShengFu renorsheng;
@end
