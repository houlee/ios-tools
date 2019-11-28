//
//  GC_TopUpViewController.m
//  caibo
//
//  Created by houchenguang on 13-5-31.
//
//

#import "GC_TopUpViewController.h"
#import "Info.h"
#import "GC_UPMPViewController.h"
#import "ChongZhiData.h"
#import "GC_HttpService.h"
#import "FAQView.h"
#import "RechargeSequenceData.h"
#import "TopUpTabelViewCell.h"
#import "CP_UIAlertView.h"
#import "GouCaiHomeViewController.h"
#import "GC_ShengfuInfoViewController.h"
#import "GouCaiShuZiInfoViewController.h"
#import "caiboAppDelegate.h"
#import "QuestionViewController.h"

#import "ColorView.h"
#import "GC_UserInfo.h"
#import "GC_OrderManager.h"
#import "MobClick.h"
#import "Info.h"

#define kConfirm          @"确定"

#define kfinish  @"完成充值"
#define kgoOn  @"继续充值"

#define IS_IOS_7    ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7)


@interface GC_TopUpViewController ()

@end

@implementation GC_TopUpViewController
@synthesize httpRequest;
@synthesize accountRequest;
@synthesize orderRequest, boxRequest;
@synthesize selectType,passWord;
@synthesize rechargeSequence;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        rechargeSequenceArray = [[NSMutableArray alloc] init];
        allowUseYHMSequenceArray = [[NSMutableArray alloc] init];
        allH5SequenceArray = [[NSMutableArray alloc] init];
        title = [[NSArray alloc] initWithObjects:@"支付宝",@"银联卡快充",@"",@"银联卡充值",@"银联卡语音回拨",@"手机充值卡充值",@"彩金卡充值",@"",@"",@"银行卡支付",@"淘宝充值",@"",@"",@"微信支付",@"",@"手Q支付",@"",@"",@"京东支付",@"支付宝转账",@"微信扫码充值",@"支付宝扫码充值",nil];
        title1 = [[NSMutableArray alloc] initWithObjects:@"(免手续费) ",@"(免手续费)",@"",@"(免手续费)",@"(免手续费)", @"      (免手续费)",@"(免手续费)",@"",@"",@"(免手续费)",@"(免手续费)",@"",@"",@"(免手续费)",@"",@"(免手续费)",@"",@"",@"(免手续费)",@"(免手续费)",@"(免手续费)",@"(免手续费)",nil];
        
        detail = [[NSMutableArray alloc] initWithObjects:@"支付宝推荐，安全快捷",@"支持全国信用卡、借记卡、无需网银",@"",@"联动优势快速充值",@"",@"支持移动、联通、电信充值卡",@"彩金卡彩金充值",@"",@"",@"无需开通网银、支持信用卡和借记卡",@"淘宝购买彩金卡充值",@"",@"",@"微信支付充值 安全快捷",@"",@"QQ支付充值 安全快捷",@"",@"",@"京东支付，安全快捷",@"支付宝转账，安全快捷",@"扫码支付转账，登记信息后客服加款",@"扫码支付转账，登记信息后客服加款",nil];
        // logoName = [[NSArray alloc] initWithObjects:@"zhifubaoLOGO.png",@"yinlianLOGO.png",@"",@"visa.png",@"",@"chongzhika.png",@"",@"",@"",@"lianlianyintong.png",nil];
        logoName = [[NSArray alloc] initWithObjects:@"chongzhi-zhifubao_1.png",@"chongzhi-yinlianka_1.png",@"",@"chongzhi-xinyongkatubiao_1.png",@"chongzhiyuyin.png",@"chongzhi-shoujichongzhi_1.png",@"chongzhicaijinka.png",@"",@"",@"chongzhi-lianlianyinhangkachongzhi_1.png",@"chongzhitaobao.png",@"",@"",@"wxchongzhi.png",@"",@"qqpay.png",@"",@"",@"chongzhiJD.png",@"chongzhi-zhifubao_1.png",@"wxchongzhi.png",@"chongzhi-zhifubao_1.png",nil];
    }
    return self;
}

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goHome{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)doPushHomeView{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.CP_navigation.title = @"账户充值";
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = leftItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAccountInfoRequest:) name:@"getOrderIsScuu" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAccountRequest) name:@"BecomeActive" object:nil];
    
#ifndef isCaiPiaoForIPad
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBounds:CGRectMake(0, 0, 60, 44)];
    [btn setImage:UIImageGetImageFromName(@"wb61.png") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.CP_navigation.rightBarButtonItem = barBtnItem;
    [barBtnItem release];
#endif
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    // backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = DEFAULT_BACKGROUNDCOLOR;
   // tableView.backgroundView = backImage;
    [self.mainView addSubview:backImage];
    [backImage release];
    
    
    
    UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthItem.bounds = CGRectMake(0, 0, 60, 44);
    [rigthItem setTitle:@"首页" forState:UIControlStateNormal];
    [rigthItem addTarget:self action:@selector(doPushHomeView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
    self.CP_navigation.rightBarButtonItem = rigthItemButton;
    [rigthItemButton release];

    
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] rechargeSequence];
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(rechargeSequence:)];
    [httpRequest startAsynchronous];
    
    myScrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
    myScrollView.backgroundColor = [UIColor clearColor];
    myScrollView.bounces = NO;
    myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, self.mainView.frame.size.height);
    [self.mainView addSubview:myScrollView];
    [myScrollView release];
    
    moneyText = [[ColorView alloc] initWithFrame:CGRectMake(15, 15, 290, 20)];
    moneyText.backgroundColor = [UIColor clearColor];
    moneyText.textAlignment = 1;
    moneyText.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    moneyText.changeColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1.0];
    moneyText.font = [UIFont systemFontOfSize:15];
    moneyText.colorfont = [UIFont systemFontOfSize:15];
