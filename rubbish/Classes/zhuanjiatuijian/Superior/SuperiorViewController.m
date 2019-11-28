//
//  SuperiorViewController.m
//  Experts
//
//  Created by V1pin on 15/10/26.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "SuperiorViewController.h"
#import "MLNavigationController.h"
#import "SMGDetailViewController.h"
#import "SearchVC.h"
#import "NSString+ExpertStrings.h"

#import "ExpertSuperiorBaseCell.h"

#import "ExpertJingjiModel.h"
#import "SharedMethod.h"
#import "MobClick.h"
#import "ExpertMainListTableViewCell.h"
#import "ProjectDetailViewController.h"
#import "Expert365Bridge.h"
#import "LoginViewController.h"

#define PRCIEPOINTDOWNTAG 500
#define PRCIEPOINTUPTAG 501
#define LOTTERRYPOINDOWNTAG 502
#define LOTTERRYPOINUPTAG 503

@interface SuperiorViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIView * screenBgView;//筛选画布
    
    UIView * shadeBg;//黑色阴影
    
    UIView * lotteryTypeBg;//彩种列表背景画布
    
    UITableView *jcListView;//竞足列表
    
    UITableView *lcListView;//篮彩
    
    UITableView *ypListView;//亚盘列表---转成二串一
    
    UITableView *szcListView;//数字彩列表
    
    NSArray * lotteryTypeAry;//包含各种彩种代码的数组
    
    NSArray * lotterySortAry;//彩种列表显示的数组
    
    NSString *erAgintOrderId;
}

@property(nonatomic,copy)NSMutableArray *jcSuperArr;
@property(nonatomic,copy)NSMutableArray *ypSuperArr;
@property(nonatomic,copy)NSMutableArray *szcSuperArr;
@property(nonatomic,copy)NSMutableArray *lcSuperArr;

@property(nonatomic,copy)NSString *superType;//专家类型
@property(nonatomic,copy)NSString *lotteyType;//彩种
@property(nonatomic,copy)NSString *szclotryType;//数字彩彩种

@property(nonatomic,assign)NSInteger jcCurrPage;//当前页
@property(nonatomic,assign)NSInteger ypCurrPage;//当前页
@property(nonatomic,assign)NSInteger szcCurrPage;//当前页
@property(nonatomic,assign)NSInteger lcCurrPage;//当前页

@property(nonatomic,strong)UIView * bpview;//暂无推荐

@property(nonatomic,strong)NSString *orderFlag;//排序方式
@property(nonatomic,strong)NSString *jcOrderFlag;//排序方式
@property(nonatomic,strong)NSString *ypOrderFlag;//排序方式
@property(nonatomic,strong)NSString *szcOrderFlag;//排序方式
//@property(nonatomic,strong)NSString *lcOrderFlag;//排序方式

@property(nonatomic,strong)UIButton *superJCBtn;//竞足btn
@property(nonatomic,strong)UIButton *superYPBtn;//亚盘btn
@property(nonatomic,strong)UIButton *superSZCBtn;//数字彩btn
@property(nonatomic,strong)UIButton *superLCBtn;//篮彩btn

@property(nonatomic,strong)UIButton *ltryOptBtn;//全部btn
@property(nonatomic,strong)UIButton *priceSzcBtn;//价格btn
//@property(nonatomic,strong)UIButton *hitRatioBtn;//命中率btn

@property(nonatomic,strong)UIImageView *selectImgV;
@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation SuperiorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //self.title_nav = @"高手推荐";
#if !defined YUCEDI && !defined DONGGEQIU
    [self creatNavView];
#endif
    
    _segmentSelectFlags=YES;
    _superType=@"001";
    _lotteyType=@"-201";
    _szclotryType=@"";
    _orderFlag=@"0";
    _jcOrderFlag=@"0";
    _ypOrderFlag=@"0";
    _szcOrderFlag=@"0";
    _jcCurrPage=1;
    _ypCurrPage=1;
    _szcCurrPage=1;
    lotteryTypeAry=[NSArray arrayWithObjects:@"",@"001",@"113",@"002",@"108",nil];
    
    [self supCurPage:@"1" superType:_superType lotryType:_lotteyType];
    
    [self creatNavBar];
    
    [self creatScreenBgView];
    
    [self creatSuperTable];
    
    [self creatSortList];
    
    [self setupRefresh];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self hideSortClick];
}

/**
 *  往导航条上添加内容
 */
-(void)creatNavBar
{
    NSString *btnText=@"";
    UIButton *btn;
    for (int i=0; i<=3; i++) {
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(27+(MyWidth-62)/4*i, HEIGHTBELOESYSSEVER, (MyWidth-62)/4, 44)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithRed:170.0/255.0 green:218.0/255.0 blue:252.0/255.0 alpha:1.0] forState:UIControlStateNormal];
//        if (i==0) {
//            btn.selected=YES;
//            btnText=@"竞足";
//        }else if(i==1){
////            btnText=@"亚盘";
//            btnText=@"二串一";
//        }else if(i==2){
//            btnText=@"数字彩";
//        }
        if (i==0) {
            btn.selected=YES;
            btnText=@"竞足";
        }else if(i==1){
            btnText=@"篮彩";
        }else if(i==2){
            btnText=@"2串1";
        }else if(i==3){
            btnText=@"数字彩";
        }
        [btn setTitle:btnText forState:UIControlStateNormal];
        [btn setTitle:btnText forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnSuperClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=FONTTHIRTY;
        [self.navView addSubview:btn];
        if (i==0) {
            _superJCBtn=btn;
        }else if(i==2){
            _superYPBtn=btn;
        }else if(i==3){
            _superSZCBtn=btn;
        }else if(i==1){
            _superLCBtn=btn;
        }
    }
    
    UIImage *searchImage=[UIImage imageNamed:@"椭圆"];//添加搜索按钮
    [self rightImgAndAction:searchImage target:self action:@selector(searchBtn)];
    [self.rightBtn setImageEdgeInsets:UIEdgeInsetsMake(HEIGHTBELOESYSSEVER+12, 25, 32-searchImage.size.height, 35-searchImage.size.width)];
}

/**
 筛选选项条
 */
-(void)creatScreenBgView
{
    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, MyHight-HEIGHTBELOESYSSEVER-44-49)];
    _scrollView.backgroundColor=[UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
//    _scrollView.contentSize=CGSizeMake(3*MyWidth, MyHight-HEIGHTBELOESYSSEVER-44-49);
    _scrollView.contentSize=CGSizeMake(4*MyWidth, MyHight-HEIGHTBELOESYSSEVER-44-49);
    _scrollView.delegate=self;
    _scrollView.bounces=NO;
    [self.view addSubview:_scrollView];
    
    //创建view
    screenBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MyWidth*4, 35)];
//    screenBgView.layer.masksToBounds=YES;
//    screenBgView.layer.borderWidth=1;
//    screenBgView.layer.borderColor=SEPARATORCOLOR.CGColor;
    [_scrollView addSubview:screenBgView];
    
    UIView *sepLine=[[UIView alloc] initWithFrame:CGRectMake(0, screenBgView.frame.size.height-1, screenBgView.frame.size.width, 1)];
    [sepLine setBackgroundColor:SEPARATORCOLOR];
    [screenBgView addSubview:sepLine];
    
