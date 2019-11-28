//
//  GqZJVc.m
//  caibo
//
//  Created by zhoujunwang on 16/5/26.
//
//

#import "GqZJVc.h"
#import "GqFillPhoneNoVC.h"
#import "GqMdl.h"
#import "GqRecCell.h"
#import "SharedMethod.h"
#import "CP_UIAlertView.h"
#import "Expert365Bridge.h"
#import "ProjectDetailViewController.h"
#import "CommonProblemViewController.h"
#import "LoginViewController.h"


@interface GqZJVc ()<UITableViewDelegate,UITableViewDataSource,GqZJCellCXXQDelegate,CP_UIAlertViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)NSMutableArray *zjRecArr;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)NSInteger gqZjTotalPage;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,strong)CP_UIAlertView *cpAlert;
@property(nonatomic,assign)float payJiage;
@property(nonatomic,strong)GqMatchRecMdl *gqCkMchRec;

@end

@implementation GqZJVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNavView];
    self.title_nav=@"专家列表";
    self.view.backgroundColor = [UIColor colorWithHexString:@"ecedf1"];
    
    UITableView *tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, 320, MyHight-HEIGHTBELOESYSSEVER-44) style:UITableViewStylePlain];
    tableView.separatorColor=SEPARATORCOLOR;
    tableView.showsHorizontalScrollIndicator=NO;
    tableView.showsVerticalScrollIndicator=NO;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=[UIColor whiteColor];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    _tableView=tableView;
    
    [self setupRefresh];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    _currentPage=1;
    [self getGqRecList:@"1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------------UITableViewDelegate--------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight=191.0;
    GqMatchRecMdl *gqMatchRec=[_zjRecArr objectAtIndex:indexPath.row];
    if ([[gqMatchRec.dicNo objectForKey:@"matchStatus"] intValue]==0||[[gqMatchRec.dicNo objectForKey:@"isRecommended"] intValue]==0) {
        rowHeight=169.0;
    }
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark -------------UITableViewDataSource--------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_zjRecArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    GqZJCell *cell=(GqZJCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[GqZJCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate=self;
    }
    GqMatchRecMdl *gqMatchRec=[_zjRecArr objectAtIndex:indexPath.row];
    NSString *gameBoth=@"";
    NSString *relesTime=@"";
    if ([[gqMatchRec.dicNo objectForKey:@"matchStatus"] intValue]==0) {
        gameBoth=[NSString stringWithFormat:@"%@  VS  %@",gqMatchRec.homeName,gqMatchRec.awayName];
        relesTime=[NSString stringWithFormat:@"%@  %@",gqMatchRec.dayOfWeek,gqMatchRec.matchTime];
    }else if([[gqMatchRec.dicNo objectForKey:@"matchStatus"] intValue]==1){
        gameBoth=[NSString stringWithFormat:@"%@  %@:%@  %@",gqMatchRec.homeName,[gqMatchRec.dicNo objectForKey:@"homeScore"],[gqMatchRec.dicNo objectForKey:@"awayScore"],gqMatchRec.awayName];
        if ([[gqMatchRec.dicNo objectForKey:@"isChange"] intValue]==0) {
            relesTime=[NSString stringWithFormat:@"%ld分钟前",(long)[[gqMatchRec.dicNo objectForKey:@"preMinutes"] intValue]];
        }else if ([[gqMatchRec.dicNo objectForKey:@"isChange"] intValue]==1){
            relesTime=[NSString stringWithFormat:@"%ld分钟前(已变盘)",(long)[[gqMatchRec.dicNo objectForKey:@"preMinutes"] intValue]];
        }
    }
    cell.ckxqBtn.tag=indexPath.row+300;
    [cell setPortrait:gqMatchRec.headPortrait gqNikNm:gqMatchRec.expertNickName gqRk:[[gqMatchRec.dicNo objectForKey:@"star"] intValue] gqGameSides:gameBoth gqsqSpl:gqMatchRec.oddsBeforeHomeWin gqsqRq:gqMatchRec.hostRqBefore gqsqFpl:gqMatchRec.oddsBeforeAwayWin gqzxSpl:gqMatchRec.oddsNewHomeWin gqzxRq:gqMatchRec.hostRqNew gqzxfpl:gqMatchRec.oddsNewAwayWin releasaTime:relesTime gpPrice:gqMatchRec.amount startOrNo:[[gqMatchRec.dicNo objectForKey:@"matchStatus"] intValue] isRec:[[gqMatchRec.dicNo objectForKey:@"isRecommended"] intValue]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)gqckxqClick:(UIButton *)btn{
    NSLog(@"click");
    Info *info = [Info getInstance];
    if (![info.userId intValue]) {
        [self toLogin];
        return;
    }
    NSInteger tag=btn.tag-300;
    _gqCkMchRec=[_zjRecArr objectAtIndex:tag];
    _payJiage=[_gqCkMchRec.amount floatValue];
    if([_gqCkMchRec.expertName isEqualToString:[[Info getInstance] userName]]||_payJiage==0.00||[[_gqCkMchRec.dicNo objectForKey:@"isHaveBought"] intValue]==1){
        ProjectDetailViewController *vc=[[ProjectDetailViewController alloc] init];
        vc.sign=@"0";
        vc.erAgintOrderId=_gqCkMchRec.erAgintOrderId;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self addDealPurchaseTicket:_payJiage tag:601];
    }
}

- (void)addDealPurchaseTicket:(float)str tag:(NSInteger)tag{
#ifdef CRAZYSPORTS
    int jinbibeishu = 10;//金币和钱比例
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"]) {
        jinbibeishu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"] intValue];
    }
    _cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付"
                                             message:[NSString stringWithFormat:@"您将支付(%.0f金币)购买此推荐",str * jinbibeishu]
                                            delegate:self
                                   cancelButtonTitle:@"取消"
                                   otherButtonTitles:@"确定", nil];
