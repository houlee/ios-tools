  //
//  GqRecVc.m
//  caibo
//
//  Created by zhoujunwang on 16/5/26.
//
//

#import "GqRecVc.h"
#import "GqZJVc.h"
#import "GqRecCell.h"
#import "GqMdl.h"
#import "SharedMethod.h"

@interface GqRecVc ()<UITableViewDelegate,UITableViewDataSource>{
    NSTimer *timer;
}

@property(nonatomic,strong)UIImageView *topImgView;
@property(nonatomic,strong)UITableView *gqRecTableView;

@property(nonatomic,strong)NSArray *matchingArr;
@property(nonatomic,strong)NSMutableArray *matchWaitArr;

@property(nonatomic,assign)NSInteger totalPage;
@property(nonatomic,assign)NSInteger currentPage;

@property(nonatomic,strong)UIView *noRecView;

@end

@implementation GqRecVc

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (timer&&[timer isValid]) {
        [timer invalidate];
        timer=nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatNavView];
    self.title_nav=@"滚球推荐";
    self.view.backgroundColor = [UIColor colorWithHexString:@"ecedf1"];
    
    _topImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, 105)];
    _topImgView.image=[UIImage imageNamed:@"gqXuanChuan"];
    _topImgView.backgroundColor=[UIColor colorWithHexString:@"ecedf1"];
    [self.view addSubview:_topImgView];
    
    _gqRecTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, 320, MyHight-HEIGHTBELOESYSSEVER-44) style:UITableViewStyleGrouped];
    _gqRecTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _gqRecTableView.showsHorizontalScrollIndicator=NO;
    _gqRecTableView.showsVerticalScrollIndicator=NO;
    _gqRecTableView.delegate=self;
    _gqRecTableView.dataSource=self;
    _gqRecTableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_gqRecTableView];
    _gqRecTableView.tableHeaderView=_topImgView;
    
    [self setupRefresh];
    
    _currentPage=1;
    [self getGqRecMatchList:@"1"];
    
    timer=[NSTimer scheduledTimerWithTimeInterval:30.0f target:self selector:@selector(updateGqMatchTime) userInfo:nil repeats:YES];
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    
}

- (void)updateGqMatchTime{
    [self getGqRecMatchList:[NSString stringWithFormat:@"%ld",(long)_currentPage]];
}

#pragma mark -------------UITableViewDelegate--------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger heightRow=109.5;
    if(_matchingArr==nil||[_matchingArr count]==0){
        if (_matchWaitArr==nil||[_matchWaitArr count]==0){
            heightRow=0.0;
        }else{
            if (indexPath.row==[_matchWaitArr count]-1) {
                heightRow=103.5;
            }
        }
    }else{
        if (_matchWaitArr==nil||[_matchWaitArr count]==0){
            if (indexPath.row==[_matchingArr count]-1) {
                heightRow=103.5;
            }
        }else{
            if ((indexPath.section==0&&indexPath.row==[_matchingArr count]-1)||(indexPath.section==1&&indexPath.row==[_matchWaitArr count]-1)) {
                heightRow=103.5;
            }
        }
    }
    return heightRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
    view.backgroundColor=[UIColor clearColor];
    
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(15, 11.5, 2, 12)];
    imgView.backgroundColor=[UIColor clearColor];
    [view addSubview:imgView];
    
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(27, 11.5, 100, 12)];
    lab.textColor=BLACK_EIGHTYSEVER;
    lab.font=FONTTWENTY_FOUR;
    lab.backgroundColor=[UIColor clearColor];
    [view addSubview:lab];
    
    NSString *imgName=@"gqRed";
    NSString *txt=@"比赛中";
    if(_matchingArr==nil||[_matchingArr count]==0){
        if (_matchWaitArr!=nil&&[_matchWaitArr count]!=0){
            imgName=@"gqOrange";
            txt=@"未开赛";
        }
    }else{
        if (_matchWaitArr!=nil||[_matchWaitArr count]!=0){
            if (section==1) {
                imgName=@"gqOrange";
                txt=@"未开赛";
            }
        }
    }
    imgView.image=[UIImage imageNamed:imgName];
    lab.text=txt;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    GqMatchInfoMdl *gqInfoMdl;
    GqZJVc *gqZJVc=[[GqZJVc alloc] init];
    if(_matchingArr==nil||[_matchingArr count]==0){
        if (_matchWaitArr!=nil&&[_matchWaitArr count]!=0){
            gqInfoMdl=[_matchWaitArr objectAtIndex:indexPath.row];
        }
    }else{
        if (_matchWaitArr==nil||[_matchWaitArr count]==0){
            gqInfoMdl=[_matchingArr objectAtIndex:indexPath.row];
        }else{
            if (indexPath.section==0) {
                gqInfoMdl=[_matchingArr objectAtIndex:indexPath.row];
            }else if (indexPath.section==1) {
                gqInfoMdl=[_matchWaitArr objectAtIndex:indexPath.row];
            }
        }
    }
    gqZJVc.playId=gqInfoMdl.PLAY_ID;
    [self.navigationController pushViewController:gqZJVc animated:YES];
}

