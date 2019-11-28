
//
//  MyViewController.m
//  Experts
//
//  Created by V1pin on 15/10/26.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "MyViewController.h"
#import "MLNavigationController.h"
#import "MyTableViewCell.h"
#import "BeenPlanViewController.h"
#import "BeenPlanNumViewController.h"
#import "BuyPlanViewController.h"
#import "MySalesViewController.h"
#import "ExpertApplyVC.h"
#import "SZCViewController.h"
#import "CommonProblemViewController.h"
#import "Expert365Bridge.h"
#import "CompeteViewController.h"
#import "MyConcernVc.h"
#import "LoginViewController.h"
#import "GqYiGouVc.h"

#import "ASIHTTPRequest.h"
#import "DataBase.h"
#import "GC_UserInfo.h"
#import "CP_SWButton.h"
#import "GC_HttpService.h"
#import "MobClick.h"
#import "ExpertSubmitViewController.h"

@interface MyViewController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UITableView * _tableView;
    UIImageView * _topImageView;
    UIImageView * _myImage;
    UILabel * _nameLabel;
    NSString  *sourceStr;
    NSString  *jcToday_Pub_Num;//竞彩今日发布次数
    NSString  *ypToday_Pub_Num;//亚盘今日发布次数
    NSString *sdjcToday_Pub_Num;//神单今日竞彩发布次数
    NSString *sdypToday_Pub_Num;//神单今日亚盘发布次数
    
//    BOOL isStar;
    BOOL mayJingcai;//是否可以发竞彩
    BOOL mayErchuanyi;//是否可以发二串一
    BOOL maybasket;//是否可以发篮球
    NSString *erchuanyiNumber;
    NSString *jingcaiNumber;
}

@property(nonatomic,strong)NSArray * myTitArr;
@property(nonatomic,strong)NSArray * myImgArr;

@property(nonatomic,strong)NSDictionary * resDic1;
@property(nonatomic,strong)NSDictionary * resDic2;
@property(nonatomic,strong)NSDictionary * resDic3;
@property(nonatomic,strong)NSDictionary * resDic4;
@property(nonatomic,strong)NSDictionary * qiHaoDic;

@property(nonatomic,strong)NSString * idStr;//用户身份：1、双系专家，2、普通用户，3、竞彩或数字彩专家
@property(nonatomic,strong)NSString * resultId;
@property(nonatomic,retain)Expert365Bridge * bridge;
@property(nonatomic,retain)NSString * personStatusStr;

@property(nonatomic,strong)ASIHTTPRequest *httpRequest;
@property(nonatomic,strong)NSString *balanceStr;

@property(nonatomic,strong)UILabel *blcLab;//当前余额
@property(nonatomic,strong)UILabel *reChargeLab;//点击充值
@property(nonatomic,strong)UIButton *quitBtn;//退出登录

@property(nonatomic,strong)UIView *headIfnoView;

@end

@implementation MyViewController

- (void)dealloc {
    [_httpRequest clearDelegatesAndCancel];
    _httpRequest = nil;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"ecedf1"];
    self.title_nav = @"个人中心";
#if !defined YUCEDI && !defined DONGGEQIU
    [self creatNavView];
#endif
    _bridge = [[Expert365Bridge alloc] init];
    [self createMyTabView];
    
//    [self getStarInfo];
    
//    [self getSubmitNumber];
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
////获取今日发布次数
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
//        [self toLogin];
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
            if([basketBall integerValue] > 0){
                maybasket = YES;
            }else{
                maybasket = NO;
            }
            
        }else{
            
        }
        
    } failure:^(NSError * error) {
        
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setInitEelement];
#if defined YUCEDI || defined DONGGEQIU
    if (_blcLab) {
        [_blcLab removeFromSuperview];
        _blcLab=nil;
    }
    if (_reChargeLab) {
        [_reChargeLab removeFromSuperview];
        _reChargeLab=nil;
    }
#endif
    
    [self getSubmitNumber];
}

