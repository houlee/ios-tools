//
//  GCHeMaiSendViewController.h
//  caibo
//
//  Created by yao on 12-6-27.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GC_BetInfo.h"
#import "ColorView.h"
#import "ASIHTTPRequest.h"
#import <AVFoundation/AVFoundation.h>
#import "CPViewController.h"
#import "CP_PTButton.h"
#import "CP_UISegement.h"
#import "CP_UIAlertView.h"
#import "GC_BuyLottery.h"
enum {
    wenzi = 0, //文字状态
    yuyinwithnone = 1, //语音，无语音状态
    hasyuyin = 2  //有语音状态
};

@interface GCHeMaiSendViewController : CPViewController<ASIHTTPRequestDelegate,UITextFieldDelegate,AVAudioRecorderDelegate,/*AVAudioPlayerDelegate,*/CP_UIAlertViewDelegate,CP_UISegementDelegate> {
	
	GC_BetInfo *betInfo;
	ColorView *infoLable;
//	AVAudioRecorder *avRecorder;
	UIButton *sendBtn;
	ASIHTTPRequest *httpRequest;
	UITextField *rengouText;
	UITextField *xuanyanText;
	CP_UISegement *baomiSegment;
	UITextField *tichengText;
	UITextField *baodiText;
	ColorView *yingfuLable;
	ColorView *zhanghuLable;
	CP_PTButton *baodiBtn;
	UILabel *baodiLable;
    BOOL isGoBuy;
    
    BOOL isPutong;  //抄单界面
    NSString *syscurIssre;
    NSInteger recorderTime;
//    NSTimer *myTimer;
    
//    CP_PTButton *recoderBtn;
//    CP_PTButton *deleteBtn;
    NSInteger GoovoiceType;
//    AVAudioPlayer *infoPlayer;
    UIImageView *back2V;
    NSString * saveKey;
    UIImageView *xuanim;
    
    BOOL isShowFangChenMi;
    
    GC_BuyLottery *buyResult;
}
@property (nonatomic, retain)GC_BuyLottery *buyResult;
@property (nonatomic, retain)GC_BetInfo *betInfo;
@property (nonatomic,retain)ASIHTTPRequest *httpRequest;
@property (nonatomic)BOOL isPutong;
@property (nonatomic,copy)NSString *syscurIssre, *saveKey;
//@property (nonatomic,retain)NSTimer *myTimer;
- (void)passWordOpenUrl;

@end
