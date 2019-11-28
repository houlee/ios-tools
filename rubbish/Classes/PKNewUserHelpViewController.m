//
//  PKNewUserHelpViewController.m
//  caibo
//
//  Created by cp365dev6 on 15/1/19.
//
//

#import "PKNewUserHelpViewController.h"

@interface PKNewUserHelpViewController ()

@end

@implementation PKNewUserHelpViewController

@synthesize request;
@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = leftItem;
    //    self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30)];
    self.CP_navigation.title = @"PK赛新手帮助";
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
    
    [self loadIphoneView];
}
-(void)loadFirstView
{
    isUp = YES;
    scroView = [[UIScrollView alloc]init];
    scroView.backgroundColor = [UIColor clearColor];
    scroView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height - 44);
    scroView.delegate = self;
    scroView.contentSize = CGSizeMake(scroView.frame.size.width, scroView.frame.size.height+0.5);
    [self.mainView addSubview:scroView];
    [scroView release];
    
    firstView = [[UIView alloc]init];
    //    firstView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height - 44);
    firstView.frame = scroView.bounds;
    //    firstView.contentSize = CGSizeMake(firstView.frame.size.width, firstView.frame.size.height+0.5);
    //    firstView.userInteractionEnabled = YES;
    firstView.backgroundColor = [UIColor colorWithRed:239/255.0 green:238/255.0 blue:226/255.0 alpha:1];
    [scroView addSubview:firstView];
    [firstView release];
    
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor colorWithRed:239/255.0 green:238/255.0 blue:226/255.0 alpha:1];
    headView.frame = CGRectMake(0, firstView.frame.origin.y - 400, firstView.frame.size.width, 400);
    [firstView addSubview:headView];
    [headView release];
    
    //    UIScrollView *scroView = [[UIScrollView alloc]init];
    //    scroView.backgroundColor = [UIColor clearColor];
    //    scroView.frame = firstView.bounds;
    //    scroView.contentSize = CGSizeMake(firstView.frame.size.width, firstView.frame.size.height+0.5);
    //    [scroView addSubview:firstView];
    //    [scroView release];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(10, 15, firstView.frame.size.width - 20, 25);
    lab.backgroundColor = [UIColor clearColor];
    lab.text = @"竞猜比赛的胜、平、负，比赛的销售时间一";
    lab.font = [UIFont systemFontOfSize:15];
    lab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [firstView addSubview:lab];
    [lab release];
    UILabel *lab1 = [[UILabel alloc]init];
    lab1.frame = CGRectMake(10, 40, firstView.frame.size.width - 20, 25);
    lab1.backgroundColor = [UIColor clearColor];
    lab1.text = @"般会在该场比赛临近开赛前截止。";
    lab1.font = [UIFont systemFontOfSize:15];
    lab1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [firstView addSubview:lab1];
    [lab1 release];
    
    UIImageView *saishiIma = [[UIImageView alloc]init];
    saishiIma.frame = CGRectMake(10, 80, firstView.frame.size.width - 20, 65);
    saishiIma.backgroundColor = [UIColor whiteColor];
    [firstView addSubview:saishiIma];
    [saishiIma release];
    
    UIImageView *line1 = [[UIImageView alloc]init];
    line1.frame = CGRectMake(0, 0, saishiIma.frame.size.width, 0.5);
    line1.backgroundColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    [saishiIma addSubview:line1];
    [line1 release];
    UIImageView *line2 = [[UIImageView alloc]init];
    line2.frame = CGRectMake(0, 65, saishiIma.frame.size.width, 0.5);
    line2.backgroundColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    [saishiIma addSubview:line2];
    [line2 release];
    UIImageView *line11 = [[UIImageView alloc]init];
    line11.frame = CGRectMake(0, 0, 0.5, 65);
    line11.backgroundColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    [saishiIma addSubview:line11];
    [line11 release];
    UIImageView *line12 = [[UIImageView alloc]init];
    line12.frame = CGRectMake(62.5, 0, 0.5, 65);
    line12.backgroundColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    [saishiIma addSubview:line12];
    [line12 release];
    UIImageView *line13 = [[UIImageView alloc]init];
    line13.frame = CGRectMake(62.5+93, 0, 0.5, 65);
    line13.backgroundColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    [saishiIma addSubview:line13];
    [line13 release];
    UIImageView *line14 = [[UIImageView alloc]init];
    line14.frame = CGRectMake(62.5+93+51.5, 0, 0.5, 65);
    line14.backgroundColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    [saishiIma addSubview:line14];
    [line14 release];
    UIImageView *line15 = [[UIImageView alloc]init];
    line15.frame = CGRectMake(62.5+93+51.5+93, 0, 0.5, 65);
    line15.backgroundColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    [saishiIma addSubview:line15];
    [line15 release];
    
    UILabel *changciLab = [[UILabel alloc]init];
    changciLab.frame = CGRectMake(0, 0, 62.5, 22);
    changciLab.backgroundColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    changciLab.text = @"场次号";
    changciLab.textColor = [UIColor whiteColor];
    changciLab.font = [UIFont systemFontOfSize:14];
    changciLab.textAlignment = NSTextAlignmentCenter;
    [saishiIma addSubview:changciLab];
    [changciLab release];
    
    UILabel *liansaiLab = [[UILabel alloc]init];
    liansaiLab.frame = CGRectMake(0, 25, 62.5, 20);
    liansaiLab.backgroundColor = [UIColor clearColor];
    liansaiLab.text = @"联赛";
    liansaiLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    liansaiLab.font = [UIFont systemFontOfSize:12];
    liansaiLab.textAlignment = NSTextAlignmentCenter;
    [saishiIma addSubview:liansaiLab];
    [liansaiLab release];
    
    UILabel *timeLab = [[UILabel alloc]init];
    timeLab.frame = CGRectMake(0, 45, 62.5, 15);
    timeLab.backgroundColor = [UIColor clearColor];
    timeLab.text = @"停售时间";
    timeLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    timeLab.font = [UIFont systemFontOfSize:12];
    timeLab.textAlignment = NSTextAlignmentCenter;
    [saishiIma addSubview:timeLab];
    [timeLab release];
    
    UILabel *homeLab = [[UILabel alloc]init];
    homeLab.frame = CGRectMake(62.5, 0, 93, 35);
    homeLab.backgroundColor = [UIColor clearColor];
    homeLab.text = @"主队";
    homeLab.textColor = [UIColor colorWithRed:254/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    homeLab.font = [UIFont systemFontOfSize:14];
    homeLab.textAlignment = NSTextAlignmentCenter;
    [saishiIma addSubview:homeLab];
    [homeLab release];
    
    UILabel *VSLab = [[UILabel alloc]init];
    VSLab.frame = CGRectMake(62.5+93, 0, 51.5, 35);
    VSLab.backgroundColor = [UIColor clearColor];
    VSLab.text = @"VS";
    VSLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    VSLab.font = [UIFont systemFontOfSize:14];
    VSLab.textAlignment = NSTextAlignmentCenter;
    [saishiIma addSubview:VSLab];
    [VSLab release];
    
    UILabel *keduiLab = [[UILabel alloc]init];
    keduiLab.frame = CGRectMake(62.5+93+51.5, 0, 93, 35);
    keduiLab.backgroundColor = [UIColor clearColor];
    keduiLab.text = @"客队";
    keduiLab.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    keduiLab.font = [UIFont systemFontOfSize:14];
    keduiLab.textAlignment = NSTextAlignmentCenter;
    [saishiIma addSubview:keduiLab];
    [keduiLab release];
    
    UILabel *homeLab1 = [[UILabel alloc]init];
    homeLab1.frame = CGRectMake(62.5, 35, 93, 30);
    homeLab1.backgroundColor = [UIColor clearColor];
    homeLab1.text = @"主队胜赔率";
    homeLab1.textColor = [UIColor colorWithRed:254/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    homeLab1.font = [UIFont systemFontOfSize:12];
    homeLab1.textAlignment = NSTextAlignmentCenter;
    [saishiIma addSubview:homeLab1];
    [homeLab1 release];
    
    UILabel *VSLab1 = [[UILabel alloc]init];
    VSLab1.frame = CGRectMake(62.5+93, 35, 51.5, 30);
    VSLab1.backgroundColor = [UIColor clearColor];
    VSLab1.text = @"平赔率";
    VSLab1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    VSLab1.font = [UIFont systemFontOfSize:12];
    VSLab1.textAlignment = NSTextAlignmentCenter;
    [saishiIma addSubview:VSLab1];
    [VSLab1 release];
    
    UILabel *keduiLab1 = [[UILabel alloc]init];
    keduiLab1.frame = CGRectMake(62.5+93+51.5, 35, 93, 30);
    keduiLab1.backgroundColor = [UIColor clearColor];
    keduiLab1.text = @"主队负赔率";
    keduiLab1.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    keduiLab1.font = [UIFont systemFontOfSize:12];
    keduiLab1.textAlignment = NSTextAlignmentCenter;
    [saishiIma addSubview:keduiLab1];
    [keduiLab1 release];
    
    UIImageView *jiantouIma = [[UIImageView alloc]init];
    jiantouIma.frame = CGRectMake(118, saishiIma.frame.origin.y + saishiIma.frame.size.height + 4, 146, 75);
    jiantouIma.backgroundColor = [UIColor clearColor];
    jiantouIma.image = [UIImage imageNamed:@"PKjiantou.png"];
    [firstView addSubview:jiantouIma];
    [jiantouIma release];
    
    UIImageView *lvseIma = [[UIImageView alloc]init];
    lvseIma.frame = CGRectMake(72, jiantouIma.frame.origin.y + 75 + 6, 238, 75);
    lvseIma.backgroundColor = [UIColor clearColor];
    lvseIma.image = [UIImage imageNamed:@"PKlvsetanchuang.png"];
    [firstView addSubview:lvseIma];
    [lvseIma release];
    UILabel *lvseLab = [[UILabel alloc]init];
    lvseLab.frame = CGRectMake(10, 10, lvseIma.frame.size.width - 20, lvseIma.frame.size.height - 20);
    lvseLab.backgroundColor = [UIColor clearColor];
    lvseLab.text = @"我叫赔率是由官方公布的，投注截止之前我可能会随时变化！别小看我，我可是计算奖金的依据！";
    lvseLab.font = [UIFont systemFontOfSize:14];
    lvseLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    lvseLab.numberOfLines = 0;
    [lvseIma addSubview:lvseLab];
    [lvseLab release];
    
    huadongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    huadongBtn.backgroundColor = [UIColor clearColor];
    huadongBtn.hidden = YES;
    huadongBtn.frame = CGRectMake(100, firstView.frame.size.height - 50, 120, 50);
    [huadongBtn addTarget:self action:@selector(yincangShouye) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:huadongBtn];
    huadongIma = [[UIImageView alloc]init];
    huadongIma.frame = CGRectMake((firstView.frame.size.width - 19)/2, firstView.frame.size.height - 45, 19, 15);
    huadongIma.hidden = YES;
    huadongIma.backgroundColor = [UIColor clearColor];
    huadongIma.image = [UIImage imageNamed:@"PKhuadongjiantou.png"];
    [firstView addSubview:huadongIma];
    [huadongIma release];
    huadongLab = [[UILabel alloc]init];
    huadongLab.frame = CGRectMake((firstView.frame.size.width - 80)/2, huadongIma.frame.origin.y + 15, 80, 30);
    huadongLab.backgroundColor = [UIColor clearColor];
    huadongLab.text = @"向上滑动";
    huadongLab.hidden = YES;
    huadongLab.textAlignment = NSTextAlignmentCenter;
    huadongLab.font = [UIFont systemFontOfSize:12];
    huadongLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [firstView addSubview:huadongLab];
    [huadongLab release];
    
    [self performSelector:@selector(xianshiUpHuadong) withObject:self afterDelay:2];
    
}
-(void)yincangShouye
{
    if(isUp)
    {
        [UIView animateWithDuration:0.3 animations:^{
            scroView.frame = CGRectMake(0, -scroView.frame.size.height, scroView.frame.size.width, scroView.frame.size.height);
        } completion:^(BOOL finished) {
//            castButton.alpha = 1;
//            castButton.enabled = YES;
            [self performSelector:@selector(yichuView) withObject:self afterDelay:2];
        }];
        isUp = NO;
    }
}
-(void)xianshiUpHuadong
{
    huadongIma.hidden = NO;
    huadongLab.hidden = NO;
    huadongBtn.hidden = NO;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"contentOffset.y=%f",scrollView.contentOffset.y);
    if(scrollView.contentOffset.y > 50 && scrollView == scroView)
    {
        if(isUp)
        {
            [UIView animateWithDuration:0.3 animations:^{
                scroView.frame = CGRectMake(0, -scroView.frame.size.height, scroView.frame.size.width, scroView.frame.size.height);
            } completion:^(BOOL finished) {
                //            [scroView removeFromSuperview];
//                castButton.alpha = 1;
//                castButton.enabled = YES;
                [self performSelector:@selector(yichuView) withObject:self afterDelay:2];
            }];
            isUp = NO;
        }
    }
}
-(void)yichuView
{
    [scroView removeFromSuperview];
}

