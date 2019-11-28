//
//  scoreLiveTelecastViewController.m
//  caibo
//
//  Created by houchenguang on 13-6-26.
//
//

#import "scoreLiveTelecastViewController.h"
#import "Info.h"
#import "liveTelecastData.h"
#import "NetURL.h"
#import "JSON.h"
#import "CheckNetwork.h"
#import "ResultString.h"
#import "singletonData.h"
#import "ScoreLiveDetailViewController.h"
#import "LoginViewController.h"

@interface scoreLiveTelecastViewController ()

@end

@implementation scoreLiveTelecastViewController
@synthesize allType;
@synthesize mRequest;
@synthesize issueString;
@synthesize selectIndex;
@synthesize refreshHeaderView;
@synthesize bifenType;
@synthesize bifenzhibo;



- (void)loginRightBarButtonFunc{
    UIBarButtonItem *right = [Info itemInitWithTitle:@"登录注册" Target:self action:@selector(doLogin) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
    self.CP_navigation.rightBarButtonItem = right;
    

}
- (void)doLogin {
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

- (void)issueRightBarButtonFunc{
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBounds:CGRectMake(0, 0, 70, 40)];
    [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
    imagevi.backgroundColor = [UIColor clearColor];
    imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    [btn addSubview:imagevi];
    [imagevi release];
    
    beginLabel = [[UILabel alloc] initWithFrame:btn.bounds];
    beginLabel.backgroundColor = [UIColor clearColor];
    beginLabel.textColor = [UIColor whiteColor];
    //    beginLabel.text = @"退出登录";
    beginLabel.font = [UIFont systemFontOfSize:9];
    beginLabel.textAlignment = NSTextAlignmentCenter;
    [btn addSubview:beginLabel];
    [beginLabel release];
    btn.hidden = YES;
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.CP_navigation.rightBarButtonItem = barBtnItem;
    [barBtnItem release];

}

- (void)loginYesOrNoFunc{
    
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        
        [self issueRightBarButtonFunc];
        
    }else{
        
        if ([titleLabel.text isEqualToString: @"竞彩比分"]) {
            
            [self loginRightBarButtonFunc];
            
        }else{
            
            [self issueRightBarButtonFunc];
        }
        
    }
}


//我关注的筛选
- (void)myAttScreen{

    singletonData * singleton = [singletonData getInstance];
    
    if ([singleton.allDataArray count] == 0) {
        [self allRequestFunc];
        return;
    }
    
    
    [dataArray removeAllObjects];
    for (int i = 0; i < [singleton.allDataArray count]; i++) {//把关注的都筛选出来
        NSArray * sectonArray = [singleton.allDataArray objectAtIndex:i];
        NSMutableArray * saveArr = [[NSMutableArray alloc] initWithCapacity:0];
        liveTelecastData * livetelecast = [sectonArray objectAtIndex:0];
        for (int n = 0; n < [sectonArray count]; n++) {
            liveTelecastData * livedata = [sectonArray objectAtIndex:n];
            if ([livedata.isAttention isEqualToString:@"1"]) {
                livedata.menuStr = livetelecast.menuStr;
                [saveArr addObject:livedata];
            }
            
            
        }
        
        [dataArray addObject:saveArr];
        [saveArr release];
    }
    
    
    
    for (int i = 0; i < [ dataArray count]; i++) {//把空的数组删除掉
        NSArray * sectonArray = [dataArray objectAtIndex:i];
        if ([sectonArray count] == 0) {
            [dataArray removeObjectAtIndex:i];
        }
    }
    NSLog(@"d = %lu, xx = %@", (unsigned long)[dataArray count], dataArray);
    
    
    
//    if ([dataArray count] > 0) {
//        NSArray * sectonArray = [dataArray objectAtIndex:0];
//        if ([sectonArray count] > 0) {
//            myTableView.hidden = NO;
//            noAttView.hidden = YES;
//        }
//        
//    }
    
    BOOL kongBool = NO;////看数组是否真正的清空
    for (int i = 0; i < [dataArray count]; i++) {
         NSArray * sectonArray = [dataArray objectAtIndex:i];
        
        if ([sectonArray count] > 0) {
            kongBool = YES;
            break;
        }
        
//        for (int n = 0; n < [sectonArray count]; n++) {
//            NSArray * rowArray = [sectonArray objectAtIndex:n];
//            if ([rowArray count] > 0) {
//                kongBool = YES;
//                break;
//            }
//        }
    }
    
    
    if (kongBool) {
        myTableView.hidden = NO;
        noAttView.hidden = YES;
    }else{
    
        myTableView.hidden = YES;
        if ([[[Info getInstance] userId] intValue]) {
            noAttView.hidden = NO;
        }else{
            noAttView.hidden = YES;
        }

    }
    if ([dataArray count] == 0) {
        myTableView.hidden = YES;
        
        if ([[[Info getInstance] userId] intValue]) {
             noAttView.hidden = NO;
        }else{
             noAttView.hidden = YES;
        }
       
    }
    
    [myTableView reloadData];

}


- (void)attentionMatchFunc{//点关注比赛
    
    

}

- (void)tableDisTitle{
    singletonData * singleton = [singletonData getInstance];
    NSLog(@"selec = %ld", (long)singleton.selectTile);
    
    if (allType == liveType) {//保存title的选项
        
        singleton.liveTitle = singleton.selectTile;
        
    }else if(allType == myAttentionType){
        
        singleton.myTitle = singleton.selectTile;
        
    }else if(allType == endType){
        
        singleton.endTitle = singleton.selectTile;
        
    }


}

- (void)tableViewTitleLabel{
    singletonData * singleton = [singletonData getInstance];
    
//    if (allType == liveType) {
//        singleton.selectTile = singleton.liveTitle;
//    }else if(allType == myAttentionType){
//        singleton.selectTile = singleton.myTitle;
//    }else if(allType == endType){
//        singleton.selectTile = singleton.endTitle;
//    }
    
    [arrayType removeAllObjects];
    
    if (singleton.selectTile == 0) {
        titleLabel.text = @"竞彩比分";
        [arrayType addObject:@"1"];
        [arrayType addObject:@"0"];
        [arrayType addObject:@"0"];
    }else if (singleton.selectTile == 1) {
        titleLabel.text = @"北单比分";
        [arrayType addObject:@"0"];
        [arrayType addObject:@"1"];
        [arrayType addObject:@"0"];
    }else if (singleton.selectTile == 2) {
        titleLabel.text = @"足彩比分";
        [arrayType addObject:@"0"];
        [arrayType addObject:@"0"];
        [arrayType addObject:@"1"];
    }
    
    
}


- (void)allRequestFunc{
    
//    loadview = [[UpLoadView alloc] init];
//    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
//    [appDelegate.window addSubview:loadview];
//    [loadview release];

    if (allType == liveType || allType == endType) {
        [self scoreLiveRequest];
    }else if(allType == myAttentionType){
        Info *info = [Info getInstance];
        if ([info.userId intValue]) {
             myTableView.hidden = NO;
            [self myAttentionNewRequest];
        }else{
            
            myTableView.hidden = YES;
            
//            [loadview stopRemoveFromSuperview];
            
        }
        
    }
}
//关注
- (void)sendAddAttention:(liveTelecastData *)match
{
	if ([CheckNetwork isExistenceNetwork])
	{
        [[ProgressBar getProgressBar]  show:@"正在添加关注..." view:self.view];
        [ProgressBar getProgressBar].mDelegate = self;
        
		if ([self mRequest])
        {
            [mRequest clearDelegatesAndCancel];
        }
        
        NSString *userId = [[Info getInstance] userId];
		
        self.mRequest = [ASIHTTPRequest requestWithURL: [NetURL CBattentionMatch:userId MatchId:match.matchId LotteryId:match.lotteryId Issue:match.issue]];
		[mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		[mRequest setDelegate:self];
		[mRequest setDidFinishSelector:@selector(didAddAttention:)];
		[mRequest setNumberOfTimesToRetryOnTimeout:2];
		[mRequest startAsynchronous];
	}
}

//取消关注
- (void)sendCancelAttention:(liveTelecastData*)match
{
	if ([CheckNetwork isExistenceNetwork])
	{
		[[ProgressBar getProgressBar] show:@"正在取消关注..." view:self.view];
        [ProgressBar getProgressBar].mDelegate = self;
        
        if ([self mRequest])
        {
            [mRequest clearDelegatesAndCancel];
        }
		
        NSString *userId = [[Info getInstance] userId];
        
        self.mRequest = [ASIHTTPRequest requestWithURL: [NetURL CBcancelAttentionMatch:userId MatchId:match.matchId LotteryId:match.lotteryId Issue:match.issue]];
		[mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		[mRequest setDelegate:self];
		[mRequest setDidFinishSelector:@selector(didCancelAttention:)];
		[mRequest setNumberOfTimesToRetryOnTimeout:2];
		[mRequest startAsynchronous];
	}
}

- (void)didCancelAttention:(ASIHTTPRequest*)request
{
	NSString* responseString = [request responseString];
	NSString *result = [ResultString resultStringByParsing:responseString];
	if ([result isEqualToString:@"succ"])
    {
        NSMutableArray * alldata = [dataArray objectAtIndex:selectIndex.section];
        liveTelecastData * teledata = [alldata objectAtIndex:selectIndex.row];
        teledata.isAttention = @"0";
        
        if (allType == myAttentionType) {
            [alldata removeObjectAtIndex:selectIndex.row];
            if ([alldata count] == 0) {
                [dataArray removeObjectAtIndex:selectIndex.section];
            }
            
            if ([dataArray count] == 0) {
                myTableView.hidden = YES;
                noAttView.hidden = NO ;
            }else{
                myTableView.hidden = NO;
                noAttView.hidden = YES ;
            }
            
            
        }
       [myTableView reloadData];
     
        [[ProgressBar getProgressBar] setTitle:@"取消成功！"];
        [self performSelector:@selector(dismissProgressBar) withObject:nil afterDelay:1];
    }
    else
    {
        [[ProgressBar getProgressBar] setTitle:@"取消失败！"];
        [self performSelector:@selector(dismissProgressBar) withObject:nil afterDelay:1];
    }
}

// 关闭进度条
- (void) dismissProgressBar
{
    [[ProgressBar getProgressBar]  dismiss];
}

-(void)didAddAttention:(ASIHTTPRequest*)request
{
	NSString* responseString = [request responseString];
	NSString *result = [ResultString resultStringByParsing:responseString];
    if ([result isEqualToString:@"succ"])
    {
        NSArray * alldata = [dataArray objectAtIndex:selectIndex.section];
        liveTelecastData * teledata = [alldata objectAtIndex:selectIndex.row];
        teledata.isAttention = @"1";
        [myTableView reloadData];
        [[ProgressBar getProgressBar] setTitle:@"关注成功！"];
        [self performSelector:@selector(dismissProgressBar) withObject:nil afterDelay:1];
    }
    else
    {
        [[ProgressBar getProgressBar] setTitle:@"关注失败！"];
        [self performSelector:@selector(dismissProgressBar) withObject:nil afterDelay:1];
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

//我关注的请求
- (void)myAttentionNewRequest{
     [mRequest clearDelegatesAndCancel];
    NSString * lotterId = @"";
    if ([titleLabel.text isEqualToString:@"竞彩比分"]) {
        lotterId = @"201";
    }else if ([titleLabel.text isEqualToString:@"北单比分"]) {
        lotterId = @"400";
    }else if ([titleLabel.text isEqualToString:@"足彩比分"]) {
        lotterId = @"300";
    }

    self.mRequest = [ASIHTTPRequest requestWithURL: [NetURL scoreLiveMyAttentionNew:lotterId]];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDelegate:self];
    [mRequest setDidFinishSelector:@selector(reqScoreLiveRequestListFinished:)];
    [mRequest setDidFailSelector:@selector(reqFailRequest:)];
    [mRequest setNumberOfTimesToRetryOnTimeout:2];
    [mRequest startAsynchronous];

}

- (void)reqFailRequest:(ASIHTTPRequest *)request{
//     [loadview stopRemoveFromSuperview];
}

//比分直播 和 已完成
- (void)scoreLiveRequest{
    
    NSString * matchType = @"";
    if (allType == liveType) {
        matchType = @"0";
    }else if (allType == endType){
        matchType = @"1"; 
    }
    
    NSString * lotterId = @"";
    if ([titleLabel.text isEqualToString:@"竞彩比分"]) {
        lotterId = @"201";
    }else if ([titleLabel.text isEqualToString:@"北单比分"]) {
        lotterId = @"400";
    }else if ([titleLabel.text isEqualToString:@"足彩比分"]) {
        lotterId = @"300";
    }
    
    //201 竟彩 ，400单场 300足彩
    NSLog(@"issue = %@", self.issueString);
    [mRequest clearDelegatesAndCancel];
    self.mRequest = [ASIHTTPRequest requestWithURL: [NetURL scoreLiveLotteryId:lotterId issue:self.issueString userId:[[Info getInstance] userId] matchestate:matchType]];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDelegate:self];
    [mRequest setDidFinishSelector:@selector(reqScoreLiveRequestListFinished:)];
    [mRequest setDidFailSelector:@selector(reqFailRequest:)];
    [mRequest setNumberOfTimesToRetryOnTimeout:2];
    [mRequest startAsynchronous];

}


- (void)reqScoreLiveRequestListFinished:(ASIHTTPRequest *)request{
    
    if (request) {
        NSString * str = [request responseString];
        NSLog(@"ScoreLiveRequest = %@", str);
        
        
        if ([str isEqualToString:@"[]"]) {
            
            
                if (allType == myAttentionType) {
                    
                    if (attentionCount == 0) {
                        
                        
                        self.tabBarController.selectedIndex = 0;
                    }
                    
                    myTableView.hidden = YES;
                    noAttView.hidden = NO ;
                    
                    
                    
                }else{
                    myTableView.hidden = NO;
                    noAttView.hidden = YES ;
                }
                           
            attentionCount +=1;
            [myTableView reloadData];
//            [loadview stopRemoveFromSuperview];
            isLoading = NO;
            [refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
            return;
        }
        
        NSDictionary * dict = [str JSONValue];
        
//        [issueArray addObjectsFromArray:[dict objectForKey:@"issueList"]];
        
         [dataArray removeAllObjects];
        
        NSArray * issarr = [dict objectForKey:@"issueList"];
        
        if ([issarr count] > 0) {
            [issueArray removeAllObjects];
        }
        for (int i = 0; i < [issarr count]; i++) {
            NSDictionary * isdit = [issarr objectAtIndex:i];
            
            NSString * isstr = [isdit objectForKey:@"issue"];
            [issueArray addObject:isstr];
        }
        
        
       self.issueString = [dict objectForKey:@"issue"];
        NSMutableArray * saveissuearr = [[NSMutableArray alloc] initWithCapacity:0];
        [saveissuearr addObjectsFromArray:issueArray];
        singletonData * single = [singletonData getInstance];
        if (allType == liveType) {
            single.liveIssue = issueString;
            single.allIussueArray = saveissuearr;
        }else if(allType == myAttentionType){
            single.myIssue = issueString;
        }else if(allType == endType){
            single.endIssue = issueString;
            single.endIussueArray = saveissuearr;
        }
        NSMutableArray * saveAllArray = [[NSMutableArray alloc] initWithCapacity:0];
        [saveAllArray addObjectsFromArray:dataArray];
        if (allType == liveType) {
            single.allDataArray = saveAllArray;
            
        }else if(allType == myAttentionType){
            single.myAllDataArray = saveAllArray;
        }else if(allType == endType){
            single.endAllDataArray = saveAllArray;
            
            NSLog(@"sing = %lu", (unsigned long)[single.endAllDataArray count]);
        }
        [saveAllArray release];
        [saveissuearr release];
        if ([titleLabel.text isEqualToString:@"竞彩比分"] || allType == myAttentionType) {
            
            
            Info * info = [Info getInstance];
            if ([info.userId intValue]) {
                beginLabel.text = @"";
                btn.hidden = YES;
            }
           
        }else{
                
                beginLabel.text = [NSString stringWithFormat:@"%@▼", issueString];
                btn.hidden = NO;
//            if (allType != endType) {
//                btn.enabled = NO;
//                beginLabel.textColor = [UIColor lightGrayColor];
//            }else {
//                btn.enabled = YES;
//                beginLabel.textColor = [UIColor whiteColor];
//            }
            
        }
        
        
        
        NSArray * matchDict = [dict objectForKey:@"matchList"];
        
        
        if ([matchDict count] == 0) {
            [dataArray removeAllObjects];
            if (allType == myAttentionType) {
                
                if (attentionCount == 0) {
                   
                    
                    self.tabBarController.selectedIndex = 0;
                }
                
                myTableView.hidden = YES;
                noAttView.hidden = NO ;
                
                
                
            }else{
                myTableView.hidden = NO;
            }
            [myTableView reloadData];
//            [loadview stopRemoveFromSuperview];
            isLoading = NO;
            [refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
             attentionCount += 1;
            return;
        }else{
            noAttView.hidden = YES ;
            myTableView.hidden = NO;
            
        }
        
  
             attentionCount += 1;
        
       
        
        for (int i = 0; i < [matchDict count]; i++) {
            NSDictionary * matchInfoDict = [matchDict objectAtIndex:i];
            
            
            NSArray * keysArray = [matchInfoDict allKeys];
            
//            NSMutableArray * keysArray = [[NSMutableArray alloc] initWithCapacity:0];
//            [keysArray addObjectsFromArray:keysOrder];
//            
//            
//        
//            
//            for (int k = 0; k < [keysArray count]; k++) {
//                
//                NSString * keysString = [keysArray objectAtIndex:k];
//                NSLog(@"keysString = %@", keysString);
//                NSString * numString = [[keysString componentsSeparatedByString:@"^"] objectAtIndex:1];
//                
//                for (int m = 0; m < [keysArray count]; m++) {
//                    NSString * twoString = [keysArray objectAtIndex:m];
//                    NSLog(@"twoString = %@", twoString);
//                     NSString * twoNumString = [[twoString componentsSeparatedByString:@"^"] objectAtIndex:1];
//                    if ([numString intValue] < [twoNumString intValue]) {
//                        [keysArray exchangeObjectAtIndex:k withObjectAtIndex:m];
//                        
//                    }
//                    
//                }
//            
//                
//            }
//            
//            NSLog(@"keysarr = %@", keysArray);
            
            
            NSArray * infoArray = [matchInfoDict objectForKey:[keysArray objectAtIndex:0]];
            NSLog(@"all key = %@", [matchInfoDict objectForKey:[keysArray objectAtIndex:0]]);
             NSMutableArray * allArray = [[NSMutableArray  alloc] initWithCapacity:0];
            for (int n = 0; n < [infoArray count]; n++) {
                
                NSDictionary * infoDict = [infoArray objectAtIndex:n];
                
                liveTelecastData * liveData = [[liveTelecastData alloc] init];
                liveData.isAttention = [infoDict objectForKey:@"isAttention"];
                liveData.home = [infoDict objectForKey:@"home"];
                liveData.hostcard = [infoDict objectForKey:@"hostcard"];
                liveData.xh = [infoDict objectForKey:@"xh"];
                liveData.leagueName = [infoDict objectForKey:@"leagueName"];
                liveData.matchstartTime = [infoDict objectForKey:@"matchstartTime"];
                liveData.status = [infoDict objectForKey:@"status"];
                liveData.lotteryId = [infoDict objectForKey:@"lotteryId"];
                liveData.caiguo = [infoDict objectForKey:@"caiguo"];
                liveData.menuStr = [infoDict objectForKey:@"menuStr"];
                liveData.issue = [infoDict objectForKey:@"issue"];
                liveData.rangqiu = [infoDict objectForKey:@"rangqiu"];
                liveData.matchTime = [infoDict objectForKey:@"matchTime"];
                liveData.pos = [infoDict objectForKey:@"pos"];
                liveData.away = [infoDict objectForKey:@"away"];
                liveData.scoreHost = [infoDict objectForKey:@"scoreHost"];
                liveData.start = [infoDict objectForKey:@"start"];
                liveData.matchId = [infoDict objectForKey:@"matchId"];
                liveData.splitDate = [infoDict objectForKey:@"splitDate"];
                liveData.awaycard = [infoDict objectForKey:@"awaycard"];
                liveData.awayHost = [infoDict objectForKey:@"awayHost"];
                liveData.section_id = [infoDict objectForKey:@"section_id"];
                liveData.ASIA_cp_p = [infoDict objectForKey:@"ASIA_cp_p"];
                liveData.bcbf = [infoDict objectForKey:@"bcbf"];
                
                NSLog(@"1%@", liveData.isAttention);
                NSLog(@"1%@", liveData.home);
                NSLog(@"1%@", liveData.hostcard);
                NSLog(@"1%@", liveData.xh);
                NSLog(@"1%@", liveData.leagueName);
                NSLog(@"1%@", liveData.matchstartTime);
                NSLog(@"1%@", liveData.status);
                NSLog(@"1%@", liveData.lotteryId);
                NSLog(@"1%@", liveData.caiguo);
                NSLog(@"1%@", liveData.menuStr);
                NSLog(@"1%@", liveData.issue );
                NSLog(@"1%@", liveData.rangqiu );
                NSLog(@"1%@", liveData.matchTime );
                NSLog(@"1%@", liveData.pos);
                NSLog(@"1%@", liveData.away);
                NSLog(@"1%@", liveData.scoreHost);
                NSLog(@"1%@", liveData.start);
                NSLog(@"1%@", liveData.matchId);
                NSLog(@"1%@", liveData.splitDate);
                NSLog(@"1%@", liveData.awaycard );
                NSLog(@"1%@", liveData.awayHost);
                               
                
                [allArray addObject:liveData];
                [liveData release];
            }
            
            [dataArray addObject:allArray];
            NSLog(@"allarray = %@", allArray);
            [allArray release];


        }//chrome
            
        [myTableView reloadData];
    }
    
    
//    [loadview stopRemoveFromSuperview];
    isLoading = NO;
     [refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
    
    singletonData * singleton = [singletonData getInstance];
    
    NSMutableArray * saveAllArray = [[NSMutableArray alloc] initWithCapacity:0];
    [saveAllArray addObjectsFromArray:dataArray];
    
   
    
    if (allType == liveType) {
        singleton.allDataArray = saveAllArray;
    
    }else if(allType == myAttentionType){
        singleton.myAllDataArray = saveAllArray;
    }else if(allType == endType){
        singleton.endAllDataArray = saveAllArray;
        
        NSLog(@"sing = %lu", (unsigned long)[singleton.endAllDataArray count]);
    }
    [saveAllArray release];
 
//    if ([titleLabel.text isEqualToString:@"竞彩比分"]) {
//        singleton.selectTile = 0;
//    }else if ([titleLabel.text isEqualToString:@"北单比分"]) {
//        singleton.selectTile = 1;
//    }else if ([titleLabel.text isEqualToString:@"足彩比分"]) {
//        singleton.selectTile = 2;
//    }

}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    attentionCount = 0;
    
    issueArray = [[NSMutableArray alloc] initWithCapacity:0];
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    kongzhiType = [[NSMutableArray alloc] initWithCapacity:0];
    arrayType = [[NSMutableArray alloc] initWithCapacity:0];
    
    issueString = @"";
    buffer[0] = 1;
    
    //背景
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgImageView.backgroundColor = [UIColor clearColor];
    bgImageView.image = UIImageGetImageFromName(@"login_bgn.png") ;
    [self.mainView addSubview:bgImageView];
    [bgImageView release];
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    
    [self issueRightBarButtonFunc];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, 260, 44)];
    
    
    UIButton * titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(10, 5, 180, 34);
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    
    titleLabel = [[UILabel alloc] initWithFrame:titleButton.bounds];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    
    titleLabel.textColor = [UIColor whiteColor];
    
    [titleButton addSubview:titleLabel];
    
    sanjiaolabel = [[UILabel alloc] init];
    sanjiaolabel.backgroundColor = [UIColor clearColor];
    sanjiaolabel.textAlignment = NSTextAlignmentCenter;
    sanjiaolabel.font = [UIFont systemFontOfSize:14];
    sanjiaolabel.text = @"▼";
    sanjiaolabel.textColor = [UIColor whiteColor];
    sanjiaolabel.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];//阴影
    sanjiaolabel.shadowOffset = CGSizeMake(0, 1.0);
    [titleButton addSubview:sanjiaolabel];
    [sanjiaolabel release];
    
    [titleView addSubview:titleButton];
    
  
//    titleLabel.text = @"竞彩比分";
    
    
    [self tableViewTitleLabel];
    
    
    
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaolabel.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width, 2, 20, 34);
    self.CP_navigation.titleView = titleView;
    [titleView release];
    
    
    
    
    
    if (allType == myAttentionType) {
        
        noAttView = [[UIView alloc] initWithFrame:self.mainView.bounds];
        
        UIImageView * attImage = [[UIImageView alloc] initWithFrame:CGRectMake((320-227/2)/2, 57, 227/2, 227/2)];
        attImage.image = UIImageGetImageFromName(@"bifenwodeguanzhu.png");
        attImage.backgroundColor = [UIColor clearColor];
        [noAttView addSubview:attImage];
        [attImage release];
        
        
        UILabel * labeltext1 = [[UILabel alloc] initWithFrame:CGRectMake((320-227/2)/2, 57+227/2+14, 150, 20)];
        labeltext1.backgroundColor = [UIColor clearColor];
        labeltext1.textAlignment = NSTextAlignmentLeft;
        labeltext1.font = [UIFont systemFontOfSize:13];
        labeltext1.text = @"您尚未关注比赛，";
        labeltext1.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
        [noAttView addSubview:labeltext1];
        [labeltext1 release];
        
        UILabel * labeltext2 = [[UILabel alloc] initWithFrame:CGRectMake((320-227/2)/2, 57+227/2+14+17, 150, 20)];
        labeltext2.backgroundColor = [UIColor clearColor];
        labeltext2.textAlignment = NSTextAlignmentLeft;
        labeltext2.font = [UIFont systemFontOfSize:13];
        labeltext2.text = @"点亮赛事前面的小星星，";
        labeltext2.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
        [noAttView addSubview:labeltext2];
        [labeltext2 release];
        
        UILabel * labeltext3 = [[UILabel alloc] initWithFrame:CGRectMake((320-227/2)/2, 57+227/2+14+17+17, 150, 20)];
        labeltext3.backgroundColor = [UIColor clearColor];
        labeltext3.textAlignment = NSTextAlignmentLeft;
        labeltext3.font = [UIFont systemFontOfSize:13];
        labeltext3.text = @"关注感兴趣的赛事！";
        labeltext3.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
        [noAttView addSubview:labeltext3];
        [labeltext3 release];
        
        
        [self.mainView addSubview:noAttView];
        [noAttView release];
        noAttView.hidden = YES;
    }
    
    
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320,self.mainView.frame.size.height-50) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:myTableView];
    [myTableView release];
    
    
    
    if (!refreshHeaderView)
    {
		CBRefreshTableHeaderView *headerview =
		[[CBRefreshTableHeaderView alloc]
		 initWithFrame:CGRectMake(0, -(myTableView.frame.size.height), myTableView.frame.size.width, myTableView.frame.size.height)];
        self.refreshHeaderView = headerview;
		refreshHeaderView.delegate = self;
		[myTableView addSubview:refreshHeaderView];
		[headerview release];
	}
    
    if (bifenzhibo) {
        if (bifenType == jingcaibifenType) {
            titleLabel.text = @"竞彩比分";
            self.issueString = @"";
        }else if(bifenType == beidanbifenType){
            titleLabel.text = @"北单比分";
            self.issueString = @"";
        }else if(bifenType == zucaibifenType){
            titleLabel.text = @"足彩比分";
            self.issueString = @"";
        }
    }
   

    [self allRequestFunc];
    
    
    [self loginYesOrNoFunc];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allRequestFunc) name:@"BecomeActive" object:nil];
   
