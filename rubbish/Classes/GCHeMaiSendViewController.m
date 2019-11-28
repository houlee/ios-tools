    //
//  GCHeMaiSendViewController.m
//  caibo
//
//  Created by yao on 12-6-27.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "GCHeMaiSendViewController.h"
#import "Info.h"
#import "GC_LotteryType.h"
#import "GC_HttpService.h"
#import "GC_BuyLottery.h"
#import "Xieyi365ViewController.h"
#import "GC_UserInfo.h"
#import "ShuangSeQiuInfoViewController.h"
#import "caiboAppDelegate.h"
#import "ChongZhiData.h"
#import "NSStringExtra.h"
#import "YDUtil.h"
#import "GoodVoiceJieXie.h"
#import "QuartzCore/QuartzCore.h"
#import "GC_TopUpViewController.h"
#import "GC_UPMPViewController.h"
#import "NetURL.h"
#import "UserInfo.h"
#import "TestViewController.h"
#import "PWInfoViewController.h"
#import "PassWordView.h"
#import "CP_TouZhuAlert.h"
#import "GC_FangChenMiParse.h"
#import "MobClick.h"

@implementation GCHeMaiSendViewController

@synthesize betInfo;
@synthesize httpRequest;
@synthesize isPutong;
@synthesize syscurIssre;
@synthesize /*myTimer,*/ saveKey;
@synthesize buyResult;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (id)init {
    self = [super init];
    if (self) {
        isGoBuy = NO;
        isPutong= NO;
        recorderTime = 0;
    }
    return self;
}

- (void)getStartTogetherBuyRequest
{
    if ([GC_LotteryType isZucai:betInfo.lotteryType]&&betInfo.issue.length > 2) {
        betInfo.issue = [betInfo.issue substringFromIndex:2];
    }
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqStartTogetherBuy:betInfo Resend:[[Info getInstance] caipaocount]];
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(reqStartTogetherBuyFinished:)];
    [httpRequest startAsynchronous];
}

- (void)wanfaInfo {
	Xieyi365ViewController *xie= [[Xieyi365ViewController alloc] init];
    xie.ALLWANFA= HeMai;
	[self.navigationController pushViewController:xie animated:YES];
//	NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"hemai.txt"];
//	NSData *fileData = [fileManager contentsAtPath:path];
//    if (fileData) {
//		NSString *str = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
//		xie.infoText.text = str;
//		[str release];
//	}
//	xie.title = @"合买介绍";
	[xie release];
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[rengouText resignFirstResponder];
	[xuanyanText resignFirstResponder];
	[tichengText resignFirstResponder];
	[baodiText resignFirstResponder];
	//[multipleTF resignFirstResponder];
}

- (void)baoMiChange:(UISegmentedControl *)sender {
	
	[rengouText resignFirstResponder];
	[xuanyanText resignFirstResponder];
	[tichengText resignFirstResponder];
	[baodiText resignFirstResponder];
}

- (void)pressaddbutton:(UIButton *)sender{
    [self baoMiChange:nil];
	if ([tichengText.text intValue] >= 10) {
		tichengText.text = @"10";
	}
	else {
		tichengText.text = [NSString stringWithFormat:@"%d",[tichengText.text intValue] + 1];
	}

}

- (void)pressjianbutton:(UIButton *)sender{
    [self baoMiChange:nil];
	if ([tichengText.text intValue] <= 0) {
		tichengText.text = @"0";
	}
	else {
		tichengText.text = [NSString stringWithFormat:@"%d",[tichengText.text intValue] - 1];
	}
	
}

- (void)quanerbaodi{
    [self baoMiChange:nil];
	baodiText.text = [NSString stringWithFormat:@"%d",betInfo.payMoney - [rengouText.text intValue]];
	yingfuLable.text = [NSString stringWithFormat:@"应付<%d>元,余额<%.2f>元",[rengouText.text intValue] + [baodiText.text intValue],[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    yingfuLable.frame = CGRectMake(120  - [rengouText.text length]*5 -[[GC_UserInfo sharedInstance].accountManage.accountBalance length]*5, 80, 300, 30);
//    NSLog(@"%f,%f",yingfuLable.frame.origin.x,yingfuLable.frame.size.width);
//    NSLog(@"%@,%d",rengouText.text,rengouText.text.length);
//    NSLog(@"%@,%d",[GC_UserInfo sharedInstance].accountManage.accountBalance,[GC_UserInfo sharedInstance].accountManage.accountBalance.length);
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

- (BOOL)checkisShuziOrNot:lotteryId {
	BOOL isShuZi = YES;
	if ([lotteryId isEqualToString:@"001"]||[lotteryId isEqualToString:@"01"]) {//双色球
		isShuZi = YES;
	}
	else if ([lotteryId isEqualToString:@"113"]) {//大乐透
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"002"]) {//3d
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"110"]) {//七星彩
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"003"]) {//七乐彩
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"111"]) {//22选5
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"108"]) {//排列3
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"109"]) {//排列5
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"010"]) {//两步彩
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"006"]) {//时时彩
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"107"] || [lotteryId isEqualToString:@"119"]) {//11选5
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"016"]) {//快乐8
		isShuZi = YES;
		
	}
	else if ([lotteryId isEqualToString:@"017"]) {//PK拾
		isShuZi = YES;
		
	}
	else {
		isShuZi = NO;
		
	}
    return isShuZi;
}

