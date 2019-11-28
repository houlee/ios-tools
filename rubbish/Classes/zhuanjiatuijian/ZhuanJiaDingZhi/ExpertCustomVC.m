//
//  ExpertCustomVC.m
//  Experts
//
//  Created by v1pin on 15/10/29.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "ExpertCustomVC.h"
#import "SMGDetailViewController.h"
#import "ExpCusView.h"
#import "ExpertJingjiModel.h"
#import "MoreConcnVc.h"
#import "SharedMethod.h"

@interface ExpertCustomVC ()<UITableViewDelegate,UITableViewDataSource>{
    UISegmentedControl *segmentCT;
    NSInteger currentPage;
}

//@property (nonatomic,copy)  UIScrollView *scExpCus;
@property (nonatomic,strong) UIImageView *noCstExpImgV;

@property (nonatomic,strong) NSString *expertType;

@property (nonatomic,strong) NSMutableArray *exFocusArr;

@property (nonatomic,strong) UITableView *expertCustomTable;

@end

@implementation ExpertCustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title_nav = @"特邀专家";
        
    //CGSize btnsize=[PublicMethod setNameFontSize:@"更多关注" andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    //UIButton *mConBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //[mConBtn setFrame:CGRectMake(MyWidth - btnsize.width-15*MyWidth/320, HEIGHTBELOESYSSEVER-btnsize.height/2+24, btnsize.width, btnsize.height)];
    //[mConBtn setTitle:@"更多关注" forState:UIControlStateNormal];
    //[mConBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[mConBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    //[mConBtn.titleLabel setFont:FONTTHIRTY];
    //[mConBtn addTarget:self action:@selector(moreGuanzhu) forControlEvents:UIControlEventTouchUpInside];
    //[self.navView addSubview:mConBtn];
    
    [self creatNavView];
    
    [self creatSegmentView];
    
    _expertType=@"001";
    
    [self setupRefresh];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    currentPage=1;
    [self requestData:_expertType page:[NSString stringWithFormat:@"%ld",(long)currentPage]];
}

-(void)creatSegmentView
{
    segmentCT=[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"竞彩",@"数字彩", nil]];
    segmentCT.frame=CGRectMake(15,CGRectGetMaxY(self.navView.frame)+15,MyWidth-30,30);
    segmentCT.selectedSegmentIndex=0;
    segmentCT.tintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"发布方案-确定按钮"]];
    [segmentCT addTarget:self action:@selector(segmentOnClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentCT];
    
    //阴影效果
    UIImageView * shaowImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(segmentCT.frame)+15, MyWidth, 4)];
    shaowImageView.image=[UIImage imageNamed:@"背景-1横条"];
    [self.view addSubview:shaowImageView];
    
    //    _scExpCus=[[UIScrollView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(segmentCT.frame)+19, MyWidth, MyHight-CGRectGetMaxY(segmentCT.frame))];
    //    _scExpCus.backgroundColor=[UIColor clearColor];
    //    [self.view addSubview:_scExpCus];
    
    _expertCustomTable=[[UITableView alloc] init];
    _expertCustomTable.delegate=self;
    _expertCustomTable.dataSource=self;
    _expertCustomTable.hidden=YES;
    _expertCustomTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_expertCustomTable];
}