//     luntime = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(allRequestFunc) userInfo:nil repeats:YES];
}

- (void)pressMenubutton:(UIButton *)sender{
    
    
    NSMutableArray * array = [NSMutableArray array];
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"期号",@"title", issueArray,@"choose", nil];
    
    
//    if ([kongzhiType count] == 0) {
    [kongzhiType removeAllObjects];
        NSMutableArray * issarr = [NSMutableArray array];
        for (int i = 0; i < [issueArray count]; i++) {
           
            NSString * str = [issueArray objectAtIndex:i];
             NSLog(@"issue = %@, xx = %@", self.issueString, str);
            if ([str isEqualToString:self.issueString]) {
                [issarr addObject:@"1"];
            }else{
                [issarr addObject:@"0"];
            }
            
        }
        
        NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"期号",@"title",issarr,@"choose", nil];
        
        [kongzhiType addObject:type1];
        
//    }
    
    
    [array addObject:dic];
    
    
    
    CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"期号选择" ChangCiTitle:@"" DataInfo:array kongtype:kongzhiType];
    alert2.delegate = self;
    alert2.tag = 20;
    [alert2 show];
    [alert2 release];


}

- (void)pressTitleButton:(UIButton *)sender{
    
    

    CP_LieBiaoView *lb2 = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds danXuan:YES type:arrayType];
    
    lb2.delegate = self;
    lb2.tag = 103;
    [lb2 LoadButtonName:[NSArray arrayWithObjects:@"竞彩比分",@"北单比分",@"足彩比分",nil]];
    lb2.isSelcetType = YES;
    [lb2 show];
    [lb2 release];

}

