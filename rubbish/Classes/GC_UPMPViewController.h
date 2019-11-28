//
//  GC_UPMPViewController.h
//  caibo
//
//  Created by houchenguang on 13-5-31.
//
//

#import <UIKit/UIKit.h>
#import "CPViewController.h"
#import "ASIHTTPRequest.h"
#import "UPPayPluginDelegate.h"
#import "UpLoadView.h"
#import "CP_UIAlertView.h"
#import "LLPaySdk.h"
#import "Umpay.h"
#import "DownLoadImageView.h"
#import "ColorView.h"
#import "MyPickerView.h"
#import "GC_YHMInfoParser.h"
typedef enum
{
    ChongZhiTypeYinLian,
	ChongZhiTypeZhiFuBao,
    Chongzhika,
    Caijinka,
    ChongZhiTypeLianLianYinTong,
    ChongZhiTypeLianDongYouShi,
    ChongZhiTypeWeiXin,
    ChongZhiTypeQQPay,
    ChongZhiTypeLiantong
}ChongZhiType;

@interface GC_UPMPViewController : CPViewController<UITextFieldDelegate, UPPayPluginDelegate,UIActionSheetDelegate,CP_UIAlertViewDelegate,LLPaySdkDelegate,UmpayDelegate,MyPickerViewDelegate>{

    UITextField * moneyTextField;
    ASIHTTPRequest * httpRequest;
    ColorView * moneyText;
    ASIHTTPRequest * upmpRequest;
    ChongZhiType chongZhiType;
    UpLoadView * loadview;
    UIButton * jianpanbg;
    
    DownLoadImageView * userImageView;        //用户头像
    ASIHTTPRequest * reqUserInfo;//头像请求
    
    UIView * BGView;        //说明背景
    UIImageView * alertBGView;      //说明窗口背景
    
    UILabel * dongJieTextLabel;     //冻结
    
    BOOL creditCard;
    CP_UIAlertView *mAlert;
    LLPaySdk *lianliansdk;//连连支付
    
    BOOL isAllowYHM; //是否允许使用充值优惠码
    UIButton *useYHMButton;
    UIButton * moreButton;
    GC_YHMInfoParser *YHMInfoList;
    NSString *yhmCodeForChongzhi;//已选择的优惠码code

    NSMutableArray *mutableYHMArray;
    
    int needRemoveIndex;
    ASIHTTPRequest * boxRequest;//提示框是否弹出
}

- (void)getAccountInfoRequest;
- (void)NewZhiFuBao:(NSString *)url;
- (void)QQpay:(NSString *)url;

@property(nonatomic, retain)ASIHTTPRequest * httpRequest, *upmpRequest,* reqUserInfo, * boxRequest;
@property (nonatomic)ChongZhiType chongZhiType;
@property(nonatomic,assign)BOOL creditCard,isAllowYHM;
@property (nonatomic,retain)LLPaySdk *lianliansdk;
@property (nonatomic,retain)GC_YHMInfoParser *YHMInfoList;
@property (nonatomic,copy) NSString *yhmCodeForChongzhi;
@property (nonatomic, retain)  NSMutableArray *mutableYHMArray;

@end
