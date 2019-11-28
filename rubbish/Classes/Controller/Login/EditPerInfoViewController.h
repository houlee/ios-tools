//
//  EditPerInfoViewController.h
//  caibo
//
//  Created by Kiefer on 11-6-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputViewController.h"
#import "ProgressBar.h"

@class AddressView;
@class ASIHTTPRequest;

@interface EditPerInfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, PassValueDelegate,PrograssBarBtnDelegate>
{
    UITableView *mTableView;
    UIImageView *mHeadView;
    UIButton *checkboxM;
    UIButton *checkboxF;
    UILabel *mLbIntro;
    UILabel *mLbAddress;
    AddressView *mAddressView;
    ProgressBar *mProgressBar;
    
    UIImage *mHeadImage;// 头像
    NSString *imageUrl;
    CGSize introCellSize; // 简介cell预估大小
    NSString *introStr; // 简介内容
    
    ASIHTTPRequest *reqUserInfo;
    ASIHTTPRequest *reqEditPerInfo;
    
    short mViewIndex; // 区别是欢迎页和我的资料
}

@property(nonatomic, retain) IBOutlet UITableView *mTableView;
@property(nonatomic, retain) UIImageView *mHeadView;
@property(nonatomic, retain) UIButton *checkboxM;
@property(nonatomic, retain) UIButton *checkboxF;
@property(nonatomic, retain) UILabel *mLbIntro;
@property(nonatomic, retain) UILabel *mLbAddress;
@property(nonatomic, retain) UIImage *mHeadImage;
@property(nonatomic, retain) NSString *introStr;
@property(nonatomic, retain) ASIHTTPRequest *reqUserInfo;
@property(nonatomic, retain) ASIHTTPRequest *reqEditPerInfo;

// 初始化
- (id)initWithNibName:(NSString *)nibNameOrNil type:(short)index;
// 取消
- (IBAction)actionCanCel:(UIButton *)sender;
// 保存
- (IBAction)actionSave:(UIButton*)sender;
// 第一彩博上传头像
- (void)uploadHeadImage:(NSData*)imageData;
// 关闭进度条
- (void) dismissProgressBar;

@end
