//
//  CompeteViewController.m
//  Experts
//
//  Created by mac on 15/11/13.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "CompeteViewController.h"
#import "MBProgressHUD+MJ.h"
#import "LoginViewController.h"

#define LOTRYTAG 300
#define TIMETAG 301
#define LEAGUETAG 302
#define MATCHTAG 303
#define GAMETAG 304
#define RESECTAG 305
#define PLANTITLETEXTVIEWTAG 1001
#define PLANREASONTEXTVIEWTAG 1002

@interface CompeteViewController (){
    CGSize remSize;
    
    UIScrollView *_rightScroll;
    UITextView *planTitView;
    UITextView *reasonView;
    
    UILabel *lotryTypeLab;//选择彩种
    UILabel *matchTimeLab;//选择比赛时间框
    UILabel *leagueLab;//选则赛事框
    UILabel *matchNameLab;//选择比赛框
    UILabel *curGameMethLab;//选择当前玩法框
    UILabel *recSdLab;//选择推荐神单框
    
    UILabel *priceLab;
    UILabel *discountLab;
    
    UIButton *commitBtn;
}

@property(nonatomic,strong)UILabel *markWarnlab;

@property(nonatomic,strong)UIView *pAndmacthView;//赛事比赛背景View

@property(nonatomic,strong)UIView *pStyleAndRView;//玩法赛果背景View

@property(nonatomic,strong)UIView *planView;//方案标题背景View
@property(nonatomic,strong)UIView *remView;//推荐理由背景View
@property(nonatomic,strong)UIView *lineRecm;//推荐理由分割线

@property(nonatomic,strong)UIView *pAndcView;//价格和折扣背景View

@property(nonatomic,strong)UIView *refundView;//不中退款背景View
@property(nonatomic,strong)UILabel *refundLab;//不中退款背景lab

@property(nonatomic,strong)UILabel *palyLab;//推荐玩法
@property(nonatomic,strong)UILabel *remLab;//推荐赛事

@property(nonatomic,strong)V1PickerView *picker;

@property(nonatomic,strong)UIButton *leftWin;//胜
@property(nonatomic,strong)UIButton *rightWin;//负
@property(nonatomic,strong)UIButton *midWin;//平

@property(nonatomic,strong)UIButton *probleBtn;//问号btn

@property(nonatomic,strong)NSString *sourceStr;//区分不同的专家类型

@property(nonatomic,strong)NSDictionary *leagueList;//联赛种类列表
@property(nonatomic,strong)NSDictionary *matchList;//获取比赛列表

@property(nonatomic,strong)NSMutableArray *lotryTypeArr;//彩种数组
@property(nonatomic,strong)NSMutableArray *leagueArr;//联赛种类列表
@property(nonatomic,strong)NSMutableArray *matchTimeArr;//联赛时间列表
@property(nonatomic,strong)NSMutableArray *leagueNameArr;//联赛名称列表
@property(nonatomic,strong)NSMutableArray *matchArr;//比赛列表
@property(nonatomic,strong)NSMutableArray *matchIdArr;//比赛id列表
@property(nonatomic,strong)NSMutableArray *playIdArr;//playId列表
@property(nonatomic,strong)NSMutableArray *prizeNameArr;//价格数组
@property(nonatomic,strong)NSMutableArray *priceNoArr;//
@property(nonatomic,strong)NSMutableArray *discountArr;//折扣数组
@property(nonatomic,strong)NSMutableArray *playWay;//玩法数组

@property(nonatomic,strong)NSArray *sdIsOrNoArr;//是否推荐神单

@property(nonatomic,strong)NSArray *priceDic;//选择比赛的价格
@property(nonatomic,strong)NSArray *discountDic;//选择比赛折扣价格

@property(nonatomic,strong)NSString *priceId;//方案的价格
@property(nonatomic,strong)NSString *discountId;//方案的折扣

@property(nonatomic,strong)NSString *selectPriceStr;//选择的价格
@property(nonatomic,strong)NSString *selectMatch;//选中比赛名称
@property(nonatomic,strong)NSString *selectDiscountStr;//选择的折扣
@property(nonatomic,strong)NSString *selectPlayWay;//选择的玩法

@property(nonatomic,strong)NSString *pickType;//弹窗标记

@property(nonatomic,strong)NSMutableArray *xqResult;//选球结果及赔率

//亚盘属性
@property(nonatomic,strong)UILabel *infoSourceLab;//澳彩Label;

@property(nonatomic,strong)UIButton *ypoLefBtn;//亚盘第一行左边btn
@property(nonatomic,strong)UILabel *ypoLabel;//亚盘第一行label
@property(nonatomic,strong)UIButton *ypoRigBtn;//亚盘第一行右边btn

@property(nonatomic,strong)UIButton *yptLefBtn;//亚盘第二行左边btn
@property(nonatomic,strong)UILabel *yptLabel;//亚盘第二行label
@property(nonatomic,strong)UIButton *yptRigBtn;//亚盘第二行右边btn

@property(nonatomic,strong)NSArray *ypsflv;//亚盘胜负率数组
@property(nonatomic,strong)NSString *firstStr;//第一组胜负赔率
@property(nonatomic,strong)NSString *secStr;//第二组胜负赔率

@property(nonatomic,strong)NSString *ypSaiGuo;//选择的亚盘赛过
@property(nonatomic,strong)NSString *ypsflvSel;//选择的亚盘胜负率

@property(nonatomic,strong)NSString *tjsdOrNo;//是否支持推荐神单(1:是,0:否);

@property(nonatomic,strong)NSString *singleSelectOdds;//单选赔率
@property(nonatomic,strong)NSString *doubleSelectOdds;//双选赔率

@end

@implementation CompeteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
    [self setTitle_nav:@"发布方案"];
    [self creatNavView];
    
    NSDictionary *sourceDic=nil;
    if ([DEFAULTS objectForKey:@"resultDic"] && [[DEFAULTS objectForKey:@"resultDic"] isKindOfClass:[NSDictionary class]] && [[DEFAULTS objectForKey:@"resultDic"] allKeys]!= nil&&
        ![[DEFAULTS objectForKey:@"resultDic"] isEqualToDictionary:[NSDictionary dictionary]]) {
        sourceDic = [DEFAULTS objectForKey:@"resultDic"];
        self.sourceStr =sourceDic[@"source"];
    }
    if ([self.sourceStr isEqualToString:@"1"]) {
        if([_jc_TdPubNo intValue]==3){
            self.lotryTypeArr=[NSMutableArray arrayWithObjects:@"亚盘", nil];
            _lotrySource=@"202";
        }else if ([_yp_TdPubNo intValue]==3){
            self.lotryTypeArr=[NSMutableArray arrayWithObjects:@"竞彩", nil];
            _lotrySource=@"-201";
        }else{
            if ([_lotrySource isEqualToString:@""]||_lotrySource==nil) {
                _lotrySource=@"-201";
            }
            self.lotryTypeArr=[NSMutableArray arrayWithObjects:@"竞彩", @"亚盘", nil];
        }
    }else{
        if ([_lotrySource isEqualToString:@""]||_lotrySource==nil) {
            _lotrySource=@"-201";
        }
        self.lotryTypeArr=[NSMutableArray arrayWithObjects:@"竞彩", @"亚盘", nil];
    }
    
    if ([self.sourceStr isEqualToString:@"1"]) {
        [self requestPulishNo];
    }

    if (!self.ypRq) {
        self.ypRq=@"";
    }
    if (!self.asianSp) {
        self.asianSp=@"";
    }
    if (!_playType) {
        _playType=@"";
    }
    if (!_supportOrNo) {
        _supportOrNo=@"0";
    }
    if (!_nameAndTimeStr) {
        _nameAndTimeStr=@"请选择比赛";
    }
    self.ypsflvSel=@"";
    self.ypSaiGuo=@"";
    self.firstStr=@"";
    self.secStr=@"";
    NSDictionary *dic=[DEFAULTS objectForKey:@"resultDic"];
    if ([_lotrySource isEqualToString:@"-201"]){
        _tjsdOrNo=[dic objectForKey:@"sdJcStatus"];
    }else if ([_lotrySource isEqualToString:@"202"]){
        _tjsdOrNo=[dic objectForKey:@"sdYpStatus"];
    }

    self.playWay=[NSMutableArray arrayWithObjects:@"胜平负", @"让球胜平负", nil];
    self.sdIsOrNoArr=[NSArray arrayWithObjects:@"是", @"否", nil];

    self.xqResult = [NSMutableArray array];
    self.leagueArr = [NSMutableArray array];
    self.matchTimeArr = [NSMutableArray array];
    self.leagueNameArr = [NSMutableArray array];
    self.matchArr = [NSMutableArray array];
    self.matchIdArr = [NSMutableArray array];
    self.playIdArr = [NSMutableArray array];
    self.prizeNameArr =  [NSMutableArray array];
    self.priceNoArr = [NSMutableArray array];
    self.discountArr =  [NSMutableArray array];
    self.priceDic = [NSArray array];
    self.discountDic = [NSArray array];

    _rightScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, MyHight-64)];
    _rightScroll.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [self.view addSubview:_rightScroll];
    
//    UILabel *pleaseLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MyWidth, 35)];
//    pleaseLab.backgroundColor =  [UIColor colorWithHexString:@"f7f7f7"];
//    pleaseLab.text = [self seletWorkAndTime];
//    pleaseLab.font = FONTTWENTY_FOUR;
//    pleaseLab.textColor=BLACK_EIGHTYSEVER;
//    [_rightScroll addSubview:pleaseLab];
    
    _pAndmacthView=[[UIView alloc] init];
    if ([_tjsdOrNo isEqualToString:@"0"]) {
        _tjsd=@"0";
        [_pAndmacthView setFrame:CGRectMake(0, 0, MyWidth, 231)];
    }else{
        [_pAndmacthView setFrame:CGRectMake(0, 0, MyWidth, 277)];
    }
    _pAndmacthView.backgroundColor=[UIColor whiteColor];
    _pAndmacthView.layer.borderWidth=0.5;
    _pAndmacthView.layer.borderColor=SEPARATORCOLOR.CGColor;
    _pAndmacthView.userInteractionEnabled=YES;
    [_rightScroll addSubview:_pAndmacthView];
    
    //选择彩种
    lotryTypeLab=[[UILabel alloc] initWithFrame:CGRectMake(15, 0.5, MyWidth-15, 46)];
    lotryTypeLab.font = FONTTHIRTY;
    lotryTypeLab.textColor=BLACK_EIGHTYSEVER;
    lotryTypeLab.backgroundColor=[UIColor whiteColor];
    lotryTypeLab.tag=LOTRYTAG;
    [_pAndmacthView addSubview:lotryTypeLab];
    
    UITapGestureRecognizer *lotryTypeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labClickTap:)];
    lotryTypeTap.numberOfTapsRequired = 1;
    lotryTypeTap.numberOfTouchesRequired = 1;
    lotryTypeTap.delegate = self;
    lotryTypeLab.userInteractionEnabled = YES;
    [lotryTypeLab addGestureRecognizer:lotryTypeTap];
    if ([_lotrySource isEqualToString:@"-201"]) {
        lotryTypeLab.text = @"当前彩种：竞彩";
    }else if([_lotrySource isEqualToString:@"202"]){
        lotryTypeLab.text = @"当前彩种：亚盘";
    }
    
    UIImage *img=[UIImage imageNamed:@"指示箭头"];
    UIImageView *arrowImgView=[[UIImageView alloc] initWithImage:img];
    arrowImgView.tag=200;
    [arrowImgView setFrame:CGRectMake(MyWidth-img.size.width-15, CGRectGetMinY(lotryTypeLab.frame)+23-img.size.height/2, img.size.width, img.size.height)];
    [_pAndmacthView addSubview:arrowImgView];
    
    UIView *line0 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lotryTypeLab.frame)-0.5, MyWidth, 0.5)];
    line0.backgroundColor = SEPARATORCOLOR;
    [_pAndmacthView addSubview:line0];
    
    //选择时间
    matchTimeLab=[[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(lotryTypeLab.frame), MyWidth-15, 46)];
    matchTimeLab.text = @"请选择时间";
    matchTimeLab.font = FONTTHIRTY;
    matchTimeLab.textColor=BLACK_EIGHTYSEVER;
    matchTimeLab.backgroundColor=[UIColor whiteColor];
    matchTimeLab.tag=TIMETAG;
    [_pAndmacthView addSubview:matchTimeLab];
    
    UITapGestureRecognizer *taplabTime = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labClickTap:)];
    taplabTime.numberOfTapsRequired = 1;
    taplabTime.numberOfTouchesRequired = 1;
    taplabTime.delegate = self;
    matchTimeLab.userInteractionEnabled = YES;
    [matchTimeLab addGestureRecognizer:taplabTime];
    
    arrowImgView=[[UIImageView alloc] initWithImage:img];
    arrowImgView.tag=201;
    [arrowImgView setFrame:CGRectMake(MyWidth-img.size.width-15, CGRectGetMinY(matchTimeLab.frame)+23-img.size.height/2, img.size.width, img.size.height)];
    [_pAndmacthView addSubview:arrowImgView];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(matchTimeLab.frame)-0.5, MyWidth, 0.5)];
    line1.backgroundColor = SEPARATORCOLOR;
    [_pAndmacthView addSubview:line1];
    
    //选择赛事和选择比赛
    leagueLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(matchTimeLab.frame), MyWidth-15, 46)];
    leagueLab.text = @"请选择赛事";
    leagueLab.font = FONTTHIRTY;
    leagueLab.textColor=BLACK_EIGHTYSEVER;
    leagueLab.backgroundColor=[UIColor whiteColor];
    leagueLab.tag=LEAGUETAG;
    [_pAndmacthView addSubview:leagueLab];
    
    //选择赛事
    UITapGestureRecognizer *taplabPlay = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labClickTap:)];
    taplabPlay.numberOfTapsRequired = 1;
    taplabPlay.numberOfTouchesRequired = 1;
    taplabPlay.delegate = self;
    leagueLab.userInteractionEnabled = YES;
    [leagueLab addGestureRecognizer:taplabPlay];
    
    arrowImgView=[[UIImageView alloc] initWithImage:img];
    arrowImgView.tag=202;
    [arrowImgView setFrame:CGRectMake(MyWidth-img.size.width-15, CGRectGetMinY(leagueLab.frame)+23-img.size.height/2, img.size.width, img.size.height)];
    [_pAndmacthView addSubview:arrowImgView];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(leagueLab.frame)-0.5, MyWidth, 0.5)];
    line2.backgroundColor = SEPARATORCOLOR;
    [_pAndmacthView addSubview:line2];
    
    matchNameLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(leagueLab.frame), MyWidth-15, 46)];
    matchNameLab.text = @"请选择比赛";
    matchNameLab.font = FONTTHIRTY;
    matchNameLab.textColor=BLACK_EIGHTYSEVER;
    matchNameLab.tag=MATCHTAG;
    matchNameLab.backgroundColor=[UIColor whiteColor];
    [_pAndmacthView addSubview:matchNameLab];
    
    //选择比赛
    UITapGestureRecognizer *taplabPlaytime = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labClickTap:)];
    taplabPlaytime.numberOfTapsRequired = 1;
    taplabPlaytime.numberOfTouchesRequired = 1;
    taplabPlaytime.delegate = self;
    matchNameLab.userInteractionEnabled = YES;
    [matchNameLab addGestureRecognizer:taplabPlaytime];
    
    arrowImgView=[[UIImageView alloc] initWithImage:img];
    arrowImgView.tag=203;
    [arrowImgView setFrame:CGRectMake(MyWidth-img.size.width-15, CGRectGetMinY(matchNameLab.frame)+23-img.size.height/2, img.size.width, img.size.height)];
    [_pAndmacthView addSubview:arrowImgView];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(matchNameLab.frame)-0.5, MyWidth, 0.5)];
    line3.backgroundColor = SEPARATORCOLOR;
    [_pAndmacthView addSubview:line3];
    
    curGameMethLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(matchNameLab.frame), MyWidth-15, 46)];
    curGameMethLab.font = FONTTHIRTY;
    curGameMethLab.textColor=BLACK_EIGHTYSEVER;
    curGameMethLab.backgroundColor=[UIColor whiteColor];
    curGameMethLab.tag=GAMETAG;
    curGameMethLab.text = @"当前玩法：胜平负";
    [_pAndmacthView addSubview:curGameMethLab];
    _playType=@"10";
    
    //选择比赛
    UITapGestureRecognizer *curGameMeth = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labClickTap:)];
    curGameMeth.numberOfTapsRequired = 1;
    curGameMeth.numberOfTouchesRequired = 1;
    curGameMeth.delegate = self;
    curGameMethLab.userInteractionEnabled = YES;
    [curGameMethLab addGestureRecognizer:curGameMeth];
    
    arrowImgView=[[UIImageView alloc] initWithImage:img];
    arrowImgView.tag=204;
    [arrowImgView setFrame:CGRectMake(MyWidth-img.size.width-15, CGRectGetMinY(curGameMethLab.frame)+23-img.size.height/2, img.size.width, img.size.height)];
    [_pAndmacthView addSubview:arrowImgView];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(curGameMethLab.frame)-0.5, MyWidth, 0.5)];
    line4.backgroundColor = SEPARATORCOLOR;
    line4.tag=105;
    [_pAndmacthView addSubview:line4];
    
    recSdLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(curGameMethLab.frame), MyWidth-15, 46)];
    recSdLab.font = FONTTHIRTY;
    recSdLab.textColor=BLACK_EIGHTYSEVER;
    recSdLab.backgroundColor=[UIColor whiteColor];
    recSdLab.tag=RESECTAG;
    if ([self.tjsd isEqualToString:@""]||self.tjsd==nil||[self.tjsd isEqualToString:@"1"]) {
        recSdLab.text = @"推荐神单：是";
        _tjsd=@"1";
    }else if([self.tjsd isEqualToString:@"0"]){
        recSdLab.text = @"推荐神单：否";
        _tjsd=@"0";
    }
    if([_tjsdOrNo isEqualToString:@"0"]){
        recSdLab.hidden=YES;
        _tjsd=@"0";
    }
    [_pAndmacthView addSubview:recSdLab];
    
    //选择比赛
    UITapGestureRecognizer *redSd = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labClickTap:)];
    redSd.numberOfTapsRequired = 1;
    redSd.numberOfTouchesRequired = 1;
    redSd.delegate = self;
    recSdLab.userInteractionEnabled = YES;
    [recSdLab addGestureRecognizer:redSd];
    
    arrowImgView=[[UIImageView alloc] initWithImage:img];
    arrowImgView.tag=205;
    if([_tjsdOrNo isEqualToString:@"0"]){
        arrowImgView.hidden=YES;
    }
    [arrowImgView setFrame:CGRectMake(MyWidth-img.size.width-15, CGRectGetMinY(recSdLab.frame)+23-img.size.height/2, img.size.width, img.size.height)];
    [_pAndmacthView addSubview:arrowImgView];
    
    [self makeUI];
    [self createTextView];
    
    [self requestOddsInfo];
}

