//
//  SMGDetailViewController.m
//  Experts
//
//  Created by hudong yule on 15/10/30.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "SMGDetailViewController.h"
#import "BallDetailViewController.h"
#import "ProjectDetailViewController.h"
#import "CommonProblemViewController.h"
#import "ShenDanDetailViewController.h"

#import "DetailHeaderView.h"
#import "CP_LieBiaoView.h"
#import "SMGDetailCell.h"
#import "DigitalDetailCell.h"
#import "PlanSMGTableViewCell.h"

#import "PerHonorCell.h"
#import "WinRecCell.h"

#import "NSString+ExpertStrings.h"

#import "ExpertDetail.h"
#import "Expert365Bridge.h"
#import "LoginViewController.h"

#import "caiboAppDelegate.h"

#import "PurchaseAlertView.h"
#import "LegMatchModel.h"
#import "MobClick.h"
#import "ExpertDetailListTableViewCell.h"
#import "UIImage+Additions.h"

@interface SMGDetailViewController ()<UITableViewDataSource,UITableViewDelegate,DetailHeaderViewDelegate,DigitalDetailCellDelegate,SMGDetailCellPlanDetailDelegate,UIAlertViewDelegate,CP_UIAlertViewDelegate,CP_lieBiaoDelegate,PurchaseAlertViewDelegate>
{
    UITableView * _SMGDetailTableView;
    DetailHeaderView * _headerViewOfSectionOne;
    
    UIView * _footView;//双色球、大乐透
    UIScrollView * _scrollowFootView;
    NSInteger _rightOrWrong; //区分对号错号
    
    NSMutableArray * _rightORwrongArr;
    
    NSInteger focusType;
    
    NSString *teamName;//跳查看方案详情用到
}

@property(nonatomic,assign)float payJiage;
@property(nonatomic,strong)NewPlanList *nPlanBtn;
@property(nonatomic,strong)NewPlanListShuZiCai *npSzcBtn;
@property(nonatomic,strong)NSMutableArray *showingArray;
@property(nonatomic,strong)CP_UIAlertView *cpAlert;
@property(nonatomic,strong)UIButton * rgtBarBtn;

@property(nonatomic,strong)NSString * sendLryType;//传过来的彩种
@property(nonatomic,strong)NSMutableArray *purchaseAlertArr;//神单购买弹窗详情
@property(nonatomic,strong)NSString *beenBuy;//是否有购买的神单方案

@end

@implementation SMGDetailViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        _rightORwrongArr = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title_nav=@"专家详情";
    
    teamName = @"";
    
    _digitalNavBtnTag=0;
    _sendLryType=_jcyplryType;
    [self creatNavView];
    self.beenBuy=@"0";
    [MobClick event:@"Zj_fangan_20161014_jingcai_zhuanjia" label:self.exBaseInfo.expertsNickName];
    UIButton * rightBarButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setBackgroundColor:[UIColor clearColor]];
    [rightBarButton setFrame:CGRectMake(MyWidth-53, HEIGHTBELOESYSSEVER, 53, 44)];
    
#if !defined YUCEDI && !defined DONGGEQIU
//    UIImageView * rightBarImageView = [[UIImageView alloc] initWithFrame:CGRectMake((rightBarButton.frame.size.width - 19)/2, (rightBarButton.frame.size.height - 19)/2, 19, 19)];
//    rightBarImageView.image = [UIImage imageNamed:@"fenxiangzjxq"];
//    [rightBarButton addSubview:rightBarImageView];
//    [rightBarButton addTarget:self action:@selector(detailShare:) forControlEvents:UIControlEventTouchUpInside];
//    [self.navView addSubview:rightBarButton];
//    _rgtBarBtn=rightBarButton;
#endif
    
    self.showingArray=[NSMutableArray arrayWithObjects:[NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], nil];
    
    if (_exBaseInfo.focusStatus==1) {
        focusType=1;
    }else if (_exBaseInfo.focusStatus==0){
        focusType=0;
    }
    
    //创建tableView
    [self creatSMGDetailTableView];
    
    //创建tableView的footView,竞彩没有footView
    if (!_segmentOnClickIndexFlags) {
        [self creatTableViewFootView];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    Info *info = [Info getInstance];
    if ([info.userId intValue]) {
        [self callGodPlanMethod];
    }
    
#if defined CRAZYSPORTS
    [self changeCSTitileColor];
#endif
}

//分享
- (void)detailShare:(UIButton *)sender {
    Info *info1 = [Info getInstance];
    if (![info1.userId intValue]) {
        [self toLogin];
        return;
    }
    
    CP_LieBiaoView *lb2 = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    lb2.delegate = self;
    lb2.tag = 103;
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        lb2.weixinBool = YES;
#ifdef CRAZYSPORTS
        [lb2 LoadButtonName:[NSArray arrayWithObjects:@"分享到朋友圈",@"分享给微信好友(未安装)",nil]];
#else
        [lb2 LoadButtonName:[NSArray arrayWithObjects:@"分享到彩民微博",@"分享到朋友圈",@"分享给微信好友(未安装)",@"新浪微博",nil]];
#endif
    }else{
        lb2.weixinBool = NO;
#ifdef CRAZYSPORTS
        [lb2 LoadButtonName:[NSArray arrayWithObjects:@"分享到朋友圈",@"分享给微信好友",nil]];
#else
        [lb2 LoadButtonName:[NSArray arrayWithObjects:@"分享到彩民微博",@"分享到朋友圈",@"分享给微信好友",@"新浪微博",nil]];
#endif
    }
    
    lb2.isSelcetType = YES;
    [lb2 shareDetail];
    return;
}

- (void)shareWiXinFriends{//微信聊天界面
    
//#ifdef CRAZYSPORTS
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    
    UIImage *image = nil;
    if(_exBaseInfo.headPortrait.length && ![_exBaseInfo.headPortrait isEqualToString:@"null"]){
        NSData *imahgeData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_exBaseInfo.headPortrait]];
        image = [UIImage imageWithData:imahgeData];
    }else{
        image = [UIImage imageNamed:@"Icon~iphone.png"];
    }
    
    [appcaibo RespLinkContentUrl:[NSString stringWithFormat:@"http://t.fengkuangtiyu.cn/module/expert/expertInfo.html?eName=%@",_exBaseInfo.expertsName] title:[NSString stringWithFormat:@"喂饼预测|%@",_exBaseInfo.expertsNickName] image:image content:[NSString stringWithFormat:@"喂饼预测|%@",_exBaseInfo.expertsNickName]  wxScene:WXSceneSession];
//#else
//    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
//    UIImage * screenImage =  [appcaibo imageWithScreenContents];
//    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
//    [appcaibo sendImageContent:screenImage ToWXScene:WXSceneSession];
//    _rgtBarBtn.userInteractionEnabled=YES;
//#endif
    
}

- (void)shareWeiXin{//微信朋友圈
    
//#ifdef CRAZYSPORTS
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    
    UIImage *image = nil;
    if(_exBaseInfo.headPortrait.length && ![_exBaseInfo.headPortrait isEqualToString:@"null"]){
        NSData *imahgeData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_exBaseInfo.headPortrait]];
        image = [UIImage imageWithData:imahgeData];
    }else{
        image = [UIImage imageNamed:@"Icon~iphone.png"];
    }
    
    [appcaibo RespLinkContentUrl:[NSString stringWithFormat:@"http://t.fengkuangtiyu.cn/module/expert/expertInfo.html?eName=%@",_exBaseInfo.expertsName] title:[NSString stringWithFormat:@"喂饼预测|%@",_exBaseInfo.expertsNickName] image:[image imageScaledInterceptToSize:CGSizeMake(100, 100)] content:[NSString stringWithFormat:@"喂饼预测|%@",_exBaseInfo.expertsNickName]];
//#else
//    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
//    UIImage * screenImage =  [appcaibo imageWithScreenContents];
//    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
//    [appcaibo sendImageContent:screenImage ToWXScene:WXSceneTimeline];
//    _rgtBarBtn.userInteractionEnabled=YES;
//#endif
    
}

- (void)sinaShareFunc{//彩民分享
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    UIImage * screenImage =  [appcaibo screenshotWithScrollView:_SMGDetailTableView bottomY:_SMGDetailTableView.contentSize.height  titleBool:YES Moreheight:45];
    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.infoShare = YES;
    publishController.mSelectImage = screenImage;
    publishController.microblogType = NewTopicController;
    publishController.title = @"分享微博";
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated:YES completion:^{}];
    _rgtBarBtn.userInteractionEnabled=YES;
}

- (void)sinaShare{//新浪分享
    caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
    UIImage * screenImage =  [appcaibo screenshotWithScrollView:_SMGDetailTableView bottomY:_SMGDetailTableView.contentSize.height  titleBool:YES Moreheight:45];
    UIImageWriteToSavedPhotosAlbum(screenImage, nil,nil, nil);
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.infoShare = YES;
    publishController.mSelectImage = screenImage;
    publishController.microblogType = NewTopicController;
    publishController.shareTo = @"1";
    publishController.title = @"分享微博";
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated:YES completion:^{}];
    _rgtBarBtn.userInteractionEnabled=YES;
}

- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    _rgtBarBtn.userInteractionEnabled=NO;
    if (liebiaoView.tag == 103) {
        if (liebiaoView.weixinBool) {
            if (buttonIndex == 0) {//分享彩民微博
#ifdef CRAZYSPORTS
                [self performSelector:@selector(shareWeiXin) withObject:nil afterDelay:0.3];
#else
                [self performSelector:@selector(sinaShareFunc) withObject:nil afterDelay:0.3];
#endif
            }else if(buttonIndex == 1){//分享新浪微博
#ifdef CRAZYSPORTS
                [self performSelector:@selector(shareWiXinFriends) withObject:nil afterDelay:0.3];
#else
                [self performSelector:@selector(sinaShare) withObject:nil afterDelay:0.3];
#endif
            }else if (buttonIndex == 2){//分享朋友圈
                [self performSelector:@selector(shareWeiXin) withObject:nil afterDelay:0.3];
            }else if(buttonIndex == 3){//分享微信好友
                [self performSelector:@selector(shareWiXinFriends) withObject:nil afterDelay:0.3];
            }
        }else {
            if (buttonIndex == 0) {//分享彩民微博
#ifdef CRAZYSPORTS
                [self performSelector:@selector(shareWeiXin) withObject:nil afterDelay:0.3];
#else
                [self performSelector:@selector(sinaShareFunc) withObject:nil afterDelay:0.3];
#endif
            }else if(buttonIndex == 1){//分享朋友圈
#ifdef CRAZYSPORTS
                [self performSelector:@selector(shareWiXinFriends) withObject:nil afterDelay:0.3];
#else
                [self performSelector:@selector(shareWeiXin) withObject:nil afterDelay:0.3];
#endif
            }else if (buttonIndex == 2){//分享微信好友
                [self performSelector:@selector(shareWiXinFriends) withObject:nil afterDelay:0.3];
            }else if(buttonIndex == 3){//分享新浪微博
                [self performSelector:@selector(sinaShare) withObject:nil afterDelay:0.3];
            }
        }
    }
}

/**
 *  创建tableView
 */
-(void)creatSMGDetailTableView
{
    if (_lotryType==101) {
        _npList=_SSQ_NP_ARR;
    }else if(_lotryType==102){
        _npList=_DLT_NP_ARR;
    }else if(_lotryType==103){
        _npList=_FC3D_NP_ARR;
    }else if(_lotryType==104){
        _npList=_PL3_NP_ARR;
    }
    _SMGDetailTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,HEIGHTBELOESYSSEVER+44, MyWidth, MyHight-64) style:UITableViewStyleGrouped];
    _SMGDetailTableView.showsHorizontalScrollIndicator=NO;
    _SMGDetailTableView.showsVerticalScrollIndicator=NO;
    _SMGDetailTableView.delegate=self;
    _SMGDetailTableView.dataSource=self;
    _SMGDetailTableView.separatorColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
    _SMGDetailTableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [self.view addSubview:_SMGDetailTableView];
}

/**
 *  创建footview
 */
-(void)creatTableViewFootView
{   //双色球和大乐透差不多，福彩3D和排列三几乎一样
    if (_lotryType==101) {
        _leastTenPlanArr=_SSQ_LTP_ARR;
    }else if(_lotryType==102){
        _leastTenPlanArr=_DLT_LTP_ARR;
    }else if(_lotryType==103){
        _leastTenPlanArr=_FC3D_LTP_ARR;
    }else if(_lotryType==104){
        _leastTenPlanArr=_PL3_LTP_ARR;
    }
    if (_lotryType==101||_lotryType==102) {
        [self creatTableViewFootViewOfShuangAndLotto];
    }else if(_lotryType==103||_lotryType==104){
        [self creatTableViewFootViewOf3DAndPailiesan];
    }
}

/**
 *  创建双色球和大乐透选项的footView（即历史战绩）
 */
-(void)creatTableViewFootViewOfShuangAndLotto
{
    if (_footView) {
        for (UIView *view in [_footView subviews]) {
            [view removeFromSuperview];
        }
        _footView=nil;
    }
    if (_footView==nil&&_leastTenPlanArr&&[_leastTenPlanArr count]!=0) {
        
        _btn3DAndPaiClickFlags=NO;
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MyWidth, 200)];
        //footView分为四种情况，双色球、大乐透、福彩3D、排列三
        CGFloat rowHeight=32.5;
        CGFloat rowWith=(MyWidth-64.5)/9;
        
        //第一条横线
        UIView * rowLine=[[UIView alloc]initWithFrame:CGRectMake(0,0, MyWidth, 0.5)];
        rowLine.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
        [_footView addSubview:rowLine];
        
        //第二条横线
        rowLine=[[UIView alloc]initWithFrame:CGRectMake(0,33, MyWidth, 0.5)];
        rowLine.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
        [_footView addSubview:rowLine];
        
        //填充第一行（双色球）
        NSArray *labelTitleArray=nil;
        if (_lotryType==101) {
            labelTitleArray=[NSArray arrayWithObjects:@"期号",@"20码",@"12码",@"3码",@"独胆",@"杀6码",@"龙头",@"凤尾",@"3码",@"杀3码", nil];
        }else if(_lotryType==102){
            labelTitleArray=[NSArray arrayWithObjects:@"期号",@"20码",@"10码",@"3码",@"独胆",@"杀6码",@"龙头",@"凤尾",@"3码",@"杀6码", nil];
        }
        
        for (int j=0; j<labelTitleArray.count; j++) {
            UILabel * headerLabel=[[UILabel alloc]init];
            [_footView addSubview:headerLabel];
            headerLabel.textAlignment=NSTextAlignmentCenter;
            headerLabel.text=[labelTitleArray objectAtIndex:j];
            if (j==0) {
                headerLabel.frame=CGRectMake(0,0.5,60, rowHeight);
                headerLabel.font=FONTTWENTY_FOUR;
                headerLabel.textColor=[UIColor blackColor];
                headerLabel.backgroundColor=[UIColor colorWithHexString:@"eaeaea"];
            }else {
                headerLabel.frame=CGRectMake(60.5+(j-1)*(rowWith+0.5),0.5,rowWith,rowHeight);
                headerLabel.font=FONTTWENTY;
                headerLabel.textColor=RGB(255., 255., 255.);
            }
            if (j>=1&&j<=7) {
                headerLabel.backgroundColor=[UIColor colorWithHexString:@"ff3b30"];
            }else if (j>7) {
                headerLabel.backgroundColor=[UIColor colorWithHexString:@"11a3ff"];
            }
            
        }
        //这里应该是填充后台给的数据，先造个假的数据
        for (int i=0; i<[_leastTenPlanArr count]; i++) {
            [self setDataOfEveryRowWithNo:i+1 andFootView:_footView];//每行数据带上线共高30.5，第一行带上线共33.5
        }
        _footView.frame=CGRectMake(0, 0, MyWidth, 33.5+30.5*[_leastTenPlanArr count]);
        //竖线
        for (int i=0; i<9; i++) {
            UIView * columnLine=[[UIView alloc]init];
            columnLine.frame=CGRectMake(60+i*(rowWith+0.5),0.5,0.5,_footView.frame.size.height-0.5);
            [_footView addSubview:columnLine];
            columnLine.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
        }
    }
    _SMGDetailTableView.tableFooterView=_footView;
    
}
/**
 *  创建福彩3D和排列三选项的footView（即历史战绩）
 */
-(void)creatTableViewFootViewOf3DAndPailiesan
{
    
    if (_scrollowFootView) {
        for (UIView *view in [_scrollowFootView subviews]) {
            [view removeFromSuperview];
        }
        _scrollowFootView=nil;
    }
    if (_scrollowFootView==nil&&_leastTenPlanArr&&[_leastTenPlanArr count]!=0) {
        _btn3DAndPaiClickFlags=YES;
        _scrollowFootView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MyWidth, 200)];
        
        //福彩3D、排列三
        CGFloat rowHeight=30;
        CGFloat rowWith=(MyWidth-41.5)/10;
        _scrollowFootView.contentSize=CGSizeMake(305.5, 200);
        
        //最左侧加条线
        UIView * rowLine=[[UIView alloc]initWithFrame:CGRectMake(0,0,0.5,_scrollowFootView.frame.size.height)];
        [_scrollowFootView addSubview:rowLine];
        rowLine.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
        
        //第一条横线
        rowLine=[[UIView alloc]initWithFrame:CGRectMake(0,0,305.5, 0.5)];
        [_scrollowFootView addSubview:rowLine];
        rowLine.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
        
        //第二条横线
        rowLine=[[UIView alloc]initWithFrame:CGRectMake(0,30,305.5, 0.5)];
        [_scrollowFootView addSubview:rowLine];
        rowLine.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
        
        //填充第一行
        NSArray * labelTitleArray=[NSArray arrayWithObjects:@"期号",@"独胆",@"双胆",@"三胆",@"杀1码",@"五码复式",@"六码复式",@"三跨度",@"五码定位",@"和值",@"包星", nil];
        
        for (int j=0; j<labelTitleArray.count; j++) {
            UILabel * headerLabel=[[UILabel alloc]init];
            [_scrollowFootView addSubview:headerLabel];
            headerLabel.backgroundColor=[UIColor colorWithHexString:@"eaeaea"];
            headerLabel.textAlignment=NSTextAlignmentCenter;
            headerLabel.text=[labelTitleArray objectAtIndex:j];
            headerLabel.numberOfLines=0;
            if (j==0) {
                headerLabel.frame=CGRectMake(0,0.5,38, rowHeight);
                headerLabel.font=FONTTWENTY_FOUR;
                headerLabel.textColor=[UIColor blackColor];
                
            }else{
                headerLabel.frame=CGRectMake(38.5+(j-1)*(rowWith+0.5),0.5,rowWith,rowHeight);
                headerLabel.font=FONTTWENTY;
                headerLabel.textColor=RGB(17., 163., 255.);
            }
        }
        
        //这里应该是填充后台给的数据，先造个假的数据
        for (int i=0; i<[_leastTenPlanArr count]; i++) {
            [self setDataOfEveryRowWithNo:i+1 andFootView:_scrollowFootView];
        }
        _scrollowFootView.frame=CGRectMake(0, 0, MyWidth, 31+30.5*[_leastTenPlanArr count]);
        _scrollowFootView.contentSize=CGSizeMake(305.5, _scrollowFootView.frame.size.height);
        //竖线
        for (int i=0; i<11; i++) {
            UIView * columnLine=[[UIView alloc]init];
            columnLine.frame=CGRectMake(38+i*(rowWith+0.5),0.5,0.5,_scrollowFootView.frame.size.height-0.5);
            [_scrollowFootView addSubview:columnLine];
            columnLine.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
            NSLog(@"最大的x坐标：%f",CGRectGetMaxX(columnLine.frame));
        }
    }
    
    _SMGDetailTableView.tableFooterView=_scrollowFootView;
    
}
/**
 *  封装填充双色球的每行数据的函数  参数为第几行，将来接口出来了可以添加后台返回的数据作为参数
 */
