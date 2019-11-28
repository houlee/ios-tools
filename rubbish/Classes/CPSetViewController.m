//
//  CPSetViewController.m
//  caibo
//
//  Created by  on 12-5-7.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "CPSetViewController.h"

#import "caiboAppDelegate.h"
#import "TuisongtongzhiButtonController.h"
#import "PhotographViewController.h"
#import "Info.h"
#import "User.h"
#import "ProvingViewCotroller.h"
#import "GC_VersionCheck.h"
#import "GC_HttpService.h"
#import "AboutOurViewController.h"
#import "NetURL.h"
#import "UserInfo.h"
#import "YaoQingViewController.h"
#import "CP_UIAlertView.h"
#import "JSON.h"
#import "ShareSetViewController.h"

#import "JingPinTuiJianViewController.h"
#import "MobClick.h"
//#import "PWGestureViewController.h"
#import "CPSetpwViewController.h"
#import "DataBase.h"
#import "GC_UserInfo.h"
#import "CP_SWButton.h"
#import "SoundSetViewController.h"
@implementation CPSetViewController
@synthesize httpRequest,messageRequest;
@synthesize versionCheck;
@synthesize urlVersion;
@synthesize passWord, psTypeString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */
- (void)typeFunc{
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
                        self.psTypeString = @"开启";
                        break;
                    }else{
                        self.psTypeString = @"关闭";
                        break;
                    }
                }
                
            }
            
        }
        
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
    [caiboappdelegate.keFuButton calloff];
    //[self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
    caiboappdelegate.keFuButton.hidden = NO;
    [caiboappdelegate.keFuButton chulaitiao];
    if (caiboappdelegate.keFuButton.markbool) {
        caiboappdelegate.keFuButton.show = YES;
    }else{
        caiboappdelegate.keFuButton.show = NO;
    }
    [self typeFunc];
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"SoundSetPage_setSound"] integerValue] == 1){
    
        isSoundOn = YES;
    }else{
    
        isSoundOn = NO;
    }
    
    [myTableView reloadData];
    
}
- (void)LoadiPhoneView {
    
    [MobClick event:@"event_shezhi"];
#ifdef  isYueYuBan
    dataArray1 = [[NSArray alloc] initWithObjects:@"精品推荐",@"声音提醒",@"推送设置",@"手势密码",@"求您不要拒绝", nil];
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] != 1) {
        // 不是三方登录
        dataArray1 = [[NSArray alloc] initWithObjects:@"精品推荐",@"声音提醒",@"推送设置",@"手势密码",@"求您不要拒绝", nil];

    }else{
    
        dataArray1 = [[NSArray alloc] initWithObjects:@"精品推荐",@"声音提醒",@"推送设置",@"求您不要拒绝", nil];

    }
    
#else
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] != 1) {
    
        dataArray1 = [[NSArray alloc] initWithObjects:@"声音提醒",@"推送设置",@"手势密码",@"求您不要拒绝", nil];

    }else{
    
        dataArray1 = [[NSArray alloc] initWithObjects:@"声音提醒",@"推送设置",@"求您不要拒绝", nil];

    }
    
