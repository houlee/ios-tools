//
//  SearchVC.m
//  Experts
//
//  Created by v1pin on 15/10/30.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "SearchVC.h"
#import "SepratorLineView.h"
#import "NSString+ExpertStrings.h"
#import "ExpertDetailCell.h"
#import "SechExpIntroCell.h"
#import "ExpertJingjiModel.h"
#import "SMGDetailViewController.h"

@interface SearchVC ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>{
    UISegmentedControl *segmentCT;
    UIView *segmentBg;
    UIView *hotRcomdBg;
    
    //竞彩和数字彩的详情标志
    BOOL segmentSelectFlags;
}

@property (nonatomic,strong) NSArray *historyArr;//搜索历史
@property (nonatomic,strong) UITableView *shTableView;//搜索历史列表
@property (nonatomic,strong) UISearchBar *schBar;
@property (nonatomic,strong) UITableView *schListTable;//搜索结果列表

@property (nonatomic,strong) NSMutableArray *searchRuArr;//搜索结果
@property (nonatomic,strong) NSString *searchType;

@property (nonatomic,strong) NSString *wordSearch;//记录搜索关键字

@end

@implementation SearchVC

static bool doSearch;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatNavView];
    
    _searchType=@"";
    doSearch=YES;
    segmentSelectFlags=YES;
    
    [self creatSearchBar];
    
    [self creatSearchTabView];//创建搜索历史列表
    
    [self creatSegmentView];
    
    [self creatSchTableView];//创建搜索结果列表
    
    hotRcomdBg=[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), MyWidth, 75)];
    hotRcomdBg.backgroundColor=[UIColor colorWithRed:254.0/255 green:246.0/255 blue:225.0/255 alpha:1.0];
    hotRcomdBg.hidden=YES;
    [self.view addSubview:hotRcomdBg];
    
    UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
    imgV.image=[UIImage imageNamed:@"叹号"];
    [hotRcomdBg addSubview:imgV];
    
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgV.frame)+15, 15, 240, 15)];
    lab.text=@"暂时没有找到相关信息";
    lab.font=FONTTHIRTY;
    lab.textColor=SEARCH_TAN;
    [hotRcomdBg addSubview:lab];
    
    CGSize cellUIsize=[PublicMethod setNameFontSize:lab.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGRect rect=lab.frame;
    rect.size=cellUIsize;
    [lab setFrame:rect];
    
    lab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgV.frame)+15, CGRectGetMaxY(lab.frame)+11, 240, 12)];
    lab.text=@"为您推荐当日最新方案";
    lab.font=FONTTWENTY_FOUR;
    lab.textColor=SEARCH_TAN;
    [hotRcomdBg addSubview:lab];
    
    cellUIsize=[PublicMethod setNameFontSize:lab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    rect=lab.frame;
    rect.size=cellUIsize;
    [lab setFrame:rect];
    
    rect=hotRcomdBg.frame;
    rect.size.height=CGRectGetMaxY(lab.frame)+15.5;
    [hotRcomdBg setFrame:rect];
    
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, hotRcomdBg.frame.size.height-0.5, MyWidth, 0.5)];
    line.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
    [hotRcomdBg addSubview:line];
    
    if(self.labelStr.length){
        if (_shTableView) {
            [_shTableView removeFromSuperview];
            _shTableView=nil;
        }
        _wordSearch = self.labelStr;
        _schBar.text = _wordSearch;
        if (IS_IOS7) {
            UITextField *field=(UITextField *)[[[[_schBar subviews] objectAtIndex:0] subviews] objectAtIndex:1];
            field.textColor=[UIColor blackColor];
        }
        [self searchPlanRequest:_wordSearch];
    }
}

