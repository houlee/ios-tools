//
//  LotteryListViewController.m
//  caibo
//
//  Created by sulele on 11-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LotteryListViewController.h"
#import "Info.h"
#import "LotteryList.h"
#import "ASIHTTPRequest.h"
#import "CheckNetwork.h"
#import "NetURL.h"
#import "LotteryDetailViewController.h"
#import "MoreLoadCell.h"
#import "LotteryDetail.h"
#import "KJXiangQingViewController.h"
#import "JSON.h"
#import "caiboAppDelegate.h"
#import "MobClick.h"
#import "HighFreqViewController.h"
#import "ShiShiCaiViewController.h"
#import "CQShiShiCaiViewController.h"
#import "GouCaiShuangSeQiuViewController.h"
#import "FuCai3DViewController.h"
#import "DaLeTouViewController.h"
#import "QIleCaiViewController.h"
#import "PaiWuOrQiXingViewController.h"
#import "Pai3ViewController.h"
#import "GCBettingViewController.h"
#import "GCJCBetViewController.h"
#import "GC_BJDanChangViewController.h"
#import "KuaiSanViewController.h"
#import "HappyTenViewController.h"
#import "KuaiLePuKeViewController.h"
#import "SharedDefine.h"
#import "GC_PKRankingList.h"
#import "HorseRaceViewController.h"

#define KBALLPICWIDTH 24


@implementation LotteryListViewController
@synthesize lotteryId,lotteryName,PageNo,PageSize;
@synthesize lotteryListArray;
@synthesize lotteryList, lotDetail, issue;
@synthesize rankRequest;


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


- (void)viewDidLoad {
     [super viewDidLoad];
	self.CP_navigation.title = self.lotteryName;
    
    if ([lotteryId isEqualToString:@"119"] || [lotteryId isEqualToString:@"012"])
    {
        if (![self.CP_navigation.title isEqualToString:Lottery_Name_Horse]) {
            self.CP_navigation.title = [NSString stringWithFormat:@"%@",self.lotteryName];
        }
    }
    if ([lotteryId isEqualToString:@"107"])
    {
        self.CP_navigation.title = [NSString stringWithFormat:@"江西%@",self.lotteryName];
    }
    if ([lotteryId isEqualToString:@"121"])
    {
        self.CP_navigation.title = [NSString stringWithFormat:@"广东%@",self.lotteryName];
    }
    if ([lotteryId isEqualToString:@"013"])
    {
        self.CP_navigation.title = [NSString stringWithFormat:@"江苏%@",self.lotteryName];
    }
    if ([lotteryId isEqualToString:@"018"])
    {
        self.CP_navigation.title = [NSString stringWithFormat:@"吉林%@",self.lotteryName];
    }
//    if ([lotteryId isEqualToString:LOTTERY_ID_ANHUI])
//    {
//        self.CP_navigation.title = [NSString stringWithFormat:@"新%@",self.lotteryName];
//    }
    if ([lotteryId isEqualToString:@"019"])
    {
        self.CP_navigation.title = [NSString stringWithFormat:@"湖北%@",self.lotteryName];
    }

    
    //    UIImageView * bgimgev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    //    bgimgev.image = UIImageGetImageFromName(@"login_bg.png");
    //    [self.view addSubview:bgimgev];
    
    
    
//    statepop = [StatePopupView getInstance];
//    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
//    [statepop showInView:appDelegate.window Text:@"请稍等..."];
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    
    
	//返回按钮
//	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(back:)];
//	self.CP_navigation.leftBarButtonItem = leftItem;
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(back)];
	//self.navigationItem.leftBarButtonItem = leftItem;
	self.CP_navigation.leftBarButtonItem = leftItem;
	
   
	//self.lotteryListArray = (NSMutableArray *)lotteryList.reListArray;
	
	//self.lotteryId = @"001";
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    bgimage.image = UIImageGetImageFromName(@"login_bgn.png");
    bgimage.backgroundColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:242/255.0 alpha:1];
    [self.mainView addSubview:bgimage];
    [bgimage release];
    
#ifdef isCaiPiaoForIPad
     myTableView = [[UITableView alloc] initWithFrame:CGRectMake(35, 0, 320, self.mainView.bounds.size.height) style:UITableViewStylePlain];
#else
     myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height) style:UITableViewStylePlain];
    
#endif
    
   

    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:myTableView];
    
	self.PageNo = @"1";
   
	self.PageSize = @"20";
	
	fristLoading = YES;
	listLoadedEnd = NO;
	if (!lotteryListArray) {
		[self sendLotteryListRequest];
	}
	else {
		[myTableView reloadData];
	}
    
	
	lotDetail.msg = nil;
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    if ([lotteryId isEqualToString:@"303"] ||[lotteryId isEqualToString:@"302"] ||[lotteryId isEqualToString:@"111"]||[lotteryId isEqualToString:@"300"]||[lotteryId isEqualToString:@"301"]||[lotteryId isEqualToString:@"200"]||[lotteryId isEqualToString:@"201"]||[lotteryId isEqualToString:@"400"]||[lotteryId isEqualToString:@"012"]||[lotteryId isEqualToString:@"013"]||[lotteryId isEqualToString:@"019"]||[lotteryId isEqualToString:@"018"]||[lotteryId isEqualToString:@"107"]||[lotteryId isEqualToString:@"119"]||[lotteryId isEqualToString:@"121"]||[lotteryId isEqualToString:@"122"]||[lotteryId isEqualToString:@"014"]||[lotteryId isEqualToString:@"011"]||[lotteryId isEqualToString:LOTTERY_ID_ANHUI]) {
        return;
    }
    
    myTableView.frame = CGRectMake(0, 0, 320, self.mainView.frame.size.height - 44);
    
    
    UIImageView * gcImageBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.frame.size.height - 44, 320, 44)];//下面投注按钮背景
    gcImageBg.backgroundColor = [UIColor clearColor];
//    gcImageBg.image = UIImageGetImageFromName(@"daigoubgimage.png");
    gcImageBg.backgroundColor = [UIColor colorWithRed:22/255.0 green:23/255.0 blue:25/255.0 alpha:1];
    gcImageBg.userInteractionEnabled = YES;
    [self.mainView addSubview:gcImageBg];
    [gcImageBg release];
    
    NSString *str = [NSString stringWithFormat:@"%@投注", self.lotteryName];
    CGSize size=[str sizeWithFont:[UIFont systemFontOfSize:18]];
    
    UIButton * gcButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    gcButton.frame = CGRectMake((gcImageBg.frame.size.width - 270)/2, (gcImageBg.frame.size.height - 33)/2, 270, 33);
    gcButton.frame = CGRectMake((gcImageBg.frame.size.width - size.width-20)/2, (gcImageBg.frame.size.height - 33)/2, size.width+20, 33);
    [gcButton addTarget:self action:@selector(pressGcButton:) forControlEvents:UIControlEventTouchUpInside];
