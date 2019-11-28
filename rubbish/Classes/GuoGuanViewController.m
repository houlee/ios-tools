//
//  GuoGuanViewController.m
//  caibo
//
//  Created by houchenguang on 13-3-8.
//
//

#import "GuoGuanViewController.h"
#import "Info.h"
#import "GC_HttpService.h"
#import "caiboAppDelegate.h"
#import "Info.h"
#import "GCGuoGuanData.h"
#import "GCGuoGuanInfo.h"
#import "GuoGuanIssue.h" 
#import "UserInfo.h"
#import "MoreLoadCell.h"
#import "GCGuoGuanCell.h"
#import "MyLottoryViewController.h"
#import "NewPostViewController.h"
#import "NetURL.h"  
#import "ProfileViewController.h"
#import "ShuangSeQiuInfoViewController.h"
#import "MobClick.h"
#import "JSON.h"
#import "TwitterMessageViewController.h"
#import "SendMicroblogViewController.h"

@interface GuoGuanViewController ()

@end

@implementation GuoGuanViewController

@synthesize httpRequest;
@synthesize moreCell;
@synthesize useridRequest;
@synthesize ggType;
@synthesize renorsheng;

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

- (void)doPushHomeView{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)guoGuanTongJiXinXi{
    
    
    NSString * fenzhong = @"1";
//    if (![issueLabel.text isEqualToString:@"我的中奖"]) {
//        NSArray * arr = [issueLabel.text componentsSeparatedByString:@" "];
//        
//        if ([[arr objectAtIndex:0] isEqualToString:@"胜负彩"]) {
//            fenzhong = @"1";
//        }else{
//            fenzhong = @"2";
//        }
//        
//    }
    
    if (ggType == shengFuCaiType) {
        fenzhong = @"1";
    }else if(ggType == renXuanJiuType){
        fenzhong = @"2";
    }else{
        fenzhong = @"1";
    }
    
    NSMutableData * postData = [[GC_HttpService sharedInstance] guoGuanXinXiCaiZhong:@"13" issue:issuestring fenzhong:fenzhong];
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(guoGuanXinxi:)];
    [httpRequest startAsynchronous];
    
    
}

