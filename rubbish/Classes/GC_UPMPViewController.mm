//
//  GC_UPMPViewController.m
//  caibo
//
//  Created by houchenguang on 13-5-31.
//
//

#import "GC_UPMPViewController.h"
#import "Info.h"
#import "GC_AccountManage.h"
#import "GC_HttpService.h"
#import "GC_UserInfo.h"
#import "UPPayPlugin.h"
#import "GC_YinLianData.h"
#import "GC_ZhiFuBaoData.h"
#import "CP_UIAlertView.h"
#import "caiboAppDelegate.h"
#import "ColorView.h"
#import "UserInfo.h"
#import "NetURL.h"
#import "GouCaiHomeViewController.h"
#import "JSON.h"
#import "GouCaiShuZiInfoViewController.h"
#import "GC_ShengfuInfoViewController.h"
#import "GC_LianLianYinTongData.h"
#import "GC_LianDongYouShiData.h"
#import "UmpayElements.h"
#import <AlipaySDK/AlipaySDK.h>
#import "QQPaySDK.h"
#import "MobClick.h"
#import "MyPickerView.h"
#import "GC_YHMInfoParser.h"
#import <CoreText/CoreText.h>

#define kResult           @"支付结果：%@"
#define kNote             @"提示" 
#define kConfirm          @"确定"

#define kfinish  @"完成充值"
#define kgoOn  @"继续充值"

#define IS_IOS_7    ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7)

@interface GC_UPMPViewController ()

@end

@implementation GC_UPMPViewController

@synthesize httpRequest;
@synthesize upmpRequest,reqUserInfo;
@synthesize chongZhiType;
@synthesize creditCard;
@synthesize lianliansdk;
@synthesize YHMInfoList;
@synthesize isAllowYHM;
@synthesize yhmCodeForChongzhi, boxRequest;
@synthesize mutableYHMArray;
- (void)showAlertMessage:(NSString*)msg finish:(NSString *)fin goon:(NSString *)go
{
    if (!mAlert) {
        mAlert = [[CP_UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:fin otherButtonTitles:go, nil];
        // mAlert.alertTpye=ordinaryType;
        mAlert.tag=3330;
    }
    
    [mAlert show];
    [mAlert release];
    if ([msg isEqualToString:@"您已经完成充值?"]) {
        for (UIImageView * bgImageView in mAlert.subviews) {
            if ([bgImageView isKindOfClass:[UIImageView class]]) {
                UIButton *qButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 118, 30, 30)];
                [qButton addTarget:self action:@selector(explain) forControlEvents:UIControlEventTouchUpInside];
                qButton.backgroundColor = [UIColor clearColor];

                UIImageView *buttonView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"faq-wenhao.png"]];
                buttonView.frame=CGRectMake(0, 0, 15, 15);
                           [qButton addSubview:buttonView];
                
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(163, 118, 77, 16)];
                label.text=@"充值遇到问题";
                label.textColor=[UIColor colorWithRed:88/255.0 green:88/255.0 blue:88/255.0 alpha:1];
                label.font=[UIFont systemFontOfSize:12];
                label.backgroundColor=[UIColor clearColor];
                [bgImageView addSubview:label];
                [bgImageView addSubview:qButton];
                [qButton release];
                [buttonView release];
            }
        }
    }
}


- (void)UPPayPluginResult:(NSString *)result
{
    
    NSString * msg = @"";
  
    if ([result isEqualToString:@"success"]) {
        if (creditCard) {
            [MobClick event:@"event_wodecaipiao_chongzhi_queren_fangshi" label:@"信用卡充值"];
        }else{
            [MobClick event:@"event_wodecaipiao_chongzhi_queren_fangshi" label:@"银行卡充值"];
        }
        
        msg = @"您已经完成充值?";
       [self getAccountInfoRequest];
        NSString *inFor=[NSString stringWithFormat:@"%@",msg];
        [self showAlertMessage:inFor finish:@"继续充值" goon:@"完成充值"];
        
      

    }else if([result isEqualToString:@"fail"]){
        
        
        msg = @"支付失败";
        
        NSString* infoString = [NSString stringWithFormat:@"%@", msg];
        [self showAlertMessage:infoString finish:kConfirm goon:nil];
    
    }else if([result isEqualToString:@"cancel"]){
        

        
        msg = @"您在中途放弃了充值";
        
    
        NSString* infoString = [NSString stringWithFormat:@"%@", msg];
        [self showAlertMessage:infoString finish:kConfirm goon:nil];
    }
    
    
  //  NSString* infoString = [NSString stringWithFormat:@"%@", msg];
   // [self showAlertMessage:infoString];
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==3330) {
    //   if ([alertView.message isEqualToString:@"您已经完成充值?"]) {
            if (buttonIndex==1) {

        for (UIViewController *cont in self.navigationController.viewControllers) {
            if ([cont isKindOfClass:[GC_ShengfuInfoViewController class] ] || [cont isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
            [self.navigationController popToViewController:cont animated:YES];
                
                return;

                
                    }
                }
                
                
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] -3] animated:YES];
                [self getAccountInfoRequest];

            }
            else
            {
                
                
            }
            mAlert = nil;
      //  }
  
    }
    
    
}