- (void)setInitEelement{
    if ([DEFAULTS objectForKey:@"resultDic"] && [[DEFAULTS objectForKey:@"resultDic"] isKindOfClass:[NSDictionary class]] && [[DEFAULTS objectForKey:@"resultDic"] allKeys]!= nil&&
        ![[DEFAULTS objectForKey:@"resultDic"] isEqualToDictionary:[NSDictionary dictionary]])  {
        NSDictionary *baseDic = [DEFAULTS objectForKey:@"resultDic"];
        self.personStatusStr = baseDic[@"expertsCodeArray"];
        sourceStr  = baseDic[@"source"];
        if ([baseDic[@"expertsStatus"] isEqualToString:@"1"]) {
            if (self.personStatusStr.length == 0||self.personStatusStr==nil) {
                _idStr = @"2";
            }else if ([self.personStatusStr isEqualToString:@"001"]) {
                _idStr = @"3";
            }else if ([self.personStatusStr isEqualToString:@"002"]) {
                _idStr = @"4";
            }
        }else{
            _idStr = @"2";
        }
        NSString *str = [baseDic objectForKey:@"headPortrait"];
        NSURL *url=[NSURL URLWithString:str];
        [_myImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageRetryFailed|SDWebImageContinueInBackground];
        _nameLabel.text = [baseDic objectForKey:@"expertsNickName"];
        
    }else{
        _idStr = @"2";//普通用户
    }
    
    _myTitArr=nil;
    _myImgArr=nil;

    if([_idStr isEqualToString:@"2"]){
        [self changeToPersonal];
    }
    if([_idStr isEqualToString:@"3"]||[_idStr isEqualToString:@"4"]){
        [self changeToZj];
    }
    if([_idStr isEqualToString:@"2"]){
        if ([[Info getInstance] nickName]!=nil&&![[[Info getInstance] nickName] isEqualToString:@""]) {
            _nameLabel.text = [[Info getInstance] nickName];
            _headIfnoView.userInteractionEnabled=NO;
        }
    }
    if (([sourceStr isEqualToString:@"1"]&&[_idStr isEqualToString:@"3"])||[_idStr isEqualToString:@"4"]) {
        if(self.personStatusStr){
            [self cheakTimeRequestData];
        }
    }
    [_tableView reloadData];
#if defined YUCEDI || defined DONGGEQIU
    if ([[[Info getInstance] userId] intValue]) {
        [self getAccountInfoRequest];
    }
#endif
    [self getData];
}



-(void)changeToPersonal//个人
{
    _myTitArr = [[NSArray alloc]initWithObjects:@"已购方案",@"已购方案-滚球",@"我的关注",@"提现",@"充值",@"常见问题",nil];;
    _myImgArr = [[NSArray alloc]initWithObjects:@"已购方案",@"已购方案",@"我的关注",@"提现",@"充值",@"常见问题", nil];;
}

-(void)changeToZj//专家
{
    _myTitArr = [[NSArray alloc]initWithObjects:@"已购方案",@"已购方案-滚球",@"我的关注",@"提现",@"充值",@"常见问题", nil];
    _myImgArr = [[NSArray alloc]initWithObjects:@"已购方案",@"已购方案",@"我的关注",@"提现",@"充值",@"常见问题",nil];;
}

-(void)createMyTabView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, MyHight-113) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator=NO;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.separatorColor=SEPARATORCOLOR;
    [self.view addSubview:_tableView];
    
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 115)];
    [_tableView setTableHeaderView:_topImageView];
    _topImageView.backgroundColor = [UIColor clearColor];
    _topImageView.image = [UIImage imageNamed:@"个人中心背景"];
    
    [self createImageAndName];
}