#endif
    
    // 背景
    backi = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    if(IS_IPHONE_5){
        backi.image = [UIImage imageNamed:@"setBackgroundImage_ip5.jpg"];
        //        backi.frame = CGRectMake(0, 0, 320, 568);
        
    }else{
        backi.image = [UIImage imageNamed:@"setBackgroundImage.jpg"];
        //        backi.frame = CGRectMake(0, 0, 320, 480);
        
        
    }
    backi.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:backi];
    [backi release];
    
    self.psTypeString = @"未设置";
    
    
    int count = (int)[dataArray1 count];
    
    
    if(IS_IPHONE_5)
    {
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(60, (568*0.1)+31, 320-60, 50*count) style:UITableViewStylePlain];
        
    }
    else
    {
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(60, (480*0.1)+1, 320-60, 50*count) style:UITableViewStylePlain];
        
    }
    myTableView.showsHorizontalScrollIndicator = NO;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.scrollEnabled = NO;
    myTableView.backgroundColor = [UIColor clearColor];
    
  
    //退出登录
    exitLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5)
    {
        exitLoginButton.frame = CGRectMake(65, 568-125, 240, 45);
        
    }
    else
    {
        exitLoginButton.frame = CGRectMake(65, 480-95, 240, 45);
        
    }
    [exitLoginButton addTarget:self action:@selector(exitLogin) forControlEvents:UIControlEventTouchUpInside];
    [exitLoginButton setTitle:@"退出登录" forState:UIControlStateNormal];
    exitLoginButton.titleLabel.font = [UIFont systemFontOfSize:18];
    exitLoginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [exitLoginButton setTitleColor:[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1] forState:UIControlStateNormal];
    [exitLoginButton setBackgroundImage:[UIImageGetImageFromName(@"btn_gray_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateNormal];
    [self.mainView addSubview:exitLoginButton];
    
    
    
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:myTableView];
    
    
#ifdef isYueYuBan
    NSLog(@"isYueYuBan");
    myTableView.frame =CGRectMake(60, myTableView.frame.origin.y-25, 320-60, 350);
    if(IS_IPHONE_5){
        exitLoginButton.frame = CGRectMake(65, self.mainView.bounds.size.height-145, 240, 45);

    }
    else{
    
        exitLoginButton.frame = CGRectMake(65, self.mainView.bounds.size.height-95, 240, 45);

    }
#endif
    
    
}

//注销
- (void)exitLogin{
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您是否退出登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 100;
    [alert show];
    [alert release];
    
}

-(void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (alertView.tag == 100)
        {// 直接注销此账号，跳转到登录界面
            [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"logincp"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"logincp"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isAlipay"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tuisongshezhi"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cheknewpush"];
            
            //[[NSUserDefaults standardUserDefaults] setValue:st forKey:@"logincp"];
            Statement *stmt =  [DataBase statementWithQuery:"SELECT * FROM users"];
            int count = 0;
            while ([stmt step] == SQLITE_ROW) {
                count++;
            }
            [stmt reset];
            for (int i = 0; i < count; i++) {
                User *user = [User getLastUser];
                [User deleteFromDB:user.user_id];
                
            }
            NSLog(@"%@",[[[Info getInstance]mUserInfo] nick_name]);
            Info *info = [Info getInstance];
            info.login_name = @"";
            info.userId = @"";
            info.nickName = @"";
            info.userName = @"";
            info.isbindmobile = @"";
            info.authentication = @"";
            info.userName = @"";
            info.requestArray = nil;
            info.mUserInfo = nil;
            info.headImage = nil;
            info.headImageURL = nil;
            info.jifen = nil;
            [ASIHTTPRequest setSessionCookies:nil];
            //[[NSUserDefaults standardUserDefaults] setValue:[[[Info getInstance]mUserInfo] nick_name] forKey:@"LogInname"];
            [[Info getInstance] setMUserInfo:nil];
            [ASIHTTPRequest clearSession];
            [GC_UserInfo sharedInstance].personalData = nil;
            [GC_HttpService sharedInstance].sessionId = nil;
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnion"];
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isUnionType"];
            [GC_UserInfo sharedInstance].accountManage = nil;
            [self.navigationController popToRootViewControllerAnimated:NO];
            
            NSMutableDictionary * weiBoLikeDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"weiBoLike"]];
            [weiBoLikeDic removeAllObjects];
            [[NSUserDefaults standardUserDefaults] setObject:weiBoLikeDic forKey:@"weiBoLike"];
            [[caiboAppDelegate getAppDelegate] goNewHomeView];
        }
    }
    
}


- (void)LoadiPadView {
    
    [MobClick event:@"event_shezhi"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    UIButton *btnwan = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnwan setBounds:CGRectMake(0, 0, 70, 40)];
    UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
    imagevi.backgroundColor = [UIColor clearColor];
    imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    [btnwan addSubview:imagevi];
    [imagevi release];
    
    backi = [[UIImageView alloc] initWithFrame:CGRectMake(0, -10, 320, self.view.bounds.size.height)];
    backi.image = UIImageGetImageFromName(@"bejing.png");
    [self.view addSubview:backi];
    [backi release];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(65, (self.view.bounds.size.height*0.1)+56, 320-65, 250) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.scrollEnabled = NO;
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:myTableView];
    
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.CP_navigation.hidden = YES;
//    self.mainView.frame = CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height);
    [self setIsRealNavigationBarHidden:YES];

    
#ifdef  isCaiPiaoForIPad
    [self LoadiPadView];
