//
//  PKRaceViewController.m
//  caibo
//
//  Created by cp365dev6 on 15/1/16.
//
//

#import "PKRaceViewController.h"
#import "PKRankingListViewController.h"

@interface PKRaceViewController ()

@end

@implementation PKRaceViewController

@synthesize dateRequest,buyArray;
@synthesize passWord;
@synthesize curCount,returnId,returnId1,statue;
@synthesize listArym;
@synthesize sysTimeString,sysTimeString1,tishiMessage;

-(void)dealloc
{
    [self.dateRequest clearDelegatesAndCancel];
    self.dateRequest = nil;
    [buyArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = leftItem;
    //    self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(gantanhao) ImageName:@"PKgantanhao.png" Size:CGSizeMake(20,20)];
    self.CP_navigation.title = @"竞彩PK赛";
    //    self.mainView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
    
    //---------------
    
    UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthItem.bounds = CGRectMake(0, 0, 60, 44);
    rigthItem.backgroundColor = [UIColor clearColor];
    [rigthItem addTarget:self action:@selector(pressRightButton:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *rightIma = [[UIImageView alloc]init];
    rightIma.frame = CGRectMake(25, 12, 20, 20);
    rightIma.backgroundColor = [UIColor clearColor];
    rightIma.image = [UIImage imageNamed:@"PKgantanhao.png"];
    [rigthItem addSubview:rightIma];
    [rightIma release];
    
    UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
    self.CP_navigation.rightBarButtonItem = rigthItemButton;
    [rigthItemButton release];
    //--------------
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgimage.backgroundColor=[UIColor colorWithRed:239/255.0 green:238/255.0 blue:226/255.0 alpha:1];
    [self.mainView addSubview:bgimage];
    [bgimage release];
    
    UIImageView *bgImage = [[UIImageView alloc]init];
    bgImage.frame = CGRectMake(0, self.mainView.frame.size.height - 59.5, self.mainView.frame.size.width, 59.5);
    bgImage.image = [UIImage imageNamed:@"PKBGImage.png"];
    bgImage.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:bgImage];
    [bgImage release];
    
    [self loadIphoneView];
}
-(void)loadIphoneView
{
    UIImageView *headIma = [[UIImageView alloc]init];
    headIma.frame = CGRectMake(0, 0, 320, 180);
    headIma.image = [UIImage imageNamed:@"headIma.png"];
    [self.mainView addSubview:headIma];
    [headIma release];
    
    buyArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    NSArray *imaArray = [NSArray arrayWithObjects:@"PKpaihang.png",@"PKzhanji.png",@"PKnewUser.png", nil];
    NSArray *titleArray = [NSArray arrayWithObjects:@"排行榜",@"我的战绩",@"新手帮助", nil];
    for(int i=0;i<imaArray.count;i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(106.5*i + i, headIma.frame.size.height, 106.5, 87);
        [btn setBackgroundImage:[UIImage imageNamed:@"PKanxia.png"] forState:UIControlStateHighlighted];
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:btn];
        
        UIImageView *ima = [[UIImageView alloc]init];
        ima.frame = CGRectMake((btn.frame.size.width - 35)/2, 14, 35, 35);
        ima.image = [UIImage imageNamed:[imaArray objectAtIndex:i]];
        ima.backgroundColor = [UIColor clearColor];
        [btn addSubview:ima];
        [ima release];
        
        UILabel *textLab = [[UILabel alloc]init];
        textLab.frame = CGRectMake(0, 50, 106.5, 25);
        textLab.backgroundColor = [UIColor clearColor];
        textLab.text = [titleArray objectAtIndex:i];
        textLab.font = [UIFont systemFontOfSize:14];
        textLab.textAlignment = NSTextAlignmentCenter;
        textLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        [btn addSubview:textLab];
        [textLab release];
        
        if(i != imaArray.count - 1)
        {
            UILabel *xianLab = [[UILabel alloc]init];
            xianLab.backgroundColor = [UIColor clearColor];
            xianLab.frame = CGRectMake(btn.frame.origin.x + 106.5, headIma.frame.size.height, 0.5, 87);
            xianLab.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
            [self.mainView addSubview:xianLab];
            [xianLab release];
        }
    }
    UILabel *line = [[UILabel alloc]init];
    line.frame = CGRectMake(0, headIma.frame.size.height + 86.5, self.mainView.frame.size.width, 0.5);
    line.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    [self.mainView addSubview:line];
    [line release];
    
    CGFloat height = self.view.bounds.size.height;
    
    CP_PTButton *joinBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    [joinBtn addTarget:self action:@selector(joinRace) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:joinBtn];
    joinBtn.frame = CGRectMake(15,line.frame.origin.y + 60 , 290, 44);
    [joinBtn loadButonImage:@"PKjoin.png" LabelName:@"立即参赛"];
    [joinBtn setImage:[UIImage imageNamed:@"PKjoin_1.png"] forState:UIControlStateHighlighted];
    joinBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    UIImageView *yuanIma = [[UIImageView alloc]init];
    yuanIma.frame = CGRectMake(68, joinBtn.frame.origin.y + 61, 15, 15);
    yuanIma.backgroundColor = [UIColor clearColor];
    yuanIma.image = [UIImage imageNamed:@"PKyuan.png"];
    [self.mainView addSubview:yuanIma];
    [yuanIma release];
    UILabel *chongjiLab = [[UILabel alloc]init];
    chongjiLab.backgroundColor = [UIColor clearColor];
    chongjiLab.frame = CGRectMake(yuanIma.frame.origin.x + 20, yuanIma.frame.origin.y - 5, 200, 25);
    chongjiLab.text = @"不花一分钱，疯狂赚积分";
    chongjiLab.font = [UIFont systemFontOfSize:14];
    chongjiLab.textColor = [UIColor colorWithRed:21/255.0 green:136/255.0 blue:218/255.0 alpha:1];
    [self.mainView addSubview:chongjiLab];
    [chongjiLab release];
    
    if(height == 480)
    {
        joinBtn.frame = CGRectMake(15,line.frame.origin.y + 60 - 40 , 290, 44);
        yuanIma.frame = CGRectMake(68, joinBtn.frame.origin.y + 61, 15, 15);
        chongjiLab.frame = CGRectMake(yuanIma.frame.origin.x + 20, yuanIma.frame.origin.y - 5, 200, 25);
    }
    
//    [self getQiciRequest];
    
}
-(void)getQiciRequest
{
    [self.dateRequest clearDelegatesAndCancel];
    NSMutableData *postData = [[GC_HttpService sharedInstance] req_GetPKQiciCaizhong:@"201"];
    self.dateRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [dateRequest setRequestMethod:@"POST"];
    [dateRequest addCommHeaders];
    [dateRequest setPostBody:postData];
    [dateRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [dateRequest setDelegate:self];
    [dateRequest setDidFinishSelector:@selector(reqPKListFinish:)];
    [dateRequest setDidFailSelector:@selector(reqPKListFailed:)];
    [dateRequest startAsynchronous];
}
-(void)reqPKListFinish:(ASIHTTPRequest *)request
{
    GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:request.responseData];
    if (drs) {
        self.returnId= [drs readShort];
        NSLog(@"返回消息id %d", (int)returnId);
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) {
            
            self.sysTimeString = [drs readComposString1];
            self.curCount = [drs readShort];
            NSLog(@"系统时间 %@",self.sysTimeString);
            NSLog(@"当前页条数 %d",(int)self.curCount);
            if (curCount > 0) {
                if(self.listArym.count > 0)
                {
                    [self.listArym removeAllObjects];
                }
                    
                self.listArym = [NSMutableArray arrayWithCapacity:curCount];
                
                for (int i = 0; i < curCount; i++) {
                    
                    NSString *data = [drs readComposString1];
                    NSString *moreData = [drs readComposString1];
                    NSLog(@"期次 %@",data);
                    NSLog(@"预留字段 %@",moreData);
                    NSMutableArray *ary = [NSMutableArray arrayWithObjects:data,moreData, nil];
                    [self.listArym addObject:ary];
                    
                }
                
                PKJoinRaceViewController *pvc = [[PKJoinRaceViewController alloc]init];
                pvc.betArray = self.listArym;
                [self.navigationController pushViewController:pvc animated:YES];
                [pvc release];
            }
            else
            {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"参赛人数太多，稍后再试！"];
            }
        }
    }
}
-(void)reqPKListFailed:(ASIHTTPRequest *)request
{
    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    [cai showMessage:@"参赛人数太多，稍后再试！"];
}
//- (void)dateDidFinishSelector:(ASIHTTPRequest *)mrequest{
//    NSString * str = [mrequest responseString];
//    NSDictionary * dict = [str JSONValue];
//    NSLog(@"11111111111dict = %@", dict);
//    NSMutableArray * array = [dict objectForKey:@"data"];
//    
//    for (NSDictionary * da in array) {
//        //        NSString * string = [da objectForKey:@"issue"];
//        //        [self.bettingTitleArray addObject:string];
//        
//        
//        if ([[da objectForKey:@"status"] isEqualToString:@"0"]) {
//            NSString * buy = [da objectForKey:@"issue"];
//            [buyArray addObject:buy];
//        }
//        
//    }
//    
//}
# pragma mark 参赛
//是否报名
-(void)baomingRequest
{
    [self.dateRequest clearDelegatesAndCancel];
    NSMutableData *postData = [[GC_HttpService sharedInstance] req_GetPKBaomingCansai];
    self.dateRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [dateRequest setRequestMethod:@"POST"];
    [dateRequest addCommHeaders];
    [dateRequest setPostBody:postData];
    [dateRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [dateRequest setDelegate:self];
    [dateRequest setDidFinishSelector:@selector(reqPKBaomingFinish:)];
    [dateRequest setDidFailSelector:@selector(reqPKBaomingFailed:)];
    [dateRequest startAsynchronous];
}
-(void)reqPKBaomingFinish:(ASIHTTPRequest *)request
{
    GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:request.responseData];
    if (drs) {
        self.returnId1 = [drs readShort];
        NSLog(@"返回消息id %d", (int)returnId);
        if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) {
            
            self.sysTimeString1 = [drs readComposString1];
            self.statue = [drs readShort];
            self.tishiMessage = [drs readComposString1];
            NSLog(@"系统时间 %@",self.sysTimeString);
            NSLog(@"报名状态 %d",(int)self.statue);
            NSLog(@"提示信息 %@",self.tishiMessage);
        }
    }
    [self cansai];
}
-(void)reqPKBaomingFailed:(ASIHTTPRequest *)request
{
    
}
//报名成功   参赛
-(void)cansai
{
    if(self.statue)
    {
        //获取期次
        [self getQiciRequest];
    }
    else
    {
        if(![self.tishiMessage isEqualToString:@""])
        {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:self.tishiMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.tag = 100;
            alert.shouldRemoveWhenOtherAppear = YES;
            [alert show];
            [alert release];
        }
    }
}
//点击参赛按钮 判断是否登录   是否完善信息    是否报名
-(void)joinRace
{
    NSLog(@"参赛");
    
    if ([[[Info getInstance] userId] intValue] == 0) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"登录后可用"];
        return;
    }
        //判断是否完善信息
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] integerValue]==0&&[[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] integerValue] == 1)
        {
            [self baomingRequest];
        }
        else
        {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您还没有完善信息，请先完善信息再来参赛！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.tag = 10;
            alert.shouldRemoveWhenOtherAppear = YES;
            [alert show];
            [alert release];
        }
    
    
    