//    for (int i=0; i<2; i++) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateNormal];
//        [btn setTitleColor:ALERT_BLUE forState:UIControlStateHighlighted];
//        [btn setTitleColor:ALERT_BLUE forState:UIControlStateSelected];
//        btn.tag=1000+i;
//        if(i == 0){
//            [btn setTitle:@"综合" forState:UIControlStateNormal];
//            btn.selected=YES;
//        }else{
//            [btn setTitle:@"价格" forState:UIControlStateNormal];
//        }
//        [btn setFrame:CGRectMake(MyWidth+MyWidth/2*i, 0, MyWidth/2, 35)];
//        btn.titleLabel.font=FONTTHIRTY;
//        [screenBgView addSubview:btn];
//        
//        if(i == 0){
//            UIImageView *intervalView=[[UIImageView alloc] initWithFrame:CGRectMake(btn.frame.size.width-0.5, 6.5, 0.5, 22)];
//            intervalView.image=[UIImage imageNamed:@"intervalLine"];
//            [btn addSubview:intervalView];
//        }else{
//            
//            UIImageView *pointView=[[UIImageView alloc] init];
//            pointView.image=[UIImage imageNamed:@"triangle-normal-down"];
//            pointView.tag=PRCIEPOINTDOWNTAG;
//            
//            CGSize btnsize=[PublicMethod setNameFontSize:@"综合" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//            [btn setTitleEdgeInsets:UIEdgeInsetsMake(12, btn.frame.size.width/2-(btnsize.width+2*MyWidth/320+10)/2, 12, btn.frame.size.width/2-(btnsize.width+2*MyWidth/320+10)/2+2*MyWidth/320+10)];
//            [pointView setFrame:CGRectMake(btn.frame.size.width/2-(btnsize.width+2*MyWidth/320+10)/2+btnsize.width+2*MyWidth/320, 15, 10, 5)];
//            [btn addSubview:pointView];
//            [btn addTarget:self action:@selector(selectLancaiSortWay:) forControlEvents:UIControlEventTouchUpInside];
//        }
//    }
    
    NSString *btnText=@"";
    UIButton *btn;
    for (int i=0; i<=14; i++) {
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateNormal];
        [btn setTitleColor:ALERT_BLUE forState:UIControlStateHighlighted];
        [btn setTitleColor:ALERT_BLUE forState:UIControlStateSelected];
        btn.tag=100+i;
        if (i==10) {
            btnText=@"全部";
            _ltryOptBtn=btn;
        }else if(i==0||i==4||i==6||i==11){
            btnText=@"综合";
        }else if(i==1||i==5||i==7||i==12){
            btnText=@"价格";
            if (i==12) {
                _priceSzcBtn=btn;
            }
        }else if(i==2||i==8||i==13){
            btnText=@"等级";
        }else if(i==3||i==9||i==14){
            btnText=@"命中率";
        }
        if(i==0||i==4||i==6||i==10){
            btn.selected=YES;
        }
        
        if(i < 4){
            [btn setFrame:CGRectMake(0+MyWidth/4*i, 0, MyWidth/4, 35)];
        }else if (i < 6){
            [btn setFrame:CGRectMake(MyWidth+MyWidth/2*(i-4), 0, MyWidth/2, 35)];
        }else if (i < 10){
            [btn setFrame:CGRectMake(MyWidth*2+MyWidth/4*(i-6), 0, MyWidth/4, 35)];
        }else{
            [btn setFrame:CGRectMake(MyWidth/5*(i-10)+MyWidth*3, 0, MyWidth/5, 35)];
        }
        [btn setTitle:btnText forState:UIControlStateNormal];
        [btn setTitle:btnText forState:UIControlStateHighlighted];
        btn.titleLabel.font=FONTTHIRTY;
        [screenBgView addSubview:btn];
        if (i!=14) {
            UIImageView *intervalView=[[UIImageView alloc] initWithFrame:CGRectMake(btn.frame.size.width-0.5, 6.5, 0.5, 22)];
            intervalView.image=[UIImage imageNamed:@"intervalLine"];
            [btn addSubview:intervalView];
        }
        
        if(i==1||i==5||i==7||i==10||i==12){
            UIImageView *pointView=[[UIImageView alloc] init];
            pointView.image=[UIImage imageNamed:@"triangle-normal-down"];
            pointView.tag=PRCIEPOINTDOWNTAG;
            if (i==8) {
                pointView.tag=LOTTERRYPOINDOWNTAG;
            }
            CGSize btnsize=[PublicMethod setNameFontSize:btnText andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(12, btn.frame.size.width/2-(btnsize.width+2*MyWidth/320+10)/2, 12, btn.frame.size.width/2-(btnsize.width+2*MyWidth/320+10)/2+2*MyWidth/320+10)];
            [pointView setFrame:CGRectMake(btn.frame.size.width/2-(btnsize.width+2*MyWidth/320+10)/2+btnsize.width+2*MyWidth/320, 15, 10, 5)];
            [btn addSubview:pointView];
        }
        if (i==10) {
            [btn addTarget:self action:@selector(showOrNotSortList:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [btn addTarget:self action:@selector(selectSortWay:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (i >= 6 && i <= 9) {
            btn.hidden = YES;
        }
    }
    
//    NSString *btnText=@"";
//    UIButton *btn;
//    for (int i=0; i<=12; i++) {
//        btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateNormal];
//        [btn setTitleColor:ALERT_BLUE forState:UIControlStateHighlighted];
//        [btn setTitleColor:ALERT_BLUE forState:UIControlStateSelected];
//        btn.tag=100+i;
//        if (i==8) {
//            btnText=@"全部";
//            _ltryOptBtn=btn;
//        }else if(i==0||i==4||i==9){
//            btnText=@"综合";
//        }else if(i==1||i==5||i==10){
//            btnText=@"价格";
//            if (i==10) {
//                _priceSzcBtn=btn;
//            }
//        }else if(i==2||i==6||i==11){
//            btnText=@"等级";
//        }else if(i==3||i==7||i==12){
//            btnText=@"命中率";
//        }
//        if(i==0||i==4||i==8){
//            btn.selected=YES;
//        }
//        if (i<8) {
//            [btn setFrame:CGRectMake(0+MyWidth/4*i, 0, MyWidth/4, 35)];
//        }else{
//            [btn setFrame:CGRectMake(MyWidth/5*(i-8)+MyWidth*2, 0, MyWidth/5, 35)];
//        }
//        [btn setTitle:btnText forState:UIControlStateNormal];
//        [btn setTitle:btnText forState:UIControlStateHighlighted];
//        btn.titleLabel.font=FONTTHIRTY;
//        [screenBgView addSubview:btn];
//        if (i!=12) {
//            UIImageView *intervalView=[[UIImageView alloc] initWithFrame:CGRectMake(btn.frame.size.width-0.5, 6.5, 0.5, 22)];
//            intervalView.image=[UIImage imageNamed:@"intervalLine"];
//            [btn addSubview:intervalView];
//        }
//        
//        if(i==1||i==5||i==8||i==10){
//            UIImageView *pointView=[[UIImageView alloc] init];
//            pointView.image=[UIImage imageNamed:@"triangle-normal-down"];
//            pointView.tag=PRCIEPOINTDOWNTAG;
//            if (i==8) {
//                pointView.tag=LOTTERRYPOINDOWNTAG;
//            }
//            CGSize btnsize=[PublicMethod setNameFontSize:btnText andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//            [btn setTitleEdgeInsets:UIEdgeInsetsMake(12, btn.frame.size.width/2-(btnsize.width+2*MyWidth/320+10)/2, 12, btn.frame.size.width/2-(btnsize.width+2*MyWidth/320+10)/2+2*MyWidth/320+10)];
//            [pointView setFrame:CGRectMake(btn.frame.size.width/2-(btnsize.width+2*MyWidth/320+10)/2+btnsize.width+2*MyWidth/320, 15, 10, 5)];
//            [btn addSubview:pointView];
//        }
//        if (i==8) {
//            [btn addTarget:self action:@selector(showOrNotSortList:) forControlEvents:UIControlEventTouchUpInside];
//        }else{
//            [btn addTarget:self action:@selector(selectSortWay:) forControlEvents:UIControlEventTouchUpInside];
//        }
//    }
    
    //NSDictionary *attributes=[NSDictionary dictionaryWithObject:FONTTHIRTY forKey:UITextAttributeFont];
    //[_segMent setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(void)creatSuperTable
{
    jcListView=[[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(screenBgView.frame), MyWidth, _scrollView.frame.size.height-screenBgView.frame.size.height) style:UITableViewStylePlain];
    jcListView.showsHorizontalScrollIndicator=NO;
    jcListView.showsVerticalScrollIndicator=NO;
    jcListView.delegate=self;
    jcListView.dataSource=self;
    jcListView.tag=501;
    jcListView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:jcListView];
    
    lcListView=[[UITableView alloc]initWithFrame:CGRectMake(MyWidth,CGRectGetMaxY(screenBgView.frame), MyWidth, _scrollView.frame.size.height-screenBgView.frame.size.height) style:UITableViewStylePlain];
    lcListView.showsHorizontalScrollIndicator=NO;
    lcListView.showsVerticalScrollIndicator=NO;
    lcListView.delegate=self;
    lcListView.dataSource=self;
    lcListView.tag=504;
    lcListView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:lcListView];
    
    ypListView=[[UITableView alloc]initWithFrame:CGRectMake(MyWidth*2,0, MyWidth, _scrollView.frame.size.height) style:UITableViewStylePlain];
    ypListView.showsHorizontalScrollIndicator=NO;
    ypListView.showsVerticalScrollIndicator=NO;
    ypListView.delegate=self;
    ypListView.dataSource=self;
    ypListView.tag=502;
    ypListView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:ypListView];
    
    szcListView=[[UITableView alloc]initWithFrame:CGRectMake(MyWidth*3,CGRectGetMaxY(screenBgView.frame), MyWidth, _scrollView.frame.size.height-screenBgView.frame.size.height) style:UITableViewStylePlain];
    szcListView.showsHorizontalScrollIndicator=NO;
    szcListView.showsVerticalScrollIndicator=NO;
    szcListView.delegate=self;
    szcListView.dataSource=self;
    szcListView.tag=503;
    szcListView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:szcListView];
}