#else
    [self LoadiPhoneView];
#endif
    
    [self requestMessageOFF];
    
    
}
//推广短信状态
-(void)requestMessageOFF
{
    self.messageRequest = [ASIHTTPRequest requestWithURL:[NetURL setSmsStateWithState:@"2"]];
    [messageRequest setTimeOutSeconds:20.0];
    [messageRequest setDidFinishSelector:@selector(TGDXSZFinish:)];
    [messageRequest setDidFailSelector:@selector(TGDXSZFailed:)];
    [messageRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [messageRequest setDelegate:self];
    [messageRequest startAsynchronous];
}
- (void)gotohome{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
    
}

- (void)doBackforiPad
{
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    UIView * backview = (UIView *)[app.window viewWithTag:10212];
    [backview removeFromSuperview];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [dataArray1 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
#ifdef  isCaiPiaoForIPad
    
    NSString * cellid = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
        
    }
    
    
    UIImageView *backima = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 477, 45.5)]
    UIImageView *heaima = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 22, 22)];
    UILabel *textl = [[UILabel alloc] initWithFrame:CGRectMake(40, 7, 200, 30)];
    textl.textAlignment = NSTextAlignmentLeft;
    textl.backgroundColor = [UIColor clearColor];
    textl.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.section == 0) {
        backima.image = UIImageGetImageFromName(@"set-input.png");
        heaima.image = UIImageGetImageFromName(@"set-tuisong.png");
        heaima.frame = CGRectMake(12, 12, 22, 22);
        textl.text = @"推送设置";
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            backima.image = UIImageGetImageFromName(@"set-input2.png");
            heaima.image = UIImageGetImageFromName(@"set-xiugaitouxiang.png");
            heaima.frame = CGRectMake(12, 12, 22, 22);
            textl.text = @"修改头像";
            
        }else if (indexPath.row == 1){
            
            backima.image = UIImageGetImageFromName(@"set-input3.png");
            heaima.image = UIImageGetImageFromName(@"set-shengfenxinxi.png");
            heaima.frame = CGRectMake(12, 12, 22, 22);
            textl.text = @"身份信息";
        }
		if ([[[Info getInstance]userId] intValue] == 0) {
			textl.textColor = [UIColor grayColor];
			cell.userInteractionEnabled = NO;
		}
    }else if(indexPath.section == 2){
        
        if (indexPath.row == 0) {
            backima.image = UIImageGetImageFromName(@"set-input2.png");
            heaima.image = UIImageGetImageFromName(@"set-luanjianshengji.png");
            heaima.frame = CGRectMake(12, 12, 22, 22);
            textl.text = @"软件升级";
        }
        
        if (indexPath.row == 1) {
            backima.image = UIImageGetImageFromName(@"set-input3.png");
            heaima.image = UIImageGetImageFromName(@"set-guanyuwomen.png");
            heaima.frame = CGRectMake(12, 12, 22, 22);
            textl.text = @"关于我们";
        }
    }else if (indexPath.section == 3) {
        
        if (indexPath.row == 0) {
            backima.image = UIImageGetImageFromName(@"set-input.png");
            heaima.image = UIImageGetImageFromName(@"set-pingjia.png");
            heaima.frame = CGRectMake(12, 12, 22, 22);
            textl.text = @"求您不要拒绝";
            textl.textColor = [UIColor redColor];
            UIImageView * faceImage = [[UIImageView alloc] initWithFrame:CGRectMake(150, 8, 21, 20)];
            faceImage.image = UIImageGetImageFromName(@"faceAppstoreimage.png");
            faceImage.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:faceImage];
            [faceImage release];
            
        }
        
    }
    
    
    
    if ([[[Info getInstance] userId] isEqualToString:CBGuiteID]||[[[Info getInstance] userId] intValue] == 0) {
        if (indexPath.section == 0) {
            textl.textColor = [UIColor grayColor];
            heaima.image = UIImageGetImageFromName(@"wb_a13_0.png");
        }else if (indexPath.section == 1) {
            textl.textColor = [UIColor grayColor];
            if (indexPath.row == 0) {
                heaima.image = UIImageGetImageFromName(@"wb_a10_0.png");
            }else if(indexPath.row == 1){
                heaima.image = UIImageGetImageFromName(@"wb_a12_0.png");
            }else if(indexPath.row == 2){
                heaima.image = UIImageGetImageFromName(@"wb_a13_0.png");
            }
        }else if(indexPath.section == 2){
            if (indexPath.row == 2) {
                
                heaima.image = UIImageGetImageFromName(@"HYQ960.png");
                
            }
        }
        
    }
    else {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [backima addSubview:heaima];
    [backima addSubview:textl];
    
    //添加箭头
    UIImageView *hou1 = [[UIImageView alloc] initWithFrame:CGRectMake(240, 15, 9, 14)];
    hou1.image = UIImageGetImageFromName(@"chongzhijian.png");
    [backima addSubview:hou1];
    [hou1 release];
    [heaima release];
    [textl release];
    
    [cell.contentView addSubview:backima];
    [backima release];
    
    
    return cell;
    
#else
    
    
    
    NSString * cellid = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
        
        UIImageView * backima = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        backima.backgroundColor = [UIColor clearColor];
        backima.tag = 200;
        [cell.contentView addSubview:backima];
        [backima release];
        
        //celliamge
        UIImageView * heaima = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 19, 19)];
        heaima.backgroundColor = [UIColor clearColor];
        
        heaima.tag = 201;
        [backima addSubview:heaima];
        [heaima release];
        
        
        //线
        UIImageView * xianImge = [[UIImageView alloc] initWithFrame:CGRectMake(40, 49, 320, 1)];
        xianImge.backgroundColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:140/255.0 alpha:1];
        [backima addSubview:xianImge];
        xianImge.tag = 202;
        [xianImge release];
        
        //文字
        UILabel * textl = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 200, 30)];
        textl.textAlignment = NSTextAlignmentLeft;
        textl.backgroundColor = [UIColor clearColor];
        textl.font = [UIFont systemFontOfSize:18];
        textl.tag = 203;
        textl.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        [backima addSubview:textl];
        [textl release];
        
        //箭头
        UIImageView * hou1 = [[UIImageView alloc] initWithFrame:CGRectMake(230, 18, 6, 13)];
        hou1.backgroundColor = [UIColor clearColor];
        hou1.tag = 204;
        hou1.image = UIImageGetImageFromName(@"JTD960.png");
        [backima addSubview:hou1];
        [hou1 release];
        
        
        //未设置
        UILabel * typeLable = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 70, 30)];
        typeLable.backgroundColor = [UIColor clearColor];
        typeLable.tag = 205;
        typeLable.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
        [backima addSubview:typeLable];
        [typeLable release];
        
        //推广短信开关
        