//    [gcButton setImage:UIImageGetImageFromName(@"daigouanniu.png") forState:UIControlStateNormal];
//    [gcButton setImage:UIImageGetImageFromName(@"daigouanniu_1.png") forState:UIControlStateHighlighted];
    
    [gcButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [gcButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [gcButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    
    [gcImageBg addSubview:gcButton];
    
    UILabel * buttonLabel = [[UILabel alloc] initWithFrame:gcButton.bounds];
    buttonLabel.backgroundColor = [UIColor clearColor];
//    buttonLabel.textColor = [UIColor colorWithRed:0/255.0 green:89/255.0 blue:126/255.0 alpha:1];
    buttonLabel.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    buttonLabel.text = [NSString stringWithFormat:@"%@投注", self.lotteryName];
//    buttonLabel.font = [UIFont systemFontOfSize:14];
    buttonLabel.font = [UIFont systemFontOfSize:18];
    buttonLabel.textAlignment = NSTextAlignmentCenter;
    [gcButton addSubview:buttonLabel];
    [buttonLabel release];
}

- (void)pressGcButton:(UIButton *)sender{
    
//    NSDictionary *dic = [self.lotteries objectAtIndex:sectionnum];
//    NSArray *arr = [dic objectForKey:@"list"];
//    LastLottery *lottery = [arr objectAtIndex:rownum];
    if ([lotteryId isEqualToString:@"119"]) {
        if ([self.lotteryName isEqualToString:Lottery_Name_Horse]) {
            HorseRaceViewController * high = [[[HorseRaceViewController alloc] init] autorelease];
            [self.navigationController pushViewController:high animated:YES];

        }else{
            HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:ShanDong11];
            [self.navigationController pushViewController:highview animated:YES];
            [highview release];
        }
    }
    else if ([lotteryId isEqualToString:@"121"]) {
        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:GuangDong11];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
    }
    else if ([lotteryId isEqualToString:LOTTERY_ID_JIANGXI_11]) {
        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:JiangXi11];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
    }
    else if ([lotteryId isEqualToString:@"123"]) {
        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:HeBei11];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
    }
    else if ([lotteryId isEqualToString:LOTTERY_ID_SHANXI_11]) {
        HighFreqViewController * highview = [[HighFreqViewController alloc] initWithElevenType:ShanXi11];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
    }
    else if ([lotteryId isEqualToString:@"006"]){
        
        ShiShiCaiViewController *shishi = [[ShiShiCaiViewController alloc] init];
        [self.navigationController pushViewController:shishi animated:YES];
        [shishi release];
    }
    else if ([lotteryId isEqualToString:@"014"]){
        
        CQShiShiCaiViewController *shishi = [[CQShiShiCaiViewController alloc] init];
        [self.navigationController pushViewController:shishi animated:YES];
        [shishi release];
    }
    else if ([lotteryId isEqualToString:@"001"]){
        GouCaiShuangSeQiuViewController *shuang = [[GouCaiShuangSeQiuViewController alloc] init];
        //        shuang.item = cell.myrecord.curIssue;
        [self.navigationController pushViewController:shuang animated:YES];
        //shuang.title = [NSString stringWithFormat:@"双色球%@期",cell.myrecord.curIssue];
        [shuang release];
    }
    else if ([lotteryId isEqualToString:@"002"]){
        //        [MobClick event:@"event_kaijiang_fucai3d_detail"];
        FuCai3DViewController *fucai = [[FuCai3DViewController alloc] init];
        //        fucai.myissueRecord = cell.myrecord;
        [self.navigationController pushViewController:fucai animated:YES];
        [fucai release];
    }
    else if ([lotteryId isEqualToString:@"113"]){
        //        [MobClick event:@"event_kaijiang_chaojiletou_detail"];
        DaLeTouViewController *dale = [[DaLeTouViewController alloc] init];
        //        dale.myissueRecord = cell.myrecord;
        [self.navigationController pushViewController:dale animated:YES];
        [dale release];
    }
    else if ([lotteryId isEqualToString:@"003"]){
        //        [MobClick event:@"event_kaijiang_7lecai_detail"];
        QIleCaiViewController *con = [[QIleCaiViewController alloc] init];
        //        con.myissueRecord = cell.myrecord;
        [self.navigationController pushViewController:con animated:YES];
        [con release];
    }
    else if ([lotteryId isEqualToString:@"109"]){
        //        [MobClick event:@"event_kaijiang_pailie5_detail"];
        PaiWuOrQiXingViewController * paiwuqixing = [[PaiWuOrQiXingViewController alloc] init];
        //        paiwuqixing.myissueRecord = cell.myrecord;
        paiwuqixing.qixingorpaiwu = shuZiCaiPaiWu;
        [self.navigationController pushViewController:paiwuqixing animated:YES];
        [paiwuqixing release];
    }
    else if ([lotteryId isEqualToString:@"110"]){
        //        [MobClick event:@"event_kaijiang_qixingcai_detail"];
        PaiWuOrQiXingViewController * paiwuqixing = [[PaiWuOrQiXingViewController alloc] init];
        //        paiwuqixing.myissueRecord = cell.myrecord;
        paiwuqixing.qixingorpaiwu = shuZiCaiQiXing;
        [self.navigationController pushViewController:paiwuqixing animated:YES];
        [paiwuqixing release];
    }
    else if ([lotteryId isEqualToString:@"108"]){
        //        [MobClick event:@"event_kaijiang_pailie3_detail"];
        Pai3ViewController *pai = [[Pai3ViewController alloc] init];
        //        pai.myissueRecord = cell.myrecord;
        [self.navigationController pushViewController:pai animated:YES];
        [pai release];
    }
    
    
    else if([lotteryId isEqualToString:@"012"]){
        KuaiSanViewController * highview = [[KuaiSanViewController alloc] initWithType:NeiMengKuaiSan];
        //        highview.issue = cell.myrecord.curIssue;
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
        
    }
    else if([lotteryId isEqualToString:@"011"]){
        
        HappyTenViewController *happy = [[HappyTenViewController alloc] init];
        //        happy.issue = cell.myrecord.curIssue;
        [self.navigationController pushViewController:happy animated:YES];
        [happy release];
        
    }
    else if([lotteryId isEqualToString:@"122"]){
        KuaiLePuKeViewController *puke = [[KuaiLePuKeViewController alloc] init];
        //        puke.myIssrecord = cell.myrecord;
        [self.navigationController pushViewController:puke animated:YES];
        [puke release];
    }
    else if([lotteryId isEqualToString:@"013"]){
        KuaiSanViewController   * highview = [[KuaiSanViewController alloc] initWithType:JiangSuKuaiSan];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
    }
    else if([lotteryId isEqualToString:@"019"]){
        KuaiSanViewController   * highview = [[KuaiSanViewController alloc] initWithType:HuBeiKuaiSan];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
    }
    else if([lotteryId isEqualToString:LOTTERY_ID_JILIN]){
        KuaiSanViewController   * highview = [[KuaiSanViewController alloc] initWithType:JiLinKuaiSan];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
    }
    else if([lotteryId isEqualToString:LOTTERY_ID_ANHUI]){
        KuaiSanViewController   * highview = [[KuaiSanViewController alloc] initWithType:AnHuiKuaiSan];
        [self.navigationController pushViewController:highview animated:YES];
        [highview release];
    }
}

