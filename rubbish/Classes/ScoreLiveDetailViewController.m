//
//  ScoreLiveDetailViewController.m
//  caibo
//
//  Created by yaofuyu on 13-7-3.
//
//

#import "ScoreLiveDetailViewController.h"
#import "Info.h"
#import "NetURL.h"
#import "AsEuCell.h"
#import "JSON.h"
#import "NewAroundViewController.h"
#import "ScoreMachInfoCell.h"
#import "TopicThemeListViewController.h"
#import "PeiLvChangeViewController.h"
#import "CP_PTButton.h"

@interface ScoreLiveDetailViewController ()

@end

@implementation ScoreLiveDetailViewController

@synthesize scoreInfo;
@synthesize mRequest;
@synthesize myMacthInfo;
@synthesize dataDic;
@synthesize peiLvRequest;
@synthesize myTimer;
@synthesize isLanqiu;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataDic = [NSMutableDictionary dictionary];
        isLanqiu = NO;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].idleTimerDisabled=YES;
    if (self.myTimer) {
        [self.myTimer invalidate];
        self.myTimer = nil;
    }
    if (isLanqiu) {
        if (!self.myMacthInfo) {
            self.myTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(getMachInfo) userInfo:nil repeats:YES];
        }
        else {
            self.myTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(refeshLanQiu) userInfo:nil repeats:YES];
        }
        
    }
    else {
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:120 target:self selector:@selector(getMachInfo) userInfo:nil repeats:YES];
    }
    
    [self.myTimer fire];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].idleTimerDisabled=NO;
    [self.myTimer invalidate];
    self.myTimer = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
    CP_PTButton *rightbtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(0, 0, 40, 40);
    [rightbtn loadButonImage:@"bifenshuaxin.png" LabelName:nil];
    rightbtn.buttonImage.image = UIImageGetImageFromName(@"bifenshuaxin.png");
    rightbtn.buttonImage.frame = CGRectMake(10, 9, 23, 21);
    [rightbtn addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[[UIBarButtonItem alloc] initWithCustomView:(rightbtn)] autorelease];
    self.CP_navigation.rightBarButtonItem = btnItem;
    self.mainView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
    self.CP_navigation.title = self.scoreInfo.leagueName;
    
    homeBack = [[DownLoadImageView alloc] initWithFrame:CGRectMake(10, 15, 79, 64)];
    homeBack.image = UIImageGetImageFromName(@"bifenflagBack.png");
	[self.mainView addSubview:homeBack];
    [homeBack release];
    
    homeImageView = [[DownLoadImageView alloc] initWithFrame:CGRectMake(12, 17, 75, 60)];
	[self.mainView addSubview:homeImageView];
    [homeImageView release];
	
	homeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 85, 85, 11)];
	[self.mainView addSubview:homeLabel];
	homeLabel.textAlignment = NSTextAlignmentCenter;
	homeLabel.backgroundColor = [UIColor clearColor];
	homeLabel.font = [UIFont systemFontOfSize:9];
    [homeLabel release];
	
    visitBack = [[DownLoadImageView alloc] initWithFrame:CGRectMake(235, 15, 79, 64)];
    visitBack.image = UIImageGetImageFromName(@"bifenflagBack.png");
	[self.mainView addSubview:visitBack];
    [visitBack release];
	
	visitImageView = [[DownLoadImageView alloc] initWithFrame:CGRectMake(237, 17, 75, 60)];
	[self.mainView addSubview:visitImageView];
    [visitImageView release];
	
	
	visitLabel = [[UILabel alloc] initWithFrame:CGRectMake(235, 85, 85, 11)];
	[self.mainView addSubview:visitLabel];
	visitLabel.backgroundColor = [UIColor clearColor];
	visitLabel.textAlignment = NSTextAlignmentCenter;
	visitLabel.font = [UIFont systemFontOfSize:9];
    [visitLabel release];
    
    bifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 29, 70, 17)];
	[self.mainView addSubview:bifenLabel];
	bifenLabel.backgroundColor = [UIColor clearColor];
	bifenLabel.textAlignment = NSTextAlignmentRight;
	bifenLabel.font = [UIFont boldSystemFontOfSize:15];
    bifenLabel.textColor = [UIColor redColor];
    [bifenLabel release];
    
    statueLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 30, 70, 17)];
	[self.mainView addSubview:statueLabel];
	statueLabel.backgroundColor = [UIColor clearColor];
	statueLabel.textAlignment = NSTextAlignmentLeft;
	statueLabel.font = [UIFont boldSystemFontOfSize:9];
    statueLabel.textColor = [UIColor redColor];
    [statueLabel release];
    
	
	
	timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 53, 140, 12)];
	[self.mainView addSubview:timeLabel];
	timeLabel.backgroundColor = [UIColor clearColor];
	timeLabel.textAlignment = NSTextAlignmentCenter;
	timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
	timeLabel.font = [UIFont systemFontOfSize:9];
    [timeLabel release];
	
    
	
	peiLvLabe = [[UILabel alloc] initWithFrame:CGRectMake(90, 67, 140, 11)];
	[self.mainView addSubview:peiLvLabe];
	peiLvLabe.backgroundColor = [UIColor clearColor];
    peiLvLabe.font = [UIFont systemFontOfSize:9];
    peiLvLabe.textAlignment = NSTextAlignmentCenter;
	peiLvLabe.textColor = [UIColor blackColor];
    
    rootScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 126, 320, self.mainView.bounds.size.height - 166)];
	rootScroll.contentSize = CGSizeMake(320 * 4, self.mainView.bounds.size.height - 166);
	rootScroll.delegate = self;
    rootScroll.scrollEnabled = NO;
	rootScroll.pagingEnabled = YES;
	[rootScroll setShowsHorizontalScrollIndicator:NO];
	[self.mainView addSubview:rootScroll];
	rootScroll.backgroundColor = [UIColor clearColor];
	[rootScroll release];
    
    myTableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, 320, self.mainView.bounds.size.height - 166) style:UITableViewStylePlain];
	myTableView1.backgroundColor = [UIColor clearColor];
	myTableView1.delegate = self;
	myTableView1.dataSource = self;
    [myTableView1 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[rootScroll addSubview:myTableView1];
	[myTableView1 release];
    if (isLanqiu) {
        
    }
	myTableView2 = [[UITableView alloc] initWithFrame:CGRectMake(320, 0, 320, self.mainView.bounds.size.height - 166) style:UITableViewStylePlain];
	myTableView2.backgroundColor = [UIColor clearColor];
	myTableView2.delegate = self;
	myTableView2.dataSource = self;
    [myTableView2 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[rootScroll addSubview:myTableView2];
	[myTableView2 release];
    
    
	myTableView3 = [[UITableView alloc] initWithFrame:CGRectMake(640, 0, 320, self.mainView.bounds.size.height - 166) style:UITableViewStylePlain];
	myTableView3.delegate = self;
	myTableView3.dataSource = self;
	myTableView3.backgroundColor = [UIColor clearColor];
    [myTableView3 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[rootScroll addSubview:myTableView3];
	[myTableView3 release];
    
    myTableView4 = [[UITableView alloc] initWithFrame:CGRectMake(960, 0, 320, self.mainView.bounds.size.height - 166) style:UITableViewStylePlain];
	myTableView4.delegate = self;
	myTableView4.dataSource = self;
	myTableView4.backgroundColor = [UIColor clearColor];
    [myTableView4 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[rootScroll addSubview:myTableView4];
	[myTableView4 release];
    
    //分析
    if (!isLanqiu) {
        UIImageView *bgimagevv = [[UIImageView alloc] initWithFrame:CGRectMake(96, 15, 30, 30)];
        
        bgimagevv.image = UIImageGetImageFromName(@"gc_xl_12_1.png");
        [self.mainView addSubview:bgimagevv];
        [bgimagevv release];
        
        UIButton *xiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        xiBtn.backgroundColor = [UIColor clearColor];
        xiBtn.frame = CGRectMake(91, 10, 40, 40);
        [xiBtn addTarget:self action:@selector(GoBafangYuCe) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:xiBtn];
    }
    else {
        myTableView2.frame = CGRectMake(320, 5, 320, self.mainView.bounds.size.height - 166);
        myTableView3.frame = CGRectMake(640, 5, 320, self.mainView.bounds.size.height - 166);
        myTableView4.frame = CGRectMake(960, 5, 320, self.mainView.bounds.size.height - 166);
        
    }
    
    UIImageView *imageViewT = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 26)];
	imageViewT.image = [UIImageGetImageFromName(@"bifenTitleBg.png") stretchableImageWithLeftCapWidth:1 topCapHeight:0];
	[self.mainView addSubview:imageViewT];
	[imageViewT release];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 100, 67, 26)];
	imageView.tag = 1101;
	imageView.image = UIImageGetImageFromName(@"bifenTitleSlect.png");
	[self.mainView addSubview:imageView];
	[imageView release];
    
    NSArray *array1 = [NSMutableArray arrayWithObjects:@"事件",@"欧赔",@"亚赔",@"大小",nil];
    if (isLanqiu) {
        array1 = [NSMutableArray arrayWithObjects:@"事件",@"欧赔",@"让分",@"大小",nil];
    }
	for (int i = 0; i < [array1 count]; i++) {
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = CGRectMake(i*80, 100, 80, 25);
		btn.tag = i;
		[self.mainView addSubview:btn];
		[btn addTarget:self action:@selector(scrollBtn:) forControlEvents:UIControlEventTouchUpInside];
	}
    

	for (int i = 0; i < [array1 count]; i++) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*80, 101, 80, 23)];
		[self.mainView addSubview:label];
		label.backgroundColor = [UIColor clearColor];
		label.text = [array1 objectAtIndex:i];
		label.textColor = [UIColor whiteColor];
		label.textAlignment = NSTextAlignmentCenter;
		[label release];
	}
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"BecomeActive" object:nil];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 重写ASIHTTPRequestDelegate

