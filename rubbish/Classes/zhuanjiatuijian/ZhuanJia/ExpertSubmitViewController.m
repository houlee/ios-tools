//
//  ExpertSubmitViewController.m
//  caibo
//
//  Created by cp365dev6 on 2016/11/27.
//
//

#import "ExpertSubmitViewController.h"
#import "ExpertInputInfoTableViewCell.h"
#import "ExpertSelectInfoTableViewCell.h"
#import "SharedMethod.h"
#import "ExpertButtonInfoTableViewCell.h"
#import "RequestEntity.h"
#import "MBProgressHUD+MJ.h"
#import "caiboAppDelegate.h"
#import "LoginViewController.h"
#import "PublicMethod.h"
#import "ResultButtonTableViewCell.h"

@interface ExpertSubmitViewController ()

@end

@implementation ExpertSubmitViewController

- (void)keyboardWillShown:(NSNotification*)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    
    CGRect rect = self.mainView.bounds;
    [myTableView setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-kbSize.height)];
    
}
-(void)keyboardWillHide:(NSNotification *)notifation{
    
    [myTableView setFrame:CGRectMake(self.mainView.frame.origin.x, myTableView.frame.origin.y, self.mainView.frame.size.width, self.mainView.frame.size.height)];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    if(!_matchdetailMdl){
        [self getSubmitNumber];//获取今日发布次数
    }
    else {
        [self requestLeagueList:@""];
    }
    
    
#if defined CRAZYSPORTS
    [self changeCSTitileColor];
#endif
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}
//-(void)getStarInfo{
//    
//    isStar = NO;
//    isSubmitFinish = NO;
//    
//    NSDictionary * expertResult = [DEFAULTS valueForKey:@"resultDic"];
//    
//    if ([[expertResult valueForKey:@"isStar"] isEqualToString:@"1"]){//明星---无限发
//        isStar = YES;
//    }else{
//        NSString *jcLevel = [expertResult valueForKey:@"jcLevel"];
//        self.jingcaiNumber = @"5";
//        if ([jcLevel integerValue] > 5){
//            self.jingcaiNumber = @"40";
//        }
//        NSString *jcCombineLevel = [expertResult valueForKey:@"jcCombineLevel"];
//        self.erchuanyiNumber = @"5";
//        if([jcCombineLevel integerValue] > 5){
//            self.erchuanyiNumber = @"40";
//        }
//    }
//}
#pragma mark -------获取竞足赔率限制--------
-(void)getOddsInfoRequest
{
    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"type":@"0"}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"expertService",@"methodName":@"getOddsInfo",@"parameters":parametersDic}];
    [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
        
        if ([[respondObject valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSDictionary *dic=respondObject[@"result"];
            self.multipleChoiceOdds  = [dic valueForKey:@"multipleChoiceOdds"];//单选赔率
            self.doubleSelectionOdds = [dic valueForKey:@"doubleSelectionOdds"];//双选赔率
        }
    } failure:^(NSError *error) {
        NSLog(@"错误的errror--%@",error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isFirst = YES;
    [self getOddsInfoRequest];
    
    _lcLeftBtn = NO;
    _lcRightBtn = NO;
    
    mayErchuanyi = YES;
    mayJingcai = YES;
    mayLancai = YES;
    
    isSubmit = NO;
    isSubmitFinish = NO;
//    [self getStarInfo];
    if(!_type || [_type isEqualToString:@""]){
        _type = @"-201";
    }
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(goBack)];
    self.CP_navigation.title = @"发布方案";
    
    [self createTableView];

    [self createInfoData];
    [self loadFooterView];

//    [self requestLeagueList:@""];
//    [self requestMatchListWithData:@"2016-11-30" leagueId:@"714" section:0];
    [self requestPriceList];//获取价格
    [self requestDiscountList];//折扣价格
}
-(void)createTableView{
    
    self.tuidan = @"0";
    dataArym = [[NSMutableArray alloc]initWithCapacity:0];
    pickerViewDataArym = [[NSMutableArray alloc]initWithCapacity:0];
    leagueTypeArym = [[NSMutableArray alloc]initWithCapacity:0];
    leagueTimeArym = [[NSMutableArray alloc]initWithCapacity:0];
    leagueTypeDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    allMatchArym1 = [[NSMutableArray alloc]initWithCapacity:0];
    allMatchArym2 = [[NSMutableArray alloc]initWithCapacity:0];
    matchArym1 = [[NSMutableArray alloc]initWithCapacity:0];
    matchArym2 = [[NSMutableArray alloc]initWithCapacity:0];
    priceArym = [[NSMutableArray alloc]initWithCapacity:0];
    discountPriceArym = [[NSMutableArray alloc]initWithCapacity:0];
    shengpingfuArym = [[NSMutableArray alloc]initWithCapacity:0];
    for(NSInteger i=0;i<6;i++){
        [shengpingfuArym addObject:@"0"];
    }
    
    myTableView = [[UITableView alloc] initWithFrame:self.mainView.bounds];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.mainView addSubview:myTableView];
    myTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    myTableView.backgroundColor = DEFAULT_BACKGROUNDCOLOR_CRAZY;
    
    mesTextView = [[UITextView alloc]init];
    mesTextView.frame = CGRectMake(67, 35*7+20+2, 235, 31);
    textContentSize = mesTextView.contentSize.height;
    textContentSize = 31;
    if([_type isEqualToString:@"201"]){
        footerView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, 90);
        mesTextView.frame = CGRectMake(67, 35*10+60+2, 235, textContentSize);
    }
    else if ([_type isEqualToString:@"204"]){
        mesTextView.frame = CGRectMake(67, 35*7+70+2, 235, textContentSize);
    }
    
    mesTextView.backgroundColor = [UIColor clearColor];
    mesTextView.font = [UIFont systemFontOfSize:12];
    mesTextView.delegate = self;
    mesTextView.textColor = BLACK_EIGHTYSEVER;
    [myTableView addSubview:mesTextView];
    
    
    placeholderLab = [[UILabel alloc]init];
    placeholderLab.frame = CGRectMake(5, 0, 230, 31);
    placeholderLab.backgroundColor = [UIColor clearColor];
    placeholderLab.text = @"输入推荐理由100~1200字";
    placeholderLab.textColor = BLACK_TWENTYFOUR;
    placeholderLab.font = [UIFont systemFontOfSize:12];
    [mesTextView addSubview:placeholderLab];
}
-(void)loadFooterView{
    footerView = [[UIView alloc]init];
    footerView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, 70);
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake((self.mainView.frame.size.width - 200)/2.0, 20, 200, 30);
    submitBtn.backgroundColor = [UIColor clearColor];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"通用-信息填写后"] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"通用-信息填写后"] forState:UIControlStateSelected];
    [submitBtn setTitle:@"提交方案" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:submitBtn];
    
