//
//  PKMyRecordViewController.m
//  caibo
//
//  Created by cp365dev6 on 15/1/23.
//
//

#import "PKMyRecordViewController.h"

@interface PKMyRecordViewController ()

@end

@implementation PKMyRecordViewController

@synthesize httpRequest,allRecord;
@synthesize totalPay,totalGet,totalScore,userName,userNickName;
@synthesize mRefreshView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadIphoneView];
}
-(void)loadIphoneView
{
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = leftItem;
    //    self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30)];
    self.CP_navigation.title = @"我的战绩";
    if(self.userName)
    {
        self.CP_navigation.title = @"TA的战绩";
    }
    //    self.mainView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgimage.backgroundColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
    bgimage.userInteractionEnabled = YES;
    [self.mainView addSubview:bgimage];
    [bgimage release];
    
    dateArray = [[NSMutableArray alloc]initWithCapacity:0];
    zongArray = [[NSMutableArray alloc]initWithCapacity:0];
    moreArym = [[NSMutableArray alloc]initWithCapacity:0];
    requestPage = 2;
    
    [self loadHeaderView];
    
    UIView *headView = [[UIView alloc]init];
    headView.frame = CGRectMake(0, 0, bgimage.frame.size.width, 97.5);
    headView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [bgimage addSubview:headView];
    [headView release];
    
//    NSString *name = [[Info getInstance] nickName];
    NSString *name = @"";
    
    if(self.userNickName)
    {
        name = self.userNickName;
    }
    else
    {
        name = [[Info getInstance] nickName];
    }
    
    userNmaeLab = [[UILabel alloc]init];
    userNmaeLab.frame = CGRectMake(15, 10, 200, 30);
    userNmaeLab.backgroundColor = [UIColor clearColor];
    userNmaeLab.text = name;
    userNmaeLab.font = [UIFont systemFontOfSize:15];
    userNmaeLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [headView addSubview:userNmaeLab];
    [userNmaeLab release];
    payMoneyLab = [[UILabel alloc]init];
    payMoneyLab.frame = CGRectMake(15, 40, (headView.frame.size.width - 30)/2, 25);
    payMoneyLab.backgroundColor = [UIColor clearColor];
    payMoneyLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    payMoneyLab.text = @"累计模拟花费--元";
    payMoneyLab.font = [UIFont systemFontOfSize:12];
    [headView addSubview:payMoneyLab];
    [payMoneyLab release];
    getMoneyLab = [[UILabel alloc]init];
    getMoneyLab.frame = CGRectMake(headView.frame.size.width/2, 40, (headView.frame.size.width - 30)/2, 25);
    getMoneyLab.backgroundColor = [UIColor clearColor];
    getMoneyLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    getMoneyLab.text = @"累计模拟中奖--元";
    getMoneyLab.font = [UIFont systemFontOfSize:12];
    [headView addSubview:getMoneyLab];
    [getMoneyLab release];
    gainMoneyLab = [[ColorView alloc] init];
    gainMoneyLab.frame = CGRectMake(14, 65, 200, 35);
    gainMoneyLab.textColor = [UIColor blackColor];
    gainMoneyLab.font = [UIFont systemFontOfSize:12];
    gainMoneyLab.colorfont = [UIFont boldSystemFontOfSize:20];
    gainMoneyLab.backgroundColor = [UIColor clearColor];
    gainMoneyLab.text = @"获得积分<-->";
    gainMoneyLab.changeColor = [UIColor colorWithRed:25/255.0 green:122/255.0 blue:228/255.0 alpha:1];
    [headView addSubview:gainMoneyLab];
    [gainMoneyLab release];
    
//    myTableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 97.5, bgimage.frame.size.width, bgimage.frame.size.height - 97.5) style:UITableViewStylePlain] autorelease];
    myTableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, bgimage.frame.size.width, bgimage.frame.size.height) style:UITableViewStylePlain] autorelease];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    //    myTableView.hidden = YES;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.tableHeaderView = headView;
    
    [bgimage addSubview:myTableView];
    
    if (!mRefreshView)
    {
        UITableView *mTableView = myTableView;
        CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -(mTableView.frame.size.height), mTableView.frame.size.width, mTableView.frame.size.height)];
        headerview.backgroundColor = [UIColor clearColor];
        self.mRefreshView = headerview;
        mRefreshView.delegate = self;
        [myTableView addSubview:mRefreshView];
        [headerview release];
    }
    [mRefreshView refreshLastUpdatedDate];