/**
 *  创建排序单击后的展示UI
 */
-(void)creatSortList
{
    lotterySortAry=[NSArray arrayWithObjects:@"        全部",@"        双色球",@"        大乐透",@"        3D",@"        排列3", nil];
    
    lotteryTypeBg=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(screenBgView.frame)+HEIGHTBELOESYSSEVER+44, MyWidth, lotterySortAry.count*45.5)];
    lotteryTypeBg.hidden=YES;
    lotteryTypeBg.userInteractionEnabled=YES;
    lotteryTypeBg.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:lotteryTypeBg];
    
    CGFloat btnW=MyWidth;
    CGFloat btnH=45.5;
    for (int i=0; i<lotterySortAry.count; i++) {
        UILabel * sortLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,i*45.5, btnW, btnH)];
        sortLabel.backgroundColor=[UIColor whiteColor];
        sortLabel.text=[lotterySortAry objectAtIndex:i];
        sortLabel.textColor=BLACK_EIGHTYSEVER;
        sortLabel.font=FONTTWENTY_EIGHT;
        sortLabel.tag=200+i;
        [lotteryTypeBg addSubview:sortLabel];
        
        UITapGestureRecognizer * sortLabrlGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectLotypeClick:)];
        sortLabel.userInteractionEnabled=YES;
        [sortLabel addGestureRecognizer:sortLabrlGes];
        
        //下面的线
        UILabel * blackLine=[[UILabel alloc]initWithFrame:CGRectMake(0, 45+i*45.5, MyWidth, 0.5)];
        blackLine.tag=400+i;
        blackLine.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
        [lotteryTypeBg addSubview:blackLine];
        
    }
    _selectImgV=[[UIImageView alloc] initWithFrame:CGRectMake(15*MyWidth/320, 17, 9, 6)];
    _selectImgV.image=[UIImage imageNamed:@"排行榜对号"];
    [lotteryTypeBg addSubview:_selectImgV];
    
    shadeBg=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lotteryTypeBg.frame), MyWidth, MyHight-CGRectGetMaxY(lotteryTypeBg.frame)-49)];
    shadeBg.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
    shadeBg.hidden=YES;
    [self.view addSubview:shadeBg];
}

/**
 *  点击搜索
 */
