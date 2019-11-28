//
//  BeenPlanNumViewController.m
//  Experts
//
//  Created by V1pin on 15/10/28.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "BeenPlanNumViewController.h"
#import "PlanNumTableViewCell.h"
#import "BeenPlanNumModel.h"
#import "BeenPlanNumHistoryModel.h"
#import "BallDetailViewController.h"
#import "SZCViewController.h"
#import "SharedMethod.h"

#import "caiboAppDelegate.h"
#import "UpLoadView.h"

@interface BeenPlanNumViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIView * _viewOfSegment;//segment所在的view
    UILabel *_Baselabel;
    UISegmentedControl * _segMent;
    UITableView * _tableView;// 主体tableview
    UITableView * _chooseTabelView; //筛选tableview

    NSArray * _seleHistory;
    NSArray * _seleNewPlan;
    
    UpLoadView *loadview;
}

@property(nonatomic, strong)NSString *planIsNewOrHis;

@property(nonatomic, strong)NSString *lotryType;
@property(nonatomic, strong)NSString *seachType;

@property(nonatomic, strong)NSMutableArray *lastDataArr;
@property(nonatomic, strong)NSMutableArray *hisDataArr;

@property(nonatomic, retain)NSString * personStatusStr;

@property(nonatomic, assign)NSInteger currPage;
@property(nonatomic, assign)NSInteger firstSing;//判断是否第一次进入

@property(nonatomic, strong)UIView * sview;

@end

@implementation BeenPlanNumViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        _seleHistory = [[NSArray alloc]initWithObjects:@"全部",@"荐中",@"未中", nil];
        _seleNewPlan = [[NSArray alloc]initWithObjects:@"全部",@"在售中",@"已停售",@"审核中",@"未通过", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNavView];
    self.title_nav = @"已发方案";
    
    _seachType = @"";
    _lotryType =@"";
    _planIsNewOrHis =@"getDigitalPublishedNewPlanList";
    _firstSing = 1;
    _currPage = 1;
    
    [self creatTypeButton];
    [self createTabelView];
    [self crateChooseTableView];
    [self creatSegmentView];
    [self setupRefresh]; //  刷新
    
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    
    [self getData:@"0" lotteryClassCode:_lotryType currPage:@"1"]; //数据的获取
}

- (void)creatTypeButton
{
    UIImageView * sview = [[UIImageView alloc]initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, 44)];
    [self.view addSubview:sview];
    sview.image = [UIImage imageNamed:@"已发方案-导航条"];
    
    for (int i = 0; i < 2; i++) {
        UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        typeBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2*i,HEIGHTBELOESYSSEVER+44, [UIScreen mainScreen].bounds.size.width/2, 44);
        typeBtn.backgroundColor = [UIColor clearColor];
        typeBtn.tag = 1000 + i;
        typeBtn.titleLabel.font = FONTTHIRTYBOLD;
        typeBtn.userInteractionEnabled = YES;
        [typeBtn setTitleColor:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1] forState:UIControlStateSelected];
        [typeBtn setTitleColor:[UIColor colorWithRed:116.0/255 green:210.0/255 blue:255.0/255 alpha:1] forState:UIControlStateNormal];
        if (typeBtn.tag == 1000) {
            typeBtn.selected=YES;
        }
        typeBtn.titleLabel.font = FONTTHIRTY;
        [typeBtn addTarget:self action:@selector(typeNoBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:typeBtn];
        
        NSArray * dataSource = [NSArray arrayWithObjects:@"最新推荐",@"历史战绩", nil];
        [typeBtn setTitle:[dataSource objectAtIndex:i] forState:UIControlStateNormal];
        
        CGSize btnsize=[PublicMethod setNameFontSize:typeBtn.titleLabel.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [typeBtn setTitleEdgeInsets:UIEdgeInsetsMake(22-btnsize.height/2, MyWidth/4-btnsize.width/2-10.5/2, 22-btnsize.height/2, MyWidth/4-btnsize.width/2+10.5/2)];
        
        UILabel * Baselabel1 = [[UILabel alloc]init];
        Baselabel1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 1,HEIGHTBELOESYSSEVER+53.5, 0.5, 25);
        Baselabel1.backgroundColor = [UIColor colorWithRed:0.46 green:0.83 blue:1 alpha:1];
        [self.view addSubview:Baselabel1];
        
        UIButton * setButImg = [UIButton buttonWithType:UIButtonTypeCustom];
        setButImg.tag = 3000+i;
        setButImg.backgroundColor = [UIColor clearColor];
        setButImg.frame = CGRectMake(MyWidth/4+btnsize.width/2-5.25, HEIGHTBELOESYSSEVER+50, 35, 25);
        if (i==1) {
            setButImg.frame = CGRectMake(MyWidth*3/4+btnsize.width/2-5.25, HEIGHTBELOESYSSEVER+50, 35, 25);
        }
        [setButImg setImage:[UIImage imageNamed:@"已发方案-导航-筛选按钮-未选"] forState:UIControlStateSelected];
        [setButImg setImage:[UIImage imageNamed:@"已发方案-导航-筛选按钮-已选"] forState:UIControlStateNormal];
        [setButImg setImageEdgeInsets:UIEdgeInsetsMake(10,5,6,19)];
        [setButImg addTarget:self action:@selector(classifyNoBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:setButImg];
        
        if (setButImg.tag == 3000) {
            setButImg.selected=YES;
        }
    }
}