//tabelview顶部的头像跟名字
-(void)createImageAndName
{
#if defined YUCEDI || defined DONGGEQIU
    _headIfnoView=[[UIView alloc] initWithFrame:CGRectMake(MyWidth/2-40, 15, 80, 90)];
    _headIfnoView.backgroundColor=[UIColor clearColor];
    [_topImageView addSubview:_headIfnoView];
#endif
    _myImage = [[UIImageView alloc] init];
    _myImage.image=[UIImage imageNamed:@"默认头像"];
    _myImage.layer.cornerRadius = 27.5;
    _myImage.layer.masksToBounds=YES;
#if defined YUCEDI || defined DONGGEQIU
    [_myImage setFrame:CGRectMake(25/2, 0, 55, 55)];
    [_headIfnoView addSubview:_myImage];
#else
    [_myImage setFrame:CGRectMake((MyWidth - 55)/2, 15, 55, 55)];
    [_topImageView addSubview:_myImage];
#endif
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont boldSystemFontOfSize:16];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.backgroundColor=[UIColor clearColor];
#if defined YUCEDI  || defined DONGGEQIU
    _nameLabel.text=@"点击登录";
    [_nameLabel setFrame:CGRectMake(0, ORIGIN_Y(_myImage)+15, 80, 20)];
    [_headIfnoView addSubview:_nameLabel];
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toLogin)];
    _headIfnoView.userInteractionEnabled=YES;
    _topImageView.userInteractionEnabled=YES;
    [_headIfnoView addGestureRecognizer:tapGesture];
#else
    [_nameLabel setFrame:CGRectMake(0, ORIGIN_Y(_myImage)+15, MyWidth, 20)];
    [_topImageView addSubview:_nameLabel];
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  UIAlertView自动消失处理代码
 */
-(void)alertActionDissmiss:(UIAlertView *)alert{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}

#pragma mark -----------UITableViewDataSource-----------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#if defined YUCEDI  || defined DONGGEQIU
    if ([[Info getInstance] nickName]!=nil&&![[[Info getInstance] nickName] isEqualToString:@""]){
        return 4;
    }
    return 3;
#else
    return 3;
#endif
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowNo=0;
    if (section == 0) {
        return 2;
        
    }
    if (section==1) {
        return 3;
    }
    if (section==2) {
        return 1;
    }
    if (section==3) {
        rowNo=1;
    }
    return rowNo;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    MyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSInteger rowForRowTit=0;
    if([_idStr isEqualToString:@"2"]||[_idStr isEqualToString:@"5"]){
        if (indexPath.section == 1) {
            rowForRowTit=2;
        }
        if (indexPath.section == 2){

            rowForRowTit=5;
        }
    }else if([_idStr isEqualToString:@"3"]||[_idStr isEqualToString:@"4"]){
        if (indexPath.section == 1){

            rowForRowTit=2;
        }
        if (indexPath.section == 2){
            rowForRowTit=5;
        }
    }
    if (indexPath.section!=3) {
        cell.titleLabel.text = [_myTitArr objectAtIndex:indexPath.row+rowForRowTit];
        cell.iconImageView.image = [UIImage imageNamed:[_myImgArr objectAtIndex:indexPath.row+rowForRowTit]];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}


