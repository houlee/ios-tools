
//
//  PKRankingListViewController.m
//  caibo
//
//  Created by GongHe on 15-1-19.
//
//

#import "PKRankingListViewController.h"
#import "Info.h"
#import "SharedMethod.h"
#import "PKRankingListTableViewCell.h"
#import "PKRankingListData.h"
#import "caiboAppDelegate.h"
#import "GC_HttpService.h"
@interface PKRankingListViewController ()

@end

@implementation PKRankingListViewController
@synthesize myRequest;
@synthesize myRequest1;
@synthesize userName,userNic_name,issue,PKUserId;
@synthesize mRefreshView;

- (void)dealloc
{
//    [loadView release];
    [rankingListTableView release];
    [weekDataArray release];
    [dayDataArray release];
    [selectDataArray release];
    [blueLine release];
    [myRequest1 clearDelegatesAndCancel];
    self.myRequest1 = nil;
    [myRequest clearDelegatesAndCancel];
    self.myRequest = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.CP_navigation.title = @"排行榜";
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
    
    UIImageView * bannerImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width, 125)] autorelease];
    bannerImageView.image = UIImageGetImageFromName(@"PKRankListBanner.png");
    [self.mainView addSubview:bannerImageView];
    
    UIView * line = [[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(bannerImageView), self.mainView.frame.size.width, 0.5)] autorelease];
    line.backgroundColor = [SharedMethod getColorByHexString:@"dddddd"];
    [self.mainView addSubview:line];
    
    UIView * titleView = [[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(line), self.mainView.frame.size.width, 50)] autorelease];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:titleView];
    
    UIView * line1 = [[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(titleView), self.mainView.frame.size.width, 0.5)] autorelease];
    line1.backgroundColor = [SharedMethod getColorByHexString:@"dddddd"];
    [self.mainView addSubview:line1];
    
    UIButton * weekButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, titleView.frame.size.width/2, titleView.frame.size.height)] autorelease];
    [weekButton setTitleColor:[SharedMethod getColorByHexString:@"858585"] forState:UIControlStateNormal];
    [weekButton setTitleColor:[SharedMethod getColorByHexString:@"13a3ff"] forState:UIControlStateSelected
     ];
    weekButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [weekButton setTitle:@"日 榜" forState:UIControlStateNormal];
    [titleView addSubview:weekButton];
    weekButton.selected = YES;
    weekButton.tag = 10;
    [weekButton addTarget:self action:@selector(changeList:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * totalButton = [[[UIButton alloc] initWithFrame:CGRectMake(ORIGIN_X(weekButton), 0, titleView.frame.size.width/2, titleView.frame.size.height)] autorelease];
    [totalButton setTitleColor:[SharedMethod getColorByHexString:@"858585"] forState:UIControlStateNormal];
    [totalButton setTitleColor:[SharedMethod getColorByHexString:@"13a3ff"] forState:UIControlStateSelected
     ];
    totalButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [totalButton setTitle:@"周 榜" forState:UIControlStateNormal];
    [titleView addSubview:totalButton];
    totalButton.tag = 20;
    [totalButton addTarget:self action:@selector(changeList:) forControlEvents:UIControlEventTouchUpInside];
    
    blueLine = [[UIView alloc] initWithFrame:CGRectMake(0, titleView.frame.size.height - 2, 160, 2)];
    blueLine.backgroundColor = [SharedMethod getColorByHexString:@"13a3ff"];
    [titleView addSubview:blueLine];
    
    rankingListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(line1), self.mainView.frame.size.width, self.mainView.frame.size.height - ORIGIN_Y(line1))];
    rankingListTableView.delegate = self;
    rankingListTableView.dataSource = self;
    rankingListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainView addSubview:rankingListTableView];
    
    wujiluView = [[UIView alloc]init];
    wujiluView.backgroundColor = [UIColor clearColor];
    wujiluView.hidden = YES;