//返回按钮
- (void)back
{
	[self.navigationController popViewControllerAnimated: YES];
}



 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:NO];
//     [self.navigationController setNavigationBarHidden:YES animated:NO];
 }
 
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */

 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:NO];
 }
 
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return NO;
 }
 */

//发送开奖列表请求
- (void)sendLotteryListRequest
{
	if ([CheckNetwork isExistenceNetwork])
	{
		
		ASIHTTPRequest *httpRequest = [ASIHTTPRequest requestWithURL:
									   [NetURL CBsynLotteryList:self.lotteryId
														 pageNo:self.PageNo
													   pageSize:self.PageSize
														 userId:[[Info getInstance] userId]]];
		
		[httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		
		[httpRequest setDelegate:self];
		
		[httpRequest setDidFinishSelector:@selector(LoadingTableViewData:)];
		[httpRequest setDidFailSelector:@selector(failselector:)];
		[httpRequest setNumberOfTimesToRetryOnTimeout:2];
		
		[httpRequest startAsynchronous];
	}
	
}
- (void)failselector:(ASIHTTPRequest *)mrequest{
    [loadview stopRemoveFromSuperview];
    loadview = nil;
}

//开奖列表请求成功 回调
-(void)LoadingTableViewData:(ASIHTTPRequest*)request
{
	NSString *responseString = [request responseString];
	
	NSLog(@"responseString = %@\n", responseString);
   	
    if (responseString != nil) {
		
		LotteryList *lList = [[LotteryList alloc] initWithParse: responseString];
		
		//self.lotteryList = lList;
		
		
		self.lotteryListArray = (NSMutableArray *)lList.reListArray;
		
		[lList release];
		
		[myTableView reloadData];
        
	}
     [loadview stopRemoveFromSuperview];
    loadview = nil;
}


//发送开奖详情请求
- (void)sendMatchDetailRequest:(NSString *)lotId issue:(NSString *)iss status:(NSString *)status userId:(NSString *)userId
{
	if ([CheckNetwork isExistenceNetwork])
	{
		ASIHTTPRequest *httpReuqest = [ASIHTTPRequest requestWithURL:
									   [NetURL synLotteryDetails: lotId
														   issue: iss
														  status: status
														  userId: userId]];
		
		[httpReuqest setDefaultResponseEncoding:NSUTF8StringEncoding];
		[httpReuqest setDelegate:self];
		[httpReuqest setDidFinishSelector:@selector(returnDetailData:)];
		[httpReuqest setNumberOfTimesToRetryOnTimeout:2];
		[httpReuqest startAsynchronous];
	}
}


//开奖详情请求成功回调
-(void)returnDetailData:(ASIHTTPRequest*)request
{
	NSString *responseString = [request responseString];
	NSLog(@"\n\n\n...xx...responseString = %@\n", responseString);
   	
	if (responseString != nil && ![responseString isEqualToString:@"{}"])
	{
		LotteryDetail *lDetail = [[LotteryDetail alloc] initWithParse: responseString];
		
		self.lotDetail = lDetail;
		
		[lDetail release];
		
		if (lotDetail.msg != nil)
		{
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
																message:@"详情信息暂未开出，请稍后再试"
															   delegate:self
													  cancelButtonTitle:@"确定"
													  otherButtonTitles:nil];
			[alertView show];
			[alertView release];
		}
		else
		{
            LotteryDetailViewController *detailViewController = [[LotteryDetailViewController alloc] initWithNibName:@"LotteryDetailViewController" bundle:nil];
            detailViewController.lotteryId = self.lotteryId;
            detailViewController.lotteryName = self.lotteryName;
            detailViewController.issue = self.issue;
            [self.navigationController pushViewController:detailViewController animated:YES];
            [detailViewController release];
		}
	}
	else {
		NSLog(@"Without Data!\n");
	}
}
//- (NSArray *)getShaiZiViewBy:(NSArray *)numArray{
//    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 21)];
//    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 21)];
//    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 21)];
//    image1.backgroundColor = [UIColor clearColor];
//    image2.backgroundColor = [UIColor clearColor];
//    image3.backgroundColor = [UIColor clearColor];
//    NSString * str1 = [NSString stringWithFormat:@"xqshaizi%d.png",[[numArray objectAtIndex:0] intValue]];
//    NSString * str2 = [NSString stringWithFormat:@"xqshaizi%d.png",[[numArray objectAtIndex:1] intValue]];
//    NSString * str3 = [NSString stringWithFormat:@"xqshaizi%d.png",[[numArray objectAtIndex:2] intValue]];
//    image1.image = UIImageGetImageFromName(str1);
//    image2.image = UIImageGetImageFromName(str2);
//    image3.image = UIImageGetImageFromName(str3);
//    NSArray *retunArray = [NSArray arrayWithObjects:image1,image2,image3,nil];
//    [image1 release];
//    [image2 release];
//    [image3 release];
//    return retunArray;
//    
//}
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
    if (a == b && b == c ) {
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
//    lab1.frame = CGRectMake(1, 1, 9, 9);
//    lab1.font = [UIFont fontWithName:@"TRENDS" size:8];
    lab1.frame = CGRectMake(1, 1, 15, 15);
    lab1.font = [UIFont fontWithName:@"TRENDS" size:13];
    lab1.backgroundColor = [UIColor clearColor];
    lab1.tag = 101;
    lab1.text = [name objectAtIndex:a];
    lab1.autoresizingMask = 111111;
    [image1 addSubview:lab1];
    [lab1 release];
    
    UILabel *lab2 = [[UILabel alloc] init];
//    lab2.frame = CGRectMake(1, 1, 9, 9);
//    lab2.font = [UIFont fontWithName:@"TRENDS" size:8];
    lab2.frame = CGRectMake(1, 1, 15, 15);
    lab2.font = [UIFont fontWithName:@"TRENDS" size:13];
    lab2.backgroundColor = [UIColor clearColor];
    lab2.tag = 101;
    lab2.text = [name objectAtIndex:b];
    lab2.autoresizingMask = 111111;
    [image2 addSubview:lab2];
    [lab2 release];
    
    UILabel *lab3 = [[UILabel alloc] init];
//    lab3.frame = CGRectMake(1, 1, 9, 9);
//    lab3.font = [UIFont fontWithName:@"TRENDS" size:8];
    lab3.frame = CGRectMake(1, 1, 15, 15);
    lab3.font = [UIFont fontWithName:@"TRENDS" size:13];
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
- (NSArray *)getPukeViewBy2:(NSArray *)numArray {//
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
    if (a == b && b == c ) {
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
    NSString *pic1 = [NSString stringWithFormat:@"puke%d.png",a1];
    NSString *pic2 = [NSString stringWithFormat:@"puke%d.png",b1];
    NSString *pic3 = [NSString stringWithFormat:@"puke%d.png",c1];
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 11, 11)];
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 11, 11)];
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 11, 11)];
    UILabel *lab1 = [[UILabel alloc] init];
    //    lab1.frame = CGRectMake(1, 1, 9, 9);
    //    lab1.font = [UIFont fontWithName:@"TRENDS" size:8];
    lab1.frame = CGRectMake(13, -2, 15, 15);
    lab1.font = [UIFont fontWithName:@"TRENDS" size:13];
    lab1.backgroundColor = [UIColor clearColor];
    lab1.tag = 101;
    lab1.text = [name objectAtIndex:a];
    lab1.autoresizingMask = 111111;
    [image1 addSubview:lab1];
    [lab1 release];
    
    UILabel *lab2 = [[UILabel alloc] init];
    //    lab2.frame = CGRectMake(1, 1, 9, 9);
    //    lab2.font = [UIFont fontWithName:@"TRENDS" size:8];
    lab2.frame = CGRectMake(13, -2, 15, 15);
    lab2.font = [UIFont fontWithName:@"TRENDS" size:13];
    lab2.backgroundColor = [UIColor clearColor];
    lab2.tag = 101;
    lab2.text = [name objectAtIndex:b];
    lab2.autoresizingMask = 111111;
    [image2 addSubview:lab2];
    [lab2 release];
    
    UILabel *lab3 = [[UILabel alloc] init];
    //    lab3.frame = CGRectMake(1, 1, 9, 9);
    //    lab3.font = [UIFont fontWithName:@"TRENDS" size:8];
    lab3.frame = CGRectMake(13, -2, 15, 15);
    lab3.font = [UIFont fontWithName:@"TRENDS" size:13];
    lab3.backgroundColor = [UIColor clearColor];
    lab3.tag = 101;
    lab3.text = [name objectAtIndex:c];
    lab3.autoresizingMask = 111111;
    [image3 addSubview:lab3];
    [lab3 release];
    
    image1.image=[UIImage imageNamed:pic1];
    image2.image=[UIImage imageNamed:pic2];
    image3.image=[UIImage imageNamed:pic3];
    NSArray *retunArray = [NSArray arrayWithObjects:image1,image2,image3,leixing,nil];
    [image1 release];
    [image2 release];
    [image3 release];
    return retunArray;
    
}

