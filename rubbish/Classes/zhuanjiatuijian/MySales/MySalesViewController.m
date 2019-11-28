//
//  MySalesViewController.m
//  Experts
//
//  Created by V1pin on 15/10/29.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "MySalesViewController.h"
#import "MySaleTableCell.h"
#import "MySalesModel.h"
#import "SharedMethod.h"

#import "caiboAppDelegate.h"
#import "UpLoadView.h"

@interface MySalesViewController ()<UIPickerViewDataSource,UIPageViewControllerDelegate>{
    UpLoadView *loadview;
}

@property(nonatomic,strong)V1PickerView *picker;
@property(nonatomic,strong)NSMutableArray * arr;
@property(nonatomic,strong)NSMutableArray * dayWeekArr;
@property(nonatomic,assign)NSInteger currPage;
@property(nonatomic,assign)NSInteger fistAsgin;//判断是否是第一次进入
@property(nonatomic,assign)BOOL shuaXin;

@end

@implementation MySalesViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
#if defined CRAZYSPORTS
    [self changeCSTitileColor];
#endif
}
- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dayWeekArr=[[NSMutableArray alloc]initWithCapacity:9];
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];

        NSString* date=[NSString stringWithFormat:@"%@",[self getNowDateFromatAnDate:[NSDate date]]];
        _dataNow=[date substringWithRange:NSMakeRange(5,2)];//月份
        _yearData=[date substringWithRange:NSMakeRange(0,4)];//年份
        _selectMonth=[[NSArray alloc]initWithObjects:@"01 月",@"02 月",@"03 月",@"04 月",@"05 月",@"06 月",@"07 月",@"08 月",@"09 月",@"10 月",@"11 月",@"12 月", nil];
        
        //前一年
        NSString *lastYear=[NSString stringWithFormat:@"%d",[_yearData intValue] -1];
        _selectYear=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%@ 年",lastYear],[NSString stringWithFormat:@"%@ 年",_yearData], nil];
        _arr = [NSMutableArray arrayWithCapacity:12];
        for(int i=1;i<=[_dataNow intValue];i++){
            [_arr addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatNavView];
    self.title_nav =@"方案销量";
    _fistAsgin = 1;
    _currPage = 1;
    _shuaXin = YES;
    
    [self creatMySaleTabView];
    [self createTopView];//头部的数据
    [self setupRefresh];
    
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    
    [self getData];//月销售的一堆数据
    [self salaGetData:_yearData month:_dataNow];//销量的数据列表
}

-(void)creatMySaleTabView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, MyHight-HEIGHTBELOESYSSEVER-44) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsHorizontalScrollIndicator=NO;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _headTopView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 126-13)];
    _headTopView.backgroundColor=[UIColor clearColor];
    [_tableView setTableHeaderView:_headTopView];
    
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,75)];
    _topImageView.backgroundColor = [UIColor clearColor];
    
#if defined CRAZYSPORTS
    _topImageView.backgroundColor = [SharedMethod getColorByHexString:@"6e29bd"];
#else
    _topImageView.image = [UIImage imageNamed:@"方案销量-背景"];
#endif
    _topImageView.alpha = 0.8;
    [_headTopView addSubview:_topImageView];
    
    [self creatHeaderView];
}

