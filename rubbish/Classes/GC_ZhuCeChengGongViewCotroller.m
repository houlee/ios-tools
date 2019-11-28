//
//  GC_ZhuCeChengGongViewCotroller.m
//  caibo
//
//  Created by houchenguang on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GC_ZhuCeChengGongViewCotroller.h"
#import "ProvingViewCotroller.h"
#import "GC_HttpService.h"
#import "User.h"
#import "UserInfo.h"
#import "NetURL.h"
#import "HongBaoInfo.h"
#import "CP_PrizeView.h"
@implementation GC_ZhuCeChengGongViewCotroller

@synthesize requestUserInfo;
@synthesize passWord;
@synthesize hongbaoMes;
@synthesize hongbao_lotteryid;
@synthesize hongbao_topicid;
@synthesize hongbao_returntype;
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
- (void)LoadiPhoneView {

    self.navigationItem.hidesBackButton = YES;
    self.title = @"注册成功";
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    // bgimage.image = UIImageGetImageFromName(@"login_bgn.png");
    bgimage.backgroundColor = [UIColor colorWithRed:250/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:bgimage];
    [bgimage release];
    
  
  
    
    // 第一个图下滑
    UIImageView * zhuceImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -75, 320, 75)];
    // zhuceImage.image = UIImageGetImageFromName(@"Success.png");
    zhuceImage.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:zhuceImage];
    [zhuceImage release];
    
    UILabel *registerSuceed = [[[UILabel alloc] init] autorelease];
    registerSuceed.frame = CGRectMake(0, 30, 320, 20);
    registerSuceed.textAlignment = NSTextAlignmentCenter;
    registerSuceed.text = @"恭喜您,注册成功 !";
    registerSuceed.font = [UIFont systemFontOfSize:18];
    registerSuceed.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
    [zhuceImage addSubview:registerSuceed];
    
    
    UIImageView *registerR = [[[UIImageView alloc] init] autorelease];
    registerR.image = [UIImage imageNamed:@"zhucechenggongduihao.png"];
    registerR.frame = CGRectMake(70-3, 4, 18, 12);
    [registerSuceed addSubview:registerR];
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 75, 320, 0.5);
    line.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:209.0/255.0 blue:219.0/255.0 alpha:1];
    [zhuceImage addSubview:line];
    [line release];
    
    
    
    UILabel * suiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 290, 45)];
    suiLabel.backgroundColor = [UIColor clearColor];
    suiLabel.text = @"开始使用";
    suiLabel.font = [UIFont systemFontOfSize:18];
    suiLabel.textAlignment = NSTextAlignmentCenter;
    suiLabel.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    
    UILabel * bangLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 290, 45)];
    bangLabel.font = [UIFont systemFontOfSize:18];
    bangLabel.backgroundColor = [UIColor clearColor];
    bangLabel.text = @"完善领奖资料";
    bangLabel.textAlignment = NSTextAlignmentCenter;
    bangLabel.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    
    UIButton * suibianBut = [UIButton buttonWithType:UIButtonTypeCustom];
    suibianBut.frame = CGRectMake(15, -45, 290, 45);
    [suibianBut setBackgroundImage:[[UIImage imageNamed:@"tongyonglan.png" ] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [suibianBut setBackgroundImage:[[UIImage imageNamed:@"tongyonglan.png" ] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateSelected];
    [suibianBut addTarget:self action:@selector(pressSuiBianButton:) forControlEvents:UIControlEventTouchUpInside];
    [suibianBut addSubview:suiLabel];
    [self.mainView addSubview:suibianBut];
    suibianBut.alpha = 0;
    
    
    UIButton * bangdingBut = [UIButton buttonWithType:UIButtonTypeCustom];
    bangdingBut.frame = CGRectMake(15,-45, 290, 45);
    [bangdingBut setBackgroundImage:[[UIImage imageNamed:@"tongyonglan.png" ] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [bangdingBut setBackgroundImage:[[UIImage imageNamed:@"tongyonglan.png" ] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateSelected];

    [bangdingBut addTarget:self action:@selector(pressBangDingButton:) forControlEvents:UIControlEventTouchUpInside];
    [bangdingBut addSubview:bangLabel];
    [self.mainView addSubview:bangdingBut];
    self.mainView.userInteractionEnabled = YES;
    bangdingBut.alpha = 0;
    
    UILabel * label1 = [[UILabel alloc] init];
    label1.text = @"投注站郑重承诺,您的身份信息只用来购彩、领奖。我们使用加密存储、独立主机等软硬件措施,保证您的信息安全。";
    label1.frame = CGRectMake(22, -60, 320-44, 60);
    label1.textColor = [UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1];
    label1.backgroundColor = [UIColor clearColor];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.lineBreakMode = NSLineBreakByWordWrapping;
    label1.numberOfLines = 0;
    label1.font = [UIFont systemFontOfSize:12];
//    CGSize labelSize = [label1.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(270, 200) lineBreakMode:NSLineBreakByWordWrapping];
//    label1.frame = CGRectMake((self.mainView.frame.size.width - labelSize.width)/2, 320, labelSize.width, labelSize.height);
    [self.mainView addSubview:label1];
    
    
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(188, -15, 15, 20)];
    label2.text = @"3";
    label2.textColor = [UIColor colorWithRed:255.0/255.0 green:59.0/255.0 blue:48.0/255.0 alpha:1];
    label2.backgroundColor = [UIColor clearColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:12];
    [self.mainView addSubview:label2];
    [label2 release];


    
    UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(80, -15, 180, 20)];
    label3.text = @"完善领奖资料可获得    元彩金";
    label3.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    label3.backgroundColor = [UIColor clearColor];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = [UIFont systemFontOfSize:12];
    [self.mainView addSubview:label3];
    [label3 release];

    
    if ([[[Info getInstance] caijin] intValue] == 0) {
        label3.text = @"完善领奖资料";
        label2.hidden = YES;
    }
    else {
        label2.text = [[Info getInstance] caijin];
    }
    
    [self.mainView insertSubview:label1 belowSubview:zhuceImage];
    [self.mainView insertSubview:label2 belowSubview:zhuceImage];
    [self.mainView insertSubview:label3 belowSubview:zhuceImage];

    
    
    
    
    [UIImageView animateWithDuration:0.9 delay:0.8 options:UIViewAnimationCurveEaseOut animations:^{
        zhuceImage.frame = CGRectMake(0, 0, 320, 75);
        suibianBut.alpha = 1;
        bangdingBut.alpha = 1;
    } completion:^(BOOL finished) {
        
        
        [UIImageView animateWithDuration:0.7 delay:0.3 options:UIViewAnimationCurveEaseOut animations:^{
            label2.frame = CGRectMake(188, 170, 15, 20);
            label3.frame = CGRectMake(80, 170, 180, 20);
            label1.frame = CGRectMake(22, 100, 320-44, 60);
            [UIImageView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationCurveEaseOut animations:^{
                
                bangdingBut.frame = CGRectMake(15, 195+10, 290, 45);
                [UIImageView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationCurveEaseOut animations:^{
                suibianBut.frame = CGRectMake(15, 265, 290, 45);

                } completion:^(BOOL finished) {
                    
                    
                    NSLog(@"动画完成");
                    if(self.hongbaoMes && self.hongbaoMes.length && ![self.hongbaoMes isEqualToString:@"null"]){
                    
                        [self showHongBao];

                    }
                    
                }];
                
            } completion:^(BOOL finished) {

                
            }];

        
            
            
        } completion:^(BOOL finished) {
            
            

            
        }];
        
        
        
    }];
    
    
   
    
   
    
    [suiLabel release];
    [bangLabel release];
    [label1 release];

}
-(void)showHongBao{

    NSLog(@"%@",self.hongbaoMes);

    HongBaoInfo *hongbao = [[HongBaoInfo alloc] initWithResponseString:self.hongbaoMes];
    
    CP_PrizeView *prizeView = [[CP_PrizeView alloc] initWithtitle:hongbao.awardInfo andBtnName:hongbao.buttonInfo returnType:hongbao.returnType topPicID:hongbao.topicID lotteryID:hongbao.lotteryID];
    prizeView.prizeType = [hongbao.showType intValue]-1;
    prizeView.delegate = self;
    [prizeView show];
    [prizeView release];
    [hongbao release];
    
    
}
-(void)CP_PrizeViewGetPressDelegate:(CP_PrizeView *)prizeview returnType:(NSString *)_returntype topPicID:(NSString *)_topicid lotteryID:(NSString *)_lotteryid{
    
    
    self.hongbao_returntype = [NSString stringWithFormat:@"%@",_returntype];
    self.hongbao_topicid = [NSString stringWithFormat:@"%@",_topicid];
    self.hongbao_lotteryid = [NSString stringWithFormat:@"%@",_lotteryid];
    
    NSString *session_id = [NSString stringWithFormat:@"%@",[GC_HttpService sharedInstance].sessionId];
    
    
    if([session_id length]){
    
        [[caiboAppDelegate getAppDelegate] hongBaoFunction:_returntype topicID:_topicid lotteryID:_lotteryid];

    }
    else{
    
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate LogInBySelf];
        
        if (!loadview) {
            loadview = [[UpLoadView alloc] init];
        }
        [appDelegate.window addSubview:loadview];
        [loadview release];
        
    }
    
    
}

-(void)hasGetSession:(NSNotification *)notifation{

    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
    [[caiboAppDelegate getAppDelegate] hongBaoFunction:self.hongbao_returntype topicID:self.hongbao_topicid lotteryID:self.hongbao_lotteryid];

}
- (void)LoadiPadView {

    self.navigationItem.hidesBackButton = YES;
    self.title = @"注册成功";
    UIImageView *backi = [[UIImageView alloc] initWithFrame:CGRectMake(0, -10, 540, 570)];
    backi.image = UIImageGetImageFromName(@"bejing.png");
    [self.mainView addSubview:backi];
    [backi release];
    
    UIImageView *zhuceImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 100, 145.5, 34)];
    zhuceImage.image = UIImageGetImageFromName(@"Reg-zhuchechengong.png");
    zhuceImage.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:zhuceImage];
    [zhuceImage release];
    
    
    UILabel * suiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 254.5, 45)];
    suiLabel.backgroundColor = [UIColor clearColor];
    suiLabel.text = @"到处转转";
    suiLabel.textAlignment = NSTextAlignmentCenter;
    suiLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    
    UILabel * bangLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 254.5, 45)];
    bangLabel.backgroundColor = [UIColor clearColor];
    bangLabel.text = @"领取彩金";
    bangLabel.text = @"完善领奖资料";
    bangLabel.textAlignment = NSTextAlignmentCenter;
    bangLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    
    UIButton *suibianBut = [UIButton buttonWithType:UIButtonTypeCustom];
    suibianBut.frame = CGRectMake(150, 220, 254.5, 45);
    [suibianBut setImage:UIImageGetImageFromName(@"Reg-btn.png") forState:UIControlStateNormal];
    [suibianBut setImage:UIImageGetImageFromName(@"Reg-btn01.png") forState:UIControlStateHighlighted];
    [suibianBut addTarget:self action:@selector(pressSuiBianButton:) forControlEvents:UIControlEventTouchUpInside];
    [suibianBut addSubview:suiLabel];
    [self.mainView addSubview:suibianBut];
    
    UIButton * bangdingBut = [UIButton buttonWithType:UIButtonTypeCustom];
    bangdingBut.frame = CGRectMake(150, 272, 254.5, 45);
    [bangdingBut addTarget:self action:@selector(pressBangDingButton:) forControlEvents:UIControlEventTouchUpInside];
    [bangdingBut setImage:UIImageGetImageFromName(@"Reg-btn.png") forState:UIControlStateNormal];
    [bangdingBut setImage:UIImageGetImageFromName(@"Reg-btn01.png") forState:UIControlStateHighlighted];
    [bangdingBut addSubview:bangLabel];
    [self.mainView addSubview:bangdingBut];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(200, 330, 100, 20)];
    label1.text = @"完善信息可获得";
    label1.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    label1.backgroundColor = [UIColor clearColor];
    label1.textAlignment = NSTextAlignmentRight;
    label1.font = [UIFont systemFontOfSize:13];
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(300, 326, 15, 25)];
    label2.text = @"3";
    label2.textColor = [UIColor redColor];
    label2.backgroundColor = [UIColor clearColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:21];
    
    UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(315, 330, 80, 20)];
    label3.text = @"元奖金";
    label3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    label3.backgroundColor = [UIColor clearColor];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = [UIFont systemFontOfSize:13];
    
    [self.mainView addSubview:label1];
    [self.mainView addSubview:label2];
    [self.mainView addSubview:label3];
    
    [suiLabel release];
    [bangLabel release];
    [label1 release];
    [label2 release];
    [label3 release];

}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasGetSession:) name:@"hasGetsession_id" object:nil];