-(void)makeUI
{
    self.pStyleAndRView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(_pAndmacthView.frame)+10, MyWidth, 47)];
    self.pStyleAndRView.backgroundColor = [UIColor whiteColor];
    _pStyleAndRView.layer.borderWidth=0.5;
    _pStyleAndRView.layer.borderColor=SEPARATORCOLOR.CGColor;
    [_rightScroll addSubview:self.pStyleAndRView];
    
    NSString *playStr = @"推荐赛果";
    CGSize  palySize = [PublicMethod setNameFontSize:playStr andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];

    self.remLab = [[UILabel alloc] initWithFrame:CGRectMake(15,23-palySize.height/2, palySize.width, palySize.height)];
    self.remLab.text = playStr;
    self.remLab.font=FONTTHIRTY;
    self.remLab.textColor=RGBAColor(0, 0, 0, 0.87);
    self.remLab.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
    [self.pStyleAndRView addSubview:self.remLab];
    
    self.leftWin = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftWin.frame =  CGRectMake(CGRectGetMaxX(self.remLab.frame)+15, 8, MyWidth*12/64, 30);
    [self.leftWin setBackgroundImage:[UIImage imageNamed:@"推荐赛果-按钮（常态）"] forState:normal];
    [self.leftWin setBackgroundImage:[UIImage imageNamed:@"推荐赛果-按钮（选中）"] forState:UIControlStateSelected];
    [self setBtnAttributedTit:@"胜" btn:self.leftWin];
    self.leftWin.titleLabel.font=FONTTHIRTY;
    self.leftWin.tag = 105;
    [self.pStyleAndRView addSubview:self.leftWin];
    
    self.midWin = [UIButton buttonWithType:UIButtonTypeCustom];
    self.midWin.frame = CGRectMake(CGRectGetMaxX(self.leftWin.frame)+5,self.leftWin.frame.origin.y, MyWidth*12/64, 30);
    [self.midWin setBackgroundImage:[UIImage imageNamed:@"推荐赛果-按钮（常态）"] forState:normal];
    [self.midWin setBackgroundImage:[UIImage imageNamed:@"推荐赛果-按钮（选中）"] forState:UIControlStateSelected];
    [self setBtnAttributedTit:@"平" btn:self.midWin];
    self.midWin.titleLabel.font=FONTTHIRTY;
    self.midWin.tag = 106;
    [self.pStyleAndRView addSubview:self.midWin];
    
    self.rightWin = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightWin.frame = CGRectMake(CGRectGetMaxX(self.midWin.frame)+5,self.leftWin.frame.origin.y, MyWidth*12/64, 30);
    [self.rightWin setBackgroundImage:[UIImage imageNamed:@"推荐赛果-按钮（常态）"] forState:normal];
    [self.rightWin setBackgroundImage:[UIImage imageNamed:@"推荐赛果-按钮（选中）"] forState:UIControlStateSelected];
    [self setBtnAttributedTit:@"负" btn:self.rightWin];
    self.rightWin.titleLabel.font=FONTTHIRTY;
    self.rightWin.tag = 107;
    [self.pStyleAndRView addSubview:self.rightWin];
    [self.leftWin  addTarget:self action:@selector(chooseSaiGuo:) forControlEvents:UIControlEventTouchUpInside];
    [self.midWin  addTarget:self action:@selector(chooseSaiGuo:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightWin  addTarget:self action:@selector(chooseSaiGuo:) forControlEvents:UIControlEventTouchUpInside];
    self.leftWin.userInteractionEnabled=NO;
    self.midWin.userInteractionEnabled=NO;
    self.rightWin.userInteractionEnabled=NO;
    
    self.probleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.probleBtn.frame = CGRectMake(CGRectGetMaxX(self.rightWin.frame),0,37,42);
    [self.probleBtn setImage:[UIImage imageNamed:@"推荐赛果问号"] forState:UIControlStateNormal];
    [self.probleBtn setImage:[UIImage imageNamed:@"推荐赛果问号"] forState:UIControlStateSelected];
    [self.probleBtn setBackgroundColor:[UIColor clearColor]];
    [self.probleBtn setImageEdgeInsets:UIEdgeInsetsMake(14, 8, 14, 15)];
    self.probleBtn.selected = YES;
    [self.probleBtn addTarget:self action:@selector(dispalyView:) forControlEvents:UIControlEventTouchUpInside];
    [self.pStyleAndRView addSubview:self.probleBtn];
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 35, MyWidth, 0.5)];
    view.backgroundColor=SEPARATORCOLOR;
    [_pStyleAndRView addSubview:view];
    
    CGSize size=[PublicMethod setNameFontSize:@"澳彩" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    UILabel *nameLab=[[UILabel alloc] initWithFrame:CGRectMake(15, 52.5, size.width, size.height)];
    nameLab.text=@"";
    nameLab.font=FONTTHIRTY;
    nameLab.textColor=BLACK_EIGHTYSEVER;
    [_pStyleAndRView addSubview:nameLab];
    _infoSourceLab=nameLab;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =  CGRectMake(CGRectGetMaxX(nameLab.frame)+15, ORIGIN_Y(view)+10, MyWidth*12/64, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"推荐赛果-按钮（常态）"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"推荐赛果-按钮（选中）"] forState:UIControlStateSelected];
    [self setBtnAttributedTit:@"主" btn:btn];
    btn.titleLabel.font=FONTTHIRTY;
    [self.pStyleAndRView addSubview:btn];
    self.ypoLefBtn=btn;
    
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.ypoLefBtn.frame)+10, self.ypoLefBtn.frame.origin.y, 60, 30)];
    lab.text=@"受球";
    lab.font=FONTTHIRTY;
    lab.layer.masksToBounds=YES;
    lab.layer.borderColor=SEPARATORCOLOR.CGColor;
    lab.layer.borderWidth=1.0;
    lab.layer.cornerRadius=5.0;
    lab.textAlignment=NSTextAlignmentCenter;
    lab.textColor=BLACK_EIGHTYSEVER;
    [self.pStyleAndRView addSubview:lab];
    self.ypoLabel=lab;
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetMaxX(self.ypoLabel.frame)+10, self.ypoLabel.frame.origin.y, MyWidth*12/64, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"推荐赛果-按钮（常态）"] forState:normal];
    [btn setBackgroundImage:[UIImage imageNamed:@"推荐赛果-按钮（选中）"] forState:UIControlStateSelected];
    [self setBtnAttributedTit:@"客" btn:btn];
    btn.titleLabel.font=FONTTHIRTY;
    [self.pStyleAndRView addSubview:btn];
    self.ypoRigBtn=btn;
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =  CGRectMake(CGRectGetMinX(self.ypoLefBtn.frame), CGRectGetMaxY(self.ypoLefBtn.frame)+10, MyWidth*12/64, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"推荐赛果-按钮（常态）"] forState:normal];
    [btn setBackgroundImage:[UIImage imageNamed:@"推荐赛果-按钮（选中）"] forState:UIControlStateSelected];
    [self setBtnAttributedTit:@"主" btn:btn];
    btn.titleLabel.font=FONTTHIRTY;
    [self.pStyleAndRView addSubview:btn];
    self.yptLefBtn=btn;
    
    lab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.yptLefBtn.frame)+10, CGRectGetMaxY(self.ypoLabel.frame)+10, 60, 30)];
    lab.text=@"受球";
    lab.font=FONTTHIRTY;
    lab.layer.masksToBounds=YES;
    lab.layer.borderColor=SEPARATORCOLOR.CGColor;
    lab.layer.borderWidth=1.0;
    lab.layer.cornerRadius=5.0;
    lab.textAlignment=NSTextAlignmentCenter;
    lab.textColor=BLACK_EIGHTYSEVER;
    [self.pStyleAndRView addSubview:lab];
    self.yptLabel=lab;
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetMaxX(self.yptLabel.frame)+10,CGRectGetMaxY(self.ypoRigBtn.frame)+10, MyWidth*12/64, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"推荐赛果-按钮（常态）"] forState:normal];
    [btn setBackgroundImage:[UIImage imageNamed:@"推荐赛果-按钮（选中）"] forState:UIControlStateSelected];
    [self setBtnAttributedTit:@"客" btn:btn];
    btn.titleLabel.font=FONTTHIRTY;
    [self.pStyleAndRView addSubview:btn];
    self.yptRigBtn=btn;
    
    [self.ypoLefBtn  addTarget:self action:@selector(chooseSaiGuo:) forControlEvents:UIControlEventTouchUpInside];
    [self.ypoRigBtn  addTarget:self action:@selector(chooseSaiGuo:) forControlEvents:UIControlEventTouchUpInside];
    [self.yptLefBtn  addTarget:self action:@selector(chooseSaiGuo:) forControlEvents:UIControlEventTouchUpInside];
    [self.yptRigBtn  addTarget:self action:@selector(chooseSaiGuo:) forControlEvents:UIControlEventTouchUpInside];
    self.ypoLefBtn.userInteractionEnabled = NO;
    self.ypoRigBtn.userInteractionEnabled = NO;
    self.yptLefBtn.userInteractionEnabled = NO;
    self.yptRigBtn.userInteractionEnabled = NO;
    
    if (_matchM||_gameDeteilMdl) {
        lotryTypeLab.textColor=BLACK_TWENTYSIX;
        lotryTypeLab.userInteractionEnabled = NO;
        
        matchTimeLab.textColor=BLACK_TWENTYSIX;
        matchTimeLab.userInteractionEnabled = NO;
        matchTimeLab.text = [NSString stringWithFormat:@"%@",_selectDate];
        
        leagueLab.textColor=BLACK_TWENTYSIX;
        leagueLab.userInteractionEnabled = NO;
        leagueLab.text = [NSString stringWithFormat:@"%@",_selectLeagueName];
        
        matchNameLab.textColor=BLACK_TWENTYSIX;
        matchNameLab.userInteractionEnabled = NO;
        matchNameLab.text = [NSString stringWithFormat:@"%@",_nameAndTimeStr];
        [self setBtnUsedEnable];
    }
    [self requestLeagueList:_lotrySource];//请求联赛列表
    [self requestDiscountList];//获取折扣列表
    [self requestPriceList];//获取价格列表
    
    if ([_lotrySource isEqualToString:@"-201"]) {
        for (UIView *view in [_pStyleAndRView subviews]) {
            if ([[_pStyleAndRView subviews] indexOfObject:view]>4) {
                view.hidden=YES;
            }else
                view.hidden=NO;
        }
    } else if ([_lotrySource isEqualToString:@"202"]) {
        if ([_tjsdOrNo isEqualToString:@"0"]) {
            [_pAndmacthView setFrame:CGRectMake(0, 0, MyWidth, 184)];
        }else if([_tjsdOrNo isEqualToString:@"1"]){
            [_pAndmacthView setFrame:CGRectMake(0, 0, MyWidth, 230)];
        }
        curGameMethLab.hidden=YES;
        [recSdLab setFrame:CGRectMake(15, CGRectGetMaxY(matchNameLab.frame), MyWidth-15, 46)];
        UIImageView *view=(UIImageView *)[_pAndmacthView viewWithTag:205];
        UIImage *img=[UIImage imageNamed:@"指示箭头"];
        [view setFrame:CGRectMake(MyWidth-img.size.width-15, CGRectGetMinY(recSdLab.frame)+23-img.size.height/2, img.size.width, img.size.height)];
        view=[_pAndmacthView viewWithTag:105];
        view.hidden=YES;
        
        CGSize size = [PublicMethod setNameFontSize:@"推荐赛果" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [self.remLab setFrame:CGRectMake(15,17.5-size.height/2, size.width, size.height)];
        
        [self reset_pStyleAndRView];
    }
}