//    moneyText.pianyiHeight = 6;
    moneyText.tag = 11;
    float  balance = [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue];
    moneyText.text = [NSString stringWithFormat:@"余额 <%.2f> 元 ", balance];
    [myScrollView addSubview:moneyText];
    [moneyText release];
    
    
    topUpTableView = [[UITableView alloc] init];
    topUpTableView.delegate = self;
    topUpTableView.dataSource = self;
    [myScrollView addSubview:topUpTableView];
    topUpTableView.backgroundColor = [UIColor clearColor];
    topUpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    topUpTableView.scrollEnabled = NO;
    
    moreButton = [[UIButton alloc] init];
    moreButton.frame = CGRectMake(10, 206, 300, 45);
    [moreButton addTarget:self action:@selector(pressMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    moreButton.backgroundColor = [UIColor clearColor];
    [myScrollView addSubview:moreButton];
    
    UIImageView * moreImage = [[UIImageView alloc] initWithFrame:moreButton.bounds];
    moreImage.backgroundColor = [UIColor clearColor];
//  moreImage.image = [UIImageGetImageFromName(@"GC_btn10.png") stretchableImageWithLeftCapWidth:6 topCapHeight:0];
    moreImage.image = [UIImageGetImageFromName(@"yinhangkachongzhizhengchang_1.png") stretchableImageWithLeftCapWidth:6 topCapHeight:0];

    [moreButton addSubview:moreImage];
    [moreImage release];
    
    UILabel * moreLabel = [[UILabel alloc] initWithFrame:moreButton.bounds];
    moreLabel.text = @"更多充值方式";
    moreLabel.textAlignment = NSTextAlignmentCenter;
//    moreLabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    moreLabel.backgroundColor = [UIColor clearColor];
    moreLabel.font = [UIFont systemFontOfSize:14];
    [moreImage addSubview:moreLabel];
    [moreLabel release];
    
    
//    UIButton * FAQButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    FAQButton.frame = CGRectMake(320 - 60, self.mainView.frame.size.height - 50, 60, 40);
//    [FAQButton addTarget:self action:@selector(pressFAQButton:) forControlEvents:UIControlEventTouchUpInside];
//    FAQButton.backgroundColor = [UIColor clearColor];
//    [self.mainView addSubview:FAQButton];
    
//    UILabel * FAQLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 10, 30, 20)];
//    FAQLabel.text = @"充值";
//    FAQLabel.textAlignment = NSTextAlignmentLeft;
//    FAQLabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
//    FAQLabel.backgroundColor = [UIColor clearColor];
//    FAQLabel.font = [UIFont systemFontOfSize:12];
//    [FAQButton addSubview:FAQLabel];
//    [FAQLabel release];
    
//    UIImageView * FAQImage = [[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(FAQLabel), 15, 11, 11)];
//    FAQImage.backgroundColor = [UIColor clearColor];
//    FAQImage.image = UIImageGetImageFromName(@"wenhao.png");
//    [FAQButton addSubview:FAQImage];
//    [FAQImage release];
    
    
//     msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, moreButton.frame.origin.y+moreButton.frame.size.height + 40, 290, 20)];
//    msgLabel.text = @"充值提醒信息";
//    msgLabel.textColor = [UIColor redColor];
//    msgLabel.backgroundColor = [UIColor clearColor];
//    msgLabel.font = [UIFont boldSystemFontOfSize:14];
//    [myScrollView addSubview:msgLabel];
//    [msgLabel release];
    
    
//    colorLabel = [[ColorView alloc] init];
//    colorLabel.frame = CGRectMake(15, msgLabel.frame.origin.y + msgLabel.frame.size.height + 5, 290, 55);
//    colorLabel.textColor = [UIColor blackColor];
//    colorLabel.font = [UIFont systemFontOfSize:13];
//    colorLabel.colorfont = [UIFont boldSystemFontOfSize:13];
//    colorLabel.backgroundColor = [UIColor clearColor];
//    colorLabel.changeColor = [UIColor redColor];
////    colorLabel.text = @"365预约信息交流平台,目前主要服务<北京五环内>用户,其他地区用户随各地投注站加入认证,将陆续开放。";
//    [myScrollView addSubview:colorLabel];
//    [colorLabel release];
    
//    //第一次进入的提示框
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"onechongzhialert"] intValue] != 1) {
//
//        CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"充值提醒信息" message:@"365预约信息交流平台,目前主要服务<北京五环内>用户,其他地区用户随各地投注站加入认证,将陆续开放。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        alert.tag = 197;
//        alert.alertTpye = chongzhidiyici;
//        [alert show];
//        [alert release];
//        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"onechongzhialert"];
//
//    }
    
    
    self.boxRequest = [ASIHTTPRequest requestWithURL:[NetURL getRefillRemindRequest]];
    [boxRequest setTimeOutSeconds:20.0];
    [boxRequest setDidFinishSelector:@selector(refillFinish:)];
    [boxRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [boxRequest setDelegate:self];
    [boxRequest startAsynchronous];
    
}

- (void)refillFinish:(ASIHTTPRequest *)requesta{
    
    
    if (requesta) {
        NSString * restr = [requesta responseString];
        NSDictionary * dict = [restr JSONValue];
        if ([[dict objectForKey:@"status"] isEqualToString:@"0"]) {
            
            UIFont * font = [UIFont systemFontOfSize:14];
            CGSize  size = CGSizeMake(290, 1000);
            colorLabel.text  = [dict objectForKey:@"msg"];
            CGSize labelSize = [colorLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
            colorLabel.frame = CGRectMake(15, msgLabel.frame.origin.y + msgLabel.frame.size.height + 5, 290, labelSize.height);
            colorLabel.text  = [dict objectForKey:@"msg"];
             myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, colorLabel.frame.origin.y + colorLabel.frame.size.height);
//            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"onechongzhialert"] intValue] != 1) {
//
//                CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"充值提醒信息" message:[dict objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                alert.tag = 197;
//                alert.alertTpye = chongzhidiyici;
//                [alert show];
//                [alert release];
//            }
            
        }
    }
    
    
    
}


//------------------------

-(void)tanchu
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BecomeActive"  object:nil];
    
    
     mAlert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您已经完成充值？" delegate:self cancelButtonTitle:@"继续充值" otherButtonTitles:@"完成充值", nil];
    // mAlert.alertTpye=ordinaryType;
    mAlert.tag=3330;
    [mAlert show];
   // if ([msg isEqualToString:@"您已经完成充值?"]) {
        for (UIImageView * bgImageView in mAlert.subviews) {
            if ([bgImageView isKindOfClass:[UIImageView class]]) {
                UIButton *qButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 118, 30, 30)];
                [qButton addTarget:self action:@selector(tishi) forControlEvents:UIControlEventTouchUpInside];
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
   // }
    
    
  
    
    
    
    [mAlert release];
   
}
- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==3330) {
        if (buttonIndex==1) {
            
            [self performSelector:@selector(getAccountInfoRequest:) withObject:nil];
            
            
            for (UIViewController *cont in self.navigationController.viewControllers) {
                if ([cont isKindOfClass:[GC_ShengfuInfoViewController class] ] || [cont isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
                    [self.navigationController popToViewController:cont animated:YES];
                    
                    return;
                }
                
            }
            
            [self.navigationController popViewControllerAnimated:YES];

            
//            UIViewController *cont = [self.navigationController.viewControllers objectAtIndex:2];
//            [self.navigationController popToViewController:cont animated:YES];
//             [self.navigationController popViewControllerAnimated:YES];
            
    
            }
            else
            {
               
                
            }
            
        }
        
    
    
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message{
    if (alertView.tag == 222) {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
            if (buttonIndex == 1) {
                CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.alertTpye = passWordType;
                alert.tag = 111;
                [alert show];
                [alert release];
            }
        }else{
            if (buttonIndex == 1) {
                ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
                //                proving.passWord = self.passWord;
                [self.navigationController pushViewController:proving animated:YES];
                [proving release];
            }
        }
    }
    if (alertView.tag == 111) {
        self.passWord = message;
        if (buttonIndex == 1) {
            if (![self.passWord isEqualToString:[[User getLastUser] password] ]) {
                if (alertView.tag == 1) {
                    
                }else{
                    [self.httpRequest clearDelegatesAndCancel];
                    NSString *name = [[Info getInstance] login_name];
                    //                    NSString *password = textF.text;
                    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:self.passWord]];
                    [httpRequest setTimeOutSeconds:20.0];
                    [httpRequest setDidFinishSelector:@selector(getUserInfoFinish:)];
                    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                    [httpRequest setDelegate:self];
                    [httpRequest startAsynchronous];
                    
                }
                
                
            }else{
                ProvingViewCotroller *proving = [[ProvingViewCotroller alloc] init];
                [self.navigationController pushViewController:proving animated:YES];
                [proving release];
            }
            
        }
        
    }
    
}