//    wujiluView.frame = CGRectMake(0, 97.5, bgimage.frame.size.width, bgimage.frame.size.height - 97.5);
    wujiluView.frame = CGRectMake(0, 176, 320, rankingListTableView.frame.size.height);
    [self.mainView addSubview:wujiluView];
    [wujiluView release];
    
    UIImageView *wujiluIma = [[UIImageView alloc]init];
    wujiluIma.frame = CGRectMake((wujiluView.frame.size.width - 140)/2, 58, 140, 140);
    wujiluIma.backgroundColor = [UIColor clearColor];
    wujiluIma.image = [UIImage imageNamed:@"PKzhanjiwu.png"];
    [wujiluView addSubview:wujiluIma];
    [wujiluIma release];
    
    UILabel *wujiluLab = [[UILabel alloc]init];
    wujiluLab.frame = CGRectMake(0, 220, wujiluView.frame.size.width, 30);
    wujiluLab.backgroundColor = [UIColor clearColor];
    wujiluLab.text = @"暂无相关信息";
    wujiluLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    wujiluLab.font = [UIFont systemFontOfSize:14];
    wujiluLab.textAlignment = NSTextAlignmentCenter;
    [wujiluView addSubview:wujiluLab];
    [wujiluLab release];
    
    CGFloat height = self.view.frame.size.height;
    if(height == 480)
    {
        wujiluIma.frame = CGRectMake((wujiluView.frame.size.width - 140)/2, 28, 140, 140);
        wujiluLab.frame = CGRectMake(0, 180, wujiluView.frame.size.width, 30);
    }
    
    if (!mRefreshView)
    {
        UITableView *mTableView = rankingListTableView;
        CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -(mTableView.frame.size.height), mTableView.frame.size.width, mTableView.frame.size.height)];
        headerview.backgroundColor = [UIColor clearColor];
        self.mRefreshView = headerview;
        mRefreshView.delegate = self;
        [rankingListTableView addSubview:mRefreshView];
        [headerview release];
    }
    [mRefreshView refreshLastUpdatedDate];
//    [self CBRefreshTableHeaderDidTriggerRefresh:mRefreshView];
    
    //    PKRankingListData * data = [[PKRankingListData alloc] initWithDictionary:@{@"userName":@"糖糖糖糖糖糖糖糖",@"earnings":@"7320.12",@"winnings":@"277700",@"rank":@"1"}];
    //    PKRankingListData * data1 = [[PKRankingListData alloc] initWithDictionary:@{@"userName":@"哈哈哈哈哈哈哈哈",@"earnings":@"111414",@"winnings":@"999",@"rank":@"12"}];
    
    //    dayDataArray = [[NSMutableArray alloc] initWithObjects:data, data,data, data,data, data,data, data,data, data,nil];
    //    weekDataArray = [[NSMutableArray alloc] initWithObjects:data1, data,data1, data,data1, data,data1, data,data, data,nil];
    dayDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    weekDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    selectDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    self.issue=[dateformatter stringFromDate:senddate];
    
    NSLog(@"%@",self.issue);
    
    [dateformatter release];
    
    
    [self getPKDayList];
    [self getPKWeekList];
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [mRefreshView CBRefreshScrollViewDidScroll:scrollView];
    
}

