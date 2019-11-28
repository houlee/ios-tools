//
//  CPSetViewController.h
//  caibo
//
//  Created by  on 12-5-7.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "GC_VersionCheck.h"
#import "CP_UIAlertView.h"
#import "CPViewController.h"
#import "StatePopupView.h"
#import "CP_SWButton.h"
@interface CPSetViewController : CPViewController<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate,CP_UIAlertViewDelegate,UITextFieldDelegate,UIActionSheetDelegate>{
    UITableView * myTableView;
    NSArray * dataArray1;
    NSArray * dataArray2;
    UITextField * text;
    ASIHTTPRequest * httpRequest;
    GC_VersionCheck * versionCheck;
    NSString * urlVersion;
    UITextField *textF;
    StatePopupView * statepop;
    NSString * passWord;
    NSString * psTypeString;
    UIImageView * backi;
    
    UIButton *exitLoginButton;
    CP_SWButton *switchyn;
    ASIHTTPRequest *messageRequest;  //推广短信request
    
    BOOL isSoundOn;//是否开启声音  1、开 0、未开
    
    
}
@property (nonatomic, retain)NSString * urlVersion;
@property (nonatomic, retain)ASIHTTPRequest * httpRequest,*messageRequest;
@property (nonatomic, retain) GC_VersionCheck * versionCheck;
@property (nonatomic, retain)NSString * passWord, * psTypeString;
- (void)sendVersionCheck;
@end
