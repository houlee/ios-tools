//
//  ExpertHomeViewController.m
//  caibo
//
//  Created by GongHe on 16/8/10.
//
//

#import "ExpertHomeViewController.h"
#import "ExpertHomeTableViewCell.h"
#import "ExpertHomeCollectionViewCell.h"
#import "SharedMethod.h"
#import "SearchVC.h"
#import "ExpertJingjiModel.h"
#import "NSString+ExpertStrings.h"
#import "SMGDetailViewController.h"
#import "ExpertHomeModuleData.h"
#import "CommonProblemViewController.h"
#import "ShenDanDetailViewController.h"
#import "LoginViewController.h"
#import "caiboAppDelegate.h"

@interface ExpertHomeViewController ()

@property(nonatomic, assign) BOOL isSdOrNo;

@end

@implementation ExpertHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navView.hidden = YES;
    self.isSdOrNo=YES;

    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MyWidth, MyHight - 49)];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.backgroundColor = DEFAULT_BACKGROUNDCOLOR;
    
    _mainTableViewHeader = [[UIView alloc] init];
    
    [self creatScrollView];
    
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(_lunBoScrollView) - 64, MyWidth, 64)];
    _navView.backgroundColor = [UIColor colorWithRed:0/255.0 green:138/255.0 blue:212/255.0 alpha:0];
    [self.view addSubview:_navView];
    _navView.userInteractionEnabled = NO;
    
    _searchButton = [[UIButton alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(_navView) - 5 - 30, MyWidth - 30, 30)];
    _searchButton.layer.masksToBounds = YES;
    _searchButton.layer.cornerRadius = 4;
    [self.view addSubview:_searchButton];
    [_searchButton addTarget:self action:@selector(toSearch) forControlEvents:UIControlEventTouchUpInside];
    _searchButton.backgroundColor = [UIColor whiteColor];
    
    UILabel * searchLabel = [[UILabel alloc] init];
    searchLabel.text = @"搜索专家";
    searchLabel.font = [UIFont systemFontOfSize:12];
    searchLabel.textColor = DEFAULT_TEXTGRAYCOLOR;
    [_searchButton addSubview:searchLabel];
    searchLabel.backgroundColor = [UIColor clearColor];
    
    CGSize searchSize = [SharedMethod getSizeByText:searchLabel.text font:searchLabel.font constrainedToSize:CGSizeMake(_searchButton.frame.size.width, _searchButton.frame.size.height) lineBreakMode:0];
    
    searchLabel.frame = CGRectMake(12.5 + 5 + (_searchButton.frame.size.width - 12.5 - 5 - searchSize.width)/2.0, 0, searchSize.width, _searchButton.frame.size.height);
    
    UIImageView * searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(searchLabel.frame.origin.x - 5 - 12.5, (_searchButton.frame.size.height - 13.5)/2.0, 12.5, 13.5)];
    searchImageView.image = [UIImage imageNamed:@"GodPlan_Search.png"];
    [_searchButton addSubview:searchImageView];
    
    if (!_independentDGQ) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 20, 40, 40)];
        [_backButton setImage:[UIImage imageNamed:@"GodPlan_BackArrow.png"] forState:UIControlStateNormal];
        _backButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        _backButton.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_backButton];
        [_backButton addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _hornView = [[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(_lunBoScrollView), MyWidth, 30)];
    _hornView.backgroundColor = [UIColor whiteColor];
    _hornView.layer.masksToBounds = YES;
    [_mainTableViewHeader addSubview:_hornView];
    
    UIImageView * hornImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (_hornView.frame.size.height - 12)/2.0, 15, 12)];
    hornImageView.image = [UIImage imageNamed:@"OY_Horn.png"];
    [_hornView addSubview:hornImageView];
    
    _hornLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(hornImageView) + 5, 0, MyWidth - ORIGIN_X(hornImageView) - 5, _hornView.frame.size.height)];
    _hornLabel.backgroundColor = [UIColor clearColor];
    _hornLabel.font = [UIFont systemFontOfSize:11];
    _hornLabel.textColor = DEFAULT_TEXTGRAYCOLOR;
    [_hornView addSubview:_hornLabel];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //cell间距
    layout.minimumInteritemSpacing = 0;
    //cell行距
    layout.minimumLineSpacing = 0;
    
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(_hornView) + 6, MyWidth, 0) collectionViewLayout:layout];
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    [_mainTableViewHeader addSubview:_mainCollectionView];
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    [_mainCollectionView registerClass:[ExpertHomeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    _mainTableViewHeader.frame = CGRectMake(0, 0, MyWidth, ORIGIN_Y(_mainCollectionView) + 5);
    _mainTableView.tableHeaderView = _mainTableViewHeader;

    _sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MyWidth, 45)];
    _sectionHeaderView.backgroundColor = [UIColor whiteColor];

    NSArray * titleArray = @[@"竞彩",@"亚盘"];
    
    for (int i = 0; i < 2; i++) {
        UIButton * headerButton = [[UIButton alloc] initWithFrame:CGRectMake(i * 89, 0, 89, _sectionHeaderView.frame.size.height)];
        [headerButton setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [headerButton setTitleColor:[SharedMethod getColorByHexString:@"13a3ff"] forState:UIControlStateNormal];
        headerButton.titleLabel.font = [UIFont systemFontOfSize:15];
        headerButton.tag = 10 + i;
        [_sectionHeaderView addSubview:headerButton];
        [headerButton addTarget:self action:@selector(changeLotteryType:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView * blueLine = [[UIView alloc] initWithFrame:CGRectMake(15, headerButton.frame.size.height - 10, headerButton.frame.size.width - 30, 2)];
        blueLine.backgroundColor = [SharedMethod getColorByHexString:@"13a3ff"];
        blueLine.tag = 100 + i;
        [headerButton addSubview:blueLine];
        
        if (i) {
            blueLine.hidden = YES;
        }
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _sectionHeaderView.frame.size.height - 0.5, _sectionHeaderView.frame.size.width, 0.5)];
        lineView.backgroundColor = DEFAULT_LINECOLOR;
        [_sectionHeaderView addSubview:lineView];
    }
    
    UIImageView * filterArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_sectionHeaderView.frame.size.width - 15 - 9.5, (_sectionHeaderView.frame.size.height - 5.5)/2.0, 9.5, 5.5)];
    [_sectionHeaderView addSubview:filterArrowImageView];
    filterArrowImageView.image = [UIImage imageNamed:@"GodPlan_BlueArrow.png"];
    filterArrowImageView.tag = 1000;
    
    UIButton * filterButton = [[UIButton alloc] initWithFrame:CGRectMake(filterArrowImageView.frame.origin.x - 3 - 44 - 5, 0, 70, _sectionHeaderView.frame.size.height)];
    [filterButton setTitle:@"筛选" forState:UIControlStateNormal];
    [filterButton setTitleColor:[SharedMethod getColorByHexString:@"13a3ff"] forState:UIControlStateNormal];
    filterButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_sectionHeaderView addSubview:filterButton];
    filterButton.backgroundColor = [UIColor clearColor];
    filterButton.tag = 10000;
    [filterButton addTarget:self action:@selector(touchFilter:) forControlEvents:UIControlEventTouchUpInside];
    
    [self createFakeHeader];

    _moduleArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    __weak ExpertHomeViewController * newSelf = self;

    _superType = @"001";
    _lotteyType = @"-201";
    _jcCurrPage = 1;
    _ypCurrPage = 1;
    _orderFlag = @"0";
    _jcOrderFlag = @"0";
    _ypOrderFlag = @"0";
    
    _jcSuperArr = [[NSMutableArray alloc] initWithCapacity:10];
    _ypSuperArr = [[NSMutableArray alloc] initWithCapacity:10];
    
    [self getExpertHomeInfo];
    [self scrImgReData];

    [self supCurPage:@"1" superType:_superType lotryType:_lotteyType];
    
    _mainTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [newSelf scrImgReData];

        [newSelf getExpertHomeInfo];
        [newSelf supCurPage:@"1" superType:_superType lotryType:_lotteyType];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_mainTableView.header];
    
    _mainTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if ([newSelf.lotteyType isEqualToString:@"-201"]) {
            [newSelf supCurPage:[NSString stringWithFormat:@"%d",newSelf.jcCurrPage + 1] superType:_superType lotryType:_lotteyType];

        }else if ([newSelf.lotteyType isEqualToString:@"202"]) {
            [newSelf supCurPage:[NSString stringWithFormat:@"%d",newSelf.ypCurrPage + 1] superType:_superType lotryType:_lotteyType];
        }
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_mainTableView.footer];
}

