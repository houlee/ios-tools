//
//  ChampionViewController.h
//  caibo
//
//  Created by houchenguang on 14-5-29.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "ChampionTableViewCell.h"
#import "ASIHTTPRequest.h"
#import "UpLoadView.h"
#import "ChampionData.h"
#import "CP_ThreeLevelNavigationView.h"

typedef enum{

    championTypeShow,
    championSecondPlaceShow,
    
} ChampionType;

@interface ChampionViewController : CPViewController<UITableViewDataSource, UITableViewDelegate, ChampionTableViewCellDelegate,CP_ThreeLevelNavDelegate>{

    
    ChampionType championType;
    NSString * curIssue;//当前期
    NSString * endTime;//截止时间
    UITableView * myTableView;
    UIView * titleJieqi;
    UILabel * jiezhilabel;
    NSString * sessionNum;//场次号
    UILabel * oneLabel;
    UILabel * twoLabel;
    UIButton * castButton;
    NSString * lotteryId;
    ASIHTTPRequest * httpRequest;
    UpLoadView * loadview;
    ChampionData *championData;
    ASIHTTPRequest * yujirequest;
    CP_ThreeLevelNavigationView * tln;

}
@property (nonatomic, retain)ChampionData *championData;
@property (nonatomic, assign)ChampionType championType;
@property (nonatomic, retain)ASIHTTPRequest * httpRequest, * yujirequest;
@property (nonatomic, retain)NSString * curIssue, * endTime , * sessionNum,* lotteryId;


@end
