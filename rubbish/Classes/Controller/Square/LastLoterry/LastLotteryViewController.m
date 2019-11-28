//
//  LastLotteryViewController.m
//  caibo
//
//  Created by user on 11-10-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LastLotteryViewController.h"
#import "LastLotteryCell.h"
#import "Info.h"
#import "ImageStoreReceiver.h"
#import "LastLotteryParser.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "LastLottery.h"

#import "LotteryListViewController.h"
#import "LotteryButton.h"
#import "KJButtdata.h"
#import "kjButtCellTuiSong.h"
#import "JSON.h"
#import "AnnouncementData.h"
#import "AnnouncementCell.h"
#import "MyLottoryViewController.h"
#import "NewPostViewController.h"
#import "ProfileTabBarController.h"
#import "LoginViewController.h"
#import "ProfileViewController.h"
#import "TuisongtongzhiButtonController.h"
#import "KJXiangQingViewController.h"
#import "MobClick.h"
#import "footballLotteryInfoViewController.h"
#import "SendMicroblogViewController.h"
//#import "moneyViewController.h"
#import "SharedDefine.h"

#define KBALLPICWIDTH 20
#define KSPACE 5
#define KNUMBERPERLOW   7

@implementation LastLotteryViewController

@synthesize aRequest,lotteries,mRefreshView, redRequest;
@synthesize tuisongb, lotteryName;
@synthesize seachTextListarry;
#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle

- (void)changeToWeiboModel {
	
}


- (void)changeToClassicModel
{
	self.navigationItem.rightBarButtonItem = [Info barItemWithImage:@"classmodel.png" addTarget:self action:@selector(changeToClassicModel)];
}


- (void)viewDidLoad {
	[super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    arrdict = [[NSMutableArray alloc] initWithCapacity:0];
    redDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    //self.title = @"开奖";
    [MobClick event:@"event_kaijiang_bangdan"];
    self.CP_navigation.title = @"开奖大厅";
    baocunArray = [[NSMutableArray alloc] initWithCapacity:0];
    statusData = [[NSMutableArray alloc] initWithCapacity:0];
    alldatabool = [[NSMutableArray alloc] initWithCapacity:0];
    if ([self.navigationController.viewControllers count] > 1) {
        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
        //self.navigationItem.leftBarButtonItem = leftItem;
        self.CP_navigation.leftBarButtonItem = leftItem;
    }
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    bgimage.image = UIImageGetImageFromName(@"login_bgn.png");
    bgimage.backgroundColor=[UIColor colorWithRed:239/255.0 green:238/255.0 blue:226/255.0 alpha:1];
    [self.mainView addSubview:bgimage];
   // self.tableView.backgroundView = bgimage;
    [bgimage release];
    
    
//    kaijiangbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    kaijiangbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//	kaijiangbtn.frame = CGRectMake(87, 9, 73, 32);
//	[kaijiangbtn setImage:UIImageGetImageFromName(@"GouCaibtn4_0.png") forState:UIControlStateSelected];
//	[kaijiangbtn setImage:UIImageGetImageFromName(@"GouCaibtn4_1.png") forState:UIControlStateHighlighted];
//	[kaijiangbtn setImage:UIImageGetImageFromName(@"GouCaibtn4.png") forState:UIControlStateNormal];
//    kaijiangbtn.selected = YES;
//    kaijiangbtn.tag = 11;
//    
//    [kaijiangbtn addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
//    UILabel * label3 = [[UILabel alloc] init];
//    label3.frame = kaijiangbtn.bounds;
//    [kaijiangbtn addSubview:label3];
//    label3.font = [UIFont systemFontOfSize:13];
//	label3.tag = 101;
//	label3.textColor = [UIColor whiteColor];
//	label3.backgroundColor = [UIColor clearColor];
//	label3.text = @"开奖";
//	label3.textAlignment = NSTextAlignmentCenter;
//	[label3 release];
//
//    
//    
//    bangdanbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    bangdanbtn.tag = 22;
//    bangdanbtn.frame = CGRectMake(160, 9, 73, 32);
//    UILabel * label4 = [[UILabel alloc] init];
//    label4.frame = bangdanbtn.bounds;
//    [bangdanbtn addSubview:label4];
//    label4.font = [UIFont systemFontOfSize:13];
//	label4.tag = 101;
//	label4.textColor = [UIColor whiteColor];
//	label4.backgroundColor = [UIColor clearColor];
//	label4.text = @"榜单";
//	label4.textAlignment = NSTextAlignmentCenter;
//	[label4 release];
//    [bangdanbtn setImage:UIImageGetImageFromName(@"GouCaibtn6_0.png") forState:UIControlStateSelected];
//	[bangdanbtn setImage:UIImageGetImageFromName(@"GouCaibtn6.png") forState:UIControlStateNormal];
//	[bangdanbtn setImage:UIImageGetImageFromName(@"GouCaibtn6_1.png") forState:UIControlStateHighlighted];
//    [bangdanbtn addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:kaijiangbtn];
//    [self.view addSubview:bangdanbtn];
    
    myTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320,   self.mainView.bounds.size.height - 49) style:UITableViewStylePlain];
    myTabelView.backgroundColor = [UIColor colorWithRed:247/255.0 green:241/255.0 blue:222/255.0 alpha:1];
    myTabelView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTabelView.delegate = self;
    myTabelView.dataSource  = self;
    [myTabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:myTabelView];
    
    
    
	if (!mRefreshView) 
    {
		UITableView *mTableView = myTabelView;
		CBRefreshTableHeaderView *headerview = 
		[[CBRefreshTableHeaderView alloc] 
		 initWithFrame:CGRectMake(0, -(mTableView.frame.size.height), mTableView.frame.size.width, mTableView.frame.size.height)];
        headerview.backgroundColor = [UIColor clearColor];
        self.mRefreshView = headerview;
		mRefreshView.delegate = self;
		[myTabelView addSubview:mRefreshView];
		[headerview release];
	}
//	self.navigationItem.rightBarButtonItem = [[Info barItemWithImage:@"weibomodel.png" addTarget:self action:@selector(changeToWeiboModel)] autorelease];
	
    
//    Info *info2 = [Info getInstance];
//    if (![info2.userId intValue]) {

//		UIBarButtonItem *rightItem = [Info longItemInitWithTitle:@"登录注册" Target:self action:@selector(doLogin)];
//        [self.navigationItem setRightBarButtonItem:rightItem];
//        [rightItem release];
//	}
//	else {
    
  

        
//    }

    
    
    
    
    
	[mRefreshView refreshLastUpdatedDate];
    [self CBRefreshTableHeaderDidTriggerRefresh:mRefreshView];
///todo	
	[self sendContentRequest];
	
    downview = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainView.bounds.size.height -90, 320, 44)];
    UIImageView * bgdownimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    bgdownimage.image = UIImageGetImageFromName(@"gc_footerBg.png");
    
    [downview addSubview:bgdownimage];
    [bgdownimage release];
    UIButton * buttondow = [UIButton buttonWithType:UIButtonTypeCustom];
    buttondow.frame = CGRectMake(125, 8, 70, 34);
    
    UILabel * qulabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 34)];
    qulabel.text = @"确定";
    qulabel.textAlignment = NSTextAlignmentCenter;
    qulabel.backgroundColor = [UIColor clearColor];
    [buttondow addSubview:qulabel];
    [qulabel release];
    
    [buttondow setImage:UIImageGetImageFromName(@"gc_footerBtnd.png") forState:UIControlStateNormal];
    [buttondow addTarget:self action:@selector(pressbuttondown:) forControlEvents:UIControlEventTouchUpInside];
    [downview addSubview:buttondow];
    downview.hidden = YES;
    [self.mainView addSubview:downview];
    
    
    bangdanview = [[UIView alloc] initWithFrame:CGRectMake(0, 42, 320, self.mainView.bounds.size.height -113)];
    bangdanview.hidden = YES;
    
    redTabelView = [[UITableView alloc] initWithFrame:CGRectMake(17, 0, 305, self.mainView.bounds.size.height -113) style:UITableViewStylePlain];
    redTabelView.backgroundColor = [UIColor clearColor];
    redTabelView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    redTabelView.delegate = self;
    redTabelView.dataSource  = self;
    [redTabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    redTabelView.tag = 111;
    [bangdanview addSubview:redTabelView];
    [self.mainView addSubview:bangdanview];
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"CPThree"];
    NSMutableArray * array = [ [ NSMutableArray alloc ] initWithContentsOfFile:plistPath ];
    if (array) {
        self.seachTextListarry = array;
    }
    else {
        self.seachTextListarry =[NSMutableArray array];
    }
    [array release];
   
}

- (void)doLogin {
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
    [loginVC release];
#endif
}



- (void)redRequesDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    
    NSDictionary * dict = [str JSONValue];
    NSLog(@"str = %@", dict);
    // arrdict = [dict allKeys];
    NSArray * arrkey = [dict allKeys];
    for (NSString * s in arrkey) {
        NSLog(@"s = %@", s);
        if (![s isEqualToString:@"code"]) {
            [arrdict addObject:s];
        }
        
    }
    
    for (int i = 0; i < [arrdict count]; i++) {
        //    NSLog(@"i = %d", i);
        NSString * st = [arrdict objectAtIndex:i];
        //   NSLog(@"st = %@", st);
        NSArray * arr = [dict objectForKey:st];
        //    NSLog(@"爱让人= %@", arr);
        NSMutableArray * dataarr = [[NSMutableArray alloc] initWithCapacity:0];
        
        
        for (NSDictionary * str in arr) {
            
            AnnouncementData * ann = [[AnnouncementData alloc] init];
            ann.money = [str objectForKey:@"awardMoney"];
			ann.userName = [str objectForKey:@"userName"];
            NSLog(@"anndata = %@",[str objectForKey:@"awardMoney"]);
            ann.level1 = [str objectForKey:@"level1"];
            ann.level2 = [str objectForKey:@"level2"];
            ann.level3 = [str objectForKey:@"level3"];
            ann.level4 = [str objectForKey:@"level4"];
            ann.level5 = [str objectForKey:@"level5"];
            ann.level6 = [str objectForKey:@"level6"];
            ann.imagestr = [str objectForKey:@"midImage"];
            NSLog(@"imagestr = %@", [str objectForKey:@"midImage"]);
            ann.user = [str objectForKey:@"nickName"];
            ann.userID = [str objectForKey:@"userId"];
            [dataarr addObject:ann];
            [ann release];
        }
        [redDictionary setObject:dataarr forKey:st];
        [dataarr release];
        
    }
    
    
    [redTabelView reloadData];
    
}