-(void)getExpertHomeInfo
{
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"zjtjIndexService" forKey:@"serviceName"];
    [bodyDic setObject:@"getDgqCapmpInfo" forKey:@"methodName"];
    NSDictionary * parametersDic=@{@"type":@"1"};
    
    [bodyDic setObject:parametersDic forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON objectForKey:@"resultCode"] isEqualToString:@"0000"]) {
            
            [_moduleArray removeAllObjects];
            
            NSArray * resultArray = [responseJSON valueForKey:@"result"];
            for (int i = 0; i < resultArray.count; i++) {
                NSDictionary * resultDic = [resultArray objectAtIndex:i];
                if ([[resultDic valueForKey:@"code"] isEqualToString:@"1004"]) {
                    _hornLabel.text = [resultDic valueForKey:@"title"];
                    continue;
                }
                
                ExpertHomeModuleData * moduleData = [[ExpertHomeModuleData alloc] init];
                moduleData.title = [resultDic valueForKey:@"title"];
                moduleData.explain = [resultDic valueForKey:@"explain"];
                moduleData.imgUrl = [resultDic valueForKey:@"imgUrl"];
                moduleData.linkUrl = [resultDic valueForKey:@"linkUrl"];
                moduleData.code = [resultDic valueForKey:@"code"];
                if (moduleData.title && moduleData.title.length && [moduleData.title rangeOfString:@"("].location !=NSNotFound) {
                    
                    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:moduleData.title];
                    
                    [attributedString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:8]} range:NSMakeRange([moduleData.title rangeOfString:@"("].location, moduleData.title.length - [moduleData.title rangeOfString:@"("].location)];
                    moduleData.limitTitle = attributedString;
                }
                
                CGSize explainSize = [SharedMethod getSizeByText:moduleData.explain font:[UIFont systemFontOfSize:8] constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:0];
                moduleData.explainSize = explainSize;
                
                [_moduleArray addObject:moduleData];
            }
            
            self.moduleNumber = _moduleArray.count;
            
            if (_moduleArray.count%2) {
                ExpertHomeModuleData * moduleData = [[ExpertHomeModuleData alloc] init];
                [_moduleArray addObject:moduleData];
            }
            
            _mainCollectionView.frame = CGRectMake(_mainCollectionView.frame.origin.x, _mainCollectionView.frame.origin.y, _mainCollectionView.frame.size.width, _moduleArray.count/2 * 55);
            
            _mainTableViewHeader.frame = CGRectMake(0, 0, MyWidth, ORIGIN_Y(_mainCollectionView) + 5);
            _mainTableView.tableHeaderView = _mainTableViewHeader;
            
            _noReconView.frame = CGRectMake(0, _mainTableViewHeader.frame.size.height + _fakeHeader.frame.size.height, MyWidth, _mainTableView.frame.size.height - _mainTableViewHeader.frame.size.height - _fakeHeader.frame.size.height);
            
            [_mainCollectionView reloadData];
        }
        
    } failure:^(NSError * error) {

    }];
}