- (void)getMachInfoFinish:(ASIHTTPRequest *)requst {
    NSLog(@"%@",[requst responseString]);
    if ([[requst responseString] isEqualToString:@"fail"]) {
        return;
    }
    
    if (isLanqiu) {
        
        ScoreMacthInfo *info = [[ScoreMacthInfo alloc] initWithLanQiuParse:[requst responseString]];
        
        if (self.myMacthInfo) {
            [ScoreMacthInfo replaceOlde:self.myMacthInfo WithNew:info];
        }
        else {
            self.myMacthInfo = info;
            
        }
        if (self.myTimer) {
            [self.myTimer invalidate];
            self.myTimer = nil;
        }
        if ([self.myMacthInfo.refreshtime integerValue]) {
            self.myTimer = [NSTimer scheduledTimerWithTimeInterval:[self.myMacthInfo.refreshtime integerValue] target:self selector:@selector(refeshLanQiu) userInfo:nil repeats:YES];
        }
        else {
            self.myTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(refeshLanQiu) userInfo:nil repeats:YES];
        }
        
        
        if ([self.myMacthInfo.eventArray count] == 0 || [self.myMacthInfo.state isEqualToString:@"0"]) {
            myTableView1.hidden = YES;
            if (!noInfoImageV) {
                noInfoImageV = [[UIImageView alloc] initWithFrame:CGRectMake(111, 80, 97, 97)];
                noInfoImageV.image = UIImageGetImageFromName(@"noInfoImage.png");
                [rootScroll addSubview:noInfoImageV];
                [noInfoImageV release];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-20, 105, 137, 30)];
                label.backgroundColor = [UIColor clearColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.text = @"暂无比赛信息";
                label.font =  [UIFont boldSystemFontOfSize:16];
                [noInfoImageV addSubview:label];
                [label release];
            }
            noInfoImageV.hidden = NO;
        }
        else {
            myTableView1.hidden = NO;
            if (noInfoImageV) {
                noInfoImageV.hidden = YES;
            }
        }
        if (!xiaoxiBtn) {
            xiaoxiBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
            [self.mainView addSubview:xiaoxiBtn];
            xiaoxiBtn.frame = CGRectMake(274, self.mainView.bounds.size.height - 48, 36, 28);
            [xiaoxiBtn loadButonImage:@"xiaoxi.png" LabelName:@"···"];
            xiaoxiBtn.hightImage = UIImageGetImageFromName(@"xiaoxi2.png");
            [xiaoxiBtn addTarget:self action:@selector(goXiaoxi) forControlEvents:UIControlEventTouchUpInside];
            xiaoxiBtn.hidden = YES;
        }
        
        self.title = self.myMacthInfo.leagueName;
        homeLabel.text = [NSString stringWithFormat:@"%@ （主）",self.myMacthInfo.home];
        visitLabel.text = [NSString stringWithFormat:@"%@ （客）",self.myMacthInfo.away];
        timeLabel.text = self.myMacthInfo.matchTime;
        if (self.myMacthInfo.spWin) {
            peiLvLabe.text = [NSString stringWithFormat:@" %@ 欧赔 %@",self.myMacthInfo.spLose,self.myMacthInfo.spWin];
        }
        [self.dataDic setObject:self.myMacthInfo.asianDic forKey:@"asia"];
        [self.dataDic setObject:self.myMacthInfo.europeDic forKey:@"euro"];
        [self.dataDic setObject:self.myMacthInfo.over_downDic forKey:@"ball"];

        homeImageView.frame = CGRectMake(237, 17, 75, 60);
        homeBack.frame = CGRectMake(235, 15, 79, 64);
        visitImageView.frame = CGRectMake(12, 17, 75, 60);
        visitBack.frame = CGRectMake(10, 15, 79, 64);
        homeLabel.frame = CGRectMake(225, 85, 99, 11);
        visitLabel.frame = CGRectMake(0, 85, 99, 11);
        [homeImageView setImageWithURL:self.myMacthInfo.HostTeamFlag DefautImage:UIImageGetImageFromName(@"bifenzhiboZhulogo.png")];
        [visitImageView setImageWithURL:self.myMacthInfo.GuestTeamFlag DefautImage:UIImageGetImageFromName(@"bifenzhiboKelogo.png")];
        statueLabel.text= self.myMacthInfo.status;
        statueLabel.frame = CGRectMake(110, 35, 100, 20);
        statueLabel.textAlignment = NSTextAlignmentCenter;
        [myTableView1 reloadData];
        bifenLabel.frame = CGRectMake(110, 20, 100, 20);
        bifenLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.frame = CGRectMake(110, 50, 100, 15);
        if ([self.myMacthInfo.state isEqualToString:@"0"]) {
            bifenLabel.text = @"VS";
        }
        else {
            bifenLabel.text = [NSString stringWithFormat:@"%ld:%ld",(long)[self.myMacthInfo.awayHost integerValue],(long)[self.myMacthInfo.scoreHost integerValue]];
        }

        if (!myTableView1.tableHeaderView) {
            UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 300, 32)];
            imageV.image = [UIImageGetImageFromName(@"SZT960.png") stretchableImageWithLeftCapWidth:12 topCapHeight:14];
            [headV addSubview:imageV];
            [imageV.layer setMasksToBounds:YES];
            imageV.tag = 101;
            [imageV release];
            myTableView1.tableHeaderView =headV;
            [headV release];
        }
        if (!wenziLabel) {
            wenziLabel = [[UILabel alloc] init];
            wenziLabel.backgroundColor = [UIColor clearColor];
            wenziLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
            wenziLabel.textAlignment = NSTextAlignmentCenter;
            wenziLabel.font = [UIFont systemFontOfSize:12];
            wenziLabel.numberOfLines = 0;
            wenziLabel.frame = CGRectMake(0, 7, 300, 14);
            UIView *v = [myTableView1.tableHeaderView viewWithTag:101];
            [v addSubview:wenziLabel];
            [wenziLabel release];
        }
        
        if ([self.myMacthInfo.actiontxt length] && ![wenziLabel.text isEqualToString:self.myMacthInfo.actiontxt]) {
            wenziLabel.text = self.myMacthInfo.actiontxt;
            CGSize size1 = CGSizeMake(wenziLabel.bounds.size.width, 1000);
            CGSize size = [wenziLabel.text sizeWithFont:wenziLabel.font constrainedToSize:size1 lineBreakMode:wenziLabel.lineBreakMode];
            wenziLabel.superview.frame = CGRectMake(10, 5, 300, size.height + 16);
            
            wenziLabel.superview.superview.frame = CGRectMake(0, 0, 320, size.height + 29);
            myTableView1.tableHeaderView =wenziLabel.superview.superview;
            wenziLabel.frame = CGRectMake(0, wenziLabel.superview.frame.size.height, 300, size.height);
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:.5];
            wenziLabel.frame = CGRectMake(0, 7, 300, size.height);
            [UIView commitAnimations];
        }
        else if (![self.myMacthInfo.actiontxt length] && ![wenziLabel.text length]) {
            myTableView1.tableHeaderView = nil;
            wenziLabel = nil;
        }
        
        UIView *footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 78)];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 42)];
        imageV.image = [UIImageGetImageFromName(@"SZT-X-960.png") stretchableImageWithLeftCapWidth:15 topCapHeight:2];
        [footV addSubview:imageV];
        [imageV release];
        if ([self.myMacthInfo.eventArray count] == 0) {
            UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 10)];
            imageV2.image = [UIImageGetImageFromName(@"SZT-S-960.png") stretchableImageWithLeftCapWidth:15 topCapHeight:2];
            [footV addSubview:imageV2];
            imageV2.backgroundColor = self.mainView.backgroundColor;
            [imageV2 release];
        }
        myTableView1.tableFooterView = footV;
        [footV release];
        
        UILabel *fencha = [[UILabel alloc] init];
        fencha.backgroundColor = [UIColor clearColor];
        fencha.text = [NSString stringWithFormat:@"分差 %@",self.myMacthInfo.fencha];
        [footV addSubview:fencha];
        fencha.font = [UIFont systemFontOfSize:12];
        fencha.frame = CGRectMake(30, 10, 150, 14);
        [fencha release];
        UILabel *zongfen = [[UILabel alloc] init];
        zongfen.backgroundColor = [UIColor clearColor];
        zongfen.text = [NSString stringWithFormat:@"总分 %@",self.myMacthInfo.totleScroe];
        [footV addSubview:zongfen];
        zongfen.textAlignment = NSTextAlignmentCenter;
        zongfen.font = [UIFont systemFontOfSize:12];
        zongfen.frame = CGRectMake(85, 10, 150, 14);
        [zongfen release];
        
        if ([self.myMacthInfo.yushezongfen length]) {
            UILabel *yszfLabel = [[UILabel alloc] init];
            yszfLabel.backgroundColor = [UIColor clearColor];
            yszfLabel.text = [NSString stringWithFormat:@"预设总分 %@",self.myMacthInfo.yushezongfen];;
            [footV addSubview:yszfLabel];
            yszfLabel.textAlignment = NSTextAlignmentRight;
            yszfLabel.font = [UIFont systemFontOfSize:12];
            yszfLabel.frame = CGRectMake(190, 10, 100, 14);
            [yszfLabel release];
        }
        
        UILabel *infL = [[UILabel alloc] init];
        infL.backgroundColor = [UIColor clearColor];
        infL.text = @"以上数据仅供参考";
        [footV addSubview:infL];
        infL.textColor = [UIColor lightGrayColor];
        infL.textAlignment = NSTextAlignmentRight;
        infL.font = [UIFont systemFontOfSize:12];
        infL.frame = CGRectMake(160, 47, 150, 14);
        [infL release];
        
        [info release];
        [myTableView2 reloadData];
        [myTableView3 reloadData];
        [myTableView4 reloadData];
    }
    else {
        ScoreMacthInfo *info = [[ScoreMacthInfo alloc] initWithParse:[requst responseString]];
        self.myMacthInfo = info;
        [info release];
        homeLabel.text = self.myMacthInfo.home;
        visitLabel.text = self.myMacthInfo.away;
        timeLabel.text = self.myMacthInfo.matchTime;
        if ([self.myMacthInfo.spWin length]) {
            peiLvLabe.text = [NSString stringWithFormat:@"竞彩赔率 %@ %@ %@",self.myMacthInfo.spWin,self.myMacthInfo.spEqual,self.myMacthInfo.spLose];
        }
        [homeImageView setImageWithURL:self.myMacthInfo.HostTeamFlag DefautImage:UIImageGetImageFromName(@"bifenzhiboZhulogo.png")];
        [visitImageView setImageWithURL:self.myMacthInfo.GuestTeamFlag DefautImage:UIImageGetImageFromName(@"bifenzhiboKelogo.png")];
        statueLabel.text= self.myMacthInfo.status;
        
        [myTableView1 reloadData];

        bifenLabel.text = [NSString stringWithFormat:@"%@:%@",self.myMacthInfo.scoreHost,self.myMacthInfo.awayHost];
        
        UIView *footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 78)];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 45)];
        imageV.image = [UIImageGetImageFromName(@"SZT-X-960.png") stretchableImageWithLeftCapWidth:15 topCapHeight:2];
        [footV addSubview:imageV];
        [imageV release];
        if ([self.myMacthInfo.eventArray count] == 0) {
            UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 10)];
            imageV2.image = [UIImageGetImageFromName(@"SZT-S-960.png") stretchableImageWithLeftCapWidth:15 topCapHeight:2];
            [footV addSubview:imageV2];
            imageV2.backgroundColor = self.mainView.backgroundColor;
            [imageV2 release];
        }
        myTableView1.tableFooterView = footV;
        UILabel *infL = [[UILabel alloc] init];
        infL.backgroundColor = [UIColor clearColor];
        infL.text = @"以上数据仅供参考";
        [footV addSubview:infL];
        infL.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
        infL.font = [UIFont systemFontOfSize:12];
        infL.frame = CGRectMake(10, 50, 150, 14);
        [infL release];
        if ([self.scoreInfo.section_id length]) {
            UIButton *pptVBTn = [UIButton buttonWithType:UIButtonTypeCustom];
            [footV addSubview:pptVBTn];
            pptVBTn.frame = CGRectMake(252, 50, 58, 25);
            [pptVBTn addTarget:self action:@selector(goPPTV) forControlEvents:UIControlEventTouchUpInside];
            [pptVBTn setImage:UIImageGetImageFromName(@"zhibopptv1.png") forState:UIControlStateNormal];
            [pptVBTn setImage:UIImageGetImageFromName(@"zhibopptv2.png") forState:UIControlStateHighlighted];
        }
        
        NSArray *array = [NSArray arrayWithObjects:@":进球",@":点球",@":乌龙",@":黄牌",@":红牌" ,nil];
        for (int i = 0; i < [array count]; i ++) {
            UIImageView *imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(16 + 55 * i, 16, 14, 14)];
            [imageV addSubview:imageIcon];
            imageIcon.image = [ScoreMachInfoCell returnImageByType:i];
            [imageIcon release];
            
            UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(32 + 55 *i, 16, 40, 14)];
            nameL.text = [array objectAtIndex:i];
            nameL.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
            [imageV addSubview:nameL];
            nameL.font = [UIFont systemFontOfSize:9];
            nameL.backgroundColor = [UIColor clearColor];
            [nameL release];
            
        }
        [footV release];
    }

}

