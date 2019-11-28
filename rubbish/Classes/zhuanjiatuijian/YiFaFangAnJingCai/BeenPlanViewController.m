//
//  BeenPlanViewController.m
//  Experts
//
//  Created by wlh on 15/10/27.
//  Copyright © 2015年 wlh. All rights reserved.
//

#import "BeenPlanViewController.h"
#import "PlanSMGTableViewCell.h"
#import "BeenPlanSMGModel.h"
#import "BeenPlanHisModel.h"
#import "ProjectDetailViewController.h"
#import "CompeteViewController.h"
#import "RejectedCell.h"
#import "SharedMethod.h"

#import "caiboAppDelegate.h"
#import "UpLoadView.h"
#import "ExpertPublishedTableViewCell.h"
#import "ExpertSubmitViewController.h"
#import "ExpertApplyVC.h"
#import "LoginViewController.h"

@interface BeenPlanViewController ()<UITableViewDataSource,UITableViewDelegate,RejectedCellDelegate>{
    UILabel *_Baselabel;
    
    UITableView * _chooseTabelView; //筛选tableview
    
    NSArray * _selNewRecommend;
    NSArray * _selHistroy;
    
    UpLoadView *loadview;
    
    NSString *erchuanyiNumber;
    NSString *jingcaiNumber;
    
//    BOOL isStar;
    BOOL mayJingcai;//是否可以发竞足
    BOOL mayErchuanyi;//是否可以发2串1
    BOOL mayLancai;//是否可以发篮彩
}

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIImageView *optView;

@property(nonatomic, strong)UITableView *jcTableView;
@property(nonatomic, strong)UITableView *ypTableView;
@property(nonatomic, strong)UITableView *lcTableView;

@property(nonatomic, strong)UIButton *jcYiFaBtn;
@property(nonatomic, strong)UIButton *ypYiFaBtn;
@property(nonatomic, strong)UIButton *lcYiFaBtn;

@property(nonatomic, strong)NSMutableArray *jcPlanArr;
@property(nonatomic, strong)NSMutableArray *ypPlanArr;
@property(nonatomic, strong)NSMutableArray *lcPlanArr;

@property(nonatomic, assign)NSInteger jcCPage;
@property(nonatomic, assign)NSInteger ypCPage;
@property(nonatomic, assign)NSInteger lcCPage;

@property(nonatomic, strong)NSString *yifaSource;//彩种(-201:竞足，202:亚盘)2012串1

@property(nonatomic, strong)NSString *searchType;//过滤条件

@property(nonatomic, strong)NSString *methodName;//方法名

@property(nonatomic, assign)NSInteger firstSing;//判断是否第一次进入
@property(nonatomic, strong)NSString *firScroll;//判断是否第一次滚动

@property(nonatomic, strong)UIView * jcBpView;//无最新推荐图案
@property(nonatomic, strong)UIView * ypBpView;//无最新推荐图案
@property(nonatomic, strong)UIView * lcBpView;//无最新推荐图案

@property(nonatomic, strong)NSString *jcTagNewOrHis;
@property(nonatomic, strong)NSString *ypTagNewOrHis;
@property(nonatomic, strong)NSString *lcTagNewOrHis;

@property(nonatomic, strong)NSString *jcNewType;
@property(nonatomic, strong)NSString *jcHisType;
@property(nonatomic, strong)NSString *ypNewType;
@property(nonatomic, strong)NSString *ypHisType;
@property(nonatomic, strong)NSString *lcNewType;
@property(nonatomic, strong)NSString *lcHisType;

@end

@implementation BeenPlanViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        _selNewRecommend = [[NSArray alloc]initWithObjects:@"全部",@"在售中",@"已停售",@"审核中",@"未通过", nil];
        _selHistroy= [[NSArray alloc]initWithObjects:@"全部",@"荐中",@"未中",nil];
    }
    return self;
}
-(void)loadSegmentView{
    
    segmentIma = [[UIImageView alloc]init];
    segmentIma.frame = CGRectMake((self.view.frame.size.width - 225)/2.0, 10+HEIGHTBELOESYSSEVER, 225, 23);
    segmentIma.backgroundColor = [UIColor clearColor];
    segmentIma.image = [UIImage imageNamed:@"expert_white_segment_bg.png"];
    segmentIma.userInteractionEnabled = YES;
    [self.navView addSubview:segmentIma];
    
    NSArray *ary = [NSArray arrayWithObjects:@"竞足",@"2串1", nil];
    for(NSInteger i=0;i<2;i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(112.5*i, 0, 112.5, 23);
        btn.backgroundColor = [UIColor clearColor];
//        btn.tag = 10+i;
//        if(i == 0){
//            btn.selected = YES;
//            segmentTag = btn.tag;
//        }
        if (i==0) {
            btn.selected=YES;
            _jcYiFaBtn=btn;
        }else if(i==1){
            _ypYiFaBtn=btn;
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:[ary objectAtIndex:i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"expert_white_segment_selected.png"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [segmentIma addSubview:btn];
        [btn addTarget:self action:@selector(btnYiFaClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:118/255.0 blue:188/255.0 alpha:1.0] forState:UIControlStateSelected];
#if defined CRAZYSPORTS
        [btn setTitleColor:[SharedMethod getColorByHexString:@"6e29bd"] forState:UIControlStateSelected];
#endif
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getSubmitNumber];
    
#if defined CRAZYSPORTS
    [self changeCSTitileColor];
#endif
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
            NSString *jcSingle = [dic valueForKey:@"jcSingle"];//今日剩余竞足发布次数
            NSString *jcCombine = [dic valueForKey:@"jcCombine"];//今日剩余2串1
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
                mayLancai = YES;
            }else{
                mayLancai = NO;
            }
        }else{
            
        }
        
    } failure:^(NSError * error) {
        
    }];
}
-(void)newLoadSegmentView{
    
    NSString *btnText=@"";
    UIButton *btn;
    for (int i=0; i<3; i++) {
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(27+(MyWidth-62)/3*i, HEIGHTBELOESYSSEVER, (MyWidth-62)/3, 44)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithRed:170.0/255.0 green:218.0/255.0 blue:252.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        if (i==0) {
            btn.selected=YES;
            _jcYiFaBtn=btn;
            btnText=@"竞足";
        }else if(i==1){
            _lcYiFaBtn=btn;
            btnText=@"篮彩";
        }else if(i==2){
            _ypYiFaBtn=btn;
            btnText=@"2串1";
        }
        [btn setTitle:btnText forState:UIControlStateNormal];
        [btn setTitle:btnText forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnYiFaClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=FONTTHIRTY;
        [self.navView addSubview:btn];
    }
}
- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    
//    [self getStarInfo];
    
    [self getSubmitNumber];
    
    [super viewDidLoad];
    [self creatNavView];
    
//    [self loadSegmentView];
    
    [self newLoadSegmentView];
    
    //self.title_nav = @"已发方案";
//    NSString *btnText=@"";
//    UIButton *btn;
//    for (int i=0; i<2; i++) {
//        btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setFrame:CGRectMake(27+(MyWidth-62)/2*i, HEIGHTBELOESYSSEVER, (MyWidth-62)/2, 44)];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [btn setTitleColor:[UIColor colorWithRed:170.0/255.0 green:218.0/255.0 blue:252.0/255.0 alpha:1.0] forState:UIControlStateNormal];
//        if (i==0) {
//            btn.selected=YES;
//            _jcYiFaBtn=btn;
//            btnText=@"竞足";
//        }else if(i==1){
//            _ypYiFaBtn=btn;
//            btnText=@"亚盘";
//        }
//        [btn setTitle:btnText forState:UIControlStateNormal];
//        [btn setTitle:btnText forState:UIControlStateHighlighted];
//        [btn addTarget:self action:@selector(btnYiFaClick:) forControlEvents:UIControlEventTouchUpInside];
//        btn.titleLabel.font=FONTTHIRTY;
//        [self.navView addSubview:btn];
//    }
    
    
    
    [self creatTypeButton];
    [self createTabelView];
    [self creatChooseTableView];
    [self setupRefresh];//刷新
    
    _yifaSource=@"-201";
    _searchType=@"0";
    _jcNewType=@"0";
    _jcHisType=@"0";
    _ypNewType=@"0";
    _ypHisType=@"0";
    _lcNewType = @"0";
    _lcHisType = @";";
    
    _jcCPage=1;
    _ypCPage=1;
    _lcCPage = 1;
    _firstSing = 1;
    _firScroll=@"1";
    _methodName=@"getSMGPublishedNewPlanList";
    _jcTagNewOrHis=_methodName;
    _ypTagNewOrHis=_methodName;
    _lcTagNewOrHis = _methodName;
    
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    
    [self getData:_searchType page:@"1"];//数据请求（0全部(closeStatus为1，2),1在售中,2已停售,3审核中,4未通过）
}

