//
//  PKJoinRaceViewController.m
//  caibo
//
//  Created by cp365dev6 on 15/1/22.
//
//

#import "PKJoinRaceViewController.h"

@interface PKJoinRaceViewController ()

@end

@implementation PKJoinRaceViewController

@synthesize request;
@synthesize dataArray,betArray,listData;
@synthesize beginInfo,beginTime,resultList,sysTimeString,dateString,statue,message,touzhuCode,chuanfaStr,betConStr,betPeilvStr,date;
@synthesize count,returnId,updata;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadIphoneView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadIphoneView
{
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = leftItem;
    //    self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30)];
//    self.CP_navigation.title = @"PK赛";
    //    self.mainView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
    
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
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgimage.backgroundColor=[UIColor colorWithRed:239/255.0 green:238/255.0 blue:226/255.0 alpha:1];
    [self.mainView addSubview:bgimage];
    [bgimage release];
    
    
    //    NSDate*date = [NSDate date];
    //    NSCalendar*calendar = [NSCalendar currentCalendar];
    //    comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)fromDate:date];
    //    NSInteger asd = [comps week];
    //    year = [comps year]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    //    month = [comps month];
    //    day = [comps day];
    //    NSLog(@"%ld",(long)year);
    //    NSLog(@"%ld",(long)month);
    //    NSLog(@"%ld",(long)day);
    //    NSLog(@"%ld",(long)asd);
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    self.date=[dateformatter stringFromDate:senddate];
    
    NSLog(@"%@",date);
    
    [dateformatter release];
    
    
    
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    zhushuDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    cellarray = [[NSMutableArray alloc]initWithCapacity:0];
    chuantype = [[NSMutableArray alloc]initWithCapacity:0];
    chuanfaAry = [[NSMutableArray alloc]initWithCapacity:0];
    chuanfaArym = [[NSMutableArray alloc]initWithCapacity:0];
    qiciArray = [[NSMutableArray alloc]initWithCapacity:0];
    qiciXuanzeArym = [[NSMutableArray alloc]initWithCapacity:0];
    
    for(NSArray *ary in self.betArray)
    {
        [qiciArray addObject:[ary objectAtIndex:0]];
    }
    if(qiciArray.count > 0)
        [qiciXuanzeArym addObject:[qiciArray objectAtIndex:0]];
    
    myTableView = [[CP_CanOpenTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height -44) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:myTableView];
    [myTableView release];
    [self tabBarView];//下面长方块view 确定投注的view
    
    
    wujiluView = [[UIView alloc]init];
    wujiluView.backgroundColor = [UIColor clearColor];
    wujiluView.hidden = YES;
    wujiluView.frame = CGRectMake(0, myTableView.frame.origin.y, 320, myTableView.frame.size.height);
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
    wujiluLab.text = @"暂无比赛信息";
    wujiluLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    wujiluLab.font = [UIFont systemFontOfSize:14];
    wujiluLab.textAlignment = NSTextAlignmentCenter;
    [wujiluView addSubview:wujiluLab];
    [wujiluLab release];
    
    
    titleView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 220, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIButton * titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(10, 5, 180, 34);
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleButton addTarget:self action:@selector(pressTitleButton1:) forControlEvents:UIControlEventTouchDown];
    [titleButton addTarget:self action:@selector(pressTitleButton2:) forControlEvents:UIControlEventTouchCancel];
    
    titleBtnIsCanPress = YES;
    
    titleLabel = [[UILabel alloc] initWithFrame:titleButton.bounds];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    if(self.betArray.count > 0)
    {
        titleLabel.text = [NSString stringWithFormat:@"PK赛%@期",[[self.betArray objectAtIndex:0] objectAtIndex:0]];
    }
    else
    {
        titleLabel.text = @"PK赛";
    }
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    [titleButton addSubview:titleLabel];
    
    sanjiaoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]];
    sanjiaoImageView.frame = CGRectMake(170, 7, 20, 20);
    sanjiaoImageView.tag = 567;
    [titleButton addSubview:sanjiaoImageView];
    
    [titleView addSubview:titleButton];
    self.CP_navigation.titleView = titleView;
    [titleView release];
    
    
    oneLabel.text = [NSString stringWithFormat:@"%d", two];
    twoLabel.text = [NSString stringWithFormat:@"%d", one];
    
    UIImageView *  upimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 26)];
    //    upimageview.backgroundColor = [UIColor clearColor];
    //    upimageview.image = UIImageGetImageFromName(@"zucaititleimage.png");
    upimageview.backgroundColor = [UIColor colorWithRed:16/255.0 green:95/255.0 blue:180/255.0 alpha:1];
    [self.mainView addSubview:upimageview];
    [upimageview release];
    
    UILabel * zhuduiLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 191, 26)];
    zhuduiLab.backgroundColor = [UIColor clearColor];
    zhuduiLab.font = [UIFont systemFontOfSize:13];
    zhuduiLab.textColor = [UIColor colorWithRed:146/255.0 green:204/255.0 blue:245/255.0 alpha:1];
    zhuduiLab.textAlignment = NSTextAlignmentCenter;
    zhuduiLab.text = @"主队";
    [upimageview addSubview:zhuduiLab];
    [zhuduiLab release];
    
    UILabel * keduiLab = [[UILabel alloc] initWithFrame:CGRectMake(192, 0, 128, 26)];
    keduiLab.backgroundColor = [UIColor clearColor];
    keduiLab.font = [UIFont systemFontOfSize:13];
    keduiLab.textColor = [UIColor colorWithRed:146/255.0 green:204/255.0 blue:245/255.0 alpha:1];
    keduiLab.textAlignment = NSTextAlignmentCenter;
    keduiLab.text = @"客队";
    [upimageview addSubview:keduiLab];
    [keduiLab release];
    
    
    UIImageView * shuimage = [[UIImageView alloc] initWithFrame:CGRectMake(191, 6, 1, 14)];
    shuimage.backgroundColor = [UIColor whiteColor];
    [upimageview addSubview:shuimage];
    [shuimage release];
    
    
    
    myTableView.frame = CGRectMake(0, 26, 320, self.mainView.bounds.size.height - 69);
    
    if(qiciArray.count)
    {
        [self getPKListRequest:[qiciArray objectAtIndex:0]];
    }
    
    
    
    oneLabel.text = [NSString stringWithFormat:@"%d", one];
    twoLabel.text = [NSString stringWithFormat:@"%d", two];
}
- (void)pressTitleButton1:(UIButton *)sender{
    
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.4];
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao_selected.png");
}
- (void)pressTitleButton2:(UIButton *)sender{
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao.png");
}
//期次选择
- (void)pressTitleButton:(UIButton *)sender{
    
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao.png");
    if(titleBtnIsCanPress)
    {
        titleBtnIsCanPress = NO;
        if(!isShowing)
        {
            UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
            [SharedMethod sanJiaoKai:sanjiao];
            
            alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"期次选择" PKNameArray:qiciArray PKArray:nil];
            
            alert2.duoXuanBool = NO;
            alert2.delegate = self;
            alert2.tag = 101;
            isShowing = YES;
            alert2.isClearBtnCanPress = NO;
            [alert2 show];
            [self.view addSubview:self.CP_navigation];
            self.CP_navigation.frame = CGRectMake(0, 20, 320, 44);
            [self.CP_navigation.window addSubview:alert2];
            [self.CP_navigation.window addSubview:self.CP_navigation];
            
            int i=0;
            for (CP_XZButton *btn in alert2.backScrollView.subviews) {
                if([btn isKindOfClass:[UIButton class]])
                {
                    if(qiciArray.count > i)
                    {
                        if([[qiciArray objectAtIndex:i] isEqualToString:[qiciXuanzeArym objectAtIndex:0]])
                        {
                            btn.selected = YES;
                            btn.buttonName.textColor = [UIColor whiteColor];
                        }
                        i++;
                    }
                }
            }
            
        }
        else
        {
            UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
            [SharedMethod sanJiaoGuan:sanjiao];
            
            [alert2 disMissWithPressOtherFrame];
        }
        
    }
    
    
}
-(void)disMissWithPressOtherFrame:(CP_KindsOfChoose *)chooseView
{
    UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
    [SharedMethod sanJiaoGuan:sanjiao];
    titleBtnIsCanPress = YES;
    isShowing = NO;
    [self addNavAgain];
}
-(void)CP_KindsOfChooseViewAlreadyShowed:(CP_KindsOfChoose *)chooseView
{
    titleBtnIsCanPress = YES;
}
-(void)addNavAgain
{
    if (IS_IOS7) {
        self.CP_navigation.frame = CGRectMake(0, 20, 320, 44);
    }else{
        self.CP_navigation.frame = CGRectMake(0, 0, 320, 44);
    }
    [self.view addSubview:self.CP_navigation];
    
    titleBtnIsCanPress = YES;
    
}
-(void)getPKListRequest:(NSString *)qici
{
    if (!loadView) {
        loadView = [[UpLoadView alloc] init];
    }
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadView];
    
    [self.request clearDelegatesAndCancel];
    NSMutableData *postData = [[GC_HttpService sharedInstance] req_GetPKList:qici];
    self.request = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [request setRequestMethod:@"POST"];
    [request addCommHeaders];
    [request setPostBody:postData];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(reqPKListFinish:)];
    [request setDidFailSelector:@selector(reqMyPrizeFailed:)];
    [request startAsynchronous];
}
- (void)reqPKListFinish:(ASIHTTPRequest *)myRequest{
    
    if (loadView) {
        [loadView stopRemoveFromSuperview];
        loadView = nil;
    }
    
    [dataArray removeAllObjects];
    
    if ([myRequest responseData])
    {
        GC_PKRaceList *pkRaceList = [[GC_PKRaceList alloc]initWithResponseData:myRequest.responseData WithRequest:myRequest];
        self.count = pkRaceList.count;
        
        if (pkRaceList.listData.count == 0)
        {
            wujiluView.hidden = NO;
            myTableView.hidden = YES;
        }
        else
        {
            wujiluView.hidden = YES;
            myTableView.hidden =  NO;
            for(PKXiangxiList *pkx in pkRaceList.listData)
            {
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:pkx.raceName,@"leagueName",pkx.keDui,@"guestName",pkx.zhuDui,@"hostName",pkx.shengPei,@"eurWin",pkx.pingPei,@"eurDraw",pkx.fuPei,@"eurLost",pkx.raceTime,@"gameStartDate", nil];
                GC_BetData * pkbet = [[GC_BetData alloc] initWithDic:dict];
                [dataArray addObject:pkbet];
                [pkbet release];
            }
        }
        
//        for(PKXiangxiList *pkx in pkRaceList.listData)
//        {
//            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:pkx.raceName,@"leagueName",pkx.zhuDui,@"guestName",pkx.keDui,@"hostName",pkx.shengPei,@"eurWin",pkx.pingPei,@"eurDraw",pkx.fuPei,@"eurLost",pkx.raceTime,@"gameStartDate", nil];
//            GC_BetData * pkbet = [[GC_BetData alloc] initWithDic:dict];
//            [dataArray addObject:pkbet];
//            [pkbet release];
//        }
        
        [myTableView reloadData];
    }
    [self pressQingButton:nil];
}
- (void)reqMyPrizeFailed:(ASIHTTPRequest*)PKListRequest{
    
    if (loadView) {
        [loadView stopRemoveFromSuperview];
        loadView = nil;
    }
    NSLog(@"reqMyPrizeFailed %@",PKListRequest.responseString);
    
    [[caiboAppDelegate getAppDelegate] showMessage:@"请检查您的网络后重试"];
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    PKTableViewCell *cell = (PKTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[PKTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        cell.wangqibool = NO;
        
        cell.cp_canopencelldelegate = self;
        cell.xzhi = 9.5;
        
        cell.normalHight = 50;
        cell.selectHight = 50+56;
    }
    
    UIButton * cellbutton = (UIButton *)[cell.butonScrollView viewWithTag:1];
    
    cellbutton.hidden = NO;
    cell.wangqibool = NO;
    
    cell.row = indexPath.row;
    cell.count = indexPath.row;
    cell.delegate = self;
    GC_BetData * pkbet = [dataArray objectAtIndex:indexPath.row];
    pkbet.donghuarow = indexPath.row;
    cell.pkbetdata = pkbet;
    
    [cell hidenXieBtn];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(dataArray.count)
    {
        return dataArray.count;
    }
    else
        return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73;
}
#pragma mark 下面黑色区域
- (void)tabBarView{
    
    tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 372, 320, 44)];
    if (IS_IPHONE_5) {
        tabView.frame = CGRectMake(0, 460, 320, 44);
    }
    //    UIImageView * tabBack = [[UIImageView alloc] initWithFrame:tabView.bounds];
    //    tabBack.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    tabView.backgroundColor = [UIColor blackColor];
    
    //已选
    UILabel * pitchLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 20, 10)];
    pitchLabel.text = @"";
    pitchLabel.textAlignment = NSTextAlignmentCenter;
    pitchLabel.font = [UIFont systemFontOfSize:9];
    pitchLabel.backgroundColor = [UIColor clearColor];
    
    //已投
    UILabel * castLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 20, 10)];
    castLabel.text = @"";
    castLabel.textAlignment = NSTextAlignmentCenter;
    castLabel.font = [UIFont systemFontOfSize:9];
    castLabel.backgroundColor = [UIColor clearColor];
    
    
    UIButton * qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    qingbutton.frame = CGRectMake(12, 8, 30, 30);
    [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
    [qingbutton addTarget:self action:@selector(pressQingButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //放图片 图片上放label 显示投多少场
    
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(52, 7, 62, 30)];
    zhubg.image = UIImageGetImageFromName(@"SRK960.png");
    zhubg.userInteractionEnabled = YES;
    
    oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 4, 40, 11)];
    oneLabel.backgroundColor = [UIColor clearColor];
    oneLabel.textAlignment = NSTextAlignmentCenter;
    oneLabel.font = [UIFont systemFontOfSize:9];
    oneLabel.textColor = [UIColor whiteColor];
    //   oneLabel.text = @"14";
    
    [zhubg addSubview:oneLabel];
    
    twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 19, 40, 11)];
    twoLabel.backgroundColor = [UIColor clearColor];
    twoLabel.textAlignment = NSTextAlignmentCenter;
    twoLabel.font = [UIFont systemFontOfSize:9];
    twoLabel.textColor = [UIColor whiteColor];
    
    [zhubg addSubview:twoLabel];
    
    //场字
    UILabel *fieldLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 4, 20, 11)];
    fieldLable.text = @"注";
    fieldLable.textAlignment = NSTextAlignmentCenter;
    fieldLable.font = [UIFont systemFontOfSize:9];
    fieldLable.backgroundColor = [UIColor clearColor];
    fieldLable.textColor = [UIColor whiteColor];
    [zhubg addSubview:fieldLable];
    //注字
    UILabel * pourLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 19, 20, 11)];
    pourLable.text = @"场";
    pourLable.textAlignment = NSTextAlignmentCenter;
    pourLable.font = [UIFont systemFontOfSize:9];
    pourLable.backgroundColor = [UIColor clearColor];
    pourLable.textColor = [UIColor whiteColor];
    [zhubg addSubview:pourLable];
    
    //投注按钮背景
    UIImageView * backButton = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 63, 30)];
    backButton.image = UIImageGetImageFromName(@"gc_footerBtn.png");
    UIImageView * backButton2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 29)];
    backButton2.image = UIImageGetImageFromName(@"GC_icon8.png");
    
    
    
    //投注按钮
    castButton = [UIButton buttonWithType:UIButtonTypeCustom];
    castButton.frame = CGRectMake(230, 6, 80, 33);
    UIImageView * chuanimage1 = [[UIImageView alloc] initWithFrame:castButton.bounds];
    chuanimage1.backgroundColor = [UIColor clearColor];
    chuanimage1.image = [UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    //    [chuanimage1 setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    //    [chuanimage1 setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [castButton addSubview:chuanimage1];
    [chuanimage1 release];
    [castButton addTarget:self action:@selector(pressCastButton:) forControlEvents:UIControlEventTouchUpInside];
    castButton.enabled = NO;
    castButton.alpha = 0.5;
    
    //按钮上的字
    UILabel * buttonLabel1 = [[UILabel alloc] initWithFrame:castButton.bounds];
    buttonLabel1.text = @"选好了";
    buttonLabel1.textAlignment = NSTextAlignmentCenter;
    buttonLabel1.backgroundColor = [UIColor clearColor];
    buttonLabel1.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    buttonLabel1.font = [UIFont boldSystemFontOfSize:18];
    
    [castButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [castButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    
    [castButton addSubview:buttonLabel1];
    
    //串法
    chuanButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    if (one < 2) {
        chuanButton1.enabled = NO;
        chuanButton1.alpha = 0.5;
    }else{
        chuanButton1.enabled = YES;
        chuanButton1.alpha = 1;
    }
    chuanButton1.frame = CGRectMake(130, 8, 68, 30);
    [chuanButton1 addTarget:self action:@selector(pressChuanButton) forControlEvents:UIControlEventTouchUpInside];
    [chuanButton1 setBackgroundImage:UIImageGetImageFromName(@"chuanbgimage.png") forState:UIControlStateNormal];
    [chuanButton1 setBackgroundImage:UIImageGetImageFromName(@"chuanbgimage_1.png") forState:UIControlStateHighlighted];
    
    
    labelch = [[UILabel alloc] initWithFrame:chuanButton1.bounds];
    labelch.text = @"串法";
    labelch.textAlignment = NSTextAlignmentCenter;
    labelch.backgroundColor = [UIColor clearColor];
    labelch.font = [UIFont boldSystemFontOfSize:20];
    labelch.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133.0/255.0 alpha:1.0];
    [chuanButton1 addSubview:labelch];
    
    
    [backButton release];
    [backButton2 release];
    [buttonLabel1 release];
    
    [tabView addSubview:pitchLabel];
    [tabView addSubview:castLabel];
    [tabView addSubview:zhubg];
    [zhubg release];
    [tabView addSubview:castButton];
    [tabView addSubview:qingbutton];
    [tabView addSubview:chuanButton1];
    [self.mainView addSubview:tabView];
    
    
    [pitchLabel release];
    [castLabel release];
    [fieldLable release];
    [pourLable release];
}
// press 串法
-(void)pressChuanButton
{
    [cellarray removeAllObjects];
    [cellarray addObjectsFromArray:dataArray];
    
    NSInteger changci = 0;//计算选多少场
    
    for (GC_BetData * da in cellarray) {
        
        if (da.selection1 || da.selection2 || da.selection3) {
            changci++;
        }
    }
    
    
    
    NSMutableArray * array = nil;
    
    //北单
    NSInteger lotteryID = 1;
    
    //    array = (NSMutableArray *)[GC_BJDanChangChuanFa lotteryId:lotteryID GameCount:one type:0];//[resultList count]
    array = (NSMutableArray *)[GC_BJDanChangChuanFa danLotteryId:lotteryID GameCount:one type:0];
    
    
    [chuantype removeAllObjects];
    if ([chuantype count] != [array count]) {
        [chuantype removeAllObjects];
        for (int i = 0; i < [array count]; i++) {
            [chuantype addObject:@"0"];
        }
    }
    
    if(chuanfaArym.count)
    {
        for(NSString *str in chuanfaArym)
        {
            for (int i = 0; i < [array count]; i++)
            {
                if ([[array objectAtIndex:i] isEqualToString:str]) {
                    [chuantype replaceObjectAtIndex:i withObject:@"1"];
                }
            }
        }
    }
    else if(![labelch.text isEqualToString:@"串法"])
    {
        for (int i = 0; i < [array count]; i++) {
            
            if ([[array objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%d串1", one]]) {
                [chuantype replaceObjectAtIndex:i withObject:@"1"];
            }
        }
    }
    
    
    CP_KindsOfChoose *alert =[[CP_KindsOfChoose alloc] initWithTitle:@"过关方式选择" withChuanNameArray:array andChuanArray:chuantype];
    alert.delegate = self;
    alert.duoXuanBool = YES;
    alert.tag = 8;
    [alert show];
    self.mainView.userInteractionEnabled = NO;
    [alert release];
    
    
}
- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt{
    
    if (chooseView.tag == 8) {
        if(buttonIndex == 1)
        {
            [chuanfaArym removeAllObjects];
            [chuanfaArym addObjectsFromArray:returnarry];
            if(returnarry.count > 0)
            {
//                [chuanfaArym removeAllObjects];
//                [chuanfaArym addObjectsFromArray:returnarry];
            }
            else
            {
                labelch.text = @"串法";
            }
            
            addchuan = 0;
            [zhushuDic removeAllObjects];
            for (int i = 0; i < 100; i++) {
                buf[i] = 0;
            }
            
            for (int i = 0; i < [returnarry count];i++) {
                NSString * str = [returnarry objectAtIndex:i];
                NSLog(@"st = %@", str);
                UIButton * senbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                senbutton.tag = i + 1;
                senbutton.titleLabel.text = str;
                [self pressChuanJiuGongGe:senbutton];
                
            }
        }
        else
        {
            
        }
        [self getChuanfa:chuanfaArym];
        
    }
    //选择期次
    if (chooseView.tag == 101)
    {
        [qiciXuanzeArym removeAllObjects];
        [qiciXuanzeArym addObjectsFromArray:returnarry];

        if(qiciXuanzeArym.count)
        {
            titleLabel.text = [NSString stringWithFormat:@"PK赛%@期",[returnarry objectAtIndex:0]];
            [self getPKListRequest:[returnarry objectAtIndex:0]];
        }
    }
    
    
}
-(void)chooseViewDidRemovedFromSuperView:(CP_KindsOfChoose *)chooseView
{
    self.mainView.userInteractionEnabled = YES;
}
-(void)pressChuanJiuGongGe:(UIButton *)sender
{
    [cellarray removeAllObjects];
    
    [cellarray addObjectsFromArray:dataArray];
    
    if (buf[sender.tag] == 0) {
        UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
        image.hidden = NO;
        UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
        imagebg.image = UIImageGetImageFromName(@"gc_chuanhover.png");
        //   sender.backgroundColor  = [UIColor blueColor];
        
        addchuan +=1;
        NSLog(@"2 add chuan = %ld", (long)addchuan);
        if (addchuan > 5) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"组合串关不能超过5个"];
            addchuan -= 1;
            
        }else{
            buf[sender.tag] = 1;
        }
        
        
        for (int i = 1; i < 160; i++) {
            if (i == sender.tag) {
                continue;
            }
            
        }
        
    }
    
    UILabel * vi = sender.titleLabel;
    int currtCount;
    int selecount;
    NSNumber * currtnum;
    NSNumber * countnum;
    
    int selecout2;
    int selecout3;
    NSMutableDictionary * diction = [NSMutableDictionary dictionaryWithCapacity:0];
    selecount = 0;
    selecout2 = 0;
    selecout3 = 0;
    
    
    for (GC_BetData * pkb in cellarray) {
        if ((pkb.selection1 && pkb.selection2 == NO && pkb.selection3 == NO)|| (pkb.selection2 && pkb.selection1 == NO && pkb.selection3 == NO) ||(pkb.selection3 && pkb.selection1 == NO && pkb.selection2 == NO)) {
            
            selecount++;
        }
        
        
    }
    
    
    if (selecount != 0) {
        currtCount = 1;
        currtnum = [NSNumber numberWithInt:selecount];
        countnum = [NSNumber numberWithInt:currtCount];
        [diction setObject:currtnum forKey:countnum];
    }
    
    for (GC_BetData * pkb in cellarray) {
        if ((pkb.selection1 && pkb.selection2 && pkb.selection3 == NO)||(pkb.selection1 && pkb.selection2== NO && pkb.selection3 )||(pkb.selection1== NO && pkb.selection2 && pkb.selection3 )) {
            selecout2++;
        }
    }
    
    if (selecout2 != 0) {
        currtCount = 2;
        currtnum = [NSNumber numberWithInt:selecout2];
        countnum = [NSNumber numberWithInt:currtCount];
        [diction setObject:currtnum forKey:countnum];
    }
    
    for (GC_BetData * pkb in cellarray) {
        if (pkb.selection1 && pkb.selection2 && pkb.selection3) {
            selecout3++;
        }
    }
    
    if (selecout3 != 0) {
        currtCount = 3;
        currtnum = [NSNumber numberWithInt:selecout3];
        countnum = [NSNumber numberWithInt:currtCount];
        [diction setObject:currtnum forKey:countnum];
    }
    
    
    
    // 未设胆情况
    GC_JCalgorithm *jcalgorithm = [GC_JCalgorithm shareJCalgorithmManager];
    //            NSArray *keys = [selectedItemsDic allKeys];
    
    //            for (NSString* stri in keys) {
    //                NSLog(@"stri = %@", stri);
    //            }
    
    [jcalgorithm passData:diction gameCount:[cellarray count] chuan:[vi text]];
    long long  total =[jcalgorithm  totalZhuShuNum];
    NSLog(@"total = %lld", total);
    NSNumber *longNum = [[NSNumber alloc] initWithLongLong:total];
    if (buf[sender.tag] == 1) {
        [zhushuDic setObject:longNum forKey:vi.text];
    }else{
        if ([zhushuDic objectForKey:vi.text]) {
            [zhushuDic removeObjectForKey:vi.text];
        }
        
    }
    [longNum release];
    
    
    
    
    
    NSArray * ar = [zhushuDic allKeys];
    
    for (NSString * st in ar) {
        NSLog(@"st = %@", st);
    }
    
    NSInteger n=0;
    for (int i = 0; i < [ar count]; i++) {
        if ([ar objectAtIndex:i] != nil || [[ar objectAtIndex:i] isEqualToString:@""]) {
            NSNumber * numq = [zhushuDic objectForKey:[ar objectAtIndex:i]];
            
            n = n + [numq intValue];
        }
        
        
    }
    oneLabel.text = [NSString stringWithFormat:@"%ld", (long)n];
    self.chuanfaStr = [NSString stringWithFormat:@"%dx1",(int)n];
    zhu = n;
    //    twoLabel.text = [NSString stringWithFormat:@"%d", n * 2];
//    NSArray * arrr = [zhushuDic allKeys];
//    [self getChuanfa:arrr];
    
    if ([ar count] > 1) {
        labelch.text = @"多串...";
        twoLabel.hidden = NO;
    }else if([ar count] == 1){
        labelch.text = [ar objectAtIndex:0];
        twoLabel.hidden = NO;
    }else if([ar count] == 0){
        labelch.text = @"串法";
        //        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        twoLabel.hidden = YES;
    }else {
        labelch.text = @"串法";
        //        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        twoLabel.hidden = YES;
    }
}
-(void)getChuanfa:(NSArray *)ary
{
    self.chuanfaStr = @"";
    [chuanfaAry removeAllObjects];
    if(ary.count > 0)
    {
        for(NSString *str in ary)
        {
            if([str isEqualToString:@"2串1"])
            {
                [chuanfaAry addObject:@"2x1"];
            }
            if([str isEqualToString:@"3串1"])
            {
                [chuanfaAry addObject:@"3x1"];
            }
            if([str isEqualToString:@"4串1"])
            {
                [chuanfaAry addObject:@"4x1"];
            }
        }
        for(NSString *s in chuanfaAry)
        {
            self.chuanfaStr = [self.chuanfaStr stringByAppendingFormat:@"%@,",s];
        }
        self.chuanfaStr = [self.chuanfaStr substringToIndex:[self.chuanfaStr length] - 1];
    }
}
# pragma mark 选好了
- (void)pressCastButton:(UIButton *)button
{
    NSLog(@"选好了");
    NSLog(@"xuan hao  le");
    if(chuanfaArym.count == 0)
    {
        [self pressChuanButton];
        return;
    }
    if ([[[Info getInstance] userId] intValue] == 0) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"登录后可用"];
        return;
    }
    if (one < 2) {
        
//        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"至少需要对2场比赛进行投注" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        alert.shouldRemoveWhenOtherAppear = YES;
//        [alert show];
//        [alert release];
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"至少需要对2场比赛进行投注"];
        return;
        
    }else if (two > 512){
        
//        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"投注方案不能超过512注" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        alert.shouldRemoveWhenOtherAppear = YES;
//        [alert show];
//        [alert release];
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"投注方案不能超过512注"];
        return;
        
    }else {
        NSString * string = @"";
        NSString * peilv = @"";
        for (GC_BetData * data in dataArray) {
            if (data.selection1) {
                string = [string stringByAppendingFormat:@"胜"];
                peilv = [peilv stringByAppendingFormat:@"%@|",data.but1];
            }
            if (data.selection2) {
                string = [string stringByAppendingFormat:@"平"];
                peilv = [peilv stringByAppendingFormat:@"%@|",data.but2];
            }
            if (data.selection3) {
                string = [string stringByAppendingFormat:@"负"];
                peilv = [peilv stringByAppendingFormat:@"%@|",data.but3];
            }
            if(!data.selection1 && !data.selection2 && !data.selection3)
            {
                string = [string stringByAppendingFormat:@"*"];
                peilv = [peilv stringByAppendingFormat:@"*,"];
            }
            string = [string stringByAppendingFormat:@","];
            peilv = [peilv substringToIndex:[peilv length] - 1];
            peilv = [peilv stringByAppendingFormat:@","];
        }
        string = [string substringToIndex:[string length] - 1];
        peilv = [peilv substringToIndex:[peilv length] - 1];
        self.betConStr = string;
        self.betPeilvStr = peilv;
        
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"确定投注？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        alert.tag = 11;
        alert.shouldRemoveWhenOtherAppear = YES;
        [alert show];
        [alert release];
    }
    
}
- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message
{
    if(alertView.tag == 11)//确定投注
    {
        if(buttonIndex == 1)
        {
            NSLog(@"确定投注");
            JiFenBetInfo *info = [[JiFenBetInfo alloc]init];
            
            info.caiZhong = @"201";
            info.wanFa = @"22";
            info.touZhu = @"02";
            info.guoGuan = chuanfaStr;
            info.beiShu = @"1";
            info.payJiFen = [NSString stringWithFormat:@"%d",(int)zhu*2];
            info.betNumber = betConStr;
            info.peiLv = betPeilvStr;
            //        info.issue = @"2015-03-05";
            if(qiciXuanzeArym.count)
            {
                info.issue = [qiciXuanzeArym objectAtIndex:0];
            }
            
            NSLog(@"%@",info.caiZhong);
            NSLog(@"%@",info.wanFa);
            NSLog(@"%@",info.touZhu);
            NSLog(@"%@",info.guoGuan);
            NSLog(@"%@",info.beiShu);
            NSLog(@"%@",info.payJiFen);
            NSLog(@"%@",info.betNumber);
            NSLog(@"%@",info.peiLv);
            NSLog(@"%@",info.issue);
            
            if(![info.guoGuan isEqualToString:@""])
                [self sendTouzhu:info];
        }
        else
        {
            
        }
    }
    else if(alertView.tag == 10)//投注成功跳入方案详情
    {
        if(buttonIndex == 1)
        {
            PKDetailViewController *pvc = [[PKDetailViewController alloc]init];
            pvc.code = self.touzhuCode;
            [self.navigationController pushViewController:pvc animated:YES];
            [pvc release];
        }
        else
        {
            
        }
    }
}
-(void)sendTouzhu:(JiFenBetInfo *)info
{
    [self.request clearDelegatesAndCancel];
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqJiFenBuyJiFenInfo:info];
    self.request = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [request setRequestMethod:@"POST"];
    [request addCommHeaders];
    [request setPostBody:postData];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(touzhuSuccessFinish:)];
    [request setDidFailSelector:@selector(touzhuFail:)];
    [request startAsynchronous];
}
-(void)touzhuSuccessFinish:(ASIHTTPRequest *)requests
{
    NSLog(@"投注成功");
//    if ([requests responseData])
//    {
//        GC_DataReadStream *drs = [[GC_DataReadStream alloc] initWithData:requests.responseData];
//        if (drs) {
//            self.returnId= [drs readShort];
//            NSLog(@"返回消息id %d", (int)returnId);
//            if (![GC_RspError parserError:drs returnId:returnId WithRequest:request]) {
//                self.sysTimeString = [drs readComposString1];
//                self.statue = [drs readComposString1];
//                self.message = [drs readComposString1];
//                self.touzhuCode = [drs readComposString1];
//                NSLog(@"系统时间 %@",self.sysTimeString);
//                NSLog(@"投注状态 %@",self.statue);
//                NSLog(@"提示信息 %@",self.message);
//                NSLog(@"方案编号 %@",self.touzhuCode);
//
//                [self betTouzhuTishiMessage:self.message touzhuStatue:self.statue];
//            }
//        }
//    }
    if ([requests responseData])
    {
        JiFenBuyLotteryData *jfData = [[JiFenBuyLotteryData alloc]initWithResponseData:requests.responseData WithRequest:requests];
        
        self.returnId= jfData.returnId;
        self.sysTimeString = jfData.systemTime;
        self.statue = jfData.returnValue;
        self.message = jfData.message;
        self.touzhuCode = jfData.fangAnCode;
        NSLog(@"返回消息id %d", (int)returnId);
        NSLog(@"系统时间 %@",self.sysTimeString);
        NSLog(@"投注状态 %@",self.statue);
        NSLog(@"提示信息 %@",self.message);
        NSLog(@"方案编号 %@",self.touzhuCode);

        [self betTouzhuTishiMessage:self.message touzhuStatue:self.statue];
    }
}
-(void)touzhuFail
{
    NSLog(@"投注失败");
    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
    [cai showMessage:@"投注失败"];
}
-(void)betTouzhuTishiMessage:(NSString *)mes touzhuStatue:(NSString *)sta
{
    if([sta isEqualToString:@"0000"])
    {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"投注成功" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"方案详情",nil];
        alert.shouldRemoveWhenOtherAppear = YES;
        alert.tag = 10;
        [alert show];
        [alert release];
    }
    else if([mes isEqualToString:@"竞彩pk赛重复投注"])
    {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"亲，竞猜PK赛一期只能投注一次！"];
    }
    else
    {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:mes];
    }
}

