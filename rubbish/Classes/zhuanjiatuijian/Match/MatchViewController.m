//
//  MatchViewController.m
//  Experts
//
//  Created by V1pin on 15/10/26.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "MatchViewController.h"
#import "MLNavigationController.h"
#import "MatchTableViewCell.h"

#import "MatchDetailVC.h"
#import "searchVC.h"

#import "MatchVCModel.h"
#import "SharedMethod.h"
#import "MobClick.h"
#import "ExpertRaceListTableViewCell.h"

@interface MatchViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UITableView *jcTableView;
@property(nonatomic,strong)UITableView *ypTableView;

@property(nonatomic,strong)NSMutableArray *jcMulArr;
@property(nonatomic,strong)NSMutableArray *ypMulArr;

@property(nonatomic,assign)NSInteger jcurrPage;
@property(nonatomic,assign)NSInteger ycurrPage;

@property(nonatomic,strong)UIButton *jcBtn;
@property(nonatomic,strong)UIButton *ypBtn;

@property(nonatomic,strong)NSString *typeSource;//彩种(1、竞足，2、亚盘)

@property(nonatomic,strong) UIView *noMatchView;

@end

@implementation MatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.title_nav = @"赛程";
#if !defined YUCEDI && !defined DONGGEQIU
    [self creatNavView];
#endif
    
    NSString *btnText=@"";
    UIButton *btn;
    for (int i=0; i<2; i++) {
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(27+(MyWidth-62)/2*i, HEIGHTBELOESYSSEVER, (MyWidth-62)/2, 44)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithRed:170.0/255.0 green:218.0/255.0 blue:252.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        if (i==0) {
            btn.selected=YES;
            _jcBtn=btn;
            btnText=@"竞足";
        }else if(i==1){
            _ypBtn=btn;
//            btnText=@"亚盘";
            btnText=@"篮彩";
        }
        [btn setTitle:btnText forState:UIControlStateNormal];
        [btn setTitle:btnText forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnMatchClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=FONTTHIRTY;
        [self.navView addSubview:btn];
    }
//    self.title_nav = @"竞足";
    if (!self.isSdOrNo) {
        UIImage *searchImage=[UIImage imageNamed:@"椭圆"];//添加搜索按钮
        [self rightImgAndAction:searchImage target:self action:@selector(searchBtn:)];
        [self.rightBtn setImageEdgeInsets:UIEdgeInsetsMake(HEIGHTBELOESYSSEVER+12, 25, 32-searchImage.size.height, 35-searchImage.size.width)];
    }

    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, MyHight-HEIGHTBELOESYSSEVER-44-49)];
    _scrollView.backgroundColor=[UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.contentSize=CGSizeMake(MyWidth*2, MyHight-HEIGHTBELOESYSSEVER-44-49);
    _scrollView.delegate=self;
    _scrollView.bounces=NO;
    [self.view addSubview:_scrollView];
    
    [self creatMatchTableView];
    [self setupRefresh];
    
    _typeSource=@"-201";
    _jcurrPage=1;
    _ycurrPage=1;
    [self requestData:_jcurrPage];
}

-(void)creatMatchTableView
{
    _jcTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, MyWidth, _scrollView.frame.size.height) style:UITableViewStylePlain];
    _jcTableView.showsHorizontalScrollIndicator=NO;
    _jcTableView.showsVerticalScrollIndicator=NO;
    _jcTableView.delegate=self;
    _jcTableView.dataSource=self;
    _jcTableView.tag=101;
    _jcTableView.separatorColor=SEPARATORCOLOR;
    [_scrollView addSubview:_jcTableView];
    _jcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _ypTableView=[[UITableView alloc]initWithFrame:CGRectMake(MyWidth, 0, MyWidth, _scrollView.frame.size.height) style:UITableViewStylePlain];
    _ypTableView.showsHorizontalScrollIndicator=NO;
    _ypTableView.showsVerticalScrollIndicator=NO;
    _ypTableView.delegate=self;
    _ypTableView.dataSource=self;
    _ypTableView.tag=102;
    _ypTableView.separatorColor=SEPARATORCOLOR;
    [_scrollView addSubview:_ypTableView];
}