-(void)loadIphoneView
{
    qipao = 1;
    
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    zhushuDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    cellarray = [[NSMutableArray alloc]initWithCapacity:0];
    chuantype = [[NSMutableArray alloc]initWithCapacity:0];
    erChaifenArym = [[NSMutableArray alloc]initWithCapacity:0];
    sanChaifenArym = [[NSMutableArray alloc]initWithCapacity:0];
    chuanfaArym = [[NSMutableArray alloc]initWithCapacity:0];
    
    myTableView = [[CP_CanOpenTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height -44) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:myTableView];
    [myTableView release];
    [self tabBarView];//下面长方块view 确定投注的view
    
    footerView = [[UIView alloc]init];
    footerView.frame = CGRectMake(0, 0, 320, 100);
    footerView.backgroundColor = [UIColor clearColor];
    myTableView.tableFooterView = footerView;
    
    erchuanView = [[UIView alloc]init];
    erchuanView.frame = CGRectMake(10, 15, 300, 20);
    erchuanView.backgroundColor = [UIColor clearColor];
    [footerView addSubview:erchuanView];
    
    sanchuanView = [[UIView alloc]init];
    sanchuanView.frame = CGRectMake(10, 15 + erchuanView.frame.size.height + 15, 300, 20);
    sanchuanView.backgroundColor = [UIColor clearColor];
    [footerView addSubview:sanchuanView];
    
    
    erChuanLab = [[UILabel alloc]init];
    erChuanLab.frame = CGRectMake(0, 0, 200, 20);
    erChuanLab.backgroundColor = [UIColor clearColor];
    erChuanLab.text = @"【2串1】 0注";
    erChuanLab.tag = 100;
    erChuanLab.textColor = [UIColor blackColor];
    erChuanLab.font = [UIFont systemFontOfSize:15];
    [erchuanView addSubview:erChuanLab];
    [erChuanLab release];
    
    sanChuanLab = [[UILabel alloc]init];
    sanChuanLab.frame = CGRectMake(0, 0, 200, 20);
    sanChuanLab.backgroundColor = [UIColor clearColor];
    sanChuanLab.text = @"【3串1】 0注";
    sanChuanLab.tag = 100;
    sanChuanLab.textColor = [UIColor blackColor];
    sanChuanLab.font = [UIFont systemFontOfSize:15];
    [sanchuanView addSubview:sanChuanLab];
    [sanChuanLab release];
    
    footerView.frame = CGRectMake(0, 0, 320, erchuanView.frame.size.height + sanchuanView.frame.size.height + 30+20);
    
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
    
    [self dateDidFinishSelector:nil];
    
    
    oneLabel.text = [NSString stringWithFormat:@"%d", one];
    twoLabel.text = [NSString stringWithFormat:@"%d", two];
    
    [self loadFirstView];
}
- (void)dateDidFinishSelector:(ASIHTTPRequest *)mrequest{
    
    NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"3.34",@"eurDraw",@"2.78",@"eurLost",@"2.43",@"eurWin",@"2015-01-21 21:00:00",@"gameStartDate",@"门兴",@"guestName",@"沙尔克",@"hostName",@"德甲",@"leagueName", nil];
    NSDictionary *dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"3.16",@"eurDraw",@"2.09",@"eurLost",@"3.47",@"eurWin",@"2015-01-21 21:00:00",@"gameStartDate",@"莱比锡",@"guestName",@"奥 厄",@"hostName",@"德乙",@"leagueName", nil];
    NSDictionary *dic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"3.08",@"eurDraw",@"2.41",@"eurLost",@"2.91",@"eurWin",@"2015-01-21 21:00:00",@"gameStartDate",@"因戈尔",@"guestName",@"菲尔特",@"hostName",@"德乙",@"leagueName", nil];
    
    NSArray *ary = [NSArray arrayWithObjects:dic1,dic2,dic3, nil];
    
    for (NSDictionary * di in ary) {
        GC_BetData * pkbet = [[GC_BetData alloc] initWithDic:di];
        
        [dataArray addObject:pkbet];
        [pkbet release];
    }
    [cellarray addObjectsFromArray:dataArray];
    [myTableView reloadData];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    PKTableViewCell *cell = (PKTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[PKTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        //        cell.wangqibool = NO;
        //
        //        cell.cp_canopencelldelegate = self;
        //        cell.xzhi = 9.5;
        //
        ////        cell.otherImageView.image = UIImageGetImageFromName(@"xialabg.png");
        //        cell.normalHight = 50;
        //        cell.selectHight = 50+56;
        ////        cell.xialabianImge.image = UIImageGetImageFromName(@"xialabian24.png");
    }
    
    UIButton * cellbutton = (UIButton *)[cell.butonScrollView viewWithTag:1];
    
    cellbutton.hidden = NO;
    cell.wangqibool = NO;
    //    if (zhankai[indexPath.row] == 1) {
    //        [cell showButonScollWithAnime:NO];
    //    }
    //    if (zhankai[indexPath.row] == 0) {
    //        [cell hidenButonScollWithAnime:NO];
    //    }
    // Configure the cell...
    cell.row = indexPath.row;
    cell.count = indexPath.row;
    cell.delegate = self;
    cell.isNewUser = YES;
    GC_BetData * pkbet = [dataArray objectAtIndex:indexPath.row];
    pkbet.donghuarow = indexPath.row;
    cell.pkbetdata = pkbet;
    
    [cell hidenXieBtn];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73;
}
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
    
    //    //投注按钮背景
    //    UIImageView * backButton = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 63, 30)];
    //    backButton.image = UIImageGetImageFromName(@"gc_footerBtn.png");
    //    UIImageView * backButton2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 29)];
    //    backButton2.image = UIImageGetImageFromName(@"GC_icon8.png");
    
    
    
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
    castButton.alpha = 0.5;
    castButton.enabled = NO;
    
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
    
    
    //    [backButton release];
    //    [backButton2 release];
    [buttonLabel1 release];
    
    [tabView addSubview:pitchLabel];
    [tabView addSubview:castLabel];
    [tabView addSubview:zhubg];
    [zhubg release];
    [tabView addSubview:castButton];
    [tabView addSubview:qingbutton];
    [tabView addSubview:chuanButton1];
    [self.mainView addSubview:tabView];
    
    [labelch release];
    [oneLabel release];
    [twoLabel release];
    [pitchLabel release];
    [castLabel release];
    [fieldLable release];
    [pourLable release];
    [tabView release];
}
//串法
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
        
        [chuanfaArym removeAllObjects];
        [chuanfaArym addObjectsFromArray:returnarry];
        if(returnarry.count > 0)
        {
//            [chuanfaArym removeAllObjects];
//            [chuanfaArym addObjectsFromArray:returnarry];
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
        if (addchuan > 5) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"组合串关不能超过5个"];
            addchuan -= 1;
            [self performSelector:@selector(chuanwuzhihou:) withObject:sender afterDelay:1];
            
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
    
    erChuanLab.textColor = [UIColor blackColor];
    sanChuanLab.textColor = [UIColor blackColor];
    oneLabel.text = [NSString stringWithFormat:@"%ld", (long)n];
    two = (int)n;
    //    twoLabel.text = [NSString stringWithFormat:@"%d", n * 2];
    NSArray * arrr = [zhushuDic allKeys];
    
    if ([arrr count] > 1) {
        labelch.text = @"多串...";
        twoLabel.hidden = NO;
    }else if([arrr count] == 1){
        labelch.text = [arrr objectAtIndex:0];
        twoLabel.hidden = NO;
    }else if([arrr count] == 0){
        labelch.text = @"串法";
        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        twoLabel.hidden = YES;
    }else {
        labelch.text = @"串法";
        oneLabel.text = [NSString stringWithFormat:@"%d", one];
        twoLabel.hidden = YES;
    }
    if ([labelch.text isEqualToString:@"2串1"])
    {
        for(UIView *lab in erchuanView.subviews)
        {
            UILabel *la = (UILabel *)lab;
            la.textColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:248/255.0 alpha:1];
        }
        for(UIView *lab in sanchuanView.subviews)
        {
            UILabel *la = (UILabel *)lab;
            la.textColor = [UIColor blackColor];
        }
        erChuanLab.textColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:248/255.0 alpha:1];
        sanChuanLab.textColor = [UIColor blackColor];
    }
    if([labelch.text isEqualToString:@"3串1"])
    {
        for(UIView *lab in erchuanView.subviews)
        {
            UILabel *la = (UILabel *)lab;
            la.textColor = [UIColor blackColor];
        }
        for(UIView *lab in sanchuanView.subviews)
        {
            UILabel *la = (UILabel *)lab;
            la.textColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:248/255.0 alpha:1];
        }
        erChuanLab.textColor = [UIColor blackColor];
        sanChuanLab.textColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:248/255.0 alpha:1];
    }
    if([labelch.text isEqualToString:@"多串..."])
    {
        for(UIView *lab in erchuanView.subviews)
        {
            UILabel *la = (UILabel *)lab;
            la.textColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:248/255.0 alpha:1];
        }
        for(UIView *lab in sanchuanView.subviews)
        {
            UILabel *la = (UILabel *)lab;
            la.textColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:248/255.0 alpha:1];
        }
        erChuanLab.textColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:248/255.0 alpha:1];
        sanChuanLab.textColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:248/255.0 alpha:1];
    }
}