- (void)returnCellInfo:(NSInteger)index buttonBoll1:(BOOL)selection1 buttonBoll:(BOOL)selection2 buttonBoll:(BOOL)selection3 dan:(BOOL)booldan{
    
    NSLog(@"1111111111111111index = %ld   button1 = %d  button2 = %d  button3 = %d, booldan = %d", (long)index, selection1, selection2, selection3, booldan);
    GC_BetData  * da = [dataArray objectAtIndex:index];
    da.count = index;
    da.selection1 = selection1;
    da.selection2 = selection2;
    da.selection3 = selection3;
    da.dandan = booldan;
    
    
    if (selection1 == NO && selection2 == NO && selection3 == NO) {
        da.dandan = NO;
    }
    
    [dataArray replaceObjectAtIndex:index withObject:da];
    NSLog(@"1111111111111111index = %ld   button1 = %d  button2 = %d  button3 = %d", (long)da.count, da.selection1, da.selection2, da.selection3);
    
    two = 1;
    one = 0;
    
    
    [self upDateFunc];
    
    
    [myTableView reloadData];
    
    
}
# pragma mark 垃圾桶
- (void)pressQingButton:(UIButton *)sender {
    for (GC_BetData * pkb in dataArray) {
        pkb.selection1 = NO;
        pkb.selection2 = NO;
        pkb.selection3 = NO;
    }
    [myTableView reloadData];
    [self upDateFunc];
}

