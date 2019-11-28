//
//  MatchDetailVC.m
//  Experts
//
//  Created by hudong yule on 15/10/28.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "MatchDetailVC.h"
#import "ExpertApplyVC.h"
#import "SearchVC.h"
#import "CompeteViewController.h"
#import "ExpertSuperiorBaseCell.h"
#import "SMGDetailViewController.h"
#import "ExpertApplyVC.h"
#import "GC_NSData+AESCrypt.h"
#import "GC_NSString+AESCrypt.h"
#import "SuperiorMdl.h"
#import "Expert365Bridge.h"
#import "SharedMethod.h"
#import "LoginViewController.h"
#import "ExpertMainListTableViewCell.h"
#import "ExpertSubmitViewController.h"
#import "ProjectDetailViewController.h"
#import "MobClick.h"

@interface MatchDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _matchDetailTableView;
    UIView * _headerOfTableView;
    UIView * _headerBottomBg;
    
    NSMutableArray * _matchDetailTableViewArray;
    NSMutableDictionary * _matchDetailTableViewHeaderDic;
    
    UIImageView * _noNewRecommandImageView;
    
    BOOL _onceFlags;
    
    NSString *erAgintOrderId;
    CGFloat disPrice;
    
    NSString *erchuanyiNumber;
    NSString *jingcaiNumber;
    
//    BOOL isStar;
    BOOL mayJingcai;//是否可以发竞彩
    BOOL mayErchuanyi;//是否可以发二串一
    BOOL mayLancai;//是否可以发篮球
}

@property(nonatomic,retain)Expert365Bridge * bridge;

@end

@implementation MatchDetailVC

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
-(void)requestPulishNo
{
    Info *info = [Info getInstance];
    if (![info.userId intValue]) {
//        [self toLogin];
        return;
    }
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:@{@"expertsName":[[Info getInstance] userName],@"expertsClassCode":@"001"}];
    NSMutableDictionary *bodDic4=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"checkPublishInfo",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic4 success:^(id JSON) {
        NSDictionary *dic=JSON[@"result"];
        NSString *jingcaiNum = [dic valueForKey:@"today_PublishNum_JcSingle"];
        NSString *erchuanyiNum = [dic valueForKey:@"today_PublishNum_JcCombine"];
        
        if([erchuanyiNum integerValue] < [erchuanyiNumber integerValue]){
            mayErchuanyi = YES;
        }else{
            mayErchuanyi = NO;
        }
        if([jingcaiNum integerValue] < [jingcaiNumber integerValue]){
            mayJingcai = YES;
        }else{
            mayJingcai = NO;
        }
        
        
    } failure:^(NSError * error) {
        
    }];
}
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self getStarInfo];
    
    _onceFlags=YES;
    _currPage=1;
    
    erAgintOrderId = @"";
    disPrice = 0;
    
    _bridge = [[Expert365Bridge alloc] init];
//    if (!self.isSdOrNo) {
//        UIImage *searchImage=[UIImage imageNamed:@"椭圆"];//添加搜索按钮
//        [self rightImgAndAction:searchImage target:self action:@selector(searchBtn:)];
//        [self.rightBtn setImageEdgeInsets:UIEdgeInsetsMake(HEIGHTBELOESYSSEVER+12, 25, 32-searchImage.size.height, 35-searchImage.size.width)];
//    }
    
    [self creatNavView];
    if (_matchModel) {
        _cId=_matchModel.ccId;
    }
    if (_cId) {
        self.title_nav=[NSString stringWithFormat:@"赛事方案-%@",_cId];
    }
    else {
        self.title_nav=@"赛事方案";
    }
    
    
    [self creatMatDetilTabView];
    
    [self setupRefresh];
    
    [self noNewRecommandDataUI];
    
    [self requestData:_currPage];
}

-(void)viewWillAppear:(BOOL)animated{
    //判断身份
    if ([DEFAULTS objectForKey:@"resultDic"] && [[DEFAULTS objectForKey:@"resultDic"] isKindOfClass:[NSDictionary class]] && [[DEFAULTS objectForKey:@"resultDic"] allKeys]!= nil)  {
        NSDictionary  *baseDic =   [DEFAULTS objectForKey:@"resultDic"];
        self.personStatusStr = baseDic[@"expertsCodeArray"];//leng＝7、双系专家 leng＝0、个人 001、竞彩专家 002、数字彩专家
        self.source  = baseDic[@"source"];
    }
    if([self.personStatusStr isEqualToString:@"001"]||[self.personStatusStr isEqualToString:@"002"]){
        Info *info = [Info getInstance];
        if ([info.userId intValue]){
            [self getSubmitNumber];
        }
    }

#if defined CRAZYSPORTS
    [self changeCSTitileColor];
#endif
}

/**
 *  搜索响应函数
 */
