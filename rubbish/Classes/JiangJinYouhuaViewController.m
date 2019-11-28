//
//  JiangJinYouhuaViewController.m
//  caibo
//
//  Created by yaofuyu on 13-7-9.
//
//

#import "JiangJinYouhuaViewController.h"
#import "GC_HttpService.h"
#import "Info.h"
#import "CP_SWButton.h"
#import "FAQView.h"
#import "CP_PTButton.h"
#import "caiboAppDelegate.h"
#import "GC_UserInfo.h"
#import "JJYHTouCell.h"
#import "JJYHChaiCell.h"
#import "NetURL.h"
#import "UserInfo.h"
#import "GCHeMaiSendViewController.h"
#import "ChongZhiData.h"
#import "ShuangSeQiuInfoViewController.h"
#import "GC_TopUpViewController.h"
#import "GC_UPMPViewController.h"
#import "PassWordView.h"
#import "TestViewController.h"
#import "PWInfoViewController.h"
#import "LoginViewController.h"
#import "CP_TouZhuAlert.h"
#import "SharedMethod.h"
#import "QuestionViewController.h"
#import "GC_FangChenMiParse.h"
@interface JiangJinYouhuaViewController ()

@end

@implementation JiangJinYouhuaViewController

@synthesize caizhong;
@synthesize myHttpRequest;
@synthesize mybetInfo;
@synthesize myYHInfo;
@synthesize isHemai,isCanBack;
@synthesize minMoney;
@synthesize betNum;
@synthesize myTableView;
@synthesize passWord;
@synthesize buyResult;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)resetPassWord{
    
    BOOL pwInfoBool = NO;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
        NSMutableArray * allUserArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
        
        
        for (int i = 0; i < [allUserArr count]; i++) {
            //        NSArray * userArr = [];
            NSString * userString = [allUserArr objectAtIndex:i];
            NSArray * userArr = [userString componentsSeparatedByString:@" "];
            if ([userArr count] == 3) {
                
                if ([[userArr objectAtIndex:0] isEqualToString:[[Info getInstance] userId]]) {
                    
                    pwInfoBool = YES;
                    
                    break;
                }
                
            }
            
        }
        
    }
    
    if (pwInfoBool) {
        TestViewController * test = [[TestViewController alloc] init];
        
        //                UIViewController * con = [viewController.navigationController.viewControllers objectAtIndex:[viewController.navigationController.viewControllers cou]];
        //
        [self.navigationController pushViewController:test animated:YES];
        [test release];
    }else{
        PWInfoViewController * pwinfo = [[PWInfoViewController alloc] init];
        [self.navigationController pushViewController:pwinfo animated:YES];
        [pwinfo release];
        
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"resetPassWord" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"passWordOpenUrl" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passWordOpenUrl) name:@"passWordOpenUrl" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetPassWord) name:@"resetPassWord" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    
    
    if ([[[Info getInstance] userId] intValue] != 0) {
        if (![GC_UserInfo sharedInstance].accountManage) {
            if (![GC_HttpService sharedInstance].sessionId) {
                [self performSelector:@selector(getAccountInfoRequest) withObject:nil afterDelay:2];
            }
            else {
                [self getAccountInfoRequest];
            }
        }
    }
    if (mybetInfo && mybetInfo.baomiType != 3 && baomiButton) {
        if (mybetInfo.baomiType == 1) {
            baomiButton.buttonName.text = @"保密";
        }
        else if (mybetInfo.baomiType == 2) {
            baomiButton.buttonName.text = @"截止后公开";
        }
        else if (mybetInfo.baomiType == 4) {
            baomiButton.buttonName.text = @"隐藏";
        }
        else {
            baomiButton.buttonName.text = @"公开";
        }
        
        mybetInfo.baomiType = [SharedMethod changeBaoMiTypeByTitle:baomiButton.buttonName.text];
    }
    
}

- (void)getAccountInfoRequest
{
    if ([[[Info getInstance] userName] length] > 0 && [[GC_HttpService sharedInstance].sessionId length]) {
        //获取账户信息
        NSMutableData *postData = [[GC_HttpService sharedInstance] reqAccountManagerNew:[[Info getInstance] userName]];
        
        [myHttpRequest clearDelegatesAndCancel];
        self.myHttpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [myHttpRequest setRequestMethod:@"POST"];
        [myHttpRequest addCommHeaders];
        [myHttpRequest setPostBody:postData];
        [myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [myHttpRequest setDelegate:self];
        [myHttpRequest setDidFinishSelector:@selector(reqAccountInfoFinished:)];
        [myHttpRequest startAsynchronous];
    }
    
}

- (void)reqAccountInfoFinished:(ASIHTTPRequest*)request
{
    if ([request responseData]) {
        GC_AccountManage *aManage = [[GC_AccountManage alloc] initWithResponseData:[request responseData]WithRequest:request];
        if (aManage != nil && aManage.returnId != 3000){
            [GC_UserInfo sharedInstance].accountManage = aManage;
            NSLog(@"%@", [GC_UserInfo sharedInstance].accountManage.accountBalance);
            [self update];
        }
        [aManage release];
        
        
    }
    
}
- (void)passWordOpenUrl{
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isunDoLongTime"];
    [self send];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"奖金优化";
    if (caizhong == jingcaihuntou) {
        self.title = @"胜平负混合奖金优化";
    }
    else if (caizhong == jingcaihuntouerxuanyi) {
        self.title = @"混合二选一奖金优化";
    }
    else if (caizhong == jingcaipiao) {
        self.title = @"胜平负奖金优化";
    }
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(goBack)];
    UIButton * exitLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitLoginButton setBounds:CGRectMake(0, 0, 70, 40)];
    [exitLoginButton addTarget:self action:@selector(goFAQ) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(60-24, (40 - 24)/2, 24, 24)];
    imagevi.backgroundColor = [UIColor clearColor];
    imagevi.image = UIImageGetImageFromName(@"GC_icon8.png") ;
    [exitLoginButton addSubview:imagevi];
    [imagevi release];
    