-(void)searchBtn
{
    [MobClick event:@"Zj_quanbu_20161014_sousuo" label:@"高手"];
    SearchVC *vc=[[SearchVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  选择专家类型
 */
- (void)btnSuperClick:(UIButton *)btn{
    btn.selected=YES;
    [self hideSortClick];
    if (btn==_superJCBtn) {
        _superLCBtn.selected = NO;
        _superYPBtn.selected=NO;
        _superSZCBtn.selected=NO;
        _superType=@"001";
        _lotteyType=@"-201";
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        _orderFlag=_jcOrderFlag;;
        if (!_jcSuperArr || !_jcSuperArr.count) {
            _jcCurrPage=1;
            [self supCurPage:@"1" superType:_superType lotryType:_lotteyType];
        }
        [jcListView reloadData];
    }else if (btn==_superYPBtn) {
        _superJCBtn.selected=NO;
        _superLCBtn.selected = NO;
        _superSZCBtn.selected=NO;
        _superType=@"001";
        _lotteyType=@"201";
        [_scrollView setContentOffset:CGPointMake(MyWidth*2, 0) animated:YES];
        _orderFlag=_ypOrderFlag;
        if (!_ypSuperArr || !_ypSuperArr.count) {
            _ypCurrPage=1;
//            [self supCurPage:@"1" superType:_superType lotryType:_lotteyType];
            [self getErchuanyiExpertRequestWithPage:@"1"];
        }
        [ypListView reloadData];
    }else if (btn==_superSZCBtn) {
        _superJCBtn.selected=NO;
        _superLCBtn.selected = NO;
        _superYPBtn.selected=NO;
        _superType=@"002";
        _lotteyType=_szclotryType;
        [_scrollView setContentOffset:CGPointMake(MyWidth*3, 0) animated:YES];
        _orderFlag=_szcOrderFlag;
        if (!_szcSuperArr || !_szcSuperArr.count) {
            _szcCurrPage=1;
            [self supCurPage:@"1" superType:_superType lotryType:_lotteyType];
        }
        [szcListView reloadData];
    }else if (btn==_superLCBtn) {
        _superJCBtn.selected=NO;
        _superYPBtn.selected=NO;
        _superSZCBtn.selected=NO;
        _superType=@"001";
        _lotteyType=@"204";
        [_scrollView setContentOffset:CGPointMake(MyWidth, 0) animated:YES];
        _orderFlag=@"";
        if (!_lcSuperArr || !_lcSuperArr.count) {
            _lcCurrPage=1;
            [self supCurPage:@"1" superType:_superType lotryType:_lotteyType];
        }
        [lcListView reloadData];
    }
}

/**
 *  展示或者隐藏彩种列表
 */
-(void)showOrNotSortList:(UIButton *)btn
{
    btn.selected=YES;
    if (btn.tag >= 100 && btn.tag < 104) {
        [MobClick event:@"Zj_gaoshou_20161014_jingcai" label:[btn titleForState:UIControlStateNormal]];
    }
    else if (btn.tag >= 104 && btn.tag > 108) {
        [MobClick event:@"Zj_gaoshou_20161014_yapan" label:[btn titleForState:UIControlStateNormal]];
    }
    else if (btn.tag < 108) {
        [MobClick event:@"Zj_gaoshou_20161014_shuzicai" label:[btn titleForState:UIControlStateNormal]];
    }
    
    for (UIView *view in [btn subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imgView=(UIImageView *)view;
            if (imgView.tag==LOTTERRYPOINDOWNTAG) {
                imgView.image=[UIImage imageNamed:@"triangle-selected-up"];
                imgView.tag=LOTTERRYPOINUPTAG;
                [self displaySortClick];
            }else if(imgView.tag==LOTTERRYPOINUPTAG){
                imgView.image=[UIImage imageNamed:@"triangle-selected-down"];
                imgView.tag=LOTTERRYPOINDOWNTAG;
                [self hideSortClick];
            }
        }
    }
    
    for (UIView *view in [screenBgView subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *sortBtn=(UIButton *)view;
            if (sortBtn!=btn) {
                if (sortBtn.tag>=109&&sortBtn.tag<113) {
                    sortBtn.selected=NO;
                    [self changeSortBtnImg:110 btn:sortBtn];
                }
            }
        }
    }
}
/**
 *  选择排序方式
 */
- (void)selectSortWay:(UIButton *)btn{
    [self hideSortClick];
    if (btn.tag >= 100 && btn.tag < 104) {
        [MobClick event:@"Zj_gaoshou_20161014_jingcai" label:[btn titleForState:UIControlStateNormal]];
    }
    else if (btn.tag >= 104 && btn.tag > 106) {
        [MobClick event:@"Zj_gaoshou_20161014_lancai" label:[btn titleForState:UIControlStateNormal]];
    }
    else if (btn.tag >= 106 && btn.tag > 110) {
        [MobClick event:@"Zj_gaoshou_20161014_yapan" label:[btn titleForState:UIControlStateNormal]];
    }
    else if (btn.tag < 110) {
        [MobClick event:@"Zj_gaoshou_20161014_shuzicai" label:[btn titleForState:UIControlStateNormal]];
    }
    btn.selected=YES;
    NSInteger tagChange;
    if ([_superType isEqualToString:@"001"]) {
        if ([_lotteyType isEqualToString:@"-201"]) {
            tagChange=101;
        }else if([_lotteyType isEqualToString:@"204"]){
            tagChange=105;
        }else if([_lotteyType isEqualToString:@"201"]){
            tagChange=107;
        }
    }else if ([_superType isEqualToString:@"002"]){
        tagChange=112;
    }
    
    if(btn.tag==tagChange){
        UIImageView *imgView=(UIImageView *)[[btn subviews] objectAtIndex:2];
        if (imgView.tag==PRCIEPOINTDOWNTAG) {
            imgView.image=[UIImage imageNamed:@"triangle-selected-up"];
            imgView.tag=PRCIEPOINTUPTAG;
        }else if (imgView.tag==PRCIEPOINTUPTAG){
            imgView.image=[UIImage imageNamed:@"triangle-selected-down"];
            imgView.tag=PRCIEPOINTDOWNTAG;
        }
    }
    
    for (UIView *view in [screenBgView subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *sortBtn=(UIButton *)view;
            if (sortBtn!=btn) {
                if ([_superType isEqualToString:@"001"]) {
                    if ([_lotteyType isEqualToString:@"-201"]) {
                        if (sortBtn.tag<104) {
                            sortBtn.selected=NO;
                            [self changeSortBtnImg:101 btn:sortBtn];
                        }
                    }else if([_lotteyType isEqualToString:@"204"]){
                        if (sortBtn.tag>=104&&sortBtn.tag<106) {
                            sortBtn.selected=NO;
                            [self changeSortBtnImg:105 btn:sortBtn];
                        }
                    }else if([_lotteyType isEqualToString:@"201"]){
                        if (sortBtn.tag>=106&&sortBtn.tag<110) {
                            sortBtn.selected=NO;
                            [self changeSortBtnImg:107 btn:sortBtn];
                        }
                    }
                }else if ([_superType isEqualToString:@"002"]){
                    if (sortBtn.tag>=110&&sortBtn.tag<115) {
                        sortBtn.selected=NO;
                        [self changeSortBtnImg:112 btn:sortBtn];
                    }
                    UIImageView *imgView=(UIImageView *)[[_ltryOptBtn subviews] objectAtIndex:2];
                    imgView.image=[UIImage imageNamed:@"triangle-normal-down"];
                    imgView.tag=LOTTERRYPOINDOWNTAG;
                }
            }
        }
    }
    if ([_superType isEqualToString:@"001"]) {
        if ([_lotteyType isEqualToString:@"-201"]) {
            _jcCurrPage=1;
            if(btn.tag==100){
                _jcOrderFlag=@"0";
            }else if (btn.tag==101) {
                UIImageView *imgView=(UIImageView *)[[btn subviews] objectAtIndex:2];
                if (imgView.tag==PRCIEPOINTDOWNTAG) {
                    _jcOrderFlag=@"2";
                }else if(imgView.tag==PRCIEPOINTUPTAG){
                    _jcOrderFlag=@"1";
                }
            }else if(btn.tag==102){
                _jcOrderFlag=@"3";
            }else if(btn.tag==103){
                _jcOrderFlag=@"4";
            }
            _orderFlag=_jcOrderFlag;
        }else if([_lotteyType isEqualToString:@"204"]){
            _lcCurrPage=1;
            if(btn.tag==104){
                _ypOrderFlag=@"0";
            }else if (btn.tag==105) {
               UIImageView *imgView=(UIImageView *)[[btn subviews] objectAtIndex:2];
                if (imgView.tag==PRCIEPOINTDOWNTAG) {
                    _ypOrderFlag=@"2";
                }else if(imgView.tag==PRCIEPOINTUPTAG){
                    _ypOrderFlag=@"1";
                }
            }
 //            _orderFlag = @"0";
           _orderFlag=_ypOrderFlag;
        }else if([_lotteyType isEqualToString:@"201"]){
            _ypCurrPage=1;
            if(btn.tag==106){
                _ypOrderFlag=@"0";
            }else if (btn.tag==107) {
                UIImageView *imgView=(UIImageView *)[[btn subviews] objectAtIndex:2];
                if (imgView.tag==PRCIEPOINTDOWNTAG) {
                    _ypOrderFlag=@"2";
                }else if(imgView.tag==PRCIEPOINTUPTAG){
                    _ypOrderFlag=@"1";
                }
            }else if(btn.tag==108){
                _ypOrderFlag=@"3";
            }else if(btn.tag==109){
                _ypOrderFlag=@"4";
            }
            _orderFlag=_ypOrderFlag;
            [self getErchuanyiExpertRequestWithPage:@"1"];
            return;
        }
    }else if ([_superType isEqualToString:@"002"]){
        _szcCurrPage=1;
        if(btn.tag==111){
            _szcOrderFlag=@"0";
        }else if (btn.tag==112) {
            UIImageView *imgView=(UIImageView *)[[btn subviews] objectAtIndex:2];
            if (imgView.tag==PRCIEPOINTDOWNTAG) {
                _szcOrderFlag=@"2";
            }else if(imgView.tag==PRCIEPOINTUPTAG){
                _szcOrderFlag=@"1";
            }
        }else if(btn.tag==113){
            _szcOrderFlag=@"3";
        }else if(btn.tag==114){
            _szcOrderFlag=@"4";
        }
        _orderFlag=_szcOrderFlag;
    }
    [self supCurPage:@"1" superType:_superType lotryType:_lotteyType];
}

- (void)changeSortBtnImg:(NSInteger)btnTag btn:(UIButton *)btn{
    if (btn.tag==btnTag) {
        UIImageView *imgView=(UIImageView *)[[btn subviews] objectAtIndex:2];
        if (imgView.tag==PRCIEPOINTDOWNTAG) {
            imgView.image=[UIImage imageNamed:@"triangle-normal-down"];
        }else if (imgView.tag==PRCIEPOINTUPTAG){
            imgView.image=[UIImage imageNamed:@"triangle-normal-up"];
        }
    }
}

/**
 *  选择彩种
 */
-(void)selectLotypeClick:(UIGestureRecognizer *)gesture
{
    _szcOrderFlag=@"0";
    _orderFlag=_szcOrderFlag;
    _szcCurrPage=1;
    
    UIView *view=gesture.view;
    NSString *tit=@"";
    for (int i=0; i<lotteryTypeAry.count; i++) {
        if (view.tag==200+i) {
            _szclotryType=[lotteryTypeAry objectAtIndex:i];
            _lotteyType=_szclotryType;
            tit=[[NSString stringWithFormat:@"%@",[lotterySortAry objectAtIndex:i]] stringByReplacingOccurrencesOfString:@" " withString:@""];
            [MobClick event:@"Zj_gaoshou_20161014_shuzicai_quanbu" label:[lotterySortAry objectAtIndex:i]];
            if([_lotteyType isEqualToString:@"201"]){
                [self getErchuanyiExpertRequestWithPage:@"1"];
            }else{
                [self supCurPage:@"1" superType:_superType lotryType:_lotteyType];
            }
        }
    }
    [_ltryOptBtn setTitle:tit forState:UIControlStateNormal];
    [_ltryOptBtn setTitle:tit forState:UIControlStateSelected];
    
    CGSize btnsize=[PublicMethod setNameFontSize:tit andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_ltryOptBtn setTitleEdgeInsets:UIEdgeInsetsMake(12, _ltryOptBtn.frame.size.width/2-(btnsize.width+2*MyWidth/320+10)/2, 12, _ltryOptBtn.frame.size.width/2-(btnsize.width+2*MyWidth/320+10)/2+2*MyWidth/320+10)];
    
    for (UIView *view in [_ltryOptBtn subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imgView=(UIImageView *)[[_ltryOptBtn subviews] objectAtIndex:2];
            if (imgView.tag==LOTTERRYPOINUPTAG||imgView.tag==LOTTERRYPOINDOWNTAG) {
                imgView.image=[UIImage imageNamed:@"triangle-selected-down"];
                imgView.tag=LOTTERRYPOINDOWNTAG;
            }
            [imgView setFrame:CGRectMake(_ltryOptBtn.frame.size.width/2-(btnsize.width+2*MyWidth/320+10)/2+btnsize.width+2*MyWidth/320, 15, 10, 5)];
        }
    }
    [self hideSortClick];
}

/**
 显示单击sort按钮展现出来的UI界面
 */
-(void)displaySortClick
{
    NSInteger tag = [lotteryTypeAry indexOfObject:_szclotryType];
    [_selectImgV setFrame:CGRectMake(15*MyWidth/320, 17+tag*45.5, 9, 6)];
    for (UIView *view in [lotteryTypeBg subviews]) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *lab=(UILabel *)view;
            if (view.tag==200+tag) {
                lab.textColor=[UIColor colorWithRed:21.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1.0];
            }else
                lab.textColor=BLACK_EIGHTYSEVER;
        }
    }
    lotteryTypeBg.hidden=NO;
    shadeBg.hidden=NO;
    _scrollView.scrollEnabled=NO;
    szcListView.userInteractionEnabled=NO;
}

/**
 隐藏单击sort按钮展现出来的UI界面
 */
-(void)hideSortClick
{
    lotteryTypeBg.hidden=YES;
    shadeBg.hidden=YES;
    _scrollView.scrollEnabled=YES;
    szcListView.userInteractionEnabled=YES;
}

#pragma mark -UITableViewDataSource数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==501) {
        return  [_jcSuperArr count];
    }else if(tableView.tag==502){
        return  [_ypSuperArr count];
    }else if (tableView.tag==503) {
        return  [_szcSuperArr count];
    }else if (tableView.tag==504) {
        return  [_lcSuperArr count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if([_superType isEqualToString:@"001"]){
//        
//        ExpertJingjiModel *supExMdl;
//        if (tableView.tag==501) {
//            supExMdl=[_jcSuperArr objectAtIndex:indexPath.row];
//        }else if(tableView.tag==502){
//            supExMdl=[_ypSuperArr objectAtIndex:indexPath.row];
//        }else if (tableView.tag==503) {
//            supExMdl=[_szcSuperArr objectAtIndex:indexPath.row];
//        }
//
//        
//        NSString * starCell = @"expertSuperCell";
//        ExpertMainListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:starCell];
//        if (!cell) {
//            cell = [[ExpertMainListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:starCell];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        
//        cell.isZhuanjia = YES;
//        
//        __block SuperiorViewController * newSelf = self;
//        cell.buttonAction = ^(UIButton *button) {
//            
//            [newSelf getIsBuyInfoWithOrderID:supExMdl];
//        };
//        
//        [cell loadYuecaiExpertListInfo:supExMdl];
//        
//        return cell;
//        
//    }else if([_superType isEqualToString:@"002"]){
//        
//        ExpertSuperiorBaseCell * cell=[ExpertSuperiorBaseCell ExpertSuperiorBaseCellWithTableView:tableView cellForRowAtIndexPath:indexPath];
//        
//        ExpertJingjiModel *supExMdl=[_szcSuperArr objectAtIndex:indexPath.row];
//        
//        NSString *compTime=@"";
//        NSString *odds=@"";
//        NSString *matchs=@"";
//        
//        CGRect rect=cell.timeLab.frame;
//        
//        cell.zhongView.hidden=NO;
//        cell.leagueTypeLab.hidden=YES;
//        
//        odds=[NSString stringWithFormat:@"%@中%@",supExMdl.ALL_HIT_NUM,supExMdl.HIT_NUM];
//        matchs=[NSString stringWithFormat:@"%@ %@期",[NSString lotteryTpye:supExMdl.LOTTEY_CLASS_CODE],supExMdl.ER_ISSUE];
//        compTime=[NSString stringWithFormat:@"截止时间 %@",supExMdl.END_TIME];
//        rect.size.width=150;
//        
//        [cell.timeLab setFrame:rect];
//        
//        [cell setCellSuperHead:supExMdl.HEAD_PORTRAIT name:supExMdl.EXPERTS_NICK_NAME starNo:supExMdl.STAR odds:odds matchSides:matchs time:compTime leagueType:supExMdl.LEAGUE_NAME exPrice:supExMdl.PRICE exDiscount:supExMdl.DISCOUNT exRank:supExMdl.SOURCE refundOrNo:supExMdl.FREE_STATUS flag:YES lotryTp:_lotteyType];
//        
//        return  cell;
//    }
//    return nil;
    
    ExpertSuperiorBaseCell * cell=[ExpertSuperiorBaseCell ExpertSuperiorBaseCellWithTableView:tableView cellForRowAtIndexPath:indexPath];
    
    ExpertJingjiModel *supExMdl;
    if (tableView.tag==501) {
        supExMdl=[_jcSuperArr objectAtIndex:indexPath.row];
    }else if(tableView.tag==502){
        supExMdl=[_ypSuperArr objectAtIndex:indexPath.row];
    }else if (tableView.tag==503) {
        supExMdl=[_szcSuperArr objectAtIndex:indexPath.row];
    }else if (tableView.tag==504) {
        supExMdl=[_lcSuperArr objectAtIndex:indexPath.row];
    }

    NSString *compTime=@"";
    NSString *odds=@"";
    NSString *matchs=@"";
    
    CGRect rect=cell.timeLab.frame;
    
    if([_superType isEqualToString:@"001"]){
        cell.zhongView.hidden=NO;
        cell.leagueTypeLab.hidden=NO;
        
        odds=[NSString stringWithFormat:@"%@中%@",supExMdl.ALL_HIT_NUM,supExMdl.HIT_NUM];
        matchs=[NSString stringWithFormat:@"%@ VS %@",supExMdl.HOME_NAME,supExMdl.AWAY_NAME];
        
        NSString *matchID=supExMdl.MATCHES_ID;
        if ([_lotteyType isEqualToString:@"201"]) {
            matchID=[matchID substringToIndex:2];
        }
        compTime=[NSString stringWithFormat:@"%@ %@",matchID,supExMdl.MATCH_TIME];
        rect.size.width=100;
    }else if([_superType isEqualToString:@"002"]){
        cell.zhongView.hidden=NO;
        cell.leagueTypeLab.hidden=YES;
        
        odds=[NSString stringWithFormat:@"%@中%@",supExMdl.ALL_HIT_NUM,supExMdl.HIT_NUM];
        matchs=[NSString stringWithFormat:@"%@ %@期",[NSString lotteryTpye:supExMdl.LOTTEY_CLASS_CODE],supExMdl.ER_ISSUE];
        compTime=[NSString stringWithFormat:@"截止时间 %@",supExMdl.END_TIME];
        rect.size.width=150;
    }
    [cell.timeLab setFrame:rect];
    
    if ([_lotteyType isEqualToString:@"201"]) {
        
        NSString *matchs2=[NSString stringWithFormat:@"%@ VS %@",supExMdl.HOME_NAME2,supExMdl.AWAY_NAME2];
        
        NSString *matchID2=supExMdl.MATCHES_ID2;
        matchID2=[matchID2 substringToIndex:2];
        NSString *compTime2=[NSString stringWithFormat:@"%@ %@",matchID2,supExMdl.MATCH_TIME2];
        
        [cell setCellSuperHead:supExMdl.HEAD_PORTRAIT name:supExMdl.EXPERTS_NICK_NAME starNo:supExMdl.STAR odds:odds matchSides:matchs time:compTime leagueType:supExMdl.LEAGUE_NAME exPrice:supExMdl.PRICE exDiscount:supExMdl.DISCOUNT exRank:supExMdl.SOURCE refundOrNo:supExMdl.FREE_STATUS flag:YES lotryTp:_lotteyType name2:matchs2 time2:compTime2 league2:supExMdl.LEAGUE_NAME2];
    }else{
        if([_lotteyType isEqualToString:@"204"]){//篮球
            NSString *str = @"让分胜负";
            if([supExMdl.PLAY_TYPE_CODE isEqualToString:@"29"]){
                str = @"大小分";
            }
            matchs=[NSString stringWithFormat:@"%@(客) VS %@(主)  \n%@ %@",supExMdl.AWAY_NAME,supExMdl.HOME_NAME,str,supExMdl.HOSTRQ];
        }
        [cell setCellSuperHead:supExMdl.HEAD_PORTRAIT name:supExMdl.EXPERTS_NICK_NAME starNo:supExMdl.STAR odds:odds matchSides:matchs time:compTime leagueType:supExMdl.LEAGUE_NAME exPrice:supExMdl.PRICE exDiscount:supExMdl.DISCOUNT exRank:supExMdl.SOURCE refundOrNo:supExMdl.FREE_STATUS flag:YES lotryTp:_lotteyType];
    }
    
    return  cell;
}

#pragma mark -------------UITableViewDelegate--------------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_lotteyType isEqualToString:@"201"]){
        return 156;
    }
    return 100;
    
//    if(tableView.tag==501){//竞足
//        return 110;
//    }else if (tableView.tag==501){//二串一
//        return 150;
//    }else{//数字彩
//        return 100;
//    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    ExpertJingjiModel *supExMdl;
    if ([_superType isEqualToString:@"001"]) {
        if ([_lotteyType isEqualToString:@"-201"]) {
            supExMdl=[_jcSuperArr objectAtIndex:indexPath.row];
            [MobClick event:@"Zj_gaoshou_20161014_jingcai_fangan" label:supExMdl.EXPERTS_NICK_NAME];
        }else if([_lotteyType isEqualToString:@"201"]){
            supExMdl=[_ypSuperArr objectAtIndex:indexPath.row];
            [MobClick event:@"Zj_gaoshou_20161014_yapan_fangan" label:supExMdl.EXPERTS_NICK_NAME];
        }else if([_lotteyType isEqualToString:@"204"]){
            supExMdl=[_lcSuperArr objectAtIndex:indexPath.row];
            [MobClick event:@"Zj_gaoshou_20161014_lancai_fangan" label:supExMdl.EXPERTS_NICK_NAME];
        }
    }else if ([_superType isEqualToString:@"002"]) {
        supExMdl=[_szcSuperArr objectAtIndex:indexPath.row];
        [MobClick event:@"Zj_gaoshou_20161014_shuzicai_fangan" label:supExMdl.EXPERTS_NICK_NAME];
    }
    if ([_superType isEqualToString:@"001"]) {
        _segmentSelectFlags=YES;
    }else if([_superType isEqualToString:@"002"]){
        _segmentSelectFlags=NO;
    }
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
    [bodyDic setObject:@{@"expertsName":supExMdl.EXPERTS_NAME,@"expertsClassCode":_superType,@"loginUserName":nameSty,@"erAgintOrderId":supExMdl.ER_AGINT_ORDER_ID,@"type":@"0",@"sid":info.cbSID,@"lotteryClassCode":_lotteyType} forKey:@"parameters"];
    
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSLog(@"responseJSON=%@",responseJSON);
        SMGDetailViewController * vc=[[SMGDetailViewController alloc]init];
        
        //建模型，请求数据
        NSDictionary *dic=responseJSON[@"result"][@"expertBaseInfo"];
        ExpertBaseInfo *exBase=[ExpertBaseInfo  expertBaseInfoWithDic:dic];
        
        if (_segmentSelectFlags) {
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
            vc.planIDStr=supExMdl.ER_AGINT_ORDER_ID;
            vc.jcyplryType=_lotteyType;
        }else{
            NSArray *nPlanArr=responseJSON[@"result"][@"newPlanList_shuangSeQiu"];
            vc.SSQ_NP_ARR=[self newPlanArr:nPlanArr];
            
            nPlanArr=responseJSON[@"result"][@"newPlanList_daLeTou"];
            vc.DLT_NP_ARR=[self newPlanArr:nPlanArr];
            
            nPlanArr=responseJSON[@"result"][@"newPlanList_3D"];
            vc.FC3D_NP_ARR=[self newPlanArr:nPlanArr];
            
            nPlanArr=responseJSON[@"result"][@"newPlanList_PaiLie3"];
            vc.PL3_NP_ARR=[self newPlanArr:nPlanArr];
            
            NSArray *lPlanArr=responseJSON[@"result"][@"leastTenPlanList_shuangSeQiu"];
            vc.SSQ_LTP_ARR=[self ltplanArr:lPlanArr lottreryType:@"shuangSeQiu"];
            
            lPlanArr=responseJSON[@"result"][@"leastTenPlanList_daLeTou"];
            vc.DLT_LTP_ARR=[self ltplanArr:lPlanArr lottreryType:@"daLeTou"];
            
            lPlanArr=responseJSON[@"result"][@"leastTenPlanList_3D"];
            vc.FC3D_LTP_ARR=[self ltplanArr:lPlanArr lottreryType:@"3D"];
            
            lPlanArr=responseJSON[@"result"][@"leastTenPlanList_PaiLie3"];
            vc.PL3_LTP_ARR=[self ltplanArr:lPlanArr lottreryType:@"PaiLie3"];
            
            if([supExMdl.LOTTEY_CLASS_CODE isEqualToString:@"001"]){
                vc.lotryType=101;
            }else if([supExMdl.LOTTEY_CLASS_CODE isEqualToString:@"113"]){
                vc.lotryType=102;
            }else if([supExMdl.LOTTEY_CLASS_CODE isEqualToString:@"002"]){
                vc.lotryType=103;
            }else if([supExMdl.LOTTEY_CLASS_CODE isEqualToString:@"108"]){
                vc.lotryType=104;
            }
        }
        vc.exBaseInfo=exBase;
        vc.hidesBottomBarWhenPushed=YES;
        vc.segmentOnClickIndexFlags=_segmentSelectFlags;
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSError * error) {
        
    }];
}

