//
//  BuyPlanViewController.m
//  Experts
//
//  Created by V1pin on 15/10/28.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "BuyPlanViewController.h"
#import "ExpertSuperiorBaseCell.h"
#import "BuyPlanModel.h"
#import "BallDetailViewController.h"
#import "ProjectDetailViewController.h"
#import "ExpertViewController.h"
#import "ExpertHomeViewController.h"
#import "SharedMethod.h"

#import "caiboAppDelegate.h"
#import "UpLoadView.h"
#import "ExpertPublishedTableViewCell.h"
#import "ExpertMainViewController.h"

@interface BuyPlanViewController ()<UIScrollViewDelegate>{
    UpLoadView *loadview;
    
    UIImageView *segmentIma;
}

@property(nonatomic,strong)UIView *noYgSignView;

@property(nonatomic,strong)UIButton *jcNavBtn;
@property(nonatomic,strong)UIButton *ypNavBtn;
@property(nonatomic,strong)UIButton *szcNavBtn;
@property(nonatomic,strong)UIButton *lcNavBtn;

@property(nonatomic,strong)UIScrollView *ygScroll;
@property(nonatomic,strong)UIView *topBgView;

@property(nonatomic,strong)UITableView * jcTableView;
@property(nonatomic,strong)UITableView * ypTableView;
@property(nonatomic,strong)UITableView * szcTableView;
@property(nonatomic,strong)UITableView * lcTableView;

@property(nonatomic,strong)NSString *selementType;
@property(nonatomic,strong)NSString *ygLotryType;

@property(nonatomic,assign)NSInteger jcCurPage;
@property(nonatomic,assign)NSInteger ypCurPage;
@property(nonatomic,assign)NSInteger szcCurPage;
@property(nonatomic,assign)NSInteger lcCurPage;

@property(nonatomic,strong)NSMutableArray * jcYgArr;
@property(nonatomic,strong)NSMutableArray * ypYgArr;
@property(nonatomic,strong)NSMutableArray * szcYgArr;
@property(nonatomic,strong)NSMutableArray * lcYgArr;

@property(nonatomic,strong)NSString *statePlan;//0:查全部,1:未开将,2:荐中,3:未中,4:走盘
@property(nonatomic,strong)NSString *jcStatePlan;
@property(nonatomic,strong)NSString *ypStatePlan;
@property(nonatomic,strong)NSString *szcStatePlan;
@property(nonatomic,strong)NSString *lcStatePlan;

@property(nonatomic,strong)NSString *jcFirst;
@property(nonatomic,strong)NSString *ypFirst;
@property(nonatomic,strong)NSString *szcFirst;
@property(nonatomic,strong)NSString *lcFirst;

@end

@implementation BuyPlanViewController

-(instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
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
    
    [self creatNavView];
    //self.title_nav = @"已购方案";
    if(self.isSdOrNo){
        [self creatNavBV];
    }else{
//#if defined CRAZYSPORTS
//        [self loadSegmentView];
//#else
//        [self creatNavBV];
//#endif
        [self creatNavBV];
    }
    
    _ygScroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, MyHight-HEIGHTBELOESYSSEVER-44)];
    _ygScroll.backgroundColor=[UIColor clearColor];
    _ygScroll.showsHorizontalScrollIndicator=NO;
    _ygScroll.showsVerticalScrollIndicator=NO;
//    float weight=3*MyWidth;
    float weight=4*MyWidth;
//    float weight=2*MyWidth;
#if defined CRAZYSPORTS
//    weight=2*MyWidth;
    weight=3*MyWidth;
#endif
    if(self.isSdOrNo==YES){
        weight=2*MyWidth;
    }
    _ygScroll.contentSize=CGSizeMake(weight, MyHight-HEIGHTBELOESYSSEVER-44);
    _ygScroll.delegate=self;
    _ygScroll.bounces=NO;
    [self.view addSubview:_ygScroll];
    
    _topBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,weight, 35)];
    //_topBgView.layer.masksToBounds=YES;
    //_topBgView.layer.borderWidth=1;
    //_topBgView.layer.borderColor=SEPARATORCOLOR.CGColor;
    _topBgView.userInteractionEnabled=YES;
    [_ygScroll addSubview:_topBgView];
    
    _topBgView.backgroundColor = [UIColor colorWithRed:0/255.0 green:118/255.0 blue:188/255.0 alpha:1];
#if defined CRAZYSPORTS
    _topBgView.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
#endif
    
    UIView *sepLine=[[UIView alloc] initWithFrame:CGRectMake(0, _topBgView.frame.size.height-1, _topBgView.frame.size.width, 1)];
    [sepLine setBackgroundColor:SEPARATORCOLOR];
    [_topBgView addSubview:sepLine];
    
//    [self creatStateBgView:13];
//    [self creatStateBgView:12];
    [self creatNewStateBgView:14];
    [self creaTabView];
    
    _jcCurPage=1;
    _ypCurPage=1;
    _szcCurPage=1;
    _lcCurPage=1;
    
    _jcFirst=@"0";
    _ypFirst=@"0";
    _szcFirst=@"0";
    _lcFirst=@"0";
    
    _statePlan = @"0";
    _jcStatePlan = @"0";
    _ypStatePlan = @"0";
    _szcStatePlan = @"0";
    _lcStatePlan = @"0";
    
    _selementType=@"001";
    _ygLotryType=@"-201";
    
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    
    [self getDataPage:1];
    
    [self setupRefresh];
}