//    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:exitLoginButton];
//    self.CP_navigation.rightBarButtonItem = barBtnItem;
//    [barBtnItem release];
    
//    self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(goFAQ) ImageName:@"GC_icon8.png"Size:CGSizeMake(35, 35)];

    UIImageView *imaegV = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    imaegV.image = UIImageGetImageFromName(@"login_bgn.png");
    [self.mainView addSubview:imaegV];
    [imaegV release];
//    self.mainView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height - 45)];
    [self.mainView addSubview:myTableView];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [myTableView release];
    myTableView.backgroundColor = [UIColor colorWithRed:246/255.0 green:245/255.0 blue:238/255.0 alpha:1];
    self.betNum = [NSString stringWithFormat:@"%@",self.mybetInfo.betNumber];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	// Do any additional setup after loading the view.
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.bounds.size.height -44, 320, 44)];
	[self.mainView addSubview:im];
    im.userInteractionEnabled = YES;
    im.backgroundColor = [UIColor blackColor];
//	im.image = UIImageGetImageFromName(@"XDH960.png");
    [im release];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(195, 10, 35, 30)];
    lable.text = @"合买";
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:13];
    [im addSubview:lable];
    lable.backgroundColor = [UIColor clearColor];
    [lable release];
    

    
    CP_SWButton *hemaiSwitch = [[CP_SWButton alloc] initWithFrame:CGRectMake(230, 6, 69.5, 31)];
   
    hemaiSwitch.onImageName = @"switch_hemai_on.png";
    hemaiSwitch.offImageName = @"switch_hemai_off.png";
    [im addSubview:hemaiSwitch];
    [hemaiSwitch addTarget:self action:@selector(hemaiSetting:) forControlEvents:UIControlEventValueChanged];
    hemaiSwitch.on = isHemai;
    [hemaiSwitch release];
    
    sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    
    senderLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    if (isHemai) {
        senderLable.text = @"发起";
    }else{
        senderLable.text = @"投注";
    }
    senderLable.textAlignment = NSTextAlignmentCenter;
    senderLable.backgroundColor = [UIColor clearColor];
    senderLable.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    senderLable.font = [UIFont boldSystemFontOfSize:18];
//    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [sendBtn addSubview:senderLable];
    
	sendBtn.frame = CGRectMake(115, 8, 80, 30);
	
	[im addSubview:sendBtn];
    [self getYouhuaInfo];

}

#pragma mark -
#pragma mark View action

- (void)keyboardWillShow{
    if (!coverBtn) {
        coverBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        coverBtn.frame = self.view.bounds;
        [coverBtn addTarget:self action:@selector(Hidenkeyboard) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:coverBtn];
    }
    coverBtn.hidden = NO;
    
}

- (void)Hidenkeyboard {
    coverBtn.hidden = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    myTableView.frame = CGRectMake(myTableView.frame.origin.x, 0, myTableView.frame.size.width, myTableView.frame.size.height);
    [UIView commitAnimations];

    if ([jihuaText isFirstResponder]) {
        mybetInfo.prices = [jihuaText.text intValue];
        mybetInfo.payMoney = mybetInfo.prices;
        
    }
    [jihuaText resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideKeyBoard" object:self];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    isYouhua = NO;
    yhBtn.buttonName.text = @"立即优化";
    yhBtn.buttonImage.image = [UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:10 topCapHeight:8];
    yhBtn.nomorImage = yhBtn.buttonImage.image;
    return YES;
}

- (void)goFAQ {
//    FAQView *faq = [[FAQView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    faq.faqdingwei = JiangJinYouHua;
//    [faq Show];
//    
//    [faq release];
    
    QuestionViewController *qvc=[[QuestionViewController alloc]init];
    qvc.question = JiangJinYouHuaType;
    [self.navigationController pushViewController:qvc animated:YES];
    [qvc release];
    
    
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)getYouhuaInfo {
    if (isYouhua) {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"请修改计划投注金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    if ([jihuaText.text intValue]%2 != 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"投注金额必须是偶数"];
        return;
    }
    if ([jihuaText.text intValue] < minMoney && jihuaText) {
        [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"投注金额必须大于等于%ld元",(long)minMoney]];
        return;
    }
    if ([jihuaText.text intValue] > 1500000) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"投注总金额不能超过150万元"];
        return;
    }
    if (jihuaText) {
        self.mybetInfo.prices = [jihuaText.text intValue];
        self.mybetInfo.totalParts = self.mybetInfo.totalParts;
    }
    if ([jihuaText.text intValue] >= minMoney * 2) {
        UIView *lable = [myTableView.tableHeaderView viewWithTag:123];
        lable.hidden = YES;
    }
    self.mybetInfo.betNumber = [NSString stringWithFormat:@"%@",self.betNum];
    NSMutableData *postData = [[GC_HttpService sharedInstance] JJYHWithBetInfo:self.mybetInfo Type:1];
    [myHttpRequest clearDelegatesAndCancel];
    self.myHttpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [myHttpRequest setRequestMethod:@"POST"];
    [myHttpRequest addCommHeaders];
    [myHttpRequest setPostBody:postData];
    [myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myHttpRequest setDelegate:self];
    [myHttpRequest setDidFinishSelector:@selector(reqYouhua:)];
    [myHttpRequest startAsynchronous];
    
}