-(void)createTextView{
    //第三部分的分割线
    _planView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pStyleAndRView.frame)+10, MyWidth, 46)];
    _planView.backgroundColor=[UIColor whiteColor];
    _planView.layer.borderWidth=0.5;
    _planView.layer.borderColor=SEPARATORCOLOR.CGColor;
    [_rightScroll addSubview:_planView];
    
    NSString  *remStr = @"方案标题:";
    remSize = [PublicMethod  setNameFontSize:remStr andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    UILabel *planLab = [[UILabel alloc]initWithFrame:CGRectMake(15,23-remSize.height/2,remSize.width,remSize.height)];
    planLab.text = remStr;
    planLab.font = FONTTHIRTY;
    planLab.textColor = BLACK_FIFITYFOUR;
    [_planView addSubview:planLab];
    
    planTitView = [[UITextView  alloc]initWithFrame:CGRectMake(CGRectGetMaxX(planLab.frame)+10, 6, MyWidth-CGRectGetMaxX(planLab.frame)-20, 34)];
    planTitView.delegate = self;
    planTitView.font = FONTTHIRTY;
    planTitView.text = @"请输入标题20字以内";
    planTitView.textColor = V2LINE_COLOR;
    planTitView.backgroundColor=[UIColor whiteColor];
    planTitView.tag = PLANTITLETEXTVIEWTAG;
    [_planView addSubview:planTitView];

    _remView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_planView.frame), MyWidth, 46)];
    _remView.backgroundColor=[UIColor whiteColor];
    [_rightScroll addSubview:_remView];
    
    UILabel *remLab1 = [[UILabel alloc]initWithFrame:CGRectMake(15,23-remSize.height/2,remSize.width,remSize.height)];
    remLab1.text = @"推荐理由:";
    remLab1.textColor = BLACK_FIFITYFOUR;
    remLab1.font = FONTTHIRTY;
    [_remView addSubview:remLab1];
    
    reasonView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(remLab1.frame)+10, 6, MyWidth-CGRectGetMaxX(remLab1.frame)-20, 34)];
    reasonView.delegate = self;
    reasonView.tag = PLANREASONTEXTVIEWTAG;
    reasonView.text = @"输入推荐理由100~1200字";
    reasonView.backgroundColor=[UIColor whiteColor];
    reasonView.textColor = V2LINE_COLOR;
    reasonView.font = FONTTHIRTY;
    [_remView addSubview:reasonView];
    
    _lineRecm = [[UIView alloc]initWithFrame:CGRectMake(0, _remView.frame.size.height-0.5, MyWidth, 0.5)];
    _lineRecm.backgroundColor = SEPARATORCOLOR;
    [_remView addSubview:_lineRecm];
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, MyWidth, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    topView.tintColor=[UIColor whiteColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        topView.barTintColor=[UIColor colorWithRed:21.0/255 green:136.0/255 blue:218.0/255 alpha:1.0];
    }
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    planTitView.inputView.backgroundColor=[UIColor clearColor];
    [planTitView setInputAccessoryView:topView];
    reasonView.inputView.backgroundColor=[UIColor clearColor];
    [reasonView setInputAccessoryView:topView];
    
    _pAndcView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_remView.frame)+10, MyWidth, 93.5)];
    _pAndcView.layer.borderWidth=0.5;
    _pAndcView.layer.borderColor=SEPARATORCOLOR.CGColor;
    [_pAndcView setBackgroundColor:[UIColor whiteColor]];
    [_rightScroll addSubview:_pAndcView];
    
    priceLab = [[UILabel alloc]initWithFrame:CGRectMake(15,0.5, MyWidth-15, 46)];
    priceLab.text = @"请选择价格";
    _priceId=@"";
    if ([DEFAULTS objectForKey:@"resultDic"] && [[DEFAULTS objectForKey:@"resultDic"] isKindOfClass:[NSDictionary class]] && [[DEFAULTS objectForKey:@"resultDic"] allKeys]!= nil&&
        ![[DEFAULTS objectForKey:@"resultDic"] isEqualToDictionary:[NSDictionary dictionary]]){
        NSDictionary *dic=[DEFAULTS objectForKey:@"resultDic"];
        NSString *price=@"";
        if([_lotrySource isEqualToString:@"-201"]){
            price=[dic objectForKey:@"jcPrice"];
        }
        priceLab.text=[NSString stringWithFormat:@"当前方案价格:￥%@",price];
        _priceId=price;
    }
    priceLab.font = FONTTHIRTY;
    priceLab.textColor=BLACK_EIGHTYSEVER;
    priceLab.backgroundColor=[UIColor whiteColor];
    [_pAndcView addSubview:priceLab];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 46, MyWidth, 0.5)];
    line2.backgroundColor = SEPARATORCOLOR;
    line2.tag=777;
    [_pAndcView addSubview:line2];
    
    discountLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(priceLab.frame)+0.5, MyWidth-15, 46)];
    _discountId=@"1";
    discountLab.text =  @"当前方案折扣:无折扣";
    discountLab.font = FONTTHIRTY;
    discountLab.textColor=BLACK_EIGHTYSEVER;
    discountLab.backgroundColor=[UIColor whiteColor];
    [_pAndcView addSubview:discountLab];
    
    UITapGestureRecognizer *taplabPrice = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pleasePalyPrice)];
    taplabPrice.numberOfTapsRequired = 1;
    taplabPrice.numberOfTouchesRequired = 1;
    taplabPrice.delegate = self;
    priceLab.userInteractionEnabled = YES;
    [priceLab addGestureRecognizer:taplabPrice];
    
    UITapGestureRecognizer *taplabDiscountPrice = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pleasePalyDiscountPrice)];
    taplabDiscountPrice.numberOfTapsRequired = 1;
    taplabDiscountPrice.numberOfTouchesRequired = 1;
    taplabDiscountPrice.delegate = self;
    discountLab.userInteractionEnabled = YES;
    [discountLab addGestureRecognizer:taplabDiscountPrice];
    
    _refundView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pAndcView.frame)+10, MyWidth, 47)];
    _refundView.layer.borderWidth=0.5;
    _refundView.layer.borderColor=SEPARATORCOLOR.CGColor;
    [_refundView setBackgroundColor:[UIColor whiteColor]];
    [_rightScroll addSubview:_refundView];
    
    _refundLab=[[UILabel alloc] initWithFrame:CGRectMake(15, 0.5, MyWidth-15, 46)];
    _refundLab.text=@"是否参加不中退款活动";
    _refundLab.font=FONTTHIRTY;
    _refundLab.textColor=BLACK_EIGHTYSEVER;
    [_refundLab setBackgroundColor:[UIColor whiteColor]];
    [_refundView addSubview:_refundLab];
    
    UIImageView *swImg=[[UIImageView alloc] initWithFrame:CGRectMake(MyWidth-85, 8, 69.5, 31)];
    swImg.image=[UIImage imageNamed:@"swoff.png"];
    if([_supportOrNo isEqualToString:@"1"]){
        swImg.image=[UIImage imageNamed:@"swon.png"];
    }
    swImg.backgroundColor=[UIColor clearColor];
    _refundView.userInteractionEnabled=YES;
    [_refundView addSubview:swImg];
    
    UITapGestureRecognizer *swGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapeSprtOrNo:)];
    swImg.userInteractionEnabled=YES;
    _refundView.userInteractionEnabled=YES;
    [swImg addGestureRecognizer:swGesture];
    
    commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(15, CGRectGetMaxY(_refundView.frame)+30, 290, 40);
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"通用-信息填写前"] forState:UIControlStateNormal];
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"通用-信息填写后"] forState:UIControlStateSelected];
    [commitBtn setTitle:@"提交方案" forState:UIControlStateNormal];
    [commitBtn setTitle:@"提交方案" forState:UIControlStateSelected];
    [commitBtn addTarget:self action:@selector(commitPlanCount) forControlEvents:UIControlEventTouchUpInside];
    commitBtn.userInteractionEnabled=NO;
    [_rightScroll addSubview:commitBtn];
    
    if([_tjsd isEqualToString:@"0"]){
        [_pAndcView setFrame:CGRectMake(0, CGRectGetMaxY(_remView.frame)+10, MyWidth, 93.5)];
        _refundView.hidden=NO;
        UIView *view=[_refundView viewWithTag:777];
        view.hidden=NO;
        discountLab.hidden=NO;
        [commitBtn setFrame:CGRectMake(15, CGRectGetMaxY(_refundView.frame)+30, 290, 40)];
    }else if ([_tjsd isEqualToString:@"1"]){
        [_pAndcView setFrame:CGRectMake(0, CGRectGetMaxY(_remView.frame)+10, MyWidth, 47)];
        _refundView.hidden=YES;
        UIView *view=[_refundView viewWithTag:777];
        view.hidden=YES;
        discountLab.hidden=YES;
        [commitBtn setFrame:CGRectMake(15, CGRectGetMaxY(_pAndcView.frame)+30, 290, 40)];
    }
    [_rightScroll setContentSize:CGSizeMake(self.view.bounds.size.width,CGRectGetMaxY(commitBtn.frame)+64)];
}

#pragma mark ------是否支持不中退款-----
- (void)tapeSprtOrNo:(UITapGestureRecognizer *)sender{
    UIImageView *imgView=(UIImageView *)sender.view;
    if ([_supportOrNo isEqualToString:@"0"]) {
        imgView.image=[UIImage imageNamed:@"swon.png"];
        _supportOrNo=@"1";
    }else if([_supportOrNo isEqualToString:@"1"]){
        imgView.image=[UIImage imageNamed:@"swoff.png"];
        _supportOrNo=@"0";
    }
}

