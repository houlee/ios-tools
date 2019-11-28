//
//  PKDetailViewController.m
//  caibo
//
//  Created by cp365dev6 on 15/2/4.
//
//

#import "PKDetailViewController.h"

@interface PKDetailViewController ()

@end

@implementation PKDetailViewController

@synthesize newUserDataArym,betContentArym,chuanfaArym;
@synthesize zhushu;
@synthesize isNewUser;
@synthesize code;
@synthesize mRefreshView;
@synthesize httpRequest;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self loadIphoneView];
}
-(void)loadIphoneView
{
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = leftItem;
    self.CP_navigation.title = @"方案详情";
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgimage.backgroundColor=[UIColor colorWithRed:239/255.0 green:238/255.0 blue:226/255.0 alpha:1];
    //    bgimage.backgroundColor = [UIColor whiteColor];
    bgimage.userInteractionEnabled = YES;
    [self.mainView addSubview:bgimage];
    [bgimage release];
    
    isKaijiang = NO;
    isZhongjiang = NO;
    
    dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    userDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    xinshouArraym = [[NSMutableArray alloc]initWithCapacity:0];
    bifenArym = [[NSMutableArray alloc]initWithCapacity:0];
    peilvArym = [[NSMutableArray alloc]initWithCapacity:0];
    self.betContentArym = [[NSMutableArray alloc]initWithCapacity:0];
    newUserResultArym = [[NSMutableArray alloc]initWithCapacity:0];
    
    if(isNewUser)
    {
        [self isHelpZhongjiang:nil];
    }
    else
    {
        [self getDetailRequest];
    }
    
    myTableView = [[[UITableView alloc]initWithFrame:bgimage.bounds style:UITableViewStylePlain] autorelease];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bgimage addSubview:myTableView];
    
    if (!mRefreshView)
    {
        UITableView *mTableView = myTableView;
        CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -(mTableView.frame.size.height), mTableView.frame.size.width, mTableView.frame.size.height)];
        headerview.backgroundColor = [UIColor clearColor];
        self.mRefreshView = headerview;
        mRefreshView.delegate = self;
        if(!isNewUser)
        {
            [myTableView addSubview:mRefreshView];
        }
        [headerview release];
    }
    [mRefreshView refreshLastUpdatedDate];