- (void)hemaiSetting:(CP_SWButton *)sender {
    isHemai = sender.on;
    if (isHemai) {
        senderLable.text = @"发起";
    }
    else {
        senderLable.text = @"投注";
    }
}

- (void)jihuaSelect {
    [jihuaText becomeFirstResponder];
}

- (void)pressbaomibutton:(CP_PTButton *)sender {
    NSLog(@"~~~%@",baomiButton.buttonName.text);
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"方案设置" message:baomiButton.buttonName.text delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.shouldRemoveWhenOtherAppear = YES;
    alert.alertTpye = segementType;
    alert.tag = 999;
    [alert show];
    [alert release];
}

- (void)getYHKey {
    
    NSString *YHKey = self.myYHInfo.YHKey;
    NSMutableArray *array = [NSMutableArray arrayWithArray:[YHKey componentsSeparatedByString:@";"]];
    for (int i = 0; i < [array count]; i ++) {
        NSString *yhkey1 = [array objectAtIndex:i];
        NSMutableArray *array1 =[NSMutableArray arrayWithArray:[yhkey1 componentsSeparatedByString:@"^"]];
        if ([array1 count] >2) {
                GC_YHChaiInfo *chaiinfo = [self.myYHInfo.chaiArray objectAtIndex:i];
                    NSString *zhushu = chaiinfo.betNum;
                    [array1 replaceObjectAtIndex:4 withObject:zhushu];
                    [array1 replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%ld",(long)[zhushu integerValue] *2]];
        }
        NSString *newYhkey1 =[array1 componentsJoinedByString:@"^"];
        [array replaceObjectAtIndex:i  withObject:newYhkey1];
    }
    NSString *newYhkey1 =[array componentsJoinedByString:@";"];
    self.myYHInfo.YHKey = newYhkey1;
    self.mybetInfo.betNumber = [NSString stringWithFormat:@"%@*%@",self.myYHInfo.YHKey,self.myYHInfo.randNum];
}

- (void)relsend {
    
    
#ifdef isYueYuBan
    if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < mybetInfo.payMoney || [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] ==0) {
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        alert.shouldRemoveWhenOtherAppear = YES;
        alert.tag = 109;
        [alert show];
        [alert release];
        return;
    }
        NSString * keyString = [NSString stringWithFormat:@"%@@%d", self.mybetInfo.betNumber, [[Info getInstance] caipaocount] ];
#else
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isAlipay"] isEqualToString:@"4"]) {
        if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < mybetInfo.payMoney) {
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 109;
            [alert show];
            [alert release];
            return;
        }
    }else{
        if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] < mybetInfo.payMoney) {
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 109;
            [alert show];
            [alert release];
            return;
        }
    
    }
    
    NSString * keyString = self.mybetInfo.betNumber;
    
#endif
    [self.myHttpRequest clearDelegatesAndCancel];
    NSMutableData * postData = [[GC_HttpService sharedInstance] reqJingcaiBetting:keyString baomi:mybetInfo.baomiType danfushi:1 betData:mybetInfo];
    
    
    self.myHttpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [myHttpRequest addCommHeaders];
    [myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myHttpRequest appendPostData:postData];
    [myHttpRequest setDelegate:self];
    [myHttpRequest setDidFinishSelector:@selector(reqBuyLotteryData:)];
    [myHttpRequest startAsynchronous];
    
}
- (BOOL)typeFunc{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
        NSMutableArray * allUserArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
        
        
        for (int i = 0; i < [allUserArr count]; i++) {
            //        NSArray * userArr = [];
            NSString * userString = [allUserArr objectAtIndex:i];
            NSArray * userArr = [userString componentsSeparatedByString:@" "];
            if ([userArr count] == 3) {
                
                if ([[userArr objectAtIndex:0] isEqualToString:[[Info getInstance] userId]]) {
                    NSString * typestr = [userArr objectAtIndex:2];
                    if ([typestr isEqualToString:@"1"]) {
                        return YES;
                    }else{
                        return NO;
                    }
                }
                
            }
            
        }
        
    }
    return NO;
}
- (void)sleepPassWordViewShow{
    caiboAppDelegate * cai = [caiboAppDelegate getAppDelegate];
    PassWordView * pwv = [[PassWordView alloc] init];
    pwv.alpha = 0;
    //    pwv.viewController = self;
    [cai.window addSubview:pwv];
    [pwv release];
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    pwv.alpha = 1;
    [UIView commitAnimations];
}
- (void)send {
    
    if ([[[Info getInstance] userId] intValue] == 0) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasLogin" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [loginVC setHidesBottomBarWhenPushed:YES];
        [loginVC setIsShowDefultAccount:YES];
        [self.navigationController pushViewController:loginVC animated:YES];
        [loginVC release];
        return;
    }
    [self update];
    if (self.mybetInfo.payMoney > 1500000) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"投注总金额不能超过150万"];
        return;
    }
    if (self.mybetInfo.payMoney <= 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"暂无投注内容。"];
        return;
    }
       [self getYHKey];
    if (isHemai) {
        
        GCHeMaiSendViewController *send = [[GCHeMaiSendViewController alloc] init];
        send.betInfo = mybetInfo;
        send.isPutong = isCanBack;
        [self.navigationController pushViewController:send animated:YES];
        [send release];
        return;
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isunDoLongTime"] intValue]&&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
        
        if ([self typeFunc]) {
            
            [self sleepPassWordViewShow];
            
            
        }else{
            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertTpye = passWordType;
            alert.tag = 101;
            [alert show];
            [alert release];
            
        }
        return;
    }

    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"投注金额为%d元，您是否确定投注？",self.mybetInfo.payMoney] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert show];
    alert.tag = 103;
    [alert release];
    
}