#pragma mark ------展示赛过问号弹窗------
- (void)dispalyView:(UIButton *)sender{
    if (sender.selected == YES) {
        if (!self.markWarnlab) {
            UILabel *label = [[UILabel alloc] init];
            label.font = FONTTWENTY_FOUR;
            label.layer.masksToBounds=YES;
            label.layer.borderWidth=1.0;
            label.layer.borderColor=[UIColor redColor].CGColor;
            label.backgroundColor=[UIColor whiteColor];
            [self.pStyleAndRView addSubview:label];
            self.markWarnlab=label;
        }
        
        NSString *displayStr=@"";
        if([_tjsd isEqualToString:@"1"]){
            displayStr = [NSString stringWithFormat:@"  单选≥%@  ",self.singleSelectOdds];
        }else
            displayStr = [NSString stringWithFormat:@"单选%@,双选≥%@",self.singleSelectOdds,self.doubleSelectOdds];
        CGSize labSize=[PublicMethod setNameFontSize:displayStr andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [self.markWarnlab setFrame:CGRectMake(CGRectGetMinX(self.probleBtn.frame)-labSize.width+6, self.rightWin.frame.origin.y-5, labSize.width+2, self.leftWin.frame.size.height)];
        self.markWarnlab.text = displayStr;
        
        self.markWarnlab.hidden=NO;
        sender.selected = NO;
        [self performSelector:@selector(viewDismiss) withObject:self afterDelay:2];
    }else{
        self.markWarnlab.hidden = YES;
        sender.selected = YES;
    }
}

#pragma mark ----------赛过问号2s后消失----------
-(void)viewDismiss
{
    self.markWarnlab.hidden = YES;
    self.probleBtn.selected = YES;
}

#pragma mark ----------弹窗消失-----------
-(void)alertActionDissmiss:(UIAlertView *)alert{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}

- (void)showAlert:(NSString *)message tit:(NSString *)tit{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:tit message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    [self performSelector:@selector(alertActionDissmiss:) withObject:alert afterDelay:1];
}

#pragma mark ----------选项点击-----------
- (void)labClickTap:(UITapGestureRecognizer *)tap{
    UIView *tapView=tap.view;
    if (tapView.tag==LOTRYTAG) {
        if([_jc_TdPubNo intValue]==3||[_yp_TdPubNo intValue]==3){
            if([_jc_TdPubNo intValue]==3){
                [self showAlert:@"高手用户，一天只能发布三场竞彩方案" tit:nil];
            }else if ([_yp_TdPubNo intValue]==3){
                [self showAlert:@"高手用户，一天只能发布三场亚盘方案" tit:nil];
            }
            return;
        }
        self.pickType=@"6";
        [self selectPickerView];
    }else if(tapView.tag==TIMETAG){
        self.pickType=@"0";
        if (self.leagueArr.count != 0) {
            [self selectPickerView];
        }else{
            [self showAlert:@"没有可选的联赛时间!" tit:@"通知"];
            return;
        }
    }else if(tapView.tag==LEAGUETAG){
        if ([matchTimeLab.text isEqualToString:@"请选择时间"]) {
            [self showAlert:@"请先确定时间" tit:@"通知"];
            return;
        }
        self.pickType=@"1";
        if (self.leagueArr.count != 0) {
            [self selectPickerView];
        }else{
            [self showAlert:@"没有可选的联赛!" tit:@"通知"];
            return;
        }
    }else if(tapView.tag==MATCHTAG){
        if ([leagueLab.text isEqualToString:@"请选择赛事"]) {
            [self showAlert:@"请先确定赛事" tit:@"通知"];
            return;
        }
        self.pickType=@"2";
        
        NSArray *nameArr = self.leagueList[@"result"];
        if (nameArr.count!=0) {
            NSString *leagueId=@"";
            for (NSDictionary *nameDic in nameArr) {
                if ([_selectLeagueName isEqualToString:nameDic[@"NAME"]]) {
                    leagueId = nameDic[@"ID"];
                }
            }
            if ([leagueId isEqualToString:@""]||leagueId==nil) {
                return;
            }
            [self requestMatchList:_lotrySource leagueId:leagueId];
        }else{
            [self showAlert:@"目前没有比赛!" tit:nil];
            return;
        }
    }else if(tapView.tag==GAMETAG){
        if([matchNameLab.text isEqualToString:@"请选择比赛"]){
            [self showAlert:@"请先确定比赛" tit:@"通知"];
            return;
        }
        self.pickType=@"5";
        [self selectPickerView];
    }else if(tapView.tag==RESECTAG){
        self.pickType=@"7";
        [self selectPickerView];
    }
}

#pragma mark ----------选择价格------------

-(void)pleasePalyPrice
{
    self.pickType=@"3";
    if (self.prizeNameArr.count != 0) {
        [self selectPickerView];
    }else{
        [self showAlert:@"目前没有价格可以选择" tit:@"通知"];
    }
}

#pragma mark ----------选择折扣价格----------
-(void)pleasePalyDiscountPrice
{
    self.pickType=@"4";
    if (self.discountArr.count != 0) {
        [self selectPickerView];
    }else{
        [self showAlert:@"没有网络不能选择!" tit:@"通知"];
    }
}

#pragma mark ----------调用选择框-------------

-(void)selectPickerView
{
    if(_picker){
        [_picker removeFromSuperview];
    }
    
    _picker=[[V1PickerView alloc] initWithFrame:CGRectMake(0, MyHight-260, MyWidth, 260)];
    _picker.delegate=self;
    //[_picker.pickerView selectRow:4 inComponent:0 animated:NO];
    _picker.pickerView.dataSource = self;
    _picker.pickerView.delegate = self;
    if ([self.pickType isEqualToString: @"5"]) {
        NSRange rang=[curGameMethLab.text rangeOfString:@"当前玩法："];
        NSString *str=[curGameMethLab.text substringFromIndex:(rang.location+rang.length)];
        if([self.playWay containsObject:str]){
            NSInteger row=[self.playWay indexOfObject:str];
            [_picker.pickerView selectRow:row inComponent:0 animated:YES];
        }
    }else if([self.pickType isEqualToString: @"6"]){
        NSRange rang=[lotryTypeLab.text rangeOfString:@"当前彩种："];
        NSString *str=[lotryTypeLab.text substringFromIndex:(rang.location+rang.length)];
        if([_lotryTypeArr containsObject:str]){
            NSInteger row=[_lotryTypeArr indexOfObject:str];
            [_picker.pickerView selectRow:row inComponent:0 animated:YES];
        }
    }else if([self.pickType isEqualToString: @"7"]){
        NSRange rang=[recSdLab.text rangeOfString:@"推荐神单："];
        NSString *str=[recSdLab.text substringFromIndex:(rang.location+rang.length)];
        if([_sdIsOrNoArr containsObject:str]){
            NSInteger row=[_sdIsOrNoArr indexOfObject:str];
            [_picker.pickerView selectRow:row inComponent:0 animated:YES];
        }
    }
    [self.view addSubview:_picker];

}

#pragma mark ----------推荐玩法-----------

-(void)remmodplayMethond{
    NSArray *arr = self.matchList[@"result"];
    for (NSDictionary *remNameDic in arr) {
        NSString *playSelId = remNameDic[@"play_ID"];
        if ([_playID isEqualToString:playSelId]) {
            _selectDate = remNameDic[@"match_DATE"];
            _homeName = remNameDic[@"host_NAME_SIMPLY"];
            if ([_lotrySource isEqualToString:@"-201"]) {
                self.supportStr = [NSString stringWithFormat:@"%@",remNameDic[@"sheng_PING_FU"]];
                _rqNo = [NSString stringWithFormat:@"%@",remNameDic[@"rq"]];
            }else if([_lotrySource isEqualToString:@"202"]){
                self.ypRq = [NSString stringWithFormat:@"%@",remNameDic[@"rq"]];
                self.asianSp = [NSString stringWithFormat:@"%@",remNameDic[@"asian_sp"]];
            }
            _oddsStr = remNameDic[@"spf_SP"];
            _rqOddStr = remNameDic[@"rang_QIU_SP"];
            _guestName = remNameDic[@"guest_NAME_SIMPLY"];
            _matchStatus =  remNameDic[@"match_STATUS"];
            _selectTime = remNameDic[@"match_TIME"];
            [self setBtnUsedEnable];
        }
    }
}

/**
 激活按钮
 */
- (void)setBtnUsedEnable{
    if([_lotrySource isEqualToString:@"-201"]){
        if(self.playWay){
            [self.playWay removeAllObjects];
            self.playWay=nil;
        }
        NSString *rangQiu=@"让球胜平负";
        if (_rqNo!=nil&&![_rqNo isEqualToString:@""]&&[_rqNo intValue]!=0) {
            rangQiu=[NSString stringWithFormat:@"让球胜平负(%@)",_rqNo];
        }
        if ([self.supportStr isEqualToString:@"1"]) {//默认胜平负被选中的
            self.playWay=[NSMutableArray arrayWithObjects:@"胜平负",rangQiu, nil];
            curGameMethLab.text = @"当前玩法：胜平负";
            _playType = @"10";
        }else{//默认让球胜平负被选中的
            self.playWay=[NSMutableArray arrayWithObjects:rangQiu, nil];
            curGameMethLab.text = [NSString stringWithFormat:@"当前玩法：%@",rangQiu];
            _playType = @"01";
        }
        if (_gameDeteilMdl&&[_compMdl.playTypeCode isEqualToString:@"01"]) {
            self.playWay=[NSMutableArray arrayWithObjects:@"胜平负",rangQiu, nil];
            curGameMethLab.text = [NSString stringWithFormat:@"当前玩法：%@",rangQiu];
            _playType = @"01";
        }
        NSString *leftStr=@"";
        NSString *midStr=@"";
        NSString *endStr=@"";
        if([_playType isEqualToString:@"10"]){
            leftStr = [_oddsStr substringWithRange:NSMakeRange(0, 4)];
            midStr = [_oddsStr substringWithRange:NSMakeRange(5, 4)];
            endStr = [_oddsStr substringWithRange:NSMakeRange(10, 4)];
        }else if([_playType isEqualToString:@"01"]){
            leftStr = [_rqOddStr substringWithRange:NSMakeRange(0, 4)];
            midStr = [_rqOddStr substringWithRange:NSMakeRange(5, 4)];
            endStr = [_rqOddStr substringWithRange:NSMakeRange(10, 4)];
        }
        NSString  *left = [NSString stringWithFormat:@"胜(%@)",leftStr];
        NSString  *middle = [NSString stringWithFormat:@"平(%@)",midStr];
        NSString  *right = [NSString stringWithFormat:@"负(%@)",endStr];
        [self setBtnAttributedTit:left btn:self.leftWin];
        [self setBtnAttributedTit:middle btn:self.midWin];
        [self setBtnAttributedTit:right btn:self.rightWin];
        self.leftWin.userInteractionEnabled = YES;
        self.rightWin.userInteractionEnabled = YES;
        self.midWin.userInteractionEnabled = YES;
        if (_gameDeteilMdl) {
            [self.xqResult removeAllObjects];
            NSString *recommentStr = _compMdl.recommendContent;
            NSRange range = [recommentStr rangeOfString:@" "];
            NSString *resultStr=[recommentStr substringFromIndex:(range.length+range.location)];
            if([resultStr rangeOfString:@"胜"].location !=NSNotFound){
                self.leftWin.selected=YES;
                [self.xqResult addObject:left];
            } else {
                self.leftWin.selected=NO;
            }
            if([resultStr rangeOfString:@"平"].location !=NSNotFound){
                self.midWin.selected=YES;
                [self.xqResult addObject:middle];
            } else {
                self.midWin.selected=NO;
            }
            if([resultStr rangeOfString:@"负"].location !=NSNotFound){
                self.rightWin.selected=YES;
                [self.xqResult addObject:right];
            } else {
                self.rightWin.selected=NO;
            }
        }
    }else if([_lotrySource isEqualToString:@"202"]&&self.asianSp!=nil&&![self.asianSp isEqualToString:@""]){
        self.ypsflv = [self.asianSp componentsSeparatedByString:@" "];
        
        self.firstStr=[self.ypsflv objectAtIndex:0];
        NSArray *sfoArr=[self.firstStr componentsSeparatedByString:@"_"];
        
        NSString *soStr=[sfoArr objectAtIndex:1];
        [self setBtnAttributedTit:[NSString stringWithFormat:@"主(%@)",soStr] btn:self.ypoLefBtn];
        
        NSArray *rqArr = [self.ypRq componentsSeparatedByString:@" "];
        self.ypoLabel.text=[rqArr objectAtIndex:0];
        
        NSString *foStr=[sfoArr objectAtIndex:2];
        [self setBtnAttributedTit:[NSString stringWithFormat:@"客(%@)",foStr] btn:self.ypoRigBtn];
        
        if([self.ypsflv count]>=2){
            
            self.secStr=[self.ypsflv objectAtIndex:1];
            NSArray *sftArr=[self.secStr componentsSeparatedByString:@"_"];
            
            NSString *stStr=[sftArr objectAtIndex:1];
            [self setBtnAttributedTit:[NSString stringWithFormat:@"主(%@)",stStr] btn:self.yptLefBtn];
            
            self.yptLabel.text=[rqArr objectAtIndex:1];
            
            NSString *ftStr=[sftArr objectAtIndex:2];
            [self setBtnAttributedTit:[NSString stringWithFormat:@"客(%@)",ftStr] btn:self.yptRigBtn];
        }
        
        [self reset_pStyleAndRView];
        
        self.ypoLefBtn.userInteractionEnabled = YES;
        self.ypoRigBtn.userInteractionEnabled = YES;
        self.yptLefBtn.userInteractionEnabled = YES;
        self.yptRigBtn.userInteractionEnabled = YES;
        
        if (_gameDeteilMdl) {
            NSString *recomment = _compMdl.recommendContent;
            NSArray *rqArr=[self.ypRq componentsSeparatedByString:@" "];
            NSInteger index=[rqArr indexOfObject:_rqNo];
            NSRange range = [recomment rangeOfString:@" "];
            NSString *resultStr=[recomment substringFromIndex:(range.length+range.location)];
            if (index==0) {
                if([resultStr rangeOfString:@"胜"].location !=NSNotFound){
                    self.ypoLefBtn.selected=YES;
                    self.ypSaiGuo=@"胜";
                } else {
                    self.ypoLefBtn.selected=NO;
                }
                if([resultStr rangeOfString:@"负"].location !=NSNotFound){
                    self.ypoRigBtn.selected=YES;
                    self.ypSaiGuo=@"负";
                } else {
                    self.ypoRigBtn.selected=NO;
                }
            }else if(index==1){
                if([resultStr rangeOfString:@"胜"].location !=NSNotFound){
                    self.yptLefBtn.selected=YES;
                    self.ypSaiGuo=@"胜";
                } else {
                    self.yptLefBtn.selected=NO;
                }
                if([resultStr rangeOfString:@"负"].location !=NSNotFound){
                    self.yptRigBtn.selected=YES;
                    self.ypSaiGuo=@"负";
                } else {
                    self.yptRigBtn.selected=NO;
                }
            }
        }
    }
}


#pragma mark ----------选择玩法----------

-(void)chooseWanFa:(UILabel *)lab{
    
    [self.xqResult removeAllObjects];

    NSString *leftStr=@"";
    NSString *midStr=@"";
    NSString *endStr=@"";
    if ([_playType isEqualToString:@"10"]) {
        leftStr = [_oddsStr substringWithRange:NSMakeRange(0, 4)];
        midStr = [_oddsStr substringWithRange:NSMakeRange(5, 4)];
        endStr = [_oddsStr substringWithRange:NSMakeRange(10, 4)];
    }else if([_playType isEqualToString:@"01"]){
        leftStr = [_rqOddStr substringWithRange:NSMakeRange(0, 4)];
        midStr = [_rqOddStr substringWithRange:NSMakeRange(5, 4)];
        endStr = [_rqOddStr substringWithRange:NSMakeRange(10, 4)];
    }
    
    NSString  *left = [NSString stringWithFormat:@"胜(%@)",leftStr];
    NSString  *middle = [NSString stringWithFormat:@"平(%@)",midStr];
    NSString  *right = [NSString stringWithFormat:@"负(%@)",endStr];
    
    [self setBtnAttributedTit:left btn:self.leftWin];
    
    [self setBtnAttributedTit:middle btn:self.midWin];
    
    [self setBtnAttributedTit:right btn:self.rightWin];
    
    //NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    //NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //[paragraphStyle setLineSpacing:8];
    //[attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    //self.addressLab.attributedText = attributedString;
    //NSRange range =[left rangeOfString:[NSString stringWithFormat:@"#%@#",left]];

}

- (void)setBtnAttributedTit:(NSString *)title btn:(UIButton *)btn{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    NSInteger rqLeng=title.length;
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:17.0/255 green:163.0/255 blue:1.0 alpha:1] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:BLACK_EIGHTYSEVER range:NSMakeRange(1, rqLeng-1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:15.0] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:9.0] range:NSMakeRange(1, rqLeng-1)];
    [btn setAttributedTitle:attributedString forState:normal];
    
    attributedString=[[NSMutableAttributedString alloc] initWithString:title];
    rqLeng=title.length;
    [attributedString addAttribute:NSForegroundColorAttributeName value:TEXTWITER_COLOR range:NSMakeRange(0, rqLeng)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:15.0] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:9.0] range:NSMakeRange(1, rqLeng-1)];
    [btn setAttributedTitle:attributedString forState:UIControlStateSelected];
    
    btn.selected=NO;
}

