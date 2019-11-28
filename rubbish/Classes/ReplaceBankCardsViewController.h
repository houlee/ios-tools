//
//  ReplaceBankCardsViewController.h
//  caibo
//
//  Created by ; on 14-5-21.
//
//
//更换银行卡
#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "CP_UIAlertView.h"
#import "SelfHelpView.h"
#import "CP_Actionsheet.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "CP_HiddenAlertView.h"
@interface ReplaceBankCardsViewController :  CPViewController<CP_UIAlertViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,CP_ActionsheetDelegate,UINavigationControllerDelegate,ASIHTTPRequestDelegate,ASIProgressDelegate,CP_HiddenAlertViewDelegate,UITextFieldDelegate>
{
    
    UILabel *userName;
    
    UIScrollView *myScrollView;
    
    SelfHelpView *selfHelp;
    SelfHelpView *selfHelp2;
    SelfHelpView *selfHelp3;
    
    UIImage *selectedImage1;
    UIImageView *picImageView1;
    UIImage *selectedImage11;
    UIImageView *picImageView11;
    UIButton *delBtn1;
    UIButton *delBtn11;
    
    UIImage *selectedImage2;
    UIImageView *picImageView2;
    UIImage *selectedImage22;
    UIImageView *picImageView22;
    UIButton *delBtn2;
    UIButton *delBtn22;
    
    UIImage *selectedImage3;
    UIImageView *picImageView3;
    UIImage *selectedImage33;
    UIImageView *picImageView33;
    UIButton *delBtn3;
    UIButton *delBtn33;
    
    ASIHTTPRequest *request;
    ASIFormDataRequest *mReqData;
    
    UIButton *tijiaoBtn;
    
    float image1DataLength;
    
//    UILabel *phonemessage;//更换银行卡......操作
    
    NSString *mNickName;
    
    NSString *mBankIdCard;
    NSString *mBankName;
//    UIImagePickerController *imagePicker;
    NSInteger imagePickerTag;
    NSString *password;
    ASIHTTPRequest *reqUserInfo;
    UILabel *truenameLabel;
    UILabel *oldUserCardidLabel;
    UILabel *oldBankidLabel;
    UILabel *oldBankaddressLabel;
    
    UITextField *newBankIdField;
    UITextField *newBankAddressField;
    
}
@property (nonatomic, retain)ASIFormDataRequest *mReqData;
@property (nonatomic, retain)ASIHTTPRequest *request,*reqUserInfo;
@property (nonatomic, copy) NSString *mNickName;
@property (nonatomic, copy) NSString *mBankIdCard;
@property (nonatomic, copy) NSString *mBankName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *mTrueName;
@property (nonatomic, copy) NSString *mUserIdCard;
@property (nonatomic, copy) NSString *mBankAddress;


@end