-(void)setDataOfEveryRowWithNo:(NSInteger)Number andFootView:(UIView *)footView
{
    NSString *reIssue=@"";
    LeastTenPlanListShuangSeQiu *shuangSeQiuDetail=nil;
    LeastTenPlanListDaLeTou *daLeTouDetaik=nil;
    LeastTenPlanList_3D_PaiLie3 *d3PaiLie3Detail=nil;
    ;
    NSInteger index=Number-1;
    if (_lotryType==101) {
        shuangSeQiuDetail= [_leastTenPlanArr objectAtIndex:index];
        reIssue=shuangSeQiuDetail.erIssue;
    }else if(_lotryType==102){
        daLeTouDetaik=[_leastTenPlanArr objectAtIndex:index];
        reIssue=daLeTouDetaik.erIssue;
    }else if(_lotryType==103||_lotryType==104){
        d3PaiLie3Detail=[_leastTenPlanArr objectAtIndex:index];
        reIssue=d3PaiLie3Detail.erIssue;
    }
    
    //填充每一行（默认是双色球、大乐透的尺寸）
    CGFloat rowHeight=30;
    CGFloat rowWith=(MyWidth-64.5)/9;
    CGFloat rowHeightOfFirstRow=33.5;
    CGFloat rowHeightAndLine=30.5;
    CGFloat columnWithAndLine=60.5;
    int columnCount=10;
    if (_btn3DAndPaiClickFlags) {
        rowWith=(MyWidth-41.5)/10;
        rowHeightOfFirstRow=31;
        columnWithAndLine=38.5;
        columnCount=11;
    }
    for (int j=0; j<columnCount; j++) {
        if (j==0) {
            UILabel * headerLabel=[[UILabel alloc]init];
            [footView addSubview:headerLabel];
            headerLabel.textAlignment=NSTextAlignmentCenter;
            headerLabel.adjustsFontSizeToFitWidth = YES;
            headerLabel.text=reIssue;
            headerLabel.font=FONTTWENTY_FOUR;
            headerLabel.textColor=[UIColor colorWithRed:138.0/255.0 green:62.0/255 blue:0.0/255.0 alpha:0.87];
            headerLabel.backgroundColor=[UIColor colorWithHexString:@"eaeaea"];
            headerLabel.frame=CGRectMake(0, rowHeightOfFirstRow+rowHeightAndLine*(Number-1), columnWithAndLine-0.5, rowHeight);
        } else {
            UILabel * bgLabel=[[UILabel alloc]initWithFrame:CGRectMake(columnWithAndLine+(j-1)*(rowWith+0.5),rowHeightOfFirstRow+(Number-1)*rowHeightAndLine,rowWith,rowHeight)];
            [footView addSubview:bgLabel];
            bgLabel.backgroundColor=[UIColor whiteColor];

            UIImage *xImage=[UIImage imageNamed:@"错号"];
            if (_lotryType==101) {
                if ((j==1&&[shuangSeQiuDetail.HONG_QIU_20_MA intValue]!=0)||(j==2&&[shuangSeQiuDetail.HONG_QIU_12_MA intValue]!=0)||(j==3&&[shuangSeQiuDetail.HONG_QIU_3_DAN intValue]!=0)||(j==4&&[shuangSeQiuDetail.HONG_QIU_DU_DAN intValue]!=0)||(j==5&&[shuangSeQiuDetail.HONG_QIU_SHA_6_MA intValue]!=0)||(j==6&&[shuangSeQiuDetail.LONG_TOU intValue]!=0)||(j==7&&[shuangSeQiuDetail.FENG_WEI intValue]!=0)||(j==8&&[shuangSeQiuDetail.LAN_QIU_3_MA intValue]!=0)||(j==9&&[shuangSeQiuDetail.LAN_QIU_SHA_3_MA intValue]!=0)) {
                    xImage=[UIImage imageNamed:@"对号"];
                    
                    _rightOrWrong = 1;
                    
                    [_rightORwrongArr removeAllObjects];
                    
                    if (j==1&&[shuangSeQiuDetail.HONG_QIU_20_MA intValue]!=0) {
                        [_rightORwrongArr addObject:shuangSeQiuDetail.HONG_QIU_20_MA];
                    }else if (j==2&&[shuangSeQiuDetail.HONG_QIU_12_MA intValue]!= 0){
                        [_rightORwrongArr addObject:shuangSeQiuDetail.HONG_QIU_12_MA];
                    }else if (j==3&&[shuangSeQiuDetail.HONG_QIU_3_DAN intValue]!= 0){
                        [_rightORwrongArr addObject:shuangSeQiuDetail.HONG_QIU_3_DAN];
                    }else if (j==4&&[shuangSeQiuDetail.HONG_QIU_DU_DAN intValue]!= 0){
                        [_rightORwrongArr addObject:shuangSeQiuDetail.HONG_QIU_DU_DAN];
                    }else if (j==5&&[shuangSeQiuDetail.HONG_QIU_SHA_6_MA intValue]!= 0){
                        [_rightORwrongArr addObject:shuangSeQiuDetail.HONG_QIU_SHA_6_MA];
                    }else if (j==6&&[shuangSeQiuDetail.LONG_TOU intValue]!= 0){
                        [_rightORwrongArr addObject:shuangSeQiuDetail.LONG_TOU];
                    }else if (j==7&&[shuangSeQiuDetail.FENG_WEI intValue]!= 0){
                        [_rightORwrongArr addObject:shuangSeQiuDetail.FENG_WEI];
                    }else if (j==8&&[shuangSeQiuDetail.LAN_QIU_3_MA intValue]!= 0){
                        [_rightORwrongArr addObject:shuangSeQiuDetail.LAN_QIU_3_MA];
                    }else if (j==9&&[shuangSeQiuDetail.LAN_QIU_SHA_3_MA intValue]!= 0){
                        [_rightORwrongArr addObject:shuangSeQiuDetail.LAN_QIU_SHA_3_MA];
                    }
                }else{
                    xImage=[UIImage imageNamed:@"错号"];
                    _rightOrWrong = 2;
                }
            }else if(_lotryType==102){
                if ((j==1&&[daLeTouDetaik.QIAN_QU_20_MA intValue]!=0)||(j==2&&[daLeTouDetaik.QIAN_QU_10_MA intValue]!=0)||(j==3&&[daLeTouDetaik.QIAN_QU_3_DAN intValue]!=0)||(j==4&&[daLeTouDetaik.QIAN_QU_DU_DAN intValue]!=0)||(j==5&&[daLeTouDetaik.QIAN_QU_SHA_6_MA intValue]!=0)||(j==6&&[daLeTouDetaik.LONG_TOU intValue]!=0)||(j==7&&[daLeTouDetaik.FENG_WEI intValue]!=0)||(j==8&&[daLeTouDetaik.HOU_QU_3_MA intValue]!=0)||(j==9&&[daLeTouDetaik.HOU_QU_SHA_6_MA intValue]!=0)) {
                    xImage=[UIImage imageNamed:@"对号"];
                    _rightOrWrong = 1;
                    
                    [_rightORwrongArr removeAllObjects];
                    
                    if (j==1&&[daLeTouDetaik.QIAN_QU_20_MA intValue]!=0) {
                        [_rightORwrongArr addObject:daLeTouDetaik.QIAN_QU_20_MA];
                    }else if (j==2&&[daLeTouDetaik.QIAN_QU_10_MA intValue]!=0){
                        [_rightORwrongArr addObject:daLeTouDetaik.QIAN_QU_10_MA];
                    }else if (j==3&&[daLeTouDetaik.QIAN_QU_3_DAN intValue]!=0){
                        [_rightORwrongArr addObject:daLeTouDetaik.QIAN_QU_3_DAN];
                    }else if (j==4&&[daLeTouDetaik.QIAN_QU_DU_DAN intValue]!=0){
                        [_rightORwrongArr addObject:daLeTouDetaik.QIAN_QU_DU_DAN];
                    }else if (j==5&&[daLeTouDetaik.QIAN_QU_SHA_6_MA intValue]!=0){
                        [_rightORwrongArr addObject:daLeTouDetaik.QIAN_QU_SHA_6_MA];
                    }else if (j==6&&[daLeTouDetaik.LONG_TOU intValue]!=0){
                        [_rightORwrongArr addObject:daLeTouDetaik.LONG_TOU];
                    }else if (j==7&&[daLeTouDetaik.FENG_WEI intValue]!=0){
                        [_rightORwrongArr addObject:daLeTouDetaik.FENG_WEI];
                    }else if (j==8&&[daLeTouDetaik.HOU_QU_3_MA intValue]!=0){
                        [_rightORwrongArr addObject:daLeTouDetaik.HOU_QU_3_MA];
                    }else if (j==9&&[daLeTouDetaik.HOU_QU_SHA_6_MA intValue]!=0){
                        [_rightORwrongArr addObject:daLeTouDetaik.HOU_QU_SHA_6_MA];
                    }
                }else{
                    xImage=[UIImage imageNamed:@"错号"];
                    _rightOrWrong = 2;
                }
            }else if(_lotryType==103||_lotryType==104){
                if ((j==1&&[d3PaiLie3Detail.DU_DAN intValue]!=0)||(j==2&&[d3PaiLie3Detail.SHUANG_DAN intValue]!=0)||(j==3&&[d3PaiLie3Detail.SAN_DAN intValue]!=0)||(j==4&&[d3PaiLie3Detail.SHA_1_MA intValue]!=0)||(j==5&&[d3PaiLie3Detail.WU_MA_ZU_XUAN intValue]!=0)||(j==6&&[d3PaiLie3Detail.LIU_MA_ZU_XUAN intValue]!=0)||(j==7&&[d3PaiLie3Detail.SAN_KUA_DU intValue]!=0)||(j==8&&[d3PaiLie3Detail.WU_MA_DING_WEI intValue]!=0)||(j==9&&[d3PaiLie3Detail.HE_ZHI intValue]!=0)||(j==10&&[d3PaiLie3Detail.BAO_XING intValue]!=0)) {
                    xImage=[UIImage imageNamed:@"对号"];
                    _rightOrWrong = 1;
                    
                    [_rightORwrongArr removeAllObjects];
                    if (j==1&&[d3PaiLie3Detail.DU_DAN intValue]!=0) {
                        [_rightORwrongArr addObject:d3PaiLie3Detail.DU_DAN];
                    }else if (j==2&&[d3PaiLie3Detail.SHUANG_DAN intValue]!= 0){
                        [_rightORwrongArr addObject:d3PaiLie3Detail.SHUANG_DAN];
                    }else if (j==3&&[d3PaiLie3Detail.SAN_DAN intValue]!= 0){
                        [_rightORwrongArr addObject:d3PaiLie3Detail.SAN_DAN];
                    }else if (j==4&&[d3PaiLie3Detail.SHA_1_MA intValue]!= 0){
                        [_rightORwrongArr addObject:d3PaiLie3Detail.SHA_1_MA];
                    }else if (j==5&&[d3PaiLie3Detail.WU_MA_ZU_XUAN intValue]!= 0){
                        [_rightORwrongArr addObject:d3PaiLie3Detail.WU_MA_ZU_XUAN];
                    }else if (j==6&&[d3PaiLie3Detail.LIU_MA_ZU_XUAN intValue]!= 0){
                        [_rightORwrongArr addObject:d3PaiLie3Detail.LIU_MA_ZU_XUAN];
                    }else if (j==7&&[d3PaiLie3Detail.SAN_KUA_DU intValue]!= 0){
                        [_rightORwrongArr addObject:d3PaiLie3Detail.SAN_KUA_DU];
                    }else if (j==8&&[d3PaiLie3Detail.WU_MA_DING_WEI intValue]!= 0){
                        [_rightORwrongArr addObject:d3PaiLie3Detail.WU_MA_DING_WEI];
                    }else if (j==9&&[d3PaiLie3Detail.HE_ZHI intValue]!= 0){
                        [_rightORwrongArr addObject:d3PaiLie3Detail.HE_ZHI];
                    }else if (j==10&&[d3PaiLie3Detail.BAO_XING intValue]!= 0){
                        [_rightORwrongArr addObject:d3PaiLie3Detail.BAO_XING];
                    }
                }else{
                    xImage=[UIImage imageNamed:@"错号"];
                    _rightOrWrong = 2;
                }
            }
            if (_rightOrWrong == 1) {
                UIImageView * xImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.5*(rowWith-xImage.size.width)+columnWithAndLine+(j-1)*(rowWith+0.5),rowHeightOfFirstRow+rowHeightAndLine*(Number-1)+0.5*(rowHeight-xImage.size.height)+5, xImage.size.width-10, xImage.size.height-10)];
                xImageView.image=xImage;
                xImageView.tag = j-1;
                [footView addSubview:xImageView];
                
                UILabel * numLabel = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(xImageView), xImageView.frame.origin.y+3, 10, 15)];
                numLabel.backgroundColor = [UIColor clearColor];
                numLabel.textColor = [UIColor redColor];
                numLabel.font = [UIFont systemFontOfSize:12.0];
                [footView addSubview:numLabel];
                if (_rightORwrongArr.count != 0) {
                    numLabel.text = [_rightORwrongArr objectAtIndex:0];
                }
            }if (_rightOrWrong == 2) {
                UIImageView * xImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.5*(rowWith-xImage.size.width)+columnWithAndLine+(j-1)*(rowWith+0.5),rowHeightOfFirstRow+rowHeightAndLine*(Number-1)+0.5*(rowHeight-xImage.size.height), xImage.size.width, xImage.size.height)];
                xImageView.image=xImage;
                [footView addSubview:xImageView];
            }
        }
    }
    //下面的那条线
    UIView * rowLine=[[UIView alloc]initWithFrame:CGRectMake(0,rowHeightOfFirstRow+rowHeight+rowHeightAndLine*(Number-1), 305.5, 0.5)];
    [footView addSubview:rowLine];
    rowLine.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
}