- (void)getMachInfoFaild:(ASIHTTPRequest *)requst {

}

#pragma mark Action

- (void)goXiaoxi {
    if ([[[Info getInstance] userId] intValue] == 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
        return;
    }
    TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:[NSString stringWithFormat:@"#%@VS%@#",self.myMacthInfo.home,self.myMacthInfo.away]];
    topicThemeListVC.cpsanliu = CpSanLiuWuyes;
    topicThemeListVC.jinnang = NO;
    [self.navigationController pushViewController:topicThemeListVC animated:YES];
    [topicThemeListVC release];
}

- (void)goPPTV {
     NSURL *pptvURL = [NSURL URLWithString:[NSString stringWithFormat:@"pptvsports://from=caipiao365&sectionid=%@",self.scoreInfo.section_id]];
    if ([[UIApplication sharedApplication] canOpenURL:pptvURL]) {
        [[UIApplication sharedApplication] openURL:pptvURL];
    }
    else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/pptv/id627781309?mt=8"]];
    }
}

- (void)refeshLanQiu {
    self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBsynlanqiuLiveMatchDetailWithIssue:self.scoreInfo.issue PlayId:self.scoreInfo.matchId]];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDelegate:self];
    [mRequest setDidFinishSelector:@selector(getMachInfoFinish:)];
    [mRequest setDidFailSelector:@selector(getMachInfoFaild:)];
    [mRequest setNumberOfTimesToRetryOnTimeout:2];
    [mRequest startAsynchronous];
}

