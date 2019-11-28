//
//  ExpertMainViewController.m
//  caibo
//
//  Created by cp365dev6 on 2016/11/21.
//
//

#import "ExpertMainViewController.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "expertTableViewCell.h"
#import "RequestEntity.h"
#import "ExpertJingjiModel.h"
#import "ExpertScrollviewTableViewCell.h"
#import "ExpertMatchListTableViewCell.h"
#import "MatchVCModel.h"
#import "MatchTableViewCell.h"
#import "MatchDetailVC.h"

#import "ExpertMainListModel.h"
#import "ExpertStarListViewController.h"
#import "ExpertRankListViewController.h"
#import "ExpertHornTableViewCell.h"
#import "SMGDetailViewController.h"
#import "MySalesViewController.h"
#import "ExpertNewMainViewController.h"

@interface ExpertMainViewController ()
{
    UITableView *myTableView;
    UIView *sectionHeadView1;
    UIView *sectionHeadView2;
    NSMutableArray *expertListArym;
    NSMutableArray *starExpertArym;
    NSMutableArray *rankExpertArym;
    NSMutableArray *matchListArym;
    NSMutableArray *hornArray;
    int hornCount;
}
@property (nonatomic, retain) ASIHTTPRequest * expertRequest;
@end

@implementation ExpertMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(goBack)];
    self.CP_navigation.title = @"专家推荐";
    
    
    [self createTableView];
    [self loadSectionHeadView];
    
    [self getExpertListRequest];//get专家列表
    
    [self getStarExpertRequest];//get明星推荐
    [self getSquareAndRedPersonExpertRequestWithType:@"0"];//get明星推荐
    [self getSquareAndRedPersonExpertRequestWithType:@"1"];//get明星推荐
    [self getRankListExpertRequestWithlotteryClassCode:@"-201" OrderFlag:@"0"];//排行榜
    [self getRankListExpertRequestWithlotteryClassCode:@"-201" OrderFlag:@"1"];//排行榜
    [self getRankListExpertRequestWithlotteryClassCode:@"201" OrderFlag:@"0"];//排行榜
    
    [self getRaceListExpertRequest];//赛程列表
    
    [self getExpertHornRequest];//获取喇叭信息
}
-(void)loadSectionHeadView{
    
    sectionHeadView1 = [[UIView alloc]init];
    sectionHeadView1.backgroundColor = [UIColor whiteColor];
    NSArray *nameAry1 = [NSArray arrayWithObjects:@"明星推荐",@"喂饼广场",@"最红新人", nil];
    for(NSInteger i=0;i<3;i++){
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(70*i, 0, 70, 35);
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = 10+i;
        if(i == 0){
            btn.selected = YES;
        }
        [btn addTarget:self action:@selector(segmentBtnAction1:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[nameAry1 objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:BLACK_SEVENTY forState:UIControlStateNormal];
        [btn setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [sectionHeadView1 addSubview:btn];
    }
    UIButton *moreBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn1.frame = CGRectMake(self.view.frame.size.width-60, 0, 60, 35);
    moreBtn1.backgroundColor = [UIColor clearColor];
    moreBtn1.tag = 13;
    [moreBtn1 addTarget:self action:@selector(segmentBtnAction1:) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn1 setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn1 setTitleColor:BLACK_FIFITYFOUR forState:UIControlStateNormal];
    moreBtn1.titleLabel.font = [UIFont systemFontOfSize:11];
    [sectionHeadView1 addSubview:moreBtn1];
    UIImageView *sliderIma1 = [[UIImageView alloc]init];
    sliderIma1.frame = CGRectMake(0, 33, 70, 2);
    sliderIma1.tag = 14;
    sliderIma1.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
    [sectionHeadView1 addSubview:sliderIma1];
    UIImageView *line1 = [[UIImageView alloc]init];
    line1.frame = CGRectMake(0, 34.5, self.view.frame.size.width, 0.5);
    line1.backgroundColor = SEPARATORCOLOR;
    [sectionHeadView1 addSubview:line1];
    
    sectionHeadView2 = [[UIView alloc]init];
    sectionHeadView2.backgroundColor = [UIColor whiteColor];
    NSArray *nameAry2 = [NSArray arrayWithObjects:@"命中榜",@"回报榜",@"串关榜", nil];
    for(NSInteger i=0;i<3;i++){
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(70*i, 0, 70, 35);
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = 10+i;
        if(i == 0){
            btn.selected = YES;
        }
        [btn addTarget:self action:@selector(segmentBtnAction2:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[nameAry2 objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:BLACK_SEVENTY forState:UIControlStateNormal];
        [btn setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [sectionHeadView2 addSubview:btn];
    }
    UIButton *moreBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn2.frame = CGRectMake(self.view.frame.size.width-60, 0, 60, 35);
    moreBtn2.backgroundColor = [UIColor clearColor];
    moreBtn2.tag = 13;
    [moreBtn2 addTarget:self action:@selector(segmentBtnAction2:) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn2 setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn2 setTitleColor:BLACK_FIFITYFOUR forState:UIControlStateNormal];
    moreBtn2.titleLabel.font = [UIFont systemFontOfSize:11];
    [sectionHeadView2 addSubview:moreBtn2];
    UIImageView *sliderIma2 = [[UIImageView alloc]init];
    sliderIma2.frame = CGRectMake(0, 33, 70, 2);
    sliderIma2.tag = 14;
    sliderIma2.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
    [sectionHeadView2 addSubview:sliderIma2];
    UIImageView *line2 = [[UIImageView alloc]init];
    line2.frame = CGRectMake(0, 34.5, self.view.frame.size.width, 0.5);
    line2.backgroundColor = SEPARATORCOLOR;
    [sectionHeadView2 addSubview:line2];
}
-(void)createTableView{
    
    expertListArym = [[NSMutableArray alloc]initWithCapacity:0];
    starExpertArym = [[NSMutableArray alloc]initWithCapacity:0];
    rankExpertArym = [[NSMutableArray alloc]initWithCapacity:0];
    matchListArym = [[NSMutableArray alloc]initWithCapacity:0];
    hornArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    for(NSInteger i=0;i<3;i++){
        NSMutableArray *ary = [[NSMutableArray alloc]initWithCapacity:0];
        [starExpertArym addObject:ary];
        [rankExpertArym addObject:ary];
    }
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height - 44)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.mainView addSubview:myTableView];
    myTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    myTableView.backgroundColor = DEFAULT_BACKGROUNDCOLOR_CRAZY;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    myTableView.contentInset = UIEdgeInsetsMake(0, 0.0f, 0.0f, 0.0f);
}


-(void)getExpertListRequest{
    
    NSString *type = @"0";
#if defined CRAZYSPORTS
    type = @"1";
#endif
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"getHomeExpertsInfo",@"parameters":@{@"type":type}}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[responseJSON valueForKey:@"result"];
            if ([result count]!=0) {
                if (expertListArym.count) {
                    [expertListArym removeAllObjects];
                }
                NSMutableArray *mutableArr=[NSMutableArray arrayWithCapacity:[result count]];
                for (NSDictionary * dic in result) {
                    [mutableArr addObject:[ExpertJingjiModel expertJingjiWithDic:dic]];
                }
                [expertListArym addObjectsFromArray:mutableArr];
                [myTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            }
        }else{
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        
    }];
}
-(void)getStarExpertRequest{
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"sid":[[Info getInstance] cbSID],
                                                                                       @"expertClassCode":@"001",
                                                                                       @"lotteryClassCode":@"",
                                                                                       @"curPage":@"1",
                                                                                       @"pageSize":@"3"}];
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getCrazySportExpertsPlanList",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[[responseJSON valueForKey:@"result"] valueForKey:@"data"];
            if ([result count]!=0) {
//                if (starExpertArym.count) {
//                    [starExpertArym removeAllObjects];
//                }
                NSMutableArray *mutableArr=[NSMutableArray arrayWithCapacity:0];
                for (NSDictionary * dic in result) {
                    [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                }
                [starExpertArym replaceObjectAtIndex:0 withObject:mutableArr];
                [myTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            }
        }else{
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        
    }];
}
-(void)getSquareAndRedPersonExpertRequestWithType:(NSString *)type{
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"sid":[[Info getInstance] cbSID],
                                                                                       @"userName":@"",
                                                                                       @"expertClassCode":@"001",//竞彩001  写死
                                                                                       @"lotteyClassCode":@"",
                                                                                       @"type":type,//0广场 1红人
                                                                                       @"orderFlag":@"1",//首页传1
                                                                                       @"currPage":@"1",
                                                                                       @"pageSize":@"3"}];
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getCrazySportMasterPlanList",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[[responseJSON valueForKey:@"result"] valueForKey:@"data"];
            if ([result count]!=0) {
                
                NSMutableArray *mutableArr=[NSMutableArray arrayWithCapacity:0];
                for (NSDictionary * dic in result) {
                    [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                }
                if([type isEqualToString:@"0"]){
                    [starExpertArym replaceObjectAtIndex:1 withObject:mutableArr];
                }else if([type isEqualToString:@"1"]){
                    [starExpertArym replaceObjectAtIndex:2 withObject:mutableArr];
                }
                [myTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            }
        }else{
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        
    }];
}
-(void)getRankListExpertRequestWithlotteryClassCode:(NSString *)lotteryClassCode OrderFlag:(NSString *)orderFlag{
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"sid":[[Info getInstance] cbSID],
                                                                                       @"userName":@"",
                                                                                       @"expertClassCode":@"001",//竞彩001  写死
                                                                                       @"lotteryClassCode":lotteryClassCode,
                                                                                       @"orderFlag":orderFlag,
                                                                                       @"currPage":@"1",
                                                                                       @"pageSize":@"3"}];
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getCrazySportExpertsRankPlanList",@"parameters":parameters}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSArray * result=[[responseJSON valueForKey:@"result"] valueForKey:@"data"];
            if ([result count]!=0) {
                
                NSMutableArray *mutableArr=[NSMutableArray arrayWithCapacity:0];
                for (NSDictionary * dic in result) {
                    [mutableArr addObject:[ExpertMainListModel expertListWithDic:dic]];
                }
                if([lotteryClassCode isEqualToString:@"-201"]){
                    if([orderFlag isEqualToString:@"0"]){
                        [rankExpertArym replaceObjectAtIndex:0 withObject:mutableArr];
                    }else if([orderFlag isEqualToString:@"1"]){
                        [rankExpertArym replaceObjectAtIndex:1 withObject:mutableArr];
                    }
                }else if([lotteryClassCode isEqualToString:@"201"]){
                    [rankExpertArym replaceObjectAtIndex:2 withObject:mutableArr];
                }
                
                [myTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
            }
        }else{
            NSLog(@"请求失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[responseJSON valueForKey:@"resultDesc"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0f];
        }
    } failure:^(NSError * error) {
        
    }];
}
-(void)getRaceListExpertRequest{
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"sMGExpertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getLeastMatchList" forKey:@"methodName"];
    NSDictionary * parametersDic=@{@"currPage":@"1",@"pageSize":@"20",@"sid":[[Info getInstance] cbSID],@"source":@"1",@"sdFlag":@"0"};
    
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
                [matchListArym addObjectsFromArray:mulArr];
                [myTableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
            } else {
                
            }
        } else {
        }
    } failure:^(NSError * error) {
        
    }];
}
-(void)getExpertHornRequest{
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"zjtjIndexService" forKey:@"serviceName"];
    [bodyDic setObject:@"getCrazySportExpertsContinuousHitUsers" forKey:@"methodName"];
    NSDictionary * parametersDic=@{@"currPage":@"1",@"pageSize":@"5",@"lotteryClassCode":@"-201"};
    
    [bodyDic setObject:parametersDic forKey:@"parameters"];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        if ([[responseJSON valueForKey:@"resultCode"] isEqualToString:@"0000"]) {
            NSDictionary * bodyData=[responseJSON valueForKey:@"result"];
            NSArray * dataArr = [bodyData objectForKey:@"data"];
            if ([dataArr count]!=0) {
                [hornArray removeAllObjects];
                for (int i = 0; i < dataArr.count; i++) {
                    NSDictionary * dataDic = [dataArr objectAtIndex:i];
                    
                    NSString *level = @"大神";
                    NSString *name = [dataDic valueForKey:@"EXPERTS_NICK_NAME"];
                    NSString *lianzhong = [dataDic valueForKey:@"CONTINUES_HIT"];
                    
                    NSString * hornString = [NSString stringWithFormat:@"连中消息:恭喜%@%@%@连中",level,name,lianzhong];
                    
                    NSMutableAttributedString * aString = [[NSMutableAttributedString alloc] initWithString:hornString];
                    
                    [aString setAttributes:@{NSForegroundColorAttributeName:[SharedMethod getColorByHexString:@"ed3f30"],NSFontAttributeName:[UIFont systemFontOfSize:11]} range:[hornString rangeOfString:@"连中消息:"]];
                    [aString setAttributes:@{NSForegroundColorAttributeName:DEFAULT_TEXTGRAYCOLOR,NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(5, hornString.length-5)];
                    if (aString && aString.length) {
                        [hornArray addObject:aString];
                    }
                }
                
                hornCount = 0;
                
                [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(hornLabelRun) object:nil];
                
                if (hornArray && hornArray.count) {
//                    _hornLabel.attributedText = [hornArray objectAtIndex:0];
                    ExpertHornTableViewCell *cell = [myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
                    cell.hornLab1.attributedText = [hornArray objectAtIndex:0];
                    if (hornArray.count > 1) {
                        [self performSelector:@selector(hornLabelRun) withObject:nil afterDelay:2];
                    }
                }
            } else {
                
            }
        } else {
        }
    } failure:^(NSError * error) {
        
    }];
}
-(void)hornLabelRun
{
    int nextTag = hornCount + 1;
    if (nextTag == hornArray.count) {
        nextTag = 0;
    }
    ExpertHornTableViewCell *cell = [myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    cell.hornLab1.attributedText = [hornArray objectAtIndex:hornCount];
    cell.hornLab2.attributedText = [hornArray objectAtIndex:nextTag];
    
    [UIView animateWithDuration:1 animations:^{
        cell.hornLab1.mj_y = -35;
        cell.hornLab2.mj_y = 0;
    } completion:^(BOOL finished) {
        
        cell.hornLab1.mj_y = 0;
        cell.hornLab2.mj_y = 35;
        cell.hornLab1.attributedText = [hornArray objectAtIndex:nextTag];
        
        [self performSelector:@selector(hornLabelRun) withObject:nil afterDelay:2];
        hornCount++;
        if (hornCount == hornArray.count) {
            hornCount = 0;
        }
    }];
}
-(void)segmentBtnAction1:(UIButton *)button{
    
    if(button.tag == 13){//更多
        ExpertStarListViewController *vc = [[ExpertStarListViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if(button.selected){
            return;
        }
        for(NSInteger i=10;i<13;i++){
            
            UIButton *btn = [sectionHeadView1 viewWithTag:i];
            if([btn isKindOfClass:[UIButton class]]){
                btn.selected = NO;
            }
        }
        button.selected = YES;
        UIImageView *sliderIma = [sectionHeadView1 viewWithTag:14];
        [UIView animateWithDuration:0.25 animations:^{
            sliderIma.frame = CGRectMake((button.tag-10)*70, 33, 70, 2);
        }];
        ExpertScrollviewTableViewCell *cell = [myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        [cell.listCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:button.tag-10 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}
-(void)segmentBtnAction2:(UIButton *)button{
    if(button.tag == 13){//更多
        ExpertRankListViewController *vc = [[ExpertRankListViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if(button.selected){
            return;
        }
        for(NSInteger i=10;i<13;i++){
            
            UIButton *btn = [sectionHeadView2 viewWithTag:i];
            if([btn isKindOfClass:[UIButton class]]){
                btn.selected = NO;
            }
        }
        button.selected = YES;
        UIImageView *sliderIma = [sectionHeadView2 viewWithTag:14];
        [UIView animateWithDuration:0.25 animations:^{
            sliderIma.frame = CGRectMake((button.tag-10)*70, 33, 70, 2);
        }];
        ExpertScrollviewTableViewCell *cell = [myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
        [cell.listCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:button.tag-10 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}
-(void)collectionScrollEndWithOffsetX:(CGFloat)offsetX andIndex:(NSInteger)index{
    NSInteger buttonTag = offsetX/self.view.frame.size.width;
//    ExpertScrollviewTableViewCell *cell = [myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]];
    UIView *view = sectionHeadView1;
    if(index == 3){
        view = sectionHeadView2;
    }
    UIButton *button = [view viewWithTag:buttonTag+10];
    if(button.selected){
        return;
    }
    for(NSInteger i=10;i<13;i++){
        
        UIButton *btn = [view viewWithTag:i];
        if([btn isKindOfClass:[UIButton class]]){
            btn.selected = NO;
        }
    }
    button.selected = YES;
    UIImageView *sliderIma = [view viewWithTag:14];
    [UIView animateWithDuration:0.25 animations:^{
        sliderIma.frame = CGRectMake(buttonTag*70, 33, 70, 2);
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        UIView *starView = [[UIView alloc]init];
        starView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, 35);
        starView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *starIma = [[UIImageView alloc]init];
        starIma.frame = CGRectMake(15, 10, 17, 17);
        starIma.backgroundColor = [UIColor clearColor];
        starIma.image = [UIImage imageNamed:@""];
        [starView addSubview:starIma];
        
        UILabel *starLab = [[UILabel alloc]init];
        starLab.frame = CGRectMake(40, 10, 100, 17);
        starLab.backgroundColor = [UIColor clearColor];
        starLab.font = [UIFont systemFontOfSize:12];
        starLab.textColor = BLACK_EIGHTYSEVER;
        starLab.text = @"明星";
        [starView addSubview:starLab];
        
        return starView;
    }
    if(section == 1){
        return sectionHeadView1;
    }else if (section == 3){
        return sectionHeadView2;
    }else if (section == 4){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIImageView *ziseIma = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 2, 20)];
        ziseIma.backgroundColor = [UIColor colorWithRed:143/255.0 green:86/255.0 blue:195/255.0 alpha:1];
        [view addSubview:ziseIma];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 35)];
        lab.backgroundColor = [UIColor clearColor];
        lab.text = @"当前赛程";
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = BLACK_EIGHTYSEVER;
        [view addSubview:lab];
        
        UIImageView *line = [[UIImageView alloc]init];
        line.frame = CGRectMake(0, 34.5, self.view.frame.size.width, 0.5);
        line.backgroundColor = SEPARATORCOLOR;
        [view addSubview:line];
        
        return view;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0 || section == 1 || section == 3 || section == 4){
        return 35;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 1 || indexPath.section == 3){
        return 360;
    }
    if(indexPath.section == 4){
        return 65;
    }
    if(indexPath.section == 2){
        return 35;
    }
    return 90;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0 || section == 1 || section == 2 || section == 3){
        return 1;
    }
    if(section == 4){
        return matchListArym.count;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        static NSString * cellID = @"cell";
        expertTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[expertTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        __block ExpertMainViewController * newSelf = self;
        cell.didSelectRow = ^(NSIndexPath *index) {
            [newSelf collectionDidSelectRowAtIndexPath:index];
        };
        [cell loadAppointInfo:expertListArym];
        return cell;
    }else if (indexPath.section == 2){
        static NSString * cellID = @"hronCell";
        ExpertHornTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ExpertHornTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }else if (indexPath.section == 1 || indexPath.section == 3){
        static NSString * cellID = @"scrollviewCell";
        ExpertScrollviewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ExpertScrollviewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID withHeight:360];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if(indexPath.section == 1){
            cell.isZhuanjia = YES;
            [cell loadAppointInfo:starExpertArym];
        }else{
            cell.isZhuanjia = NO;
            [cell loadAppointInfo:rankExpertArym];
        }
        __block ExpertMainViewController * newSelf = self;
        cell.collectionScrollEnd = ^(CGFloat offsetX) {
            [newSelf collectionScrollEndWithOffsetX:offsetX andIndex:indexPath.section];
        };
        cell.didSelectRow = ^(UITableView * tableView, NSIndexPath * index, NSIndexPath * indexP) {
            NSLog(@"456456456");
        };
        return cell;
    }else if (indexPath.section == 4){
        
        static NSString * cellID = @"ExpertMatchListTableViewCell";
        ExpertMatchListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ExpertMatchListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        MatchVCModel *model=[matchListArym objectAtIndex:indexPath.row];
        [cell loadAppointInfo:model];
        return cell;
        
        
//        MatchTableViewCell * cell=[MatchTableViewCell matchTableViewCellWithTableView:tableView];
//        MatchVCModel *model;
//        model=[matchListArym objectAtIndex:indexPath.row];
//        [cell setDataWithMatchMdl:model];
//        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.section == 4){
        
        MatchDetailVC * vc=[[MatchDetailVC alloc] init];
        MatchVCModel *model;
        model=[matchListArym objectAtIndex:indexPath.row];
        
        vc.playId=[model playId];
        vc.matchModel=model;
        vc.matchSource=@"-201";
        vc.matchSource = model.source;
        vc.isSdOrNo=NO;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexPath.section == 3){
        MySalesViewController *vc = [[MySalesViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)collectionDidSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExpertNewMainViewController *vc = [[ExpertNewMainViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    return;
    
    ExpertJingjiModel *model = [expertListArym objectAtIndex:indexPath.section];
    
    Info *info = [Info getInstance];
    NSString *nameSty=@"";
    if ([info.userId intValue]) {
        nameSty=[[Info getInstance] userName];
    }
    NSString *lotteryClassCode = model.lotteryClassCode;
    
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
    [bodyDic setObject:@"expertService" forKey:@"serviceName"];
    [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
    [bodyDic setObject:@{@"expertsName":model.expertsName,@"expertsClassCode":model.expertsClassCode,@"loginUserName":nameSty,@"erAgintOrderId":@"",@"type":@"0",@"sdStatus":@"0",@"sid":[[Info getInstance] cbSID],@"lotteryClassCode":lotteryClassCode} forKey:@"parameters"];
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
        vc.planIDStr=@"";
        vc.jcyplryType=lotteryClassCode;//
        vc.isSdOrNo=NO;//
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError * error) {
    }];
}
-(void)dimissAlert:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}
-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
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