-(void)searchBtn:(UIButton *)btn
{
    SearchVC *vc=[[SearchVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.isSdOrNo = self.isSdOrNo;
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  测试接口，完成
 */
-(void)requestData:(NSInteger)currentPage
{
    //调用接口时，汉字字符串放入BodyDic要进行encodeToPercentEscapeString，例如[NSString encodeToPercentEscapeString:@"你好"]
    NSString *sourPara=@"";
    if ([_matchSource isEqualToString:@"-201"]) {
        sourPara=@"1";
    }else if([_matchSource isEqualToString:@"204"]){
        sourPara=@"4";
    }
//    else if([_matchSource isEqualToString:@"202"]){
//        sourPara=@"2";
//    }
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"sMGExpertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getAginOrderListByPlayId" forKey:@"methodName"];
    
    NSMutableDictionary * parametersDic=[NSMutableDictionary dictionary];
    [parametersDic setObject:_playId forKey:@"playId"];
    [parametersDic setObject:nameSty forKey:@"userName"];
    [parametersDic setObject:sourPara forKey:@"source"];
    [parametersDic setObject:@"1" forKey:@"levelType"];
    [parametersDic setObject:@"20" forKey:@"pageSize"];
    [parametersDic setObject:[NSString stringWithFormat:@"%i",self.isSdOrNo] forKey:@"sdFlag"];
    [parametersDic setObject:[NSString stringWithFormat:@"%ld",(long)currentPage] forKey:@"currPage"];
    [parametersDic setObject:[[Info getInstance] cbSID] forKey:@"sid"];
    [bodyDic setObject:parametersDic forKey:@"parameters"];
    
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSDictionary * bodyData=[responseJSON valueForKey:@"result"];
            NSDictionary *dic=[bodyData objectForKey:@"matchInfo"];
            _matchdetailMdl=[MatchDetailVCMdl MatchDetialMdlWithDic:dic];
            
            NSArray * dataArr = [bodyData objectForKey:@"planList"];
            if ([dataArr count]!=0) {
                _noNewRecommandImageView.hidden=YES;
                _matchDetailTableView.scrollEnabled=YES;
                NSMutableArray * mutalArr=[NSMutableArray array];
                for (NSDictionary * dic in dataArr) {
                    [mutalArr addObject:[SuperiorMdl superMdlWithDic:dic]];
                }
                if (currentPage>1) {
                    [_matchDetailTableViewArray addObjectsFromArray:mutalArr];
                    _currPage++;
                } else if(currentPage==1) {
                    [_matchDetailTableViewArray removeAllObjects];
                    _matchDetailTableViewArray=nil;
                    _matchDetailTableViewArray=mutalArr;
                }
                [_matchDetailTableView reloadData];
            } else {
                if (_onceFlags) {//暂无最新推荐
                    _noNewRecommandImageView.hidden=NO;
                    _matchDetailTableView.scrollEnabled=NO;
                } else {
                    UIAlertView *accountart = [[UIAlertView alloc]initWithTitle:nil message:@"没有更多啦！" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                    [accountart show];
                    [self performSelector:@selector(dimissAlert:) withObject:accountart afterDelay:1.0f];
                }
            }
            if (_onceFlags) {
                _matchDetailTableViewHeaderDic=[bodyData objectForKey:@"matchInfo"];
                _onceFlags=NO;
            }
        } else {
            NSLog(@"请求失败");
            UIAlertView *accountart = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [accountart show];
            [self performSelector:@selector(dimissAlert:) withObject:accountart afterDelay:1.0f];
        }
        
        [_matchDetailTableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_matchDetailTableView.header endRefreshing];
            [_matchDetailTableView.footer endRefreshing];
        });
    } failure:^(NSError * error) {
        NSLog(@"%@",error);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_matchDetailTableView.header endRefreshing];
            [_matchDetailTableView.footer endRefreshing];
        });
    }];
}
/**
 *  UIAlertView自动消失处理代码
 */
-(void)dimissAlert:(UIAlertView *)Alert
{
    [Alert dismissWithClickedButtonIndex:[Alert cancelButtonIndex] animated:YES];
}
/**
 *  暂无最新推荐UI
 */
-(void)noNewRecommandDataUI
{
    UIImage * image=[UIImage imageNamed:@"暂无最新推荐"];
    _noNewRecommandImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.5*(MyWidth-image.size.width),MyHight-264, image.size.width,image.size.height)];//193.72
    [self.view addSubview:_noNewRecommandImageView];
    _noNewRecommandImageView.image=image;
    _noNewRecommandImageView.hidden=YES;
}
/**
 *  创建本页面tableView
 */