- (void)btnMatchClick:(UIButton *)btn{
    if(_noMatchView){
        [_noMatchView removeFromSuperview];
        _noMatchView=nil;
    }
    btn.selected=YES;
    if (btn==_jcBtn) {
        _typeSource=@"-201";
        _ypBtn.selected=NO;
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        if (!_jcMulArr) {
            _jcurrPage=1;
            [self requestData:1];
        }
    }else if(btn==_ypBtn){
        _typeSource=@"204";
        _jcBtn.selected=NO;
        [_scrollView setContentOffset:CGPointMake(MyWidth, 0) animated:YES];
        if (!_ypMulArr) {
            _ycurrPage=1;
            [self requestData:1];
        }
    }
}

/**
 *  搜索响应函数
 */
-(void)searchBtn:(UIButton *)btn
{
    SearchVC *vc=[[SearchVC alloc] init];
    vc.isSdOrNo=self.isSdOrNo;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -UITableViewDataSource数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==101) {
        return [_jcMulArr count];
    }else if (tableView.tag==102){
        return [_ypMulArr count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MatchTableViewCell * cell=[MatchTableViewCell matchTableViewCellWithTableView:tableView];
//    MatchVCModel *model;
//    if (tableView.tag==101) {
//        model=[_jcMulArr objectAtIndex:indexPath.row];
//    }else if (tableView.tag==102){
//        model=[_ypMulArr objectAtIndex:indexPath.row];
//    }
//    [cell setDataWithMatchMdl:model];
//    return  cell;
    
    NSString * raceCell = @"raceCell";
    ExpertRaceListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:raceCell];
    if (!cell) {
        cell = [[ExpertRaceListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:raceCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MatchVCModel *model;
    if (tableView.tag==101) {
        model=[_jcMulArr objectAtIndex:indexPath.row];
    }else if (tableView.tag==102){
        model=[_ypMulArr objectAtIndex:indexPath.row];
    }
    [cell loadAppointInfo:model];
    return cell;
}

#pragma mark ----------UITableViewDelegate--------------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 69.5;
    return 55;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MatchDetailVC * vc=[[MatchDetailVC alloc] init];
    MatchVCModel *model;
    if (tableView.tag==101) {
        model=[_jcMulArr objectAtIndex:indexPath.row];
        [MobClick event:@"Zj_saicheng_20161014_jingcai" label:[NSString stringWithFormat:@"%@VS%@",model.hostNameSimply,model.guestNameSimply]];
    }else if (tableView.tag==102){
        model=[_ypMulArr objectAtIndex:indexPath.row];
        [MobClick event:@"Zj_saicheng_20161014_yapan" label:[NSString stringWithFormat:@"%@VS%@",model.hostNameSimply,model.guestNameSimply]];
    }
    vc.playId=[model playId];
    vc.matchModel=model;
    vc.matchSource=_typeSource;
    vc.isSdOrNo=self.isSdOrNo;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -------刷新----------

- (void)setupRefresh
{
    _jcTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_jcTableView.header];
    
    _jcTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_jcTableView.footer];
    
    _ypTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_ypTableView.header];
    
    _ypTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_ypTableView.footer];
    
}

#pragma mark 开始进入刷新状态
- (void)NearheaderRereshing
{
    if ([_typeSource isEqualToString:@"-201"]) {
        _jcurrPage=1;
        [self requestData:_jcurrPage];
    }else if([_typeSource isEqualToString:@"204"]){
        _ycurrPage=1;
        [self requestData:_ycurrPage];
    }
}

#pragma mark - 加载
- (void)NearfooterRereshing
{
    NSInteger curPage;
    if ([_typeSource isEqualToString:@"-201"]) {
        curPage=_jcurrPage+1;
    }else if([_typeSource isEqualToString:@"204"]){
        curPage=_ycurrPage+1;
    }
    [self requestData:curPage];
}

/**
 *  请求网络数据
 */