- (void)upmpHttpRequest{

//    NSMutableData *postData = [[GC_HttpService sharedInstance] reqAccountManager:[[Info getInstance] userName]];
    if (chongZhiType == ChongZhiTypeZhiFuBao) {
        if ([moneyTextField.text integerValue] < 1) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"支付宝充值至少充值1元" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [alert release];
           
            return;
        }
        
        loadview = [[UpLoadView alloc] init];
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:loadview];
        [loadview release];
        
        NSMutableData *postData = [[GC_HttpService sharedInstance] ZhiFuBaoMoney:moneyTextField.text userName:[[Info getInstance] userName] YHMCode:self.yhmCodeForChongzhi];
        
        [upmpRequest clearDelegatesAndCancel];
        self.upmpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [upmpRequest setRequestMethod:@"POST"];
        [upmpRequest addCommHeaders];
        [upmpRequest setPostBody:postData];
        [upmpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [upmpRequest setDelegate:self];
        [upmpRequest setDidFinishSelector:@selector(reqZhiFuBaoFinished:)];
        [upmpRequest setDidFailSelector:@selector(reqFailChongZhi:)];
        [upmpRequest startAsynchronous];
        
    }
    else if (chongZhiType == ChongZhiTypeYinLian){
        
        if (!moneyTextField.text || [moneyTextField.text intValue] < 1 ) {
            
            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"最少充值1元" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            return;
            
        }
        loadview = [[UpLoadView alloc] init];
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:loadview];
        [loadview release];
        
        NSMutableData *postData = [[GC_HttpService sharedInstance] upmpMoney:moneyTextField.text userName:[[Info getInstance] userName] YHMCode:self.yhmCodeForChongzhi];
        
        [upmpRequest clearDelegatesAndCancel];
        self.upmpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [upmpRequest setRequestMethod:@"POST"];
        [upmpRequest addCommHeaders];
        [upmpRequest setPostBody:postData];
        [upmpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [upmpRequest setDelegate:self];
        [upmpRequest setDidFinishSelector:@selector(reqUPMPFinished:)];
        [upmpRequest setDidFailSelector:@selector(reqFailChongZhi:)];
        [upmpRequest startAsynchronous];
    }
    else if (chongZhiType == ChongZhiTypeLianLianYinTong) {
        if ([moneyTextField.text integerValue] < 1) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"银行卡支付充值至少充值1元" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [alert release];
            
            return;
        }
        
        loadview = [[UpLoadView alloc] init];
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:loadview];
        [loadview release];
        
        NSMutableData *postData = [[GC_HttpService sharedInstance] reqLianlianYintong:moneyTextField.text YHMCode:@""];
        
        [upmpRequest clearDelegatesAndCancel];
        self.upmpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [upmpRequest setRequestMethod:@"POST"];
        [upmpRequest addCommHeaders];
        [upmpRequest setPostBody:postData];
        [upmpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [upmpRequest setDelegate:self];
        [upmpRequest setDidFinishSelector:@selector(reqLianLianYintongFinished:)];
        [upmpRequest setDidFailSelector:@selector(reqFailChongZhi:)];
        [upmpRequest startAsynchronous];
    }
    else if (chongZhiType == ChongZhiTypeLianDongYouShi) {
        if ([moneyTextField.text integerValue] < 1) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"信用卡充值至少充值1元" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [alert release];
            
            return;
        }
        
        loadview = [[UpLoadView alloc] init];
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:loadview];
        [loadview release];
        
        NSMutableData *postData = [[GC_HttpService sharedInstance] umpayMoney:moneyTextField.text YHMCode:self.yhmCodeForChongzhi];
        
        [upmpRequest clearDelegatesAndCancel];
        self.upmpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [upmpRequest setRequestMethod:@"POST"];
        [upmpRequest addCommHeaders];
        [upmpRequest setPostBody:postData];
        [upmpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [upmpRequest setDelegate:self];
        [upmpRequest setDidFinishSelector:@selector(reqLianDongYouShiFinished:)];
        [upmpRequest setDidFailSelector:@selector(reqFailChongZhi:)];
        [upmpRequest startAsynchronous];
        
    }
    else if (chongZhiType == ChongZhiTypeWeiXin) {
        if ([moneyTextField.text integerValue] < 1) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"银行卡支付充值至少充值1元" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [alert release];
            
            return;
        }
        
        loadview = [[UpLoadView alloc] init];
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:loadview];
        [loadview release];
        
        NSMutableData *postData = [[GC_HttpService sharedInstance]reqWeiXinChongZhi:moneyTextField.text withYHMCode:self.yhmCodeForChongzhi];
        
        [upmpRequest clearDelegatesAndCancel];
        self.upmpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [upmpRequest setRequestMethod:@"POST"];
        [upmpRequest addCommHeaders];
        [upmpRequest setPostBody:postData];
        [upmpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [upmpRequest setDelegate:self];
        [upmpRequest setDidFinishSelector:@selector(reqWeiXinFinished:)];
        [upmpRequest setDidFailSelector:@selector(reqFailChongZhi:)];
        [upmpRequest startAsynchronous];
    }
    else if (chongZhiType == ChongZhiTypeQQPay) {
        if ([moneyTextField.text integerValue] < 1) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"QQ充值至少充值1元" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [alert release];
            
            return;
        }
        
        loadview = [[UpLoadView alloc] init];
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:loadview];
        [loadview release];
        
        NSMutableData *postData = [[GC_HttpService sharedInstance]reqQQpay:moneyTextField.text withYHMCode:self.yhmCodeForChongzhi];
        
        [upmpRequest clearDelegatesAndCancel];
        self.upmpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [upmpRequest setRequestMethod:@"POST"];
        [upmpRequest addCommHeaders];
        [upmpRequest setPostBody:postData];
        [upmpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [upmpRequest setDelegate:self];
        [upmpRequest setDidFinishSelector:@selector(reqQQpayFinished:)];
        [upmpRequest setDidFailSelector:@selector(reqFailChongZhi:)];
        [upmpRequest startAsynchronous];
    }
    else if (chongZhiType == ChongZhiTypeLiantong) {
//        if ([moneyTextField.text integerValue] < 1) {
//            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"联通充值至少充值1元" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alert show];
//            [alert release];
//            
//            return;
//        }
//        
//        loadview = [[UpLoadView alloc] init];
//        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
//        [appDelegate.window addSubview:loadview];
//        [loadview release];
//        
//        NSMutableData *postData = [[GC_HttpService sharedInstance]reqLiantongpay:moneyTextField.text withYHMCode:self.yhmCodeForChongzhi];
//        
//        [upmpRequest clearDelegatesAndCancel];
//        self.upmpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
//        [upmpRequest setRequestMethod:@"POST"];
//        [upmpRequest addCommHeaders];
//        [upmpRequest setPostBody:postData];
//        [upmpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//        [upmpRequest setDelegate:self];
//        [upmpRequest setDidFinishSelector:@selector(reqLiantongpayFinished:)];
//        [upmpRequest setDidFailSelector:@selector(reqFailChongZhi:)];
//        [upmpRequest startAsynchronous];
    }

}

#pragma mark - 联动优势

