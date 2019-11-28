//
//  KFMessageBoxView.h
//  caibo
//
//  Created by houchenguang on 12-11-21.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "CP_PTButton.h"
#import "KFSiXinCell.h"
#import "UpLoadView.h"
#import "NewPostViewController.h"
#import "SendMicroblogViewController.h"


@interface KFMessageBoxView : UIView<UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, KFSiXinCellDelegate>{
    
    UITableView * myTableView;
    UITextView * myTextView;
    UIImageView * textimage;
    CGSize keysize;
    UIImageView * textbg;
    UIImageView * shangbg;
    UIImageView * xiabg;
    UIButton * sendButton;
    UIButton * xbutton;
    NSMutableArray * dataArray;
    BOOL showBool;//标志此页面的状态 是出现 还是消失
    ASIHTTPRequest * request;
    BOOL newBool;//是否有新消息
    UIButton * jianpanbg;
    UIImageView *bgkefuimage;
    UIImageView *takeimage;
    
    UITextView *infoText;
    BOOL FAQ;
    
    CP_PTButton * potButton1;
    CP_PTButton * potButton2;
    UIImageView * potimage;
    UIButton * delButton;
    UIImageView *wbBgImage;
    BOOL photoShowDis;
    UIImage * selectImage;
    ASIFormDataRequest * mReqData;
    UpLoadView * loadview;
    SendMicroblogViewController * newpost;
    BOOL newpostBool;
    
}
@property (nonatomic, assign)BOOL showBool, newBool, newpostBool;
@property(nonatomic, retain)ASIHTTPRequest * request;
@property (nonatomic, retain)ASIFormDataRequest * mReqData;
@property (nonatomic, retain)UIImage * selectImage;
@property (nonatomic, retain)SendMicroblogViewController * newpost;
- (void)returnSiXinCount;
- (void)kefusixinfunc;
- (void)upDate;
- (void)tsInfo;
- (void)tsInfoHidden;
@end