- (void)guoGuanXinxi:(ASIHTTPRequest *)mrequest{
    if ([mrequest responseData]) {
        GCGuoGuanInfo *guoguaninfo = [[GCGuoGuanInfo alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
        
        if (guoguaninfo.sysid == 3000) {
            [guoguaninfo release];
            return;
        }
        
        
//        caiguola.text = guoguaninfo.caiguo;
        NSLog(@"caiguola.text = %@", guoguaninfo.caiguo);
        NSArray *caiguolaNum = [guoguaninfo.caiguo componentsSeparatedByString:@","];
//        for (NSString *str in caiguolaNum) {
//            NSLog(@"caiguolaNum %@",str);
//        }
        for (int i = 0; i< ([guoguaninfo.caiguo length]+1)/2; i++) {
            UILabel *caiGuoLaBg = [[[UILabel alloc] init] autorelease];
            caiGuoLaBg.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:59.0/255.0 blue:48.0/255.0 alpha:1];
            caiGuoLaBg.frame = CGRectMake(5+i*11, 0, 9, 15);
            if ([caiguolaNum count] > i) {
                caiGuoLaBg.text = [caiguolaNum objectAtIndex:i];
            }else{
                caiGuoLaBg.text = @"";
            }
            
            caiGuoLaBg.textAlignment = NSTextAlignmentCenter;
            caiGuoLaBg.textColor = [UIColor whiteColor];
            caiGuoLaBg.font = [UIFont systemFontOfSize:11];
            [caiguola addSubview:caiGuoLaBg];
        }
        
        
        xiaoshoula.text = @"销售";
        xiaoshoula.textColor = [UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1];
        CGSize maxSize2 = CGSizeMake(50, 20);
        CGSize expectedSize2 = [xiaoshoula.text sizeWithFont:xiaoshoula.font constrainedToSize:maxSize2 lineBreakMode:UILineBreakModeWordWrap];
        xiaoshoula.frame = CGRectMake(15, 15, expectedSize2.width, expectedSize2.height);
        
        xiaoliangla.text = [NSString stringWithFormat:@"%@", guoguaninfo.quanguo];
        xiaoliangla.textColor = [UIColor colorWithRed:242.0/255.0 green:61.0/255.0 blue:61.0/255.0 alpha:1];
        CGSize maxSize = CGSizeMake(120, 15);
        CGSize expectedSize = [xiaoliangla.text sizeWithFont:xiaoliangla.font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
        xiaoliangla.frame = CGRectMake(20+expectedSize2.width+3, 13, expectedSize.width, expectedSize.height);
        
        
        yuanla.frame = CGRectMake(20+expectedSize2.width+expectedSize.width+3+3, 15, 13, 15);
        yuanla.text = @"元";
        yuanla.textColor = [UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1];
        [guoguaninfo release];
        
        
#ifdef isCaiPiaoForIPad
        xiaoshoula.frame = CGRectMake(20+35, 7, expectedSize2.width, expectedSize2.height);
        xiaoliangla.frame = CGRectMake(20+35+expectedSize2.width+3, 7, expectedSize.width, expectedSize.height);
        yuanla.frame = CGRectMake(20+35+expectedSize2.width+expectedSize.width+3+3, 7, 13, 15);

#endif
        
    }
}

//请求期号
- (void)getIssueListRequest
{
    // 1 北京单场；4 进球彩； 6 六场半全；10 竞彩足球； 14 胜负彩
    int lotteryType = 300;
    // int lotteryType = 14;
    //    if (betInfo.lotteryType == TYPE_ZC_BANQUANCHANG) {
    //        lotteryType = 6;
    //    } else if (betInfo.lotteryType == TYPE_ZC_JINQIUCAI) {
    //        lotteryType = 4;
    //    }
    NSMutableData * postData = [[GC_HttpService sharedInstance] reqGetIssueList:lotteryType count:10];
    //NSMutableData *postData = [[GC_HttpService sharedInstance] reqGetZucaiJingcaiIssueList:lotteryType];
    NSLog(@"lotter = %d", lotteryType);
    NSLog(@"url = %@", [GC_HttpService sharedInstance].hostUrl);
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(reqIssueListFinished:)];
    [httpRequest startAsynchronous];
}

- (void)questGuoGuanTongJi{
    if (panduan) {
        [allArray removeAllObjects];
        
    }
    NSInteger page = [allArray count]/20 +1;
	if ([allArray count]%20 != 0) {
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
		[cai showMessage:@"加载完毕"];
        [moreCell setInfoText:@"加载完毕"];
        return;
	}
    NSMutableData * postData= nil;
    // NSLog(@"issuestring = %@", issuestring);
    // NSLog(@"page = %d", page);
    
    
    if (ggType == WoDeGuoGuanType) {
        mehe = YES;
        NSString * cai = @"";
        if (renorsheng == renjiu) {
            cai = @"301";
        }else{
            cai = @"300";
        }
        
        postData = [[GC_HttpService sharedInstance] reqGuoGuanTongJiUserName:[[[Info getInstance] mUserInfo] user_name] caizhong:cai issue:@"" wanfa:@"01" meiyejilushu:20 dangqianye:page];
    }else
      
        if (ggType != WoDeGuoGuanType) {
//            NSArray * arr = [issueLabel.text componentsSeparatedByString:@" "];
            
            if (ggType == shengFuCaiType) {
                mehe = NO;
                postData = [[GC_HttpService sharedInstance] reqGuoGuanTongJiUserName:@"" caizhong:@"300" issue:issuestring wanfa:@"01" meiyejilushu:20 dangqianye:page];
            }else{
                postData = [[GC_HttpService sharedInstance] reqGuoGuanTongJiUserName:@"" caizhong:@"301" issue:issuestring wanfa:@"01" meiyejilushu:20 dangqianye:page];
            }
        }
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(returnGuoGuanTongJi:)];
    [httpRequest startAsynchronous];
}