- (void)reqLianDongYouShiFinished:(ASIHTTPRequest *)request
{
    [loadview stopRemoveFromSuperview];
    loadview = nil;
    if ([request responseData]) {
        GC_LianDongYouShiData * lianDongYouShiData = [[[GC_LianDongYouShiData alloc] initWithResponseData:[request responseData] WithRequest:request] autorelease];
        
        if (!lianDongYouShiData.returnMessage) {
            UmpayElements* inPayInfo = [[[UmpayElements alloc]init] autorelease];
            inPayInfo.identityCode = lianDongYouShiData.idCard;
            inPayInfo.editFlag = @"0";
            inPayInfo.cardHolder = lianDongYouShiData.realName;
            inPayInfo.mobileId = nil;

            [Umpay pay:lianDongYouShiData.orderNumber merCustId:nil shortBankName:nil cardType:nil payDic:inPayInfo rootViewController:self delegate:self];
        }else{
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:lianDongYouShiData.showMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
    }
}

- (void)onPayResult:(NSString*)orderId resultCode:(NSString*)resultCode resultMessage:(NSString*)resultMessage
{
    if ([resultCode isEqualToString:@"1001"]) {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:resultMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }else{
        CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您已经完成充值？" delegate:self cancelButtonTitle:@"继续充值" otherButtonTitles:@"完成充值", nil];
        alert.tag = 3330;
        [alert show];
        [alert release];
    }
}

#pragma mark -


- (void)reqFailChongZhi:(ASIHTTPRequest *)request{
    
 [loadview stopRemoveFromSuperview];
    loadview = nil;

}

- (void)reqUPMPFinished:(ASIHTTPRequest *)request{
    [loadview stopRemoveFromSuperview];
    loadview = nil;
    if ([request responseData]) {
        
        GC_YinLianData * yinlian = [[GC_YinLianData alloc] initWithResponseData:[request responseData] WithRequest:request];
        [UPPayPlugin startPay:yinlian.returnContent mode:@"00" viewController:self delegate:self];
        [yinlian release];
//        [UPPayPlugin startPay:yinlian.returnContent sysProvide:nil spId:nil mode:@"00" viewController:self delegate:self];
        
    }

}

- (void)reqLianLianYintongFinished:(ASIHTTPRequest *)request{
    [loadview stopRemoveFromSuperview];
    loadview = nil;
    if ([request responseData]) {
        GC_LianLianYinTongData * lianlian = [[GC_LianLianYinTongData alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (lianlian.returnId != 3000) {
            if (lianlian.returnMessage == 0 && [lianlian.returnContent length]) {
                NSArray *array = [lianlian.returnContent componentsSeparatedByString:@"|"];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                if ([array count] >= 10) {
                    [dic setValue:[array objectAtIndex:2] forKey:@"busi_partner"];
                    [dic setValue:[array objectAtIndex:4] forKey:@"dt_order"];
                    [dic setValue:[array objectAtIndex:6] forKey:@"info_order"];
                    [dic setValue:[array objectAtIndex:7] forKey:@"money_order"];
                    [dic setValue:[array objectAtIndex:5] forKey:@"name_goods"];
                    [dic setValue:[array objectAtIndex:3] forKey:@"no_order"];
                    [dic setValue:[array objectAtIndex:8] forKey:@"notify_url"];
                    [dic setValue:[array objectAtIndex:0] forKey:@"oid_partner"];
                    [dic setValue:[array objectAtIndex:9] forKey:@"partner_sign"];
                    [dic setValue:[array objectAtIndex:1] forKey:@"partner_sign_type"];
                }
                if ([dic count]) {
                    if ([lianlian.Other length]) {
                        [dic setValue:lianlian.Other forKey:@"user_id"];
                    }
                    
                    if ([lianlian.realInfo length]) {
                        [dic setValue:lianlian.realInfo forKey:@"risk_item"];
                        NSDictionary *dic2 = [lianlian.realInfo JSONValue];
                        if (dic2) {
                            if ([dic2 valueForKey:@"user_info_full_name"]) {
                                [dic setValue:[dic2 valueForKey:@"user_info_full_name"] forKey:@"acct_name"];
                            }
                            if ([dic2 valueForKey:@"user_info_id_no"]) {
                                [dic setValue:[dic2 valueForKey:@"user_info_id_no"] forKey:@"id_no"];
                                [dic setValue:@"1" forKey:@"flag_modify"];
                            }
                            
                            
                        }
                    }
                    LLPaySdk *sdk = [[LLPaySdk alloc] init];
                    self.lianliansdk =sdk;
                    sdk.sdkDelegate = self;
                    
                    self.modalTransitionStyle = UIModalTransitionStylePartialCurl;
                    [sdk presentPaySdkInViewController:self withTraderInfo:dic];
                    [sdk release];

                    
                }
                else {
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"订单提交失败，请稍后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }

            }
            else {
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"订单提交失败，请稍后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
        }
        [lianlian release];
    }
}

-(void)payFinished:(NSDictionary *) dic{
    NSLog(@"%@",dic);
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        if ([[dic objectForKey:@"RET_CODE"] integerValue] == 0) {
            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:[dic valueForKey:@"RET_MSG"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else if ([[dic objectForKey:@"RET_CODE"] integerValue] == 1) {
            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:[dic valueForKey:@"RET_MSG"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
}

- (void)reqLiantongpayFinished:(ASIHTTPRequest *)request{
    [loadview stopRemoveFromSuperview];
    loadview = nil;
//    if ([request responseData]) {
//        GC_LianLianYinTongData * lianlian = [[GC_LianLianYinTongData alloc] initWithResponseData:[request responseData] WithRequest:request];
//        if (lianlian.returnId != 3000) {
//            HuaFTSDK * huang = [HuaFTSDK initHuaFTSDK];
//            huang.delegate = self;
//            //            [huang submitPayReqFromView:self WithRequest:lianlian.realInfo WithServiceType:4 WithAppKey:lianlian.liantongurl ];
//            [huang submitPayReqFromView:self WithPartnerTradeNo:lianlian.orderID WithRequest:lianlian.realInfo WithServiceType:4 WithAppKey:@"caipiao365"];
//            
//        }
//        [lianlian release];
//    }
}

- (void)reqQQpayFinished:(ASIHTTPRequest *)request{
    [loadview stopRemoveFromSuperview];
    loadview = nil;
    if ([request responseData]) {
        GC_LianLianYinTongData * lianlian = [[GC_LianLianYinTongData alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (lianlian.returnId != 3000) {
            if([QQPaySDK isQQPayWork] == NO)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"您的手机上未安装手机QQ或QQ版本过低，请升级手机QQ后方可使用QQ支付"
                                                              delegate:nil
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
                [alert show];
                [alert release];
                
               
            }
            else {
                [QQPaySDK startQQPay:lianlian.realInfo appName:@"caipiao365" appId:nil];
            }
            
        }
        [lianlian release];
    }
    
}


- (void)reqWeiXinFinished:(ASIHTTPRequest *)request{
    [loadview stopRemoveFromSuperview];
    loadview = nil;
    if ([request responseData]) {
        GC_LianLianYinTongData * lianlian = [[GC_LianLianYinTongData alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (lianlian.returnId != 3000) {
            if (lianlian.returnMessage == 0 && [lianlian.returnContent length]) {
                NSArray *array = [lianlian.returnContent componentsSeparatedByString:@"|"];
                PayReq *request = [[[PayReq alloc] init] autorelease];
                if ([array count] > 5) {
                    request.partnerId = [array objectAtIndex:0];
                    request.prepayId= [array objectAtIndex:1];
                    request.package = [array objectAtIndex:2];
                    request.nonceStr= [array objectAtIndex:3];
                    request.timeStamp= [[array objectAtIndex:4] unsignedIntValue];
                    request.sign= [array objectAtIndex:5];
                    
                }
                if ([array count] > 6) {
                    [WXApi registerApp:[array objectAtIndex:6]];
                }
                [WXApi sendReq:request];
                
            }
            else {
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"订单提交失败，请稍后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
        }
        [lianlian release];
    }
}

- (void)QQpay:(NSString *)url{
    [MobClick event:@"event_wodecaipiao_chongzhi_queren_fangshi" label:@"QQ钱包"];
    CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"充值成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)NewZhiFuBao:(NSString *)url {
    NSArray *array1 = [url componentsSeparatedByString:@"?"];
    if ([array1 count] > 1) {
        NSString *str = [[array1 objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [[str JSONValue] valueForKey:@"memo"];
        if (dic && [dic isKindOfClass:[NSDictionary class]]) {
            if ([[dic objectForKey:@"ResultStatus"] integerValue] == 9000) {
                [self getAccountInfoRequest];
                [MobClick event:@"event_wodecaipiao_chongzhi_queren_fangshi" label:@"支付宝"];
                CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"充值成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
            else  {
                if ([[dic objectForKey:@"memo"] length]) {
                    CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:[dic objectForKey:@"memo"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
            }
        }

    }

}

- (void)reqZhiFuBaoFinished :(ASIHTTPRequest *)request{
     [loadview stopRemoveFromSuperview];
    loadview = nil;
    if ([request responseData]) {
        
        GC_ZhiFuBaoData * zhifubao = [[GC_ZhiFuBaoData alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (zhifubao.returnId != 3000) {
            [[AlipaySDK defaultService] payOrder:zhifubao.zhifuBaoContent fromScheme:caipiao365BackURLForAlipay callback:^(NSDictionary *dic) {
                if ([[dic objectForKey:@"ResultStatus"] integerValue] == 9000) {
                    [self getAccountInfoRequest];
                }
                else {
                    if ([[dic objectForKey:@"memo"] length]) {
                        CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:[dic objectForKey:@"memo"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                    }
                }
                
            }];
        }
        [zhifubao release];
    }
}

- (void)getAccountInfoRequest
{
    if ([[[Info getInstance] userName] length] > 0) {
        //获取账户信息
        NSMutableData *postData = [[GC_HttpService sharedInstance] reqAccountManager:[[Info getInstance] userName]];
        
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
		[httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(reqAccountInfoFinished:)];
        [httpRequest startAsynchronous];
    }
}

- (void)reqAccountInfoFinished:(ASIHTTPRequest*)request
{
    if ([request responseData]) {
		GC_AccountManage *aManage = [[GC_AccountManage alloc] initWithResponseData:[request responseData]WithRequest:request];
        if (aManage != nil && aManage.returnId != 3000){
            
            [GC_UserInfo sharedInstance].accountManage = aManage;
            NSLog(@"%@", [GC_UserInfo sharedInstance].accountManage.accountBalance);
            float  balance = [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue];
            NSString * fanganstr5 = [NSString stringWithFormat:@"余额 <%.2f> 元 ", balance ];
            moneyText.text=fanganstr5;
            
        }
		[aManage release];
        
        
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getAccountInfoRequest];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (chongZhiType == ChongZhiTypeZhiFuBao) {
        self.CP_navigation.title = @"支付宝充值";
    }
    else if (chongZhiType == ChongZhiTypeLianLianYinTong) {
        self.CP_navigation.title = @"银行卡支付充值";
    }
    else if (chongZhiType == ChongZhiTypeWeiXin ){
        self.CP_navigation.title = @"微信支付充值";
    }else if (chongZhiType == ChongZhiTypeQQPay) {
        self.CP_navigation.title = @"手Q支付充值";
    }
    
    else {
        if (creditCard == YES) {
            self.CP_navigation.title = @"信用卡充值";
        }
        
        else{
            self.CP_navigation.title = @"银行卡充值";
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(YHMTextFieldChaned:) name:@"YHMTextFieldChaned" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAccountInfoRequest) name:@"BecomeActive" object:nil];
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = leftItem;
    
    self.mainView.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1.0];
    

    jianpanbg = [UIButton buttonWithType:UIButtonTypeCustom];
    //            caiboAppDelegate * caiboapp = [caiboAppDelegate getAppDelegate];
    
    jianpanbg.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);//caiboapp.window.bounds;
    jianpanbg.backgroundColor = [UIColor clearColor];
    jianpanbg.hidden = YES;
    [jianpanbg addTarget:self action:@selector(pressJianPanBG:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:jianpanbg];

    
    
    
    UILabel * userNameText = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, 120, 15)];
    userNameText.backgroundColor = [UIColor clearColor];
    userNameText.textAlignment = NSTextAlignmentLeft;
    userNameText.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    userNameText.font = [UIFont systemFontOfSize:12];
    userNameText.tag = 10;
    userNameText.text =[[Info getInstance] nickName];
    [self.mainView addSubview:userNameText];
    [userNameText release];
    
    
    
    moneyText = [[ColorView alloc] initWithFrame:CGRectMake(125, 33, 170, 20)];
    moneyText.backgroundColor = [UIColor clearColor];
    moneyText.textAlignment = 1;
    moneyText.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    moneyText.font = [UIFont systemFontOfSize:12];
    moneyText.colorfont = [UIFont systemFontOfSize:18];
    moneyText.pianyiHeight = 6;
    moneyText.tag = 11;
    float  balance = [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue];
    moneyText.text = [NSString stringWithFormat:@"余额 <%.2f> 元 ", balance ];
    [self.mainView addSubview:moneyText];
    [moneyText release];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];
    
    
    UIView *chongBack = [[UIView alloc]initWithFrame:CGRectMake(-0.5, 76, 321, 45)];
    chongBack.layer.borderWidth = 0.5;
    chongBack.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.mainView addSubview:chongBack];
    chongBack.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    [chongBack release];
    

    
    moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, 14, 85, 20)];
    if (IS_IOS_7) {
        moneyTextField.frame = CGRectMake(90, 16, 85, 20);
    }
    moneyTextField.backgroundColor=  [UIColor clearColor];
    moneyTextField.placeholder = @"请输入金额";
    moneyTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    moneyTextField.layer.borderWidth = 0.5;
    moneyTextField.layer.masksToBounds = YES;
    moneyTextField.font = [UIFont systemFontOfSize:13];
    moneyTextField.layer.cornerRadius = 5;
    moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    moneyTextField.textAlignment = NSTextAlignmentCenter;
    moneyTextField.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    moneyTextField.delegate =  self;
    [moneyTextField setValue:moneyTextField.textColor forKeyPath:@"_placeholderLabel.textColor"];
    [chongBack addSubview:moneyTextField];
    [moneyTextField release];
    
    UILabel * chongZhiLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 16, 30, 20)];
    chongZhiLabel.backgroundColor = [UIColor clearColor];
    chongZhiLabel.text = @"金额";
    chongZhiLabel.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    chongZhiLabel.textAlignment = NSTextAlignmentLeft;
    chongZhiLabel.font = [UIFont boldSystemFontOfSize:14];
    [chongBack addSubview:chongZhiLabel];
    [chongZhiLabel release];
    
    UILabel * yuanLabel = [[UILabel alloc] initWithFrame:CGRectMake(178, 16, 30, 20)];
    yuanLabel.backgroundColor = [UIColor clearColor];
    yuanLabel.text = @"元";
    yuanLabel.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    yuanLabel.textAlignment = 1;
    yuanLabel.font = [UIFont boldSystemFontOfSize:14];
    [chongBack addSubview:yuanLabel];
    [yuanLabel release];
    
    
    ColorView * downTextColorView = [[ColorView alloc] initWithFrame:CGRectMake(12, 200, 210, 160)];
    downTextColorView.backgroundColor = [UIColor clearColor];
    downTextColorView.huanString = @"~";
    downTextColorView.text = @"最少充值<1>元。~充值后,消费充值金额的 <30%> 可提现。";
    if (chongZhiType == ChongZhiTypeLianLianYinTong) {
        downTextColorView.text = @"最少充值<10>元。~充值后,消费充值金额的 <30%> 可提现。";
    }else if (chongZhiType == ChongZhiTypeLianDongYouShi) {
        downTextColorView.text = @"最少充值<1>元。~充值金额必须全部消费，不能提现。";
    }
    downTextColorView.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0];
    downTextColorView.font = [UIFont systemFontOfSize:12];
    [self.mainView addSubview:downTextColorView];
    [downTextColorView release];
    
    if (chongZhiType != ChongZhiTypeLianDongYouShi) {
        UILabel * explainLable = [[UILabel alloc] initWithFrame:CGRectMake(251, 200, 30, 20)];
        explainLable.text = @"说明";
        explainLable.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:1 alpha:1.0];
        explainLable.backgroundColor = [UIColor clearColor];
        explainLable.font = [UIFont boldSystemFontOfSize:12];
        [self.mainView addSubview:explainLable];
        [explainLable release];
        
        UIButton * explainButton = [[[UIButton alloc] initWithFrame:CGRectMake(270, 190, 40, 40)] autorelease];
        [self.mainView addSubview:explainButton];
        [explainButton addTarget:self action:@selector(explain) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView * explainImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(280, 203, 15, 15)] autorelease];
        explainImageView.image = [UIImage imageNamed:@"chongzhiwenhao.png"];
        [self.mainView addSubview:explainImageView];
    }
    
    //默认无充值优惠码
    
    useYHMButton =[UIButton buttonWithType:UIButtonTypeCustom];
    useYHMButton.frame = CGRectMake(15, 275, 290, 45);
    [useYHMButton addTarget:self action:@selector(pressUseYHM:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:useYHMButton];
    useYHMButton.hidden = YES;
    useYHMButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [useYHMButton setTitle:@"使用优惠码" forState:UIControlStateNormal];
    [useYHMButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [useYHMButton setBackgroundImage:UIImageGetImageFromName(@"point_useYHM.png") forState:UIControlStateNormal];
    
    moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(15, 335, 290, 45);
    [moreButton addTarget:self action:@selector(pressMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:moreButton];
    moreButton.hidden = YES;
    [moreButton setTitle:@"充值" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    moreButton.layer.masksToBounds = YES;
    moreButton.layer.cornerRadius = 5;
    [moreButton setBackgroundImage:[UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    
    UIView *btnView = [[UIView alloc] init];
    [self.mainView addSubview:btnView];
    btnView.tag = 500;
    btnView.backgroundColor = [UIColor whiteColor];
    btnView.frame = CGRectMake(-0.5, 120, 321, 69);
    btnView.layer.borderWidth = 0.5;
    btnView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [btnView release];
    
    NSArray * moneysArray = @[@[@"10",@"20",@"50",@"100"]];
    for (int i = 0; i < moneysArray.count; i++) {
        for (int j = 0; j < [[moneysArray objectAtIndex:i] count]; j++) {
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(15 + 75*j, 15 + 50 * i, 63, 35)];
            [button setTitle:[[moneysArray objectAtIndex:i] objectAtIndex:j] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            button.layer.borderWidth = 0.5;
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 5;
            [button setBackgroundImage:nil forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateSelected];
            [btnView addSubview:button];
            [button addTarget:self action:@selector(addMoneys:) forControlEvents:UIControlEventTouchUpInside];
            [button release];
        }
    }
    
    
    self.yhmCodeForChongzhi = @"";
    
    [self getUserYHMList];
    
//    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isAlipay"] isEqualToString:@"4"]) {
//        self.boxRequest = [ASIHTTPRequest requestWithURL:[NetURL getRefillRemindRequest]];
//        [boxRequest setTimeOutSeconds:20.0];
//        [boxRequest setDidFinishSelector:@selector(refillFinish:)];
//        [boxRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//        [boxRequest setDelegate:self];
//        [boxRequest startAsynchronous];
//    }
    
    
    
//    //第一次进入的提示框
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"onechongzhialert"] intValue] != 1) {
//        
//       
//        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"onechongzhialert"];
//    }
}

- (void)refillFinish:(ASIHTTPRequest *)requesta{

    
//    if (requesta) {
//        NSString * restr = [requesta responseString];
//        NSDictionary * dict = [restr JSONValue];
//        if ([[dict objectForKey:@"status"] isEqualToString:@"0"]) {
//            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"充值提醒信息" message:[dict objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            alert.tag = 197;
//            alert.alertTpye = chongzhidiyici;
//            [alert show];
//            [alert release];
//        }
//    }
    
    

}


-(void)getUserYHMList{

    NSMutableData *postData = [[GC_HttpService sharedInstance] reqGetUserYHMListStatus:@"0" pageNum:1 pageCount:10];
    
    ASIHTTPRequest *httpRequests = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequests setRequestMethod:@"POST"];
    [httpRequests addCommHeaders];
    [httpRequests setPostBody:postData];
    [httpRequests setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequests setDelegate:self];
    [httpRequests setDidFinishSelector:@selector(reqUserYHMListFinished:)];
    [httpRequests setDidFailSelector:@selector(reqUserYHMListFailed:)];
    [httpRequests startAsynchronous];
}
-(void)reqUserYHMListFinished:(ASIHTTPRequest *)requests{
    
    if(![requests.responseString isEqualToString:@"fail"]){
        
        GC_YHMInfoParser *prizeinfo = [[GC_YHMInfoParser alloc] initWithResponseData:requests.responseData WithRequest:requests];
        if(prizeinfo.returnId != 3000){
            
            if (self.YHMInfoList) {
                
                if (prizeinfo.curCount > 0) {
                    [self.YHMInfoList.YHMInfoArray addObjectsFromArray:prizeinfo.YHMInfoArray];
                }
            }
            else {
                self.YHMInfoList = prizeinfo;
            }
            
            if(self.isAllowYHM && self.self.YHMInfoList.YHMInfoArray && self.YHMInfoList.YHMInfoArray.count){
            
                useYHMButton.hidden = NO;
                moreButton.hidden = NO;
            }
            else{
            
                moreButton.hidden = NO;
                moreButton.frame = CGRectMake(15, 275, 290, 45);
                
            }
        }
        
        
        [prizeinfo release];
    }
}
-(void)reqUserYHMListFailed:(ASIHTTPRequest *)requests{

    NSLog(@"reqUserYHMListFailed %@",requests.responseString);
    
    moreButton.hidden = NO;
    moreButton.frame = CGRectMake(15, 275, 290, 45);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self pressJianPanBG:nil];
}

- (NSString *)transString:(NSString *)text
{
    NSString *string = [[text componentsSeparatedByString:@"."] objectAtIndex:0];
    if (string.length>4) {
        NSInteger ge = [string integerValue]%10;
        NSInteger shi = ([string integerValue]%100 - ge)/10;
        NSInteger bai = ([string integerValue]%1000 - shi -ge)/100;
        NSInteger qian = ([string integerValue]%10000 - bai - shi- ge)/1000;
        NSInteger wan = [string integerValue]/10000 ;
        NSString *result = [NSString stringWithFormat:@"%ld%@%ld%ld万",(long)wan,@".",(long)qian,(long)bai];
        return result;
    }else{
        return [NSString stringWithFormat:@"%@ ",text];
    }
}


- (void)reqUserInfoFinished:(ASIHTTPRequest *)request
{
	NSString *responseStr = [request responseString];
    if (![responseStr isEqualToString:@"fail"])
    {
        UserInfo *mUserInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
        if (mUserInfo)
        {
            [[Info getInstance] setMUserInfo:mUserInfo];
            if (mUserInfo.big_image)
            {
                NSString *urlStr = [Info strFormatWithUrl:mUserInfo.big_image];
                NSURL *url = [NSURL URLWithString:urlStr];
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                UIImage *headImage = [UIImage imageWithData:imageData];
                userImageView.image = headImage;
            }
        }
        [mUserInfo release];
    }
}


-(void)explain
{
    if (mAlert) {
        [mAlert removeFromSuperview];
        mAlert = nil;
    }
    
    [moneyTextField resignFirstResponder];
    BGView = [[UIView alloc] initWithFrame:self.view.bounds];
    BGView.backgroundColor = [UIColor blackColor];
    BGView.alpha = 0.8;
    [self.view addSubview:BGView];
    
    alertBGView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TSBG960.png"]];
    alertBGView.userInteractionEnabled = YES;
    [self.view addSubview:alertBGView];
    
    
    
    UIImageView * alertMsgBGView = [[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"AlertMsgBG.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:18]]autorelease];
    [alertBGView addSubview:alertMsgBGView];
    
    
    if (chongZhiType == ChongZhiTypeYinLian) {
//        if (IS_IOS_7) {
            alertBGView.frame = CGRectMake(10, 70, 300, 310);
            alertMsgBGView.frame = CGRectMake(10, alertBGView.frame.origin.y - 25, 280, alertBGView.frame.size.height - 115);
//        }else{
//            alertBGView.frame = CGRectMake(10, 60, 300, 330);
//            alertMsgBGView.frame = CGRectMake(10, alertBGView.frame.origin.y - 20, 280, alertBGView.frame.size.height - 105);
//        }
        
        ColorView * alertMsgView = [[ColorView alloc] initWithFrame:CGRectMake(10, 10, 260, 70)];
        [alertMsgBGView addSubview:alertMsgView];
        [alertMsgView release];
        alertMsgView.font = [UIFont systemFontOfSize:12.5];
        alertMsgView.backgroundColor = [UIColor clearColor];
        if (IS_IOS_7) {
            alertMsgView.text = @"1.姓名要与银行卡填写的户名一致                   2.身份证号要与银行卡填写的一致                   3.手机号码要与银行卡开户填写的号码一致";
        }else{
            alertMsgView.text = @"1.姓名要与银行卡填写的户名一致                2.身份证号要与银行卡填写的一致                3.手机号码要与银行卡开户填写的号码一致";
        }
        
        ColorView * alertMsgView1 = [[ColorView alloc] initWithFrame:CGRectMake(10, alertMsgView.frame.origin.y + alertMsgView.frame.size.height - 20, 260, 80)];
        [alertMsgBGView addSubview:alertMsgView1];
        alertMsgView1.font = [UIFont systemFontOfSize:12];
        alertMsgView1.textColor = [UIColor darkGrayColor];
        alertMsgView1.backgroundColor = [UIColor clearColor];
        alertMsgView1.text = @"在使用网上银行方式充值时，请您注意查看所填写的金额及银行，避免造成充值失败。一般情况下网上银行充值为即时到账，当您充值成功后，请再次查看账户中的余额是否增加。充值后，消费充值金额的<30%>可提现。";
        [alertMsgView1 release];
        
        
        //        UITextView * alertMsgTextView1 = [[[UITextView alloc] init] autorelease];
        //        if (IS_IOS_7) {
        //            alertMsgTextView1.frame = CGRectMake(6, alertMsgTextView.frame.origin.y + alertMsgTextView.frame.size.height - 18, 268, 110);
        //        }else{
        //            alertMsgTextView1.frame = CGRectMake(6, alertMsgTextView.frame.origin.y + alertMsgTextView.frame.size.height - 10, 268, 110);
        //        }
        //        [alertMsgBGView addSubview:alertMsgTextView1];
        //        alertMsgTextView1.text = @"在使用网上银行方式充值时，请您注意查看所填写的金额及银行，避免造成充值失败。一般情况下网上银行充值为即时到账，当您充值成功后，请再次查看账户中的余额是否增加。充值后，消费充值金额的        可提现。";
        //        alertMsgTextView1.font = [UIFont systemFontOfSize:12];
        //        alertMsgTextView1.textColor = [UIColor darkGrayColor];
        //        alertMsgTextView1.backgroundColor = [UIColor clearColor];
        
        //        UILabel * msgLabel = [[UILabel alloc] init];
        //        if (IS_IOS_7) {
        //            msgLabel.frame = CGRectMake(80, 67, 30, 10);
        //        }else{
        //            msgLabel.frame = CGRectMake(82, alertMsgTextView1.frame.origin.y + alertMsgTextView1.frame.size.height - 81, 30, 10);
        //        }
        //        msgLabel.text = @"30%";
        //        msgLabel.textColor = [UIColor redColor];
        //        [alertMsgTextView1 addSubview:msgLabel];
        //        msgLabel.backgroundColor = [UIColor clearColor];
        //        msgLabel.font = [UIFont systemFontOfSize:12];

    }else if(chongZhiType == ChongZhiTypeZhiFuBao){
        alertBGView.frame = CGRectMake(10, 60, 300, 310);
        alertMsgBGView.frame = CGRectMake(10, 40, 280, 200);
        
        ColorView * colorView = [[[ColorView alloc] initWithFrame:CGRectMake(10, 10, 265, 200)] autorelease];
        [alertMsgBGView addSubview:colorView];
        if (IS_IOS_7) {
            colorView.text = @"1、支付前，请您确认您已是支付宝会员         ，如您还没有支付宝账户，请登录支          付宝注册。                                        2、手机支付宝将通过WAP或短信方式从        您的支付宝账户扣款完成支付。           3、支付宝客服热线：<0571-88156688>。  4、充值后，消费充值金额的<30%>可提现。";
        }else{
            colorView.text = @"1、支付前，请您确认您已是支付宝会员          ，如您还没有支付宝账户，请登录支         付宝注册。                                         2、手机支付宝将通过WAP或短信方式从        您的支付宝账户扣款完成支付。          3、支付宝客服热线：<0571-88156688>。  4、充值后，消费充值金额的<30%>可提现。";
        }
        
        
        
        colorView.font = [UIFont systemFontOfSize:14];
        colorView.textColor = [UIColor darkGrayColor];
        colorView.backgroundColor = [UIColor clearColor];
    }
    else if (chongZhiType == Chongzhika )
    {
        alertBGView.frame = CGRectMake(10, 60, 300, 310);
        alertMsgBGView.frame = CGRectMake(10, 40, 280, 200);
        
        ColorView * chongzhika = [[[ColorView alloc] initWithFrame:CGRectMake(10, 10, 265, 200)] autorelease];
        [alertMsgBGView addSubview:chongzhika];

            chongzhika.text=@"￼中国移动充值卡充值服务商将收取充值卡面额 4%的服务费(中国联通充值卡充值服务商将收取充值卡面额6%的服务费/中国电信充值卡充值服务商将收取充值卡面额6%的服务费),在充值卡金额中直接扣除,请务必选择与您的充值卡(非彩铃充值 卡)面额相同的消费金额,输入错误会导致失败。 此种充值方式不能提现。";
            
    
        chongzhika.font = [UIFont systemFontOfSize:12];
        chongzhika.textColor = [UIColor darkGrayColor];
        chongzhika.backgroundColor = [UIColor clearColor];
        
        
    }
    else if (chongZhiType == ChongZhiTypeLianLianYinTong ) {
        alertBGView.frame = CGRectMake(10, 60, 300, 380);
        alertMsgBGView.frame = CGRectMake(10, 40, 280, 280);
        
        ColorView * chongzhika = [[[ColorView alloc] initWithFrame:CGRectMake(10, 10, 265, 120)] autorelease];
        [alertMsgBGView addSubview:chongzhika];
        chongzhika.huanString = @"~";
        chongzhika.text=@"￼1、本充值方式以下银行需自行开通在线支付业务才可使用：~中国银行借记卡、交通银行借记卡、民生银行借记卡。邮政银行借记卡、中信银行借记卡、浦发银行借记卡、温州银行卡。~2、联系客服<QQ3254056760>";
        
        
        
        chongzhika.font = [UIFont systemFontOfSize:12];
        chongzhika.backgroundColor = [UIColor clearColor];
        ColorView * alertMsgView1 = [[ColorView alloc] initWithFrame:CGRectMake(10, chongzhika.frame.origin.y + chongzhika.frame.size.height - 20, 260, 140)];
        [alertMsgBGView addSubview:alertMsgView1];
        alertMsgView1.font = [UIFont systemFontOfSize:12];
        alertMsgView1.textColor = [UIColor darkGrayColor];
        alertMsgView1.backgroundColor = [UIColor clearColor];
        alertMsgView1.text = @"注：为配合银行系统反洗钱法的实施，保证正常用户的资金安全，针对异常提款作出以下规定：针对充值后消费金额（现金购买彩票成功的金额）小于存入金额（不包含奖金）30%的帐户的提款申请，将加收10%的异常提款处理费用，同时，提款到账日自提出申请之日起，不少于15个工作日。";
        [alertMsgView1 release];
    }
    else if (chongZhiType == ChongZhiTypeWeiXin) {
        alertBGView.frame = CGRectMake(10, 60, 300, 310);
        alertMsgBGView.frame = CGRectMake(10, 40, 280, 200);
        
        ColorView * colorView = [[[ColorView alloc] initWithFrame:CGRectMake(10, 10, 265, 200)] autorelease];
        colorView.huanString = @"~";
        [alertMsgBGView addSubview:colorView];
            colorView.text = @"1、支付前，请您确认您已开通微信钱包~如您还没有微信账户，请登录微信注册。~2、充值后，消费充值金额的<30%>可提现。";
        colorView.font = [UIFont systemFontOfSize:14];
        colorView.textColor = [UIColor darkGrayColor];
        colorView.backgroundColor = [UIColor clearColor];


    }
    else
    {
        alertBGView.frame = CGRectMake(10, 60, 300, 310);
        alertMsgBGView.frame = CGRectMake(10, 40, 280, 200);
        
        ColorView * caijinka = [[[ColorView alloc] initWithFrame:CGRectMake(10, 10, 265, 200)] autorelease];
        [alertMsgBGView addSubview:caijinka];
        if (IS_IOS_7) {
            caijinka.text = @"1、彩金卡只适用第一彩、中国足彩网用户中心账户 充值之用,购买彩票。                                               2、彩金卡只能一次性全额充值,不能分次充值。           3、本卡不能提现,只能用于充值购买彩票。  4、本卡不记名,不挂失,已经售出,非质量问题概    不退换,请妥善保管。";
        }else{
             caijinka.text = @"1、彩金卡只适用第一彩、中国足彩网用户中心账户 充值之用,购买彩票。                               2、彩金卡只能一次性全额充值,不能分次充值。           3、本卡不能提现,只能用于充值购买彩票。  4、本卡不记名,不挂失,已经售出,非质量问题概    不退换,请妥善保管。";
        }
        
        
        
        caijinka.font = [UIFont systemFontOfSize:14];
        caijinka.textColor = [UIColor darkGrayColor];
        caijinka.backgroundColor = [UIColor clearColor];

    }
        
    
    UIImageView * alertTitleView = [[[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"TYCD960.png")] autorelease];
//    if (IS_IOS_7) {
        alertTitleView.frame = CGRectMake(alertBGView.frame.size.width/2 - 60,  2, 120, 30);
//    }else{
//        alertTitleView.frame = CGRectMake(alertBGView.frame.size.width/2 - 60, alertBGView.frame.origin.y - 58, 120, 30);
//    }
    [alertBGView addSubview:alertTitleView];
    
    UILabel * alertTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(11, 3, 95, 22)] autorelease];
    [alertTitleView addSubview:alertTitleLabel];
    alertTitleLabel.font = [UIFont systemFontOfSize:14];
    alertTitleLabel.textAlignment = 1;
    alertTitleLabel.backgroundColor = [UIColor clearColor];
    alertTitleLabel.text = @"说 明";
    
    UIButton * keFuButton = [[[UIButton alloc] initWithFrame:CGRectMake(20, alertMsgBGView.frame.origin.y + alertMsgBGView.frame.size.height - 50, 260, 40)] autorelease];
    [alertBGView addSubview:keFuButton];
    [keFuButton setTitle:@"      QQ：3254056760" forState:UIControlStateNormal];
    keFuButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [keFuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [keFuButton setBackgroundImage:[UIImageGetImageFromName(@"whiteButton.png") stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
    [keFuButton addTarget:self action:@selector(keFuTel) forControlEvents:UIControlEventTouchUpInside];
//
//    UIImageView * keFuTelImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(17, 13, 15, 15)] autorelease];
//    keFuTelImageView.image = [UIImage imageNamed:@"keFuTel.png"];
//    [keFuButton addSubview:keFuTelImageView];
    
    UIButton * rightButton = [[[UIButton alloc] init] autorelease];
 //   if (IS_IOS_7) {
        rightButton.frame = CGRectMake(20, alertBGView.bounds.size.height - 50, 260, 40);
//    }else{
//        rightButton.frame = CGRectMake(20, alertBGView.frame.origin.y + alertBGView.frame.size.height - 115, 260, 40);
//    }
    [alertBGView addSubview:rightButton];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[[UIImage imageNamed:@"TYD960.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
}

-(void)right
{
    [BGView removeFromSuperview];
    [alertBGView removeFromSuperview];
}

- (void)keFuTel
{
//    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//    NSString * appName = [NSString stringWithFormat:@"是否要拨打%@客服电话:", [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
//    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:appName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"QQ：3254056760", nil];
//    [actionSheet showInView:self.mainView];
//    [actionSheet release];
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 0) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008130001"]];
//    }
}
-(void)pressUseYHM:(UIButton *)button{

    if([moneyTextField.text integerValue] >=1){
        
        NSMutableArray *contentArray = [NSMutableArray arrayWithCapacity:0];
        for(int i = 0;i<self.mutableYHMArray.count;i++){
        
            YHMInfo *info = [self.mutableYHMArray objectAtIndex:i];
            [contentArray addObject:[NSString stringWithFormat:@"%@",info.YHM_mes]];
        }
        
        MyPickerView *picker = [[MyPickerView alloc] initWithContentArray:contentArray];
        picker.tag = 300;
        picker.delegate = self;
        [picker showWithTitle:[contentArray objectAtIndex:0]];
        [picker release];
        
    }
    else{
    
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"亲,请先输入金额\n再选择优惠码" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil,nil];
        alert.delegate = self;
        [alert show];
        [alert release];
    }
    

}
-(void)myPickerView:(MyPickerView *)myPickerView cellIndex:(NSInteger)index content:(NSString *)content{

    NSLog(@"%ld %@",(long)myPickerView.tag,content);
    
    if(myPickerView.tag == 300){
    
        if(content.length){
            
            YHMInfo *info = [self.mutableYHMArray objectAtIndex:index];
            self.yhmCodeForChongzhi = [NSString stringWithFormat:@"%@",info.YHM_code];
            

            NSString *contentStr = [NSString stringWithFormat:@"已选择%@",content];
            BOOL isTwoPath = NO;
            NSString *contentStr1 = nil;
            NSString *contentStr2 = nil;
            NSArray *contentStrArr1 = [contentStr componentsSeparatedByString:@"("];
            
            // @"已选择2元优惠码   (   充值100以上可用)"
            if(contentStrArr1.count == 2){
                
                isTwoPath = YES;
                contentStr1 = [contentStrArr1 objectAtIndex:0];
                contentStr2 = [NSString stringWithFormat:@"(%@",[contentStrArr1 objectAtIndex:1]];
            }
            
            NSMutableAttributedString *attriString = [[[NSMutableAttributedString alloc] initWithString:contentStr]autorelease];
            [attriString addAttribute:(NSString *)kCTFontAttributeName value:(id)CTFontCreateWithName((CFStringRef)[UIFont systemFontOfSize:18].fontName, 18, NULL) range:NSMakeRange(0, contentStr1.length)];
            [attriString addAttribute:(NSString *)kCTFontAttributeName value:(id)CTFontCreateWithName((CFStringRef)[UIFont systemFontOfSize:12].fontName, 12, NULL) range:NSMakeRange(contentStr1.length, contentStr2.length)];

            [useYHMButton setAttributedTitle:attriString forState:UIControlStateNormal];
            
            [useYHMButton setBackgroundImage:UIImageGetImageFromName(@"point_choosedYHM.png") forState:UIControlStateNormal];
        }
    }

}
-(void)addMoneys:(UIButton *)buttons
{
    UIView *btnView = [self.mainView viewWithTag:500];
    if([btnView isKindOfClass:[UIView class]]){
    
        for(UIButton *btn in btnView.subviews){
        
            if([btn isKindOfClass:[UIButton class]]){
            
                btn.selected = NO;
            }
        }
    }

    buttons.selected = YES;
    moneyTextField.text = buttons.titleLabel.text;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YHMTextFieldChaned" object:nil];
    
    
}
-(void)YHMTextFieldChaned:(NSNotification *)notifation{

    [self YHMArrayChange];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    UIView *btnView = [self.mainView viewWithTag:500];
    if([btnView isKindOfClass:[UIView class]]){
        
        for(UIButton *btn in btnView.subviews){
            
            if([btn isKindOfClass:[UIButton class]]){
                
                btn.selected = NO;
            }
        }
    }
    
    [self performSelector:@selector(YHMArrayChange) withObject:nil afterDelay:0.2];
    [self YHMArrayChange];
    
    return YES;
}

-(void)YHMArrayChange{

    needRemoveIndex = (int)self.YHMInfoList.YHMInfoArray.count;
    
    if(self.YHMInfoList.YHMInfoArray.count){
        
        self.mutableYHMArray = [NSMutableArray arrayWithArray:self.YHMInfoList.YHMInfoArray];
        
        for(int i = 0;i<[self.mutableYHMArray count];i++){
            
            
            YHMInfo *info  =[self.mutableYHMArray objectAtIndex:i];
            NSLog(@"全部的充值金额: %@",info.YHM_chong);
            
            int jine = (int)[moneyTextField.text intValue]; //用户输入的金额
            int jine1 = (int)[info.YHM_chong intValue];     //优惠码的充值金额
            
            if(jine>=jine1){
                
                needRemoveIndex = i;
                break;
            }
            
        }
    }
    
    NSRange yhmRange = NSMakeRange(0,needRemoveIndex);
    
    [mutableYHMArray removeObjectsInRange:yhmRange];


    if([mutableYHMArray count]== 0){
        
        [useYHMButton setBackgroundImage:UIImageGetImageFromName(@"PKhuiseanniu.png") forState:UIControlStateNormal];
        useYHMButton.enabled = NO;
    }else{
        
        [useYHMButton setBackgroundImage:UIImageGetImageFromName(@"point_useYHM.png") forState:UIControlStateNormal];
        useYHMButton.enabled = YES;
        
    }
    
    NSMutableAttributedString *attriString = [[[NSMutableAttributedString alloc] initWithString:@"使用优惠码"]autorelease];

    [useYHMButton setAttributedTitle:attriString forState:UIControlStateNormal];
}

- (void)pressMoreButton:(UIButton *)sender{//完成按钮
    
    NSLog(@"m = %@", moneyTextField.text);
    
    if(![useYHMButton.titleLabel.text hasPrefix:@"已选择"]){
    
        self.yhmCodeForChongzhi  = @"";
    }
    
    
    jianpanbg.hidden = YES;
    [moneyTextField resignFirstResponder];
    [MobClick event:@"event_wodecaipiao_chongzh_queren" label:self.CP_navigation.title];
    
    [self upmpHttpRequest];
}

- (void)pressUpDataButton:(UIButton *)sender{//刷新按钮
    
    [self getAccountInfoRequest];

}

- (void) keyboardWillShow:(id)sender
{
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    jianpanbg.hidden = NO;
    
   
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

}

- (void) keyboardWillDisapper:(id)sender
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)pressJianPanBG:(UIButton *)sender{

    sender.hidden = YES;
    [moneyTextField resignFirstResponder];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
       return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 123) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/cn/app/id535715926?mt=8"]];
	}
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"YHMTextFieldChaned" object:nil];

    [boxRequest clearDelegatesAndCancel];
    [boxRequest release];
    [userImageView release];
    [upmpRequest clearDelegatesAndCancel];
    self.upmpRequest = nil;
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = nil;
    [BGView release];
    [alertBGView release];
    self.lianliansdk = nil;
//    [mAlert release];
//    [reqUserInfo clearDelegatesAndCancel];
    [super dealloc];
}

#pragma mark 连连支付回调
// 订单支付结果返回，主要是异常和成功的不同状态
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic
{
    NSString *msg = @"支付异常";
    switch (resultCode) {
        case kLLPayResultSuccess:
        {
            msg = @"支付成功";
            [MobClick event:@"event_wodecaipiao_chongzhi_queren_fangshi" label:@"连连支付"];
            NSString* result_pay = dic[@"result_pay"];
            if ([result_pay isEqualToString:@"SUCCESS"])
            {
                //
                [self getAccountInfoRequest];
            }
            else if ([result_pay isEqualToString:@"PROCESSING"])
            {
                msg = @"支付单处理中";
            }
            else if ([result_pay isEqualToString:@"FAILURE"])
            {
                msg = @"支付单失败";
            }
            else if ([result_pay isEqualToString:@"REFUND"])
            {
                msg = @"支付单已退款";
            }
        }
            break;
        case kLLPayResultFail:
        {
            msg = @"支付失败";
        }
            break;
        case kLLPayResultCancel:
        {
            msg = @"支付取消";
        }
            break;
        case kLLPayResultInitError:
        {
            msg = @"钱包初始化异常";
        }
            break;
            
        default:
            break;
    }
    self.lianliansdk = nil;
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [alert  release];
}

@end