- (void)creatSearchBar{
    _schBar=[[UISearchBar alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.popBackBtn.frame), HEIGHTBELOESYSSEVER+4, MyWidth-CGRectGetMaxX(self.popBackBtn.frame)-100, 36)];
    _schBar.delegate=self;
    _schBar.placeholder=@"搜索方案、专家";
    _schBar.backgroundColor=[UIColor clearColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        _schBar.searchBarStyle=UISearchBarStyleDefault;
        for (UIView *view in _schBar.subviews)
        {
            UITextField *txt=(UITextField *)[[view subviews] objectAtIndex:1];
            txt.textColor=BLACK_TWENTYFOUR;
            UIView *seacchBackView=(UIView *)[[view subviews] objectAtIndex:0];
            [seacchBackView removeFromSuperview];
            
            UIImageView *img=[[UIImageView alloc] initWithFrame:view.frame];
            img.image=[UIImage imageNamed:@"搜索框"];
            [view insertSubview:img atIndex:0];
        }
    }
    [self.navView addSubview:_schBar];
    
    UIButton *scBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [scBtn setFrame:CGRectMake(CGRectGetMaxX(_schBar.frame)+9, HEIGHTBELOESYSSEVER+4, 75, 36)];
    [scBtn setBackgroundImage:[UIImage imageNamed:@"搜索按钮"] forState:UIControlStateNormal];
    [scBtn setBackgroundImage:[UIImage imageNamed:@"搜索按钮-点击"] forState:UIControlStateHighlighted];
    [scBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [scBtn setTitle:@"搜索" forState:UIControlStateHighlighted];
    [scBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [scBtn addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:scBtn];
}

- (NSString *)filename{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask,YES);
    NSString *path=[documentPaths objectAtIndex:0];
    
    NSString *filename=[path stringByAppendingPathComponent:@"SechHistory.plist"];   //获取路径
    NSLog(@"filename==%@",filename);
    
    return filename;
}

- (void)creatSearchTabView{
    NSString *filename=[self filename];
    
    NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];  //读取数据
    NSLog(@"dic2 is:%@",dic2);
    
    if(dic2 == nil) {
        //创建一个plist文件
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
    } else {
        NSMutableArray *resultData=[dic2 objectForKey:@"sHistory"];
        if(resultData!=nil&&[resultData count]>0){
            _historyArr=[NSArray arrayWithArray:resultData];
            _shTableView=[[UITableView alloc] init];
            _shTableView.delegate = self;
            _shTableView.dataSource = self;
            _shTableView.backgroundColor = [UIColor clearColor];
            _shTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            [self.view addSubview:_shTableView];
            if(45*[_historyArr count]+45>MyHight-64){
                [_shTableView setFrame:CGRectMake(0,CGRectGetMaxY(self.navView.frame), MyWidth, MyHight-64)];
            }else{
                [_shTableView setFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), MyWidth, 45*[_historyArr count]+45)];
            }
        } else {
            //创建一个dic，写到plist文件里
            //NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:_historyArr,@"sHistory",nil]; //写入数据
            //[dic writeToFile:filename atomically:YES];
        }
    }
}

- (void)searchBtn:(id)sender{
    if(_schBar.text==nil||[_schBar.text isEqualToString:@""]){
        return;
    }
    if (_shTableView) {
        [_shTableView removeFromSuperview];
        _shTableView=nil;
    }
    doSearch=YES;
    _wordSearch=_schBar.text;
    //将搜索字段写入本地字典中
    NSString *filename=[self filename];
    NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];  //读取数据
    NSMutableArray *resultData=[dic2 objectForKey:@"sHistory"];
    if (resultData==nil) {
        resultData=[NSMutableArray arrayWithObject:_wordSearch];
    }else{
        if (![resultData containsObject:_wordSearch]) {
            [resultData addObject:_wordSearch];
        }
    }
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:resultData,@"sHistory",nil];
    [dic writeToFile:filename atomically:YES];
    
    _wordSearch=_schBar.text;
    [self segmentOnClick:segmentCT];
//    [self searchPlanRequest:_schBar.text];
    [_schBar resignFirstResponder];
}

/**
 创建tableView上面的SegmentView
 */
