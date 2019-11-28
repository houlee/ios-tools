//
//  ModifyAccountViewController.h
//  caibo
//
//  Created by cp365dev on 14-5-21.
//
//
//修改账户信息
#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "CP_UIAlertView.h"
#import "SelfHelpView.h"
#import "CP_Actionsheet.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "CP_HiddenAlertView.h"
@interface ModifyAccountViewController : CPViewController<CP_UIAlertViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,CP_ActionsheetDelegate,UINavigationControllerDelegate,ASIHTTPRequestDelegate,ASIProgressDelegate,CP_HiddenAlertViewDelegate,UITextFieldDelegate>
{
    
    UILabel *userName;
    UILabel *oldnameLabel;
    UILabel *oldusercardLabel;
    
    UIScrollView *myScrollView;
    
    SelfHelpView *selfHelp;
    
    UIImage *selectedImage1;
    UIImageView *picImageView1;
    UIButton *picCloseBtn1;
    
    
    UIImage *selectedImage2;
    UIImageView *picImageView2;
    UIButton *picCloseBtn2;
    
    CP_Actionsheet *sheet;
    
    UIButton *delBtn1;
    UIButton *delBtn2;
    
    UIButton *tijiaoBtn;
    
    ASIFormDataRequest *mReqData;
    ASIHTTPRequest *request;
    
    float image1DataLength;
    
    NSString *mNickName;
    NSString *mTrueName;
    NSString *mUserIdCard;
    
//    UIImagePickerController  *imagePicker;
    
    NSInteger imagePickerTag;
    
    UITextField *newnameField;
    UITextField *newusercardField;
    NSString *password;
    ASIHTTPRequest *reqUserInfo;

    
}
@property (nonatomic, retain) ASIHTTPRequest *request,*reqUserInfo;
@property (nonatomic, retain) ASIFormDataRequest *mReqData;
@property (nonatomic, copy) NSString *mNickName;
@property (nonatomic, copy) NSString *mTrueName;
@property (nonatomic, copy) NSString *mUserIdCard;
@property (nonatomic, copy) NSString *password;
@end
