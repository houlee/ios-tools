//
//  MyConcernVc.m
//  caibo
//
//  Created by zhoujunwang on 15/12/28.
//
//

#import "MyConcernVc.h"
#import "MyConcernM.h"
#import "ExpertDetailCell.h"
#import "MoreConcnVc.h"
#import "SMGDetailViewController.h"
#import "SharedMethod.h"
#import "NSString+ExpertStrings.h"

@interface MyConcernVc ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger currentPage;
}

@property(nonatomic,strong) UITableView *concernTableV;
@property(nonatomic,strong) NSMutableArray *myconcerAry;
@property(nonatomic,strong) UIImageView *noImgView;

@end

@implementation MyConcernVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title_nav=@"我的关注";
    [self creatNavView];
    CGSize btnsize=[PublicMethod setNameFontSize:@"更多关注" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    UIButton *mConBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [mConBtn setFrame:CGRectMake(MyWidth - btnsize.width-15*MyWidth/320, HEIGHTBELOESYSSEVER-btnsize.height/2+24, btnsize.width, btnsize.height)];
    [mConBtn setTitle:@"更多" forState:UIControlStateNormal];
    [mConBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mConBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [mConBtn.titleLabel setFont:FONTTHIRTY];
    [mConBtn addTarget:self action:@selector(moreGuanzhu) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:mConBtn];
    
    [self creatCnTable];
}

- (void)addImage{
    _concernTableV.hidden=YES;
    UIImage *imgno=[UIImage imageNamed:@"暂无关注"];
    _noImgView=[[UIImageView alloc] initWithFrame:CGRectMake(MyWidth/2-imgno.size.width/2, MyHight/2-imgno.size.height/2-32, imgno.size.width, imgno.size.height)];
    _noImgView.image=imgno;
    [self.view addSubview:_noImgView];
}

- (void)creatCnTable{
    _concernTableV=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _concernTableV.delegate=self;
    _concernTableV.dataSource=self;
    _concernTableV.hidden=YES;
    _concernTableV.showsHorizontalScrollIndicator=NO;
    _concernTableV.showsVerticalScrollIndicator=NO;
    _concernTableV.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_concernTableV];
    [self setupRefresh];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    currentPage=1;
    [self myGuangzhu:currentPage];
    
#if defined CRAZYSPORTS
    [self changeCSTitileColor];
#endif
}

- (void)myGuangzhu:(NSInteger)page{
    if (_noImgView) {
        [_noImgView removeFromSuperview];
        _noImgView=nil;
    }
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getMyFocusExpertsPlanList",@"parameters":@{@"expertsName":[[Info getInstance] userName],@"curPage":[NSString stringWithFormat:@"%ld",(long)page],@"flag":@"1",@"pageSize":@"20",@"levelType":@"1"}}];
    
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSDictionary *dic=responseJSON;
        NSArray *arr_plan=dic[@"result"][@"data"];
        NSLog(@"arr_plan===%@",arr_plan);
        if([arr_plan count]!=0){
            NSMutableArray *arr=[NSMutableArray arrayWithCapacity:[arr_plan count]];
            for (NSDictionary *dic in arr_plan) {
                MyConcernM *myCocenM=[MyConcernM MyConcernMWithDic:dic];
                [arr addObject:myCocenM];
            }
            if (page==1) {
                [_myconcerAry removeAllObjects];
                _myconcerAry=nil;
                _myconcerAry=arr;
            }else{
                currentPage++;
                [_myconcerAry addObjectsFromArray:arr];
            }
            [_concernTableV setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, MyHight-64)];
            _concernTableV.hidden=NO;
            [_concernTableV reloadData];
        }else{
            if (page>1) {
                UIAlertView *accountart = [[UIAlertView alloc]initWithTitle:nil message:@"没有更多啦！" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                [accountart show];
                [self performSelector:@selector(dimissAlert:) withObject:accountart afterDelay:1.0f];
            }else{
                [self addImage];
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_concernTableV.header endRefreshing];
            [_concernTableV.footer endRefreshing];
        });
    } failure:^(NSError * error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_concernTableV.header endRefreshing];
            [_concernTableV.footer endRefreshing];
        });
    }];
}

-(void)dimissAlert:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}

- (void)moreGuanzhu{
    MoreConcnVc *moreCncnVc=[[MoreConcnVc alloc] init];
    moreCncnVc.expertType=@"001";
    [self.navigationController pushViewController:moreCncnVc animated:YES];
}