- (void)creatTypeButton
{
    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, MyHight-HEIGHTBELOESYSSEVER-44)];
    _scrollView.backgroundColor=[UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
//    _scrollView.contentSize=CGSizeMake(2*MyWidth, MyHight-HEIGHTBELOESYSSEVER-44-49);
    _scrollView.contentSize=CGSizeMake(3*MyWidth, MyHight-HEIGHTBELOESYSSEVER-44-49);
    _scrollView.delegate=self;
    _scrollView.tag=501;
    _scrollView.bounces=NO;
    [self.view addSubview:_scrollView];
    
//    _optView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MyWidth*2, 44)];
    _optView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MyWidth*3, 44)];
#if defined CRAZYSPORTS
    _optView.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
#else
    _optView.image=[UIImage imageNamed:@"已发方案-导航条"];
#endif
    
    _optView.userInteractionEnabled=YES;
    [_scrollView addSubview:_optView];
    
    NSArray * dataSource = [NSArray arrayWithObjects:@"最新推荐",@"历史战绩",@"最新推荐",@"历史战绩",@"最新推荐",@"历史战绩",nil];
    for (int i = 0; i <=5; i++) {
        UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        typeBtn.frame = CGRectMake(MyWidth/2*i, 0, MyWidth/2, 44);
//        [typeBtn setTitleColor:[UIColor colorWithRed:116.0/255 green:210.0/255 blue:255.0/255 alpha:1] forState:UIControlStateNormal];
        [typeBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
        [typeBtn setTitleColor:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1] forState:UIControlStateSelected];
        [typeBtn setTitle:[dataSource objectAtIndex:i] forState:UIControlStateNormal];
        [typeBtn setTitle:[dataSource objectAtIndex:i] forState:UIControlStateSelected];
        typeBtn.titleLabel.font = FONTTHIRTY;
        typeBtn.backgroundColor = [UIColor clearColor];
        typeBtn.tag = 1000 + i;
        [typeBtn addTarget:self action:@selector(optBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        [_optView addSubview:typeBtn];
        if (i==0||i==2 || i == 4) {
            typeBtn.selected=YES;
        }
        CGSize btnsize=[PublicMethod setNameFontSize:typeBtn.titleLabel.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [typeBtn setTitleEdgeInsets:UIEdgeInsetsMake(22-btnsize.height/2, MyWidth/4-btnsize.width/2-10.5/2, 22-btnsize.height/2, MyWidth/4-btnsize.width/2+10.5/2)];
        
        UIButton * setButImg = [UIButton buttonWithType:UIButtonTypeCustom];
        setButImg.frame = CGRectMake(MyWidth/4+btnsize.width/2-5.25/2, 6, 35, 25);
        if (i==1) {
            setButImg.frame = CGRectMake(MyWidth*3/4+btnsize.width/2-5.25, 6, 35, 25);
        }else if (i==2){
            setButImg.frame = CGRectMake(MyWidth*5/4+btnsize.width/2-5.25, 6, 35, 25);
        }else if(i==3){
            setButImg.frame = CGRectMake(MyWidth*7/4+btnsize.width/2-5.25, 6, 35, 25);
            setButImg.hidden = YES;
        }else if(i==4){
            setButImg.frame = CGRectMake(MyWidth*9/4+btnsize.width/2-5.25, 6, 35, 25);
        }else if(i==5){
            setButImg.frame = CGRectMake(MyWidth*11/4+btnsize.width/2-5.25, 6, 35, 25);
        }
        [setButImg setImage:[UIImage imageNamed:@"已发方案-导航-筛选按钮-已选"] forState:UIControlStateNormal];
        [setButImg setImage:[UIImage imageNamed:@"已发方案-导航-筛选按钮-未选"] forState:UIControlStateSelected];
        [setButImg setImageEdgeInsets:UIEdgeInsetsMake(10,5,6,19)];
        [setButImg addTarget:self action:@selector(smBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        setButImg.backgroundColor = [UIColor clearColor];
        setButImg.tag = 3000+i;
        [_optView addSubview:setButImg];
        
        if (setButImg.tag==3000||setButImg.tag==3002 || setButImg.tag == 3004) {
            setButImg.selected=YES;
        }
    }
    
    UIView * divid = [[UIView alloc] initWithFrame:CGRectMake(MyWidth/2-0.5,9.5, 1, 25)];
    divid.backgroundColor = [UIColor colorWithRed:0.46 green:0.83 blue:1 alpha:1];
    divid.hidden = YES;
    [_optView addSubview:divid];
    
    UIView * divid1 = [[UIView alloc] initWithFrame:CGRectMake(MyWidth*3/2-0.5,9.5, 1, 25)];
    divid1.backgroundColor = [UIColor colorWithRed:0.46 green:0.83 blue:1 alpha:1];
    divid1.hidden = YES;
    [_optView addSubview:divid1];
}

-(void)createTabelView
{
    _jcTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, MyWidth,_scrollView.frame.size.height-44) style:UITableViewStylePlain];
    _jcTableView.delegate = self;
    _jcTableView.dataSource = self;
    _jcTableView.tag = 201;
    _jcTableView.showsHorizontalScrollIndicator=NO;
    _jcTableView.showsVerticalScrollIndicator=NO;
    _jcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:_jcTableView];
    
    _lcTableView=[[UITableView alloc]initWithFrame:CGRectMake(MyWidth, 44, MyWidth,_scrollView.frame.size.height-44) style:UITableViewStylePlain];
    _lcTableView.delegate = self;
    _lcTableView.dataSource = self;
    _lcTableView.tag = 203;
    _lcTableView.showsHorizontalScrollIndicator=NO;
    _lcTableView.showsVerticalScrollIndicator=NO;
    _lcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:_lcTableView];
    
    _ypTableView=[[UITableView alloc]initWithFrame:CGRectMake(MyWidth*2, 44, MyWidth,_scrollView.frame.size.height-44) style:UITableViewStylePlain];
    _ypTableView.delegate = self;
    _ypTableView.dataSource = self;
    _ypTableView.tag = 202;
    _ypTableView.showsHorizontalScrollIndicator=NO;
    _ypTableView.showsVerticalScrollIndicator=NO;
    _ypTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:_ypTableView];
}

#pragma mark ------筛选tableview------

-(void)creatChooseTableView
{
    _chooseTabelView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _chooseTabelView.dataSource = self;
    _chooseTabelView.delegate = self;
    _chooseTabelView.tag = 102;
    _chooseTabelView.hidden = YES;
    _chooseTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_chooseTabelView];
}

#pragma mark -----如果没有发布方案提示用户发布方案--------