// 下拉结束停在正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [mRefreshView CBRefreshScrollViewDidEndDragging:scrollView];
}
#pragma mark CBRefreshTableHeaderDelegate
// 刷新发送请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view
{
    isLoading = YES;
    [mRefreshView setState:CBPullRefreshLoading];
    
    [self getPKDayList];
    [self getPKWeekList];
    
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
    UITableView *mTableView = rankingListTableView;
    isLoading = NO;
    [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:mTableView];
}
-(void)getPKDayList{
    
//    if (!loadView) {
//        loadView = [[UpLoadView alloc] init];
//    }
//    
//    caiboAppDelegate *appDelegate = (caiboAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [appDelegate.window addSubview:loadView];
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] req_GetPKRanking:@"day" caizhongId:@"201" qici:self.issue];
    [myRequest clearDelegatesAndCancel];
    self.myRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [myRequest setRequestMethod:@"POST"];
    [myRequest addCommHeaders];
    [myRequest setPostBody:postData];
    [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myRequest setDelegate:self];
    [myRequest setDidFinishSelector:@selector(requestPkDayListFinished:)];
    [myRequest setDidFailSelector:@selector(requestPkDayListFailed:)];
    [myRequest startAsynchronous];
}
-(void)getPKWeekList{
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] req_GetPKRanking:@"week" caizhongId:@"201" qici:self.issue];
    self.myRequest1 = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [myRequest1 setRequestMethod:@"POST"];
    [myRequest1 addCommHeaders];
    [myRequest1 setPostBody:postData];
    [myRequest1 setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myRequest1 setDelegate:self];
    [myRequest1 setDidFinishSelector:@selector(requestPkWeekListFinished:)];
    [myRequest1 setDidFailSelector:@selector(requestPkWeekListFailed:)];
    [myRequest1 startAsynchronous];
}
-(void)requestPkDayListFinished:(ASIHTTPRequest *)requests{
    
    [dayDataArray removeAllObjects];
    
    if ([requests responseData])
    {
        GC_PKRankingList *pkRankingList = [[GC_PKRankingList alloc]initWithResponseData:requests.responseData WithRequest:requests];
        dayCurCount = pkRankingList.curCount;
        [dayDataArray addObjectsFromArray:pkRankingList.listData];
        if(!rightSelected)
        {
            [selectDataArray removeAllObjects];
            [selectDataArray addObjectsFromArray:dayDataArray];
            if (dayDataArray.count == 0)
            {
                wujiluView.hidden = NO;
                rankingListTableView.hidden = YES;
            }
            else
            {
                wujiluView.hidden = YES;
                rankingListTableView.hidden =  NO;
            }
        }
        [pkRankingList release];
    }
    [rankingListTableView reloadData];
    
}
-(void)requestPkDayListFailed:(ASIHTTPRequest *)requests{
    
}
-(void)requestPkWeekListFinished:(ASIHTTPRequest *)requests{
    
//    if (loadView) {
//        [loadView stopRemoveFromSuperview];
//        loadView = nil;
//    }
    [self dismissRefreshTableHeaderView];
    
    [weekDataArray removeAllObjects];
    if ([requests responseData])
    {
        GC_PKRankingList *pkRankingList = [[GC_PKRankingList alloc]initWithResponseData:requests.responseData WithRequest:requests];
        weekCurCount = pkRankingList.curCount;
        [weekDataArray addObjectsFromArray:pkRankingList.listData];
        if(rightSelected)
        {
            [selectDataArray removeAllObjects];
            [selectDataArray addObjectsFromArray:weekDataArray];
            if (weekDataArray.count == 0)
            {
                wujiluView.hidden = NO;
                rankingListTableView.hidden = YES;
            }
            else
            {
                wujiluView.hidden = YES;
                rankingListTableView.hidden = NO;
            }
        }
        [pkRankingList release];
    }
    
}
-(void)requestPkWeekListFailed:(ASIHTTPRequest *)requests{
    
//    if (loadView) {
//        [loadView stopRemoveFromSuperview];
//        loadView = nil;
//    }
    [self dismissRefreshTableHeaderView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return selectDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"cell";
    PKRankingListTableViewCell * cell = (PKRankingListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[PKRankingListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    
    //    if ([[[selectDataArray objectAtIndex:indexPath.row] rank] integerValue] == 1) {
    //        cell.medalImageView.image = UIImageGetImageFromName(@"gradeImage%d.png");
    //    }
    //    else if ([[[selectDataArray objectAtIndex:indexPath.row] rank] integerValue] == 2) {
    //        cell.medalImageView.image = UIImageGetImageFromName(@"gradeImage%d.png");
    //    }
    //    else if ([[[selectDataArray objectAtIndex:indexPath.row] rank] integerValue] == 3) {
    //        cell.medalImageView.image = UIImageGetImageFromName(@"gradeImage%d.png");
    //    }
    //    else {
    //        cell.medalImageView.image = UIImageGetImageFromName(@"gradeImage4.png");
    //    }
    if(indexPath.row < 3)
    {
        cell.medalImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"gradeImage%d.png",(int)(indexPath.row+1)]];
        cell.mingciLab.frame = CGRectMake(0, 0, 24, 18);
    }
    else
    {
        cell.medalImageView.image = UIImageGetImageFromName(@"gradeImage4.png");
        cell.mingciLab.frame = CGRectMake(0, 0, 24, 24);
    }
    
    
    //    cell.userNameLabel.text = [[selectDataArray objectAtIndex:indexPath.row] userName];
    //    cell.earningsLabel.text = [NSString stringWithFormat:@"收益%@",[[selectDataArray objectAtIndex:indexPath.row] earnings]];
    //    cell.winningsLabel.text = [NSString stringWithFormat:@"%@元 彩金",[[selectDataArray objectAtIndex:indexPath.row] winnings]];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PKMyRankingList *pkr = [selectDataArray objectAtIndex:indexPath.row];
    cell.mingciLab.text = [NSString stringWithFormat:@"%d",(int)(indexPath.row+1)];
    cell.userNameLabel.text = pkr.userNicheng;
    cell.earningsLabel.text = [NSString stringWithFormat:@"收益%@",pkr.winMoney];
    cell.winningsLabel.text = [NSString stringWithFormat:@"%@积分",pkr.getScore];
    [cell.userImageView setImageWithURL:pkr.userIma];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    
    
    return cell;
}

-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)changeList:(UIButton *)selectButton
{
    [selectDataArray removeAllObjects];
    UIButton * weekButton = (UIButton *)[self.view viewWithTag:10];
    UIButton * totalButton = (UIButton *)[self.view viewWithTag:20];
    
    selectButton.selected = YES;
    
    if (selectButton == weekButton) {
        totalButton.selected = NO;
        rightSelected = NO;
        [selectDataArray addObjectsFromArray:dayDataArray];
        if(dayDataArray.count == 0)
        {
            wujiluView.hidden = NO;
            rankingListTableView.hidden = YES;
        }
        else
        {
            wujiluView.hidden = YES;
            rankingListTableView.hidden = NO;
        }
    }else{
        weekButton.selected = NO;
        rightSelected = YES;
        [selectDataArray addObjectsFromArray:weekDataArray];
        if(weekDataArray.count == 0)
        {
            wujiluView.hidden = NO;
            rankingListTableView.hidden = YES;
        }
        else
        {
            wujiluView.hidden = YES;
            rankingListTableView.hidden = NO;
        }
    }
    [UIView animateWithDuration:0.2 animations:^{
        blueLine.frame = CGRectMake(selectButton.frame.origin.x, blueLine.frame.origin.y, blueLine.frame.size.width, blueLine.frame.size.height);
    }];
    
    [rankingListTableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CP_Actionsheet * sheet = [[CP_Actionsheet alloc] initWithType:writeMicroblogActionsheetType Title:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"TA的PK赛方案",@"@TA",@"TA的微博",@"TA的资料", nil];
    sheet.tag = 10;
    sheet.delegate = self;
    
    PKMyRankingList *pkx = [selectDataArray objectAtIndex:indexPath.row];
    self.userName = pkx.userName;
    self.userNic_name = pkx.userNicheng;
    
    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    [app.window addSubview:sheet];
    
    [sheet release];
}
- (void)CP_Actionsheet:(CP_Actionsheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex==%d",(int)buttonIndex);
    if(buttonIndex)
    {
        if ([[[Info getInstance] userId] intValue] == 0) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"登录后可用"];
            return;
        }
    }
    if(buttonIndex == 1)//他的PK赛方案
    {
        PKMyRecordViewController *pvc = [[PKMyRecordViewController alloc]init];
        pvc.userName = self.userName;
        pvc.userNickName = self.userNic_name;
        [self.navigationController pushViewController:pvc animated:YES];
        [pvc release];
    }
    else if(buttonIndex == 2)//@他
    {
        SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
        publishController.microblogType = NewTopicController;// 自发彩博
        YtTopic *topic = [[YtTopic alloc] init];
        NSMutableString *mTempStr = [[NSMutableString alloc] init];
        [mTempStr appendString:@"@"];
        //        [mTempStr appendString:mUserInfo.nick_name];
        [mTempStr appendString:self.userNic_name];
        [mTempStr appendString:@" "];
        topic.nick_name = mTempStr;
        publishController.mStatus = topic;
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
        [self presentViewController:nav animated: YES completion:nil];
        [publishController release];
        [nav release];
        [topic release];
        [mTempStr release];
    }
    else if(buttonIndex == 3)//@他的微博
    {
//        [[Info getInstance] setHimId:self.userName];
//        NSString *himId = self.userName;
//        TwitterMessageViewController *controller = [[TwitterMessageViewController alloc] init];
//        controller.userID = himId;
//        controller.title = @"他的动态";
//        [self.navigationController pushViewController:controller animated:YES];
//        [controller release];
//        [self.myRequest clearDelegatesAndCancel];
        
        [myRequest clearDelegatesAndCancel];
        self.myRequest = [ASIHTTPRequest requestWithURL:[NetURL cpThreeUserName:self.userName]];
        [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [myRequest setDelegate:self];
        [myRequest setDidFinishSelector:@selector(useridRequestDidFinishSelector:)];
        [myRequest setNumberOfTimesToRetryOnTimeout:2];
        [myRequest startAsynchronous];
    }
    else if(buttonIndex == 4)//@他的资料
    {
//        [[Info getInstance] setHimId:self.userName];
        ProfileViewController *followeesController = [[ProfileViewController alloc] init];
        followeesController.himNickName = self.userNic_name;
        [self.navigationController pushViewController:followeesController animated:YES];
        [followeesController release];
    }
    else//取消
    {
        
    }
}
//获取用户id
-(void)useridRequestDidFinishSelector:(ASIHTTPRequest *)request
{
    if (request) {
        NSString * str = [request responseString];
        
        NSDictionary * dict = [str JSONValue];
        NSString * codestr = [dict objectForKey:@"code"];
        if([codestr isEqualToString:@"1"]){
            NSString * useridst = [dict objectForKey:@"userid"];
            self.PKUserId = useridst;
            TwitterMessageViewController *controller = [[TwitterMessageViewController alloc] init];
            controller.userID = PKUserId;
            controller.title = @"他的微博";
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
            
        }
        else {
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"获取失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            [alert show];
            [alert release];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    