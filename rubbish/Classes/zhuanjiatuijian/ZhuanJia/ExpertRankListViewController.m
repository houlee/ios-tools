//
//  ExpertRankListViewController.m
//  caibo
//
//  Created by cp365dev6 on 2016/11/27.
//
//

#import "ExpertRankListViewController.h"
#import "SharedMethod.h"
#import "ExpertMainListTableViewCell.h"
#import "RequestEntity.h"
#import "SMGDetailViewController.h"
#import "LoginViewController.h"
#import "MobClick.h"
#import "ProjectDetailViewController.h"
#import "Expert365Bridge.h"

@interface ExpertRankListViewController ()

@end

@implementation ExpertRankListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self changeCSTitileColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(goBack)];
    
//    [self loadSegmentView];
    [self createTableView];
    
    if(_expertType == expertMingzhongType){
        segmentTag = 10;
        [self getRankListExpertRequestWithlotteryClassCode:@"-201" OrderFlag:@"0" page:@"1"];
        self.CP_navigation.title = @"命中榜";
    }else if (_expertType == expertHuibaoType){
        segmentTag = 11;
        [self getRankListExpertRequestWithlotteryClassCode:@"-201" OrderFlag:@"1" page:@"1"];
        self.CP_navigation.title = @"回报榜";
    }else if (_expertType == expertChuanguanType){
        segmentTag = 12;
        [self getRankListExpertRequestWithlotteryClassCode:@"201" OrderFlag:@"0" page:@"1"];
        self.CP_navigation.title = @"串关榜";
    }
}
-(void)loadSegmentView{
    
    erAgintOrderId = @"";
    disPrice = 0;
    
    segmentIma = [[UIImageView alloc]init];
    segmentIma.frame = CGRectMake((self.mainView.frame.size.width - 225)/2.0, 10.5, 225, 23);
    segmentIma.backgroundColor = [UIColor clearColor];
    segmentIma.image = [UIImage imageNamed:@"expert_segment_bg.png"];
    segmentIma.userInteractionEnabled = YES;
    [self.CP_navigation addSubview:segmentIma];
    
    NSArray *ary = [NSArray arrayWithObjects:@"命中榜",@"回报榜",@"串关榜", nil];
    for(NSInteger i=0;i<3;i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(75*i, 0, 75, 23);
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = 10+i;
        if(i == 0){
            btn.selected = YES;
            segmentTag = btn.tag;
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:[ary objectAtIndex:i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"expert_segment_selected.png"] forState:UIControlStateSelected];
//        [btn setBackgroundImage:[UIImage imageNamed:@"expert_segment_selected.png"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [segmentIma addSubview:btn];
        [btn addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[SharedMethod getColorByHexString:@"6e29bd"] forState:UIControlStateNormal];
    }
    
}
-(void)createTableView{
    
    cellPage1 = 1;
    cellPage2 = 1;
    cellPage3 = 1;
    
    dataArym = [[NSMutableArray alloc]initWithCapacity:0];
    for(NSInteger i=0;i<3;i++){
        NSMutableArray *ary = [[NSMutableArray alloc]initWithCapacity:0];
        [dataArym addObject:ary];
    }
    
    myTableView = [[UITableView alloc] initWithFrame:self.mainView.bounds];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.mainView addSubview:myTableView];
    myTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    myTableView.backgroundColor = DEFAULT_BACKGROUNDCOLOR_CRAZY;
    
    __block ExpertRankListViewController * newSelf = self;
    
    myTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if(segmentTag == 10){
            cellPage1 = 1;
            [newSelf getRankListExpertRequestWithlotteryClassCode:@"-201" OrderFlag:@"0" page:@"1"];
        }else if (segmentTag == 11){
            cellPage2 = 1;
            [newSelf getRankListExpertRequestWithlotteryClassCode:@"-201" OrderFlag:@"1" page:@"1"];
        }else if (segmentTag == 12){
            cellPage3 = 1;
            [newSelf getRankListExpertRequestWithlotteryClassCode:@"201" OrderFlag:@"0" page:@"1"];
        }
    }];
    
    myTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if(segmentTag == 10){
            [newSelf getRankListExpertRequestWithlotteryClassCode:@"-201" OrderFlag:@"0" page:[NSString stringWithFormat:@"%ld",(long)cellPage1]];
        }else if (segmentTag == 11){
            [newSelf getRankListExpertRequestWithlotteryClassCode:@"-201" OrderFlag:@"1" page:[NSString stringWithFormat:@"%ld",(long)cellPage2]];
        }else if (segmentTag == 12){
            [newSelf getRankListExpertRequestWithlotteryClassCode:@"201" OrderFlag:@"0" page:[NSString stringWithFormat:@"%ld",(long)cellPage3]];
        }
    }];

}
-(void)getRankListExpertRequestWithlotteryClassCode:(NSString *)lotteryClassCode OrderFlag:(NSString *)orderFlag page:(NSString *)page{
    
    if (!_loadView) {
        _loadView = [[UpLoadView alloc] init];
    }
    if (!_loadView.superview) {
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:_loadView];
    }
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"sid":[[Info getInstance] cbSID],
                                                                                       @"userName":[[Info getInstance] userName],
                                                                                       @"expertClassCode":@"001",//竞彩001  写死
                                                                                       @"lotteryClassCode":lotteryClassCode,
                                                                                       @"orderFlag":orderFlag,
                                                                                       @"curPage":page,
                                                                                       @"pageSize":@"20"}];
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getCrazySportExpertsRankPlanList",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if (_loadView) {
            [_loadView stopRemoveFromSuperview];
            _loadView = nil;
        }
        [myTableView.footer endRefreshing];
        [myTableView.header endRefreshing];
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[[responseJSON valueForKey:@"result"] valueForKey:@"data"];
            if ([result count]!=0) {
                
                if([lotteryClassCode isEqualToString:@"-201"]){
                    if([orderFlag isEqualToString:@"0"]){
                        cellPage1 += 1;
                        NSMutableArray *mutableArr=[dataArym objectAtIndex:0];
                        if([page isEqualToString:@"1"]){
                            [mutableArr removeAllObjects];
                        }
                        for (NSDictionary * dic in result) {
                            [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                        }
                        [dataArym replaceObjectAtIndex:0 withObject:mutableArr];
                    }else if ([orderFlag isEqualToString:@"1"]){
                        cellPage2 += 1;
                        NSMutableArray *mutableArr=[dataArym objectAtIndex:1];
                        if([page isEqualToString:@"1"]){
                            [mutableArr removeAllObjects];
                        }
                        for (NSDictionary * dic in result) {
                            [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                        }
                        [dataArym replaceObjectAtIndex:1 withObject:mutableArr];
                    }
                }else if ([lotteryClassCode isEqualToString:@"201"]){
                    cellPage3 += 1;
                    NSMutableArray *mutableArr=[dataArym objectAtIndex:2];
                    if([page isEqualToString:@"1"]){
                        [mutableArr removeAllObjects];
                    }
                    for (NSDictionary * dic in result) {
                        [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                    }
                    [dataArym replaceObjectAtIndex:2 withObject:mutableArr];
                }
                [myTableView reloadData];
            }
        }else{
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        if (_loadView) {
            [_loadView stopRemoveFromSuperview];
            _loadView = nil;
        }
        [myTableView.footer endRefreshing];
        [myTableView.header endRefreshing];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(segmentTag > 0){
        
        NSMutableArray *ary = [dataArym objectAtIndex:segmentTag-10];
        return ary.count;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(segmentTag > 0){
        NSMutableArray *ary = [dataArym objectAtIndex:segmentTag-10];
        ExpertMainListModel *model = [ary objectAtIndex:indexPath.row];
        if([model.LOTTEY_CLASS_CODE isEqualToString:@"201"]){
            return 150;
        }else{
            return 110;
        }
    }else{
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"ExpertRankListTableViewCell";
    ExpertMainListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ExpertMainListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSMutableArray *ary = [dataArym objectAtIndex:segmentTag-10];
    ExpertMainListModel *model = [ary objectAtIndex:indexPath.row];
    
    __block ExpertRankListViewController * newSelf = self;
    cell.buttonAction = ^(UIButton *button) {
        
        [newSelf getIsBuyInfoWithOrderID:model];
    };
    cell.isZhuanjia = NO;
    [cell loadAppointInfo:model];
//    if(indexPath.row == 0){
//        cell.rankingIma.hidden = NO;
//        cell.rankingIma.image = [UIImage imageNamed:@"expert_first.png"];
//    }else if (indexPath.row == 1){
//        cell.rankingIma.hidden = NO;
//        cell.rankingIma.image = [UIImage imageNamed:@"expert_second.png"];
//    }else if (indexPath.row == 2){
//        cell.rankingIma.hidden = NO;
//        cell.rankingIma.image = [UIImage imageNamed:@"expert_third.png"];
//    }else{
//        cell.rankingIma.hidden = YES;
//    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"单击了某个方案响应函数");
    NSMutableArray *ary = [dataArym objectAtIndex:segmentTag-10];
    ExpertMainListModel *model = [ary objectAtIndex:indexPath.row];
    
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    NSString *lotteryClassCode = @"-201";
    if(segmentTag == 12){
        lotteryClassCode = @"201";
    }
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
    [bodyDic setObject:@{@"expertsName":model.EXPERTS_NAME,@"expertsClassCode":model.EXPERTS_CLASS_CODE,@"loginUserName":nameSty,@"erAgintOrderId":model.ER_AGINT_ORDER_ID,@"type":@"0",@"sdStatus":@"0",@"sid":[[Info getInstance] cbSID],@"lotteryClassCode":lotteryClassCode} forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSLog(@"responseJSON=%@",responseJSON);
        SMGDetailViewController * vc=[[SMGDetailViewController alloc]init];
        NSDictionary *dic=responseJSON[@"result"][@"expertBaseInfo"];
        ExpertBaseInfo *exBase=[ExpertBaseInfo  expertBaseInfoWithDic:dic];
        NSArray *arr=responseJSON[@"result"][@"historyPlanList"];
        NSMutableArray *historyArr=[NSMutableArray arrayWithCapacity:[arr count]];
        for (NSDictionary *dicHistoryPlan in arr) {
            HistoryPlanList *hisPlanList=[HistoryPlanList historyPlanListWithDic:dicHistoryPlan];
            [historyArr addObject:hisPlanList];
        }
        dic=responseJSON[@"result"][@"leastTenInfo"];
        LeastTenInfo *leastTenInfo=[LeastTenInfo leastTenInfoWithDic:dic];
        arr=responseJSON[@"result"][@"newPlanList"];
        NSMutableArray *newPlanArr=[NSMutableArray arrayWithCapacity:[arr count]];
        for (NSDictionary *dicNewPlan in arr) {
            NewPlanList *newPlanList=[NewPlanList newPlanListWithDic:dicNewPlan];
            if ([newPlanList.closeStatus isEqualToString:@"1"]) {
                [newPlanArr addObject:newPlanList];
            }
        }
        vc.historyPlanArr=historyArr;
        vc.leastTenInfo=leastTenInfo;
        vc.npList=newPlanArr;
        vc.exBaseInfo=exBase;
        vc.hidesBottomBarWhenPushed=YES;
        vc.segmentOnClickIndexFlags=YES;
        vc.planIDStr=model.ER_AGINT_ORDER_ID;
        vc.jcyplryType=lotteryClassCode;//
        vc.isSdOrNo=NO;//
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError * error) {
    }];
}
-(void)segmentAction:(UIButton *)button{
    
    if(button.selected){
        return;
    }
    
    for(NSInteger i=10;i<13;i++){
        UIButton *btn = [segmentIma viewWithTag:i];
        btn.selected = NO;
    }
    button.selected = YES;
    segmentTag = button.tag;
    
    [myTableView reloadData];
    
    NSArray *ary = [dataArym objectAtIndex:segmentTag-10];
    if(!ary.count){
        if(segmentTag == 10){
            cellPage1 = 1;
            [self getRankListExpertRequestWithlotteryClassCode:@"-201" OrderFlag:@"0" page:@"1"];
        }else if (segmentTag == 11){
            cellPage2 = 1;
            [self getRankListExpertRequestWithlotteryClassCode:@"-201" OrderFlag:@"1" page:@"1"];
        }else if (segmentTag == 12){
            cellPage3 = 1;
            [self getRankListExpertRequestWithlotteryClassCode:@"201" OrderFlag:@"0" page:@"1"];
        }
    }
}
-(void)dimissAlert:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
}
-(void)getIsBuyInfoWithOrderID:(ExpertMainListModel *)data{//获取是否购买
    
    Info *info = [Info getInstance];
    if (![info.userId intValue]){
        [self toLogin];
        return;
    }
    erAgintOrderId = data.ER_AGINT_ORDER_ID;
    disPrice = data.DISCOUNTPRICE;
    [MobClick event:@"Zj_fangan_20161014_jingcai_fangan" label:[NSString stringWithFormat:@"%@VS%@",data.HOME_NAME1,data.AWAY_NAME1]];
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"verifyIsBuyPlanByUserNameErAgintOrderId" forKey:@"methodName"];
    [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"er_agint_order_id":data.ER_AGINT_ORDER_ID} forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSLog(@"responseJSON=%@",responseJSON);
        NSDictionary *dict = responseJSON[@"result"];//返回编码: 0000：已经购买; 0400:没有购买
        if ([[dict valueForKey:@"code"] isEqualToString:@"0000"]) {
            
            ProjectDetailViewController *proVC=[[ProjectDetailViewController alloc] init];
            proVC.erAgintOrderId=data.ER_AGINT_ORDER_ID;
            proVC.pdLotryType = @"-201";
            proVC.isSdOrNo=NO;
            [self.navigationController pushViewController:proVC animated:YES];
            
        }else if([[dict valueForKey:@"code"] isEqualToString:@"0400"]){
            [self addDealPurchaseTicket:disPrice tag:601];
        }
    } failure:^(NSError * error) {
        
    }];
}
- (void)addDealPurchaseTicket:(float)str tag:(NSInteger)tag{
//#ifdef CRAZYSPORTS
//    int jinbibeishu = 10;//金币和钱比例
//    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"]) {
//        jinbibeishu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"] intValue];
//    }
//    CP_UIAlertView *_cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付"
//                                                             message:[NSString stringWithFormat:@"您将支付(%.0f金币)购买此方案内容",str * jinbibeishu]
//                                                            delegate:self
//                                                   cancelButtonTitle:@"取消"
//                                                   otherButtonTitles:@"确定", nil];
//#else
//    CP_UIAlertView *_cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付"
//                                                             message:[NSString stringWithFormat:@"您将支付(%.2f元)购买此推荐",str]
//                                                            delegate:self
//                                                   cancelButtonTitle:@"取消"
//                                                   otherButtonTitles:@"确定", nil];
//#endif
    
    CP_UIAlertView *_cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付"
                                                             message:[NSString stringWithFormat:@"您将支付(%.2f元)购买此方案内容",str]
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"确定", nil];
    
    _cpAlert.alertTpye=purchasePaln;
    _cpAlert.tag=tag;
    [_cpAlert show];
}
- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message
{
    if (buttonIndex==1&&(alertView.tag==601||alertView.tag==604)) {
        NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
        [bodyDic setObject:@"expertService" forKey:@"serviceName"];
        [bodyDic setObject:@"getLoginUserInfo" forKey:@"methodName"];
        [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName]} forKey:@"parameters"];
        [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
            NSLog(@"responseJSON=%@",responseJSON);
            if ([[responseJSON objectForKey:@"resultCode"] isEqualToString:@"0000"]) {
                NSDictionary * resultDic = [responseJSON objectForKey:@"result"];
                float balance=[[resultDic objectForKey:@"userValidFee"] floatValue];
                if (0 && disPrice>balance) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"您的余额不足请及时充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alert.tag=602;
                    [alert show];
                }else{
                    
                    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
                    [bodyDic setObject:@"commonExpertService" forKey:@"serviceName"];
                    [bodyDic setObject:@"buyPlan" forKey:@"methodName"];
#ifdef CRAZYSPORTS
                    [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"erAgintOrderId":erAgintOrderId,@"orderSource":@"10002000",@"payType":@"1",@"clientType":@"2",@"publishVersion":APPVersion,@"isNew":@"1"} forKey:@"parameters"];
#else
                    [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"erAgintOrderId":erAgintOrderId,@"orderSource":@"10002000",@"clientType":@"2",@"publishVersion":APPVersion,@"isNew":@"1"} forKey:@"parameters"];
