//
//  KuaiSanTuiJianViewCotroller.h
//  CPgaopin  快三推荐号
//
//  Created by yaofuyu on 13-11-20.
//
//

#import "CPViewController.h"
#import "GouCaiShuZiInfoViewController.h"
#import "CPZhanKaiView.h"
#import "CP_PTButton.h"
#import "ColorView.h"
#import "CalculateViewController.h"
#import "GC_BetInfo.h"
#import "CPTuiJianCell.h"
#import "GCBallView.h"
#import "ASIHTTPRequest.h"

typedef enum
{
    KuaiSanTuiJianTypeHeZhi,
	KuaiSanTuiJianTypeSanBuTong,
    KuaiSanTuiJianTypeErBuTong,
}KuaiSanTuiJianType;

@interface KuaiSanTuiJianViewCotroller : CPViewController <calculateDelegate,CPTuiJianCellDelegate,GCBallViewDelegate,ASIHTTPRequestDelegate> {
    KuaiSanTuiJianType viewType;
    UITableView *mytableView;
    UIButton *sendBtn;
    GouCaiShuZiInfoViewController *infoViewController;
    CPZhanKaiView *infoBackImage;
    UIView *footBackImage;
    UIImageView *infoBackImaeg2;
    UIButton *zhuiBtn;//追号期数
    CP_PTButton *zhuiInfoBtn;//追号详情
    UITextField *zhuiTextField;
    CP_PTButton *addbutton;
    CP_PTButton *jianbutton;
    UILabel *touruLabel;
    UILabel *yuchuLabel;
    UILabel *danZhuLabel;
    NSMutableArray *issuearr;
    NSDictionary *dataDic;//遗漏数据
    GC_BetInfo *myBentInfo;
    UIImageView *numView;
    ASIHTTPRequest *ahttpRequest;
    
    ASIHTTPRequest * yilouRequest;
    NSString * myLotteryID;
}
@property (nonatomic)KuaiSanTuiJianType viewType;
@property (nonatomic,retain)GouCaiShuZiInfoViewController *infoViewController;
@property (nonatomic,retain)NSDictionary *dataDic;
@property (nonatomic,retain)GC_BetInfo *myBentInfo;
@property (nonatomic,retain)ASIHTTPRequest *ahttpRequest, * yilouRequest;

- (id)initWithLotteryID:(NSString *)lotteryID;

@end