#ifdef  isCaiPiaoForIPad
    [self LoadiPadView];
#else
    [self LoadiPhoneView];
#endif
    
}

- (void)pressSuiBianButton:(UIButton *)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CancelPrivateLetter" object:nil];
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}

- (void)pressBangDingButton:(UIButton *)sender{
//        ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
//        proving.canTiaoguo = YES;
//        proving.canBack = NO;
//        [self.navigationController pushViewController:proving animated:YES];
//        [proving release];
//    ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
//    [self.navigationController pushViewController:proving animated:YES];
//    [proving release];
    
    ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
    proving.passWord = passWord;
    [self.navigationController pushViewController:proving animated:YES];
    [proving release];
    
//    if (([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0)) {
//        
//        [textF release];
//        textF = [[UITextField alloc] initWithFrame:CGRectMake(40, 50, 200, 20)];
//        textF.placeholder = @"请输入登录密码";
//        
//        textF.autocorrectionType = UITextAutocorrectionTypeYes;
//        textF.secureTextEntry = YES;
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"要查看身份信息,请输入密码" message:@" " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
//        alert.tag = 111;
//        [alert show];
//        [alert addSubview:textF];
//        textF.backgroundColor = [UIColor whiteColor];
//        [alert release];
//        
//    }

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 111) {
        if (buttonIndex == 1) {
            if (![textF.text isEqualToString:[[User getLastUser] password] ]) {
                if (alertView.tag == 1) {
                    
                }else{
                    [self.requestUserInfo clearDelegatesAndCancel];
                    NSString *name = [[Info getInstance] login_name];
                    NSString *password = textF.text;
                    self.requestUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:password]];
                    [requestUserInfo setTimeOutSeconds:20.0];
                    [requestUserInfo setDidFinishSelector:@selector(recivedLoginFinish:)];
                    [requestUserInfo setDidFailSelector:@selector(recivedFail:)];
                    [requestUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
                    [requestUserInfo setDelegate:self];
                    [requestUserInfo startAsynchronous];
                    
                }
                
                
            }else{
                ProvingViewCotroller *proving = [[ProvingViewCotroller alloc] init];
                [self.navigationController pushViewController:proving animated:YES];
                [proving release];
            }
            
        }
        
    }
    
    
}


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
		}
        else if (isTixian) {
            NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
            
            [requestUserInfo clearDelegatesAndCancel];
            self.requestUserInfo = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
            [requestUserInfo setRequestMethod:@"POST"];
            [requestUserInfo addCommHeaders];
            [requestUserInfo setPostBody:postData];
            [requestUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
            [requestUserInfo setDelegate:self];
            [requestUserInfo setDidFinishSelector:@selector(returnTiXianSysTime:)];
            [requestUserInfo startAsynchronous];
            
        }
        else{
            ProvingViewCotroller * proving = [[ProvingViewCotroller alloc] init];
            proving.passWord = textF.text;
            [self.navigationController pushViewController:proving animated:YES];
            [proving release];
            
        }
        [userInfo release];
		
	}
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasGetsession_id" object:self];
    [requestUserInfo clearDelegatesAndCancel];
    [requestUserInfo release];
    
    [super dealloc];
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

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    