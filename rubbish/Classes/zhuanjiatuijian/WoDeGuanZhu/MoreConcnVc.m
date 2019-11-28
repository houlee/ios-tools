//
//  MoreConcnVc.m
//  caibo
//
//  Created by zhoujunwang on 16/1/22.
//
//

#import "MoreConcnVc.h"
#import "ExpCusView.h"
#import "ExpertJingjiModel.h"
#import "MBProgressHUD+MJ.h"

@interface MoreConcnVc (){
    UISegmentedControl *segmentCT;
    UITableView *_tableView;
    NSInteger currentPage;
}

@property (nonatomic,copy)UIScrollView *scMoreConcn;

@property (nonatomic,strong) NSMutableArray *moreConcnAry;

@property (nonatomic,strong) NSMutableString *concernNameSty;

@end

@implementation MoreConcnVc

float HEIGHTMORECONCN=0.0f;


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
#if defined CRAZYSPORTS
    [self changeCSTitileColor];
#endif
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title_nav = @"更多关注";
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0) {
        HEIGHTMORECONCN=20.0f;
    }
    currentPage=1;
    _concernNameSty = [NSMutableString string];
    
    [self creatNavView];
    
    [self creatSegmentView];
    
    [self requestData:_expertType page:currentPage];
    
    if(_expertType==nil){
        _expertType=@"001";
    }
    
}

-(void)creatSegmentView
{
//    segmentCT=[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"竞彩亚盘",@"数字彩", nil]];
//    segmentCT.frame=CGRectMake(15,CGRectGetMaxY(self.navView.frame)+15,MyWidth-30,30);
//    if ([_expertType isEqualToString:@"001"]) {
//        segmentCT.selectedSegmentIndex=0;
//    }else if ([_expertType isEqualToString:@"002"]){
//        segmentCT.selectedSegmentIndex=1;
//    }
//    segmentCT.tintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"发布方案-确定按钮"]];
//    [segmentCT addTarget:self action:@selector(segmentOnClick:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:segmentCT];
//    
//    //阴影效果
//    UIImageView * shaowImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(segmentCT.frame)+15, MyWidth, 4)];
//    shaowImageView.image=[UIImage imageNamed:@"背景-1横条"];
//    [self.view addSubview:shaowImageView];
    
//    _scMoreConcn=[[UIScrollView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(segmentCT.frame)+19, MyWidth, MyHight-CGRectGetMaxY(segmentCT.frame)-64)];
    
#if defined CRAZYSPORTS
    _scMoreConcn=[[UIScrollView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navView.frame), MyWidth, MyHight-CGRectGetMaxY(segmentCT.frame)-64)];
#else
    segmentCT=[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"竞彩",@"数字彩", nil]];
    segmentCT.frame=CGRectMake(15,CGRectGetMaxY(self.navView.frame)+15,MyWidth-30,30);
    if ([_expertType isEqualToString:@"001"]) {
        segmentCT.selectedSegmentIndex=0;
    }else if ([_expertType isEqualToString:@"002"]){
        segmentCT.selectedSegmentIndex=1;
    }
    segmentCT.tintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"发布方案-确定按钮"]];
    [segmentCT addTarget:self action:@selector(segmentOnClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentCT];
    
    //阴影效果
    UIImageView * shaowImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(segmentCT.frame)+15, MyWidth, 4)];
    shaowImageView.image=[UIImage imageNamed:@"背景-1横条"];
    [self.view addSubview:shaowImageView];
    
    _scMoreConcn=[[UIScrollView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(segmentCT.frame)+19, MyWidth, MyHight-CGRectGetMaxY(segmentCT.frame)-64)];

#endif
    
    _scMoreConcn.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_scMoreConcn];
    
    UIButton *newBatchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [newBatchBtn setFrame:CGRectMake(0, MyHight-45-HEIGHTMORECONCN, MyWidth/2, 45)];
    [newBatchBtn setBackgroundColor:[UIColor colorWithHexString:@"13A3FF"]];
#if defined CRAZYSPORTS
    [newBatchBtn setBackgroundColor:CS_NAVAGATION_COLOR];