//    PKJoinRaceViewController *pvc = [[PKJoinRaceViewController alloc]init];
//    pvc.betArray = buyArray;
//    [self.navigationController pushViewController:pvc animated:YES];
//    [pvc release];
    
}
-(void)wanshanXinxi
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
        CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertTpye = passWordType;
        alert.tag = 11;
        [alert show];
        [alert release];
        
    }
    else {
        
        ProvingViewCotroller *proving = [[ProvingViewCotroller alloc] init];
        proving.passWord = self.passWord;
        [self.navigationController pushViewController:proving animated:YES];
        [proving release];
        
    }
}
- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message
{
    //去完善信息
    if(alertView.tag == 10)
    {
        if(buttonIndex == 1)
        {
            [self performSelector:@selector(wanshanXinxi) withObject:self afterDelay:0.1];
        }
        else
        {
            
        }
    }
    else if(alertView.tag == 11)
    {
        if(buttonIndex == 1)
        {
            self.passWord = message;
            if (![self.passWord isEqualToString:[[User getLastUser] password] ]) {
                if (alertView.tag == 1) {
                    
                }else{
                    [self.dateRequest clearDelegatesAndCancel];
                    NSString *name = [[Info getInstance] login_name];
                    NSString *password = self.passWord;
                    self.dateRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:password]];
                    [dateRequest setTimeOutSeconds:20.0];
                    [dateRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
                    [dateRequest setDidFailSelector:@selector(recivedFail:)];
                    [dateRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                    [dateRequest setDelegate:self];
                    [dateRequest startAsynchronous];
                    
                }
                
                
            }
        }
    }
    else if(alertView.tag == 100)
    {
        
    }
}
-(void)recivedLoginFinish:(ASIHTTPRequest *)request
{
    NSString *responseStr = [request responseString];
    if ([responseStr isEqualToString:@"fail"])
    {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您输入的密码不正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [alert show];
        alert.tag = 100;
        [alert release];
    }
    else
    {
        UserInfo *userInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
        if (!userInfo) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您输入的密码不正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
            [alert show];
            alert.tag = 100;
            [alert release];
            return;
        }
        
        else
        {
            NSDictionary * responseDic = [responseStr JSONValue];
            
            [[NSUserDefaults standardUserDefaults] setValue:[[responseDic valueForKey:@"userInfo"] valueForKey:@"isbindmobile"] forKey:@"isbindmobile"];
            [[NSUserDefaults standardUserDefaults] setValue:[[responseDic valueForKey:@"userInfo"] valueForKey:@"authentication"] forKey:@"authentication"];
            
            ProvingViewCotroller *proving = [[ProvingViewCotroller alloc] init];
            proving.passWord = self.passWord;
            [self.navigationController pushViewController:proving animated:YES];
            [proving release];
        }
        [userInfo release];
        
    }
}
-(void)recivedFail:(ASIHTTPRequest *)request
{
    
}
#pragma mark 排行榜战绩新手
-(void)btnAction:(UIButton *)button
{
    NSLog(@"排行榜战绩新手");
    if(button.tag == 0)
    {
        [self paihang];
    }
    else if(button.tag == 1)
    {
        [self myrecord];
    }
    else if(button.tag == 2)
    {
        [self newUserHelp];
    }
}
//排行榜
-(void)paihang
{
    PKRankingListViewController * rankingList = [[[PKRankingListViewController alloc] init] autorelease];
    [self.navigationController pushViewController:rankingList animated:YES];
}
//我的战绩
-(void)myrecord
{
    if ([[[Info getInstance] userId] intValue] == 0) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"登录后可用"];
        return;
    }
    
    PKMyRecordViewController *pvc = [[PKMyRecordViewController alloc]init];
    [self.navigationController pushViewController:pvc animated:YES];
    [pvc release];
}
//新手帮助
-(void)newUserHelp
{
    PKNewUserHelpViewController *pvc = [[PKNewUserHelpViewController alloc]init];
    //    pvc.betArray = buyArray;
    [self.navigationController pushViewController:pvc animated:YES];
    [pvc release];
}
//玩法规则
-(void)pressRightButton:(UIButton *)button
{
    NSLog(@"右侧按钮");
    PKRuleViewController *pvc = [[PKRuleViewController alloc]init];
    [self.navigationController pushViewController:pvc animated:YES];
    [pvc release];
}
- (void)doBack {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    