-(void)creatMatDetilTabView
{
    _matchDetailTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,HEIGHTBELOESYSSEVER+44, MyWidth, MyHight-64) style:UITableViewStyleGrouped];
    [self.view addSubview:_matchDetailTableView];
    _matchDetailTableView.showsHorizontalScrollIndicator=NO;
    _matchDetailTableView.showsVerticalScrollIndicator=NO;
    _matchDetailTableView.delegate=self;
    _matchDetailTableView.dataSource=self;
    _matchDetailTableView.separatorStyle=UITableViewCellSelectionStyleNone;
}
#pragma mark 刷新
- (void)setupRefresh
{
    // 下拉刷新
    _matchDetailTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_matchDetailTableView.header];

    // 上拉加载
    _matchDetailTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_matchDetailTableView.footer];

}

#pragma mark 开始进入刷新状态
- (void)NearheaderRereshing
{
    _currPage=1;
    [self requestData:_currPage];
}

#pragma mark - 加载
- (void)NearfooterRereshing
{
    NSInteger cuPage=_currPage+1;
    [self requestData:cuPage];
}

#pragma mark -UITableViewDataSource数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _matchDetailTableViewArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString * cellID = @"ExpertMainListTableViewCell";
//    ExpertMainListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[ExpertMainListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    SuperiorMdl *superModel=[_matchDetailTableViewArray objectAtIndex:indexPath.row];
//    
//    [cell loadProgramListInfo:superModel];
//    __block MatchDetailVC * newSelf = self;
//    cell.buttonAction = ^(UIButton *button) {
//        [newSelf getIsBuyInfoWithOrderID:superModel];
//    };
//    
//    return cell;
#if defined CRAZYSPORTS
    static NSString * cellID = @"ExpertMainListTableViewCell";
    ExpertMainListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ExpertMainListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SuperiorMdl *superModel=[_matchDetailTableViewArray objectAtIndex:indexPath.row];
    
    [cell loadProgramListInfo:superModel];
    __block MatchDetailVC * newSelf = self;
    cell.buttonAction = ^(UIButton *button) {
        [newSelf getIsBuyInfoWithOrderID:superModel];
    };
    
    return cell;
#else
    ExpertSuperiorBaseCell * cell=[ExpertSuperiorBaseCell ExpertSuperiorBaseCellWithTableView:tableView cellForRowAtIndexPath:indexPath];

    SuperiorMdl *superModel=[_matchDetailTableViewArray objectAtIndex:indexPath.row];
    NSString *odds=[NSString stringWithFormat:@"%@中%@",[superModel.SiperiorExpertsLeastFiveHitInfo objectForKey:@"totalNum"],[superModel.SiperiorExpertsLeastFiveHitInfo objectForKey:@"hitNum"]];
    
    NSString *matchs=[NSString stringWithFormat:@"%@ VS %@",superModel.hostNameSimply,superModel.guestNameSimply];
    NSString *compTime=superModel.matchTime;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date=[dateFormatter dateFromString:compTime];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"HH:mm"];
    
    NSString *matchID=superModel.CCId;
    if ([_matchSource isEqualToString:@"202"]) {
        matchID=[matchID substringToIndex:2];
    }
    compTime=[NSString stringWithFormat:@"%@ %@",superModel.CCId,[dateFormatter2 stringFromDate:date]];
    
    if([_matchSource isEqualToString:@"204"]){//篮球
        NSString *str = @"让分胜负";
        if([superModel.playTypeCode isEqualToString:@"29"]){
            str = @"大小分";
        }
        matchs=[NSString stringWithFormat:@"%@(客)VS%@(主) | %@ %@",superModel.guestNameSimply,superModel.hostNameSimply,str,superModel.rqs];
    }
    
    [cell setCellSuperHead:superModel.headPortrait name:superModel.expertsNickName starNo:superModel.expertsLevelValue odds:odds matchSides:matchs time:compTime leagueType:superModel.leagueNameSimply exPrice:superModel.price exDiscount:superModel.discount exRank:superModel.source refundOrNo:superModel.free_status flag:YES lotryTp:_matchSource];
    if(self.isSdOrNo){
        cell.priceLab.hidden=YES;
        cell.rankImgView.hidden=YES;
        cell.rankLab.hidden=YES;
    }
    return  cell;
