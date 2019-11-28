//
//  ExpertViewController.m
//  Experts
//
//  Created by V1pin on 15/10/26.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "ExpertViewController.h"
#import "LoginViewController.h"
#import "MLNavigationController.h"
#import "ExpertCustomVC.h"
#import "SMGDetailViewController.h"
#import "CommonProblemViewController.h"
#import "SearchVC.h"
#import "GqRecVc.h"
#import "MatchDetailVC.h"
#import "ExpertDetailCell.h"
#import "ExpertJingjiModel.h"
#import "NSString+ExpertStrings.h"

#import "caiboAppDelegate.h"
#import "UpLoadView.h"
//#import "OY_AllItemsViewController.h"
#import "LiveScoreViewController.h"
//#import "GameCenterViewController.h"
//#import "JingCaiYouXiViewController.h"
#import "UIColor+Extension.h"
#import "UIImageView+WebCache.h"
#import "MobClick.h"
#import "MyConcernVc.h"
#import "ExpertMainListTableViewCell.h"
#import "ProjectDetailViewController.h"
#import "Expert365Bridge.h"

#define LISTTABLETAG 333

static const int EVENTNAME=800;
static const int PARTIESOFEVENT=801;
static const int EVENTTIME=802;
static const int EVENTNUM=803;

@interface ExpertViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,ASIHTTPRequestDelegate>{
    
@private NSMutableArray *tagNewAry;
    NSTimer *timer;
    NSInteger currentPage;
    
    UIView *bgSegment;
//    UISegmentedControl *segmentCT;
    UITableView *_tableView;
    
    NSInteger jCPageNum;
    NSInteger ypPageNum;
    NSInteger szcPageNum;
    NSInteger lcPageNum;
    
    NSMutableArray * _photoImageArr;
    UpLoadView *loadview;
    
    ASIHTTPRequest *_pointRequest;
    
    NSMutableArray *toutiaoH5URLArym;
    
    NSString *erAgintOrderId;
}

@property(nonatomic,strong) ASIHTTPRequest *pointRequest;
@property(nonatomic,strong) UIView *dgqBgView;
@property(nonatomic,strong) UIImageView *olympicXcView;

@property(nonatomic,strong) UIView *gqView;
@property(nonatomic,strong) UIView *recHeadView;

@property(nonatomic,strong) UIScrollView *scrollView,*zhuanjiaScro;
@property(nonatomic,strong) UIPageControl *pageControl;
//@property(nonatomic,strong) UIImageView *preImgView;
//@property(nonatomic,strong) UIImageView *curImgView;
//@property(nonatomic,strong) UIImageView *nexImgView;

@property(nonatomic,strong) UIView *categoryView,*sixbtnBGView,*toutiaoView;

@property(nonatomic,strong) UIView *headPortView;

@property(nonatomic,strong) UIImageView *slidSwImgView;
@property(nonatomic,strong) UIButton *jcBtn;
@property(nonatomic,strong) UIButton *ypBtn;
@property(nonatomic,strong) UIButton *szcBtn;
@property(nonatomic,strong) UIButton *lcBtn;

@property(nonatomic,strong) UIView *noReconView;

@property(nonatomic,retain) NSMutableArray *adImgArr;
@property(nonatomic,strong) NSMutableArray *focusArr;

//@property(nonatomic,assign) NSInteger currentIndex;
@property(nonatomic,strong) NSString *jcTotalPg;
@property(nonatomic,strong) NSString *ypTotalPg;
@property(nonatomic,strong) NSString *szcTotalPg;
@property(nonatomic,strong) NSString *lcTotalPg;

@property(nonatomic,copy) NSMutableArray * szcExpList;
@property(nonatomic,copy) NSMutableArray * jcExpList;
@property(nonatomic,copy) NSMutableArray * ypExpList;
@property(nonatomic,copy) NSMutableArray * lcExpList;

//竞足和数字彩的详情标志
@property(nonatomic,assign)BOOL segmentSelectFlags;

@property(nonatomic,strong) DgqOlympicMdl *dgqOlympicMdl;//懂个球奥运宣传位palyId;
@property(nonatomic,strong) NSString *firstUrl;//滚球推荐链接;
@property(nonatomic,strong) NSString *secondUrl;//滚球推荐链接;

@end

@implementation ExpertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    toutiaoH5URLArym = [[NSMutableArray alloc]initWithCapacity:0];
    
#if !defined YUCEDI && !defined DONGGEQIU
    [self creatNavView];
#endif
    
    _lotteryType=@"001";
    _expLoType=@"-201";
    _isfromYiGou=NO;
    _segmentSelectFlags=YES;
#if !defined DONGGEQIU
    self.title_nav = @"专家推荐";
#else
    UIImageView *naviBarIconImgView=[[UIImageView alloc] initWithFrame:CGRectMake((MyWidth-84.5)/2, HEIGHTBELOESYSSEVER+44-37.5, 84.5, 30.5)];
    naviBarIconImgView.image=[UIImage imageNamed:@"navBarIcon"];
    [self.navView addSubview:naviBarIconImgView];
#endif
    tagNewAry=[NSMutableArray arrayWithObjects:@"0", @"0", @"0", @"0", nil];
    
    UIImage *searchImage=[UIImage imageNamed:@"椭圆"];//添加搜索按钮
    [self rightImgAndAction:searchImage target:self action:@selector(searchBtn:)];
    [self.rightBtn setImageEdgeInsets:UIEdgeInsetsMake(HEIGHTBELOESYSSEVER+12, 25, 32-searchImage.size.height, 35-searchImage.size.width)];
    
    _recHeadView=[[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, 100)];
    _recHeadView.backgroundColor=[UIColor colorWithHexString:@"ecedf1"];
    [self.view addSubview:_recHeadView];
    
//    [self creatScrollView];
    [self creatSixButton];
    [self creatZhuanjiaScrollView];
    
#if defined DONGGEQIU
    [self creaDgqView];
    [self creatOlympicView];
#endif
    
#if defined YUCEDI
    [self creatCategoryView];
#endif
    
//    [self creatHeadPort];
    [self creatToutiaoView];
    
#if !defined DONGGEQIU
    [self creatGqView];
#endif
    
    [self creatSegmentView];
    
    [self creatExpTabView];
    
    [self setupRefresh];
    
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    
    jCPageNum = 1;
    ypPageNum=1;
    szcPageNum = 1;
    lcPageNum = 1;
    
#if defined DONGGEQIU
    [self getDgqGq];
    [self getDgqOlympic];
#endif
    
#if !defined DONGGEQIU
    [self getGqPicture];
#endif
    
    [self getExpertList:@"1"];
    [self getManySeniorExpertRequest];//获取好多资深专家
    [self getToutiaoRequest];//获取头条
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollImg) userInfo:nil repeats:YES];
    if ([_lotteryType isEqualToString:@"001"]) {
        //segmentCT.selectedSegmentIndex=0;
        _segmentSelectFlags=YES;
    }else if ([_lotteryType isEqualToString:@"002"]){
        //segmentCT.selectedSegmentIndex=1;
        _segmentSelectFlags=NO;
    }
    if (_isfromYiGou) {
        jCPageNum = 1;
        ypPageNum=1;
        szcPageNum = 1;
        lcPageNum = 1;
        if ([_lotteryType isEqualToString:@"001"]) {
            if ([_expLoType isEqualToString:@"-201"]) {
                [self btnLotteryTypeClick:_jcBtn];
            }else if ([_expLoType isEqualToString:@"201"]){
                [self btnLotteryTypeClick:_ypBtn];
            }else if ([_expLoType isEqualToString:@"204"]){
                [self btnLotteryTypeClick:_lcBtn];
            }
        }else if ([_lotteryType isEqualToString:@"002"]){
            [self btnLotteryTypeClick:_szcBtn];
        }
    }
    
    for (int i=0; i<4; i++) {
        for (UIView *view in [_recHeadView subviews]) {
            if (view.tag==100+i) {
                view.userInteractionEnabled=NO;
                for (UIView *imgV in [view subviews]) {
                    if (imgV.tag==500+i) {
                        UIImageView *newPlanTag=(UIImageView *)imgV;
                        if ([[tagNewAry objectAtIndex:i] isEqualToString:@"0"]) {
                            newPlanTag.hidden=YES;
                        }else
                            newPlanTag.hidden=NO;
                    }
                }
            }
        }
    }
    
//    [self scrImgReData];
//    [self getFocusExpert];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if ([timer isValid]) {
        [timer invalidate];
        timer = nil;
    }
}