//        switchyn = [[CP_SWButton alloc] initWithFrame:CGRectMake(165, 8, 70, 31)];
//        switchyn.tag = 206;
//        switchyn.onImageName = @"heji2-640_10.png";
//        switchyn.offImageName = @"heji2-640_11.png";
//        switchyn.hidden = YES;
//        switchyn.backgroundColor = [UIColor clearColor];
//        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] integerValue]==0&&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] integerValue] == 1)
//        {
//            [switchyn addTarget:self action:@selector(pressSwitchYN) forControlEvents:UIControlEventValueChanged];
//        }else{
//        
//            switchyn.onImageName = @"heji2-640_11.png";
//            switchyn.enabled = NO;
//
//
//        }
//        [backima addSubview:switchyn];
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView * backima = (UIImageView *)[cell.contentView viewWithTag:200];
    UIImageView * heaima = (UIImageView *)[backima viewWithTag:201];
    UIImageView * xianImge = (UIImageView *)[backima viewWithTag:202];
    UILabel * textl = (UILabel *)[backima viewWithTag:203];
    UIImageView * hou1 = (UIImageView *)[backima viewWithTag:204];
    UILabel * typeLable = (UILabel *)[backima viewWithTag:205];
    CP_SWButton *switchBtn = (CP_SWButton *)[backima viewWithTag:206];
    
    
    