- (void)getMachInfo {
    if (isLanqiu) {
        self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlanqiuLiveMatchDetailWithIssue:self.scoreInfo.issue PlayId:self.scoreInfo.matchId]];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest setDelegate:self];
        [mRequest setDidFinishSelector:@selector(getMachInfoFinish:)];
        [mRequest setDidFailSelector:@selector(getMachInfoFaild:)];
        [mRequest setNumberOfTimesToRetryOnTimeout:2];
        [mRequest startAsynchronous];
    }
    else {
        self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetMatchInfo:[[Info getInstance] userId] MatchId:self.scoreInfo.matchId LotteryId:scoreInfo.lotteryId Issue:scoreInfo.issue]];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest setDelegate:self];
        [mRequest setDidFinishSelector:@selector(getMachInfoFinish:)];
        [mRequest setDidFailSelector:@selector(getMachInfoFaild:)];
        [mRequest setNumberOfTimesToRetryOnTimeout:2];
        [mRequest startAsynchronous];
    }
    
}

- (void)scrollBtn:(UIButton *)btn {
	UIView *v = [self.mainView viewWithTag:1101];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	v.center = btn.center;
	[UIView commitAnimations];
	
	[rootScroll scrollRectToVisible:CGRectMake(btn.tag *320, 0, 320, 320) animated:NO];
    if (btn.tag == 0) {
            [self getMachInfo];
        
    }
    else if (btn.tag == 1) {
        if (![dataDic objectForKey:@"euro"]) {
            [self refreshEURO];
        }
        
    }
    else if (btn.tag == 2) {
        if (![dataDic objectForKey:@"asia"]) {
            [self refreshASIA];
        }
        
    }
    else if (btn.tag == 3) {
        if ((![dataDic objectForKey:@"ball"])) {
            [self refreshBall];
        }
    }
}