#pragma mark -------上面6个按钮----------
- (void)creatSixButton{
    
    NSArray *imageAry = [NSArray arrayWithObjects:
                         @"zhuanjia_TVpresenter.png",
                         @"zhuanjia_reporter.png",
                         @"zhuanjia_footballer.png",
                         @"zhuanjia_expert.png",
                         @"zhuanjia_redOne.png",
                         @"zhuanjia_ace.png", nil];
    NSArray *titleAry = [NSArray arrayWithObjects:
                         @"TV名嘴",
                         @"媒体记者",
                         @"足球名将",
                         @"彩票专家",
                         @"连红牛人",
                         @"民间高手", nil];
    CGSize size = self.view.frame.size;
    _sixbtnBGView = [[UIView alloc]init];
    _sixbtnBGView.frame = CGRectMake(0, 0, size.width, 80);
    _sixbtnBGView.backgroundColor = [UIColor whiteColor];
    [_recHeadView addSubview:_sixbtnBGView];
    
    CGFloat width = size.width/3.0;
    for(NSInteger i=0;i<6;i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0+(i%3)*width, 0+(i/3)*40, width, 40);
        btn.tag = i;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(sixButtonActionToSearch:) forControlEvents:UIControlEventTouchUpInside];
        [_sixbtnBGView addSubview:btn];
        
        UIImageView *ima = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 20, 20)];
        ima.backgroundColor = [UIColor clearColor];
        ima.layer.masksToBounds=YES;
        
        ima.layer.cornerRadius=10.0;
        ima.image = [UIImage imageNamed:[imageAry objectAtIndex:i]];
        [btn addSubview:ima];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, width-35, 20)];
        lab.backgroundColor = [UIColor clearColor];
        lab.text = [titleAry objectAtIndex:i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:12];
        lab.alpha = 0.87;
        [btn addSubview:lab];
        
        UIImageView *lineIma1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, btn.frame.size.height-0.5, btn.frame.size.width, 0.5)];
        lineIma1.backgroundColor = SEPARATORCOLOR;
        [btn addSubview:lineIma1];
        UIImageView *lineIma2 = [[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.size.width, 0, 0.5, btn.frame.size.height)];
        lineIma2.backgroundColor = SEPARATORCOLOR;
        [btn addSubview:lineIma2];
    }
    UIImageView *lineIma = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, 0.5)];
    lineIma.backgroundColor = SEPARATORCOLOR;
    [_sixbtnBGView addSubview:lineIma];
}
-(void)creatZhuanjiaScrollView{
    
    CGSize size = self.view.frame.size;
    
    if(!_zhuanjiaScro){
        
        _zhuanjiaScro=[[UIScrollView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(_sixbtnBGView), size.width, 230)];
        _zhuanjiaScro.delegate=self;
        _zhuanjiaScro.bounces=NO;
        _zhuanjiaScro.contentSize=CGSizeMake(size.width, 220);
        _zhuanjiaScro.backgroundColor=[UIColor whiteColor];
        _zhuanjiaScro.pagingEnabled=YES;
        _zhuanjiaScro.showsHorizontalScrollIndicator=NO;
        [_recHeadView addSubview:_zhuanjiaScro];
        
        _pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(_zhuanjiaScro.frame.size.width/2-50, ORIGIN_Y(_zhuanjiaScro)-30, 100, 30)];
        _pageControl.numberOfPages=0;
        //    _pageControl.backgroundColor=[UIColor clearColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0/255.0 green:137/255.0 blue:212/255.0 alpha:1];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0/255.0 green:137/255.0 blue:212/255.0 alpha:0.5];
        _pageControl.currentPage=0;
        [_pageControl addTarget:self action:@selector(pageValueChange:) forControlEvents:UIControlEventValueChanged];
        [_recHeadView addSubview:_pageControl];
    }
    if(_focusArr.count){
        
        CGFloat width = size.width/4.0;
        NSInteger page = _focusArr.count/8 + (_focusArr.count % 8 ? 1 : 0);
        _zhuanjiaScro.contentSize=CGSizeMake(size.width*page, 220);
        _pageControl.numberOfPages=page;
        for(NSInteger i=0;i<page;i++){
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(size.width * i, 0, size.width, 220)];
            view.backgroundColor = [UIColor clearColor];
            [_zhuanjiaScro addSubview:view];
            NSInteger p = 8;
            if(i == page - 1){
                p = _focusArr.count % 8 ? _focusArr.count % 8 : 8;
            }
            for(NSInteger j=0;j<p;j++){
                
                ExpertJingjiModel *expertModel=[_focusArr objectAtIndex:i*8+j];
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(0+(j%4)*width, (j/4)*95, width, 98);
                btn.backgroundColor = [UIColor clearColor];
                btn.tag = 123+i*8+j;
                [btn addTarget:self action:@selector(manySeniorExpertClick:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
                
                UIImageView *headIma = [[UIImageView alloc]init];
                headIma.frame = CGRectMake((width - 40)/2.0, 15, 40, 40);
                headIma.backgroundColor = [UIColor clearColor];
                headIma.layer.masksToBounds = YES;
                headIma.layer.cornerRadius = 20;
                headIma.tag = 1;
//                headIma.image = [UIImage imageNamed:@"默认头像"];
                [headIma sd_setImageWithURL:[NSURL URLWithString:expertModel.headPortrait] placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageContinueInBackground|SDWebImageRetryFailed];
                [btn addSubview:headIma];
                
                UIImageView *professionalIma = [[UIImageView alloc]init];
                professionalIma.frame = CGRectMake((width - 52)/2.0, 50, 52, 14);
                professionalIma.backgroundColor = [UIColor clearColor];
                professionalIma.tag = 2;
                professionalIma.image = [UIImage imageNamed:@"zhuanjia_professional.png"];
                [btn addSubview:professionalIma];
                UILabel *professionalLab = [[UILabel alloc]init];
                professionalLab.frame = CGRectMake(0, 0, 52, 14);;
                professionalLab.text = @"资深专家";
                if(expertModel.labelName.length && ![expertModel.labelName isEqualToString:@"null"]){
                    
                    professionalLab.text = expertModel.labelName;
                }
                professionalLab.textAlignment = NSTextAlignmentCenter;
                professionalLab.font = [UIFont systemFontOfSize:11];
                professionalLab.textColor=[UIColor colorWithHexString:@"1588DA"];
                [professionalIma addSubview:professionalLab];
                
                UIImageView *miniIma = [[UIImageView alloc]init];
                miniIma.frame = CGRectMake(ORIGIN_X(professionalIma)-13, professionalIma.frame.origin.y-10, 10, 10);
                miniIma.backgroundColor = [UIColor clearColor];
//                miniIma.image = [UIImage imageNamed:@"zhuanjia_ace.png"];
                [miniIma sd_setImageWithURL:[NSURL URLWithString:expertModel.labelPic]];
                [btn addSubview:miniIma];
                
                UILabel *nameLab = [[UILabel alloc]init];
                nameLab.frame = CGRectMake(0, ORIGIN_Y(professionalIma)+4, btn.frame.size.width, 15);
                nameLab.font = [UIFont systemFontOfSize:11];
                nameLab.backgroundColor = [UIColor clearColor];
                nameLab.textAlignment = NSTextAlignmentCenter;
//                nameLab.text = @"孙继海";
                nameLab.text = expertModel.expertsNickName;
                nameLab.tag = 3;
                nameLab.alpha = 0.87;
                [btn addSubview:nameLab];
                
                UILabel *recordLab = [[UILabel alloc]init];
                recordLab.frame = CGRectMake(0, ORIGIN_Y(nameLab), btn.frame.size.width, 15);
                recordLab.font = [UIFont systemFontOfSize:10];
                recordLab.backgroundColor = [UIColor clearColor];
                recordLab.textAlignment = NSTextAlignmentCenter;
//                recordLab.text = @"近3中3";
                recordLab.text = [NSString stringWithFormat:@"近%@中%@",expertModel.totalNum,expertModel.hitNum];
                recordLab.tag = 4;
                recordLab.alpha = 0.7;
                [btn addSubview:recordLab];
                
                [view addSubview:btn];
            }
        }
    }
}
-(void)creatToutiaoView{
    
    CGSize size = self.view.frame.size;
    
    CGFloat yFrame=0.0;
#if defined YUCEDI
    yFrame=ORIGIN_Y(_categoryView);
#else
    yFrame=ORIGIN_Y(_zhuanjiaScro);
#endif
    
    _toutiaoView = [[UIView alloc]initWithFrame:CGRectMake(0, yFrame, size.width, 127)];
    _toutiaoView.backgroundColor = [UIColor clearColor];
    [_recHeadView addSubview:_toutiaoView];
    
    UIView *upView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, 55)];
    upView.backgroundColor = [UIColor whiteColor];
    [_toutiaoView addSubview:upView];
    
    UIImageView *lineIma1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, 0.5)];
    lineIma1.backgroundColor = SEPARATORCOLOR;
    [upView addSubview:lineIma1];
    
    UIImageView *toutiaoIma = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 35, 35)];
    toutiaoIma.backgroundColor = [UIColor clearColor];
    toutiaoIma.image = [UIImage imageNamed:@"zhuanjia_toutiao.png"];
    [upView addSubview:toutiaoIma];
    
    UIImageView *lineIma = [[UIImageView alloc]initWithFrame:CGRectMake(ORIGIN_X(toutiaoIma)+15, 7, 0.5, 40)];
    lineIma.backgroundColor = SEPARATORCOLOR;
    [upView addSubview:lineIma];
    
    UIButton *reyiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reyiBtn.frame = CGRectMake(75, 10, 27, 14);
    reyiBtn.backgroundColor = [UIColor clearColor];
    [reyiBtn setBackgroundImage:[UIImage imageNamed:@"zhuanjia_redCircle.png"] forState:UIControlStateNormal];
    [reyiBtn setTitle:@"热议" forState:UIControlStateNormal];
    reyiBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    reyiBtn.tag = 1;
    [reyiBtn setTitleColor:[UIColor colorWithHexString:@"f04343"] forState:UIControlStateNormal];
    reyiBtn.enabled = NO;
    [upView addSubview:reyiBtn];
    
    UIButton *zanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zanBtn.frame = CGRectMake(75, ORIGIN_Y(reyiBtn)+7, 27, 14);
    zanBtn.backgroundColor = [UIColor clearColor];
    [zanBtn setBackgroundImage:[UIImage imageNamed:@"zhuanjia_redCircle.png"] forState:UIControlStateNormal];
    [zanBtn setTitle:@"超赞" forState:UIControlStateNormal];
    zanBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [zanBtn setTitleColor:[UIColor colorWithHexString:@"f04343"] forState:UIControlStateNormal];
    zanBtn.enabled = NO;
    zanBtn.tag = 2;
    [upView addSubview:zanBtn];//
    
    UIButton *reyiH5Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    reyiH5Btn.backgroundColor = [UIColor clearColor];
    reyiH5Btn.frame = CGRectMake(ORIGIN_X(reyiBtn)+5, 7, size.width-ORIGIN_X(reyiBtn)-20, 20);
    [reyiH5Btn setTitle:@"" forState:UIControlStateNormal];
    reyiH5Btn.titleLabel.font = [UIFont systemFontOfSize:11];
    reyiH5Btn.alpha = 0.87;
    [reyiH5Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    reyiH5Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    reyiH5Btn.tag = 3;
    [reyiH5Btn addTarget:self action:@selector(zhuanjiaToutiaoH5Action:) forControlEvents:UIControlEventTouchUpInside];
    [upView addSubview:reyiH5Btn];
    
    UIButton *zanH5Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    zanH5Btn.backgroundColor = [UIColor clearColor];
    zanH5Btn.frame = CGRectMake(ORIGIN_X(zanBtn)+5, ORIGIN_Y(reyiH5Btn)+1, size.width-ORIGIN_X(zanBtn)-20, 20);
    [zanH5Btn setTitle:@"" forState:UIControlStateNormal];
    zanH5Btn.titleLabel.font = [UIFont systemFontOfSize:11];
    zanH5Btn.alpha = 0.87;
    [zanH5Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    zanH5Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    zanH5Btn.tag = 4;
    [zanH5Btn addTarget:self action:@selector(zhuanjiaToutiaoH5Action:) forControlEvents:UIControlEventTouchUpInside];
    [upView addSubview:zanH5Btn];
    
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, ORIGIN_Y(upView)+8, size.width, 64)];
    downView.backgroundColor = [UIColor whiteColor];
    [_toutiaoView addSubview:downView];
    
    UIImageView *middleLine = [[UIImageView alloc]initWithFrame:CGRectMake(size.width/2, 9, 0.5, 45)];
    middleLine.backgroundColor = SEPARATORCOLOR;
    [downView addSubview:middleLine];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];//专家脸谱按钮
    leftBtn.frame = CGRectMake(0, 0, size.width/2, 64);
    leftBtn.backgroundColor = [UIColor clearColor];
    [leftBtn addTarget:self action:@selector(tapExpertCustom:) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];//我的关注按钮
    rightBtn.frame = CGRectMake(ORIGIN_X(leftBtn), 0, size.width/2, 64);
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn addTarget:self action:@selector(goMyConcern) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:rightBtn];
    
    UIImageView *leftIma = [[UIImageView alloc]initWithFrame:CGRectMake(middleLine.frame.origin.x - 55, 9, 45, 45)];
    leftIma.backgroundColor = [UIColor clearColor];
    leftIma.image = [UIImage imageNamed:@"zhuanjia_face.png"];
    [downView addSubview:leftIma];
    
    UILabel *leftLab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 80, 20)];
    leftLab1.backgroundColor = [UIColor clearColor];
    leftLab1.font = [UIFont systemFontOfSize:13];
    leftLab1.alpha = 0.87;
    leftLab1.text = @"专家脸谱";
    [downView addSubview:leftLab1];
    UILabel *leftLab2 = [[UILabel alloc]initWithFrame:CGRectMake(15, ORIGIN_Y(leftLab1), 80, 20)];
    leftLab2.backgroundColor = [UIColor clearColor];
    leftLab2.font = [UIFont systemFontOfSize:11];
    leftLab2.alpha = 0.7;
    leftLab2.text = @"实力专家在此";
    [downView addSubview:leftLab2];
    
    UILabel *rightLab1 = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(middleLine)+10, 10, 80, 20)];
    rightLab1.backgroundColor = [UIColor clearColor];
    rightLab1.font = [UIFont systemFontOfSize:13];
    rightLab1.alpha = 0.87;
    rightLab1.text = @"我的关注";
    [downView addSubview:rightLab1];
    UILabel *rightLab2 = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(middleLine)+10, ORIGIN_Y(rightLab1), 80, 20)];
    rightLab2.backgroundColor = [UIColor clearColor];
    rightLab2.font = [UIFont systemFontOfSize:11];
    rightLab2.alpha = 0.7;
    rightLab2.text = @"看专家最新动态";
    [downView addSubview:rightLab2];
    
    UIImageView *rightIma = [[UIImageView alloc]initWithFrame:CGRectMake(size.width - 60, 9, 45, 45)];
    rightIma.backgroundColor = [UIColor clearColor];
    rightIma.image = [UIImage imageNamed:@"zhuanjia_guanzhu.png"];
    [downView addSubview:rightIma];
    
    UIImageView *lineIma2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, size.width, 0.5)];
    lineIma2.backgroundColor = SEPARATORCOLOR;
    [downView addSubview:lineIma2];
}
#pragma mark -------添加轮播图----------
- (void)creatScrollView{
    
    float height=105;
    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MyWidth, height)];
    _scrollView.delegate=self;
    _scrollView.bounces=NO;
    if (_photoImageArr.count != 0) {
        _scrollView.contentSize=CGSizeMake(MyWidth*_photoImageArr.count, height);
    }
    _scrollView.backgroundColor=[UIColor clearColor];
    _scrollView.pagingEnabled=YES;
    _scrollView.showsHorizontalScrollIndicator=NO;
    [_recHeadView addSubview:_scrollView];
    
    [_scrollView setContentOffset:CGPointMake(MyWidth, 0) animated:NO];
    
    _pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(_scrollView.frame.size.width/2-50, _scrollView.frame.size.height-20, 100, 20)];
    if (_photoImageArr.count != 0) {
        _pageControl.numberOfPages=_photoImageArr.count;
    }
    _pageControl.backgroundColor=[UIColor clearColor];
    _pageControl.currentPage=0;
    [_pageControl addTarget:self action:@selector(pageValueChange:) forControlEvents:UIControlEventValueChanged];
    [_recHeadView addSubview:_pageControl];
    
    //_currentIndex=0;
}