//    [self CBRefreshTableHeaderDidTriggerRefresh:mRefreshView];
    
    headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, 320, 140);
    headerView.backgroundColor = [UIColor clearColor];
    
    //    myTableView.tableHeaderView = headerView;
    //    [bgimage addSubview:headerView];
    
    firstView = [[UIView alloc]init];
    firstView.frame = CGRectMake(0, 0, 320, 70);
    firstView.backgroundColor = [UIColor colorWithRed:250/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    //    firstView.backgroundColor = [UIColor magentaColor];
    [headerView addSubview:firstView];
    
    zhongjiangLab = [[UILabel alloc]init];
    zhongjiangLab.frame = CGRectMake(0, 0, 140, 70);
    zhongjiangLab.backgroundColor = [UIColor clearColor];
    zhongjiangLab.font = [UIFont systemFontOfSize:30];
    zhongjiangLab.textAlignment = NSTextAlignmentRight;
    zhongjiangLab.text = @"中奖";
    zhongjiangLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [firstView addSubview:zhongjiangLab];
    [zhongjiangLab release];
    
    statueLab = [[UILabel alloc]init];
    statueLab.frame = CGRectMake(0, 0, 320, 70);
    statueLab.backgroundColor = [UIColor clearColor];
    //    statueLab.text = @"中奖151.18元";
    statueLab.textAlignment = NSTextAlignmentCenter;
    statueLab.font = [UIFont systemFontOfSize:32];
    statueLab.textColor = [UIColor redColor];
    [firstView addSubview:statueLab];
    
    yuanLab = [[UILabel alloc]init];
    yuanLab.frame = CGRectMake(220, 0, 140, 70);
    yuanLab.backgroundColor = [UIColor clearColor];
    yuanLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    yuanLab.text = @"元";
    yuanLab.font = [UIFont systemFontOfSize:30];
    [firstView addSubview:yuanLab];
    [yuanLab release];
    
    firstView.frame = CGRectMake(0, 0, 320, 0);
    statueLab.frame = CGRectMake(0, 0, 320, 0);
    headerView.frame = CGRectMake(0, 0, 320, 70);
    myTableView.tableHeaderView = headerView;
    
    secondView = [[UIView alloc]init];
    secondView.frame = CGRectMake(0, firstView.frame.size.height, 320, 70);
    secondView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    //    secondView.backgroundColor = [UIColor cyanColor];
    [headerView addSubview:secondView];
    
    UILabel *wanfaLab = [[UILabel alloc]init];
    wanfaLab.backgroundColor = [UIColor clearColor];
    wanfaLab.frame = CGRectMake(15, 15, 100, 20);
    wanfaLab.text = @"PK赛胜平负(过关)";
    wanfaLab.textColor = [UIColor blackColor];
    wanfaLab.font = [UIFont systemFontOfSize:12];
    [secondView addSubview:wanfaLab];
    [wanfaLab release];
    
//    UILabel *danshiLab = [[UILabel alloc]init];
//    danshiLab.frame = CGRectMake(120, 15, 30, 35);
//    danshiLab.numberOfLines = 0;
//    danshiLab.backgroundColor = [UIColor clearColor];
//    danshiLab.text = @"单式过关";
//    danshiLab.textColor = [UIColor blackColor];
//    danshiLab.font = [UIFont systemFontOfSize:12];
//    [secondView addSubview:danshiLab];
//    [danshiLab release];
//    
//    zhushuLab = [[UILabel alloc]init];
//    zhushuLab.frame = CGRectMake(160, 15, 50, 20);
//    zhushuLab.backgroundColor = [UIColor clearColor];
//    zhushuLab.text = [NSString stringWithFormat:@"共%d注",self.zhushu];
//    zhushuLab.textColor = [UIColor blackColor];
//    zhushuLab.font = [UIFont systemFontOfSize:12];
//    [secondView addSubview:zhushuLab];
//    [zhushuLab release];
    
    payLab = [[ColorView alloc]init];
    payLab.frame = CGRectMake(160, 9, 150, 25);
    payLab.backgroundColor = [UIColor clearColor];
    payLab.textColor = [UIColor blackColor];
    payLab.changeColor = [UIColor blueColor];
    payLab.text = [NSString stringWithFormat:@"虚拟花费<%d>元",self.zhushu*2];
    payLab.font = [UIFont systemFontOfSize:12];
    payLab.colorfont = [UIFont systemFontOfSize:20];
    [secondView addSubview:payLab];
    
    UILabel *danshiLab = [[UILabel alloc]init];
    danshiLab.frame = CGRectMake(15, 40, 30, 20);
    danshiLab.numberOfLines = 0;
    danshiLab.backgroundColor = [UIColor clearColor];
    danshiLab.text = @"单式";
    danshiLab.textColor = [UIColor blackColor];
    danshiLab.font = [UIFont systemFontOfSize:12];
    [secondView addSubview:danshiLab];
    [danshiLab release];
    
    zhushuLab = [[UILabel alloc]init];
    zhushuLab.frame = CGRectMake(50, 40, 50, 20);
    zhushuLab.backgroundColor = [UIColor clearColor];
    zhushuLab.text = [NSString stringWithFormat:@"共%d注",self.zhushu];
    zhushuLab.textColor = [UIColor blackColor];
    zhushuLab.font = [UIFont systemFontOfSize:12];
    [secondView addSubview:zhushuLab];
    [zhushuLab release];
    
    chuanfaLab = [[UILabel alloc]init];
    chuanfaLab.frame = CGRectMake(100, 40, 200, 20);
    chuanfaLab.backgroundColor = [UIColor clearColor];
    chuanfaLab.textColor = [UIColor blackColor];
    chuanfaLab.font = [UIFont systemFontOfSize:12];
    [secondView addSubview:chuanfaLab];
    [chuanfaLab release];
    NSString *chuanfaText = @"";
    for(int i=0;i<self.chuanfaArym.count;i++)
    {
        chuanfaText = [chuanfaText stringByAppendingFormat:@"%@ ",[self.chuanfaArym objectAtIndex:i]];
    }
    if(chuanfaText.length > 1)
    {
        chuanfaText = [chuanfaText substringToIndex:chuanfaText.length - 1];
    }
    chuanfaLab.text = chuanfaText;
    
    if(self.chuanfaArym.count == 2)
    {
        isErchuan = YES;
        isSanchuan = YES;
    }
    else
    {
        for (NSString *str in self.chuanfaArym)
        {
            if([str isEqualToString:@"2串1"])
            {
                isErchuan = YES;
            }
            if([str isEqualToString:@"3串1"])
            {
                isSanchuan = YES;
            }
        }
    }
    caiChangci = 0;

    
    footerView = [[UIView alloc]init];
    footerView.frame = CGRectMake(0, 200, 320, 100);
    footerView.backgroundColor = [UIColor clearColor];
    
    //    UIButton *chongtiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    chongtiBtn.frame = CGRectMake(15, 25, 290, 45);
    //    chongtiBtn.backgroundColor = [UIColor clearColor];
    //    [chongtiBtn setBackgroundImage:[[UIImage imageNamed:@"btn_blue_selected.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    //    chongtiBtn.tag = 1;
    //    [chongtiBtn addTarget:self action:@selector(chongtiAction:) forControlEvents:UIControlEventTouchUpInside];
    //    [footerView addSubview:chongtiBtn];
    //
    //    kaijiangLab = [[UILabel alloc]init];
    //    kaijiangLab.frame = chongtiBtn.bounds;
    //    kaijiangLab.backgroundColor = [UIColor clearColor];
    //    kaijiangLab.text = @"点我开奖";
    //    kaijiangLab.textColor = [UIColor whiteColor];
    //    kaijiangLab.font = [UIFont systemFontOfSize:18];
    //    kaijiangLab.textAlignment = NSTextAlignmentCenter;
    //    [chongtiBtn addSubview:kaijiangLab];
    
    
    myTableView.tableFooterView = footerView;
    //    [bgimage addSubview:footerView];
    
    //    [self loadZhongjiangView];
    
    if(isNewUser)
    {
        [self loadKaijiangView];
    }
    else
    {
        [self loadFooterView];
    }
    
}
-(void)loadFooterView
{
    orderNumLab = [[UILabel alloc]init];
    orderNumLab.frame = CGRectMake(10, 10, 300, 25);
    orderNumLab.backgroundColor = [UIColor clearColor];
    orderNumLab.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
    orderNumLab.text = @"订单号    无";
    orderNumLab.font = [UIFont systemFontOfSize:13];
    [footerView addSubview:orderNumLab];
    timeLab = [[UILabel alloc]init];
    timeLab.frame = CGRectMake(10, 35, 300, 25);
    timeLab.backgroundColor = [UIColor clearColor];
    timeLab.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
    timeLab.font = [UIFont systemFontOfSize:13];
    [footerView addSubview:timeLab];
    staLab = [[UILabel alloc]init];
    staLab.frame = CGRectMake(10, 60, 300, 25);
    staLab.backgroundColor = [UIColor clearColor];
    staLab.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
    staLab.font = [UIFont systemFontOfSize:13];
    [footerView addSubview:staLab];
}
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!isNewUser)
        [mRefreshView CBRefreshScrollViewDidScroll:scrollView];
    
}