-(void)createTopView{
    _yearsData = [[UILabel alloc]initWithFrame:CGRectMake(25, 17.5, 70, 12)];
    _yearsData.text = [NSString stringWithFormat:@"%@ 年",_yearData];
    _yearsData.font = FONTTWENTY_FOUR;
    _yearsData.textColor = [UIColor whiteColor];
    _yearsData.backgroundColor=[UIColor clearColor];
    [_topImageView addSubview:_yearsData];
    
    UIView *simgBV=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_yearsData.frame), 75, 47.5)];
    simgBV.backgroundColor=[UIColor clearColor];
    [_topImageView addSubview:simgBV];
    
    _monthLabel = [[UILabel alloc] init];
    _monthLabel.text = [NSString stringWithFormat:@"%@ 月",_dataNow];
    _monthLabel.font= FONTTHIRTY_TWO;
    _monthLabel.textColor = [UIColor whiteColor];
    _monthLabel.backgroundColor=[UIColor clearColor];
    [simgBV addSubview:_monthLabel];
    CGSize size=[PublicMethod setNameFontSize:_monthLabel.text andFont:FONTTHIRTY_TWO andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_monthLabel setFrame:CGRectMake(25, 15, size.width, size.height)];
    
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(_monthLabel)+5, ORIGIN_Y(_monthLabel)-13, 11, 9)];
    [imgView setImage:[UIImage imageNamed:@"已发方案-导航-筛选按钮-已选"]];
    imgView.backgroundColor=[UIColor clearColor];
    [simgBV addSubview:imgView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAct:)];
    simgBV.userInteractionEnabled = YES;
    _topImageView.userInteractionEnabled = YES;
    [simgBV addGestureRecognizer:tap];
    
    UILabel *saleLab=[[UILabel alloc]initWithFrame:CGRectMake(125,17.5,60,12)];
    saleLab.text = @"售出 (单)";
    saleLab.font = FONTTWENTY_FOUR;
    saleLab.textColor = [UIColor whiteColor];
    saleLab.backgroundColor=[UIColor clearColor];
    [_topImageView addSubview:saleLab];
    
    _salesNum = [[UILabel alloc]initWithFrame:CGRectMake(saleLab.frame.origin.x,40,100,25)];
    _salesNum.textColor = [UIColor whiteColor];
    _salesNum.font = FONTTHIRTY_TWO;
    _salesNum.backgroundColor=[UIColor clearColor];
    [_topImageView addSubview:_salesNum];
    
    UILabel *salemon=[[UILabel alloc]initWithFrame:CGRectMake(MyWidth-94,17.5,57,15)];
    salemon.text = @"销量 (元)";
    salemon.font = FONTTWENTY_FOUR;
    salemon.textColor = [UIColor whiteColor];
    salemon.backgroundColor=[UIColor clearColor];
    [_topImageView addSubview:salemon];
    
    _salesMoney = [[UILabel alloc]initWithFrame:CGRectMake(salemon.frame.origin.x,40,90,25)];
    _salesMoney.textColor = [UIColor whiteColor];
    _salesMoney.font = FONTTHIRTY_TWO;
    _salesMoney.backgroundColor = [UIColor clearColor];
    [_topImageView addSubview:_salesMoney];
}

-(void)creatHeaderView
{
//    UIView * sview=[[UIView alloc] initWithFrame:CGRectMake(0, 75, MyWidth, 51)];
    UIView * sview=[[UIView alloc] initWithFrame:CGRectMake(0, 75, MyWidth, 38)];
//    sview.backgroundColor=[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];//
    sview.backgroundColor=[SharedMethod getColorByHexString:@"e5e5e5"];//
    [_headTopView addSubview:sview];
    
    UIView *baiseView = [[UIView alloc]init];
    baiseView.backgroundColor = [UIColor whiteColor];
    baiseView.frame = CGRectMake(0, 8, MyWidth, 30);
    [sview addSubview:baiseView];
    
    UILabel *redLine=[[UILabel alloc] initWithFrame:CGRectMake(15, 25, 3, 15)];
    redLine.backgroundColor=[UIColor redColor];
    redLine.hidden = YES;
    [sview addSubview:redLine];
    
//    UILabel *actLabel=[[UILabel alloc] initWithFrame:CGRectMake(28,redLine.frame.origin.y, 30, 15)];
    UILabel *actLabel=[[UILabel alloc] initWithFrame:CGRectMake(15,8, 60, 30)];
    actLabel.text=@"方案";
    actLabel.font=FONTTHIRTY;
    actLabel.textColor=BLACK_EIGHTYSEVER;
    [sview addSubview:actLabel];
    
    UILabel *price=[[UILabel alloc] init];
    price.text=@"定价 (元)";
    price.font=FONTTWENTY_FOUR;
    price.backgroundColor=[UIColor clearColor];
    price.textAlignment=NSTextAlignmentCenter;
    [sview addSubview:price];
    CGSize size=[PublicMethod setNameFontSize:price.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//    [price setFrame:CGRectMake(217.5-size.width/2, 29, size.width, 12)];
    [price setFrame:CGRectMake(217.5-size.width/2, 8, size.width, 30)];
    
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc] initWithString:price.text];
    [str addAttribute:NSForegroundColorAttributeName value:BLACK_FIFITYFOUR range:NSMakeRange(2,[str length]-2)];
    [str addAttribute:NSFontAttributeName value:FONTTWENTY range:NSMakeRange(2,[str length]-2)];
    price.attributedText=str;
    
//    UILabel *sale=[[UILabel alloc]initWithFrame:CGRectMake(272.5-size.width/2, 29, size.width, 12)];
    UILabel *sale=[[UILabel alloc]initWithFrame:CGRectMake(272.5-size.width/2, 8, size.width, 30)];
    sale.text=@"销量 (元)";
    sale.font=FONTTWENTY_FOUR;
    sale.backgroundColor=[UIColor clearColor];
    sale.textAlignment=NSTextAlignmentCenter;
    [sview addSubview:sale];
    
    NSMutableAttributedString *str1=[[NSMutableAttributedString alloc] initWithString:sale.text];
    [str1 addAttribute:NSForegroundColorAttributeName value:BLACK_FIFITYFOUR range:NSMakeRange(2,[str1 length]-2)];
    [str1 addAttribute:NSFontAttributeName value:FONTTWENTY range:NSMakeRange(2,[str1 length]-2)];
    sale.attributedText=str1;
}