- (void)returnGuoGuanTongJi:(ASIHTTPRequest*)mrequest{
    GCGuoGuanData *personalData = [[GCGuoGuanData alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
    if (personalData.sysid == 3000) {
        [personalData release];
        return;
    }
    
    [allArray addObjectsFromArray:personalData.allArray];
    
    
    [personalData release];
    
    if(personalData.allArray.count)
    {
        [myTabelview reloadData];
    }
//    [myTabelview reloadData];
    panduan = NO;
    [moreCell spinnerStopAnimating];
//    if ([issuestring isEqualToString:@"我的中奖"]) {
//        xiaoshoula.text = @"";
//        caiguola.text = @"";
//        
//        xiaoliangla.text = @"";
//        yuanla.text = @"";
//    }else{
//        [self guoGuanTongJiXinXi];
//    }
    [self guoGuanTongJiXinXi];
}




- (void)reqIssueListFinished:(ASIHTTPRequest*)_request
{
    
    if ([_request responseData]) {
        GuoGuanIssue *issuelist = [[GuoGuanIssue alloc] initWithResponseData:[_request responseData]WithRequest:_request];
        //  self.issueDetails = issuelist.details;
        //  NSLog(@"%@", issuelist.details);
        
        if (issuelist.returnid == 3000) {
            [issuelist release];
            return;
        }
        
        if (issuelist.details.count > 0) {
       
            for (GuoGuanIssueDetail *_detail in issuelist.details) {
                
               
                [issueArray addObject:_detail.issue];
          
                
                NSLog(@"issue = %@", _detail.issue);
                NSLog(@"idsd = %@", _detail.status);
            }
            issuestring = [issueArray objectAtIndex:0];
            issuecount = 0;
            issueLabel.text = [NSString stringWithFormat:@"%@期", issuestring];
            
        }
        [issuelist release];
    }
   
    [self questGuoGuanTongJi];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    

    issueArray = [[NSMutableArray alloc] initWithCapacity:0];
    allArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgimage.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:bgimage];
    [bgimage release];
    
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = left;
    
    
//    UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
//    rigthItem.bounds = CGRectMake(0, 0, 60, 44);
//    [rigthItem setTitle:@"首页" forState:UIControlStateNormal];
//    [rigthItem addTarget:self action:@selector(pressHome) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
//    self.CP_navigation.rightBarButtonItem = rigthItemButton;
//    [rigthItemButton release];
    
    
          
    if (ggType == WoDeGuoGuanType) {
        
        self.CP_navigation.title = @"我的中奖";
    }else{
        
        UIButton * issuebut = [UIButton buttonWithType:UIButtonTypeCustom];
        
#ifdef isCaiPiaoForIPad
        issuebut.frame = CGRectMake(80+35, 7, 150, 30);
#else
        issuebut.frame = CGRectMake(80, 7, 150, 30);
#endif
        [issuebut addTarget:self action:@selector(pressIssueBut:) forControlEvents:UIControlEventTouchUpInside];
        issuestring = @"";
        issueLabel = [[UILabel alloc] initWithFrame:issuebut.bounds];
        issueLabel.textAlignment = NSTextAlignmentCenter;
        issueLabel.text = [NSString stringWithFormat:@"胜负彩 %@", issuestring];
        issueLabel.backgroundColor = [UIColor clearColor];
        issueLabel.font = [UIFont boldSystemFontOfSize:17];
        issueLabel.textColor = [UIColor whiteColor];
        [issuebut addSubview:issueLabel];
        
        UIImageView * sanjiaoImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]] autorelease];
        sanjiaoImageView.frame = CGRectMake(issueLabel.frame.origin.x + issueLabel.frame.size.width - 42, 8, 17, 17);
        [issuebut addSubview:sanjiaoImageView];
        
        self.CP_navigation.titleView = issuebut;
    }

    
   
    

#ifndef isCaiPiaoForIPad
    
    UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *imagerigthItem = UIImageGetImageFromName(@"wb61.png");
    rigthItem.bounds = CGRectMake(0, 0, 60, 44);
//    [rigthItem setImage:imagerigthItem forState:UIControlStateNormal];
    [rigthItem setTitle:@"首页" forState:UIControlStateNormal];
    [rigthItem addTarget:self action:@selector(doPushHomeView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
    self.CP_navigation.rightBarButtonItem = rigthItemButton;
    [rigthItemButton release];
#endif
    
    
    
    
    
    xiaoshoula = [[UILabel alloc] init];
    xiaoshoula.backgroundColor = [UIColor clearColor];
    xiaoshoula.textAlignment = NSTextAlignmentRight;
    xiaoshoula.font = [UIFont systemFontOfSize:12];
    [self.mainView addSubview:xiaoshoula];
    [xiaoshoula release];
    
    xiaoliangla = [[UILabel alloc] init];
    xiaoliangla.backgroundColor = [UIColor clearColor];
    xiaoliangla.textAlignment = NSTextAlignmentCenter;
    xiaoliangla.font = [UIFont systemFontOfSize:15];
    xiaoliangla.textColor = [UIColor redColor];
    [self.mainView addSubview:xiaoliangla];
    [xiaoliangla release];
    
    yuanla = [[UILabel alloc] init];
    yuanla.backgroundColor = [UIColor clearColor];
    yuanla.textAlignment = NSTextAlignmentLeft;
    yuanla.font = [UIFont systemFontOfSize:12];
    [self.mainView addSubview:yuanla];
    [yuanla release];
    
    
    
    
    
//    UIImageView * caiGuoImage = [[UIImageView alloc] initWithFrame:CGRectMake(150, 5, 150, 20)];
//    caiGuoImage.backgroundColor = [UIColor clearColor];
//    caiGuoImage.image = [UIImageGetImageFromName(@"GC_sqkjback.png")stretchableImageWithLeftCapWidth:5 topCapHeight:5];
//    [self.mainView addSubview:caiGuoImage];
    
    
    caiguola = [[UIView alloc] initWithFrame:CGRectMake(150, 15, 180, 20)];
    caiguola.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:caiguola];
    [caiguola release];
    
    
    
    myTabelview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, self.mainView.bounds.size.height-49-40)];