// 下拉结束停在正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!isNewUser)
        [mRefreshView CBRefreshScrollViewDidEndDragging:scrollView];
}
#pragma mark CBRefreshTableHeaderDelegate
// 刷新发送请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view
{
    if(isNewUser)
    {
        
    }
    else
    {
        isLoading = YES;
        [mRefreshView setState:CBPullRefreshLoading];
        [self getDetailRequest];
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
    UITableView *mTableView = myTableView;
    isLoading = NO;
    [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:mTableView];
}
-(void)getDetailRequest
{
//    if (!loadView) {
//        loadView = [[UpLoadView alloc] init];
//    }
//    
//    caiboAppDelegate *appDelegate = (caiboAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [appDelegate.window addSubview:loadView];
    
    [httpRequest clearDelegatesAndCancel];
    NSMutableData *postData = [[GC_HttpService sharedInstance] req_GetPKDetail:self.code];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(getDetailRequestFinish:)];
    [httpRequest setDidFailSelector:@selector(getDetailRequestFail:)];
    [httpRequest startAsynchronous];
}
-(void)getDetailRequestFinish:(ASIHTTPRequest *)request
{
//    if (loadView) {
//        [loadView stopRemoveFromSuperview];
//        loadView = nil;
//    }
    [self dismissRefreshTableHeaderView];
    
    if ([request responseData])
    {
        GC_PKDetailData *br = [[GC_PKDetailData alloc]initWithResponseData:request.responseData WithRequest:request];
        
        orderNumLab.text = [NSString stringWithFormat:@"订单号  %@",br.orderNum];
        timeLab.text = [NSString stringWithFormat:@"%@",br.orderTime];
//        staLab.text = [NSString stringWithFormat:@"%@",br.statue];
        zhushuLab.text = [NSString stringWithFormat:@"共%@注",br.zhuShu];
        payLab.text = [NSString stringWithFormat:@"虚拟花费<%@>元",br.betMoney];
        NSString *chuanfa = [br.passType stringByReplacingOccurrencesOfString:@"x" withString:@"串"];
        chuanfaLab.text = chuanfa;
        
        [self.betContentArym removeAllObjects];
        for(PKDetailData *pkd in br.listData)
        {
            NSString *betCon = [pkd.betContent stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSString *result = @"";
            NSString *fen = @"";
            NSString *trueOrFlase = @"";
            if(![br.statue isEqualToString:@"等待开奖"])
            {
                result = pkd.raceResult;
//                fen = [NSString stringWithFormat:@"%@:%@",pkd.zhuBifen,pkd.keBifen];
//                NSRange range = [pkd.betContent rangeOfString:result];
//                if(range.location == NSNotFound)
//                {
//                    trueOrFlase = @"false";
//                }
//                else
//                {
//                    trueOrFlase = @"true";
//                }
                if([result isEqualToString:@"取消"])
                {
                    fen = [NSString stringWithFormat:@"%@",pkd.raceResult];
                    trueOrFlase = @"true";
                }
                else
                {
                    fen = [NSString stringWithFormat:@"%@:%@",pkd.zhuBifen,pkd.keBifen];
                    NSRange range = [pkd.betContent rangeOfString:result];
                    if(range.location == NSNotFound)
                    {
                        trueOrFlase = @"false";
                    }
                    else
                    {
                        trueOrFlase = @"true";
                    }
                }
            }
            else
            {
                result = @"-";
                fen = @"-";
                trueOrFlase = @"-";
            }
            NSString *betContent = [NSString stringWithFormat:@"00%@;;%@|0|%@;%@;0;0;-;%@;%@;%@;%@ %@ %@;123123;;%@|%@|%@|-",pkd.changci,pkd.zhuName,pkd.keName,fen,pkd.zhuName,pkd.keName,pkd.raceTime,pkd.shengPei,pkd.pingPei,pkd.fuPei,betCon,result,trueOrFlase];
            [self.betContentArym addObject:betContent];
        }
        if(![br.statue isEqualToString:@"等待开奖"])
        {
            //            br.statue = @"已中奖";
            [self detailKaijiangYesOrNo:br.statue getMoney:br.getMoney];
        }
        
    }
    [myTableView reloadData];
    
}
-(void)getDetailRequestFail
{
//    if (loadView) {
//        [loadView stopRemoveFromSuperview];
//        loadView = nil;
//    }
    [self dismissRefreshTableHeaderView];
}
-(void)detailKaijiangYesOrNo:(NSString *)statue getMoney:(NSString *)money
{
    firstView.frame = CGRectMake(0, 0, 320, 70);
    statueLab.frame = CGRectMake(0, 0, 320, 70);
    secondView.frame = CGRectMake(0, firstView.frame.size.height, 320, 70);
    headerView.frame = CGRectMake(0, 0, 320, 140);
    myTableView.tableHeaderView = headerView;
//    if([statue isEqualToString:@"未中奖"])//未中奖
//    {
//        statueLab.text = @"真遗憾 未中奖";
//    }
//    else if([statue isEqualToString:@"中奖"])//中奖
//    {
//        statueLab.text = [NSString stringWithFormat:@"中奖 %@元",money];
//    }
    float i = [money intValue];
    if(i > 0)//中奖
    {
        statueLab.text = [NSString stringWithFormat:@"%@",money];
        statueLab.textColor = [UIColor redColor];
        zhongjiangLab.text = @"中奖";
        staLab.text = @"中奖";
        yuanLab.text = @"元";
    }
    else //未中奖
    {
        statueLab.text = @"真遗憾 未中奖";
        statueLab.textColor = [UIColor blackColor];
        zhongjiangLab.text = @"";
        staLab.text = @"未中奖";
        yuanLab.text = @"";
    }
    NSString * moneyStr = statueLab.text;
    UIFont * moneyFont = [UIFont systemFontOfSize:32];
    CGSize  moneySize = CGSizeMake(100, 20);
    CGSize moneyLabelSize = [moneyStr sizeWithFont:moneyFont constrainedToSize:moneySize lineBreakMode:UILineBreakModeWordWrap];
    zhongjiangLab.frame = CGRectMake(0, 0, (320 - moneyLabelSize.width)/2, 70);
    yuanLab.frame = CGRectMake(zhongjiangLab.frame.size.width + moneyLabelSize.width, 0, zhongjiangLab.frame.size.width, 70);
}
-(void)isHelpZhongjiang:(NSInteger)index
{
    [xinshouArraym removeAllObjects];
    [peilvArym removeAllObjects];
//    [newUserResultArym removeAllObjects];
    [bifenArym removeAllObjects];
    NSString *str1 = @"周四001;荷甲;赫拉克勒|0|格罗宁根;2:2;0;0;-;赫拉克勒;格罗宁根;2015-02-06 01:30;2.35 3.45 2.45;1877961;;胜 2.12,平 3.55|平|true|-";
    NSString *str2 = @"周四002;非洲杯;赤几内亚|0|加　纳;0:3;0;0;-;赤几内亚;加　纳;2015-02-06 03:00;1.99 3.20 3.20;1952260;;平 3.20,负 3.30|负|true|-";
    //等待开奖
    [userDataArray addObject:str1];
    [userDataArray addObject:str2];
    
    if(self.newUserDataArym)
    {
        int i=0;
        for(GC_BetData * da in self.newUserDataArym)
        {
            i++;
            NSString *shujuLiu;
            if(da.selection1 || da.selection2 || da.selection3)
            {
                NSString *dataTime = [NSString stringWithFormat:@"%@ %@",da.date,da.time];
                NSString *zhudui;
                NSString *kedui;
                NSArray * teamarray = [da.team componentsSeparatedByString:@","];
                if ([teamarray count] > 1) {
                    zhudui = [teamarray objectAtIndex:0];
                    kedui = [teamarray objectAtIndex:1];
                }
                NSString *shengpei = da.but1;
                NSString *pingpei = da.but2;
                NSString *fupei = da.but3;
                NSString *fenshu;
                if(index == 1)
                {
                    if(bifenNum)
                    {
//                        fenshu = [bifenArym objectAtIndex:i-1];
                        fenshu = [newUserResultArym objectAtIndex:i-1];
                    }
                    else
                    {
                        fenshu = @"2:0";
                    }
                }
                else
                {
                    fenshu = @"-";
                }
//                shujuLiu = [NSString stringWithFormat:@"00%d;新手帮助;%@|0|%@;%@;0;0;-;%@;%@;%@;%@ %@ %@;0;;",i,zhudui,kedui,fenshu,zhudui,kedui,dataTime,shengpei,pingpei,fupei];
                shujuLiu = [NSString stringWithFormat:@"00%d;;%@|0|%@;%@;0;0;-;%@;%@;04月25日 00:00;%@ %@ %@;0;;",i,zhudui,kedui,fenshu,zhudui,kedui,shengpei,pingpei,fupei];
                zhusheng = NO;
                ping = NO;
                kesheng = NO;
                if(da.selection1)
                {
                    zhusheng = YES;
                    shujuLiu = [NSString stringWithFormat:@"%@胜 %@\n",shujuLiu,shengpei];
                }
                if(da.selection2)
                {
                    ping = YES;
                    shujuLiu = [NSString stringWithFormat:@"%@平 %@\n",shujuLiu,pingpei];
                }
                if(da.selection3)
                {
                    kesheng = YES;
                    shujuLiu = [NSString stringWithFormat:@"%@负 %@",shujuLiu,fupei];
                }
                
                if(index == 1)
                {
                    if(zhusheng)
                    {
                        bifen = @"2:0";
                        peilv = da.but1;
                    }
                    else if(ping)
                    {
                        bifen = @"1:1";
                        peilv = da.but2;
                    }
                    else
                    {
                        bifen = @"0:1";
                        peilv = da.but3;
                    }
                    [bifenArym addObject:bifen];
                    [peilvArym addObject:peilv];
                    if(zhusheng && da.selection1)
                    {
                        shujuLiu = [NSString stringWithFormat:@"%@|fu|true|-",shujuLiu];
                        caiChangci ++;
                    }
                    else if(!bifenNum)
                    {
                        isZhongjiang = NO;
                        zhongjiangView.hidden = YES;
                        buzhongView.hidden = NO;
                        shujuLiu = [NSString stringWithFormat:@"%@|fu|false|-",shujuLiu];
                    }
                    if(bifenNum)
                    {
                        isZhongjiang = YES;
                        zhongjiangView.hidden = NO;
                        buzhongView.hidden = YES;
                        shujuLiu = [NSString stringWithFormat:@"%@|fu|true|-",shujuLiu];
                    }
                }
                else
                {
                    if(zhusheng)
                    {
                        shujuLiu = [NSString stringWithFormat:@"%@|fu|-|-",shujuLiu];
                    }
                    else
                    {
                        shujuLiu = [NSString stringWithFormat:@"%@|fu|-|-",shujuLiu];
                    }
                }
                [xinshouArraym addObject:shujuLiu];
            }
            
        }
        bifenNum = bifenArym.count;
        [newUserResultArym addObjectsFromArray:bifenArym];
    }
}
-(void)loadZhongjiangView
{
    zhongjiangView = [[UIView alloc]init];
    zhongjiangView.frame = footerView.bounds;
    zhongjiangView.backgroundColor = [UIColor clearColor];
    zhongjiangView.hidden = YES;
    [footerView addSubview:zhongjiangView];
    
    UILabel *zenmesuanLab = [[UILabel alloc]init];
    zenmesuanLab.frame = CGRectMake(15, 15, 290, 20);
    zenmesuanLab.backgroundColor = [UIColor clearColor];
    zenmesuanLab.font = [UIFont systemFontOfSize:15];
    zenmesuanLab.textColor = [UIColor blackColor];
    zenmesuanLab.text = @"奖金怎么算的？";
    [zhongjiangView addSubview:zenmesuanLab];
    [zenmesuanLab release];
    
    jisuanLab = [[UILabel alloc]init];
    jisuanLab.frame = CGRectMake(15, 35, 290, 40);
    jisuanLab.backgroundColor = [UIColor clearColor];
    jisuanLab.numberOfLines = 0;
    jisuanLab.font = [UIFont systemFontOfSize:14];
    //    jisuanLab.text = @"（2.13 x 1.55 x 4.21）x 2 = 151.18元";
    jisuanLab.textColor = [UIColor blackColor];
    [zhongjiangView addSubview:jisuanLab];
    [jisuanLab release];
    
    UIImageView *tishiIma = [[UIImageView alloc]init];
    tishiIma.frame = CGRectMake(15, 70, 290, 55);
    tishiIma.backgroundColor = [UIColor clearColor];
    tishiIma.image = [UIImage imageNamed:@"PKdetailtishi.png"];
    [zhongjiangView addSubview:tishiIma];
    [tishiIma release];
    
    UILabel *tishiLab = [[UILabel alloc]init];
    tishiLab.frame = CGRectMake(0, 5, 290, 50);
    tishiLab.backgroundColor = [UIColor clearColor];
    tishiLab.font = [UIFont systemFontOfSize:15];
    tishiLab.textColor = [UIColor blackColor];
    tishiLab.text = @"现在您都了解了吗？赶快来试试手气吧！";
    [tishiIma addSubview:tishiLab];
    [tishiLab release];
    
    UIButton *guanbiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    guanbiBtn.frame = CGRectMake(15, 140, 125, 40);
    guanbiBtn.backgroundColor = [UIColor clearColor];
    [guanbiBtn setBackgroundImage:[[UIImage imageNamed:@"PKhuiseanniu.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    guanbiBtn.tag = 3;
    [guanbiBtn addTarget:self action:@selector(chongtiAction:) forControlEvents:UIControlEventTouchUpInside];
    [zhongjiangView addSubview:guanbiBtn];
    
    UILabel *guanbiLab = [[UILabel alloc]init];
    guanbiLab.frame = guanbiBtn.bounds;
    guanbiLab.backgroundColor = [UIColor clearColor];
    guanbiLab.text = @"关闭教程";
    guanbiLab.textColor = [UIColor whiteColor];
    guanbiLab.font = [UIFont systemFontOfSize:18];
    guanbiLab.textAlignment = NSTextAlignmentCenter;
    [guanbiBtn addSubview:guanbiLab];
    [guanbiLab release];
    
    UIButton *canjiaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canjiaBtn.frame = CGRectMake(170, 140, 125, 40);
    canjiaBtn.backgroundColor = [UIColor clearColor];
    [canjiaBtn setBackgroundImage:[[UIImage imageNamed:@"btn_blue_selected.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    canjiaBtn.tag = 4;
    [canjiaBtn addTarget:self action:@selector(chongtiAction:) forControlEvents:UIControlEventTouchUpInside];
    [zhongjiangView addSubview:canjiaBtn];
    
    UILabel *canjiaLab = [[UILabel alloc]init];
    canjiaLab.frame = canjiaBtn.bounds;
    canjiaLab.backgroundColor = [UIColor clearColor];
    canjiaLab.text = @"立即参赛";
    canjiaLab.textColor = [UIColor whiteColor];
    canjiaLab.font = [UIFont systemFontOfSize:18];
    canjiaLab.textAlignment = NSTextAlignmentCenter;
    [canjiaBtn addSubview:canjiaLab];
    [canjiaLab release];
    
    
    
}
-(void)loadKaijiangView
{
    buzhongView = [[UIView alloc]init];
    buzhongView.frame = CGRectMake(0, 0, 320, 100);
    buzhongView.backgroundColor = [UIColor clearColor];
    //    buzhongView.hidden = YES;
    [footerView addSubview:buzhongView];
    
    
    UIButton *chongtiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chongtiBtn.frame = CGRectMake(15, 25, 290, 45);
    chongtiBtn.backgroundColor = [UIColor clearColor];
    [chongtiBtn setBackgroundImage:[[UIImage imageNamed:@"btn_blue_selected.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    chongtiBtn.tag = 1;
    [chongtiBtn addTarget:self action:@selector(chongtiAction:) forControlEvents:UIControlEventTouchUpInside];
    [buzhongView addSubview:chongtiBtn];
    
    chongtiLab = [[UILabel alloc]init];
    chongtiLab.frame = chongtiBtn.bounds;
    chongtiLab.backgroundColor = [UIColor clearColor];
    chongtiLab.text = @"时光倒流，重踢一次";
    chongtiLab.hidden = YES;
    chongtiLab.textColor = [UIColor whiteColor];
    chongtiLab.font = [UIFont systemFontOfSize:18];
    chongtiLab.textAlignment = NSTextAlignmentCenter;
    [chongtiBtn addSubview:chongtiLab];
    
    kaijiangLab = [[UILabel alloc]init];
    kaijiangLab.frame = chongtiBtn.bounds;
    kaijiangLab.backgroundColor = [UIColor clearColor];
    kaijiangLab.text = @"点我开奖";
    kaijiangLab.textColor = [UIColor whiteColor];
    kaijiangLab.font = [UIFont systemFontOfSize:18];
    kaijiangLab.textAlignment = NSTextAlignmentCenter;
    [chongtiBtn addSubview:kaijiangLab];
    
}
-(void)erChuan
{
    if(caiChangci == 2)
    {
        isZhongjiang = YES;
        zhongjiangView.hidden = NO;
        buzhongView.hidden = YES;
    }
}
-(void)chongtiAction:(UIButton *)button
{
    NSLog(@"重踢一次");
    
    if(button.tag == 1)
    {
        [self loadZhongjiangView];
        buzhongView.hidden = YES;
        zhongjiangView.hidden = NO;
        isZhongjiang = YES;
        
        [self isHelpZhongjiang:1];
        if(bifenNum && peilvArym.count == 3 && isErchuan)
        {
            [self erChuan];
        }
        firstView.frame = CGRectMake(0, 0, 320, 70);
        statueLab.frame = CGRectMake(0, 0, 320, 70);
        secondView.frame = CGRectMake(0, firstView.frame.size.height, 320, 70);
        headerView.frame = CGRectMake(0, 0, 320, 140);
        myTableView.tableHeaderView = headerView;
        if(isZhongjiang)
        {
            footerView.frame = CGRectMake(0, 200, 320, 200);
            zhongjiangView.frame = footerView.bounds;
            //            statueLab.text = @"中奖 151.18元";
            if(peilvArym.count == 2)
            {
                CGFloat a = [[peilvArym objectAtIndex:0] floatValue];
                CGFloat b = [[peilvArym objectAtIndex:1] floatValue];
                statueLab.text = [NSString stringWithFormat:@"%.2f",a*b*2];
                jisuanLab.text = [NSString stringWithFormat:@"（%@ x %@）x 2 = %.2f元",[peilvArym objectAtIndex:0],[peilvArym objectAtIndex:1],a*b*2];
            }
            else if(peilvArym.count == 3)
            {
                CGFloat a = [[peilvArym objectAtIndex:0] floatValue];
                CGFloat b = [[peilvArym objectAtIndex:1] floatValue];
                CGFloat c = [[peilvArym objectAtIndex:2] floatValue];
                statueLab.text = [NSString stringWithFormat:@"%.2f",a*b*c*2];
                jisuanLab.text = [NSString stringWithFormat:@"（%@ x %@ x %@）x 2 = %.2f",[peilvArym objectAtIndex:0],[peilvArym objectAtIndex:1],[peilvArym objectAtIndex:2],a*b*c*2];
                
                if(isErchuan)
                {
                    NSMutableArray *pl = [NSMutableArray arrayWithArray:peilvArym];
                    NSMutableArray *bf = [NSMutableArray arrayWithArray:bifenArym];
                    CGFloat d = 1;
                    for (int i=0;i<pl.count;i++)
                    {
                        if([[bf objectAtIndex:i] isEqualToString:@"2:0"])
                        {
                            d = [[peilvArym objectAtIndex:i] floatValue]*d;
                        }
                        else
                        {
                            [pl removeObjectAtIndex:i];
                            [bf removeObjectAtIndex:i];
                            i -= 1;
                            
                        }
                    }
                    if(pl.count == 2)
                    {
                        CGFloat x = [[pl objectAtIndex:0] floatValue];
                        CGFloat y = [[pl objectAtIndex:1] floatValue];
                        statueLab.text = [NSString stringWithFormat:@"%.2f",x*y*2];
                        jisuanLab.text = [NSString stringWithFormat:@"（%@ x %@）x 2 = %.2f",[pl objectAtIndex:0],[pl objectAtIndex:1],x*y*2];
                    }
                    else 
                    {
                        CGFloat x = [[peilvArym objectAtIndex:0] floatValue];
                        CGFloat y = [[peilvArym objectAtIndex:1] floatValue];
                        CGFloat z = [[peilvArym objectAtIndex:2] floatValue];
                        CGFloat o = 0;
                        if(isSanchuan)
                        {
                            o = (x*y + y*z + x*z)*2 + x*y*z*2;
                            jisuanLab.text = [NSString stringWithFormat:@"(%@x%@)x2+(%@x%@)x2+(%@x%@)x2+(%@x%@x%@)x2=%.2f",
                                              [peilvArym objectAtIndex:0],
                                              [peilvArym objectAtIndex:1],
                                              [peilvArym objectAtIndex:0],
                                              [peilvArym objectAtIndex:2],
                                              [peilvArym objectAtIndex:1],
                                              [peilvArym objectAtIndex:2],
                                              [peilvArym objectAtIndex:0],
                                              [peilvArym objectAtIndex:1],
                                              [peilvArym objectAtIndex:2],
                                              o];
                        }
                        else
                        {
                            o = (x*y + y*z + x*z)*2;
                            jisuanLab.text = [NSString stringWithFormat:@"(%@x%@)x2+(%@x%@)x2+(%@x%@)x2=%.2f",
                                              [peilvArym objectAtIndex:0],
                                              [peilvArym objectAtIndex:1],
                                              [peilvArym objectAtIndex:0],
                                              [peilvArym objectAtIndex:2],
                                              [peilvArym objectAtIndex:1],
                                              [peilvArym objectAtIndex:2],
                                              o];
                        }
                        statueLab.text = [NSString stringWithFormat:@"%.2f",o];
//                        jisuanLab.text = [NSString stringWithFormat:@"（%@ x %@ x %@）x 2 = %.2f",[peilvArym objectAtIndex:0],[peilvArym objectAtIndex:1],[peilvArym objectAtIndex:2],x*y*z*2];
                    }
                    
                }
                
            }
            zhongjiangLab.text = @"中奖";
            yuanLab.text = @"元";
            statueLab.textColor = [UIColor redColor];
            
        }
        else
        {
            statueLab.text = @"真遗憾 未中奖";
            statueLab.textColor = [UIColor blackColor];
            kaijiangLab.hidden = YES;
            chongtiLab.hidden = NO;
            zhongjiangLab.text = @"";
            yuanLab.text = @"";
        }
        
        NSString * moneyStr = statueLab.text;
        UIFont * moneyFont = [UIFont systemFontOfSize:32];
        CGSize  moneySize = CGSizeMake(100, 20);
        CGSize moneyLabelSize = [moneyStr sizeWithFont:moneyFont constrainedToSize:moneySize lineBreakMode:UILineBreakModeWordWrap];
        zhongjiangLab.frame = CGRectMake(0, 0, (320 - moneyLabelSize.width)/2, 70);
        yuanLab.frame = CGRectMake(zhongjiangLab.frame.size.width + moneyLabelSize.width, 0, zhongjiangLab.frame.size.width, 70);
        
        myTableView.tableFooterView = footerView;
        [myTableView reloadData];
    }
    else if(button.tag == 3 || button.tag == 4)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName;
    PKDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(!cell)
    {
        cell = [[PKDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    if(self.isNewUser)
    {
        [cell LoadData:[xinshouArraym objectAtIndex:indexPath.row] Info:nil LottoryType:nil];
    }
    else
    {
        [cell LoadData:[self.betContentArym objectAtIndex:indexPath.row] Info:nil LottoryType:nil];
    }
    
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.isNewUser)
    {
        return xinshouArraym.count;
    }
    else
    {
        return self.betContentArym.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = nil;
    [newUserResultArym release];
//    [loadView release];
    [xinshouArraym release];
    [dataArray release];
    [userDataArray release];
    [chongtiLab release];
    [kaijiangLab release];
    [zhongjiangView release];
    [buzhongView release];
    [firstView release];
    [secondView release];
    [statueLab release];
    [headerView release];
    [footerView release];
    [bifenArym release];
    [peilvArym release];
    [orderNumLab release];
    [timeLab release];
    [staLab release];
    [payLab release];
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