- (void)getUserInfoFinish:(ASIHTTPRequest*)request {
    NSString *responseStr = [request responseString];
    
    if ([responseStr isEqualToString:@"fail"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您输入的密码不正确" message:@" " delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [alert show];
        [alert release];
    }
    else {
        UserInfo *userInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
        if (!userInfo) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您输入的密码不正确" message:@" " delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
            [alert show];
            [alert release];
            return;
        }
        else{
            ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
            proving.passWord = self.passWord;
            [self.navigationController pushViewController:proving animated:YES];
            [proving release];
            
        }
        [userInfo release];
        
    }
}

-(void)tishi
{
    [mAlert removeFromSuperview];
    
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
        alertMsgView.font = [UIFont systemFontOfSize:12.5];
        alertMsgView.backgroundColor = [UIColor clearColor];
        if (IS_IOS_7) {
            alertMsgView.text = @"1.姓名要与银行卡填写的户名一致                   2.身份证号要与银行卡填写的一致                   3.手机号码要与银行卡开户填写的号码一致";
        }else{
            alertMsgView.text = @"1.姓名要与银行卡填写的户名一致                2.身份证号要与银行卡填写的一致                3.手机号码要与银行卡开户填写的号码一致";
        }
        [alertMsgView release];
        
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
    else
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
//    else
//    {
//        alertBGView.frame = CGRectMake(10, 60, 300, 310);
//        alertMsgBGView.frame = CGRectMake(10, 40, 280, 200);
//        
//        ColorView * caijinka = [[[ColorView alloc] initWithFrame:CGRectMake(10, 10, 265, 200)] autorelease];
//        [alertMsgBGView addSubview:caijinka];
//        if (IS_IOS_7) {
//            caijinka.text = @"1、彩金卡只适用第一彩、中国足彩网用户中心账户 充值之用,购买彩票。                                               2、彩金卡只能一次性全额充值,不能分次充值。           3、本卡不能提现,只能用于充值购买彩票。  4、本卡不记名,不挂失,已经售出,非质量问题概    不退换,请妥善保管。";
//        }else{
//            caijinka.text = @"1、彩金卡只适用第一彩、中国足彩网用户中心账户 充值之用,购买彩票。                               2、彩金卡只能一次性全额充值,不能分次充值。            3、本卡不能提现,只能用于充值购买彩票。  4、本卡不记名,不挂失,已经售出,非质量问题概      不退换,请妥善保管。";
//        }
//        
//        
//        
//        caijinka.font = [UIFont systemFontOfSize:14];
//        caijinka.textColor = [UIColor darkGrayColor];
//        caijinka.backgroundColor = [UIColor clearColor];
//        
//    }
    
    
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
    [keFuButton setTitle:@"      客服QQ3254056760" forState:UIControlStateNormal];
    keFuButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [keFuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [keFuButton setBackgroundImage:[UIImageGetImageFromName(@"whiteButton.png") stretchableImageWithLeftCapWidth:10 topCapHeight:5] forState:UIControlStateNormal];
//    [keFuButton addTarget:self action:@selector(keFuTel) forControlEvents:UIControlEventTouchUpInside];
    
//    UIImageView * keFuTelImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(17, 13, 15, 15)] autorelease];
//    keFuTelImageView.image = [UIImage imageNamed:@"keFuTel.png"];
//    [keFuButton addSubview:keFuTelImageView];
    
    UIButton * rightButton = [[[UIButton alloc] init] autorelease];
    //   if (IS_IOS_7) {
    rightButton.frame = CGRectMake(20, alertBGView.bounds.size.height -50, 260, 40);
    //    }else{
    //        rightButton.frame = CGRectMake(20, alertBGView.frame.origin.y + alertBGView.frame.size.height - 115, 260, 40);
    //    }
    [alertBGView addSubview:rightButton];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[[UIImage imageNamed:@"TYD960.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
}

- (void)keFuTel
{
//    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//    NSString * appName = [NSString stringWithFormat:@"是否要拨打%@客服电话:", [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
//    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:appName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"400-813-0001", nil];
//    [actionSheet showInView:self.mainView];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        actionSheet.frame = CGRectMake(0, self.mainView.frame.size.height - actionSheet.frame.size.height + 60, 320, actionSheet.frame.size.height);
//    }
//    [actionSheet release];
}
- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008130001"]];
    }
}


-(void)right
{
    [BGView removeFromSuperview];
    [alertBGView removeFromSuperview];
}


- (void)getAccountInfoRequest:(NSNotification *)notifation
{
    if ([[[Info getInstance] userName] length] > 0 && [[GC_HttpService sharedInstance].sessionId length]) {
        
        NSString *orderid = [NSString stringWithFormat:@"%@",notifation.object];
        
        //查询订单
        [orderRequest clearDelegatesAndCancel];
        NSMutableData *postData1=  [[GC_HttpService sharedInstance] reqPrepaidOrder:orderid];
        self.orderRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [orderRequest setRequestMethod:@"POST"];
        [orderRequest addCommHeaders];
        [orderRequest setPostBody:postData1];
        [orderRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [orderRequest setDelegate:self];
        [orderRequest setDidFinishSelector:@selector(reqOrderInfoFinished:)];
        [orderRequest setDidFailSelector:@selector(reqOrderInfoFailed:)];
        [orderRequest startAsynchronous];
        

//        [self getAccountRequest];
    }
}
-(void)getAccountRequest{

    //获取账户信息
    [accountRequest clearDelegatesAndCancel];
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqAccountManagerNew:[[Info getInstance] userName]];
    self.accountRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [accountRequest setRequestMethod:@"POST"];
    [accountRequest addCommHeaders];
    [accountRequest setPostBody:postData];
    [accountRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [accountRequest setDelegate:self];
    [accountRequest setDidFinishSelector:@selector(reqAccountInfoFinished:)];
    [accountRequest startAsynchronous];
}
//获取余额
- (void)reqAccountInfoFinished:(ASIHTTPRequest*)request
{
    if ([request responseData]) {
        GC_AccountManage *aManage = [[GC_AccountManage alloc] initWithResponseData:[request responseData]WithRequest:request];
        if (aManage != nil && aManage.returnId != 3000){
            [GC_UserInfo sharedInstance].accountManage = aManage;
            
            float  balance = [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue];
            NSString * fanganstr5 = [NSString stringWithFormat:@"余额 <%.2f> 元 ", balance];
            moneyText.text=fanganstr5;
            
//            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"充值金额还未到账\n请稍后在 <我的彩票> 里查看" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
//            alert.alertTpye = ChongzhiFailType;
//            [alert show];
//            [alert release];
        }
        [aManage release];
        
        
    }
}
//查询订单
- (void)reqOrderInfoFinished:(ASIHTTPRequest*)request{
    
    if ([request responseData]) {
        
        GC_OrderManager *order = [[GC_OrderManager alloc] initWithResponseData:[request responseData] WithRequest:request];
        
        if(order.returnId != 3000){
            
            if([@"1" isEqualToString:order.isSucc]){
                
                NSLog(@"到账金额 : %@",order.money);
                
                NSString *message = [NSString stringWithFormat:@"%@",order.message];
            
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                alert.alertTpye = ChongzhiSuccType;
                [alert show];
                [alert release];
            
            }
            else if([@"0" isEqualToString:order.isSucc]){
            
                NSString *message = [NSString stringWithFormat:@"%@",order.message];
                
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                alert.alertTpye = ChongzhiFailType;
                [alert show];
                [alert release];
            }
        
        }
        
        [order release];
    }
}
- (void)reqOrderInfoFailed:(ASIHTTPRequest*)request{
    
    if ([request responseData]) {
        
        
    }
}
//---------------------------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rechargeSequence.chongzhiTypeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    TopUpTabelViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[TopUpTabelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.backgroundColor = [UIColor whiteColor];
        UIView *back = [[UIView alloc] init];
        back.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        [cell setSelectedBackgroundView:back];
        [back release];
    }
    if (self.rechargeSequence.chongzhiTypeList.count > 1) {                //set-input.png
        if (indexPath.row == 0) {
            //cell.BGImageView.image = [UIImage imageNamed:@"yinliancell.png"];
            UIView * line = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)] autorelease];
            line.backgroundColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
            [cell.contentView addSubview:line];
            
        }
        else if(indexPath.row == self.rechargeSequence.chongzhiTypeList.count - 1 ){
           // cell.BGImageView.image = [UIImage imageNamed:@"zhifubaocell.png"];
            UIView * line = [[[UIView alloc] initWithFrame:CGRectMake(60, 0, 320, 0.5)] autorelease];
            line.backgroundColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
            [cell.contentView addSubview:line];
            UIView * line1 = [[[UIView alloc] initWithFrame:CGRectMake(0, -0.25+46, 320, 0.5)] autorelease];
            line1.backgroundColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
            [cell.contentView addSubview:line1];
            
        }
        else{
           // cell.BGImageView.image = [[UIImage imageNamed:@"SZT-Z-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:12];
            
            UIView * line = [[[UIView alloc] initWithFrame:CGRectMake(60, 0, 320, 0.5)] autorelease];
            line.backgroundColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
            [cell.contentView addSubview:line];
        }
    }
    
    
    else if(self.rechargeSequence.chongzhiTypeList.count == 1){
        UIView * line = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)] autorelease];
        line.backgroundColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
        [cell.contentView addSubview:line];
        UIView * line1 = [[[UIView alloc] initWithFrame:CGRectMake(0, -0.25+46, 320, 0.5)] autorelease];
        line1.backgroundColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1];
        [cell.contentView addSubview:line1];
    }
    RechargeTypeData *rechargeType = [self.rechargeSequence.chongzhiTypeList objectAtIndex:indexPath.row];

    cell.titleLabel.text = rechargeType.name;
    cell.titleLabel1.text = rechargeType.feeInfo;
    cell.detailLabel.text = rechargeType.huodong;
    [cell.logoImgeView setImageWithURL:rechargeType.logourl];
    if (cell.titleLabel.text.length >= 9 ) {
        cell.titleLabel1.frame = CGRectMake(195,2.5, 90+60, 20);
    }
    else if (cell.titleLabel.text.length >5 ) {
        cell.titleLabel1.frame = CGRectMake(165,2.5, 90+60, 20);
    }
    else {
        cell.titleLabel1.frame = CGRectMake(140,2.5, 90+60, 20);
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row >=[self.rechargeSequence.chongzhiTypeList count]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell) {
            [cell setSelected:NO animated:YES];
        }
        return;
    }
    
    RechargeTypeData *rechargeType = [self.rechargeSequence.chongzhiTypeList objectAtIndex:indexPath.row];
    if ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] != 0) {
        if (![rechargeType.code isEqualToString:@"24"] && ![rechargeType.code isEqualToString:@"14"] && ![rechargeType.code isEqualToString:@"6"] && ![rechargeType.code isEqualToString:@"7"]) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"为了更好的保护您的购彩信息，请先完善您的个人信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.delegate = self;
            alert.tag = 222;
            [alert show];
            [alert release];
            
            return;
        }
    }
    if ([rechargeType.wapurl isEqualToString:@"1"]) {
        self.selectType = rechargeType.code;
        [self pressnewXinyong];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell) {
            [cell setSelected:NO animated:YES];
        }
        return;
    }

        switch ([rechargeType.code integerValue]) {
                
              
        case 1:
        {
            [MobClick event:@"event_wodecaipiao_chongzhi_fangshi" label:@"支付宝"];
            [MobClick event:@"event_wodecaipiao_chongzhi_zhifubao"];
            GC_UPMPViewController * upmpView = [[GC_UPMPViewController alloc] init];

            if ([rechargeType.Youhuima isEqualToString:@"1"]) {
                upmpView.isAllowYHM = YES;
            }
            upmpView.chongZhiType = ChongZhiTypeZhiFuBao;
            [self.navigationController pushViewController:upmpView animated:YES];
            [upmpView release];

//            [self pressChongZhi];
        }
            break;
        case 2:
        {
            [MobClick event:@"event_wodecaipiao_chongzhi_fangshi" label:@"银行卡充值"];
            GC_UPMPViewController * upmpView = [[GC_UPMPViewController alloc] init];
            upmpView.creditCard = NO;
            if ([rechargeType.Youhuima isEqualToString:@"1"]) {
                upmpView.isAllowYHM = YES;
            }
            [self.navigationController pushViewController:upmpView animated:YES];
            [upmpView release];
        }
            break;
        case 4:
        {
            [MobClick event:@"event_wodecaipiao_chongzhi_fangshi" label:@"信用卡充值"];
            GC_UPMPViewController * upmpView = [[GC_UPMPViewController alloc] init];
            upmpView.creditCard = YES;
            if ([rechargeType.Youhuima isEqualToString:@"1"]) {
                upmpView.isAllowYHM = YES;
            }
            upmpView.chongZhiType = ChongZhiTypeLianDongYouShi;
            [self.navigationController pushViewController:upmpView animated:YES];
            [upmpView release];
            
//            chongZhiType =ChongZhiTypeYinLian;
//
//            [self pressnewXinyong];
            
            
        }
           break;
        case 6:
            {
                chongZhiType = Chongzhika;

                [self pressnewChongzhi];

            }
                 break;
            case 10: {
                [MobClick event:@"event_wodecaipiao_chongzhi_fangshi" label:@"连连银通"];
                GC_UPMPViewController * upmpView = [[GC_UPMPViewController alloc] init];
                upmpView.chongZhiType = ChongZhiTypeLianLianYinTong;
                if ([rechargeType.Youhuima isEqualToString:@"1"]) {
                    upmpView.isAllowYHM = YES;
                }
                [self.navigationController pushViewController:upmpView animated:YES];
                [upmpView release];
                
            }
                break;
            case 14: {
                [MobClick event:@"event_wodecaipiao_chongzhi_fangshi" label:@"微信"];
                GC_UPMPViewController * upmpView = [[GC_UPMPViewController alloc] init];
                upmpView.chongZhiType = ChongZhiTypeWeiXin;
                if ([rechargeType.Youhuima isEqualToString:@"1"]) {
                    upmpView.isAllowYHM = YES;
                }
                //测试，微信默认可以使用优惠码
//                upmpView.isAllowYHM = NO;

                [self.navigationController pushViewController:upmpView animated:YES];
                [upmpView release];
                
            }
                break;
            case 16: {
                [MobClick event:@"event_wodecaipiao_chongzhi_fangshi" label:@"QQ钱包"];
                GC_UPMPViewController * upmpView = [[GC_UPMPViewController alloc] init];
                upmpView.chongZhiType = ChongZhiTypeQQPay;
                if ([rechargeType.Youhuima isEqualToString:@"1"]) {
                    upmpView.isAllowYHM = YES;
                }
                [self.navigationController pushViewController:upmpView animated:YES];
                [upmpView release];
            }
        default:
            break;
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        [cell setSelected:NO animated:YES];
    }
}