#if defined CRAZYSPORTS
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"expert_submit_abled.png"] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"expert_submit_disabled.png"] forState:UIControlStateDisabled];
#endif
    
    UILabel *tishiLab = [[UILabel alloc]init];
    tishiLab.frame = CGRectMake(0, 60, self.mainView.frame.size.width, 15);
    tishiLab.backgroundColor = [UIColor clearColor];
    tishiLab.text = @"*请保证填写完两场比赛后提交";
    tishiLab.textColor = BLACK_FIFITYFOUR;
    tishiLab.hidden = YES;
    tishiLab.tag = 123;
    tishiLab.textAlignment = NSTextAlignmentCenter;
    tishiLab.font = [UIFont systemFontOfSize:11];
    [footerView addSubview:tishiLab];
    
    if([_type isEqualToString:@"201"]){
        footerView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, 90);
    }
    
    myTableView.tableFooterView = footerView;
}
-(void)createInfoData{
    
    NSString *shijian = @"";
    NSString *saishi = @"";
    NSString *race = @"";
    NSString *peilv = @"";
    NSString *wanfa = @"胜平负";
    NSString *caizhong = @"竞足";
    if(_matchdetailMdl){
        shijian = _matchdetailMdl.match_DATA;
        saishi = _matchdetailMdl.leagueNameSimply;
        race = [NSString stringWithFormat:@"%@ %@VS%@",_matchdetailMdl.CCId,_matchdetailMdl.hostNameSimply,_matchdetailMdl.guestNameSimply];
        peilv = _matchdetailMdl.spf_SP;
        if(_matchdetailMdl.sheng_PING_FU == 0){
            peilv = _matchdetailMdl.rang_QIU_SP;
            wanfa = [NSString stringWithFormat:@"让球胜平负(%@)",_matchdetailMdl.rq];
        }
        
        if([_type isEqualToString:@"-201"]){
            caizhong = @"竞足";
        }else if ([_type isEqualToString:@"201"]){
            caizhong = @"2串1";
        }else if ([_type isEqualToString:@"204"]){
            caizhong = @"篮彩";
            
            shijian = _matchdetailMdl.match_DATA;
            saishi = _matchdetailMdl.leagueNameSimply;
            race = [NSString stringWithFormat:@"%@ %@VS%@",_matchdetailMdl.CCId,_matchdetailMdl.guestNameSimply,_matchdetailMdl.hostNameSimply];
            peilv = [NSString stringWithFormat:@"%@ %@ daxiaoqiu",_matchdetailMdl.daxiao_sp,_matchdetailMdl.daxiao_comityball];
            wanfa = @"大小分";
        }
    }else{
        _type = @"-201";
        
        if(mayJingcai){
            caizhong = @"竞足";
            _type = @"-201";
        }else if (mayErchuanyi){
            caizhong = @"2串1";
            _type = @"201";
        }else if (mayLancai){
            caizhong = @"篮彩";
            _type = @"204";
            wanfa = @"大小分";
        }
    }
    
//    if(!mayErchuanyi && mayJingcai){//能发竞足
//        
//    }else if (mayErchuanyi && !mayJingcai){//能发2串1
//        
//    }
    
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"当前彩种",@"left",caizhong,@"right", nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"请选择时间",@"left",shijian,@"right", nil];
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:@"当前玩法",@"left",wanfa,@"right", nil];
    
    NSDictionary *dict4 = [NSDictionary dictionaryWithObjectsAndKeys:@"请选择赛事",@"left",saishi,@"right", nil];
    NSDictionary *dict5 = [NSDictionary dictionaryWithObjectsAndKeys:@"请选择比赛",@"left",race,@"right", nil];
    NSDictionary *dict6 = [NSDictionary dictionaryWithObjectsAndKeys:@"推荐赛果",@"left",peilv,@"right", nil];
    
    NSDictionary *dict7 = [NSDictionary dictionaryWithObjectsAndKeys:@"请选择赛事",@"left",@"",@"right", nil];
    NSDictionary *dict8 = [NSDictionary dictionaryWithObjectsAndKeys:@"请选择比赛",@"left",@"",@"right", nil];
    NSDictionary *dict9 = [NSDictionary dictionaryWithObjectsAndKeys:@"推荐赛果",@"left",@"",@"right", nil];
    
    NSDictionary *dict10 = [NSDictionary dictionaryWithObjectsAndKeys:@"方案标题:",@"left",@"",@"right", nil];
    NSDictionary *dict11 = [NSDictionary dictionaryWithObjectsAndKeys:@"推荐理由:",@"left",@"",@"right", nil];
    
    NSDictionary *dict12 = [NSDictionary dictionaryWithObjectsAndKeys:@"当前方案价格",@"left",@"",@"right", nil];
    NSDictionary *dict13 = [NSDictionary dictionaryWithObjectsAndKeys:@"当前方案折扣",@"left",@"",@"right", nil];
    
    NSDictionary *dict14 = [NSDictionary dictionaryWithObjectsAndKeys:@"是否参加不中退款活动",@"left",@"",@"right", nil];
    
    [dataArym addObject:dict1];
    [dataArym addObject:dict2];
    [dataArym addObject:dict3];
    [dataArym addObject:dict4];
    [dataArym addObject:dict5];
    [dataArym addObject:dict6];
    [dataArym addObject:dict7];
    [dataArym addObject:dict8];
    [dataArym addObject:dict9];
    [dataArym addObject:dict10];
    [dataArym addObject:dict11];
    [dataArym addObject:dict12];
    [dataArym addObject:dict13];
    [dataArym addObject:dict14];
    
    [myTableView reloadData];
}
- (NSMutableDictionary *)handleDataArray:(NSArray *)array
{
    NSMutableDictionary *_conditionInfos = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableArray *_sortAllkeys = [[NSMutableArray alloc]initWithCapacity:0];
    for(int i = 0;i<[array count];i++){
        
        NSDictionary *dict = [array objectAtIndex:i];
        NSString *creetTimer = [dict valueForKey:@"MATCHDATE"];
        
        if (![_conditionInfos valueForKey:creetTimer]) {
            NSMutableArray *mutable = [NSMutableArray array];
            [_conditionInfos setValue:mutable forKey:creetTimer];
            if (![_sortAllkeys containsObject:creetTimer]) {
                [_sortAllkeys addObject:creetTimer];
            }
            
        }
        NSMutableArray *mutableArray = [_conditionInfos valueForKey:creetTimer];
        [mutableArray addObject:dict];
        [_conditionInfos setValue:mutableArray forKey:creetTimer];
    }
    NSArray *_allKeys = [_conditionInfos allKeys];
    
    return _conditionInfos;
}
#pragma mark -------获取竞足联赛种类列表--------
-(void)requestLeagueList:(NSString *)sourceqwe
{
    NSString *source = @"1";
    if([_type isEqualToString:@"204"]){
        source = @"4";
    }
    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"expertsName":[[Info getInstance] userName],@"source":source}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"sMGExpertService",@"methodName":@"getLeagueTypeList",@"parameters":parametersDic}];
    [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
        
        if ([[respondObject valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray *resultArr = respondObject[@"result"];
            [leagueTypeDict removeAllObjects];
            [leagueTimeArym removeAllObjects];
            [leagueTypeArym removeAllObjects];
            if(resultArr.count > 0){
                NSMutableArray *arym = [[NSMutableArray alloc]initWithCapacity:0];
                for (NSDictionary *nameDic in resultArr) {
                    
                    [arym addObject:nameDic];
                }
//                [leagueTypeDict removeAllObjects];
                leagueTypeDict = [[self handleDataArray:arym] retain];
//                [leagueTimeArym removeAllObjects];
                [leagueTimeArym addObjectsFromArray:[leagueTypeDict allKeys]];
                
                if(_matchdetailMdl){
//                    [leagueTypeArym removeAllObjects];
                    [leagueTypeArym addObjectsFromArray:[leagueTypeDict valueForKey:_matchdetailMdl.match_DATA]];
                    [self requestMatchListWithData:_matchdetailMdl.match_DATA leagueId:_matchdetailMdl.league_id section:0];
                }
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"错误的errror--%@",error);
    }];
}
#pragma mark ----------获取某联赛下的比赛列表---------
-(void)requestMatchListWithData:(NSString *)data leagueId:(NSString *)leagueId section:(NSInteger)section
{
    NSString *source = @"1";
    if([_type isEqualToString:@"204"]){
        source = @"4";
    }
    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"leagueId":leagueId,@"expertsName":[[Info getInstance] userName],@"date":data,@"source":source}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"sMGExpertService",@"methodName":@"getMatchList",@"parameters":parametersDic}];
    if (leagueId.length != 0) {
        [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
            
            if ([[respondObject valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
                NSArray *resultArr = respondObject[@"result"];
                if(section == 6){//第二场
                    [allMatchArym2 removeAllObjects];
                    for (NSDictionary *nameDic in resultArr) {//
                        [allMatchArym2 addObject:nameDic];
                    }
                }else{
                    [allMatchArym1 removeAllObjects];
                    for (NSDictionary *nameDic in resultArr) {//
                        [allMatchArym1 addObject:nameDic];
                    }
                }
            }
            if(_matchdetailMdl && !section){
                [matchArym1 removeAllObjects];
                for(NSDictionary *dict in allMatchArym1){
//                    [matchArym1 removeAllObjects];
                    if([[dict valueForKey:@"play_ID"] isEqualToString:_matchdetailMdl.play_ID]){
                        [matchArym1 addObject:dict];
                        break;
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
    NSString *lotteryClassCode = @"-201";//竞足
    if([_type isEqualToString:@"201"]){
        lotteryClassCode = @"201";//2串1
    }
    if([_type isEqualToString:@"204"]){
        lotteryClassCode = @"204";//篮彩
    }
    NSMutableDictionary  *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"expertsName":[[Info getInstance] userName],@"lotteryClassCode":lotteryClassCode}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"commonExpertService",@"methodName":@"getPlanPriceList",@"parameters":parametersDic}];
    [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
        NSDictionary *dataDic = respondObject;
        if ([dataDic[@"resultCode"] isEqualToString:@"0000"]) {
            NSArray *resultArr = respondObject[@"result"];
            [priceArym removeAllObjects];
            self.price = @"";
            self.discountPrice = @"1";
            [self reloadCollectionWithInfo:@"" section:11];//价格
            [self reloadCollectionWithInfo:@"无折扣" section:12];//折扣
            if(resultArr.count > 0){
                NSDictionary *dict = [resultArr objectAtIndex:0];
                self.price = [dict valueForKey:@"price"];
                [self reloadCollectionWithInfo:[NSString stringWithFormat:@"￥%@",[dict valueForKey:@"priceName"]] section:11];//价格
            }
            for (NSDictionary *nameDic in resultArr) {//价格
                [priceArym addObject:nameDic];
            }
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
             NSArray *resultArr = respondObject[@"result"];
            self.discountPrice = @"1";
            [self reloadCollectionWithInfo:@"无折扣" section:12];//折扣
            if(resultArr.count > 0){
                NSDictionary *dict = [resultArr objectAtIndex:0];
                self.discountPrice = [dict valueForKey:@"discountCoeff"];
                [self reloadCollectionWithInfo:[dict valueForKey:@"discountName"] section:12];//折扣
            }
            [discountPriceArym removeAllObjects];
            for (NSDictionary *discountDic in resultArr) {
                [discountPriceArym addObject:discountDic];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"错误的errror--%@",error);
    }];
}
#pragma mark -----------提交方案------------
-(void)commitPlanCount
{

    if([_type isEqualToString:@"-201"]){
        
        NSDictionary *newDict = [dataArym objectAtIndex:1];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择时间"];
            return;
        }
        newDict = [dataArym objectAtIndex:3];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择赛程"];
            return;
        }
        newDict = [dataArym objectAtIndex:4];
        if(!matchArym1.count || ![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择比赛"];
            return;
        }
        newDict = [dataArym objectAtIndex:2];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择玩法"];
            return;
        }
        BOOL have0 = NO;
        BOOL have1 = NO;
        BOOL have2 = NO;
        NSInteger num = 0;
        for(NSInteger i=0;i<3;i++){
            if([[shengpingfuArym objectAtIndex:i] isEqualToString:@"1"]){
                if(i == 0){
                    have0 = YES;
                }
                if(i == 1){
                    have1 = YES;
                }
                if(i == 2){
                    have2 = YES;
                }
                num += 1;
            }
        }
        if(num == 0){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择赛果"];
            return;
        }
        
        newDict = [dataArym objectAtIndex:9];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请输入标题"];
            return;
        }
        if([mesTextView.text length] < 100 ||[mesTextView.text length] > 1200){
            [[caiboAppDelegate getAppDelegate] showMessage:@"推荐理由100~1200字"];
            return;
        }
        if(![mesTextView.text length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请输入理由"];
            return;
        }
        newDict = [dataArym objectAtIndex:11];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择选择方案价格"];
            return;
        }
        newDict = [dataArym objectAtIndex:12];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择方案折扣"];
            return;
        }
        NSDictionary *dict = [matchArym1 objectAtIndex:0];
        NSString *leagueName = [[dataArym objectAtIndex:3] valueForKey:@"right"];
        NSString *biaoti = [[dataArym objectAtIndex:9] valueForKey:@"right"];
        NSString *tuijian = mesTextView.text;
        NSString *playTypeCode = @"01";
        if([[[dataArym objectAtIndex:2] valueForKey:@"right"] isEqualToString:@"胜平负"]){
            playTypeCode = @"10";
        }
        NSString *hostRq = @"0";
        if([playTypeCode isEqualToString:@"01"]){
            hostRq = [dict valueForKey:@"rq"];
        }
        
        if(num > 0){
            NSArray *ary;
            if([playTypeCode isEqualToString:@"01"]){//让球胜平负
                ary = [[dict valueForKey:@"rang_QIU_SP"] componentsSeparatedByString:@" "];
                
            }else{
                ary = [[dict valueForKey:@"spf_SP"] componentsSeparatedByString:@" "];
            }
            NSString *xianzhi = _multipleChoiceOdds;
            if(num == 2){
                xianzhi = _doubleSelectionOdds;
            }
            if(ary.count == 3){
                if(have0 && [[ary objectAtIndex:0] floatValue] < [xianzhi floatValue]){
                    [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"单选≥%@,双选≥%@",_multipleChoiceOdds,_doubleSelectionOdds]];
                    return;
                }
                if(have1 && [[ary objectAtIndex:1] floatValue] < [xianzhi floatValue]){
                    [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"单选≥%@,双选≥%@",_multipleChoiceOdds,_doubleSelectionOdds]];
                    return;
                }
                if(have2 && [[ary objectAtIndex:2] floatValue] < [xianzhi floatValue]){
                    [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"单选≥%@,双选≥%@",_multipleChoiceOdds,_doubleSelectionOdds]];
                    return;
                }
            }
        }
        
        NSString *shengpingfu = @"";
        if([[shengpingfuArym objectAtIndex:0] isEqualToString:@"1"]){
            shengpingfu = @"胜,";
        }if([[shengpingfuArym objectAtIndex:1] isEqualToString:@"1"]){
            shengpingfu = [NSString stringWithFormat:@"%@平,",shengpingfu];
        }if([[shengpingfuArym objectAtIndex:2] isEqualToString:@"1"]){
            shengpingfu = [NSString stringWithFormat:@"%@负,",shengpingfu];
        }
        shengpingfu = [shengpingfu substringToIndex:shengpingfu.length - 1];