- (void)creaDgqView{
    _dgqBgView=[[UIView alloc] initWithFrame:CGRectMake(0,  ORIGIN_Y(_scrollView)+6.0, 320, 50)];
    _dgqBgView.backgroundColor=[UIColor whiteColor];
    _dgqBgView.userInteractionEnabled=YES;
    [_recHeadView addSubview:_dgqBgView];
    
    CGSize dgqUpSize;
    CGSize dgqBelowSize;
    NSString *textTit=@"";
    NSString *detailTit=@"";
    for (int i=0; i<2; i++) {
        UIView *dgqGgBg=[[UIView alloc] initWithFrame:CGRectMake(0+160.5*i, 0, 159.5, 50)];
        dgqGgBg.backgroundColor=[UIColor clearColor];
        dgqGgBg.tag=370+i;
        [_dgqBgView addSubview:dgqGgBg];

        if (i==0) {
            textTit=@"滚球推荐";
            detailTit=@"带你赢到最后一分钟";
        }else if(i==1){
            textTit=@"球迷制造";
            detailTit=@"全民球赛，全民游戏";
        }
        dgqUpSize=[PublicMethod setNameFontSize:textTit andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        dgqBelowSize=[PublicMethod setNameFontSize:detailTit andFont:FONTEIGHTEEN andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(15, (46-dgqUpSize.height-dgqBelowSize.height)/2, dgqUpSize.width, dgqUpSize.height)];
        lab.text=textTit;
        lab.backgroundColor=[UIColor clearColor];
        if(i==0){
            lab.textColor=[UIColor colorWithHexString:@"66B31C"];
        }else if(i==1){
            lab.textColor=[UIColor colorWithHexString:@"FF9900"];
        }
        lab.textAlignment=NSTextAlignmentLeft;
        lab.font=FONTTWENTY_FOUR;
        lab.tag=470+i;
        [dgqGgBg addSubview:lab];
        
        UILabel *graylab=[[UILabel alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(lab)+4, dgqBelowSize.width, dgqBelowSize.height)];
        graylab.text=detailTit;
        graylab.backgroundColor=[UIColor clearColor];
        graylab.textColor=BLACK_FIFITYFOUR;
        graylab.textAlignment=NSTextAlignmentLeft;
        graylab.font=FONTEIGHTEEN;
        graylab.tag=570+i;
        [dgqGgBg addSubview:graylab];
        
        UIImageView *dgqImgView=[[UIImageView alloc] init];
        if(i==0){
#if defined DONGGEQIU
             [dgqImgView setFrame:CGRectMake(99.5, 2.5, 45, 45)];
#else
             [dgqImgView setFrame:CGRectMake(95.5, 6, 44, 38)];
#endif
        }else if(i==1){
#if defined DONGGEQIU
            [dgqImgView setFrame:CGRectMake(99.5, 2.5, 45, 45)];
#else
            [dgqImgView setFrame:CGRectMake(99, 6.25, 45.5, 37.5)];
#endif
        }
        dgqImgView.backgroundColor=[UIColor clearColor];
        dgqImgView.tag=670+i;
        [dgqGgBg addSubview:dgqImgView];
        
        SEL seltor;
        if (i==0) {
            seltor=@selector(gqTapAction:);
        }else if(i==1){
            seltor=@selector(qmzzClick:);
        }
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:seltor];
        dgqGgBg.userInteractionEnabled=YES;
        [dgqGgBg addGestureRecognizer:tap];
    }
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(159.5, 0, 1, 50)];
    view.backgroundColor=SEPARATORCOLOR;
    [_dgqBgView addSubview:view];
}

#pragma mark ---------添加比赛宣传图------------
- (void)creatOlympicView{
    _olympicXcView=[[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(_dgqBgView)+6.0, MyWidth, 60)];
    _olympicXcView.backgroundColor=[UIColor whiteColor];
    _olympicXcView.image=[UIImage imageNamed:@"olympicBg"];
    _olympicXcView.hidden=YES;
    [_recHeadView addSubview:_olympicXcView];
    
    CGSize olympicSize=[PublicMethod setNameFontSize:@"吉尼斯杯" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGSize timeSize=[PublicMethod setNameFontSize:@"周五001" andFont:FONTEIGHTEEN andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    UILabel *eventNameLab=[[UILabel alloc] initWithFrame:CGRectMake(15, 24-olympicSize.height, 0, olympicSize.height)];
    eventNameLab.backgroundColor=[UIColor clearColor];
    eventNameLab.font=FONTTWENTY_FOUR;
    eventNameLab.textAlignment=NSTextAlignmentCenter;
    eventNameLab.textColor=[UIColor colorWithHexString:@"FF7E00"];
    eventNameLab.tag=EVENTNAME;
    [_olympicXcView addSubview:eventNameLab];
    
    UILabel *eventTimeLab=[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(eventNameLab)+12, ORIGIN_Y(eventNameLab)-(olympicSize.height-timeSize.height), 0, timeSize.height)];
    eventTimeLab.backgroundColor=[UIColor clearColor];
    eventTimeLab.font=FONTEIGHTEEN;
    eventTimeLab.textAlignment=NSTextAlignmentCenter;
    eventTimeLab.textColor=BLACK_FIFITYFOUR;
    eventTimeLab.tag=EVENTTIME;
    [_olympicXcView addSubview:eventTimeLab];
    
    UILabel *partiesLab=[[UILabel alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(eventNameLab)+12, 0, olympicSize.height)];
    partiesLab.backgroundColor=[UIColor clearColor];
    partiesLab.font=FONTTWENTY_FOUR;
    partiesLab.textAlignment=NSTextAlignmentCenter;
    partiesLab.textColor=[UIColor colorWithHexString:@"1588DA"];
    partiesLab.tag=PARTIESOFEVENT;
    [_olympicXcView addSubview:partiesLab];
    
    UILabel *eventNumLab=[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_Y(partiesLab)+12, ORIGIN_Y(partiesLab)-(olympicSize.height-timeSize.height), 0, timeSize.height)];
    eventNumLab.backgroundColor=[UIColor clearColor];
    eventNumLab.font=FONTEIGHTEEN;
    eventNumLab.textAlignment=NSTextAlignmentCenter;
    eventNumLab.textColor=BLACK_FIFITYFOUR;
    eventNumLab.tag=EVENTNUM;
    [_olympicXcView addSubview:eventNumLab];
    
    UIImageView *olympicJtView=[[UIImageView alloc] initWithFrame:CGRectMake(MyWidth-30, 22.5, 15, 15)];
    olympicJtView.image=[UIImage imageNamed:@"olympicJt"];
    [_olympicXcView addSubview:olympicJtView];
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookUpXcw)];
    _olympicXcView.userInteractionEnabled=YES;
    [_olympicXcView addGestureRecognizer:tapGesture];
}

- (void)creatCategoryView{
    CGSize size=[PublicMethod setNameFontSize:@"夺宝" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];

//    _categoryView=[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(_scrollView)+6.0, MyWidth, 70+size.height)];
    _categoryView=[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(_zhuanjiaScro), MyWidth, 70+size.height)];
    _categoryView.backgroundColor=[UIColor whiteColor];
    _categoryView.userInteractionEnabled=YES;
    [_recHeadView addSubview:_categoryView];
    
    for (int i=0; i<5; i++) {
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(15+64*i, 15, 35, 35)];
        imgView.image=[UIImage imageNamed:[NSString stringWithFormat:@"catagory%d",i+1]];
        [_categoryView addSubview:imgView];
        
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(imgView.frame)+(35-size.width)/2, ORIGIN_Y(imgView)+5, size.width, size.height)];
        lab.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        lab.textColor=BLACK_EIGHTYSEVER;
        lab.textAlignment=NSTextAlignmentCenter;
        lab.font=FONTTWENTY_FOUR;
        [_categoryView addSubview:lab];
        
        UIButton * categoryButton = [[UIButton alloc] initWithFrame:CGRectMake(_categoryView.frame.size.width/5.0 * i, 0, _categoryView.frame.size.width/5.0, _categoryView.frame.size.height)];
        [categoryButton addTarget:self action:@selector(touchCategoryButton:) forControlEvents:UIControlEventTouchUpInside];
        categoryButton.tag = 100 + i;
        categoryButton.backgroundColor = [UIColor clearColor];
        [_categoryView addSubview:categoryButton];
        
        NSString *text=@"";
        switch (i) {
            case 0:
                text=@"夺宝";
                break;
            case 1:
                text=@"比分";
                break;
            case 2:
                text=@"赛事";
                break;
            case 3:
                text=@"竞猜";
                break;
            case 4:
                text=@"资讯";
                break;
            default:
                break;
        }
        lab.text=text;
    }
}

#pragma mark -------四个关注专家显示部分-------------
- (void)creatHeadPort{
    CGFloat yFrame=0.0;
#if defined DONGGEQIU
    yFrame=ORIGIN_Y(_dgqBgView);
#elif defined YUCEDI
    yFrame=ORIGIN_Y(_categoryView);
#else
    yFrame=ORIGIN_Y(_scrollView);
#endif
    _headPortView=[[UIView alloc] initWithFrame:CGRectMake(0, yFrame+6.0, MyWidth, 150)];
    _headPortView.backgroundColor=[UIColor clearColor];
    _headPortView.layer.masksToBounds=YES;
    _headPortView.layer.borderWidth=0.5;
    _headPortView.layer.borderColor=SEPARATORCOLOR.CGColor;
    _headPortView.userInteractionEnabled=YES;
    [_recHeadView addSubview:_headPortView];
    for (int i=0; i<5; i++) {
        UIView *headView=[[UIView alloc] initWithFrame:CGRectMake(64*i, 0.0, 64, 150)];
        headView.backgroundColor=[UIColor whiteColor];
        headView.tag=i+100;
        [_headPortView addSubview:headView];
        
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(14.5, 10, 35, 35)];
        imgView.backgroundColor=[UIColor clearColor];
        if (i==4) {
            imgView.image=[UIImage imageNamed:@"更多"];
        }else
            imgView.image=[UIImage imageNamed:@"默认头像"];
        imgView.clipsToBounds=YES;
        imgView.layer.cornerRadius=imgView.frame.size.width/2;
        imgView.tag=400+i;
        [headView addSubview:imgView];
        
        UIImageView *newPlanTagV=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(imgView.frame)+28, CGRectGetMinY(imgView.frame)+24, 9, 9)];
        newPlanTagV.layer.masksToBounds=YES;
        newPlanTagV.layer.borderColor=[[UIColor clearColor] CGColor];
        newPlanTagV.layer.cornerRadius=4.5;
        newPlanTagV.layer.borderWidth=1.0f;
        newPlanTagV.image=[UIImage imageNamed:@"有新方案"];
        newPlanTagV.contentMode=UIViewContentModeScaleAspectFill;
        newPlanTagV.hidden=YES;
        newPlanTagV.tag=500+i;
        if (i!=4) {
            [headView addSubview:newPlanTagV];
        }
        
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(imgView)+8, 64, 20)];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.textColor=BLACK_EIGHTYSEVER;
        lab.font=[UIFont systemFontOfSize:12.0f];
        if (i==4) {
            lab.text=@"更多";
        }
        lab.backgroundColor=[UIColor clearColor];
        lab.tag=600+i;
        [headView addSubview:lab];
        
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] init];
        if (i!=4) {
            [tapGesture addTarget:self action:@selector(tapExpertDetail:)];
        }else
            [tapGesture addTarget:self action:@selector(tapExpertCustom:)];
        headView.userInteractionEnabled=YES;
        [headView addGestureRecognizer:tapGesture];
        
        CGSize cellUIsize=[PublicMethod setNameFontSize:@"更多" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGRect rect=lab.frame;
        rect.origin.x=rect.origin.x+(rect.size.width-cellUIsize.width)/2;
        rect.size=cellUIsize;
        [lab setFrame:rect];
        
        rect=_headPortView.frame;
        rect.size.height=CGRectGetMaxY(lab.frame)+17;
        [_headPortView setFrame:rect];
    }
}