- (void)addImage{
    _expertCustomTable.hidden=YES;
    UIImage *imgno=[UIImage imageNamed:@"暂无关注"];
    _noCstExpImgV=[[UIImageView alloc] initWithFrame:CGRectMake(MyWidth/2-imgno.size.width/2, MyHight/2-imgno.size.height/2+64, imgno.size.width, imgno.size.height)];
    _noCstExpImgV.image=imgno;
    [self.view addSubview:_noCstExpImgV];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat count=0;
    if ([_exFocusArr count]%4!=0.0) {
        count=[_exFocusArr count]/4+1;
    }else
        count=[_exFocusArr count]/4;
    return 112*count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_exFocusArr count]!=0) {
        return 1;
    }else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier=@"cell";
    UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    for (int i=0; i<[_exFocusArr count]; i++) {
        ExpertJingjiModel *exFocMdl=[_exFocusArr objectAtIndex:i];
        
        NSInteger a=i%4,b=i/4;
        ExpCusView *expCusView=[[ExpCusView alloc] initWithFrame:CGRectMake(a*MyWidth/4, b*112, MyWidth/4, 112)];
        expCusView.tag=100+i;
        if (b==0) {
            UIView *sepHorizon=[[UIView alloc] initWithFrame:CGRectMake(0, -2, expCusView.frame.size.width, 2)];
            sepHorizon.backgroundColor=SEPARATORCOLOR;
            [expCusView addSubview:sepHorizon];
        }
        [expCusView creatView];
        [expCusView setPortImg:exFocMdl.HEAD_PORTRAIT charaName:exFocMdl.EXPERTS_NICK_NAME hasFocus:exFocMdl.SOURCE];
        [cell addSubview:expCusView];
        
        UITapGestureRecognizer *tapPort=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailClick:)];
        expCusView.userInteractionEnabled=YES;
        [expCusView addGestureRecognizer:tapPort];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)moreGuanzhu{
    MoreConcnVc *moreCncnVc=[[MoreConcnVc alloc] init];
    moreCncnVc.expertType=_expertType;
    [self.navigationController pushViewController:moreCncnVc animated:YES];
}

#pragma mark -segment的单击响应方法
-(void)segmentOnClick:(UISegmentedControl *)segment
{
    currentPage=1;
    _expertCustomTable.userInteractionEnabled=NO;
    NSInteger index=segment.selectedSegmentIndex;
    switch (index) {
        case 0:
        {
            _expertType=@"001";
            [self requestData:_expertType page:[NSString stringWithFormat:@"%ld",(long)currentPage]];
            break;
        }
        case 1:
        {
            _expertType=@"002";
            [self requestData:_expertType page:[NSString stringWithFormat:@"%ld",(long)currentPage]];
            break;
        }
        default:
            break;
    }
}

/**
 *  请求网络数据
 */