- (void)rightshanbutton{
   

    
    UIBarButtonItem *rightItem = [Info itemInitWithTitletwo:@"取消" Target:self action:@selector(actionSave:)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    [self performSelector:@selector(rightBarButtonItemxianshi) withObject:nil afterDelay:.1];
    
}


- (void)rightBarButtonItemxianshi{
    
    UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"取消" Target:self action:@selector(actionSave:)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    [self performSelector:@selector(rightbarbutonnil) withObject:nil afterDelay:0.1];
}

- (void)rightbarbutonnil{
    UIBarButtonItem *rightItem = [Info itemInitWithTitletwo:@"取消" Target:self action:@selector(actionSave:)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    [self performSelector:@selector(rightbarbuttonhiss) withObject:nil afterDelay:0.1];
}

- (void)rightbarbuttonhiss{
    UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"取消" Target:self action:@selector(actionSave:)];
    [self.navigationItem setRightBarButtonItem:rightItem];
     [self performSelector:@selector(rightbarbuttonzui) withObject:nil afterDelay:0.1];
}
- (void)rightbarbuttonzui{
    UIBarButtonItem *rightItem = [Info itemInitWithTitletwo:@"取消" Target:self action:@selector(actionSave:)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    [self performSelector:@selector(rightbatbuttonzuihou) withObject:nil afterDelay:0.1];

}
- (void)rightbatbuttonzuihou{
    UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"取消" Target:self action:@selector(actionSave:)];
    [self.navigationItem setRightBarButtonItem:rightItem];
 

}



- (void)pressTitleButton:(UIButton *)sender{
    kaijiangbtn.selected = NO;
    bangdanbtn.selected = NO;
    sender.selected = YES;
    if (sender.tag == 11) {
        if (tuisongb == NO) {
            tuisongb = NO;
            
//            Info *info2 = [Info getInstance];
//            if (![info2.userId intValue]) {
//                //		UIBarButtonItem *leftItem = [Info itemInitWithTitle:@"注册" Target:self action:@selector(doRegister)];
//                //		[self.navigationItem setLeftBarButtonItem:leftItem];
//                //		[leftItem release];
//                //        UIButton * buttxie = (UIButton *)[self.navigationItem.titleView viewWithTag:99];
//                //        buttxie.hidden = YES;
//                //        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];   
//                //        self.navigationItem.leftBarButtonItem = leftItem;  
//                //        [leftItem release];
//                UIBarButtonItem *rightItem = [Info longItemInitWithTitle:@"登录注册" Target:self action:@selector(doLogin)];
//                [self.navigationItem setRightBarButtonItem:rightItem];
//                [rightItem release];
//            }
//            else {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage *image = UIImageGetImageFromName(@"gc_gokj.png");
                [btn setImage:image forState:UIControlStateNormal];
                [btn setBounds:CGRectMake(0, 0, 87, 29)];
                
                UILabel * kaijiang  = [[UILabel alloc] initWithFrame:CGRectMake(28, 0, 62, 29)];
                kaijiang.textAlignment = NSTextAlignmentLeft;
                kaijiang.textColor = [UIColor whiteColor];
                kaijiang.backgroundColor = [UIColor clearColor];
                kaijiang.font = [UIFont boldSystemFontOfSize:13];
                kaijiang.text = @"开奖推送";
                [btn addSubview:kaijiang];
                [kaijiang release];
                
                [btn addTarget:self action:@selector(pressKaiJiangTuiSong:) forControlEvents:UIControlEventTouchUpInside];
                UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
                self.CP_navigation.rightBarButtonItem = barBtnItem;
                [barBtnItem release];

                
//            }
            

            
           
        }else{
            tuisongb  = YES;
            
            NSLog(@"tuisongb = %d", tuisongb);
           // UIBarButtonItem *rightItem = [Info longItemInitWithTitle:@"合买模式" Target:self action:@selector(myInfo)];
            
            UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"取消" Target:self action:@selector(actionSave:)];
            [self.navigationItem setRightBarButtonItem:rightItem];
            [myTabelView reloadData];

        }
                
        myTabelView.hidden = NO;
        bangdanview.hidden = YES;
        redTabelView.hidden = YES;
        
        NSLog(@"tuisob = %d", tuisongb);
        [myTabelView reloadData];
    }else if(sender.tag == 22){
        if ([redDictionary count] == 0) {
            [redRequest clearDelegatesAndCancel];
            self.redRequest = [ASIHTTPRequest requestWithURL:[NetURL caipiaoRedRequest]];
            [redRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [redRequest setDelegate:self];
            [redRequest setDidFinishSelector:@selector(redRequesDidFinishSelector:)];
            [redRequest setNumberOfTimesToRetryOnTimeout:2];
            [redRequest startAsynchronous];
        }
        
        if (tuisongb == YES) {
         
            [self rightshanbutton];
            
            
            
            kaijiangbtn.selected = YES;
            bangdanbtn.selected = NO;
            return;
        }
        
        Info *info2 = [Info getInstance];
        if (![info2.userId intValue]) {
            //		UIBarButtonItem *leftItem = [Info itemInitWithTitle:@"注册" Target:self action:@selector(doRegister)];
            //		[self.navigationItem setLeftBarButtonItem:leftItem];
            //		[leftItem release];
            //        UIButton * buttxie = (UIButton *)[self.navigationItem.titleView viewWithTag:99];
            //        buttxie.hidden = YES;
            //        UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];   
            //        self.navigationItem.leftBarButtonItem = leftItem;  
            //        [leftItem release];
            UIBarButtonItem *rightItem = [Info longItemInitWithTitle:@"登录注册" Target:self action:@selector(doLogin)];
            [self.CP_navigation setRightBarButtonItem:rightItem];

        }
        else {
            UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
            
            UIImage *imagerigthItem = UIImageGetImageFromName(@"sachet_2.png");
            
            rigthItem.bounds = CGRectMake(0, 12, 41, 19);
            
            [rigthItem setImage:imagerigthItem forState:UIControlStateNormal];
            [rigthItem addTarget:self action:@selector(pressSearch:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
            
            self.CP_navigation.rightBarButtonItem = rigthItemButton;
            
            [rigthItemButton release];

            
        }
        

        
        
        
        
        myTabelView.hidden = YES;
        bangdanview.hidden = NO;
        redTabelView.hidden = NO;
    }

}

- (void)pressSearch:(id)sender{
    if (!PKsearchBar) {
		PKsearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
		[self.mainView addSubview:PKsearchBar];
		PKsearchBar.delegate = self;
		PKsearchBar.showsCancelButton = YES;
		searchDC = [[UISearchDisplayController alloc] initWithSearchBar:PKsearchBar contentsController:self];
		searchDC.searchResultsDataSource = self;
		searchDC.searchResultsDelegate = self;
	}
    isQuxiao = YES;
	[self.mainView addSubview:PKsearchBar];
	[PKsearchBar becomeFirstResponder];
    
}
#pragma mark -
#pragma mark UISearchBarDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    isQuxiao = NO;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isQuxiao = YES;
	[searchDC.searchResultsTableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if (PKsearchBar.superview && isQuxiao) {
        [PKsearchBar resignFirstResponder];
        [PKsearchBar removeFromSuperview];
    }
}

-(void)sendSeachRequest:(NSString*)keywords
{	
    isQuxiao = NO;
	FansViewController * seachPerson = [[FansViewController alloc] initWithKeywords:keywords];
	[seachPerson setHidesBottomBarWhenPushed:YES];
	seachPerson.cpthree = YES;
    seachPerson.titlestring = keywords;
    seachPerson.titlebool = YES;
	[self.navigationController pushViewController:seachPerson animated:NO];
	[seachPerson release];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	if ([searchBar text]&&![searchBar.text  isEqualToString:@""]) {
		[self.seachTextListarry removeObject:searchBar.text];
		if ([self.seachTextListarry count]==10) {
			
			[seachTextListarry lastObject];
			
		}
		[self.seachTextListarry insertObject:searchBar.text atIndex:0]; 
		NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
		NSString *path=[paths    objectAtIndex:0];
		NSString *plistPath = [path stringByAppendingPathComponent:@"CPThree"];
		[self.seachTextListarry writeToFile:plistPath atomically:YES];
		[self.searchDisplayController.searchResultsTableView reloadData];
		
	}
	[self sendSeachRequest:searchBar.text];
	isQuxiao = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    isQuxiao = YES;
    [PKsearchBar resignFirstResponder];
	[PKsearchBar removeFromSuperview];
}




- (void)tuisongRequest{
    
    NSString * userid1 = [[Info getInstance] userId];
    if ([userid1 length] == 0){
        userid1 = @"0";
    }
    NSLog(@"userid = %@", userid1);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NetURL CBgetPushStatus:userid1]];
    
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(parseSwitchStatu:)];
	//[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];

}

- (void)parseSwitchStatu:(ASIHTTPRequest *)request
{
    
    NSString *responseString = [request responseString];
	SBJSON *jsonParse = [[SBJSON alloc]init];
    NSLog(@"respo = %@", responseString);
	NSDictionary *dic = [jsonParse objectWithString:responseString];
    NSLog(@"dic = %@", dic);
    //    NSString *switch2Value=[dic objectForKey:@"kj"];
    //    NSString *switch1Value=[dic objectForKey:@"zj"];
	
	[statusData removeAllObjects];
    
    [statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"zckj"] intValue]]];
     [statusData addObject:[NSString stringWithFormat:@"%d", [[dic objectForKey:@"lcbqckj"] intValue]]];
    //进球彩
    [statusData addObject:[NSString stringWithFormat:@"%d", [[dic objectForKey:@"scjqkj"] intValue]]];
    //
    
    [statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"qlckj"] intValue]]];
    [statusData addObject:[NSString stringWithFormat:@"0"]];
    [statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"pskj"] intValue]]];
    [statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"pskj"] intValue]]];
    [statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"dltkj"] intValue]]];
    [statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"sdkj"] intValue]]];
    //两步彩
    [statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:0] intValue]]];
	[statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"ssqkj"] intValue]]];
    [statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"qxckj"] intValue]]];
    
    NSMutableArray * array1 = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray * array2 = [[NSMutableArray alloc] initWithCapacity:0];
    

	[array1 addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"zj"] intValue]]];
    
	[array2 addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"ssqkj"] intValue]]];//0
	[array2 addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"sdkj"] intValue]]];//1
	[array2 addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"qlckj"] intValue]]];//2
	[array2 addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"dltkj"] intValue]]];//3
	[array2 addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"pskj"] intValue]]];//4
	[array2 addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"qxckj"] intValue]]];//5
//	[array2 addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"eekj"] intValue]]];//6
	[array2 addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"zckj"] intValue]]];//7
    [array2 addObject:[NSString stringWithFormat:@"%d", [[dic objectForKey:@"lcbqckj"] intValue]]];//8
    [array2 addObject:[NSString stringWithFormat:@"%d", [[dic objectForKey:@"scjqkj"] intValue]]];//9
    if (!swicthArray) {
        swicthArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    [swicthArray addObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"pushSound"]];
    [swicthArray addObject:array1];
    [swicthArray addObject:array2];
    [array1 release];
    [array2 release];
    
     [[NSUserDefaults standardUserDefaults] setValue:swicthArray forKey:@"tuisongshezhi"];
    //
//	for (NSString * st in statusData) {
//        kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
//        song.tuisongshezhi = [st boolValue];
//        [baocunArray addObject:song];
//       // [alldatabool addObject:song];
//        [song release];
//        
//    }
	
	[alldatabool removeAllObjects];
    for (NSString * st in statusData) {
        kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
        song.tuisongshezhi = [st boolValue];
      //  [baocunArray addObject:song];
        [alldatabool addObject:song];
        [song release];
        
    }
	
   
    
    
    
	[myTabelView reloadData];
    
    
    
    //   NSLog(@"switch1Value====%@", switch1Value);
    //    NSLog(@"switch2Value====%@", switch2Value);
    //    [datafile setdata: switch1Value forkey:KEY_ZHONGJIANG];
    //    [datafile setdata: switch2Value   forkey:KEY_KAIJIANG];
    //    if (dic) {
    //        UISwitch *switch1=(UISwitch *)[self.view  viewWithTag:SWITCH1NUM];
    //        [switch1 setOn:[switch1Value boolValue]];
    //        UISwitch *switch2=(UISwitch *)[self.view  viewWithTag:SWITCH2NUM];
    //        [switch2 setOn:[switch2Value boolValue]];
    //        
    //    }
    
    
    [jsonParse release];
    
    
    
    
}


//确定点击事件
- (void)pressbuttondown:(UIButton *)sender{
    tuisongb = NO;
    downview.hidden = YES;
    myTabelView.frame = CGRectMake(0, 48, 320, self.mainView.bounds.size.height -69);
    
    
    NSMutableArray * arrayb = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [alldatabool count]; i++) {
        kjButtCellTuiSong * song = [alldatabool objectAtIndex:i];
        NSString * str = [NSString stringWithFormat:@"%d", song.tuisongshezhi];
        NSLog(@"aaaaaaaaaaaaaaaa = %@", str);
        [arrayb addObject:str];
    }
    
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL: [NetURL CBsetPushStatustwo:[[Info getInstance] userId] kj:arrayb zj:@""]];
    
    [arrayb release];
    
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(parseInfoStatu:)];
	//[request setNumberOfTimesToRetryOnTimeout:2];
	[request startAsynchronous];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = UIImageGetImageFromName(@"gc_gokj.png");
    [btn setImage:image forState:UIControlStateNormal];
    [btn setBounds:CGRectMake(0, 0, 87, 29)];
    [btn addTarget:self action:@selector(pressKaiJiangTuiSong:) forControlEvents:UIControlEventTouchUpInside];
    UILabel * kaijiang  = [[UILabel alloc] initWithFrame:CGRectMake(28, 0, 62, 29)];
    kaijiang.textAlignment = NSTextAlignmentLeft;
    kaijiang.textColor = [UIColor whiteColor];
    kaijiang.backgroundColor = [UIColor clearColor];
    kaijiang.font = [UIFont boldSystemFontOfSize:13];
    kaijiang.text = @"开奖推送";
    [btn addSubview:kaijiang];
    [kaijiang release];
	UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
	self.CP_navigation.rightBarButtonItem = barBtnItem;
	[barBtnItem release];
    [myTabelView reloadData];
}
- (void)parseInfoStatu:(ASIHTTPRequest *)request 
{
    NSString *responseString = [request responseString];
	SBJSON *jsonParse = [[SBJSON alloc]init];
	NSDictionary *dic = [jsonParse objectWithString:responseString];
    NSString *result =[dic objectForKey:@"result"];
    NSLog(@"result=====%@", result);
    
    if ([result isEqualToString:@"succ"]) {
        tuisongb = NO;
      //  [self tuisongRequest];
        
    }else{
        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:@"请求失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [aler  show];
        [aler release];
    }
    
    
    [jsonParse release];
}
- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pressKaiJiangTuiSong:(UIButton *)sender{
    
    [MobClick event:@"event_kaijiangdating_tuisong"];
    
    
    TuisongtongzhiButtonController *tsViewController = [[TuisongtongzhiButtonController alloc] initWithNibName: nil bundle: nil];
    [self.navigationController pushViewController: tsViewController animated: YES];
    [tsViewController release];

    
    
    
//    Info *info2 = [Info getInstance];
//    if (![info2.userId intValue]) {
//        [self doLogin];
//        return;
//    }
//    
//    
//    tuisongb  = YES;
//    
//    NSLog(@"tuisongb = %d", tuisongb);
//    UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"取消" Target:self action:@selector(actionSave:)];
//    [self.navigationItem setRightBarButtonItem:rightItem];
//    
//    
//    if (tuisongb) {
//        downview.hidden = NO;
//        myTabelView.frame = CGRectMake(0, 48, 320,self.view.bounds.size.height -99);
//    }else {
//        downview.hidden = YES;
//        myTabelView.frame = CGRectMake(0, 48, 320, self.view.bounds.size.height -69);
//    }
//    
//
//    
//    [myTabelView reloadData];
}
- (void)actionSave:(UIButton *)sender{
    tuisongb = NO;
    
    NSLog(@"tuisongb = %d", tuisongb);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = UIImageGetImageFromName(@"gc_gokj.png");
    [btn setImage:image forState:UIControlStateNormal];
    [btn setBounds:CGRectMake(0, 0, 87, 29)];
    [btn addTarget:self action:@selector(pressKaiJiangTuiSong:) forControlEvents:UIControlEventTouchUpInside];
    UILabel * kaijiang  = [[UILabel alloc] initWithFrame:CGRectMake(28, 0, 62, 29)];
    kaijiang.textAlignment = NSTextAlignmentLeft;   
    kaijiang.textColor = [UIColor whiteColor];
    kaijiang.backgroundColor = [UIColor clearColor];
    kaijiang.font = [UIFont boldSystemFontOfSize:13];
    kaijiang.text = @"开奖推送";
    [btn addSubview:kaijiang];
    [kaijiang release];
	UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
	self.CP_navigation.rightBarButtonItem = barBtnItem;
	[barBtnItem release];
    
    [alldatabool removeAllObjects];
    
    for (NSString * st in statusData) {
        kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
        song.tuisongshezhi = [st boolValue];
        //  [baocunArray addObject:song];
        [alldatabool addObject:song];
        [song release];
        
    }
    
    if (tuisongb) {
        downview.hidden = NO;
        myTabelView.frame = CGRectMake(0, 48, 320,self.mainView.bounds.size.height -99);
    }else {
        downview.hidden = YES;
        myTabelView.frame = CGRectMake(0, 48, 320, self.mainView.bounds.size.height -69);
    }
    
    
//    [alldatabool removeAllObjects];
//    for (int i = 0; i < [baocunArray count]; i++) {
//        kjButtCellTuiSong * kj = [baocunArray objectAtIndex:i];
//        [alldatabool addObject:kj];
//    }
//    [self tuisongRequest];
    
     [myTabelView reloadData];
}