#pragma mark ----------添加滚球推荐------------
-(void)creatGqView{
//    _gqView=[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(_headPortView), 320, 0)];
    _gqView=[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(_toutiaoView), 320, 0)];
    _gqView.backgroundColor=[UIColor whiteColor];
    _gqView.hidden=YES;
    _gqView.layer.masksToBounds=YES;
    _gqView.layer.borderColor=SEPARATORCOLOR.CGColor;
    _gqView.layer.borderWidth=0.5;
    [_recHeadView addSubview:_gqView];
    
    CGSize oneSize=[PublicMethod setNameFontSize:@"滚球专家推荐" andFont:FONTTHIRTY_TWO andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGSize twoSize=[PublicMethod setNameFontSize:@"名家带你赢到最后一分钟" andFont:FONTTWENTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    UILabel *onelab=[[UILabel alloc] initWithFrame:CGRectMake(15, (61-oneSize.height-twoSize.height)/2, oneSize.width, oneSize.height)];
    onelab.textColor=[UIColor colorWithHexString:@"FF9900"];
    onelab.font=FONTTHIRTY_TWO;
    onelab.text=@"滚球专家推荐";
    onelab.backgroundColor=[UIColor clearColor];
    [_gqView addSubview:onelab];
    
    UILabel *twolab=[[UILabel alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(onelab)+4, twoSize.width, twoSize.height)];
    twolab.textColor=BLACK_FIFITYFOUR;
    twolab.font=FONTTWENTY;
    twolab.text=@"名家带你赢到最后一分钟";
    twolab.backgroundColor=[UIColor clearColor];
    [_gqView addSubview:twolab];
    
    UIImageView *gqImgView=[[UIImageView alloc] initWithFrame:CGRectMake(320-15-60, 7, 60, 51)];
    gqImgView.image=[UIImage imageNamed:@"gq"];
    gqImgView.backgroundColor=[UIColor clearColor];
    [_gqView addSubview:gqImgView];
    
    UITapGestureRecognizer *tapGusture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gqTapAction:)];
    _gqView.userInteractionEnabled=YES;
    [_gqView addGestureRecognizer:tapGusture];
}

#pragma mark ---------创建segmentView---------
-(void)creatSegmentView
{
    bgSegment=[[UIView alloc] init];
    CGFloat yFrame=ORIGIN_Y(_gqView);
#if defined DONGGEQIU
    yFrame=ORIGIN_Y(_headPortView);
#endif
    [bgSegment setFrame:CGRectMake(0, yFrame, 320, 45)];
    //bgSegment.layer.masksToBounds=YES;
    //bgSegment.layer.borderWidth=0.5;
    //bgSegment.layer.borderColor=SEPARATORCOLOR.CGColor;
    bgSegment.backgroundColor=[UIColor whiteColor];
    [_recHeadView addSubview:bgSegment];
    
    UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    lineView.backgroundColor=SEPARATORCOLOR;
    [bgSegment addSubview:lineView];
    
    NSString *btnText=@"";
    UIButton *btn;
    for (int i=0; i<4; i++) {
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0+MyWidth/4*i, 0, MyWidth/4, 45)];
        [btn setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateSelected];
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
        [btn addTarget:self action:@selector(btnLotteryTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=FONTTHIRTY;
        [bgSegment addSubview:btn];
        if (i==0) {
            _jcBtn=btn;
        }else if(i==1){
            _lcBtn=btn;
        }else if(i==2){
            _ypBtn=btn;
        }else if(i==3){
            _szcBtn=btn;
        }
    }
    
//    UIImageView *sswImgv=[[UIImageView alloc] initWithFrame:CGRectMake(MyWidth/6-32, CGRectGetMaxY(btn.frame)-10, 64, 2)];
    UIImageView *sswImgv=[[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(btn.frame)-10, MyWidth/4.0-40, 2)];
    sswImgv.image=[UIImage imageNamed:@"slidsw"];
    [bgSegment addSubview:sswImgv];
    _slidSwImgView=sswImgv;
    
    //    segmentCT=[[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"竞足",@"数字彩", nil]];
    //    segmentCT.frame=CGRectMake(15,15,MyWidth-30,bgSegment.frame.size.height-30);
    //    segmentCT.selectedSegmentIndex=0;
    //
    //    UIFont *font =FONTTHIRTY;
    //    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
    //    [segmentCT setTitleTextAttributes:attributes forState:UIControlStateNormal];
    //
    //    segmentCT.tintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"发布方案-确定按钮"]];
    //    [segmentCT addTarget:self action:@selector(segmentOnClick:) forControlEvents:UIControlEventValueChanged];
    //    [bgSegment addSubview:segmentCT];
    
    CGRect rect=_recHeadView.frame;
    rect.size.height=CGRectGetMaxY(bgSegment.frame);
    [_recHeadView setFrame:rect];
    
    UIImageView * shaowImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, bgSegment.frame.size.height-2, MyWidth, 2)];
    shaowImageView.image=[UIImage imageNamed:@"背景-1横条"];
    [bgSegment addSubview:shaowImageView];
}

- (void)gqTapAction:(UITapGestureRecognizer *)act{
    if ([_firstUrl hasPrefix:@"https://itunes.apple.com"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_firstUrl]];
        return;
    }
    CommonProblemViewController *gqRecVc=[[CommonProblemViewController alloc] init];
    gqRecVc.nsUrl=_firstUrl;
    gqRecVc.sourceFrom=@"shouye";
    gqRecVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:gqRecVc animated:YES];
}

- (void)qmzzClick:(UITapGestureRecognizer *)tap{
    UIView *view=tap.view;
    UILabel *lab=[view viewWithTag:view.tag+100];
    if ([lab.text isEqualToString:@"球迷制造"]) {
//        if (![[[Info getInstance] userId] intValue]) {
//            [self doLogin];
//            return;
//        }
//        [_pointRequest clearDelegatesAndCancel];
//        self.pointRequest = [ASIHTTPRequest requestWithURL:[NetURL guessBallLogin]];
//        [_pointRequest setTimeOutSeconds:20.0];
//        [_pointRequest setDidFinishSelector:@selector(getcaiqiuURLFinish:)];
//        [_pointRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//        [_pointRequest setDelegate:self];
//        [_pointRequest startAsynchronous];
    }else{
        CommonProblemViewController *gqRecVc=[[CommonProblemViewController alloc] init];
        gqRecVc.nsUrl=_secondUrl;
        gqRecVc.sourceFrom=@"shouye";
        gqRecVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:gqRecVc animated:YES];
    }
}

- (void)doLogin {
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:loginVC animated:YES];
#endif
}

