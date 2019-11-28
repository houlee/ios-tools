//
//  GqYiGouVc.m
//  caibo
//
//  Created by zhoujunwang on 16/5/27.
//
//

#import "GqYiGouVc.h"
#import "GqYiGouCell.h"
#import "GqMdl.h"
#import "SharedMethod.h"
#import "ProjectDetailViewController.h"

@interface GqYiGouVc ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *gqYgTableView;
    UIView *sxBgView;
}
@property(nonatomic,strong)NSString *condit;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,assign)NSInteger gqYgTotalPage;
@property(nonatomic,strong)NSMutableArray *yiGouArr;

@end

@implementation GqYiGouVc

- (instancetype)init{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNavView];
    self.title_nav = @"已购方案";
    
    sxBgView=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth*3, 35)];
    //_topBgView.layer.masksToBounds=YES;
    //_topBgView.layer.borderWidth=1;
    //_topBgView.layer.borderColor=SEPARATORCOLOR.CGColor;
    sxBgView.userInteractionEnabled=YES;
    [self.view addSubview:sxBgView];
    
    UIView *sepLine=[[UIView alloc] initWithFrame:CGRectMake(0, sxBgView.frame.size.height-1, sxBgView.frame.size.width, 1)];
    [sepLine setBackgroundColor:SEPARATORCOLOR];
    [sxBgView addSubview:sepLine];
    
    NSString *btnText=@"";
    for (int i=0; i<3; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateNormal];
        [btn setTitleColor:ALERT_BLUE forState:UIControlStateHighlighted];
        [btn setTitleColor:ALERT_BLUE forState:UIControlStateSelected];
        if (i==0) {
            btn.selected=YES;
            _condit=@"0";
            btnText=@"开赛中";
        }else if(i==1){
            btnText=@"未开赛";
        }else if(i==2){
            btnText=@"已结束";
        }
        float loc=MyWidth/3*i;
        float wid=MyWidth/3;
        [btn setFrame:CGRectMake(loc, 0,wid, 35)];
        [btn setTitle:btnText forState:UIControlStateNormal];
        [btn setTitle:btnText forState:UIControlStateHighlighted];
        btn.titleLabel.font=FONTTHIRTY;
        btn.tag=100+i;
        [btn addTarget:self action:@selector(selGqType:) forControlEvents:UIControlEventTouchUpInside];
        [sxBgView addSubview:btn];
        
        if (i!=2) {
            UIImageView *intervalView=[[UIImageView alloc] initWithFrame:CGRectMake(btn.frame.size.width-0.5, 6.5, 0.5, 22)];
            intervalView.image=[UIImage imageNamed:@"intervalLine"];
            [btn addSubview:intervalView];
        }
    }
    
    gqYgTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+80, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-HEIGHTBELOESYSSEVER-80) style:UITableViewStylePlain];
    gqYgTableView.delegate = self;
    gqYgTableView.dataSource = self;
    gqYgTableView.showsHorizontalScrollIndicator=NO;
    gqYgTableView.showsVerticalScrollIndicator=NO;
    gqYgTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:gqYgTableView];
    
    [self setupRefresh];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _currentPage=1;
    [self getGqYiGou:@"1"];
}