-(void)sendContentRequest{
    [self.aRequest clearDelegatesAndCancel];
	self.aRequest = [ASIHTTPRequest requestWithURL:[NetURL CBsynLotteryHall]];
	[aRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
	
	[aRequest setDelegate:self];
	
	[aRequest setDidFinishSelector:@selector(didFinishSend:)];
    
    [aRequest setDidFailSelector:@selector(dismissRefreshTableHeaderView)];
	
	[aRequest setNumberOfTimesToRetryOnTimeout:2];

	[aRequest startAsynchronous];

}

- (void)sortFunc{
    
    ///////////////////////  取交集 排除不支持的彩种
    NSArray * lotteryArray = [NSArray arrayWithObjects:@"001", @"113",@"002",@"122",@"119",
                              @"121", @"013",@"012",@"019",@"300",
                              @"201",@"200",@"400",@"011",@"006",
                              @"014",@"110",@"108",@"109",@"003",
                              @"302",@"303", @"010", @"111",LOTTERY_ID_JILIN,LOTTERY_ID_JIANGXI_11,LOTTERY_ID_SHANXI_11,LOTTERY_ID_HEBEI_11, LOTTERY_ID_ANHUI,nil];
    
    //001,113,002,122,119,121,013,012,019,300,201,200,400,011,006,014,110,108,109,003,302,303
    
    NSArray *array2 = [[NSUserDefaults standardUserDefaults] valueForKey:@"serverlastLottery"];
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (array2 &&[ array2 isKindOfClass:[NSArray class]] && [array2 count]) {
        
        for (int i = 0; i < [array2 count]; i++) {
            
            NSString * lotterystr = [array2 objectAtIndex:i];
            
            for (int j = 0; j < [lotteryArray count]; j++) {
                
                NSString * lotterystrTwo = [lotteryArray objectAtIndex:j];
                if ([lotterystr isEqualToString:lotterystrTwo]) {
                    
                    [array addObject:lotterystr];
                    break;
                }
                
            }
            
        }
        
        
    }
    /////////////////////////////////////////
    
    if ([array count] == 0) {
        [array addObjectsFromArray:lotteryArray];
    }
    if (self.lotteries.count == 0) {
        return;
    }
    NSDictionary *dic = [self.lotteries objectAtIndex:0];
    NSArray *arr = [dic objectForKey:@"list"];
    
    NSMutableArray * lastArray = [NSMutableArray array];
    
    
    for (int i = 0; i < [array count]; i++) {
        NSString * lotteryid = [array objectAtIndex:i];
        for (int j = 0; j < [arr count]; j++) {
            LastLottery *lottery = [arr objectAtIndex:j];
            if ([lotteryid isEqualToString:lottery.lotteryNo]) {
                [lastArray addObject:lottery];
            }
        }
        
        
    }
    NSDictionary * dictData = [NSDictionary dictionaryWithObject:lastArray forKey:@"list"];
    [self.lotteries replaceObjectAtIndex:0 withObject:dictData];
    


}

-(void)didFinishSend:(ASIHTTPRequest*)request{
    
	NSString *responseString = [request responseString];
    NSLog(@"%@", responseString);
	self.lotteries = [NSMutableArray arrayWithArray:[LastLotteryParser parseWithResponseString:responseString]];
    
  
    [self sortFunc];//排序 取交集
    
	[myTabelView reloadData];
	[self performSelector:@selector(dismissRefreshTableHeaderView) withObject:nil afterDelay:.5];
	//NSLog(@"count::::%@",self.lotteries);
	
}


#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (scrollView.tag == 11) {
        return;
    }
    if (tuisongb) {
        mRefreshView.hidden = YES;
    }else{
        mRefreshView.hidden = NO;
    }
  
   
	UITableView *mTableView = myTabelView;
//    CGFloat f = 100;
    if (mTableView.contentSize.height >= mTableView.frame.size.height)
    {
//        f = mTableView.contentSize.height - mTableView.frame.size.height + 120;
    }
    
    
        [mRefreshView CBRefreshScrollViewDidScroll:scrollView];
    
//    if (scrollView.contentOffset.y >= f) 
//    {
//       [mRefreshView CBRefreshScrollViewDidScroll:scrollView];
//    }
      
    
}

// 下拉结束停在正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.tag == 111) {
        return;
    }
	[mRefreshView CBRefreshScrollViewDidEndDragging:scrollView];
}


#pragma mark CBRefreshTableHeaderDelegate
// 刷新发送请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view
{
   	isLoading = YES;

	[mRefreshView setState:CBPullRefreshLoading];
    myTabelView.contentInset = UIEdgeInsetsMake(60.0, 0.0f, 0.0f, 0.0f);
    if (tuisongb) {
        isLoading = NO;
        [self performSelector:@selector(dismissRefreshTableHeaderView) withObject:nil afterDelay:0];
      //  [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoadingNoDongHua:myTabelView];
    }else{

        [self sendContentRequest];
    
    }
       
    
	
    
}



// 判断是否正在刷新状态 
- (BOOL)CBRefreshTableHeaderDataSourceIsLoading:(CBRefreshTableHeaderView*)view
{
	return isLoading; // should return if data source model is reloading	
}

// 最近更新时间
- (NSDate*)CBRefreshTableHeaderDataSourceLastUpdated:(CBRefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed	
}

// 数据接收完成调用
- (void)dismissRefreshTableHeaderView
{
	UITableView *mTableView = myTabelView;
    isLoading = NO;
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:mTableView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    Info *info2 = [Info getInstance];
    if (![info2.userId intValue]) {
     
//            UIBarButtonItem *rightItem = [Info longItemInitWithTitle:@"登录注册" Target:self action:@selector(doLogin)];
//            [self.CP_navigation setRightBarButtonItem:rightItem];
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 setBounds:CGRectMake(0, 0, 80, 44)];
//        UIImageView * imagevi1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
//        imagevi1.backgroundColor = [UIColor clearColor];
//        imagevi1.image = UIImageGetImageFromName(@"IZL-960.png");
//        [btn1 addSubview:imagevi1];
//        [imagevi1 release];
        
//        [btn1 setImage:UIImageGetImageFromName(@"IZL-960.png") forState:UIControlStateNormal];
//        [btn1 setImage:UIImageGetImageFromName(@"IZL-960-1.png") forState:UIControlStateHighlighted];
        [btn1 setTitle:@"推送设置" forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barBtnItem1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
        self.CP_navigation.rightBarButtonItem = barBtnItem1;
        [barBtnItem1 release];
		
	}
	else {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBounds:CGRectMake(0, 0, 80, 44)];
        
//        [btn setImage:UIImageGetImageFromName(@"IZL-960.png") forState:UIControlStateNormal];
//        [btn setImage:UIImageGetImageFromName(@"IZL-960-1.png") forState:UIControlStateHighlighted];
        [btn setTitle:@"推送设置" forState:UIControlStateNormal];
//        UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
//        imagevi.backgroundColor = [UIColor clearColor];
//        imagevi.image = UIImageGetImageFromName(@"IZL-960.png");
//        [btn addSubview:imagevi];
//        [imagevi release];
        [btn addTarget:self action:@selector(pressKaiJiangTuiSong:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.CP_navigation.rightBarButtonItem = barBtnItem;
        [barBtnItem release];
    }

    caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
    caiboappdelegate.keFuButton.hidden = NO;
    [caiboappdelegate.keFuButton chulaitiao];
    if (caiboappdelegate.keFuButton.markbool) {
         caiboappdelegate.keFuButton.show = YES;
    }else{
         caiboappdelegate.keFuButton.show = NO;
    }
   
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    [cai.keFuButton calloff];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"tuisongshezhi"]) {// [[NSUserDefaults standardUserDefaults] setValue:swicthArray forKey:@"tuisongshezhi"];
        
        NSMutableArray * muArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"tuisongshezhi"];

        if (muArray.count == 2) {
            [muArray insertObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"pushSound"] atIndex:0];
        }

        if ([muArray count] > 0) {
            
            NSMutableArray * array2 = [muArray objectAtIndex:2];
            [statusData removeAllObjects];
            if ([array2 count] >= 9) {
                [statusData addObject:[NSString stringWithFormat:@"%d", [[array2 objectAtIndex:6] intValue]]];
                [statusData addObject:[NSString stringWithFormat:@"%d", [[array2 objectAtIndex:7] intValue]]];
                //进球
                [statusData addObject:[NSString stringWithFormat:@"%d", [[array2 objectAtIndex:8] intValue]]];
                //
                
                [statusData addObject:[NSString stringWithFormat:@"%d",[[array2 objectAtIndex:2] intValue]]];
                [statusData addObject:[NSString stringWithFormat:@"0"]];
                [statusData addObject:[NSString stringWithFormat:@"%d",[[array2 objectAtIndex:4] intValue]]];
                [statusData addObject:[NSString stringWithFormat:@"%d",[[array2 objectAtIndex:4] intValue]]];
                [statusData addObject:[NSString stringWithFormat:@"%d",[[array2 objectAtIndex:3] intValue]]];
                [statusData addObject:[NSString stringWithFormat:@"%d",[[array2 objectAtIndex:1] intValue]]];
                //两步彩
                [statusData addObject:[NSString stringWithFormat:@"%d",0]];
                [statusData addObject:[NSString stringWithFormat:@"%d",[[array2 objectAtIndex:0] intValue]]];
                [statusData addObject:[NSString stringWithFormat:@"%d",[[array2 objectAtIndex:5] intValue]]];
            }

            [alldatabool removeAllObjects];
            for (NSString * st in statusData) {
                kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
                song.tuisongshezhi = [st boolValue];
                //  [baocunArray addObject:song];
                [alldatabool addObject:song];
                [song release];
                
            }
            if (myTabelView) {
                [myTabelView reloadData];
            }
        }else{
            [self tuisongRequest];
        }
    }else{
        [self tuisongRequest];
    }
   
}

/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	//NSLog(@"count::::%d",[self.lotteries count]);
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		return 1;
	}

    
    if (tableView.tag == 111) {
        if (arrdict == nil) {
            return 1;
        }
      //  NSLog(@"arrdict = %@", arrdict);
        return [arrdict count];

    }else{
        return [self.lotteries count];
    }
    
	return 0;
	
}

- (NSArray *)getShaiZiViewBy:(NSArray *)numArray{
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 21)];
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 21)];
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 21)];
    image1.backgroundColor = [UIColor clearColor];
    image2.backgroundColor = [UIColor clearColor];
    image3.backgroundColor = [UIColor clearColor];
//    NSString * str1 = [NSString stringWithFormat:@"xqshaizi%d.png",[[numArray objectAtIndex:0] intValue]];
//    NSString * str2 = [NSString stringWithFormat:@"xqshaizi%d.png",[[numArray objectAtIndex:1] intValue]];
//    NSString * str3 = [NSString stringWithFormat:@"xqshaizi%d.png",[[numArray objectAtIndex:2] intValue]];
    NSString * str1 = [NSString stringWithFormat:@"kaijiangshaizi%d.png",[[numArray objectAtIndex:0] intValue]];
    NSString * str2 = [NSString stringWithFormat:@"kaijiangshaizi%d.png",[[numArray objectAtIndex:1] intValue]];
    NSString * str3 = [NSString stringWithFormat:@"kaijiangshaizi%d.png",[[numArray objectAtIndex:2] intValue]];
    image1.image = UIImageGetImageFromName(str1);
    image2.image = UIImageGetImageFromName(str2);
    image3.image = UIImageGetImageFromName(str3);
    NSArray *retunArray = [NSArray arrayWithObjects:image1,image2,image3,nil];
    [image1 release];
    [image2 release];
    [image3 release];
    return retunArray;

}