- (void)addDealPurchaseTicket:(NSString *)str tag:(NSInteger)tag{
//#ifdef CRAZYSPORTS
//    int jinbibeishu = 10;//金币和钱比例
//    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"]) {
//        jinbibeishu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"] intValue];
//    }
//    _cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付"
//                                             message:[NSString stringWithFormat:@"您将支付(%.0f金币)购买此方案内容",[str floatValue] * jinbibeishu]
//                                            delegate:self
//                                   cancelButtonTitle:@"取消"
//                                   otherButtonTitles:@"确定", nil];
//#else
//    _cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付"
//                                             message:[NSString stringWithFormat:@"您将支付（%.2f元）购买此方案内容",[str floatValue]]
//                                            delegate:self
//                                   cancelButtonTitle:@"取消"
//                                   otherButtonTitles:@"确定", nil];
//#endif
    
    _cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付"
                                             message:[NSString stringWithFormat:@"您将支付(%.2f元)购买此方案内容",[str floatValue]]
                                            delegate:self
                                   cancelButtonTitle:@"取消"
                                   otherButtonTitles:@"确定", nil];
    
    _cpAlert.alertTpye=purchasePaln;
    _cpAlert.tag=tag;
    [_cpAlert show];
}

#pragma marked -----------选择已购买过的套餐------------------

- (void)selPlanBlock:(selPlanBlock)block{
    block();
    //NSLog(@"套餐code值为:%@",self.selTag);
}

#pragma marked -----------去购买套餐------------------

- (void)selPlanPurchaseBlock:(selPlanBlock)block{
    block();
    //NSLog(@"套餐编码code值为:%@",self.selPurchaseTag);
    ShenDanDetailViewController *sdDetailVc=[[ShenDanDetailViewController alloc] init];
    sdDetailVc.code=self.selPurchaseTag;
    [self.navigationController pushViewController:sdDetailVc animated:YES];
}

#pragma mark  -----------PurchaseAlertViewDelegate--------------

- (void)purchaseAlertView:(PurchaseAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        if(self.selTag){
            [self callDoOptionAgintMethod];
        }
    }
    return;
}

- (void)purchaseAlertView:(PurchaseAlertView *)alertView clickPuchsPlanDealTap:(UITapGestureRecognizer *)sender{
    CommonProblemViewController * vc = [[CommonProblemViewController alloc] init];
    vc.sourceFrom=@"purchasePlanDeal";
    [self.navigationController pushViewController:vc animated:YES];
    [alertView removeFromSuperview];
}