-(void)creatNavBV
{
    NSString *btnText=@"";
    UIButton *btn;
//    int count=2;
//    float weight=(MyWidth-62)/3;
    int count=3;
    float weight=(MyWidth-62)/4;
#if defined CRAZYSPORTS
    count=2;
    weight=(MyWidth-62)/3;
#endif
    if(self.isSdOrNo==YES){
        count=1;
        weight=(MyWidth-62)/2;
    }
    for (int i=0; i<=count; i++) {
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(27+weight*i, HEIGHTBELOESYSSEVER, weight, 44)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithRed:170.0/255.0 green:218.0/255.0 blue:252.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        if (i==0) {
            btn.selected=YES;
            btnText=@"竞足";
        }else if(i==1){
            btnText=@"篮彩";
        }else if(i==2){
//            btnText=@"亚盘";
            btnText=@"2串1";
        }else if(i==3){
            btnText=@"数字彩";
        }
        [btn setTitle:btnText forState:UIControlStateNormal];
        [btn setTitle:btnText forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnYgClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=FONTTHIRTY;
        [self.navView addSubview:btn];
        if (i==0) {
            _jcNavBtn=btn;
        }else if(i==1){
            _lcNavBtn=btn;
        }else if(i==2){
            _ypNavBtn=btn;
        }else if(i==3){
            _szcNavBtn=btn;
        }
    }
}
-(void)loadSegmentView{
    
    segmentIma = [[UIImageView alloc]init];
    segmentIma.frame = CGRectMake((self.view.frame.size.width - 225)/2.0, 10+HEIGHTBELOESYSSEVER, 225, 23);
    segmentIma.backgroundColor = [UIColor clearColor];
    segmentIma.image = [UIImage imageNamed:@"expert_white_segment_bg.png"];
    segmentIma.userInteractionEnabled = YES;
    [self.navView addSubview:segmentIma];
    
    NSArray *ary = [NSArray arrayWithObjects:@"竞足",@"二串一", nil];
    for(NSInteger i=0;i<2;i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(112.5*i, 0, 112.5, 23);
        btn.backgroundColor = [UIColor clearColor];
        if (i==0) {
            btn.selected = YES;
            _jcNavBtn=btn;
        }else if(i==1){
            _ypNavBtn=btn;
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:[ary objectAtIndex:i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"expert_white_segment_selected.png"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [segmentIma addSubview:btn];
        [btn addTarget:self action:@selector(btnYgClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:118/255.0 blue:188/255.0 alpha:1.0] forState:UIControlStateSelected];
#if defined CRAZYSPORTS
        [btn setTitleColor:[SharedMethod getColorByHexString:@"6e29bd"] forState:UIControlStateSelected];
#endif
    }
    
}
-(void)creatNewStateBgView:(NSInteger)num{
    NSString *btnText=@"";
    for (int i=0; i<num; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (i==0||i==4||i==6||i==10) {
            btn.selected=YES;
            btnText=@"全部";
        }else if(i==1||i==5||i==7||i==11){
            btnText=@"未开";
        }else if(i==2||i==8||i==12){
            btnText=@"荐中";
        }else if(i==3||i==9||i==13){
            btnText=@"未中";
        }
        float loc;
        float wid;
        if ((i>=0&&i<4)) {
            loc=MyWidth/4*i;
            wid=MyWidth/4;
        }else if (i>=4&&i<6){
            loc=MyWidth/2*(i-4)+MyWidth;
            wid=MyWidth/2;
        }else if (i>=6&&i<10){
            loc=MyWidth/4*(i-6)+MyWidth*2;
            wid=MyWidth/4;
        }else if ((i>=10&&i<14)){
            loc=MyWidth/4*(i-10)+MyWidth*3;
            wid=MyWidth/4;
        }
        [btn setFrame:CGRectMake(loc, 0,wid, 35)];
        [btn setTitle:btnText forState:UIControlStateNormal];
        [btn setTitle:btnText forState:UIControlStateHighlighted];
        btn.titleLabel.font=FONTTHIRTY;
        btn.tag=100+i;
        
        [btn addTarget:self action:@selector(newSelType:) forControlEvents:UIControlEventTouchUpInside];
        [_topBgView addSubview:btn];
        if (i!=3||i!=5||i!=9||i!=13) {
            UIImageView *intervalView=[[UIImageView alloc] initWithFrame:CGRectMake(btn.frame.size.width-0.5, 6.5, 0.5, 22)];
            intervalView.image=[UIImage imageNamed:@"intervalLine"];
            intervalView.hidden = YES;
            [btn addSubview:intervalView];
        }
    }
}
//-(void)creatStateBgView:(NSInteger)num
//{
//    NSString *btnText=@"";
//    for (int i=0; i<num; i++) {
//        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
////        if (i==0||i==4||i==9) {
////            btn.selected=YES;
////            btnText=@"全部";
////        }else if(i==1||i==5||i==10){
////            btnText=@"未开";
////        }else if(i==2||i==6||i==11){
////            btnText=@"荐中";
////        }else if(i==3||i==7||i==12){
////            btnText=@"未中";
////        }else if(i==8){
////            btnText=@"走盘";
////        }
////        float loc;
////        float wid;
////        if ((i>=0&&i<4)) {
////            loc=MyWidth/4*i;
////            wid=MyWidth/4;
////        }else if (i>=4&&i<9){
////            loc=MyWidth/5*(i-4)+MyWidth;
////            wid=MyWidth/5;
////        }else if ((i>=9&&i<13)){
////            loc=MyWidth/4*(i-9)+MyWidth*2;
////            wid=MyWidth/4;
////        }
//        if (i==0||i==4||i==8) {
//            btn.selected=YES;
//            btnText=@"全部";
//        }else if(i==1||i==5||i==9){
//            btnText=@"未开";
//        }else if(i==2||i==6||i==10){
//            btnText=@"荐中";
//        }else if(i==3||i==7||i==11){
//            btnText=@"未中";
//        }
//        float loc;
//        float wid;
//        if ((i>=0&&i<4)) {
//            loc=MyWidth/4*i;
//            wid=MyWidth/4;
//        }else if (i>=4&&i<8){
//            loc=MyWidth/4*(i-4)+MyWidth;
//            wid=MyWidth/4;
//        }else if ((i>=8&&i<12)){
//            loc=MyWidth/4*(i-8)+MyWidth*2;
//            wid=MyWidth/4;
//        }
//        [btn setFrame:CGRectMake(loc, 0,wid, 35)];
//        [btn setTitle:btnText forState:UIControlStateNormal];
//        [btn setTitle:btnText forState:UIControlStateHighlighted];
//        btn.titleLabel.font=FONTTHIRTY;
//        btn.tag=100+i;
//
//        [btn addTarget:self action:@selector(selType:) forControlEvents:UIControlEventTouchUpInside];
//        [_topBgView addSubview:btn];
//        if (i!=3||i!=7||i!=11) {
//            UIImageView *intervalView=[[UIImageView alloc] initWithFrame:CGRectMake(btn.frame.size.width-0.5, 6.5, 0.5, 22)];
//            intervalView.image=[UIImage imageNamed:@"intervalLine"];
//            intervalView.hidden = YES;
//            [btn addSubview:intervalView];
//        }
//    }
//}

-(void)creaTabView
{
    _jcTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,35,MyWidth,_ygScroll.frame.size.height-35) style:UITableViewStylePlain];
    _jcTableView.delegate = self;
    _jcTableView.dataSource = self;
    _jcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _jcTableView.showsHorizontalScrollIndicator=NO;
    _jcTableView.showsVerticalScrollIndicator=NO;
    _jcTableView.tag = 101;
    [_ygScroll addSubview:_jcTableView];
    
    _lcTableView = [[UITableView alloc]initWithFrame:CGRectMake(MyWidth,35,MyWidth,_ygScroll.frame.size.height-35) style:UITableViewStylePlain];
    _lcTableView.delegate = self;
    _lcTableView.dataSource = self;
    _lcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _lcTableView.showsHorizontalScrollIndicator=NO;
    _lcTableView.showsVerticalScrollIndicator=NO;
    _lcTableView.tag = 401;
    [_ygScroll addSubview:_lcTableView];
    
    _ypTableView = [[UITableView alloc]initWithFrame:CGRectMake(MyWidth*2,35,MyWidth,_ygScroll.frame.size.height-35) style:UITableViewStylePlain];
    _ypTableView.delegate = self;
    _ypTableView.dataSource = self;
    _ypTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _ypTableView.showsHorizontalScrollIndicator=NO;
    _ypTableView.showsVerticalScrollIndicator=NO;
    _ypTableView.tag = 201;
    [_ygScroll addSubview:_ypTableView];
    
    _szcTableView = [[UITableView alloc]initWithFrame:CGRectMake(MyWidth*3,35,MyWidth,_ygScroll.frame.size.height-35) style:UITableViewStylePlain];
    _szcTableView.delegate = self;
    _szcTableView.dataSource = self;
    _szcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _szcTableView.showsHorizontalScrollIndicator=NO;
    _szcTableView.showsVerticalScrollIndicator=NO;
    _szcTableView.tag = 301;
    [_ygScroll addSubview:_szcTableView];
}

- (void)btnYgClick:(UIButton *)btn{
    btn.selected=YES;
    if (btn==_jcNavBtn) {
        _szcNavBtn.selected=NO;
        _ypNavBtn.selected=NO;
        _lcNavBtn.selected = NO;
        _selementType=@"001";
        _ygLotryType=@"-201";
        [_ygScroll setContentOffset:CGPointMake(0, 0) animated:YES];
        _statePlan=_jcStatePlan;
        if (!_jcYgArr) {
            _jcFirst=@"1";
            _jcCurPage=1;
            [self getDataPage:1];
        }
    }else if (btn==_ypNavBtn) {
        _jcNavBtn.selected=NO;
        _szcNavBtn.selected=NO;
        _lcNavBtn.selected = NO;
        _selementType=@"001";
        _ygLotryType=@"201";
        [_ygScroll setContentOffset:CGPointMake(MyWidth*2, 0) animated:YES];
        _statePlan=_ypStatePlan;
        if (!_ypYgArr) {
            _ypFirst=@"1";
            _ypCurPage=1;
            [self getDataPage:1];
        }
    }else if (btn==_szcNavBtn) {
        _jcNavBtn.selected=NO;
        _ypNavBtn.selected=NO;
        _lcNavBtn.selected = NO;
        _selementType=@"002";
        _ygLotryType=@"";
        [_ygScroll setContentOffset:CGPointMake(MyWidth*3, 0) animated:YES];
        _statePlan=_szcStatePlan;
        if (!_szcYgArr) {
            _szcFirst=@"1";
            _szcCurPage=1;
            [self getDataPage:1];
        }
    }else if (btn==_lcNavBtn) {
        _jcNavBtn.selected=NO;
        _ypNavBtn.selected=NO;
        _szcNavBtn.selected = NO;
        _selementType=@"001";
        _ygLotryType=@"204";
        [_ygScroll setContentOffset:CGPointMake(MyWidth, 0) animated:YES];
        _statePlan=_lcStatePlan;
        if (!_lcYgArr) {
            _lcFirst=@"1";
            _lcCurPage=1;
            [self getDataPage:1];
        }
    }
}
- (void)newSelType:(UIButton *)btn{
    btn.selected=YES;
    for (UIView *view in [_topBgView subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *sortBtn=(UIButton *)view;
            if (btn.tag<104) {
                if (sortBtn!=btn&&sortBtn.tag<104) {
                    sortBtn.selected=NO;
                }
            }else if (btn.tag>=104&&btn.tag<106) {
                if (sortBtn!=btn&&sortBtn.tag>=104&&sortBtn.tag<106) {
                    sortBtn.selected=NO;
                }
            }else if (btn.tag>=106&&btn.tag<110) {
                if (sortBtn!=btn&&sortBtn.tag>=106&&sortBtn.tag<110) {
                    sortBtn.selected=NO;
                }
            }else if (btn.tag>=110) {
                if (sortBtn!=btn&&sortBtn.tag>=110) {
                    sortBtn.selected=NO;
                }
            }
        }
    }

    if (btn.tag==100) {
        _jcStatePlan=@"0";
    }else if (btn.tag==101) {
        _jcStatePlan=@"1";
    }else if (btn.tag==102) {
        _jcStatePlan=@"2";
    }else if (btn.tag==103) {
        _jcStatePlan=@"3";
    }else if (btn.tag==104) {
        _lcStatePlan=@"0";
    }else if (btn.tag==105) {
        _lcStatePlan=@"1";
    }else if (btn.tag==106) {
        _ypStatePlan=@"0";
    }else if (btn.tag==107) {
        _ypStatePlan=@"1";
    }else if (btn.tag==108) {
        _ypStatePlan=@"2";
    }else if (btn.tag==109) {
        _ypStatePlan=@"3";
    }else if (btn.tag==110) {
        _szcStatePlan=@"0";
    }else if(btn.tag==111){
        _szcStatePlan=@"1";
    }else if(btn.tag==112){
        _szcStatePlan=@"2";
    }else if(btn.tag==113){
        _szcStatePlan=@"3";
    }
    
    if (btn.tag<=103) {
        _statePlan=_jcStatePlan;
    }else if (btn.tag<=105) {
        _statePlan=_lcStatePlan;
    }else if (btn.tag<=109) {
        _statePlan=_ypStatePlan;
    }else if (btn.tag<=113) {
        _statePlan=_szcStatePlan;
    }
    [self getDataPage:1];
}
//- (void)selType:(UIButton *)btn{
//    btn.selected=YES;
////    for (UIView *view in [_topBgView subviews]) {
////        if ([view isKindOfClass:[UIButton class]]) {
////            UIButton *sortBtn=(UIButton *)view;
////            if (btn.tag<104) {
////                if (sortBtn!=btn&&sortBtn.tag<104) {
////                    sortBtn.selected=NO;
////                }
////            }else if (btn.tag>=104&&btn.tag<109) {
////                if (sortBtn!=btn&&sortBtn.tag>=104&&sortBtn.tag<109) {
////                    sortBtn.selected=NO;
////                }
////            }else if (btn.tag>=109) {
////                if (sortBtn!=btn&&sortBtn.tag>=109) {
////                    sortBtn.selected=NO;
////                }
////            }
////        }
////    }
////    if (btn.tag==100) {
////        _jcStatePlan=@"0";
////    }else if (btn.tag==101) {
////        _jcStatePlan=@"1";
////    }else if (btn.tag==102) {
////        _jcStatePlan=@"2";
////    }else if (btn.tag==103) {
////        _jcStatePlan=@"3";
////    }else if (btn.tag==104) {
////        _ypStatePlan=@"0";
////    }else if (btn.tag==105) {
////        _ypStatePlan=@"1";
////    }else if (btn.tag==106) {
////        _ypStatePlan=@"2";
////    }else if (btn.tag==107) {
////        _ypStatePlan=@"3";
////    }else if (btn.tag==108) {
////        _ypStatePlan=@"4";
////    }else if(btn.tag==109){
////        _szcStatePlan=@"0";
////    }else if(btn.tag==110){
////        _szcStatePlan=@"1";
////    }else if(btn.tag==111){
////        _szcStatePlan=@"2";
////    }else if(btn.tag==112){
////        _szcStatePlan=@"3";
////    }
////    if (btn.tag<=103) {
////        _statePlan=_jcStatePlan;
////    }else if (btn.tag<=108) {
////        _statePlan=_ypStatePlan;
////    }else if (btn.tag<=112) {
////        _statePlan=_szcStatePlan;
////    }
//    for (UIView *view in [_topBgView subviews]) {
//        if ([view isKindOfClass:[UIButton class]]) {
//            UIButton *sortBtn=(UIButton *)view;
//            if (btn.tag<104) {
//                if (sortBtn!=btn&&sortBtn.tag<104) {
//                    sortBtn.selected=NO;
//                }
//            }else if (btn.tag>=104&&btn.tag<108) {
//                if (sortBtn!=btn&&sortBtn.tag>=104&&sortBtn.tag<108) {
//                    sortBtn.selected=NO;
//                }
//            }else if (btn.tag>=108) {
//                if (sortBtn!=btn&&sortBtn.tag>=108) {
//                    sortBtn.selected=NO;
//                }
//            }
//        }
//    }
//    if (btn.tag==100) {
//        _jcStatePlan=@"0";
//    }else if (btn.tag==101) {
//        _jcStatePlan=@"1";
//    }else if (btn.tag==102) {
//        _jcStatePlan=@"2";
//    }else if (btn.tag==103) {
//        _jcStatePlan=@"3";
//    }else if (btn.tag==104) {
//        _ypStatePlan=@"0";
//    }else if (btn.tag==105) {
//        _ypStatePlan=@"1";
//    }else if (btn.tag==106) {
//        _ypStatePlan=@"2";
//    }else if (btn.tag==107) {
//        _ypStatePlan=@"3";
//    }else if (btn.tag==108) {
//        _szcStatePlan=@"0";
//    }else if(btn.tag==109){
//        _szcStatePlan=@"1";
//    }else if(btn.tag==110){
//        _szcStatePlan=@"2";
//    }else if(btn.tag==111){
//        _szcStatePlan=@"3";
//    }
//    
//    if (btn.tag<=103) {
//        _statePlan=_jcStatePlan;
//    }else if (btn.tag<=107) {
//        _statePlan=_ypStatePlan;
//    }else if (btn.tag<=111) {
//        _statePlan=_szcStatePlan;
//    }
//    [self getDataPage:1];
//}
#pragma mark ----------UITableViewDataSource-----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView.tag==101){
        return [_jcYgArr count];
    }else if(tableView.tag==201){
        return [_ypYgArr count];
    }else if(tableView.tag==301){
        return [_szcYgArr count];
    }else if(tableView.tag==401){
        return [_lcYgArr count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_selementType isEqualToString:@"001"]) {//竞足的数据
        
        static NSString * newCell = @"ExpertPublishedCell";
        ExpertPublishedTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:newCell];
        if (!cell) {
            cell = [[ExpertPublishedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        BuyPlanModel *jgMdl;
        if (tableView.tag==101) {
            jgMdl= (BuyPlanModel *)[_jcYgArr objectAtIndex:indexPath.row];
        }else if (tableView.tag==201) {
            jgMdl= (BuyPlanModel *)[_ypYgArr objectAtIndex:indexPath.row];
        }else if (tableView.tag==301) {
            jgMdl= (BuyPlanModel *)[_szcYgArr objectAtIndex:indexPath.row];
        }else if (tableView.tag==401) {
            jgMdl= (BuyPlanModel *)[_lcYgArr objectAtIndex:indexPath.row];
        }
        
        BOOL isErchuanyi = NO;
        if(tableView.tag == 201){//二串一
            isErchuanyi = YES;
        }
        [cell loadBuyAppointInfo:jgMdl isErchuanyi:isErchuanyi];
        return cell;
    }else if ([_selementType isEqualToString:@"002"]) {//数字彩的数据
        
        ExpertSuperiorBaseCell * cell = [ExpertSuperiorBaseCell ExpertSuperiorBaseCellWithTableView:tableView cellForRowAtIndexPath:indexPath];
        BuyPlanModel *jgMdl;
        if (tableView.tag==101) {
            jgMdl= (BuyPlanModel *)[_jcYgArr objectAtIndex:indexPath.row];
        }else if (tableView.tag==201) {
            jgMdl= (BuyPlanModel *)[_ypYgArr objectAtIndex:indexPath.row];
        }else if (tableView.tag==301) {
            jgMdl= (BuyPlanModel *)[_szcYgArr objectAtIndex:indexPath.row];
        }
        NSString *amount=[NSString stringWithFormat:@"%@元",jgMdl.AMOUNT];
        if ([jgMdl.AMOUNT floatValue]==0.00) {
            amount=@"免费";
        }
        
        [cell HeadImageView:[NSString stringWithFormat:@"%@",jgMdl.HEAD_PORTRAIT] vImageView:[NSString stringWithFormat:@"%@",jgMdl.SOURCE] nickName:[NSString stringWithFormat:@"%@",jgMdl.EXPERTS_NICK_NAME] levels:[NSString stringWithFormat:@"%@",jgMdl.STAR] statics:[NSString stringWithFormat:@"%@%@",jgMdl.CLOSE_STATUS,jgMdl.HIT_STATUS] dueOfTwoSides:[NSString stringWithFormat:@"%@ %@期",jgMdl.LOTTEY_CLASS_CODE,jgMdl.ER_ISSUE] time:[NSString stringWithFormat:@"购买时间 %@",jgMdl.CREATE_TIME] price:amount flag:_selementType refundOrNo:jgMdl.FREE_STATUS lotryTp:_ygLotryType];
        
        return cell;
    }
    return nil;
}

#pragma mark --------UITableViewDelegate-----------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 101 || tableView.tag == 401){
        return 55;
    }else if(tableView.tag == 201){
        return 110;
    }
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BuyPlanModel * model;
    if (tableView.tag==101) {
        model = (BuyPlanModel *)[_jcYgArr objectAtIndex:indexPath.row];
        ProjectDetailViewController * vc = [[ProjectDetailViewController alloc]init];
        vc.erAgintOrderId = model.ER_AGINT_ORDER_ID;
        vc.pdLotryType=_ygLotryType;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (tableView.tag==201) {
        model = (BuyPlanModel *)[_ypYgArr objectAtIndex:indexPath.row];
        ProjectDetailViewController * vc = [[ProjectDetailViewController alloc]init];
        vc.erAgintOrderId = model.ER_AGINT_ORDER_ID;
        vc.pdLotryType=_ygLotryType;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (tableView.tag==301) {
        model = (BuyPlanModel *)[_szcYgArr objectAtIndex:indexPath.row];
        BallDetailViewController * vc = [[BallDetailViewController alloc]init];
        vc.planId = model.ER_AGINT_ORDER_ID;
        vc.caiZhongType=model.LOTTEY_CLASS_CODE;
        vc.qiHao = model.ER_ISSUE;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (tableView.tag==401) {
        model = (BuyPlanModel *)[_lcYgArr objectAtIndex:indexPath.row];
        ProjectDetailViewController * vc = [[ProjectDetailViewController alloc]init];
        vc.erAgintOrderId = model.ER_AGINT_ORDER_ID;
        vc.pdLotryType=_ygLotryType;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -----刷新-----
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
    
    _szcTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_szcTableView.header];
    
    
    _szcTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_szcTableView.footer];
    
    _lcTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_lcTableView.header];
    
    
    _lcTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_lcTableView.footer];
}