- (NSArray *)getPukeViewBy:(NSArray *)numArray {//
    if ([numArray count] < 3) {
        NSArray *retunArray = [NSArray arrayWithObjects:nil];
        return retunArray;
    }
    NSArray *name = [NSArray arrayWithObjects:@"",@"⑴",@"⑵",@"⑶",@"⑷",@"⑸",@"⑹",@"⑺",@"⑻",@"⑼",@"⒂",@"⑾",@"⑿",@"⒀", nil];
    NSArray *array1 = [[numArray objectAtIndex:0] componentsSeparatedByString:@":"];
    NSArray *array2 = [[numArray objectAtIndex:1] componentsSeparatedByString:@":"];
    NSArray *array3 = [[numArray objectAtIndex:2] componentsSeparatedByString:@":"];
    int a,b,c,a1,b1,c1;
    a = (int)[[array1 objectAtIndex:0] integerValue];
    b = (int)[[array2 objectAtIndex:0] integerValue];
    c = (int)[[array3 objectAtIndex:0] integerValue];
    a1 = (int)[[array1 objectAtIndex:1] integerValue];
    b1 = (int)[[array2 objectAtIndex:1] integerValue];
    c1 = (int)[[array3 objectAtIndex:1] integerValue];
    NSString *leixing = @"";
    int smal = 100,mid = 0,big = 0;
    if (smal > a) {
        smal = a;
    }
    if (smal > b) {
        smal = b;
    }
    if (smal > c) {
        smal = c;
    }
    if (big < a) {
        big = a;
    }
    if (big < b) {
        big = b;
    }
    if (big < c) {
        big = c;
    }
    mid = a + b + c - smal - big;
    if (a == b && b == c) {
        leixing = @"豹子";
    }
    else if (a == b || b == c || a == c) {
        leixing = @"对子";
    }
    else if (a1 == b1 && b1 == c1) {
        leixing = @"同花";
        if (smal + 1 == mid && mid + 1 ==big) {
            leixing = @"同花顺";
        }
    }
    else if (smal + 1 == mid && mid + 1 ==big) {
        leixing = @"顺子";
    }
    NSString *pic1 = [NSString stringWithFormat:@"puke_%d.png",a1];
    NSString *pic2 = [NSString stringWithFormat:@"puke_%d.png",b1];
    NSString *pic3 = [NSString stringWithFormat:@"puke_%d.png",c1];
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 26)];
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 26)];
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 26)];
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.frame = CGRectMake(5, 4, 16, 16);
    lab1.font = [UIFont fontWithName:@"TRENDS" size:16];
    if (a1%2 == 0) {
        lab1.textColor = [UIColor colorWithRed:255/255.0 green:29/255.0 blue:37/255.0 alpha:1];
    }else{
        lab1.textColor = [UIColor blackColor];
    }
    lab1.backgroundColor = [UIColor clearColor];
    lab1.tag = 101;
    lab1.text = [name objectAtIndex:a];
    lab1.autoresizingMask = 111111;
    [image1 addSubview:lab1];
    [lab1 release];
    
    UILabel *lab2 = [[UILabel alloc] init];
    lab2.frame = CGRectMake(5, 4, 16, 16);
    lab2.font = [UIFont fontWithName:@"TRENDS" size:16];
    if (b1%2 == 0) {
        lab2.textColor = [UIColor colorWithRed:255/255.0 green:29/255.0 blue:37/255.0 alpha:1];
    }else{
        lab2.textColor = [UIColor blackColor];
    }
    lab2.backgroundColor = [UIColor clearColor];
    lab2.tag = 101;
    lab2.text = [name objectAtIndex:b];
    lab2.autoresizingMask = 111111;
    [image2 addSubview:lab2];
    [lab2 release];
    
    UILabel *lab3 = [[UILabel alloc] init];
    lab3.frame = CGRectMake(5, 4, 16, 16);
    lab3.font = [UIFont fontWithName:@"TRENDS" size:16];
    if (c1%2 == 0) {
        lab3.textColor = [UIColor colorWithRed:255/255.0 green:29/255.0 blue:37/255.0 alpha:1];
    }else{
        lab3.textColor = [UIColor blackColor];
    }
    lab3.backgroundColor = [UIColor clearColor];
    lab3.tag = 101;
    lab3.text = [name objectAtIndex:c];
    lab3.autoresizingMask = 111111;
    [image3 addSubview:lab3];
    [lab3 release];
    
    image1.image = UIImageGetImageFromName(pic1);
    image2.image = UIImageGetImageFromName(pic2);
    image3.image = UIImageGetImageFromName(pic3);
    NSArray *retunArray = [NSArray arrayWithObjects:image1,image2,image3,leixing,nil];
    [image1 release];
    [image2 release];
    [image3 release];
    return retunArray;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		return [self.seachTextListarry count];
	}
    
    if (tableView.tag == 111) {
        NSString * string = [arrdict objectAtIndex:section];
        NSArray * array = [redDictionary objectForKey:string];
        if ([string isEqualToString:@"sfc"]) {
            return [array count];
        }else if ([string isEqualToString:@"rx9"]){
            return [array count];
        }else if ([string isEqualToString:@"bd"]){
            return [array count];
        }else if ([string isEqualToString:@"jingcai"]){
            return [array count];
        }

    }else{
        NSDictionary *dic = [self.lotteries objectAtIndex:section];
        NSArray *arr = [dic objectForKey:@"list"];
        return [arr count];
    }
    
	
	
    return 0;
    
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section   // custom view for header. will be adjusted to default or specified header height
{
    if (tableView.tag == 111) {
        UIView * bgviewim = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 7)] autorelease];
        bgviewim.backgroundColor = [UIColor clearColor];
        return bgviewim;
    }else{
        UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)] autorelease];
        headerView.backgroundColor = [UIColor clearColor];
//        headerView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"headerBackground.jpg")];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 24)];
//        label.font = [UIFont boldSystemFontOfSize:15];
//        label.textColor = [UIColor blackColor];
//        label.backgroundColor = [UIColor clearColor];
//        
//        NSDictionary *dic = [self.lotteries objectAtIndex:section];
//        
//        label.text = [dic objectForKey:@"lotteryType"];
//        
//        [headerView addSubview:label];
//        [label release];

        
        return headerView;

    
    }
	
    return nil;
	
}