-(void)createIfNoHave
{
    UIView *bpview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyWidth, _scrollView.frame.size.height-44)];
    bpview.backgroundColor = [UIColor whiteColor];
    
    UIImage * image = [UIImage imageNamed:@"大师您还没有最新方案"];
    UIImageView * simgV = [[UIImageView alloc] initWithFrame:CGRectMake((MyWidth - image.size.width)/2, 88, image.size.width, image.size.height)];
    [simgV setImage:image];
    [bpview addSubview:simgV];

    UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake((MyWidth - 140)/2, ORIGIN_Y(simgV)+50, 140, 40);
    [but setBackgroundImage:[UIImage imageNamed:@"发布方案-确定按钮@2x"] forState:normal];
    but.layer.cornerRadius = 5;
    but.layer.masksToBounds = YES;
    [but setTitle:@"发布方案" forState:normal];
    [but addTarget:self action:@selector(makeAction) forControlEvents:UIControlEventTouchUpInside];
    [bpview addSubview:but];
    
    NSDictionary * expertResult = [DEFAULTS valueForKey:@"resultDic"];
    if ([[expertResult valueForKey:@"smgAuditStatus"] isEqualToString:@"2"] && [[expertResult valueForKey:@"expertsCodeArray"] isEqualToString:@"001"]){
        but.hidden = NO;
    }else{
        but.hidden = YES;
    }
    
    if ([_yifaSource isEqualToString:@"-201"]) {
        _jcBpView=bpview;
        [_jcTableView addSubview:bpview];
    }else if ([_yifaSource isEqualToString:@"201"]) {
        _ypBpView=bpview;
        [_ypTableView addSubview:bpview];
    }else if ([_yifaSource isEqualToString:@"204"]) {
        _lcBpView=bpview;
        [_lcTableView addSubview:bpview];
    }
}

#pragma mark -------前往发布方案页面----------