-(void)createTabelView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+88, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 104) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 101;
    _tableView.showsHorizontalScrollIndicator=NO;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark - 筛选tableview
-(void)crateChooseTableView
{
    _chooseTabelView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _chooseTabelView.dataSource = self;
    _chooseTabelView.delegate = self;
    _chooseTabelView.tag = 102;
    _chooseTabelView.hidden = YES;
    [self.view addSubview:_chooseTabelView];
}

/**
 创建tableView上面的SegmentView
 */
-(void)creatSegmentView
{
    //创建view
    _viewOfSegment=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MyWidth, 60)];
    [_tableView setTableHeaderView:_viewOfSegment];
    
    _segMent=[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"全部",@"双色球",@"大乐透",@"3D",@"排列三", nil]];
    _segMent.frame=CGRectMake(15,15,MyWidth-30,_viewOfSegment.frame.size.height-30);
    _segMent.selectedSegmentIndex=0;
    _segMent.tintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"发布方案-确定按钮"]];
    [_segMent addTarget:self action:@selector(segmentOnClick:) forControlEvents:UIControlEventValueChanged];
    [_viewOfSegment addSubview:_segMent];
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, ORIGIN_Y(_segMent)+15, MyWidth, 1)];
    line.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1];
    [_viewOfSegment addSubview:line];
}

#pragma mark -  如果没有发布方案的时候 提示用户发布方案啊、
-(void)createIfNoHaveNum
{
    _sview = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+148, MyWidth, MyHight - 168)];
    _sview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_sview];
    
    UIImageView * simgV = [[UIImageView alloc]init];
    UIImage * image = [UIImage imageNamed:@"大师您还没有最新方案"];
    [simgV setImage:image];
    simgV.frame = CGRectMake((MyWidth - image.size.width)/2, 30, image.size.width, image.size.height);
    [_sview addSubview:simgV];
    
    UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake((MyWidth - 140)/2, ORIGIN_Y(simgV)+50, 140, 40);
    [but setBackgroundImage:[UIImage imageNamed:@"发布方案-确定按钮@2x"] forState:normal];
    but.layer.cornerRadius = 5;
    but.layer.masksToBounds = YES;
    [but setTitle:@"发布方案" forState:normal];
    [but addTarget:self action:@selector(makeAction) forControlEvents:UIControlEventTouchUpInside];
    [_sview addSubview:but];
}