#pragma mark ------刷新-----
- (void)NearheaderRereshing
{
    if ([_selementType isEqualToString:@"001"]) {
        if ([_ygLotryType isEqualToString:@"-201"]) {
            _jcCurPage=1;
        }else if([_ygLotryType isEqualToString:@"201"]){
            _ypCurPage=1;
        }else if([_ygLotryType isEqualToString:@"204"]){
            _lcCurPage=1;
        }
    }else if([_selementType isEqualToString:@"002"]){
        _szcCurPage =1;
    }
    [self getDataPage:1];
}

#pragma mark -----加载------
- (void)NearfooterRereshing
{
    NSInteger curPage;
    if ([_selementType isEqualToString:@"001"]) {
        if ([_ygLotryType isEqualToString:@"-201"]) {
            curPage=_jcCurPage+1;
        }else if([_ygLotryType isEqualToString:@"201"]){
            curPage=_ypCurPage+1;
        }else if([_ygLotryType isEqualToString:@"204"]){
            curPage=_lcCurPage+1;
        }
    }else if([_selementType isEqualToString:@"002"]){
        curPage=_szcCurPage+1;
    }
    [self getDataPage:curPage];
}

-(void)getDataPage:(NSInteger)page
{
//    if(_noYgSignView){
//        [_noYgSignView removeFromSuperview];
//    }
    if(page == 1){
        [self createIfNoHave];
    }
    NSString *sdFlag=[NSString stringWithFormat:@"%i",self.isSdOrNo];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"expertClassCode":_selementType,@"lotteryClassCode":_ygLotryType,@"userName":[[Info getInstance] userName],@"condition":_statePlan,@"curPage":[NSString stringWithFormat:@"%ld",(long)page],@"pageSize":@"20",@"levelType":@"1",@"sdFlag":sdFlag}];
    
    NSMutableDictionary * bodyDic = [NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getMyBuyPlanList",@"parameters":parameters}];
    
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id JSON) {
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        NSArray * dataArr=JSON[@"result"][@"data"];
        if (dataArr.count != 0) {
//            _noYgSignView.hidden = YES;
//            _jcTableView.hidden = NO;
//            _ypTableView.hidden = NO;
//            _szcTableView.hidden = NO;
//            _lcTableView.hidden = NO;
            if(_noYgSignView){
                [_noYgSignView removeFromSuperview];
            }
            NSMutableArray *mutArr=[NSMutableArray arrayWithCapacity:[dataArr count]];
            for (NSDictionary * dataDic in dataArr) {
                BuyPlanModel * model = [[BuyPlanModel alloc]init];
                [model setValuesForKeysWithDictionary:dataDic];
                [mutArr addObject:model];
            }
            if (page==1) {
                if([_selementType isEqualToString:@"001"]){
                    if ([_ygLotryType isEqualToString:@"-201"]) {
                        [_jcYgArr removeAllObjects];
                        _jcYgArr=nil;
                        _jcYgArr=mutArr;
                    }else if ([_ygLotryType isEqualToString:@"201"]) {
                        [_ypYgArr removeAllObjects];
                        _ypYgArr=nil;
                        _ypYgArr=mutArr;
                    }else if ([_ygLotryType isEqualToString:@"204"]) {
                        [_lcYgArr removeAllObjects];
                        _lcYgArr=nil;
                        _lcYgArr=mutArr;
                    }
                }else if([_selementType isEqualToString:@"002"]){
                    [_szcYgArr removeAllObjects];
                    _szcYgArr=nil;
                    _szcYgArr=mutArr;
                }
            }else{
                if ([_selementType isEqualToString:@"001"]) {
                    if ([_ygLotryType isEqualToString:@"-201"]) {
                        _jcCurPage++;
                        [_jcYgArr addObjectsFromArray:mutArr];
                    }else if ([_ygLotryType isEqualToString:@"201"]) {
                        _ypCurPage++;
                        [_ypYgArr addObjectsFromArray:mutArr];
                    }else if ([_ygLotryType isEqualToString:@"204"]) {
                        _lcCurPage++;
                        [_lcYgArr addObjectsFromArray:mutArr];
                    }
                }else if([_selementType isEqualToString:@"002"]){
                    _szcCurPage++;
                    [_szcYgArr addObjectsFromArray:mutArr];
                }
            }
            if ([_selementType isEqualToString:@"001"]) {
                if ([_ygLotryType isEqualToString:@"-201"]) {
                    [_jcTableView reloadData];
                }else if ([_ygLotryType isEqualToString:@"201"]) {
                    [_ypTableView reloadData];
                }else if ([_ygLotryType isEqualToString:@"204"]) {
                    [_lcTableView reloadData];
                }
            }else if([_selementType isEqualToString:@"002"]){
                [_szcTableView reloadData];
            }
        }else{
//            if (page ==1) {
//                [self createIfNoHave];
//            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_jcTableView.header endRefreshing];
            [_jcTableView.footer endRefreshing];
            [_ypTableView.header endRefreshing];
            [_ypTableView.footer endRefreshing];
            [_szcTableView.header endRefreshing];
            [_szcTableView.footer endRefreshing];
            [_lcTableView.header endRefreshing];
            [_lcTableView.footer endRefreshing];
        });
    } failure:^(NSError *error ) {
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_jcTableView.header endRefreshing];
            [_jcTableView.footer endRefreshing];
            [_ypTableView.header endRefreshing];
            [_ypTableView.footer endRefreshing];
            [_szcTableView.header endRefreshing];
            [_szcTableView.footer endRefreshing];
            [_lcTableView.header endRefreshing];
            [_lcTableView.footer endRefreshing];
        });
    }];
}