#pragma mark 竞彩查看方案详情代理方法
#pragma mark -----------SMGDetailCellPlanDetailDelegate----------
-(void)SMGDetailCellPlanDetail:(UIButton *)btn SMGDetailCell:(SMGDetailCell *)cell
{
    Info *info = [Info getInstance];
    if (![info.userId intValue]
#if defined YUCEDI || defined DONGGEQIU
        &&![[caiboAppDelegate getAppDelegate] isShenhe]
#endif
        ){
        [self toLogin];
        return;
    }
    
    _nPlanBtn = [_npList objectAtIndex:(btn.tag-100)];
    _payJiage=[_nPlanBtn.discountPrice floatValue];
    [MobClick event:@"Zj_fangan_20161014_jingcai_fangan" label:[NSString stringWithFormat:@"%@VS%@",cell.sidesOne.text,cell.sidesTwo.text]];
    if (_payJiage==0.00||[_nPlanBtn.paidStatus isEqualToString:@"1"]||[_exBaseInfo.expertsName isEqualToString:[[Info getInstance] userName]]
#if defined YUCEDI || defined DONGGEQIU
         ||[[caiboAppDelegate getAppDelegate] isShenhe]
#endif
        ) {
        ProjectDetailViewController *proVC=[[ProjectDetailViewController alloc] init];
        proVC.erAgintOrderId=_nPlanBtn.erAgintOrderId;
        if (_jcyplryType) {
            proVC.pdLotryType=_jcyplryType;
        }
        else {
            proVC.pdLotryType =_nPlanBtn.lotteryClassCode;
        }
        
        proVC.isSdOrNo=self.isSdOrNo;
        [self.navigationController pushViewController:proVC animated:YES];
    }else{
        if (self.isSdOrNo) {
            NSString *titlePurchaseAlert=@"您还未购买套餐计划";
            if ([self.beenBuy isEqualToString:@"1"]) {
                titlePurchaseAlert=@"请选择您所使用的套餐";
            }
            PurchaseAlertView *purchaseAlertView=[[PurchaseAlertView alloc] initWithTitle:titlePurchaseAlert delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            purchaseAlertView.tag=101;
            purchaseAlertView.smgVc=self;
            [purchaseAlertView show:_purchaseAlertArr];
            return;
        }
        NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
        [bodyDic setObject:@"expertService" forKey:@"serviceName"];
        [bodyDic setObject:@"getPlanInfo" forKey:@"methodName"];
        [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"erAgintOrderId":_nPlanBtn.erAgintOrderId} forKey:@"parameters"];
        [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
            NSLog(@"responseJSON=%@",responseJSON);
            NSString *paidState = responseJSON[@"result"][@"planInfo"][@"paidStatus"];
            if (![paidState isEqualToString:@"1"]) {
                if([_nPlanBtn.lotteryClassCode isEqualToString:@"204"]){//篮球
                    [self getChangeSPRequest];
                }else{
                    [self addDealPurchaseTicket:_nPlanBtn.discountPrice tag:601];
                }
            }else if([paidState isEqualToString:@"1"]){
                ProjectDetailViewController *proVC=[[ProjectDetailViewController alloc] init];
                proVC.erAgintOrderId=_nPlanBtn.erAgintOrderId;
                proVC.pdLotryType=_jcyplryType;
                proVC.isSdOrNo=self.isSdOrNo;
                [self.navigationController pushViewController:proVC animated:YES];
            }
        } failure:^(NSError * error) {
            
        }];
    }
}
#pragma mark 查看是否变盘接口
-(void)getChangeSPRequest{
    
    NSString *message = [NSString stringWithFormat:@"您购买的推荐与当前盘口不符，是否确认支付(%.2f元)购买此方案内容",[_nPlanBtn.discountPrice floatValue]];
//#ifdef CRAZYSPORTS
//    message = [NSString stringWithFormat:@"您购买的推荐与当前盘口不符，是否确认支付(%.0f金币)购买此方案内容",[_nPlanBtn.goldDiscountPrice floatValue]];
//#endif
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:@{@"erAgintOrderId":_nPlanBtn.erAgintOrderId}];
    NSMutableDictionary *bodDic4=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"checkPlanSpIsChange",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic4 success:^(id JSON) {
        
        if([[JSON valueForKey:@"resultCode"] isEqualToString:@"0000"]){
            NSDictionary *dic=JSON[@"result"];
            NSString *changeStatus = [dic valueForKey:@"changeStatus"];
            if([changeStatus isEqualToString:@"1"]){//1变盘
                _cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付提示"
                                                         message:message
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确定", nil];
                
                
                _cpAlert.alertTpye=purchasePaln;
                _cpAlert.tag=601;
                [_cpAlert show];
            }else{
                [self addDealPurchaseTicket:_nPlanBtn.discountPrice tag:601];
            }
            
        }else{
            
        }
        
    } failure:^(NSError * error) {
        
    }];
}
#pragma mark 数字彩查看方案详情代理方法
#pragma mark -----------digitalDetailCellDelegate-------------
-(void)digitalDetailCellPlanDetail:(UIButton *)btn
{
    Info *info = [Info getInstance];
    if (![info.userId intValue]) {
        [self toLogin];
        return;
    }
    
    _npSzcBtn=[_npList objectAtIndex:btn.tag-200];
    _payJiage=[_npSzcBtn.discountPrice floatValue];
    
    NSDictionary *dic = [DEFAULTS objectForKey:@"resultDic"];
    if (dic.allKeys == nil) {
        [self addDealPurchaseTicket:_npSzcBtn.discountPrice tag:604];
    }else{
        if (_payJiage==0.00||[_npSzcBtn.paidStatus isEqualToString:@"1"]||[_exBaseInfo.expertsName isEqualToString:[[DEFAULTS objectForKey:@"resultDic"] objectForKey:@"expertsName"]]) {
            BallDetailViewController *ballVC=[[BallDetailViewController alloc] init];
            ballVC.planId=_npSzcBtn.erAgintOrderId;
            ballVC.caiZhongType=_npSzcBtn.lotteryClassCode;
            ballVC.qiHao=_npSzcBtn.erIssue;
            [self.navigationController pushViewController:ballVC animated:YES];
        }else{
            NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
            [bodyDic setObject:@"expertService" forKey:@"serviceName"];
            [bodyDic setObject:@"getPlanInfo" forKey:@"methodName"];
            [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"erAgintOrderId":_npSzcBtn.erAgintOrderId} forKey:@"parameters"];
            [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
                NSLog(@"responseJSON=%@",responseJSON);
                NSString *paidState = responseJSON[@"result"][@"planInfo"][@"paidStatus"];
                if (![paidState isEqualToString:@"1"]) {
                    [self addDealPurchaseTicket:_npSzcBtn.discountPrice tag:604];
                }else if([paidState isEqualToString:@"1"]){
                    BallDetailViewController *ballVC=[[BallDetailViewController alloc] init];
                    ballVC.planId=_npSzcBtn.erAgintOrderId;
                    ballVC.caiZhongType=_npSzcBtn.lotteryClassCode;
                    ballVC.qiHao=_npSzcBtn.erIssue;
                    [self.navigationController pushViewController:ballVC animated:YES];
                }
            } failure:^(NSError * error) {
                
            }];
        }
    }
}

#pragma mark ----------------------UIAlertViewDelegate------------------------

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==602){
        if (buttonIndex==1) {
            Expert365Bridge * bridge = [[Expert365Bridge alloc] init];
            [bridge toRechargeFromController:self];
        }
    }else if (alertView.tag==603) {
        if(_segmentOnClickIndexFlags){
            ProjectDetailViewController *proVC=[[ProjectDetailViewController alloc] init];
            proVC.erAgintOrderId=_nPlanBtn.erAgintOrderId;
            proVC.pdLotryType=_jcyplryType;
            proVC.isSdOrNo=self.isSdOrNo;
            _nPlanBtn.paidStatus=@"1";
            [self.navigationController pushViewController:proVC animated:YES];
        }else{
            BallDetailViewController *ballVC=[[BallDetailViewController alloc] init];
            ballVC.planId=_npSzcBtn.erAgintOrderId;
            ballVC.caiZhongType=_npSzcBtn.lotteryClassCode;
            ballVC.qiHao=_npSzcBtn.erIssue;
            _npSzcBtn.paidStatus=@"1";
            [self.navigationController pushViewController:ballVC animated:YES];
            
        }
    }
}

#pragma mark ----------------------CP_UIAlertViewDelegate------------------------

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
                if (0 && _payJiage>balance) {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"您的余额不足请及时充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alert.tag=602;
                    [alert show];
                }else{
                    NSString *erID=@"";
                    if(_segmentOnClickIndexFlags){
                        erID=_nPlanBtn.erAgintOrderId;
                    }else{
                        erID=_npSzcBtn.erAgintOrderId;
                    }
                    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
                    [bodyDic setObject:@"commonExpertService" forKey:@"serviceName"];
                    [bodyDic setObject:@"buyPlan" forKey:@"methodName"];
#ifdef CRAZYSPORTS
                    [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"erAgintOrderId":erID,@"orderSource":@"10002000",@"payType":@"1",@"clientType":@"2",@"publishVersion":APPVersion,@"isNew":@"1"} forKey:@"parameters"];
#else
                    [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"erAgintOrderId":erID,@"orderSource":@"10002000",@"clientType":@"2",@"publishVersion":APPVersion,@"isNew":@"1"} forKey:@"parameters"];
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