- (void)pressFAQButton:(UIButton *)sender{//FAQ

    
//    FAQView *faq = [[FAQView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    faq.faqdingwei = Chongzhi;
//#ifdef isCaiPiaoForIPad
//    [faq Show:self];
//#else
//    [faq Show];
//#endif
//    [faq release];
    
    
    QuestionViewController *qvc=[[QuestionViewController alloc]init];
    qvc.question = ChongzhiType;
    [self.navigationController pushViewController:qvc animated:YES];
    [qvc release];
    
}

//信用卡 改成跳H5充值
-(void)pressnewXinyong
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tanchu) name:@"BecomeActive"  object:nil];
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(returnSysTime1:)];
    [httpRequest startAsynchronous];
}

-(void)pressnewChongzhi
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tanchu) name:@"BecomeActive"  object:nil];
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(returnSysTime2:)];
    [httpRequest startAsynchronous];
}


- (void)pressChongZhi{//充值跳网页
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    NSLog(@"##%@",[GC_HttpService sharedInstance].hostUrl);
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(returnSysTime:)];
    [httpRequest startAsynchronous];
    // NSLog(@"url = %@", [[GC_HttpService sharedInstance] reChangeUrl]);
	//[[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrlSysTime:(NSString *)]];
}

- (void)rechargeSequence:(ASIHTTPRequest *)sequence{
    if ([sequence responseData]) {
        RechargeSequenceData * rechargeSequenceData = [[RechargeSequenceData alloc] initWithResponseData:[sequence responseData]];
        
        self.rechargeSequence = rechargeSequenceData;
//        NSLog(@"rechargeSequenceData.sequence = %@",rechargeSequenceData.sequence);
      // rechargeSequenceData.sequence = @"2_1_3_6";
        if ([rechargeSequenceData.changeContent length]) {
            NSArray * changeContentArray = [rechargeSequenceData.changeContent componentsSeparatedByString:@"^"];
            for (int i = 0; i < changeContentArray.count; i++) {
                NSArray * contentArray = [[changeContentArray objectAtIndex:i] componentsSeparatedByString:@"|"];
                if (contentArray.count == 2 && [[contentArray objectAtIndex:0] integerValue] && ([[contentArray objectAtIndex:0] integerValue] - 1) < detail.count) {
                    [detail replaceObjectAtIndex:[[contentArray objectAtIndex:0] integerValue] - 1 withObject:[contentArray objectAtIndex:1]];
                }
            }
            
            NSLog(@"==============%@",detail);
            
        }
        if ([rechargeSequenceData.changeContent2 length]) {
            NSArray * changeContentArray = [rechargeSequenceData.changeContent2 componentsSeparatedByString:@"^"];
            for (int i = 0; i < changeContentArray.count; i++) {
                NSArray * contentArray = [[changeContentArray objectAtIndex:i] componentsSeparatedByString:@"|"];
                if (contentArray.count == 2 && [[contentArray objectAtIndex:0] integerValue] && ([[contentArray objectAtIndex:0] integerValue] - 1) < title1.count) {
                    [title1 replaceObjectAtIndex:[[contentArray objectAtIndex:0] integerValue] - 1 withObject:[contentArray objectAtIndex:1]];
                }
            }
            
        
            
        }

//        title1
        if (!rechargeSequenceData.sequence) {
            [rechargeSequenceData release];
            rechargeSequenceArray = nil;
        }else if ([rechargeSequenceData.sequence isEqualToString:@"-"]) {
            [rechargeSequenceData release];
            rechargeSequenceArray = nil;
        }else{
            if ([rechargeSequenceData.sequence length] > 1) {
                for (NSString * str in [rechargeSequenceData.sequence componentsSeparatedByString:@"_"]) {
                    if ([str integerValue] && [str integerValue] - 1 < [title count] && [[title objectAtIndex:[str integerValue] - 1] length]) {
                        if ([str integerValue] > 0 && [str integerValue] < 23) {
                            if (![rechargeSequenceArray containsObject:str]) {
                                [rechargeSequenceArray addObject:str];
                            }
                        }
                    }

                }
                
            }else{
                if ([rechargeSequenceData.sequence integerValue] > 0 && [rechargeSequenceData.sequence integerValue] < 23) {
                    [rechargeSequenceArray addObject:rechargeSequenceData.sequence];
                }
            }
            
            
            //允许使用优惠码的充值列表
            if(rechargeSequenceData.methodYHM && [rechargeSequenceData.methodYHM length] > 0){
                
                for (NSString * str in [rechargeSequenceData.methodYHM componentsSeparatedByString:@"_"]) {
                    
                    if ([str integerValue] && [str integerValue] <= [title count] && [[title objectAtIndex:[str integerValue] - 1] length]) {
                        if ([str integerValue] > 0 && [str integerValue] < 23) {
                            if (![allowUseYHMSequenceArray containsObject:str]) {
                                [allowUseYHMSequenceArray addObject:str];
                            }
                        }
                    }

                }
                
            }
            
            //允许跳H5充值列表
            if(rechargeSequenceData.H5Type && [rechargeSequenceData.H5Type length] > 0){
                
                for (NSString * str in [rechargeSequenceData.H5Type componentsSeparatedByString:@"_"]) {
                    
                    if ([str integerValue] && [str integerValue] <= [title count] && [[title objectAtIndex:[str integerValue] - 1] length]) {
                        if ([str integerValue] > 0 && [str integerValue] < 23) {
                            if (![allH5SequenceArray containsObject:str]) {
                                [allH5SequenceArray addObject:str];
                            }
                        }
                    }
                    
                }
                
            }
            
            [rechargeSequenceData release];
        }
        
//        if ([self.rechargeSequence.chongzhiTypeList count] > 0) {
//            NSMutableArray *deleatArray = [NSMutableArray array];
//            for (int i = 0 ; i < [self.rechargeSequence.chongzhiTypeList count]; i ++ ) {
//                RechargeTypeData *rechangetype = [self.rechargeSequence.chongzhiTypeList objectAtIndex:i];
//                if ([rechangetype.code length] && ![rechargeSequenceArray containsObject:rechangetype.code]) {
//                    [deleatArray addObject:rechangetype];
//                }
//            }
//            if ([deleatArray count] > 0) {
//                [self.rechargeSequence.chongzhiTypeList removeObjectsInArray:deleatArray];
//            }
//        }
        
        [topUpTableView reloadData];
        topUpTableView.frame = CGRectMake(0, 40, 320, topUpTableView.contentSize.height);
        
        moreButton.frame = CGRectMake(10, topUpTableView.frame.origin.y + topUpTableView.frame.size.height + 30, 300, 35);
        msgLabel.frame = CGRectMake(15, moreButton.frame.origin.y+moreButton.frame.size.height + 40, 290, 20);
        colorLabel.frame = CGRectMake(15, msgLabel.frame.origin.y + msgLabel.frame.size.height+7, 290, 55);
        
        myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, colorLabel.frame.origin.y + colorLabel.frame.size.height);
        
        
        }
}

