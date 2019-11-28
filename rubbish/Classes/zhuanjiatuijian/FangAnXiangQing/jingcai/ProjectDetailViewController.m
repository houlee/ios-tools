//
//  PlanDetailsViewController.m
//  Experts
//
//  Created by mac on 15/10/27.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "ProjectDetailViewController.h"
#import "TimeCell.h"
#import "GqXQCell.h"
#import "GameDetailMdl.h"
#import "Expert365Bridge.h"
#import "CompeteViewController.h"
#import "caiboAppDelegate.h"
#import "MBProgressHUD+MJ.h"
#import "ExpertSubmitViewController.h"
#import "GCJCBetViewController.h"

#define MAXFLOAT    0x1.fffffep+127f

@interface ProjectDetailViewController ()<TimeCellDelegate,UIAlertViewDelegate>{
    NSTimer *timer;
}

@property(nonatomic,strong)GameDetailMdl *gameDetlMdl;
@property(nonatomic,strong)GqXQMdl *gqXqMdl;

@end

@implementation ProjectDetailViewController

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (timer&&[timer isValid]) {
        [timer invalidate];
        timer=nil;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
#if defined CRAZYSPORTS
    [self changeCSTitileColor];
#endif
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"ecedf1"];
    [self creatNavView];
    self.title_nav = @"方案详情";
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake1(0, HEIGHTBELOESYSSEVER+44, 320, MyHight-HEIGHTBELOESYSSEVER-44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    if(![_sign isEqualToString:@"0"]){
        self.competeGoBetDic = [NSDictionary dictionary];
        [self requestCompeteData];//获取竞彩数字彩方案详情
    }else{
        [self getGqXq];
        timer=[NSTimer scheduledTimerWithTimeInterval:30.0f target:self selector:@selector(updateGqXQ) userInfo:nil repeats:YES];
        [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

- (void)updateGqXQ{
    [self getGqXq];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    if(![_sign isEqualToString:@"0"]){
        TimeCell *timeCell=(TimeCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!timeCell) {
            timeCell = [[TimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        timeCell.timeCellDelegate=self;
        if (_gameDetlMdl) {
            [timeCell setDataModel:_gameDetlMdl lotryTy:_pdLotryType isSd:[NSString stringWithFormat:@"%i",self.isSdOrNo]];
        }
        return timeCell;
    }else if([_sign isEqualToString:@"0"]){
        GqXQCell *gqCell=(GqXQCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!gqCell) {
            gqCell=[[GqXQCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (_gqXqMdl) {
            [gqCell setGqMdl:_gqXqMdl];
        }
        return gqCell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     NSString *contStr = plainModel.recommendExplain;
     CGRect contentrRect = [contStr boundingRectWithSize:CGSizeMake(MyWidth-20, 3000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONTTWENTY_SIX} context:nil];
     */
    CGFloat heightRow=0.0;
    if(![_sign isEqualToString:@"0"]){
        CompPlanInfoMdl *planMdl = [[CompPlanInfoMdl alloc] init];
        [planMdl setValuesForKeysWithDictionary:_gameDetlMdl.planInfo];
        CGSize contentSize= [PublicMethod setNameFontSize:planMdl.recommendExplain andFont:FONTTWENTY_SIX andMaxSize:CGSizeMake(MyWidth-20, 3000)];
        heightRow=600+contentSize.height+125;
    }else if ([_sign isEqualToString:@"0"]){
        CGSize contentSize= [PublicMethod setNameFontSize:_gqXqMdl.recommendExplain andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(290, 3000)];
        if ([[_gqXqMdl.dicNo objectForKey:@"matchStatus"] intValue]==0) {
            heightRow=453;
        }else{
            heightRow=550+contentSize.height;
            if([[_gqXqMdl.dicNo valueForKey:@"recommendStatus"] intValue]==0){
                heightRow=445+contentSize.height;
            }
        }
    }
    
    return heightRow;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------网络请求---------

-(void)requestCompeteData
{
#if defined YUCEDI || defined DONGGEQIU
    if (![[Info getInstance] userName] && [[caiboAppDelegate getAppDelegate] isShenhe]) {
        [[Info getInstance] setUserName:@"148145604"];
    }
#endif

    NSMutableDictionary  *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"erAgintOrderId": _erAgintOrderId,@"loginUserName":[[Info getInstance] userName],@"levelType":@"1"}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"expertService",@"methodName":@"getPlanInfo",@"parameters":parametersDic}];
    if (_gameDetlMdl) {
        _gameDetlMdl=nil;
    }
    [MBProgressHUD showMessage:@"正在加载..."];
    [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
        NSLog(@"respondObject==%@",respondObject);
        NSDictionary *dataDic = respondObject;
        [MBProgressHUD hideHUD];
        if ([dataDic[@"resultCode"] isEqualToString:@"0000"]) {
            NSDictionary *bigDic = dataDic[@"result"];
            self.competeGoBetDic = bigDic;
            _gameDetlMdl = [[GameDetailMdl alloc]init];
            [_gameDetlMdl setValuesForKeysWithDictionary:bigDic];
            [_tableView reloadData];
        }else{
            [MBProgressHUD showError:dataDic[@"resultDesc"]];
            [MBProgressHUD hideHUD];
            [_tableView removeFromSuperview];
        }
    } failure:^(NSError *error) {
        [_tableView removeFromSuperview];
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
        [MBProgressHUD hideHUD];
    }];
}

-(void)getGqXq
{
    NSMutableDictionary  *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"erAgintOrderId": _erAgintOrderId,@"userName":[[Info getInstance] userName]}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"zjtjIndexService",@"methodName":@"getGqBuyOrderDetail",@"parameters":parametersDic}];
    if (_gqXqMdl) {
        _gqXqMdl=nil;
    }
    [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
        NSLog(@"respondObject==%@",respondObject);
        NSDictionary *dataDic = respondObject;
        if ([dataDic[@"resultCode"] isEqualToString:@"0000"]) {
            NSDictionary *bigDic = dataDic[@"result"];
            _gqXqMdl = [GqXQMdl gqXQMdlWithDic:bigDic];
            [_tableView reloadData];
        }else{
            [_tableView removeFromSuperview];
        }
    } failure:^(NSError *error) {
        [_tableView removeFromSuperview];
    }];
}

#pragma mark 投注此推荐入口
- (void)betClick:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"重新编辑此方案"]) {
        
        ExpertSubmitViewController *vc = [[ExpertSubmitViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];//跳发布页面，信息先不传
        return;
        
        if (_gameDetlMdl) {
            
            CompExpInfoMdl *expertMdl = [[CompExpInfoMdl alloc]init];
            [expertMdl setValuesForKeysWithDictionary:_gameDetlMdl.expertInfo];

            CompPlanInfoMdl *planMdl = [[CompPlanInfoMdl alloc]init];
            [planMdl setValuesForKeysWithDictionary:_gameDetlMdl.planInfo];
            
            CompMdl *competeMdl = [[CompMdl alloc]init];
            for (NSDictionary  *planDic in planMdl.contentInfo) {
                [competeMdl setValuesForKeysWithDictionary:planDic];
            }
            
            NSString *sourPara=@"";
            if ([_pdLotryType isEqualToString:@"-201"] || [_pdLotryType isEqualToString:@"201"]) {
                sourPara=@"1";
            }else if([_pdLotryType isEqualToString:@"202"]){
                sourPara=@"2";
            }else if([_pdLotryType isEqualToString:@"202"]){
                sourPara=@"2";
            }
            Info *info = [Info getInstance];
            NSString *nameSty=@"";
            if ([info.userId intValue]) {
                nameSty=[[Info getInstance] userName];
            }
            NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
            [bodyDic setObject:@"sMGExpertService" forKey:@"serviceName"];
            [bodyDic setObject:@"getAginOrderListByPlayId" forKey:@"methodName"];
            
            NSMutableDictionary * parametersDic=[NSMutableDictionary dictionary];
            [parametersDic setObject:competeMdl.playId forKey:@"playId"];
            [parametersDic setObject:nameSty forKey:@"userName"];
            [parametersDic setObject:sourPara forKey:@"source"];
            [parametersDic setObject:@"1" forKey:@"levelType"];
            [parametersDic setObject:@"20" forKey:@"pageSize"];
            [parametersDic setObject:@"1" forKey:@"currPage"];
            [parametersDic setObject:[NSString stringWithFormat:@"%i",self.isSdOrNo] forKey:@"sdFlag"];
            
            [bodyDic setObject:parametersDic forKey:@"parameters"];
            [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
                if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
                    NSDictionary * bodyData=[responseJSON valueForKey:@"result"];
                    NSDictionary * dic=[bodyData objectForKey:@"matchInfo"];
                    CompeteViewController *competeVC = [[CompeteViewController alloc] init];
                    competeVC.gameDeteilMdl=_gameDetlMdl;
                    competeVC.lotrySource=planMdl.lotteryClassCode;
                    competeVC.supportOrNo=[NSString stringWithFormat:@"%ld",(long)planMdl.free_status];
                    competeVC.compMdl=competeMdl;
                    competeVC.matchIdSelected=[dic objectForKey:@"matchId"];
                    competeVC.selectLeagueName=competeMdl.leagueName;
                    competeVC.homeName=competeMdl.homeName;
                    competeVC.guestName = competeMdl.awayName;
                    competeVC.playID=competeMdl.playId;
                    competeVC.matchStatus = competeMdl.matchStatus;
                    competeVC.selectDate=[dic objectForKey:@"match_DATA"];
                    competeVC.selectTime=competeMdl.matchTime;
                    competeVC.eventId=competeMdl.matchesId;
                    competeVC.rqOddStr=competeMdl.rqOdds;
                    competeVC.oddsStr=competeMdl.odds;
                    competeVC.rqNo=competeMdl.rqs;
                    competeVC.playType=competeMdl.playTypeCode;
                    competeVC.nameAndTimeStr = [NSString stringWithFormat:@"%@   %@VS%@",competeMdl.matchesId,competeMdl.homeName,competeMdl.awayName];
                    competeVC.asianSp=[dic objectForKey:@"rang_QIU_SP"];
                    competeVC.ypRq=[dic objectForKey:@"rq"];
                    competeVC.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:competeVC animated:YES];
                }else{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:responseJSON[@"resultDesc"] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                    [alert show];
                }
            } failure:^(NSError * error) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"服务器错误" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                [alert show];
            }];
        }
    }else if([btn.titleLabel.text isEqualToString:@"投注此推荐"]){
#if !defined YUCEDI && !defined DONGGEQIU
        if([_pdLotryType isEqualToString:@"204"]){
            
            GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:9];
            NSDictionary * planInfoDic = [self.competeGoBetDic valueForKey:@"planInfo"];
            NSString * systemTime = [planInfoDic valueForKey:@"systemtime"];
            NSArray * systemTimeArray = [systemTime componentsSeparatedByString:@" "];
            if (systemTimeArray.count > 1) {
                gcjc.systimestr = [systemTimeArray objectAtIndex:0];
            }else{
                gcjc.systimestr = @"";
            }
            gcjc.zhuanjiaDic = planInfoDic;
            gcjc.lanqiubool = YES;
            [self.navigationController pushViewController:gcjc animated:YES];
        }else{
            if (self.competeGoBetDic && self.competeGoBetDic.count) {
                Expert365Bridge  *experVC = [[Expert365Bridge alloc]init];
                [experVC betJingCaiFromController:self competeGoBetDic:self.competeGoBetDic];
            }
        }
#endif
    }
}

#pragma mark -------------UIAlertViewDelegate---------------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        NSString *urlText =@"https://itunes.apple.com/us/app/yue-cai365-shou-ji-mai-cai/id875144559?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlText]];
    }
}

CG_INLINE CGRect

CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
    CGRect rect;
    rect.origin.x = x ; rect.origin.y = y ;
    rect.size.width = width; rect.size.height = height;
    //AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    //rect.origin.x = x * myDelegate.autoSizeScaleX; rect.origin.y = y * myDelegate.autoSizeScaleY;
    //rect.size.width = width * myDelegate.autoSizeScaleX; rect.size.height = height * myDelegate.autoSizeScaleY;
    return rect;
}



@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    