-(void)creatSegmentView
{
    //创建view
    segmentBg=[[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, 60)];
    segmentBg.backgroundColor=[UIColor clearColor];
    segmentBg.layer.masksToBounds=YES;
    segmentBg.layer.borderWidth=1;
    segmentBg.layer.borderColor=SEPARATORCOLOR.CGColor;
    segmentBg.hidden=YES;
    [self.view addSubview:segmentBg];
    
    segmentCT=[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"方案",@"专家", nil]];
    segmentCT.frame=CGRectMake(15,15,MyWidth-30,30);
    segmentCT.selectedSegmentIndex=0;
    segmentCT.tintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"发布方案-确定按钮"]];
    [segmentCT addTarget:self action:@selector(segmentOnClick:) forControlEvents:UIControlEventValueChanged];
    [segmentBg addSubview:segmentCT];
}

- (void)creatSchTableView{
    _schListTable=[[UITableView alloc] initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, MyHight-HEIGHTBELOESYSSEVER-44)];
    _schListTable.delegate = self;
    _schListTable.dataSource = self;
    _schListTable.showsHorizontalScrollIndicator=NO;
    _schListTable.showsVerticalScrollIndicator=NO;
//    _schListTable.separatorStyle=UITableViewCellSeparatorStyleNone;
//    _schListTable.separatorColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    _schListTable.backgroundColor = [UIColor clearColor];
    _schListTable.hidden=YES;
    [self.view addSubview:_schListTable];
    _schListTable.tableHeaderView=segmentBg;
    
    _schListTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
}

#pragma mark -segment的单击响应方法
-(void)segmentOnClick:(UISegmentedControl *)segment
{
    NSInteger index=segment.selectedSegmentIndex;
//    doSearch=NO;
    NSLog(@"index %li",(long)index);
    switch (index) {
        case 0:
        {
            NSLog(@"index %li",(long)index);
            segmentSelectFlags=YES;
            [self searchPlanRequest:_wordSearch];
            break;
        }
        case 1:
        {
            NSLog(@"index %li",(long)index);
            segmentSelectFlags=NO;
            [self searchExpertRequest];
            break;
        }
        default:
            break;
    }
}

- (void)searchPlanRequest:(NSString *)str{
    segmentCT.selectedSegmentIndex = 0;
    NSString *labelId = @"";
    if(str.length){
        NSArray *labelNameAry = [NSArray arrayWithObjects:
                                 @"TV名嘴带你看推荐",
                                 @"媒体记者带你看推荐",
                                 @"足球名将带你看推荐",
                                 @"彩票专家带你看推荐",
                                 @"连红牛人带你看推荐",
                                 @"民间高手带你看推荐", nil];
        for (NSInteger i=0;i<labelNameAry.count;i++){
            NSString *ss = [labelNameAry objectAtIndex:i];
            if([ss isEqualToString:str]){
                labelId = [NSString stringWithFormat:@"%d",i+1];
            }
        }
    }
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"serchPlanList",@"parameters":@{@"keywords":str,@"levelType":@"1",@"flag":@"1",@"sdFlag":[NSString stringWithFormat:@"%i",self.isSdOrNo],@"curPage":@"1",@"pageSize":@"20",@"sid":[[Info getInstance] cbSID],@"labelId":labelId}}];

    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSDictionary *dic=responseJSON;
        NSArray *arr_plan=dic[@"result"][@"data"];
        if(_searchRuArr){
            _searchRuArr=nil;
        }
        if(arr_plan==nil||[arr_plan count]==0){
            if (doSearch) {
                [self searchExpertRequest];
            }else{
                CGRect rect=_schListTable.frame;
                if((58+45*MyWidth/320)*[_searchRuArr count]+60>MyHight-64){
                    rect.size.height=MyHight-64;
                }else{
                    rect.size.height=(58+45*MyWidth/320)*[_searchRuArr count]+60;
                }
                segmentBg.hidden=NO;
                hotRcomdBg.hidden=YES;
                _schListTable.hidden=NO;
                [_schListTable setFrame:rect];
            }
        }else{
//            segmentCT.selectedSegmentIndex=0;
            NSMutableArray *mutableArr=[NSMutableArray array];
            for (NSDictionary * dic in arr_plan) {
                [mutableArr addObject:[ExpertJingjiModel expertJingjiWithDic:dic]];
            }
            _searchRuArr=mutableArr;
            CGRect rect=_schListTable.frame;
            if ([str isEqualToString:@""]) {
                _searchType=@"";
                _schListTable.tableHeaderView=hotRcomdBg;
                rect.origin.y=rect.origin.y+0.5;
                if((58+45*MyWidth/320)*[_searchRuArr count]+hotRcomdBg.frame.size.height>MyHight-64){
                    rect.size.height=MyHight-64;
                }else{
                    rect.size.height=(58+45*MyWidth/320)*[_searchRuArr count]+hotRcomdBg.frame.size.height;
                }
                segmentBg.hidden=YES;
                hotRcomdBg.hidden=NO;
            }else{
                _searchType=@"方案";
                _schListTable.tableHeaderView=segmentBg;
                if((58+45*MyWidth/320)*[_searchRuArr count]+60>MyHight-64){
                    rect.size.height=MyHight-64;
                }else{
                    rect.size.height=(58+45*MyWidth/320)*[_searchRuArr count]+60;
                }
                segmentBg.hidden=NO;
                hotRcomdBg.hidden=YES;
            }
            
            _schListTable.hidden=NO;
//            [_schListTable setFrame:rect];
            [_schListTable setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, MyHight-HEIGHTBELOESYSSEVER-44)];
        }
        [_schListTable reloadData];
    } failure:^(NSError * error) {
        NSLog(@"error3=%@",error);
    }];
}