-(void)requestData:(NSInteger)currentPage
{
    if(_noMatchView){
        [_noMatchView removeFromSuperview];
        _noMatchView=nil;
    }
    NSString *sourPara=@"";
    if ([_typeSource isEqualToString:@"-201"]) {
        sourPara=@"1";
    }else if([_typeSource isEqualToString:@"204"]){
        sourPara=@"4";
    }
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"sMGExpertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getLeastMatchList" forKey:@"methodName"];
    NSDictionary * parametersDic=@{@"currPage":[NSString stringWithFormat:@"%ld",(long)currentPage],@"pageSize":@"20",@"sid":[[Info getInstance] cbSID],@"source":sourPara,@"sdFlag":[NSString stringWithFormat:@"%i",self.isSdOrNo]};
    
    [bodyDic setObject:parametersDic forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSDictionary * bodyData=[responseJSON valueForKey:@"result"];
            NSArray * dataArr = [bodyData objectForKey:@"data"];
            if ([dataArr count]!=0) {
                NSMutableArray * mulArr=[NSMutableArray array];
                for (NSDictionary * dic in dataArr) {
                    [mulArr addObject:[MatchVCModel MatchVCModelWithDic:dic]];
                }
                if (currentPage>1) {
                    if ([_typeSource isEqualToString:@"-201"]) {
                        [_jcMulArr addObjectsFromArray:mulArr];;
                        _jcurrPage++;
                    }else if([_typeSource isEqualToString:@"204"]){
                        [_ypMulArr addObjectsFromArray:mulArr];;
                        _ycurrPage++;
                    }
                }else if(currentPage==1){
                    if ([_typeSource isEqualToString:@"-201"]) {
                        [_jcMulArr removeAllObjects];
                        _jcMulArr=mulArr;
                    }else if ([_typeSource isEqualToString:@"204"]) {
                        [_ypMulArr removeAllObjects];
                        _ypMulArr=mulArr;
                    }
                }
                if ([_typeSource isEqualToString:@"-201"]) {
                    [_jcTableView reloadData];
                }else if ([_typeSource isEqualToString:@"204"]) {
                    [_ypTableView reloadData];
                }
            } else {
                //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"没有更多啦！" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                //[alert show];
                //[self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
            }
        } else {
            if (currentPage==1) {
                    _noMatchView=[[UIView alloc] init];
                    _noMatchView.backgroundColor=[UIColor clearColor];
                    if([_typeSource isEqualToString:@"-201"]){
                        [_noMatchView setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, 320, MyHight-HEIGHTBELOESYSSEVER-44-49)];
                    }else if ([_typeSource isEqualToString:@"204"]){
                        [_noMatchView setFrame:CGRectMake(320, HEIGHTBELOESYSSEVER+44, 320, MyHight-HEIGHTBELOESYSSEVER-44-49)];
                    }
                    [_scrollView addSubview:_noMatchView];
                    
                    UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(125, (_noMatchView.frame.size.height-92.5)/2-80, 70, 92.5)];
                    imgV.image=[UIImage imageNamed:@"norecon"];
                    [_noMatchView addSubview:imgV];
                    
                    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(60, ORIGIN_Y(imgV)+10, 200, 40)];
                    lab.backgroundColor=[UIColor clearColor];
                    lab.text=@"近期没有比赛";
                    lab.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
                    lab.textAlignment=NSTextAlignmentCenter;
                    lab.font=FONTTHIRTY_TWO;
                    [_noMatchView addSubview:lab];
            }
            //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            //[alert show];
            //[self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_jcTableView.header endRefreshing];
            [_jcTableView.footer endRefreshing];
            [_ypTableView.header endRefreshing];
            [_ypTableView.footer endRefreshing];
        });
    } failure:^(NSError * error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_jcTableView.header endRefreshing];
            [_jcTableView.footer endRefreshing];
            [_ypTableView.header endRefreshing];
            [_ypTableView.footer endRefreshing];
        });
    }];
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

#define mark -----------UIScrollViewDelegate------------------
- (void)setScrollContent{
    CGPoint offset=_scrollView.contentOffset;
    if (offset.x<MyWidth/2) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (offset.x>=MyWidth/2&&offset.x<MyWidth*3/2) {
        [_scrollView setContentOffset:CGPointMake(MyWidth, 0) animated:YES];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if(_noMatchView){
        [_noMatchView removeFromSuperview];
        _noMatchView=nil;
    }
    [self setScrollContent];
    CGPoint offset=_scrollView.contentOffset;
    if (offset.x<MyWidth/2) {
        _typeSource=@"-201";
        _jcBtn.selected=YES;
        _ypBtn.selected=NO;
        if (!_jcMulArr) {
            _jcurrPage=1;
            [self requestData:1];
        }
    }else if (offset.x>=MyWidth/2&&offset.x<MyWidth*3/2) {
        _typeSource=@"204";
        _jcBtn.selected=NO;
        _ypBtn.selected=YES;
        if (!_ypMulArr) {
            _ycurrPage=1;
            [self requestData:1];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setScrollContent];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self setScrollContent];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    