#ifdef  isYueYuBan
    NSInteger yueyupianyi = 1;
    if (indexPath.row == 0) {
        
        backima.backgroundColor = [UIColor clearColor];
        heaima.image = UIImageGetImageFromName(@"shezhi_jingpinshezhi_1.png");
        xianImge.image = nil;
        textl.text = @"精品推荐";
        textl.textColor = [UIColor colorWithRed:255.0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        
    }
    
#else
    NSInteger yueyupianyi = 0;
#endif
    
//    if (indexPath.row == 0+yueyupianyi) {
//        // 推广短信
//
//        backima.userInteractionEnabled = YES;
//        switchBtn.hidden = NO;
//        switchBtn.on = switchyn.on;
//        hou1.image = nil;
//        heaima.image = UIImageGetImageFromName(@"message-normal_1.png");
//        textl.text = [dataArray1 objectAtIndex:indexPath.row];
//            
//        
//    }
//    else
        if (indexPath.row == 0+yueyupianyi){
        //声音提醒
        hou1.frame = CGRectMake(225, 18, 15, 14.5);
        if(isSoundOn){
            hou1.image = UIImageGetImageFromName(@"sound_on.png");

        }
        else{
            hou1.image = UIImageGetImageFromName(@"sound_off.png");

        }
        heaima.image = UIImageGetImageFromName(@"sound-normal_1.png");
        textl.text = [dataArray1 objectAtIndex:indexPath.row];
    }
    else if (indexPath.row == 1+yueyupianyi){
        //推送设置
        heaima.image = UIImageGetImageFromName(@"push-normal_1.png");
        textl.text = [dataArray1 objectAtIndex:indexPath.row];
    }
//    else if (indexPath.row == 3+yueyupianyi){
//        
//        //分享设置
//        heaima.image = UIImageGetImageFromName(@"share-normal_1.png");
//        xianImge.image = nil;
//        textl.text = [dataArray1 objectAtIndex:indexPath.row];
//    }
    else if (indexPath.row == 2+yueyupianyi)
    {
        //手势密码
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] != 1) {
            heaima.image = UIImageGetImageFromName(@"open-normal_1.png");
            xianImge.image = nil;
            textl.text = [dataArray1 objectAtIndex:indexPath.row];
            
            typeLable.text = self.psTypeString;
        }else{
        
            heaima.image = UIImageGetImageFromName(@"comment-normal_1.png");
            xianImge.image = nil;
            hou1.image = nil;
            textl.text = [dataArray1 objectAtIndex:indexPath.row];
        }
        
       
    }
    else
    {
        //求您不要拒绝
        if(indexPath.row != 0)
        {
                heaima.image = UIImageGetImageFromName(@"comment-normal_1.png");
                xianImge.image = nil;
                hou1.image = nil;
                textl.text = [dataArray1 objectAtIndex:indexPath.row];
            
        }
        
        
        
    }
    
    if ([[[Info getInstance]userId] intValue] == 0)
    {
        textl.textColor = [UIColor grayColor];
        cell.userInteractionEnabled = NO;
    }
    

    
    return cell;
    
#endif
    
}



- (void)activityIndicatorViewshow{
    
    statepop = [StatePopupView getInstance];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [statepop showInView:appDelegate.window Text:@"请稍等..."];
    
    [appDelegate LogInBySelf];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dissmisspop" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dissmissstatepop) name:@"dissmisspop" object:nil];
    //if ([[GC_HttpService sharedInstance].sessionId length]) {
    //[statepop dismiss];//去掉转圈
}
- (void)dissmissstatepop{
    [statepop dismiss];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dissmisspop" object:nil];
}



- (void)TGDXSZFinish:(ASIHTTPRequest *)mrequest{
    
    NSString * requestString = [mrequest responseString];
    if (requestString) {
        NSDictionary * dict = [requestString JSONValue];
        
        if (dict) {
            NSString * code = [dict objectForKey:@"code"];
            if ([code intValue] == 1) {
                
                NSString * state = [dict objectForKey:@"state"];
                if ([state intValue] == 1) {
                    switchyn.on = YES;
                }else{
                    switchyn.on = NO;
                }
                
            }else{
                NSString * msg = [dict objectForKey:@"state"];
                if (msg) {
                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                    [cai showMessage:msg];
                }
                
            }
        }
    }
    [myTableView reloadData];
    
}
- (void)TGDXSZFailed:(ASIHTTPRequest *)mrequest
{
    NSLog(@"TGDXSZFailed : %@",mrequest.responseString);
}
#pragma mark - UITableView DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BOOL selbol;
    if ([[Info getInstance] userId] == nil || [[[Info getInstance] userId] isEqualToString:@""])
    {
        selbol = NO;
    }else
    {
        selbol = YES;
    }
    
    