#pragma mark ----------------UITableViewDelegate-----------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        return 70;
    } else {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.view.backgroundColor =[UIColor whiteColor];//阴影效果取消
    _tableView.alpha=1;
    _chooseTabelView.hidden = YES;
    
    if (tableView.tag == 102) {
        _firstSing = 2;
        _currPage=1;
        if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedNewPlanList"]) {
            UIButton *btn = (UIButton *)[self.view viewWithTag:3000];
            btn.selected=YES;
            if (indexPath.row ==0) {
                _seachType = @"0";
            }
            if (indexPath.row == 1) {
                _seachType = @"1";
            }
            if (indexPath.row == 2) {
                _seachType = @"2";
            }
            if (indexPath.row == 3) {
                _seachType = @"3";
            }
            if (indexPath.row == 4) {
                _seachType = @"4";
            }
            [self getData:_seachType lotteryClassCode:_lotryType currPage:@"1"];
        }else if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedHisPlanList"]) {
            UIButton *btn = (UIButton *)[self.view viewWithTag:3001];
            btn.selected=YES;
            if (indexPath.row == 0) {
                _seachType = @"0";
            }
            if (indexPath.row ==1) {
                _seachType = @"1";
            }
            if (indexPath.row ==2) {
                _seachType = @"2";
            }
            [self historyGetData:_seachType lotteryClassCode:_lotryType currPage:@"1"];
        }
    }else if (tableView.tag == 101) {
        BallDetailViewController * vc = [[BallDetailViewController alloc]init];
        if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedNewPlanList"]) {
            if (_lastDataArr.count!= 0) {
                BeenPlanNumModel * model = (BeenPlanNumModel *)[_lastDataArr objectAtIndex:indexPath.row];
                vc.caiZhongType=model.lotteryClassCode;
                vc.planId = model.erAgintOrderId;
                vc.qiHao=model.erIssue;
            }
        }else if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedHisPlanList"]) {
            if (_hisDataArr.count != 0) {
                BeenPlanNumHistoryModel * model = (BeenPlanNumHistoryModel *)[_hisDataArr objectAtIndex:indexPath.row];
                vc.planId = model.erAgintOrderId;
                vc.caiZhongType=model.lotteryClassCode;
                vc.qiHao=model.erIssue;
            }
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ----------------UITableViewDataSource-----------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 101) {
        if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedNewPlanList"]) {
            return _lastDataArr.count;
        }if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedHisPlanList"]) {
            return _hisDataArr.count;
        }
    } else if (tableView.tag == 102) {
        if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedNewPlanList"]) {
            return [_seleNewPlan count];
        }else if([_planIsNewOrHis isEqualToString:@"getDigitalPublishedHisPlanList"]){
            return [_seleHistory count];
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedNewPlanList"]) {
            static NSString *identifier = @"cell";
            PlanNumTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[PlanNumTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];

                UIView * line=[[UIView alloc]initWithFrame:CGRectMake(0,69.5, MyWidth, 0.5)];
                [cell.contentView addSubview:line];
                line.backgroundColor=SEPARATORCOLOR;
            }
            BeenPlanNumModel * model = (BeenPlanNumModel *)[_lastDataArr objectAtIndex:indexPath.row];
            NSString *prc=[NSString stringWithFormat:@"%.1f元",[model.price floatValue]*[model.discount floatValue]];
            if([model.price floatValue]*[model.discount floatValue]==0.0){
                prc=@"免费";
            }
            [cell TypeOf:model.lotteryClassCode NumData:[NSString stringWithFormat:@"%@期",model.erIssue] TimeOfRelease:[NSString stringWithFormat:@"发布时间 %@",[model.createTime substringFromIndex:5]] SeleStatus:[NSString stringWithFormat:@"%@%@",model.orderStatus,model.closeStatus] NumPrice:prc];
            
            cell.backgroundColor=[UIColor whiteColor];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
            return cell;
        }else if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedHisPlanList"]) {
            static NSString * identifier = @"historyCell";
            PlanNumTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[PlanNumTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];

                UIView * line=[[UIView alloc]initWithFrame:CGRectMake(0,69.5, MyWidth, 0.5)];
                line.backgroundColor=SEPARATORCOLOR;
                [cell.contentView addSubview:line];
            }
            
            BeenPlanNumHistoryModel * model = (BeenPlanNumHistoryModel *)[_hisDataArr objectAtIndex:indexPath.row];
            [cell TypeOf:model.lotteryClassCode NumData:[NSString stringWithFormat:@"%@期",model.erIssue] TimeOfRelease:[NSString stringWithFormat:@"发布时间 %@",[model.createTime substringFromIndex:5]] Price:[NSString stringWithFormat:@"%.1f元",[model.price floatValue]*[model.discount floatValue]] NewStatus:model.hitStatus];
            
            cell.backgroundColor=[UIColor whiteColor];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
            return cell;
        }
    } else if (tableView.tag == 102) {
        static NSString *identifier = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            
            UIView * line=[[UIView alloc]initWithFrame:CGRectMake(0,49.5, MyWidth, 0.5)];
            line.backgroundColor=SEPARATORCOLOR;
            [cell.contentView addSubview:line];
        }
        cell.textLabel.font = FONTTWENTY_EIGHT;
        if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedNewPlanList"]) {
            cell.textLabel.text = [_seleNewPlan objectAtIndex:indexPath.row];
        }else if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedHisPlanList"]) {
            cell.textLabel.text = [_seleHistory objectAtIndex:indexPath.row];
        }
        return cell;
    }
    
    return nil;
}