#pragma mark -------UITableViewDelegate---------
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section==0||indexPath.section==1) {
        Info *info = [Info getInstance];
        if (![info.userId intValue]) {

            [self toLogin];
            return;
        }
    }

    if (indexPath.section == 0) {
        if (indexPath.row == 0){
            //已购方案
            [MobClick event:@"Zj_my_20161014_yigou" label:nil];
            BuyPlanViewController * vc = [[BuyPlanViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
            //已购方案(滚球)
            GqYiGouVc * vc = [[GqYiGouVc alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    if (indexPath.section ==1&& ![[[Info getInstance] userName] isEqualToString:@""]){
        int rowIndex=0;
#if defined YUCEDI  || defined DONGGEQIU
        if (indexPath.row == 0){
            [_bridge toRechargeFromController:self];//充值
        }
        if (indexPath.row == 1){
            [_bridge toWithdrawalFromController:self];//提现
        }
        rowIndex=2;
#else
        rowIndex=0;
#endif
        if (![_idStr isEqualToString:@"2"]) {
#if defined YUCEDI  || defined DONGGEQIU
            rowIndex=3;
#else
            rowIndex=1;
#endif
            if (indexPath.row == rowIndex-1) {//我的销量
                MySalesViewController * vc = [[MySalesViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
#if !defined YUCEDI && !defined DONGGEQIU
            rowIndex=0;
#endif
        }
        if (indexPath.row == rowIndex){
            MyConcernVc *myconcernVc=[[MyConcernVc alloc] init];
            myconcernVc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:myconcernVc animated:YES];
        }
#if !defined YUCEDI && !defined DONGGEQIU
        if (indexPath.row == rowIndex+1){
            [_bridge toWithdrawalFromController:self];//提现
        }
        if (indexPath.row == rowIndex+2){
            [_bridge toRechargeFromController:self];//充值
        }
#endif
    }
    
    if (indexPath.section == 2){
        if (indexPath.row == 0) {//常见问题
            CommonProblemViewController * vc = [[CommonProblemViewController alloc]init];
            vc.sourceFrom=@"commonProblem";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark -------------网络请求------------

-(void)cheakTimeRequestData
{
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    NSMutableDictionary * parameters =[NSMutableDictionary dictionaryWithDictionary:@{@"expertsName":nameSty,@"expertsClassCode":self.personStatusStr}];
    NSMutableDictionary * bodDic4 =[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"checkPublishInfo",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic4 success:^(id JSON) {
        NSDictionary *dataDic = JSON;
        if ([dataDic[@"resultCode"] isEqualToString:@"0000"]) {
            NSDictionary *dic = dataDic[@"result"];
            _qiHaoDic=dic;
            jcToday_Pub_Num = dic[@"today_PublishNum_JcSingle"];
            ypToday_Pub_Num=dic[@"today_PublishNum_Asian"];
            sdjcToday_Pub_Num=dic[@"today_PublishNum_SdJcSingle"];
            sdypToday_Pub_Num=dic[@"today_PublishNum_SdAsian"];
            [DEFAULTS setObject:dic forKey:@"qihaodic"];
        }
        [_tableView reloadData];
    } failure:^(NSError * error) {

    }];
}

-(void)getData
{
    NSMutableDictionary * parameters =[NSMutableDictionary dictionaryWithDictionary:@{@"lotteryClassCode":@"001"}];
    NSMutableDictionary * bodDic =[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"digitalExpertService",@"methodName":@"getDigitalLastIssue",@"parameters":parameters}];
    
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic success:^(id JSON) {
        NSLog(@"双色*-*-*-%@",JSON);
        _resDic1 = JSON[@"result"];
        [DEFAULTS setObject:_resDic1 forKey:@"szcssdic"];
    } failure:^(NSError * error) {
        
    }];
    
    NSMutableDictionary * parameters2 =[NSMutableDictionary dictionaryWithDictionary:@{@"lotteryClassCode":@"113"}];
    NSMutableDictionary * bodDic2 =[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"digitalExpertService",@"methodName":@"getDigitalLastIssue",@"parameters":parameters2}];
    
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic2 success:^(id JSON) {
        NSLog(@"大乐*-*-*-%@",JSON);
        _resDic2 = JSON[@"result"];
        [DEFAULTS setObject:_resDic2 forKey:@"szcdltdic"];
    } failure:^(NSError * error) {
        
    }];
    
    NSMutableDictionary * parameters3 =[NSMutableDictionary dictionaryWithDictionary:@{@"lotteryClassCode":@"002"}];
    NSMutableDictionary * bodDic3 =[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"digitalExpertService",@"methodName":@"getDigitalLastIssue",@"parameters":parameters3}];
    
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic3 success:^(id JSON) {
        NSLog(@"福彩*-*-*-%@",JSON);
        _resDic3 = JSON[@"result"];
        [DEFAULTS setObject:_resDic3 forKey:@"szc3ddic"];
    } failure:^(NSError * error) {
        
    }];
    
    NSMutableDictionary * parameters4 =[NSMutableDictionary dictionaryWithDictionary:@{@"lotteryClassCode":@"108"}];
    NSMutableDictionary * bodDic4 =[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"digitalExpertService",@"methodName":@"getDigitalLastIssue",@"parameters":parameters4}];
    
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic4 success:^(id JSON) {
        NSLog(@"排列*-*-*-%@",JSON);
        _resDic4 = JSON[@"result"];
        [DEFAULTS setObject:_resDic4 forKey:@"szcplsdic"];
    } failure:^(NSError * error) {
        
    }];
}

- (void)backClick:(id)sender{
    if ([self.navigationController isKindOfClass:[MLNavigationController class]]) {
        MLNavigationController *nlnav=(MLNavigationController *)self.navigationController;
        nlnav.canDragBack=YES;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backaction" object:self];
}

CG_INLINE CGRect

CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = x; rect.origin.y = y ;
    rect.size.width = width ; rect.size.height = height ;
    //AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    //rect.origin.x = x * myDelegate.autoSizeScaleX; rect.origin.y = y * myDelegate.autoSizeScaleY;
    //rect.size.width = width * myDelegate.autoSizeScaleX; rect.size.height = height * myDelegate.autoSizeScaleY;
    return rect;
}

-(void)toLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
#if defined YUCEDI || defined DONGGEQIU
    loginVC.isPushFromMy=YES;
#endif
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
}

-(void)quitClick{
    _idStr=@"5";
    _nameLabel.text=@"点击登录";
    _headIfnoView.userInteractionEnabled=YES;
    _balanceStr = @"";
    _myImage.image=[UIImage imageNamed:@"默认头像"];
    if (_blcLab) {
        [_blcLab setFrame:CGRectZero];
        _blcLab.text=@"";
        [_blcLab removeFromSuperview];
        _blcLab = nil;
    }
    if (_reChargeLab) {
        [_reChargeLab setFrame:CGRectZero];
        _reChargeLab.text=@"";
        [_reChargeLab removeFromSuperview];
        _reChargeLab=nil;
    }
    if (_quitBtn) {
        [_quitBtn setFrame:CGRectZero];
        _quitBtn=nil;
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"logincp"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"logincp"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isAlipay"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tuisongshezhi"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cheknewpush"];
    
    Info *info = [Info getInstance];
    info.login_name = @"";
    info.userId = @"";
    info.nickName = @"";
    info.userName = @"";
    info.isbindmobile = @"";
    info.authentication = @"";
    info.userName = @"";
    info.requestArray = nil;
    info.mUserInfo = nil;
    info.headImage = nil;
    info.headImageURL = nil;
    info.jifen = nil;
    info.phoneNum = nil;
    [ASIHTTPRequest setSessionCookies:nil];
    [[Info getInstance] setMUserInfo:nil];
    [ASIHTTPRequest clearSession];
    [GC_UserInfo sharedInstance].personalData = nil;
    [GC_HttpService sharedInstance].sessionId = nil;
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isUnion"];
    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isUnionType"];
    [GC_UserInfo sharedInstance].accountManage = nil;
    
    NSMutableDictionary * weiBoLikeDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"weiBoLike"]];
    [weiBoLikeDic removeAllObjects];
    [[NSUserDefaults standardUserDefaults] setObject:weiBoLikeDic forKey:@"weiBoLike"];
    
    //清除专家推荐
    [DEFAULTS removeObjectForKey:@"resultDic"];
    [DEFAULTS setObject:[NSDictionary dictionary] forKey:@"resultDic"];
    [self setInitEelement];
    [_tableView reloadData];
}