-(void)getcaiqiuURLFinish:(ASIHTTPRequest *)request
{
    NSDictionary * dic = [request.responseString JSONValue];
    if (dic) {
        if ([[dic valueForKey:@"code"] isEqualToString:@"0000"]) {
            MyWebViewController *web=[[MyWebViewController alloc] init];
            [web LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:[[[dic valueForKey:@"data"] valueForKey:@"url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
            web.delegate= self;
            web.webTitle = @"球迷制造";
            
            [self.navigationController pushViewController:web animated:YES];
            
        }else{
            [[caiboAppDelegate getAppDelegate] showMessage:[dic valueForKey:@"message"]];
        }
    }
}

#pragma mark -------创建专家列表-----------
- (void)creatExpTabView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,HEIGHTBELOESYSSEVER+44.0f, MyWidth, MyHight-113) style:UITableViewStylePlain];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsHorizontalScrollIndicator=NO;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tag=LISTTABLETAG;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView=_recHeadView;
}
#pragma mark ---------点击搜索------------
- (void)searchBtn:(id)sender{
    [MobClick event:@"Zj_quanbu_20161014_sousuo" label:@"专家"];
    SearchVC *vc=[[SearchVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)sixButtonActionToSearch:(UIButton *)button{
    
    NSArray *titleAry = [NSArray arrayWithObjects:
                         @"TV名嘴带你看推荐",
                         @"媒体记者带你看推荐",
                         @"足球名将带你看推荐",
                         @"彩票专家带你看推荐",
                         @"连红牛人带你看推荐",
                         @"民间高手带你看推荐", nil];
    
    SearchVC *vc=[[SearchVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.labelStr = [titleAry objectAtIndex:button.tag];
    [MobClick event:@"Zj_zishen_20161014_zhiming_toubuanniu" label:[titleAry objectAtIndex:button.tag]];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)zhuanjiaToutiaoH5Action:(UIButton *)button{
    
    if(toutiaoH5URLArym.count < 2){
        return;
    }
    NSString *url = @"";
    [MobClick event:@"Zj_zishen_20161014_toutiao" label:[button titleForState:UIControlStateNormal]];
    if(button.tag == 3){//热议
        url = [toutiaoH5URLArym objectAtIndex:0];
    }else if (button.tag == 4){//超赞
        url = [toutiaoH5URLArym objectAtIndex:1];
    }
    if(url.length == 0 || [url isEqualToString:@"null"]){
        return;
    }
    CommonProblemViewController * vc = [[CommonProblemViewController alloc]init];
    vc.sourceFrom=@"experCon";
    vc.nsUrl = url;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -------点击更多进入我的关注--------点击专家脸谱跳资深专家列表-----
- (void)tapExpertCustom:(id)sender{//MyConcernVc.m
    Info *info = [Info getInstance];
    if (![info.userId intValue]) {
#ifdef isCaiPiaoForIPad
        [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
        [self toLogin];
        return;
#endif
    }
    [MobClick event:@"Zj_zishen_20161014_lianpu" label:nil];
    ExpertCustomVC *expertCustom=[[ExpertCustomVC alloc] init];
    expertCustom.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:expertCustom animated:YES];
}
#pragma mark ---------------点击我的关注进入我的关注-------------
-(void)goMyConcern{
    
    Info *info = [Info getInstance];
    if (![info.userId intValue]) {
#ifdef isCaiPiaoForIPad
        [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
        [self toLogin];
        return;
#endif
    }
    
    [MobClick event:@"Zj_zishen_20161014_guanzhu" label:nil];
    MyConcernVc *myconcernVc=[[MyConcernVc alloc] init];
    myconcernVc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:myconcernVc animated:YES];
}

#pragma mark -----------轮播图的点击事件-----------
-(void)tapAction:(UITapGestureRecognizer *)gesture{
    UIView *view=gesture.view;
    CommonProblemViewController * vc = [[CommonProblemViewController alloc]init];
    vc.sourceFrom=@"experCon";
    vc.nsUrl = [_photoImageArr objectAtIndex:view.tag-300][@"linkUrl"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -segment的单击响应方法
- (void)btnLotteryTypeClick:(UIButton *)btn{
    if(_noReconView){
        [_noReconView removeFromSuperview];
        _noReconView=nil;
        [_tableView setBackgroundColor:[UIColor whiteColor]];
    }
    [MobClick event:@"Zj_zishen_20161014_caizhong" label:[btn titleForState:UIControlStateNormal]];
    btn.selected=YES;
    if (btn==_jcBtn) {
        _lcBtn.selected = NO;
        _ypBtn.selected=NO;
        _szcBtn.selected=NO;
//        [_slidSwImgView setFrame:CGRectMake(MyWidth/6-32, CGRectGetMaxY(btn.frame)-10, 64, 2)];
        [_slidSwImgView setFrame:CGRectMake(20, CGRectGetMaxY(btn.frame)-10, MyWidth/4.0-40, 2)];
        if (jCPageNum!=[_jcTotalPg intValue]) {
            [_tableView.footer resetNoMoreData];
            MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)_tableView.footer;
            f.stateLabel.font=[UIFont systemFontOfSize:17.0f];
        }
        _lotteryType=@"001";
        _expLoType=@"-201";
        _segmentSelectFlags=YES;
        if (!_jcExpList.count) {
            jCPageNum = 1;
            _tableView.userInteractionEnabled=NO;
            [self getExpertList:@"1"];
        }else{
            [_tableView reloadData];
        }
    }else if (btn==_lcBtn) {
        _jcBtn.selected=NO;
        _ypBtn.selected = NO;
        _szcBtn.selected=NO;
//        [_slidSwImgView setFrame:CGRectMake(MyWidth/2-32, CGRectGetMaxY(btn.frame)-10, 64, 2)];
        [_slidSwImgView setFrame:CGRectMake(20+MyWidth/4, CGRectGetMaxY(btn.frame)-10, MyWidth/4.0-40, 2)];
        if (lcPageNum!=[_lcTotalPg intValue]) {
            [_tableView.footer resetNoMoreData];
            MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)_tableView.footer;
            f.stateLabel.font=[UIFont systemFontOfSize:17.0f];
        }
        _lotteryType=@"001";
        _expLoType=@"204";
        _segmentSelectFlags=YES;
        if (!_lcExpList.count) {
            lcPageNum = 1;
            _tableView.userInteractionEnabled=NO;
            [self getExpertList:@"1"];
//            [self getErchuanyiExpertRequestWithPage:@"1"];
        }else{
            [_tableView reloadData];
        }
    }else if (btn==_ypBtn) {
        _jcBtn.selected=NO;
        _lcBtn.selected = NO;
        _szcBtn.selected=NO;
//        [_slidSwImgView setFrame:CGRectMake(MyWidth/2-32, CGRectGetMaxY(btn.frame)-10, 64, 2)];
        [_slidSwImgView setFrame:CGRectMake(20+MyWidth*2/4, CGRectGetMaxY(btn.frame)-10, MyWidth/4.0-40, 2)];
        if (ypPageNum!=[_ypTotalPg intValue]) {
            [_tableView.footer resetNoMoreData];
            MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)_tableView.footer;
            f.stateLabel.font=[UIFont systemFontOfSize:17.0f];
        }
        _lotteryType=@"001";
        _expLoType=@"201";
        _segmentSelectFlags=YES;
        if (!_ypExpList.count) {
            ypPageNum = 1;
            _tableView.userInteractionEnabled=NO;
//            [self getExpertList:@"1"];
            [self getErchuanyiExpertRequestWithPage:@"1"];
        }else{
            [_tableView reloadData];
        }
    }else if (btn==_szcBtn) {
        _jcBtn.selected=NO;
        _lcBtn.selected = NO;
        _ypBtn.selected=NO;
//        [_slidSwImgView setFrame:CGRectMake(MyWidth*5/6-32, CGRectGetMaxY(btn.frame)-10, 64, 2)];
        [_slidSwImgView setFrame:CGRectMake(15+MyWidth*3/4, CGRectGetMaxY(btn.frame)-10, MyWidth/4.0-30, 2)];
        if (szcPageNum!=[_szcTotalPg intValue]) {
            [_tableView.footer resetNoMoreData];
            MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)_tableView.footer;
            f.stateLabel.font=[UIFont systemFontOfSize:17.0f];
        }
        _lotteryType=@"002";
        _expLoType=@"";
        _segmentSelectFlags=NO;
        if (!_szcExpList.count) {
            szcPageNum = 1;
            _tableView.userInteractionEnabled=NO;
            [self getExpertList:@"1"];
        }else{
            [_tableView reloadData];
        }
    }
}

//-(void)segmentOnClick:(UISegmentedControl *)segment
//{
//    NSInteger index=segment.selectedSegmentIndex;
//    switch (index) {
//        case 0:
//        {
//            if (jCPageNum !=[_jcTotalPg intValue]) {
//                [_tableView.footer resetNoMoreData];
//                MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)_tableView.footer;
//                f.stateLabel.font=[UIFont systemFontOfSize:17.0f];
//            }
//            _lotteryType=@"001";
//            _segmentSelectFlags=YES;
//            if (!_jcExpList.count) {
//                jCPageNum = 1;
//                [self getExpertList:@"1"];
//                _tableView.userInteractionEnabled=NO;
//            }else{
//                [_tableView reloadData];
//            }
//            break;
//        }
//        case 1:
//        {
//            if (szcPageNum !=[_szcTotalPg intValue]) {
//                [_tableView.footer resetNoMoreData];
//                MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)_tableView.footer;
//                f.stateLabel.font=[UIFont systemFontOfSize:17.0f];
//            }
//            _lotteryType=@"002";
//            _segmentSelectFlags=NO;
//            if (!_szcExpList.count) {
//                szcPageNum = 1;
//                [self getExpertList:@"1"];
//                _tableView.userInteractionEnabled=NO;
//            }else{
//                [_tableView reloadData];
//            }
//            break;
//        }
//
//        default:
//            break;
//    }
//}

#pragma mark ---------------调取接口----------------

#pragma mark -----------获取专家头条信息列表-------------
-(void)getToutiaoRequest{
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"getHomeExpertsHeadLineInfo",@"parameters":@{}}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[responseJSON valueForKey:@"result"];
            if(result.count >= 2){
                
                [toutiaoH5URLArym removeAllObjects];
                [toutiaoH5URLArym addObject:[[result objectAtIndex:0] valueForKey:@"articleLinkUrl"]];
                [toutiaoH5URLArym addObject:[[result objectAtIndex:1] valueForKey:@"articleLinkUrl"]];
                
                UIButton *btn1 = [_toutiaoView viewWithTag:1];
                [btn1 setTitle:[[result objectAtIndex:0] valueForKey:@"articleName"] forState:UIControlStateNormal];
                UIButton *btn2 = [_toutiaoView viewWithTag:2];
                [btn2 setTitle:[[result objectAtIndex:1] valueForKey:@"articleName"] forState:UIControlStateNormal];
                UIButton *btn3 = [_toutiaoView viewWithTag:3];
                [btn3 setTitle:[[result objectAtIndex:0] valueForKey:@"articleTitle"] forState:UIControlStateNormal];
                UIButton *btn4 = [_toutiaoView viewWithTag:4];
                [btn4 setTitle:[[result objectAtIndex:1] valueForKey:@"articleTitle"] forState:UIControlStateNormal];
            }
        }else{
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        
    }];
}
#pragma mark -----------获取资深专家列表-------------
-(void)getManySeniorExpertRequest{
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"getHomeExpertsInfo",@"parameters":@{}}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[responseJSON valueForKey:@"result"];
            if ([result count]!=0) {
                if (_focusArr) {
                    [_focusArr removeAllObjects];
                    _focusArr=nil;
                }
                NSMutableArray *mutableArr=[NSMutableArray arrayWithCapacity:[result count]];
                for (NSDictionary * dic in result) {
                    [mutableArr addObject:[ExpertJingjiModel expertJingjiWithDic:dic]];
                }
                _focusArr=mutableArr;
                [self creatZhuanjiaScrollView];
            }
        }else{
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        
    }];
}
#pragma mark -----------获取关注专家列表-------------
-(void)getFocusExpert
{
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getMyExperts",@"parameters":@{@"userName":nameSty}}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[responseJSON valueForKey:@"result"];
            if ([result count]!=0) {
                if (_focusArr) {
                    [_focusArr removeAllObjects];
                    _focusArr=nil;
                }
                NSMutableArray *mutableArr=[NSMutableArray arrayWithCapacity:[result count]];
                for (NSDictionary * dic in result) {
                    [mutableArr addObject:[ExpertJingjiModel expertJingjiWithDic:dic]];
                }
                _focusArr=mutableArr;
                NSInteger exfocNo=[mutableArr count];
                if (exfocNo>4) {
                    exfocNo=4;
                }
                for (int i=0; i<exfocNo; i++) {
                    ExpertJingjiModel *expertModel=[_focusArr objectAtIndex:i];
                    UIView *view=[_headPortView viewWithTag:i+100];
                    
                    UIImageView *imV=(UIImageView *)[[view subviews] objectAtIndex:0];
                    NSURL *url=[NSURL URLWithString:expertModel.HEAD_PORTRAIT];
                    [imV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageContinueInBackground|SDWebImageRetryFailed];
                    
                    if (expertModel.NEW_RECOMMEND_NUM!=0) {
                        UIImageView *newPlanTag=(UIImageView *)[[view subviews] objectAtIndex:1];
                        newPlanTag.hidden=NO;
                    }
                    
                    UILabel *lab=(UILabel *)[[view subviews] objectAtIndex:2];
                    NSString *subString=expertModel.EXPERTS_NICK_NAME;
                    if(expertModel.EXPERTS_NICK_NAME.length>4){
                        NSRange range=NSMakeRange(0, 4);
                        subString=[expertModel.EXPERTS_NICK_NAME substringWithRange:range];
                    }
                    lab.text=subString;
                    
                    CGSize cellUIsize=[PublicMethod setNameFontSize:lab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
                    CGRect rect=lab.frame;
                    rect.origin.x=rect.origin.x+(rect.size.width-cellUIsize.width)/2;
                    rect.size=cellUIsize;
                    [lab setFrame:rect];
                    view.userInteractionEnabled=YES;
                }
            }
        }else{
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        
    }];
}

#pragma mark -----------获取专家列表-------------
-(void)getExpertList:(NSString *)page{
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    if(_noReconView){
        [_noReconView removeFromSuperview];
        _noReconView=nil;
        [_tableView setBackgroundColor:[UIColor whiteColor]];
    }
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getExpertsPlanList",@"parameters":@{@"expertClassCode":_lotteryType,@"lotteryClassCode":_expLoType,@"levelType":@"1",@"curPage":page,@"pageSize":@"20",@"sid":[[Info getInstance] cbSID]}}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        _tableView.userInteractionEnabled=YES;
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            if([_lotteryType isEqualToString:@"001"]){
                if ([_expLoType isEqualToString:@"-201"]) {
                    _jcTotalPg=[responseJSON valueForKey:@"result"][@"pageInfo"][@"totalPage"];
                }else if ([_expLoType isEqualToString:@"204"]){
                    _lcTotalPg=[responseJSON valueForKey:@"result"][@"pageInfo"][@"totalPage"];
                }else if ([_expLoType isEqualToString:@"201"]){
                    _ypTotalPg=[responseJSON valueForKey:@"result"][@"pageInfo"][@"totalPage"];
                }
            }else if([_lotteryType isEqualToString:@"002"]){
                _szcTotalPg=[responseJSON valueForKey:@"result"][@"pageInfo"][@"totalPage"];
            }
            NSArray * result=[responseJSON valueForKey:@"result"][@"data"];
            if ([result count]!=0) {
                NSMutableArray *mutableArr=[NSMutableArray array];
                for (NSDictionary * dic in result) {
                    [mutableArr addObject:[ExpertJingjiModel expertJingjiWithDic:dic]];
                }
                if ([_lotteryType isEqualToString:@"001"]) {
                    if ([_expLoType isEqualToString:@"-201"]) {
                        if ([page isEqualToString:@"1"]) {
                            [_jcExpList removeAllObjects];
                            _jcExpList=nil;
                            _jcExpList=mutableArr;
                        }else{
                            jCPageNum++;
                            [_jcExpList addObjectsFromArray:mutableArr];
                        }
                    }else if([_expLoType isEqualToString:@"201"]){
                        if ([page isEqualToString:@"1"]) {
                            [_ypExpList removeAllObjects];
                            _ypExpList=nil;
                            _ypExpList=mutableArr;
                        }else{
                            ypPageNum++;
                            [_ypExpList addObjectsFromArray:mutableArr];
                        }
                    }else if([_expLoType isEqualToString:@"204"]){
                        if ([page isEqualToString:@"1"]) {
                            [_lcExpList removeAllObjects];
                            _lcExpList=nil;
                            _lcExpList=mutableArr;
                        }else{
                            lcPageNum++;
                            [_lcExpList addObjectsFromArray:mutableArr];
                        }
                    }
                }else if([_lotteryType isEqualToString:@"002"]){
                    if ([page isEqualToString:@"1"]) {
                        [_szcExpList removeAllObjects];
                        _szcExpList=nil;
                        _szcExpList=mutableArr;
                    }else{
                        szcPageNum++;
                        [_szcExpList addObjectsFromArray:mutableArr];
                    }
                }
            }else{
                if([page isEqualToString:@"1"]){
#if !defined DONGGEQIU
                    [bgSegment removeFromSuperview];
                    [bgSegment setFrame:CGRectMake(0.0, ORIGIN_Y(_gqView), MyWidth, 45)];
                    [_recHeadView addSubview:bgSegment];
#endif
                    _noReconView=[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(bgSegment), 320, 200)];
                    _noReconView.backgroundColor=[UIColor clearColor];
                    [_recHeadView addSubview:_noReconView];
                    
                    UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(125, 20, 70, 92.5)];
                    imgV.image=[UIImage imageNamed:@"norecon"];
                    [_noReconView addSubview:imgV];
                    
                    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(60, ORIGIN_Y(imgV)+10, 200, 40)];
                    lab.backgroundColor=[UIColor clearColor];
                    lab.text=@"专家正在发布方案中";
                    lab.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
                    lab.textAlignment=NSTextAlignmentCenter;
                    lab.font=FONTTHIRTY_TWO;
                    [_noReconView addSubview:lab];
                    [_tableView setBackgroundColor:[UIColor colorWithHexString:@"ecedf1"]];
                }
            }
            [_tableView reloadData];
        }else{
            if (loadview) {
                [loadview stopRemoveFromSuperview];
                loadview = nil;
            }
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.footer endRefreshing];
            [_tableView.header endRefreshing];
        });
    } failure:^(NSError * error) {
        _tableView.userInteractionEnabled=YES;
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.footer endRefreshing];
            [_tableView.header endRefreshing];
        });
    }];
}