- (void)searchExpertRequest{
    segmentCT.selectedSegmentIndex = 1;
    NSString *labelId = @"";
    NSArray *labelNameAry = [NSArray arrayWithObjects:
                             @"TV名嘴带你看推荐",
                             @"媒体记者带你看推荐",
                             @"足球名将带你看推荐",
                             @"彩票专家带你看推荐",
                             @"连红牛人带你看推荐",
                             @"民间高手带你看推荐", nil];
    for (NSInteger i=0;i<labelNameAry.count;i++){
        NSString *ss = [labelNameAry objectAtIndex:i];
        if([ss isEqualToString:_wordSearch]){
            labelId = [NSString stringWithFormat:@"%d",i+1];
            break;
        }else{
        }
    }
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"serchExpertsList",@"parameters":@{@"keywords":_wordSearch,@"levelType":@"1",@"sdFlag":[NSString stringWithFormat:@"%i",self.isSdOrNo],@"curPage":@"1",@"pageSize":@"20",@"sid":[[Info getInstance] cbSID],@"labelId":labelId}}];
    
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSDictionary *dic=responseJSON;
        NSArray *arr_expert=dic[@"result"][@"data"];
        if(_searchRuArr){
            _searchRuArr=nil;
        }
        if(arr_expert==nil || [arr_expert count]==0){
            if (doSearch) {
                [self searchPlanRequest:@""];
                doSearch = NO;
            }
        }else{
            _searchType=@"专家";
            _schListTable.tableHeaderView=segmentBg;
//            segmentCT.selectedSegmentIndex=1;
            NSMutableArray *mutableArr=[NSMutableArray array];
            for (NSDictionary * dic in arr_expert) {
                [mutableArr addObject:[ExpertJingjiModel expertJingjiWithDic:dic]];
            }
            _searchRuArr=mutableArr;
            
            CGRect rect=_schListTable.frame;
            if((58+45*MyWidth/320)*[_searchRuArr count]+60>MyHight-64){
                rect.size.height=MyHight-64;
            }else{
                rect.size.height=(58+45*MyWidth/320)*[_searchRuArr count]+60;
            }
//            [_schListTable setFrame:rect];
            [_schListTable setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44, MyWidth, MyHight-HEIGHTBELOESYSSEVER-44)];
            segmentBg.hidden=NO;
            hotRcomdBg.hidden=YES;
            _schListTable.hidden=NO;
        }
        [_schListTable reloadData];
    } failure:^(NSError * error) {
        NSLog(@"error2=%@",error);
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark -----------------UITableViewDataSource---------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_shTableView) {
        return [_historyArr count];
    }else
        return [_searchRuArr count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    if (tableView==_shTableView) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, MyWidth-10, 44)];
        lab.text =[NSString stringWithFormat:@"%@",[_historyArr objectAtIndex:indexPath.row]];
        lab.textColor = BLACK_EIGHTYSEVER;
        lab.font=FONTTHIRTY;
        lab.backgroundColor=[UIColor clearColor];
        [cell addSubview:lab];
        
        SepratorLineView *sepretorLineView=[[SepratorLineView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame), MyWidth, 1)];
        sepretorLineView.backgroundColor=SEPARATORCOLOR;
        [cell addSubview:sepretorLineView];
        cell.backgroundColor=[UIColor clearColor];
        return cell;
    }else{
        ExpertJingjiModel *expertList=[_searchRuArr objectAtIndex:indexPath.row];
        
        if([_searchType isEqualToString:@"方案"]||[_searchType isEqualToString:@""]){
            ExpertDetailCell * cell=[ExpertDetailCell ExpertDetailCellWithTableView:tableView indexPath:indexPath];
            
            NSString *compTime=@"";
            NSString *odds=@"";
            NSString *matchs=@"";
            
            CGRect rect=cell.timeLab.frame;
            if([expertList.EXPERTS_CLASS_CODE isEqualToString:@"001"]){
                cell.zhongView.hidden=NO;
                cell.leagueTypeLab.hidden=NO;
                odds=[NSString stringWithFormat:@"%@中%@",expertList.ALL_HIT_NUM,expertList.HIT_NUM];
                if([odds isEqualToString:@"0中0"]||expertList.ALL_HIT_NUM<expertList.HIT_NUM){
                    cell.statLab.hidden=YES;
                    cell.zhongView.hidden=YES;
                }
                matchs=[NSString stringWithFormat:@"%@ VS %@",expertList.HOME_NAME,expertList.AWAY_NAME];
                compTime=[NSString stringWithFormat:@"%@ %@",expertList.MATCHES_ID,expertList.MATCH_TIME];
                rect.size.width=100;
            }else if([expertList.EXPERTS_CLASS_CODE isEqualToString:@"002"]){
                cell.zhongView.hidden=NO;
                cell.leagueTypeLab.hidden=NO;
                
                odds=[NSString stringWithFormat:@"%@中%@",expertList.ALL_HIT_NUM,expertList.HIT_NUM];
                if([odds isEqualToString:@"0中0"]||expertList.ALL_HIT_NUM<expertList.HIT_NUM){
                    odds = @"0中0";
                    cell.statLab.hidden=YES;
                    cell.zhongView.hidden=YES;
                }
                
                matchs=[NSString stringWithFormat:@"%@ %@期",[NSString lotteryTpye:expertList.LOTTEY_CLASS_CODE],expertList.ER_ISSUE];
                if (expertList.END_TIME!=nil&&![expertList.END_TIME isEqualToString:@""]) {
                    compTime=[NSString stringWithFormat:@"截止时间 %@",expertList.END_TIME];
                }else
                    compTime=@"截止时间";
                
                rect.size.width=150;
            }
            [cell.timeLab setFrame:rect];
            
            if([expertList.LOTTEY_CLASS_CODE isEqualToString:@"201"]){
                NSString *matchs2=[NSString stringWithFormat:@"%@ VS %@",expertList.HOME_NAME2,expertList.AWAY_NAME2];
                
                NSString *compTime2=[NSString stringWithFormat:@"%@ %@",expertList.MATCHES_ID2,expertList.MATCH_TIME2];
                [cell expertHead:expertList.HEAD_PORTRAIT name:expertList.EXPERTS_NICK_NAME starNo:expertList.STAR odds:odds matchSides:matchs time:compTime leagueType:expertList.LEAGUE_NAME exPrice:expertList.PRICE exDiscount:expertList.DISCOUNT exRank:expertList.SOURCE refundOrNo:expertList.FREE_STATUS lotype:expertList.LOTTEY_CLASS_CODE name2:matchs2 time2:compTime2 league2:expertList.LEAGUE_NAME2];
            }else{
                if([expertList.LOTTEY_CLASS_CODE isEqualToString:@"204"]){//篮球
                    NSString *str = @"让分胜负";
                    if([expertList.PLAY_TYPE_CODE isEqualToString:@"29"]){
                        str = @"大小分";
                    }
                    matchs=[NSString stringWithFormat:@"%@(客)VS%@(主) \n%@ %@",expertList.AWAY_NAME,expertList.HOME_NAME,str,expertList.HOSTRQ];
                }
                [cell expertHead:expertList.HEAD_PORTRAIT name:expertList.EXPERTS_NICK_NAME starNo:expertList.STAR odds:odds matchSides:matchs time:compTime leagueType:expertList.LEAGUE_NAME exPrice:expertList.PRICE exDiscount:expertList.DISCOUNT exRank:expertList.SOURCE refundOrNo:expertList.FREE_STATUS lotype:expertList.LOTTEY_CLASS_CODE];
            }
            
            if (self.isSdOrNo) {
                cell.disCountLab.hidden=YES;
                cell.priceLab.hidden=YES;
                cell.rankImgView.hidden = YES;
            }
            
            return cell;
            
        }else if([_searchType isEqualToString:@"专家"]){
            SechExpIntroCell * cell=[SechExpIntroCell SechExpCellWithTableView:tableView indexPath:indexPath];
            [cell expertHead:expertList.HEAD_PORTRAIT name:expertList.EXPERTS_NICK_NAME exRank:expertList.SOURCE starNo:expertList.STAR exType:expertList.EXPERTS_CLASS_CODE exIntro:expertList.EXPERTS_INTRODUCTION];
                        if (self.isSdOrNo) {
                            cell.djImgV.hidden = YES;
                        }
            return cell;
        }
    }
    return nil;
}