#pragma mark ----------选择赛果-----------

-(void)chooseSaiGuo:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSString *btnStr = [NSString stringWithFormat:@"%@",btn.titleLabel.text];
    
    if ([_lotrySource isEqualToString:@"-201"]) {
        if ([_tjsd isEqualToString:@"1"]) {
            NSArray *arr=@[self.leftWin,self.midWin,self.rightWin];
            for (UIButton *sbtn in arr) {
                if (sbtn!=btn) {
                    sbtn.selected=NO;
                    [self.xqResult removeObject:sbtn.titleLabel.text];
                }
            }
        }else if([_tjsd isEqualToString:@"0"]){
            if((self.leftWin.selected==YES&&self.midWin.selected == YES&&btn==self.rightWin)||(self.leftWin.selected==YES&&self.rightWin.selected == YES&&btn==self.midWin)||(self.midWin.selected == YES&&self.rightWin.selected == YES&&btn==self.leftWin)){
                return;
            }
        }
        if (btn.selected==YES) {
            btn.selected=NO;
            [self.xqResult removeObject:btnStr];
        }else if(btn.selected==NO){
            btn.selected = YES;
            [self.xqResult addObject:btnStr];
        }
    }else if([_lotrySource isEqualToString:@"202"]){
        _rqNo=@"";
        self.ypSaiGuo=@"";
        if (btn.selected==YES) {
            btn.selected=NO;
        }else if(btn.selected==NO){
            btn.selected=YES;
            NSArray *rqArr=[self.ypRq componentsSeparatedByString:@" "];
            if (btn==_ypoLefBtn||btn==_ypoRigBtn) {
                _rqNo=[rqArr objectAtIndex:0];
                self.ypsflvSel=self.firstStr;
            }else if(btn==_yptLefBtn||btn==_yptRigBtn){
                _rqNo=[rqArr objectAtIndex:1];
                self.ypsflvSel=self.secStr;
            }
            if (btn==_ypoLefBtn||btn==_yptLefBtn) {
                self.ypSaiGuo=@"胜";
            }else if (btn==_ypoRigBtn||btn==_yptRigBtn){
                self.ypSaiGuo = @"负";
            }
        }
        NSArray *arr=@[_ypoLefBtn,_ypoRigBtn,_yptLefBtn,_yptRigBtn];
        for (UIButton *sbtn in arr) {
            if (sbtn!=btn) {
                sbtn.selected=NO;
            }
        }
    }
    [self publichCompetePlan];
}

#pragma mark ----------激活提交按钮响应事件----------

-(void)publichCompetePlan
{
    //检索发布竞彩是否填写完全
    BOOL matchTimeBool=NO;
    BOOL leaguelabBool=NO;
    BOOL matchNameBool=NO;
    BOOL titTxtBool=NO;
    BOOL reasonTxtBool=NO;
    BOOL pricelabBool=NO;
    BOOL discountBool=NO;
    
    if (![matchTimeLab.text isEqualToString:@"请选择时间"]&&matchTimeLab.text.length!=0) {
        matchTimeBool=YES;
    }
    if (![leagueLab.text isEqualToString:@"请选择赛事"]&&leagueLab.text.length!=0) {
        leaguelabBool=YES;
    }
    if (![matchNameLab.text isEqualToString:@"请选择比赛"]&&matchNameLab.text.length!=0) {
        matchNameBool=YES;
    }
    if (![planTitView.text isEqualToString:@"请输入标题20字以内"]&&planTitView.text.length!=0) {
        titTxtBool=YES;
    }
    if (![reasonView.text isEqualToString:@"输入推荐理由100~1200字"]&&reasonView.text.length!=0) {
        reasonTxtBool=YES;
    }
    if (![priceLab.text isEqualToString:@"请选择价格"]&&priceLab.text.length!=0) {
        pricelabBool=YES;
    }
    if (![discountLab.text isEqualToString:@"请选择折扣价格"]&&discountLab.text!=0) {
        discountBool=YES;
    }
    
    if ([self.tjsd isEqualToString:@"0"]||[_tjsdOrNo isEqualToString:@"0"]) {
        if (titTxtBool&&reasonTxtBool&&pricelabBool&&discountBool&&matchTimeBool&&leaguelabBool&&matchNameBool) {
                commitBtn.userInteractionEnabled = YES;
                commitBtn.selected=YES;
        }
    }else if ([self.tjsd isEqualToString:@"1"]){
        if (titTxtBool&&reasonTxtBool&&pricelabBool&&matchTimeBool&&leaguelabBool&&matchNameBool) {
            commitBtn.userInteractionEnabled = YES;
            commitBtn.selected=YES;
        }
    }
}

#pragma mark -----------提交方案------------

-(void)commitPlanCount
{
    if ([_lotrySource isEqualToString:@"-201"]) {
        if (self.xqResult.count != 0) {
            if([_tjsd isEqualToString:@"1"]){
                for (NSString *btnStr in self.xqResult) {
                    NSString *defineStr = [btnStr substringWithRange:NSMakeRange(2, 4)];
                    if ([defineStr floatValue]<[self.singleSelectOdds floatValue]){
                        [self showAlert:[NSString stringWithFormat:@" 单选≥%@ ",self.singleSelectOdds] tit:@"通知"];
                        return;
                    }
                }
            }else if([_tjsd isEqualToString:@"0"]){
                for (NSString *btnStr in self.xqResult) {
                    NSString *defineStr = [btnStr substringWithRange:NSMakeRange(2, 4)];
                    if(([self.xqResult count]==1&&[defineStr floatValue]<[self.singleSelectOdds floatValue])||([self.xqResult count]==2&&[defineStr floatValue]<[self.doubleSelectOdds floatValue])){
                        [self showAlert:[NSString stringWithFormat:@" 单选≥%@，双选≥%@ ",self.singleSelectOdds,self.doubleSelectOdds] tit:@"通知"];
                        return;
                    }
                }
            }
        }else{
            [self showAlert:@"请选择推荐赛果" tit:@"通知"];
            return;
        }
    }else if ([_lotrySource isEqualToString:@"202"]){
        if([self.ypSaiGuo isEqualToString:@""]||self.ypSaiGuo==nil){
            [self showAlert:@" 请选择赛果 " tit:@"通知"];
            return;
        }
    }
    if (planTitView.text.length<=20&&planTitView.text.length>0) {
        if (reasonView.text.length>=100&&reasonView.text.length<=1200) {
            [self commitCompeteRequest];
        }else{
            [self showAlert:@"推荐理由字数不符合要求" tit:@"通知"];
            return;
        }
    }else{
        [self showAlert:@"方案标题字数不符合要求" tit:@"通知"];
        return;
    }
}

#pragma mark -------------UITextViewDelegate-------------

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if (planTitView.text.length == 0) {
        planTitView.text = @"请输入标题20字以内";
        planTitView.textColor = V2LINE_COLOR;
        planTitView.font = FONTTHIRTY;
    }
    if (reasonView.text.length == 0){
        reasonView.text = @"输入推荐理由100~1200字";
        reasonView.textColor = V2LINE_COLOR;
        reasonView.font = FONTTHIRTY;
    }
    NSString *equStr=@"";
    if (textView.tag == PLANTITLETEXTVIEWTAG) {
        equStr=@"请输入标题20字以内";
    }else if(textView.tag == PLANREASONTEXTVIEWTAG){
        equStr=@"输入推荐理由100~1200字";
    }
    if ([textView.text isEqualToString:equStr]) {
        textView.text = @"";
    }
    textView.textColor = [UIColor blackColor];
    
    if (MyWidth!=414) {
        CGRect rect;
        if (textView.tag == PLANTITLETEXTVIEWTAG) {
            rect=_planView.frame;
        }
        if (textView.tag == PLANREASONTEXTVIEWTAG) {
            rect=_remView.frame;
        }
        float sizeHeight=282-(MyHight-HEIGHTBELOESYSSEVER-44-CGRectGetMaxY(rect));
        [_rightScroll setContentOffset:CGPointMake(0, sizeHeight)];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    textView.text=[textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *messageStr=@"";
    NSInteger strLength=0;
    CGSize txtContentSize = textView.contentSize;
    if (textView.tag==PLANTITLETEXTVIEWTAG) {
        messageStr=@"方案标题不能超过20个字";
        strLength=20;
        txtContentSize.height=52;
    }else if (textView.tag==PLANREASONTEXTVIEWTAG) {
        messageStr=@"推荐理由在100~1200字之间";
        strLength=1200;
        txtContentSize.height=267;
    }
    int textLength=[self convertToInt:textView.text];
    if (textLength>strLength) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:messageStr delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alert show];
        [self performSelector:@selector(alertActionDissmiss:) withObject:alert afterDelay:0.5f];
        textView.text = [textView.text substringToIndex:strLength];
        textView.contentSize=txtContentSize;
        [self textViewChangeFrame:textView];
    }
    
    if (planTitView.text.length == 0) {
        planTitView.text = @"请输入标题20字以内";
        planTitView.textColor = V2LINE_COLOR;
        planTitView.font = FONTTHIRTY;
    }else if (reasonView.text.length == 0){
        reasonView.text = @"输入推荐理由100~1200字";
        reasonView.textColor = V2LINE_COLOR;
        reasonView.font = FONTTHIRTY;
    }

    [self publichCompetePlan];
    [_rightScroll setContentOffset:CGPointMake(0, 0)];
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    return YES;
//}

-(void)textViewDidChange:(UITextView *)textView{
    [self textViewChangeFrame:textView];
}

/**
 计算UITextView的text的长度
 @param str 要计算该字符串的长度
 */
-  (int)convertToInt:(NSString*)str{
    int strlength = 0;
    char* p = (char*)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}

/**
 UITextView的frame随文本高度变化而变化
 */
- (void)textViewChangeFrame:(UITextView *)txtView{
    CGSize txtContentSize = txtView.contentSize;
    
    if ((txtView.tag==PLANTITLETEXTVIEWTAG&&txtContentSize.height<=52.000000)||(txtView.tag==PLANREASONTEXTVIEWTAG&&txtContentSize.height<=267.000000)) {
        CGRect selfFrame = txtView.frame;
        selfFrame.size.height = txtContentSize.height;
        txtView.frame = selfFrame;
        
        if (txtView.tag==PLANTITLETEXTVIEWTAG&&txtContentSize.height<=52.000000) {
            selfFrame=_planView.frame;
            selfFrame.size.height=txtView.frame.size.height+12;
            [_planView setFrame:selfFrame];
            
            selfFrame=_remView.frame;
            selfFrame.origin.y=CGRectGetMaxY(_planView.frame);
            [_remView setFrame:selfFrame];
        }else if(txtView.tag==PLANREASONTEXTVIEWTAG&&txtContentSize.height<=267.000000){
            selfFrame=_remView.frame;
            selfFrame.size.height=txtView.frame.size.height+12;
            [_remView setFrame:selfFrame];
            
            [_lineRecm setFrame:CGRectMake(0, _remView.frame.size.height-0.5, MyWidth, 0.5)];
        }
        selfFrame=_pAndcView.frame;
        selfFrame.origin.y=CGRectGetMaxY(_remView.frame)+10;
        [_pAndcView setFrame:selfFrame];
        
        if([_tjsd isEqualToString:@"0"]){
            selfFrame=_refundView.frame;
            selfFrame.origin.y= CGRectGetMaxY(_pAndcView.frame)+10;
            [_refundView setFrame:selfFrame];
            
            selfFrame=commitBtn.frame;
            selfFrame.origin.y=CGRectGetMaxY(_refundView.frame)+30;
            commitBtn.frame = selfFrame;
        }else if ([_tjsd isEqualToString:@"1"]){
            selfFrame=commitBtn.frame;
            selfFrame.origin.y=CGRectGetMaxY(_pAndcView.frame)+30;
            commitBtn.frame = selfFrame;
        }
        [_rightScroll setContentSize:CGSizeMake(self.view.bounds.size.width,CGRectGetMaxY(commitBtn.frame)+64)];
        
        CGRect rect=_planView.frame;
        if(txtView.tag==PLANREASONTEXTVIEWTAG){
            rect=_remView.frame;
        }
        float sizEHeight=282-(MyHight-HEIGHTBELOESYSSEVER-44-CGRectGetMaxY(rect));
        [_rightScroll setContentOffset:CGPointMake(0, sizEHeight)];
    }
}

#pragma mark ----隐藏键盘----

-(void)dismissKeyBoard
{
    [UIView transitionWithView:_rightScroll duration:0.5 options:0 animations:^{
        _rightScroll.contentSize = CGSizeMake(self.view.bounds.size.width,CGRectGetMaxY(commitBtn.frame)+64);
    } completion:^(BOOL finished) {
        
    }];
    [self.view endEditing:YES];
}

