//
//  ReplaceAccountViewController.h
//  caibo
//
//  Created by cp365dev on 14-5-21.
//
//
//更换账户真实信息
#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "CP_UIAlertView.h"
#import "SelfHelpView.h"
#import "CP_Actionsheet.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "CP_HiddenAlertView.h"
@interface ReplaceAccountViewController :  CPViewController<CP_UIAlertViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,CP_ActionsheetDelegate,UINavigationControllerDelegate,ASIHTTPRequestDelegate,ASIProgressDelegate,CP_HiddenAlertViewDelegate>
{
    
    UILabel *userName;
    
    UIScrollView *myScrollView;
    
    SelfHelpView *selfHelp;
    SelfHelpView *selfHelp2;
    
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
    
    CP_Actionsheet *sheet;
    
    ASIFormDataRequest *mReqData;
    ASIHTTPRequest *request;
    
    UIButton *tijiaoBtn;
    
    float image1DataLength;
    
    UILabel *phonemessage;
    
    NSString *mNickName;
    NSString *mTrueName;
    NSString *mUserIdCard;
    
//    UIImagePickerController *imagePicker;
    
    NSInteger imagePickerTag;
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