#endif
    [newBatchBtn setTitle:@"换一批" forState:UIControlStateNormal];
    [newBatchBtn setTitle:@"换一批" forState:UIControlStateHighlighted];
    [newBatchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newBatchBtn setTitleColor:[UIColor colorWithRed:19.0/255 green:163.0/255 blue:255.0/255 alpha:0.70] forState:UIControlStateHighlighted];
    [newBatchBtn addTarget:self action:@selector(newBatchPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newBatchBtn];
    
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(MyWidth/2-0.5, MyHight-45-HEIGHTMORECONCN, 1, 45)];
    [line setBackgroundColor:SEPARATORCOLOR];
    [self.view addSubview:line];
    
    UIButton *allBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [allBtn setFrame:CGRectMake(MyWidth/2, MyHight-45-HEIGHTMORECONCN, MyWidth/2, 45)];
    [allBtn setBackgroundColor:[UIColor colorWithHexString:@"13A3FF"]];
#if defined CRAZYSPORTS
    [allBtn setBackgroundColor:CS_NAVAGATION_COLOR];
#endif
    [allBtn setTitle:@"全部关注" forState:UIControlStateNormal];
    [allBtn setTitle:@"全部关注" forState:UIControlStateHighlighted];
    [allBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [allBtn setTitleColor:[UIColor colorWithRed:19.0/255 green:163.0/255 blue:255.0/255 alpha:0.70] forState:UIControlStateHighlighted];
    [allBtn addTarget:self action:@selector(allConcern:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:allBtn];
     
}

- (void)newBatchPress:(id)sender{
    currentPage++;
    [self requestData:_expertType page:currentPage];
}

- (void)allConcern:(id)sender{
    NSLog(@"全部关注");
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"focusExpert",@"parameters":@{@"expertClassCode":_expertType,@"userName":[[Info getInstance] userName],@"expertName":_concernNameSty}}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        NSLog(@"关注成功");
        for (UIView *aview in [_scMoreConcn subviews]) {
            for (UIView * bview in [aview subviews]) {
                if ([bview isKindOfClass:[UIButton class]]) {
                    UIButton *btn=(UIButton *)bview;
                    btn.selected=YES;
                }
            }
        }
    } failure:^(NSError * error) {
        
    }];
    
}

#pragma mark -segment的单击响应方法
-(void)segmentOnClick:(UISegmentedControl *)segment
{
    currentPage=1;
    NSInteger index=segment.selectedSegmentIndex;
    switch (index) {
        case 0:
        {
            _expertType=@"001";
            [self requestData:_expertType page:currentPage];
            break;
        }
        case 1:
        {
            _expertType=@"002";
            [self requestData:_expertType page:currentPage];
            break;
        }
        default:
            break;
    }
}

/**
 *  请求网络数据
 */