//        NSString *content = [NSString stringWithFormat:@"%@ %@",[dict valueForKey:@"host_NAME_SIMPLY"],shengpingfu];
        NSString *content = [NSString stringWithFormat:@"%@ %@",[dict valueForKey:@"host_NAME_SIMPLY"],shengpingfu];
        if([playTypeCode isEqualToString:@"01"]){
            NSString *rqnum = [[matchArym1 objectAtIndex:0] valueForKey:@"rq"];
            content = [NSString stringWithFormat:@"%@ (%@) %@",[dict valueForKey:@"host_NAME_SIMPLY"],rqnum,shengpingfu];
        }
        NSMutableDictionary  *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"dadtaSource":@"1",
                                                                                               @"leagueName":leagueName,//赛事
                                                                                               @"playTypeCode":playTypeCode,//胜平负
                                                                                               @"matchTime":[dict valueForKey:@"match_TIME"],
                                                                                               @"discount":self.discountPrice,
                                                                                               @"expertsName":[[Info getInstance] userName],
                                                                                               @"recommendTitle":biaoti,
                                                                                               @"price":self.price,
                                                                                               @"hostRq":hostRq,
                                                                                               @"predictResult":shengpingfu,
                                                                                               @"matchId":[dict valueForKey:@"match_ID"],
                                                                                               @"sdStatus":@"0",//非神单
                                                                                               @"free_status":self.tuidan,//是否参加不中退款
                                                                                               @"recommendContent":content,
                                                                                               @"recommendExplain":tuijian,
                                                                                               @"lotteryClassCode":@"-201",
                                                                                               @"playId":[dict valueForKey:@"play_ID"],
                                                                                               @"matchStatus":[dict valueForKey:@"match_STATUS"],
                                                                                               @"ccId":[dict valueForKey:@"cc_ID"],
                                                                                               @"awayName":[dict valueForKey:@"guest_NAME_SIMPLY"],//客队
                                                                                               @"expertsClassCode":@"001",//001竞足
                                                                                               @"homeName":[dict valueForKey:@"host_NAME_SIMPLY"],//主队
                                                                                               @"odds":[dict valueForKey:@"spf_SP"],//胜平负赔率
                                                                                               @"rqOdds":[dict valueForKey:@"rang_QIU_SP"],//让球胜平负赔率
                                                                                               @"asian_sp":@"",//亚盘什么的  不传
                                                                                               @"clientType":@"2",//ios
                                                                                               @"publishVersion":APPVersion}];
        NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"sMGExpertService",@"methodName":@"publishSMGPlan",@"parameters":parametersDic}];
        
        [self commitCompeteRequest:bodyDic];
    }else if([_type isEqualToString:@"201"]){
        
        NSDictionary *newDict = [dataArym objectAtIndex:1];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择时间"];
            return;
        }
        newDict = [dataArym objectAtIndex:3];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择赛程"];
            return;
        }
        newDict = [dataArym objectAtIndex:4];
        if(!matchArym1.count || ![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择比赛"];
            return;
        }
        newDict = [dataArym objectAtIndex:2];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择玩法"];
            return;
        }
//        BOOL have = NO;
//        for(NSInteger i=0;i<3;i++){
//            if([[shengpingfuArym objectAtIndex:i] isEqualToString:@"1"]){
//                have = YES;
//                break;
//            }
//        }
//        if(!have){
//            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择赛果"];
//            return;
//        }
        BOOL have0 = NO;
        BOOL have1 = NO;
        BOOL have2 = NO;
        NSInteger num = 0;
        for(NSInteger i=0;i<3;i++){
            if([[shengpingfuArym objectAtIndex:i] isEqualToString:@"1"]){
                if(i == 0){
                    have0 = YES;
                }
                if(i == 1){
                    have1 = YES;
                }
                if(i == 2){
                    have2 = YES;
                }
                num += 1;
            }
        }
        if(num == 0){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择赛果"];
            return;
        }
        newDict = [dataArym objectAtIndex:6];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择赛程"];
            return;
        }
        newDict = [dataArym objectAtIndex:7];
        if(!matchArym2.count || ![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择比赛"];
            return;
        }
        BOOL have = NO;
        for(NSInteger i=3;i<6;i++){
            if([[shengpingfuArym objectAtIndex:i] isEqualToString:@"1"]){
                have = YES;
                break;
            }
        }
        if(!have){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择赛果"];
            return;
        }
        newDict = [dataArym objectAtIndex:9];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请输入标题"];
            return;
        }
        if([mesTextView.text length] < 100 ||[mesTextView.text length] > 1200){
            [[caiboAppDelegate getAppDelegate] showMessage:@"推荐理由100~1200字"];
            return;
        }
        if(![mesTextView.text length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请输入理由"];
            return;
        }
        newDict = [dataArym objectAtIndex:11];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择选择方案价格"];
            return;
        }
        newDict = [dataArym objectAtIndex:12];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择方案折扣"];
            return;
        }
        
        NSDictionary *dict = [matchArym1 objectAtIndex:0];
        if(num > 0){
            NSArray *ary;
            if([[[dataArym objectAtIndex:2] valueForKey:@"right"] isEqualToString:@"胜平负"]){//胜平负
                ary = [[dict valueForKey:@"spf_SP"] componentsSeparatedByString:@" "];
                
            }else{
                ary = [[dict valueForKey:@"rang_QIU_SP"] componentsSeparatedByString:@" "];
            }
            NSString *xianzhi = _multipleChoiceOdds;
            if(num == 2){
                xianzhi = _doubleSelectionOdds;
            }
            if(ary.count == 3){
                if(have0 && [[ary objectAtIndex:0] floatValue] < [xianzhi floatValue]){
                    [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"第一场比赛单选≥%@,双选≥%@",_multipleChoiceOdds,_doubleSelectionOdds]];
                    return;
                }
                if(have1 && [[ary objectAtIndex:1] floatValue] < [xianzhi floatValue]){
                    [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"第一场比赛单选≥%@,双选≥%@",_multipleChoiceOdds,_doubleSelectionOdds]];
                    return;
                }
                if(have2 && [[ary objectAtIndex:2] floatValue] < [xianzhi floatValue]){
                    [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"第一场比赛单选≥%@,双选≥%@",_multipleChoiceOdds,_doubleSelectionOdds]];
                    return;
                }
            }
        }
        NSDictionary *dict1 = [matchArym2 objectAtIndex:0];
        if([[dict valueForKey:@"play_ID"] isEqualToString:[dict1 valueForKey:@"play_ID"]]){
            
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择不同的两场比赛"];
            return;
        }
        NSString *leagueName = [NSString stringWithFormat:@"%@|%@",[[dataArym objectAtIndex:3] valueForKey:@"right"],[[dataArym objectAtIndex:6] valueForKey:@"right"]];
        
        NSString *playTypeCode = @"01|01";
        NSString *hostRq = [NSString stringWithFormat:@"%@|%@",[dict valueForKey:@"rq"],[dict1 valueForKey:@"rq"]];
        if([[[dataArym objectAtIndex:2] valueForKey:@"right"] isEqualToString:@"胜平负"]){
            playTypeCode = @"10|10";
            hostRq = @"0|0";
        }
//        if([[[dataArym objectAtIndex:9] valueForKey:@"right"] isEqualToString:@"胜平负"]){
//            playTypeCode = [NSString stringWithFormat:@"%@|10",playTypeCode];
//            hostRq = [NSString stringWithFormat:@"%@|0",hostRq];
//        }else{
//            playTypeCode = [NSString stringWithFormat:@"%@|01",playTypeCode];
//            hostRq = [NSString stringWithFormat:@"%@|%@",hostRq,[dict1 valueForKey:@"rq"]];
//        }
        
        NSString *matchTime = [NSString stringWithFormat:@"%@|%@",[dict valueForKey:@"match_TIME"],[dict1 valueForKey:@"match_TIME"]];
        
        
