//
//  ExpertStarListViewController.m
//  caibo
//
//  Created by cp365dev6 on 2016/11/26.
//
//

#import "ExpertStarListViewController.h"
#import "ExpertMainCollectionViewCell.h"
#import "RequestEntity.h"
#import "SharedMethod.h"
#import "SMGDetailViewController.h"
#import "ProjectDetailViewController.h"
#import "LoginViewController.h"
#import "MobClick.h"
#import "Expert365Bridge.h"

@interface ExpertStarListViewController ()

@end

@implementation ExpertStarListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self changeCSTitileColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(goBack)];
    
    cellPageArym = [[NSMutableArray alloc]initWithCapacity:0];
    for(NSInteger i=0;i<7;i++){
        NSString *page = @"1";
        [cellPageArym addObject:page];
    }
    
    erAgintOrderId = @"";
    disPrice = 0;
    starArym = [[NSMutableArray alloc]initWithCapacity:0];
    squareArym = [[NSMutableArray alloc]initWithCapacity:0];
    redArym = [[NSMutableArray alloc]initWithCapacity:0];
    for(NSInteger i=0;i<2;i++){
        NSMutableArray *ary = [[NSMutableArray alloc]initWithCapacity:0];
        [starArym addObject:ary];
    }
    for(NSInteger i=0;i<3;i++){
        NSMutableArray *ary = [[NSMutableArray alloc]initWithCapacity:0];
        [squareArym addObject:ary];
    }
    for(NSInteger i=0;i<2;i++){
        NSMutableArray *ary = [[NSMutableArray alloc]initWithCapacity:0];
        [redArym addObject:ary];
    }
    
//    [self loadSegmentView];
    [self loadHeaderSegmentView];
    [self loadCollectionView];
    
    if(_expertType == expertStarType){
        segmentTag = 10;
        [self getStarExpertRequestWithLotteryClassCode:@"-201" page:@"1"];
        self.CP_navigation.title = @"名人推荐";
    }else if (_expertType == expertSquareType){
        segmentTag = 11;
        [self getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"-201" Type:@"0" OrderFlag:@"0" page:@"1"];
        self.CP_navigation.title = @"喂饼广场";
    }else if (_expertType == expertRedType){
        segmentTag = 12;
        [self getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"-201" Type:@"1" OrderFlag:@"2" page:@"1"];
        self.CP_navigation.title = @"蹿红新秀";
    }
}
-(void)loadSegmentView{
    
    segmentIma = [[UIImageView alloc]init];
    segmentIma.frame = CGRectMake((self.mainView.frame.size.width - 225)/2.0, 10.5, 225, 23);
    segmentIma.backgroundColor = [UIColor clearColor];
    segmentIma.image = [UIImage imageNamed:@"expert_segment_bg.png"];
    segmentIma.userInteractionEnabled = YES;
    [self.CP_navigation addSubview:segmentIma];
    
    NSArray *ary = [NSArray arrayWithObjects:@"明星推荐",@"喂饼广场",@"最红新人", nil];
    for(NSInteger i=0;i<3;i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(75*i, 0, 75, 23);
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = 10+i;
        if(i == 0){
            btn.selected = YES;
            segmentTag = btn.tag;
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:[ary objectAtIndex:i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"expert_segment_selected.png"] forState:UIControlStateSelected];
//        [btn setBackgroundImage:[UIImage imageNamed:@"expert_segment_selected.png"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [segmentIma addSubview:btn];
        [btn addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[SharedMethod getColorByHexString:@"6e29bd"] forState:UIControlStateNormal];
    }
    
}
-(void)loadHeaderSegmentView{
    
    headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, 35);
    headerView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:headerView];
    
    for(NSInteger i=0;i<3;i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(self.mainView.frame.size.width/2.0*i, 0, self.mainView.frame.size.width/2.0, 35);
        if(i == 0){
            [btn setTitle:@"竞彩" forState:UIControlStateNormal];
        }else{
            [btn setTitle:@"二串一" forState:UIControlStateNormal];
        }
        if(_expertType == expertSquareType){
            btn.frame = CGRectMake(self.mainView.frame.size.width/3.0*i, 0, self.mainView.frame.size.width/3.0, 35);
            if(i == 0){
                [btn setTitle:@"用户等级" forState:UIControlStateNormal];
            }else if(i == 1){
                [btn setTitle:@"发布时间" forState:UIControlStateNormal];
            }else if(i == 2){
                [btn setTitle:@"二串一" forState:UIControlStateNormal];
            }
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = 10+i;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn addTarget:self action:@selector(headerSegAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:btn];
    }
    UIImageView *lineIma = [[UIImageView alloc]init];
    lineIma.frame = CGRectMake(0, 34.5, self.mainView.frame.size.width, 0.5);
    lineIma.backgroundColor = SEPARATORCOLOR;
    [headerView addSubview:lineIma];
    
    UIImageView *sliderIma = [[UIImageView alloc]init];
    sliderIma.frame = CGRectMake(0, 33, self.mainView.frame.size.width/2.0, 2);
    if(_expertType == expertSquareType){
        sliderIma.frame = CGRectMake(0, 33, self.mainView.frame.size.width/3.0, 2);
    }
    sliderIma.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
    sliderIma.tag = 14;
    [headerView addSubview:sliderIma];
}