#pragma mark -------获取轮播图URL----------
-(void)scrImgReData
{
    float height=105;
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"zjtjIndexService" forKey:@"serviceName"];
    [bodyDic setObject:@"getAllCarouseImage" forKey:@"methodName"];
    [bodyDic setObject:@{} forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSArray *arr=[responseJSON objectForKey:@"result"];
        NSMutableArray * muArr = [NSMutableArray array];
        for (NSDictionary * dic in arr) {
            if ([[dic objectForKey:@"type"]isEqualToString:@"1"]) {
                [muArr addObject:dic];
            }
        }
        _photoImageArr = muArr;
        
        [self creatScrollView];
        
        for (int i=0; i<muArr.count; i++) {
            UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(MyWidth*i, 0, MyWidth, height)];
            [imgView setContentScaleFactor:[[UIScreen mainScreen] scale]];
            //imgView.contentMode =  UIViewContentModeScaleAspectFill;
            //imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            imgView.clipsToBounds = YES;
            imgView.tag=300+i;
            
            NSURL *url=[NSURL URLWithString:[muArr objectAtIndex:i][@"imgUrl"]];
            NSString *scolImgName=@"";
#if defined YUCEDI
            scolImgName=@"yucedi_default";
#elif defined DONGGEQIU
            scolImgName=@"dgq_default";
#elif defined CRAZYSPORTS
            scolImgName=@"CS_LunBoDefault210";
#else
            scolImgName=@"灰色默认";
#endif
            [imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:scolImgName] options:SDWebImageContinueInBackground|SDWebImageRetryFailed];
            [_scrollView addSubview:imgView];
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            _scrollView.userInteractionEnabled = YES;
            imgView.userInteractionEnabled = YES;
            [imgView addGestureRecognizer:tap];
        }
    } failure:^(NSError * error) {
        NSLog(@"error=%@",error);
    }];
}

#pragma mark ---------奥运宣传位查看赛程-------------
- (void)lookUpXcw{
    MatchDetailVC *vc=[[MatchDetailVC alloc] init];
    vc.playId=_dgqOlympicMdl.playId;
    vc.cId=_dgqOlympicMdl.ccid;
    vc.matchSource=@"-201";
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark -------点击资深专家头像进入专家详情--------
-(void)manySeniorExpertClick:(UIButton *)button{
    
    if(_focusArr==nil||[_focusArr count]==0){
        return;
    }
    NSInteger tag=button.tag-123;
    
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    NSString *lotry=@"";
    ExpertJingjiModel *expMdl=[_focusArr objectAtIndex:tag];
    if([expMdl.expertsClassCode isEqualToString:@"001"]){
        _segmentSelectFlags=YES;
        lotry=@"-201";
    }else if([expMdl.expertsClassCode isEqualToString:@"002"]){
        _segmentSelectFlags=NO;
        lotry=@"001";
    }
    [MobClick event:@"Zj_zishen_20161014_zhiming" label:expMdl.expertsNickName];
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
    
    [bodyDic setObject:@{@"expertsName":expMdl.expertsName,@"expertsClassCode":expMdl.expertsClassCode,@"loginUserName":nameSty,@"erAgintOrderId":@"",@"type":@"1",@"sid":info.cbSID,@"lotteryClassCode":lotry} forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        //NSLog(@"responseJSON=%@",responseJSON);
        SMGDetailViewController * vc=[[SMGDetailViewController alloc]init];
        NSDictionary *dic=responseJSON[@"result"][@"expertBaseInfo"];
        ExpertBaseInfo *exBase=[ExpertBaseInfo expertBaseInfoWithDic:dic];
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
            vc.planIDStr=@"";
            vc.jcyplryType=@"-201";
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
            
            vc.lotryType=101;
        }
        vc.exBaseInfo=exBase;
        vc.hidesBottomBarWhenPushed=YES;
        vc.segmentOnClickIndexFlags=_segmentSelectFlags;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError * error) {
        
    }];
}
#pragma mark -------点击关注专家头像进入专家详情--------
- (void)tapExpertDetail:(UITapGestureRecognizer *)sender{
    if(_focusArr==nil||[_focusArr count]==0){
        return;
    }
    UIView *view=sender.view;
    NSInteger tag=view.tag-100;
    [tagNewAry replaceObjectAtIndex:tag withObject:@"0"];
    
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    NSString *lotry=@"";
    ExpertJingjiModel *expMdl=[_focusArr objectAtIndex:tag];
    if([expMdl.EXPERTS_CODE_ARRAY isEqualToString:@"001"]){
        _segmentSelectFlags=YES;
        lotry=@"-201";
    }else if([expMdl.EXPERTS_CODE_ARRAY isEqualToString:@"002"]){
        _segmentSelectFlags=NO;
        lotry=@"001";
    }
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
    
    [bodyDic setObject:@{@"expertsName":expMdl.EXPERTS_NAME,@"expertsClassCode":expMdl.EXPERTS_CODE_ARRAY,@"loginUserName":nameSty,@"erAgintOrderId":@"",@"type":@"1",@"sid":info.cbSID,@"lotteryClassCode":lotry} forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        //NSLog(@"responseJSON=%@",responseJSON);
        SMGDetailViewController * vc=[[SMGDetailViewController alloc]init];
        NSDictionary *dic=responseJSON[@"result"][@"expertBaseInfo"];
        ExpertBaseInfo *exBase=[ExpertBaseInfo expertBaseInfoWithDic:dic];
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
            vc.planIDStr=@"";
            vc.jcyplryType=@"-201";
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
            
            vc.lotryType=101;
        }
        vc.exBaseInfo=exBase;
        vc.hidesBottomBarWhenPushed=YES;
        vc.segmentOnClickIndexFlags=_segmentSelectFlags;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError * error) {
        
    }];
}

#pragma mark -----------滚球是否隐藏-------------
-(void)getGqPicture{
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getBowlsPicture",@"parameters":@{}}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray *arr=[responseJSON objectForKey:@"result"];
            for (NSDictionary *dic in arr) {
                if ([[dic objectForKey:@"type"] isEqualToString:@"1"]) {
                    NSString *whetherShow=[dic objectForKey:@"whetherShow"];
                    if ([whetherShow isEqualToString:@"0"]) {
                        _gqView.hidden=YES;
                        CGRect rect=_gqView.frame;
//                        rect.origin.y=ORIGIN_Y(_headPortView);
                        rect.origin.y=ORIGIN_Y(_toutiaoView);
                        rect.size.height=0;
                        [_gqView setFrame:rect];
                        
                    }else if ([whetherShow isEqualToString:@"1"]) {
                        _gqView.hidden=NO;
                        CGRect rect=_gqView.frame;
//                        rect.origin.y=ORIGIN_Y(_headPortView)+6.0;
                        rect.origin.y=ORIGIN_Y(_toutiaoView)+6.0;
                        rect.size.height=65;
                        [_gqView setFrame:rect];
                    }
                    
                    
                    CGRect rect=bgSegment.frame;
                    rect.origin.y=ORIGIN_Y(_gqView);
                    [bgSegment setFrame:rect];
                    if (_noReconView) {
                        [_noReconView setFrame:CGRectMake(0, ORIGIN_Y(bgSegment), 320, 200)];
                    }
                    
                    rect=_recHeadView.frame;
                    rect.size.height=CGRectGetMaxY(bgSegment.frame);
                    [_recHeadView setFrame:rect];
                }
                [_tableView setTableHeaderView:_recHeadView];
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        
    }];
}

#pragma mark ---------------滚球推荐----------------

