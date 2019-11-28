//
//  SendMicroblogViewController.h
//  caibo
//
//  Created by houchenguang on 14-10-29.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "CP_UIAlertView.h"
#import "CP_LieBiaoView.h"
#import "UpLoadView.h"
#import "CP_Actionsheet.h"
#import "MyLottoryViewController.h"
#import "MicroblogPictureViewController.h"
#import "ASIHTTPRequest.h"
#import "ProgressBar.h"
#import "ASIFormDataRequest.h"
#import "FolloweesViewController.h"

typedef enum{
    CPThreeTopica,
    CPThreeTopicBacka
}CPThreea;

typedef enum {
    NewTopicController,     //发布新消息类型
    ForwardTopicController, //转发类型
    CommentTopicController, //评论类型
    CommentRevert,          //2.51评论回复
    ShareController        //分享
}MPublishType;

@interface SendMicroblogViewController : CPViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate,UITextViewDelegate, CP_lieBiaoDelegate, CP_UIAlertViewDelegate, CP_ActionsheetDelegate, MyLotteryDelegate,MicroblogPictureDelegate, PrograssBarBtnDelegate, PrograssBarBtnDelegate, FolloweesDelegate>{

    UITextView * mMessage;
    NSRange mIndex;//光标的位置
    MPublishType microblogType;
    UIButton *mTextCount;     // 输入字数
    UIImage *mSelectImage;
    BOOL canPublice;
    UIButton * btnwan;
    UpLoadView * loadview;
    UIView * toolView;//工具栏
    UIView * transmitView;//同时转发栏
    UIScrollView * myScrollView;
    UIPageControl * myPageControl;
     BOOL pageControlUsed;
    NSMutableArray *viewControllers;
     UILabel * preinstallLabel;
    UIButton * transmitButton;//同时转发
    UIButton * imageButtonPicture;
    UIView * shareView;
    UIButton * sinaMicroblogButton;
    UIButton * qqMicroblogButton;
    ASIHTTPRequest * mRequest;
    ASIHTTPRequest * mReqUpload;
    ASIFormDataRequest *mReqData;
    BOOL share0;
    BOOL infoShare;
    NSString *shareTo;//分享到，分享模式下可用
     NSString * lotteryID;//方案id 只要是从方案详情页分享的 这个字段必传
    CPThreea cpthree;
    YtTopic *mStatus;
     NSString *orderID;
    NSString *lottery_id;
    NSString *play;
    NSString * weiBoContent;
    NSMutableArray * rangArray;
//    NSString * frontString;//截取前字符串
//    NSString * rearString;//截取后字符串
    NSMutableArray * keyArray;//保持链接
//    BOOL deleteBool;//删除整个文字
//    NSInteger locationCount;//看光标在第几位
    BOOL three;
    NSString * caizhong;
    NSString * myyuce;
    UIButton * shareButton;
    UIButton * faceButton;
    UIButton * potoButton;
    NSRange textRang;
    NSString * textString;
    BOOL eightTextBool;//ios8记录是否触发代理
    BOOL eightBool;//ios8 记录是否可变色
    NSString * faxqUlr;
    UIButton * kefuButton;//联系客服
    BOOL detailedBool;//微博正文过来的
    
    NSURLConnection *urlConnection;
//    NSInteger textCountInt;
}
@property (nonatomic, retain) ASIFormDataRequest *mReqData;
@property (nonatomic, assign)NSRange textRang;
@property (nonatomic, retain)YtTopic *mStatus;
@property (nonatomic)CPThreea cpthree;
@property (nonatomic,copy)NSString *shareTo, * lotteryID, * orderID, * lottery_id, *play, * weiBoContent, * caizhong, * myyuce, * textString, * faxqUlr;
@property (nonatomic, assign)BOOL share0, infoShare, three, detailedBool;
@property (nonatomic,assign)MPublishType microblogType;
@property (nonatomic, retain) UIImage *mSelectImage;
@property (nonatomic, retain) NSMutableArray *viewControllers, * keyArray;
@property (nonatomic, retain)ASIHTTPRequest * mRequest, * mReqUpload;
@property (nonatomic, retain)NSURLConnection *urlConnection;


- (void) actionPublish: (UIButton *)sender; // 发送帖子
@end