-(void)requestData:(NSString *)str page:(NSString *)page
{
    //    for(UIView *view in [_scExpCus subviews]){
    //        [view removeFromSuperview];
    //    }
    if (_noCstExpImgV) {
        [_noCstExpImgV removeFromSuperview];
        _noCstExpImgV=nil;
    }
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getErExpertsList",@"parameters":@{@"expertClassCode":str,@"userName":nameSty,@"type":@"",@"curPage":page,@"pageSize":@"20",@"sid":info.cbSID}}];

    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        _expertCustomTable.userInteractionEnabled=YES;
        if ([responseJSON[@"resultCode"] isEqualToString:@"0000"]) {
            NSArray *focArr=[responseJSON objectForKey:@"result"][@"data"];
            if (focArr&&[focArr count]!=0) {
                NSMutableArray *mutlArr=[NSMutableArray array];
                for (NSDictionary * dic in focArr) {
                    [mutlArr addObject:[ExpertJingjiModel expertJingjiWithDic:dic]];
                }
                if ([page isEqualToString:@"1"]) {
                    [_exFocusArr removeAllObjects];
                    _exFocusArr=nil;
                    _exFocusArr=mutlArr;
                }else
                    [_exFocusArr addObjectsFromArray:mutlArr];
                
                //for (int i=0; i<[_exFocusArr count]; i++) {
                //     ExpertJingjiModel *exFocMdl=[_exFocusArr objectAtIndex:i];
                //     NSInteger a=i%4,b=i/4;
                //     ExpCusView *expCusView=[[ExpCusView alloc] initWithFrame:CGRectMake(a*MyWidth/4, b*112, MyWidth/4, 112)];
                //     expCusView.tag=100+i;
                //     if (b==0) {
                //         UIView *sepHorizon=[[UIView alloc] initWithFrame:CGRectMake(0, -2, expCusView.frame.size.width, 2)];
                //         sepHorizon.backgroundColor=SEPARATORCOLOR;
                //         [expCusView addSubview:sepHorizon];
                //     }
                //     [expCusView creatView];
                //     [expCusView setPortImg:exFocMdl.HEAD_PORTRAIT charaName:exFocMdl.EXPERTS_NICK_NAME hasFocus:exFocMdl.SOURCE];
                //     [_scExpCus addSubview:expCusView];
                //     UITapGestureRecognizer *tapPort=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailClick:)];
                //     expCusView.userInteractionEnabled=YES;
                //     [expCusView addGestureRecognizer:tapPort];
                //}
                //[_scExpCus setContentSize:CGSizeMake(MyWidth, ([_exFocusArr count]-1)/4*112)];
                NSInteger count=0;
                if ([_exFocusArr count]%4!=0.0) {
                    count=[_exFocusArr count]/4+1;
                }else
                    count=[_exFocusArr count]/4;
                [_expertCustomTable setFrame:CGRectMake(0, CGRectGetMaxY(segmentCT.frame)+19, MyWidth, 112*count)];
                if (112*count>MyHight-CGRectGetMaxY(segmentCT.frame)) {
                    [_expertCustomTable setFrame:CGRectMake(0, CGRectGetMaxY(segmentCT.frame)+19, MyWidth, MyHight-CGRectGetMaxY(segmentCT.frame)-19)];
                }
                if ([page integerValue]>1) {
                    currentPage++;
                }
                _expertCustomTable.hidden=NO;
                [_expertCustomTable reloadData];
            }else{
                if (![page isEqualToString:@"1"]) {
                    UIAlertView *accountart = [[UIAlertView alloc]initWithTitle:nil message:@"没有更多啦！" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                    [accountart show];
                    [self performSelector:@selector(dimissAlert:) withObject:accountart afterDelay:1.0f];
                }else{
                    [self addImage];
                }
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([page isEqualToString:@"1"]) {
                [_expertCustomTable.header endRefreshing];
            }else
                [_expertCustomTable.footer endRefreshing];
        });
        
    } failure:^(NSError * error) {
        _expertCustomTable.userInteractionEnabled=YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([page isEqualToString:@"1"]) {
                [_expertCustomTable.header endRefreshing];
            }else
                [_expertCustomTable.footer endRefreshing];
        });
    }];
}

- (void)detailClick:(UITapGestureRecognizer *)sender{
    ExpCusView *lab=(ExpCusView *)sender.view;
    ExpertJingjiModel *expertList=[_exFocusArr objectAtIndex:lab.tag-100];
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    NSString *lotry=@"";
    if ([_expertType isEqualToString:@"001"]) {
        lotry=@"-201";
    }else if ([_expertType isEqualToString:@"002"]){
        lotry=@"001";
    }
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
    [bodyDic setObject:@{@"expertsName":expertList.EXPERTS_NAME,@"expertsClassCode":_expertType,@"loginUserName":nameSty,@"erAgintOrderId":@"",@"type":@"0",@"sid":info.cbSID,@"lotteryClassCode":lotry} forKey:@"parameters"];

    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSDictionary *dic=responseJSON[@"result"][@"expertBaseInfo"];
        ExpertBaseInfo *exBase=[ExpertBaseInfo  expertBaseInfoWithDic:dic];
        
        SMGDetailViewController * vc=[[SMGDetailViewController alloc]init];
        if ([_expertType isEqualToString:@"001"]) {
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
            vc.segmentOnClickIndexFlags=YES;
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
            
            vc.lotryType=101;
            vc.segmentOnClickIndexFlags=NO;
        }
        vc.exBaseInfo=exBase;
        vc.hidesBottomBarWhenPushed=YES;
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

- (void)setupRefresh
{
    //下拉刷新
    _expertCustomTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_expertCustomTable.header];
    
    //上拉加载
    _expertCustomTable.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_expertCustomTable.footer];
    
}

- (void)NearheaderRereshing
{
    currentPage=1;
    [self requestData:_expertType page:[NSString stringWithFormat:@"%ld",(long)currentPage]];;
}

- (void)NearfooterRereshing
{
    NSInteger page=currentPage+1;
    [self requestData:_expertType page:[NSString stringWithFormat:@"%ld",(long)page]];
}

-(void)dimissAlert:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
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