#ifdef  isYueYuBan
    NSInteger yueyupianyi = 1;
    if (indexPath.row == 0)
    {
        JingPinTuiJianViewController *JPTJViewController = [[JingPinTuiJianViewController alloc] init];
        [self.navigationController pushViewController:JPTJViewController animated:YES];
        [JPTJViewController release];
    }
    
#else
    
    NSInteger yueyupianyi = 0;
#endif
    if(indexPath.section == 0)
    {
        //推广短信
//        if(indexPath.row == 0+yueyupianyi)
//        {
//            
//        }
        //声音提醒
//        else
            if (indexPath.row == 0+yueyupianyi){
        
            NSLog(@"声音提醒");
            SoundSetViewController *sound = [[SoundSetViewController alloc] init];
            [self.navigationController pushViewController:sound animated:YES];
            [sound release];
        }
        // 推送设置
        else if(indexPath.row == 1+yueyupianyi)
        {
            if (selbol) {
                [MobClick event:@"event_shezhi_tuisongshezhi"];
                TuisongtongzhiButtonController *tsViewController = [[TuisongtongzhiButtonController alloc] initWithNibName: nil bundle: nil];
                [self.navigationController pushViewController: tsViewController animated: YES];
                [tsViewController release];
            }
            
        }
        // 分享设置
//        else if (indexPath.row == 3+yueyupianyi)
//        {
//            if (selbol) {
//                [MobClick event:@"event_shezhi_fenxiangshezhi"];
//                ShareSetViewController * pho = [[ShareSetViewController alloc] init];
//                pho.title = @"分享设置";
//                [self.navigationController pushViewController:pho animated:YES];
//                [pho release];
//            }
//            
//        }
        //手势密码
        else if (indexPath.row == 2+yueyupianyi)
        {
            // 判断是否是三方登录
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] != 1) {

               // 如果不是执行
            CPSetpwViewController * pwg = [[CPSetpwViewController alloc] init];
            [self.navigationController pushViewController:pwg animated:YES];
            [pwg release];
            }else{
                // 是三方登录，不进行操作
                if(indexPath.row != 0)
                {
                    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",caipiaoAppleID];
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
                        str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",caipiaoAppleID];
                    }
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }
            }
        }
        //求您不要拒绝
        else
        {
            if(indexPath.row != 0)
            {
                [MobClick event:@"event_pingjia"];
                NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",caipiaoAppleID];
                if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
                    str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",caipiaoAppleID];
                }
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
            
            
        }
    }
    
    
    
}
-(void)pressSwitchYN
{
    NSLog(@"pressSwitchYN");
    NSString * onbool = @"";
    switchyn.on = !switchyn.on;
    
    if (switchyn.on == YES) {
        [MobClick event:@"event_shezhi_tuiguangduanxin"];
        onbool = @"1";
    }else{
        onbool = @"0";
    }
    
    [messageRequest clearDelegatesAndCancel];
    self.messageRequest = [ASIHTTPRequest requestWithURL:[NetURL setSmsStateWithState:onbool]];
    [messageRequest setTimeOutSeconds:20.0];
    [messageRequest setDidFinishSelector:@selector(doneFinish:)];
    [messageRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [messageRequest setDelegate:self];
    [messageRequest startAsynchronous];
}
- (void)doneFinish:(ASIHTTPRequest *)mrequest{
    
    NSString * requestString = [mrequest responseString];
    if (requestString) {
        NSDictionary * dict = [requestString JSONValue];
        
        if (dict) {
            NSString * code = [dict objectForKey:@"code"];
            if ([code intValue] == 1) {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"推广短信设置已更新"];
                
            }
            else{
                
                NSString * msg = [dict objectForKey:@"state"];
                if (msg) {
                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                    [cai showMessage:msg];
                }
                
            }
        }
    }
}



- (void)sendVersionCheck {
    //    NSMutableData *postData = [[GC_HttpService sharedInstance] reqVersionCheck];
    //
    //    [httpRequest clearDelegatesAndCancel];
    //    NSLog(@"hosturl = %@", [GC_HttpService sharedInstance].hostUrl);
    //    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    //    [httpRequest setRequestMethod:@"POST"];
    //    [httpRequest addCommHeaders];
    //    [httpRequest setPostBody:postData];
    //    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    //    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(reqCheckFinished:)];
    //    [httpRequest startAsynchronous];
    
    [self.httpRequest clearDelegatesAndCancel];
    
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL checkUpDateFunc]];
    [httpRequest setTimeOutSeconds:20.0];
    [httpRequest setDidFinishSelector:@selector(reqCheckFinished:)];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];
    
}