//获取最新方案列表
- (NSArray *)newPlanArr:(NSArray *)newPlanArr{
    NSMutableArray *shuZiCaiArr=[NSMutableArray arrayWithCapacity:[newPlanArr count]];
    for (NSDictionary *dic in newPlanArr) {
        NewPlanListShuZiCai *newShuZiCai=[NewPlanListShuZiCai newPlanListShuZiCaiWithDic:dic];
        if ([newShuZiCai.closeStatus isEqualToString:@"1"]) {
            [shuZiCaiArr addObject:newShuZiCai];
        }
    }
    return shuZiCaiArr;
}

//获取最近十次方案列表
- (NSArray *)ltplanArr:(NSArray *)ltplanArr lottreryType:(NSString *)lottreryType{
    NSMutableArray *leastArr=[NSMutableArray arrayWithCapacity:[ltplanArr count]];
    for(NSDictionary *dic in ltplanArr) {
        if ([lottreryType isEqualToString:@"shuangSeQiu"]) {
            LeastTenPlanListShuangSeQiu *leastShuangSeQiu=[LeastTenPlanListShuangSeQiu leastTenPlanListShuangSeQiuWithDic:dic];
            [leastArr addObject:leastShuangSeQiu];
        }else if([lottreryType isEqualToString:@"daLeTou"]){
            LeastTenPlanListDaLeTou *leastShuangSeQiu=[LeastTenPlanListDaLeTou leastTenPlanListDaLeTouWithDic:dic];
            [leastArr addObject:leastShuangSeQiu];
        }else if([lottreryType isEqualToString:@"3D"]){
            LeastTenPlanList_3D_PaiLie3 *leastShuangSeQiu=[LeastTenPlanList_3D_PaiLie3 leastTenPlanList_3D_PaiLie3WithDic:dic];
            [leastArr addObject:leastShuangSeQiu];
        }else if([lottreryType isEqualToString:@"PaiLie3"]){
            LeastTenPlanList_3D_PaiLie3 *leastShuangSeQiu=[LeastTenPlanList_3D_PaiLie3 leastTenPlanList_3D_PaiLie3WithDic:dic];
            [leastArr addObject:leastShuangSeQiu];
        }
    }
    return leastArr;
}