-(void)supCurPage:(NSString *)curPage superType:(NSString *)superType lotryType:(NSString *)lotryType
{
    if (_noReconView) {
        [_noReconView removeFromSuperview];
    }
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    
    if (!_orderFlag) {
        return;
    }
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"zjtjIndexService" forKey:@"serviceName"];
    [bodyDic setObject:@"getMasterPlanList" forKey:@"methodName"];
    NSDictionary * parametersDic=@{@"userName":nameSty,@"expertClassCode":superType,@"lotteyClassCode":lotryType,@"orderFlag":_orderFlag,@"curPage":curPage,@"pageSize":@"20",@"levelType":@"1",@"sid":[[Info getInstance] cbSID], @"sdFlag":@"1"};
    
    [bodyDic setObject:parametersDic forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON objectForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray *arr=responseJSON[@"result"][@"data"];
            if ([curPage intValue]==1) {
                if ([lotryType isEqualToString:@"-201"]) {
                    [_jcSuperArr removeAllObjects];
                    _jcCurrPage = 1;
                }else if([lotryType isEqualToString:@"202"]){
                    [_ypSuperArr removeAllObjects];
                    _ypCurrPage = 1;
                }
            }
            if (arr&&[arr count]!=0) {
                for (NSDictionary *dic in arr) {
                    ExpertJingjiModel *supExMdl=[ExpertJingjiModel expertJingjiWithDic:dic];
                    if ([lotryType isEqualToString:@"-201"]) {
                        [_jcSuperArr addObject:supExMdl];
                    }else if([lotryType isEqualToString:@"202"]){
                        [_ypSuperArr addObject:supExMdl];
                    }
                }
                if ([curPage intValue]>1) {
                    if ([lotryType isEqualToString:@"-201"]) {
                        _jcCurrPage++;
                    }else if([lotryType isEqualToString:@"202"]){
                        _ypCurrPage++;
                    }
                }
            }else{

                if ([curPage isEqualToString:@"1"]) {
                    [self createIfNoHave];
                }
            }
            [_mainTableView reloadData];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_mainTableView.header endRefreshing];
            [_mainTableView.footer endRefreshing];
        });
        
    } failure:^(NSError * error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_mainTableView.header endRefreshing];
            [_mainTableView.footer endRefreshing];
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_lotteyType isEqualToString:@"-201"]) {
        return _jcSuperArr.count;
    }else if ([_lotteyType isEqualToString:@"202"]) {
        return _ypSuperArr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpertHomeTableViewCell * cell=[ExpertHomeTableViewCell ExpertSuperiorBaseCellWithTableView:tableView cellForRowAtIndexPath:indexPath];
    
    ExpertJingjiModel *supExMdl;
    
    if ([_lotteyType isEqualToString:@"-201"]) {
        supExMdl=[_jcSuperArr objectAtIndex:indexPath.row];
    }else if ([_lotteyType isEqualToString:@"202"]) {
        supExMdl=[_ypSuperArr objectAtIndex:indexPath.row];
    }
    
    NSString *compTime=@"";
    NSString *odds=@"";
    NSString *matchs=@"";
    
    CGRect rect=cell.timeLab.frame;
    
    cell.zhongView.hidden=NO;
    cell.leagueTypeLab.hidden=NO;
    
    odds=[NSString stringWithFormat:@"%@中%@",supExMdl.ALL_HIT_NUM,supExMdl.HIT_NUM];
    matchs=[NSString stringWithFormat:@"%@ VS %@",supExMdl.HOME_NAME,supExMdl.AWAY_NAME];
    
    NSString *matchID=supExMdl.MATCHES_ID;
    if ([_lotteyType isEqualToString:@"202"]) {
        matchID=[matchID substringToIndex:2];
    }
    compTime=[NSString stringWithFormat:@"%@ %@",supExMdl.LEAGUE_NAME ,matchID];
    rect.size.width=100;
    
    [cell.timeLab setFrame:rect];
    
    NSString * timeString = @"";
    
    NSString * date = @"";
    NSString * time = @"";
    if (supExMdl.MATCH_DATE && supExMdl.MATCH_DATE.length) {
        date = supExMdl.MATCH_DATE;
    }
    if (supExMdl.MATCH_TIME && supExMdl.MATCH_TIME.length) {
        time = supExMdl.MATCH_TIME;
    }
    timeString = [NSString stringWithFormat:@"开赛：%@ %@",date,time];
    
    [cell setCellSuperHead:supExMdl.HEAD_PORTRAIT name:supExMdl.EXPERTS_NICK_NAME starNo:supExMdl.STAR odds:odds matchSides:matchs time:compTime leagueType:timeString exPrice:supExMdl.PRICE exDiscount:supExMdl.DISCOUNT exRank:supExMdl.SOURCE refundOrNo:supExMdl.FREE_STATUS flag:YES lotryTp:_lotteyType];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
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
    if ([_lotteyType isEqualToString:@"-201"]) {
        supExMdl=[_jcSuperArr objectAtIndex:indexPath.row];
    }else if([_lotteyType isEqualToString:@"202"]){
        supExMdl=[_ypSuperArr objectAtIndex:indexPath.row];
    }
    if (!supExMdl) {
        return;
    }
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
    [bodyDic setObject:@{@"expertsName":supExMdl.EXPERTS_NAME,@"expertsClassCode":_superType,@"loginUserName":nameSty,@"erAgintOrderId":supExMdl.ER_AGINT_ORDER_ID,@"type":@"0",@"sdStatus":[NSString stringWithFormat:@"%i",self.isSdOrNo],@"sid":info.cbSID,@"lotteryClassCode":_lotteyType} forKey:@"parameters"];
    
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSLog(@"responseJSON=%@",responseJSON);
        SMGDetailViewController * vc=[[SMGDetailViewController alloc]init];
        
        //建模型，请求数据
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
        vc.isSdOrNo=self.isSdOrNo;
        vc.historyPlanArr=historyArr;
        vc.leastTenInfo=leastTenInfo;
        vc.npList=newPlanArr;
        vc.planIDStr=supExMdl.ER_AGINT_ORDER_ID;
        vc.jcyplryType=_lotteyType;
        
        vc.exBaseInfo=exBase;
        vc.hidesBottomBarWhenPushed=YES;
        vc.segmentOnClickIndexFlags=YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSError * error) {
        
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58+45*MyWidth/320;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _moduleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cell";
    ExpertHomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    ExpertHomeModuleData * moduleData = [_moduleArray objectAtIndex:indexPath.row];
    
    if (moduleData.limitTitle && moduleData.limitTitle.length) {
        cell.titleLabel.attributedText = moduleData.limitTitle;
    }else{
        cell.titleLabel.text = moduleData.title;
    }
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:moduleData.imgUrl]];
    cell.moneyLabel.text = moduleData.explain;
    
    int a = 0;
    if (moduleData.explainSize.width) {
        a = 13;
    }
    
    cell.moneyLabel.frame = CGRectMake(cell.moneyLabel.frame.origin.x, cell.moneyLabel.frame.origin.y, moduleData.explainSize.width + a, cell.moneyLabel.frame.size.height);
    
    if (indexPath.row == 0) {
        cell.moneyLabel.layer.borderColor = [SharedMethod getColorByHexString:@"51b8f2"].CGColor;
        cell.moneyLabel.textColor = [SharedMethod getColorByHexString:@"51b8f2"];
    }
    else if (indexPath.row == 1) {
        cell.moneyLabel.layer.borderColor = [SharedMethod getColorByHexString:@"2bcec4"].CGColor;
        cell.moneyLabel.textColor = [SharedMethod getColorByHexString:@"2bcec4"];
    }
    else if (indexPath.row == 2) {
        cell.moneyLabel.layer.borderColor = [SharedMethod getColorByHexString:@"ffaf13"].CGColor;
        cell.moneyLabel.textColor = [SharedMethod getColorByHexString:@"ffaf13"];
    }
    else if (indexPath.row == 3) {
        cell.moneyLabel.layer.borderColor = [SharedMethod getColorByHexString:@"fc807a"].CGColor;
        cell.moneyLabel.textColor = [SharedMethod getColorByHexString:@"fc807a"];
    }
    else {
        cell.moneyLabel.layer.borderColor = [UIColor blackColor].CGColor;
        cell.moneyLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(MyWidth/2.0, 55);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _mainTableView) {
        
        if (scrollView.contentOffset.y > ORIGIN_Y(_lunBoScrollView) - _navView.frame.size.height) {
            _navView.frame = CGRectMake(_navView.frame.origin.x, 0, _navView.frame.size.width, _navView.frame.size.height);
    
            if (!_independentDGQ) {
                _searchButton.frame = CGRectMake(ORIGIN_X(_backButton) + _backButton.frame.origin.x, ORIGIN_Y(_navView) - 5 - 30, MyWidth - 15 - (ORIGIN_X(_backButton) + _backButton.frame.origin.x), _searchButton.frame.size.height);
            }else{
                _searchButton.frame = CGRectMake(_searchButton.frame.origin.x, ORIGIN_Y(_navView) - 5 - 30, _searchButton.frame.size.width, _searchButton.frame.size.height);
            }
        }
        else{
            _navView.frame = CGRectMake(_navView.frame.origin.x, -scrollView.contentOffset.y + ORIGIN_Y(_lunBoScrollView) - 64, _navView.frame.size.width, _navView.frame.size.height);
            
            if (!_independentDGQ) {
                if (_searchButton.frame.origin.x >= 15) {
                    
                    if (scrollView.contentOffset.y > 0) {
                        _searchButton.frame = CGRectMake(15 + (ORIGIN_X(_backButton) + _backButton.frame.origin.x -15)*scrollView.contentOffset.y/(ORIGIN_Y(_lunBoScrollView) - _navView.frame.size.height), ORIGIN_Y(_navView) - 5 - 30, MyWidth - 30 - (ORIGIN_X(_backButton) + _backButton.frame.origin.x -15)*scrollView.contentOffset.y/(ORIGIN_Y(_lunBoScrollView) - _navView.frame.size.height), _searchButton.frame.size.height);
                    }else{
                        _searchButton.frame = CGRectMake(_searchButton.frame.origin.x, ORIGIN_Y(_navView) - 5 - 30, _searchButton.frame.size.width, _searchButton.frame.size.height);
                    }
                    
                }else{
                    _searchButton.frame = CGRectMake(15 , _searchButton.frame.origin.y, _searchButton.frame.size.width, _searchButton.frame.size.height);
                }
            }else{
                _searchButton.frame = CGRectMake(_searchButton.frame.origin.x, ORIGIN_Y(_navView) - 5 - 30, _searchButton.frame.size.width, _searchButton.frame.size.height);
            }
        }

        
        if (scrollView.contentOffset.y >= _mainTableViewHeader.frame.size.height - _navView.frame.size.height) {
            _fakeHeader.hidden = NO;
        }else{
            _fakeHeader.hidden = YES;
        }
        
        _navView.backgroundColor = [UIColor colorWithRed:0/255.0 green:138/255.0 blue:212/255.0 alpha:scrollView.contentOffset.y/70.0];
    }
    else if(scrollView==_lunBoScrollView){
        CGPoint offset=scrollView.contentOffset;
        NSInteger page=offset.x/MyWidth;
        _pageControl.currentPage=page;
    }
}