#ifdef isCaiPiaoForIPad
    caiGuoImage.frame = CGRectMake(150+35, 5, 150, 20);
    myTabelview.frame = CGRectMake(35, 30, 320, self.mainView.bounds.size.height - 49-30);
#endif
    myTabelview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTabelview.delegate = self;
    myTabelview.dataSource = self;
    myTabelview.backgroundColor = [UIColor clearColor];
    myTabelview.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTabelview.showsVerticalScrollIndicator = NO;
    [self.mainView addSubview:myTabelview];
    
    UIView *lineView = [[[UIView alloc] init] autorelease];
    lineView.frame = CGRectMake(0, 0, 320, 0.5);
    lineView.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    [myTabelview addSubview:lineView];
    
    
    
    
    
    [self getIssueListRequest];
    
}

-(void)pressHome
{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}

- (void)pressIssueBut:(UIButton *)sender{
    
    if ([issueArray count] >= 5) {
        NSString * s1 = [NSString stringWithFormat:@"%@期", [issueArray objectAtIndex:0]];
        NSString * s2 = [NSString stringWithFormat:@"%@期", [issueArray objectAtIndex:1]];
        NSString * s3 = [NSString stringWithFormat:@"%@期", [issueArray objectAtIndex:2]];
        NSString * s4 = [NSString stringWithFormat:@"%@期", [issueArray objectAtIndex:3]];
        NSString * s5 = [NSString stringWithFormat:@"%@期", [issueArray objectAtIndex:4]];

       
        
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        [lb LoadButtonName:[NSArray arrayWithObjects: s1, s2, s3,s4, s5, nil]];
        [lb show];
        [lb release];
    }
    
    
}

// 下面的分栏控制器
- (void)otherLottoryViewController:(NSInteger)indexd{
    
    MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
    my.userName = gcgginfo.username;
    my.nickName = gcgginfo.nickName;
    my.userid = gcgginfo.userid;
    
    NSLog(@"my.userName = %@ my.nickName = %@", gcgginfo.username,gcgginfo.nickName);
    
    MyLottoryViewController *my2 = [[MyLottoryViewController alloc] init];
    my2.myLottoryType = MyLottoryTypeOtherHe;
    my2.userName = gcgginfo.username;
    my2.nickName = gcgginfo.nickName;
    my2.userid = gcgginfo.userid;
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:my, my2, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"他的彩票"];
    [labearr addObject:@"他的合买"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"goucaizubai.png"];
    [imagestring addObject:@"goucaihemaibai.png"];
    
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"tabbg_zulan.png"];
    [imageg addObject:@"tabbg_hemai.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    tabc.selectedIndex = indexd;

    //  tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    [self.navigationController pushViewController:tabc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [tabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [my2 release];
    [my release];
}

- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (liebiaoView.tag == 2) {
        if (buttonIndex == 0) {//他的彩票
            //            MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
            //            my.userName = gcgginfo.username;
            //            my.nickName = gcgginfo.nickName;
            //            [self.navigationController pushViewController:my animated:YES];
            //            my.title = gcgginfo.nickName;
            //            [my release];
            [MobClick event:@"event_goumai_guoguantongji_tadecaipiao"];
            [self otherLottoryViewController:0];
        }else if(buttonIndex == 1){
            //他的合买
            //            MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
            //            my.myLottoryType = MyLottoryTypeOtherHe;
            //            my.userName = gcgginfo.username;
            //            my.nickName = gcgginfo.nickName;
            //            [self.navigationController pushViewController:my animated:YES];
            //            my.title = gcgginfo.nickName;
            //            [my release];
            [MobClick event:@"event_goumai_guoguantongji_tadehemai"];
            [self otherLottoryViewController:1];
        }else if (buttonIndex == 2){ // @他
            [MobClick event:@"event_goumai_guoguantongji_atta"];
            
#ifdef isCaiPiaoForIPad
            YtTopic *topic1 = [[YtTopic alloc] init];
            NSMutableString *mTempStr = [[NSMutableString alloc] init];
            [mTempStr appendString:@"@"];
            [mTempStr appendString:gcgginfo.nickName];//传用户名
            [mTempStr appendString:@" "];
            topic1.nick_name = mTempStr;
            [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kNewTopicController mStatus:topic1];
            
            [topic1 release];
#else
            
//            NewPostViewController *publishController = [[NewPostViewController alloc] init];
//            publishController.publishType = kNewTopicController;// 自发彩博
//            YtTopic *topic1 = [[YtTopic alloc] init];
//            NSMutableString *mTempStr = [[NSMutableString alloc] init];
//            [mTempStr appendString:@"@"];
//            [mTempStr appendString:gcgginfo.nickName];//传用户名
//            [mTempStr appendString:@" "];
//            topic1.nick_name = mTempStr;
//            publishController.mStatus = topic1;
//            [self.navigationController pushViewController:publishController animated:YES];
//            [topic1 release];
//            [mTempStr release];
//            [publishController release];
            
            
            SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
            publishController.microblogType = NewTopicController;// 自发彩博
            YtTopic *topic1 = [[YtTopic alloc] init];
            NSMutableString *mTempStr = [[NSMutableString alloc] init];
            [mTempStr appendString:@"@"];
            [mTempStr appendString:gcgginfo.nickName];//传用户名
            [mTempStr appendString:@" "];
            topic1.nick_name = mTempStr;
            [mTempStr release];
            publishController.mStatus = topic1;
            [topic1 release];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
            [self presentViewController:nav animated: YES completion:nil];
            [publishController release];
            [nav release];
#endif
        }else if (buttonIndex == 3){ // 他的微博
            [MobClick event:@"event_goumai_guoguantongji_tadeweibo"];
            [useridRequest clearDelegatesAndCancel];
            self.useridRequest = [ASIHTTPRequest requestWithURL:[NetURL cpThreeUserName:gcgginfo.username]];
            [useridRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [useridRequest setDelegate:self];
            [useridRequest setDidFinishSelector:@selector(useridRequestDidFinishSelector:)];
            [useridRequest setNumberOfTimesToRetryOnTimeout:2];
            [useridRequest startAsynchronous];
            
            
            
        }else if (buttonIndex == 4){//他的资料
            [MobClick event:@"event_goumai_guoguantongji_tadeziliao"];
            ProfileViewController *followeesController = [[ProfileViewController alloc] init];
            followeesController.himNickName = gcgginfo.nickName;
            [self.navigationController pushViewController:followeesController animated:YES];
            [followeesController release];
        }
        
    }else{
        if (buttonIndex == 0) {//
            issuecount = 0;
            issuestring = [issueArray objectAtIndex:0];
            issueLabel.text = [NSString stringWithFormat:@"%@期", issuestring];
            
            
        }else if (buttonIndex == 1){ //
            issuecount = 1;
            issuestring = [issueArray objectAtIndex:1];
            issueLabel.text = [NSString stringWithFormat:@"%@期", issuestring];
            
        }else if (buttonIndex == 2){ //
            issuecount = 2;
            issuestring = [issueArray objectAtIndex:2];
            issueLabel.text = [NSString stringWithFormat:@"%@期", issuestring];
            
        }else if (buttonIndex == 3){
            issuecount = 3;
            issuestring = [issueArray objectAtIndex:3];
            issueLabel.text = [NSString stringWithFormat:@"%@期", issuestring];
            
        }else if(buttonIndex == 4){
            issuecount = 4;
            issuestring = [issueArray objectAtIndex:4];
            issueLabel.text = [NSString stringWithFormat:@"%@期", issuestring];
            
        }
//        else if (buttonIndex == 5){
//            issuecount = 5;
//            issuestring = [issueArray objectAtIndex:2];
//            issueLabel.text = [NSString stringWithFormat:@"胜负彩 %@期", issuestring];
//            
//        }else if(buttonIndex == 6){
//            issuecount = 6;
//            issuestring = [issueArray objectAtIndex:2];
//            issueLabel.text = [NSString stringWithFormat:@"任选九 %@期", issuestring];
//            
//        }else if(buttonIndex == 7){
//            issuecount = 7;
//            issuestring = [issueArray objectAtIndex:3];
//            issueLabel.text = [NSString stringWithFormat:@"胜负彩 %@期", issuestring];
//            
//        }else if(buttonIndex == 8){
//            issuecount = 8;
//            issuestring = [issueArray objectAtIndex:3];
//            issueLabel.text = [NSString stringWithFormat:@"任选九 %@期", issuestring];
//            
//        }else if(buttonIndex == 9){
//            issuecount = 9;
//            issuestring = [issueArray objectAtIndex:4];
//            issueLabel.text = [NSString stringWithFormat:@"胜负彩 %@期", issuestring];
//            
//        }else if(buttonIndex == 10){
//            issuecount = 10;
//            issuestring = [issueArray objectAtIndex:4];
//            issueLabel.text = [NSString stringWithFormat:@"任选九 %@期", issuestring];
//            
//        }
        
        panduan = YES;
        [self questGuoGuanTongJi];
        
    }
}