/**
 *  获取专家列表
 */
-(void)supCurPage:(NSString *)curPage superType:(NSString *)superType lotryType:(NSString *)lotryType
{
    if (_bpview) {
        [_bpview removeFromSuperview];
    }
    if ([superType isEqualToString:@"001"]) {
        if ([lotryType isEqualToString:@"-201"] && _jcSuperArr.count == 0) {
            if ([curPage isEqualToString:@"1"]) {
                [self createIfNoHave];
            }
        }else if([lotryType isEqualToString:@"201"] && _ypSuperArr.count == 0){
            if ([curPage isEqualToString:@"1"]) {
                [self createIfNoHave];
            }
        }else if([lotryType isEqualToString:@"204"] && _lcSuperArr.count == 0){
            if ([curPage isEqualToString:@"1"]) {
                [self createIfNoHave];
            }
        }
    }else if([superType isEqualToString:@"002"] && _szcSuperArr.count == 0){
        if ([curPage isEqualToString:@"1"]) {
            [self createIfNoHave];
        }
    }
    
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    if ([_superType isEqualToString:@"001"]) {
        _segmentSelectFlags=YES;
    }else if([_superType isEqualToString:@"002"]){
        _segmentSelectFlags=NO;
    }
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"zjtjIndexService" forKey:@"serviceName"];
    [bodyDic setObject:@"getMasterPlanList" forKey:@"methodName"];
    NSDictionary * parametersDic=@{@"userName":nameSty,@"expertClassCode":superType,@"lotteyClassCode":lotryType,@"orderFlag":_orderFlag,@"curPage":curPage,@"pageSize":@"20",@"levelType":@"1",@"sid":[[Info getInstance] cbSID]};

    [bodyDic setObject:parametersDic forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON objectForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray *arr=responseJSON[@"result"][@"data"];
            if ([curPage intValue]==1) {
                if ([superType isEqualToString:@"001"]) {
                    if ([lotryType isEqualToString:@"-201"]) {
                        _jcSuperArr=nil;
                        _jcSuperArr=[NSMutableArray arrayWithCapacity:[arr count]];
                    }else if([lotryType isEqualToString:@"201"]){
                        _ypSuperArr=nil;
                        _ypSuperArr=[NSMutableArray arrayWithCapacity:[arr count]];
                    }else if([lotryType isEqualToString:@"204"]){
                        _lcSuperArr=nil;
                        _lcSuperArr=[NSMutableArray arrayWithCapacity:[arr count]];
                    }
                }else if([superType isEqualToString:@"002"]){
                    _szcSuperArr=nil;
                    _szcSuperArr=[NSMutableArray arrayWithCapacity:[arr count]];
                }
            }
            if (arr&&[arr count]!=0) {
                if (_bpview) {
                    [_bpview removeFromSuperview];
                }
                for (NSDictionary *dic in arr) {
                    ExpertJingjiModel *supExMdl=[ExpertJingjiModel expertJingjiWithDic:dic];
                    if ([superType isEqualToString:@"001"]) {
                        if ([lotryType isEqualToString:@"-201"]) {
                            [_jcSuperArr addObject:supExMdl];
                        }else if([lotryType isEqualToString:@"201"]){
                            [_ypSuperArr addObject:supExMdl];
                        }else if([lotryType isEqualToString:@"204"]){
                            [_lcSuperArr addObject:supExMdl];
                        }
                    }else if([superType isEqualToString:@"002"]){
                        [_szcSuperArr addObject:supExMdl];
                    }
                }
                if ([curPage intValue]>1) {
                    if ([superType isEqualToString:@"001"]) {
                        if ([lotryType isEqualToString:@"-201"]) {
                            _jcCurrPage++;
                        }else if([lotryType isEqualToString:@"201"]){
                            _ypCurrPage++;
                        }else if([lotryType isEqualToString:@"204"]){
                            _lcCurrPage++;
                        }
                    }else if([superType isEqualToString:@"002"]){
                        _szcCurrPage++;
                    }
                }
            }else{
                //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"没有更多啦" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                //[alert show];
                //[self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
                if ([curPage isEqualToString:@"1"]) {
                    if (_bpview) {
                        [_bpview removeFromSuperview];
                    }
                    [self createIfNoHave];
                }
            }
            if ([superType isEqualToString:@"001"]) {
                if ([lotryType isEqualToString:@"-201"]) {
                    [jcListView reloadData];
                }else if([lotryType isEqualToString:@"201"]){
                    [ypListView reloadData];
                }else if([lotryType isEqualToString:@"204"]){
                    [lcListView reloadData];
                }
            }else if([superType isEqualToString:@"002"]){
                [szcListView reloadData];
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [jcListView.header endRefreshing];
            [jcListView.footer endRefreshing];
            [ypListView.header endRefreshing];
            [ypListView.footer endRefreshing];
            [szcListView.header endRefreshing];
            [szcListView.footer endRefreshing];
            [lcListView.header endRefreshing];
            [lcListView.footer endRefreshing];
        });
        
    } failure:^(NSError * error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [jcListView.header endRefreshing];
            [jcListView.footer endRefreshing];
            [ypListView.header endRefreshing];
            [ypListView.footer endRefreshing];
            [szcListView.header endRefreshing];
            [szcListView.footer endRefreshing];
            [lcListView.header endRefreshing];
            [lcListView.footer endRefreshing];
        });
    }];
}