#pragma mark ------------UIAlertViewDelegate----------------

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //跳转个人中心界面
#if defined YUCEDI || defined DONGGEQIU
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:0] animated:YES];
#else
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
#endif
    }else{
        _matchM=nil;
        _gameDeteilMdl=nil;
        
        [self requestPulishNo];
        
        _rqNo=@"";

        self.matchList=nil;
        
        if (alertView.tag==101) {
            _lotrySource =@"202";
        }else if(alertView.tag==102){
            _lotrySource =@"-201";
        }
        NSDictionary *dic=[DEFAULTS objectForKey:@"resultDic"];
        if ([_lotrySource isEqualToString:@"-201"]){
            _tjsdOrNo=[dic objectForKey:@"sdJcStatus"];
        }else if ([_lotrySource isEqualToString:@"202"]){
            _tjsdOrNo=[dic objectForKey:@"sdYpStatus"];
        }
        [self resetData];
        [self resetView];

        lotryTypeLab.userInteractionEnabled = YES;
        lotryTypeLab.textColor=BLACK_EIGHTYSEVER;
        
        matchTimeLab.text = @"请选择时间";
        matchTimeLab.textColor=BLACK_EIGHTYSEVER;
        matchTimeLab.userInteractionEnabled = YES;
        _selectDate=@"";
        
        leagueLab.text = @"请选择赛事";
        leagueLab.textColor=BLACK_EIGHTYSEVER;
        leagueLab.userInteractionEnabled=YES;
        _selectLeagueName=@"";
        
        matchNameLab.text = @"请选择比赛";
        matchNameLab.textColor=BLACK_EIGHTYSEVER;
        matchNameLab.userInteractionEnabled=YES;
        _homeName=@"";
        
        planTitView.text = @"请输入标题20字以内";
        planTitView.textColor = V2LINE_COLOR;

        reasonView.text = @"输入推荐理由100~1200字";
        reasonView.textColor = V2LINE_COLOR;
        
        priceLab.text = @"请选择价格";
        priceLab.textColor = [UIColor blackColor];
        
        NSString *price=[self.prizeNameArr objectAtIndex:0];
        priceLab.text=[NSString stringWithFormat:@"当前方案价格:￥%@",price];
        _priceId=[self.priceNoArr objectAtIndex:0];
        
        _discountId=@"1";
        discountLab.text =  @"当前方案折扣:无折扣";

        if ([_lotrySource isEqualToString:@"-201"]) {
            curGameMethLab.text = @"当前玩法：胜平负";
            _playType=@"10";
            [self setBtnAttributedTit:@"胜" btn:self.leftWin];
            [self setBtnAttributedTit:@"平" btn:self.midWin];
            [self setBtnAttributedTit:@"负" btn:self.rightWin];
            self.leftWin.userInteractionEnabled = NO;
            self.rightWin.userInteractionEnabled = NO;
            self.midWin.userInteractionEnabled = NO;
        }else if ([_lotrySource isEqualToString:@"202"]){
            _playType=@"";
            [self setBtnAttributedTit:@"主" btn:self.ypoLefBtn];
            [self setBtnAttributedTit:@"客" btn:self.ypoRigBtn];
            [self setBtnAttributedTit:@"主" btn:self.yptLefBtn];
            [self setBtnAttributedTit:@"客" btn:self.yptRigBtn];
            self.ypoLabel.text=@"受球";
            self.yptLabel.text=@"受球";
            self.ypoLefBtn.userInteractionEnabled = NO;
            self.ypoRigBtn.userInteractionEnabled = NO;
            self.yptLefBtn.userInteractionEnabled = NO;
            self.yptRigBtn.userInteractionEnabled = NO;
        }
        
        commitBtn.userInteractionEnabled = NO;
        commitBtn.selected=NO;
        discountLab.backgroundColor = [UIColor whiteColor];
        
        //第三部分的分割线
        CGRect rect=_planView.frame;
        rect.size.height=46;
        [_planView setFrame:rect];
        
        rect=planTitView.frame;
        rect.size.height=34;
        [planTitView setFrame:rect];
        
        rect=_remView.frame;
        rect.size.height=46;
        [_remView setFrame:rect];
        
        rect=reasonView.frame;
        rect.size.height=34;
        [reasonView setFrame:rect];
        
        [_lineRecm setFrame:CGRectMake(0, _remView.frame.size.height-0.5, MyWidth, 0.5)];
        
        rect=_pAndcView.frame;
        rect.origin.y=CGRectGetMaxY(_remView.frame)+10;
        [_pAndcView setFrame:rect];
        
        rect=_refundView.frame;
        rect.origin.y=CGRectGetMaxY(_pAndcView.frame)+10;
        [_refundView setFrame:rect];
        
        rect=commitBtn.frame;
        if ([_tjsd isEqualToString:@"1"]){
            rect.origin.y=CGRectGetMaxY(_pAndcView.frame)+30;
        }else
            rect.origin.y=CGRectGetMaxY(_refundView.frame)+30;
        [commitBtn setFrame:rect];
        
        [_rightScroll setContentOffset:CGPointMake(0, 0)];
    }
}

#pragma mark ----------V1PickerViewDelegate(弹窗取消与确定)-----------

/**
 初始化界面数据
 */
- (void)resetView{
    if ([_lotrySource isEqualToString:@"-201"]) {
        for (UIView *view in [_pStyleAndRView subviews]) {
            if ([[_pStyleAndRView subviews] indexOfObject:view]>4) {
                view.hidden=YES;
            }else
                view.hidden=NO;
        }
        if ([_tjsdOrNo isEqualToString:@"0"]) {
            _tjsd=@"0";
            recSdLab.hidden=YES;
            [_pAndmacthView setFrame:CGRectMake(0, 0, MyWidth, 231)];
        }else if ([_tjsdOrNo isEqualToString:@"1"]) {
            recSdLab.hidden=NO;
            [_pAndmacthView setFrame:CGRectMake(0, 0, MyWidth, 277)];
        }
        curGameMethLab.hidden=NO;
        UIView *view=[_pAndmacthView viewWithTag:105];
        view.hidden=NO;
        
        [recSdLab setFrame:CGRectMake(15, CGRectGetMaxY(curGameMethLab.frame), MyWidth-15, 46)];
        view=(UIImageView *)[_pAndmacthView viewWithTag:205];
        UIImage *img=[UIImage imageNamed:@"指示箭头"];
        [view setFrame:CGRectMake(MyWidth-img.size.width-15, CGRectGetMinY(recSdLab.frame)+23-img.size.height/2, img.size.width, img.size.height)];
        
        CGSize size = [PublicMethod setNameFontSize:@"推荐赛果" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [self.remLab setFrame:CGRectMake(MyWidth*3/64,23-size.height/2, size.width, size.height)];
        [_pStyleAndRView setFrame:CGRectMake(0,CGRectGetMaxY(_pAndmacthView.frame)+10, MyWidth, 47)];
    }else if([_lotrySource isEqualToString:@"202"]){
        if ([_tjsdOrNo isEqualToString:@"0"]) {
            _tjsd=@"0";
            recSdLab.hidden=YES;
            [_pAndmacthView setFrame:CGRectMake(0, 0, MyWidth, 184)];
        }if ([_tjsdOrNo isEqualToString:@"1"]) {
            recSdLab.hidden=NO;
            [_pAndmacthView setFrame:CGRectMake(0, 0, MyWidth, 230)];
        }
        curGameMethLab.hidden=YES;
        UIView *view=[_pAndmacthView viewWithTag:105];
        view.hidden=YES;
        
        [recSdLab setFrame:CGRectMake(15, CGRectGetMaxY(matchNameLab.frame), MyWidth-15, 46)];
        view=(UIImageView *)[_pAndmacthView viewWithTag:205];
        UIImage *img=[UIImage imageNamed:@"指示箭头"];
        [view setFrame:CGRectMake(MyWidth-img.size.width-15, CGRectGetMinY(recSdLab.frame)+23-img.size.height/2, img.size.width, img.size.height)];
        
        CGSize size = [PublicMethod setNameFontSize:@"推荐赛果" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [self.remLab setFrame:CGRectMake(MyWidth*3/64,17.5-size.height/2, size.width, size.height)];
        
        [self reset_pStyleAndRView];
    }
    if ([_tjsd isEqualToString:@"1"]){
        recSdLab.text = @"推荐神单：是";
    }else
        recSdLab.text = @"推荐神单：否";

    CGRect rect=_planView.frame;
    rect.origin.y=CGRectGetMaxY(_pStyleAndRView.frame)+10;
    [_planView setFrame:rect];
    
    rect=_remView.frame;
    rect.origin.y=CGRectGetMaxY(_planView.frame);
    [_remView setFrame:rect];
    
    rect=_pAndcView.frame;
    rect.origin.y=CGRectGetMaxY(_remView.frame)+10;
    if ([_tjsd isEqualToString:@"1"]){
        rect.size.height=47;
        discountLab.hidden=YES;
    }else{
        rect.size.height=93.5;
        discountLab.hidden=NO;
    }
    [_pAndcView setFrame:rect];

    rect=_refundView.frame;
    rect.origin.y=CGRectGetMaxY(_pAndcView.frame)+10;
    [_refundView setFrame:rect];
    if ([_tjsd isEqualToString:@"1"]){
        _refundView.hidden=YES;
        UIView *view=[_refundView viewWithTag:777];
        view.hidden=YES;
    }else{
        _refundView.hidden=NO;
        UIView *view=[_refundView viewWithTag:777];
        view.hidden=NO;
    }
    
    rect=commitBtn.frame;
    if ([_tjsd isEqualToString:@"1"]){
        rect.origin.y=CGRectGetMaxY(_pAndcView.frame)+30;
    }else{
        rect.origin.y=CGRectGetMaxY(_refundView.frame)+30;
    }
    [commitBtn setFrame:rect];
    
    _rightScroll.contentSize = CGSizeMake(self.view.bounds.size.width,CGRectGetMaxY(commitBtn.frame)+64);
    
    if (![matchTimeLab.text isEqualToString:@"请选择时间"] && matchTimeLab.userInteractionEnabled) {
        matchTimeLab.text = @"请选择时间";
    }
    if (![leagueLab.text isEqualToString:@"请选择赛事"] && leagueLab.userInteractionEnabled) {
        leagueLab.text = @"请选择赛事";
    }
    if (![matchNameLab.text isEqualToString:@"请选择比赛"] && matchNameLab.userInteractionEnabled) {
        matchNameLab.text = @"请选择比赛";
    }
    if ([self.prizeNameArr count]!=0) {
        NSString *price=[self.prizeNameArr objectAtIndex:0];
        priceLab.text=[NSString stringWithFormat:@"当前方案价格:￥%@",price];
        _priceId=[self.priceNoArr objectAtIndex:0];
    }
    [self requestLeagueList:_lotrySource];//请求联赛列表
    [self requestPriceList];//获取价格列表
}

#pragma marked ----------重置赛果View-----------------
- (void)reset_pStyleAndRView{
    for (UIView *view in [_pStyleAndRView subviews]) {
        if ([[_pStyleAndRView subviews] indexOfObject:view]==0||[[_pStyleAndRView subviews] indexOfObject:view]>4) {
            view.hidden=NO;
            if ([self.ypsflv count]<2&&[[_pStyleAndRView subviews] indexOfObject:view]>9) {
                view.hidden=YES;
            }
        }else
            view.hidden=YES;
    }
    NSInteger pStyleheight=135;
    if([self.ypsflv count]<2){
        pStyleheight=85;
    }
    [_pStyleAndRView setFrame:CGRectMake(0,CGRectGetMaxY(_pAndmacthView.frame)+10, MyWidth, pStyleheight)];
}

#pragma marked ----------重置属性值-----------------

- (void)resetData{
    [self.xqResult removeAllObjects];
    _playType=@"";
    
    self.ypsflvSel=@"";
    self.ypSaiGuo=@"";
    self.ypRq=@"";
    self.asianSp=@"";
    self.firstStr=@"";
    self.secStr=@"";
    
    if ([_tjsdOrNo isEqualToString:@"0"]) {
        _tjsd=@"0";
    }else if([_tjsdOrNo isEqualToString:@"1"]){
        _tjsd=@"1";
    }
}

-(void)sure:(id)sender
{
    if ([self.pickType isEqualToString:@"6"]) {
        
        NSString *lotrStr=[self.lotryTypeArr objectAtIndex:[_picker.pickerView selectedRowInComponent:0]];
        lotryTypeLab.text=[NSString stringWithFormat:@"当前彩种：%@",lotrStr];
        if ([lotrStr isEqualToString:@"竞彩"]) {
            _lotrySource=@"-201";
        }else if([lotrStr isEqualToString:@"亚盘"]){
            _lotrySource=@"202";
        }
        NSDictionary *dic=[DEFAULTS objectForKey:@"resultDic"];
        if ([_lotrySource isEqualToString:@"-201"]){
            _tjsdOrNo=[dic objectForKey:@"sdJcStatus"];
        }else if ([_lotrySource isEqualToString:@"202"]){
            _tjsdOrNo=[dic objectForKey:@"sdYpStatus"];
        }
        [self resetData];
        [self resetView];
    }else if ([self.pickType isEqualToString:@"0"]) {
        [self resetData];
        
        _selectDate = [self.matchTimeArr objectAtIndex:[_picker.pickerView selectedRowInComponent:0]];
        matchTimeLab.text = [NSString stringWithFormat:@"%@",_selectDate];
        if(self.leagueNameArr){
            [self.leagueNameArr removeAllObjects];
        }
        for (NSDictionary *dic in self.leagueArr) {
            NSString *time=[dic objectForKey:@"MATCHDATE"];
            if ([time isEqualToString:_selectDate]) {
                NSString *leagueName=[dic objectForKey:@"NAME"];
                if (![self.leagueNameArr containsObject:leagueName]) {
                    [self.leagueNameArr addObject:leagueName];
                }
            }
        }
        if (![leagueLab.text isEqualToString:@"请选择赛事"]) {
            leagueLab.text = @"请选择赛事";
        }
        if (![matchNameLab.text isEqualToString:@"请选择比赛"]) {
            matchNameLab.text = @"请选择比赛";
        }
    }else if ([self.pickType isEqualToString:@"1"]) {
        [self resetData];
        
        _selectLeagueName = [self.leagueNameArr objectAtIndex:[_picker.pickerView selectedRowInComponent:0]];
        leagueLab.text = [NSString stringWithFormat:@"%@",_selectLeagueName];
        
        //赛事重新选择置空至空且不可选中
        if([_lotrySource isEqualToString:@"-201"]){
            [self setBtnAttributedTit:@"胜" btn:self.leftWin];
            [self setBtnAttributedTit:@"平" btn:self.midWin];
            [self setBtnAttributedTit:@"负" btn:self.rightWin];
            self.leftWin.userInteractionEnabled=NO;
            self.midWin.userInteractionEnabled=NO;
            self.rightWin.userInteractionEnabled=NO;
        }else if([_lotrySource isEqualToString:@"202"]){
            [self setBtnAttributedTit:@"主" btn:self.ypoLefBtn];
            [self setBtnAttributedTit:@"客" btn:self.ypoRigBtn];
            [self setBtnAttributedTit:@"主" btn:self.yptLefBtn];
            [self setBtnAttributedTit:@"客" btn:self.yptRigBtn];
            self.ypoLefBtn.userInteractionEnabled=NO;
            self.ypoRigBtn.userInteractionEnabled=NO;
            self.yptLefBtn.userInteractionEnabled=NO;
            self.yptRigBtn.userInteractionEnabled=NO;
        }
        if (![matchNameLab.text isEqualToString:@"请选择比赛"]) {
            matchNameLab.text = @"请选择比赛";
        }
    } else if([self.pickType isEqualToString:@"2"]){
        [self resetData];

        self.selectMatch = [self.matchArr objectAtIndex:[_picker.pickerView selectedRowInComponent:0]];
        _eventSelRow=[_picker.pickerView selectedRowInComponent:0];
        _playID=[self.playIdArr objectAtIndex:_eventSelRow];
        _matchIdSelected=[self.matchIdArr objectAtIndex:_eventSelRow];
        matchNameLab.text = [NSString stringWithFormat:@"%@", self.selectMatch];
        if ([_lotrySource isEqualToString:@"-201"]) {
            _eventId =[NSString stringWithFormat:@"%@", [self.selectMatch substringWithRange:NSMakeRange(0, 5)]];
        }else if ([_lotrySource isEqualToString:@"202"]) {
            _eventId =[NSString stringWithFormat:@"%@", [self.selectMatch substringWithRange:NSMakeRange(0, 7)]];
        }
        [self remmodplayMethond];
    }else if([self.pickType isEqualToString:@"3"]){
        self.selectPriceStr = [self.prizeNameArr objectAtIndex:[_picker.pickerView selectedRowInComponent:0]];
        priceLab.textColor = [UIColor redColor];
        if ([self.selectPriceStr isEqualToString:@"免费"]) {
            priceLab.text = [NSString stringWithFormat:@"%@",self.selectPriceStr];
            discountLab.backgroundColor = [UIColor colorWithHexString:@"fcfcfc"];
            discountLab.text = @"无折扣";
            discountLab.userInteractionEnabled = NO;
            UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, discountLab.frame.size.height-0.5, MyWidth, 0.5)];
            line3.backgroundColor = SEPARATORCOLOR;
            [discountLab addSubview:line3];
        }else{
            if ([self.selectPriceStr isEqualToString:@"免费"]) {
            }else{
                discountLab.text = @"请选择折扣价格";
                discountLab.userInteractionEnabled = YES;
                discountLab.backgroundColor = [UIColor whiteColor];
                priceLab.text = [NSString stringWithFormat:@"￥%@",self.selectPriceStr];
            }
        }
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, priceLab.frame.size.height-0.5, MyWidth, 0.5)];
        line2.backgroundColor = SEPARATORCOLOR;
        [priceLab addSubview:line2];
        [self publichCompetePlan];
    }else if([self.pickType isEqualToString:@"4"]){
        self.selectDiscountStr = [self.discountArr objectAtIndex:[_picker.pickerView selectedRowInComponent:0]];
        discountLab.text =  [NSString stringWithFormat:@"%@",self.selectDiscountStr];
        [self publichCompetePlan];
    }else if([self.pickType isEqualToString:@"5"]){
        self.selectPlayWay = [self.playWay objectAtIndex:[_picker.pickerView selectedRowInComponent:0]];
        curGameMethLab.text =  [NSString stringWithFormat:@"当前玩法：%@",self.selectPlayWay];
        if([self.selectPlayWay isEqualToString:@"胜平负"]){
            _playType=@"10";
        }else{
            _playType=@"01";
        }
        [self chooseWanFa:curGameMethLab];
    }else if([self.pickType isEqualToString:@"7"]){
        NSString *secSdStr = [self.sdIsOrNoArr objectAtIndex:[_picker.pickerView selectedRowInComponent:0]];
        recSdLab.text =  [NSString stringWithFormat:@"推荐神单：%@",secSdStr];
        if([secSdStr isEqualToString:@"否"]){
            _tjsd=@"0";
            [_pAndcView setFrame:CGRectMake(0, CGRectGetMaxY(_remView.frame)+10, MyWidth, 93.5)];
            _refundView.hidden=NO;
            UIView *view=[_refundView viewWithTag:777];
            view.hidden=NO;
            discountLab.hidden=NO;
            
            CGRect selfFrame=_refundView.frame;
            selfFrame.origin.y= CGRectGetMaxY(_pAndcView.frame)+10;
            [_refundView setFrame:selfFrame];
            
            [commitBtn setFrame:CGRectMake(15, CGRectGetMaxY(_refundView.frame)+30, 290, 40)];
        }else if ([secSdStr isEqualToString:@"是"]){
            _tjsd=@"1";
            _supportOrNo = @"0";
            self.selectDiscountStr=@"无折扣";
            discountLab.text = @"请选择折扣价格";
            [_pAndcView setFrame:CGRectMake(0, CGRectGetMaxY(_remView.frame)+10, MyWidth, 47)];
            _refundView.hidden=YES;
            UIView *view=[_refundView viewWithTag:777];
            view.hidden=YES;
            discountLab.hidden=YES;
            [commitBtn setFrame:CGRectMake(15, CGRectGetMaxY(_pAndcView.frame)+30, 290, 40)];
        }
        [self requestPriceList];
        [self requestOddsInfo];
        [_rightScroll setContentSize:CGSizeMake(self.view.bounds.size.width,CGRectGetMaxY(commitBtn.frame)+64)];

        if ([_lotrySource isEqualToString:@"-201"]) {
            [self.xqResult removeAllObjects];
            NSArray *arr=@[self.leftWin,self.midWin,self.rightWin];
            for (UIButton *sbtn in arr) {
                sbtn.selected=NO;
            }
        }
        if([_lotrySource isEqualToString:@"202"]){
            _rqNo=@"";
            self.ypSaiGuo=@"";
            NSArray *arr=@[_ypoLefBtn,_ypoRigBtn,_yptLefBtn,_yptRigBtn];
            for (UIButton *sbtn in arr) {
                sbtn.selected=NO;
            }
        }
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        [_picker setFrame:CGRectMake(0, _picker.frame.origin.y+_picker.frame.size.height, _picker.frame.size.width, 0)];
        [_picker removeFromSuperview];
    }];
}