- (void)selGqType:(UIButton *)btn{

    btn.selected=YES;
    for (UIView *view in [sxBgView subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *sortBtn=(UIButton *)view;
            if (sortBtn!=btn) {
                sortBtn.selected=NO;
            }
        }
    }
    
    if (btn.tag==100) {
        _condit=@"0";
    }else if (btn.tag==101) {
        _condit=@"1";
    }else if (btn.tag==102) {
        _condit=@"2";
    }
    _currentPage=1;
    [self getGqYiGou:@"1"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GqYgRecMdl *gqYgRecMdl=[_yiGouArr objectAtIndex:indexPath.row];
    ProjectDetailViewController *vc=[[ProjectDetailViewController alloc] init];
    vc.sign=@"0";
    vc.erAgintOrderId=gqYgRecMdl.ER_AGINT_ORDER_ID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_yiGouArr count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * gqygIdentifier=@"gqYiGouCell";
    GqYiGouCell *gqYgCell=(GqYiGouCell *)[tableView dequeueReusableCellWithIdentifier:gqygIdentifier];
    if (!gqYgCell) {
        gqYgCell=[[GqYiGouCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:gqygIdentifier];
    }
    GqYgRecMdl *gqYgRecMdl=[_yiGouArr objectAtIndex:indexPath.row];
    NSString *homeName=gqYgRecMdl.HOME_NAME;
    NSString *awayName=gqYgRecMdl.AWAY_NAME;
    if(gqYgRecMdl.HOME_NAME.length>5){
        homeName=[gqYgRecMdl.HOME_NAME substringToIndex:5];
    }
    if(gqYgRecMdl.AWAY_NAME.length>5){
        awayName=[gqYgRecMdl.AWAY_NAME substringToIndex:5];
    }
    NSString *bothSide=[NSString stringWithFormat:@"%@  VS  %@",homeName,awayName];
    [gqYgCell setPortView:gqYgRecMdl.HEAD_PORTRAIT nickName:gqYgRecMdl.EXPERTS_NICK_NAME levels:[[gqYgRecMdl.dicNo valueForKey:@"STAR"] intValue] legName:gqYgRecMdl.LEAGUE_NAME bothSide:bothSide price:[[gqYgRecMdl.dicNo valueForKey:@"AMOUNT"] intValue] time:gqYgRecMdl.MATCH_TIME npTag:gqYgRecMdl.STATUS];
    return gqYgCell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getGqYiGou:(NSString *)page{
    NSMutableDictionary  *parametersDic=[[NSMutableDictionary alloc]initWithDictionary:@{@"expertClassCode":@"001",@"lotteryClassCode":@"203",@"userName":[[Info getInstance] userName],@"condition":_condit,@"curPage":page,@"pageSize":@"20"}];
    NSMutableDictionary *bodyDic=[[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"zjtjIndexService",@"methodName":@"getMyBuyGqPlanList",@"parameters":parametersDic}];
    if ([page isEqualToString:@"1"]) {
        _yiGouArr=nil;
    }
    [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
        NSLog(@"respondObject==%@",respondObject);
        NSDictionary *dataDic = respondObject;
        if ([dataDic[@"resultCode"] isEqualToString:@"0000"]) {
            NSArray *arr = dataDic[@"result"][@"data"];
            NSMutableArray *mutArr=[NSMutableArray arrayWithCapacity:[arr count]];
            for (NSDictionary * dic in arr) {
                [mutArr addObject:[GqYgRecMdl gqYgRecMdlWithDic:dic]];
            }
            if ([page isEqualToString:@"1"]) {
                _yiGouArr=mutArr;
            }else{
                _currentPage++;
                [_yiGouArr addObjectsFromArray:mutArr];
            }
            _gqYgTotalPage=[dataDic[@"result"][@"pageInfo"][@"totalPage"] integerValue];
            //if (100*[_yiGouArr count]>MyHight-HEIGHTBELOESYSSEVER-80) {
            //    [gqYgTableView setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+80, 320, MyHight-HEIGHTBELOESYSSEVER-80)];
            //}else
            //    [gqYgTableView setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+80, 320, 100*[_yiGouArr count])];
            [gqYgTableView reloadData];
        }else{
            
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [gqYgTableView.footer endRefreshing];
            [gqYgTableView.header endRefreshing];
        });
    } failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [gqYgTableView.footer endRefreshing];
            [gqYgTableView.header endRefreshing];
        });
    }];
}

#pragma mark 刷新
- (void)setupRefresh
{
    gqYgTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:gqYgTableView.header];
    
    gqYgTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:gqYgTableView.footer];
}

#pragma mark 开始进入刷新状态
- (void)NearheaderRereshing
{
    _currentPage=1;
    MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)gqYgTableView.footer;
    f.stateLabel.font=[UIFont systemFontOfSize:17.0f];
    [self getGqYiGou:@"1"];
}

#pragma mark - 加载
- (void)NearfooterRereshing
{
    if (_currentPage==_gqYgTotalPage) {
        [gqYgTableView.footer noticeNoMoreData];
        MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)gqYgTableView.footer;
        f.stateLabel.font=FONTTWENTY_FOUR;
        [f setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
        [f setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
        [f setTitle:@"没有更多啦" forState:MJRefreshStateNoMoreData];
        return;
    }
    NSInteger page=_currentPage+1;
    [self getGqYiGou:[NSString stringWithFormat:@"%ld",(long)page]];
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