//        if([playTypeCode isEqualToString:@"01"]){
//            hostRq = [dict valueForKey:@"rq"];
//        }
        
        NSString *biaoti = [[dataArym objectAtIndex:9] valueForKey:@"right"];
        NSString *tuijian = mesTextView.text;
        
        NSString *predictResult1 = @"";
        if([[shengpingfuArym objectAtIndex:0] isEqualToString:@"1"]){
            predictResult1 = @"胜,";
        }if([[shengpingfuArym objectAtIndex:1] isEqualToString:@"1"]){
            predictResult1 = [NSString stringWithFormat:@"%@平,",predictResult1];
        }if([[shengpingfuArym objectAtIndex:2] isEqualToString:@"1"]){
            predictResult1 = [NSString stringWithFormat:@"%@负,",predictResult1];
        }
        predictResult1 = [predictResult1 substringToIndex:predictResult1.length - 1];
        NSString *recommendContent1 = [NSString stringWithFormat:@"%@ %@",[dict valueForKey:@"host_NAME_SIMPLY"],predictResult1];
        if([playTypeCode isEqualToString:@"01|01"]){
            NSString *rqnum = [[matchArym1 objectAtIndex:0] valueForKey:@"rq"];
            recommendContent1 = [NSString stringWithFormat:@"%@ (%@) %@",[dict valueForKey:@"host_NAME_SIMPLY"],rqnum,predictResult1];
        }
        
        NSString *predictResult2 = @"";
        if([[shengpingfuArym objectAtIndex:3] isEqualToString:@"1"]){
            predictResult2 = @"胜,";
        }if([[shengpingfuArym objectAtIndex:4] isEqualToString:@"1"]){
            predictResult2 = [NSString stringWithFormat:@"%@平,",predictResult2];
        }if([[shengpingfuArym objectAtIndex:5] isEqualToString:@"1"]){
            predictResult2 = [NSString stringWithFormat:@"%@负,",predictResult2];
        }
        predictResult2 = [predictResult2 substringToIndex:predictResult2.length - 1];
        NSString *recommendContent2 = [NSString stringWithFormat:@"%@ %@",[dict1 valueForKey:@"host_NAME_SIMPLY"],predictResult2];
        if([playTypeCode isEqualToString:@"01|01"]){
            NSString *rqnum = [[matchArym2 objectAtIndex:0] valueForKey:@"rq"];
            recommendContent2 = [NSString stringWithFormat:@"%@ (%@) %@",[dict1 valueForKey:@"host_NAME_SIMPLY"],rqnum,predictResult2];
        }
        
        NSString *matchId = [NSString stringWithFormat:@"%@|%@",[dict valueForKey:@"match_ID"],[dict1 valueForKey:@"match_ID"]];
        
        NSString *playId = [NSString stringWithFormat:@"%@|%@",[dict valueForKey:@"play_ID"],[dict1 valueForKey:@"play_ID"]];
        NSString *matchStatus = [NSString stringWithFormat:@"%@|%@",[dict valueForKey:@"match_STATUS"],[dict1 valueForKey:@"match_STATUS"]];
        NSString *ccId = [NSString stringWithFormat:@"%@|%@",[dict valueForKey:@"cc_ID"],[dict1 valueForKey:@"cc_ID"]];
        NSString *awayName = [NSString stringWithFormat:@"%@|%@",[dict valueForKey:@"guest_NAME_SIMPLY"],[dict1 valueForKey:@"guest_NAME_SIMPLY"]];
        NSString *homeName = [NSString stringWithFormat:@"%@|%@",[dict valueForKey:@"host_NAME_SIMPLY"],[dict1 valueForKey:@"host_NAME_SIMPLY"]];
        NSString *odds = [NSString stringWithFormat:@"%@|%@",[dict valueForKey:@"spf_SP"],[dict1 valueForKey:@"spf_SP"]];
        NSString *rqOdds = [NSString stringWithFormat:@"%@|%@",[dict valueForKey:@"rang_QIU_SP"],[dict1 valueForKey:@"rang_QIU_SP"]];
        NSMutableDictionary  *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"dadtaSource":@"1",
                                                                                               @"leagueName":leagueName,//赛事
                                                                                               @"playTypeCode":playTypeCode,//胜平负
                                                                                               @"matchTime":matchTime,
                                                                                               @"discount":self.discountPrice,
                                                                                               @"expertsName":[[Info getInstance] userName],
                                                                                               @"recommendTitle":biaoti,
                                                                                               @"price":self.price,
                                                                                               @"hostRq":hostRq,
                                                                                               @"predictResult":[NSString stringWithFormat:@"%@|%@",predictResult1,predictResult2],
                                                                                               @"matchId":matchId,
                                                                                               @"sdStatus":@"0",//非神单
                                                                                               @"free_status":@"0",//是否参加不中退款
                                                                                               @"recommendContent":[NSString stringWithFormat:@"%@|%@",recommendContent1,recommendContent2],
                                                                                               @"recommendExplain":tuijian,
                                                                                               @"lotteryClassCode":@"201",
                                                                                               @"playId":playId,
                                                                                               @"matchStatus":matchStatus,
                                                                                               @"ccId":ccId,
                                                                                               @"awayName":awayName,//客队
                                                                                               @"expertsClassCode":@"001",//001竞足
                                                                                               @"homeName":homeName,//主队
                                                                                               @"odds":odds,//胜平负赔率
                                                                                               @"rqOdds":rqOdds,//让球胜平负赔率
                                                                                               @"asian_sp":@"",//亚盘什么的  不传
                                                                                               @"clientType":@"2",//ios
                                                                                               @"passType":@"2x1",//过关方式 2x1
                                                                                               @"publishVersion":APPVersion}];
        NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"sMGExpertService",@"methodName":@"publishCombinePlan",@"parameters":parametersDic}];
        
        [self commitCompeteRequest:bodyDic];
    }else if ([_type isEqualToString:@"204"]){//篮球
        
        NSDictionary *newDict = [dataArym objectAtIndex:1];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择时间"];
            return;
        }
        newDict = [dataArym objectAtIndex:3];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择赛程"];
            return;
        }
        newDict = [dataArym objectAtIndex:4];
        if(!matchArym1.count || ![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择比赛"];
            return;
        }
        newDict = [dataArym objectAtIndex:2];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择玩法"];
            return;
        }
        if(!_lcLeftBtn && !_lcRightBtn){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择赛果"];
            return;
        }
        if(_lcLeftBtn && _lcRightBtn){
            [[caiboAppDelegate getAppDelegate] showMessage:@"只能选择一种赛果"];
            return;
        }
        newDict = [dataArym objectAtIndex:9];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请输入标题"];
            return;
        }
        if([mesTextView.text length] < 100 ||[mesTextView.text length] > 1200){
            [[caiboAppDelegate getAppDelegate] showMessage:@"推荐理由100~1200字"];
            return;
        }
        if(![mesTextView.text length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请输入理由"];
            return;
        }
        newDict = [dataArym objectAtIndex:11];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择选择方案价格"];
            return;
        }
        newDict = [dataArym objectAtIndex:12];
        if(![[newDict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择方案折扣"];
            return;
        }
        NSDictionary *dict = [matchArym1 objectAtIndex:0];
        NSString *leagueName = [[dataArym objectAtIndex:3] valueForKey:@"right"];
        NSString *biaoti = [[dataArym objectAtIndex:9] valueForKey:@"right"];
        NSString *tuijian = mesTextView.text;
        NSString *playTypeCode = @"27";//27让分胜负; 29大小分
        if([[[dataArym objectAtIndex:2] valueForKey:@"right"] isEqualToString:@"大小分"]){
            playTypeCode = @"29";
        }
        NSString *hostRq = [dict valueForKey:@"rangfen_comityball"];
        if([playTypeCode isEqualToString:@"29"]){
            hostRq = [dict valueForKey:@"daxiao_comityball"];
        }
        
        NSString *shengpingfu = @"";
        if([playTypeCode isEqualToString:@"29"]){
            if(_lcLeftBtn){
                shengpingfu = @"大";
            }
            if(_lcRightBtn){
                shengpingfu = @"小";
            }
        }else{
            if(_lcLeftBtn){
                shengpingfu = @"负";
            }
            if(_lcRightBtn){
                shengpingfu = @"胜";
            }
        }
        
        NSString *content = [NSString stringWithFormat:@"%@ (%@) %@",[dict valueForKey:@"host_NAME_SIMPLY"],[[matchArym1 objectAtIndex:0] valueForKey:@"rangfen_comityball"],shengpingfu];
        if([playTypeCode isEqualToString:@"29"]){
            content = [NSString stringWithFormat:@"%@ (%@) %@",[dict valueForKey:@"host_NAME_SIMPLY"],[[matchArym1 objectAtIndex:0] valueForKey:@"daxiao_comityball"],shengpingfu];
        }
        NSString *odds = [dict valueForKey:@"daxiao_sp"];
        if([playTypeCode isEqualToString:@"27"]){
            odds = [dict valueForKey:@"rangfen_sp"];
        }
        NSMutableDictionary  *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"dadtaSource":@"4",
                                                                                               @"leagueName":leagueName,//赛事
                                                                                               @"playTypeCode":playTypeCode,//胜平负
                                                                                               @"matchTime":[dict valueForKey:@"match_TIME"],
                                                                                               @"discount":self.discountPrice,
                                                                                               @"expertsName":[[Info getInstance] userName],
                                                                                               @"recommendTitle":biaoti,
                                                                                               @"price":self.price,
                                                                                               @"hostRq":hostRq,
                                                                                               @"predictResult":shengpingfu,
                                                                                               @"matchId":[dict valueForKey:@"match_ID"],
                                                                                               @"sdStatus":@"0",//非神单
                                                                                               @"free_status":@"0",//是否参加不中退款
                                                                                               @"recommendContent":content,
                                                                                               @"recommendExplain":tuijian,
                                                                                               @"lotteryClassCode":@"204",
                                                                                               @"playId":[dict valueForKey:@"play_ID"],
                                                                                               @"matchStatus":[dict valueForKey:@"match_STATUS"],
                                                                                               @"ccId":[dict valueForKey:@"cc_ID"],
                                                                                               @"awayName":[dict valueForKey:@"guest_NAME_SIMPLY"],//客队
                                                                                               @"expertsClassCode":@"001",//001竞足
                                                                                               @"homeName":[dict valueForKey:@"host_NAME_SIMPLY"],//主队
                                                                                               @"odds":odds,//胜平负赔率
                                                                                               @"asian_sp":@"",//亚盘什么的  不传
                                                                                               @"clientType":@"2",//ios
                                                                                               @"publishVersion":APPVersion}];
        NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"sMGExpertService",@"methodName":@"publishBasketBallPlan",@"parameters":parametersDic}];
        
        [self commitCompeteRequest:bodyDic];
    }
}
-(void)commitCompeteRequest:(NSMutableDictionary *)bodyDic
{
    [MBProgressHUD showMessage:@"提交中..."];
    [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
        [MBProgressHUD hideHUD];
        NSDictionary  *respondDic = respondObject;
        if ([respondDic[@"resultCode"] isEqualToString:@"0000"]){
//            if(isStar){
//                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"恭喜您方案提交成功我们将尽快为您审核" delegate:self cancelButtonTitle:@"一会再说" otherButtonTitles:@"再发一单", nil];
//                alertView.tag = 123123;
//                [alertView show];
//            }else{
//                isSubmitFinish = YES;
//                [self requestPulishNo];
//            }
            isSubmitFinish = YES;
            [self getSubmitNumber];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:respondDic[@"resultDesc"] delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alertView show];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}
//#pragma mark ----------获取今日发布方案的次数-------------
//
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
//        if([erchuanyiNum integerValue] < [self.erchuanyiNumber integerValue]){
//            mayErchuanyi = YES;
//        }else{
//            mayErchuanyi = NO;
//        }
//        if([jingcaiNum integerValue] < [self.jingcaiNumber integerValue]){
//            mayJingcai = YES;
//        }else{
//            
//            mayJingcai = NO;
//        }
//        
//        if(isSubmit){//去发布
//            isSubmit = NO;
//            if(mayErchuanyi || mayJingcai){
//                [self commitPlanCount];
//            }else{
//                [[caiboAppDelegate getAppDelegate] showMessage:@"您已超过发布次数限制"];
//                return ;
//            }
//        }
//        else if(isSubmitFinish){//发布完成
//            isSubmitFinish = NO;
//            if(mayErchuanyi || mayJingcai){//如果有一个能发
//                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"恭喜您方案提交成功我们将尽快为您审核" delegate:self cancelButtonTitle:@"一会再说" otherButtonTitles:@"再发一单", nil];
//                alertView.tag = 123123;
//                [alertView show];
//            }else{
//                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"恭喜您方案提交成功我们将尽快为您审核" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
//                [alertView show];
//            }
//        }else{//首次进入页面
//            [self performSelector:@selector(reloadCaizhong) withObject:nil afterDelay:0.1];
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
            
            
            if(isSubmit){//去发布
                isSubmit = NO;
                if(mayErchuanyi || mayJingcai || mayLancai){
                    [self commitPlanCount];
                }else{
                    [[caiboAppDelegate getAppDelegate] showMessage:@"您已超过发布次数限制"];
                    return ;
                }
            }
            else if(isSubmitFinish){//发布完成
                isSubmitFinish = NO;
                if(mayErchuanyi || mayJingcai || mayLancai){//如果有一个能发
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"恭喜您方案提交成功我们将尽快为您审核" delegate:self cancelButtonTitle:@"一会再说" otherButtonTitles:@"再发一单", nil];
                    alertView.tag = 123123;
                    [alertView show];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"恭喜您方案提交成功我们将尽快为您审核" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                    alertView.tag = 123123;
                    [alertView show];
                }
            }else if (isFirst && !_matchdetailMdl){//首次进入页面
                isFirst = NO;
                [self performSelector:@selector(reloadCaizhong) withObject:nil afterDelay:0.05];
            }
            
            
        }else{
            
        }
        
    } failure:^(NSError * error) {
        
    }];
}
-(void)reloadCaizhong{
    if(dataArym.count > 0){
        NSString *caizhong = @"竞足";
        _type = @"-201";
        NSString *wanfa = @"胜平负";
        if(mayJingcai){
            caizhong = @"竞足";
            _type = @"-201";
        }else if (mayErchuanyi){
            caizhong = @"2串1";
            _type = @"201";
        }else if (mayLancai){
            caizhong = @"篮彩";
            _type = @"204";
            wanfa = @"大小分";
        }
        
        [self requestPriceList];//获取价格
        
        UILabel *lab = [footerView viewWithTag:123];
        lab.hidden = YES;
        mesTextView.frame = CGRectMake(67, 35*7+20+2, 235, textContentSize);
        if([_type isEqualToString:@"201"]){
            lab.hidden = NO;
            footerView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, 90);
            mesTextView.frame = CGRectMake(67, 35*10+60+2, 235, textContentSize);
        }
        else if ([_type isEqualToString:@"204"]){
            mesTextView.frame = CGRectMake(67, 35*7+70+2, 235, textContentSize);
        }
        myTableView.tableFooterView = footerView;
        [self requestLeagueList:@""];
        NSDictionary *d = [dataArym objectAtIndex:0];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[d valueForKey:@"left"],@"left",caizhong,@"right", nil];
        NSDictionary *d2 = [dataArym objectAtIndex:2];
        NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:[d2 valueForKey:@"left"],@"left",wanfa,@"right", nil];
        [dataArym replaceObjectAtIndex:0 withObject:dict];
        [dataArym replaceObjectAtIndex:2 withObject:dict2];
        [myTableView reloadData];
    }
}
-(void)submitBtnAction:(UIButton *)button{
    Info *info = [Info getInstance];
    if (![info.userId intValue]) {
        [self toLogin];
        return;
    }
    
    isSubmit = YES;
    [self getSubmitNumber];//获取发布次数
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 10){
//        if(liyouSize.height < 15){
//            liyouSize.height = 15;
//        }
        return 4 + textContentSize;
    }
    if(indexPath.section == 5 && [_type isEqualToString:@"204"]){
        return 85;
    }
    return 35;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if([_type isEqualToString:@"-201"]){
        if(section == 6 || section == 7 || section == 8){
            return 0;
        }
    }
    else if([_type isEqualToString:@"201"]){
        if (section == 13) {
            return 0;
        }
    }
    else if([_type isEqualToString:@"204"]){
        if(section == 6 || section == 7 || section == 8 || section == 13){
            return 0;
        }
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArym.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 5 || indexPath.section == 8 || indexPath.section == 13){
        
        if(indexPath.section == 5 && [_type isEqualToString:@"204"]){
            NSString * cellID = @"BasketButtonInfoCell";
            ResultButtonTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[ResultButtonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }

            cell.buttonBlcok = ^(UIButton *button) {
                NSLog(@"%@  tag==%ld  %d",button.titleLabel.text,(long)button.tag,button.selected);
                if(button.tag == 10){
                    _lcLeftBtn = button.selected;
                }
                if(button.tag == 11){
                    _lcRightBtn = button.selected;
                }
            };
            
            NSDictionary *dict = [dataArym objectAtIndex:indexPath.section];
            [cell loadAppointInfo:dict];
            cell.leftBtn.selected = _lcLeftBtn;
            cell.rightBtn.selected = _lcRightBtn;
            return cell;
        }
        
        NSString * cellID = @"ButtonInfoCell";
        ExpertButtonInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ExpertButtonInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(indexPath.section == 13){
            cell.btnBGIma.hidden = YES;
            cell.switchBtn.hidden = NO;
            if([self.tuidan isEqualToString:@"1"]){
                cell.switchBtn.selected = YES;
            }else{
                cell.switchBtn.selected = NO;
            }
        }else{
            cell.btnBGIma.hidden = NO;
            cell.switchBtn.hidden = YES;
        }
        cell.buttonBlcok = ^(UIButton *button) {
            NSLog(@"%@  tag==%ld  %d",button.titleLabel.text,(long)button.tag,button.selected);
            if(indexPath.section == 5){
                [shengpingfuArym replaceObjectAtIndex:button.tag-10 withObject:[NSString stringWithFormat:@"%d",button.selected]];
            }else if(indexPath.section == 8){
                [shengpingfuArym replaceObjectAtIndex:button.tag-7 withObject:[NSString stringWithFormat:@"%d",button.selected]];
            }else{
                if(button.selected){
                    self.tuidan = @"1";
                }else{
                    self.tuidan = @"0";
                }
            }
        };
        NSArray *seletArray = [NSArray array];
        if(indexPath.section == 5){
            seletArray = [shengpingfuArym subarrayWithRange:NSMakeRange(0, 3)];
        }
        else if(indexPath.section == 8){
            seletArray = [shengpingfuArym subarrayWithRange:NSMakeRange(3, 3)];
        }
        NSDictionary *dict = [dataArym objectAtIndex:indexPath.section];
        [cell loadAppointInfo:dict WithSeletArray:seletArray];
        return cell;
    }else if (indexPath.section == 9 || indexPath.section == 10){
        NSString * cellID = @"InputInfoCell";
        ExpertInputInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ExpertInputInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSDictionary *dict = [dataArym objectAtIndex:indexPath.section];
        cell.textDidEndEditing = ^(NSString *message) {
            NSLog(@"message  %@",message);
            NSDictionary *dict = [dataArym objectAtIndex:indexPath.section];
            NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:[dict valueForKey:@"left"],@"left",message,@"right", nil];
            [dataArym replaceObjectAtIndex:indexPath.section withObject:dict1];
            [myTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        };
        
        [cell loadAppointInfo:dict];
        if(indexPath.section == 9){
            cell.mesText.placeholder = @"请输入标题20字以内";
            cell.mesText.hidden = NO;
            cell.lineIma.hidden = NO;
        }else if (indexPath.section == 10){
//            cell.mesText.placeholder = @"输入推荐理由100~1200字";
//            cell.lineIma.frame = CGRectMake(0, textContentSize + 3.5, self.mainView.frame.size.width, 0.5);
            cell.lineIma.hidden = YES;
            cell.mesText.hidden = YES;
        }
        
        return cell;
    }else{
        NSString * cellID = @"SelectInfoCell";
        ExpertSelectInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ExpertSelectInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSDictionary *dict = [dataArym objectAtIndex:indexPath.section];
        [cell loadAppointInfo:dict];
        return cell;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if([_type isEqualToString:@"201"]){
        if(section == 3 || section == 6){
            UIView *view = [[UIView alloc]init];
            view.frame = CGRectMake(0, 0, 320, 25);
            view.backgroundColor = [UIColor clearColor];
            
            UIImageView *ima = [[UIImageView alloc]init];
            ima.frame = CGRectMake(0, 0, 2, 25);
            ima.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
            [view addSubview:ima];
            
            UILabel *lab = [[UILabel alloc]init];
            lab.frame = CGRectMake(15, 0, 100, 25);
            lab.backgroundColor = [UIColor clearColor];
            lab.text = @"第一场比赛";
            if(section == 6){
                lab.text = @"第二场比赛";
            }
            lab.font = [UIFont systemFontOfSize:11];
            lab.textColor = BLACK_SEVENTY;
            [view addSubview:lab];
            
            return view;
        }
        return nil;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 3 || section == 6 || section == 9 || section == 11 || section == 13){
        if(section == 3 || section == 6){
            if([_type isEqualToString:@"201"]){
                return 25;
            }else if(section == 3){
                return 10;
            }else{
                return 0;
            }
        }else{
            if(section == 13 && ([_type isEqualToString:@"201"] || [_type isEqualToString:@"204"])){
                return 0;
            }
            return 10;
        }
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
    if(!picker){
        picker=[[V1PickerView alloc] initWithFrame:CGRectMake(0, MyHight, MyWidth, 260)];
        picker.delegate=self;
        picker.pickerView.dataSource = self;
        picker.pickerView.delegate = self;
        [self.view addSubview:picker];
    }
    __block ExpertSubmitViewController * newSelf = self;
    if(indexPath.section == 0){
        
        [pickerViewDataArym removeAllObjects];
        
        if(mayJingcai && mayErchuanyi && mayLancai){
            [pickerViewDataArym addObject:@"竞足"];
            [pickerViewDataArym addObject:@"2串1"];
            [pickerViewDataArym addObject:@"篮彩"];
        }else if (!mayJingcai && mayErchuanyi && mayLancai){
            [pickerViewDataArym addObject:@"2串1"];
            [pickerViewDataArym addObject:@"篮彩"];
        }else if (mayJingcai && !mayErchuanyi && mayLancai){
            [pickerViewDataArym addObject:@"竞足"];
            [pickerViewDataArym addObject:@"篮彩"];
        }else if (mayJingcai && mayErchuanyi && !mayLancai){
            [pickerViewDataArym addObject:@"竞足"];
            [pickerViewDataArym addObject:@"2串1"];
        }else if (!mayJingcai && !mayErchuanyi && mayLancai){
            [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"您已超过竞足和2串1发布次数"]];
            return;
        }else if (!mayJingcai && mayErchuanyi &&! mayLancai){
            [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"您已超过竞足和篮彩发布次数"]];
            return;
        }else if (mayJingcai && !mayErchuanyi && !mayLancai){
            [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"您已超过2串1和篮彩发布次数"]];
            return;
        }
        