#pragma mark ------------UITableViewDelegate-------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyConcernM *myconcernM=[_myconcerAry objectAtIndex:indexPath.row];
    if ([myconcernM.LOTTEY_CLASS_CODE isEqualToString:@"201"]){
        return 58+45*MyWidth/320+56;
    }
    return 58+45*MyWidth/320;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MyConcernM *myconcernM=[_myconcerAry objectAtIndex:indexPath.row];
    NSString *lotry=@"";
    if([myconcernM.EXPERTS_CLASS_CODE isEqualToString:@"001"]){
        lotry=@"-201";
        if([myconcernM.LOTTEY_CLASS_CODE isEqualToString:@"201"]){
            lotry=@"201";
        }else if ([myconcernM.LOTTEY_CLASS_CODE isEqualToString:@"204"]){
            lotry=@"204";
        }
    }else if([myconcernM.EXPERTS_CLASS_CODE isEqualToString:@"002"]){
        lotry=@"001";
    }
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
    [bodyDic setObject:@{@"expertsName":myconcernM.EXPERTS_NAME,@"expertsClassCode":myconcernM.EXPERTS_CLASS_CODE,@"loginUserName":[[Info getInstance] userName],@"erAgintOrderId":@"",@"type":@"0",@"sid":[[Info getInstance] cbSID],@"lotteryClassCode":lotry} forKey:@"parameters"];

    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        SMGDetailViewController * vc=[[SMGDetailViewController alloc]init];
        
        NSDictionary *dic=responseJSON[@"result"][@"expertBaseInfo"];
        ExpertBaseInfo *exBase=[ExpertBaseInfo  expertBaseInfoWithDic:dic];
        
        if ([myconcernM.EXPERTS_CLASS_CODE isEqualToString:@"001"]) {
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
            vc.jcyplryType=lotry;
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
            
            if([myconcernM.LOTTEY_CLASS_CODE isEqualToString:@"001"]){
                vc.lotryType=101;
            }else if([myconcernM.LOTTEY_CLASS_CODE isEqualToString:@"113"]){
                vc.lotryType=102;
            }else if([myconcernM.LOTTEY_CLASS_CODE isEqualToString:@"002"]){
                vc.lotryType=103;
            }else if([myconcernM.LOTTEY_CLASS_CODE isEqualToString:@"108"]){
                vc.lotryType=104;
            }
        }
        vc.exBaseInfo=exBase;
        if ([myconcernM.EXPERTS_CLASS_CODE isEqualToString:@"001"]) {
            vc.segmentOnClickIndexFlags=YES;
        }else{
            vc.segmentOnClickIndexFlags=NO;
        }
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



#pragma mark ------------UITableViewDataSource---------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_myconcerAry count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExpertDetailCell * cell=[ExpertDetailCell ExpertDetailCellWithTableView:tableView indexPath:indexPath];
    MyConcernM *myconcernM=[_myconcerAry objectAtIndex:indexPath.row];
    CGRect rect=cell.timeLab.frame;
    NSString *hitState=@"";
    NSString *palySides=@"";
    NSString *matchID=@"";
    NSString *lotype = @"";//篮球所加
    if([myconcernM.EXPERTS_CLASS_CODE isEqualToString:@"001"]){
        cell.zhongView.hidden=NO;
        cell.leagueTypeLab.hidden=NO;
        hitState=[NSString stringWithFormat:@"%@中%@",myconcernM.ALL_HIT_NUM,myconcernM.HIT_NUM];
        palySides=[NSString stringWithFormat:@"%@ VS %@",myconcernM.HOME_NAME,myconcernM.AWAY_NAME];
        matchID=[NSString stringWithFormat:@"%@ %@",myconcernM.MATCHES_ID,myconcernM.MATCH_TIME];
        rect.size.width=100;
        if([myconcernM.LOTTEY_CLASS_CODE isEqualToString:@"204"]){
            lotype = myconcernM.LOTTEY_CLASS_CODE;
            NSString *str = @"让分胜负";
            if([myconcernM.PLAY_TYPE_CODE isEqualToString:@"29"]){
                str = @"大小分";
            }
            palySides=[NSString stringWithFormat:@"%@(客)VS%@(主) \n%@ %@",myconcernM.AWAY_NAME,myconcernM.HOME_NAME,str,myconcernM.HOSTRQ];
        }
        
        if([myconcernM.LOTTEY_CLASS_CODE isEqualToString:@"201"]){
            
            [cell.timeLab setFrame:rect];
            
            NSString *matchs2=[NSString stringWithFormat:@"%@ VS %@",myconcernM.HOME_NAME2,myconcernM.AWAY_NAME2];
            
            NSString *compTime2=[NSString stringWithFormat:@"%@ %@",myconcernM.MATCHES_ID2,myconcernM.MATCH_TIME2];
            [cell expertHead:myconcernM.HEAD_PORTRAIT name:myconcernM.EXPERTS_NICK_NAME starNo:myconcernM.STAR odds:hitState matchSides:palySides time:matchID leagueType:myconcernM.LEAGUE_NAME exPrice:myconcernM.PRICE exDiscount:myconcernM.DISCOUNT exRank:myconcernM.SOURCE refundOrNo:myconcernM.FREE_STATUS lotype:myconcernM.LOTTEY_CLASS_CODE name2:matchs2 time2:compTime2 league2:myconcernM.LEAGUE_NAME2];
            
            return  cell;
        }
    }else if([myconcernM.EXPERTS_CLASS_CODE isEqualToString:@"002"]){
        cell.zhongView.hidden=YES;
        cell.leagueTypeLab.hidden=YES;
        palySides=[NSString stringWithFormat:@"%@ %@期", [NSString lotteryTpye:myconcernM.LOTTEY_CLASS_CODE],myconcernM.ER_ISSUE];
        matchID=[NSString stringWithFormat:@"截止时间 %@",myconcernM.END_TIME];
        rect.size.width=150;
    }
    [cell.timeLab setFrame:rect];
    [cell expertHead:myconcernM.HEAD_PORTRAIT name:myconcernM.EXPERTS_NICK_NAME starNo:myconcernM.STAR odds:hitState matchSides:palySides time:matchID leagueType:myconcernM.LEAGUE_NAME exPrice:myconcernM.PRICE exDiscount:myconcernM.DISCOUNT exRank:myconcernM.SOURCE refundOrNo:myconcernM.FREE_STATUS lotype:lotype];
    return  cell;
}

#pragma mark 刷新
- (void)setupRefresh
{
    //下拉刷新
    _concernTableV.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_concernTableV.header];
    //上拉加载
    _concernTableV.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_concernTableV.footer];
}

- (void)NearheaderRereshing
{
    currentPage=1;
    [self myGuangzhu:currentPage];
}

- (void)NearfooterRereshing
{
    NSInteger page=currentPage;
    page++;
    [self myGuangzhu:page];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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