- (void)clearSaveFunc{
    if (saveKey && [saveKey length] > 0) {
        NSMutableArray * saveArray = [[NSMutableArray alloc] initWithCapacity:0];
        [[NSUserDefaults standardUserDefaults] setValue:saveArray forKey:saveKey];
        [saveArray release];
    }
   

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
- (void)passWordOpenUrl{
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isunDoLongTime"];
    [self send];
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

- (void)send {
    
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isunDoLongTime"] intValue]&&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
        
        if ([self typeFunc]) {
            
            [self sleepPassWordViewShow];
            
            
        }else{
            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertTpye = passWordType;
            alert.tag = 106;
            [alert show];
            [alert release];
            
        }
        
		return;
	}
    [MobClick event:@"event_goucai_hemai_queren" label:[GC_LotteryType lotteryNameWithLotteryID:self.betInfo.lotteryId]];
    if([self.betInfo.lotteryId isEqualToString: @"300"]||[self.betInfo.lotteryId isEqualToString: @"400"]||[self.betInfo.lotteryId isEqualToString: @"301"]||[self.betInfo.lotteryId isEqualToString: @"200"]||[self.betInfo.lotteryId isEqualToString: @"201"]||[self.betInfo.lotteryId isEqualToString: @"202"]){
        
        [self clearSaveFunc];
        
    }
    
    
//	NSLog(@"发起合买请求id %i", reqID_startTogetherBuy);
//    NSLog(@"Hzf SID %@", HzfSID);
//    NSLog(@"彩种 %i", _betInfo.lotteryType);
//    NSLog(@"玩法 %i", _betInfo.modeType);
//    NSLog(@"期号 %@", _betInfo.issue);
//    NSLog(@"投注号码 %@", _betInfo.betNumber);
//    NSLog(@"方案金额（单倍）%i", _betInfo.price);
//    NSLog(@"投注倍数 %i", _betInfo.multiple);
//    NSLog(@"总份数 %i", _betInfo.totalParts);
//    NSLog(@"认购份数 %i", _betInfo.rengouParts);
//    NSLog(@"保底份数 %i", _betInfo.baodiParts);
//    NSLog(@"提成比例 %i", _betInfo.tichengPercentage);
//    NSLog(@"保密类型 %i", _betInfo.secrecyType);
//    NSLog(@"方案截止日期 %@", _betInfo.endTime);
//    NSLog(@"方案标题 %@", _betInfo.schemeTitle);
//    NSLog(@"方案描述 %@", _betInfo.schemeDescription);
//    [infoPlayer stop];
	self.betInfo.totalParts = self.betInfo.payMoney;
    if ([rengouText.text intValue] < (betInfo.payMoney -1)/100 +1) {
        rengouText.text = [NSString stringWithFormat:@"%d",(betInfo.payMoney -1)/100 +1];
    }
	self.betInfo.rengouParts = [rengouText.text intValue];
	self.betInfo.tichengPercentage = [tichengText.text intValue];
	self.betInfo.secrecyType = 1;
	if (baomiSegment.selectIndex == 1) {
		self.betInfo.secrecyType = 2;
	}
    else if (baomiSegment.selectIndex == 2){
        self.betInfo.secrecyType = 3;
    }
	else if (baomiSegment.selectIndex == 3) {
		self.betInfo.secrecyType = 4;
	}
    self.betInfo.baodiParts = [baodiText.text intValue];
//	self.betInfo.issue = @"2012075";
	self.betInfo.schemeTitle = @"";
	self.betInfo.endTime = @"";
	if ([xuanyanText.text length]) {
		self.betInfo.schemeDescription = xuanyanText.text;
	}
	else {
		self.betInfo.schemeDescription = xuanyanText.placeholder;
	}
#ifdef isYueYuBan
    
    if (betInfo.rengouParts + self.betInfo.baodiParts> [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]) {
        
        CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
        aler.tag = 109;
        [aler show];
        [aler release];
        return;
    }
    
    CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:@"是否确定投注" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    aler.tag = 119;
    [aler show];
    [aler release];
#else
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isAlipay"] isEqualToString:@"4"]) {
        if (betInfo.rengouParts + self.betInfo.baodiParts> [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]) {
            
            CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
            aler.tag = 109;
            [aler show];
            [aler release];
            return;
        }
    }else{
        if (betInfo.rengouParts + self.betInfo.baodiParts> [[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]) {
            
            CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
            aler.tag = 109;
            [aler show];
            [aler release];
            return;
        }
    
    }
    
    [self getStartTogetherBuyRequest];
#endif
	
}


- (void)pressaddbuttonone:(UIButton *)sender{
    [self baoMiChange:nil];
    if ([rengouText.text intValue] >= betInfo.payMoney) {
        rengouText.text = [NSString stringWithFormat:@"%d", betInfo.payMoney];
    }else{
        rengouText.text = [NSString stringWithFormat:@"%d", [rengouText.text intValue]+1];
        
    }

    if ([rengouText.text intValue] > betInfo.payMoney) {
        rengouText.text = [NSString stringWithFormat:@"%d", betInfo.payMoney];
    }
    else if ([rengouText.text intValue] < (betInfo.payMoney -1)/100 +1){
        rengouText.text = [NSString stringWithFormat:@"%d", (betInfo.payMoney -1)/100 +1];
    }
    if ([baodiText.text intValue] + [rengouText.text intValue]>betInfo.payMoney) {
        baodiText.text = [NSString stringWithFormat:@"%d",betInfo.payMoney - [rengouText.text intValue]];
        
    }
    baodiLable.text = [NSString stringWithFormat:@"全额保底(%d份)",betInfo.payMoney - [rengouText.text intValue]];
    yingfuLable.text = [NSString stringWithFormat:@"应付<%d>元,余额<%.2f>元",[rengouText.text intValue] + [baodiText.text intValue],[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    yingfuLable.frame = CGRectMake(120  - [rengouText.text length]*5 -[[GC_UserInfo sharedInstance].accountManage.accountBalance length]*5, 80, 300, 30);
}

- (void)pressjianbuttonone:(UIButton *)sender{
    [self baoMiChange:nil];
    if ([rengouText.text intValue] <= (betInfo.payMoney -1)/100 +1) {
        rengouText.text = @"1"; 
    }else{
        rengouText.text = [NSString stringWithFormat:@"%d", [rengouText.text intValue]-1];
    }

    if ([rengouText.text intValue] > betInfo.payMoney) {
        rengouText.text = [NSString stringWithFormat:@"%d", betInfo.payMoney];
    }
    else if ([rengouText.text intValue] < (betInfo.payMoney -1)/100 +1){
        rengouText.text = [NSString stringWithFormat:@"%d", (betInfo.payMoney -1)/100 +1];
    }
    if ([baodiText.text intValue] + [rengouText.text intValue]>betInfo.payMoney) {
        baodiText.text = [NSString stringWithFormat:@"%d",betInfo.payMoney - [rengouText.text intValue]];
        
    }
    baodiLable.text = [NSString stringWithFormat:@"全额保底(%d份)",betInfo.payMoney - [rengouText.text intValue]];
    yingfuLable.text = [NSString stringWithFormat:@"应付<%d>元,余额<%.2f>元",[rengouText.text intValue] + [baodiText.text intValue],[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
    yingfuLable.frame = CGRectMake(120  - [rengouText.text length]*5 -[[GC_UserInfo sharedInstance].accountManage.accountBalance length]*5, 80, 300, 30);
    
     
}

#pragma mark -
#pragma mark action



- (void)doBack {
	[self.navigationController popViewControllerAnimated:YES];
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)resetTitle {
    
    NSLog(@"self.betInfo.lotteryId = %@", self.betInfo.lotteryId);
    
    NSString *caizhong = [GC_LotteryType lotteryNameWithLotteryID:self.betInfo.lotteryId];
    
    if ([self.betInfo.lotteryId isEqualToString: @"001"]) {
        caizhong = @"双色球";
    }else if ([self.betInfo.lotteryId isEqualToString:@"119"]) {
        
        caizhong = @"山东11选5";
    }else if ([self.betInfo.lotteryId isEqualToString: @"113"]) {
        
        caizhong = @"大乐透";
    }else if ([self.betInfo.lotteryId isEqualToString: @"002"]) {
        caizhong = @"福彩3D";
    }else if ([self.betInfo.lotteryId isEqualToString: @"109"]) {
        caizhong = @"排列5";
    }else if ([self.betInfo.lotteryId isEqualToString: @"110"]) {
        caizhong = @"七星彩";
    }else if ([self.betInfo.lotteryId isEqualToString: @"111"]) {
        caizhong = @"22选5";
    }else if ([self.betInfo.lotteryId isEqualToString: @"003"]) {
        
        caizhong = @"七乐彩";
        
    }else if ([self.betInfo.lotteryId isEqualToString: @"006"]) {
        caizhong = @"时时彩";
        
    }else if ([self.betInfo.lotteryId isEqualToString: @"108"]) {
        
        caizhong = @"排列3";
        
    }else if([self.betInfo.lotteryId isEqualToString: @"300"]){
        
        caizhong = @"胜负彩";
        
    }else if([self.betInfo.lotteryId isEqualToString: @"301"]){
        
        caizhong = @"任选九";
        
    }else if([self.betInfo.lotteryId isEqualToString: @"200"]){
        
        caizhong = @"竞彩篮球";
        
    }else if([self.betInfo.lotteryId isEqualToString: @"201"]||[self.betInfo.lotteryId isEqualToString: @"202"]){
        
        caizhong  = @"竞彩足球";
        
    }else if([self.betInfo.lotteryId isEqualToString: @"400"]){
        
        caizhong  = @"单场";
    }else if ([self.betInfo.lotteryId isEqualToString:@"203"]){
        caizhong = @"竞彩篮球";
    }
        
    if([self.betInfo.lotteryId  isEqualToString:@"200"]){
            self.CP_navigation.title = [NSString stringWithFormat:@"%@",caizhong];
    }else if([self.betInfo.lotteryId isEqualToString: @"201"]||[self.betInfo.lotteryId isEqualToString: @"202"]||[self.betInfo.lotteryId isEqualToString: @"203"]){
            self.CP_navigation.title = [NSString stringWithFormat:@"%@",caizhong];
    }else{
            self.CP_navigation.title = [NSString stringWithFormat:@"%@ %@期",caizhong,self.betInfo.issue];
    }
        
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passWordOpenUrl) name:@"passWordOpenUrl" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetPassWord) name:@"resetPassWord" object:nil];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.myTimer invalidate];
//    self.myTimer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"resetPassWord" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"passWordOpenUrl" object:nil];
}

- (void)LoadIpadView {
    back2V = [[UIImageView alloc] initWithFrame:CGRectMake(10 + 35, 10, 300, 350)];
    back2V.image = [UIImageGetImageFromName(@"GC_touzhuback.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [self.mainView addSubview:back2V];
    back2V.userInteractionEnabled = YES;
    [back2V release];
    
    
    UILabel *label2 = [[UILabel alloc] init];
	label2.frame = CGRectMake(15 , 112, 70, 30);
	[back2V addSubview:label2];
    label2.font = [UIFont systemFontOfSize:10];
	label2.text = @"方案宣言";
	label2.backgroundColor = [UIColor clearColor];
	[label2 release];
	
    
    xuanim = [[UIImageView alloc] initWithFrame:CGRectMake(70, 115, 180, 30)];
    [back2V addSubview:xuanim];
    xuanim.userInteractionEnabled = YES;
    xuanim.image = [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [xuanim release];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:xuanim.bounds];
    scrollView.backgroundColor = [UIColor clearColor];
    [xuanim addSubview:scrollView];
    [scrollView release];
    
	xuanyanText = [[UITextField alloc] init];
	xuanyanText.delegate = self;
//    xuanim.hidden = YES;
	xuanyanText.placeholder = @"我出方案你受益，跟的多中的多";
	xuanyanText.frame = scrollView.bounds;
	xuanyanText.font = [UIFont systemFontOfSize:12];
    xuanyanText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	xuanyanText.textAlignment = NSTextAlignmentCenter;
	xuanyanText.backgroundColor = [UIColor clearColor];
    
	[scrollView addSubview:xuanyanText];
	[xuanyanText release];
    
    UIImageView *infoBack = [[UIImageView alloc] initWithFrame:CGRectMake(10, 14, 280, 30)];
    [back2V addSubview:infoBack];
    infoBack.image = [UIImageGetImageFromName(@"XQCYHMTBG960.png") stretchableImageWithLeftCapWidth:20 topCapHeight:10];
    [infoBack release];
    
    UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 105, 280, 2)];
    imageV2.image = UIImageGetImageFromName(@"SZTG960.png");
    [back2V addSubview:imageV2];
    [imageV2 release];
    
    NSString *pay = [NSString stringWithFormat:@"%d",betInfo.payMoney];
	infoLable = [[ColorView alloc] initWithFrame:CGRectMake(65 -[pay length]*10, 2, 300, 25)];
	infoLable.text = [NSString stringWithFormat:@"当前方案共<%d>份，每份<1>元",betInfo.payMoney];
    
	infoLable.backgroundColor = [UIColor clearColor];
	infoLable.font = [UIFont systemFontOfSize:15];
    infoLable.pianyiHeight = 4;
    infoLable.colorfont = [UIFont systemFontOfSize:20];
	infoLable.changeColor = [UIColor redColor];
	[infoBack addSubview:infoLable];
	
	[infoLable release];
	
    UIImageView *rengouBack = [[UIImageView alloc] initWithFrame:CGRectMake(10 , 65, 170, 30)];
    [back2V addSubview:rengouBack];
    rengouBack.userInteractionEnabled = YES;
    rengouBack.image = [UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
    [rengouBack release];
    
    UIImageView *imageV3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 149, 280, 2)];
    imageV3.image = UIImageGetImageFromName(@"SZTG960.png");
    [back2V addSubview:imageV3];
    [imageV3 release];
    
	UILabel *label1 = [[UILabel alloc] init];
	label1.frame = CGRectMake(23, 0, 70, 30);
	[rengouBack addSubview:label1];
	label1.text = @"认购";
    label1.font = [UIFont systemFontOfSize:13];
	label1.backgroundColor = [UIColor clearColor];
	[label1 release];
	
	rengouText = [[UITextField alloc] init];
	rengouText.delegate = self;
	rengouText.text = [NSString stringWithFormat:@"%d", (betInfo.payMoney -1)/100 +1];
	rengouText.keyboardType = UIKeyboardTypeNumberPad;
	rengouText.frame = CGRectMake(60, 3, 60, 20);
	rengouText.textAlignment = NSTextAlignmentCenter;
	rengouText.backgroundColor = [UIColor clearColor];
	[rengouBack addSubview:rengouText];
	[rengouText release];
	
	UILabel *label11 = [[UILabel alloc] init];
	label11.frame = CGRectMake(145, 0, 70, 30);
	[rengouBack addSubview:label11];
	label11.text = @"份";
    label11.font = [UIFont systemFontOfSize:13];
	label11.backgroundColor = [UIColor clearColor];
	[label11 release];
	
    
    
    CP_PTButton *addbutton1 = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    addbutton1.frame = CGRectMake(188, 65, 49, 30);
    [addbutton1 loadButonImage:@"TYD960.png" LabelName:@"+"];
    addbutton1.buttonName.frame = CGRectMake(0, -3, 45, 30);
    addbutton1.buttonName.font = [UIFont systemFontOfSize:28];
    [addbutton1 addTarget:self action:@selector(pressaddbuttonone:) forControlEvents:UIControlEventTouchUpInside];
    
    CP_PTButton *jianbutton1 = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    jianbutton1.frame = CGRectMake(240, 65, 49, 30);
    [jianbutton1 loadButonImage:@"TYD960.png" LabelName:@"-"];
    jianbutton1.buttonName.frame = CGRectMake(0, -3, 45, 30);
    jianbutton1.buttonName.font = [UIFont systemFontOfSize:28];
    [jianbutton1 addTarget:self action:@selector(pressjianbuttonone:) forControlEvents:UIControlEventTouchUpInside];
    [back2V addSubview:addbutton1];
    [back2V addSubview:jianbutton1];
	
	baomiSegment = [[CP_UISegement alloc] initWithItems:[NSArray arrayWithObjects:@"公开",@"保密",@"截止后公开",@"跟单公开",nil]];
    [baomiSegment setBackgroudImage:[UIImageGetImageFromName(@"XQCYHMTBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
	baomiSegment.frame = CGRectMake(10 , 160, 280, 31);
    baomiSegment.delegate = self;
    if (betInfo.baomiType == 0) {
        baomiSegment.selectIndex = 0;
        self.betInfo.secrecyType = 1;
    }
    else if (betInfo.baomiType == 1) {
        baomiSegment.selectIndex = 1;
        self.betInfo.secrecyType = 2;
    }
    else if (betInfo.baomiType == 2){
        baomiSegment.selectIndex = 2;
        self.betInfo.secrecyType = 3;
    }
    else if (betInfo.baomiType == 4) {
        baomiSegment.selectIndex = 1;
        self.betInfo.secrecyType = 2;
        betInfo.baomiType = 1;
    }
	[back2V addSubview:baomiSegment];
    
    UIImageView *imageV4 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 196, 280, 2)];
    imageV4.image = UIImageGetImageFromName(@"SZTG960.png");
    [back2V addSubview:imageV4];
    [imageV4 release];
    
    
	[baomiSegment release];
	
    UIImageView *shuiBack = [[UIImageView alloc] initWithFrame:CGRectMake(10, 202, 170, 30)];
    [back2V addSubview:shuiBack];
    shuiBack.image = [UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
    [shuiBack release];
    
    UIImageView *imageV5 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 237, 280, 2)];
    imageV5.image = UIImageGetImageFromName(@"SZTG960.png");
    [back2V addSubview:imageV5];
    [imageV5 release];
    
	UILabel *label4 = [[UILabel alloc] init];
	label4.frame = CGRectMake(15 , 202, 80, 30);
	[back2V addSubview:label4];
    label4.font = [UIFont systemFontOfSize:13];
	label4.text = @"税后提成";
	label4.backgroundColor = [UIColor clearColor];
	[label4 release];
	
	tichengText = [[UITextField alloc] init];
	tichengText.delegate = self;
	
	tichengText.text = @"0";
	tichengText.font = [UIFont systemFontOfSize:14];
	tichengText.frame = CGRectMake(70, 208, 40, 20);
	tichengText.keyboardType = UIKeyboardTypeNumberPad;
	tichengText.textAlignment = NSTextAlignmentCenter;
	tichengText.backgroundColor = [UIColor clearColor];
	[back2V addSubview:tichengText];
	[tichengText release];
	
	UILabel *label41 = [[UILabel alloc] init];
	label41.frame = CGRectMake(140, 202, 30, 30);
	[back2V addSubview:label41];
	label41.text = @"%";
	label41.backgroundColor = [UIColor clearColor];
	[label41 release];
    
    CP_PTButton *addbutton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    addbutton.frame = CGRectMake(188, 201, 49, 29);
    [addbutton loadButonImage:@"TYD960.png" LabelName:@"+"];
    addbutton.buttonName.frame = CGRectMake(0, -3, 45, 30);
    addbutton.buttonName.font = [UIFont systemFontOfSize:28];
    [addbutton addTarget:self action:@selector(pressaddbutton:) forControlEvents:UIControlEventTouchUpInside];
    
    CP_PTButton *jianbutton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    jianbutton.frame = CGRectMake(240, 201, 49, 29);
    [jianbutton loadButonImage:@"TYD960.png" LabelName:@"-"];
    jianbutton.buttonName.frame = CGRectMake(0, -3, 45, 30);
    jianbutton.buttonName.font = [UIFont systemFontOfSize:28];
    [jianbutton addTarget:self action:@selector(pressjianbutton:) forControlEvents:UIControlEventTouchUpInside];
    [back2V addSubview:addbutton];
    [back2V addSubview:jianbutton];
    
    
    UIImageView *baodiBack = [[UIImageView alloc] initWithFrame:CGRectMake(10, 245, 197, 30)];
    [back2V addSubview:baodiBack];
    baodiBack.image = [UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
    [baodiBack release];
    
	UILabel *label5 = [[UILabel alloc] init];
	label5.frame = CGRectMake(15 , 250, 70, 20);
	[back2V addSubview:label5];
    label5.font = [UIFont systemFontOfSize:13];
	label5.text = @"保底";
	label5.backgroundColor = [UIColor clearColor];
	[label5 release];
	
	baodiText = [[UITextField alloc] init];
	baodiText.text = @"0";
	baodiText.delegate = self;
    
	baodiText.frame = CGRectMake(30, 250, 130, 20);
	baodiText.keyboardType = UIKeyboardTypeNumberPad;
	baodiText.textAlignment = NSTextAlignmentCenter;
	baodiText.backgroundColor = [UIColor clearColor];
	[back2V addSubview:baodiText];
	[baodiText release];
	
	UILabel *label51 = [[UILabel alloc] init];
	label51.frame = CGRectMake(180, 250, 30, 20);
	[back2V addSubview:label51];
	label51.text = @"份";
    label51.font = [UIFont systemFontOfSize:13];
	label51.backgroundColor = [UIColor clearColor];
	[label51 release];
	
	baodiBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
	baodiBtn.frame = CGRectMake(217, 243, 73, 30);
	[back2V addSubview:baodiBtn];
	[baodiBtn addTarget:self action:@selector(quanerbaodi) forControlEvents:UIControlEventTouchUpInside];
	[baodiBtn loadButonImage:@"FQHMAN960.png" LabelName:[NSString stringWithFormat:@"全额保底"]];
    baodiBtn.buttonName.font = [UIFont systemFontOfSize:14];
	
    UIImageView *yinfuBack = [[UIImageView alloc] initWithFrame:CGRectMake(10, 304, 280, 30)];
    [back2V addSubview:yinfuBack];
    yinfuBack.image = [UIImageGetImageFromName(@"XQCYHMTBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
    [yinfuBack release];
    
    
    
	yingfuLable = [[ColorView alloc] initWithFrame:CGRectMake(120  - [rengouText.text length]*5 -[[GC_UserInfo sharedInstance].accountManage.accountBalance length]*5, 308, 200, 20)];
	yingfuLable.text = [NSString stringWithFormat:@"应付<%@>元,余额<%.2f>元",rengouText.text,[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
	yingfuLable.backgroundColor = [UIColor clearColor];
	yingfuLable.font = [UIFont systemFontOfSize:13];
    yingfuLable.colorfont =  [UIFont systemFontOfSize:15];
	yingfuLable.changeColor = [UIColor redColor];
	[back2V addSubview:yingfuLable];
	
	[yingfuLable release];
	
    
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 748 - 88, 390, 44)];
	[self.mainView addSubview:im];
    im.userInteractionEnabled = YES;
	im.image = UIImageGetImageFromName(@"XDH960.png");
	
	
	sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
	sendBtn.frame = CGRectMake(120 + 35, 8, 80, 30);
    
    UILabel * buttonLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    buttonLabel1.text = @"发起";
    buttonLabel1.textAlignment = NSTextAlignmentCenter;
    buttonLabel1.backgroundColor = [UIColor clearColor];
    buttonLabel1.textColor = [UIColor colorWithRed:25/255.0 green:114/255.0 blue:176/255.0 alpha:1];
    buttonLabel1.font = [UIFont boldSystemFontOfSize:13];
	[sendBtn addSubview:buttonLabel1];
    [buttonLabel1 release];
	[im addSubview:sendBtn];
	
	UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn2 addTarget:self action:@selector(wanfaInfo) forControlEvents:UIControlEventTouchUpInside];
	btn2.frame = CGRectMake(280 +35, 10, 30, 30);
	[btn2 setImage:UIImageGetImageFromName(@"GC_icon8.png") forState:UIControlStateNormal];
	
	[im addSubview:btn2];
    [im release];
}

- (void)LoadIphoneView {
//    back2V = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 350)];
    back2V = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 350+100)];
//    back2V.image = [UIImageGetImageFromName(@"GC_touzhuback.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    back2V.backgroundColor=[UIColor clearColor];
    [self.mainView addSubview:back2V];
    back2V.userInteractionEnabled = YES;
    [back2V release];
    
    UIImageView *rengouBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 75+35, 320, 105)];
    [back2V addSubview:rengouBack];
    rengouBack.userInteractionEnabled = YES;
    //    rengouBack.image = [UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
    rengouBack.backgroundColor=[UIColor whiteColor];
    [rengouBack release];
    
    
    UILabel *label2 = [[UILabel alloc] init];
