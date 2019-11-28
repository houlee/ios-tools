//
//  ScoreLiveDetailViewController.h
//  caibo
//
//  Created by yaofuyu on 13-7-3.
//
//

#import "CPViewController.h"
#import "liveTelecastData.h"
#import "ASIHTTPRequest.h"
#import "ScoreMacthInfo.h"
#import "DownLoadImageView.h"
#import "CP_PTButton.h"

@interface ScoreLiveDetailViewController : CPViewController<UITableViewDataSource,UITableViewDelegate> {
    liveTelecastData *scoreInfo;
    ASIHTTPRequest * mRequest;
    ScoreMacthInfo *myMacthInfo;
    DownLoadImageView *homeImageView;
    DownLoadImageView *visitImageView;
    
    UIImageView *noInfoImageV;
    
    UIImageView *homeBack;
    UIImageView *visitBack;
    
    UILabel *homeLabel;
    UILabel *visitLabel;
    UILabel *timeLabel;
    UILabel *peiLvLabe;
    UILabel *bifenLabel;
    UILabel *statueLabel;
    
    UITableView *myTableView1;
    UITableView *myTableView2;
    UITableView *myTableView3;
    UITableView *myTableView4;
    UIScrollView *rootScroll;
    NSMutableDictionary *dataDic;
    ASIHTTPRequest * peiLvRequest;
    NSTimer *myTimer;
    BOOL isLanqiu;//篮球的比分直播
    UILabel *wenziLabel;//文字轮播
    CP_PTButton *xiaoxiBtn;
    UIImageView *backImageV;
    
}
@property (nonatomic,retain)liveTelecastData *scoreInfo;
@property (nonatomic,retain)ASIHTTPRequest * mRequest,*peiLvRequest;
@property (nonatomic,retain)ScoreMacthInfo *myMacthInfo;
@property (nonatomic,retain)NSMutableDictionary *dataDic;
@property (nonatomic,retain)NSTimer *myTimer;
@property (nonatomic)BOOL isLanqiu;

@end