#pragma mark - 俩个大but 的点击事件
-(void)typeNoBtnAct:(UIButton*)sender
{
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView.alpha = 1;
    _chooseTabelView.hidden =YES;
    
    _firstSing =1;
    _currPage=1;
    
    sender.selected=YES;
    if (sender.tag == 1000) {
        _planIsNewOrHis=@"getDigitalPublishedNewPlanList";
        
        UIButton * btn = (UIButton *)[self.view viewWithTag:1001];
        btn.selected=NO;
        
        btn = (UIButton *)[self.view viewWithTag:3000];
        btn.selected=YES;
        
        btn = (UIButton *)[self.view viewWithTag:3001];
        btn.selected=NO;
        
        [self getData:@"0" lotteryClassCode:_lotryType currPage:@"1"];
    }else if (sender.tag == 1001) {
        _planIsNewOrHis=@"getDigitalPublishedHisPlanList";
        
        UIButton * btn = (UIButton *)[self.view viewWithTag:1000];
        btn.selected=NO;
        
        btn = (UIButton *)[self.view viewWithTag:3001];
        btn.selected=YES;
        
        btn = (UIButton *)[self.view viewWithTag:3000];
        btn.selected=NO;
        
        [self historyGetData:@"0"lotteryClassCode:_lotryType currPage:@"1"];
    }
}

#pragma mark - 小三角but 的点击事件

-(void)classifyNoBtnAct:(UIButton *)sender
{
    if (_chooseTabelView.hidden == NO&&(([_planIsNewOrHis isEqualToString:@"getDigitalPublishedNewPlanList"]&&sender.tag==3000)||([_planIsNewOrHis isEqualToString:@"getDigitalPublishedHisPlanList"]&&sender.tag==3001))) {//阴影效果取消
        sender.selected=YES;
        self.view.backgroundColor = [UIColor whiteColor];
        _tableView.alpha = 1;
        _chooseTabelView.hidden =YES;
        if (_sview) {
            _sview.alpha=1.0;
        }
        return;
    }
    self.view.backgroundColor = [UIColor blackColor];
    _tableView.alpha = 0.7;
    if (_sview) {
        _sview.alpha=0.6;
        [self.view bringSubviewToFront:_chooseTabelView];
    }
    sender.selected=NO;
    _segMent.selectedSegmentIndex=0;
    if (sender.tag == 3000) {
        _planIsNewOrHis=@"getDigitalPublishedNewPlanList";
        _chooseTabelView.frame = CGRectMake(0, HEIGHTBELOESYSSEVER+88, MyWidth, 250);
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000];//这个button是左边的
        btn.selected=YES;
        
        btn =(UIButton *)[self.view viewWithTag:1001];
        btn.selected=NO;
        
        btn =(UIButton *)[self.view viewWithTag:3001];
        btn.selected=NO;
    }else if (sender.tag == 3001){
        _planIsNewOrHis=@"getDigitalPublishedHisPlanList";
        _chooseTabelView.frame = CGRectMake(0, HEIGHTBELOESYSSEVER+88, MyWidth, 150);
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:1001];//这个button是右边的
        btn.selected=YES;
        
        btn =(UIButton *)[self.view viewWithTag:1000];
        btn.selected=NO;
        
        btn =(UIButton *)[self.view viewWithTag:3000];
        btn.selected=NO;
    }
    
    [_chooseTabelView reloadData];
    _chooseTabelView.hidden = NO;
}

