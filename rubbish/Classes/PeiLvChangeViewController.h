//
//  PeiLvChangeViewController.h
//  caibo
//
//  Created by yaofuyu on 13-10-29.
//
//

#import "CPViewController.h"
#import "ASIHTTPRequest.h"
#import "ScoreMacthInfo.h"
#import "DownLoadImageView.h"

@interface PeiLvChangeViewController : CPViewController {
    ScoreMacthInfo *myMacthInfo;
    DownLoadImageView *homeImageView;
    DownLoadImageView *visitImageView;
    UIImageView *homeBack;
    UIImageView *visitBack;
    
    UILabel *homeLabel;
    UILabel *visitLabel;
    UILabel *timeLabel;
    UILabel *peiLvLabe;
    UILabel *bifenLabel;
    UILabel *statueLabel;
    UITableView *myTableView;
    BOOL isOuPei;
    NSString *cid;//公司编号
    NSArray *dataArray;
}
@property (nonatomic,retain)ScoreMacthInfo *myMacthInfo;
@property (nonatomic) BOOL isOuPei;
@property (nonatomic,retain)NSString *cid;
@property (nonatomic,retain)NSArray *dataArray;


@end