#pragma mark -
#pragma mark Table view data source
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section   // custom view for header. will be adjusted to default or specified header height
{
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)] autorelease];
    headerView.backgroundColor = [UIColor clearColor];
    
    
    return headerView;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	NSInteger count = [lotteryListArray count];
    return  (count == 0)?count:count+1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier;
	if (indexPath.row ==[lotteryListArray count]) {
		
		CellIdentifier = @"MoreLoadCell";
		
		MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if(cell==nil){
			cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		if (listMoreCell==nil) {
			listMoreCell = cell;
		}
        
        if (!listLoadedEnd) {
			if([tableView numberOfRowsInSection:indexPath.section] > 1)
            {
                [cell spinnerStartAnimating];
                
                [self performSelector:@selector(sendMoreListRequest) withObject:nil afterDelay:.5];
            }
			
			
		}
        
		return cell;
		
	}
    else {
		CellIdentifier = @"LotteryListCell";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[NSBundle mainBundle] loadNibNamed:@"LotteryListCell" owner:self options:nil]objectAtIndex:0];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
		}
		
		// Configure the cell...
		
		
		LotteryList *lList = [lotteryListArray objectAtIndex:indexPath.row];
		
        //背景
        UIImageView * bgimage = (UIImageView *)[cell viewWithTag:10];
//        bgimage.image = [UIImageGetImageFromName(@"LBT960.png") stretchableImageWithLeftCapWidth:160 topCapHeight:6];
        if(indexPath.row == 0)
        {
            bgimage.backgroundColor=[UIColor whiteColor];
        }
        bgimage.frame=CGRectMake(0, 0, 320, 84);
        
        UIImageView *lineIma=[[UIImageView alloc]init];
//        lineIma.frame=CGRectMake(15, 83.5, 320, 0.5);
        if(indexPath.row == 0)
        {
            lineIma.frame=CGRectMake(0, 83.5, 320, 0.5);
        }
        else
        {
            lineIma.frame=CGRectMake(15, 83.5, 320, 0.5);
        }
        lineIma.image=[UIImage imageNamed:@"SZTG960.png"];
        [cell.contentView addSubview:lineIma];
        [lineIma release];
        
        UILabel *diLab=(UILabel *)[cell viewWithTag:110];
        diLab.frame=CGRectMake(15, 15, 20, 20);
        diLab.font=[UIFont systemFontOfSize:15];
        
		//彩期
		UILabel *issueL = (UILabel*)[cell viewWithTag:1];
        issueL.text = [NSString stringWithFormat:@"%@",lList.issue];
//        issueL.font = [UIFont boldSystemFontOfSize:13];
        issueL.font = [UIFont boldSystemFontOfSize:17];
        issueL.textColor = [UIColor colorWithRed:25/255.0 green:122/255.0 blue:228/255.0 alpha:1];
        issueL.frame=CGRectMake(35, 15, 100, 20);
        issueL.textAlignment=NSTextAlignmentLeft;
        
        CGSize size=[issueL.text sizeWithFont:[UIFont systemFontOfSize:17]];
        UILabel *qiLab=(UILabel *)[cell viewWithTag:11];
        qiLab.frame=CGRectMake(size.width+40, 15, 20, 20);
        qiLab.font=[UIFont systemFontOfSize:15];
        
		
		//开奖时间
		UILabel *lotteryTime = (UILabel*)[cell viewWithTag:2];
		lotteryTime.text = lList.ernie_date;
        NSLog(@"%@",lotteryTime.text);
		lotteryTime.hidden = NO;
        lotteryTime.font = [UIFont boldSystemFontOfSize:12];
        lotteryTime.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