-(void)toSearch
{
    SearchVC * vc = [[SearchVC alloc] init];
    vc.isSdOrNo=YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  如果没有发布方案的时候 提示用户发布方案啊、
-(void)createIfNoHave
{
    if (!_noReconView) {
        _noReconView=[[UIView alloc] initWithFrame:CGRectMake(0, _mainTableViewHeader.frame.size.height + _fakeHeader.frame.size.height, MyWidth, _mainTableView.frame.size.height - _mainTableViewHeader.frame.size.height - _fakeHeader.frame.size.height)];
        _noReconView.backgroundColor=[UIColor clearColor];
        
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
//        [_mainTableView setBackgroundColor:[UIColor colorWithHexString:@"ecedf1"]];
    }
    
    [_mainTableView addSubview:_noReconView];
}

-(void)changeLotteryType:(UIButton *)button
{
    if (_noReconView) {
        [_noReconView removeFromSuperview];
    }
    for (int i = 0; i < 2; i++) {
        UIButton * typeButton;
        UIButton * typeButton1;
        if (_fakeHeader.hidden == NO) {
            typeButton = [_fakeHeader viewWithTag:10 + i];
            typeButton1 = [_sectionHeaderView viewWithTag:10 + i];
        }else{
            typeButton = [_sectionHeaderView viewWithTag:10 + i];
            typeButton1 = [_fakeHeader viewWithTag:10 + i];
        }
        UIView * lineView = [typeButton viewWithTag:100 + i];
        UIView * lineView1 = [typeButton1 viewWithTag:100 + i];
        
        if (typeButton == button) {
            lineView.hidden = NO;
            lineView1.hidden = NO;
        }else{
            lineView.hidden = YES;
            lineView1.hidden = YES;
        }
    }
    
    if (button.tag == 10) {
        _lotteyType = @"-201";
        [self hiddenFilter];
        
        if (!_jcSuperArr.count) {
            [self supCurPage:@"1" superType:_superType lotryType:_lotteyType];
        }else{
            [_mainTableView reloadData];
        }
        _orderFlag = _jcOrderFlag;
        
    }else if (button.tag == 11) {
        _lotteyType =@"202";
        [self hiddenFilter];

        if (!_ypSuperArr.count) {
            [self supCurPage:@"1" superType:_superType lotryType:_lotteyType];
        }else{
            [_mainTableView reloadData];
        }
        
        _orderFlag = _ypOrderFlag;

    }
}

-(void)touchFilter:(UIButton *)button
{

    button.selected = !button.selected;
    
    UIImageView * filterArrowImageView;
    
    filterArrowImageView = [_fakeHeader viewWithTag:1000];
    _fakeFilterBGButton.hidden = !button.selected;

    UIButton * filterButton = [_sectionHeaderView viewWithTag:10000];
    filterButton.selected = button.selected;
    
    UIButton * filterButton1 = [_fakeHeader viewWithTag:10000];
    filterButton1.selected = button.selected;
    
    if (_fakeHeader.hidden == YES) {
        _mainTableView.contentOffset = CGPointMake(_mainTableView.contentOffset.x, _mainTableViewHeader.frame.size.height - _navView.frame.size.height);
    }
    
    if (button.selected) {
        filterArrowImageView.image = [UIImage imageNamed:@"GodPlan_BlueArrow1.png"];
        
        for (int i = 0; i < _filterTitleArray.count; i++) {
            UIImageView * checkMark = [_fakeFilterBGButton viewWithTag:100 + i];
            if ([_orderFlag isEqualToString:@"0"]) {
                if (i == 0) {
                    checkMark.hidden = NO;
                }else{
                    checkMark.hidden = YES;
                }
            }else if ([_orderFlag isEqualToString:@"5"]) {
                if (i == 0) {
                    checkMark.hidden = YES;
                }else{
                    checkMark.hidden = NO;
                }
            }
        }
        

    }else{
        filterArrowImageView.image = [UIImage imageNamed:@"GodPlan_BlueArrow.png"];
    }
}

-(void)hiddenFilter
{
    UIButton * filterButton = [_fakeHeader viewWithTag:10000];
    filterButton.selected = NO;
    UIImageView * filterArrowImageView = [_fakeHeader viewWithTag:1000];
    filterArrowImageView.image = [UIImage imageNamed:@"GodPlan_BlueArrow.png"];
    
    _fakeFilterBGButton.hidden = YES;
    
    UIButton * filterButton1 = [_sectionHeaderView viewWithTag:10000];
    filterButton1.selected = NO;

//    _mainTableView.contentOffset = CGPointMake(0, 0);
//    
//    _searchButton.frame = CGRectMake(15, _searchButton.frame.origin.y, MyWidth - 30, _searchButton.frame.size.height);
}

-(void)changeFilter:(UIButton *)button
{
    if (button.tag == 0) {
        if ([_lotteyType isEqualToString:@"-201"]) {
            _jcOrderFlag = @"0";
        }else if ([_lotteyType isEqualToString:@"202"]) {
            _ypOrderFlag = @"0";
        }
        _orderFlag = @"0";
    }else if (button.tag == 1) {
        if ([_lotteyType isEqualToString:@"-201"]) {
            _jcOrderFlag = @"5";
        }else if ([_lotteyType isEqualToString:@"202"]) {
            _ypOrderFlag = @"5";
        }
        _orderFlag = @"5";
    }
    [self hiddenFilter];

    [self supCurPage:@"1" superType:_superType lotryType:_lotteyType];
}

-(void)createFakeHeader
{
    
    _fakeHeader = [[UIView alloc] initWithFrame:CGRectMake(0, _navView.frame.size.height, MyWidth, _sectionHeaderView.frame.size.height)];
    _fakeHeader.backgroundColor = [UIColor whiteColor];
    _fakeHeader.hidden = YES;
    [self.view addSubview:_fakeHeader];
    
    NSArray * titleArray = @[@"竞彩",@"亚盘"];
    
    for (int i = 0; i < 2; i++) {
        UIButton * headerButton = [[UIButton alloc] initWithFrame:CGRectMake(i * 89, 0, 89, _fakeHeader.frame.size.height)];
        [headerButton setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [headerButton setTitleColor:[SharedMethod getColorByHexString:@"13a3ff"] forState:UIControlStateNormal];
        headerButton.titleLabel.font = [UIFont systemFontOfSize:15];
        headerButton.tag = 10 + i;
        [_fakeHeader addSubview:headerButton];
        [headerButton addTarget:self action:@selector(changeLotteryType:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView * blueLine = [[UIView alloc] initWithFrame:CGRectMake(15, headerButton.frame.size.height - 10, headerButton.frame.size.width - 30, 2)];
        blueLine.backgroundColor = [SharedMethod getColorByHexString:@"13a3ff"];
        blueLine.tag = 100 + i;
        [headerButton addSubview:blueLine];
        
        if (i) {
            blueLine.hidden = YES;
        }
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _fakeHeader.frame.size.height - 0.5, _fakeHeader.frame.size.width, 0.5)];
        lineView.backgroundColor = DEFAULT_LINECOLOR;
        [_fakeHeader addSubview:lineView];
    }
    
    UIImageView * filterArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_fakeHeader.frame.size.width - 15 - 9.5, (_fakeHeader.frame.size.height - 5.5)/2.0, 9.5, 5.5)];
    [_fakeHeader addSubview:filterArrowImageView];
    filterArrowImageView.image = [UIImage imageNamed:@"GodPlan_BlueArrow.png"];
    filterArrowImageView.tag = 1000;
    
    UIButton * filterButton = [[UIButton alloc] initWithFrame:CGRectMake(filterArrowImageView.frame.origin.x - 3 - 44 - 5, 0, 70, _fakeHeader.frame.size.height)];
    [filterButton setTitle:@"筛选" forState:UIControlStateNormal];
    [filterButton setTitleColor:[SharedMethod getColorByHexString:@"13a3ff"] forState:UIControlStateNormal];
    filterButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_fakeHeader addSubview:filterButton];
    filterButton.backgroundColor = [UIColor clearColor];
    filterButton.tag = 10000;
    [filterButton addTarget:self action:@selector(touchFilter:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray * filterArray = @[@"GodPlan_General.png", @"GodPlan_Recent.png"];
    _filterTitleArray = [[NSArray alloc] initWithObjects:@"综合推荐", @"近5场战绩", nil];
    
    _fakeFilterBGButton = [[UIButton alloc] initWithFrame:CGRectMake(0, _navView.frame.size.height + _fakeHeader.frame.size.height, MyWidth, self.view.frame.size.height)];
    _fakeFilterBGButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [self.view addSubview:_fakeFilterBGButton];
    [_fakeFilterBGButton addTarget:self action:@selector(hiddenFilter) forControlEvents:UIControlEventTouchUpInside];
    _fakeFilterBGButton.hidden = YES;
    
    for (int i = 0; i < 2; i++) {
        UIButton * filterButton1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 40 * i, MyWidth, 40)];
        filterButton1.backgroundColor = [UIColor whiteColor];
        [filterButton1 addTarget:self action:@selector(changeFilter:) forControlEvents:UIControlEventTouchUpInside];
        filterButton1.tag = i;
        [_fakeFilterBGButton addSubview:filterButton1];
        
        UIImageView * filterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, (filterButton1.frame.size.height - 20)/2.0, 20, 20)];
        filterImageView.image = [UIImage imageNamed:[filterArray objectAtIndex:i]];
        [filterButton1 addSubview:filterImageView];
        
        UILabel * filterLabel = [[UILabel alloc] init];
        filterLabel.backgroundColor = [UIColor clearColor];
        filterLabel.text = [_filterTitleArray objectAtIndex:i];
        filterLabel.textColor = DEFAULT_TEXTBLACKCOLOR;
        filterLabel.font = [UIFont systemFontOfSize:13];
        [filterButton1 addSubview:filterLabel];
        
        CGSize filterTitleSize = [SharedMethod getSizeByText:filterLabel.text font:filterLabel.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX) lineBreakMode:0];
        filterLabel.frame = CGRectMake(ORIGIN_X(filterImageView) + 10, 0, filterTitleSize.width, filterButton1.frame.size.height);
        
        UIImageView * checkMarkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(filterLabel) + 15, (filterButton1.frame.size.height - 9.5)/2.0, 13.5, 9.5)];
        checkMarkImageView.image = [UIImage imageNamed:@"GodPlan_CheckMark.png"];
        [filterButton1 addSubview:checkMarkImageView];
        checkMarkImageView.hidden = YES;
        checkMarkImageView.tag = 100 + i;
        
        UIView * filterLineView = [[UIView alloc] initWithFrame:CGRectMake(0, filterButton1.frame.size.height - 0.5, filterButton1.frame.size.width, 0.5)];
        filterLineView.backgroundColor = DEFAULT_LINECOLOR;
        [filterButton1 addSubview:filterLineView];
        
    }
}