-(void)chooseViewDidRemovedFromSuperView:(CP_KindsOfChoose *)chooseView
{
    self.mainView.userInteractionEnabled = YES;
}
- (void)pressCastButton:(UIButton *)button
{
    NSLog(@"选好了");
    NSLog(@"xuan hao  le");
    //    if ([[[Info getInstance] userId] intValue] == 0) {
    //        [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
    //        return;
    //    }
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
        for (GC_BetData * data in dataArray) {
            if (data.selection1) {
                string = [string stringByAppendingFormat:@"3"];
            }
            if (data.selection2) {
                string = [string stringByAppendingFormat:@"1"];
            }
            if (data.selection3) {
                string = [string stringByAppendingFormat:@"0"];
            }
            string = [string stringByAppendingFormat:@"*"];
        }
        string = [string substringToIndex:[string length] - 1];
        
        if(chuanfaArym.count == 0)
        {
            [self pressChuanButton];
        }
        else
        {
            PKDetailViewController *pvc = [[PKDetailViewController alloc]init];
            pvc.newUserDataArym = cellarray;
            pvc.zhushu = two;
            pvc.isNewUser = YES;
            pvc.chuanfaArym = chuanfaArym;
            [self.navigationController pushViewController:pvc animated:YES];
            [pvc release];
        }

    }
    
}


