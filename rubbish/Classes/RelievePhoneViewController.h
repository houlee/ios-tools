//
//  RelievePhoneViewController.h
//  caibo
//
//  Created by houchenguang on 14-5-6.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "CP_UIAlertView.h"
#import "SelfHelpView.h"
#import "CP_Actionsheet.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "CP_HiddenAlertView.h"
@interface RelievePhoneViewController : CPViewController<CP_UIAlertViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,CP_ActionsheetDelegate,UINavigationControllerDelegate,ASIHTTPRequestDelegate,ASIProgressDelegate,CP_HiddenAlertViewDelegate>
{
    
    UILabel *userName;
    
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
    
    UIButton *tijiaoBtn;  //提交
    
    ASIFormDataRequest *mReqData;
    ASIHTTPRequest *request;
    
    float image1DataLength;
    
    
    UILabel *phonemessage;
    
    NSString *mNickName;
    NSString *mMobile;
    
//    UIImagePickerController *imagePicker;
    
    NSInteger imagePickerTag;
    
    NSString * password;
    ASIHTTPRequest *reqUserInfo;
    
}
@property (nonatomic, retain) ASIFormDataRequest *mReqData;
@property (nonatomic, retain) ASIHTTPRequest *request,*reqUserInfo;
@property (nonatomic, copy) NSString *mNickName;
@property (nonatomic, copy) NSString *mMobile;
@property (nonatomic, copy) NSString *password;
@end