-(void)createIfNoHave
{
    if (_noYgSignView) {
        [_noYgSignView removeFromSuperview];
    }
//    _noYgSignView = [[UIView alloc]initWithFrame:CGRectMake(0,HEIGHTBELOESYSSEVER+84,MyWidth,_ygScroll.frame.size.height)];
    _noYgSignView = [[UIView alloc]initWithFrame:CGRectMake(0,0,MyWidth,_ygScroll.frame.size.height)];
    _noYgSignView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_noYgSignView];
    UIImage *image=[UIImage imageNamed:@"还没有购买方案"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((MyWidth - image.size.width)/2, 30, image.size.width, image.size.height)];
    [imgView setImage:image];
    [_noYgSignView addSubview:imgView];
    
    UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake((MyWidth - 140)/2, ORIGIN_Y(imgView)+60, 140, 40);
    [but setBackgroundImage:[UIImage imageNamed:@"发布方案-确定按钮@2x"] forState:normal];
    but.layer.cornerRadius = 5;
    but.layer.masksToBounds = YES;
    [but addTarget:self action:@selector(jumpToHomePage:) forControlEvents:UIControlEventTouchUpInside];
    [but setTitle:@"去逛逛" forState:normal];
    [_noYgSignView addSubview:but];
    
    if ([_selementType isEqualToString:@"001"]) {
        if ([_ygLotryType isEqualToString:@"-201"]) {
             [_jcTableView addSubview:_noYgSignView];
//            _jcTableView.hidden = YES;
        }else if ([_ygLotryType isEqualToString:@"201"]) {
             [_ypTableView addSubview:_noYgSignView];
//            _ypTableView.hidden = YES;
        }else if ([_ygLotryType isEqualToString:@"204"]) {
            [_lcTableView addSubview:_noYgSignView];
//            _lcTableView.hidden = YES;
        }
    }else if([_selementType isEqualToString:@"002"]){
        [_szcTableView addSubview:_noYgSignView];
//        _szcTableView.hidden = YES;
    }
}