#pragma mark -----------------UITableViewDelegate--------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_shTableView){
        return 45;
    }else{
        ExpertJingjiModel *expertList=[_searchRuArr objectAtIndex:indexPath.row];
        if([expertList.LOTTEY_CLASS_CODE isEqualToString:@"201"]){
            return 58+45*MyWidth/320 + 56;
        }
        return 58+45*MyWidth/320;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView==_shTableView) {
        if ([_historyArr count]==0) {
            return 0;
        }else
            return 45;
    }else
        return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    if(tableView==_shTableView){
        doSearch=YES;
        if (_shTableView) {
            [_shTableView removeFromSuperview];
            _shTableView=nil;
        }
        NSString *text=[_historyArr objectAtIndex:indexPath.row];
        _schBar.text=text;
        _wordSearch=text;
        if (IS_IOS7) {
            UITextField *field=(UITextField *)[[[[_schBar subviews] objectAtIndex:0] subviews] objectAtIndex:1];
            field.textColor=[UIColor blackColor];
        }
        [self searchPlanRequest:text];
    }else if(tableView==_schListTable){
        ExpertJingjiModel *expertList=[_searchRuArr objectAtIndex:indexPath.row];
        NSString *erAgOrId=@"";
        if(expertList.ER_AGINT_ORDER_ID){
            erAgOrId=expertList.ER_AGINT_ORDER_ID;
        }
        Info *info = [Info getInstance];
        NSString *nameSty=@"";
        if ([info.userId intValue]) {
            nameSty=[[Info getInstance] userName];
        }
        NSString *lotry=@"";
        if (expertList.LOTTEY_CLASS_CODE==nil||[expertList.LOTTEY_CLASS_CODE isEqualToString:@""]) {
            if ([expertList.EXPERTS_CLASS_CODE isEqualToString:@"001"]) {
                lotry=@"-201";
            }else if ([expertList.EXPERTS_CLASS_CODE isEqualToString:@"002"]){
                lotry=@"001";
            }
        }else
            lotry=expertList.LOTTEY_CLASS_CODE;
        NSMutableDictionary * bodyDic=[NSMutableDictionary dictionary];
        [bodyDic setObject:@"expertService" forKey:@"serviceName"];
        [bodyDic setObject:@"getExpertInfo" forKey:@"methodName"];
        [bodyDic setObject:@{@"expertsName":expertList.EXPERTS_NAME,@"expertsClassCode":expertList.EXPERTS_CLASS_CODE,@"loginUserName":nameSty,@"erAgintOrderId":erAgOrId,@"type":@"0",@"sdStatus":[NSString stringWithFormat:@"%i",self.isSdOrNo],@"sid":[[Info getInstance] cbSID],@"lotteryClassCode":lotry} forKey:@"parameters"];
        
        [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
            NSLog(@"responseJSON=%@",responseJSON);
            SMGDetailViewController * vc=[[SMGDetailViewController alloc]init];
            
            //建模型，请求数据
            NSDictionary *dic=responseJSON[@"result"][@"expertBaseInfo"];
            ExpertBaseInfo *exBase=[ExpertBaseInfo  expertBaseInfoWithDic:dic];
            
            if ([expertList.EXPERTS_CLASS_CODE isEqualToString:@"001"]) {
                vc.segmentOnClickIndexFlags=YES;
                vc.isSdOrNo=self.isSdOrNo;
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
                vc.planIDStr=erAgOrId;
                vc.jcyplryType=@"-201";
                if (![expertList.LOTTEY_CLASS_CODE isEqualToString:@""]&&expertList.LOTTEY_CLASS_CODE!=nil) {
                    vc.jcyplryType=expertList.LOTTEY_CLASS_CODE;
                }
            }else if([expertList.EXPERTS_CLASS_CODE isEqualToString:@"002"]){
                vc.segmentOnClickIndexFlags=NO;
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
                
                
                if([_searchType isEqualToString:@"方案"]||[_searchType isEqualToString:@""]){
                    if([expertList.LOTTEY_CLASS_CODE isEqualToString:@"001"]){
                        vc.lotryType=101;
                    }else if([expertList.LOTTEY_CLASS_CODE isEqualToString:@"113"]){
                        vc.lotryType=102;
                    }else if([expertList.LOTTEY_CLASS_CODE isEqualToString:@"002"]){
                        vc.lotryType=103;
                    }else if([expertList.LOTTEY_CLASS_CODE isEqualToString:@"108"]){
                        vc.lotryType=104;
                    }
                }else if ([_searchType isEqualToString:@"专家"]){
                    vc.lotryType=101;
                }
            }
            
            vc.exBaseInfo=exBase;
            [self.navigationController pushViewController:vc animated:YES];
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
        } failure:^(NSError * error) {
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
        }];
    }
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


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView==_shTableView) {
        if ([_historyArr count]!=0) {
            UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, MyWidth, 45)];
            lab.text=@"清空历史记录";
            lab.textAlignment=NSTextAlignmentCenter;
            lab.textColor=BLACK_FIFITYFOUR;
            lab.font=FONTTWENTY_FOUR;
            lab.backgroundColor=[UIColor clearColor];
            
            UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearHistory:)];
            lab.userInteractionEnabled=YES;
            [lab addGestureRecognizer:tapGesture];
            return lab;
        }
    }
    return nil;
}