- (void)CP_alertView:(CP_UIAlertView *)alertView clickPuchsPlanDealTap:(UITapGestureRecognizer *)sender{
    CommonProblemViewController * vc = [[CommonProblemViewController alloc]init];
    if(self.isSdOrNo){
        vc.sourceFrom=@"sd_purchasePlanDeal";
    }else
        vc.sourceFrom=@"purchasePlanDeal";
    [self.navigationController pushViewController:vc animated:YES];
    [alertView removeFromSuperview];
}

#pragma mark ---------------UITableViewDataSource----------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_segmentOnClickIndexFlags) {
        if([_jcyplryType isEqualToString:@"204"]){
            return 2;
        }
        if([_exBaseInfo.source isEqualToString:@"0"]){
            return 3;
        }else if ([_exBaseInfo.source isEqualToString:@"1"]){
            if([_jcyplryType isEqualToString:@"201"]){
                return 3;
            }
            if([_jcyplryType isEqualToString:@"204"]){
                return 2;
            }
            return 4;
        }
        return 0;
    }else
        return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_segmentOnClickIndexFlags) {
        if(![[self.showingArray objectAtIndex:section] boolValue]){
            if (section==0) {
                if(_npList&&[_npList count]!=0){
                    return [_npList count];
                }else
                    return 1;
            }
            else if (section==1){
                if([_jcyplryType isEqualToString:@"204"]){
                    return _historyPlanArr.count;
                }
                return 1;
            }
            if (section==2&&[_exBaseInfo.source isEqualToString:@"1"] && [_jcyplryType isEqualToString:@"-201"]){
                return 1;
            }else if (section==3||(section==2&&([_exBaseInfo.source isEqualToString:@"0"] || [_jcyplryType isEqualToString:@"201"]))){
                return [_historyPlanArr count];
            }
        }else if([[self.showingArray objectAtIndex:section] boolValue]){
            return 0;
        }
    } else {//数字彩测试
        if (section==0) {
            if(_npList&&[_npList count]!=0){
                return [_npList count];
            }else
                return 1;
        } else  {
            return 0;
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *npcell=@"npcell";
        UITableViewCell *tableCell=(UITableViewCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:npcell];
        if (tableCell==nil) {
            tableCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:npcell];
        }
        UIImage *img=[UIImage imageNamed:@"暂无最新推荐"];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake((MyWidth-img.size.width*120/img.size.height)/2, 0, img.size.width*120/img.size.height, 120)];
        imgView.image=img;
        tableCell.selectionStyle=UITableViewCellSelectionStyleNone;
        [tableCell addSubview:imgView];
        if (_segmentOnClickIndexFlags) {
            if(_npList&&[_npList count]!=0){
                NewPlanList *newPlan = [_npList objectAtIndex:indexPath.row];
                if (newPlan.matchs&&[newPlan.matchs count]!=0) {
//                    SMGDetailCell * cell=[SMGDetailCell SMGDetailCellWithTableView:tableView index:indexPath];
//                    NSDictionary *dic=dic=[newPlan.matchs objectAtIndex:0];
//                    [cell setCellMatchTime:[dic objectForKey:@"matchesId"] homeTeam:[dic objectForKey:@"homeName"] visiTeam:[dic objectForKey:@"awayName"] starTime:[dic objectForKey:@"matchTime"] price:newPlan.discountPrice matchType:[dic objectForKey:@"leagueName"] exsource:newPlan.free_status titName:newPlan.recommendTitle isSd:self.isSdOrNo];
//                    cell.backgroundColor=[UIColor whiteColor];
//                    cell.planDetailBtn.tag=indexPath.row+100;
//                    cell.delegateSMG=self;
//                    return cell;
                    static NSString * newCell = @"newCell";
                    ExpertDetailListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:newCell];
                    if (!cell) {
                        cell = [[ExpertDetailListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newCell];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    }
                    
                    __block SMGDetailViewController * newSelf = self;
                    __block ExpertDetailListTableViewCell *weakcell = cell;
                    cell.lookBtn.tag = indexPath.row + 100;
                    cell.lookButtonAction = ^(NSString *message) {
                        teamName = message;
                        
                        [newSelf SMGDetailCellPlanDetail:weakcell.lookBtn SMGDetailCell:nil];
                    };
                    [cell loadAppointInfo:newPlan];
                    return cell;
                }else
                    return tableCell;
            }else
                return tableCell;
        } else {
            DigitalDetailCell * cell=[DigitalDetailCell digitalDetailCellWithTableView:tableView index:indexPath];
            cell.backgroundColor=[UIColor whiteColor];
            if (_npList&&[_npList count]!=0) {
                NewPlanListShuZiCai *newPlist=[_npList objectAtIndex:indexPath.row];
                NSString *type =[NSString lotteryTpye:newPlist.lotteryClassCode];
                [cell setCellLotteryType:type erIsu:newPlist.erIssue pricePlan:newPlist.discountPrice source:newPlist.free_status];
                cell.planDetailBtn.tag=indexPath.row+200;
                cell.delegate=self;
                return cell;
            }else
                return tableCell;
        }
    }
    if (_segmentOnClickIndexFlags) {
        if([_jcyplryType isEqualToString:@"204"]){
            
            static NSString * historyCell = @"historyCell";
            ExpertDetailListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:historyCell];
            if (!cell) {
                cell = [[ExpertDetailListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:historyCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            HistoryPlanList *hisPlan=[_historyPlanArr objectAtIndex:indexPath.row];
            [cell loadAppointHistoryInfo:hisPlan];
            return cell;
        }
        if(indexPath.section==1&&[_exBaseInfo.source isEqualToString:@"1"] && [_jcyplryType isEqualToString:@"-201"]){
            PerHonorCell * cell=[PerHonorCell perhonorCellWithTableView:tableView indexPath:indexPath];
            cell.backgroundColor=[UIColor whiteColor];
            [cell hitRateWeek:_exBaseInfo.hitRateWeekRank hitRateMouth:_exBaseInfo.hitRateMonthRank returnRankWeek:_exBaseInfo.rewardRateWeekRank returnRankMouth:_exBaseInfo.rewardRateMonthRank popularRankWeek:_exBaseInfo.heatWeekRank popularRankMouth:_exBaseInfo.heatMonthRank];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if ((indexPath.section==1&&([_exBaseInfo.source isEqualToString:@"0"] || [_jcyplryType isEqualToString:@"201"]))||(indexPath.section==2&&[_exBaseInfo.source isEqualToString:@"1"] && [_jcyplryType isEqualToString:@"-201"])){
            WinRecCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WinRecCell class])];
            if (cell==nil) {
                cell=[[WinRecCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([WinRecCell class])];
            }
            cell.leagueMatchArr=_exBaseInfo.leagueMatch;
            [cell configUI:indexPath];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else if((indexPath.section==2&&([_exBaseInfo.source isEqualToString:@"0"] || [_jcyplryType isEqualToString:@"201"]))||(indexPath.section==3&&[_exBaseInfo.source isEqualToString:@"1"])){
//            static NSString *identifier = @"cell";
//            PlanSMGTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (!cell) {
//                cell = [[PlanSMGTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
//                UIView * Line=[[UIView alloc]initWithFrame:CGRectMake(0,99.5, MyWidth, 0.5)];
//                [cell.contentView addSubview:Line];
//                Line.backgroundColor=[UIColor blackColor];
//                Line.alpha=0.1;
//            }
//            if (_historyPlanArr&&[_historyPlanArr count]!=0) {
//                HistoryPlanList *hisPlan=[_historyPlanArr objectAtIndex:indexPath.row];
//                NSDictionary *dic=[hisPlan.matchs objectAtIndex:0];
//                [cell dataWeek:[dic objectForKey:@"matchesId"] contestType:[dic objectForKey:@"leagueName"] contestTime:[NSString stringWithFormat:@"比赛时间 %@",[dic objectForKey:@"matchTime"]] contestName:[NSString stringWithFormat:@"%@   %@  %@",[dic objectForKey:@"homeName"],[dic objectForKey:@"score"],[dic objectForKey:@"awayName"]] statusImg:hisPlan.isHit];
//            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.backgroundColor=[UIColor whiteColor];
//            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
//            cell.selectedBackgroundView.backgroundColor =[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
//            return cell;
            static NSString * historyCell = @"historyCell";
            ExpertDetailListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:historyCell];
            if (!cell) {
                cell = [[ExpertDetailListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:historyCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            HistoryPlanList *hisPlan=[_historyPlanArr objectAtIndex:indexPath.row];
            [cell loadAppointHistoryInfo:hisPlan];
            return cell;
        }
    }
    return nil;
}

#pragma mark -----------UITableViewDelegate--------------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (_segmentOnClickIndexFlags) {
            if(_npList&&[_npList count]!=0){
                NewPlanList *newPlan = [_npList objectAtIndex:indexPath.row];
                if (newPlan.matchs&&[newPlan.matchs count]!=0) {
//                    return 184.82;
                    if([_jcyplryType isEqualToString:@"201"]){
                        return 175;
                    }
                    return 125;
                }
                else
                    return 120.5;
            }
            else
                return 120.5;
        }
        else {
            //数字彩测试
            if (_npList&&[_npList count]!=0) {
                return 97.900;
            }
            else
                return 120.5;
        }
    }
    else if (indexPath.section==1&&_segmentOnClickIndexFlags) {
        if([_jcyplryType isEqualToString:@"204"]){
            return 60;
        }
        if ([_exBaseInfo.source isEqualToString:@"1"] && [_jcyplryType isEqualToString:@"-201"]) {
            return 120;
        }
        else if([_exBaseInfo.source isEqualToString:@"0"] || [_jcyplryType isEqualToString:@"201"]){
            return 185;
        }
        
    }
    else if(indexPath.section==2&&_segmentOnClickIndexFlags){
        if ([_exBaseInfo.source isEqualToString:@"1"] && [_jcyplryType isEqualToString:@"-201"]) {
            return 185;
        }
        else if([_exBaseInfo.source isEqualToString:@"0"] || [_jcyplryType isEqualToString:@"201"]){
//            return 99.9;
//            HistoryPlanList *hisPlan=[_historyPlanArr objectAtIndex:indexPath.row];
            if([_jcyplryType isEqualToString:@"201"]){
                return 105;
            }
            return 60;
        }
    }
    else if(indexPath.section==3){
        if (_segmentOnClickIndexFlags) {
//            return 99.9;
            return 60;
        }
        else{
            //数字彩测试
            return 0.1f;
        }
    }
    return 0.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        _headerViewOfSectionOne=[[DetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, MyWidth, 196)];
        _headerViewOfSectionOne.backgroundColor=[UIColor whiteColor];
        _headerViewOfSectionOne.delegate=self;
        _headerViewOfSectionOne.SMGOrDigitalFlags=_segmentOnClickIndexFlags;
        
        //NSString *fiveInfo=[_exBaseInfo.expertsLeastFiveHitInfo objectForKey:@"fiveInfo"];
        //if ([fiveInfo isEqualToString:@""]||fiveInfo==nil) {
        //    fiveInfo=@"";
        //}
        //NSString *odds=[NSString stringWithFormat:@"最近%@",fiveInfo];
        
        [_headerViewOfSectionOne DetailHeaderViewWithArray:nil andShowManayFalgs:_headerOfSectionOneShowBtnFlags andDigitalNavBtnTag:_digitalNavBtnTag headStr:_exBaseInfo.headPortrait superNick:_exBaseInfo.expertsNickName superIntro:_exBaseInfo.expertsIntroduction superLevelValue:_exBaseInfo.expertsLevelValue exsource:_exBaseInfo.source smgBtn:[[self.showingArray objectAtIndex:section]boolValue] totalRecNo:_exBaseInfo.totalRecommend weekWinRate:[NSString stringWithFormat:@"%@%%",_exBaseInfo.weekRate] monthWinRate:[NSString stringWithFormat:@"%@%%",_exBaseInfo.monthRate] isfocusOrNo:_exBaseInfo.focusStatus source:_jcyplryType isSdOrZj:self.isSdOrNo];
        _headerViewOfSectionOne.accessoryBtn.sectag=section;
        if (_segmentOnClickIndexFlags) {
            
        }else{
            for (UIView *view in [_headerViewOfSectionOne.viewOfDigital subviews] ) {
                if ([view isKindOfClass:[UIButton class]]) {
                    UIButton *btn=(UIButton *)view;
                    if (_lotryType==btn.tag+1) {
                        btn.selected=YES;
                    }else
                        btn.selected=NO;
                }
            }
        }
        return _headerViewOfSectionOne;
    } else {
        //推荐方案所在的黑色背景
//        UIView * headerViewOfSectionTwo=[[UIView alloc]initWithFrame:CGRectMake(0,0, MyWidth, 48)];
        UIView * headerViewOfSectionTwo=[[UIView alloc]initWithFrame:CGRectMake(0,0, MyWidth, 25)];
        headerViewOfSectionTwo.layer.borderColor=SEPARATORCOLOR.CGColor;
        headerViewOfSectionTwo.layer.borderWidth=0.5;
        headerViewOfSectionTwo.backgroundColor=[UIColor colorWithHexString:@"f2f2f2"];;
        
        //添加小竖条
        NSString *str=@"个人荣誉";
        if ([_exBaseInfo.source isEqualToString:@"0"] || [_jcyplryType isEqualToString:@"201"]) {
            str=@"推荐联赛胜场";
        }
        if (!_segmentOnClickIndexFlags) {
            str=@"历史战绩";
        }else{
            if (section==2) {
                if ([_exBaseInfo.source isEqualToString:@"0"] || [_jcyplryType isEqualToString:@"201"]) {
                    str=@"历史战绩";
                }else if ([_exBaseInfo.source isEqualToString:@"1"]) {
                    str=@"推荐联赛胜场";
                }
            }else if(section==3){
                str=@"历史战绩";
            }
        }
        UIImage * shuTiao=[UIImage imageNamed:str];
        UIImageView * shuTiaoImageView=[[UIImageView alloc] initWithImage:shuTiao];
        shuTiaoImageView.frame=CGRectMake(15, (25-shuTiao.size.height)*0.5, shuTiao.size.width, shuTiao.size.height);
        [headerViewOfSectionTwo addSubview:shuTiaoImageView];
        shuTiaoImageView.hidden = YES;
        //推荐方案汉字
        UILabel * recommandPlan=[[UILabel alloc]init];
        NSString *headText=@"个人荣誉";
        if ([_exBaseInfo.source isEqualToString:@"0"] || [_jcyplryType isEqualToString:@"201"]){
            headText=@"推荐联赛胜场";
        }
        if (!_segmentOnClickIndexFlags) {
            headText=@"历史战绩";
        }else{
            if(section==2){
                if([_exBaseInfo.source isEqualToString:@"0"] || [_jcyplryType isEqualToString:@"201"]){
                    headText=@"历史战绩";
                }else if ([_exBaseInfo.source isEqualToString:@"1"]){
                    headText=@"推荐联赛胜场";
                }
            }else if(section==3){
                headText=@"历史战绩";
            }
        }
        if([_jcyplryType isEqualToString:@"204"] && section == 1){
            headText=@"历史战绩";
        }
        recommandPlan.text=headText;
        recommandPlan.textColor=[UIColor blackColor];
        recommandPlan.alpha=0.87;
        recommandPlan.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        recommandPlan.font=FONTTHIRTY;
        CGSize headerViewSize=[PublicMethod setNameFontSize:recommandPlan.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        recommandPlan.frame=CGRectMake(15, 0.5*(25-headerViewSize.height), headerViewSize.width, headerViewSize.height);
        [headerViewOfSectionTwo addSubview:recommandPlan];
        
        
        UILabel * slabel = [[UILabel alloc]initWithFrame:CGRectMake(ORIGIN_X(recommandPlan)+10, recommandPlan.frame.origin.y+2, 200, 15)];
        slabel.font = [UIFont systemFontOfSize:12];
        slabel.backgroundColor = [UIColor clearColor];
        slabel.textAlignment = NSTextAlignmentLeft;
        slabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.54];
        NSString *str1 = [NSString stringWithFormat:@"%@",_leastTenInfo.tenHitRate];
        NSString *str2 = [NSString stringWithFormat:@"%.0f%%",[str1 floatValue]*100];
        slabel.text =[NSString stringWithFormat:@"近10场%@发%@中胜率%@",_leastTenInfo.tenTotalNum,_leastTenInfo.tenHitNum,str2];
        
        if (_segmentOnClickIndexFlags&&![_leastTenInfo.tenTotalNum isEqualToString:@""]&&![_leastTenInfo.tenHitNum isEqualToString:@""]&&_leastTenInfo.tenTotalNum!=nil&&_leastTenInfo.tenHitNum!=nil&&((section==3&&[_exBaseInfo.source isEqualToString:@"1"])||(([_exBaseInfo.source isEqualToString:@"0"] || [_jcyplryType isEqualToString:@"201"])&&section==2))) {
            [headerViewOfSectionTwo addSubview:slabel];
        }
        
        UIImage *img=[UIImage imageNamed:@"展开箭头"];
        if ([[self.showingArray objectAtIndex:section] boolValue]) {
            img=[UIImage imageNamed:@"收起箭头"];
        }
        
        SMGBtn *smgBtn=[SMGBtn buttonWithType:UIButtonTypeCustom];
        [smgBtn setFrame:CGRectMake(MyWidth-60, 0, 60, 25)];
        [smgBtn setBackgroundColor:[UIColor clearColor]];
        [smgBtn setImage:img forState:UIControlStateNormal];
        [smgBtn setImage:img forState:UIControlStateHighlighted];
//        smgBtn.imageEdgeInsets=UIEdgeInsetsMake(24-img.size.height/2, 30-img.size.width/2, 24-img.size.height/2, 30-img.size.width/2);
        smgBtn.sectag=section;
        [smgBtn addTarget:self action:@selector(showContent:) forControlEvents:UIControlEventTouchUpInside];
        if (_segmentOnClickIndexFlags) {
            [headerViewOfSectionTwo addSubview:smgBtn];
        }
        
        return headerViewOfSectionTwo;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        CGSize itdcSize=[PublicMethod setNameFontSize:[NSString stringWithFormat:@"简介：%@",_exBaseInfo.expertsIntroduction] andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MyWidth-30, MAXFLOAT)];
        float introductLabHig=0.0;
        if(itdcSize.height>30){
            introductLabHig=itdcSize.height-30;//2行大概是28.64,这个变量记录的是多于两行之外的简介文字的高度
        }
        float showManyImg=0.0;
        if (itdcSize.height>30) {
            CGSize headerViewSize=[PublicMethod setNameFontSize:@"展开" andFont:FONTTWENTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            //UIImage * showManayImage=[UIImage imageNamed:@"向下展开箭头"];
            showManyImg=headerViewSize.height;
        }
        _headerViewOfSectionOne=[[DetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, MyWidth, 196)];
        CGRect rect=_headerViewOfSectionOne.frame;
        
        float shuzicaiHeight=46.5;
        if (_headerOfSectionOneShowBtnFlags) {
            rect.size.height=188+introductLabHig+showManyImg+shuzicaiHeight;
        } else {
            if(itdcSize.height>30){
                rect.size.height=188+showManyImg+shuzicaiHeight;//90+itdcSize.height+10+showManyImg+10+48+shuzicaiHeight+30
            }else{
                rect.size.height=153+itdcSize.height+shuzicaiHeight;//90+itdcSize.height+15+48+shuzicaiHeight
            }
        }
        return rect.size.height-25;
    }else
        return 25;
}