//	label2.frame = CGRectMake(25 - 10, 125 - 10, 70, 30);
    label2.frame = CGRectMake(15, 170, 70, 30);
	[back2V addSubview:label2];
    label2.font = [UIFont systemFontOfSize:15];
	label2.text = @"方案宣言";
	label2.backgroundColor = [UIColor clearColor];
	[label2 release];
	
    
     xuanim = [[UIImageView alloc] initWithFrame:CGRectMake(80, 170, 225, 30)];
    [back2V addSubview:xuanim];
    xuanim.userInteractionEnabled = YES;

    xuanim.image = [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [xuanim release];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:xuanim.bounds];
    scrollView.backgroundColor = [UIColor clearColor];
    [xuanim addSubview:scrollView];
    [scrollView release];
    
	xuanyanText = [[UITextField alloc] init];
	xuanyanText.delegate = self;
//    xuanim.hidden = YES;
	xuanyanText.placeholder = @"我出方案你受益，跟的多中的多";
	xuanyanText.frame = scrollView.bounds;
	xuanyanText.font = [UIFont systemFontOfSize:12];
    xuanyanText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	xuanyanText.textAlignment = NSTextAlignmentCenter;
	xuanyanText.backgroundColor = [UIColor clearColor];

	[scrollView addSubview:xuanyanText];
	[xuanyanText release];
	
    