-(void)getDgqGq{
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getDgqCapmpInfo",@"parameters":@{}}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray *arr=[responseJSON objectForKey:@"result"];
            if([arr count]!=0){
                for (NSDictionary *dic in arr) {
                    if([[dic objectForKey:@"type"] isEqualToString:@"1"]){
                        UIView *firstView;
                        if ([[dic objectForKey:@"postion"] isEqualToString:@"1"]) {
                            firstView=[_dgqBgView viewWithTag:370];
                            _firstUrl=[dic objectForKey:@"linkUrl"];
                        }else if ([[dic objectForKey:@"postion"] isEqualToString:@"2"]) {
                            firstView=[_dgqBgView viewWithTag:371];
                            _secondUrl=[dic objectForKey:@"linkUrl"];
                        }
                        NSString *textTit=[dic objectForKey:@"title"];
                        NSString *detailTit=[dic objectForKey:@"explain"];
                        CGSize dgqUpSize=[PublicMethod setNameFontSize:textTit andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
                        CGSize dgqBelowSize=[PublicMethod setNameFontSize:detailTit andFont:FONTEIGHTEEN andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
                        
                        UILabel *lab=[firstView viewWithTag:firstView.tag+100];
                        lab.text=textTit;
                        CGRect rect=lab.frame;
                        rect.size.width=dgqUpSize.width;
                        [lab setFrame:rect];
                        
                        lab=[firstView viewWithTag:firstView.tag+200];
                        lab.text=detailTit;
                        rect=lab.frame;
                        rect.size.width=dgqBelowSize.width;
                        [lab setFrame:rect];
                        
                        UIImageView *imgView=(UIImageView *)[firstView viewWithTag:firstView.tag+300];
                        imgView.backgroundColor=[UIColor clearColor];
                        NSURL *url=[NSURL URLWithString:[dic objectForKey:@"imgUrl"]];
                        [imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageRetryFailed|SDWebImageContinueInBackground];
                        imgView.contentMode=UIViewContentModeScaleAspectFill;
                    }
                }
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        
    }];
}


#pragma mark ---------------懂个球宣传位----------------

-(void)getDgqOlympic{
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getDgqOlympicInfo",@"parameters":@{}}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray *arr=[responseJSON objectForKey:@"result"];
            if([arr count]!=0){
                for (NSDictionary *dic in arr) {
                    DgqOlympicMdl *dgqOlympicMdl=[DgqOlympicMdl dgqOlympicMdlWithDic:dic];
                    _dgqOlympicMdl=dgqOlympicMdl;
                    
                    _olympicXcView.hidden=NO;
                    CGRect rect=_olympicXcView.frame;
                    rect.origin.y=ORIGIN_Y(_dgqBgView)+6.0;
                    rect.size.height=60;
                    [_olympicXcView setFrame:rect];
                    
                    CGFloat originX=0.0;
                    CGFloat originY=0.0;
                    UILabel *lab=(UILabel *)[_olympicXcView viewWithTag:EVENTNAME];
                    lab.text=dgqOlympicMdl.leagueName;
                    CGSize olympicSize=[PublicMethod setNameFontSize:dgqOlympicMdl.leagueName andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
                    rect=lab.frame;
                    rect.origin.y=24-olympicSize.height;
                    rect.size.width=olympicSize.width;
                    rect.size.height=olympicSize.height;
                    [lab setFrame:rect];
                    originX=ORIGIN_X(lab);
                    originY=rect.origin.y;
                    
                    lab=(UILabel *)[_olympicXcView viewWithTag:EVENTTIME];
                    lab.text=dgqOlympicMdl.matchTime;
                    CGSize timeSize=[PublicMethod setNameFontSize:dgqOlympicMdl.matchTime andFont:FONTEIGHTEEN andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
                    rect=lab.frame;
                    rect.origin.x=originX+12;
                    rect.origin.y=originY+olympicSize.height-timeSize.height;
                    rect.size.width=timeSize.width;
                    rect.size.height=timeSize.height;
                    [lab setFrame:rect];
                    
                    lab=(UILabel *)[_olympicXcView viewWithTag:PARTIESOFEVENT];
                    lab.text=dgqOlympicMdl.playInfo;
                    olympicSize=[PublicMethod setNameFontSize:dgqOlympicMdl.playInfo andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
                    rect=lab.frame;
                    rect.size.width=olympicSize.width;
                    rect.size.height=olympicSize.height;
                    [lab setFrame:rect];
                    originX=ORIGIN_X(lab);
                    originY=rect.origin.y;
                    
                    lab=(UILabel *)[_olympicXcView viewWithTag:EVENTNUM];
                    lab.text=dgqOlympicMdl.ccid;
                    timeSize=[PublicMethod setNameFontSize:dgqOlympicMdl.ccid andFont:FONTEIGHTEEN andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
                    rect=lab.frame;
                    rect.origin.x=originX+12;
                    rect.origin.y=originY+olympicSize.height-timeSize.height;
                    rect.size.width=timeSize.width;
                    rect.size.height=timeSize.height;
                    [lab setFrame:rect];
                }
            }else{
                _olympicXcView.hidden=YES;
                CGRect rect=_olympicXcView.frame;
                rect.origin.y=ORIGIN_Y(_dgqBgView);
                rect.size.height=0;
                [_olympicXcView setFrame:rect];
                
                UILabel *lab=(UILabel *)[_olympicXcView viewWithTag:EVENTNAME];
                rect=lab.frame;
                rect.size.width=0.0;
                [lab setFrame:rect];
                
                lab=(UILabel *)[_olympicXcView viewWithTag:EVENTTIME];
                rect=lab.frame;
                rect.size.width=0.0;
                [lab setFrame:rect];
                
                lab=(UILabel *)[_olympicXcView viewWithTag:PARTIESOFEVENT];
                rect=lab.frame;
                rect.size.width=0.0;
                [lab setFrame:rect];
                
                lab=(UILabel *)[_olympicXcView viewWithTag:EVENTNUM];
                rect=lab.frame;
                rect.size.width=0.0;
                [lab setFrame:rect];
            }
            CGRect rect=_headPortView.frame;
            rect.origin.y=ORIGIN_Y(_olympicXcView)+6.0;
            [_headPortView setFrame:rect];
            
            rect=bgSegment.frame;
            rect.origin.y=ORIGIN_Y(_headPortView);
            [bgSegment setFrame:rect];
            
            if (_noReconView) {
                [_noReconView setFrame:CGRectMake(0, ORIGIN_Y(bgSegment), 320, 200)];
            }
            rect=_recHeadView.frame;
            rect.size.height=CGRectGetMaxY(bgSegment.frame);
            [_recHeadView setFrame:rect];
            [_tableView setTableHeaderView:_recHeadView];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        
    }];
}

#pragma mark -----------UITableViewDataSource-------------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger noRow=0;
    if ([_lotteryType isEqualToString:@"001"]) {
        if ([_expLoType isEqualToString:@"-201"]) {
            noRow=_jcExpList.count;
        }else if([_expLoType isEqualToString:@"201"]){
            noRow=_ypExpList.count;
        }else if([_expLoType isEqualToString:@"204"]){
            noRow=_lcExpList.count;
        }
    }else{
        noRow=_szcExpList.count;
    }
    if ((58+45*MyWidth/320)*noRow<MyHight-HEIGHTBELOESYSSEVER-93) {
#if !defined DONGGEQIU
        [bgSegment removeFromSuperview];
        [bgSegment setFrame:CGRectMake(0.0, ORIGIN_Y(_gqView), MyWidth, 45)];
        [_recHeadView addSubview:bgSegment];
#endif
    }
    return noRow;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpertDetailCell * cell=[ExpertDetailCell ExpertDetailCellWithTableView:tableView indexPath:indexPath];
    
    ExpertJingjiModel *expertList;
    if ([_lotteryType isEqualToString:@"001"]) {
        if ([_expLoType isEqualToString:@"-201"]) {
            if (indexPath.row < [_jcExpList count]) {
                expertList = [_jcExpList objectAtIndex:indexPath.row];
            }
        }else if ([_expLoType isEqualToString:@"201"]) {
            if (indexPath.row < [_ypExpList count]) {
                expertList = [_ypExpList objectAtIndex:indexPath.row];
            }
        }else if ([_expLoType isEqualToString:@"204"]) {
            if (indexPath.row < [_lcExpList count]) {
                expertList = [_lcExpList objectAtIndex:indexPath.row];
            }
        }
    }else{
        if (indexPath.row < [_szcExpList count]) {
            expertList = [_szcExpList objectAtIndex:indexPath.row];
        }
    }
    
    NSString *compTime=@"";
    NSString *odds=@"";
    NSString *matchs=@"";
    
    CGRect rect=cell.timeLab.frame;
    
    if([_lotteryType isEqualToString:@"001"]){
        cell.zhongView.hidden=NO;
        cell.leagueTypeLab.hidden=NO;
        
        odds=[NSString stringWithFormat:@"%@中%@",expertList.ALL_HIT_NUM,expertList.HIT_NUM];
        matchs=[NSString stringWithFormat:@"%@ VS %@",expertList.HOME_NAME,expertList.AWAY_NAME];
        
        compTime=[NSString stringWithFormat:@"%@ %@",expertList.MATCHES_ID,expertList.MATCH_TIME];
        rect.size.width=100;
    }else if([_lotteryType isEqualToString:@"002"]){
        cell.zhongView.hidden=NO;
        odds=[NSString stringWithFormat:@"%@中%@",expertList.ALL_HIT_NUM,expertList.HIT_NUM];
        cell.leagueTypeLab.hidden=YES;
        
        matchs=[NSString stringWithFormat:@"%@ %@期", [NSString lotteryTpye:expertList.LOTTEY_CLASS_CODE],expertList.ER_ISSUE];
        compTime=[NSString stringWithFormat:@"截止时间 %@",expertList.END_TIME];
        rect.size.width=150;
    }
    [cell.timeLab setFrame:rect];
    
    if ([_expLoType isEqualToString:@"201"]){
        NSString *matchs2=[NSString stringWithFormat:@"%@ VS %@",expertList.HOME_NAME2,expertList.AWAY_NAME2];
        
        NSString *compTime2=[NSString stringWithFormat:@"%@ %@",expertList.MATCHES_ID2,expertList.MATCH_TIME2];
        [cell expertHead:expertList.HEAD_PORTRAIT name:expertList.EXPERTS_NICK_NAME starNo:expertList.STAR odds:odds matchSides:matchs time:compTime leagueType:expertList.LEAGUE_NAME exPrice:expertList.PRICE exDiscount:expertList.DISCOUNT exRank:expertList.SOURCE refundOrNo:expertList.FREE_STATUS lotype:_expLoType name2:matchs2 time2:compTime2 league2:expertList.LEAGUE_NAME2];
    }else{
        if([_expLoType isEqualToString:@"204"]){//篮球
            NSString *str = @"让分胜负";
            if([expertList.PLAY_TYPE_CODE isEqualToString:@"29"]){
                str = @"大小分";
            }
            matchs=[NSString stringWithFormat:@"%@(客)VS%@(主) \n%@ %@",expertList.AWAY_NAME,expertList.HOME_NAME,str,expertList.HOSTRQ];
        }
        [cell expertHead:expertList.HEAD_PORTRAIT name:expertList.EXPERTS_NICK_NAME starNo:expertList.STAR odds:odds matchSides:matchs time:compTime leagueType:expertList.LEAGUE_NAME exPrice:expertList.PRICE exDiscount:expertList.DISCOUNT exRank:expertList.SOURCE refundOrNo:expertList.FREE_STATUS lotype:_expLoType];
    }
    
    return  cell;
    
//    if ([_lotteryType isEqualToString:@"001"]) {
//        ExpertJingjiModel *expertList;
//        if ([_expLoType isEqualToString:@"-201"]) {
//            if (indexPath.row < [_jcExpList count]) {
//                expertList = [_jcExpList objectAtIndex:indexPath.row];
//            }
//        }else if ([_expLoType isEqualToString:@"201"]) {
//            if (indexPath.row < [_ypExpList count]) {
//                expertList = [_ypExpList objectAtIndex:indexPath.row];
//            }
//        }
//        NSString * starCell = @"expertHomeCell";
//        ExpertMainListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:starCell];
//        if (!cell) {
//            cell = [[ExpertMainListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:starCell];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        
//        cell.isZhuanjia = YES;
//        
//        __block ExpertViewController * newSelf = self;
//        cell.buttonAction = ^(UIButton *button) {
//            
//            [newSelf getIsBuyInfoWithOrderID:expertList];
//        };
//        
//        [cell loadYuecaiExpertListInfo:expertList];
//        
//        return cell;
//    }else{
//        ExpertDetailCell * cell=[ExpertDetailCell ExpertDetailCellWithTableView:tableView indexPath:indexPath];
//        ExpertJingjiModel *expertList;
//        if (indexPath.row < [_szcExpList count]) {
//            expertList = [_szcExpList objectAtIndex:indexPath.row];
//        }
//        
//        NSString *compTime=@"";
//        NSString *odds=@"";
//        NSString *matchs=@"";
//        
//        CGRect rect=cell.timeLab.frame;
//        
//        cell.zhongView.hidden=NO;
//        odds=[NSString stringWithFormat:@"%@中%@",expertList.ALL_HIT_NUM,expertList.HIT_NUM];
//        cell.leagueTypeLab.hidden=YES;
//        
//        matchs=[NSString stringWithFormat:@"%@ %@期", [NSString lotteryTpye:expertList.LOTTEY_CLASS_CODE],expertList.ER_ISSUE];
//        compTime=[NSString stringWithFormat:@"截止时间 %@",expertList.END_TIME];
//        rect.size.width=150;
//        
//        [cell.timeLab setFrame:rect];
//        
//        [cell expertHead:expertList.HEAD_PORTRAIT name:expertList.EXPERTS_NICK_NAME starNo:expertList.STAR odds:odds matchSides:matchs time:compTime leagueType:expertList.LEAGUE_NAME exPrice:expertList.PRICE exDiscount:expertList.DISCOUNT exRank:expertList.SOURCE refundOrNo:expertList.FREE_STATUS lotype:_expLoType];
//        
//        return  cell;
//    }
}

#pragma mark -----------UITableViewDelegate--------------
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 45;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc]init];
//    view.frame = CGRectMake(0, 0, 320, 45);
//    view.backgroundColor = [UIColor cyanColor];
//    
//    return view;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([_lotteryType isEqualToString:@"001"]){
//        return 110;
//    }else{
//        return 58+45*MyWidth/320;
//    }
    if ([_expLoType isEqualToString:@"201"]){
        return 58+45*MyWidth/320+56;
    }
    return 58+45*MyWidth/320;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ExpertDetailCell *cell=(ExpertDetailCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.userInteractionEnabled=NO;
    
    ExpertJingjiModel *expertList;
    if ([_lotteryType isEqualToString:@"001"]) {
        if ([_expLoType isEqualToString:@"-201"]) {
            expertList = [_jcExpList objectAtIndex:indexPath.row];
        }else if ([_expLoType isEqualToString:@"201"]){
            expertList = [_ypExpList objectAtIndex:indexPath.row];
        }else if ([_expLoType isEqualToString:@"204"]){
            expertList = [_lcExpList objectAtIndex:indexPath.row];
        }
    }else{
        expertList = [_szcExpList objectAtIndex:indexPath.row];
    }
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    if (_jcBtn.selected) {
        [MobClick event:@"Zj_zishen_20161014_jingcai" label:expertList.EXPERTS_NICK_NAME];
    }
    else if (_lcBtn.selected) {
        [MobClick event:@"Zj_zishen_20161014_lancai" label:expertList.EXPERTS_NICK_NAME];
    }
    else if (_ypBtn.selected) {
        [MobClick event:@"Zj_zishen_20161014_yapan" label:expertList.EXPERTS_NICK_NAME];
    }
    else if (_szcBtn.selected) {
        [MobClick event:@"Zj_zishen_20161014_shuzicai" label:expertList.EXPERTS_NICK_NAME];
        
    }
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
    [bodyDic setObject:@{@"expertsName":expertList.EXPERTS_NAME,@"expertsClassCode":_lotteryType,@"loginUserName":nameSty,@"erAgintOrderId":expertList.ER_AGINT_ORDER_ID,@"type":@"0",@"sid":info.cbSID,@"lotteryClassCode":_expLoType} forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        cell.userInteractionEnabled=YES;
        SMGDetailViewController * vc=[[SMGDetailViewController alloc]init];
        NSDictionary *dic=responseJSON[@"result"][@"expertBaseInfo"];
        ExpertBaseInfo *exBase=[ExpertBaseInfo expertBaseInfoWithDic:dic];
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
            vc.planIDStr=expertList.ER_AGINT_ORDER_ID;
            vc.jcyplryType=_expLoType;
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
            
            ExpertJingjiModel *supExMdl=[_szcExpList objectAtIndex:indexPath.row];
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

//滚动视图切换页
- (void)pageValueChange:(id)sender{
    currentPage=_pageControl.currentPage;
    CGPoint offset=CGPointMake(currentPage*320.0f, 0.0f);
//    [_scrollView setContentOffset:offset animated:YES];
    [_zhuanjiaScro setContentOffset:offset animated:YES];
}

-(void)scrollImg
{
    int offsetHeight=0;
    if((_scrollView.contentOffset.x + MyWidth) >(_photoImageArr.count-1)*MyWidth){
        [_scrollView setContentOffset:CGPointMake(0, offsetHeight) animated:YES];
    }else{
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + MyWidth, offsetHeight) animated:YES];
    }
}

#pragma mark 刷新
- (void)setupRefresh
{
    //下拉刷新
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_tableView.header];
    
    //上拉加载
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_tableView.footer];
    
}