#else
    _cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付"
                                             message:[NSString stringWithFormat:@"您将支付(%.2f元)购买此推荐",str]
                                            delegate:self
                                   cancelButtonTitle:@"取消"
                                   otherButtonTitles:@"确定", nil];
#endif
    
    _cpAlert.alertTpye=purchasePaln;
    _cpAlert.tag=tag;
    [_cpAlert show];
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message
{
    if (buttonIndex==1&&alertView.tag==601) {
        NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
        [bodyDic setObject:@"expertService" forKey:@"serviceName"];
        [bodyDic setObject:@"getLoginUserInfo" forKey:@"methodName"];
        [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName]} forKey:@"parameters"];
        [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
            NSLog(@"responseJSON=%@",responseJSON);
            if ([[responseJSON objectForKey:@"resultCode"] isEqualToString:@"0000"]) {
                NSDictionary * resultDic = [responseJSON objectForKey:@"result"];
                float balance=[[resultDic objectForKey:@"userValidFee"] floatValue];
                if (0 && _payJiage>balance) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"您的余额不足请及时充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alert.tag=602;
                    [alert show];
                }else{
                    NSString *erID=_gqCkMchRec.erAgintOrderId;
                    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
                    [bodyDic setObject:@"commonExpertService" forKey:@"serviceName"];
                    [bodyDic setObject:@"buyPlan" forKey:@"methodName"];
#ifdef CRAZYSPORTS
                    [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"erAgintOrderId":erID,@"orderSource":@"10002000",@"payType":@"1",@"clientType":@"2",@"publishVersion":APPVersion} forKey:@"parameters"];
#else
                    [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"erAgintOrderId":erID,@"orderSource":@"10002000",@"clientType":@"2",@"publishVersion":APPVersion} forKey:@"parameters"];
#endif
                    
                    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
                        NSLog(@"responseJSON=%@",responseJSON);
                        if ([[responseJSON objectForKey:@"resultCode"] isEqualToString:@"0000"]) {
                            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"支付成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                            alert.tag=603;
                            [alert show];
                        }else if ([[responseJSON objectForKey:@"resultCode"] isEqualToString:@"0301"]){
                            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"您的余额不足请及时充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                            alert.tag=602;
                            [alert show];
                        }
                        else{
                            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alert show];
                        }
                    } failure:^(NSError * error) {
                        
                    }];
                }
            }
        } failure:^(NSError * error) {
            
        }];
    }
}

- (void)CP_alertView:(CP_UIAlertView *)alertView clickPuchsPlanDealTap:(UITapGestureRecognizer *)sender{
    CommonProblemViewController * vc = [[CommonProblemViewController alloc]init];
    vc.sourceFrom=@"purchasePlanDeal";
    [self.navigationController pushViewController:vc animated:YES];
    [_cpAlert removeFromSuperview];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==602){
        if (buttonIndex==1) {
            Expert365Bridge * bridge = [[Expert365Bridge alloc] init];
            [bridge toRechargeFromController:self];
        }
    }else if (alertView.tag==603) {
        GqFillPhoneNoVC *gqfpnoVc=[[GqFillPhoneNoVC alloc] init];
        gqfpnoVc.agOrderId=_gqCkMchRec.erAgintOrderId;
        [self.navigationController pushViewController:gqfpnoVc animated:YES];
    }
}

#pragma mark 刷新
- (void)setupRefresh
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_tableView.header];
    
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_tableView.footer];
}

#pragma mark 开始进入刷新状态
- (void)NearheaderRereshing
{
    _currentPage=1;
    MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)_tableView.footer;
    f.stateLabel.font=[UIFont systemFontOfSize:17.0f];
    [self getGqRecList:@"1"];
}

#pragma mark - 加载
- (void)NearfooterRereshing
{
    if (_currentPage==_gqZjTotalPage) {
        [_tableView.footer noticeNoMoreData];
        MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)_tableView.footer;
        f.stateLabel.font=FONTTWENTY_FOUR;
        [f setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
        [f setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
        [f setTitle:@"没有更多啦" forState:MJRefreshStateNoMoreData];
        return;
    }
    NSInteger page=_currentPage+1;
    [self getGqRecList:[NSString stringWithFormat:@"%ld",(long)page]];
}

- (void)getGqRecList:(NSString *)page{
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getGqMatchRecommendList",@"parameters":@{@"playId":_playId,@"userName":nameSty,@"curPage":page,@"pageSize":@"20"}}];
    if ([page isEqualToString:@"1"]) {
        _zjRecArr=nil;
    }
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray *arr=responseJSON[@"result"][@"data"];
            NSMutableArray *mutalArr=[NSMutableArray arrayWithCapacity:[arr count]];
            for (NSDictionary *dic in arr) {
                GqMatchRecMdl *gqMatchMdl=[GqMatchRecMdl gqMatchRecMdlWithDic:dic];
                [mutalArr addObject:gqMatchMdl];
            }
            if ([page isEqualToString:@"1"]) {
                _zjRecArr=mutalArr;
            }else{
                _currentPage++;
                [_zjRecArr addObjectsFromArray:mutalArr];
            }
            _gqZjTotalPage=[responseJSON[@"result"][@"pageInfo"][@"totalPage"] integerValue];
            [_tableView reloadData];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.footer endRefreshing];
            [_tableView.header endRefreshing];
        });
    } failure:^(NSError * error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.footer endRefreshing];
            [_tableView.header endRefreshing];
        });
    }];
}


-(void)toLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
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