//    [self CBRefreshTableHeaderDidTriggerRefresh:mRefreshView];
    
    wujiluView = [[UIView alloc]init];
    wujiluView.backgroundColor = [UIColor clearColor];
    wujiluView.hidden = YES;
    wujiluView.frame = CGRectMake(0, 97.5, bgimage.frame.size.width, bgimage.frame.size.height - 97.5);
    [bgimage addSubview:wujiluView];
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
    wujiluLab.text = @"没有您的参赛记录";
    wujiluLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    wujiluLab.font = [UIFont systemFontOfSize:14];
    wujiluLab.textAlignment = NSTextAlignmentCenter;
    [wujiluView addSubview:wujiluLab];
    [wujiluLab release];
    
    [self getMyRecordRequest];
    
}
-(void)loadHeaderView
{
    headView2 = [[UIView alloc]init];
    headView2.frame = CGRectMake(0, 0, 320, 97.5);
    headView2.hidden = YES;
    headView2.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [self.mainView addSubview:headView2];
    [headView2 release];
    UILabel *userNmae = [[UILabel alloc]init];
    userNmae.frame = CGRectMake(15, 10, 200, 30);
    userNmae.backgroundColor = [UIColor clearColor];
    NSString *name = @"";
    
    if(self.userNickName)
    {
        name = self.userNickName;
    }
    else
    {
        name = [[Info getInstance] nickName];
    }
    userNmae.text = name;
    userNmae.font = [UIFont systemFontOfSize:15];
    userNmae.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [headView2 addSubview:userNmae];
    [userNmae release];
    UILabel *payMoney = [[UILabel alloc]init];
    payMoney.frame = CGRectMake(15, 40, (headView2.frame.size.width - 30)/2, 25);
    payMoney.backgroundColor = [UIColor clearColor];
    payMoney.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    payMoney.text = @"累计模拟花费--元";
    payMoney.font = [UIFont systemFontOfSize:12];
    [headView2 addSubview:payMoney];
    [payMoney release];
    UILabel *getMoney = [[UILabel alloc]init];
    getMoney.frame = CGRectMake(headView2.frame.size.width/2, 40, (headView2.frame.size.width - 30)/2, 25);
    getMoney.backgroundColor = [UIColor clearColor];
    getMoney.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    getMoney.text = @"累计模拟中奖--元";
    getMoney.font = [UIFont systemFontOfSize:12];
    [headView2 addSubview:getMoney];
    [getMoney release];
    ColorView *gainMoney = [[ColorView alloc] init];
    gainMoney.frame = CGRectMake(14, 65, 200, 35);
    gainMoney.textColor = [UIColor blackColor];
    gainMoney.font = [UIFont systemFontOfSize:12];
    gainMoney.colorfont = [UIFont boldSystemFontOfSize:20];
    gainMoney.backgroundColor = [UIColor clearColor];
    gainMoney.text = @"获得积分<-->";
    gainMoney.changeColor = [UIColor colorWithRed:25/255.0 green:122/255.0 blue:228/255.0 alpha:1];
    [headView2 addSubview:gainMoney];
    [gainMoney release];
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
    
    [self getMyRecordRequest];
    
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
    UITableView *mTableView = myTableView;
    isLoading = NO;
    listMoreCell.userInteractionEnabled = YES;
    requestPage = 2;
    [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:mTableView];
}