#pragma mark -segment的单击响应方法
-(void)segmentOnClick:(UISegmentedControl *)segment
{
    _currPage=1;
    NSInteger index=segment.selectedSegmentIndex;
    switch (index) {
        case 0:
        {
            _lotryType = @"";
            break;
        }
        case 1:
        {
            _lotryType = @"001";
            break;
        }
        case 2:
        {
            _lotryType = @"113";
            break;
        }
        case 3:
        {
            _lotryType = @"002";
            break;
        }
        case 4:
        {
            _lotryType = @"108";
            break;
        }
        default:
            break;
    }
    if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedNewPlanList"]) {
        [self getData:_seachType lotteryClassCode:_lotryType currPage:@"1"];
    }else if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedHisPlanList"]) {
        [self historyGetData:_seachType lotteryClassCode:_lotryType currPage:@"1"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数字彩的已发方案
-(void)getData:(NSString*)searchType lotteryClassCode:(NSString *)lotteryClassCode currPage:(NSString *)currPage{
    if (_sview) {
        [_sview removeFromSuperview];
    }
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    if ([currPage isEqualToString:@"1"]) {
        [_lastDataArr removeAllObjects];
        _lastDataArr=nil;
    }
    NSMutableDictionary * parameters =[NSMutableDictionary dictionaryWithDictionary:@{@"expertsName":[[Info getInstance] userName],@"searchType":searchType,@"lotteryClassCode":lotteryClassCode,@"currPage":currPage,@"pageSize":@"20"}];
    NSMutableDictionary * bodDic =[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"getDigitalPublishedNewPlanList",@"parameters":parameters}];
    
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic success:^(id JSON) {
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        if (JSON!=nil&&JSON[@"result"]!=nil&&![JSON[@"result"] isEqual:[NSNull null]]) {
            NSArray * dataArr = JSON[@"result"][@"data"];
            if (dataArr.count != 0) {
                if ([currPage isEqualToString:@"1"]) {
                    _lastDataArr=[NSMutableArray arrayWithCapacity:[dataArr count]];
                }
                for (NSDictionary * dataDic in dataArr) {
                    BeenPlanNumModel * model = [[BeenPlanNumModel alloc]init];
                    [model setValuesForKeysWithDictionary:dataDic];
                    [_lastDataArr addObject:model];
                }
                if ([currPage intValue]>1) {
                    _currPage++;
                }
            } else {
                if ([currPage isEqualToString:@"1"]&&_firstSing ==1) {
                    [self createIfNoHaveNum];
                }else if([currPage intValue]>1){
                    UIAlertView *accountart = [[UIAlertView alloc]initWithTitle:nil message:@"没有更多啦！" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                    [accountart show];
                    [self performSelector:@selector(dimissAlert:) withObject:accountart afterDelay:1.0f];
                }
            }
        }
        [_tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];
        });
    } failure:^(NSError *error) {
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];
        });
    }];
}

#pragma mark -  历史战绩的数据解析
-(void)historyGetData:(NSString *)searchType lotteryClassCode:(NSString *)lotteryClassCode currPage:(NSString *)currPage
{
    if (_sview) {
        [_sview removeFromSuperview];
    }
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    if ([currPage isEqualToString:@"1"]) {
        [_hisDataArr removeAllObjects];
        _hisDataArr=nil;
    }
    NSMutableDictionary * parameters =[NSMutableDictionary dictionaryWithDictionary:@{@"expertsName":[[Info getInstance] userName],@"searchType":searchType,@"lotteryClassCode":lotteryClassCode,@"currPage":currPage,@"pageSize":@"20"}];
    NSMutableDictionary * bodDic =[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"expertService",@"methodName":@"getDigitalPublishedHisPlanList",@"parameters":parameters}];
    
    [RequestEntity requestDatapartWithJsonBodyDic:bodDic success:^(id JSON) {
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        if (JSON!=nil&&JSON[@"result"]!=nil&&![JSON[@"result"] isEqual:[NSNull null]]) {
            NSArray * dataArr = JSON[@"result"][@"data"];
            if (dataArr.count != 0) {
                if ([currPage isEqualToString:@"1"]) {
                    _hisDataArr=[NSMutableArray arrayWithCapacity:[dataArr count]];
                }
                for (NSDictionary * dataDic in dataArr) {
                    BeenPlanNumHistoryModel * model = [[BeenPlanNumHistoryModel alloc]init];
                    [model setValuesForKeysWithDictionary:dataDic];
                    [_hisDataArr addObject:model];
                }
                if ([currPage intValue]>1) {
                    _currPage++;
                }
            } else {
                if ([currPage isEqualToString:@"1"]&&_firstSing ==1) {
                    [self createIfNoHaveNum];
                }else if ([currPage intValue]>1) {
                    UIAlertView *accountart = [[UIAlertView alloc]initWithTitle:nil message:@"没有更多啦！" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                    [accountart show];
                    [self performSelector:@selector(dimissAlert:) withObject:accountart afterDelay:1.0f];
                }
            }
        }
        [_tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];
        });
    } failure:^(NSError *error) {
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];
        });
    }];
}