#endif
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headerOfTableView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MyWidth, 193.72)];
    _headerOfTableView.backgroundColor=[UIColor whiteColor];
    
    //横条上的队名(左侧)
    UIImage *leftLineBoldImage=[UIImage imageNamed:@"line_blue"];
    UILabel * leftTeamName=[[UILabel alloc]initWithFrame:CGRectMake(30, 32, 50, 30)];
    if([_matchDetailTableViewHeaderDic objectForKey:@"hostNameSimply"]){
        leftTeamName.text=[_matchDetailTableViewHeaderDic objectForKey:@"hostNameSimply"];
    }
    if([_matchSource isEqualToString:@"204"] && [_matchDetailTableViewHeaderDic objectForKey:@"guestNameSimply"]){
        leftTeamName.text=[NSString stringWithFormat:@"%@(客)",[_matchDetailTableViewHeaderDic objectForKey:@"guestNameSimply"]];
    }
    leftTeamName.font=FONTTHIRTY;
    leftTeamName.textColor=RGB(6.0, 96.0, 211.0);
    [_headerOfTableView addSubview:leftTeamName];
    CGSize headerUISize=[PublicMethod setNameFontSize:leftTeamName.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (headerUISize.width>=leftLineBoldImage.size.width) {
        leftTeamName.frame=CGRectMake(0, 32, leftLineBoldImage.size.width, headerUISize.height);
    }else{
        leftTeamName.frame=CGRectMake(0.5*(leftLineBoldImage.size.width-headerUISize.width), 32, headerUISize.width, headerUISize.height);
    }
    
    UILabel * leftRankingLabel=[[UILabel alloc]init];
    if (![[_matchDetailTableViewHeaderDic objectForKey:@"hostRankNumber"] isEqual:[NSDictionary class]]) {
        leftRankingLabel.text=@" ";
    }else{
        if ([_matchDetailTableViewHeaderDic objectForKey:@"hostRankNumber"]) {
            leftRankingLabel.text=[_matchDetailTableViewHeaderDic objectForKey:@"hostRankNumber"];
        }
    }
    
    leftRankingLabel.textColor=RGB(6., 96., 211.);
    leftRankingLabel.font=FONTTWENTY;
    headerUISize=[PublicMethod setNameFontSize:leftRankingLabel.text andFont:FONTTWENTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    leftRankingLabel.frame=CGRectMake(CGRectGetMaxX(leftTeamName.frame)+4, CGRectGetMaxY(leftTeamName.frame)-headerUISize.height, headerUISize.width, headerUISize.height);
    [_headerOfTableView addSubview:leftRankingLabel];
    
    //左侧横条
    UIView *leftLineBold=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(leftTeamName.frame)+5, leftLineBoldImage.size.width, leftLineBoldImage.size.height)];
    [leftLineBold setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"line_blue"]]];
    [_headerOfTableView addSubview:leftLineBold];
    
    //比赛类别,英超
    UILabel * matchType=[[UILabel alloc]initWithFrame:CGRectMake(0.5*(MyWidth-80), 30, 80, 30)];
    if ([_matchDetailTableViewHeaderDic objectForKey:@"leagueNameSimply"]) {
        matchType.text=[_matchDetailTableViewHeaderDic objectForKey:@"leagueNameSimply"];
    }
    
    matchType.font=FONTTHIRTY_SIX;
    matchType.textColor=RGB(56., 56., 56.);
    headerUISize=[PublicMethod setNameFontSize:matchType.text andFont:FONTTHIRTY_SIX andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (headerUISize.width>=80) {
        matchType.frame=CGRectMake(0.5*(MyWidth-80), CGRectGetMaxY(leftTeamName.frame)-headerUISize.height,80, headerUISize.height);
    }else{
        matchType.frame=CGRectMake(0.5*(MyWidth-headerUISize.width), CGRectGetMaxY(leftTeamName.frame)-headerUISize.height, headerUISize.width, headerUISize.height);
    }
    [_headerOfTableView addSubview:matchType];
    
    //横条上的队名(右)
    UIImage *rightLineBoldImage=[UIImage imageNamed:@"line_orange"];
    UILabel * rightTeamName=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftLineBold.frame)+115, 32, 80, 30)];
    if ([_matchDetailTableViewHeaderDic objectForKey:@"guestNameSimply"]) {
        rightTeamName.text=[_matchDetailTableViewHeaderDic objectForKey:@"guestNameSimply"];
    }
    if([_matchSource isEqualToString:@"204"] && [_matchDetailTableViewHeaderDic objectForKey:@"hostNameSimply"]){
        rightTeamName.text=[NSString stringWithFormat:@"%@(主)",[_matchDetailTableViewHeaderDic objectForKey:@"hostNameSimply"]];
    }
    rightTeamName.font=FONTTHIRTY;
    rightTeamName.textColor=RGB(249., 135., 14.);
    [_headerOfTableView addSubview:rightTeamName];
    headerUISize=[PublicMethod setNameFontSize:rightTeamName.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (headerUISize.width>=rightLineBoldImage.size.width) {
        rightTeamName.frame=CGRectMake(MyWidth-rightLineBoldImage.size.width, 32,rightLineBoldImage.size.width, headerUISize.height);
    }else{
        CGFloat rightTeamNameX=MyWidth-rightLineBoldImage.size.width+(rightLineBoldImage.size.width-headerUISize.width)*0.5;
        rightTeamName.frame=CGRectMake(rightTeamNameX, 32, headerUISize.width, headerUISize.height);
    }
    
    //右侧的小角标
    UILabel * rightRankingLabel=[[UILabel alloc]init];
    if (![[_matchDetailTableViewHeaderDic objectForKey:@"guestRankNumber"] isEqual:[NSDictionary class]]) {
        rightRankingLabel.text=@" ";
    }else{
        if ([_matchDetailTableViewHeaderDic objectForKey:@"guestRankNumber"]) {
            rightRankingLabel.text=[_matchDetailTableViewHeaderDic objectForKey:@"guestRankNumber"];
        }
    }
    rightRankingLabel.textColor=RGB(249.0, 135.0, 14.0);
    rightRankingLabel.font=FONTTWENTY;
    headerUISize=[PublicMethod setNameFontSize:rightRankingLabel.text andFont:FONTTWENTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    rightRankingLabel.frame=CGRectMake(rightTeamName.frame.origin.x-headerUISize.width-4, CGRectGetMaxY(rightTeamName.frame)-headerUISize.height, headerUISize.width, headerUISize.height);
    [_headerOfTableView addSubview:rightRankingLabel];
    
    //右侧横条
    UIView  * rightLineBold=[[UIView alloc]initWithFrame:CGRectMake(MyWidth-rightLineBoldImage.size.width, CGRectGetMaxY(rightTeamName.frame)+5, rightLineBoldImage.size.width, rightLineBoldImage.size.height)];
    [rightLineBold setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"line_orange"]]];
    [_headerOfTableView addSubview:rightLineBold];
    
    UILabel * timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(leftLineBold.frame)+9, MyWidth, 20)];
    //时间
    if ([_matchDetailTableViewHeaderDic objectForKey:@"matchTime"]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
        NSDate *date=[dateFormatter dateFromString:[_matchDetailTableViewHeaderDic objectForKey:@"matchTime"]];
        
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"MM月dd日 HH:mm"];
        NSString * compTime=[NSString stringWithFormat:@"%@",[dateFormatter2 stringFromDate:date]];
        timeLabel.text=[NSString stringWithFormat:@"%@开赛",compTime];
    }

    timeLabel.font=FONTTWENTY_FOUR;
    timeLabel.textColor=RGB(174., 167., 128.);
    headerUISize=[PublicMethod setNameFontSize:timeLabel.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    timeLabel.frame=CGRectMake(0, timeLabel.frame.origin.y, MyWidth, headerUISize.height);
    [_headerOfTableView addSubview:timeLabel];
    timeLabel.textAlignment=NSTextAlignmentCenter;
    
    //发布方案按钮
    UIButton * releasePlanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * releaseImage=[UIImage imageNamed:@"发布方案-按钮"];
    releasePlanBtn.frame=CGRectMake(0.5*(MyWidth-releaseImage.size.width), CGRectGetMaxY(timeLabel.frame)+15, releaseImage.size.width,releaseImage.size.height);
    [_headerOfTableView addSubview:releasePlanBtn];
    [releasePlanBtn setBackgroundImage:[UIImage imageNamed:@"发布方案-按钮"] forState:UIControlStateNormal];
    [releasePlanBtn setBackgroundImage:[UIImage imageNamed:@"发布方案-按钮"] forState:UIControlStateHighlighted];
    [releasePlanBtn setTitle:@"发布方案" forState:UIControlStateNormal];
    [releasePlanBtn setTitleColor:RGB(255., 69., 0.) forState:UIControlStateNormal];
    [releasePlanBtn setTitleColor:RGB(255., 69., 0.) forState:UIControlStateHighlighted];
    releasePlanBtn.titleLabel.font=FONTTHIRTY;
    [releasePlanBtn addTarget:self action:@selector(releaseBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
//    if(self.isSdOrNo){
        releasePlanBtn.hidden=YES;
//    }
    
    //推荐方案所在的黑色背景
    _headerBottomBg=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(releasePlanBtn.frame)+17.5, MyWidth, 48)];
    _headerBottomBg.backgroundColor=[UIColor blackColor];
    _headerBottomBg.alpha=0.05;
    [_headerOfTableView addSubview:_headerBottomBg];
    
    //阴影效果
    UIImageView * shaowImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,_headerBottomBg.frame.origin.y, MyWidth, 2)];
    [_headerOfTableView addSubview:shaowImageView];
    shaowImageView.image=[UIImage imageNamed:@"背景-1横条"];
    
    //添加小竖条
    UIImage * shuTiao=[UIImage imageNamed:@"推荐方案"];
    UIImageView * shuTiaoImageView=[[UIImageView alloc]initWithImage:shuTiao];
    shuTiaoImageView.frame=CGRectMake(18-shuTiao.size.width, (48-shuTiao.size.height)*0.5+_headerBottomBg.frame.origin.y, shuTiao.size.width, shuTiao.size.height);
    [_headerOfTableView addSubview:shuTiaoImageView];
    
    //推荐方案汉字
    UILabel * recommandPlan=[[UILabel alloc]init];
    recommandPlan.text=@"推荐方案";
    recommandPlan.textColor=[UIColor blackColor];
    recommandPlan.font=FONTTHIRTY;
    headerUISize=[PublicMethod setNameFontSize:recommandPlan.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    recommandPlan.frame=CGRectMake(28, 0.5*(48-headerUISize.height)+_headerBottomBg.frame.origin.y, headerUISize.width, headerUISize.height);
    [_headerOfTableView addSubview:recommandPlan];
    
    _headerOfTableView.frame=CGRectMake(0, 0, MyWidth, CGRectGetMaxY(_headerBottomBg.frame));
    NSLog(@"头部的高度%f",_headerOfTableView.frame.size.height);
    
    return _headerOfTableView;
}