- (void)returncellrownum:(NSInteger)num quedingbool:(BOOL)quebool{
    
    
    
    NSDictionary *dic = [self.lotteries objectAtIndex:0];
	NSArray *arr = [dic objectForKey:@"list"];
    
    
    
	LastLottery *lottery = [arr objectAtIndex:num];
    if ([lottery.lotteryNo isEqualToString:@"001"]) {
        
        kjButtCellTuiSong * cellsong = [alldatabool objectAtIndex:10];
        cellsong.tuisongshezhi = quebool;
        [alldatabool replaceObjectAtIndex:10 withObject:cellsong];

    }else if ([lottery.lotteryNo isEqualToString:@"111"]) {
        
        kjButtCellTuiSong * cellsong = [alldatabool objectAtIndex:4];
        cellsong.tuisongshezhi = quebool;
        [alldatabool replaceObjectAtIndex:4 withObject:cellsong];
        
    }else if ([lottery.lotteryNo isEqualToString:@"109"]) {
        
        kjButtCellTuiSong * cellsong = [alldatabool objectAtIndex:5];
        cellsong.tuisongshezhi = quebool;
        [alldatabool replaceObjectAtIndex:5 withObject:cellsong];
        
    }else if ([lottery.lotteryNo isEqualToString:@"108"]) {
        
        kjButtCellTuiSong * cellsong = [alldatabool objectAtIndex:6];
        cellsong.tuisongshezhi = quebool;
        [alldatabool replaceObjectAtIndex:6 withObject:cellsong];
        
    }else if ([lottery.lotteryNo isEqualToString:@"002"]) {
        
        kjButtCellTuiSong * cellsong = [alldatabool objectAtIndex:8];
        cellsong.tuisongshezhi = quebool;
        [alldatabool replaceObjectAtIndex:8 withObject:cellsong];
        
    }else if ([lottery.lotteryNo isEqualToString:@"300"]||[lottery.lotteryNo isEqualToString:@"301"]) {
        
        kjButtCellTuiSong * cellsong = [alldatabool objectAtIndex:0];
        cellsong.tuisongshezhi = quebool;
        [alldatabool replaceObjectAtIndex:0 withObject:cellsong];
        
    }else if ([lottery.lotteryNo isEqualToString:@"302"]) {
        
        kjButtCellTuiSong * cellsong = [alldatabool objectAtIndex:1];
        cellsong.tuisongshezhi = quebool;
        [alldatabool replaceObjectAtIndex:1 withObject:cellsong];
        
    }else if ([lottery.lotteryNo isEqualToString:@"303"]) {
        
        kjButtCellTuiSong * cellsong = [alldatabool objectAtIndex:2];
        cellsong.tuisongshezhi = quebool;
        [alldatabool replaceObjectAtIndex:2 withObject:cellsong];
        
    }else if ([lottery.lotteryNo isEqualToString:@"003"]) {
        
        kjButtCellTuiSong * cellsong = [alldatabool objectAtIndex:3];
        cellsong.tuisongshezhi = quebool;
        [alldatabool replaceObjectAtIndex:3 withObject:cellsong];
        
    }else if ([lottery.lotteryNo isEqualToString:@"113"]) {
        
        kjButtCellTuiSong * cellsong = [alldatabool objectAtIndex:7];
        cellsong.tuisongshezhi = quebool;
        [alldatabool replaceObjectAtIndex:7 withObject:cellsong];
        
    }else if ([lottery.lotteryNo isEqualToString:@"010"]) {
        
        kjButtCellTuiSong * cellsong = [alldatabool objectAtIndex:9];
        cellsong.tuisongshezhi = quebool;
        [alldatabool replaceObjectAtIndex:9 withObject:cellsong];
        
    }else if ([lottery.lotteryNo isEqualToString:@"110"]) {
        
        kjButtCellTuiSong * cellsong = [alldatabool objectAtIndex:11];
        cellsong.tuisongshezhi = quebool;
        [alldatabool replaceObjectAtIndex:11 withObject:cellsong];
        
    }
    
    
       
    
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        static NSString *CellIdentifier = @"SearchCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
       
        
        NSString *text = [self.seachTextListarry objectAtIndex:indexPath.row]; 
        
        cell.textLabel.text =text ;
        
        
        
        return cell;
    }else if (tableView.tag == 111) {
        NSString * cellID = @"cellid";
        AnnouncementCell * cell = (AnnouncementCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            cell = [[[AnnouncementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID ] autorelease];
            cell.backgroundColor = [UIColor clearColor];
        }
        
        
        NSString * strname = [arrdict objectAtIndex:indexPath.section];
        
        NSArray * arraystr = [redDictionary objectForKey:strname];
        
        AnnouncementData * annou = [arraystr objectAtIndex:indexPath.row];
        NSString * string = [arrdict objectAtIndex:indexPath.section];
        
        if ([string isEqualToString:@"sfc"]) {
            annou.headna = @"胜负彩";
            
        }else if ([string isEqualToString:@"rx9"]){
            annou.headna = @"任选九";
        }else if ([string isEqualToString:@"bd"]){
            annou.headna = @"单场";
        }else if ([string isEqualToString:@"jingcai"]){
            annou.headna = @"竞彩足球";
        }
        if (indexPath.row == [arraystr count]-1) {
            cell.imagebool = YES;
            
        }else{
            cell.imagebool = NO;
        }
        
        if ([arraystr count] == 1) {
            cell.headbool = YES;
        }else{
            cell.headbool = NO;
        }
        
        annou.num = indexPath.row;
        cell.annou = annou;
        
        
        
        
        
        return cell;

    }else{
    
        NSDictionary *dic = [self.lotteries objectAtIndex:indexPath.section];
        NSArray *arr = [dic objectForKey:@"list"];
        NSLog(@"%@",arr);
        LastLottery *lottery = [arr objectAtIndex:indexPath.row];
        
        static NSString *CellIdentifier = @"LastLoterryCell";
        
        LastLotteryCell *cell = (LastLotteryCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        if (cell == nil) {            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LastLotteryCell" owner:self options:nil]objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            
            
            
        }
        cell.cellbgimage.backgroundColor=[UIColor clearColor];
//        cell.cellbgimage.layer.shadowOffset=CGSizeMake(0, 2);
//        cell.cellbgimage.layer.shadowRadius=1;
//        cell.cellbgimage.layer.shadowOpacity=0.5;
//        cell.cellbgimage.layer.shadowColor=[UIColor grayColor].CGColor;
        
        cell.name.font = [UIFont boldSystemFontOfSize:18];
        cell.issue.textColor = [UIColor colorWithRed:25/255.0 green:122/255.0 blue:228/255.0 alpha:1];
        cell.issue.font = [UIFont boldSystemFontOfSize:12];
        cell.qilabel.font = [UIFont boldSystemFontOfSize:12];
        
        cell.delegate = self;
        cell.row = (int)indexPath.row;
   
        if (tuisongb) {
            [cell.buttxuan setImage:UIImageGetImageFromName(@"login_right_0.png") forState:UIControlStateNormal];
            cell.buttxuan.enabled = YES;
            cell.headImageBtn.frame = CGRectMake(14, 4, 42, 42);
        }else {
           // cell.buttxuan.hidden = YES;
            cell.buttxuan.enabled = NO;
            [cell.buttxuan setImage:nil forState:UIControlStateNormal];
            //[cell.buttxuan setImage:UIImageGetImageFromName(@"") forState:UIControlStateNormal];
            cell.headImageBtn.frame = CGRectMake(14, 4, 42, 42);
        }
        cell.name.text = lottery.lotteryName;
        if ([lottery.lotteryNo isEqualToString:@"001"]) {
           
            cell.caiimage.image = UIImageGetImageFromName(@"shuangseqiu-960.png");
            
        }else if ([lottery.lotteryNo isEqualToString:@"111"]){
            
            cell.caiimage.image = UIImageGetImageFromName(@"22xuan5-960.png");
            
        }else if([lottery.lotteryNo isEqualToString:@"109"]){
            
            cell.caiimage.image = UIImageGetImageFromName(@"paiwu-960.png");
            
        }else if([lottery.lotteryNo isEqualToString:@"108"]){
            
            cell.caiimage.image = UIImageGetImageFromName(@"paisan-960.png");
            
        }else if([lottery.lotteryNo isEqualToString:@"002"]){
            
            cell.caiimage.image = UIImageGetImageFromName(@"fucai3d-960.png");
            
        }else if([lottery.lotteryNo isEqualToString:@"301"]||[lottery.lotteryNo isEqualToString:@"300"]){
            
            cell.caiimage.image = UIImageGetImageFromName(@"shengfucai-960.png");
            
        }else if([lottery.lotteryNo isEqualToString:@"302"]){
            
            cell.caiimage.image = UIImageGetImageFromName(@"banquanchang-960.png");
            
        }else if([lottery.lotteryNo isEqualToString:@"303"]){////
            
            cell.caiimage.image = UIImageGetImageFromName(@"jinqiucai-960.png");
            
        }else if([lottery.lotteryNo isEqualToString:@"003"]){
            
            cell.caiimage.image = UIImageGetImageFromName(@"7leicai-960.png");
            
        }else if([lottery.lotteryNo isEqualToString:@"113"]){
            
            cell.caiimage.image = UIImageGetImageFromName(@"daleitou-960.png");
            
        }else if([lottery.lotteryNo isEqualToString:@"010"]){////
            
            cell.caiimage.image = UIImageGetImageFromName(@"liangbucai-960.png");
            
        }else if([lottery.lotteryNo isEqualToString:@"110"]){
          
            cell.caiimage.image = UIImageGetImageFromName(@"qixing-960.png");
            
        }else if([lottery.lotteryNo isEqualToString:@"006"]){
            
            cell.caiimage.image = UIImageGetImageFromName(@"shishi-960.png");
            
        }else if([lottery.lotteryNo isEqualToString:@"119"]){
            
            cell.caiimage.image = UIImageGetImageFromName(@"11xuan5-960.png");
            
        }else if ([lottery.lotteryNo isEqualToString:@"121"]){
            cell.caiimage.image = UIImageGetImageFromName(@"guangdong11xuan5.png");
        }else if([lottery.lotteryNo isEqualToString:@"011"]){
            cell.caiimage.image = UIImageGetImageFromName(@"kaileishifenimage.png");
            
            
        }else if([lottery.lotteryNo isEqualToString:@"012"]){
            cell.caiimage.image = UIImageGetImageFromName(@"kuaisan-960.png");
        }else if([lottery.lotteryNo isEqualToString:@"201"]){
            cell.caiimage.image = UIImageGetImageFromName(@"logo_01.png");
        }else if([lottery.lotteryNo isEqualToString:@"200"]){
            cell.caiimage.image = UIImageGetImageFromName(@"logo_02.png");
        }else if([lottery.lotteryNo isEqualToString:@"400"]){
            cell.caiimage.image = UIImageGetImageFromName(@"logo_03.png");
        }else if ([lottery.lotteryNo isEqualToString:@"122"]){
            cell.caiimage.image = UIImageGetImageFromName(@"puke-960.png");
        }else if ([lottery.lotteryNo isEqualToString:@"013"]){
            cell.caiimage.image = UIImageGetImageFromName(@"puke-960.png");
        }else if ([lottery.lotteryNo isEqualToString:@"014"]){
            cell.caiimage.image = UIImageGetImageFromName(@"CQshishicai.png");
        }else if ([lottery.lotteryNo isEqualToString:@"019"]){
//            cell.caiimage.image = UIImageGetImageFromName(@"CQshishicai.png");
        }
        

        
        
        if ([alldatabool count] >= 12) {
            //  kjButtCellTuiSong * cellsong = [alldatabool objectAtIndex:indexPath.row];
            
            
            kjButtCellTuiSong * cellsong;
            
            if ([lottery.lotteryNo isEqualToString:@"001"]) {
                cellsong = [alldatabool objectAtIndex:10];
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = cellsong;
                cell.caiimage.image = UIImageGetImageFromName(@"shuangseqiu-960.png");
                
            }else if ([lottery.lotteryNo isEqualToString:@"111"]){
                cellsong = [alldatabool objectAtIndex:4];
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = cellsong;
                cell.caiimage.image = UIImageGetImageFromName(@"22xuan5-960.png");
                
            }else if([lottery.lotteryNo isEqualToString:@"109"]){
                cellsong = [alldatabool objectAtIndex:5];
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = cellsong;
                cell.caiimage.image = UIImageGetImageFromName(@"paiwu-960.png");
                
            }else if([lottery.lotteryNo isEqualToString:@"108"]){
                cellsong = [alldatabool objectAtIndex:6];
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = cellsong;
                cell.caiimage.image = UIImageGetImageFromName(@"paisan-960.png");
                
            }else if([lottery.lotteryNo isEqualToString:@"002"]){
                cellsong = [alldatabool objectAtIndex:8];
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = cellsong;
                cell.caiimage.image = UIImageGetImageFromName(@"fucai3d-960.png");
                
            }else if([lottery.lotteryNo isEqualToString:@"300"]||[lottery.lotteryNo isEqualToString:@"301"]){
                cellsong = [alldatabool objectAtIndex:0];
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = cellsong;
                cell.caiimage.image = UIImageGetImageFromName(@"shengfucai-960.png");
                
            }else if([lottery.lotteryNo isEqualToString:@"302"]){
                cellsong = [alldatabool objectAtIndex:1];
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = cellsong;
                cell.caiimage.image = UIImageGetImageFromName(@"banquanchang-960.png");
                
            }else if([lottery.lotteryNo isEqualToString:@"303"]){////
                cellsong = [alldatabool objectAtIndex:2];
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = cellsong;
                cell.caiimage.image = UIImageGetImageFromName(@"jinqiucai-960.png");
                
            }else if([lottery.lotteryNo isEqualToString:@"003"]){
                cellsong = [alldatabool objectAtIndex:3];
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = cellsong;
                cell.caiimage.image = UIImageGetImageFromName(@"7leicai-960.png");
                
            }else if([lottery.lotteryNo isEqualToString:@"113"]){
                cellsong = [alldatabool objectAtIndex:7];
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = cellsong;
                cell.caiimage.image = UIImageGetImageFromName(@"daleitou-960.png");
                
            }else if([lottery.lotteryNo isEqualToString:@"010"]){////
                cellsong = [alldatabool objectAtIndex:9];
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = cellsong;
                cell.caiimage.image = UIImageGetImageFromName(@"liangbucai-960.png");
                
            }else if([lottery.lotteryNo isEqualToString:@"110"]){
                cellsong = [alldatabool objectAtIndex:11];
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                
                cell.tuisongtongzhi = cellsong;
                cell.caiimage.image = UIImageGetImageFromName(@"qixing-960.png");
                
            }else if([lottery.lotteryNo isEqualToString:@"006"]){
                kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
                song.tuisongshezhi = NO;
                cellsong = song;
                
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = song;
                cell.caiimage.image = UIImageGetImageFromName(@"shishi-960.png");
                [song release];
            
            }else if([lottery.lotteryNo isEqualToString:@"119"]){
                kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
                song.tuisongshezhi = NO;
                cellsong = song;
                
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = song;
                cell.caiimage.image = UIImageGetImageFromName(@"11xuan5-960.png");
                [song release];
            
            }else if([lottery.lotteryNo isEqualToString:@"121"]){
                kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
                song.tuisongshezhi = NO;
                cellsong = song;
                
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = song;
                cell.caiimage.image = UIImageGetImageFromName(@"guangdong11xuan5.png");
                [song release];
                
            }else if([lottery.lotteryNo isEqualToString:LOTTERY_ID_JIANGXI_11]){
                kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
                song.tuisongshezhi = NO;
                cellsong = song;
                
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = song;
                cell.caiimage.image = UIImageGetImageFromName(@"guangdong11xuan5.png");
                [song release];
                
            }else if([lottery.lotteryNo isEqualToString:@"013"]){
                kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
                song.tuisongshezhi = NO;
                cellsong = song;
                
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = song;
                cell.caiimage.image = UIImageGetImageFromName(@"jskuaisan.png");
                [song release];
                
            }else if([lottery.lotteryNo isEqualToString:@"019"]){
                kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
                song.tuisongshezhi = NO;
                cellsong = song;
                
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = song;
                cell.caiimage.image = UIImageGetImageFromName(@"jskuaisan.png");
                [song release];
                
            }
            
            else if([lottery.lotteryNo isEqualToString:@"012"]){
                kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
                song.tuisongshezhi = NO;
                cellsong = song;
                
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = song;
                cell.caiimage.image = UIImageGetImageFromName(@"kuaisan-960.png");
                [song release];
                
            }
            else if([lottery.lotteryNo isEqualToString:LOTTERY_ID_JILIN]){
                kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
                song.tuisongshezhi = NO;
                cellsong = song;
                
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = song;
                cell.caiimage.image = UIImageGetImageFromName(@"kuaisan-960.png");
                [song release];
                
            }
            else if([lottery.lotteryNo isEqualToString:LOTTERY_ID_ANHUI]){
                kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
                song.tuisongshezhi = NO;
                cellsong = song;
                
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = song;
                cell.caiimage.image = UIImageGetImageFromName(@"kuaisan-960.png");
                [song release];
                
            }
            else if([lottery.lotteryNo isEqualToString:@"201"]){
                kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
                song.tuisongshezhi = NO;
                cellsong = song;
                
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = song;
                cell.caiimage.image = UIImageGetImageFromName(@"logo_01.png");
                [song release];
                
            }else if([lottery.lotteryNo isEqualToString:@"200"]){
                kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
                song.tuisongshezhi = NO;
                cellsong = song;
                
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = song;
                cell.caiimage.image = UIImageGetImageFromName(@"logo_02.png");
                [song release];
                
            }else if([lottery.lotteryNo isEqualToString:@"400"]){
                kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
                song.tuisongshezhi = NO;
                cellsong = song;
                
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = song;
                cell.caiimage.image = UIImageGetImageFromName(@"logo_03.png");
                [song release];
                
            }else if([lottery.lotteryNo isEqualToString:@"122"]){
                kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
                song.tuisongshezhi = NO;
                cellsong = song;
                
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = song;
                cell.caiimage.image = UIImageGetImageFromName(@"puke-960.png");
                [song release];
                
            }
            else if([lottery.lotteryNo isEqualToString:@"014"]){
                kjButtCellTuiSong * song = [[kjButtCellTuiSong alloc] init];
                song.tuisongshezhi = NO;
                cellsong = song;
                
                if (tuisongb) {
                    cellsong.tuisongxuan = YES;
                }else{
                    cellsong.tuisongxuan = NO;
                }
                cell.tuisongtongzhi = song;
                cell.caiimage.image = UIImageGetImageFromName(@"CQshishicai.png");
                [song release];
                
            }
            
            if([lottery.lotteryNo isEqualToString:@"002"])
            {
                cell.tryLab.text=@"";
                NSLog(@"%@",lottery.tryoutNumber);
                if(lottery.tryoutNumber)
                {
                    cell.tryLab.text=[NSString stringWithFormat:@"试机号 %@",lottery.tryoutNumber];
                    cell.tryLab.text=[cell.tryLab.text stringByReplacingOccurrencesOfString:@"," withString:@" "];
                    cell.tryLab.frame=CGRectMake(160, 45, 100, 30);
                }
            }
            else if([lottery.lotteryNo isEqualToString:@"012"]||[lottery.lotteryNo isEqualToString:@"013"]||[lottery.lotteryNo isEqualToString:@"019"]||[lottery.lotteryNo isEqualToString:LOTTERY_ID_JILIN]||[lottery.lotteryNo isEqualToString:LOTTERY_ID_ANHUI])
            {
                cell.tryLab.text=@"";
                NSArray * openArray = [lottery.openNumber componentsSeparatedByString:@","];
                NSLog(@"%@",openArray);
                NSInteger num=0;
                for (NSString *str in openArray)
                {
                    num += [str integerValue];
                }
                cell.tryLab.frame=CGRectMake(160, 45, 100, 30);
                cell.tryLab.text=[NSString stringWithFormat:@"和值 %d",(int)num];
            }
            else if([lottery.lotteryNo isEqualToString:@"006"]||[lottery.lotteryNo isEqualToString:@"014"])
            {
                cell.tryLab.text=@"";
                NSLog(@"%@",lottery.openNumber);
                NSArray * openArray = [lottery.openNumber componentsSeparatedByString:@","];
                
                if(openArray.count==5)
                {
                    NSInteger num1=[[openArray objectAtIndex:3] integerValue];
                    NSInteger num2=[[openArray objectAtIndex:4] integerValue];
                    if(num1 == 0 || num1 == 2 || num1 == 4)
                    {
                        if(num2 == 0 || num2 == 2 || num2 == 4)
                        {
                            cell.tryLab.text=@"小双|小双";
                        }
                        else if(num2 == 1 || num2 == 3)
                        {
                            cell.tryLab.text=@"小双|小单";
                        }
                        else if(num2 == 6 || num2 == 8)
                        {
                            cell.tryLab.text=@"小双|大双";
                        }
                        else if(num2 == 5 || num2 == 7 || num2 == 9)
                        {
                            cell.tryLab.text=@"小双|大单";
                        }
                    }
                    else if(num1 == 1 || num1 == 3)
                    {
                        if(num2 == 0 || num2 == 2 || num2 == 4)
                        {
                            cell.tryLab.text=@"小单|小双";
                        }
                        else if(num2 == 1 || num2 == 3)
                        {
                            cell.tryLab.text=@"小单|小单";
                        }
                        else if(num2 == 6 || num2 == 8)
                        {
                            cell.tryLab.text=@"小单|大双";
                        }
                        else if(num2 == 5 || num2 == 7 || num2 == 9)
                        {
                            cell.tryLab.text=@"小单|大单";
                        }
                    }
                    else if(num1 == 5 || num1 == 7 || num1 == 9)
                    {
                        if(num2 == 0 || num2 == 2 || num2 == 4)
                        {
                            cell.tryLab.text=@"大单|小双";
                        }
                        else if(num2 == 1 || num2 == 3)
                        {
                            cell.tryLab.text=@"大单|小单";
                        }
                        else if(num2 == 6 || num2 == 8)
                        {
                            cell.tryLab.text=@"大单|大双";
                        }
                        else if(num2 == 5 || num2 == 7 || num2 == 9)
                        {
                            cell.tryLab.text=@"大单|大单";
                        }
                    }
                    else if(num1 == 6 || num1 == 8)
                    {
                        if(num2 == 0 || num2 == 2 || num2 == 4)
                        {
                            cell.tryLab.text=@"大双|小双";
                        }
                        else if(num2 == 1 || num2 == 3)
                        {
                            cell.tryLab.text=@"大双|小单";
                        }
                        else if(num2 == 6 || num2 == 8)
                        {
                            cell.tryLab.text=@"大双|大双";
                        }
                        else if(num2 == 5 || num2 == 7 || num2 == 9)
                        {
                            cell.tryLab.text=@"大双|大单";
                        }
                    }
                    cell.tryLab.text=[cell.tryLab.text stringByReplacingOccurrencesOfString:@"|" withString:@" | "];
                }
                
                cell.tryLab.frame=CGRectMake(200, 45, 100, 30);
//                cell.tryLab.text=[NSString stringWithFormat:@"和值 %d",num];
            }
            else
            {
                cell.tryLab.text=@"";
                cell.tryLab.frame=CGRectMake(0, 0, 0, 0);
            }
            
            CGSize size;
            size=[cell.name.text sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(200, 20)];
        
            if([lottery.lotteryNo isEqualToString:@"201"]){
                cell.qilabel.hidden = YES;
//                cell.issue.frame = CGRectMake(189, 6, 74, 23);
                cell.issue.frame = CGRectMake(110, 10, 74, 20);
            }else if([lottery.lotteryNo isEqualToString:@"200"]){
                cell.qilabel.hidden = YES;
//                 cell.issue.frame = CGRectMake(189, 6, 74, 23);
                cell.issue.frame = CGRectMake(110, 10, 74, 20);
            }else{
                cell.qilabel.hidden = NO;
//                 cell.issue.frame = CGRectMake(174, 6, 74, 23);
                cell.issue.frame = CGRectMake(110, 10, 74, 20);
            }
        
            cell.issue.frame = CGRectMake(size.width+20, 10, 74, 20);
        
        }
        
        UILabel *xianLab = (UILabel*)[cell viewWithTag:123];
        xianLab.frame=CGRectMake(15, 92.5, 320, 0.5);
        UILabel *jiantouLab=(UILabel *)[cell viewWithTag:122];
        jiantouLab.frame=CGRectMake(290, 40, 8, 13);
        if([lottery.lotteryNo isEqualToString:@"201"]||[lottery.lotteryNo isEqualToString:@"400"])
        {
//            xianLab.frame=CGRectMake(15, 49.5, 320, 0.5);
//            jiantouLab.frame=CGRectMake(297, 18.5, 8, 13);
            cell.guanfangIma.image=[UIImage imageNamed:@"guanfanglv.png"];
        }
        else if([lottery.lotteryNo isEqualToString:@"200"])
        {
            cell.guanfangIma.image=[UIImage imageNamed:@"guanfanghong.png"];
        }
        else
        {
            cell.guanfangIma.image=nil;
        }
        
        
        
        
        KJButtdata * butdat = [[KJButtdata alloc] init];
        butdat.yincang = YES;
        cell.buttdata = butdat;
        [butdat release];
        
        cell.contentView.userInteractionEnabled = YES;
        cell.headImageBtn.indexPath = indexPath;
        //    if (tuisongb == NO) {
        //        [cell.headImageBtn addTarget:self action:@selector(goToLotteryList:) forControlEvents:UIControlEventTouchUpInside];
        //    }
        
        //[cell.headImageBtn setImage:[Info imageFromURLString:lottery.picurl] forState:UIControlStateNormal];
        
        
        [cell setImageUrl:lottery.picurl];
        
        
        //cell.name.text = [lottery.lotteryName stringByAppendingString:[NSString stringWithFormat:@"第%@期",lottery.issue]];
        
        CGSize size1,size3;
//        size1=[cell.name.text sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(200, 20)];
        size1=[cell.name.text sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(200, 20)];
        size3=[lottery.region sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 20)];
        
        cell.issue.text = [NSString stringWithFormat:@"%@",lottery.issue];
        
        if([lottery.lotteryNo isEqualToString:@"119"])
        {
            cell.name.text=lottery.lotteryName;
            cell.difangLab.text=lottery.region;
            cell.issue.frame = CGRectMake(size1.width+10, 10, 74, 20);
            cell.issue.frame = CGRectMake(size1.width+size3.width+20+5, 10, 74, 20);
        }
        else if([lottery.lotteryNo isEqualToString:LOTTERY_ID_SHANXI_11])
        {
            cell.name.text=lottery.lotteryName;
            cell.difangLab.text=lottery.region;
            cell.issue.frame = CGRectMake(size1.width+10, 10, 74, 20);
            cell.issue.frame = CGRectMake(size1.width+size3.width+20+5, 10, 74, 20);
        }
        else if([lottery.lotteryNo isEqualToString:LOTTERY_ID_JIANGXI_11])
        {
            cell.name.text=lottery.lotteryName;
            cell.difangLab.text=lottery.region;
            cell.issue.frame = CGRectMake(size1.width+10, 10, 74, 20);
            cell.issue.frame = CGRectMake(size1.width+size3.width+20+5, 10, 74, 20);
        }
        else if([lottery.lotteryNo isEqualToString:@"121"])
        {
            cell.name.text=lottery.lotteryName;
            cell.difangLab.text=lottery.region;
            cell.issue.frame = CGRectMake(size1.width+10, 10, 74, 20);
            cell.issue.frame = CGRectMake(size1.width+size3.width+20+5, 10, 74, 20);
        }
        else if([lottery.lotteryNo isEqualToString:@"012"])
        {
            cell.name.text=lottery.lotteryName;
            cell.difangLab.text=lottery.region;
            cell.issue.frame = CGRectMake(size1.width+10, 10, 74, 20);
            cell.issue.frame = CGRectMake(size1.width+size3.width+20+5, 10, 74, 20);
        }
        else if([lottery.lotteryNo isEqualToString:@"013"])
        {
            cell.name.text=lottery.lotteryName;
            cell.difangLab.text=lottery.region;
            cell.issue.frame = CGRectMake(size1.width+10, 10, 74, 20);
            cell.issue.frame = CGRectMake(size1.width+size3.width+20+5, 10, 74, 20);
        }
        else if([lottery.lotteryNo isEqualToString:@"019"])
        {
            cell.name.text=lottery.lotteryName;
            cell.difangLab.text=lottery.region;
            cell.issue.frame = CGRectMake(size1.width+10, 10, 74, 20);
            cell.issue.frame = CGRectMake(size1.width+size3.width+20+5, 10, 74, 20);
        }
        else if([lottery.lotteryNo isEqualToString:LOTTERY_ID_JILIN])
        {
            cell.name.text=lottery.lotteryName;
            cell.difangLab.text=lottery.region;
            cell.issue.frame = CGRectMake(size1.width+10, 10, 74, 20);
            cell.issue.frame = CGRectMake(size1.width+size3.width+20+5, 10, 74, 20);
        }
        else if([lottery.lotteryNo isEqualToString:LOTTERY_ID_ANHUI])
        {
            cell.name.text=lottery.lotteryName;
            cell.difangLab.text=lottery.region;
            cell.issue.frame = CGRectMake(size1.width+10, 10, 74, 20);
            cell.issue.frame = CGRectMake(size1.width+size3.width+20+5, 10, 74, 20);
        }

        else if([lottery.lotteryNo isEqualToString:@"006"])
        {
            cell.name.text=lottery.lotteryName;
            cell.difangLab.text=lottery.region;
            cell.issue.frame = CGRectMake(size1.width+10, 10, 74, 20);
            cell.issue.frame = CGRectMake(size1.width+size3.width+20+5, 10, 74, 20);
        }
        else if([lottery.lotteryNo isEqualToString:@"014"])
        {
            cell.name.text=lottery.lotteryName;
            cell.difangLab.text=lottery.region;
            cell.issue.frame = CGRectMake(size1.width+10, 10, 74, 20);
            cell.issue.frame = CGRectMake(size1.width+size3.width+20+5, 10, 74, 20);
        }
        else
        {
            cell.difangLab.text=@"";
        }
        NSLog(@"%@",lottery.issue);
        CGSize size;
//        NSString * nameLeng = @"";
        
//        if ([lottery.lotteryNo isEqualToString:@"014"] || [lottery.lotteryNo isEqualToString:@"006"]||[lottery.lotteryNo isEqualToString:@"019"]|[lottery.lotteryNo isEqualToString:@"013"]||[lottery.lotteryNo isEqualToString:@"012"]||[lottery.lotteryNo isEqualToString:@"121"]||[lottery.lotteryNo isEqualToString:@"119"]) {
//            nameLeng = [NSString stringWithFormat:@"%@%@", cell.name.text, lottery.region];
//        }else{
//            nameLeng = [NSString stringWithFormat:@"%@", cell.name.text];
//        }
        
        size=[cell.name.text sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(200, 20)];
        cell.difangLab.frame=CGRectMake(size.width+20, 10, 60, 20);
        
        
        //cell.issue.text = [NSString stringWithFormat:@"%@",lottery.ernieDateNew];
        
        CGSize size2;
        size2=[cell.issue.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 20)];
        cell.labaimage.frame = CGRectMake(280, 10, 10, 12);
        cell.qilabel.frame = CGRectMake(size2.width+cell.issue.frame.origin.x + 3, 10, 200, 20);
        cell.qilabel.text = [NSString stringWithFormat:@"期 %@",lottery.ernieDateNew];
        if ([lottery.weekday length] && ([lottery.lotteryNo isEqualToString:@"001"]||[lottery.lotteryNo isEqualToString:@"003"]||[lottery.lotteryNo isEqualToString:@"113"])) {
            cell.qilabel.text = [NSString stringWithFormat:@"期 %@ %@",lottery.ernieDateNew,lottery.weekday];
        }
        if ([lottery.lotteryNo isEqualToString:@"300"]||[lottery.lotteryNo isEqualToString:@"301"]||[lottery.lotteryNo isEqualToString:@"302"]||[lottery.lotteryNo isEqualToString:@"303"]) {
            cell.ballsView.hidden = NO;
            if ([cell.ballsView.subviews count]>0) {
                for (UIView *view in cell.ballsView.subviews) {
                    [view removeFromSuperview];
                }
            }
//            cell.ballsView.frame = CGRectMake(63, 30, 232, 45);
            cell.ballsView.frame = CGRectMake(15+10, 50-5, 232, 45);
            NSArray * allnumber = [lottery.openNumber componentsSeparatedByString:@","];
            NSLog(@"all = %@", allnumber);
            
            for (int i = 0; i < [allnumber count]; i++) {
//                UIImageView * numbg = [[UIImageView alloc] initWithFrame:CGRectMake(15 * i+1, 0, 15, 20)];
                UIImageView * numbg = [[UIImageView alloc] initWithFrame:CGRectMake(19 * i, 0, 17, 30)];
                numbg.backgroundColor = [UIColor clearColor];
//                numbg.image = UIImageGetImageFromName(@"BDHK960.png");
                numbg.backgroundColor=[UIColor redColor];
                
                UILabel * labelnum = [[UILabel alloc] initWithFrame:numbg.bounds];
                labelnum.backgroundColor = [UIColor clearColor];
//                labelnum.font = [UIFont systemFontOfSize:12];
                labelnum.font = [UIFont systemFontOfSize:13];
                labelnum.textAlignment = NSTextAlignmentCenter;
                labelnum.textColor = [UIColor whiteColor];
                labelnum.text = [allnumber objectAtIndex:i];

                [numbg addSubview:labelnum];
                [labelnum release];
                [cell.ballsView addSubview:numbg];
                [numbg release];
              
                
            }
            
            
//            UILabel *label = [[UILabel alloc] init];
//            label.frame = CGRectMake(0, 0, 250, 25);
//            label.backgroundColor = [UIColor clearColor];
//            label.text = lottery.openNumber;
//            [cell.ballsView addSubview:label];
//            [label release];
        }else if([lottery.lotteryNo isEqualToString:@"122"]){
             cell.ballsView.hidden = NO;
            if ([cell.ballsView.subviews count]>0) {
                for (UIView *view in cell.ballsView.subviews) {
                    [view removeFromSuperview];
                }
            }
//            cell.ballsView.frame = CGRectMake(63, 30, 232, 45);
            cell.ballsView.frame = CGRectMake(15+5, 45-5, 232, 45);
            NSArray * openArray = [lottery.openNumber componentsSeparatedByString:@","];
            if ([openArray count] >= 3) {
               
                
                 NSArray * pukeImageArray =  [self getPukeViewBy:openArray];
                
                for (int i = 0; i < [pukeImageArray count] - 1; i++) {
                    UIImageView * pukeImage = [pukeImageArray objectAtIndex:i];
//                    pukeImage.frame = CGRectMake((pukeImage.frame.size.width+3)*i  , 0, pukeImage.frame.size.width, pukeImage.frame.size.height);
                    pukeImage.frame = CGRectMake((pukeImage.frame.size.width+5+10)*i  , 0, pukeImage.frame.size.width+10, pukeImage.frame.size.height+13);
                    NSLog(@"pukeImage.frame.size.width===%f",pukeImage.frame.size.width);
                    NSLog(@"pukeImage.frame.size.height===%f",pukeImage.frame.size.height);
                   
                    NSLog(@"aaa = %f", pukeImage.frame.size.height );
                    [cell.ballsView addSubview:pukeImage];
                }
                UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(232-100-30, 3, 100, 20)];
                nameLabel.backgroundColor= [UIColor clearColor];
                nameLabel.textAlignment = NSTextAlignmentRight;
                nameLabel.font = [UIFont boldSystemFontOfSize:12];
                nameLabel.text = [pukeImageArray objectAtIndex:3];
                [cell.ballsView addSubview:nameLabel];
                [nameLabel release];
            }
          
            
        
        
        }else if([lottery.lotteryNo isEqualToString:@"012"]||[lottery.lotteryNo isEqualToString:@"013"]||[lottery.lotteryNo isEqualToString:@"019"]||[lottery.lotteryNo isEqualToString:LOTTERY_ID_JILIN]||[lottery.lotteryNo isEqualToString:LOTTERY_ID_ANHUI]){
        
            cell.ballsView.hidden = NO;
            if ([cell.ballsView.subviews count]>0) {
                for (UIView *view in cell.ballsView.subviews) {
                    [view removeFromSuperview];
                }
            }
            
//            cell.ballsView.frame = CGRectMake(63, 30, 232, 45);
            cell.ballsView.frame = CGRectMake(15+5, 45, 232, 45);
            NSArray * openArray = [lottery.openNumber componentsSeparatedByString:@","];
            if ([openArray count] >= 3) {
                
                
                NSArray * pukeImageArray =  [self getShaiZiViewBy:openArray];
                
                for (int i = 0; i < [pukeImageArray count] ; i++) {
                    UIImageView * pukeImage = [pukeImageArray objectAtIndex:i];
//                    pukeImage.frame = CGRectMake((pukeImage.frame.size.width+3)*i  , 0, pukeImage.frame.size.width, pukeImage.frame.size.height);
                    pukeImage.frame = CGRectMake((pukeImage.frame.size.width+5+15)*i  , 0, pukeImage.frame.size.width+15, pukeImage.frame.size.height+13);
                    
                    NSLog(@"aaa = %f", pukeImage.frame.size.height );
                    [cell.ballsView addSubview:pukeImage];
                }
              
            }
        
        } else if([lottery.lotteryNo isEqualToString:@"201"]||[lottery.lotteryNo isEqualToString:@"200"]||[lottery.lotteryNo isEqualToString:@"400"]){
            cell.ballsView.hidden = YES;
        }
        else {
            cell.ballsView.hidden = NO;
            NSMutableArray *imageList = nil;
            if ([lottery.lotteryNo isEqualToString:@"011"]) {
                 imageList = [NSMutableArray arrayWithArray: [lottery imagesWithKuaiLeShiFen] ];
            }else{
                 imageList = [NSMutableArray arrayWithArray:[lottery imagesWithNumber]];
                if ([lottery.lotteryNo isEqualToString:@"001"] && [lottery.Luck_blueNumber length] > 0) {
                    
                    UIImageView *iView = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"luckyblue.png")] ;
                    iView.frame = CGRectMake(0, 0, 24, 24);
                    UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, 22, 22)];
                    [nLabel setText:lottery.Luck_blueNumber];
                    nLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
                    nLabel.textAlignment = NSTextAlignmentCenter;
                    nLabel.highlightedTextColor = [UIColor whiteColor];
                    nLabel.highlighted = YES;
                    nLabel.backgroundColor = [UIColor clearColor];
                    [iView addSubview:nLabel];
                    [nLabel release];
                    [imageList addObject:iView];
                    [iView release];
                }
                
            }
           
            NSArray* temp1 = [lottery.openNumber componentsSeparatedByString:@"+"];
            NSArray* temp3 = nil;
            if ([temp1 count]>1) {
                temp3 = [[temp1 objectAtIndex:0] componentsSeparatedByString:@","];
            }
            
