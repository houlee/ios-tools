//
//  PhotographViewController.h
//  caibo
//
//  Created by  on 12-5-9.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressBar.h"
#import "AddressView.h"
#import "ASIHTTPRequest.h"
#import "CPViewController.h"

typedef enum
{
    wodecaipiao,
	setting
}XiuGaiTouXiangType;

@class AddressView;
@interface UIImage (wiRoundedRectImage)  

+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size;  

@end  

@interface PhotographViewController : CPViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,PrograssBarBtnDelegate,UIPopoverControllerDelegate>{
    UIImageView * myImageView;//相片显示
    UIButton * potbutton;//拍照
    UIButton * potbuttontwo;//相册
     ProgressBar *mProgressBar;
     AddressView *mAddressView;
    UIImage *mHeadImage;// 头像
    NSString *imageUrl;
     ASIHTTPRequest *reqEditPerInfo;
    ASIHTTPRequest * reqUserInfo;
    BOOL padDoBack;
    BOOL finish;
    XiuGaiTouXiangType xiugaitouxiangtype;
    
}
@property(nonatomic, retain) ASIHTTPRequest *reqEditPerInfo;
@property(nonatomic, retain) ASIHTTPRequest *reqUserInfo;
@property(nonatomic, assign) BOOL padDoBack;
@property(nonatomic, assign) BOOL finish;
@property(nonatomic, assign) XiuGaiTouXiangType xiugaitouxiangtype;
//@property(nonatomic, retain) UIImageView *myImageView;

+ (id) createRoundedRectImage:(UIImage*)image size:(CGSize)size;
- (void)pressPotButton:(UIButton *)sender;
- (void) sendRequest;
- (void)uploadHeadImage:(NSData*)imageData;
@end