- (void)hasLogin {
    if ([[[Info getInstance] userId] intValue] != 0) {
        zhanghuLabel.hidden = NO;
    }
    for (UIView *v in [caiboAppDelegate getAppDelegate].window.subviews) {
        NSLog(@"%@  ,  %@",[v class],v );
    }
}

- (void)buyBack {
    
    
    if (isGoBuy) {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"购买成功？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        alert.tag = 102;
        [alert release];
    }
    isGoBuy = NO;

}

- (void)update {
//    if (!mySegment) {
//        [self.mybetInfo setBaomiType:BaoMiTypeGongKai];
//    }
//    else if (mySegment.selectIndex == 3){
//        [self.mybetInfo setBaomiType:BaoMiTypeYinShen];
//    }
//    else {
//        [self.mybetInfo setBaomiType:mySegment.selectIndex];
//    }
    
    [self.mybetInfo setBaomiType:[SharedMethod changeBaoMiTypeByTitle:baomiButton.buttonName.text]];

    mybetInfo.bets = 0;
    for (int i = 0; i < [myYHInfo.chaiArray count];i ++) {
        GC_YHChaiInfo *tou = [myYHInfo.chaiArray objectAtIndex:i];
        mybetInfo.bets = [tou.betNum intValue] + mybetInfo.bets;
    }
    
    NSString *chuan = @"";
    NSArray *array  = [self.mybetInfo.betNumber componentsSeparatedByString:@"^"];
    if ([array count]>2) {
        chuan = [[array objectAtIndex:1] stringByReplacingOccurrencesOfString:@"x" withString:@"串"];
    }
    nameLabel.text = [NSString stringWithFormat:@"<%d>注 %@",mybetInfo.bets,chuan];
    yujiMoney.text = [NSString stringWithFormat:@"预计奖金 <%@-%@> 元",myYHInfo.minMoney,myYHInfo.maxMoney];
    
    mybetInfo.payMoney = mybetInfo.bets *2;
    mybetInfo.prices = mybetInfo.bets *2;
    mybetInfo.price = mybetInfo.bets;
    mybetInfo.totalParts = mybetInfo.payMoney;
    moneyLabel.text = [NSString stringWithFormat:@"应付: <%d>元",mybetInfo.payMoney];
    zhanghuLabel.text = [NSString stringWithFormat:@"余额: <%.2f>元",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    moneyLabel.frame = CGRectMake(240-[[NSString stringWithFormat:@"%d",mybetInfo.payMoney] length] *10,0, 200, 20);
    NSString *st = [NSString stringWithFormat:@"%.2f",[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    
    zhanghuLabel.frame = CGRectMake(246 - [st length]*8, 25, 200, 20);
//    self.myYHInfo.YHKey =
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

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)returnSysTime:(ASIHTTPRequest *)mrequest{
    
    if ([mrequest responseData]) {
        //	GC_PersonalData *personalData = [[GC_PersonalData alloc] initWithResponseData:[mrequest responseData]];
        ChongZhiData * chongzhi = [[ChongZhiData alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
        NSLog(@"systime = %@", chongzhi.systime);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
        [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime] afterDelay:1];
        [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime]];
        [chongzhi release];
    }

}

-(void)requestFangChenMi
{
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"FangChenMiSwitch"] integerValue] == 1){
        
        NSMutableData *postData = [[GC_HttpService sharedInstance] getUSerFangChenMiMessage];
        
        [myHttpRequest clearDelegatesAndCancel];
        self.myHttpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [myHttpRequest setRequestMethod:@"POST"];
        [myHttpRequest addCommHeaders];
        [myHttpRequest setPostBody:postData];
        [myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [myHttpRequest setDelegate:self];
        [myHttpRequest setDidFinishSelector:@selector(requestFangChenMiFinished:)];
        [myHttpRequest startAsynchronous];
        
    }

}
- (void)requestFangChenMiFinished:(ASIHTTPRequest*)request{
    
    if([request responseData]){
        
        GC_FangChenMiParse *fangchenmi = [[GC_FangChenMiParse alloc] initWithResponseData:request.responseData WithRequest:request];
        
        if(fangchenmi.returnID != 3000){
            
            if([fangchenmi.code integerValue] == 1){
                
                [self showFangChenMiText:fangchenmi.alertText andImageNum:fangchenmi.alertNum];
                
            }
            
        }
        [fangchenmi release];
        
    }
}


- (void)reqBuyLotteryData:(ASIHTTPRequest*)request {
    NSData  *data = [request responseData];
    if (data) {
#ifdef isYueYuBan
        self.buyResult = [[GC_BuyLottery alloc] initWithResponseData:[request responseData] WithRequest:request];
#else
        self.buyResult = [[GC_BuyLottery alloc] initWithResponseData:[request responseData] WithRequest:request];
#endif
        buyResult.lotteryId = self.mybetInfo.lotteryId;
        
#ifdef isYueYuBan
        
        if (buyResult.returnValue == 0) {
            

            CP_TouZhuAlert *alert = [[CP_TouZhuAlert alloc] init];
            alert.buyResult = buyResult;
            alert.delegate = self;
            [alert show];
            [alert release];


            
        }else if(buyResult.returnValue == 2){
            // NSString * msgstr = [NSString stringWithFormat:@"",betInfo.issue];
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 109;
            [alert show];
            [alert release];
            
        } else if (buyResult.returnValue == 10) {
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您之前已经投过此注，是否继续投注" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 105;
            [alert show];
            [alert release];
        }else if (buyResult.returnValue == 9){
            
            NSString * h5url = @"http://h5123.cmwb.com/lottery/nearStation/toMap.jsp";
            
            MyWebViewController *webview = [[MyWebViewController alloc] init];
            [webview LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:h5url]]];
            webview.delegate= self;
            webview.hiddenNav = NO;
            [self.navigationController pushViewController:webview animated:YES];
            [webview release];
            
        }
        //  [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrlSysTime:buyResult.systemTime]];
        
#else
        if (buyResult.returnValue == 1) {
            isGoBuy = YES;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
            [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] payUrlWith:buyResult] afterDelay:1];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyBack) name:@"BecomeActive" object:nil];
            [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] payUrlWith:buyResult]];
        }
        