//        lotteryTime.frame=CGRectMake(size.width+60, 15, 200, 20);
        lotteryTime.frame=CGRectMake(size.width, 15, 220, 20);
        lotteryTime.textAlignment=NSTextAlignmentRight;
        if ([self.lotteryName isEqualToString:Lottery_Name_Horse]) {
            CGSize lotteryTimeSize = [lotteryTime.text sizeWithFont:lotteryTime.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];
            lotteryTime.frame = CGRectMake(ORIGIN_X(issueL) + 2, lotteryTime.frame.origin.y, lotteryTimeSize.width, lotteryTime.frame.size.height);
            lotteryTime.textColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1];
            
            issueL.textColor = [UIColor colorWithRed:32/255.0 green:142/255.0 blue:255/255.0 alpha:1];
            
        }
        
		//开奖号码
		UIView *lotteryView = (UIView*)[cell viewWithTag:3];
        lotteryView.backgroundColor = [UIColor clearColor];
        NSMutableArray *imageList = nil;
        NSLog(@"%@",lotteryId);
//        if ([self.lotteryName isEqualToString:Lottery_Name_Horse]) {
//            if(indexPath.row == 0)
//            {
//                imageList = [NSMutableArray arrayWithArray:[lList imagesWithHorseNumber:lList.lotteryNumber]];
//            }
//            else
//            {
//                imageList = [NSMutableArray arrayWithArray:[lList imagesWithNumber2:lList.lotteryNumber]];
//            }
//        }
//        else
        if ([lotteryId isEqualToString:@"012"] || [lotteryId isEqualToString:@"013"] || [lotteryId isEqualToString:@"019"] || [lotteryId isEqualToString:LOTTERY_ID_JILIN] || [lotteryId isEqualToString:LOTTERY_ID_ANHUI]) {
            imageList = [NSMutableArray arrayWithArray:[lList imagesWithKuaiSan:lList.lotteryNumber]];
        }
        else if ([lotteryId isEqualToString:@"011"]) {
            if(indexPath.row == 0)
            {
                imageList = [NSMutableArray arrayWithArray:[lList imagesWithKuaiLeShiFen:lList.lotteryNumber]];
            }
            else
            {
                imageList = [NSMutableArray arrayWithArray: [lList imagesWithKuaiLeShiFen2:lList.lotteryNumber]];
            }
        }else{
            if(indexPath.row == 0)
            {
                imageList = [NSMutableArray arrayWithArray:[lList imagesWithNumber:lList.lotteryNumber]];
            }
            else
            {
                imageList = [NSMutableArray arrayWithArray:[lList imagesWithNumber2:lList.lotteryNumber]];
            }
        }
        lotteryView.frame=CGRectMake(15, 40, 290, 40);
        
		CGFloat width = KBALLPICWIDTH + 2;
        
        NSLog(@"%@",lotteryId);//122puke
        
        if ([lotteryId isEqualToString:@"302"] || [lotteryId isEqualToString:@"303"]||[lotteryId isEqualToString:@"301"]||[lotteryId isEqualToString:@"300"]) {
            
            //            UILabel * zucaila  = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, lotteryView.frame.size.width, 13)];
            //            zucaila.textAlignment = NSTextAlignmentLeft;
            //            zucaila.text = lList.lotteryNumber;
            //            zucaila.backgroundColor = [UIColor clearColor];
            //            [lotteryView addSubview:zucaila];
            //            [zucaila release];
            
            
            
            NSArray * allnumber = [lList.lotteryNumber componentsSeparatedByString:@","];
            NSLog(@"all = %@", allnumber);
            
            for (int i = 0; i < [allnumber count]; i++) {
//                UIImageView * numbg = [[UIImageView alloc] initWithFrame:CGRectMake(15 * i+1, 6, 15, 20)];
                UIImageView * numbg = [[UIImageView alloc] initWithFrame:CGRectMake(18 * i, 5, 17, 30)];
                numbg.backgroundColor = [UIColor clearColor];
//                numbg.image = UIImageGetImageFromName(@"BDHK960.png");
                numbg.backgroundColor=[UIColor redColor];
                
                UILabel * labelnum = [[UILabel alloc] initWithFrame:numbg.bounds];
                labelnum.backgroundColor = [UIColor clearColor];
                labelnum.font = [UIFont systemFontOfSize:10];
                labelnum.textAlignment = NSTextAlignmentCenter;
                labelnum.textColor = [UIColor whiteColor];
                labelnum.text = [allnumber objectAtIndex:i];
                
                [numbg addSubview:labelnum];
                [labelnum release];
                [lotteryView addSubview:numbg];
                [numbg release];
                
                
            }
            
            
            
            
            
        }else if ([lotteryId isEqualToString:@"122"]){
        
            NSArray * openArray = [lList.lotteryNumber componentsSeparatedByString:@","];
            if ([openArray count] >= 3) {
                
                
//                NSArray * pukeImageArray =  [self getPukeViewBy:openArray];
                 NSArray * pukeImageArray;
                
                if(indexPath.row == 0)
                {
                    pukeImageArray =  [self getPukeViewBy:openArray];
                }
                else
                {
                    pukeImageArray =  [self getPukeViewBy2:openArray];
                }
                
                for (int i = 0; i < [pukeImageArray count] - 1; i++) {
                    UIImageView * pukeImage = [pukeImageArray objectAtIndex:i];
//                    pukeImage.frame = CGRectMake( (pukeImage.frame.size.width+3)*i  , 5, pukeImage.frame.size.width, pukeImage.frame.size.height);
//                    pukeImage.frame = CGRectMake( (pukeImage.frame.size.width+3)*i  , 5, pukeImage.frame.size.width, pukeImage.frame.size.height);//19  26
//                    pukeImage.frame = CGRectMake( (pukeImage.frame.size.width+3+6)*i  , 5, pukeImage.frame.size.width+6, pukeImage.frame.size.height+6);
                    if(indexPath.row == 0)
                    {
                        pukeImage.frame = CGRectMake( (pukeImage.frame.size.width+3+6)*i  , 5, pukeImage.frame.size.width+6, pukeImage.frame.size.height+6);
                    }
                    else
                    {
                        pukeImage.frame = CGRectMake( 30*i  , 5+5, 11, 11);
                    }
                    
                    NSLog(@"aaa = %f", pukeImage.frame.size.height );
                    [lotteryView addSubview:pukeImage];
                }
                UILabel * nameLabel = (UILabel *)[cell viewWithTag:4];
//                nameLabel.frame = CGRectMake(232- 100 +20, 9, 100, 20);
                nameLabel.frame = CGRectMake(130, 5, 100, 20);
                nameLabel.backgroundColor= [UIColor clearColor];
                nameLabel.hidden = NO;
                nameLabel.textAlignment = NSTextAlignmentLeft;
                nameLabel.textColor=[UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
//                nameLabel.font = [UIFont boldSystemFontOfSize:12];
                nameLabel.font = [UIFont boldSystemFontOfSize:15];
                if ([pukeImageArray count] >= 4) {
                    nameLabel.text = [pukeImageArray objectAtIndex:3];
                }
                
                [lotteryView addSubview:nameLabel];
            }
            
        
        }else if([lotteryId isEqualToString:@"012"] || [lotteryId isEqualToString:@"013"] || [lotteryId isEqualToString:@"019"] || [lotteryId isEqualToString:LOTTERY_ID_JILIN] || [lotteryId isEqualToString:LOTTERY_ID_ANHUI]){
//            NSArray * openArray = [lList.lotteryNumber componentsSeparatedByString:@","];
//            if ([openArray count] >= 3) {
//                
//                
//                NSArray * pukeImageArray =  [self getShaiZiViewBy:openArray];
//                
//                for (int i = 0; i < [pukeImageArray count]; i++) {
//                    UIImageView * pukeImage = [pukeImageArray objectAtIndex:i];
//                    pukeImage.frame = CGRectMake((pukeImage.frame.size.width+3)*i  , 7, pukeImage.frame.size.width, pukeImage.frame.size.height);
//                    
//                    NSLog(@"aaa = %f", pukeImage.frame.size.height );
//                    [lotteryView addSubview:pukeImage];
//                }
//               
//            }
        
            int heZhi = 0;
            NSMutableArray * heArr = [[NSMutableArray alloc] initWithCapacity:3];
            for (int i = 0; i < imageList.count; i++) {
                UIImageView * imageView = [imageList objectAtIndex:i];
//                imageView.frame = CGRectMake(6 + i * 23, 10, 19.5, 21);
                imageView.frame = CGRectMake(i * 30, 5, 25, 25);
                [lotteryView addSubview:imageView];
                
                [heArr addObject:[[lList.lotteryNumber componentsSeparatedByString:@","] objectAtIndex:i]];
                heZhi += [[heArr objectAtIndex:i] integerValue];
            }
            [heArr release];
            
            UILabel * heLabel = (UILabel *)[cell viewWithTag:4];
//            heLabel.backgroundColor = [UIColor orangeColor];
            heLabel.font = [UIFont systemFontOfSize:13];
            heLabel.hidden = NO;
            heLabel.text = [NSString stringWithFormat:@"和值 %d",heZhi];
            [lotteryView addSubview:heLabel];
            
//            lotteryTime.frame = CGRectMake(160, 5, 145, 21);

        } else{
            if ([imageList count]>12)
            {
                for (int i = 0; i<[imageList count]; i++)
                {
                    int x = i;
                    int y = 0;
                    if (i >= 12)
                    {
                        x = x-12;
                        y = width;
                    }
                    
                    UIImageView *view = [imageList objectAtIndex:i];
                    view.center = CGPointMake((x+0.5)*width, (width - 2)/2+y);
                    
                    [lotteryView addSubview:view];
                }
                
            }
            else
            {
                //                for (int i = 0; i<[imageList count]; i++)
                //                    {
                //
                //                    UIImageView *view = [imageList objectAtIndex:i];
                //                    view.center = CGPointMake((i+0.5)*width, width/2 + 5);
                //
                //                    [lotteryView addSubview:view];
                //                    }
                //                }
                
                NSArray* temp1 = [lList.lotteryNumber componentsSeparatedByString:@"+"];
                NSArray* temp3 = [NSMutableArray array];
                if ([temp1 count]>=1) {
                    temp3 = [[temp1 objectAtIndex:0] componentsSeparatedByString:@","];
                }
                NSLog(@"%@",temp1);
                NSLog(@"%@",temp3);
                
                
                
                if ([lotteryId isEqualToString:@"001"] && [lList.Luck_blueNumber length] > 0) {
                    
//                    UIImageView *iView = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"luckyblue.png")] ;
//                    iView.frame = CGRectMake(0, 0, 25, 25);
//                    UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 25, 22)];
//                    [nLabel setText:lList.Luck_blueNumber];
//                    nLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
//                    nLabel.textAlignment = NSTextAlignmentCenter;
//                    nLabel.highlightedTextColor = [UIColor whiteColor];
//                    nLabel.highlighted = YES;
//                    nLabel.backgroundColor = [UIColor clearColor];
//                    [iView addSubview:nLabel];
//                    [nLabel release];
//                    [imageList addObject:iView];
//                    [iView release];
                    
                    
                    UIImageView *iView = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"luckyblue.png")] ;
                    //	iView.frame = CGRectMake(0, 0, 24, 24);
                    iView.frame = CGRectMake(0, 0, 25, 25);
                    //	UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 22, 22)];
                    UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 23, 23)];
                    [nLabel setText:lList.Luck_blueNumber];
                    nLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
                    nLabel.textAlignment = NSTextAlignmentCenter;
                    nLabel.highlightedTextColor = [UIColor whiteColor];
                    nLabel.highlighted = YES;
                    nLabel.backgroundColor = [UIColor clearColor];
                    [iView addSubview:nLabel];
                    [nLabel release];
                    [imageList addObject:iView];
                    [iView release];
                }
                
                for (int i = 0; i<[imageList count]; i++) {
                    
                    UIImageView *view = [imageList objectAtIndex:i];
                    
                    
                    
                    if ([temp1 count]>1) {
//                        if ([lotteryId isEqualToString:@"001"] && [lList.Luck_blueNumber length] > 0) {
//                         
//                           view.frame =CGRectMake(220 - ([imageList count] - i - 1)*30, 5, 25, 25);
//                        }else
                            if (i+1 > [temp3 count]) {
                            
//                            view.frame =CGRectMake(202 - ([imageList count] - i - 1)*24, 5, 24, 24);
                            view.frame =CGRectMake(220 - ([imageList count] - i - 1)*30, 5, 25, 25);
                            
                            
                        }else{
//                            view.center = CGPointMake((i+0.5)*width, width/2 + 5);
                            view.center = CGPointMake(i*30+10, 20);
                            view.frame=CGRectMake(view.frame.origin.x, 5, 25, 25);
                            NSLog(@"%f,%f,%f,%f",view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height);
                            //                        view.center = CGPointMake(i*(width + space), width/2);
                        }
                    }else{
//                        view.center = CGPointMake((i+0.5)*width, width/2 + 5);
//                        if ([lotteryName isEqualToString:Lottery_Name_Horse] && indexPath.row == 0) {
//                            view.center = CGPointMake(i*37.5+10, 27.5);
//                            view.frame=CGRectMake(view.frame.origin.x, 5, 32.5, 32.5);
//                        }else{
                            view.center = CGPointMake(i*30+10, 20);
                            view.frame=CGRectMake(view.frame.origin.x, 5, 25, 25);
//                        }
                        
                        //                    view.center = CGPointMake(i*(width + space), width/2);

                    }
                    [lotteryView addSubview:view];
                    
                    
                }
                
                
                
                
            }
            
            
            
            
            
            
            return cell;
        }
        return cell;
        
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	if(indexPath.row ==[lotteryListArray count])
	{
		return 60;
	}
	LotteryList *list1 = [lotteryListArray objectAtIndex:indexPath.row];
	NSArray *imageList = nil;
    if ([lotteryId isEqualToString:@"011"]) {
        imageList = [list1 imagesWithKuaiLeShiFen:list1.lotteryNumber];
    }else{
        imageList = [list1 imagesWithNumber:list1.lotteryNumber];
    }
	if([imageList count] > 12){
		//return 72.0;
//        return 57;
        return 84;
	}else{
		//return 60.0;
//        return 57;
        return 84;
	}
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    index=indexPath.row;
	
	if (indexPath.row == [lotteryListArray count]) {
		
		MoreLoadCell *cell = (MoreLoadCell*)[tableView cellForRowAtIndexPath:indexPath];
		
		if (!listLoadedEnd) {
			
			[cell spinnerStartAnimating];
			
			[self performSelector:@selector(sendMoreListRequest) withObject:nil afterDelay:.5];
			
		}
		
		
	}
	else{
        
        
        
        selectedList = [lotteryListArray objectAtIndex:indexPath.row];
		self.issue = selectedList.issue;
        
        NSLog(@"lotterid = %@", self.lotteryId);
        NSLog(@"userid = %@", [[Info getInstance] userId]);
        NSLog(@"issue = %@", selectedList.issue);
        
        NSString * useridstr = @"";
        if ([[[Info getInstance] userId] length]>1) {
            useridstr = [[Info getInstance] userId];
        }else{
            useridstr = @"0";
        }
        statepop = [StatePopupView getInstance];
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        statepop.tag = indexPath.row;
        [statepop showInView:appDelegate.window Text:@"请稍等..."];
       
//             loadview = [[UpLoadView alloc] init];
//        
//        loadview.tag = indexPath.row;
//        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
//        [appDelegate.window addSubview:loadview];
//        [loadview release];
        
        
        NSString * huastr = [NSString stringWithFormat:@"%@%@期开奖", self.lotteryName, selectedList.issue];
        if ([self.lotteryName isEqualToString:Lottery_Name_Horse]) {
            NSMutableData *postData = [[GC_HttpService sharedInstance] req_GetPKRanking:@"day" caizhongId:LOTTERY_ID_SHANDONG_11 qici:issue];
            [rankRequest clearDelegatesAndCancel];
            self.rankRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
            [rankRequest setRequestMethod:@"POST"];
            [rankRequest addCommHeaders];
            [rankRequest setPostBody:postData];
            [rankRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [rankRequest setDelegate:self];
            [rankRequest setDidFinishSelector:@selector(requestRankListFinished:)];
            [rankRequest setDidFailSelector:@selector(requestRankListFailed:)];
            [rankRequest startAsynchronous];

        }else{
            ASIHTTPRequest *httpReuqest = [ASIHTTPRequest requestWithURL:
                                           [NetURL cpthreeKaiJiangHuaTiLotteryId:self.lotteryId userid:useridstr pageSize:@"5" PageNum:@"1" issue:selectedList.issue themeName:huastr]];
            
            [httpReuqest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [httpReuqest setDelegate:self];
            [httpReuqest setDidFinishSelector:@selector(kaijianghuati:)];
            [httpReuqest setDidFailSelector:@selector(kaijiangshibai:)];
            [httpReuqest setNumberOfTimesToRetryOnTimeout:2];
            [httpReuqest startAsynchronous];
        }
	}
}

-(void)requestRankListFailed:(ASIHTTPRequest *)requests{
    [statepop dismiss];
}

-(void)requestRankListFinished:(ASIHTTPRequest *)requests{
    
    [statepop dismiss];

    if ([requests responseData])
    {
        GC_PKRankingList * pkRankingList = [[[GC_PKRankingList alloc]initWithResponseData:requests.responseData WithRequest:requests] autorelease];
        
        KJXiangQingViewController * kjxq = [[[KJXiangQingViewController alloc] init] autorelease];
        kjxq.lotteryName = Lottery_Name_Horse;
        kjxq.qiustring = selectedList.lotteryNumber;
        kjxq.issuesting = selectedList.issue;
        kjxq.datestring = selectedList.ernie_date;
        kjxq.cainame = LOTTERY_ID_SHANDONG_11;
        kjxq.huatistring = [NSString stringWithFormat:@"#11选5赛马场%@场开奖#",kjxq.issuesting];
        kjxq.paihangarr = pkRankingList.listData;
        [self.navigationController pushViewController:kjxq animated:YES];

    }
}

- (void)kaijiangshibai:(ASIHTTPRequest *)mrequest{
//   [loadview stopRemoveFromSuperview];
    [statepop dismiss];
}

- (void)kaijianghuati:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    [statepop dismiss];
    
    
    NSDictionary * dict = [str JSONValue];
    
    NSString * msg = [dict valueForKey:@"msg"];
    if (msg && [msg length]) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:msg];
        
        if ([msg isEqualToString:@"详情信息暂未开出，请稍后再试"]) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
            return;
        }
    }
    
    
    NSString * xiaoshou = [dict objectForKey:@"buyamont"];