#pragma mark ---------DetailHeaderViewDelegate----------
/**
 *  显示更多按钮单击响应的代理方法
 *
 *  @param introductionLabHeight 简介的高度-29（2行的高度约等于29（28.64））
 *  @param flags                 是否点击了头部中的显示更多按钮的标志位
 */
-(void)showManayBtnOnClick:(CGFloat)introductionLabHeight andFlags:(BOOL)flags
{
    self.introductionLabHeight=introductionLabHeight;
    _headerOfSectionOneShowBtnFlags=flags;
    [_SMGDetailTableView reloadData];
}
/**
 *  数字彩按钮点击相应的代理方法
 *
 *  @param btnTag 单击的按钮的tag-100值
 */
-(void)digitalNavBtnOnClickWithBtnTag:(NSInteger)btnTag
{
    if (_segmentOnClickIndexFlags) {
        NSString *orderId=@"";
        if (btnTag==0) {
            _jcyplryType=@"-201";
        }else if (btnTag==1){
//            _jcyplryType=@"202";
            _jcyplryType=@"204";
        }else if (btnTag==2){
            _jcyplryType=@"201";
        }
        if ([_sendLryType isEqualToString:_jcyplryType]) {
            orderId=_planIDStr;
        }
        self.historyPlanArr=nil;
        self.leastTenInfo=nil;
        self.npList=nil;
        Info *info = [Info getInstance];
        NSString *nameSty=@"";
        if ([info.userId intValue]) {
            nameSty=[[Info getInstance] userName];
        }
        NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
        [bodyDic setObject:@"expertService" forKey:@"serviceName"];
        [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
        [bodyDic setObject:@{@"expertsName":_exBaseInfo.expertsName,@"expertsClassCode":@"001",@"loginUserName":nameSty,@"erAgintOrderId":orderId,@"type":@"0",@"sdStatus":[NSString stringWithFormat:@"%i",self.isSdOrNo],@"lotteryClassCode":_jcyplryType} forKey:@"parameters"];
        [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
            if([responseJSON[@"resultCode"] isEqualToString:@"0000"]){
                NSDictionary *dic=responseJSON[@"result"][@"expertBaseInfo"];
                ExpertBaseInfo *exBase=[ExpertBaseInfo expertBaseInfoWithDic:dic];
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
                self.historyPlanArr=historyArr;
                self.leastTenInfo=leastTenInfo;
                self.npList=newPlanArr;
                self.exBaseInfo=exBase;
            }
            _digitalNavBtnTag=btnTag;
            [_SMGDetailTableView reloadData];
        } failure:^(NSError * error) {
            
        }];
    }else if(!_segmentOnClickIndexFlags){
        for (UIView *view in _footView.subviews) {
            [view removeFromSuperview];
        }
        for (UIView *view in _scrollowFootView.subviews) {
            [view removeFromSuperview];
        }
        if (_SMGDetailTableView) {
            _SMGDetailTableView=nil;
            [self creatSMGDetailTableView];
        }
        if (btnTag==0) {
            _lotryType=101;
            _npList=_SSQ_NP_ARR;
            _leastTenPlanArr=_SSQ_LTP_ARR;
        }else if (btnTag==1) {
            _lotryType=102;
            _npList=_DLT_NP_ARR;
            _leastTenPlanArr=_DLT_LTP_ARR;
        }else if (btnTag==2) {
            _lotryType=103;
            _npList=_FC3D_NP_ARR;
            _leastTenPlanArr=_FC3D_LTP_ARR;
        }else if (btnTag==3) {
            _lotryType=104;
            _npList=_PL3_NP_ARR;
            _leastTenPlanArr=_PL3_LTP_ARR;
        }
        if (btnTag==0||btnTag==1) {
            [self creatTableViewFootViewOfShuangAndLotto];
        } else if(btnTag==2||btnTag==3){
            [self creatTableViewFootViewOf3DAndPailiesan];
        }
        _digitalNavBtnTag=btnTag;
        [_SMGDetailTableView reloadData];
    }
}