- (void)jumpToHomePage:(id)sender{
    UITabBarController *vc=(UITabBarController *)[[self.navigationController viewControllers] objectAtIndex:
#if defined YUCEDI || defined DONGGEQIU || defined CRAZYSPORTS
                                                  0
#else
                                                  1
#endif
                                                  ];
#if defined CRAZYSPORTS
    vc.selectedIndex=2;
//    ExpertMainViewController *expertVc=(ExpertMainViewController *)vc.selectedViewController;
////    expertVc.lotteryType=_selementType;
////    expertVc.expLoType=_ygLotryType;
////    expertVc.isfromYiGou=YES;
    [self.navigationController popToViewController:vc animated:YES];
#else
    vc.selectedIndex=0;
    if(self.isSdOrNo){
        ExpertHomeViewController *expertVc=(ExpertHomeViewController *)vc.selectedViewController;
        expertVc.lotteyType=_ygLotryType;
        expertVc.superType=_selementType;
        expertVc.isfromYiGou=YES;
    }else{
        ExpertViewController *expertVc=(ExpertViewController *)vc.selectedViewController;
        expertVc.lotteryType=_selementType;
        expertVc.expLoType=_ygLotryType;
        expertVc.isfromYiGou=YES;
    }
    
    [self.navigationController popToViewController:vc animated:YES];
    
#endif
}