-(void)loadCollectionView{
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为水平流布局
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置每个item的大小为100*100
    //    layout.itemSize = CGSizeMake(70, 90);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    //创建collectionView 通过一个布局策略layout来创建
    myCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 35, self.mainView.frame.size.width, self.mainView.frame.size.height-35) collectionViewLayout:layout];
    myCollection.backgroundColor = [UIColor clearColor];
    myCollection.showsHorizontalScrollIndicator = NO;
    //代理设置
    myCollection.delegate=self;
    myCollection.dataSource=self;
    myCollection.pagingEnabled = YES;
    //注册item类型 这里使用系统的类型
    [myCollection registerClass:[ExpertMainCollectionViewCell class] forCellWithReuseIdentifier:@"ExpertMainCollectionViewCell"];
    [self.mainView addSubview:myCollection];
}

-(void)getStarExpertRequestWithLotteryClassCode:(NSString *)lotteryClassCode page:(NSString *)page{
    
    ExpertMainCollectionViewCell *cell;
    if([lotteryClassCode isEqualToString:@"-201"]){
        cell = (ExpertMainCollectionViewCell *)[myCollection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }else if ([lotteryClassCode isEqualToString:@"201"]){
        cell = (ExpertMainCollectionViewCell *)[myCollection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    }
    //lotteryClassCode  竞彩-201   二串一201     明星推荐
    if (!_loadView) {
        _loadView = [[UpLoadView alloc] init];
    }
    if (!_loadView.superview) {
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:_loadView];
    }
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"sid":[[Info getInstance] cbSID],
                                                                                       @"expertClassCode":@"001",
                                                                                       @"lotteryClassCode":lotteryClassCode,
                                                                                       @"curPage":page,
                                                                                       @"pageSize":@"20"}];
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getCrazySportExpertsPlanList",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if (_loadView) {
            [_loadView stopRemoveFromSuperview];
            _loadView = nil;
        }
        [cell.myTableView.footer endRefreshing];
        [cell.myTableView.header endRefreshing];
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[[responseJSON valueForKey:@"result"] valueForKey:@"data"];
            if ([result count]!=0) {
                
                if([lotteryClassCode isEqualToString:@"-201"]){
                    
                    NSInteger curPage = [[cellPageArym objectAtIndex:0] integerValue];
                    curPage += 1;
                    [cellPageArym replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%ld",(long)curPage]];
                    NSMutableArray *mutableArr=[starArym objectAtIndex:0];
                    if([page isEqualToString:@"1"]){
                        [mutableArr removeAllObjects];
                    }
                    for (NSDictionary * dic in result) {
                        [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                    }
                    [starArym replaceObjectAtIndex:0 withObject:mutableArr];
                }else if ([lotteryClassCode isEqualToString:@"201"]){
                    NSInteger curPage = [[cellPageArym objectAtIndex:1] integerValue];
                    curPage += 1;
                    [cellPageArym replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%ld",(long)curPage]];
                    NSMutableArray *mutableArr=[starArym objectAtIndex:1];
                    if([page isEqualToString:@"1"]){
                        [mutableArr removeAllObjects];
                    }
                    for (NSDictionary * dic in result) {
                        [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                    }
                    [starArym replaceObjectAtIndex:1 withObject:mutableArr];
                }
                [myCollection reloadData];
            }
            else {
                [cell.myTableView.footer noticeNoMoreData];
            }
        }else{
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        if (_loadView) {
            [_loadView stopRemoveFromSuperview];
            _loadView = nil;
        }
        [cell.myTableView.footer endRefreshing];
        [cell.myTableView.header endRefreshing];
    }];
}
-(void)getSquareAndRedPersonExpertRequestWithLotteyClassCode:(NSString *)lotteyClassCode Type:(NSString *)type OrderFlag:(NSString *)orderFlag page:(NSString *)page{
    
    /*
     喂饼广场：type = 0   lotteyClassCode = -201   orderFlag = 0用户等级  orderFlag = 1发布时间   竞彩
                        lotteyClassCode = 201    二串一
     
     最近红人：type = 1    orderFlag = 2 lotteyClassCode = -201竞彩
                         orderFlag = 3 lotteyClassCode = 201二串一
     */
    ExpertMainCollectionViewCell *cell;
    if([type isEqualToString:@"0"]){
        if([lotteyClassCode isEqualToString:@"-201"]){
            if([orderFlag isEqualToString:@"0"]){
                cell = (ExpertMainCollectionViewCell *)[myCollection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            }else if ([orderFlag isEqualToString:@"1"]){
                cell = (ExpertMainCollectionViewCell *)[myCollection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            }
        }else{
            cell = (ExpertMainCollectionViewCell *)[myCollection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        }
//        if([orderFlag isEqualToString:@"0"]){
//            cell = (ExpertMainCollectionViewCell *)[myCollection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        }else if ([orderFlag isEqualToString:@"1"]){
//            cell = (ExpertMainCollectionViewCell *)[myCollection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//        }else{
//            cell = (ExpertMainCollectionViewCell *)[myCollection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//        }
    }else if ([type isEqualToString:@"1"]){
        
        if([lotteyClassCode isEqualToString:@"-201"]){
            cell = (ExpertMainCollectionViewCell *)[myCollection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        }else if ([lotteyClassCode isEqualToString:@"201"]){
            cell = (ExpertMainCollectionViewCell *)[myCollection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        }
    }
    if (!_loadView) {
        _loadView = [[UpLoadView alloc] init];
    }
    if (!_loadView.superview) {
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:_loadView];
    }
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"sid":[[Info getInstance] cbSID],
                                                                                       @"userName":[[Info getInstance] userName],
                                                                                       @"expertClassCode":@"001",//竞彩001  写死
                                                                                       @"lotteryClassCode":lotteyClassCode,
                                                                                       @"type":type,//0广场 1红人
                                                                                       @"orderFlag":orderFlag,//首页传1
                                                                                       @"curPage":page,
                                                                                       @"pageSize":@"20"}];
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getCrazySportMasterPlanList",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if (_loadView) {
            [_loadView stopRemoveFromSuperview];
            _loadView = nil;
        }
        [cell.myTableView.footer endRefreshing];
        [cell.myTableView.header endRefreshing];
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[[responseJSON valueForKey:@"result"] valueForKey:@"data"];
            if ([result count]!=0) {
                
                if([type isEqualToString:@"0"]){
                    
                    if([lotteyClassCode isEqualToString:@"-201"]){
                        if([orderFlag isEqualToString:@"0"]){
                            NSInteger curPage = [[cellPageArym objectAtIndex:2] integerValue];
                            curPage += 1;
                            [cellPageArym replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%ld",(long)curPage]];
                            NSMutableArray *mutableArr=[squareArym objectAtIndex:0];
                            if([page isEqualToString:@"1"]){
                                [mutableArr removeAllObjects];
                            }
                            for (NSDictionary * dic in result) {
                                [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                            }
                            [squareArym replaceObjectAtIndex:0 withObject:mutableArr];
                        }else if ([orderFlag isEqualToString:@"1"]){
                            NSInteger curPage = [[cellPageArym objectAtIndex:3] integerValue];
                            curPage += 1;
                            [cellPageArym replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%ld",(long)curPage]];
                            NSMutableArray *mutableArr=[squareArym objectAtIndex:1];
                            if([page isEqualToString:@"1"]){
                                [mutableArr removeAllObjects];
                            }
                            for (NSDictionary * dic in result) {
                                [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                            }
                            [squareArym replaceObjectAtIndex:1 withObject:mutableArr];
                        }
                    }else{
                        NSInteger curPage = [[cellPageArym objectAtIndex:4] integerValue];
                        curPage += 1;
                        [cellPageArym replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%ld",(long)curPage]];
                        NSMutableArray *mutableArr=[squareArym objectAtIndex:2];
                        if([page isEqualToString:@"1"]){
                            [mutableArr removeAllObjects];
                        }
                        for (NSDictionary * dic in result) {
                            [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                        }
                        [squareArym replaceObjectAtIndex:2 withObject:mutableArr];
                    }
                }else if ([type isEqualToString:@"1"]){
                    
                    if([lotteyClassCode isEqualToString:@"-201"]){
                        NSInteger curPage = [[cellPageArym objectAtIndex:5] integerValue];
                        curPage += 1;
                        [cellPageArym replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%ld",(long)curPage]];
                        NSMutableArray *mutableArr=[redArym objectAtIndex:0];
                        if([page isEqualToString:@"1"]){
                            [mutableArr removeAllObjects];
                        }
                        for (NSDictionary * dic in result) {
                            [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                        }
                        [redArym replaceObjectAtIndex:0 withObject:mutableArr];
                    }else if ([lotteyClassCode isEqualToString:@"201"]){
                        NSInteger curPage = [[cellPageArym objectAtIndex:6] integerValue];
                        curPage += 1;
                        [cellPageArym replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"%ld",(long)curPage]];
                        NSMutableArray *mutableArr=[redArym objectAtIndex:1];
                        if([page isEqualToString:@"1"]){
                            [mutableArr removeAllObjects];
                        }
                        for (NSDictionary * dic in result) {
                            [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                        }
                        [redArym replaceObjectAtIndex:1 withObject:mutableArr];
                    }
                }
                [myCollection reloadData];
            }
            else {
                [cell.myTableView.footer noticeNoMoreData];
            }
        }else{
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        if (_loadView) {
            [_loadView stopRemoveFromSuperview];
            _loadView = nil;
        }
        [cell.myTableView.footer endRefreshing];
        [cell.myTableView.header endRefreshing];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSMutableArray *dataAry;
    if(segmentTag == 10){
        dataAry = [NSMutableArray arrayWithArray:starArym];
        return dataAry.count;
    }else if (segmentTag == 11){
        dataAry = [NSMutableArray arrayWithArray:squareArym];
        return dataAry.count;
    }else{
        dataAry = [NSMutableArray arrayWithArray:redArym];
        return dataAry.count;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"ExpertMainCollectionViewCell";
    ExpertMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"-----------------");
    }
    NSMutableArray *dataAry;
    if(segmentTag == 10){
        dataAry = [NSMutableArray arrayWithArray:starArym];
    }else if (segmentTag == 11){
        dataAry = [NSMutableArray arrayWithArray:squareArym];
    }else{
        dataAry = [NSMutableArray arrayWithArray:redArym];
    }
    if(indexPath.row < dataAry.count){
        [cell loadAppointInfo:[dataAry objectAtIndex:indexPath.row]];
    }
    __block ExpertStarListViewController * newSelf = self;
    cell.didSelectRow = ^(UITableView * tableView, NSIndexPath * index) {
        [newSelf didSelectItemAtCollectionIndexPath:indexPath tableViewIndexPath:index];
    };
    cell.buttonAction = ^(NSIndexPath *index) {
        
        [newSelf coinButtonItemAtCollectionIndexPath:indexPath tableViewIndexPath:index];
    };
    cell.myTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if(segmentTag == 10){
            
            if(indexPath.row == 0){
                [cellPageArym replaceObjectAtIndex:0 withObject:@"1"];
                [newSelf getStarExpertRequestWithLotteryClassCode:@"-201" page:@"1"];
            }else{
                [cellPageArym replaceObjectAtIndex:1 withObject:@"1"];
                [newSelf getStarExpertRequestWithLotteryClassCode:@"201" page:@"1"];
            }
        }else if (segmentTag == 11){
            
            if(indexPath.row == 0){
                [cellPageArym replaceObjectAtIndex:2 withObject:@"1"];
                [newSelf getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"-201" Type:@"0" OrderFlag:@"0" page:@"1"];
            }else if(indexPath.row == 1){
                [cellPageArym replaceObjectAtIndex:3 withObject:@"1"];
                [newSelf getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"-201" Type:@"0" OrderFlag:@"1" page:@"1"];
            }else{
                [cellPageArym replaceObjectAtIndex:4 withObject:@"1"];
                [newSelf getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"201" Type:@"0" OrderFlag:@"0" page:@"1"];
            }
        }else if (segmentTag == 12){
            
            if(indexPath.row == 0){
                [cellPageArym replaceObjectAtIndex:5 withObject:@"1"];
                [newSelf getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"-201" Type:@"1" OrderFlag:@"2" page:@"1"];
            }else{
                [cellPageArym replaceObjectAtIndex:6 withObject:@"1"];
                [newSelf getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"201" Type:@"1" OrderFlag:@"3" page:@"1"];
            }
        }
    }];

    cell.myTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if(segmentTag == 10){
            
            if(indexPath.row == 0){
                NSString *page = [cellPageArym objectAtIndex:0];
                [newSelf getStarExpertRequestWithLotteryClassCode:@"-201" page:page];
            }else{
                NSString *page = [cellPageArym objectAtIndex:1];
                [newSelf getStarExpertRequestWithLotteryClassCode:@"201" page:page];
            }
        }else if (segmentTag == 11){
            
            if(indexPath.row == 0){
                NSString *page = [cellPageArym objectAtIndex:2];
                [newSelf getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"-201" Type:@"0" OrderFlag:@"0" page:page];
            }else if(indexPath.row == 1){
                NSString *page = [cellPageArym objectAtIndex:3];
                [newSelf getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"-201" Type:@"0" OrderFlag:@"1" page:page];
            }else{
                NSString *page = [cellPageArym objectAtIndex:4];
                [newSelf getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"201" Type:@"0" OrderFlag:@"0" page:page];
            }
        }else if (segmentTag == 12){
            
            if(indexPath.row == 0){
                NSString *page = [cellPageArym objectAtIndex:5];
                [newSelf getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"-201" Type:@"1" OrderFlag:@"2" page:page];
            }else{
                NSString *page = [cellPageArym objectAtIndex:6];
                [newSelf getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"201" Type:@"1" OrderFlag:@"3" page:page];
            }
        }
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.mainView.frame.size.width, self.mainView.frame.size.height-35);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(void)didSelectItemAtCollectionIndexPath:(NSIndexPath *)collectionIndex tableViewIndexPath:(NSIndexPath *)tableViewIndex{
    
    NSArray *dataAry;
    if(segmentTag == 10){
        dataAry = [NSMutableArray arrayWithArray:starArym];
    }else if (segmentTag == 11){
        dataAry = [NSMutableArray arrayWithArray:squareArym];
    }else if (segmentTag == 12){
        dataAry = [NSMutableArray arrayWithArray:redArym];
    }
    NSLog(@"单击了某个方案响应函数");
    NSMutableArray *ary = [dataAry objectAtIndex:collectionIndex.row];
    ExpertMainListModel *model = [ary objectAtIndex:tableViewIndex.row];
    
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    NSString *lotteryClassCode = @"-201";
    if((segmentTag == 10 && collectionIndex.row == 1) || (segmentTag == 11 && collectionIndex.row == 2) || (segmentTag == 12 && collectionIndex.row == 1)){
        lotteryClassCode = @"201";
    }
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
    [bodyDic setObject:@{@"expertsName":model.EXPERTS_NAME,@"expertsClassCode":@"001",@"loginUserName":nameSty,@"erAgintOrderId":model.ER_AGINT_ORDER_ID,@"type":@"0",@"sdStatus":@"0",@"sid":[[Info getInstance] cbSID],@"lotteryClassCode":lotteryClassCode} forKey:@"parameters"];
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
        vc.planIDStr=model.ER_AGINT_ORDER_ID;
        vc.jcyplryType=lotteryClassCode;//
        vc.isSdOrNo=NO;//
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError * error) {
    }];
}
-(void)headerSegAction:(UIButton *)button{
    
    UIImageView *sliderIma = [headerView viewWithTag:14];
    [UIView animateWithDuration:0.25 animations:^{
        if(segmentTag == 10){
            sliderIma.frame = CGRectMake((self.mainView.frame.size.width/2.0)*(button.tag - 10), 33, self.mainView.frame.size.width/2.0, 2);
        }else if (segmentTag == 11){
            sliderIma.frame = CGRectMake((self.mainView.frame.size.width/3.0)*(button.tag - 10), 33, self.mainView.frame.size.width/3.0, 2);
        }else if (segmentTag == 12){
            sliderIma.frame = CGRectMake((self.mainView.frame.size.width/2.0)*(button.tag - 10), 33, self.mainView.frame.size.width/2.0, 2);
        }
    }];
    [myCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:button.tag-10 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}
-(void)segmentAction:(UIButton *)button{
    if(button.selected){
        return;
    }
    
    for(NSInteger i=10;i<13;i++){
        UIButton *btn = [segmentIma viewWithTag:i];
        btn.selected = NO;
    }
    button.selected = YES;
    segmentTag = button.tag;
    
    if(segmentTag == 10 || segmentTag == 12){
        for(NSInteger i=0;i<3;i++){
            UIButton *btn = [headerView viewWithTag:i+10];
            btn.frame = CGRectMake(self.mainView.frame.size.width/2.0*i + 0, 0, self.mainView.frame.size.width/2.0, 35);
            if(i == 0){
                [btn setTitle:@"竞彩" forState:UIControlStateNormal];
            }else{
                [btn setTitle:@"二串一" forState:UIControlStateNormal];
            }
        }
        UIImageView *sliderIma = [headerView viewWithTag:14];
        [UIView animateWithDuration:0.25 animations:^{
            sliderIma.frame = CGRectMake(0, 33, self.mainView.frame.size.width/2.0, 2);
        }];
    }else if (segmentTag == 11){
        for(NSInteger i=0;i<3;i++){
            UIButton *btn = [headerView viewWithTag:i+10];
            btn.frame = CGRectMake(self.mainView.frame.size.width/3.0*i + 0, 0, self.mainView.frame.size.width/3.0, 35);
            if(i == 0){
                [btn setTitle:@"用户等级" forState:UIControlStateNormal];
            }else if(i == 1){
                [btn setTitle:@"发布时间" forState:UIControlStateNormal];
            }else{
                [btn setTitle:@"二串一" forState:UIControlStateNormal];
            }
        }
        UIImageView *sliderIma = [headerView viewWithTag:14];
        [UIView animateWithDuration:0.25 animations:^{
            sliderIma.frame = CGRectMake(0, 33, self.mainView.frame.size.width/3.0, 2);
        }];
    }
    [myCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    [myCollection reloadData];
    
    if(button.tag == 10){
        if(![[starArym objectAtIndex:0] count]){
            [self getStarExpertRequestWithLotteryClassCode:@"-201" page:@"1"];
        }
    }else if (button.tag == 11){
        if(![[squareArym objectAtIndex:0] count]){
            [self getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"-201" Type:@"0" OrderFlag:@"0" page:@"1"];
        }
    }else if (button.tag == 12){
        if(![[redArym objectAtIndex:0] count]){
            [self getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"-201" Type:@"1" OrderFlag:@"2" page:@"1"];
        }
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger buttonTag = scrollView.contentOffset.x/self.view.frame.size.width;
    
    UIImageView *sliderIma = [headerView viewWithTag:14];
    [UIView animateWithDuration:0.25 animations:^{
        if(segmentTag == 10){
            sliderIma.frame = CGRectMake((self.mainView.frame.size.width/2.0)*buttonTag, 33, self.mainView.frame.size.width/2.0, 2);
        }else if (segmentTag == 11){
            sliderIma.frame = CGRectMake((self.mainView.frame.size.width/3.0)*buttonTag, 33, self.mainView.frame.size.width/3.0, 2);
        }else if (segmentTag == 12){
            sliderIma.frame = CGRectMake((self.mainView.frame.size.width/2.0)*buttonTag, 33, self.mainView.frame.size.width/2.0, 2);
        }
    }];
    
    if(segmentTag == 10){
        if(![[starArym objectAtIndex:buttonTag] count]){
            if(buttonTag == 0){
                [self getStarExpertRequestWithLotteryClassCode:@"-201" page:@"1"];
            }else if (buttonTag == 1){
                [self getStarExpertRequestWithLotteryClassCode:@"201" page:@"1"];
            }
        }
    }else if (segmentTag == 11){
        if(![[squareArym objectAtIndex:buttonTag] count]){
            if(buttonTag == 0){
                [self getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"-201" Type:@"0" OrderFlag:@"0" page:@"1"];
            }else if (buttonTag == 1){
                [self getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"-201" Type:@"0" OrderFlag:@"1" page:@"1"];
            }else if (buttonTag == 2){
                [self getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"201" Type:@"0" OrderFlag:@"0" page:@"1"];
            }
        }
    }else if (segmentTag == 12){
        if(![[redArym objectAtIndex:buttonTag] count]){
            if(buttonTag == 0){
                [self getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"-201" Type:@"1" OrderFlag:@"2" page:@"1"];
            }else if (buttonTag == 1){
                [self getSquareAndRedPersonExpertRequestWithLotteyClassCode:@"201" Type:@"1" OrderFlag:@"3" page:@"1"];
            }
        }
    }
//    [myCollection reloadData];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}
-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dimissAlert:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
}
-(void)coinButtonItemAtCollectionIndexPath:(NSIndexPath *)collectionIndex tableViewIndexPath:(NSIndexPath *)tableViewIndex{
    
    NSArray *dataAry;
    if(segmentTag == 10){
        dataAry = [NSMutableArray arrayWithArray:starArym];
    }else if (segmentTag == 11){
        dataAry = [NSMutableArray arrayWithArray:squareArym];
    }else if (segmentTag == 12){
        dataAry = [NSMutableArray arrayWithArray:redArym];
    }
    NSLog(@"单击了某个方案响应函数");
    NSMutableArray *ary = [dataAry objectAtIndex:collectionIndex.row];
    ExpertMainListModel *model = [ary objectAtIndex:tableViewIndex.row];
    
    [self getIsBuyInfoWithOrderID:model];
}
-(void)getIsBuyInfoWithOrderID:(ExpertMainListModel *)data{//获取是否购买
    
    Info *info = [Info getInstance];
    if (![info.userId intValue]){
        [self toLogin];
        return;
    }
    erAgintOrderId = data.ER_AGINT_ORDER_ID;
    disPrice = data.DISCOUNTPRICE;
    [MobClick event:@"Zj_fangan_20161014_jingcai_fangan" label:[NSString stringWithFormat:@"%@VS%@",data.HOME_NAME1,data.AWAY_NAME1]];
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"verifyIsBuyPlanByUserNameErAgintOrderId" forKey:@"methodName"];
    [bodyDic setObject:@{@"loginUserName":[[Info getInstance] userName],@"er_agint_order_id":data.ER_AGINT_ORDER_ID} forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSLog(@"responseJSON=%@",responseJSON);
        NSDictionary *dict = responseJSON[@"result"];//返回编码: 0000：已经购买; 0400:没有购买
        if ([[dict valueForKey:@"code"] isEqualToString:@"0000"]) {
            
            ProjectDetailViewController *proVC=[[ProjectDetailViewController alloc] init];
            proVC.erAgintOrderId=data.ER_AGINT_ORDER_ID;
            proVC.pdLotryType = @"-201";
            proVC.isSdOrNo=NO;
            [self.navigationController pushViewController:proVC animated:YES];
            
        }else if([[dict valueForKey:@"code"] isEqualToString:@"0400"]){
            [self addDealPurchaseTicket:disPrice tag:601];
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
//                                                             message:[NSString stringWithFormat:@"您将支付(%.0f金币)购买此方案内容",str * jinbibeishu]
//                                                            delegate:self
//                                                   cancelButtonTitle:@"取消"
//                                                   otherButtonTitles:@"确定", nil];
//#else
//    CP_UIAlertView *_cpAlert = [[CP_UIAlertView alloc] initWithTitle:@"支付"
//                                                             message:[NSString stringWithFormat:@"您将支付(%.2f元)购买此推荐",str]
//                                                            delegate:self
//                                                   cancelButtonTitle:@"取消"
//                                                   otherButtonTitles:@"确定", nil];
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
        proVC.isSdOrNo=NO;
        //        _nPlanBtn.paidStatus=@"1";
        [self.navigationController pushViewController:proVC animated:YES];
    }
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