#pragma mark -------添加轮播图----------
- (void)creatScrollView{
    
    float height=105;
    if (!_lunBoScrollView) {
        _lunBoScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MyWidth, 160)];
        _lunBoScrollView.delegate=self;
        _lunBoScrollView.bounces=NO;
        _lunBoScrollView.backgroundColor=[UIColor clearColor];
        _lunBoScrollView.pagingEnabled=YES;
        _lunBoScrollView.showsHorizontalScrollIndicator=NO;
        [_mainTableViewHeader addSubview:_lunBoScrollView];
    }
    if (_photoImageArr.count != 0) {
        _lunBoScrollView.contentSize=CGSizeMake(MyWidth*_photoImageArr.count, height);
    }
    
    [_lunBoScrollView setContentOffset:CGPointMake(MyWidth, 0) animated:NO];
    
    if (!_pageControl) {
        _pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(_lunBoScrollView.frame.size.width/2-50, _lunBoScrollView.frame.size.height-20, 100, 20)];
        _pageControl.backgroundColor=[UIColor clearColor];
        [_pageControl addTarget:self action:@selector(pageValueChange:) forControlEvents:UIControlEventValueChanged];
        [_mainTableViewHeader addSubview:_pageControl];
    }

    if (_photoImageArr.count != 0) {
        _pageControl.numberOfPages=_photoImageArr.count;
    }
    _pageControl.currentPage=0;

    
    //_currentIndex=0;
}