- (void)returnSysTime:(ASIHTTPRequest *)mrequest{
    
    if ([mrequest responseData]) {
        //	GC_PersonalData *personalData = [[GC_PersonalData alloc] initWithResponseData:[mrequest responseData]];
        ChongZhiData * chongzhi = [[ChongZhiData alloc] initWithResponseData:[mrequest responseData] WithRequest:mrequest];
        NSLog(@"systime = %@", chongzhi.systime);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
        [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime] afterDelay:2];
        [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime]];
        [chongzhi release];
    }
}

- (void)returnSysTime1:(ASIHTTPRequest *)mrequest{
    
    if ([mrequest responseData]) {
        //	GC_PersonalData *personalData = [[GC_PersonalData alloc] initWithResponseData:[mrequest responseData]];
        ChongZhiData * chongzhi = [[ChongZhiData alloc] initWithResponseData:[mrequest responseData] WithRequest:mrequest];
        NSLog(@"systime = %@", chongzhi.systime);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
        [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] reChangeUrlSysTimew:chongzhi.systime Type:self.selectType] afterDelay:2];
        [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrlSysTimew:chongzhi.systime Type:self.selectType]];
        [chongzhi release];
    }
}


- (void)returnSysTime2:(ASIHTTPRequest *)mrequest{
    
    if ([mrequest responseData]) {
        //	GC_PersonalData *personalData = [[GC_PersonalData alloc] initWithResponseData:[mrequest responseData]];
        ChongZhiData * chongzhi = [[ChongZhiData alloc] initWithResponseData:[mrequest responseData] WithRequest:mrequest];
        NSLog(@"systime = %@", chongzhi.systime);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
        [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] reChangeUrlSysTimeChongzhi:chongzhi.systime Type:@"phoneCharge "] afterDelay:2];
        [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrlSysTimeChongzhi:chongzhi.systime Type:@"phoneCharge "]];
        [chongzhi release];
    }
}

