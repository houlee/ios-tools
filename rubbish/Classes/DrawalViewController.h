//
//  DrawalViewController.h
//  caibo
//
//  Created by cp365dev on 14-8-4.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "MyPickerView.h"
#import "CP_UIAlertView.h"
#import "ASIHTTPRequest.h"
#import "ColorView.h"
#import "GC_UIkeyView.h"
@interface DrawalViewController : CPViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,CP_UIAlertViewDelegate,ASIHTTPRequestDelegate,GC_UIkeyViewDelegate>
{
    NSMutableArray *bankCardArray;//银行名称
    UITableView *mytableView;
    NSMutableArray *bankNumArray; //银行卡号
    NSMutableArray *bankCardIdArray;//银行卡号id  唯一标识
    
    NSString *drawal_yue; //余额
    NSString *drawal_canTiKuan; //可提款
    
    int selectedRow;
    
    UIScrollView * myScrollView;
    
    UITapGestureRecognizer *_tapGestureRec;
    
    
    ASIHTTPRequest *cardListRequest;  //银行卡列表
    ASIHTTPRequest *subMitRequest; //提交(设置默认银行卡)
    ASIHTTPRequest *userBankRequest;//银联回拨成功用户请求银行卡

    UILabel *yueLabel; //余额
    ColorView *canDrawal;//可提款
    UILabel *jiangliLabel;//奖励账户
    NSString *cardMessage;//银行卡信息
    
    NSDictionary *bankIDDic;  //开户银行id对应字典
    
    UIImageView *backImage;
    
    BOOL yinLianBackSucc; //银联回拨
    
    BOOL isNextAddBank;  //添加完银行卡后返回的本页
    UIButton *tishiBtn;
    
    UITextField *usertextField;
    
    UIButton *addBankBtn;
    
    UILabel *addBankLabel;
    
    UIButton *submitBtn;
    
    UILabel *submitLabel;
    
    GC_UIkeyView *gckeyView;

}
@property (nonatomic, retain) UITableView *mytableView;
@property (nonatomic, retain)  NSMutableArray *bankCardArray;
@property (nonatomic, retain)  NSMutableArray *bankNumArray;
@property (nonatomic, retain) NSMutableArray *bankCardIdArray;

@property (nonatomic, copy) NSString *drawal_yue;
@property (nonatomic, copy) NSString *drawal_canTiKuan;
@property (nonatomic, copy) NSString *drawal_jiangli;
@property (nonatomic, copy) NSString *cardMess;
@property (nonatomic, copy) NSString *cardMessage;

@property (nonatomic, retain) ASIHTTPRequest *cardListRequest,*subMitRequest,*userBankRequest;

@property (nonatomic, retain) NSDictionary *bankIDDic;

@property (nonatomic, copy) NSString *password;

@property (nonatomic) BOOL yinLianBackSucc;

@end