- (void)getAccountInfoRequest
{
    if ([[[Info getInstance] userName] length] > 0) {
        //获取账户信息
        NSMutableData *postData = [[GC_HttpService sharedInstance] reqAccountManager:[[Info getInstance] userName]];
        [_httpRequest clearDelegatesAndCancel];
        _httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [_httpRequest setRequestMethod:@"POST"];
        [_httpRequest addCommHeaders];
        [_httpRequest setPostBody:postData];
        [_httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [_httpRequest setDelegate:self];
        [_httpRequest setDidFinishSelector:@selector(reqAccountInfoFinished:)];
        [_httpRequest setDidFailSelector:@selector(reqAccountInfoFail:)];
        [_httpRequest startAsynchronous];
    }
}

- (void)reqAccountInfoFinished:(ASIHTTPRequest*)request
{
    if ([request responseData]) {
        GC_AccountManage *aManage = [[GC_AccountManage alloc] initWithResponseData:[request responseData] WithRequest:request];
        [GC_UserInfo sharedInstance].accountManage = aManage;
        if ([[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue] == 0) {
            _balanceStr = @"0.00";
        }else{
            _balanceStr = [NSString stringWithFormat:@"%@",[GC_UserInfo sharedInstance].accountManage.accountBalance];
        }
        [_tableView reloadData];
    }
}

-(void)reqAccountInfoFail:(ASIHTTPRequest*)request
{
    NSLog(@"获取失败");
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    