- (void)returnCellInfo:(NSInteger)index buttonBoll1:(BOOL)selection1 buttonBoll:(BOOL)selection2 buttonBoll:(BOOL)selection3 dan:(BOOL)booldan{
    
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
    
    two = 1;
    one = 0;
    
    [self upDateFunc];
    
    
    
    [myTableView reloadData];
    
    
}


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
    // 未设胆情况
    GC_JCalgorithm *jcalgorithm = [GC_JCalgorithm shareJCalgorithmManager];
    //            NSArray *keys = [selectedItemsDic allKeys];
    
    //            for (NSString* stri in keys) {
    //                NSLog(@"stri = %@", stri);
    //            }
    
    [jcalgorithm passData:diction gameCount:[cellarray count] chuan:str];
    long long  total =[jcalgorithm  totalZhuShuNum];
    NSLog(@"total = %lld", total);
    
    [jcalgorithm passData:diction gameCount:[cellarray count] chuan:@"2串1"];
    erchuanChai =[jcalgorithm  totalZhuShuNum];
    [jcalgorithm passData:diction gameCount:[cellarray count] chuan:@"3串1"];
    sanchuanChai =[jcalgorithm  totalZhuShuNum];
    
    oneLabel.text = [NSString stringWithFormat:@"%d", two];//注
    twoLabel.text = [NSString stringWithFormat:@"%d", one];//场
    
    if(one == 0)
    {
        castButton.alpha = 0.5;
        castButton.enabled = NO;
    }
    else
    {
        castButton.alpha = 1;
        castButton.enabled = YES;
    }
    
    if(qipao)
    {
        if(one == 3)
        {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"这里可以切换串法哦"];
            qipao = 0;
        }
    }
    
    if (one < 2) {
        chuanButton1.enabled = NO;
        chuanButton1.alpha = 0.5;
        labelch.text = @"串法";
    }else{
        two = (int)total;
        chuanButton1.enabled = YES;
        chuanButton1.alpha = 1;
        labelch.text = [NSString stringWithFormat:@"%d串1",one];
        oneLabel.text = [NSString stringWithFormat:@"%lld", total];
        twoLabel.text = [NSString stringWithFormat:@"%d", one];
    }
    [chuanfaArym removeAllObjects];
    [chuanfaArym addObject:labelch.text];
    
    [self xiangxiChuanfa];
    
    
    
    
    
}
-(void)xiangxiChuanfa
{
    for(UIView *lab in erchuanView.subviews)
    {
        if(lab.tag != 100)
        {
            [lab removeFromSuperview];
        }
    }
    for(UIView *lab in sanchuanView.subviews)
    {
        if(lab.tag != 100)
        {
            [lab removeFromSuperview];
        }
    }
    
    [erChaifenArym removeAllObjects];
    [sanChaifenArym removeAllObjects];
    NSArray *changciAry = [NSArray arrayWithObjects:@"001",@"002",@"003", nil];
    NSArray *shengfuAry = [NSArray arrayWithObjects:@"胜",@"平",@"负", nil];
    if(one > 1)
    {
        
        for (int i=0;i<cellarray.count;i++)
        {
            GC_BetData * pkb = [cellarray objectAtIndex:i];
            NSMutableArray *ary = [[NSMutableArray alloc]initWithCapacity:0];
            if(pkb.selection1)
            {
                if(i < changciAry.count)
                {
                    [erChaifenArym addObject:[NSString stringWithFormat:@"%@|%@",[changciAry objectAtIndex:i],[shengfuAry objectAtIndex:0]]];
                    [ary addObject:[NSString stringWithFormat:@"%@|%@",[changciAry objectAtIndex:i],[shengfuAry objectAtIndex:0]]];
                    
                }
            }
            if(pkb.selection2)
            {
                if(i < changciAry.count)
                {
                    [erChaifenArym addObject:[NSString stringWithFormat:@"%@|%@",[changciAry objectAtIndex:i],[shengfuAry objectAtIndex:1]]];
                    [ary addObject:[NSString stringWithFormat:@"%@|%@",[changciAry objectAtIndex:i],[shengfuAry objectAtIndex:1]]];
                }
            }
            if(pkb.selection3)
            {
                if(i < changciAry.count)
                {
                    [erChaifenArym addObject:[NSString stringWithFormat:@"%@|%@",[changciAry objectAtIndex:i],[shengfuAry objectAtIndex:2]]];
                    [ary addObject:[NSString stringWithFormat:@"%@|%@",[changciAry objectAtIndex:i],[shengfuAry objectAtIndex:2]]];
                }
            }
            [sanChaifenArym addObject:ary];
            [ary release];
        }
        
    }
    
    PermutationAndCombination * pandc2 = [[PermutationAndCombination alloc] init];
    [pandc2 combinationWhithMatchArray:erChaifenArym chuanCount:@"2"];
    NSMutableArray *erchuanChaifenArym = [pandc2 chaifenArray];
    PermutationAndCombination * pandc3 = [[PermutationAndCombination alloc] init];
    NSMutableArray *sanchuanChaifenArym;
    if(one == 3)
    {
        [pandc3 combinationWhithMatchArray:sanChaifenArym chuanCount:@"3"];
        sanchuanChaifenArym = [pandc3 chaifenArray];
    }
    
    NSInteger chaiNum = 0;
    chaiNum = (NSInteger)erchuanChai + (NSInteger)sanchuanChai;
    CGFloat lastErchuanRect = 0;
    CGFloat lastSanchuanRect = 0;
    for(int i=0; i<erchuanChaifenArym.count; i++)
    {
        UILabel *lab = [[UILabel alloc]init];
//        lab.frame = CGRectMake(73+i%2*(110+5), 20+(i/2)*20, 110, 20);//每行两个
        lab.frame = CGRectMake(73, 20+i*20, 110, 20);//每行一个
        lastErchuanRect = lab.frame.origin.y;
        lab.tag = i;
        lab.backgroundColor = [UIColor clearColor];
//        lab.text = [erchuanChaifenArym objectAtIndex:i];
        lab.text = [[erchuanChaifenArym objectAtIndex:i] stringByReplacingOccurrencesOfString:@"|" withString:@""];
        lab.textColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:248/255.0 alpha:1];
        lab.font = [UIFont systemFontOfSize:15];
        [erchuanView addSubview:lab];
        [lab release];
    }
    
    erChuanLab.text = [NSString stringWithFormat:@"【2串1】 %lu注",(unsigned long)erchuanChaifenArym.count];
    sanChuanLab.text = [NSString stringWithFormat:@"【3串1】 0注"];
    erChuanLab.textColor = [UIColor blackColor];
    sanChuanLab.textColor = [UIColor blackColor];
    if(one == 2)
    {
        erChuanLab.textColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:248/255.0 alpha:1];
        sanChuanLab.textColor = [UIColor blackColor];
    }
    if(one == 3)
    {
        for(int i=0; i<sanchuanChaifenArym.count; i++)
        {
            UILabel *lab = [[UILabel alloc]init];
            lab.frame = CGRectMake(73, 20+i*20, 200, 20);
            lastSanchuanRect = lab.frame.origin.y;
            lab.tag = i;
            lab.backgroundColor = [UIColor clearColor];
            lab.text = [[sanchuanChaifenArym objectAtIndex:i] stringByReplacingOccurrencesOfString:@"|" withString:@""];
            lab.textColor = [UIColor blackColor];
            lab.font = [UIFont systemFontOfSize:15];
            [sanchuanView addSubview:lab];
            [lab release];
        }
        
        for(UIView *lab in erchuanView.subviews)
        {
            UILabel *la = (UILabel *)lab;
            la.textColor = [UIColor blackColor];
        }
        for(UIView *lab in sanchuanView.subviews)
        {
            UILabel *la = (UILabel *)lab;
            la.textColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:248/255.0 alpha:1];
        }
        erChuanLab.textColor = [UIColor blackColor];
        sanChuanLab.textColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:248/255.0 alpha:1];
        sanChuanLab.text = [NSString stringWithFormat:@"【3串1】 %lu注",(unsigned long)sanchuanChaifenArym.count];
    }
    
    
    erchuanView.frame = CGRectMake(10, 15, 300, lastErchuanRect + 20);
    sanchuanView.frame = CGRectMake(10, 15 + erchuanView.frame.size.height + 15, 300, lastSanchuanRect + 20);
    
    footerView.frame = CGRectMake(0, 0, 320, erchuanView.frame.size.height + sanchuanView.frame.size.height + 30+20);
    
    myTableView.tableFooterView = footerView;
    
    [pandc2 release];
    [pandc3 release];
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
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    [chuanfaArym release];
    [erchuanView release];
    [sanchuanView release];
    [dataArray release];
    [zhushuDic release];
    [cellarray release];
    [chuantype release];
    [erChaifenArym release];
    [sanChaifenArym release];
    [footerView release];
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