//            CGFloat width = KBALLPICWIDTH;
//            CGFloat space = KSPACE;
//            cell.ballsView.frame = CGRectMake(73, 30, 232, 45);
            cell.ballsView.frame = CGRectMake(25+10, 50-5, 232, 45);
            //clear the ballsview
            if ([cell.ballsView.subviews count]>0) {
                for (UIView *view in cell.ballsView.subviews) {
                    [view removeFromSuperview];
                }
            }
            
           
            if ([imageList count]>KNUMBERPERLOW+1) {//two lows
                for (int i = 0; i<[imageList count]; i++) {
//                    int x = i;
//                    int y = 0;
                    if (i >= KNUMBERPERLOW) {
//                        x = x-KNUMBERPERLOW;
//                        y = width;
                    }
                    UIImageView *view = [imageList objectAtIndex:i];
//                    view.center = CGPointMake(x*(width + space), width/2+y);
                    view.center = CGPointMake(i*30, 0);
                    view.frame=CGRectMake(view.frame.origin.x, 0, 28, 28);
                    [cell.ballsView addSubview:view];
                    
                }
            }else {//one low
                
                for (int i = 0; i<[imageList count]; i++) {
                    
                    UIImageView *view = [imageList objectAtIndex:i];
                    
                   
                    
                    if ([temp1 count]>1) {
                        if ([lottery.lotteryNo isEqualToString:@"001"] && [lottery.Luck_blueNumber length] > 0) {
                            view.center = CGPointMake(i*30, 0);
                            view.frame=CGRectMake(view.frame.origin.x, 0, 28, 28);
                        }else if (i+1 > [temp3 count]) {
                            
//                            view.frame =CGRectMake(182 - ([imageList count] - i - 1)*24, 0, 24, 24);//篮球
                            view.frame =CGRectMake(200 - ([imageList count] - i - 1)*30-30, 0, 28, 28);
                            if([lottery.lotteryNo isEqualToString:@"003"])
                            {
                                view.frame =CGRectMake(200 - ([imageList count] - i - 1)*30, 0, 28, 28);
                            }
                          
                        }else{
//                            view.center = CGPointMake(i*(width + space), width/2);//红球
                            view.center = CGPointMake(i*30, 0);
                            view.frame=CGRectMake(view.frame.origin.x, 0, 28, 28);
                            NSLog(@"%f,%f,%f,%f",view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height);
                            
                            }
                    }else{
                    
//                        view.center = CGPointMake(i*(width + space), width/2);
                        view.center = CGPointMake(i*30, 0);
                        view.frame=CGRectMake(view.frame.origin.x, 0, 28, 28);
                    }
                    [cell.ballsView addSubview:view];

                    
                }
            }
           // [imageList release];
