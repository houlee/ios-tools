//
//  CPselfServiceViewController.h
//  caibo
//
//  Created by houchenguang on 14-5-6.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "ASIHTTPRequest.h"
#import "CP_UIAlertView.h"
@interface CPselfServiceViewController : CPViewController<UITableViewDataSource, UITableViewDelegate,CP_UIAlertViewDelegate>{

    UITableView * myTableView;
    NSMutableArray * dataArray;
    
    NSString *password;
    
    
    ASIHTTPRequest *reqUserInfo;
    
    NSString *mNickName;
    NSString *mMobile;
    NSString *mTrueName;
    NSString *mUserIdCard;
    NSString *mBankIdCard;
    NSString *mBankName;
    NSString *isBank;//是否绑定银行卡
    
    ASIHTTPRequest *httpRequest;
    int selectedRow;
}
@property (nonatomic, copy) NSString *password;
@property (nonatomic, retain) ASIHTTPRequest *reqUserInfo,*httpRequest;

@property (nonatomic, copy) NSString *mNickName;
@property (nonatomic, copy) NSString *mMobile;
@property (nonatomic, copy) NSString *mTrueName;
@property (nonatomic, copy) NSString *mUserIdCard;
@property (nonatomic, copy) NSString *mBankIdCard;
@property (nonatomic, copy) NSString *mBankName;
@property (nonatomic, retain)NSMutableArray * dataArray;
@property (nonatomic, retain)UITableView * myTableView;
@property (nonatomic, copy) NSString *isBank;


@end