//跳转其他浏览器
- (void)goLiuLanqi:(NSURL *)url {
    NSURL *newURl = [[GC_HttpService sharedInstance] changeURLToTheOther:url];
    if (newURl) {
        [[UIApplication sharedApplication] openURL:newURl];
    }
    else {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"如果不能切换到浏览器进一步操作，请修改“设置->通用->访问限制->Safari”为“开启”" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

//成功跳转safari取消跳转其他浏览器
- (void)EnterBackground {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EnterBackground" object:nil];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
}

- (void)pressMoreButton:(UIButton *)sender{
    [self pressChongZhi];
}

//- (void)pressUPMPButton:(UIButton *)sender{
//
//    GC_UPMPViewController * upmpView = [[GC_UPMPViewController alloc] init];
//    if (sender.tag == 10) {
//        upmpView.creditCard = NO;
//    }else{
//        upmpView.creditCard = YES;
//    }
//    [self.navigationController pushViewController:upmpView animated:YES];
//    [upmpView release];
//
//}

//- (void)pressZhiFuBaoBtn:(UIButton *)sender{
//    GC_UPMPViewController * upmpView = [[GC_UPMPViewController alloc] init];
//    upmpView.chongZhiType = ChongZhiTypeZhiFuBao;
//    [self.navigationController pushViewController:upmpView animated:YES];
//    [upmpView release];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    for (CP_UIAlertView *alert in [(UIWindow *)[[UIApplication sharedApplication].windows objectAtIndex:0] subviews]) {
        if ([alert isKindOfClass:[CP_UIAlertView class]] && alert.delegate == self) {
            [alert removeFromSuperview];
        }
    }
    self.passWord = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BecomeActive" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"getOrderIsScuu" object:nil];
    self.selectType = nil;
    [orderRequest clearDelegatesAndCancel];
    self.orderRequest = nil;
    [accountRequest clearDelegatesAndCancel];
    self.accountRequest = nil;
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = nil;
    [boxRequest clearDelegatesAndCancel];
    self.boxRequest = nil;
    self.rechargeSequence = nil;
    [topUpTableView release];
    [rechargeSequenceArray release];
    [allowUseYHMSequenceArray release];
    [title release];
    [title1 release];
    [detail release];
    [logoName release];
    [moreButton release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    