-(void)makeAction
{
//    CompeteViewController * vc = [[CompeteViewController alloc]init];
//    vc.lotrySource=_yifaSource;
//    [self.navigationController pushViewController:vc animated:YES];
    
    if ([DEFAULTS objectForKey:@"resultDic"] && [[DEFAULTS objectForKey:@"resultDic"] isKindOfClass:[NSDictionary class]] && [[DEFAULTS objectForKey:@"resultDic"] allKeys]!= nil&&
        ![[DEFAULTS objectForKey:@"resultDic"] isEqualToDictionary:[NSDictionary dictionary]]) {
        
        if(mayErchuanyi || mayJingcai || mayLancai){
            ExpertSubmitViewController *vc = [[ExpertSubmitViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [[caiboAppDelegate getAppDelegate] showMessage:@"您已超过发布次数限制"];
            return;
        }
//        ExpertSubmitViewController *vc = [[ExpertSubmitViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
    }else{//普通用户需要申请成为专家
        ExpertApplyVC *expertApplyVc=[[ExpertApplyVC alloc] init];
        expertApplyVc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:expertApplyVc animated:YES];
    }
}

- (void)btnYiFaClick:(UIButton *)btn{
    if (btn.selected==YES) {
        return;
    }
    btn.selected=YES;
    if([_yifaSource isEqualToString:@"-201"]){
        _jcTableView.alpha=1;
        if (_jcBpView) {
            _jcBpView.alpha=1.0;
        }
    }else if([_yifaSource isEqualToString:@"201"]){
        _ypTableView.alpha=1;
        if (_ypBpView) {
            _ypBpView.alpha=1.0;
        }
    }else if([_yifaSource isEqualToString:@"204"]){
        _lcTableView.alpha=1;
        if (_lcBpView) {
            _lcBpView.alpha=1.0;
        }
    }
    _chooseTabelView.hidden=YES;
    self.view.backgroundColor = [UIColor whiteColor];//阴影效果取消
    _scrollView.scrollEnabled=YES;
    
    _selHistroy = nil;
    float wid;
    if (btn==_jcYiFaBtn) {
        _yifaSource=@"-201";
        _ypYiFaBtn.selected=NO;
        _lcYiFaBtn.selected = NO;
        _selHistroy= [[NSArray alloc]initWithObjects:@"全部",@"荐中",@"未中",nil];
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        if (!_jcPlanArr&&[_jcTagNewOrHis isEqualToString:@"getSMGPublishedNewPlanList"]) {
            _jcCPage=1;
            _jcNewType=@"0";
            _methodName=@"getSMGPublishedNewPlanList";
            _firScroll=@"2";
            [self getData:_jcNewType page:@"1"];
        }
        if ([_jcTagNewOrHis isEqualToString:@"getSMGPublishedNewPlanList"]) {
            _searchType=_jcNewType;
        }else if ([_jcTagNewOrHis isEqualToString:@"getSMGPublishedHisPlanList"]){
            _searchType=_jcHisType;
        }
        _methodName=_jcTagNewOrHis;
        wid=0;
    }else if(btn==_ypYiFaBtn){
        _yifaSource=@"201";
        _jcYiFaBtn.selected=NO;
        _lcYiFaBtn.selected = NO;
//        _selHistroy= [[NSArray alloc]initWithObjects:@"全部",@"荐中",@"未中",@"走盘", nil];
        _selHistroy= [[NSArray alloc]initWithObjects:@"全部",@"荐中",@"未中", nil];
        [_scrollView setContentOffset:CGPointMake(MyWidth*2, 0) animated:YES];
        if (!_ypPlanArr&&[_ypTagNewOrHis isEqualToString:@"getSMGPublishedNewPlanList"]) {
            _ypCPage=1;
            _ypNewType=@"0";
            _methodName=@"getSMGPublishedNewPlanList";
            _firScroll=@"2";
            [self getData:_ypNewType page:@"1"];
        }
        if ([_ypTagNewOrHis isEqualToString:@"getSMGPublishedNewPlanList"]) {
            _searchType=_ypNewType;
        }else if ([_ypTagNewOrHis isEqualToString:@"getSMGPublishedHisPlanList"]){
            _searchType=_ypHisType;
        }
        _methodName=_ypTagNewOrHis;
        wid=MyWidth;
    }else if(btn==_lcYiFaBtn){
        _yifaSource=@"204";
        _ypYiFaBtn.selected=NO;
        _jcYiFaBtn.selected=NO;
        _selHistroy= [[NSArray alloc]initWithObjects:@"全部",@"荐中",@"未中", nil];
        [_scrollView setContentOffset:CGPointMake(MyWidth, 0) animated:YES];
        if (!_lcPlanArr&&[_lcTagNewOrHis isEqualToString:@"getSMGPublishedNewPlanList"]) {
            _lcCPage=1;
            _lcNewType=@"0";
            _methodName=@"getSMGPublishedNewPlanList";
            _firScroll=@"2";
            [self getData:_lcNewType page:@"1"];
        }
        if ([_lcTagNewOrHis isEqualToString:@"getSMGPublishedNewPlanList"]) {
            _searchType=_lcNewType;
        }else if ([_lcTagNewOrHis isEqualToString:@"getSMGPublishedHisPlanList"]){
            _searchType=_lcHisType;
        }
        _methodName=_lcTagNewOrHis;
        wid=MyWidth;
    }
    _chooseTabelView.frame = CGRectMake(wid, HEIGHTBELOESYSSEVER+88, MyWidth, 50*[_selHistroy count]);
    [_chooseTabelView reloadData];
}


#pragma mark --------筛选最新推荐与历史战绩--------

-(void)optBtnAct:(UIButton*)sender
{
    sender.selected=YES;
    _chooseTabelView.hidden=YES;
    self.view.backgroundColor = [UIColor whiteColor];//阴影效果取消
    _scrollView.scrollEnabled=YES;
    if([_yifaSource isEqualToString:@"-201"]){
        _jcTableView.alpha = 1;
        _jcCPage=1;
    }else if([_yifaSource isEqualToString:@"201"]){
        _ypTableView.alpha = 1;
        _ypCPage=1;
    }else if([_yifaSource isEqualToString:@"204"]){
        _lcTableView.alpha = 1;
        _lcCPage=1;
    }
    _firstSing=1;
    _searchType=@"0";
    
    if (sender.tag == 1000) {
        _jcTagNewOrHis=@"getSMGPublishedNewPlanList";
        _methodName=@"getSMGPublishedNewPlanList";
        _jcNewType=@"0";
        
        UIButton * btn = (UIButton *)[_optView viewWithTag:1001];
        btn.selected=NO;
        
        btn = (UIButton *)[_optView viewWithTag:3000];
        btn.selected=YES;
        
        btn = (UIButton *)[_optView viewWithTag:3001];
        btn.selected=NO;
    }else if (sender.tag == 1001) {
        _jcTagNewOrHis=@"getSMGPublishedHisPlanList";
        _methodName=@"getSMGPublishedHisPlanList";
        _jcHisType=@"0";
        
        UIButton * btn = (UIButton *)[self.view viewWithTag:1000];
        btn.selected=NO;
        
        btn = (UIButton *)[self.view viewWithTag:3001];
        btn.selected=YES;
        
        btn = (UIButton *)[self.view viewWithTag:3000];
        btn.selected=NO;
    }else if (sender.tag == 1002) {
        _lcTagNewOrHis=@"getSMGPublishedNewPlanList";
        _methodName=@"getSMGPublishedNewPlanList";
        _lcNewType=@"0";
        
        UIButton * btn = (UIButton *)[self.view viewWithTag:1003];
        btn.selected=NO;
        
        btn = (UIButton *)[self.view viewWithTag:3002];
        btn.selected=YES;
        
        btn = (UIButton *)[self.view viewWithTag:3003];
        btn.selected=NO;
    }else if (sender.tag == 1003) {
        _lcTagNewOrHis=@"getSMGPublishedHisPlanList";
        _methodName=@"getSMGPublishedHisPlanList";
        _lcHisType=@"0";
        
        UIButton * btn = (UIButton *)[self.view viewWithTag:1002];
        btn.selected=NO;
        
        btn = (UIButton *)[self.view viewWithTag:3003];
        btn.selected=YES;
        
        btn = (UIButton *)[self.view viewWithTag:3002];
        btn.selected=NO;
    }else if (sender.tag == 1004) {
        _ypTagNewOrHis=@"getSMGPublishedNewPlanList";
        _methodName=@"getSMGPublishedNewPlanList";
        _ypNewType=@"0";
        
        UIButton * btn = (UIButton *)[self.view viewWithTag:1005];
        btn.selected=NO;
        
        btn = (UIButton *)[self.view viewWithTag:3004];
        btn.selected=YES;
        
        btn = (UIButton *)[self.view viewWithTag:3005];
        btn.selected=NO;
    }else if (sender.tag == 1005) {
        _ypTagNewOrHis=@"getSMGPublishedHisPlanList";
        _methodName=@"getSMGPublishedHisPlanList";
        _ypHisType=@"0";
        
        UIButton * btn = (UIButton *)[self.view viewWithTag:1004];
        btn.selected=NO;
        
        btn = (UIButton *)[self.view viewWithTag:3005];
        btn.selected=YES;
        
        btn = (UIButton *)[self.view viewWithTag:3004];
        btn.selected=NO;
    }
    [self getData:_searchType page:@"1"];
}

#pragma mark --------显示分类弹窗------------

-(void)smBtnAct:(UIButton *)sender
{
    if(sender.tag == 3003){
        return;
    }
    if (_chooseTabelView.hidden == NO&&(([_methodName isEqualToString:@"getSMGPublishedNewPlanList"]&&(sender.tag==3000||sender.tag==3002||sender.tag==3006))||([_methodName isEqualToString:@"getSMGPublishedHisPlanList"]&&(sender.tag==3001||sender.tag==3003||sender.tag==3005)))) {
        sender.selected=YES;
        _chooseTabelView.hidden=YES;
        self.view.backgroundColor = [UIColor whiteColor];//阴影效果取消
        if([_yifaSource isEqualToString:@"-201"]){
            _jcTableView.alpha=1;
            if (_jcBpView) {
                _jcBpView.alpha=1.0;
            }
        }else if([_yifaSource isEqualToString:@"201"]){
            _ypTableView.alpha=1;
            if (_ypBpView) {
                _ypBpView.alpha=1.0;
            }
        }else if([_yifaSource isEqualToString:@"204"]){
            _lcTableView.alpha=1;
            if (_lcBpView) {
                _lcBpView.alpha=1.0;
            }
        }
        _scrollView.scrollEnabled=YES;
        return;
    }
    sender.selected=NO;
    self.view.backgroundColor = [UIColor blackColor];
    if([_yifaSource isEqualToString:@"-201"]){
        _jcTableView.alpha=0.7;
    }else if([_yifaSource isEqualToString:@"201"]){
        _ypTableView.alpha=0.7;
    }else if([_yifaSource isEqualToString:@"204"]){
        _lcTableView.alpha=0.7;
    }
    if ([_yifaSource isEqualToString:@"-201"]) {
        if (_jcBpView) {
            _jcBpView.alpha=0.6;
            [self.view bringSubviewToFront:_chooseTabelView];
        }
    }else if ([_yifaSource isEqualToString:@"201"]) {
        if (_ypBpView) {
            _ypBpView.alpha=0.6;
            [self.view bringSubviewToFront:_chooseTabelView];
        }
    }else if ([_yifaSource isEqualToString:@"204"]) {
        if (_lcBpView) {
            _lcBpView.alpha=0.6;
            [self.view bringSubviewToFront:_chooseTabelView];
        }
    }
    
    if (sender.tag == 3000){
        _methodName=@"getSMGPublishedNewPlanList";
        _jcTagNewOrHis=@"getSMGPublishedNewPlanList";
        _chooseTabelView.frame = CGRectMake(0, HEIGHTBELOESYSSEVER+88, MyWidth, 250);
        
        UIButton * btn = (UIButton *)[self.view viewWithTag:1000];
        btn.selected=YES;
        
        btn = (UIButton *)[self.view viewWithTag:1001];
        btn.selected=NO;
        
        btn = (UIButton *)[self.view viewWithTag:3001];
        btn.selected=NO;
    }else if (sender.tag == 3001) {
        _methodName=@"getSMGPublishedHisPlanList";
        _jcTagNewOrHis=@"getSMGPublishedHisPlanList";
        _chooseTabelView.frame = CGRectMake(0, HEIGHTBELOESYSSEVER+88, MyWidth, 50*[_selHistroy count]);
        
        UIButton * btn= (UIButton *)[self.view viewWithTag:1001];
        btn.selected=YES;
        
        btn = (UIButton *)[self.view viewWithTag:1000];
        btn.selected=NO;
        
        btn = (UIButton *)[self.view viewWithTag:3000];
        btn.selected=NO;
    }else if (sender.tag == 3002){
        _methodName=@"getSMGPublishedNewPlanList";
        _lcTagNewOrHis=@"getSMGPublishedNewPlanList";
        _chooseTabelView.frame = CGRectMake(0, HEIGHTBELOESYSSEVER+88, MyWidth, 250);
        
        UIButton * btn = (UIButton *)[self.view viewWithTag:1002];
        btn.selected=YES;
        
        btn = (UIButton *)[self.view viewWithTag:1003];
        btn.selected=NO;
        
        btn = (UIButton *)[self.view viewWithTag:3003];
        btn.selected=NO;
    }else if (sender.tag == 3003) {
        _methodName=@"getSMGPublishedHisPlanList";
        _lcTagNewOrHis=@"getSMGPublishedHisPlanList";
        _chooseTabelView.frame = CGRectMake(0, HEIGHTBELOESYSSEVER+88, MyWidth, 50*[_selHistroy count]);
        
        UIButton * btn= (UIButton *)[self.view viewWithTag:1003];
        btn.selected=YES;
        
        btn = (UIButton *)[self.view viewWithTag:1002];
        btn.selected=NO;
        
        btn = (UIButton *)[self.view viewWithTag:3002];
        btn.selected=NO;
    }else if (sender.tag == 3004){
        _methodName=@"getSMGPublishedNewPlanList";
        _ypTagNewOrHis=@"getSMGPublishedNewPlanList";
        _chooseTabelView.frame = CGRectMake(0, HEIGHTBELOESYSSEVER+88, MyWidth, 250);
        
        UIButton * btn = (UIButton *)[self.view viewWithTag:1004];
        btn.selected=YES;
        
        btn = (UIButton *)[self.view viewWithTag:1005];
        btn.selected=NO;
        
        btn = (UIButton *)[self.view viewWithTag:3005];
        btn.selected=NO;
    }else if (sender.tag == 3005) {
        _methodName=@"getSMGPublishedHisPlanList";
        _ypTagNewOrHis=@"getSMGPublishedHisPlanList";
        _chooseTabelView.frame = CGRectMake(0, HEIGHTBELOESYSSEVER+88, MyWidth, 50*[_selHistroy count]);
        
        UIButton * btn= (UIButton *)[self.view viewWithTag:1005];
        btn.selected=YES;
        
        btn = (UIButton *)[self.view viewWithTag:1004];
        btn.selected=NO;
        
        btn = (UIButton *)[self.view viewWithTag:3004];
        btn.selected=NO;
    }
    [_chooseTabelView reloadData];
    _chooseTabelView.hidden = NO;
    _scrollView.scrollEnabled=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---------------------UITableViewDelegate--------------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==102){
        return 50;
    }else{
        if(tableView.tag == 201 || tableView.tag==203){
            if(tableView.tag==203){
                return 60;
            }
            return 55;
        }else{
            return 110;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //阴影效果取消
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollView.scrollEnabled=YES;
    if([_yifaSource isEqualToString:@"-201"]){
        _jcTableView.alpha=1;
        if (_jcBpView) {
            _jcBpView.alpha=1.0;
        }
    }else if([_yifaSource isEqualToString:@"201"]){
        _ypTableView.alpha=1;
        if (_ypBpView) {
            _ypBpView.alpha=1.0;
        }
    }else if([_yifaSource isEqualToString:@"204"]){
        _lcTableView.alpha=1;
        if (_lcBpView) {
            _lcBpView.alpha=1.0;
        }
    }
    _chooseTabelView.hidden = YES;

    if (tableView.tag == 102) {
        _firstSing = 2;
        if([_yifaSource isEqualToString:@"-201"]){
            _jcCPage=1;
        }else if([_yifaSource isEqualToString:@"201"]){
            _ypCPage=1;
        }else if([_yifaSource isEqualToString:@"204"]){
            _lcCPage=1;
        }
        if (indexPath.row ==0) {
            _searchType=@"0";
        }
        if (indexPath.row == 1) {
            _searchType=@"1";
        }
        if (indexPath.row == 2) {
            _searchType=@"2";
        }
        if (indexPath.row == 3) {
            _searchType=@"3";
        }
        if (indexPath.row == 4) {
            _searchType=@"4";
        }
        NSInteger btnTag;
        if ([_methodName isEqualToString:@"getSMGPublishedNewPlanList"]) {
            if([_yifaSource isEqualToString:@"-201"]){
                btnTag=3000;
                _jcNewType=_searchType;
            }else if([_yifaSource isEqualToString:@"201"]){
                btnTag=3002;
                _ypNewType=_searchType;
            }else if([_yifaSource isEqualToString:@"204"]){
                btnTag=3004;
                _lcNewType=_searchType;
            }
        }else if ([_methodName isEqualToString:@"getSMGPublishedHisPlanList"]) {
            if([_yifaSource isEqualToString:@"-201"]){
                btnTag=3001;
                _jcHisType=_searchType;
            }else if([_yifaSource isEqualToString:@"201"]){
                btnTag=3003;
                _ypHisType=_searchType;
            }else if([_yifaSource isEqualToString:@"204"]){
                btnTag=3005;
                _lcHisType=_searchType;
            }
        }
        UIButton *btn = (UIButton *)[self.view viewWithTag:btnTag];
        btn.selected=YES;
        [self getData:_searchType page:@"1"];
    }else if (tableView.tag == 201||tableView.tag==202 || tableView.tag == 203) {
        ProjectDetailViewController * vc = [[ProjectDetailViewController alloc]init];
        if ([_methodName isEqualToString:@"getSMGPublishedNewPlanList"]) {
            BeenPlanSMGModel * model;
            if([_yifaSource isEqualToString:@"-201"]){
                model= (BeenPlanSMGModel *)[_jcPlanArr objectAtIndex:indexPath.row];
            }else if([_yifaSource isEqualToString:@"201"]){
                model= (BeenPlanSMGModel *)[_ypPlanArr objectAtIndex:indexPath.row];
            }else if([_yifaSource isEqualToString:@"204"]){
                model= (BeenPlanSMGModel *)[_lcPlanArr objectAtIndex:indexPath.row];
            }
            vc.erAgintOrderId=model.erAgintOrderId;
        }else if ([_methodName isEqualToString:@"getSMGPublishedHisPlanList"]) {
            BeenPlanHisModel *model;
            if([_yifaSource isEqualToString:@"-201"]){
                model=(BeenPlanHisModel *)[_jcPlanArr objectAtIndex:indexPath.row];
            }else if([_yifaSource isEqualToString:@"201"]){
                model=(BeenPlanHisModel *)[_ypPlanArr objectAtIndex:indexPath.row];
            }else if([_yifaSource isEqualToString:@"204"]){
                model=(BeenPlanHisModel *)[_lcPlanArr objectAtIndex:indexPath.row];
            }
            vc.erAgintOrderId = model.erAgintOrderId;
        }
        vc.pdLotryType=_yifaSource;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ---------------------UITableViewDataSource--------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==201) {
        if (_jcPlanArr&&[_jcPlanArr count]!=0) {
            return _jcPlanArr.count;
        }else
            return 0;
    }else if (tableView.tag==202){
        if (_ypPlanArr&&[_ypPlanArr count]!=0) {
            return _ypPlanArr.count;
        }else
            return 0;
    }else if (tableView.tag==203){
        if (_lcPlanArr&&[_lcPlanArr count]!=0) {
            return _lcPlanArr.count;
        }else
            return 0;
    }else if (tableView.tag == 102){
        if ([_methodName isEqualToString:@"getSMGPublishedNewPlanList"]) {
            return [_selNewRecommend count];
        }else{
            return [_selHistroy count];
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag != 102) {
        NSArray *arr;
        BOOL isErchuanyi = NO;
        if(tableView.tag==201){
            arr=[NSArray arrayWithArray:_jcPlanArr];
        }else if(tableView.tag==202){
            isErchuanyi = YES;
            arr=[NSArray arrayWithArray:_ypPlanArr];
        }else if(tableView.tag==203){
            arr=[NSArray arrayWithArray:_lcPlanArr];
        }
        
        static NSString * newCell = @"ExpertPublishedCell";
        ExpertPublishedTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:newCell];
        if (!cell) {
            cell = [[ExpertPublishedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if ([_methodName isEqualToString:@"getSMGPublishedNewPlanList"]) {
            
            if (arr.count != 0) {
                BeenPlanSMGModel * model = (BeenPlanSMGModel *)[arr objectAtIndex:indexPath.row];
                [cell loadAppointInfo:model isErchuanyi:isErchuanyi];
            }
            
        }else if ([_methodName isEqualToString:@"getSMGPublishedHisPlanList"]) {
            
            if (arr.count != 0) {
                BeenPlanHisModel * model=(BeenPlanHisModel *)[arr objectAtIndex:indexPath.row];
                [cell loadAppointHistoryInfo:model isErchuanyi:isErchuanyi];
            }
        }
        
        return cell;
        
//        if ([_methodName isEqualToString:@"getSMGPublishedNewPlanList"]) {
//            if(arr.count != 0){
//                BeenPlanSMGModel * model = (BeenPlanSMGModel *)[arr objectAtIndex:indexPath.row];
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
//                NSDate *date=[dateFormatter dateFromString:model.matchTime];
//                
//                NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
//                [dateFormatter2 setDateFormat:@"MM-dd HH:mm"];
//                
//                NSString *time=[NSString stringWithFormat:@"开赛时间 %@",[dateFormatter2 stringFromDate:date]];
//                if([model.orderStatus intValue]==3){
//                    NSString *identifier = [NSString stringWithFormat:@"%@rejectCell",_methodName];
//                    RejectedCell *cell=(RejectedCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
//                    if (!cell) {
//                        cell=[[RejectedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//                        //黑线
//                        UIView * Line=[[UIView alloc]initWithFrame:CGRectMake(0,99.5, MyWidth+80, 0.5)];
//                        Line.backgroundColor=[UIColor blackColor];
//                        Line.alpha=0.1;
//                        [cell.contentView addSubview:Line];
//                    }
//                    cell.rejectDelegate=self;
//                    cell.deletelab.tag=indexPath.row;
//                    cell.mainView.tag=indexPath.row;
//                    [cell rejectDataWeek:model.matchesId contestType:model.leagueName contestTime:time contestName:model.matchesName contestStatus:[NSString stringWithFormat:@"%@%@",model.orderStatus,model.closeStatus] contestPrice:model.discountPrice];
//                    
//                    cell.backgroundColor=[UIColor whiteColor];
//                    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
//                    cell.selectedBackgroundView.backgroundColor =[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
//                    return cell;
//                }else{
//                    NSString *identifier = [NSString stringWithFormat:@"%@passCell",_methodName];
//                    PlanSMGTableViewCell * cell = (PlanSMGTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
//                    if (!cell) {
//                        cell = [[PlanSMGTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
//                        //黑线
//                        UIView * Line=[[UIView alloc]initWithFrame:CGRectMake(0,99.5, MyWidth, 0.5)];
//                        [cell.contentView addSubview:Line];
//                        Line.backgroundColor=[UIColor blackColor];
//                        Line.alpha=0.1;
//                    }
//                    [cell dataWeek:model.matchesId contestType:model.leagueName contestTime:time contestName:model.matchesName contestStatus:[NSString stringWithFormat:@"%@%@",model.orderStatus,model.closeStatus] contestPrice:model.discountPrice];
//                    
//                    cell.backgroundColor=[UIColor whiteColor];
//                    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
//                    cell.selectedBackgroundView.backgroundColor =[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
//                    return cell;
//                }
//            }
//        }else if ([_methodName isEqualToString:@"getSMGPublishedHisPlanList"]) {
//            NSString * identifier = [NSString stringWithFormat:@"%@historyCell",_methodName];
//            PlanSMGTableViewCell * cell = (PlanSMGTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
//            if (!cell) {
//                cell = [[PlanSMGTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
//                //黑线
//                UIView * Line=[[UIView alloc]initWithFrame:CGRectMake(0,99.5, MyWidth, 0.5)];
//                [cell.contentView addSubview:Line];
//                Line.backgroundColor=[UIColor blackColor];
//                Line.alpha=0.1;
//            }
//            if (arr.count != 0) {
//                BeenPlanHisModel *model=(BeenPlanHisModel *)[arr objectAtIndex:indexPath.row];
//                NSString *hitStr=@"";
//                if (tableView.tag==201) {
//                    hitStr=model.hitStatus;
//                }else if (tableView.tag==202){
//                    hitStr=model.asian_result_status;
//                }
//                [cell dataWeek:model.matchesId contestType:model.leagueName contestTime:model.matchTime contestName:[NSString stringWithFormat:@"%@   %@:%@  %@",model.homeName,model.homeScore,model.awayScore,model.awayName] statusImg:hitStr];
//            }
//            
//            cell.backgroundColor=[UIColor whiteColor];
//            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
//            cell.selectedBackgroundView.backgroundColor =[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] ;
//            return cell;
//        }
    } else if (tableView.tag == 102) {
        static NSString *identifier = @"selectCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            //黑线
            UIView * line=[[UIView alloc]initWithFrame:CGRectMake(0,49.5, MyWidth, 0.5)];
            line.backgroundColor=[UIColor blackColor];
            line.alpha=0.1;
            [cell.contentView addSubview:line];
        }
        
        cell.imageView.image=[UIImage imageNamed:@"排行榜对号"];
        cell.imageView.hidden=YES;
        cell.textLabel.font = FONTTWENTY_EIGHT;
        if ([_methodName isEqualToString:@"getSMGPublishedNewPlanList"]) {
            cell.textLabel.text = [_selNewRecommend objectAtIndex:indexPath.row];
        }else if ([_methodName isEqualToString:@"getSMGPublishedHisPlanList"]) {
            cell.textLabel.text = [_selHistroy objectAtIndex:indexPath.row];
        }
        if (indexPath.row==[_searchType integerValue]) {
            cell.imageView.hidden=NO;
            cell.textLabel.textColor = [UIColor colorWithRed:21.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1.0];
        }else{
            cell.textLabel.textColor = BLACK_EIGHTYSEVER;
        }
        return cell;
    }
    return nil;
}

#pragma mark ------------------添加刷新--------------------

- (void)setupRefresh
{
    _jcTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_jcTableView.header];
    
    _jcTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_jcTableView.footer];
    
    _ypTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_ypTableView.header];
    
    _ypTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_ypTableView.footer];
    
    _lcTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_lcTableView.header];
    
    _lcTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_lcTableView.footer];
}