#endif
        
        
        
        else if (buyResult.returnValue == 4) {
            
            if([buyResult.curIssure length] == 0){
                
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您选择的比赛已截止" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.tag = 108;
                [alert show];
                [alert release];
                
            }else {
                
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您选择的比赛已截止,请重新投注" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.tag = 108;
                [alert show];
                [alert release];
            }
            
            
            
            
        } else {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"投注失败"];
        }
    }
    
}

- (void)reqYouhua:(ASIHTTPRequest*)request {
    isYouhua = YES;
	if ([request responseData]) {
        JiangJinYouHuaJX *jex = [[JiangJinYouHuaJX alloc] initWithResponseData:request.responseData WithRequest:request];
        if (!self.myYHInfo) {
            isYouhua = NO;
        }
        else {
            yhBtn.buttonName.text = @"已优化";
            yhBtn.buttonImage.image =[UIImageGetImageFromName(@"jjyhhuiimage.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
            yhBtn.nomorImage = yhBtn.buttonImage.image;
        }
        self.myYHInfo = jex;
        [jex release];
	}
    if (![self.myYHInfo.YHStueNum isEqualToString:@"0000"]) {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:self.myYHInfo.YHMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alert show];
        alert.tag = 106;
        [alert release];
        return;
    }
    if (!myTableView.tableHeaderView) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 117)];
        myTableView.tableHeaderView = v;
        
        UILabel *jiezhilabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 6, 180, 20)];
        jiezhilabel.font = [UIFont systemFontOfSize:12];
        jiezhilabel.textAlignment = NSTextAlignmentLeft;
        jiezhilabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
        jiezhilabel.backgroundColor = [UIColor clearColor];
        jiezhilabel.text = @"优化方式";
        [v addSubview:jiezhilabel];
        [jiezhilabel release];
        
        
        UIButton *rengouBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rengouBtn.frame = CGRectMake(10, 27, 190, 30);
        [v addSubview:rengouBtn];
        [rengouBtn addTarget:self action:@selector(jihuaSelect) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [rengouBtn setBackgroundImage:[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateNormal];
//        [rengouBtn setBackgroundImage:[UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10] forState:UIControlStateHighlighted];
        
        UILabel *label = [[UILabel alloc] initWithFrame:rengouBtn.bounds];
        label.text = @"  计划投注                                   元";
        label.backgroundColor = [UIColor clearColor];
        [rengouBtn addSubview:label];
        label.font = [UIFont systemFontOfSize:11];
        [label release];
        
        jihuaText = [[UITextField alloc] init];
        jihuaText.delegate = self;
        jihuaText.text = [NSString stringWithFormat:@"%d",self.mybetInfo.prices];
        jihuaText.textColor = [UIColor redColor];
        jihuaText.font = [UIFont systemFontOfSize:12];
        jihuaText.keyboardType = UIKeyboardTypeNumberPad;
        jihuaText.frame = CGRectMake(60, 7, 110, 20);
        jihuaText.textAlignment = NSTextAlignmentCenter;
        jihuaText.backgroundColor = [UIColor clearColor];
        [rengouBtn addSubview:jihuaText];
        [jihuaText release];
        
        yhBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
        yhBtn.frame = CGRectMake(205, 27, 105, 30);
        [yhBtn loadButonImage:@"btn_blue_selected.png" LabelName:@"立即优化"];
        [yhBtn setHightImage:[UIImageGetImageFromName(@"jjyhhuiimage.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [v addSubview:yhBtn];
        [yhBtn addTarget:self action:@selector(getYouhuaInfo) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *infolabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 62, 300, 14)];
        infolabel.backgroundColor = [UIColor clearColor];
        infolabel.textColor = [UIColor redColor];
        infolabel.font = [UIFont systemFontOfSize:11];
        infolabel.tag = 123;
        infolabel.text = [NSString stringWithFormat:@" 注：投注金额必须大于等于%ld元,金额越多，变化幅度越大。",(long)minMoney];
        [v addSubview:infolabel];
        [infolabel release];
        
        UIImageView * xian1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 81, 320, 0.5)];
        xian1.backgroundColor = [UIColor colorWithRed:180/255.0 green:174/255.0 blue:158/255.0 alpha:1];
        [v addSubview:xian1];
        [xian1 release];

        
        UIImageView * bgfangan = [[UIImageView alloc] initWithFrame:CGRectMake(0, 81.5, 320, 117 - 81.5)];
        bgfangan.backgroundColor = [UIColor colorWithRed:246/255.0 green:245/255.0 blue:238/255.0 alpha:1];
        [v addSubview:bgfangan];
        [bgfangan release];
        
        UILabel *fangan = [[UILabel alloc] initWithFrame:CGRectMake(13, 82+10, 180, 20)];
        fangan.font = [UIFont systemFontOfSize:11];
        fangan.textAlignment = NSTextAlignmentLeft;
        fangan.textColor = [UIColor colorWithRed:118/255.0 green:101/255.0 blue:58/255.0 alpha:1];
        fangan.backgroundColor = [UIColor clearColor];
        fangan.text = @"投注方案";
        [v addSubview:fangan];
        [fangan release];
        
//        UIImageView * xian2 = [[UIImageView alloc] initWithFrame:CGRectMake(74, 90, 230, 2)];
//        xian2.backgroundColor = [UIColor clearColor];
//        xian2.image = UIImageGetImageFromName(@"SZTG960.png");
//        [v addSubview:xian2];
//        [xian2 release];
        
        v.backgroundColor = [UIColor whiteColor];
        [v release];
    }
    if (!myTableView.tableFooterView) {
        UIView *infoBackImage = [[UIView alloc] init];
       
        infoBackImage.frame = CGRectMake(0, 0, 320, 97);
        myTableView.tableFooterView = infoBackImage;
        infoBackImage.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView1 = [[UIImageView alloc] init];
        imageView1.backgroundColor = [UIColor clearColor];
//        imageView1.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        imageView1.frame = CGRectMake(10, 8, 300, 85);
        imageView1.userInteractionEnabled = YES;
        [infoBackImage addSubview:imageView1];
        [imageView1 release];
        
        [infoBackImage release];
        
        
        UIImageView * xiaImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        xiaImageV.backgroundColor = [UIColor colorWithRed:180/255.0 green:174/255.0 blue:158/255.0 alpha:1];
        [infoBackImage addSubview:xiaImageV];
        [xiaImageV release];
        
        
        nameLabel = [[ColorView alloc] initWithFrame:CGRectMake(5, 0, 290, 20)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor grayColor];
        [imageView1 addSubview:nameLabel];
        NSString *chuan = @"";
        NSArray *array  = [self.mybetInfo.betNumber componentsSeparatedByString:@"^"];
        if ([array count]>2) {
            chuan = [[array objectAtIndex:1] stringByReplacingOccurrencesOfString:@"x" withString:@"串"];
        }
        nameLabel.colorfont = [UIFont systemFontOfSize:17];
        nameLabel.changeColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        nameLabel.text = [NSString stringWithFormat:@"<%d>注 %@",mybetInfo.bets,chuan];
        nameLabel.font = [UIFont systemFontOfSize:11];
        [nameLabel release];
        
        yujiMoney = [[ColorView alloc] initWithFrame:CGRectMake(5, 25, 170, 40)];
        yujiMoney.backgroundColor = [UIColor clearColor];
        yujiMoney.textColor = [UIColor grayColor];
        [imageView1 addSubview:yujiMoney];
        yujiMoney.text = [NSString stringWithFormat:@"预计奖金 <%@-%@> 元",myYHInfo.minMoney,myYHInfo.maxMoney];
        yujiMoney.font = [UIFont systemFontOfSize:11];
        [yujiMoney release];
        
        moneyLabel = [[ColorView alloc] initWithFrame:CGRectMake(100, 0, 290, 20)];
        moneyLabel.backgroundColor = [UIColor clearColor];
        moneyLabel.textColor = [UIColor grayColor];
        moneyLabel.font = [UIFont systemFontOfSize:13];
        moneyLabel.changeColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:1 alpha:1];
        moneyLabel.colorfont = [UIFont systemFontOfSize:17];
        [imageView1 addSubview:moneyLabel];
        [moneyLabel release];
        
        zhanghuLabel = [[ColorView alloc] initWithFrame:CGRectMake(203, 25, 100, 20)];
        zhanghuLabel.backgroundColor = [UIColor clearColor];
        zhanghuLabel.textColor = [UIColor grayColor];
        zhanghuLabel.changeColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        [imageView1 addSubview:zhanghuLabel];
        zhanghuLabel.font = [UIFont systemFontOfSize:13];
        if ([[[Info getInstance] userId] intValue] == 0) {
            zhanghuLabel.hidden = YES;
        }
        [zhanghuLabel release];
        
        baomiButton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
        baomiButton.frame = CGRectMake(215, 48, 75, 31);
        [baomiButton loadButonImage:@"btn_yellow_normal.png" LabelName:@"公开"];
        if (self.mybetInfo.baomiType == 1) {
            baomiButton.buttonName.text = @"保密";
        }
        else if (self.mybetInfo.baomiType == 2) {
            baomiButton.buttonName.text = @"截止后公开";
        }
        else if (self.mybetInfo.baomiType == 4) {
            baomiButton.buttonName.text = @"隐藏";
        }
        else {
            baomiButton.buttonName.text = @"公开";
        }
        baomiButton.buttonName.textColor = [UIColor colorWithRed:1 green:200/255.0 blue:50/255.0 alpha:1];
//        baomiButton.buttonName.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        baomiButton.buttonName.font = [UIFont systemFontOfSize:14];
        [baomiButton addTarget:self action:@selector(pressbaomibutton:) forControlEvents:UIControlEventTouchUpInside];
        [imageView1 addSubview:baomiButton];
    }
    yujiMoney.hidden = NO;
    [myTableView reloadData];
    [self update];
}