-(void)cancle:(id)sender
{
    _picker.pickerView.hidden = YES;
}

#pragma mark -------------UIPickerViewDelegate--------------------

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([self.pickType isEqualToString:@"6"]) {
        return [NSString stringWithFormat:@"%@",[self.lotryTypeArr objectAtIndex:row]];
    }else if ([self.pickType isEqualToString:@"0"]) {
        return [NSString stringWithFormat:@"%@",[self.matchTimeArr objectAtIndex:row]];
    }else if ([self.pickType isEqualToString:@"1"]) {
        return [NSString stringWithFormat:@"%@",[self.leagueNameArr objectAtIndex:row]];
    }else if ([self.pickType isEqualToString:@"2"]){
        return [NSString stringWithFormat:@"%@",[self.matchArr objectAtIndex:row]];
    }else if ([self.pickType isEqualToString:@"3"]){
        return [NSString stringWithFormat:@"%@",[self.prizeNameArr objectAtIndex:row]];
    }else if ([self.pickType isEqualToString:@"4"]){
        return [NSString stringWithFormat:@"%@",[self.discountArr objectAtIndex:row]];
    }else if ([self.pickType isEqualToString:@"5"]){
        return [NSString stringWithFormat:@"%@",[self.playWay objectAtIndex:row]];
    }else if ([self.pickType isEqualToString:@"7"]){
        return [NSString stringWithFormat:@"%@",[self.sdIsOrNoArr objectAtIndex:row]];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //[pickerView reloadComponent:1];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if([self.pickType isEqualToString:@"6"]){
        return self.lotryTypeArr.count;
    }else if ([self.pickType isEqualToString:@"0"]) {
        return self.matchTimeArr.count;
    }else if ([self.pickType isEqualToString:@"1"]) {
        return self.leagueNameArr.count;
    }else if ([self.pickType isEqualToString:@"2"]) {
        return self.matchArr.count;
    }else if ([self.pickType isEqualToString:@"3"]) {
        return self.prizeNameArr.count;
    }else if ([self.pickType isEqualToString:@"4"]){
        return self.discountArr.count;
    }else if ([self.pickType isEqualToString:@"5"]){
        return self.playWay.count;
    }else if ([self.pickType isEqualToString:@"7"]){
        return self.sdIsOrNoArr.count;
    }
    return 0;
}

#pragma mark ----------------请求接口------------------

#pragma mark -----------调用发布竞彩方案接口-------------

/**
 包含非法字符
 */
- (BOOL)haveExpRecSensitiveWorld{
    return NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"expRecSensitiveWord.txt"];
    NSData *fileData = [fileManager contentsAtPath:path];
    if (fileData) {
        NSString *str = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
        NSArray *arr=[str componentsSeparatedByString:@"\r\n"];
        for (int i=0; i<[arr count]; i++) {
            NSString *compareStr=[arr objectAtIndex:i];
            if ([planTitView.text rangeOfString:compareStr].location!=NSNotFound||[reasonView.text rangeOfString:compareStr].location!=NSNotFound) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的发布内容含有敏感词汇，请修改！！！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                return YES;
            }
        }
    }
    return NO;
}

-(void)commitCompeteRequest
{
    BOOL canReleaseOrNo=[self canReleasePlanOrNo];
    if (!canReleaseOrNo) {
        return;
    }
    //if ([self haveExpRecSensitiveWorld]) {
    //    return;
    //}
    
    //选择的价格
    for (NSDictionary *nameDic in self.priceDic) {
        if ([self.selectPriceStr isEqualToString:nameDic[@"priceName"]]) {
            _priceId = nameDic[@"price"];
        }
    }
    //选择折扣的价格
    for (NSDictionary *nameDic in self.discountDic) {
        if ([self.selectPriceStr isEqualToString:@"免费"]) {
            NSString *wuDiscountStr = @"无折扣";
            if ([wuDiscountStr isEqualToString:nameDic[@"discountName"]]) {
                _discountId = nameDic[@"discountCoeff"];
            }
        }else{
            if ([self.selectDiscountStr isEqualToString:nameDic[@"discountName"]]) {
                _discountId = nameDic[@"discountCoeff"];
            }
        }
    }
    NSString *rcStr=@"";
    NSString *preRslt=@"";
    if ([_lotrySource isEqualToString:@"-201"]) {
        NSString *sgSheng=@"";
        NSString *sgPing=@"";
        NSString *sgFu=@"";
        for (NSString *btnStr in self.xqResult) {
            NSString *sgResult = [btnStr substringToIndex:1];
            if ([sgResult isEqualToString:@"胜"]) {
                sgSheng=@"胜";
            }else if ([sgResult isEqualToString:@"平"]){
                sgPing=@"平";
            }else if([sgResult isEqualToString:@"负"]){
                sgFu=@"负";
            }
        }
        if([sgSheng isEqualToString:@"胜"]){
            preRslt=sgSheng;
            if ([sgPing isEqualToString:@"平"]) {
                preRslt=[NSString stringWithFormat:@"%@,%@",sgSheng,sgPing];
            }else if([sgFu isEqualToString:@"负"]){
                preRslt=[NSString stringWithFormat:@"%@,%@",sgSheng,sgFu];
            }
        }else if ([sgPing isEqualToString:@"平"]){
            preRslt=sgPing;
            if([sgFu isEqualToString:@"负"]){
                preRslt=[NSString stringWithFormat:@"%@,%@",sgPing,sgFu];
            }
        }else if([sgFu isEqualToString:@"负"]){
            preRslt=sgFu;
        }
        if ([_playType isEqualToString:@"10"]){//拼接方法[主队(空格)胜，平，负]
            rcStr = [NSString stringWithFormat:@"%@ %@",_homeName,preRslt];
            _rqNo=@"";
        } else if([_playType isEqualToString:@"01"]) {//拼接方法[主队(空格)(让球数)(空格)胜，平，负]
            rcStr = [NSString stringWithFormat:@"%@ (%@) %@",_homeName,_rqNo,preRslt];
        }
    }else if([_lotrySource isEqualToString:@"202"]){
        if (self.ypsflvSel!=nil&&![self.ypsflvSel isEqualToString:@""]) {
            NSArray *sfoArr=[self.ypsflvSel componentsSeparatedByString:@"_"];
            _playType=[sfoArr objectAtIndex:0];
            _rqOddStr=[NSString stringWithFormat:@"%@ %@",[sfoArr objectAtIndex:1],[sfoArr objectAtIndex:2]];
        }
        if (self.ypSaiGuo!=nil&&![self.ypSaiGuo isEqualToString:@""]) {
            rcStr = [NSString stringWithFormat:@"%@ (%@) %@",_homeName,_rqNo,self.ypSaiGuo];
            preRslt=[NSMutableString stringWithString:self.ypSaiGuo];
        }
    }
    
    NSMutableDictionary  *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"dadtaSource":_lotrySource,@"leagueName":_selectLeagueName,@"playTypeCode":_playType,@"matchTime":_selectTime,@"discount":_discountId,@"expertsName":[[Info getInstance] userName],@"recommendTitle":planTitView.text,@"price":_priceId,@"hostRq":_rqNo,@"predictResult":preRslt,@"matchId":_matchIdSelected,@"sdStatus":_tjsd,@"free_status":_supportOrNo,@"recommendContent":rcStr,@"recommendExplain":reasonView.text,@"lotteryClassCode":_lotrySource,@"playId":_playID,@"matchStatus":_matchStatus,@"ccId":_eventId,@"awayName":_guestName,@"expertsClassCode":@"001",@"homeName":_homeName,@"odds":_oddsStr,@"rqOdds":_rqOddStr,@"asian_sp":self.ypsflvSel,@"clientType":@"2",@"publishVersion":APPVersion}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"sMGExpertService",@"methodName":@"publishSMGPlan",@"parameters":parametersDic}];
    
    [MBProgressHUD showMessage:@"提交中..."];
    [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
        [MBProgressHUD hideHUD];
        NSDictionary  *respondDic = respondObject;
        if ([respondDic[@"resultCode"] isEqualToString:@"0000"]){
            if ([self.sourceStr isEqualToString:@"0"]||[self.sourceStr isEqualToString:@"11"]||[self.sourceStr isEqualToString:@"9"]) {//特邀专家
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"恭喜您提交方案成功" delegate:self cancelButtonTitle:@"一会再说" otherButtonTitles:@"再发一场", nil];
                [alertView show];
            }else if ([self.sourceStr isEqualToString:@"1"]){
                if ([_lotrySource isEqualToString:@"-201"]&&([self.jc_TdPubNo intValue]+[self.sd_jc_TdPubNo intValue]>=2)) {
                    if ([self.yp_TdPubNo intValue]+[self.sd_yp_TdPubNo intValue]<3) {
                        [self showAlertTitle:@"恭喜您方案提交成功" tag:101 msg:@"高手一天只能发布三场竞彩，快去发亚盘吧！"  delegate:self cancelBtnTitle:@"一会再说" otherBtnTitle:@"去发亚盘"];
                    }else{
                        [self showAlertTitle:nil tag:0 msg:@"恭喜您方案提交成功,我们将尽快为您审核" delegate:self cancelBtnTitle:@"好的" otherBtnTitle:nil];
                    }
                }else if ([_lotrySource isEqualToString:@"202"]&&([self.yp_TdPubNo intValue]+[self.sd_yp_TdPubNo intValue]>=2)){
                    if ([self.jc_TdPubNo intValue]+[self.sd_jc_TdPubNo intValue]<3) {
                        [self showAlertTitle:@"恭喜您方案提交成功" tag:102 msg:@"高手一天只能发布三场亚盘，快去发竞彩吧！"  delegate:self cancelBtnTitle:@"一会再说" otherBtnTitle:@"去发竞彩"];
                    }else{
                        [self showAlertTitle:nil tag:0 msg:@"恭喜您方案提交成功,我们将尽快为您审核" delegate:self cancelBtnTitle:@"好的" otherBtnTitle:nil];
                    }
                }else{
                    [self showAlertTitle:nil tag:0 msg:@"恭喜您方案提交成功,我们将尽快为您审核" delegate:self cancelBtnTitle:@"一会再说" otherBtnTitle:@"再发一场"];
                }
            }
        }else{
            [self showAlertTitle:nil tag:0 msg:respondDic[@"resultDesc"] delegate:nil cancelBtnTitle:@"好的" otherBtnTitle:nil];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

- (void)showAlertTitle:(NSString *)title tag:(NSInteger)tag msg:(NSString *)msg delegate:(nullable id)delegate cancelBtnTitle:(NSString *)cancelBtnTitle otherBtnTitle:(NSString *)otherBtnTitle,...{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:delegate cancelButtonTitle:cancelBtnTitle otherButtonTitles:otherBtnTitle,nil];
    alert.tag=tag;
    [alert show];
}