-(void)tapAct:(UITapGestureRecognizer *)sender
{
    _picker=[[V1PickerView alloc] initWithFrame:CGRectMake(0, MyHight-260, MyWidth, 260)];
    _picker.delegate=self;
    _picker.pickerView.dataSource=self;
    _picker.pickerView.delegate=self;
    [self.view addSubview:_picker];
    [_picker.pickerView selectRow:1 inComponent:0 animated:NO];
    [_picker.pickerView selectRow:_arr.count-1 inComponent:1 animated:NO];
    [_picker.pickerView reloadAllComponents];
    
    self.view.backgroundColor = [UIColor blackColor];
    _tableView.alpha = 0.7;
}

- (void)sure:(id)sender{
    self.view.backgroundColor = [UIColor clearColor];
    _tableView.alpha = 1;
    
    _fistAsgin = 2;

    _yearsData.text=[_selectYear objectAtIndex:[_picker.pickerView selectedRowInComponent:0]];
    _monthLabel.text=[_selectMonth objectAtIndex:[_picker.pickerView selectedRowInComponent:1]];
    
    _yearData=[_yearsData.text substringToIndex:4];
    _dataNow=[_monthLabel.text substringToIndex:2];
    
    [self getData];
    
    [self salaGetData:[_yearsData.text substringToIndex:4] month:[_monthLabel.text substringToIndex:2]];//销量的数据列表
    
    [UIView animateWithDuration:0.5 animations:^{
        [_picker setFrame:CGRectMake(0, _picker.frame.origin.y+_picker.frame.size.height, _picker.frame.size.width, 0)];
        [_picker removeFromSuperview];
    }];
}

-(void)cancle:(id)sender
{
    self.view.backgroundColor = [UIColor clearColor];
    _tableView.alpha = 1;
}

#pragma mark -----------UITableViewDelegate---------------------

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 28;
    MySalesModel *model=(MySalesModel *)[_dayWeekArr objectAtIndex:indexPath.section];
    NSDictionary *billListdic=(NSDictionary *)[model.billList objectAtIndex:indexPath.row];
    
    if ([billListdic[@"EXPERTS_CLASS_CODE"] isEqualToString:@"001"]){
        if([[billListdic valueForKey:@"LOTTERY_CLASS_CODE"] isEqualToString:@"201"]){//二串一
            return 55;
        }else{
            return 33;
        }
    }else{
        return 28;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    UIView *sview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MyWidth, 37.5)];
    UIView *sview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MyWidth, 25)];
    sview.backgroundColor=[SharedMethod getColorByHexString:@"e5e5e5"];
    
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, MyWidth, 1)];
//    label.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
//    [sview addSubview:label];
    
    UIImageView *lineIma = [[UIImageView alloc]init];
    lineIma.frame = CGRectMake(0, 24.5, sview.frame.size.width, 0.5);
    lineIma.backgroundColor = [UIColor blackColor];
    lineIma.alpha = 0.1;
    [sview addSubview:lineIma];
    
    if (_dayWeekArr.count!=0) {
        MySalesModel *model=(MySalesModel *)[_dayWeekArr objectAtIndex:section];
        
        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 25)];
        la.text=model.monthDayName;
        la.backgroundColor=[UIColor clearColor];
        la.font=FONTTWENTY_FOUR;
        [sview addSubview:la];
    }
    return sview;
}