- (void)recivedFail:(ASIHTTPRequest*)request {
    [[caiboAppDelegate getAppDelegate] showMessage:@"网络请求超时"];
}

- (void)recivedLoginFinish:(ASIHTTPRequest*)request {
	NSString *responseStr = [request responseString];
	
	if ([responseStr isEqualToString:@"fail"])
    {
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
		[cai showMessage:@"密码不正确"];
    }
	else {
		UserInfo *userInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
		if (!userInfo) {
			caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
			[cai showMessage:@"密码不正确"];
			return;
		}
		[userInfo release];
		
		[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isunDoLongTime"];
        
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"oneAlertView"] intValue] == 0) {
            CP_UIAlertView * alear = [[CP_UIAlertView alloc] initWithTitle:@"设置手势密码" message:@"" delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"马上设置",nil];
            alear.delegate = self;
            alear.tag = 998;
            alear.alertTpye = twoTextType;
            [alear show];
        }else{
           [self send];
        }
        
        
	}
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
   
    [self.myHttpRequest clearDelegatesAndCancel];
    [buyResult release];

    self.myHttpRequest = nil;
    self.mybetInfo = nil;
    self.myYHInfo = nil;
    self.betNum = nil;
//    [editeView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark -
#pragma mark JJYHChaiCellDelegate
//投注成功回调
- (void)CP_TouZhuAlert:(CP_TouZhuAlert *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
        info.nikeName = [[[Info getInstance] mUserInfo] user_name] ;
        info.orderId = chooseView.buyResult.totalMoney;
        info.issure = self.mybetInfo.issue;
        [self.navigationController pushViewController:info animated:YES];
        [info release];
    }
    
    [self requestFangChenMi];
}
//防沉迷弹窗
-(void)showFangChenMiText:(NSString *)_text andImageNum:(NSInteger)_imgNum
{
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"投注站提示您" message:_text delegate:self cancelButtonTitle:@"休息一下" otherButtonTitles:nil,nil];
    alert.alertTpye = textAndImage;
    alert.tag = 1234;
    if(_imgNum%9 == 1 || _imgNum%9 == 2 || _imgNum%9 == 3){
        alert.imageName = @"anti-addiction_1.png";
        
    }
    if(_imgNum%9 == 4 || _imgNum%9 == 5 || _imgNum%9 == 6){
        alert.imageName = @"anti-addiction_2.png";
        
    }
    
    if(_imgNum%9 == 7 || _imgNum%9 == 8 || _imgNum%9 == 0){
        alert.imageName = @"anti-addiction_3.png";
        
    }
    
    [alert show];
    [alert release];
}
- (void)delegateUpdate:(JJYHChaiCell *)cell {
    yujiMoney.hidden = YES;
    [self update];
}