- (void)doBack{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void)pressBgHeader:(UIButton *)sender{

    if (buffer[sender.tag] == 0) {
        buffer[sender.tag] = 1;
    }else{
        buffer[sender.tag] = 0;
        
        
    }
    
    [myTableView reloadData];

}

#pragma mark UITableView delegate dataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIButton * bgheader = [UIButton buttonWithType:UIButtonTypeCustom];
    bgheader.tag = section;
    
#ifdef isCaiPiaoForIPad
    bgheader.frame = CGRectMake(0, 0, 390, 28);
#else
    bgheader.frame = CGRectMake(0, 0, 320, 28);
#endif
    bgheader.backgroundColor = [UIColor clearColor];
    UIImageView *im = [[UIImageView alloc] initWithFrame:bgheader.frame];
    im.backgroundColor = [UIColor clearColor];
    if (buffer[section] == 0) {
        im.image =[UIImageGetImageFromName(@"DHTY960.png") stretchableImageWithLeftCapWidth:1 topCapHeight:0];
        
    }else{
        im.image =[UIImageGetImageFromName(@"DHTX960.png") stretchableImageWithLeftCapWidth:1 topCapHeight:0];
        
    }
    [bgheader addSubview:im];
    [im release];
    [bgheader addTarget:self action:@selector(pressBgHeader:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * timelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgheader.frame.size.width, 28)];
    timelabel.textColor = [UIColor whiteColor];//[UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
    timelabel.backgroundColor = [UIColor clearColor];
    timelabel.textAlignment = NSTextAlignmentCenter;
    timelabel.font = [UIFont boldSystemFontOfSize:13];