#pragma mark 刷新
- (void)setupRefresh
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self NearheaderRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_tableView.header];
    
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self NearfooterRereshing];
    }];
    [SharedMethod setRefreshByHeaderOrFooter:_tableView.footer];
}

#pragma mark 开始进入刷新状态
- (void)NearheaderRereshing
{
    _currPage =1;
    if (_tableView.tag == 101) {
        if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedNewPlanList"]) {
            [self getData:_seachType lotteryClassCode:_lotryType currPage:@"1"];
        }else if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedHisPlanList"]) {
            [self historyGetData:_seachType lotteryClassCode:_lotryType currPage:@"1"];
        }
    }
}

#pragma mark - 加载
- (void)NearfooterRereshing
{
    NSInteger cuPage=_currPage+1;
    if (_tableView.tag == 101) {
        if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedNewPlanList"]) {
            [self getData:_seachType lotteryClassCode:_lotryType currPage:[NSString stringWithFormat:@"%ld",(long)cuPage]];
        }else if ([_planIsNewOrHis isEqualToString:@"getDigitalPublishedHisPlanList"]) {
            [self historyGetData:_seachType lotteryClassCode:_lotryType currPage:[NSString stringWithFormat:@"%ld",(long)cuPage]];
        }
    }
}

-(void)makeAction
{
    NSDictionary *dic = [DEFAULTS objectForKey:@"qihaodic"];
    NSDictionary *ssDic = [DEFAULTS objectForKey:@"szcssdic"];
    NSDictionary *dltDic = [DEFAULTS objectForKey:@"szcdltdic"];
    NSDictionary *sdDic = [DEFAULTS objectForKey:@"szc3ddic"];
    NSDictionary *plsDic = [DEFAULTS objectForKey:@"szcplsdic"];
    NSInteger i=0;
    if (![dic[@"publish_SHUANGSEQIU"] isEqualToString:@"0"]){
        i++;
    }
    if (![dic[@"publish_DALETOU"] isEqualToString:@"0"]){
        i++;
    }
    if (![dic[@"publish_SanD"] isEqualToString:@"0"]){
        i++;
    }
    if (![dic[@"publish_PaiLieSan"] isEqualToString:@"0"]){
        i++;
    }
    if (i==4) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"您今天今天的发布次数已经用完" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [alert show];
        [self performSelector:@selector(alertActionDissmiss:) withObject:alert afterDelay:1];
    }else{
        if(dic){
            SZCViewController *planVC = [[SZCViewController alloc]init];
            if([dic[@"publish_SHUANGSEQIU"] isEqualToString:@"0"]){
                planVC.szcType=0;
            }else if([dic[@"publish_DALETOU"] isEqualToString:@"0"]){
                planVC.szcType=1;
            }else if([dic[@"publish_SanD"] isEqualToString:@"0"]){
                planVC.szcType=2;
            }else if([dic[@"publish_PaiLieSan"] isEqualToString:@"0"]){
                planVC.szcType=3;
            }
            planVC.resDic1=ssDic;
            planVC.resDic2=dltDic;
            planVC.resDic3=sdDic;
            planVC.resDic4=plsDic;
            planVC.todayPubNumDic=dic;
            planVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:planVC animated:YES];
        }
    }
}

/**
 *  UIAlertView自动消失处理代码
 */
-(void)dimissAlert:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
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