//    NSString * datestr = [dict objectForKey:@"ernie_datestr"];
    NSString * datestr = [dict objectForKey:@"ernie_date"];
    NSString * jiangchistr = [dict objectForKey:@"prizePool"];
    NSArray * zhongArray = [dict objectForKey:@"reList"];
    NSString * issstri = [dict objectForKey:@"issue"];
    NSString *  lotternum = [dict objectForKey:@"lotteryNumber"];
    NSArray * conarray = [dict objectForKey:@"themes"];
    NSDictionary * matchdict = [dict objectForKey:@"match"];
    NSArray * paihangarr = [dict objectForKey:@"paihangbang"];
    NSMutableArray * urarray = [NSMutableArray arrayWithCapacity:0];
    if ([conarray isKindOfClass:[NSArray class]]) {
        for (NSDictionary * d in conarray) {
            if ([d isKindOfClass:[NSDictionary class]]) {
                NSString * ur = [d objectForKey:@"content"];
                NSLog(@"ur = %@", ur);
                [urarray addObject:ur];
            }
            
        }
    }
    NSString * shisichang = [dict objectForKey:@"sales_sfc"];
    NSString * renjiu = [dict objectForKey:@"sales_rx9"];
    NSLog(@"paihangarr = %@, matchdict = %@", paihangarr, matchdict);
    //  NSString * contentstr = [dict objectForKey:@"content"];
    NSLog(@"issue = %@", issstri);
    NSLog(@"date = %@" , datestr);
    NSLog(@"jiangchi = %@", jiangchistr);
    NSLog(@"xiaoshoujin e = %@", xiaoshou);
    NSLog(@"zhongjiang = %@", zhongArray);
    NSLog(@"lotternum = %@", lotternum);
    NSLog(@"contentstr = %@", conarray);
    NSString * huastr = [NSString stringWithFormat:@"#%@%@期开奖#", self.lotteryName, issstri];
    NSLog(@"huati = %@", huastr);
    
    KJXiangQingViewController * kjxq = [[KJXiangQingViewController alloc] init];
    kjxq.wangqibool = NO;
    kjxq.lotteryNumber = lotternum;
    kjxq.paihangarr = paihangarr;
    kjxq.matchdict = matchdict;
    kjxq.issuesting = issstri;
    kjxq.lotteryName = self.lotteryName;
    if ([self.lotteryId isEqualToString:@"119"] || [self.lotteryId isEqualToString:@"012"])
    {
//        if (![kjxq.lotteryName isEqualToString:Lottery_Name_Horse]) {
//            kjxq.lotteryName = [NSString stringWithFormat:@"新%@",self.lotteryName];
//        }
    }
    if ([self.lotteryId isEqualToString:@"107"])
    {
        kjxq.lotteryName = [NSString stringWithFormat:@"江西%@",self.lotteryName];
    }
    if ([self.lotteryId isEqualToString:@"121"])
    {
        kjxq.lotteryName = [NSString stringWithFormat:@"广东%@",self.lotteryName];
    }
    if ([self.lotteryId isEqualToString:@"013"])
    {
        kjxq.lotteryName = [NSString stringWithFormat:@"江苏%@",self.lotteryName];
    }
    if ([self.lotteryId isEqualToString:@"018"])
    {
        kjxq.lotteryName = [NSString stringWithFormat:@"吉林%@",self.lotteryName];
    }