#pragma mark ---------------下拉刷新-------------------

- (void)NearheaderRereshing
{
    if ([_yifaSource isEqualToString:@"-201"]) {
        _jcCPage=1;
    }else if([_yifaSource isEqualToString:@"201"]){
        _ypCPage=1;
    }else if([_yifaSource isEqualToString:@"204"]){
        _lcCPage=1;
    }
    [self getData:_searchType page:@"1"];
}

#pragma mark ----------------上拉加载-----------------

- (void)NearfooterRereshing
{
    NSInteger cuPage;
    if ([_yifaSource isEqualToString:@"-201"]) {
        cuPage=_jcCPage+1;
    }else if([_yifaSource isEqualToString:@"201"]){
        cuPage=_ypCPage+1;
    }else if([_yifaSource isEqualToString:@"204"]){
        cuPage=_lcCPage+1;
    }
    [self getData:_searchType page:[NSString stringWithFormat:@"%ld",(long)cuPage]];
}

#pragma mark ------------获取数据--------------

-(void)getData:(NSString*)searchType page:(NSString *)page
{
    
    if ([_yifaSource isEqualToString:@"-201"]) {
        if (_jcBpView) {
            [_jcBpView removeFromSuperview];
        }
    }else if ([_yifaSource isEqualToString:@"201"]) {
        if (_ypBpView) {
            [_ypBpView removeFromSuperview];
        }
    }else if ([_yifaSource isEqualToString:@"204"]) {
        if (_lcBpView) {
            [_lcBpView removeFromSuperview];
        }
    }
    NSMutableDictionary * parameters=[NSMutableDictionary dictionaryWithDictionary:@{@"expertsName":[[Info getInstance] userName],@"lotteryClassCode":_yifaSource,@"searchType":searchType,@"currPage":page,@"pageSize":@"20"}];
    NSMutableDictionary * bodDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":_methodName,@"parameters":parameters}];
    
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic success:^(id JSON) {
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        if (JSON!=nil&&JSON[@"result"]!=nil&&![JSON[@"result"] isEqual:[NSNull null]]) {
            NSArray *dataArr=JSON[@"result"][@"data"];
            if (dataArr.count != 0) {
                NSMutableArray *matchDataArr=[NSMutableArray arrayWithCapacity:[dataArr count]];
                for (NSDictionary * datadic in dataArr) {
                    NSArray * matchsList = datadic[@"matchsList"];
                    if (matchsList.count != 0) {
                        NSDictionary * ListDic = [matchsList objectAtIndex:0];
                        if([_methodName isEqualToString:@"getSMGPublishedNewPlanList"]){
                            BeenPlanSMGModel * model = [[BeenPlanSMGModel alloc]init];
                            [model setValuesForKeysWithDictionary:ListDic];
                            model.discountPrice = [datadic objectForKey:@"discountPrice"];
                            model.orderStatus = [datadic objectForKey:@"orderStatus"];
                            model.closeStatus = [datadic objectForKey:@"closeStatus"];
                            model.erAgintOrderId = [datadic objectForKey:@"erAgintOrderId"];
                            
                            model.goldDiscountPrice = [datadic objectForKey:@"goldDiscountPrice"];
                            model.lotteryClassCode = [datadic objectForKey:@"lotteryClassCode"];
//                            model.FREE_STATUS = [datadic objectForKey:@"FREE_STATUS"];
                            [matchDataArr addObject:model];
                        }else if([_methodName isEqualToString:@"getSMGPublishedHisPlanList"]){
                            NSDictionary * ListDic = [matchsList objectAtIndex:0];
                            BeenPlanHisModel * model = [[BeenPlanHisModel alloc]init];
                            [model setValuesForKeysWithDictionary:ListDic];
                            model.hitStatus = [datadic objectForKey:@"hitStatus"];
                            model.erAgintOrderId = [datadic objectForKey:@"erAgintOrderId"];
                            model.asian_result_status=[datadic objectForKey:@"asian_result_status"];
                            
                            model.goldDiscountPrice = [datadic objectForKey:@"goldDiscountPrice"];
                            model.lotteryClassCode = [datadic objectForKey:@"lotteryClassCode"];
//                            model.FREE_STATUS = [datadic objectForKey:@"FREE_STATUS"];
                            [matchDataArr addObject:model];
                        }
                    }
                }
                if ([page isEqualToString:@"1"]) {
                    if ([_yifaSource isEqualToString:@"-201"]) {
                        [_jcPlanArr removeAllObjects];
                        _jcPlanArr=nil;
                        _jcPlanArr=matchDataArr;
                    }else if ([_yifaSource isEqualToString:@"201"]) {
                        [_ypPlanArr removeAllObjects];
                        _ypPlanArr=nil;
                        _ypPlanArr=matchDataArr;
                    }else if ([_yifaSource isEqualToString:@"204"]) {
                        [_lcPlanArr removeAllObjects];
                        _lcPlanArr=nil;
                        _lcPlanArr=matchDataArr;
                    }
                }else{
                    if ([_yifaSource isEqualToString:@"-201"]) {
                        [_jcPlanArr addObjectsFromArray:matchDataArr];
                        _jcCPage++;
                    }else if ([_yifaSource isEqualToString:@"201"]) {
                        [_ypPlanArr addObjectsFromArray:matchDataArr];
                        _ypCPage++;
                    }else if ([_yifaSource isEqualToString:@"204"]) {
                        [_lcPlanArr addObjectsFromArray:matchDataArr];
                        _lcCPage++;
                    }
                }
            }else{
                if ([page intValue]==1) {
                    if ([_yifaSource isEqualToString:@"-201"]) {
                        if (_jcPlanArr) {
                            [_jcPlanArr removeAllObjects];
                            _jcPlanArr=nil;
                        }
                    }else if ([_yifaSource isEqualToString:@"201"]) {
                        if (_ypPlanArr) {
                            [_ypPlanArr removeAllObjects];
                            _ypPlanArr=nil;
                        }
                    }else if ([_yifaSource isEqualToString:@"204"]) {
                        if (_lcPlanArr) {
                            [_lcPlanArr removeAllObjects];
                            _lcPlanArr=nil;
                        }
                    }
                    if (_firstSing==1) {
                        [self createIfNoHave];
                    }
                }else if([page intValue]>1){
                    //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"没有更多啦！" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                    //[alert show];
                    //[self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
                }
            }
        }else{
            if ([_yifaSource isEqualToString:@"-201"]) {
                if (_jcPlanArr) {
                    [_jcPlanArr removeAllObjects];
                    _jcPlanArr=nil;
                }
            }else if ([_yifaSource isEqualToString:@"201"]) {
                if (_ypPlanArr) {
                    [_ypPlanArr removeAllObjects];
                    _ypPlanArr=nil;
                }
            }else if ([_yifaSource isEqualToString:@"204"]) {
                if (_lcPlanArr) {
                    [_lcPlanArr removeAllObjects];
                    _lcPlanArr=nil;
                }
            }
            [self createIfNoHave];
        }
        if ([_yifaSource isEqualToString:@"-201"]) {
            [_jcTableView reloadData];
        }else if ([_yifaSource isEqualToString:@"201"]) {
            [_ypTableView reloadData];
        }else if ([_yifaSource isEqualToString:@"204"]) {
            [_lcTableView reloadData];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_jcTableView.header endRefreshing];
            [_jcTableView.footer endRefreshing];
            [_ypTableView.header endRefreshing];
            [_ypTableView.footer endRefreshing];
            [_lcTableView.header endRefreshing];
            [_lcTableView.footer endRefreshing];
        });
    } failure:^(NSError *error) {
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_jcTableView.header endRefreshing];
            [_jcTableView.footer endRefreshing];
            [_ypTableView.header endRefreshing];
            [_ypTableView.footer endRefreshing];
            [_lcTableView.header endRefreshing];
            [_lcTableView.footer endRefreshing];
        });
    }];
}