- (void)clearHistory:(id)sender{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [self filename];
    [fileManager removeItemAtPath:plistPath error:nil];
    
    _historyArr=nil;
    [_shTableView removeFromSuperview];
    _shTableView=nil;
}

#define mark -------UISearchBarDelegate----------

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    if (IS_IOS7) {
        UITextField *field=(UITextField *)[[[[searchBar subviews] objectAtIndex:0] subviews] objectAtIndex:1];
        field.textColor=[UIColor blackColor];
    }
 
    //    [searchBar resignFirstResponder];
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    //    [searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if(searchBar.text==nil||[searchBar.text isEqualToString:@""]){
        return;
    }
    if (_shTableView) {
        [_shTableView removeFromSuperview];
        _shTableView=nil;
    }
    doSearch=YES;
    _wordSearch=searchBar.text;
    //将搜索字段写入本地字典中
    NSString *filename=[self filename];
    NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];  //读取数据
    NSMutableArray *resultData=[dic2 objectForKey:@"sHistory"];
    if (resultData==nil) {
        resultData=[NSMutableArray arrayWithObject:_wordSearch];
    }else{
        if (![resultData containsObject:_wordSearch]) {
            [resultData addObject:_wordSearch];
        }
    }
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:resultData,@"sHistory",nil];
    [dic writeToFile:filename atomically:YES];
    
    [self searchPlanRequest:_wordSearch];
    [searchBar resignFirstResponder];
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