//    if ([self.lotteryId isEqualToString:LOTTERY_ID_ANHUI])
//    {
//        kjxq.lotteryName = [NSString stringWithFormat:@"新%@",self.lotteryName];
//    }
    if ([self.lotteryId isEqualToString:@"019"])
    {
        kjxq.lotteryName = [NSString stringWithFormat:@"湖北%@",self.lotteryName];
    }
    kjxq.benstring = xiaoshou;
//    kjxq.datestring = datestr;
    NSLog(@"%@",datestr);
    kjxq.qiustring = lotternum;
    kjxq.zhongarray = zhongArray;
    kjxq.chistring = jiangchistr;
    if ([conarray isKindOfClass:[NSArray class]]) {
        kjxq.reyiArray = conarray;
    }
    kjxq.shisi = shisichang;
    kjxq.renjiu = renjiu;
    kjxq.huatistring = huastr;
    kjxq.cainame = self.lotteryId;
//    kjxq.isDangQianQi = !loadview.tag;
    kjxq.isDangQianQi = !statepop.tag;
    
    LotteryList *lList = [lotteryListArray objectAtIndex:index];
    kjxq.datestring = lList.ernie_date;
    kjxq.Luck_blueNumber = [dict objectForKey:@"Luck_blueNumber"];
//    kjxq.Luck_blueNumber = @"12";
    
    [self.navigationController pushViewController:kjxq animated:YES];
    [kjxq release];