/**
 *  UIAlertView自动消失处理代码
 */
-(void)dimissAlert:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}

#pragma mark -  如果没有发布方案的时候 提示用户发布方案啊、
-(void)createIfNoHave
{
    _bpview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyWidth, _scrollView.frame.size.height)];
    _bpview.backgroundColor = [UIColor clearColor];
    if ([_superType isEqualToString:@"001"]) {
        if ([_lotteyType isEqualToString:@"-201"]) {
            [jcListView addSubview:_bpview];
        }else if([_lotteyType isEqualToString:@"201"]){
            [ypListView addSubview:_bpview];
        }else if([_lotteyType isEqualToString:@"204"]){
            [lcListView addSubview:_bpview];
        }
    }else if([_superType isEqualToString:@"002"]){
        [szcListView addSubview:_bpview];
    }
    
    UIImage *image=[UIImage imageNamed:@"暂无最新推荐"];
    UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake((MyWidth-image.size.width)/2,30,image.size.width,image.size.height)];
    [imgV setImage:image];
    [_bpview addSubview:imgV];
}


#pragma mark ---------------刷新-------------

- (void)setupRefresh
{
    // 下拉刷新
    jcListView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:jcListView.header];
    
    // 上拉加载
    jcListView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:jcListView.footer];
    
    ypListView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:ypListView.header];
    
    // 上拉加载
    ypListView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:ypListView.footer];
    
    szcListView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:szcListView.header];
    
    // 上拉加载
    szcListView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:szcListView.footer];
    
    
    lcListView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:lcListView.header];
    
    // 上拉加载
    lcListView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:lcListView.footer];
    
}

#pragma mark ----------开始进入刷新状态----------

- (void)NearheaderRereshing
{
    if ([_superType isEqualToString:@"001"]) {
        if ([_lotteyType isEqualToString:@"-201"]) {
            _jcCurrPage =1;
        }else if([_lotteyType isEqualToString:@"201"]){
            _ypCurrPage =1;
            [self getErchuanyiExpertRequestWithPage:@"1"];
            return;
        }else if([_lotteyType isEqualToString:@"204"]){
            _lcCurrPage =1;
        }
    }else if([_superType isEqualToString:@"002"]){
        _szcCurrPage =1;
    }
    [self supCurPage:@"1" superType:_superType lotryType:_lotteyType];
}

#pragma mark -------------加载-------------------

- (void)NearfooterRereshing
{
    NSInteger curPage=1;
    if ([_superType isEqualToString:@"001"]) {
        if ([_lotteyType isEqualToString:@"-201"]) {
            curPage=_jcCurrPage+1;
        }else if([_lotteyType isEqualToString:@"201"]){
            curPage=_ypCurrPage+1;
            [self getErchuanyiExpertRequestWithPage:[NSString stringWithFormat:@"%ld",(long)curPage]];
            return;
        }else if([_lotteyType isEqualToString:@"204"]){
            curPage=_lcCurrPage+1;
        }
    }else if([_superType isEqualToString:@"002"]){
        curPage=_szcCurrPage+1;
    }
    [self supCurPage:[NSString stringWithFormat:@"%ld",(long)curPage] superType:_superType lotryType:_lotteyType];
}