#pragma mark 开始进入刷新状态
- (void)NearheaderRereshing
{
    MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)_tableView.footer;
    f.stateLabel.font=[UIFont systemFontOfSize:17.0f];
    if ([_lotteryType isEqualToString:@"001"]) {
        if ([_expLoType isEqualToString:@"-201"]) {
            jCPageNum = 1;
        }else if ([_expLoType isEqualToString:@"204"]) {
            lcPageNum = 1;
        }else if ([_expLoType isEqualToString:@"201"]) {
            ypPageNum = 1;
            [self getErchuanyiExpertRequestWithPage:@"1"];
            return;
        }
    }else if([_lotteryType isEqualToString:@"002"]){
        szcPageNum = 1;
    }
    [self getExpertList:@"1"];
}

#pragma mark - 加载
- (void)NearfooterRereshing
{
    if ([_lotteryType isEqualToString:@"001"]) {
        if ([_expLoType isEqualToString:@"-201"]) {
            if (jCPageNum ==[_jcTotalPg intValue]) {
                [_tableView.footer noticeNoMoreData];
                MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)_tableView.footer;
                f.stateLabel.font=FONTTWENTY_FOUR;
                [f setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
                [f setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
                [f setTitle:@"没有更多啦,去看看高手方案" forState:MJRefreshStateNoMoreData];
                return;
            }
            [self getExpertList:[NSString stringWithFormat:@"%ld",(long)jCPageNum + 1]];
        }else if ([_expLoType isEqualToString: @"204"]){
            if (lcPageNum ==[_lcTotalPg intValue]) {
                [_tableView.footer noticeNoMoreData];
                MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)_tableView.footer;
                f.stateLabel.font=FONTTWENTY_FOUR;
                [f setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
                [f setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
                [f setTitle:@"没有更多啦,去看看高手方案" forState:MJRefreshStateNoMoreData];
                return;
            }
            [self getExpertList:[NSString stringWithFormat:@"%ld",(long)lcPageNum + 1]];
            
        }else if ([_expLoType isEqualToString: @"201"]){
            if (ypPageNum ==[_ypTotalPg intValue]) {
                [_tableView.footer noticeNoMoreData];
                MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)_tableView.footer;
                f.stateLabel.font=FONTTWENTY_FOUR;
                [f setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
                [f setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
                [f setTitle:@"没有更多啦,去看看高手方案" forState:MJRefreshStateNoMoreData];
                return;
            }
//            [self getExpertList:[NSString stringWithFormat:@"%ld",(long)ypPageNum + 1]];
            [self getErchuanyiExpertRequestWithPage:[NSString stringWithFormat:@"%ld",(long)ypPageNum + 1]];
            
        }
    }else{
        if (szcPageNum ==[_szcTotalPg intValue]) {
            [_tableView.footer noticeNoMoreData];
            MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)_tableView.footer;
            f.stateLabel.font=FONTTWENTY_FOUR;
            [f setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
            [f setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
            [f setTitle:@"没有更多啦,去看看高手方案" forState:MJRefreshStateNoMoreData];
            return;
        }
        [self getExpertList:[NSString stringWithFormat:@"%ld",(long)szcPageNum + 1]];
    }
}

//自适应文本大小
- (CGSize)getSizeByText:(NSString *)text font:(UIFont *)textFont constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if(IS_IOS7){
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        NSMutableParagraphStyle *paragraphStyle= [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:textFont, NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName, nil];
        CGRect rect = [text boundingRectWithSize:size options:options attributes:dic context:nil];
        return rect.size;
    }else{
        return [text sizeWithFont:textFont constrainedToSize:size lineBreakMode:lineBreakMode];
    }
}

- (void)backClick:(id)sender{
    if ([self.navigationController isKindOfClass:[MLNavigationController class]]) {
        MLNavigationController *nlnav=(MLNavigationController *)self.navigationController;
        nlnav.canDragBack=YES;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backaction" object:self];
}

/**
 *  UIAlertView自动消失处理代码
 */
-(void)dimissAlert:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}

-(void)toLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
}

#pragma mark --------------UIScrollViewDelegate-----------------

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(scrollView==_scrollView){
        [timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView==_scrollView){
        NSDate *delay = [[NSDate alloc] initWithTimeIntervalSinceNow:2];
        [timer setFireDate:delay];
        //[_scrollView setContentOffset:CGPointMake(MyWidth, 0) animated:NO];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(scrollView==_scrollView){
        NSDate *delay = [[NSDate alloc] initWithTimeIntervalSinceNow:2];
        [timer setFireDate:delay];
        //[_scrollView setContentOffset:CGPointMake(MyWidth, 0) animated:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView==_scrollView){
        CGPoint offset=scrollView.contentOffset;
        NSInteger page=offset.x/MyWidth;
        _pageControl.currentPage=page;
    }else if (scrollView == _zhuanjiaScro){
        CGPoint offset=scrollView.contentOffset;
        NSInteger page=offset.x/MyWidth;
        _pageControl.currentPage=page;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
#if !defined DONGGEQIU
    if (scrollView.tag==LISTTABLETAG) {
        if (velocity.y>=0&&targetContentOffset->y>=(ORIGIN_Y(_gqView)+CGRectGetMinY(_recHeadView.frame))) {
            [bgSegment removeFromSuperview];
            [self.view addSubview:bgSegment];
            [bgSegment setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, 45)];
            [self.view bringSubviewToFront:bgSegment];

            CGRect rect=_recHeadView.frame;
            rect.size.height=CGRectGetMaxY(_gqView.frame);
            [_recHeadView setFrame:rect];

        }else if(velocity.y<=0&&targetContentOffset->y<=(ORIGIN_Y(_gqView)+CGRectGetMinY(_recHeadView.frame))) {
            [bgSegment removeFromSuperview];
            [bgSegment setFrame:CGRectMake(0.0, ORIGIN_Y(_gqView), MyWidth, 45)];
            [_recHeadView addSubview:bgSegment];
            
            CGRect rect=_recHeadView.frame;
            rect.size.height=CGRectGetMaxY(bgSegment.frame);
            [_recHeadView setFrame:rect];
        }
        _tableView.tableHeaderView=_recHeadView;
    }
#endif
}

//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    CGPoint offset=scrollView.contentOffset;
//    if (offset.x>=MyWidth*3/2||velocity.x>0) {
//        _currentIndex++;
//        if (_currentIndex > _adImgArr.count-1)
//            _currentIndex = 0;
//
//        NSString *str=[NSString stringWithFormat:@"%@",[_adImgArr objectAtIndex:_currentIndex]];
//        [self str:str imgView:_curImgView];
//
//        NSInteger index=_currentIndex;
//        if (_currentIndex!=0) {
//            str = [NSString stringWithFormat:@"%@",[_adImgArr objectAtIndex:_currentIndex-1]];
//            index=_currentIndex-1;
//        }else{
//            str = [NSString stringWithFormat:@"%@",[_adImgArr objectAtIndex:_adImgArr.count-1]];
//            index=_adImgArr.count-1;
//        }
//        [self str:str imgView:_preImgView];
//
//        if (_currentIndex==_adImgArr.count-1) {
//            str = [_adImgArr objectAtIndex:0];
//            index=0;
//        }else{
//            str = [_adImgArr objectAtIndex:_currentIndex+1];
//            index=_currentIndex+1;
//        }
//        [self str:str imgView:_nexImgView];
//
//    }else if(offset.x<MyWidth/2||velocity.x<0){
//
//        _currentIndex--;
//        if (_currentIndex < 0)
//            _currentIndex = _adImgArr.count-1;
//
//        NSString *str=[NSString stringWithFormat:@"%@",[_adImgArr objectAtIndex:_currentIndex]];
//        [self str:str imgView:_curImgView];
//
//        NSInteger index=_currentIndex;
//        if (_currentIndex!=0) {
//            str = [_adImgArr objectAtIndex:_currentIndex-1];
//            index=_currentIndex-1;
//        }else{
//            str = [_adImgArr objectAtIndex:_adImgArr.count-1];
//            index=_adImgArr.count-1;
//        }
//        [self str:str imgView:_preImgView];
//
//        if (_currentIndex==_adImgArr.count-1) {
//            str = [_adImgArr objectAtIndex:0];
//            index=0;
//        }else{
//            str = [_adImgArr objectAtIndex:_currentIndex+1];
//            index=_currentIndex+1;
//        }
//        [self str:str imgView:_nexImgView];
//    }
//}
//
//- (void)str:(NSString *)str imgView:(UIImageView *)view{
//    view.image=[UIImage imageNamed:str];
//}

-(void)touchCategoryButton:(UIButton *)button
{
    switch (button.tag) {
        case 100:
        {
//            OY_AllItemsViewController * controller = [[OY_AllItemsViewController alloc] init];
//            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 101:
        {
            LiveScoreViewController *lsViewController = [[LiveScoreViewController alloc] init];
            [self.navigationController pushViewController:lsViewController animated:YES];
        }
            break;
        case 102:
        {
//            GameCenterViewController * gc = [[GameCenterViewController alloc] init];
//            [self.navigationController pushViewController:gc animated:YES];
        }
            break;
        case 103:
        {
//            JingCaiYouXiViewController * gcjc = [[JingCaiYouXiViewController alloc] initWithLotteryID:1];
//            gcjc.systimestr = @"";
//            [self.navigationController pushViewController:gcjc animated:YES];
        }
            break;
        case 104:
        {
            [self toInformation];
        }
            break;

        default:
            break;
    }
}

-(void)toInformation
{
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        
        NSString *h5url = @"http://news.zgzcw.com/h5/c/zqfx16.html";

        MyWebViewController *webview = [[MyWebViewController alloc] init];
        [webview LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:h5url]]];
        webview.delegate= self;
        webview.needPopSupController = YES;
        webview.webTitle = @"资讯";
        webview.showExit = YES;
        [self.navigationController pushViewController:webview animated:YES];
        
    }
    else {
        
        [self toLogin];
        
    }
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
            proVC.pdLotryType = @"-201";
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
        proVC.isSdOrNo=NO;
        //        _nPlanBtn.paidStatus=@"1";
        [self.navigationController pushViewController:proVC animated:YES];
    }
}
-(void)getErchuanyiExpertRequestWithPage:(NSString *)page{
    
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    if(_noReconView){
        [_noReconView removeFromSuperview];
        _noReconView=nil;
        [_tableView setBackgroundColor:[UIColor whiteColor]];
    }
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"sid":[[Info getInstance] cbSID],
                                                                                       @"expertClassCode":@"001",
                                                                                       @"lotteryClassCode":@"201",
                                                                                       @"curPage":page,
                                                                                       @"pageSize":@"20"}];
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getCrazySportExpertsPlanList",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        _tableView.userInteractionEnabled=YES;
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[[responseJSON valueForKey:@"result"] valueForKey:@"data"];
            if ([result count]!=0) {
                
                NSMutableArray *mutableArr = [self reloadArrayWithAry:result];
                if ([page isEqualToString:@"1"]) {
                    [_ypExpList removeAllObjects];
                    _ypExpList=nil;
                    _ypExpList=mutableArr;
                }else{
                    ypPageNum++;
                    [_ypExpList addObjectsFromArray:mutableArr];
                }
                
                [_tableView reloadData];
            }
            else{
                if([page isEqualToString:@"1"]){
#if !defined DONGGEQIU
                    [bgSegment removeFromSuperview];
                    [bgSegment setFrame:CGRectMake(0.0, ORIGIN_Y(_gqView), MyWidth, 45)];
                    [_recHeadView addSubview:bgSegment];
#endif
                    _noReconView=[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(bgSegment), 320, 200)];
                    _noReconView.backgroundColor=[UIColor clearColor];
                    [_recHeadView addSubview:_noReconView];
                    
                    UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(125, 20, 70, 92.5)];
                    imgV.image=[UIImage imageNamed:@"norecon"];
                    [_noReconView addSubview:imgV];
                    
                    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(60, ORIGIN_Y(imgV)+10, 200, 40)];
                    lab.backgroundColor=[UIColor clearColor];
                    lab.text=@"专家正在发布方案中";
                    lab.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
                    lab.textAlignment=NSTextAlignmentCenter;
                    lab.font=FONTTHIRTY_TWO;
                    [_noReconView addSubview:lab];
                    [_tableView setBackgroundColor:[UIColor colorWithHexString:@"ecedf1"]];
                }
            }
            [_tableView reloadData];
        }else{
            [_tableView reloadData];
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.footer endRefreshing];
            [_tableView.header endRefreshing];
        });
    } failure:^(NSError * error) {
        _tableView.userInteractionEnabled=YES;
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.footer endRefreshing];
            [_tableView.header endRefreshing];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    