-(void)getMyRecordRequest
{
//    if (!loadView) {
//        loadView = [[UpLoadView alloc] init];
//    }
//    
//    caiboAppDelegate *appDelegate = (caiboAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [appDelegate.window addSubview:loadView];
    
    NSString *name = nil;
    if(self.userName)
    {
        name = self.userName;
    }
    else
    {
        name = [[Info getInstance] userName];
    }
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] req_GetPKMyRecordUser:name recordType:@"0" caizhongId:@"201" pageNum:1 pageCount:20];
    SEL Finish = @selector(getMyRecordRequestFinish:);
    [self.httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:Finish];
    [httpRequest setDidFailSelector:@selector(getMyRecordRequestFail:)];
    [httpRequest startAsynchronous];
}
-(void)getMyRecordRequestFail:(ASIHTTPRequest *)request
{
//    if (loadView) {
//        [loadView stopRemoveFromSuperview];
//        loadView = nil;
//    }
    [self dismissRefreshTableHeaderView];
}
-(void)getMyRecordRequestFinish:(ASIHTTPRequest *)request
{
//    if (loadView) {
//        [loadView stopRemoveFromSuperview];
//        loadView = nil;
//    }
    [self dismissRefreshTableHeaderView];
    
    if ([request responseData]) {
        
        GC_PKMyRecordList *br = [[GC_PKMyRecordList alloc]initWithResponseData:request.responseData WithRequest:request];
        
//        if(self.userNickName)
//        {
//            userNmaeLab.text = self.userNickName;
//        }
//        else
//        {
//            NSString *name = [[Info getInstance] nickName];
//            userNmaeLab.text = name;
//        }
        
        if(br.totalPay && [br.totalPay integerValue])
        {
            payMoneyLab.text = [NSString stringWithFormat:@"累计模拟花费%@元",br.totalPay];
        }
        else
        {
            payMoneyLab.text = [NSString stringWithFormat:@"累计模拟花费--元"];
        }
        if(br.totalGet && [br.totalGet integerValue])
        {
            getMoneyLab.text = [NSString stringWithFormat:@"累计模拟中奖%@元",br.totalGet];
        }
        else
        {
            getMoneyLab.text = [NSString stringWithFormat:@"累计模拟中奖--元"];
        }
        if(br.totalScore && [br.totalScore integerValue])
        {
            gainMoneyLab.text = [NSString stringWithFormat:@"获得积分 <%@>",br.totalScore];
        }
        else
        {
            gainMoneyLab.text = [NSString stringWithFormat:@"获得积分 <-->"];
        }
        
        
        
        self.totalPay = br.totalPay;
        self.totalGet = br.totalGet;
        self.totalScore = br.totalScore;
        
        GC_BetRecord *br2 = [[GC_BetRecord alloc]init];
        if(!br2.brInforArray)
            br2.brInforArray = [[NSMutableArray alloc]initWithCapacity:0];
        br2.returnId = br.returnId;
        br2.systemTime = br.systemTime;
        br2.reRecordNum = br.numCount;
        br2.totalPage = br.pageCount;
        requestTotalPage = br.pageCount;
        NSLog(@"返回消息id %i", (int)br2.returnId);
        NSLog(@"系统时间 %@",br2.systemTime);
        NSLog(@"当前页条数 %ld",(long)br2.reRecordNum);
        NSLog(@"总页数 %ld",(long)br2.totalPage);
        for(PKMyRecordList *pkr in br.listData)
        {
            BetRecordInfor *brInfor = [[BetRecordInfor alloc]init];
            //            NSLog(@"投注时间 %@", brInfor.betDate);
            //            NSLog(@"彩种名称 %@", brInfor.lotteryName);
            //            NSLog(@"彩种编号 %@", brInfor.lotteryNum);
            //            NSLog(@"玩法 %@", brInfor.mode);
            //            NSLog(@"投注金额 %@", brInfor.betAmount);
            //            NSLog(@"方案状态 %@", brInfor.programState);
            //            NSLog(@"期号 %@", brInfor.issue);
            //            NSLog(@"投注方式 %@", brInfor.betStyle);
            //            NSLog(@"购买方式 %@", brInfor.buyStyle);
            //            NSLog(@"中奖状态 %@", brInfor.awardState);
            //            NSLog(@"方案编号 %@", brInfor.programNumber);
            //            NSLog(@"保密类型 %@", brInfor.baomiType);
            //            NSLog(@"中奖金额 %@", brInfor.lotteryMoney);
            //            NSLog(@"中奖金额 %@", brInfor.lotteryMoney);
            //            NSLog(@"预留id %@", brInfor.yuliustring);
            ////            [self.brInforArray addObject:brInfor];
            //            NSLog(@"方案编号 %@",pkx.fanganNum);
            //            NSLog(@"创建时间 %@",pkx.createTime);
            //            NSLog(@"期次 %@",pkx.qici);
            //            NSLog(@"投注内容 %@",pkx.betContent);
            //            NSLog(@"过关方式 %@",pkx.passType);
            //            NSLog(@"投注金额 %@",pkx.betMoney);
            //            NSLog(@"中奖金额 %@",pkx.getMoney);
            //            NSLog(@"获得积分 %@",pkx.getScore);
            //            NSLog(@"虚拟收益 %@",pkx.winMoney);
            //            NSLog(@"中奖状态 %@",pkx.statue);
            //            NSLog(@"预留字段 %@",pkx.moreData);
            
            brInfor.betDate = pkr.createTime;
            brInfor.programNumber = pkr.fanganNum;
            brInfor.issue = pkr.qici;
            brInfor.betStyle = pkr.betContent;
            brInfor.buyStyle = pkr.passType;
            brInfor.betAmount = pkr.betMoney;
            brInfor.lotteryMoney = pkr.getMoney;
            //            brInfor.betAmount = pkr.getScore;
            //            brInfor.betAmount = pkr.winMoney;
            brInfor.awardState = pkr.statue;
            brInfor.lotteryName = @"竞彩足球";
            brInfor.programState = @"1";
            brInfor.yuliustring = pkr.moreData;
            [br2.brInforArray addObject:brInfor];
            
        }
        
        
        
        
        
        
        
        
        
        self.allRecord = br2;
        
        //        self.allRecord.curPage =br.curPage;
        //        self.allRecord.numCount = br.numCount;
        //        self.allRecord.pageCount = br.pageCount;
        self.allRecord.curPage =br2.curPage;
        self.allRecord.totalPage = br2.totalPage;
        //        isAllRefresh = NO;
        //        isLoading = NO;
        
        [self seqencingFunc:self.allRecord.brInforArray];
        [moreArym removeAllObjects];
        [moreArym addObjectsFromArray:self.allRecord.brInforArray];
        
        if(br.listData.count != 0)
            [myTableView reloadData];
        //			[myTableView reloadData];
        //        [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
        if (self.allRecord.brInforArray.count == 0) {
            
            //            UIView *viewJia=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 480, 520)];
            //            // viewJia.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bgn.png"]];
            //            viewJia.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
            //
            //            // 480-800.png
            //            UIImageView *imageJia=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button-100_1.png"]];
            //            imageJia.frame=CGRectMake(60, 60, 200, 200);
            //
            //            UILabel *labelJia=[[UILabel alloc]initWithFrame:CGRectMake(60, 270, 200, 30)];
            //            labelJia.text=@"最近三个月无相关记录";
            //            labelJia.backgroundColor=[UIColor clearColor];
            //            labelJia.font=[UIFont systemFontOfSize:20.0];
            //            labelJia.textColor=[UIColor grayColor];
            //            [viewJia addSubview:imageJia];
            //            [viewJia addSubview:labelJia];
            //            [myTableView addSubview:viewJia];
            //            [viewJia release];
            //            [imageJia release];
            //            [labelJia release];
            
            wujiluView.hidden = NO;
            myTableView.hidden = YES;
            headView2.hidden = NO;
            
            
            //  [moreCell setInfoText:@"最近3个月无相关记录!"];
        }
        else
        {
            wujiluView.hidden = YES;
            myTableView.hidden = NO;
            headView2.hidden = YES;
        }
        
        
        [br release];
        
        
        
        [httpRequest clearDelegatesAndCancel];
        
        [self setHttpRequest:[ASIHTTPRequest requestWithURL:[NetURL CBusersMailList:[[Info getInstance]userId]
                                                                            userId2:@"0"
                                                                            pageNum:@"1"
                                                                           pageSize:@"1"
                                                                           mailType:@"1"
                                                                               mode:@"1"]]];
        
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(clearZhongjiang:)];
        [httpRequest setNumberOfTimesToRetryOnTimeout:2];
        [httpRequest startAsynchronous];
    }
    
}
- (void)seqencingFunc:(NSMutableArray *)arraybrin{
    if ([arraybrin count] == 0) {//如果为空 return
        return;
    }
    
    //取出第一个当参数
    BetHeRecordInfor *brInfor = [arraybrin objectAtIndex:0];
    
    
    [dateArray removeAllObjects];
    
    if ([brInfor.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的
        NSArray * timearr = [brInfor.betDate componentsSeparatedByString:@" "];
        if ([timearr count] >= 1) {
            [dateArray addObject:[timearr objectAtIndex:0]];
        }
        
        
    }else{//不带空格的
        [dateArray addObject:brInfor.betDate];
    }
    
    //拿第一个和其他的去比较
    for (int i = 0; i < [arraybrin count]; i++) {
        BOOL zhongjie = NO;
        for (int j = 0; j < [dateArray count]; j++) {
            
            NSString * timestring = [dateArray objectAtIndex:j];
            BetHeRecordInfor *brIn = [arraybrin objectAtIndex:i];
            
            if ([brIn.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的
                
                NSArray * timearr = [brIn.betDate componentsSeparatedByString:@" "];
                if ([timearr count] >= 1) {
                    if ([[timearr objectAtIndex:0] isEqualToString:timestring]) {
                        //                    [dateArray addObject:[timearr objectAtIndex:0]];
                        zhongjie = YES;
                        break;
                    }
                }
                
                
            }else{  //不带空格的
                
                if ([brIn.betDate isEqualToString:timestring]) {
                    //                    [dateArray addObject:brIn.betDate];
                    zhongjie = YES;
                    break;
                }
                
            }
        }
        if (!zhongjie) {
            BetHeRecordInfor *brIn = [arraybrin objectAtIndex:i];
            NSLog(@"%@",brIn.betDate);
            if ([brIn.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的
                NSArray * timearr = [brIn.betDate componentsSeparatedByString:@" "];
                if ([timearr count] >=1) {
                    [dateArray addObject:[timearr objectAtIndex:0]];
                }
                
                
            }else{
                [dateArray addObject:brIn.betDate];
            }
        }
        
    }
    
    
    NSLog(@"datearray = %@", dateArray);
    [self zongArrayFunc:arraybrin];
}
- (void)zongArrayFunc:(NSMutableArray *)arraybrin{
    [zongArray removeAllObjects];
    for (int i = 0; i < [dateArray count]; i++) {
        NSMutableArray * danarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int j = 0; j < [arraybrin count]; j++) {
            NSString * timestring = [dateArray objectAtIndex:i];
            BetHeRecordInfor *brIn = [arraybrin objectAtIndex:j];
            
            if ([brIn.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的
                
                NSArray * timearr = [brIn.betDate componentsSeparatedByString:@" "];
                if ([[timearr objectAtIndex:0] isEqualToString:timestring]) {
                    
                    [danarray addObject:brIn];
                    
                }
                
            }else{  //不带空格的
                
                if ([brIn.betDate isEqualToString:timestring]) {
                    
                    [danarray addObject:brIn];
                    
                }
                
            }
        }
        [zongArray addObject:danarray];
        [danarray release];
    }
}
- (void)clearZhongjiang:(ASIHTTPRequest*)request {
}
//加载更多
-(void)sendMoreListRequest
{
    NSString *name = nil;
    if(self.userName)
    {
        name = self.userName;
    }
    else
    {
        name = [[Info getInstance] userName];
    }

    NSMutableData *postData = [[GC_HttpService sharedInstance] req_GetPKMyRecordUser:name recordType:@"0" caizhongId:@"201" pageNum:requestPage pageCount:20];
    SEL Finish = @selector(getMoreRecordRequestFinish:);
    [self.httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:Finish];
    [httpRequest setDidFailSelector:@selector(getMoreRecordRequestFail:)];
    [httpRequest startAsynchronous];
}
-(void)getMoreRecordRequestFinish:(ASIHTTPRequest *)request
{
    [listMoreCell spinnerStopAnimating];
    if ([request responseData]) {
        requestPage ++;
        GC_PKMyRecordList *br = [[GC_PKMyRecordList alloc]initWithResponseData:request.responseData WithRequest:request];

//        NSString *name = [[Info getInstance] nickName];
//        userNmaeLab.text = name;
//        payMoneyLab.text = [NSString stringWithFormat:@"累计模拟花费%@元",br.totalPay];
//        getMoneyLab.text = [NSString stringWithFormat:@"累计模拟中奖%@元",br.totalGet];
//        gainMoneyLab.text = [NSString stringWithFormat:@"获得积分 <%@>",br.totalScore];
        

        self.totalPay = br.totalPay;
        self.totalGet = br.totalGet;
        self.totalScore = br.totalScore;

        GC_BetRecord *br2 = [[GC_BetRecord alloc]init];
        if(!br2.brInforArray)
            br2.brInforArray = [[NSMutableArray alloc]initWithCapacity:0];
        br2.returnId = br.returnId;
        br2.systemTime = br.systemTime;
        br2.reRecordNum = br.numCount;
        br2.totalPage = br.pageCount;
        requestTotalPage = br.pageCount;
        NSLog(@"返回消息id %i", (int)br2.returnId);
        NSLog(@"系统时间 %@",br2.systemTime);
        NSLog(@"当前页条数 %ld",(long)br2.reRecordNum);
        NSLog(@"总页数 %ld",(long)br2.totalPage);
        for(PKMyRecordList *pkr in br.listData)
        {
            BetRecordInfor *brInfor = [[BetRecordInfor alloc]init];
            //            NSLog(@"投注时间 %@", brInfor.betDate);
            //            NSLog(@"彩种名称 %@", brInfor.lotteryName);
            //            NSLog(@"彩种编号 %@", brInfor.lotteryNum);
            //            NSLog(@"玩法 %@", brInfor.mode);
            //            NSLog(@"投注金额 %@", brInfor.betAmount);
            //            NSLog(@"方案状态 %@", brInfor.programState);
            //            NSLog(@"期号 %@", brInfor.issue);
            //            NSLog(@"投注方式 %@", brInfor.betStyle);
            //            NSLog(@"购买方式 %@", brInfor.buyStyle);
            //            NSLog(@"中奖状态 %@", brInfor.awardState);
            //            NSLog(@"方案编号 %@", brInfor.programNumber);
            //            NSLog(@"保密类型 %@", brInfor.baomiType);
            //            NSLog(@"中奖金额 %@", brInfor.lotteryMoney);
            //            NSLog(@"中奖金额 %@", brInfor.lotteryMoney);
            //            NSLog(@"预留id %@", brInfor.yuliustring);
            ////            [self.brInforArray addObject:brInfor];
            //            NSLog(@"方案编号 %@",pkx.fanganNum);
            //            NSLog(@"创建时间 %@",pkx.createTime);
            //            NSLog(@"期次 %@",pkx.qici);
            //            NSLog(@"投注内容 %@",pkx.betContent);
            //            NSLog(@"过关方式 %@",pkx.passType);
            //            NSLog(@"投注金额 %@",pkx.betMoney);
            //            NSLog(@"中奖金额 %@",pkx.getMoney);
            //            NSLog(@"获得积分 %@",pkx.getScore);
            //            NSLog(@"虚拟收益 %@",pkx.winMoney);
            //            NSLog(@"中奖状态 %@",pkx.statue);
            //            NSLog(@"预留字段 %@",pkx.moreData);

            brInfor.betDate = pkr.createTime;
            brInfor.programNumber = pkr.fanganNum;
            brInfor.issue = pkr.qici;
            brInfor.betStyle = pkr.betContent;
            brInfor.buyStyle = pkr.passType;
            brInfor.betAmount = pkr.betMoney;
            brInfor.lotteryMoney = pkr.getMoney;
            //            brInfor.betAmount = pkr.getScore;
            //            brInfor.betAmount = pkr.winMoney;
            brInfor.awardState = pkr.statue;
            brInfor.lotteryName = @"竞彩足球";
            brInfor.programState = @"1";
            brInfor.yuliustring = pkr.moreData;
            [br2.brInforArray addObject:brInfor];
            
            [moreArym addObject:brInfor];
        }

        if([br2.brInforArray count] == 0){
            listMoreCell.type =MSG_TYPE_LOAD_NODATA;
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"加载完毕"];
            [listMoreCell spinnerStopAnimating];
            [listMoreCell setInfoText:@"只能查询近3个月的相关记录!"];
            listMoreCell.userInteractionEnabled = NO;
        }


        self.allRecord = br2;

        self.allRecord.curPage =br2.curPage;
        self.allRecord.totalPage = br2.totalPage;

//        [self seqencingMoreFunc:self.allRecord.brInforArray];
        [self seqencingMoreFunc:moreArym];

        if(br.listData.count != 0)
            [myTableView reloadData];
//        if (self.allRecord.brInforArray.count == 0) {
//
//            wujiluView.hidden = NO;
//            myTableView.hidden = YES;
//
//        }


        [br release];



        [httpRequest clearDelegatesAndCancel];

        [self setHttpRequest:[ASIHTTPRequest requestWithURL:[NetURL CBusersMailList:[[Info getInstance]userId]
                                                                            userId2:@"0"
                                                                            pageNum:@"1"
                                                                           pageSize:@"1"
                                                                           mailType:@"1"
                                                                               mode:@"1"]]];

        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest setDidFinishSelector:@selector(clearMoreZhongjiang:)];
        [httpRequest setNumberOfTimesToRetryOnTimeout:2];
        [httpRequest startAsynchronous];
    }
}
-(void)getMoreRecordRequestFail:(ASIHTTPRequest *)request
{
    [listMoreCell spinnerStopAnimating];
}
- (void)seqencingMoreFunc:(NSMutableArray *)arraybrin{
    if ([arraybrin count] == 0) {//如果为空 return
        return;
    }

    //取出第一个当参数
    BetHeRecordInfor *brInfor = [arraybrin objectAtIndex:0];


    [dateArray removeAllObjects];

    if ([brInfor.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的
        NSArray * timearr = [brInfor.betDate componentsSeparatedByString:@" "];
        if ([timearr count] >= 1) {
            [dateArray addObject:[timearr objectAtIndex:0]];
        }


    }else{//不带空格的
        [dateArray addObject:brInfor.betDate];
    }

    //拿第一个和其他的去比较
    for (int i = 0; i < [arraybrin count]; i++) {
        BOOL zhongjie = NO;
        for (int j = 0; j < [dateArray count]; j++) {

            NSString * timestring = [dateArray objectAtIndex:j];
            BetHeRecordInfor *brIn = [arraybrin objectAtIndex:i];

            if ([brIn.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的

                NSArray * timearr = [brIn.betDate componentsSeparatedByString:@" "];
                if ([timearr count] >= 1) {
                    if ([[timearr objectAtIndex:0] isEqualToString:timestring]) {
                        //                    [dateArray addObject:[timearr objectAtIndex:0]];
                        zhongjie = YES;
                        break;
                    }
                }


            }else{  //不带空格的

                if ([brIn.betDate isEqualToString:timestring]) {
                    //                    [dateArray addObject:brIn.betDate];
                    zhongjie = YES;
                    break;
                }

            }
        }
        if (!zhongjie) {
            BetHeRecordInfor *brIn = [arraybrin objectAtIndex:i];
            NSLog(@"%@",brIn.betDate);
            if ([brIn.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的
                NSArray * timearr = [brIn.betDate componentsSeparatedByString:@" "];
                if ([timearr count] >=1) {
                    [dateArray addObject:[timearr objectAtIndex:0]];
                }


            }else{
                [dateArray addObject:brIn.betDate];
            }
        }

    }


    NSLog(@"datearray = %@", dateArray);
    [self zongArrayMoreFunc:arraybrin];
}
- (void)zongArrayMoreFunc:(NSMutableArray *)arraybrin{
    [zongArray removeAllObjects];
    for (int i = 0; i < [dateArray count]; i++) {
        NSMutableArray * danarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int j = 0; j < [arraybrin count]; j++) {
            NSString * timestring = [dateArray objectAtIndex:i];
            BetHeRecordInfor *brIn = [arraybrin objectAtIndex:j];

            if ([brIn.betDate rangeOfString:@" "].location != NSNotFound) {//带空格的

                NSArray * timearr = [brIn.betDate componentsSeparatedByString:@" "];
                if ([[timearr objectAtIndex:0] isEqualToString:timestring]) {

                    [danarray addObject:brIn];

                }

            }else{  //不带空格的

                if ([brIn.betDate isEqualToString:timestring]) {

                    [danarray addObject:brIn];

                }

            }
        }
        [zongArray addObject:danarray];
        [danarray release];
    }
}
- (void)clearMoreZhongjiang:(ASIHTTPRequest*)request {
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString * cellID = @"cell";
    //    PKMyRecordTableViewCell * cell = (PKMyRecordTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    //    if (!cell)
    //    {
    //        cell = [[[PKMyRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    //    }
    //    cell.moneyLab.text = @"";
    //    cell.zhongjiangIma.image = nil;
    //    cell.caizhongLab.text = @"竞彩足球";
    //    cell.payLab.text = @"模拟花费<24>元";
    ////    cell.statueLab.text = @"等待开奖";
    //    cell.wanfaLab.text = @"PK赛胜平负";
    //    cell.qihaoLab.text = @"20150123期";
    //    cell.statueLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    //    if(indexPath.section == 0 && indexPath.row == 0)
    //    {
    //        cell.statueLab.text = @"等待开奖";
    //    }
    //    else if(indexPath.section == 0 && indexPath.row == 1)
    //    {
    //        cell.moneyLab.text = @"23";
    //        cell.statueLab.text = @"元";
    //        cell.statueLab.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    //        cell.zhongjiangIma.image = [UIImage imageNamed:@"PKzhanjiwin.png"];
    //    }
    //    else
    //    {
    //        cell.statueLab.text = @"未中奖";
    //    }
    
//    if(indexPath.row == [[zongArray objectAtIndex:indexPath.section] count] && indexPath.section == zongArray.count-1)
    if(indexPath.section == zongArray.count)
    {
        static NSString *CellIdentifier = @"MoreLoadCell";
        
        MoreLoadCell *cell = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell==nil){
            cell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (listMoreCell==nil) {
            listMoreCell = cell;
        }
        [listMoreCell setInfoText:@"加载更多"];
        if(!isLoading && requestPage <= requestTotalPage)
        {
            if([tableView numberOfRowsInSection:indexPath.section] > 1)
            {
                //                [cell spinnerStartAnimating];
                //
                //                [self performSelector:@selector(sendMoreListRequest) withObject:nil afterDelay:.5];
            }
        }
        
        return cell;
    }
    else
    {
        NSMutableArray *array = nil;
        if ([zongArray count] > 0 && indexPath.section < [zongArray count]) {
            
            array =  [zongArray objectAtIndex:indexPath.section];//self.allRecord.brInforArray;
        }
        
        static NSString * cellID = @"cell";
        PKMyRecordTableViewCell * cell = (PKMyRecordTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell)
        {
            //        cell = [[[PKMyRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
            cell = [[[PKMyRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID withIndex:indexPath withCellCount:[array count]] autorelease];
        }
        
        [cell LoadData:[array objectAtIndex:indexPath.row]];
        
        return cell;
    }
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    UIView *headView = [[UIView alloc]init];
    //    headView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, 34);
    //    headView.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
    //
    //    UILabel *timeLab = [[UILabel alloc]init];
    //    timeLab.backgroundColor = [UIColor clearColor];
    //    timeLab.frame = CGRectMake(15, 13, 100, 21);
    //    timeLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    //    timeLab.font = [UIFont systemFontOfSize:12];
    //    timeLab.text = @"7月30日 星期四";
    //    [headView addSubview:timeLab];
    //    [timeLab release];
    //
    //    return headView;
    if ([zongArray count] > section) {
        UIImageView * returnView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 23)] autorelease];
        returnView.userInteractionEnabled = YES;
        returnView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
        // returnView.image = UIImageGetImageFromName(@"gcheadbg.png");
        UILabel * timelabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, 100, 23)];
        timelabel.textColor = [UIColor colorWithRed:80.0 /255.0 green:80.0/255.0 blue:80.0/255.0 alpha:1];
        timelabel.backgroundColor = [UIColor clearColor];
        timelabel.textAlignment = NSTextAlignmentLeft;
        timelabel.font = [UIFont boldSystemFontOfSize:12];
        
        NSString * weekstr = [NSString stringWithFormat:@"%@ 00:00:01",[dateArray objectAtIndex:section]];
        NSInteger week = [[NSDate dateFromString:weekstr] weekday];
        NSLog(@"week = %ld  str = %@", (long)week,[dateArray objectAtIndex:section]);
        NSString * nianyueri = [dateArray objectAtIndex:section];
        if([nianyueri rangeOfString:@"-"].location != NSNotFound && [nianyueri length]>5){
            NSArray * nianarr = [nianyueri componentsSeparatedByString:@"-"];
            if ([nianarr count] > 2) {
                nianyueri = [NSString stringWithFormat:@"%@月%@日", [nianarr objectAtIndex:1], [nianarr objectAtIndex:2]];
            }
            
        }
        
        if (week == 2) {
            weekstr = @"星期一";
        }else if(week == 3){
            weekstr = @"星期二";
        }else if(week == 4){
            weekstr = @"星期三";
        }else if(week == 5){
            weekstr = @"星期四";
        }else if(week == 6){
            weekstr = @"星期五";
        }else if(week == 7){
            weekstr = @"星期六";
        }else if(week == 1){
            weekstr = @"星期日";
        }
        timelabel.text = [NSString stringWithFormat:@"%@ %@",nianyueri, weekstr];
        [returnView addSubview:timelabel];
        [timelabel release];
        
        
        // 第一根线
        UIImageView * xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 0.5)];
        xian.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [returnView addSubview:xian];
        [xian release];
        
        
        //        // 最后一根线
        //        UIView *cellCuttingLine = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)] autorelease];
        //        cellCuttingLine.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        //        [returnView addSubview:cellCuttingLine];
        
        return returnView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([zongArray count] > section) {
        return 34;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section >= [zongArray count]) {
        return 1;
    }
    return [[zongArray objectAtIndex:section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.allRecord.brInforArray.count > 6)
    {
        return [zongArray count]+1;
    }
    else
    {
        return [zongArray count];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.row == [[zongArray objectAtIndex:indexPath.section] count] && indexPath.section == zongArray.count-1)
    if(indexPath.section == zongArray.count)
    {
        [listMoreCell spinnerStartAnimating];
        
        [self performSelector:@selector(sendMoreListRequest) withObject:nil afterDelay:.5];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        PKDetailViewController *pvc = [[PKDetailViewController alloc]init];
        BetHeRecordInfor *pkr = [[zongArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        pvc.code = pkr.programNumber;
        [self.navigationController pushViewController:pvc animated:YES];
        [pvc release];
    }
}
- (void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    [self.httpRequest clearDelegatesAndCancel];
    self.httpRequest = nil;
//    [loadView release];
    [zongArray release];
    [dateArray release];
    [super dealloc];
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