#pragma mark ---------删除未通过方案接口-----------

- (void)deleteRejectCell:(UITapGestureRecognizer *)tap{
    UILabel *lab=(UILabel *)tap.view;
    BeenPlanSMGModel * delMdl;
    if ([_yifaSource isEqualToString:@"-201"]) {
        delMdl = (BeenPlanSMGModel *)[_jcPlanArr objectAtIndex:lab.tag];
        [_jcPlanArr removeObject:delMdl];
        [_jcTableView reloadData];
    }else if ([_yifaSource isEqualToString:@"201"]) {
        delMdl = (BeenPlanSMGModel *)[_ypPlanArr objectAtIndex:lab.tag];
        [_ypPlanArr removeObject:delMdl];
        [_ypTableView reloadData];
    }else if ([_yifaSource isEqualToString:@"204"]) {
        delMdl = (BeenPlanSMGModel *)[_lcPlanArr objectAtIndex:lab.tag];
        [_lcPlanArr removeObject:delMdl];
        [_lcTableView reloadData];
    }
    NSDictionary * parameters =@{@"orderId":delMdl.erAgintOrderId};
    NSDictionary * bodDic =@{@"serviceName":@"sMGExpertService",@"methodName":@"deleteOrderByEragintOrderId",@"parameters":parameters};
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic success:^(id JSON) {
        NSString *code=JSON[@"resultCode"];
        if([code isEqualToString:@"0000"]){
            //NSLog(@"delete success!!!");
        }
    } failure:^(NSError *error) {
        //NSLog(@"delete error");
    }];
}