//    timelabel.text = @"今天 几天呢 几天呢撒旦法";
    [bgheader addSubview:timelabel];
    [timelabel release];
    
    NSArray * alldata = [dataArray objectAtIndex:section];
    
    if ([alldata count] > 0) {
        liveTelecastData * teldata = [alldata objectAtIndex:0];
        timelabel.text = teldata.menuStr;
    }
    
    
    
    
    if (buffer[section] == 0) {
        timelabel.textColor = [UIColor blackColor];
        
        
    }else{
        timelabel.textColor = [UIColor whiteColor];
        
    }
    
    return bgheader;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     NSArray * alldata = [dataArray objectAtIndex:section];
    if ([alldata count] == 0) {
        return 0;
    }
    return 28;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"section = %lu", (unsigned long)[dataArray count]);
    return [dataArray count];
//    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (buffer[section] == 1) {
        NSMutableArray * allarr = [dataArray objectAtIndex:section];
        
        return [allarr count];
    }else{
        
        return 0;
    }

//    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellid = @"cellid";
    liveTelecastCell * cell = (liveTelecastCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        
            cell = [[[liveTelecastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
        cell.delegate = self;
        
    }
    NSMutableArray * infoArray = [dataArray objectAtIndex:indexPath.section];
    cell.liveData = [infoArray objectAtIndex:indexPath.row];
    cell.indexPath = indexPath;
//    cell.typeCell = allType;
    if (allType == liveType) {
        cell.typeCell = liveTypeCell;
    }else if(allType == myAttentionType){
        cell.typeCell = myAttentionTypeCell;
    }else if(allType == endType){
        cell.typeCell = endTypeCell;
    }
    return cell;
}


#pragma mark didSelectRowAtIndexPath

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    NSArray * allData = [dataArray objectAtIndex:indexPath.section];
    liveTelecastData * telecastData = [allData objectAtIndex:indexPath.row];
    ScoreLiveDetailViewController *score = [[ScoreLiveDetailViewController alloc] init];
    score.scoreInfo = telecastData;
    [self.navigationController pushViewController:score animated:YES];
    [score release];
//    telecastData.matchId
    
    
}

- (void)liveTelecastCellReturn:(NSIndexPath *)index uiButton:(UIButton *)sender{

    NSLog(@"xxxx收藏");
    NSLog(@"xx = %ld, row = %ld", (long)index.section, (long)index.row);
    
    NSArray * alldata = [dataArray objectAtIndex:index.section];
    liveTelecastData * match = [alldata objectAtIndex:index.row];
    
    
   
    
    self.selectIndex = index;
    
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        
        if (sender.selected == NO) //发送取消关注请求
        {
            [self sendCancelAttention:match];
        }
        else //发送添加关注请求
        {
            if ([match.start isEqualToString:@"2"])
            {
                [Info showDialogWithTitle:@"提示"  BtnTitle:@"确定" Msg:@"抱歉,已结束的比赛不能添加关注" :self];
                return;
            }
            [self sendAddAttention:match];
        }
    }else{
    
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"您还未登录,请先登录"];
    }
    
   

    

}

- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex type:(NSMutableArray *)typearr{
    NSLog(@"type = %@", typearr);
    
    for (int i = 0; i < [typearr count]; i++) {
        [arrayType replaceObjectAtIndex:i withObject:[typearr objectAtIndex:i]];
    }
    
    
    if (liebiaoView.tag == 103) {
        if (buttonIndex == 0){//竞彩
        
            titleLabel.text = @"竞彩比分";
            if ([[[Info getInstance] userId] intValue]) {
                btn.hidden = YES;
            }
            
            self.issueString = @"";
            
            [self allRequestFunc];
            [self loginYesOrNoFunc];
        }else if(buttonIndex == 1){//北单
        
            titleLabel.text = @"北单比分";
            self.issueString = @"";
//            if (allType != endType) {
//                btn.enabled = NO;
//                beginLabel.textColor = [UIColor lightGrayColor];
//            }else {
//                btn.enabled = YES;
//                beginLabel.textColor = [UIColor whiteColor];
//            }
            [self allRequestFunc];
            [self loginYesOrNoFunc];
        }else if(buttonIndex == 2){//足彩
        
            titleLabel.text = @"足彩比分";
            self.issueString = @"";
//            if (allType != endType) {
//                btn.enabled = NO;
//                beginLabel.textColor = [UIColor lightGrayColor];
//            }else {
//                btn.enabled = YES;
//                beginLabel.textColor = [UIColor whiteColor];
//            }
            [self allRequestFunc];
            [self loginYesOrNoFunc];
        }
        
        
        singletonData * singleton = [singletonData getInstance];
        
        if ([titleLabel.text isEqualToString:@"竞彩比分"]) {
            singleton.selectTile = 0;
        }else if ([titleLabel.text isEqualToString:@"北单比分"]) {
            singleton.selectTile = 1;
        }else if ([titleLabel.text isEqualToString:@"足彩比分"]) {
            singleton.selectTile = 2;
        }
//        singletonData * single = [singletonData getInstance];
        if (allType == liveType) {
            singleton.liveIssue = issueString;
        }else if(allType == myAttentionType){
            singleton.myIssue = issueString;
        }else if(allType == endType){
            singleton.endIssue = issueString;
        }
        
    }
}


- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt{
    
    if (buttonIndex == 1) {
      
        [kongzhiType removeAllObjects];
        [kongzhiType addObjectsFromArray:kongt];
        NSArray * isar = [returnarry objectAtIndex:0];
        NSString * issues = [isar objectAtIndex:0];
        self.issueString = issues;
        
        singletonData * single = [singletonData getInstance];
        if (allType == liveType) {
            single.liveIssue = issueString;
        }else if(allType == myAttentionType){
            single.myIssue = issueString;
        }else if(allType == endType){
            single.endIssue = issueString;
        }
        
        [self allRequestFunc];
        
        NSLog(@"ississString = %@", issueString);
        
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark CBRefreshTableHeaderDelegate
// 刷新发送请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view
{
	//[self reloadSegmentData];
    isLoading = YES;
    
    
    [self allRequestFunc];
    [refreshHeaderView setState:CBPullRefreshLoading];
    //
    //	myTableView.contentInset = UIEdgeInsetsMake(60, 0.0f, 0.0f, 0.0f);
}

// 加载更多
- (void)doMoreLoading
{
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
- (void)reloadTableViewDataSource{
	isLoading = YES;
    
}
// 数据接收完成调用
- (void)dismissRefreshTableHeaderView
{
    isLoading = NO;
	[refreshHeaderView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
}

#pragma mark SvrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	
	[refreshHeaderView CBRefreshScrollViewDidScroll:scrollView];
	
}


// 下拉结束 时 调用 停在 正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (myTableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
		
				
	}
	
	[refreshHeaderView CBRefreshScrollViewDidEndDragging:scrollView];
	
}

- (void)readDataFunc{

    singletonData * single = [singletonData getInstance];
    
    NSInteger singcount = 0;
    
    if (allType == myAttentionType) {
        singcount = single.myTitle;
    }else if(allType == liveType){
        singcount = single.liveTitle;
    }else if(allType == endType){
        singcount = single.endTitle;
    }
    NSLog(@"select = %ld", (long)single.selectTile);
    if (singcount != single.selectTile) {//如果他们的选项不一样时 请求
        [self tableViewTitleLabel];
        self.issueString = @"";
        [self allRequestFunc];
    }else{
        if (allType == myAttentionType) {//赋值
            
            
            
//            if ([single.myAllDataArray count] == 0 || ![issueString isEqualToString:single.myIssue]) {//如果保存的数组里为空 请求
                [self tableViewTitleLabel];
                self.issueString = single.myIssue;
                [self allRequestFunc];
//            }else{
//                [dataArray removeAllObjects];
//                
//                [dataArray addObjectsFromArray:single.myAllDataArray];
//                self.issueString = single.myIssue;
//
//                [myTableView reloadData];
//                
//                
//            }
        }else if(allType == liveType){
           
//            if ([single.allDataArray count] == 0|| ![issueString isEqualToString:single.liveIssue]) {//如果保存的数组里为空 请求
                [self tableViewTitleLabel];
                self.issueString = single.myIssue;

                [self allRequestFunc];
//            }else{
//                [dataArray removeAllObjects];
//                
//                [dataArray addObjectsFromArray:single.allDataArray];
//                [issueArray removeAllObjects];
//                [issueArray addObjectsFromArray:single.allIussueArray];
//                
//                self.issueString = single.liveIssue;
//
//                
//                [myTableView reloadData];
//                
//                
//            }
        }else if(allType == endType){
           
//            if ([single.endAllDataArray count] == 0|| ![issueString isEqualToString:single.endIssue]) {//如果保存的数组里为空 请求
                [self tableViewTitleLabel];
                self.issueString = single.myIssue;
                [self allRequestFunc];
//            }else{
//                [dataArray removeAllObjects];
//                NSLog(@"end = %d", [single.endAllDataArray count]);
//                [dataArray addObjectsFromArray:single.endAllDataArray];
//                [issueArray removeAllObjects];
//                [issueArray addObjectsFromArray:single.endIussueArray];
//                self.issueString = single.endIssue;
//                [myTableView reloadData];
//                
//                
//            }
        }
        
        if ([titleLabel.text isEqualToString:@"竞彩比分"]) {
            
        }else{
             btn.hidden = NO;
            beginLabel.text = [NSString stringWithFormat:@"%@▼", issueString];
        }
        
        
        
        
        
        
        
    }
}

- (void)myAttentionTypeFunc{

//    if (singcount != single.selectTile) {//如果他们的选项不一样时 请求
        [self tableViewTitleLabel];
        [self allRequestFunc];
//    }else{
//        [self tableViewTitleLabel];
//        [self myAttScreen];
//        
//        
//    }

}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self tableViewTitleLabel];
    [self loginYesOrNoFunc];
    if (attentionCount == 0) {
        
        
    }else{
        
        
        if (bifenzhibo) {
            bifenzhibo = NO;
        }else{
        
            if (allType == myAttentionType) {
                
                [self myAttentionTypeFunc];
                
            }else{
                [self readDataFunc];
            }
        }
    
       
        
        
         
    
        
    }
    [self allRequestFunc];
    luntime = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(allRequestFunc) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
//    caiboappdelegate.keFuButton.hidden = NO;
//    [caiboappdelegate.keFuButton chulaitiao];
//    if (caiboappdelegate.keFuButton.markbool) {
//        caiboappdelegate.keFuButton.show = YES;
//    }else{
//        caiboappdelegate.keFuButton.show = NO;
//    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
//    [cai.keFuButton calloff];
    
    [self tableDisTitle];
    
    [luntime invalidate];
    luntime = nil;
}

- (void)dealloc{
     
    [refreshHeaderView release];
    [kongzhiType release];
    [dataArray release];
    [issueArray release];
    [mRequest clearDelegatesAndCancel];
    [mRequest release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    