//            UIImageView *lineIma=[[UIImageView alloc]init];
//            lineIma.image=[UIImage imageNamed:@"SZTG960.png"];
//            [cell addSubview:lineIma];
//            [lineIma release];
//
//            if ([lottery.lotteryNo isEqualToString:@"300"]||[lottery.lotteryNo isEqualToString:@"301"]||[lottery.lotteryNo isEqualToString:@"302"]||[lottery.lotteryNo isEqualToString:@"303"]) {
//                lineIma.frame=CGRectMake(15, 61.5, 320, 0.5);
//            }
//            if ([imageList count]>KNUMBERPERLOW+1) {
//                lineIma.frame=CGRectMake(15, 61.5, 320, 0.5);
//            }else {
//                lineIma.frame=CGRectMake(15, 61.5, 320, 0.5);
//            }
        }
        
        //行色
        if (indexPath.row < 3) {
            //	cell.contentView.backgroundColor = [UIColor colorWithRed:1.0 green:200/255.0 blue:104/255.0 alpha:1.0];
            cell.contentView.backgroundColor = [UIColor clearColor];
        }
        else {
            cell.contentView.backgroundColor = [UIColor clearColor];
        }
        

//        UIImageView *lineIma=[[UIImageView alloc]init];
//        lineIma.image=[UIImage imageNamed:@"SZTG960.png"];
//        [cell addSubview:lineIma];
//        [lineIma release];
//        
//        if ([lottery.lotteryNo isEqualToString:@"300"]||[lottery.lotteryNo isEqualToString:@"301"]||[lottery.lotteryNo isEqualToString:@"302"]||[lottery.lotteryNo isEqualToString:@"303"]) {
//            lineIma.frame=CGRectMake(15, 61.5, 320, 0.5);
//        }
//        if ([imageList count]>KNUMBERPERLOW+1) {
//            lineIma.frame=CGRectMake(15, 83.5, 320, 0.5);
//        }else {
//            lineIma.frame=CGRectMake(15, 61.5, 320, 0.5);
//        }
        
        cell.caiimage.image=nil;
        cell.caiimage.backgroundColor=[UIColor clearColor];
        
        
        return cell;
    
    }
    
	return nil;
	

}


-(void)goToLotteryList:(id)sender{
    
    NSLog(@"　");
    NSLog(@" ");
    NSLog(@" ");
    NSLog(@" ");
	
	LotteryButton *btn = (LotteryButton*)sender;
	NSIndexPath* indexPath = btn.indexPath;
	
	NSDictionary *dic = [self.lotteries objectAtIndex:indexPath.section];
	NSArray *arr = [dic objectForKey:@"list"];
    LastLottery *lottery = [arr objectAtIndex:indexPath.row];
    if ([lottery.lotteryNo isEqualToString:@"119"]) {
        [MobClick event:@"event_kaijiang_11xuan5_history"];
    }
    else if ([lottery.lotteryNo isEqualToString:@"006"]){
        [MobClick event:@"event_kaijiang_shishicai_history"];
    }
    else if ([lottery.lotteryNo isEqualToString:@"001"]){
        [MobClick event:@"event_kaijiang_shuangseqiu_history"];
    }
    else if ([lottery.lotteryNo isEqualToString:@"002"]){
        [MobClick event:@"event_kaijiang_fucai3d_history"];
    }
    else if ([lottery.lotteryNo isEqualToString:@"113"]){
        [MobClick event:@"event_kaijiang_chaojiletou_history"];
    }
    else if ([lottery.lotteryNo isEqualToString:@"003"]){
        [MobClick event:@"event_kaijiang_7lecai_history"];
    }
    else if ([lottery.lotteryNo isEqualToString:@"109"]){
        [MobClick event:@"event_kaijiang_pailie5_history"];
    }
    else if ([lottery.lotteryNo isEqualToString:@"110"]){
        [MobClick event:@"event_kaijiang_qixingcai_histroy"];
    }
    else if ([lottery.lotteryNo isEqualToString:@"111"]){
        [MobClick event:@"event_kaijiang_22xuan5_history"];
    }
    else if ([lottery.lotteryNo isEqualToString:@"108"]){
        [MobClick event:@"event_kaijiang_pailie3_history"];
    }
    else if ([lottery.lotteryNo isEqualToString:@"300"]||[lottery.lotteryNo isEqualToString:@"301"]){
        [MobClick event:@"event_kaijiang_shengfu9_history"];
    }
    else if ([lottery.lotteryNo isEqualToString:@"302"]){
        [MobClick event:@"event_kaijiang_banquanchang_history"];
    }
    else if ([lottery.lotteryNo isEqualToString:@"303"]){
        [MobClick event:@"event_kaijiang_jinqiucai_history"];
    }else if([lottery.lotteryNo isEqualToString:@"011"]){
        
    }

	LotteryListViewController *controller = [[LotteryListViewController alloc] init];
	
	controller.lotteryId = lottery.lotteryNo;
	[self.navigationController pushViewController:controller animated:YES];
    [controller release];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		return 44;
	}

    
    if (tableView.tag == 111) {
        if (indexPath.row == 0) {
            return 73;
        }
        
        
        
        return 43;
    }else{
        
        
        
        NSDictionary *dic = [self.lotteries objectAtIndex:indexPath.section];
        NSArray *arr = [dic objectForKey:@"list"];
        LastLottery *lottery = [arr objectAtIndex:indexPath.row];
            NSLog(@"%@",lottery.lotteryNo);
        NSArray *imageList = nil;
        if ([lottery.lotteryNo isEqualToString:@"011"]) {
            imageList = [lottery imagesWithKuaiLeShiFen];
        }else{
            imageList = [lottery imagesWithNumber];
        }
        if ([lottery.lotteryNo isEqualToString:@"300"]||[lottery.lotteryNo isEqualToString:@"301"]||[lottery.lotteryNo isEqualToString:@"302"]||[lottery.lotteryNo isEqualToString:@"303"]) {
//            return 62;
            return 93;
        }
        if ([imageList count]>KNUMBERPERLOW+1) {
            return 85.0;
        }
//        if([lottery.lotteryNo isEqualToString:@"201"]||[lottery.lotteryNo isEqualToString:@"200"]||[lottery.lotteryNo isEqualToString:@"400"])
//        {
//            return 50;
//        }
        else {
//            return 62.0;
            return 93.0;
        }

    }
    return 0;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	
//	return 25.0;