- (void)reqCheckFinished:(ASIHTTPRequest *)request {
    NSString *responseStr = [request responseString];
    
    NSLog(@"responsestr = %@", responseStr);
    NSDictionary * dict = [responseStr JSONValue];
    NSString * versionstr = [dict objectForKey:@"version"];
    NSString * upDatastr = [dict objectForKey:@"isUpdate"];
    NSArray * infoArray = [dict objectForKey:@"info"];
    self.urlVersion = [NSString stringWithFormat:@"%@",[dict objectForKey:@"add"] ];
    NSLog(@"ulversion = %@", self.urlVersion);
    NSMutableString * msgString = [[NSMutableString alloc] init];
    
    if ([infoArray count] > 0) {
        for (int i = 0; i < [infoArray count]; i++) {
            NSDictionary * dictmsg = [infoArray objectAtIndex:i];
            [msgString appendFormat:@"%@\n", [dictmsg objectForKey:@"line"]];
        }
    }
    
    if ([upDatastr isEqualToString:@"0"]) {
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil
                                                              message:@"已经是最新版本!"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                                    otherButtonTitles:@"确定", nil];
        
        [alert show];
#ifdef isCaiPiaoForIPad
        alert.frame = CGRectMake(0, 0, 540, 560);
#endif
        
        [alert release];
        
        
        
        
    }else if([upDatastr isEqualToString:@"1"]){
        NSString * msg = @"";
        if ([msgString length] > 0) {
            msg = [NSString stringWithFormat:@"%@",msgString];
        }else{
            msg = [NSString stringWithFormat:@"发现新版本 %@\n是否更新", versionstr];
        }
        [[NSUserDefaults standardUserDefaults] setValue:versionstr forKey:@"newestversion"];
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil
                                                              message:msg
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                                    otherButtonTitles:@"更新", nil];
        alert.tag = 2;
        alert.delegate = self;
        [alert show];
        [alert release];
        
        
        
    }else if([upDatastr isEqualToString:@"2"]){
        NSString * msg = @"";
        if ([msgString length] > 0) {
            msg = [NSString stringWithFormat:@"%@", msgString];
        }else{
            msg = [NSString stringWithFormat:@"发现新版本 %@\n请更新", versionstr];
        }
        [[NSUserDefaults standardUserDefaults] setValue:versionstr forKey:@"newestversion"];
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil
                                                              message:msg
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                                    otherButtonTitles:@"更新", nil];
        alert.tag = 3;
        alert.delegate = self;
        [alert show];
        [alert release];
        
    }
    [msgString release];
    
    //    GC_VersionCheck *vc = [[GC_VersionCheck alloc] initWithResponseData:[request responseData]WithRequest:request];
    //    self.versionCheck = vc;
    //    NSLog(@"banbehao = %d", versionCheck.lastVerNum);
    //    if (versionCheck.reVer == 1) {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
    //                                                        message:@"已经是最新版本!"
    //                                                       delegate:self
    //                                              cancelButtonTitle:@"取消"
    //                                              otherButtonTitles:@"确定", nil];
    //        alert.tag = 19161;
    //        [alert show];
    //        [alert release];
    //
    //    }else
    //    if (versionCheck.reVer == 2) {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
    //                                                        message:[NSString stringWithFormat:@"发现新版本 %.2f\n是否更新",(float)versionCheck.lastVerNum/100]
    //                                                       delegate:self
    //                                              cancelButtonTitle:@"取消"
    //                                              otherButtonTitles:@"更新", nil];
    //        alert.tag = 2;
    //        [alert show];
    //        [alert release];
    //    }
    //    else if (versionCheck.reVer == 3) {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
    //                                                        message:[NSString stringWithFormat:@"发现新版本 %.2f\n请更新",(float)versionCheck.lastVerNum/100]
    //                                                       delegate:self
    //                                              cancelButtonTitle:nil
    //                                              otherButtonTitles:@"更新", nil];
    //        alert.tag = 3;
    //        [alert show];
    //        [alert release];
    //    }
    //
    //    [vc release];
}