- (void)GoBafangYuCe {
    if ([[[Info getInstance] userId] integerValue] == 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
        return;
    }
    
    NewAroundViewController *new = [[NewAroundViewController alloc] init];
    new.playID = self.scoreInfo.matchId;
    [self.navigationController pushViewController:new animated:YES];
    [new release];
}


- (void)doBack {
    [self.navigationController popViewControllerAnimated: YES];
}

- (void)refresh {
    [UIApplication sharedApplication].idleTimerDisabled=YES;
    if (isLanqiu) {
        [self getMachInfo];
    }
    else if (rootScroll.contentOffset.x == 0) {
        [self getMachInfo];
    }
    else if (rootScroll.contentOffset.x == 320) {
            [self refreshEURO];
        
    }
    else if (rootScroll.contentOffset.x == 640) {
            [self refreshASIA];
    }
    else if (rootScroll.contentOffset.x == 960) {
            [self refreshBall];
    }
}

//大小分
- (void)refreshBall {
    if (self.dataDic ) {
        
		[self.peiLvRequest clearDelegatesAndCancel];
		self.peiLvRequest = nil;
		self.peiLvRequest = [ASIHTTPRequest requestWithURL:[NetURL refreshBall:self.scoreInfo.matchId]];
		[peiLvRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [peiLvRequest setDelegate:self];
        [peiLvRequest setDidFinishSelector:@selector(BallFinish:)];
        [peiLvRequest startAsynchronous];
	}
}

- (void)refreshASIA {
    if (self.dataDic ) {

		[self.peiLvRequest clearDelegatesAndCancel];
		self.peiLvRequest = nil;
		self.peiLvRequest = [ASIHTTPRequest requestWithURL:[NetURL refreshASIA:self.scoreInfo.matchId]];
		[peiLvRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [peiLvRequest setDelegate:self];
        [peiLvRequest setDidFinishSelector:@selector(ASIAFinish:)];
        [peiLvRequest startAsynchronous];
	}
}

- (void)refreshEURO {
    if (self.dataDic ) {
		[self.peiLvRequest clearDelegatesAndCancel];
		self.peiLvRequest = nil;
		self.peiLvRequest = [ASIHTTPRequest requestWithURL:[NetURL refreshEURO:self.scoreInfo.matchId]];
		[peiLvRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [peiLvRequest setDelegate:self];
        [peiLvRequest setDidFinishSelector:@selector(EUROFinish:)];
        [peiLvRequest startAsynchronous];
	}
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate


- (void)requestFailed:(ASIHTTPRequest *)request {
}

- (void)ASIAFinish:(ASIHTTPRequest *)request {
	NSString *responseStr = [request responseString];
    [self.dataDic setValue:[[NSMutableDictionary dictionaryWithDictionary:[responseStr JSONValue]] objectForKey:@"asia"] forKey:@"asia"];
    [myTableView3 reloadData];
}

- (void)EUROFinish:(ASIHTTPRequest *)request {
	NSString *responseStr = [request responseString];
    [self.dataDic setValue:[[NSMutableDictionary dictionaryWithDictionary:[responseStr JSONValue]] objectForKey:@"euro"] forKey:@"euro"];
    [myTableView2 reloadData];
}

- (void)BallFinish:(ASIHTTPRequest *)request {
	NSString *responseStr = [request responseString];
    [self.dataDic setValue:[[NSMutableDictionary dictionaryWithDictionary:[responseStr JSONValue]] objectForKey:@"ball"] forKey:@"ball"];
    [myTableView4 reloadData];
}

#pragma mark -
#pragma mark Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (tableView == myTableView1) {
        return [self.myMacthInfo.eventArray count];
	}
	if (tableView == myTableView2) {
        if (isLanqiu) {
            return [[dataDic objectForKey:@"euro"] count]+1;
        }
        else {
            NSArray *array1 = [[[dataDic objectForKey:@"euro"] objectAtIndex:0] objectForKey:@"companyList"];
            if ([array1 isKindOfClass:[NSArray class]]) {
                NSArray *array = [[array1 objectAtIndex:0] objectForKey:@"c"];
                return [array count]+1;
            }
        }
		
		return 0;
	}
	if (tableView == myTableView3) {
        if (isLanqiu) {
            return [[dataDic objectForKey:@"asia"] count]+1;
        }
        else {
            NSArray *array1 = [[[dataDic objectForKey:@"asia"] objectAtIndex:0] objectForKey:@"companyList"];
            if ([array1 isKindOfClass:[NSArray class]]) {
                NSArray *array = [[array1 objectAtIndex:0] objectForKey:@"c"];
                return [array count]+1;
            }
        }
		
		return 0;
	}
    if (tableView == myTableView4) {
        if (isLanqiu) {
            return [[dataDic objectForKey:@"ball"] count]+1;
        }
        else {
            NSArray *array1 = [[[dataDic objectForKey:@"ball"] objectAtIndex:0] objectForKey:@"companyList"];
            if ([array1 isKindOfClass:[NSArray class]]) {
                NSArray *array = [[array1 objectAtIndex:0] objectForKey:@"c"];
                return [array count]+1;
            }
        }
		
		return 0;
	}
	return 0;
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (tableView == myTableView1) {
        static NSString *CellIdentifier1 = @"MatchCell";
		ScoreMachInfoCell *cell1 = (ScoreMachInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (!cell1) {
			cell1 = [[[ScoreMachInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
            cell1.isLanqiu = self.isLanqiu;
			
		}
        [cell1 LoadMacthInfo:[self.myMacthInfo.eventArray objectAtIndex:indexPath.row] Row:indexPath.row];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
		return cell1;
	}else if (tableView == myTableView2) {
		static NSString *CellIdentifier1 = @"EuCell";
		AsEuCell *cell1 = (AsEuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (!cell1) {
			cell1 = [[[AsEuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
            cell1.isLanQiu = self.isLanqiu;
            cell1.isOuPei = YES;
		}
        if (isLanqiu) {
            NSDictionary *dic = [dataDic objectForKey:@"euro"];
            if (indexPath.row == 0) {
                [cell1 LoadData:nil isTitle:YES CId:nil isFoot:NO isBianHua:NO];
            }
            else {
                NSArray *array = [dic allKeys];
                NSDictionary *dic2 = myMacthInfo.europe_changeDic;
                if (indexPath.row == [array count]) {
                    
                    [cell1 LoadData:[dic objectForKey:[array objectAtIndex:indexPath.row -1]] isTitle:NO CId:[array objectAtIndex:indexPath.row -1] isFoot:YES isBianHua:[[dic2 objectForKey:[array objectAtIndex:indexPath.row -1]] count] > 1];
                }
                else if (indexPath.row -1< [dic count]) {
                    [cell1 LoadData:[dic objectForKey:[array objectAtIndex:indexPath.row -1]] isTitle:NO CId:[array objectAtIndex:indexPath.row -1] isFoot:NO isBianHua:[[dic2 objectForKey:[array objectAtIndex:indexPath.row -1]] count] > 1];
                }
                else {
                    [cell1 LoadData:nil isTitle:NO];
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    return cell;
                }
            }
        }
        else {
            NSArray *array = [[[[[dataDic objectForKey:@"euro"] objectAtIndex:0] objectForKey:@"companyList"] objectAtIndex:0] objectForKey:@"c"];
            if (indexPath.row == 0) {
                [cell1 LoadData:nil isTitle:YES];
            }
            else {
                if (indexPath.row -1< [array count]) {
                    [cell1 LoadData:[array objectAtIndex:indexPath.row -1] isTitle:NO];
                }
                else {
                    [cell1 LoadData:nil isTitle:NO];
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    return cell;
                }
            }
        }
		
		return cell1;
	}
	else if (tableView == myTableView3) {
		static NSString *CellIdentifier1 = @"asCell";
		AsEuCell *cell1 = (AsEuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (!cell1) {
			cell1 = [[[AsEuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
            cell1.isLanQiu = self.isLanqiu;
			
		}
        if (isLanqiu) {
            NSDictionary *dic = [dataDic objectForKey:@"asia"];
            if (indexPath.row == 0) {
                [cell1 LoadData:nil isTitle:YES CId:nil isFoot:NO isBianHua:NO];
            }
            else {
                NSArray *array = [dic allKeys];
                NSDictionary *dic2 = myMacthInfo.asian_changeDic;
                if (indexPath.row == [array count]) {
                    
                    [cell1 LoadData:[dic objectForKey:[array objectAtIndex:indexPath.row -1]] isTitle:NO CId:[array objectAtIndex:indexPath.row -1] isFoot:YES isBianHua:[[dic2 objectForKey:[array objectAtIndex:indexPath.row -1]] count] > 1];
                }
                else if (indexPath.row -1< [dic count]) {
                    [cell1 LoadData:[dic objectForKey:[array objectAtIndex:indexPath.row -1]] isTitle:NO CId:[array objectAtIndex:indexPath.row -1] isFoot:NO isBianHua:[[dic2 objectForKey:[array objectAtIndex:indexPath.row -1]] count] > 1];
                }
                else {
                    [cell1 LoadData:nil isTitle:NO];
                    cell1.contentView.backgroundColor = [UIColor whiteColor];
                    return cell1;
                }
            }
        }
        else {
            NSArray *array = [[[[[dataDic objectForKey:@"asia"] objectAtIndex:0] objectForKey:@"companyList"] objectAtIndex:0] objectForKey:@"c"];
            if (indexPath.row == 0) {
                [cell1 LoadData:nil isTitle:YES];
            }
            else {
                if (indexPath.row -1 < [array count]) {
                    [cell1 LoadData:[array objectAtIndex:indexPath.row -1] isTitle:NO];
                }
                else {
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    return cell;
                }
            }
        }
		
		return cell1;
	}
    else if (tableView == myTableView4) {
		static NSString *CellIdentifier1 = @"ballCell";
		AsEuCell *cell1 = (AsEuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (!cell1) {
			cell1 = [[[AsEuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
            cell1.isLanQiu = self.isLanqiu;
			
		}
        if (isLanqiu) {
            
            NSDictionary *dic = [dataDic objectForKey:@"ball"];
            if (indexPath.row == 0) {
                [cell1 LoadData:nil isTitle:YES CId:nil isFoot:NO isBianHua:NO];
            }
            else {
                NSArray *array = [dic allKeys];
                NSDictionary *dic2 = myMacthInfo.over_down_changeDic;
                if (indexPath.row == [array count]) {
                    
                    [cell1 LoadData:[dic objectForKey:[array objectAtIndex:indexPath.row -1]] isTitle:NO CId:[array objectAtIndex:indexPath.row -1] isFoot:YES isBianHua:[[dic2 objectForKey:[array objectAtIndex:indexPath.row -1]] count] > 1];
                }
                else if (indexPath.row -1< [dic count]) {
                    [cell1 LoadData:[dic objectForKey:[array objectAtIndex:indexPath.row -1]] isTitle:NO CId:[array objectAtIndex:indexPath.row -1] isFoot:NO isBianHua:[[dic2 objectForKey:[array objectAtIndex:indexPath.row -1]] count] > 1];
                }
                else {
                    [cell1 LoadData:nil isTitle:NO];
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    return cell;
                }
            }
        }
        else {
            NSArray *array = [[[[[dataDic objectForKey:@"ball"] objectAtIndex:0] objectForKey:@"companyList"] objectAtIndex:0] objectForKey:@"c"];
            if (indexPath.row == 0) {
                [cell1 LoadData:nil isTitle:YES];
            }
            else {
                if (indexPath.row -1 < [array count]) {
                    [cell1 LoadData:[array objectAtIndex:indexPath.row -1] isTitle:NO];
                }
                else {
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    return cell;
                }
            }
        }
		return cell1;
	}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 33;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isLanqiu) {
        if (tableView == myTableView2) {
            if (indexPath.row >= 1) {
                NSDictionary *dic = [dataDic objectForKey:@"euro"];
                NSArray *array = [dic allKeys];
                NSDictionary *dic2 = myMacthInfo.europe_changeDic;
                NSArray *array2 = [dic2 objectForKey:[array objectAtIndex:indexPath.row -1]];
                if ([array2 count]) {
                    PeiLvChangeViewController *info = [[PeiLvChangeViewController alloc] init];
                    info.myMacthInfo = self.myMacthInfo;
                    info.dataArray = array2;
                    info.isOuPei = YES;
                    info.cid = [array objectAtIndex:indexPath.row -1];
                    [self.navigationController pushViewController:info animated:YES];
                    [info release];
                }
            }
            
        }
        else if (tableView == myTableView3) {
            NSDictionary *dic = [dataDic objectForKey:@"asia"];
            NSArray *array = [dic allKeys];
            NSDictionary *dic2 = myMacthInfo.asian_changeDic;
            NSArray *array2 = [dic2 objectForKey:[array objectAtIndex:indexPath.row -1]];
            if ([array2 count]) {
                PeiLvChangeViewController *info = [[PeiLvChangeViewController alloc] init];
                info.myMacthInfo = self.myMacthInfo;
                info.dataArray = array2;
                info.isOuPei = NO;
                info.cid = [array objectAtIndex:indexPath.row -1];
                [self.navigationController pushViewController:info animated:YES];
                [info release];
            }
            
        }
        else if (tableView == myTableView4) {
            NSDictionary *dic = [dataDic objectForKey:@"ball"];
            NSArray *array = [dic allKeys];
            NSDictionary *dic2 = myMacthInfo.over_down_changeDic;
            NSArray *array2 = [dic2 objectForKey:[array objectAtIndex:indexPath.row -1]];
            if ([array2 count]) {
                PeiLvChangeViewController *info = [[PeiLvChangeViewController alloc] init];
                info.myMacthInfo = self.myMacthInfo;
                info.isOuPei = NO;
                info.dataArray = array2;
                info.cid = [array objectAtIndex:indexPath.row -1];
                [self.navigationController pushViewController:info animated:YES];
                [info release];
            }
            
        }
    }
}


//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//	if (scrollView == rootScroll) {
//		UIView *v = [self.mainView viewWithTag:1101];
//		[UIView setAnimationDuration:0.5];
//		NSLog(@"%f",scrollView.contentOffset.x);
//		v.frame = CGRectMake(scrollView.contentOffset.x/4 + 6, v.frame.origin.y, v.frame.size.width, v.frame.size.height);
//		[UIView commitAnimations];
//        if (scrollView.contentOffset.x == 0) {
//            [self getMachInfo];
//        }
//        else if (scrollView.contentOffset.x == 320) {
//            if (![dataDic objectForKey:@"euro"]) {
//                [self refreshEURO];
//            }
//
//        }
//        else if (scrollView.contentOffset.x == 640) {
//            if (![dataDic objectForKey:@"asia"]) {
//                [self refreshASIA];
//            }
//
//        }
//        else if (scrollView.contentOffset.x == 960) {
//            if ((![dataDic objectForKey:@"ball"])) {
//                [self refreshBall];
//            }
//        }
//	}
//    
//}

- (void)dealloc{
    [mRequest clearDelegatesAndCancel];
    self.mRequest = nil;
    [peiLvRequest clearDelegatesAndCancel];
    self.peiLvRequest = nil;
    self.scoreInfo = nil;
    self.myMacthInfo = nil;
    self.dataDic = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BecomeActive" object:nil];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    