//    return  10;
    return  10;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		[self sendSeachRequest:[self.seachTextListarry objectAtIndex:indexPath.row]];
		return;
	}
    
    if (tableView.tag == 111) {
        NSString * string = [arrdict objectAtIndex:indexPath.section];
        NSArray * array = [redDictionary objectForKey:string];
        AnnouncementData * annou = [array objectAtIndex:indexPath.row];
        Nickname = annou.user;
        userid = annou.userID;
        
        username= annou.userName;
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"他的彩票", @"他的合买", @"@他", @"他的微博",@"他的资料", nil];
        [actionSheet showInView:self.mainView];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            actionSheet.frame = CGRectMake(0, self.mainView.frame.size.height - actionSheet.frame.size.height + 60, 320, actionSheet.frame.size.height);
        }
        [actionSheet release];

    }else{
    
//        if (tuisongb == NO) {
//            NSDictionary *dic = [self.lotteries objectAtIndex:indexPath.section];
//            NSArray *arr = [dic objectForKey:@"list"];
//            LastLottery *lottery = [arr objectAtIndex:indexPath.row];
//            LotteryListViewController *controller = [[LotteryListViewController alloc] init];
//            
//            controller.lotteryId = lottery.lotteryNo;
//            controller.lotteryName = lottery.lotteryName;
//            [self.navigationController pushViewController:controller animated:YES];
//            [controller release];
//        }
        
        
        NSDictionary *dic = [self.lotteries objectAtIndex:indexPath.section];
        NSArray *arr = [dic objectForKey:@"list"];
        LastLottery *lottery = [arr objectAtIndex:indexPath.row];
        
        if ([lottery.lotteryNo isEqualToString:@"201"] || [lottery.lotteryNo isEqualToString:@"200"] || [lottery.lotteryNo isEqualToString:@"400"]) {
            
            footballLotteryInfoViewController * football = [[footballLotteryInfoViewController alloc] init];
//            football.issueString = lottery.issue;
            
            if ([lottery.lotteryNo isEqualToString:@"201"]) {
                football.lotteryAll = jingcaizuqiu;
                
            }else if ([lottery.lotteryNo isEqualToString:@"200"]) {
                football.lotteryAll = jingcailanqiu;
            }else if ([lottery.lotteryNo isEqualToString:@"400"]) {
                football.lotteryAll = beijingdanchang;
            }
            
            
            [self.navigationController pushViewController:football animated:YES];
            [football release];
            return;
        }
        
//        LotteryList *lList = [lotteryListArray objectAtIndex:indexPath.row];
//		self.issue = lList.issue;
        
        NSLog(@"lotterid = %@", lottery.lotteryNo);
        NSLog(@"userid = %@", [[Info getInstance] userId]);
        NSLog(@"issue = %@", lottery.issue);
        
        lotteryId = lottery.lotteryNo;
        NSString * huastr = [NSString stringWithFormat:@"%@%@期开奖", lottery.lotteryName, lottery.issue];
        NSLog(@"sss= %@",huastr);
        
        if ([lottery.lotteryNo isEqualToString:@"014"] || [lottery.lotteryNo isEqualToString:@"006"]||[lottery.lotteryNo isEqualToString:@"019"]|[lottery.lotteryNo isEqualToString:@"013"]||[lottery.lotteryNo isEqualToString:@"012"]||[lottery.lotteryNo isEqualToString:@"121"]||[lottery.lotteryNo isEqualToString:@"119"]||[lottery.lotteryNo isEqualToString:LOTTERY_ID_JILIN]||[lottery.lotteryNo isEqualToString:LOTTERY_ID_JIANGXI_11]||[lottery.lotteryNo isEqualToString:LOTTERY_ID_ANHUI]) {
        
            self.lotteryName =  [NSString stringWithFormat:@"%@%@", lottery.region, lottery.lotteryName];
        }else{
            self.lotteryName = lottery.lotteryName;
        }
        NSLog(@"aaaaaaaa = %@", self.lotteryName);
        rownum = indexPath.row;
        sectionnum = indexPath.section;
        
        
        
        NSString * useridstr = @"";
        if ([[[Info getInstance] userId] length]>1) {
            useridstr = [[Info getInstance] userId];
        }else{
            useridstr = @"0";
        }
        statepop = [StatePopupView getInstance];
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [statepop showInView:appDelegate.window Text:@"请稍等..."];

        NSLog(@"url = %@", [NetURL cpthreeKaiJiangHuaTiLotteryId:lottery.lotteryNo userid:useridstr pageSize:@"5" PageNum:@"1" issue:lottery.issue themeName:huastr]);
        ASIHTTPRequest *httpReuqest = [ASIHTTPRequest requestWithURL:
									   [NetURL cpthreeKaiJiangHuaTiLotteryId:lottery.lotteryNo userid:useridstr pageSize:@"5" PageNum:@"1" issue:lottery.issue themeName:huastr]];
		
		[httpReuqest setDefaultResponseEncoding:NSUTF8StringEncoding];
		[httpReuqest setDelegate:self];
		[httpReuqest setDidFinishSelector:@selector(kaijianghuati:)];
        [httpReuqest setDidFailSelector:@selector(failselector:)];
		[httpReuqest setNumberOfTimesToRetryOnTimeout:2];
		[httpReuqest startAsynchronous];

        
    }
	
		
	

}

- (void)failselector:(ASIHTTPRequest *)mrequest{
    [statepop dismiss];
}

- (void)kaijianghuati:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    [statepop dismiss];
    
    NSDictionary * dict = [str JSONValue];
    NSLog(@"str = %@", dict);
    
    NSString * msg = [dict valueForKey:@"msg"];
    if (msg && [msg length]) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:msg];
        
        if ([msg isEqualToString:@"详情信息暂未开出，请稍后再试"]) {
            return;
        }
    }
    
    NSString * xiaoshou = [dict objectForKey:@"buyamont"];
    NSString * datestr = [dict objectForKey:@"ernie_date"];
    NSString * jiangchistr = [dict objectForKey:@"prizePool"];
    NSArray * zhongArray = [dict objectForKey:@"reList"];
    
    //大乐透修改
    if(zhongArray.count == 8)
    {
        if([[dict objectForKey:@"lotteryId"] isEqualToString:@"113"])
        {
            NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:zhongArray];
            [mutableArray removeObjectAtIndex:7];
            [mutableArray removeObjectAtIndex:6];
            zhongArray = [NSArray arrayWithArray:mutableArray];
        }
    }

    NSString * issstri = [dict objectForKey:@"issue"];
    NSString *  lotternum = [dict objectForKey:@"lotteryNumber"];
    NSArray * conarray = [dict objectForKey:@"themes"];
    NSMutableArray * urarray = [NSMutableArray arrayWithCapacity:0];
    NSDictionary * matchdict = [dict objectForKey:@"match"];
    NSArray * paihangarr = [dict objectForKey:@"paihangbang"];
   
    for (NSDictionary * d in conarray) {
        NSString * ur = [d objectForKey:@"content"];
        NSLog(@"ur = %@", ur);
        [urarray addObject:ur];
    }
    NSString * shisichang = [dict objectForKey:@"sales_sfc"];
    NSString * renjiu = [dict objectForKey:@"sales_rx9"];
    
    //  NSString * contentstr = [dict objectForKey:@"content"];
    NSString * huastr = [NSString stringWithFormat:@"#%@%@期开奖#", lotteryName, issstri];
//    NSLog(@"huati = %@", huastr);
    
    KJXiangQingViewController * kjxq = [[KJXiangQingViewController alloc] init];
    kjxq.paihangarr = paihangarr;
    kjxq.lotteryNumber = lotternum;
    kjxq.matchdict = matchdict;
    kjxq.rownum = rownum;
    kjxq.lotteryName = lotteryName;
    kjxq.sectionnum = sectionnum;
    kjxq.lotteries = self.lotteries;
    kjxq.wangqibool = YES;
    kjxq.issuesting = issstri;
    kjxq.benstring = xiaoshou;
    kjxq.datestring = datestr;
    NSLog(@"%@",datestr);
    if ([[dict objectForKey:@"lotteryId"] isEqualToString:@"113"] || [[dict objectForKey:@"lotteryId"] isEqualToString:@"001"] || [[dict objectForKey:@"lotteryId"] isEqualToString:@"003"]) {
        if ([[dict objectForKey:@"weekday"] length]) {
            kjxq.datestring = [NSString stringWithFormat:@"%@ %@",datestr,[dict objectForKey:@"weekday"]];
        }
    }
    kjxq.qiustring = lotternum;
    kjxq.zhongarray = zhongArray;
    kjxq.chistring = jiangchistr;
    NSLog(@"reyiarray = %@", conarray);
    kjxq.reyiArray = conarray;
    kjxq.shisi = shisichang;
    kjxq.renjiu = renjiu;
    kjxq.huatistring = [NSString stringWithFormat:@"%@", huastr];
    kjxq.cainame = [NSString stringWithFormat:@"%@", lotteryId];
    kjxq.Luck_blueNumber = [dict objectForKey:@"Luck_blueNumber"];
//    kjxq.Luck_blueNumber = @"10";
    [self.navigationController pushViewController:kjxq animated:YES];
    [kjxq release];
    //    @synthesize  issuesting;//期号
    //    @synthesize datestring;//时间
    //    @synthesize qiustring;//开奖号码 球
    //    @synthesize benstring;//本期销售
    //    @synthesize chistring;//奖池
    
    //    @synthesize zhongarray;//中奖信息
    
}
- (void)otherLottoryViewController:(NSInteger)indexd{
    
    MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
    my.userName = username;
    my.nickName = Nickname;
    my.userid = userid;
    
    MyLottoryViewController *my2 = [[MyLottoryViewController alloc] init];
    my2.myLottoryType = MyLottoryTypeOtherHe;
    my2.userName = username;
    my2.nickName = Nickname;
    my2.userid = userid;
    
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
//    tabc.delegateCP = self;
//    tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
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


- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {//他的方案
        if ([[[Info getInstance] userId] intValue] == 0) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"登录后可用"];
            return;
        }

        NSLog(@"0000000000");
//		MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
//		my.userName = username;
//		my.nickName = Nickname;
//		[self.navigationController pushViewController:my animated:YES];
//		my.title = Nickname;
//		[my release];
        [self otherLottoryViewController:0];
    }else if(buttonIndex == 1){
        if ([[[Info getInstance] userId] intValue] == 0) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"登录后可用"];
            return;
        }

//        MyLottoryViewController *my = [[MyLottoryViewController alloc] init];
//        my.myLottoryType = MyLottoryTypeOtherHe;
//		my.userName = username;
//		my.nickName = Nickname;
//		[self.navigationController pushViewController:my animated:YES];
//		my.title = Nickname;
//		[my release];
        [self otherLottoryViewController:1];
        
    }else if (buttonIndex == 2){ // @他
        if ([[[Info getInstance] userId] intValue] == 0) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"登录后可用"];
            return;
        }
        

        NSLog(@"1111111");
        
#ifdef isCaiPiaoForIPad
        YtTopic *topic1 = [[YtTopic alloc] init];
        NSMutableString *mTempStr = [[NSMutableString alloc] init];
        [mTempStr appendString:@"@"];
        [mTempStr appendString:Nickname];//传用户名
        [mTempStr appendString:@" "];
        topic1.nick_name = mTempStr;
        [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kNewTopicController mStatus:topic1];
        
        [topic1 release];
#else
        
//        NewPostViewController *publishController = [[NewPostViewController alloc] init];
//        publishController.publishType = kNewTopicController;// 自发彩博
//        YtTopic *topic1 = [[YtTopic alloc] init];
//        NSMutableString *mTempStr = [[NSMutableString alloc] init];
//        [mTempStr appendString:@"@"];
//        [mTempStr appendString:Nickname];//传用户名
//        [mTempStr appendString:@" "];
//        topic1.nick_name = mTempStr;
//        publishController.mStatus = topic1;
//
//        [self.navigationController pushViewController:publishController animated:YES];
//        [topic1 release];
//        [mTempStr release];
////        [navController release];
//        [publishController release];
        
        
        SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
        publishController.microblogType = NewTopicController;// 自发彩博
        YtTopic *topic1 = [[YtTopic alloc] init];
        NSMutableString *mTempStr = [[NSMutableString alloc] init];
        [mTempStr appendString:@"@"];
        [mTempStr appendString:Nickname];//传用户名
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
        if ([[[Info getInstance] userId] intValue] == 0) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"登录后可用"];
            return;
        }
        TwitterMessageViewController *controller = [[TwitterMessageViewController alloc] init];
        controller.userID = userid;
        controller.title = @"他的微博";
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
        
//        ProfileTabBarController *controller = [[ProfileTabBarController alloc] initWithUerself:NO userID:userid];//himID传用户的id
//        [controller setSelectedIndex:0];
//        controller.navigationItem.title = @"微博";
//        [self.navigationController pushViewController:controller animated:YES];
//		[controller release];
    }else if (buttonIndex == 4){//他的资料
        [[Info getInstance] setHimId:userid];
        ProfileViewController *followeesController = [[ProfileViewController alloc] init];
        [self.navigationController pushViewController:followeesController animated:YES];
        [followeesController release];
    }
}



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    [super viewDidUnload];
}


- (void)dealloc {
    [swicthArray release];
    [arrdict release];
    [redDictionary release];
    [redTabelView release];
  
    [alldatabool release];
    [baocunArray release];
    [statusData release];
    [myTabelView release];
	[mRefreshView release];
	[lotteries release];
    [redRequest clearDelegatesAndCancel];
    [redRequest release];
	[aRequest clearDelegatesAndCancel];
	[aRequest release];
    [super dealloc];
}


@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    