//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if ((alertView.tag == 2 && buttonIndex != 0) || alertView.tag == 3) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:versionCheck.updateAddr]];
//    }
//}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message{
    if ((alertView.tag == 2 && buttonIndex != 0) || alertView.tag == 3) {
        NSLog(@"url = %@", self.urlVersion);
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlVersion]];
        
        
    }
    
    if (alertView.tag == 111) {
        if (buttonIndex == 1) {
            self.passWord = message;
            if (![self.passWord isEqualToString:[[User getLastUser] password] ]) {
                if (alertView.tag == 1) {
                    
                }else{
                    [self.httpRequest clearDelegatesAndCancel];
                    NSString *name = [[Info getInstance] login_name];
                    NSString *password = self.passWord;
                    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:password]];
                    [httpRequest setTimeOutSeconds:20.0];
                    [httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
                    //                    [httpRequest setDidFailSelector:@selector(recivedFail:)];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //    if ((alertView.tag == 2 && buttonIndex != 0) || alertView.tag == 3) {
    //        NSLog(@"url = %@", self.urlVersion);
    //#ifdef  isCaiPiao365ForIphone5
    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlVersion]];
    //#else
    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlVersion]];
    //#endif
    //
    //    }
    
    if (alertView.tag == 111) {
        if (buttonIndex == 1) {
            if (![self.passWord isEqualToString:[[User getLastUser] password] ]) {
                if (alertView.tag == 1) {
                    
                }else{
                    [self.httpRequest clearDelegatesAndCancel];
                    NSString *name = [[Info getInstance] login_name];
                    NSString *password = self.passWord;
                    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:password]];
                    [httpRequest setTimeOutSeconds:20.0];
                    [httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
                    //                    [httpRequest setDidFailSelector:@selector(recivedFail:)];
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


//- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
////    NSLog(@"text = %@ , %@", textF.text, [[User getLastUser] password]);
//    if ((alertView.tag == 2 && buttonIndex != 0) || alertView.tag == 3) {
//        NSLog(@"url = %@", self.urlVersion);
//#ifdef  isCaiPiao365ForIphone5
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlVersion]];
//#else
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlVersion]];
//#endif
//
//    }
//
//    if (alertView.tag == 89) {
//
//
//        if (buttonIndex == 1) {

//            [self.httpRequest clearDelegatesAndCancel];
//            NSString *name = [[Info getInstance] login_name];
//            NSString *password = textF.text;
//            self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:password]];
//            [httpRequest setTimeOutSeconds:20.0];
//            [httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
//            [httpRequest setDidFailSelector:@selector(recivedFail:)];
//            [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//            [httpRequest setDelegate:self];
//            [httpRequest startAsynchronous];

//            if (![textF.text isEqualToString:[[User getLastUser] password] ]) {
//
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您输入的密码不正确" message:@" " delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
//                [alert show];
//                [alert release];
//
//            }else{
//                ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
//                [self.navigationController pushViewController:proving animated:YES];
//                [proving release];
//            }
//
//        }
//
//    }
//
//}

- (void)recivedLoginFinish:(ASIHTTPRequest*)request {
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
		}else{
            ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
            proving.passWord = self.passWord;
            [self.navigationController pushViewController:proving animated:YES];
            [proving release];
            
        }
        [userInfo release];
		
	}
}

//- (void)keFuTel
//{
//    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否要拨打客服电话:" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"QQ：3254056760", nil];
//    [actionSheet showInView:self.mainView];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        actionSheet.frame = CGRectMake(0, self.mainView.frame.size.height - actionSheet.frame.size.height + 60, 320, actionSheet.frame.size.height);
//    }
//    [actionSheet release];
//}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 0) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008130001"]];
//    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

//-(void)pressSwitchButton:(CP_SWButton *)switchButton
//{
//    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",switchButton.on] forKey:@"WCStyle"];
//}

- (void)dealloc{
    
    
    [messageRequest clearDelegatesAndCancel];
    [messageRequest release];
    [switchyn release];
    
    [psTypeString release];
    [versionCheck release];
    
    [httpRequest clearDelegatesAndCancel];
    [text release];
    [dataArray1 release];
    [dataArray2 release];
    [myTableView release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    