/**
 *  发布方案接口
 */
-(void)releaseBtnOnClick
{
    Info *info = [Info getInstance];
    if (![info.userId intValue]) {
#ifdef isCaiPiaoForIPad
        [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
        [self toLogin];
        return;
#endif
    }
//    NSDictionary * expertResult = [DEFAULTS valueForKey:@"resultDic"];
    if([_bridge validateRealNameFormController:self]==NO){
        return;
    }
    if ([DEFAULTS objectForKey:@"resultDic"] && [[DEFAULTS objectForKey:@"resultDic"] isKindOfClass:[NSDictionary class]] && [[DEFAULTS objectForKey:@"resultDic"] allKeys]!= nil&&
        ![[DEFAULTS objectForKey:@"resultDic"] isEqualToDictionary:[NSDictionary dictionary]]) {
        NSDictionary *dic=[DEFAULTS objectForKey:@"resultDic"];
        NSString *smg=[dic objectForKey:@"smgAuditStatus"];
        NSString *dig=[dic objectForKey:@"digAuditStatus"];
        if([smg isEqualToString:@"2"]){
            NSDictionary * expertResult = [DEFAULTS valueForKey:@"resultDic"];
            
            if ([[expertResult valueForKey:@"smgAuditStatus"] isEqualToString:@"2"] && [[expertResult valueForKey:@"expertsCodeArray"] isEqualToString:@"001"]){
                if(((mayErchuanyi || mayJingcai) && ![_matchSource isEqualToString:@"204"]) || ([_matchSource isEqualToString:@"204"] && mayLancai)){
                    ExpertSubmitViewController *vc = [[ExpertSubmitViewController alloc]init];
                    vc.type = _matchSource;
                    if (mayErchuanyi && !mayJingcai && [_matchSource isEqualToString:@"-201"]) {
                        vc.type = @"201";
                    }
                    vc.matchdetailMdl = _matchdetailMdl;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [[caiboAppDelegate getAppDelegate] showMessage:@"您已超过发布次数限制"];
                    return;
                }
            }
//            if([self.source isEqualToString:@"1"]&&(([_matchSource isEqualToString:@"-201"]&&[self.jc_todayPubNum intValue]>2)||([_matchSource isEqualToString:@"202"]&&[self.yp_todayPubNum intValue]>2))){
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"每天只能发三场比赛" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//                [alert show];
//                [self performSelector:@selector(alertActionDissmiss:) withObject:alert afterDelay:1];
//                return;
//            }else{
//                
//                NSDictionary * expertResult = [DEFAULTS valueForKey:@"resultDic"];
//                
//                if ([[expertResult valueForKey:@"smgAuditStatus"] isEqualToString:@"2"] && [[expertResult valueForKey:@"expertsCodeArray"] isEqualToString:@"001"]){
//                    
//                    if(isStar || mayErchuanyi || mayJingcai){
//                        ExpertSubmitViewController *vc = [[ExpertSubmitViewController alloc]init];
//                        vc.matchdetailMdl = _matchdetailMdl;
//                        [self.navigationController pushViewController:vc animated:YES];
//                    }else{
//                        [[caiboAppDelegate getAppDelegate] showMessage:@"您已超过发布次数限制"];
//                        return;
//                    }
////                    ExpertSubmitViewController *vc = [[ExpertSubmitViewController alloc]init];
////                    vc.matchdetailMdl = _matchdetailMdl;
////                    [self.navigationController pushViewController:vc animated:YES];
//                }
//                
////                CompeteViewController *competeVC = [[CompeteViewController alloc]init];
////                competeVC.matchM=_matchdetailMdl;
////                competeVC.lotrySource=_matchSource;
////                competeVC.jc_TdPubNo=self.jc_todayPubNum;
////                competeVC.yp_TdPubNo=self.yp_todayPubNum;
////                competeVC.matchIdSelected=_matchdetailMdl.matchId;
////                competeVC.selectLeagueName=_matchdetailMdl.leagueNameSimply;
////                competeVC.homeName=_matchdetailMdl.hostNameSimply;
////                competeVC.guestName=_matchdetailMdl.guestNameSimply;
////                competeVC.playID=_matchdetailMdl.play_ID;
////                competeVC.matchStatus=_matchdetailMdl.match_STATUS;
////                competeVC.selectDate=_matchdetailMdl.match_DATA;
////                competeVC.selectTime=_matchdetailMdl.matchTime;
////                competeVC.eventId=_matchdetailMdl.CCId;
////                competeVC.rqOddStr=_matchdetailMdl.rang_QIU_SP;
////                competeVC.oddsStr=_matchdetailMdl.spf_SP;
////                competeVC.rqNo=_matchdetailMdl.rq;
////                competeVC.ypRq=_matchdetailMdl.rq;
////                competeVC.supportStr = [NSString stringWithFormat:@"%ld",(long)_matchdetailMdl.sheng_PING_FU];
////                competeVC.nameAndTimeStr=[NSString stringWithFormat:@"%@   %@VS%@",_matchdetailMdl.CCId,_matchdetailMdl.hostNameSimply,_matchdetailMdl.guestNameSimply];
////                competeVC.asianSp=_matchModel.asian_sp;
////                competeVC.hidesBottomBarWhenPushed=YES;
////                [self.navigationController pushViewController:competeVC animated:YES];
//            }
        }else if([dig isEqualToString:@"2"]){
            NSString *alertCont=@"";
            if([_matchSource isEqualToString:@"-201"]){
                alertCont=@"您是数字彩专家，无法发布竞足方案";
            }if([_matchSource isEqualToString:@"202"]){
                alertCont=@"您是数字彩专家，无法发布亚盘方案";
            }
            if([_matchSource isEqualToString:@"204"]){
                alertCont=@"您是数字彩专家，无法发布篮彩方案";
            }
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:alertCont delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(alertActionDissmiss:) withObject:alert afterDelay:1];
            return;
        }else{
#if !defined YUCEDI && !defined DONGGEQIU
            if(self.personStatusStr.length==0||self.personStatusStr==nil){
                if([_bridge validateRealNameFormController:self]==NO){
                    return;
                }
            }
#endif
            if(([smg isEqualToString:@""]||[smg isEqualToString:@"3"])&&([dig isEqualToString:@""]||[dig isEqualToString:@"3"])){//能发起审核
                ExpertApplyVC *expertApplyVc=[[ExpertApplyVC alloc] init];
                expertApplyVc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:expertApplyVc animated:YES];
            }else{//不能发起审核
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"已经发起过审核，不能重复操作" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                [alert show];
                [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
            }
        }
    }else{//普通用户需要申请专家
        ExpertApplyVC *expertApplyVc=[[ExpertApplyVC alloc] init];
        expertApplyVc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:expertApplyVc animated:YES];
    }
}