-(void)requestData:(NSString *)str page:(NSInteger)page
{
    for(UIView *view in [_scMoreConcn subviews]){
        [view removeFromSuperview];
    }
    if (_concernNameSty) {
        _concernNameSty=nil;
        _concernNameSty = [NSMutableString string];
    }
    NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"getMyMoreFocusExperts",@"parameters":@{@"expertsName":[[Info getInstance] userName],@"expertClassCode":str,@"curPage":[NSString stringWithFormat:@"%ld",(long)page],@"pageSize":@"20"}}];
    [MBProgressHUD showMessage:@"正在加载..."];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
        [MBProgressHUD hideHUD];
        NSArray *arr_plan=[responseJSON objectForKey:@"result"][@"data"];
        
        NSMutableArray *mutlArr=[NSMutableArray arrayWithCapacity:[arr_plan count]];
        for (NSDictionary * dic in arr_plan) {
            [mutlArr addObject:[ExpertJingjiModel expertJingjiWithDic:dic]];
        }
        _moreConcnAry=mutlArr;
        
        for (int i=0; i<[_moreConcnAry count]; i++) {
            ExpertJingjiModel *exFocMdl=[_moreConcnAry objectAtIndex:i];
            NSString *str=@"";
            if (i==0) {
                str=[NSString stringWithFormat:@"%@",exFocMdl.EXPERTS_NAME];
            }else
                str=[NSString stringWithFormat:@",%@",exFocMdl.EXPERTS_NAME];
            [_concernNameSty appendString:str];
            NSInteger a=i%3,b=i/3;
            ExpCusView *expCusView=[[ExpCusView alloc] initWithFrame:CGRectMake(a*MyWidth/3, b*119, MyWidth/3, 119)];
            expCusView.tag=100+i;
            if (b==0) {
                UIView *sepHorizon=[[UIView alloc] initWithFrame:CGRectMake(0, -2, expCusView.frame.size.width, 2)];
                sepHorizon.backgroundColor=SEPARATORCOLOR;
                [expCusView addSubview:sepHorizon];
            }
            [expCusView creatView];
            [expCusView.potratView setFrame:CGRectMake(expCusView.frame.size.width/2-27.5, 8, 55, 55)];
            expCusView.potratView.clipsToBounds=YES;
            expCusView.potratView.layer.masksToBounds=YES;
            expCusView.potratView.layer.cornerRadius=27.5;
            [expCusView.charatLab setFrame:CGRectMake(0, CGRectGetMaxY(expCusView.potratView.frame)+8, expCusView.frame.size.width, 12)];
            expCusView.charatLab.font=FONTTWENTY_FOUR;
            expCusView.charatLab.textColor=BLACK_EIGHTYSEVER;
            [expCusView setPortImg:exFocMdl.HEAD_PORTRAIT charaName:exFocMdl.EXPERTS_NICK_NAME hasFocus:exFocMdl.SOURCE];
            
            [expCusView.markView setFrame:CGRectMake(CGRectGetMinX(expCusView.potratView.frame)+37.5, CGRectGetMinY(expCusView.potratView.frame)+37.5, 15, 15)];
            expCusView.markView.layer.cornerRadius=7.5;
            expCusView.markView.layer.masksToBounds=YES;
            
            UIImage *img=[UIImage imageNamed:@"更多关注-加关注"];
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(expCusView.frame.size.width/2-img.size.width/2, CGRectGetMaxY(expCusView.charatLab.frame)+8, img.size.width, img.size.height)];
            [btn setBackgroundImage:[UIImage imageNamed:@"更多关注-加关注"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"更多关注-已关注"] forState:UIControlStateSelected];
            [btn setTitle:@"+关注" forState:UIControlStateNormal];
            [btn setTitle:@"已关注" forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor colorWithHexString:@"#13a3ff"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0] forState:UIControlStateSelected];
            btn.titleLabel.font=FONTTWENTY_FOUR;
            [btn addTarget:self action:@selector(focus:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=100+i;
            [expCusView addSubview:btn];
            [_scMoreConcn addSubview:expCusView];
            
            //UITapGestureRecognizer *tapPort=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focus:)];
            expCusView.userInteractionEnabled=YES;
            //[expCusView addGestureRecognizer:tapPort];
        }
        
        NSInteger count=0;
        if ([_moreConcnAry count]%3!=0.0) {
            count=[_moreConcnAry count]/3+1;
        }else
            count=[_moreConcnAry count]/3;
        [_scMoreConcn setContentSize:CGSizeMake(MyWidth, 119*count)];
        
    } failure:^(NSError * error) {
        [MBProgressHUD hideHUD];
    }];
}

- (void)focus:(UIButton *)btn{
    //ExpCusView *view=(ExpCusView *)sender.view;
    ExpertJingjiModel *exFocMdl=[_moreConcnAry objectAtIndex:btn.tag-100];
    if (btn.selected==NO) {
        NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"focusExpert",@"parameters":@{@"expertClassCode":_expertType,@"userName":[[Info getInstance] userName],@"expertName":exFocMdl.EXPERTS_NAME}}];
        [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
            NSLog(@"关注成功");
        } failure:^(NSError * error) {
            
        }];
    }else{
        NSMutableDictionary * bodyDic=[NSMutableDictionary dictionaryWithDictionary:@{@"serviceName":@"zjtjIndexService",@"methodName":@"cancelFocusExpert",@"parameters":@{@"expertClassCode":_expertType,@"userName":[[Info getInstance] userName],@"expertName":exFocMdl.EXPERTS_NAME}}];
        [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id responseJSON) {
            NSLog(@"取消关注成功");
        } failure:^(NSError * error) {
            
        }];
    }
    btn.selected=!btn.selected;

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