#pragma mark -------------UITableViewDataSource--------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger sectNo=0;
    if(_matchingArr==nil||[_matchingArr count]==0){
        if (_matchWaitArr==nil||[_matchWaitArr count]==0){
            sectNo=0;
        }else
            sectNo=[_matchWaitArr count];
    }else{
        if (_matchWaitArr==nil||[_matchWaitArr count]==0){
            sectNo=[_matchingArr count];
        }else{
            if (section==0) {
                sectNo=[_matchingArr count];
            }else if (section==1) {
                sectNo=[_matchWaitArr count];
            }
        }
    }
    return sectNo;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    GqRecCell *cell=(GqRecCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[GqRecCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    GqMatchInfoMdl *gqInfoMdl;
    if(_matchingArr==nil||[_matchingArr count]==0){
        if (_matchWaitArr!=nil&&[_matchWaitArr count]!=0){
            gqInfoMdl=[_matchWaitArr objectAtIndex:indexPath.row];
            NSString *leagueStr=[NSString stringWithFormat:@"%@  %@",gqInfoMdl.LEAGUE_NAME,gqInfoMdl.DAY_WEEK];
            NSArray *timeArr = [gqInfoMdl.MATCH_TIME componentsSeparatedByString:@" "];
            NSString *score=[timeArr objectAtIndex:0];
            NSString *gameTime=[timeArr objectAtIndex:1];
            [cell setHostName:gqInfoMdl.HOME_NAME score:score guestName:gqInfoMdl.AWAY_NAME gameTime:gameTime leagueTime:leagueStr recNo:gqInfoMdl.RECOMMEND_COUNT];
        }
    }else{
        if (_matchWaitArr==nil||[_matchWaitArr count]==0){
            gqInfoMdl=[_matchingArr objectAtIndex:indexPath.row];
            NSString *scoreStr=[NSString stringWithFormat:@"%@:%@",gqInfoMdl.HOME_SCORE,gqInfoMdl.AWAY_SCORE];
            NSString *leagueStr=[NSString stringWithFormat:@"%@  %@",gqInfoMdl.LEAGUE_NAME,gqInfoMdl.DAY_WEEK];
            [cell setHostName:gqInfoMdl.HOME_NAME score:scoreStr guestName:gqInfoMdl.AWAY_NAME gameTime:[NSString stringWithFormat:@"%@'",gqInfoMdl.HAS_BEEN_MINUTES] leagueTime:leagueStr recNo:gqInfoMdl.RECOMMEND_COUNT];
        }else{
            if (indexPath.section==0) {
                gqInfoMdl=[_matchingArr objectAtIndex:indexPath.row];
                NSString *scoreStr=[NSString stringWithFormat:@"%@:%@",gqInfoMdl.HOME_SCORE,gqInfoMdl.AWAY_SCORE];
                NSString *leagueStr=[NSString stringWithFormat:@"%@  %@",gqInfoMdl.LEAGUE_NAME,gqInfoMdl.DAY_WEEK];
                [cell setHostName:gqInfoMdl.HOME_NAME score:scoreStr guestName:gqInfoMdl.AWAY_NAME gameTime:[NSString stringWithFormat:@"%@'",gqInfoMdl.HAS_BEEN_MINUTES] leagueTime:leagueStr recNo:gqInfoMdl.RECOMMEND_COUNT];
            }else if (indexPath.section==1){
                gqInfoMdl=[_matchWaitArr objectAtIndex:indexPath.row];
                NSString *leagueStr=[NSString stringWithFormat:@"%@  %@",gqInfoMdl.LEAGUE_NAME,gqInfoMdl.DAY_WEEK];
                NSArray *timeArr = [gqInfoMdl.MATCH_TIME componentsSeparatedByString:@" "];
                NSString *score=[timeArr objectAtIndex:0];
                NSString *gameTime=[timeArr objectAtIndex:1];
                [cell setHostName:gqInfoMdl.HOME_NAME score:score guestName:gqInfoMdl.AWAY_NAME gameTime:gameTime leagueTime:leagueStr recNo:gqInfoMdl.RECOMMEND_COUNT];
            }

        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_matchingArr==nil||[_matchingArr count]==0){
        if (_matchWaitArr==nil||[_matchWaitArr count]==0){
            return 0;
        }else
            return 1;
    }else{
        if (_matchWaitArr==nil||[_matchWaitArr count]==0){
            return 1;
        }else
            return 2;
    }
    return 0;
}

#pragma mark -----------获取滚球图片-------------
-(void)getGqRecMatchList:(NSString *)page{
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getGqMatchInfoList",@"parameters":@{@"curPage":page,@"pageSize":@"20"}}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSDictionary *dic=[responseJSON objectForKey:@"result"];
            
            NSArray *matchWaitArr=dic[@"matchesWaiting"][@"data"];
            NSMutableArray *matchWaitMtlArr=[NSMutableArray arrayWithCapacity:[matchWaitArr count]];
            for (NSDictionary *dic in matchWaitArr) {
                [matchWaitMtlArr addObject:[GqMatchInfoMdl gqMatchInfoMdlWithDic:dic]];
            }
            if ([page integerValue]==1) {
                _matchingArr=nil;
                NSArray *matchArr=dic[@"matchesPlaying"];
                NSMutableArray *matchMtlArr=[NSMutableArray arrayWithCapacity:[matchArr count]];
                for (NSDictionary *dic in matchArr) {
                    [matchMtlArr addObject:[GqMatchInfoMdl gqMatchInfoMdlWithDic:dic]];
                }
                _matchingArr=matchMtlArr;
                
                _matchWaitArr=nil;
                _matchWaitArr=matchWaitMtlArr;
            }else{
                if (_currentPage!=[page integerValue]) {
                    _currentPage++;
                    [_matchWaitArr addObjectsFromArray:matchWaitMtlArr];
                }
            }
            _totalPage=[dic[@"matchesWaiting"][@"pageInfo"][@"totalPage"] integerValue];
            [_gqRecTableView reloadData];
            
            if((_matchingArr==nil||[_matchingArr count]==0)&&(_matchWaitArr==nil||[_matchWaitArr count]==0)){
                if (!_noRecView) {
                    _noRecView=[[UIView alloc] initWithFrame:CGRectMake(0, 105, 320, _gqRecTableView.frame.size.height-105)];
                    _noRecView.backgroundColor=[UIColor clearColor];
                    [_gqRecTableView addSubview:_noRecView];
                    
                    UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(125,(_noRecView.frame.size.height-162.5)/2, 70, 92.5)];
                    imgV.image=[UIImage imageNamed:@"norecon"];
                    [_noRecView addSubview:imgV];
                    
                    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(60, ORIGIN_Y(imgV)+10, 200, 40)];
                    lab.backgroundColor=[UIColor clearColor];
                    lab.text=@"专家正在发布方案中";
                    lab.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
                    lab.textAlignment=NSTextAlignmentCenter;
                    lab.font=FONTTHIRTY_TWO;
                    [_noRecView addSubview:lab];
                }
            }else{
                if(_noRecView){
                    [_noRecView removeFromSuperview];
                    _noRecView=nil;
                }
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_gqRecTableView.footer endRefreshing];
            [_gqRecTableView.header endRefreshing];
        });
    } failure:^(NSError * error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_gqRecTableView.footer endRefreshing];
            [_gqRecTableView.header endRefreshing];
        });
    }];
}

-(void)dimissAlert:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 刷新
- (void)setupRefresh
{
    _gqRecTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_gqRecTableView.header];
    
    _gqRecTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_gqRecTableView.footer];
}

#pragma mark 开始进入刷新状态
- (void)NearheaderRereshing
{
    _currentPage=1;
    MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)_gqRecTableView.footer;
    f.stateLabel.font=[UIFont systemFontOfSize:17.0f];
    [self getGqRecMatchList:@"1"];
}

#pragma mark - 加载
- (void)NearfooterRereshing
{
    if (_currentPage==_totalPage) {
        [_gqRecTableView.footer noticeNoMoreData];
        MJRefreshBackNormalFooter *f=(MJRefreshBackNormalFooter *)_gqRecTableView.footer;
        f.stateLabel.font=FONTTWENTY_FOUR;
        [f setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
        [f setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
        [f setTitle:@"没有更多啦" forState:MJRefreshStateNoMoreData];
        return;
    }
    NSInteger page=_currentPage+1;
    [self getGqRecMatchList:[NSString stringWithFormat:@"%ld",(long)page]];
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