#pragma mark -------获取轮播图URL----------
-(void)scrImgReData
{

    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"zjtjIndexService" forKey:@"serviceName"];
    [bodyDic setObject:@"getAllCarouseImage" forKey:@"methodName"];
    [bodyDic setObject:@{@"type":@"1"} forKey:@"parameters"];
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
            UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(MyWidth*i, 0, MyWidth, _lunBoScrollView.frame.size.height)];
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
            scolImgName = @"CS_LunBoDefault";
#else
            scolImgName=@"灰色默认";
#endif
            [imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:scolImgName] options:SDWebImageContinueInBackground|SDWebImageRetryFailed];
            [_lunBoScrollView addSubview:imgView];
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            _lunBoScrollView.userInteractionEnabled = YES;
            imgView.userInteractionEnabled = YES;
            [imgView addGestureRecognizer:tap];
        }
    } failure:^(NSError * error) {
        NSLog(@"error=%@",error);
    }];
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

//滚动视图切换页
- (void)pageValueChange:(id)sender{
    _currentPage=_pageControl.currentPage;
    CGPoint offset=CGPointMake(_currentPage*320.0f, 0.0f);
    [_lunBoScrollView setContentOffset:offset animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    Info *info = [Info getInstance];
    if (![info.userId intValue]) {
        [self toLogin];
        return;
    }
    if (indexPath.row < self.moduleNumber) {
        ExpertHomeModuleData * moduleData = [_moduleArray objectAtIndex:indexPath.row];
        if (!moduleData.code) {
            return;
        }
        
        ShenDanDetailViewController * controller = [[ShenDanDetailViewController alloc] init];
        controller.code = moduleData.code;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)toLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    