- (void)useridRequestDidFinishSelector:(ASIHTTPRequest *)mrequest{
    
    if (mrequest) {
        NSString * str = [mrequest responseString];
        
        NSDictionary * dict = [str JSONValue];
        NSString * codestr = [dict objectForKey:@"code"];
        if([codestr isEqualToString:@"1"]){
            NSString * useridst = [dict objectForKey:@"userid"];
//            useridstring = useridst;
            TwitterMessageViewController *controller = [[TwitterMessageViewController alloc] init];
            controller.userID = useridst;
            controller.title = @"他的微博";
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
            //            ProfileTabBarController *controller = [[ProfileTabBarController alloc] initWithUerself:NO userID:useridst];//himID传用户的id
            //            [controller setSelectedIndex:0];
            //            controller.navigationItem.title = @"微博";
            //            [self.navigationController pushViewController:controller animated:YES];
            //            [controller release];
            
        }
        else {
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"获取失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            [alert show];
            [alert release];
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		return 60;
	}
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return [allArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == [allArray count]) {
        static NSString *CellIdentifier = @"Cell";
        CellIdentifier = @"MoreLoadCell";
        
        MoreLoadCell *cell1 = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell1 == nil) {
            cell1 = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            
            [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
            //moreCell.backgroundColor = [UIColor clearColor];
        }
        
        if (moreCell == nil) {
            self.moreCell = cell1;
        }
        if ([tableView numberOfRowsInSection:0] > 1) {
            [moreCell spinnerStartAnimating];
            [self questGuoGuanTongJi];//网络请求函数
        }
        return cell1;
    }else{
        NSString * cellid = @"cellid";
        GCGuoGuanCell * cell = (GCGuoGuanCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[[GCGuoGuanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            
        }
        if (indexPath.row == [allArray count]) {
            cell.cellLine.hidden = YES;
            cell.cellLine2.hidden = NO;
        }else{
            cell.cellLine2.hidden = YES;
            cell.cellLine.hidden = NO;
        }
        cell.delegate = self;
        
        
        //            if ([issueLabel.text isEqualToString:@"我的中奖"]) {
        //
        //                cell.panduanme = YES;
        //            }else{
        //                cell.panduanme = NO;
        //            }
        //
        
        
        cell.rowcount = indexPath;
        GCGuoGuanDataDetail * guodata = nil;
        if ([allArray count] != 0) {
            guodata = [allArray objectAtIndex:indexPath.row];
        }
        
        if([guodata.username isEqualToString:[[[Info getInstance] mUserInfo] user_name]]){
            cell.panduanme = YES;
        }else{
            cell.panduanme = NO;
            
        }
        
//        if (ggType == WoDeGuoGuanType) {
//            cell.userName.frame = CGRectMake(15, 16, 65, 30);
//            cell.userName.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
//        }
        
        
        cell.guoGuanData = guodata;
        
        return cell;
        
    }
    return nil;
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (myTabelview.contentSize.height-scrollView.contentOffset.y<=360.0 && myTabelview.contentOffset.y > 0) {
        //        if (!isAllRefresh) {
        [self performSelector:@selector(questGuoGuanTongJi) withObject:nil afterDelay:0.5];
        [moreCell spinnerStartAnimating];
        //        }
	}
    //	[mRefreshView CBRefreshScrollViewDidEndDragging:scrollView];
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [allArray count]) {
        [moreCell spinnerStartAnimating];
        [self questGuoGuanTongJi];//网络请求函数
    }else{
        
        if (mehe) {
            
            
            GCGuoGuanDataDetail * guodetail = [allArray objectAtIndex:indexPath.row];
            
            
            //                    if ([guodetail.baomi isEqualToString:@"4"]) {
            //                        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            //                        [cai showMessage:@"隐藏方案不能查看"];
            //
            //                    }else
            //                    if ([guodetail.baomi isEqualToString:@"1"]) {
            //
            //                        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            //                        [cai showMessage:@"保密方案不能查看"];
            //
            //                    }else
            if([guodetail.username isEqualToString:[[[Info getInstance] mUserInfo] user_name]]){
                ShuangSeQiuInfoViewController *shuang = [[ShuangSeQiuInfoViewController alloc] init];
                //                        shuang.BetInfo.lotteryNum = @"300";
                //                        GCGuoGuanDataDetail * num = [allArray objectAtIndex:indexPath.row];
                //                        shuang.BetInfo.programNumber = num.fanganbianh;
                //                        shuang.BetInfo.issue = @"-";
                //                        shuang.BetInfo.lotteryName = @"胜负彩";
                shuang.guoguanme = YES;
                shuang.hemaibool = NO;
                shuang.nikeName = guodetail.username;
                BetRecordInfor * betinfo = [[BetRecordInfor alloc] init];
                GCGuoGuanDataDetail * num = [allArray objectAtIndex:indexPath.row];
                betinfo.programNumber = num.fanganbianh;
//                betinfo.issue = issuestring;
                
                if (ggType != WoDeGuoGuanType) {
//                    NSArray * arr = [issueLabel.text componentsSeparatedByString:@" "];
                    
                    if (ggType == shengFuCaiType) {
                        betinfo.lotteryNum = @"300";
                        
                        betinfo.lotteryName = @"胜负彩";
                    }else{
                        betinfo.lotteryNum = @"301";
                        betinfo.lotteryName = @"任选九";
                    }
                    
                }else{
                    betinfo.lotteryNum = @"300";
                    
                    betinfo.lotteryName = @"胜负彩";
                }
                
                
                
                //                            if (issuecount < 6) {
                //                                betinfo.lotteryNum = @"300";
                //                                betinfo.lotteryName = @"胜负彩";
                //                            }else{
                //                                betinfo.lotteryNum = @"301";
                //                                betinfo.lotteryName = @"任选九";
                //
                //                            }
                
                shuang.BetInfo = betinfo;
                [betinfo release];
                
                //					shuang.BetInfo = [allRecord.brInforArray objectAtIndex:indexPath.row];
                shuang.isMine = YES;
                [self.navigationController pushViewController:shuang animated:YES];
                [shuang release];
                
            }else{
                ShuangSeQiuInfoViewController *shuang = [[ShuangSeQiuInfoViewController alloc] init];
                shuang.nikeName = guodetail.username;
                shuang.guoguanme = YES;
                shuang.hemaibool = NO;
                BetRecordInfor * betinfo = [[BetRecordInfor alloc] init ];
                
                GCGuoGuanDataDetail * num = [allArray objectAtIndex:indexPath.row];
                betinfo.programNumber = num.fanganbianh;
//                betinfo.issue = issuestring;
                //                        if (issuecount < 6) {
                //                            betinfo.lotteryNum = @"300";
                //                            betinfo.lotteryName = @"胜负彩";
                //                        }else{
                //                            betinfo.lotteryNum = @"301";
                //                            betinfo.lotteryName = @"任选九";
                //
                //                        }
                
                if (ggType != WoDeGuoGuanType) {
//                    NSArray * arr = [issueLabel.text componentsSeparatedByString:@" "];
                    
                    if (ggType == shengFuCaiType) {
                        betinfo.lotteryNum = @"300";
                        betinfo.lotteryName = @"胜负彩";
                    }else{
                        betinfo.lotteryNum = @"301";
                        betinfo.lotteryName = @"任选九";
                    }
                    
                }
                
                
                shuang.BetInfo = betinfo;
                [betinfo release];
                
                //					shuang.BetInfo = [allRecord.brInforArray objectAtIndex:indexPath.row];
                shuang.isMine = YES;
                [self.navigationController pushViewController:shuang animated:YES];
                [shuang release];
            }
        }else {
            
            
            GCGuoGuanDataDetail * guodetail = nil;
            if ([allArray count] != 0) {
                guodetail = [allArray objectAtIndex:indexPath.row];
            }
            NSLog(@"baomi = %@", guodetail.baomi);
            
            if ([guodetail.baomi isEqualToString:@"4"]) {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"隐藏方案不能查看"];
            }else
                
                
                if ([guodetail.baomi isEqualToString:@"1"])
                {//||[guodetail.baomi isEqualToString:@"3"]

// ****
//                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
//                    [cai showMessage:@"保密方案不能查看"];
//                    
                    
                    ShuangSeQiuInfoViewController *shuang = [[ShuangSeQiuInfoViewController alloc] init];
                    //						shuang.BetInfo = [allRecord.brInforArray objectAtIndex:indexPath.row];
                    shuang.isMine = NO;
                    shuang.nikeName = guodetail.username;
                    BetRecordInfor * betinfo = [[BetRecordInfor alloc] init ];
                    
                    GCGuoGuanDataDetail * num = [allArray objectAtIndex:indexPath.row];
                    betinfo.programNumber = num.fanganbianh;

                    if (ggType != WoDeGuoGuanType) {
                        //                        NSArray * arr = [issueLabel.text componentsSeparatedByString:@" "];
                        
                        if (ggType == shengFuCaiType) {
                            betinfo.lotteryNum = @"300";
                            betinfo.lotteryName = @"胜负彩";
                        }else{
                            betinfo.lotteryNum = @"301";
                            betinfo.lotteryName = @"任选九";
                        }
                        
                    }
                    
                    shuang.BetInfo = betinfo;
                    [betinfo release];
                    //                        shuang.BetInfo.lotteryNum = @"300";
                    //                        GCGuoGuanDataDetail * num = [allArray objectAtIndex:indexPath.row];
                    //                        shuang.BetInfo.programNumber = num.fanganbianh;
                    //                        shuang.BetInfo.issue = issuestring;
                    //                        shuang.BetInfo.lotteryName = @"胜负彩";
                    [self.navigationController pushViewController:shuang animated:YES];
                    [shuang release];
                    
                    
                }else if([guodetail.username isEqualToString:[[[Info getInstance] mUserInfo] user_name]])
                {
                    
                    
                    
                    ShuangSeQiuInfoViewController *shuang = [[ShuangSeQiuInfoViewController alloc] init];
                    //						shuang.BetInfo = [allRecord.brInforArray objectAtIndex:indexPath.row];
                    shuang.isMine = NO;
                    shuang.nikeName = guodetail.username;
                    BetRecordInfor * betinfo = [[BetRecordInfor alloc] init ];
                    
                    GCGuoGuanDataDetail * num = [allArray objectAtIndex:indexPath.row];
                    betinfo.programNumber = num.fanganbianh;
//                    betinfo.issue = issuestring;
                    //                        if (issuecount < 6) {
                    //                            betinfo.lotteryNum = @"300";
                    //                            betinfo.lotteryName = @"胜负彩";
                    //                        }else{
                    //                            betinfo.lotteryNum = @"301";
                    //                            betinfo.lotteryName = @"任选九";
                    //
                    //                        }
                    
                    if (ggType != WoDeGuoGuanType) {
//                        NSArray * arr = [issueLabel.text componentsSeparatedByString:@" "];
                        
                        if (ggType == shengFuCaiType) {
                            betinfo.lotteryNum = @"300";
                            betinfo.lotteryName = @"胜负彩";
                        }else{
                            betinfo.lotteryNum = @"301";
                            betinfo.lotteryName = @"任选九";
                        }
                        
                    }
                    
                    shuang.BetInfo = betinfo;
                    [betinfo release];
                    //                        shuang.BetInfo.lotteryNum = @"300";
                    //                        GCGuoGuanDataDetail * num = [allArray objectAtIndex:indexPath.row];
                    //                        shuang.BetInfo.programNumber = num.fanganbianh;
                    //                        shuang.BetInfo.issue = issuestring;
                    //                        shuang.BetInfo.lotteryName = @"胜负彩";
                    [self.navigationController pushViewController:shuang animated:YES];
                    [shuang release];
                    
                }else{
                   
                    ShuangSeQiuInfoViewController *shuang = [[ShuangSeQiuInfoViewController alloc] init];
                    //						shuang.BetInfo = [allRecord.brInforArray objectAtIndex:indexPath.row];
                    shuang.isMine = NO;
                    shuang.nikeName = guodetail.username;
                    BetRecordInfor * betinfo = [[BetRecordInfor alloc] init ];
                    
                    GCGuoGuanDataDetail * num = [allArray objectAtIndex:indexPath.row];
                    betinfo.programNumber = num.fanganbianh;
//                    betinfo.issue = issuestring;
                    //                        if (issuecount < 6) {
                    //                            betinfo.lotteryNum = @"300";
                    //                            betinfo.lotteryName = @"胜负彩";
                    //                        }else{
                    //                            betinfo.lotteryNum = @"301";
                    //                            betinfo.lotteryName = @"任选九";
                    //
                    //                        }
                    
                    if (ggType != WoDeGuoGuanType) {
//                        NSArray * arr = [issueLabel.text componentsSeparatedByString:@" "];
                        
                        if (ggType == shengFuCaiType) {
                            betinfo.lotteryNum = @"300";
                            betinfo.lotteryName = @"胜负彩";
                        }else{
                            betinfo.lotteryNum = @"301";
                            betinfo.lotteryName = @"任选九";
                        }
                        
                    }
                    
                    shuang.BetInfo = betinfo;
                    [betinfo release];
                    //                        shuang.BetInfo.lotteryNum = @"300";
                    //                        GCGuoGuanDataDetail * num = [allArray objectAtIndex:indexPath.row];
                    //                        shuang.BetInfo.programNumber = num.fanganbianh;
                    //                        shuang.BetInfo.issue = issuestring;
                    //                        shuang.BetInfo.lotteryName = @"胜负彩";
                    [self.navigationController pushViewController:shuang animated:YES];
                    [shuang release];
                }
            
        }
        
        
        
    }
    
    return;
}

- (void)returnGuoGanInfo:(GCGuoGuanDataDetail *)ggdata indexr:(NSIndexPath *)indexrow{
    gcgginfo = nil;
    gcgginfo = ggdata;
    
    if(![gcgginfo.username isEqualToString:[[[Info getInstance] mUserInfo] user_name]]){
        
      
        
        CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        lb.delegate = self;
        lb.tag = 2;
        [lb LoadButtonName:[NSArray arrayWithObjects:@"他的彩票", @"他的合买", @"@他", @"他的微博",@"他的资料", nil]];
        [lb show];
        [lb release];
    }else{
        
        [self  tableView:myTabelview didSelectRowAtIndexPath:indexrow];
    }
    
    
    
    
}


- (void)dealloc{
    
    [useridRequest clearDelegatesAndCancel];
    [useridRequest release];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [issueArray release];
    [allArray release];
    [super dealloc];
//    self.moreCell = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    