#endif
                    
                    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
                        NSLog(@"responseJSON=%@",responseJSON);
                        if([[responseJSON objectForKey:@"resultCode"] isEqualToString:@"0000"]){
                            if([[[responseJSON objectForKey:@"result"] objectForKey:@"code"] isEqualToString:@"0000"]){
                                [MobClick event:@"Zj_fangan_20161014_jingcai_ok" label:nil];
                                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"支付成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                alert.tag=603;
                                [alert show];
                            }else if ([[[responseJSON objectForKey:@"result"] objectForKey:@"code"] isEqualToString:@"0301"]){
                                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"您的余额不足请及时充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                alert.tag=602;
                                [alert show];
                            }
                            else{
                                [MobClick event:@"Zj_fangan_20161014_jingcai_loss" label:[[responseJSON objectForKey:@"result"] objectForKey:@"info"]];
                                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:[[responseJSON objectForKey:@"result"] objectForKey:@"info"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                [alert show];
                            }
                        }else{
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==602){
        if (buttonIndex==1) {
            Expert365Bridge * bridge = [[Expert365Bridge alloc] init];
            [bridge toRechargeFromController:self];
        }
    }else if (alertView.tag==603) {
        
        ProjectDetailViewController *proVC=[[ProjectDetailViewController alloc] init];
        proVC.erAgintOrderId=erAgintOrderId;
        proVC.pdLotryType=@"201";
        proVC.isSdOrNo=NO;
        //        _nPlanBtn.paidStatus=@"1";
        [self.navigationController pushViewController:proVC animated:YES];
    }
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