- (void)clickDetailCell:(UITapGestureRecognizer *)tap{
    UIView *mainView=tap.view;
    ProjectDetailViewController *vc=[[ProjectDetailViewController alloc]init];
    if ([_methodName isEqualToString:@"getSMGPublishedNewPlanList"]) {
        BeenPlanSMGModel *model;
        if ([_yifaSource isEqualToString:@"-201"]) {
            model=(BeenPlanSMGModel *)[_jcPlanArr objectAtIndex:mainView.tag];
        }else if ([_yifaSource isEqualToString:@"201"]) {
            model=(BeenPlanSMGModel *)[_ypPlanArr objectAtIndex:mainView.tag];
        }else if ([_yifaSource isEqualToString:@"204"]) {
            model=(BeenPlanSMGModel *)[_lcPlanArr objectAtIndex:mainView.tag];
        }
        vc.erAgintOrderId=model.erAgintOrderId;
    }else if ([_methodName isEqualToString:@"getSMGPublishedHisPlanList"]) {
        BeenPlanHisModel *model;
        if ([_yifaSource isEqualToString:@"-201"]) {
            model=(BeenPlanHisModel *)[_jcPlanArr objectAtIndex:mainView.tag];
        }else if ([_yifaSource isEqualToString:@"201"]) {
            model=(BeenPlanHisModel *)[_ypPlanArr objectAtIndex:mainView.tag];
        }else if ([_yifaSource isEqualToString:@"204"]) {
            model=(BeenPlanHisModel *)[_lcPlanArr objectAtIndex:mainView.tag];
        }
        vc.erAgintOrderId=model.erAgintOrderId;
    }
    vc.pdLotryType=_yifaSource;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ---------提示弹窗自动消失---------

-(void)dimissAlert:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}