#define mark -----------UIScrollViewDelegate------------------

- (void)setScrollContent{
    CGPoint offset=_ygScroll.contentOffset;
    if (offset.x<MyWidth/2) {
        [_ygScroll setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (offset.x>=MyWidth/2&&offset.x<MyWidth*3/2) {
        [_ygScroll setContentOffset:CGPointMake(MyWidth, 0) animated:YES];
    }else if (offset.x>=MyWidth*3/2&&offset.x<MyWidth*5/2) {
        [_ygScroll setContentOffset:CGPointMake(MyWidth*2, 0) animated:YES];
    }else{
        [_ygScroll setContentOffset:CGPointMake(3*MyWidth, 0) animated:YES];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [self setScrollContent];
    CGPoint offset=_ygScroll.contentOffset;
    if (offset.x<MyWidth/2) {
        _selementType=@"001";
        _ygLotryType=@"-201";
        _jcNavBtn.selected=YES;
        _lcNavBtn.selected = NO;
        _ypNavBtn.selected=NO;
        _szcNavBtn.selected=NO;
        _statePlan=_jcStatePlan;
        if (!_jcYgArr) {
            _jcFirst=@"1";
            [self getDataPage:1];
        }
    }else if (offset.x>=MyWidth/2&&offset.x<MyWidth*3/2) {
        _selementType=@"001";
        _ygLotryType=@"204";
        _jcNavBtn.selected=NO;
        _lcNavBtn.selected = YES;
        _ypNavBtn.selected=NO;
        _szcNavBtn.selected=NO;
        _statePlan=_lcStatePlan;
        if (!_lcYgArr) {
            _lcFirst=@"1";
            [self getDataPage:1];
        }
    }else if (offset.x>=MyWidth*3/2&&offset.x<MyWidth*5/2) {
        _selementType=@"001";
        _ygLotryType=@"201";
        _jcNavBtn.selected=NO;
        _lcNavBtn.selected = NO;
        _ypNavBtn.selected=YES;
        _szcNavBtn.selected=NO;
        _statePlan=_ypStatePlan;
        if (!_ypYgArr) {
            _ypFirst=@"1";
            [self getDataPage:1];
        }
    }else{
        _selementType=@"002";
        _ygLotryType=@"";
        _jcNavBtn.selected=NO;
        _lcNavBtn.selected = NO;
        _ypNavBtn.selected=NO;
        _szcNavBtn.selected=YES;
        _statePlan=_szcStatePlan;
        if (!_szcYgArr) {
            _szcFirst=@"1";
            [self getDataPage:1];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setScrollContent];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self setScrollContent];
}

//-(void)creatSegmentView
//{
//    _viewOfSegment=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MyWidth, 60)];
//    [_tableView setTableHeaderView:_viewOfSegment];

//    _segMent=[[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"竞足",@"数字彩", nil]];
//    _segMent.frame=CGRectMake(15,15,MyWidth-30,_viewOfSegment.frame.size.height-30);
//    _segMent.selectedSegmentIndex=0;
//    _segMent.tintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"发布方案-确定按钮"]];
//    [_segMent addTarget:self action:@selector(segmentOnClick:) forControlEvents:UIControlEventValueChanged];
//    [_viewOfSegment addSubview:_segMent];
//}

//-(void)segmentOnClick:(UISegmentedControl *)segment
//{
//    NSInteger index=segment.selectedSegmentIndex;
//    switch (index) {
//        case 0:
//        {
//            _selementType=@"001";
//            break;
//        }
//        case 1:
//        {
//            _selementType=@"002";
//            break;
//        }
//        default:
//            break;
//    }
//}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    