#pragma  mark -UITableViewDelegate代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
#if defined CRAZYSPORTS
    return 120;
#endif
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSLog(@"单击了某个方案响应函数");
    SuperiorMdl *superModel=[_matchDetailTableViewArray objectAtIndex:indexPath.row];
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
    [bodyDic setObject:@{@"expertsName":superModel.expertsName,@"expertsClassCode":@"001",@"loginUserName":nameSty,@"erAgintOrderId":superModel.erAgintOrderId,@"type":@"0",@"sdStatus":[NSString stringWithFormat:@"%i",self.isSdOrNo],@"sid":[[Info getInstance] cbSID],@"lotteryClassCode":_matchSource} forKey:@"parameters"];
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
        vc.planIDStr=superModel.erAgintOrderId;
        vc.jcyplryType=_matchSource;
        vc.isSdOrNo=self.isSdOrNo;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError * error) {
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 193.72;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}
//#pragma mark 判断双系或者竞彩高手是否发布了三场
//-(void)cheakTimeRequestData
//{
//    Info *info = [Info getInstance];
//    NSString *nameSty=@"";
//    if ([info.userId intValue]) {
//        nameSty=[[Info getInstance] userName];
//    }
//    NSString *expType=@"";
//    if ([DEFAULTS objectForKey:@"resultDic"] && [[DEFAULTS objectForKey:@"resultDic"] isKindOfClass:[NSDictionary class]] && [[DEFAULTS objectForKey:@"resultDic"] allKeys]!= nil&&
//        ![[DEFAULTS objectForKey:@"resultDic"] isEqualToDictionary:[NSDictionary dictionary]])  {
//        NSDictionary  *baseDic=[DEFAULTS objectForKey:@"resultDic"];
//        expType = baseDic[@"expertsCodeArray"];
//    }
//    NSMutableDictionary * parameters =[NSMutableDictionary dictionaryWithDictionary:@{@"expertsName":nameSty,@"expertsClassCode":expType}];
//    NSMutableDictionary * bodDic4 =[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"checkPublishInfo",@"parameters":parameters}];
//    [RequestEntity requestDatapartWithJsonBodyDic:bodDic4 success:^(id JSON) {
//        NSDictionary *dataDic = JSON;
//        if ([dataDic[@"resultCode"] isEqualToString:@"0000"]) {
//            NSDictionary *dic=dataDic[@"result"];
//            self.jc_todayPubNum=dic[@"today_PublishNum_JcSingle"];
//            self.yp_todayPubNum=dic[@"today_PublishNum_Asian"];
//        }
//    } failure:^(NSError * error) {
//        
//    }];
//}