- (void)showContent:(SMGBtn *)btn{
    NSInteger *index=btn.sectag;
    [UIView animateWithDuration:0.2 animations:^{
        if([[self.showingArray objectAtIndex:index] boolValue]){
            btn.transform = CGAffineTransformMakeRotation(0);
            [self.showingArray setObject:[NSNumber numberWithBool:NO] atIndexedSubscript:index];
        }else{
            btn.transform = CGAffineTransformMakeRotation(M_PI);
            [self.showingArray setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:index];
        }
    } completion:^(BOOL finished) {
        [_SMGDetailTableView reloadData];
    }];
}

-(void)focusOrNo:(UITapGestureRecognizer *)tap{
    
    if (![[Info getInstance] userName] || ![[Info getInstance] userName].length) {
        [self toLogin];
        return;
    }
    
    UIView *baseView=tap.view;
    UIImageView *imgV=[[baseView subviews] objectAtIndex:0];
    UILabel *foclab=[[baseView subviews] objectAtIndex:1];
    
    if (focusType==0) {
        focusType=1;
        NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"focusExpert",@"parameters":@{@"expertClassCode":_exBaseInfo.expertsCodeArray,@"userName":[[Info getInstance] userName],@"expertName":_exBaseInfo.expertsName}}];
        [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
            if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
                imgV.image=[UIImage imageNamed:@"CS_atlascomment_collect"];
                foclab.text=@"已关注";
            }
        } failure:^(NSError * error) {
            
        }];
    }else if(focusType==1){
        focusType=0;
        NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"cancelFocusExpert",@"parameters":@{@"expertClassCode":_exBaseInfo.expertsCodeArray,@"userName":[[Info getInstance] userName],@"expertName":_exBaseInfo.expertsName}}];
        [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
            if([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]){
                imgV.image=[UIImage imageNamed:@"CS_atlascomment_nocollect"];
                foclab.text=@"关注";
            }
        } failure:^(NSError * error) {
            
        }];
    }
}

-(void)toLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
}

#pragma marked ---------神单计划弹窗------------

- (void)callGodPlanMethod{
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    
    NSMutableDictionary * parameters =[NSMutableDictionary dictionaryWithDictionary:@{@"user_name":nameSty}];
    NSMutableDictionary * bodDic4 =[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"erGodPlanService",@"methodName":@"godPlan",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic4 success:^(id JSON) {
        NSDictionary *dataDic = JSON;
        if(!_purchaseAlertArr){
            _purchaseAlertArr=[NSMutableArray array];
        }
        if ([dataDic[@"resultCode"] isEqualToString:@"0000"]) {
            if (_purchaseAlertArr) {
                [_purchaseAlertArr removeAllObjects];
            }
            NSArray *dicArr = dataDic[@"result"][@"list"];
            for (NSDictionary *dic in dicArr) {
                PurchaseMdl *purchaseMdl=[PurchaseMdl purchaseMdlWithDic:dic];
                if ([purchaseMdl.is_buy isEqualToString:@"1"]) {
                    self.beenBuy=@"1";
                }
                [_purchaseAlertArr addObject:purchaseMdl];
            }
        }else{
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提醒" message:dataDic[@"resultDesc"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } failure:^(NSError * error) {
        
    }];
}

- (void)callDoOptionAgintMethod{
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    
    NSMutableDictionary * parameters =[NSMutableDictionary dictionaryWithDictionary:@{@"user_name":nameSty,@"code":self.selTag,@"er_agint_order_id":_nPlanBtn.erAgintOrderId}];
    NSMutableDictionary * bodDic4 =[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"erGodPlanService",@"methodName":@"doOptionAgint",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic4 success:^(id JSON) {
        if ([JSON[@"resultCode"] isEqualToString:@"0000"]) {
            ProjectDetailViewController *proVC=[[ProjectDetailViewController alloc] init];
            proVC.erAgintOrderId=_nPlanBtn.erAgintOrderId;
            proVC.pdLotryType=_jcyplryType;
            proVC.isSdOrNo=self.isSdOrNo;
            _nPlanBtn.paidStatus=@"1";
            [self.navigationController pushViewController:proVC animated:YES];
        }else{
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提醒" message:JSON[@"resultDesc"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } failure:^(NSError * error) {
        
    }];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    