#pragma mark ---------UITableViewDataSource--------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MySalesModel *model=(MySalesModel *)[_dayWeekArr objectAtIndex:section];
    return model.billList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *MySaleCell=@"MySaleCell";
    MySaleTableCell *cell=[tableView dequeueReusableCellWithIdentifier:MySaleCell];
    if (!cell) {
        cell=[[MySaleTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MySaleCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_dayWeekArr.count !=0 ) {
        MySalesModel *model=(MySalesModel *)[_dayWeekArr objectAtIndex:indexPath.section];
        NSDictionary *billListdic=(NSDictionary *)[model.billList objectAtIndex:indexPath.row];
        
        if ([billListdic[@"EXPERTS_CLASS_CODE"] isEqualToString:@"001"]) {//竞彩
//            [cell group:[NSString stringWithFormat:@"%@ VS %@",billListdic[@"HOME_NAME"],billListdic[@"AWAY_NAME"]] price:[NSString stringWithFormat:@"%@",billListdic[@"AMOUNT"]] sales:[NSString stringWithFormat:@"%@",billListdic[@"ALL_AMOUNT"]] lotryTpye:billListdic[@"LOTTERY_CLASS_CODE"] sdType:billListdic[@"TYPE_INFO"]];
            
            if ([[billListdic valueForKey:@"LOTTERY_CLASS_CODE"] isEqualToString:@"201"]){//二串一
                [cell loadErchuanyiAppointInfo:billListdic];
            }else{
                [cell loadAppointInfo:billListdic];
            }
        }if ([billListdic[@"EXPERTS_CLASS_CODE"] isEqualToString:@"002"]) {//数字彩
            [cell group:[NSString stringWithFormat:@"%@ %@期",billListdic[@"LOTTERY_CLASS_NAME"],billListdic[@"ER_ISSUE"]] price:[NSString stringWithFormat:@"%@",billListdic[@"AMOUNT"]] sales:[NSString stringWithFormat:@"%@",billListdic[@"ALL_AMOUNT"]] lotryTpye:@"" sdType:@""];
        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dayWeekArr.count;
}

#pragma mark ----------------UIPickerViewDelegate----------------

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return MyWidth*2/5;
        case 1:
            return MyWidth*2/7;
        default:
            return 0;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
            return [_selectYear objectAtIndex:row];
        case 1:
            return [_selectMonth objectAtIndex:row];
            
        default:
            return nil;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [pickerView reloadAllComponents];
}

#pragma mark ------------UIPickerViewDataSource---------------

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return 2;
    }if (component == 1){
        if ([pickerView selectedRowInComponent:0]==0) {
            return _selectMonth.count;
        }
        if ([pickerView selectedRowInComponent:0]==1){
            return _arr.count;
        }
    }
    return 0;
}

#pragma mark --------顶端销售的数据---------
-(void)getData
{
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"expertName":[[Info getInstance] userName],@"year":_yearData,@"month":_dataNow,@"flag":@"1"}];
    NSMutableDictionary * bodyDic = [NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getMonthSalesInfo",@"parameters":parameters}];
    
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id JSON) {
        NSDictionary * resultDic = JSON[@"result"];
        _salesNum.text = [NSString stringWithFormat:@"%@",resultDic[@"MONTH_ORDER_NUM"]];//月销售数量
        if ([[NSString stringWithFormat:@"%@",resultDic[@"MONTH_AMOUNT"]] isEqualToString:@""]||[[NSString stringWithFormat:@"%@",resultDic[@"MONTH_AMOUNT"]]isEqualToString:@"(null)"]||[NSString stringWithFormat:@"%@",resultDic[@"MONTH_AMOUNT"]]==nil) {
            _salesMoney.text = @"0";
        }else{
            _salesMoney.text = [NSString stringWithFormat:@"%.2f",[resultDic[@"MONTH_AMOUNT"] floatValue]];//月销售金额合计
        }
    } failure:^(NSError *error) {
    }];
}

-(void)salaGetData:(NSString *)year month:(NSString *)month{
    if (_shuaXin) {
        [_dayWeekArr removeAllObjects];
    }
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"expertName":[[Info getInstance] userName],@"year":year,@"month":month,@"curPage":[NSString stringWithFormat:@"%ld",(long)_currPage],@"pageSize":@"20",@"flag":@"1"}];
    NSMutableDictionary * bodyDic = [NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getMonthSalesDetail",@"parameters":parameters}];
    
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id JSON) {
        if (loadview) {
            [loadview stopRemoveFromSuperview];
            loadview = nil;
        }
        NSArray *dataArr=JSON[@"result"][@"data"];
        if (dataArr.count!=0) {
            for (NSDictionary * dataDic in dataArr) {
                MySalesModel * model = [[MySalesModel alloc]init];
                model.billList = [dataDic objectForKey:@"monthDayData"];
                [model setValuesForKeysWithDictionary:dataDic];
                [_dayWeekArr addObject:model];
            }
        } else {
            if(_fistAsgin!=1){
                UIAlertView *accountart = [[UIAlertView alloc]initWithTitle:nil message:@"没有更多啦！" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                [accountart show];
                [self performSelector:@selector(dimissAlert:) withObject:accountart afterDelay:1.0f];
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

/**
 *  UIAlertView自动消失处理代码
 */
-(void)dimissAlert:(UIAlertView *)Alert
{
    [Alert dismissWithClickedButtonIndex:[Alert cancelButtonIndex] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    _currPage = 1;
    _shuaXin = YES;
    [self getData];
    [self salaGetData:_yearData month:_dataNow];
}

#pragma mark - 加载
- (void)NearfooterRereshing
{
    _currPage++;
    _shuaXin = NO;
    [self salaGetData:_yearData month:_dataNow];
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