//        if(!mayErchuanyi && mayJingcai){//能发竞足
//            [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"您已超过2串1发布次数"]];
//            return;
//        }else if (mayErchuanyi && !mayJingcai){//能发2串1
//            [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"您已超过竞足发布次数"]];
//            return;
//        }
        
        [picker.pickerView reloadAllComponents];
        picker.frame = CGRectMake(0, MyHight-260, MyWidth, 260);
        picker.selectedWithSure = ^(NSString *message) {
            NSLog(@"message  %@",message);
            NSString *str = [pickerViewDataArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]];
            NSDictionary *dict = [dataArym objectAtIndex:indexPath.section];
            
            if([[dict valueForKey:@"right"] length] > 0){
                if(([[dict valueForKey:@"right"] isEqualToString:@"篮彩"] && ![str isEqualToString:@"篮彩"]) || (![[dict valueForKey:@"right"] isEqualToString:@"篮彩"] && [str isEqualToString:@"篮彩"])){
                    [newSelf reloadCollectionWithInfo:@"" section:indexPath.section+1];//时间
                    if([str isEqualToString:@"篮彩"]){
                        [newSelf reloadCollectionWithInfo:@"大小分" section:indexPath.section+2];//玩法
                        [newSelf reloadCellbuttonWithPeilv:@"daxiaoqiu" section:indexPath.section+5];//赔率
                    }else{
                        [newSelf reloadCollectionWithInfo:@"胜平负" section:indexPath.section+2];//玩法
                        [newSelf reloadCellbuttonWithPeilv:@"" section:indexPath.section+5];//赔率
                    }
                    [newSelf reloadCollectionWithInfo:@"" section:indexPath.section+3];//赛事
                    [newSelf reloadCollectionWithInfo:@"" section:indexPath.section+4];//赛程
//                    [newSelf reloadCellbuttonWithPeilv:@"" section:indexPath.section + 5];//赛果
                }
            }
            
            NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:[dict valueForKey:@"left"],@"left",str,@"right", nil];
            [dataArym replaceObjectAtIndex:indexPath.section withObject:dict1];