#define mark -----------UIScrollViewDelegate------------------
- (void)setScrollContent{
    CGPoint offset=_scrollView.contentOffset;
    if (offset.x<MyWidth/2) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (offset.x>=MyWidth/2&&offset.x<MyWidth*3/2) {
        [_scrollView setContentOffset:CGPointMake(MyWidth, 0) animated:YES];
    }else if (offset.x>=MyWidth*3/2&&offset.x<MyWidth*5/2) {
        [_scrollView setContentOffset:CGPointMake(MyWidth*2, 0) animated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag!=501) {
        return;
    }
    CGPoint offset=_scrollView.contentOffset;
    if (offset.x==0||offset.x==MyWidth || offset.x==MyWidth*2) {
        _jcTableView.userInteractionEnabled=YES;
        _ypTableView.userInteractionEnabled=YES;
        _lcTableView.userInteractionEnabled = YES;
    }else{
        _jcTableView.userInteractionEnabled=NO;
        _ypTableView.userInteractionEnabled=NO;
        _lcTableView.userInteractionEnabled = NO;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView.tag!=501) {
        return;
    }
    _jcTableView.userInteractionEnabled=NO;
    _ypTableView.userInteractionEnabled=NO;
    _lcTableView.userInteractionEnabled = NO;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (scrollView.tag!=501) {
        return;
    }
    [self setScrollContent];
    CGPoint offset=_scrollView.contentOffset;
    _selHistroy = nil;
    float wid;
    if (offset.x<MyWidth/2) {
        _yifaSource=@"-201";
        _jcYiFaBtn.selected=YES;
        _lcYiFaBtn.selected = NO;
        _ypYiFaBtn.selected=NO;
        _selHistroy= [[NSArray alloc]initWithObjects:@"全部",@"荐中",@"未中",nil];
        if (!_jcPlanArr&&[_jcTagNewOrHis isEqualToString:@"getSMGPublishedNewPlanList"]) {
            _jcCPage=1;
            _jcNewType=@"0";
            _methodName=@"getSMGPublishedNewPlanList";
            _firScroll=@"2";
            [self getData:_jcNewType page:@"1"];
        }
        if ([_jcTagNewOrHis isEqualToString:@"getSMGPublishedNewPlanList"]) {
            _searchType=_jcNewType;
        }else if ([_jcTagNewOrHis isEqualToString:@"getSMGPublishedHisPlanList"]){
            _searchType=_jcHisType;
        }
        _methodName=_jcTagNewOrHis;
        wid=0;
    }else if (offset.x>=MyWidth/2&&offset.x<MyWidth*3/2) {
        _yifaSource=@"204";
        _jcYiFaBtn.selected=NO;
        _lcYiFaBtn.selected = YES;
        _ypYiFaBtn.selected=NO;
//        _selHistroy= [[NSArray alloc]initWithObjects:@"全部",@"荐中",@"未中",@"走盘", nil];
        _selHistroy= [[NSArray alloc]initWithObjects:@"全部",@"荐中",@"未中", nil];
        if (!_lcPlanArr&&[_lcTagNewOrHis isEqualToString:@"getSMGPublishedNewPlanList"]) {
            _lcCPage=1;
            _lcNewType=@"0";
            _methodName=@"getSMGPublishedNewPlanList";
            _firScroll=@"2";
            [self getData:_lcNewType page:@"1"];
        }
        if ([_lcTagNewOrHis isEqualToString:@"getSMGPublishedNewPlanList"]) {
            _searchType=_lcNewType;
        }else if ([_lcTagNewOrHis isEqualToString:@"getSMGPublishedHisPlanList"]){
            _searchType=_lcHisType;
        }
        _methodName=_lcTagNewOrHis;
        wid=MyWidth;
    }else if (offset.x>=MyWidth*3/2&&offset.x<MyWidth*5/2) {
        _yifaSource=@"201";
        _jcYiFaBtn.selected=NO;
        _lcYiFaBtn.selected = NO;
        _ypYiFaBtn.selected=YES;
        //        _selHistroy= [[NSArray alloc]initWithObjects:@"全部",@"荐中",@"未中",@"走盘", nil];
        _selHistroy= [[NSArray alloc]initWithObjects:@"全部",@"荐中",@"未中", nil];
        if (!_ypPlanArr&&[_ypTagNewOrHis isEqualToString:@"getSMGPublishedNewPlanList"]) {
            _ypCPage=1;
            _ypNewType=@"0";
            _methodName=@"getSMGPublishedNewPlanList";
            _firScroll=@"2";
            [self getData:_ypNewType page:@"1"];
        }
        if ([_ypTagNewOrHis isEqualToString:@"getSMGPublishedNewPlanList"]) {
            _searchType=_ypNewType;
        }else if ([_ypTagNewOrHis isEqualToString:@"getSMGPublishedHisPlanList"]){
            _searchType=_ypHisType;
        }
        _methodName=_ypTagNewOrHis;
        wid=MyWidth;
    }
    if (offset.x==0||offset.x==MyWidth || offset.x==MyWidth*2) {
        _jcTableView.scrollEnabled=YES;
        _ypTableView.scrollEnabled=YES;
        _lcTableView.scrollEnabled = YES;
    }
    _chooseTabelView.frame = CGRectMake(wid, HEIGHTBELOESYSSEVER+88, MyWidth, 50*[_selHistroy count]);
    [_chooseTabelView reloadData];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.tag!=501) {
        return;
    }
    [self setScrollContent];
    CGPoint offset=_scrollView.contentOffset;
    if (offset.x==0||offset.x==MyWidth || offset.x==MyWidth*2) {
        _jcTableView.userInteractionEnabled=YES;
        _ypTableView.userInteractionEnabled=YES;
        _lcTableView.userInteractionEnabled=YES;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag!=501) {
        return;
    }
    [self setScrollContent];
    CGPoint offset=_scrollView.contentOffset;
    if (offset.x==0||offset.x==MyWidth || offset.x==MyWidth*2) {
        _jcTableView.userInteractionEnabled=YES;
        _ypTableView.userInteractionEnabled=YES;
        _lcTableView.userInteractionEnabled=YES;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag!=501) {
        return;
    }
    [self setScrollContent];
    CGPoint offset=_scrollView.contentOffset;
    if (offset.x==0||offset.x==MyWidth || offset.x==MyWidth*2) {
        _jcTableView.userInteractionEnabled=YES;
        _ypTableView.userInteractionEnabled=YES;
        _lcTableView.userInteractionEnabled=YES;
    }
}

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    