-(void)alertActionDissmiss:(UIAlertView *)alert{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}

-(void)toLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
}

-(void)getIsBuyInfoWithOrderID:(SuperiorMdl *)data{//获取是否购买
    
    Info *info = [Info getInstance];
    if (![info.userId intValue]){
        [self toLogin];
        return;
    }
    erAgintOrderId = data.erAgintOrderId;
    disPrice = data.discountPrice;
    [MobClick event:@"Zj_fangan_20161014_jingcai_fangan" label:[NSString stringWithFormat:@"%@VS%@",data.hostNameSimply,data.guestNameSimply]];
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"verifyIsBuyPlanByUserNameErAgintOrderId" forKey:@"methodName"];
    [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"er_agint_order_id":data.erAgintOrderId} forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSLog(@"responseJSON=%@",responseJSON);
        NSDictionary *dict = responseJSON[@"result"];//返回编码: 0000：已经购买; 0400:没有购买
        if ([[dict valueForKey:@"code"] isEqualToString:@"0000"]) {
            
            ProjectDetailViewController *proVC=[[ProjectDetailViewController alloc] init];
            proVC.erAgintOrderId=data.erAgintOrderId;
            proVC.pdLotryType = @"-201";
            if([data.playTypeCode isEqualToString:@"27"] || [data.playTypeCode isEqualToString:@"29"]){
                proVC.pdLotryType = @"204";
            }
            proVC.isSdOrNo=self.isSdOrNo;
            [self.navigationController pushViewController:proVC animated:YES];
            
        }else if([[dict valueForKey:@"code"] isEqualToString:@"0400"]){
            if([_matchSource isEqualToString:@"204"]){
                [self getChangeSPRequest];
            }else{
                [self addDealPurchaseTicket:disPrice tag:601];
            }
        }
    } failure:^(NSError * error) {
        
    }];
}
#pragma mark 查看是否变盘接口
-(void)getChangeSPRequest{
    
    NSString *message = [NSString stringWithFormat:@"您购买的推荐与当前盘口不符，是否确认支付(%.2f元)购买此方案内容",disPrice];
//#ifdef CRAZYSPORTS
//    message = [NSString stringWithFormat:@"您购买的推荐与当前盘口不符，是否确认支付(%.0f金币)购买此方案内容",disPrice * 10];
//#endif
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:@{@"erAgintOrderId":erAgintOrderId}];
    NSMutableDictionary *bodDic4=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"checkPlanSpIsChange",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic4 success:^(id JSON) {
        
        if([[JSON valueForKey:@"resultCode"] isEqualToString:@"0000"]){
            NSDictionary *dic=JSON[@"result"];
            NSString *changeStatus = [dic valueForKey:@"changeStatus"];
            if([changeStatus isEqualToString:@"1"]){//1变盘
                CP_UIAlertView *_cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付提示"
                                                                         message:message
                                                                        delegate:self
                                                               cancelButtonTitle:@"取消"
                                                               otherButtonTitles:@"确定", nil];
                
                
                _cpAlert.alertTpye=purchasePaln;
                _cpAlert.tag=601;
                [_cpAlert show];
            }else{
                [self addDealPurchaseTicket:disPrice tag:601];
            }
            
        }else{
            
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
//                                             message:[NSString stringWithFormat:@"您将支付(%.0f金币)购买此方案内容",str * jinbibeishu]
//                                            delegate:self
//                                   cancelButtonTitle:@"取消"
//                                   otherButtonTitles:@"确定", nil];
//#else
//    CP_UIAlertView *_cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付"
//                                             message:[NSString stringWithFormat:@"您将支付(%.2f元)购买此推荐",str]
//                                            delegate:self
//                                   cancelButtonTitle:@"取消"
//                                   otherButtonTitles:@"确定", nil];
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
        if([_matchSource isEqualToString:@"204"]){
            proVC.pdLotryType=@"204";
        }
        proVC.isSdOrNo=self.isSdOrNo;
//        _nPlanBtn.paidStatus=@"1";
        [self.navigationController pushViewController:proVC animated:YES];
    }
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    