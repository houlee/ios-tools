//
//  MyExpertViewController.m
//  caibo
//
//  Created by cp365dev6 on 2016/12/1.
//
//

#import "MyExpertViewController.h"
#import "BeenPlanViewController.h"
#import "MySalesViewController.h"
#import "ExpertSubmitViewController.h"
#import "BuyPlanViewController.h"
#import "MyConcernVc.h"
#import "ExpertApplyVC.h"
#import "LoginViewController.h"
#import "Expert365Bridge.h"

@interface MyExpertViewController ()
{
    UITableView *myTableView;
    NSMutableArray *dataArym;
    
    NSString *erchuanyiNumber;
    NSString *jingcaiNumber;
    
//    BOOL isStar;
    BOOL mayJingcai;//是否可以发竞彩
    BOOL mayErchuanyi;//是否可以发二串一
    
    Expert365Bridge *_bridge;
}
@end

@implementation MyExpertViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getSubmitNumber];
    
    [self changeCSTitileColor];
}
//-(void)getStarInfo{
//    
//    isStar = NO;
//    mayJingcai = NO;
//    mayErchuanyi = NO;
//    
//    NSDictionary * expertResult = [DEFAULTS valueForKey:@"resultDic"];
//    
//    if ([[expertResult valueForKey:@"isStar"] isEqualToString:@"1"]){//明星---无限发
//        isStar = YES;
//    }else{
//        NSString *jcLevel = [expertResult valueForKey:@"jcLevel"];
//        jingcaiNumber = @"5";
//        if ([jcLevel integerValue] > 5){
//            jingcaiNumber = @"40";
//        }
//        NSString *jcCombineLevel = [expertResult valueForKey:@"jcCombineLevel"];
//        erchuanyiNumber = @"5";
//        if([jcCombineLevel integerValue] > 5){
//            erchuanyiNumber = @"40";
//        }
//    }
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _bridge = [[Expert365Bridge alloc] init];
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(goBack)];
    self.CP_navigation.title = @"专家推荐";
    
//    [self getStarInfo];
    
    [self getSubmitNumber];
    
    [self createTableView];
}
-(void)createTableView{
    
    dataArym = [[NSMutableArray alloc]initWithCapacity:0];
    
    NSDictionary * expertResult = [DEFAULTS valueForKey:@"resultDic"];
    
    if ([[expertResult valueForKey:@"smgAuditStatus"] isEqualToString:@"2"] && [[expertResult valueForKey:@"expertsCodeArray"] isEqualToString:@"001"]){
        
        [dataArym addObject:@"发布方案"];
        [dataArym addObject:@"已发方案"];
        [dataArym addObject:@"已购方案"];
        [dataArym addObject:@"我的关注"];
        [dataArym addObject:@"我的销量"];
    }else{
        
        [dataArym addObject:@"已发方案"];
        [dataArym addObject:@"已购方案"];
        [dataArym addObject:@"我的关注"];
    }
    
    myTableView = [[UITableView alloc] initWithFrame:self.mainView.bounds];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.mainView addSubview:myTableView];
//    myTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    myTableView.backgroundColor = DEFAULT_BACKGROUNDCOLOR_CRAZY;
    
    [myTableView reloadData];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellName = @"cellName";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [dataArym objectAtIndex:indexPath.section];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.87];
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArym.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    NSString *text = [dataArym objectAtIndex:section];
    if([text isEqualToString:@"我的关注"]){
        return 8;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *text = [dataArym objectAtIndex:indexPath.section];
    if([text isEqualToString:@"发布方案"]){
        if([_bridge validateRealNameFormController:self]==NO){
            return;
        }
        if ([DEFAULTS objectForKey:@"resultDic"] && [[DEFAULTS objectForKey:@"resultDic"] isKindOfClass:[NSDictionary class]] && [[DEFAULTS objectForKey:@"resultDic"] allKeys]!= nil&&
            ![[DEFAULTS objectForKey:@"resultDic"] isEqualToDictionary:[NSDictionary dictionary]]) {
            
            if(mayErchuanyi || mayJingcai){
                ExpertSubmitViewController *vc = [[ExpertSubmitViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [[caiboAppDelegate getAppDelegate] showMessage:@"您已超过发布次数限制"];
                return;
            }
        }else{//普通用户需要申请成为专家
            ExpertApplyVC *expertApplyVc=[[ExpertApplyVC alloc] init];
            expertApplyVc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:expertApplyVc animated:YES];
        }
    }else if ([text isEqualToString:@"已发方案"]){
        BeenPlanViewController *vc = [[BeenPlanViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([text isEqualToString:@"已购方案"]){
        BuyPlanViewController *vc = [[BuyPlanViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([text isEqualToString:@"我的关注"]){
        MyConcernVc *vc=[[MyConcernVc alloc] init];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([text isEqualToString:@"我的销量"]){
        MySalesViewController *vc = [[MySalesViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)toLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
}
//-(void)requestPulishNo
//{
//    Info *info = [Info getInstance];
//    if (![info.userId intValue]) {
//        [self toLogin];
//        return;
//    }
//    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:@{@"expertsName":[[Info getInstance] userName],@"expertsClassCode":@"001"}];
//    NSMutableDictionary *bodDic4=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"checkPublishInfo",@"parameters":parameters}];
//    [RequestEntity requestDatapartWithJsonBodyDic:bodDic4 success:^(id JSON) {
//        NSDictionary *dic=JSON[@"result"];
//        NSString *jingcaiNum = [dic valueForKey:@"today_PublishNum_JcSingle"];
//        NSString *erchuanyiNum = [dic valueForKey:@"today_PublishNum_JcCombine"];
//        
//        if([erchuanyiNum integerValue] < [erchuanyiNumber integerValue]){
//            mayErchuanyi = YES;
//        }else{
//            mayErchuanyi = NO;
//        }
//        if([jingcaiNum integerValue] < [jingcaiNumber integerValue]){
//            mayJingcai = YES;
//        }else{
//            mayJingcai = NO;
//        }
//        
//        
//    } failure:^(NSError * error) {
//        
//    }];
//}
#pragma mark ----------获取今日发布方案的次数-------------

-(void)getSubmitNumber
{
    Info *info = [Info getInstance];
    if (![info.userId intValue]) {
        [self toLogin];
        return;
    }
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:@{@"expertsName":[[Info getInstance] userName]}];
    NSMutableDictionary *bodDic4=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"checkPublishResidueTimes",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic4 success:^(id JSON) {
        
        if([[JSON valueForKey:@"resultCode"] isEqualToString:@"0000"]){
            NSDictionary *dic=JSON[@"result"];
            NSString *jcSingle = [dic valueForKey:@"jcSingle"];//今日剩余竞彩发布次数
            NSString *jcCombine = [dic valueForKey:@"jcCombine"];//今日剩余二串一
            NSString *asian = [dic valueForKey:@"asian"];//今日剩余亚盘
            NSString *basketBall = [dic valueForKey:@"basketBall"];//今日剩余篮球
            
            if([jcCombine integerValue] > 0){
                mayErchuanyi = YES;
            }else{
                mayErchuanyi = NO;
            }
            if([jcSingle integerValue] > 0){
                mayJingcai = YES;
            }else{
                mayJingcai = NO;
            }
        }else{
            
        }
        
    } failure:^(NSError * error) {
        
    }];
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