//    [loadview stopRemoveFromSuperview];
    //    @synthesize  issuesting;//期号
    //    @synthesize datestring;//时间
    //    @synthesize qiustring;//开奖号码 球
    //    @synthesize benstring;//本期销售
    //    @synthesize chistring;//奖池
    //    @synthesize zhongarray;//中奖信息
    
}

// "更多" 发送请求
-(void)sendMoreListRequest{
//	if ([[self loadedCount] intValue] > 3) {
//        [listMoreCell spinnerStopAnimating];
//        
//        fristLoading = NO;
//        return;
//    }
	if([CheckNetwork isExistenceNetwork]){
		
        NSString * pageloadd = [self loadedCount];
        if ([pageloadd intValue]>3) {
            [listMoreCell spinnerStopAnimating];
            
            fristLoading = NO;
            return;

        }
        NSLog(@"page = %@", pageloadd);
		ASIHTTPRequest  *request;
		
		request = [ASIHTTPRequest requestWithURL:
				   [NetURL CBsynLotteryList:self.lotteryId
									 pageNo:pageloadd
								   pageSize:self.PageSize
									 userId:[[Info getInstance] userId]]];
		
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		
		[request setDelegate:self];
		
		[request setDidFinishSelector:@selector(moreListTableViewDataBack:)];
		
		// 异步获取
		[request startAsynchronous];
		
	}
	
}

// "更多 "数据接收
-(void)moreListTableViewDataBack:(ASIHTTPRequest*)request{
	
	NSString *responseString = [request responseString];
	
	if (responseString) {
		
		LotteryList *list = [[LotteryList alloc] initWithParse:responseString];
		
		if ([list.reListArray count]>0) {
			
			//if (lotteryListArray) {
            
            [lotteryListArray addObjectsFromArray:list.reListArray];
            
			//}
			[myTableView reloadData];
			
		}else {
			
			[listMoreCell setType:MSG_TYPE_LOAD_NODATA];
			
			listLoadedEnd = YES;
			
		}
		
		[list release];
		
//		[myTableView reloadData];
		
	}
	
	[listMoreCell spinnerStopAnimating];
	
	fristLoading = NO;
	if (listMoreCell.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [listMoreCell spinnerStopAnimating];
        [listMoreCell setInfoText:@"加载完毕"];
    }

	
}

// 计算 点击 “更多 ”次数
-(NSString*)loadedCount
{
	
	NSString *count;	
	if (fristLoading) 
    {		
		listLoadCount = 1;
	}
	
        listLoadCount ++;
    
			
	NSNumber *num = [[NSNumber alloc] initWithInteger:listLoadCount];	
	count = [num stringValue];	
	[num release];
	return count;
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
    [myTableView release];
	[lotteryId release];
	[PageNo release];
	[PageSize release];
	[lotteryList release];
	[lotteryListArray release];
	[lotteryName release];
	[lotDetail release];
	[issue release];
    [rankRequest clearDelegatesAndCancel];
    self.rankRequest = nil;
	
    [super dealloc];
}


@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    