- (BOOL)canReleasePlanOrNo{
    if ([self.tjsd isEqualToString:@"1"]) {
        if ([_lotrySource isEqualToString:@"-201"]) {
            if ([self.sd_jc_TdPubNo intValue]>=2) {
                [self showAlert:@"竞彩每天只能发两场神单" tit:@"提醒"];
                return NO;
            }else
                return YES;
        }
        if ([_lotrySource isEqualToString:@"202"]) {
            if ([self.sd_yp_TdPubNo intValue]>=2) {
                [self showAlert:@"亚盘每天只能发两场神单" tit:@"提醒"];
                return NO;
            }else
                return YES;
        }
    }else
        return YES;
    return YES;
}

#pragma mark -------获取竞彩联赛种类列表--------

-(void)requestLeagueList:(NSString *)source
{
    [self.leagueArr removeAllObjects];
    [self.matchTimeArr removeAllObjects];
    NSString *sourPara=@"";
    if ([source isEqualToString:@"-201"]) {
        sourPara=@"1";
    }else if([source isEqualToString:@"202"]){
        sourPara=@"2";
    }
    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"expertsName":[[Info getInstance] userName],@"source":sourPara}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"sMGExpertService",@"methodName":@"getLeagueTypeList",@"parameters":parametersDic}];
    [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
        self.leagueList = respondObject;
        if ([self.leagueList[@"resultCode"] isEqualToString:@"0000"]) {
            NSArray *resultArr = self.leagueList[@"result"];
            for (NSDictionary *nameDic in resultArr) {
                [self.leagueArr addObject:nameDic];
                NSString *time=[nameDic objectForKey:@"MATCHDATE"];
                if (![self.matchTimeArr containsObject:time]) {
                    [self.matchTimeArr addObject:time];
                }
                if (![[nameDic objectForKey:@"INFOSOURCE"] isEqualToString:@""]&&[nameDic objectForKey:@"INFOSOURCE"]!=nil) {
                    _infoSourceLab.text=[nameDic objectForKey:@"INFOSOURCE"];
                }
            }
            if (_matchM||_gameDeteilMdl) {
                NSString *idStr=@"";
                NSArray *nameArr = self.leagueList[@"result"];
                for (NSDictionary *nameDic in nameArr) {
                    if ([self.selectLeagueName isEqualToString:nameDic[@"NAME"]]) {
                        idStr = nameDic[@"ID"];
                    }
                }
                if ([idStr isEqualToString:@""]||idStr==nil) {
                    return;
                }
                [self requestMatchList:_lotrySource leagueId:idStr];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"错误的errror--%@",error);
    }];
}

#pragma mark ----------获取某联赛下的比赛列表---------

-(void)requestMatchList:(NSString *)source leagueId:(NSString *)leagueId
{
    [self.matchArr removeAllObjects];
    [self.matchIdArr removeAllObjects];
    [self.playIdArr removeAllObjects];
    if (!_matchM&&!_gameDeteilMdl) {
        _matchIdSelected=@"";
    }
    NSString *sourPara=@"1";
    if ([source isEqualToString:@"-201"]) {
        sourPara=@"1";
    }else if([source isEqualToString:@"202"]){
        sourPara=@"2";
    }
    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"leagueId":leagueId,@"expertsName":[[Info getInstance] userName],@"date":_selectDate,@"source":sourPara}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"sMGExpertService",@"methodName":@"getMatchList",@"parameters":parametersDic}];
    if (leagueId.length != 0) {
        [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
            self.matchList = respondObject;
            if ([self.matchList[@"resultCode"] isEqualToString:@"0000"]) {
                NSArray *resultArr = self.matchList[@"result"];
                for (NSDictionary *nameDic in resultArr) {//添加比赛
                    NSString *nameAndTimeStr = [NSString stringWithFormat:@"%@   %@VS%@",nameDic[@"cc_ID"],nameDic[@"host_NAME_SIMPLY"],nameDic[@"guest_NAME_SIMPLY"]];
                    [self.playIdArr addObject:nameDic[@"play_ID"]];
                    [self.matchIdArr addObject:nameDic[@"match_ID"]];
                    [self.matchArr addObject:nameAndTimeStr];
                }
            }
            if (_matchM||_gameDeteilMdl) {
                [self remmodplayMethond];
            }else{
                if (self.matchArr.count != 0) {
                    [self selectPickerView];
                }else {
                    if ([leagueLab.text isEqualToString:@"请选择赛事"]) {
                        [self showAlert:@"请先确定赛事!" tit:nil];
                    }else{
                        [self showAlert:@"目前没有比赛!" tit:nil];
                    }
                }
            }
        } failure:^(NSError *error) {
            NSLog(@"错误的errror--%@",error);
        }];
    }
}

#pragma mark -----------获取价格列表---------

-(void)requestPriceList
{
    NSString *loSource=_lotrySource;
    if ([_tjsd isEqualToString:@"1"]){
        if ([_lotrySource isEqualToString:@"-201"]) {
            loSource=@"sd_201";
        }else if([_lotrySource isEqualToString:@"202"]) {
            loSource=@"sd_202";
        }
    }
    
    NSMutableDictionary  *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"expertsName":[[Info getInstance] userName],@"lotteryClassCode":loSource}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"commonExpertService",@"methodName":@"getPlanPriceList",@"parameters":parametersDic}];
    [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
        NSDictionary *dataDic = respondObject;
        if ([dataDic[@"resultCode"] isEqualToString:@"0000"]) {
            [self.prizeNameArr removeAllObjects];
            [self.priceNoArr removeAllObjects];
            self.priceDic = dataDic[@"result"];
            for (NSDictionary *priceDic in self.priceDic) {
                [self.prizeNameArr addObject:priceDic[@"priceName"]];
                [self.priceNoArr addObject:priceDic[@"price"]];
            }
            NSString *price=[self.prizeNameArr objectAtIndex:0];
            priceLab.text=[NSString stringWithFormat:@"当前方案价格:￥%@",price];
            _priceId=[self.priceNoArr objectAtIndex:0];
        }
    } failure:^(NSError *error) {
        NSLog(@"错误的errror--%@",error);
    }];
}

#pragma mark ------------获取折扣列表------------

-(void)requestDiscountList
{
    NSMutableDictionary  *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"commonExpertService",@"methodName":@"getPlanDiscountList",@"parameters":parametersDic}];
    [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
        NSDictionary *dataDic = respondObject;
        if ([dataDic[@"resultCode"] isEqualToString:@"0000"]) {
            self.discountDic = dataDic[@"result"];
            for (NSDictionary *discountDic in self.discountDic) {
                [self.discountArr addObject:discountDic[@"discountName"]];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"错误的errror--%@",error);
    }];
}

#pragma mark ----------获取今日发布方案的次数-------------

-(void)toLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
}
-(void)requestPulishNo
{
    Info *info = [Info getInstance];
    if (![info.userId intValue]) {
        [self toLogin];
        return;
    }
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:@{@"expertsName":[[Info getInstance] userName],@"expertsClassCode":@"001"}];
    NSMutableDictionary *bodDic4=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"checkPublishInfo",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic4 success:^(id JSON) {
        NSDictionary *dic=JSON[@"result"];
        self.jc_TdPubNo=dic[@"today_PublishNum_JcSingle"];
        self.yp_TdPubNo=dic[@"today_PublishNum_Asian"];
        self.sd_jc_TdPubNo=dic[@"today_PublishNum_SdJcSingle"];
        self.sd_yp_TdPubNo=dic[@"today_PublishNum_SdAsian"];
        if (([_jc_TdPubNo intValue] + [_sd_jc_TdPubNo intValue] == 3) && ([_yp_TdPubNo intValue] + [_sd_yp_TdPubNo intValue] ==3)) {
            self.lotryTypeArr=[NSMutableArray array];
        }
        else if([_jc_TdPubNo intValue] + [_sd_jc_TdPubNo intValue]==3){
            self.lotryTypeArr=[NSMutableArray arrayWithObjects:@"亚盘", nil];
            lotryTypeLab.textColor=BLACK_TWENTYSIX;
            _lotrySource=@"202";
        }else if ([_yp_TdPubNo intValue] + [_sd_yp_TdPubNo intValue] ==3){
            self.lotryTypeArr=[NSMutableArray arrayWithObjects:@"竞彩", nil];
            lotryTypeLab.textColor=BLACK_TWENTYSIX;
            _lotrySource=@"-201";
        }else{
            if ([_lotrySource isEqualToString:@""]||_lotrySource==nil) {
                _lotrySource=@"-201";
            }
            self.lotryTypeArr=[NSMutableArray arrayWithObjects:@"竞彩", @"亚盘", nil];
        }
        
        NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] initWithDictionary:[DEFAULTS objectForKey:@"resultDic"]];
        
        if ([_lotrySource isEqualToString:@"-201"]) {
            lotryTypeLab.text = @"当前彩种：竞彩";
            if ([self.sd_jc_TdPubNo intValue]>=2) {
                _tjsdOrNo=@"0";
                [dic1 setValue:_tjsdOrNo forKey:@"sdJcStatus"];
            }
        }else if([_lotrySource isEqualToString:@"202"]){
            lotryTypeLab.text = @"当前彩种：亚盘";
            if ([self.sd_yp_TdPubNo intValue]>=2) {
                _tjsdOrNo=@"0";
                [dic1 setValue:_tjsdOrNo forKey:@"sdYpStatus"];
            }
        }
        
        [DEFAULTS setValue:dic1 forKey:@"resultDic"];
        
        [self resetView];

    } failure:^(NSError * error) {
        
    }];
}


#pragma mark -----------获取价格列表---------

-(void)requestOddsInfo
{
    NSMutableDictionary  *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"type":_tjsd}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"expertService",@"methodName":@"getOddsInfo",@"parameters":parametersDic}];
    [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
        NSDictionary *dataDic = respondObject;
        if ([dataDic[@"resultCode"] isEqualToString:@"0000"]) {
            self.singleSelectOdds = dataDic[@"result"][@"multipleChoiceOdds"];
            self.doubleSelectOdds = dataDic[@"result"][@"doubleSelectionOdds"];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"错误的errror--%@",error);
    }];
}

//#pragma mark -----------周几的选择--------------
//
//-(NSString *)seletWorkAndTime
//{
//    //当前日前日期
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
//    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    //实例化一个NSDateFormatter对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    //此刻的系统时间
//    NSDate *now = [NSDate date];
//    NSString *currentDateStr=[dateFormatter stringFromDate:[NSDate date]];
//    comps = [calendar components:unitFlags fromDate:now];
//    NSString * week = [NSString stringWithFormat:@"%ld",(long)[comps weekday]];
//
//    NSDictionary * Weekdic = @{@"1":@"星期日",@"2":@"星期一",@"3":@"星期二",@"4":@"星期三",@"5":@"星期四",@"6":@"星期五",@"7":@"星期六"};
//    NSString * years = [NSString stringWithFormat:@"%@年",[currentDateStr substringToIndex:4]];
//    NSString * month = [NSString stringWithFormat:@"%@月",[currentDateStr substringWithRange:NSMakeRange(5, 2)]];
//    NSString * dayNow = [NSString stringWithFormat:@"%@日",[currentDateStr substringWithRange:NSMakeRange(8, 2)]];
//    NSString * WeekDay = [Weekdic objectForKey:week];
//
//    return  [NSString stringWithFormat:@"   %@%@%@ %@",years,month,dayNow,WeekDay];
//}

//#pragma mark ------------添加本地推送---------------
//- (void)willMoveToSuperview
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextViewTextDidChangeNotification object:nil];
//}
//
//- (void)notifiRemoveFSuperview
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
//}

@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    