//    UIImageView *infoBack = [[UIImageView alloc] initWithFrame:CGRectMake(20 - 10, 24 - 10, 280, 30)];
    UIImageView *infoBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 75)];
    [back2V addSubview:infoBack];
//    infoBack.image = [UIImageGetImageFromName(@"XQCYHMTBG960.png") stretchableImageWithLeftCapWidth:20 topCapHeight:10];
    infoBack.backgroundColor=[UIColor whiteColor];
    [infoBack release];
    
//    UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(20 - 10, 115 - 10, 280, 2)];
//    imageV2.image = UIImageGetImageFromName(@"SZTG960.png");
//    [back2V addSubview:imageV2];
//    [imageV2 release];
    
    NSString *pay = [NSString stringWithFormat:@"%d",betInfo.payMoney];
//	infoLable = [[ColorView alloc] initWithFrame:CGRectMake(75-[pay length]*10, 2, 300, 25)];
    infoLable = [[ColorView alloc] initWithFrame:CGRectMake(65-[pay length]*10, 20, 320, 75)];
	infoLable.text = [NSString stringWithFormat:@"当前方案共<%d>份，每份<1>元",betInfo.payMoney];
    
	infoLable.backgroundColor = [UIColor clearColor];
	infoLable.font = [UIFont systemFontOfSize:18];
