//
//  AddBankCardViewController.h
//  caibo
//
//  Created by cp365dev on 14-8-4.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "MyPickerView.h"
#import "ASIHTTPRequest.h"
#import "CP_UIAlertView.h"
#import "GC_UIkeyView.h"
@interface AddBankCardViewController : CPViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UITextFieldDelegate,MyPickerViewDelegate,ASIHTTPRequestDelegate,CP_UIAlertViewDelegate,GC_UIkeyViewDelegate>
{
    UITableView *bankTableView;  //银行列表
    
    UITableView *bankIdTableView;  //银行卡号列表
    
    UITableView *cardNameTableView;  //持卡人列表
    
    UIScrollView *myScrollView;
    
    
    UIButton *bankNameField;//选择银行
    
    UIButton *kaihuCityField;//开户地
    UIButton *kaihuCity1Field;//开户地1
    
    UITextField *kaihuQuanNameField; //开户行全称
    
    UITextField *bankCardField;  //银行卡号
    
    UITextField *sureBankCardField;//银行卡号确认
    
    NSArray *allcityArray;
    NSMutableArray *provinceArray; //省
    NSArray *cityArray;   //市
    
    NSInteger choosePro;//选择的省的位置
    
    BOOL isHuiBoChongZ; //用户是否使用过银联回拨充值
    
    NSDictionary *cellPhoneDic;//银行对应电话字典
    NSString *bankPhone;  //选中银行电话
    
    ASIHTTPRequest *addBindBankCardReq; //添加绑定银行卡
    
    ASIHTTPRequest *reqUserInfo;
    
    NSString *true_name;
    NSString *id_num;
    NSString *bank_Num;
    NSString *bank_Name;
    
    UILabel *trueNameLabel;
    UILabel *idNumLabel;
    
    NSDictionary *bankIDDic;
    
    
    int selectedBank;
    int selectedCity;
    
    NSArray *bankArray;

    GC_UIkeyView *gckeyView;
    GC_UIkeyView *gckeyView1;

}
@property (nonatomic, retain) NSArray *allcityArray;
@property (nonatomic, retain) NSMutableArray *provinceArray;
@property (nonatomic, retain) NSArray *cityArray;
@property (nonatomic, retain) NSDictionary *cellPhoneDic;
@property (nonatomic, copy) NSString *bankPhone;
@property (nonatomic) BOOL isHuiBoChongZ;
@property (nonatomic, retain) ASIHTTPRequest *addBindBankCardReq,*reqUserInfo;

@property (nonatomic ,retain) NSString *password,*true_name,*id_num,*bank_Num,*bank_Name;

@property (nonatomic, retain) NSDictionary *bankIDDic;
@property (nonatomic, retain) NSArray *bankArray;
@end