//            [myTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            
            if([str isEqualToString:@"2串1"]){
                _type = @"201";
            }else if ([str isEqualToString:@"篮彩"]){
                _type = @"204";
            }else{
                _type = @"-201";
            }
            UILabel *lab = [footerView viewWithTag:123];
            lab.hidden = YES;
            mesTextView.frame = CGRectMake(67, 35*7+20+2, 235, textContentSize);
            if([_type isEqualToString:@"201"]){
                lab.hidden = NO;
                footerView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, 90);
                mesTextView.frame = CGRectMake(67, 35*10+60+2, 235, textContentSize);
            }else if ([_type isEqualToString:@"204"]){
                mesTextView.frame = CGRectMake(67, 35*7+70+2, 235, textContentSize);
            }
            myTableView.tableFooterView = footerView;
            [self requestLeagueList:@""];
            [self requestPriceList];//获取价格
            [myTableView reloadData];
        };
        
    }else if (indexPath.section == 1){//时间
        [pickerViewDataArym removeAllObjects];
        [pickerViewDataArym addObjectsFromArray:leagueTimeArym];
        [picker.pickerView reloadAllComponents];
        [picker.pickerView selectRow:0 inComponent:0 animated:NO];
        picker.frame = CGRectMake(0, MyHight-260, MyWidth, 260);
        picker.selectedWithSure = ^(NSString *message) {
            NSLog(@"message  %@",message);
            if(pickerViewDataArym.count == 0){
                return ;
            }
            NSString *str = [pickerViewDataArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]];
            
            [leagueTypeArym removeAllObjects];
            [leagueTypeArym addObjectsFromArray:[leagueTypeDict valueForKey:str]];
            
            NSDictionary *d = [dataArym objectAtIndex:indexPath.section];//第一场时间
            if(![[d valueForKey:@"right"] isEqualToString:str]){
                
                [newSelf reloadCollectionWithInfo:str section:indexPath.section];//时间
//                [newSelf reloadCollectionWithInfo:@"" section:indexPath.section+1];//玩法  选择时间  不需要重置玩法
                
                NSDictionary *d2 = [dataArym objectAtIndex:indexPath.section+2];
                if([[d2 valueForKey:@"right"] length] > 0){
                    BOOL asd = NO;
                    for(NSDictionary *dd in leagueTypeArym){
                        NSString *str = [dd valueForKey:@"NAME"];
                        if([str isEqualToString:[d2 valueForKey:@"right"]]){
                            asd = YES;
                            break;
                        }
                    }
                    if(!asd){
                        [newSelf reloadCollectionWithInfo:@"" section:indexPath.section+2];//赛事
                        [newSelf reloadCollectionWithInfo:@"" section:indexPath.section+3];//赛程
                        [newSelf reloadCellbuttonWithPeilv:@"" section:indexPath.section + 4];//赔率
                        [matchArym1 removeAllObjects];
                    }
                }
                //第二场
                NSDictionary *d5 = [dataArym objectAtIndex:indexPath.section+5];
                if([[d5 valueForKey:@"right"] length] > 0){
                    BOOL asd = NO;
                    for(NSDictionary *dd in leagueTypeArym){
                        NSString *str = [dd valueForKey:@"NAME"];
                        if([str isEqualToString:[d2 valueForKey:@"right"]]){
                            asd = YES;
                            break;
                        }
                    }
                    if(!asd){
                        [newSelf reloadCollectionWithInfo:@"" section:indexPath.section+5];//赛事
                        [newSelf reloadCollectionWithInfo:@"" section:indexPath.section+6];//赛程
                        [newSelf reloadCellbuttonWithPeilv:@"" section:indexPath.section + 7];//赔率
                        [matchArym2 removeAllObjects];
                    }
                }
            }
        };
    }else if (indexPath.section == 2){//玩法
        
        NSDictionary *dict = [dataArym objectAtIndex:indexPath.section + 2];//看选没选比赛
//        if(![[dict valueForKey:@"right"] length]){
//            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择比赛"];
//            return;
//        }
        
        [pickerViewDataArym removeAllObjects];
        
        if([_type isEqualToString:@"204"]){
            if([[dict valueForKey:@"right"] length] > 0 && matchArym1.count > 0){
                NSInteger shengpingfu = [[[matchArym1 objectAtIndex:0] valueForKey:@"daxiao_fen"] integerValue];//是否支持大小分
                if(shengpingfu == 1){
                    [pickerViewDataArym addObject:@"大小分"];
                }
                NSInteger shengpingfu1 = [[[matchArym1 objectAtIndex:0] valueForKey:@"rangfen_sf"] integerValue];//是否支持让分胜负
                if(shengpingfu1 == 1){
                    [pickerViewDataArym addObject:@"让分胜负"];
                }
            }else{
                [pickerViewDataArym addObject:@"大小分"];
                [pickerViewDataArym addObject:@"让分胜负"];
            }
        }else{
            if([[dict valueForKey:@"right"] length] > 0 && matchArym1.count > 0){
                NSInteger shengpingfu = [[[matchArym1 objectAtIndex:0] valueForKey:@"sheng_PING_FU"] integerValue];//是否支持胜平负
                if(shengpingfu == 1){
                    [pickerViewDataArym addObject:@"胜平负"];
                }
                [pickerViewDataArym addObject:[NSString stringWithFormat:@"让球胜平负(%@)",[[matchArym1 objectAtIndex:0] valueForKey:@"rq"]]];
            }else{
                [pickerViewDataArym addObject:@"胜平负"];
                [pickerViewDataArym addObject:@"让球胜平负"];
            }
        }
        [picker.pickerView reloadAllComponents];
        picker.frame = CGRectMake(0, MyHight-260, MyWidth, 260);
        picker.selectedWithSure = ^(NSString *message) {
            NSLog(@"message  %@",message);
            if(pickerViewDataArym.count == 0){
                return ;
            }
            NSString *str = [pickerViewDataArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]];
            NSDictionary *dict = [dataArym objectAtIndex:indexPath.section];
            
            if(![[dict valueForKey:@"right"] isEqualToString:str]){
                [newSelf reloadCollectionWithInfo:str section:indexPath.section];//玩法
                if([_type isEqualToString:@"204"]){
                    if([str isEqualToString:@"大小分"]){
                        [newSelf reloadCellbuttonWithPeilv:@"daxiaoqiu" section:indexPath.section+3];//赔率
                    }else{
                        [newSelf reloadCellbuttonWithPeilv:@"rangqiu" section:indexPath.section+3];//赔率
                    }
                }
                if(matchArym1.count > 0){
                    if([_type isEqualToString:@"204"]){
                        //改变赔率
                        NSInteger daxiao = [[[matchArym1 objectAtIndex:0] valueForKey:@"daxiao_fen"] integerValue];//是否支持大小分
                        if(daxiao == 0 && [str isEqualToString:@"大小分"]){//如果选择大小分  并且当前比赛不支持大小分--正常不会走，因为如果选择好比赛就会知道是否支持大小分
                            [newSelf reloadCollectionWithInfo:@"" section:indexPath.section+2];//赛程
                            [newSelf reloadCellbuttonWithPeilv:@"daxiaoqiu" section:indexPath.section+3];//赔率
                            [matchArym1 removeAllObjects];
                        }
                        NSInteger rangfen = [[[matchArym1 objectAtIndex:0] valueForKey:@"rangfen_sf"] integerValue];//是否支持让分胜负
                        if(rangfen == 0 && [str isEqualToString:@"让分胜负"]){//如果选择让分胜负  并且当前比赛不支持让分胜负--正常不会走，因为如果选择好比赛就会知道是否支持大小分
                            [newSelf reloadCollectionWithInfo:@"" section:indexPath.section+2];//赛程
                            [newSelf reloadCellbuttonWithPeilv:@"rangqiu" section:indexPath.section+3];//赔率
                            [matchArym1 removeAllObjects];
                        }
                        else{
                            NSString *peilv = @"";
                            if([str isEqualToString:@"大小分"]){
                                peilv = [[matchArym1 objectAtIndex:0] valueForKey:@"daxiao_sp"];
                                peilv = [NSString stringWithFormat:@"%@ %@ daxiaoqiu",peilv,[[matchArym1 objectAtIndex:0] valueForKey:@"daxiao_comityball"]];
                            }else{
                                peilv = [[matchArym1 objectAtIndex:0] valueForKey:@"rangfen_sp"];
                                peilv = [NSString stringWithFormat:@"%@ %@ rangqiu",peilv,[[matchArym1 objectAtIndex:0] valueForKey:@"rangfen_comityball"]];
                            }
                            [newSelf reloadCellbuttonWithPeilv:peilv section:indexPath.section+3];
                        }
                    }else{
                        //改变赔率
                        NSInteger shengpingfu = [[[matchArym1 objectAtIndex:0] valueForKey:@"sheng_PING_FU"] integerValue];//是否支持胜平负
                        if(shengpingfu == 0 && [str isEqualToString:@"胜平负"]){//如果选择胜平负  并且当前比赛不支持胜平负--正常不会走，因为如果选择好比赛就会知道是否支持胜平负
                            [newSelf reloadCollectionWithInfo:@"" section:indexPath.section+2];//赛程
                            [newSelf reloadCellbuttonWithPeilv:@"" section:indexPath.section+3];//赔率
                            [matchArym1 removeAllObjects];
                        }else{
                            NSString *peilv = @"";
                            if([str isEqualToString:@"胜平负"]){
                                peilv = [[matchArym1 objectAtIndex:0] valueForKey:@"spf_SP"];
                            }else{
                                peilv = [[matchArym1 objectAtIndex:0] valueForKey:@"rang_QIU_SP"];
                            }
                            [newSelf reloadCellbuttonWithPeilv:peilv section:indexPath.section+3];
                        }
                    }
                }
            }
            if([_type isEqualToString:@"201"]){
                if(matchArym2.count > 0){
                    //改变赔率
                    NSInteger shengpingfu = [[[matchArym2 objectAtIndex:0] valueForKey:@"sheng_PING_FU"] integerValue];//是否支持胜平负
                    if(shengpingfu == 0 && [str isEqualToString:@"胜平负"]){//如果选择胜平负  并且当前比赛不支持胜平负--正常不会走，因为如果选择好比赛就会知道是否支持胜平负
                        [newSelf reloadCollectionWithInfo:@"" section:indexPath.section+5];//赛程
                        [newSelf reloadCellbuttonWithPeilv:@"" section:indexPath.section+6];//赔率
                        [matchArym2 removeAllObjects];
                    }else{
                        NSString *peilv = @"";
                        if([str isEqualToString:@"胜平负"]){
                            peilv = [[matchArym2 objectAtIndex:0] valueForKey:@"spf_SP"];
                        }else{
                            peilv = [[matchArym2 objectAtIndex:0] valueForKey:@"rang_QIU_SP"];
                        }
                        [newSelf reloadCellbuttonWithPeilv:peilv section:indexPath.section+6];
                    }
                }
            }
        };
    }else if (indexPath.section == 3 || indexPath.section == 6){//赛事
        NSDictionary *dict = [dataArym objectAtIndex:1];
        if(![[dict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择时间"];
            return;
        }
        
        [pickerViewDataArym removeAllObjects];
        for(NSDictionary *dict in leagueTypeArym){
            [pickerViewDataArym addObject:[dict valueForKey:@"NAME"]];
        }
        
        [picker.pickerView reloadAllComponents];
        picker.frame = CGRectMake(0, MyHight-260, MyWidth, 260);
        picker.selectedWithSure = ^(NSString *message) {
            NSLog(@"message  %@",message);
            if(pickerViewDataArym.count == 0){
                return ;
            }
            NSString *str = [pickerViewDataArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]];
            NSDictionary *d = [dataArym objectAtIndex:indexPath.section];//
            if(![[d valueForKey:@"right"] isEqualToString:str]){
                
                [newSelf reloadCollectionWithInfo:str section:indexPath.section];//赛事
                [newSelf reloadCollectionWithInfo:@"" section:indexPath.section+1];//赛程
                [newSelf reloadCellbuttonWithPeilv:@"" section:indexPath.section + 2];//赔率
                
//                [newSelf reloadCollectionWithInfo:@"" section:2];//玩法
                
                
                NSDictionary *dd = [dataArym objectAtIndex:1];
                if(leagueTypeArym.count == 0){
                    return;
                }
                NSString *raceID = [[leagueTypeArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]] valueForKey:@"ID"];
                
                [newSelf requestMatchListWithData:[dd valueForKey:@"right"] leagueId:raceID section:indexPath.section];
                
            }
        };
    }else if (indexPath.section == 4 || indexPath.section == 7){//比赛
        NSDictionary *dict = [dataArym objectAtIndex:indexPath.section - 1];
        if(![[dict valueForKey:@"right"] length]){
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择赛事"];
            return;
        }
        if((!allMatchArym1.count && indexPath.section == 4) || (!allMatchArym2.count && indexPath.section == 7)){
            return;
        }
        [pickerViewDataArym removeAllObjects];
        NSMutableArray *newMatchArym = [[NSMutableArray alloc]initWithCapacity:0];
        NSDictionary *wanfa = [dataArym objectAtIndex:2];
        if(indexPath.section == 4){
            if([_type isEqualToString:@"204"]){
                if([[wanfa valueForKey:@"right"] isEqualToString:@"大小分"]){
                    for(NSDictionary *dict in allMatchArym1){
                        NSInteger shengpingfu = [[dict valueForKey:@"daxiao_fen"] integerValue];//是否支持大小分
                        if(shengpingfu == 1){
                            NSString *raceName = [NSString stringWithFormat:@"%@ %@VS%@",[dict valueForKey:@"cc_ID"],[dict valueForKey:@"guest_NAME_SIMPLY"],[dict valueForKey:@"host_NAME_SIMPLY"]];
                            [pickerViewDataArym addObject:raceName];
                            [newMatchArym addObject:dict];
                        }
                    }
                }else{
                    for(NSDictionary *dict in allMatchArym1){
                        NSInteger shengpingfu = [[dict valueForKey:@"rangfen_sf"] integerValue];//是否支持让分胜负
                        if(shengpingfu == 1){
                            NSString *raceName = [NSString stringWithFormat:@"%@ %@VS%@",[dict valueForKey:@"cc_ID"],[dict valueForKey:@"guest_NAME_SIMPLY"],[dict valueForKey:@"host_NAME_SIMPLY"]];
                            [pickerViewDataArym addObject:raceName];
                            [newMatchArym addObject:dict];
                        }
                    }
                }
            }else{
                if([[wanfa valueForKey:@"right"] isEqualToString:@"胜平负"]){
                    for(NSDictionary *dict in allMatchArym1){
                        NSInteger shengpingfu = [[dict valueForKey:@"sheng_PING_FU"] integerValue];//是否支持胜平负
                        if(shengpingfu == 1){
                            NSString *raceName = [NSString stringWithFormat:@"%@ %@VS%@",[dict valueForKey:@"cc_ID"],[dict valueForKey:@"host_NAME_SIMPLY"],[dict valueForKey:@"guest_NAME_SIMPLY"]];
                            [pickerViewDataArym addObject:raceName];
                            [newMatchArym addObject:dict];
                        }
                    }
                }else{
                    for(NSDictionary *dict in allMatchArym1){
                        NSString *raceName = [NSString stringWithFormat:@"%@ %@VS%@",[dict valueForKey:@"cc_ID"],[dict valueForKey:@"host_NAME_SIMPLY"],[dict valueForKey:@"guest_NAME_SIMPLY"]];
                        [pickerViewDataArym addObject:raceName];
                        [newMatchArym addObject:dict];
                    }
                }
            }
        }else if (indexPath.section == 7){
            if([[wanfa valueForKey:@"right"] isEqualToString:@"胜平负"]){
                for(NSDictionary *dict in allMatchArym2){
                    NSInteger shengpingfu = [[dict valueForKey:@"sheng_PING_FU"] integerValue];//是否支持胜平负
                    if(shengpingfu == 1){
                        NSString *raceName = [NSString stringWithFormat:@"%@ %@VS%@",[dict valueForKey:@"cc_ID"],[dict valueForKey:@"host_NAME_SIMPLY"],[dict valueForKey:@"guest_NAME_SIMPLY"]];
                        [pickerViewDataArym addObject:raceName];
                        [newMatchArym addObject:dict];
                    }
                }
            }else{
                for(NSDictionary *dict in allMatchArym2){
                    NSString *raceName = [NSString stringWithFormat:@"%@ %@VS%@",[dict valueForKey:@"cc_ID"],[dict valueForKey:@"host_NAME_SIMPLY"],[dict valueForKey:@"guest_NAME_SIMPLY"]];
                    [pickerViewDataArym addObject:raceName];
                    [newMatchArym addObject:dict];
                }
            }
//            for(NSDictionary *dict in allMatchArym2){
//                NSString *raceName = [NSString stringWithFormat:@"%@ %@VS%@",[dict valueForKey:@"cc_ID"],[dict valueForKey:@"host_NAME_SIMPLY"],[dict valueForKey:@"guest_NAME_SIMPLY"]];
//                [pickerViewDataArym addObject:raceName];
//            }
        }
        [picker.pickerView reloadAllComponents];
        picker.frame = CGRectMake(0, MyHight-260, MyWidth, 260);
        picker.selectedWithSure = ^(NSString *message) {
            NSLog(@"message  %@",message);
            if(pickerViewDataArym.count == 0){
                return ;
            }
            NSString *str = [pickerViewDataArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]];
            NSDictionary *dict = [dataArym objectAtIndex:indexPath.section];
            
            if(![[dict valueForKey:@"right"] isEqualToString:str]){
                if(newMatchArym.count == 0){
                    return;
                }
                [newSelf reloadCollectionWithInfo:str section:indexPath.section];//赛程
                
                NSDictionary *wanfa = [dataArym objectAtIndex:2];
                NSString *peilv = @"";
                if([_type isEqualToString:@"204"]){
                    if([[wanfa valueForKey:@"right"] isEqualToString:@"大小分"]){
                        peilv = [[newMatchArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]] valueForKey:@"daxiao_sp"];
                        peilv = [NSString stringWithFormat:@"%@ %@ daxiaoqiu",peilv,[[newMatchArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]] valueForKey:@"daxiao_comityball"]];
                    }else if ([[wanfa valueForKey:@"right"] isEqualToString:@"让分胜负"]){//让分胜负
                        peilv = [[newMatchArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]] valueForKey:@"rangfen_sp"];
                        peilv = [NSString stringWithFormat:@"%@ %@ rangqiu",peilv,[[newMatchArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]] valueForKey:@"rangfen_comityball"]];
                    }
                }else{
                    if([[wanfa valueForKey:@"right"] isEqualToString:@"胜平负"]){
                        peilv = [[newMatchArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]] valueForKey:@"spf_SP"];
                    }else if ([[wanfa valueForKey:@"right"] length] > 0){//让球胜平负
                        peilv = [[newMatchArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]] valueForKey:@"rang_QIU_SP"];
                        NSString *rangqiushu = [[newMatchArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]] valueForKey:@"rq"];
                        [newSelf reloadCollectionWithInfo:[NSString stringWithFormat:@"让球胜平负(%@)",rangqiushu] section:2];//玩法
                    }
                }
                
                [newSelf reloadCellbuttonWithPeilv:peilv section:indexPath.section+1];
                
                if(indexPath.section == 4){
                    [matchArym1 removeAllObjects];
                    [matchArym1 addObject:[newMatchArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]]];
                }else{
                    [matchArym2 removeAllObjects];
                    [matchArym2 addObject:[newMatchArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]]];
                }
            }
        };
    }else if (indexPath.section == 11){//价格
        
        [pickerViewDataArym removeAllObjects];
        for(NSDictionary *dict in priceArym){
            [pickerViewDataArym addObject:[NSString stringWithFormat:@"￥%@",[dict valueForKey:@"priceName"]]];
        }
        [picker.pickerView reloadAllComponents];
        picker.frame = CGRectMake(0, MyHight-260, MyWidth, 260);
        picker.selectedWithSure = ^(NSString *message) {
            NSLog(@"message  %@",message);
            if(pickerViewDataArym.count == 0 || priceArym.count == 0){
                return ;
            }
            NSString *str = [pickerViewDataArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]];
            NSDictionary *dict = [dataArym objectAtIndex:indexPath.section];
            
            if(![[dict valueForKey:@"right"] isEqualToString:str]){
                [self reloadCollectionWithInfo:str section:indexPath.section];
                NSDictionary *d1 = [priceArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]];
                self.price = [d1 valueForKey:@"price"];
            }
        };
    }else if (indexPath.section == 12){//折扣价格
        
        [pickerViewDataArym removeAllObjects];
        for(NSDictionary *dict in discountPriceArym){
            [pickerViewDataArym addObject:[dict valueForKey:@"discountName"]];
        }
        [picker.pickerView reloadAllComponents];
        picker.frame = CGRectMake(0, MyHight-260, MyWidth, 260);
        picker.selectedWithSure = ^(NSString *message) {
            NSLog(@"message  %@",message);
            if(pickerViewDataArym.count == 0 || discountPriceArym.count == 0){
                return ;
            }
            NSString *str = [pickerViewDataArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]];
            NSDictionary *dict = [dataArym objectAtIndex:indexPath.section];
            
            if(![[dict valueForKey:@"right"] isEqualToString:str]){
                [self reloadCollectionWithInfo:str section:indexPath.section];
                NSDictionary *d1 = [discountPriceArym objectAtIndex:[picker.pickerView selectedRowInComponent:0]];
                self.discountPrice = [d1 valueForKey:@"discountCoeff"];
            }
        };
    }
}
#pragma mark -------------UIPickerViewDelegate--------------------
-(void)sure:(id)sender
{
    [UIView animateWithDuration:0.1 animations:^{
        [picker setFrame:CGRectMake(0, picker.frame.origin.y+picker.frame.size.height, picker.frame.size.width, 0)];
//        [picker removeFromSuperview];
    }];
}
-(void)cancle:(id)sender
{
//    picker.pickerView.hidden = YES;
    [UIView animateWithDuration:0.1 animations:^{
        [picker setFrame:CGRectMake(0, picker.frame.origin.y+picker.frame.size.height, picker.frame.size.width, 0)];
        //        [picker removeFromSuperview];
    }];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [pickerViewDataArym objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return pickerViewDataArym.count;
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)reloadCollectionWithInfo:(NSString *)info section:(NSInteger)section{
    
    NSDictionary *d = [dataArym objectAtIndex:section];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[d valueForKey:@"left"],@"left",info,@"right", nil];
    [dataArym replaceObjectAtIndex:section withObject:dict];
    [myTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)reloadCellbuttonWithPeilv:(NSString *)peilv section:(NSInteger)section{
    
//    NSArray *ary;
//    if(peilv.length){
//        ary = [peilv componentsSeparatedByString:@" "];
//    }else{
//        ary = [NSArray arrayWithObjects:@"",@"",@"", nil];
//    }
//    ExpertButtonInfoTableViewCell *cell = [myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
//    [cell.leftBtn setTitle:[NSString stringWithFormat:@"胜%@",[ary objectAtIndex:0]] forState:UIControlStateNormal];
//    [cell.middleBtn setTitle:[NSString stringWithFormat:@"平%@",[ary objectAtIndex:1]] forState:UIControlStateNormal];
//    [cell.rightBtn setTitle:[NSString stringWithFormat:@"负%@",[ary objectAtIndex:2]] forState:UIControlStateNormal];
//    cell.leftBtn.selected = NO;
//    cell.middleBtn.selected = NO;
//    cell.rightBtn.selected = NO;
    if(section < 5){
        for(NSInteger i=0;i<3;i++){
            [shengpingfuArym replaceObjectAtIndex:i withObject:@"0"];
        }
    }else{
        for(NSInteger i=3;i<6;i++){
            [shengpingfuArym replaceObjectAtIndex:i withObject:@"0"];
        }
    }
    
    _lcLeftBtn = NO;
    _lcRightBtn = NO;
    
    NSDictionary *d = [dataArym objectAtIndex:section];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[d valueForKey:@"left"],@"left",peilv,@"right", nil];
    [dataArym replaceObjectAtIndex:section withObject:dict];
    
    [myTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag == 123123){
        
        if(buttonIndex == 0){
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self clearInfo];
        }
    }
}
-(void)clearInfo{
    
    _lcLeftBtn = NO;
    _lcRightBtn = NO;
    placeholderLab.hidden = NO;
    mesTextView.text = @"";
    self.tuidan = @"0";
    [dataArym removeAllObjects];
    [pickerViewDataArym removeAllObjects];
    [leagueTypeArym removeAllObjects];
    [leagueTimeArym removeAllObjects];
    [leagueTypeDict removeAllObjects];
    [allMatchArym1 removeAllObjects];
    [allMatchArym2 removeAllObjects];
    [matchArym1 removeAllObjects];
    [matchArym2 removeAllObjects];
    [discountPriceArym removeAllObjects];
    [shengpingfuArym removeAllObjects];
    
    for(NSInteger i=0;i<6;i++){
        [shengpingfuArym addObject:@"0"];
    }
    
    _matchdetailMdl = nil;
    [self createInfoData];
    
    UILabel *lab = [footerView viewWithTag:123];
    lab.hidden = YES;
    mesTextView.frame = CGRectMake(67, 35*7+20+2, 235, textContentSize);
    if([_type isEqualToString:@"201"]){
        lab.hidden = NO;
        footerView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, 90);
        mesTextView.frame = CGRectMake(67, 35*10+60+2, 235, textContentSize);
    }else if ([_type isEqualToString:@"204"]){
        mesTextView.frame = CGRectMake(67, 35*7+70+2, 235, textContentSize);
    }
    myTableView.tableFooterView = footerView;
    
    [self requestLeagueList:@""];
    [self requestPriceList];//获取价格
    [self requestDiscountList];//折扣价格
    
    [myTableView reloadData];
}
-(void)toLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
//    if ([textView.text length] == 0) {
//        [textView scrollRectToVisible:CGRectMake(0, 5, 320, 0) animated:NO];
//    }
}
-(void)textViewDidChange:(UITextView *)textView{
    
    if([textView.text isEqualToString:@""]){
        placeholderLab.hidden = NO;
    }else{
        placeholderLab.hidden = YES;
    }
    
    textContentSize = textView.contentSize.height;
    mesTextView.frame = CGRectMake(67, 35*7+20+2, 235, textContentSize);
    if([_type isEqualToString:@"201"]){
        mesTextView.frame = CGRectMake(67, 35*10+60+2, 235, textContentSize);
    }else if ([_type isEqualToString:@"204"]){
        mesTextView.frame = CGRectMake(67, 35*7+70+2, 235, textContentSize);
    }
    
    [myTableView reloadSections:[NSIndexSet indexSetWithIndex:10] withRowAnimation:UITableViewRowAnimationNone];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    return YES;
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