//    infoLable.pianyiHeight = 4;
    infoLable.colorfont = [UIFont systemFontOfSize:24];
	infoLable.changeColor = [UIColor redColor];
	[infoBack addSubview:infoLable];
	
	[infoLable release];

	
//    UIImageView *rengouBack = [[UIImageView alloc] initWithFrame:CGRectMake(20 - 10, 75 -10, 170, 30)];
//    UIImageView *rengouBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 75+35, 320, 105)];
//    [back2V addSubview:rengouBack];
//    rengouBack.userInteractionEnabled = YES;
////    rengouBack.image = [UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
//    rengouBack.backgroundColor=[UIColor whiteColor];
//    [rengouBack release];
    
//    UIImageView *imageV3 = [[UIImageView alloc] initWithFrame:CGRectMake(20 - 10, 159 - 10, 280, 2)];
//    imageV3.image = UIImageGetImageFromName(@"SZTG960.png");
//    [back2V addSubview:imageV3];
//    [imageV3 release];
    
    UIImageView *rengouIma=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 175, 30)];
    rengouIma.image=[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
    [rengouBack addSubview:rengouIma];
    [rengouIma release];
    
	UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(23, 15, 70, 30);
	[rengouBack addSubview:label1];
	label1.text = @"认购";
    label1.font = [UIFont systemFontOfSize:13];
	label1.backgroundColor = [UIColor clearColor];
	[label1 release];
	
	rengouText = [[UITextField alloc] init];
	rengouText.delegate = self;
	rengouText.text = [NSString stringWithFormat:@"%d", (betInfo.payMoney -1)/100 +1];
	rengouText.keyboardType = UIKeyboardTypeNumberPad;
	rengouText.frame = CGRectMake(40, 20, 130, 20);
	rengouText.textAlignment = NSTextAlignmentCenter;
	rengouText.backgroundColor = [UIColor clearColor];
	[rengouBack addSubview:rengouText];
	[rengouText release];
	
	UILabel *label11 = [[UILabel alloc] init];
	label11.frame = CGRectMake(165, 15, 70, 30);
	[rengouBack addSubview:label11];
	label11.text = @"份";
    label11.font = [UIFont systemFontOfSize:13];
	label11.backgroundColor = [UIColor clearColor];
	[label11 release];
	
    
    
    CP_PTButton *addbutton1 = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//    addbutton1.frame = CGRectMake(198 - 10, 75 - 10, 49, 30);
    addbutton1.frame = CGRectMake(205, 110+15, 49, 30);
//    [addbutton1 loadButonImage:@"TYD960.png" LabelName:@"+"];
    [addbutton1 loadButonImage:@"zhuihaojia_normal.png" LabelName:nil];
    addbutton1.buttonName.frame = CGRectMake(0, -3, 45, 30);
    addbutton1.buttonName.font = [UIFont systemFontOfSize:28];
    [addbutton1 addTarget:self action:@selector(pressaddbuttonone:) forControlEvents:UIControlEventTouchUpInside];
    
    CP_PTButton *jianbutton1 = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//    jianbutton1.frame = CGRectMake(250 - 10, 75 - 10, 49, 30);
    jianbutton1.frame = CGRectMake(256, 110+15, 49, 30);
//    [jianbutton1 loadButonImage:@"TYD960.png" LabelName:@"-"];
    [jianbutton1 loadButonImage:@"zhuihaojian_normal.png" LabelName:nil];
    jianbutton1.buttonName.frame = CGRectMake(0, -3, 45, 30);
    jianbutton1.buttonName.font = [UIFont systemFontOfSize:28];
    [jianbutton1 addTarget:self action:@selector(pressjianbuttonone:) forControlEvents:UIControlEventTouchUpInside];
    [back2V addSubview:addbutton1];
    [back2V addSubview:jianbutton1];
	
	baomiSegment = [[CP_UISegement alloc] initWithItems:[NSArray arrayWithObjects:@"公开",@"保密",@"截止后公开",@"跟单公开",nil]];
//    [baomiSegment setBackgroudImage:[UIImageGetImageFromName(@"XQCYHMTBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
    [baomiSegment setBackgroudImage:UIImageGetImageFromName(@"SegementBG.png")];
//	baomiSegment.frame = CGRectMake(20 - 10, 170 - 10, 280, 31);
    baomiSegment.frame = CGRectMake((back2V.frame.size.width - 260)/2, 110+105+10, 260, 40);
    baomiSegment.delegate = self;
    if (betInfo.baomiType == 0) {
        baomiSegment.selectIndex = 0;
        self.betInfo.secrecyType = 1;
    }
    else if (betInfo.baomiType == 1) {
        baomiSegment.selectIndex = 1;
        self.betInfo.secrecyType = 2;
    }
    else if (betInfo.baomiType == 2){
        baomiSegment.selectIndex = 2;
        self.betInfo.secrecyType = 3;
    }
    else if (betInfo.baomiType == 4) {
        baomiSegment.selectIndex = 1;
        self.betInfo.secrecyType = 2;
        betInfo.baomiType = 1;
    }
	[back2V addSubview:baomiSegment];
    
//    UIImageView *imageV4 = [[UIImageView alloc] initWithFrame:CGRectMake(20 - 10, 206 - 10, 280, 2)];
//    imageV4.image = UIImageGetImageFromName(@"SZTG960.png");
//    [back2V addSubview:imageV4];
//    [imageV4 release];
    
	[baomiSegment release];
    
    UIImageView *shuiIma = [[UIImageView alloc] initWithFrame:CGRectMake(0, 275, 320, 105)];
    [back2V addSubview:shuiIma];
    shuiIma.userInteractionEnabled = YES;
    //    rengouBack.image = [UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
    shuiIma.backgroundColor=[UIColor whiteColor];
    [shuiIma release];
	
//    UIImageView *shuiBack = [[UIImageView alloc] initWithFrame:CGRectMake(20 - 10, 212 - 10, 170, 30)];
    UIImageView *shuiBack = [[UIImageView alloc] initWithFrame:CGRectMake(15, 290, 175, 30)];
    [back2V addSubview:shuiBack];
//    shuiBack.image = [UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
    shuiBack.image = [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
    [shuiBack release];
    
//    UIImageView *imageV5 = [[UIImageView alloc] initWithFrame:CGRectMake(20 - 10, 247 - 10, 280, 2)];
//    UIImageView *imageV5 = [[UIImageView alloc] initWithFrame:CGRectMake(20 - 10, 247 - 10+50+50, 280, 2)];
//    imageV5.image = UIImageGetImageFromName(@"SZTG960.png");
//    [back2V addSubview:imageV5];
//    [imageV5 release];
    
	UILabel *label4 = [[UILabel alloc] init];
//	label4.frame = CGRectMake(25 - 10, 212 - 10, 70, 30);
    label4.frame = CGRectMake(20, 290, 70, 30);
	[back2V addSubview:label4];
    label4.font = [UIFont systemFontOfSize:15];
	label4.text = @"税后提成";
	label4.backgroundColor = [UIColor clearColor];
	[label4 release];
	
	tichengText = [[UITextField alloc] init];
	tichengText.delegate = self;
	
	tichengText.text = @"0";
	tichengText.font = [UIFont systemFontOfSize:15];
//	tichengText.frame = CGRectMake(80 - 10, 218 - 10, 40, 20);(40, 340, 130, 20)
    tichengText.frame = CGRectMake(50, 295, 130, 20);

	tichengText.keyboardType = UIKeyboardTypeNumberPad;
	tichengText.textAlignment = NSTextAlignmentCenter;
	tichengText.backgroundColor = [UIColor clearColor];
	[back2V addSubview:tichengText];
	[tichengText release];
	
	UILabel *label41 = [[UILabel alloc] init];
//	label41.frame = CGRectMake(150 - 10, 212 - 10, 30, 30);
    label41.frame = CGRectMake(165, 290, 30, 30);
	[back2V addSubview:label41];
	label41.text = @"%";
    label41.font=[UIFont systemFontOfSize:15];
	label41.backgroundColor = [UIColor clearColor];
	[label41 release];
    
    CP_PTButton *addbutton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//    addbutton.frame = CGRectMake(198 - 10, 211 - 10, 49, 29);
    addbutton.frame = CGRectMake(205, 290, 49, 30);
//    [addbutton loadButonImage:@"TYD960.png" LabelName:@"+"];
    [addbutton loadButonImage:@"zhuihaojia_normal.png" LabelName:nil];
    addbutton.buttonName.frame = CGRectMake(0, -3, 45, 30);
    addbutton.buttonName.font = [UIFont systemFontOfSize:28];
    [addbutton addTarget:self action:@selector(pressaddbutton:) forControlEvents:UIControlEventTouchUpInside];
    
    CP_PTButton *jianbutton = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//    jianbutton.frame = CGRectMake(250 - 10, 211 - 10, 49, 29);
    jianbutton.frame = CGRectMake(256, 290, 49, 30);
//    [jianbutton loadButonImage:@"TYD960.png" LabelName:@"-"];
    [jianbutton loadButonImage:@"zhuihaojian_normal.png" LabelName:nil];
    jianbutton.buttonName.frame = CGRectMake(0, -3, 45, 30);
    jianbutton.buttonName.font = [UIFont systemFontOfSize:28];
    [jianbutton addTarget:self action:@selector(pressjianbutton:) forControlEvents:UIControlEventTouchUpInside];
    [back2V addSubview:addbutton];
    [back2V addSubview:jianbutton];
    
    
//    UIImageView *baodiBack = [[UIImageView alloc] initWithFrame:CGRectMake(20 - 10, 255 - 10, 197, 30)];
    UIImageView *baodiBack = [[UIImageView alloc] initWithFrame:CGRectMake(15, 335, 175, 30)];
    [back2V addSubview:baodiBack];
//    baodiBack.image = [UIImageGetImageFromName(@"TXWZBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
    baodiBack.image = [UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
    [baodiBack release];
    
	UILabel *label5 = [[UILabel alloc] init];
//	label5.frame = CGRectMake(25 - 10, 260 - 10, 70, 20);
    label5.frame = CGRectMake(20, 340, 70, 20);
	[back2V addSubview:label5];
    label5.font = [UIFont systemFontOfSize:15];
	label5.text = @"保底";
	label5.backgroundColor = [UIColor clearColor];
	[label5 release];
	
	baodiText = [[UITextField alloc] init];
	baodiText.text = @"0";
	baodiText.delegate = self;
    baodiText.font=[UIFont systemFontOfSize:15];
//	baodiText.frame = CGRectMake(40 - 10, 260 - 10, 130, 20);
    baodiText.frame = CGRectMake(50, 340, 130, 20);
	baodiText.keyboardType = UIKeyboardTypeNumberPad;
	baodiText.textAlignment = NSTextAlignmentCenter;
	baodiText.backgroundColor = [UIColor clearColor];
	[back2V addSubview:baodiText];
	[baodiText release];
	
	UILabel *label51 = [[UILabel alloc] init];
//	label51.frame = CGRectMake(190 - 10, 260 - 10, 30, 20);
    label51.frame = CGRectMake(165, 340, 30, 20);
	[back2V addSubview:label51];
	label51.text = @"份";
    label51.font = [UIFont systemFontOfSize:15];
	label51.backgroundColor = [UIColor clearColor];
	[label51 release];
	
	baodiBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//	baodiBtn.frame = CGRectMake(227 - 10, 253 - 10, 73, 30);
    baodiBtn.frame = CGRectMake(205, 335, 100, 30);
	[back2V addSubview:baodiBtn];
	[baodiBtn addTarget:self action:@selector(quanerbaodi) forControlEvents:UIControlEventTouchUpInside];
//	[baodiBtn loadButonImage:@"FQHMAN960.png" LabelName:[NSString stringWithFormat:@"全额保底"]];
    [baodiBtn loadButonImage:nil LabelName:[NSString stringWithFormat:@"全额保底"]];
    baodiBtn.backgroundColor=[UIColor colorWithRed:255/255.0 green:200/255.0 blue:50/255.0 alpha:1];
    baodiBtn.layer.masksToBounds=YES;
    baodiBtn.layer.cornerRadius=5.0;
    baodiBtn.buttonName.font = [UIFont systemFontOfSize:14];
    
	
//    UIImageView *yinfuBack = [[UIImageView alloc] initWithFrame:CGRectMake(20 - 10, 314 - 10, 280, 30)];
//    [back2V addSubview:yinfuBack];
//    yinfuBack.image = [UIImageGetImageFromName(@"XQCYHMTBG960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:10];
//    [yinfuBack release];
    
    
    
//	yingfuLable = [[ColorView alloc] initWithFrame:CGRectMake(150 - 10 - [rengouText.text length]*10 -[[GC_UserInfo sharedInstance].accountManage.accountBalance length]*10, 318 - 10, 200, 20)];
//	yingfuLable.text = [NSString stringWithFormat:@"应付<%@>元,余额<%.2f>元",rengouText.text,[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
//	yingfuLable.backgroundColor = [UIColor clearColor];
//	yingfuLable.font = [UIFont systemFontOfSize:13];
//    yingfuLable.colorfont =  [UIFont systemFontOfSize:15];
//	yingfuLable.changeColor = [UIColor redColor];
//	[back2V addSubview:yingfuLable];
//	
//	[yingfuLable release];
    

    yingfuLable = [[ColorView alloc] initWithFrame:CGRectMake(110  - [rengouText.text length]*5 -[[GC_UserInfo sharedInstance].accountManage.accountBalance length]*5, 75+5, 300, 30)];

	yingfuLable.text = [NSString stringWithFormat:@"应付<%@>元,余额<%.2f>元",rengouText.text,[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
	yingfuLable.backgroundColor = [UIColor clearColor];
	yingfuLable.font = [UIFont systemFontOfSize:15];
    yingfuLable.colorfont =  [UIFont systemFontOfSize:18];
	yingfuLable.changeColor = [UIColor redColor];
	[back2V addSubview:yingfuLable];
	
	[yingfuLable release];
    
//    NSLog(@"%f,%f",yingfuLable.frame.origin.x,yingfuLable.frame.size.width);
//    NSLog(@"%@,%d",rengouText.text,rengouText.text.length);
//    NSLog(@"%@,%d",[GC_UserInfo sharedInstance].accountManage.accountBalance,[GC_UserInfo sharedInstance].accountManage.accountBalance.length);
	
    
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.bounds.size.height -44, 320, 44)];
	[self.mainView addSubview:im];
    im.userInteractionEnabled = YES;
//	im.image = UIImageGetImageFromName(@"XDH960.png");
    im.backgroundColor=[UIColor blackColor];
	
	
	sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
//    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
	sendBtn.frame = CGRectMake(120, 8, 80, 30);
    UILabel * buttonLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    buttonLabel1.text = @"发起";
    buttonLabel1.textAlignment = NSTextAlignmentCenter;
    buttonLabel1.backgroundColor = [UIColor clearColor];
//    buttonLabel1.textColor = [UIColor colorWithRed:25/255.0 green:114/255.0 blue:176/255.0 alpha:1];
    buttonLabel1.textColor=[UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    buttonLabel1.font = [UIFont boldSystemFontOfSize:18];
	[sendBtn addSubview:buttonLabel1];
    [buttonLabel1 release];
	[im addSubview:sendBtn];
	
	UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn2 addTarget:self action:@selector(wanfaInfo) forControlEvents:UIControlEventTouchUpInside];
	btn2.frame = CGRectMake(280, 10, 30, 30);
	[btn2 setImage:UIImageGetImageFromName(@"GC_icon8.png") forState:UIControlStateNormal];
	
	[im addSubview:btn2];
    [im release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = left;

//    [self recoderPrepare];

    
//	UIImageView *backImageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"login_bgn.png")];
    UIImageView *backImageV = [[UIImageView alloc] init];
    backImageV.backgroundColor=[UIColor clearColor];
	backImageV.frame = self.mainView.bounds;
	[self.mainView addSubview:backImageV];
	[backImageV release];
    self.mainView.backgroundColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
#ifdef isCaiPiaoForIPad
    [self LoadIpadView];
#else
    [self LoadIphoneView];
#endif
    [self resetTitle];
	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [buyResult release];
//    [avRecorder release];
    [httpRequest clearDelegatesAndCancel];
	[httpRequest release];
	[betInfo release];
//    [infoPlayer stop];
//    [infoPlayer release];
    self.syscurIssre = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BecomeActive" object:nil];
    [super dealloc];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
	return YES;
}
// 监听用户输入；改变字数限制提示
//- (void)textViewDidChange:(UITextView *)textView{
//    NSLog(@"textview = %@", textView.text);
//    NSLog(@"zifulong = %d", [xuanyanText.text zifuLong]);
//    if ([xuanyanText.text zifuLong] > 40) {//
//        
//        for (int i = 0; i < [xuanyanText.text length]; i++) {
//            NSString * stringstr = [xuanyanText.text substringToIndex:[xuanyanText.text length]-i];
//            if ([stringstr zifuLong] <= 40) {
//                = stringstr;
//                return;
//            }
//        }
//        // myTextView.text = [myTextView.text substringToIndex:14];
//    }
//    
//}
- (void)jiantingzishu{
    
    if ([xuanyanText.text zifuLong] > 400) {//
        
        for (int i = 0; i < [xuanyanText.text length]; i++) {
            NSString * stringstr = [xuanyanText.text substringToIndex:[xuanyanText.text length]-i];
            if ([stringstr zifuLong] <= 400) {
                xuanyanText.text = stringstr;
                return;
            }
        }
        // myTextView.text = [myTextView.text substringToIndex:14];
    }
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [self performSelector:@selector(jiantingzishu) withObject:self afterDelay:0.2];
    if ([textField isEqual:rengouText] && rengouText.frame.size.width == 60) {

        textField.delegate = self;
        rengouText.text = string;
        rengouText.frame = CGRectMake(60, 3, 61, 20);
        return NO;
    }
    if ([string length] > 0) {
        if (textField == rengouText) {
            if ([[NSString stringWithFormat:@"%@%@",rengouText.text,string] intValue] > betInfo.payMoney) {
                
                return NO;
            }
            else if ([textField.text isEqualToString:@"0"]) {
                textField.text = @"";
            }
        }
        else if (textField == baodiText ) {
            if ([[NSString stringWithFormat:@"%@%@",baodiText.text,string] intValue] + [rengouText.text intValue]>betInfo.payMoney) {
                return NO;
            }
            else if ([textField.text isEqualToString:@"0"]) {
                textField.text = @"";
            }
        }
        else if (textField == tichengText) {
            if ([[NSString stringWithFormat:@"%@%@",tichengText.text,string] intValue] > 10) {
                return  NO;
            }
            else if ([textField.text isEqualToString:@"0"]) {
                textField.text = @"";
            }
        }
    }
    
    
        return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (xuanyanText != textField && rengouText != textField) {
#ifdef isCaiPiaoForIPad
        back2V.frame = CGRectMake(10 + 35, 10 - 88, 300, 350);
        self.mainView.layer.masksToBounds = YES;
#else
        self.mainView.frame = CGRectMake(0, -44, 320, self.mainView.bounds.size.height);
#endif
        
    }
	
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
#ifdef isCaiPiaoForIPad
    back2V.frame = CGRectMake(10 + 35, 10, 300, 350);
#else
    self.mainView.frame = CGRectMake(0, 44 + self.isIOS7Pianyi, 320, self.mainView.bounds.size.height);
#endif
	if (textField == xuanyanText) {
        if ([xuanyanText.text sizeWithFont:xuanyanText.font].width < 225) {
                        xuanyanText.frame = CGRectMake(0, 0, 225, xuanyanText.frame.size.height);
        }
        else {
            xuanyanText.frame = CGRectMake(0, 0, [xuanyanText.text sizeWithFont:xuanyanText.font].width, xuanyanText.frame.size.height);
        }
    UIScrollView *scr = (UIScrollView *)[xuanyanText superview];
    if ([scr isKindOfClass:[UIScrollView class]]) {
        scr.contentSize = CGSizeMake(xuanyanText.bounds.size.width, xuanyanText.bounds.size.height);
    }
    }
	if (textField == rengouText) {
		if ([rengouText.text intValue] > betInfo.payMoney) {
			rengouText.text = [NSString stringWithFormat:@"%d", betInfo.payMoney];
		}
		else if ([rengouText.text intValue] < (betInfo.payMoney -1)/100 +1){
			rengouText.text = [NSString stringWithFormat:@"%d", (betInfo.payMoney -1)/100 +1];
		}
		if ([baodiText.text intValue] + [rengouText.text intValue]>betInfo.payMoney) {
			baodiText.text = [NSString stringWithFormat:@"%d",betInfo.payMoney - [rengouText.text intValue]];
			
		}
		baodiLable.text = [NSString stringWithFormat:@"全额保底(%d份)",betInfo.payMoney - [rengouText.text intValue]];
		yingfuLable.text = [NSString stringWithFormat:@"应付<%d>元,余额<%.2f>元",[rengouText.text intValue] + [baodiText.text intValue],[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
        yingfuLable.frame = CGRectMake(120  - [rengouText.text length]*5 -[[GC_UserInfo sharedInstance].accountManage.accountBalance length]*5, 80, 300, 30);
	}
	
	if (textField == tichengText) {
		if ([tichengText.text intValue] > 10) {
			tichengText.text = @"10";
		}
	}
	if (textField == baodiText) {
		if ([baodiText.text intValue] + [rengouText.text intValue]>betInfo.payMoney) {
			baodiText.text = [NSString stringWithFormat:@"%d",betInfo.payMoney - [rengouText.text intValue]];
		}
		yingfuLable.text = [NSString stringWithFormat:@"应付<%d>元,余额<%.2f>元",[rengouText.text intValue] + [baodiText.text intValue],[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
        yingfuLable.frame = CGRectMake(120  - [rengouText.text length]*5 -[[GC_UserInfo sharedInstance].accountManage.accountBalance length]*5, 80, 300, 30);
	}
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

//充值请求
- (void)returnSysTime:(ASIHTTPRequest *)mrequest{
    
    if ([mrequest responseData]) {
        //	GC_PersonalData *personalData = [[GC_PersonalData alloc] initWithResponseData:[mrequest responseData]];
        ChongZhiData * chongzhi = [[ChongZhiData alloc] initWithResponseData:[mrequest responseData] WithRequest:mrequest];
        NSLog(@"systime = %@", chongzhi.systime);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
        [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime] afterDelay:1];
        [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] reChangeUrlSysTime:chongzhi.systime]];
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

//投注成功回调
- (void)CP_TouZhuAlert:(CP_TouZhuAlert *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
        info.nikeName = [[Info getInstance] nickName] ;
        info.canBack = self.isPutong;
        info.title = @"投注详情";
        info.orderId = chooseView.buyResult.number;
        info.issure = self.betInfo.issue;
        [self.navigationController pushViewController:info animated:YES];
        [info release];
    }
    
    [self requestFangChenMi];


}
//防沉迷弹窗
-(void)showFangChenMiText:(NSString *)_text andImageNum:(int)_imgNum
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

- (void)selectIndexChangde:(CP_UISegement *)cpsegement {
    if (baomiSegment.selectIndex == 0) {
        self.betInfo.secrecyType = 1;
        self.betInfo.baomiType = 0;
    }
    else if (baomiSegment.selectIndex == 1) {
        self.betInfo.secrecyType = 2;
        self.betInfo.baomiType = 1;
    }
    else if (baomiSegment.selectIndex == 2){
        self.betInfo.secrecyType = 3;
        self.betInfo.baomiType = 2;
    }
    else if (baomiSegment.selectIndex == 3) {
        self.betInfo.secrecyType = 4;
        self.betInfo.baomiType = 1;
    }
}

#pragma mark -
#pragma mark CP_UIAlertViewDelegate
- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 109) {
        if (buttonIndex == 1) {
//            #ifdef isYueYuBan
//            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isAlipay"] isEqualToString:@"4"]) {
//                GC_UPMPViewController * upmpView = [[GC_UPMPViewController alloc] init];
//                upmpView.chongZhiType = ChongZhiTypeZhiFuBao;
//                [self.navigationController pushViewController:upmpView animated:YES];
//                [upmpView release];
//            }else{
                GC_TopUpViewController * toUp = [[GC_TopUpViewController alloc] init];
                [self.navigationController pushViewController:toUp animated:YES];
                [toUp release];
//            }
//#else
//            NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
//            
//            [httpRequest clearDelegatesAndCancel];
//            self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
//            [httpRequest setRequestMethod:@"POST"];
//            [httpRequest addCommHeaders];
//            [httpRequest setPostBody:postData];
//            [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//            [httpRequest setDelegate:self];
//            [httpRequest setDidFinishSelector:@selector(returnSysTime:)];
//            [httpRequest startSynchronous];
//
//#endif
            
        }
    }
    
    else if (alertView.tag == 102) {
        if (buttonIndex == 1) {
            
            ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
            info.canBack = self.isPutong;
            info.issure = self.betInfo.issue;
            info.nikeName = [[Info getInstance] nickName] ;

            info.title = @"投注详情";
            [self.navigationController pushViewController:info animated:YES];
            [info release];
        }
        
 
        [self requestFangChenMi];
    }

    else if (alertView.tag == 104) {
        if (buttonIndex == 1) {
            self.betInfo.issue = self.syscurIssre;
            [self getStartTogetherBuyRequest];
        }
    }
    else if (alertView.tag == 105) {
        if (buttonIndex == 1) {
            [[Info getInstance] setCaipaocount:[[Info getInstance] caipaocount]+ 1];
            [self getStartTogetherBuyRequest];
        }
            
    }
    else if (alertView.tag == 1234){

    }
    else if (alertView.tag == 119) {
        if (buttonIndex == 1) {
            [self getStartTogetherBuyRequest];
        }
        
    }
//    else if (alertView.tag == 101) {
//        if (buttonIndex == 1) {
//            [self doDelete];
//        }
//    }
    else if (alertView.tag == 998) {
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

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message {
    
    if (alertView.tag == 106) {
		if (buttonIndex == 1) {
			[self.httpRequest clearDelegatesAndCancel];
			NSString *name = [[Info getInstance] login_name];
			NSString *password = message;
			self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:password]];
			[httpRequest setTimeOutSeconds:20.0];
			[httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
			[httpRequest setDidFailSelector:@selector(recivedFail:)];
			[httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
			[httpRequest setDelegate:self];
			[httpRequest startAsynchronous];
			
		}
	}
    
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

//		[self send];
	}
}

-(void)requestFangChenMi
{
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"FangChenMiSwitch"] integerValue] == 1){
        
        NSMutableData *postData = [[GC_HttpService sharedInstance] getUSerFangChenMiMessage];
        
        [httpRequest clearDelegatesAndCancel];
        self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [httpRequest setRequestMethod:@"POST"];
        [httpRequest addCommHeaders];
        [httpRequest setPostBody:postData];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(requestFangChenMiFinished:)];
        [httpRequest startAsynchronous];
        
    }

}
- (void)requestFangChenMiFinished:(ASIHTTPRequest*)request{

    if([request responseData]){
    
        GC_FangChenMiParse *fangchenmi = [[GC_FangChenMiParse alloc] initWithResponseData:request.responseData WithRequest:request];
        
        if(fangchenmi.returnID != 3000){
        
            if([fangchenmi.code integerValue] == 1){
                
                [self showFangChenMiText:fangchenmi.alertText andImageNum:(int)fangchenmi.alertNum];
                
            }
        
        }
        [fangchenmi release];
        
    }
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)reqStartTogetherBuyFinished:(ASIHTTPRequest*)request
{
    
    if ([request responseData]) {
        /*******
         投注结果：
         1.操作成功！
         2.操作失败！
         3.彩期已截止
         6.余额不足，请充值！
         20.企业账户余额不足
         21.单笔购彩限额100元，您已超限，请重新投注
         *******/
        
        
#ifdef isYueYuBan
        
        self.buyResult = [[GC_BuyLottery alloc]initWithResponseData:[request responseData] isHemaiYueyu:YES WithRequest:request];
#else
        
        self.buyResult = [[GC_BuyLottery alloc]initWithResponseData:[request responseData] WithRequest:request];
#endif
        buyResult.lotteryId = self.betInfo.lotteryId;
        if (buyResult.returnValue == 1) {
#ifdef isYueYuBan
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            
            CP_TouZhuAlert *alert = [[CP_TouZhuAlert alloc] init];
            alert.buyResult = buyResult;
            alert.delegate = self;
            [alert show];
            [alert release];

#else
            isGoBuy = YES;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyBack) name:@"BecomeActive" object:nil];

                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
                [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] payUrlWith:buyResult] afterDelay:1];
                [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] payUrlWith:buyResult]];

            
                #endif

        } else if (buyResult.returnValue == 4){
            self.syscurIssre = buyResult.curIssure;
             if ([self checkisShuziOrNot:self.betInfo.lotteryId]) {
                 if ([self.syscurIssre length] == 0) {
                     CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil
                                                                     message:@"此彩种已经截期"
                                                                    delegate:self
                                                           cancelButtonTitle:@"取消"
                                                           otherButtonTitles: @"确定",nil];
                     aler.tag = 0;
                     [aler show];
                     [aler release];
                     
                 }
                 else{
                     CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil
                                                                     message:[NSString stringWithFormat:@"%@期已截止，当前只能投注%@期，是否继续投注？",self.betInfo.issue,self.syscurIssre]
                                                                    delegate:self
                                                           cancelButtonTitle:@"取消"
                                                           otherButtonTitles: @"确定",nil];
                     aler.tag = 104;
                     [aler show];
                     [aler release];
                 }
                
            }
            else {
                if ([self.syscurIssre length] == 0) {
                    if ([self.betInfo.lotteryId isEqualToString:@"300"]) {
                        NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期已截止",betInfo.issue];
                        CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        aler.tag = 108;
                        [aler show];
                        [aler release];
                    }else if([self.betInfo.lotteryId isEqualToString:@"301"]){
                        NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期已截止",betInfo.issue];
                        CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        aler.tag = 108;
                        [aler show];
                        [aler release];
                    }else if([self.betInfo.lotteryId isEqualToString:@"400"]){
                        NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期已截止",betInfo.issue];
                        CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        aler.tag = 108;
                        [aler show];
                        [aler release];
                    }else {
                        CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您选择的比赛已截止" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        aler.tag = 108;
                        [aler show];
                        [aler release];
                    }
                }else{
                
                    if ([self.betInfo.lotteryId isEqualToString:@"300"]) {
                        NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期已截止，请重新投注",betInfo.issue];
                        CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        aler.tag = 108;
                        [aler show];
                        [aler release];
                    }else if([self.betInfo.lotteryId isEqualToString:@"301"]){
                        NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期已截止，请重新投注",betInfo.issue];
                        CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        aler.tag = 108;
                        [aler show];
                        [aler release];
                    }else if([self.betInfo.lotteryId isEqualToString:@"400"]){
                        NSString * msgstr = [NSString stringWithFormat:@"您选择的%@期已截止，请重新投注",betInfo.issue];
                        CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:msgstr delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        aler.tag = 108;
                        [aler show];
                        [aler release];
                    }else {
                        CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您选择的比赛已截止，请重新投注" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        aler.tag = 108;
                        [aler show];
                        [aler release];
                    }
                }
                

            }
            
        }
#ifdef isYueYuBan
        else  if(buyResult.returnValue == 6){
            CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:@"余额不足是否充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
            aler.tag = 109;
            [aler show];
            [aler release];
        }
        else if (buyResult.returnValue == 10) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您之前已经投过此注，是否继续投注" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
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
#else
#endif
        else {
            [[caiboAppDelegate getAppDelegate] showMessage:@"投注失败"];
        }
    }
}



@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    