#pragma mark -
#pragma mark CP_UIAlertViewDelegate
- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 101) {
        if (buttonIndex == 1) {
			[self.myHttpRequest clearDelegatesAndCancel];
			NSString *name = [[Info getInstance] login_name];
            //            UITextField *alertext = (UITextField *)[alertView viewWithTag:1102];
			NSString *password = self.passWord;
			self.myHttpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:password]];
			[myHttpRequest setTimeOutSeconds:20.0];
			[myHttpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
			[myHttpRequest setDidFailSelector:@selector(recivedFail:)];
			[myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
			[myHttpRequest setDelegate:self];
			[myHttpRequest startAsynchronous];
			
		}
    }
    else if (alertView.tag == 109) {
        if (buttonIndex == 1) {
            GC_TopUpViewController * toUp = [[GC_TopUpViewController alloc] init];
            [self.navigationController pushViewController:toUp animated:YES];
            [toUp release];
//            NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
//            
//            [myHttpRequest clearDelegatesAndCancel];
//            self.myHttpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
//            [myHttpRequest setRequestMethod:@"POST"];
//            [myHttpRequest addCommHeaders];
//            [myHttpRequest setPostBody:postData];
//            [myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//            [myHttpRequest setDelegate:self];
//            [myHttpRequest setDidFinishSelector:@selector(returnSysTime:)];
//            [myHttpRequest startAsynchronous];
        }
    }else if (alertView.tag == 999) {
        if (buttonIndex == 1) {
        baomiButton.buttonName.text = alertView.alertSegement.selectBtn.buttonName.text;
            [self.mybetInfo setBaomiType:[SharedMethod changeBaoMiTypeByTitle:baomiButton.buttonName.text]];
        }
    }

    if (alertView.tag == 102) {
        if (buttonIndex == 1) {
            ShuangSeQiuInfoViewController *shuang = [[ShuangSeQiuInfoViewController alloc] init];
            [self.navigationController pushViewController:shuang animated:YES];
            [shuang release];
        }
        
        [self requestFangChenMi];
    }
    else if(alertView.tag == 1234)
    {

    }
    else if (alertView.tag == 103) {
        if (buttonIndex == 1) {
            [self relsend];
        }
    }
    else if (alertView.tag == 106) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (alertView.tag == 998) {
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"oneAlertView"];
        if (buttonIndex == 1) {
            
            BOOL pwInfoBool = NO;
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"]) {
                NSMutableArray * allUserArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"testPassWord"];
                
                
                for (int i = 0; i < [allUserArr count]; i++) {
                    //        NSArray * userArr = [];
                    NSString * userString = [allUserArr objectAtIndex:i];
                    NSArray * userArr = [userString componentsSeparatedByString:@" "];
                    if ([userArr count] == 3) {
                        
                        if ([[userArr objectAtIndex:0] isEqualToString:[[Info getInstance] userId]]) {
                            
                            pwInfoBool = YES;
                            
                            break;
                        }
                        
                    }
                    
                }
                
            }
            
            if (pwInfoBool) {
                TestViewController * test = [[TestViewController alloc] init];
                [self.navigationController pushViewController:test animated:YES];
                [test release];
            }else{
                PWInfoViewController * pwinfo = [[PWInfoViewController alloc] init];
                [self.navigationController pushViewController:pwinfo animated:YES];
                [pwinfo release];
                
            }
        }else{
            
            [self send];
        }
        
    }
}