- (void)backClick:(id)sender{
    if ([self.navigationController isKindOfClass:[MLNavigationController class]]) {
        MLNavigationController *nlnav=(MLNavigationController *)self.navigationController;
        nlnav.canDragBack=YES;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backaction" object:self];
}

#define mark -----------UIScrollViewDelegate------------------

- (void)setScrollContent{
    CGPoint offset=_scrollView.contentOffset;
    if (offset.x<MyWidth/2) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (offset.x>=MyWidth/2&&offset.x<MyWidth*3/2) {
        [_scrollView setContentOffset:CGPointMake(MyWidth, 0) animated:YES];
    }
//    else if (offset.x>=MyWidth/2&&offset.x<MyWidth*3/2) {
    else if (offset.x>=MyWidth*3/2&&offset.x<MyWidth*5/2) {
        [_scrollView setContentOffset:CGPointMake(MyWidth*2, 0) animated:YES];
    }else{
        [_scrollView setContentOffset:CGPointMake(3*MyWidth, 0) animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"1111");
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"2222");
    [self setScrollContent];
    CGPoint offset=_scrollView.contentOffset;
    if (offset.x<MyWidth/2) {
        _superType=@"001";
        _lotteyType=@"-201";
        _superJCBtn.selected=YES;
        _superLCBtn.selected=NO;
        _superYPBtn.selected=NO;
        _superSZCBtn.selected=NO;
        _orderFlag=_jcOrderFlag;
        if (!_jcSuperArr) {
            [self supCurPage:@"1" superType:_superType lotryType:_lotteyType];
        }
        [jcListView reloadData];
    }else if (offset.x>=MyWidth/2&&offset.x<MyWidth*3/2) {
        _superType=@"001";
        _lotteyType=@"204";
        _superJCBtn.selected=NO;
        _superLCBtn.selected=YES;
        _superYPBtn.selected=NO;
        _superSZCBtn.selected=NO;
        _orderFlag=@"";
        if (!_lcSuperArr) {
            [self supCurPage:@"1" superType:@"001" lotryType:@"204"];
        }
        [lcListView reloadData];
    }
//    else if (offset.x>=MyWidth/2&&offset.x<MyWidth*3/2) {
    else if (offset.x>=MyWidth*3/2&&offset.x<MyWidth*5/2) {
        _superType=@"001";
        _lotteyType=@"201";
        _superJCBtn.selected=NO;
        _superLCBtn.selected=NO;
        _superYPBtn.selected=YES;
        _superSZCBtn.selected=NO;
        _orderFlag=_ypOrderFlag;
        if (!_ypSuperArr) {
//            [self supCurPage:@"1" superType:@"001" lotryType:@"201"];
            [self getErchuanyiExpertRequestWithPage:@"1"];
        }
        [ypListView reloadData];
    }else{
        _superType=@"002";
        _lotteyType=_szclotryType;
        _superJCBtn.selected=NO;
        _superLCBtn.selected=NO;
        _superYPBtn.selected=NO;
        _superSZCBtn.selected=YES;
        _orderFlag=_szcOrderFlag;
        if (!_szcSuperArr) {
            [self supCurPage:@"1" superType:_superType lotryType:_lotteyType];
        }
        [szcListView reloadData];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"3333");
    [self setScrollContent];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"4444");
    [self setScrollContent];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"5555");
}
-(void)toLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
}
-(void)getIsBuyInfoWithOrderID:(ExpertJingjiModel *)model{
    
    Info *info = [Info getInstance];
    if (![info.userId intValue]){
        [self toLogin];
        return;
    }
    erAgintOrderId = model.ER_AGINT_ORDER_ID;
    [MobClick event:@"Zj_fangan_20161014_jingcai_fangan" label:[NSString stringWithFormat:@"%@VS%@",model.HOME_NAME,model.AWAY_NAME]];
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"verifyIsBuyPlanByUserNameErAgintOrderId" forKey:@"methodName"];
    [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"er_agint_order_id":model.ER_AGINT_ORDER_ID} forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSLog(@"responseJSON=%@",responseJSON);
        NSDictionary *dict = responseJSON[@"result"];//返回编码: 0000：已经购买; 0400:没有购买
        if ([[dict valueForKey:@"code"] isEqualToString:@"0000"]) {
            
            ProjectDetailViewController *proVC=[[ProjectDetailViewController alloc] init];
            proVC.erAgintOrderId=model.ER_AGINT_ORDER_ID;
            proVC.pdLotryType = model.LOTTEY_CLASS_CODE;
            proVC.isSdOrNo=NO;
            [self.navigationController pushViewController:proVC animated:YES];
            
        }else if([[dict valueForKey:@"code"] isEqualToString:@"0400"]){
            [self addDealPurchaseTicket:model.PRICE tag:601];
        }
    } failure:^(NSError * error) {
        
    }];
}
- (void)addDealPurchaseTicket:(float)str tag:(NSInteger)tag{
#ifdef CRAZYSPORTS
    int jinbibeishu = 10;//金币和钱比例
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"]) {
        jinbibeishu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"] intValue];
    }
    CP_UIAlertView *_cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付"
                                                             message:[NSString stringWithFormat:@"您将支付(%.0f金币)购买此方案内容",str * jinbibeishu]
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"确定", nil];
#else
    CP_UIAlertView *_cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付"
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
                if (0) {
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
                            }
                            else if([[[responseJSON objectForKey:@"result"] objectForKey:@"code"] isEqualToString:@"0301"]){
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
        if([_lotteyType isEqualToString:@"204"]){
            proVC.pdLotryType=@"204";
        }
        proVC.isSdOrNo=NO;
        //        _nPlanBtn.paidStatus=@"1";
        [self.navigationController pushViewController:proVC animated:YES];
    }
}
-(void)getErchuanyiExpertRequestWithPage:(NSString *)page{
    
    /*
     喂饼广场：type = 0   lotteyClassCode = -201   orderFlag = 0用户等级  orderFlag = 1发布时间   竞足
     lotteyClassCode = 201    二串一
     
     最近红人：type = 1    orderFlag = 2 lotteyClassCode = -201竞足
     orderFlag = 3 lotteyClassCode = 201二串一
     */
    if (_bpview) {
        [_bpview removeFromSuperview];
    }
    if(_ypSuperArr.count == 0){
        if ([page isEqualToString:@"1"]) {
            [self createIfNoHave];
        }
    }
    
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    if ([_superType isEqualToString:@"001"]) {
        _segmentSelectFlags=YES;
    }else if([_superType isEqualToString:@"002"]){
        _segmentSelectFlags=NO;
    }
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"sid":[[Info getInstance] cbSID],
                                                                                       @"userName":nameSty,
                                                                                       @"expertClassCode":@"001",//
                                                                                       @"lotteryClassCode":@"201",
                                                                                       @"type":@"0",//
                                                                                       @"orderFlag":@"1",//
                                                                                       @"curPage":page,
                                                                                       @"pageSize":@"20"}];
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getCrazySportMasterPlanList",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[[responseJSON valueForKey:@"result"] valueForKey:@"data"];
            
            if ([page intValue]==1) {
                _ypSuperArr=nil;
                _ypSuperArr=[NSMutableArray arrayWithCapacity:[result count]];
            }
            
            if (result&&[result count]!=0) {
                
                if (_bpview) {
                    [_bpview removeFromSuperview];
                }
                
                NSMutableArray *ary = [self reloadArrayWithAry:result];
                
                [_ypSuperArr addObjectsFromArray:ary];
                _ypCurrPage++;
                
                [ypListView reloadData];
            }else {
                if (_bpview) {
                    [_bpview removeFromSuperview];
                }
                if ([page isEqualToString:@"1"]) {
                    [self createIfNoHave];
                }
            }
        }else{
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [jcListView.header endRefreshing];
            [jcListView.footer endRefreshing];
            [ypListView.header endRefreshing];
            [ypListView.footer endRefreshing];
            [szcListView.header endRefreshing];
            [szcListView.footer endRefreshing];
            [lcListView.header endRefreshing];
            [lcListView.footer endRefreshing];
        });
    } failure:^(NSError * error) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [jcListView.header endRefreshing];
            [jcListView.footer endRefreshing];
            [ypListView.header endRefreshing];
            [ypListView.footer endRefreshing];
            [szcListView.header endRefreshing];
            [szcListView.footer endRefreshing];
            [lcListView.header endRefreshing];
            [lcListView.footer endRefreshing];
        });
    }];
}
-(NSMutableArray *)reloadArrayWithAry:(NSArray *)ary{
    
    NSMutableArray *arym = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSDictionary * dic in ary) {
        ExpertJingjiModel *model = [[ExpertJingjiModel alloc]init];
        model.ALL_HIT_NUM = [dic valueForKey:@"ALL_HIT_NUM"];
        model.AWAY_NAME = [dic valueForKey:@"AWAY_NAME1"];
        model.DIS_HIT_NUM = [dic valueForKey:@"DIS_HIT_NUM"];
        model.ER_AGINT_ORDER_ID = [dic valueForKey:@"ER_AGINT_ORDER_ID"];
        model.ER_ISSUE = [dic valueForKey:@"ER_ISSUE"];
        model.EXPERTS_CLASS_CODE = [dic valueForKey:@"EXPERTS_CLASS_CODE"];
        model.EXPERTS_NAME = [dic valueForKey:@"EXPERTS_NAME"];
        model.EXPERTS_NICK_NAME = [dic valueForKey:@"EXPERTS_NICK_NAME"];
        model.FREE_STATUS = [[dic valueForKey:@"FREE_STATUS"] integerValue];
        model.HEAD_PORTRAIT = [dic valueForKey:@"HEAD_PORTRAIT"];
        model.HIT_NUM = [dic valueForKey:@"HIT_NUM"];
        model.HOME_NAME = [dic valueForKey:@"HOME_NAME1"];
        model.IS_NEW = [dic valueForKey:@"IS_NEW"];
        model.LEAGUE_NAME = [dic valueForKey:@"LEAGUE_NAME1"];
        model.LEVEL_VALUE = [dic valueForKey:@"LEVEL_VALUE"];
        model.LOTTEY_CLASS_CODE = [dic valueForKey:@"LOTTEY_CLASS_CODE"];
        model.MATCHES_ID = [dic valueForKey:@"MATCHES_ID1"];
        model.MATCH_STATUS = [dic valueForKey:@"MATCH_STATUS1"];
        model.MATCH_TIME = [dic valueForKey:@"MATCH_TIME1"];
        model.PLAY_ID = [dic valueForKey:@"PLAY_ID1"];
        model.PRICE = [[dic valueForKey:@"PRICE"] floatValue];
        model.SOURCE = [[dic valueForKey:@"SOURCE"] integerValue];
        model.STAR = [[dic valueForKey:@"STAR"] integerValue];
        model.DISCOUNT = [[dic valueForKey:@"DISCOUNT"] floatValue];
        model.PLAY_ID2 = [dic valueForKey:@"PLAY_ID2"];
        model.HOME_NAME2 = [dic valueForKey:@"HOME_NAME2"];
        model.AWAY_NAME2 = [dic valueForKey:@"AWAY_NAME2"];
        model.MATCH_TIME2 = [dic valueForKey:@"MATCH_TIME2"];
        model.MATCH_STATUS2 = [dic valueForKey:@"MATCH_STATUS2"];
        model.MATCHES_ID2 = [dic valueForKey:@"MATCHES_ID2"];
        model.LEAGUE_NAME2 = [dic valueForKey:@"LEAGUE_NAME2"];
        
        model.MATCH_DATE2 = [dic valueForKey:@"MATCH_DATE2"];
        model.MATCH_DATA_TIME2 = [dic valueForKey:@"MATCH_DATA_TIME2"];
        
        [arym addObject:model];
        //        [arym addObject:[ExpertMainListModel expertListWithDic:dic]];
    }
    
    return arym;
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    