- (void)upDateFunc{
    
    [cellarray removeAllObjects];
    
    [cellarray addObjectsFromArray:dataArray];
    
    two = 1;
    one = 0;
    for (GC_BetData * pkb in cellarray) {
        if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
            one++;
            
        }
        
        two = two *(pkb.selection1+pkb.selection2+pkb.selection3);
    }
    if(cellarray.count == 0)
    {
        two = 0;
    }
    
    
    int currtCount;
    int selecount;
    NSNumber * currtnum;
    NSNumber * countnum;
    
    int selecout2;
    int selecout3;
    NSMutableDictionary * diction = [NSMutableDictionary dictionaryWithCapacity:0];
    selecount = 0;
    selecout2 = 0;
    selecout3 = 0;
    
    
    for (GC_BetData * pkb in cellarray) {
        if ((pkb.selection1 && pkb.selection2 == NO && pkb.selection3 == NO)|| (pkb.selection2 && pkb.selection1 == NO && pkb.selection3 == NO) ||(pkb.selection3 && pkb.selection1 == NO && pkb.selection2 == NO)) {
            
            selecount++;
        }
        
        
    }
    
    
    if (selecount != 0) {
        currtCount = 1;
        currtnum = [NSNumber numberWithInt:selecount];
        countnum = [NSNumber numberWithInt:currtCount];
        [diction setObject:currtnum forKey:countnum];
    }
    
    for (GC_BetData * pkb in cellarray) {
        if ((pkb.selection1 && pkb.selection2 && pkb.selection3 == NO)||(pkb.selection1 && pkb.selection2== NO && pkb.selection3 )||(pkb.selection1== NO && pkb.selection2 && pkb.selection3 )) {
            selecout2++;
        }
    }
    
    if (selecout2 != 0) {
        currtCount = 2;
        currtnum = [NSNumber numberWithInt:selecout2];
        countnum = [NSNumber numberWithInt:currtCount];
        [diction setObject:currtnum forKey:countnum];
    }
    
    for (GC_BetData * pkb in cellarray) {
        if (pkb.selection1 && pkb.selection2 && pkb.selection3) {
            selecout3++;
        }
    }
    
    if (selecout3 != 0) {
        currtCount = 3;
        currtnum = [NSNumber numberWithInt:selecout3];
        countnum = [NSNumber numberWithInt:currtCount];
        [diction setObject:currtnum forKey:countnum];
    }
    
    
    NSString *str;
    str = [NSString stringWithFormat:@"%d串1",one];
    self.chuanfaStr = [NSString stringWithFormat:@"%dx1",(int)one];
    // 未设胆情况
    GC_JCalgorithm *jcalgorithm = [GC_JCalgorithm shareJCalgorithmManager];
    //            NSArray *keys = [selectedItemsDic allKeys];
    
    //            for (NSString* stri in keys) {
    //                NSLog(@"stri = %@", stri);
    //            }
    
    [jcalgorithm passData:diction gameCount:[cellarray count] chuan:str];
    long long  total =[jcalgorithm  totalZhuShuNum];
    NSLog(@"total = %lld", total);
    
    if(one == 0)
    {
        castButton.enabled = NO;
        castButton.alpha = 0.5;
    }
    else
    {
        castButton.enabled = YES;
        castButton.alpha = 1;
    }
    
    
    oneLabel.text = [NSString stringWithFormat:@"%d", two];
    twoLabel.text = [NSString stringWithFormat:@"%d", one];
    zhu = total;
    
    if (one < 2) {
        chuanButton1.enabled = NO;
        chuanButton1.alpha = 0.5;
        labelch.text = @"串法";
    }else{
        chuanButton1.enabled = YES;
        chuanButton1.alpha = 1;
        labelch.text = [NSString stringWithFormat:@"%d串1",one];
        oneLabel.text = [NSString stringWithFormat:@"%lld", total];
        twoLabel.text = [NSString stringWithFormat:@"%d", one];
    }
    [chuanfaArym removeAllObjects];
    [chuanfaArym addObject:labelch.text];
    
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
    if(isShowing)
        [alert2 disMissWithPressOtherFrame];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    [self.request clearDelegatesAndCancel];
    self.request = nil;
    [qiciXuanzeArym release];
    [qiciArray release];
    [chuanfaArym release];
    [loadView release];
    [chuanfaAry release];
    [chuantype release];
    [cellarray release];
    [zhushuDic release];
    [dataArray release];
    [labelch release];
    [oneLabel release];
    [twoLabel release];
    [tabView release];
    [super dealloc];
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