#pragma mark -
#pragma mark UIAlertViewDelegate 

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message{
    if (alertView.tag == 101) {
        if (buttonIndex == 1) {
            self.passWord = message;
			[self.myHttpRequest clearDelegatesAndCancel];
			NSString *name = [[Info getInstance] login_name];
            //            UITextField *alertext = (UITextField *)[alertView viewWithTag:1102];
			NSString *password = self.passWord;
			self.myHttpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:password]];
			[myHttpRequest setTimeOutSeconds:20.0];
			[myHttpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
			[myHttpRequest setDidFailSelector:@selector(recivedFail:)];
			[myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
			[myHttpRequest setDelegate:self];
			[myHttpRequest startAsynchronous];
			
		}
    }


}


#pragma mark -
#pragma mark Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < [self.myYHInfo.betArray count]) {
        if (self.caizhong == jingcaihuntou) {
            return 71;
        }
        return 56;
    }
    else if (indexPath.row ==[self.myYHInfo.betArray count]) {
        
        GC_YHChaiInfo *info = [self.myYHInfo.chaiArray objectAtIndex:0];
        NSArray *array = [info.betInfo componentsSeparatedByString:@"x"];
        
        return 111 + [array count] * 11;
    }
    GC_YHChaiInfo *info = [self.myYHInfo.chaiArray objectAtIndex:0];
    NSArray *array = [info.betInfo componentsSeparatedByString:@"x"];
    
    return 73 + [array count] * 11;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.myYHInfo) {
        return [self.myYHInfo.chaiArray count] + [self.myYHInfo.betArray count];
    }
    return 0;
    
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundColor = [UIColor clearColor];
    }
    if (indexPath.row < [self.myYHInfo.betArray count]) {
        static NSString *CellIdentifier2 = @"CellTou";
        JJYHTouCell *cell2 = (JJYHTouCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (!cell2) {
            cell2 = [[[JJYHTouCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier2] autorelease];
            cell2.caizhong = self.caizhong;
        }
        
        if (indexPath.row == [self.myYHInfo.betArray count] - 1) {
            cell2.zhuihouBool = YES;
        }else{
            cell2.zhuihouBool = NO;
        }
        
        GC_YHTouInfo *tou = [myYHInfo.betArray objectAtIndex:indexPath.row];
        [cell2 setPkbetdata:tou];
        cell2.count = indexPath.row;
        return cell2;
    }
    else {
        static NSString *CellIdentifier2 = @"CellChai";
        JJYHChaiCell *cell2 = (JJYHChaiCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (!cell2) {
            cell2 = [[[JJYHChaiCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier2] autorelease];
            
        }
        
        
        
        GC_YHChaiInfo *tou = [myYHInfo.chaiArray objectAtIndex:indexPath.row - [self.myYHInfo.betArray count]];
        cell2.Index = indexPath.row - [self.myYHInfo.betArray count];
        
        if ((indexPath.row - [self.myYHInfo.betArray count]) == ([myYHInfo.chaiArray count]-1)) {
            cell2.zuihouBool = YES;
        }else{
            cell2.zuihouBool = NO;
        }
        
        cell2.jJYHChaiCellDelegate = self;
        [cell2 setMyinfo:tou];
        return cell2;
        
    }
    
    return cell;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    