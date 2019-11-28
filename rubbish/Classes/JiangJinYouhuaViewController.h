//
//  JiangJinYouhuaViewController.h
//  caibo
//
//  Created by yaofuyu on 13-7-9.
//
//

#import "CPViewController.h"
#import "ASIHTTPRequest.h"
#import "GC_BetInfo.h"
#import "JiangJinYouHuaJX.h"
#import "ColorView.h"
#import "CP_PTButton.h"
#import "CP_UISegement.h"
#import "CP_UIAlertView.h"
#import "GC_ShengfuInfoViewController.h"
#import "GC_BuyLottery.h"
@interface JiangJinYouhuaViewController : CPViewController <ASIHTTPRequestDelegate,UITextFieldDelegate, CP_UIAlertViewDelegate> {
    ASIHTTPRequest *myHttpRequest;
    GC_BetInfo *mybetInfo;
    JiangJinYouHuaJX *myYHInfo;
    BOOL isHemai;
    UIButton *sendBtn;
    UILabel *senderLable;
    
    UITableView *myTableView;
    UITextField *jihuaText;
    
    ColorView *nameLabel;//串法
    ColorView *yujiMoney;//预计奖金
    ColorView *moneyLabel;//应付金额
    ColorView *zhanghuLabel;//账户金额
    CP_PTButton *baomiButton;//保密
//    CP_UISegement *mySegment;
//    UIView *editeView;
    UIButton *coverBtn;
    BOOL isGoBuy;
    NSInteger minMoney;
    NSString *betNum;//优化前的值
    BOOL isCanBack;
    NSString * passWord;
    Caifenzhong caizhong;
    BOOL isYouhua;//已经优化过
    CP_PTButton *yhBtn;//奖金优化按钮
    
    BOOL isShowFangChenMi;
    GC_BuyLottery *buyResult;
    
}
@property (nonatomic, retain) GC_BuyLottery *buyResult;
@property (nonatomic,retain)ASIHTTPRequest *myHttpRequest;
@property (nonatomic,retain)GC_BetInfo *mybetInfo;
@property (nonatomic,retain)JiangJinYouHuaJX *myYHInfo;
@property (nonatomic,retain)UITableView *myTableView;
@property (nonatomic)BOOL isHemai,isCanBack;
@property (nonatomic)NSInteger minMoney;
@property (nonatomic,copy)NSString *betNum;
@property (nonatomic, retain)NSString * passWord;
@property (nonatomic)Caifenzhong caizhong;
- (void)passWordOpenUrl;

@end
