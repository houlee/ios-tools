//
//  SZCViewController.m
//  Experts
//
//  Created by mac on 15/11/4.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "SZCViewController.h"
#import "SZCCell.h"
#import "SZCSbViewController.h"
#import "GifButton.h"
#import "ClassifyCell.h"

@interface SZCViewController ()<GifButtonDelegate>

@property(nonatomic,strong)NSString *btnTit;

@property(nonatomic,strong)NSString *qishu;//彩票期数

@property(nonatomic,strong)NSDictionary *qsDic;

@property(nonatomic,strong)UITableView *LTTable;//筛选彩种列表

@property (nonatomic,strong)UIButton *ltBtn;//选择彩种的btn

@property (nonatomic,strong)UILabel *qsLab;//当前期次UILabel

@property (nonatomic,strong)UIView *ballNmWindow;//选球弹窗

@property (nonatomic,strong)UITableView *tableView;//选球列表

@property (nonatomic,strong)UIButton *commitBtn;//提交btn

@property (nonatomic,strong)UIButton *geBtn;//个位btn

@property (nonatomic,strong)UIButton *shiBtn;//十位btn

@property (nonatomic,strong)UIButton *baiBtn;//百位btn

@property (nonatomic,strong)NSArray *ltArr;//彩种数组

@property (nonatomic,strong)NSArray *rowNameArr;//行标题

@property (nonatomic,strong)NSArray *totalBallNmArr;//前区总数

@property (nonatomic,strong)NSString *alertType;//弹窗tag

@property (nonatomic,assign)NSInteger frontOrBack;//1、前区，2、后区(前区总数发生变化)

//每行显示的字符串
@property (nonatomic,strong)NSString *oneStr;
@property (nonatomic,strong)NSString *twoStr;
@property (nonatomic,strong)NSString *threeStr;
@property (nonatomic,strong)NSString *fourStr;
@property (nonatomic,strong)NSString *fiveStr;
@property (nonatomic,strong)NSString *sixStr;
@property (nonatomic,strong)NSString *sevenStr;
@property (nonatomic,strong)NSString *eightStr;
@property (nonatomic,strong)NSString *nineStr;
@property (nonatomic,strong)NSString *tenStr;
@property (nonatomic,strong)NSString *elvenStr;
@property (nonatomic,strong)NSString *twelveStr;

@property (nonatomic,strong)NSString *digitGeStr;
@property (nonatomic,strong)NSString *digitShiStr;
@property (nonatomic,strong)NSString *digitBaiStr;
@property (nonatomic,strong)NSString *digitTypeStr;//1、个位 2、十位 3、百位


//每行选球数组
@property (nonatomic,strong)NSMutableArray *firstRowArr;
@property (nonatomic,strong)NSMutableArray *secRowArr;
@property (nonatomic,strong)NSMutableArray *thirdRowArr;
@property (nonatomic,strong)NSMutableArray *fourRowArr;
@property (nonatomic,strong)NSMutableArray *fiveRowArr;
@property (nonatomic,strong)NSMutableArray *sixRowArr;
@property (nonatomic,strong)NSMutableArray *severRowArr;
@property (nonatomic,strong)NSMutableArray *eightRowArr;
@property (nonatomic,strong)NSMutableArray *nineRowArr;
@property (nonatomic,strong)NSMutableArray *tenRowArr;
@property (nonatomic,strong)NSMutableArray *elevenRowArr;
@property (nonatomic,strong)NSMutableArray *twelveRowArr;

@end

@implementation SZCViewController

#pragma mark ----------GifButtonDelegate-----------

-(void)animationCompleted:(GifButton *)gifButton{
    if ([self.alertType isEqualToString:@"1"]||[self.alertType isEqualToString:@"3"]||[self.alertType isEqualToString:@"5"]||[self.alertType isEqualToString:@"7"]||[self.alertType isEqualToString:@"9"]||[self.alertType isEqualToString:@"11"]||[self.alertType isEqualToString:@"13"]) {
        NSInteger nmb=0;
        if (_szcType==0) {
            nmb=33;
        }else if(_szcType==1){
            nmb=35;
        }else if(_szcType==2||_szcType==3){
            nmb=10;
        }
        for (int k = 0; k < nmb; k++) {
            UIButton *btn = (UIButton *)[self.ballNmWindow viewWithTag:100+k];
            NSString *str = [NSString stringWithFormat:@"%@",btn.titleLabel.text];
            if ([btn isKindOfClass:[UIButton class]]&& btn.isSelected) {
                if ([self.alertType isEqualToString:@"1"]) {
                    [self.firstRowArr removeObject:str];
                }else if([self.alertType isEqualToString:@"3"]){
                    [self.secRowArr removeObject:str];
                }else if([self.alertType isEqualToString:@"5"]){
                    [self.thirdRowArr removeObject:str];
                }else if ([self.alertType isEqualToString:@"7"]) {
                    [self.fourRowArr removeObject:str];
                }else  if ([self.alertType isEqualToString:@"9"]) {
                    [self.fiveRowArr removeObject:str];
                }else if ([self.alertType isEqualToString:@"11"]) {
                    [self.sixRowArr removeObject:str];
                }else if ([self.alertType isEqualToString:@"13"]) {
                    [self.severRowArr removeObject:str];
                }
                btn.selected = NO;
            }
        }
    }else if([self.alertType isEqualToString:@"15"]||[self.alertType isEqualToString:@"17"]||[self.alertType isEqualToString:@"19"]||[self.alertType isEqualToString:@"21"]){
        NSInteger nmb=0;
        if (_szcType==0) {
            nmb=16;
        }else if(_szcType==1){
            nmb=12;
        }else if(_szcType==2||_szcType==3){
            nmb=10;
            if ([self.alertType isEqualToString:@"21"]) {
                nmb=28;
            }
        }
        for (int k = 0; k < nmb; k++) {
            UIButton *btn = (UIButton *)[self.ballNmWindow viewWithTag:100+k];
            NSString *str = [NSString stringWithFormat:@"%@",btn.titleLabel.text];
            if ([btn isKindOfClass:[UIButton class]]&& btn.isSelected) {
                if ([self.alertType isEqualToString:@"15"]) {
                    [self.eightRowArr removeObject:str];
                }else if ([self.alertType isEqualToString:@"17"]) {
                    [self.nineRowArr removeObject:str];
                }else if ([self.alertType isEqualToString:@"19"]) {
                    [self.tenRowArr removeObject:str];
                }else if ([self.alertType isEqualToString:@"21"]) {
                    [self.elevenRowArr removeObject:str];
                }
                btn.selected = NO;
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle_nav:@"发布方案"];
    [self creatNavView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"ecedf1"];

    _ltArr=[[NSMutableArray alloc] initWithObjects:@"双色球", @"大乐透", @"3D", @"排列三", nil];
    if (_szcType==0) {
        self.rowNameArr = @[@"红球\n20码",@"红球\n12码",@"红球\n3胆",@"红球\n独胆",@"红球\n杀6码",@"龙头",@"凤尾",@"蓝球\n3码",@"蓝球\n杀3码",@"12+3\n复式单"];
        self.totalBallNmArr = [[NSArray alloc] initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",nil];
        self.qsDic=self.resDic1;
        self.btnTit=@"双色球";
    }else if (_szcType==1) {
        self.rowNameArr = @[@"前区\n20码",@"前区\n10码",@"前区\n3胆",@"前区\n独胆",@"前区\n杀6码",@"龙头",@"凤尾",@"后区\n3码",@"后区\n杀6码",@"10+3\n复式单"];
        self.totalBallNmArr = [[NSArray alloc] initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",nil];
        self.qsDic=self.resDic2;
        self.btnTit=@"大乐透";
    }else if(_szcType==2||_szcType==3){
        self.rowNameArr = @[@"独胆",@"双胆",@"三胆",@"杀一码",@"5码复式",@"6码复式",@"3跨度",@"5码定位\n(百位)",@"5码定位\n(十位)",@"5码定位\n(个位)",@"和值",@"包星"];
        if (_szcType==2) {
            self.qsDic=self.resDic3;
            self.btnTit=@"3D";
        }else if(_szcType==3){
            self.qsDic=self.resDic4;
            self.btnTit=@"排列三";
        }
    }
    [self resetData];//初始化数据
    
    [self creatSSTabView];
    
    self.ballNmWindow = [[UIView alloc] init];
    self.ballNmWindow.backgroundColor = TEXTWITER_COLOR;
    [self.view addSubview:self.ballNmWindow];
}

- (void)resetData{
    self.qishu = self.qsDic[@"NAME"];
    
    self.alertType = @"";
    
    self.oneStr = @"";
    self.twoStr = @"";
    self.threeStr = @"";
    self.fourStr = @"";
    self.fiveStr = @"";
    self.sixStr = @"";
    self.sevenStr = @"";
    self.eightStr = @"";
    self.nineStr = @"";
    self.tenStr = @"";
    self.elvenStr = @"";
    self.twelveStr = @"";
    
    self.digitGeStr=@"";
    self.digitShiStr=@"";
    self.digitBaiStr=@"";
    self.digitTypeStr=@"1";
    
    self.firstRowArr=nil;
    self.secRowArr=nil;
    self.thirdRowArr=nil;
    self.fourRowArr=nil;
    self.fiveRowArr=nil;
    self.sixRowArr=nil;
    self.severRowArr=nil;
    self.eightRowArr=nil;
    self.nineRowArr=nil;
    self.tenRowArr=nil;
    self.elevenRowArr=nil;
    self.twelveRowArr=nil;
    
    self.firstRowArr=[NSMutableArray array];
    self.secRowArr=[NSMutableArray array];
    self.thirdRowArr=[NSMutableArray array];
    self.fourRowArr= [NSMutableArray array];
    self.fiveRowArr=[NSMutableArray array];
    self.sixRowArr=[NSMutableArray array];
    self.severRowArr=[NSMutableArray array];
    self.eightRowArr=[NSMutableArray array];
    self.nineRowArr=[NSMutableArray array];
    self.tenRowArr=[NSMutableArray array];
    self.elevenRowArr=[NSMutableArray array];
    self.twelveRowArr=[NSMutableArray array];
    
    _commitBtn.userInteractionEnabled = NO;
    [_commitBtn setBackgroundImage:[UIImage imageNamed:@"通用-信息填写前"] forState:normal];
}

-(void)creatSSTabView
{
    UIView *typeView = [[UIView alloc]initWithFrame:CGRectMake(0,44+HEIGHTBELOESYSSEVER, MyWidth, 35)];
    typeView.backgroundColor = [UIColor colorWithHexString:@"fcfcfc"];
    [self.view addSubview:typeView];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.masksToBounds=YES;
    btn.tag=201;
    btn.layer.borderWidth=0.5;
    btn.layer.borderColor=V2LINE_COLOR.CGColor;
    [btn setFrame:CGRectMake(0, 0, MyWidth, 35)];
    [btn setTitle:_btnTit forState:UIControlStateNormal];
    [btn setTitle:_btnTit forState:UIControlStateSelected];
    [btn setTitleColor:BLACK_EIGHTYSEVER forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:21.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1.0] forState:UIControlStateSelected];
    btn.backgroundColor=[UIColor clearColor];
    btn.titleLabel.font=FONTTWENTY_FOUR;
    [btn addTarget:self action:@selector(chioceTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [typeView addSubview:btn];
    _ltBtn=btn;
    
    CGSize btnsize=[PublicMethod setNameFontSize:btn.titleLabel.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(11.5, MyWidth/2-(btnsize.width+6*MyWidth/320+10)/2, 11.5, MyWidth/2-(btnsize.width+6*MyWidth/320+10)/2+6*MyWidth/320+10)];
    
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(MyWidth/2+(btnsize.width+6*MyWidth/320)/2-5, 15, 10, 5)];
    imgView.image=[UIImage imageNamed:@"triangle-selected-down"];
    [btn addSubview:imgView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44+35, self.view.frame.size.width,self.view.frame.size.height-HEIGHTBELOESYSSEVER-44) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithHexString:@"fcfcfc"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag=401;
    [self.view addSubview:_tableView];
    
    _LTTable=[[UITableView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(typeView), MyWidth, 0) style:UITableViewStylePlain];
    _LTTable.backgroundColor=[UIColor whiteColor];
    _LTTable.dataSource=self;
    _LTTable.delegate=self;
    _LTTable.hidden=YES;
    _LTTable.tag=501;
    [self.view addSubview:_LTTable];
    
//    NSString *totalStr  = [NSString stringWithFormat:@"%@ 第 %@ 期",str,_qishu];
//    CGSize labSize = [PublicMethod setNameFontSize:totalStr andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:totalStr];
//    NSRange range =[totalStr rangeOfString:[NSString stringWithFormat:@"%@",_qishu]];
//    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range];

}

- (void)chioceTypeBtn:(UIButton *)btn{
    CGRect rect=_LTTable.frame;
    if (btn.tag==301) {
        btn.tag=201;
        _tableView.alpha=1.0;
        self.view.backgroundColor=TEXTWITER_COLOR;
        _LTTable.hidden=YES;
        for(UIView *view in [btn subviews]){
            if([view isKindOfClass:[UIImageView class]]){
                UIImageView *imgV=(UIImageView *)view;
                imgV.image=[UIImage imageNamed:@"triangle-selected-down"];
            }
        }
        rect.size.height=0;
    }else if(btn.tag==201){
        btn.tag=301;
        _tableView.alpha=0.6;
        self.view.backgroundColor=[UIColor blackColor];
        _LTTable.hidden=NO;
        for(UIView *view in [btn subviews]){
            if([view isKindOfClass:[UIImageView class]]){
                UIImageView *imgV=(UIImageView *)view;
                imgV.image=[UIImage imageNamed:@"triangle-selected-up"];
            }
        }
        rect.size.height=160;
    }
    [_LTTable setFrame:rect];
}

#pragma mark ------------UITextViewDelegate-----------

- (void)tableSetContent:(CGFloat)yHeight txtView:(UITextView *)txtView count:(int)count type:(NSString *)type rowArr:(NSMutableArray *)rowArr{
    if ([self.alertType intValue]<count&&[self.alertType intValue]%2==0) {
        if (rowArr.count!=0) {
            self.alertType=type;
//            NSString *contentOff=[NSString stringWithFormat:@"%f",_tableView.contentOffset.y];
//            [DEFAULTS setObject:contentOff forKey:@"contentOff"];
            [UIView transitionWithView:_tableView duration:0.5 options:0 animations:^{
                [_tableView setContentOffset:CGPointMake(0, yHeight)];
            } completion:^(BOOL finished) {
                [self showSelectBallView:txtView];
            }];
        }
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    textView.inputView = [[UIView alloc] initWithFrame:CGRectZero];
    self.ballNmWindow.hidden = YES;
    if (textView.tag == 100) {
        if ([self.alertType isEqualToString:@""]) {
            self.alertType = @"1";
            [UIView transitionWithView:_tableView duration:0.5 options:0 animations:^{
                [_tableView setContentOffset:CGPointMake(0, 40)];
            } completion:^(BOOL finished) {
                [self showSelectBallView:textView];
            }];
        }
    }else if (textView.tag == 101) {
        [self tableSetContent:80 txtView:textView count:4 type:@"3" rowArr:self.firstRowArr];
    }else if (textView.tag == 102){
        [self tableSetContent:120 txtView:textView count:6 type:@"5" rowArr:self.secRowArr];
    }else if (textView.tag == 103){
        [self tableSetContent:160 txtView:textView count:8 type:@"7" rowArr:self.thirdRowArr];
    }else if (textView.tag == 104){
        [self tableSetContent:200 txtView:textView count:10 type:@"9" rowArr:self.fourRowArr];
    }else if (textView.tag == 105){
        [self tableSetContent:240 txtView:textView count:12 type:@"11" rowArr:self.fiveRowArr];
    }else if (textView.tag == 106){
        [self tableSetContent:280 txtView:textView count:14 type:@"13" rowArr:self.sixRowArr];
    }else if (textView.tag == 107){
        [self tableSetContent:320 txtView:textView count:16 type:@"15" rowArr:self.severRowArr];
    }else if (textView.tag == 108){
        [self tableSetContent:360 txtView:textView count:18 type:@"17" rowArr:self.eightRowArr];
    }else if (textView.tag == 109){
        if(_szcType==0||_szcType==1){
            return NO;
        }else{
            [self tableSetContent:400 txtView:textView count:20 type:@"19" rowArr:self.nineRowArr];
        }
    }else if (textView.tag == 110){
        [self tableSetContent:440 txtView:textView count:22 type:@"21" rowArr:self.tenRowArr];
    }else if (textView.tag == 111){
        [self tableSetContent:480 txtView:textView count:24 type:@"23" rowArr:self.elevenRowArr];
    }
    return NO;
}

#pragma mark -----------显示弹窗-----------

- (void)setBtn:(UIButton *)btn normalName:(NSString *)normalName selectedName:(NSString *)selectedName{
    [btn setBackgroundImage:[UIImage imageNamed:normalName] forState:normal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedName] forState:UIControlStateSelected];
}

- (void)setBtn:(UIButton *)btn normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor{
    [btn setTitleColor:normalColor forState:normal];
    [btn setTitleColor:selectedColor forState:UIControlStateSelected];
}

- (void)choiceDigit:(UIButton *)btn{
    NSString *compareStr=@"";
    if (btn==_geBtn) {
        _digitTypeStr=@"1";
        _shiBtn.selected=NO;
        _baiBtn.selected=NO;
        compareStr=_digitGeStr;
    }else if (btn==_shiBtn) {
        _digitTypeStr=@"2";
        _geBtn.selected=NO;
        _baiBtn.selected=NO;
        compareStr=_digitShiStr;
    }else if (btn==_baiBtn) {
        _digitTypeStr=@"3";
        _geBtn.selected=NO;
        _shiBtn.selected=NO;
        compareStr=_digitBaiStr;
    }
    btn.selected=YES;

    for (int i=100;i<110;i++){
        UIButton *ballbtn = (UIButton *)[self.ballNmWindow viewWithTag:i];
        ballbtn.selected = NO;
        NSRange range = [compareStr rangeOfString:ballbtn.titleLabel.text];
        
        if ([_digitTypeStr isEqualToString:@"1"]&&![compareStr isEqualToString:@""]&&(range.location!= NSNotFound)) {
            ballbtn.selected=YES;
        }
        if ([_digitTypeStr isEqualToString:@"2"]&&![compareStr isEqualToString:@""]&&(range.location!= NSNotFound)) {
            ballbtn.selected=YES;
        }
        if ([_digitTypeStr isEqualToString:@"3"]&&![compareStr isEqualToString:@""]&&(range.location!= NSNotFound)) {
            ballbtn.selected=YES;
        }
    }
}

-(void)showSelectBallView:(UITextView *)textView
{
    _ltBtn.userInteractionEnabled=NO;
    for (UIView *subViews in self.ballNmWindow.subviews) {
        [subViews removeFromSuperview];
    }
    _tableView.scrollEnabled = NO;
    _tableView.userInteractionEnabled=NO;
    self.ballNmWindow.hidden = NO;
    
    NSInteger disFordigitToBall=0;

    CGRect rect;
    rect.origin.y=HEIGHTBELOESYSSEVER+44+76;
    if(_szcType==0||_szcType==1){
        if ([_alertType intValue]>=1&&[_alertType intValue]<=13&&[_alertType intValue]%2!=0) {
            _frontOrBack=1;
        }else if([_alertType intValue]>=15&&[_alertType intValue]<=17&&[_alertType intValue]%2!=0){
            _frontOrBack=2;
        }
        rect.origin.x=83.5;
        rect.size.width=MyWidth-95.5;
        
        rect.origin.x=38;
        rect.size.width=268;
        rect.size.height=253;
        
        if (_frontOrBack==1) {
            rect.size.height=339;
        }else if (_frontOrBack==2) {
            rect.size.height=213;
        }
    }else if(_szcType==2||_szcType==3){
        rect.origin.x=72;
        rect.size.width=234;
        rect.size.height=253;
        if([self.alertType isEqualToString:@"21"]){
            rect.size.height=271;
        }
        if ([self.alertType isEqualToString:@"23"]) {
            disFordigitToBall=25;
            rect.size.height=rect.size.height+disFordigitToBall;
        }
    }
    self.ballNmWindow.frame = rect;
    
    UIImageView *leftLab = [[UIImageView  alloc]initWithFrame:CGRectMake(0, 0, 1, self.ballNmWindow.frame.size.height-50)];
    leftLab.backgroundColor = [UIColor grayColor];
    leftLab.image = [UIImage imageNamed:@"vertical"];
    [self.ballNmWindow addSubview:leftLab];
    
    UIImageView *rightLab = [[UIImageView alloc]initWithFrame:CGRectMake(self.ballNmWindow.frame.size.width-1, 0, 1, self.ballNmWindow.frame.size.height-50)];
    rightLab.image = [UIImage imageNamed:@"vertical"];
    rightLab.backgroundColor = [UIColor grayColor];
    [self.ballNmWindow addSubview:rightLab];
    
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,75,25)];
    nameLab.font = FONTTWENTY_EIGHT;
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.textColor = TEXTWITER_COLOR;
    nameLab.backgroundColor = [UIColor redColor];
    [self.ballNmWindow addSubview:nameLab];
    if(_szcType==2||_szcType==3){
        nameLab.font = FONTTWENTY_EIGHT;
    }
    
    UILabel *countLab = [[UILabel alloc]initWithFrame:CGRectMake(nameLab.frame.size.width, 0, self.ballNmWindow.frame.size.width-nameLab.frame.size.width, 25)];
    countLab.textAlignment = NSTextAlignmentCenter;
    countLab.font = [UIFont systemFontOfSize:11.0];
    countLab.textColor = BLACK_EIGHTYSEVER;
    countLab.backgroundColor = [UIColor colorWithHexString:@"ffc832"];
    [self.ballNmWindow addSubview:countLab];
    if (_frontOrBack==2) {
        if (_szcType==1) {
            countLab.font = [UIFont systemFontOfSize:11];
            countLab.textAlignment = NSTextAlignmentCenter;
            countLab.backgroundColor = [UIColor colorWithHexString:@"ffc732"];
        }
    }
    if (_szcType==2||_szcType==3) {
        if ([_alertType intValue]>=1&&[_alertType intValue]<=11&&[_alertType intValue]%2!=0) {
            countLab.backgroundColor = [UIColor colorWithHexString:@"ffc732"];
        }
        if([_alertType intValue]>=13&&[_alertType intValue]<=23&&[_alertType intValue]%2!=0){
            countLab.backgroundColor = [UIColor colorWithHexString:@"ffc832"];
        }
    }
    
    NSArray  *arrCount;
    if (_frontOrBack==1) {
        if (_szcType==0) {
            arrCount = [[NSMutableArray alloc]initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",nil];
        }else if(_szcType==1){
            arrCount = [[NSMutableArray alloc]initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",nil];
        }
    }else if(_frontOrBack==2){
        if (_szcType==0) {
            arrCount = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16"];
        }else if (_szcType==1) {
            arrCount = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
        }
    }
    if (_szcType==2||_szcType==3) {
        if(![self.alertType isEqualToString:@"21"]){
            arrCount = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        }else
            arrCount = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27"];
        if ([self.alertType isEqualToString:@"23"]) {
            NSString *btnText=@"";
            for (int i=0; i<3; i++) {
                if (i==0) {
                    btnText=@"个位";
                }else if (i==1){
                    btnText=@"十位";
                }else if(i==2){
                    btnText=@"百位";
                }
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                [btn setFrame:CGRectMake(15+73*i, 35, 58, 25)];
                btn.tag=900+i;
                btn.titleLabel.font = [UIFont systemFontOfSize:11.0];
                [self setBtn:btn normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                [self setBtn:btn normalName:@"digitGray" selectedName:@"digitRed"];
                [btn setBackgroundColor:BLACK_TWENTYFOUR];
                [btn setTitle:btnText forState:UIControlStateNormal];
                [btn setTitle:btnText forState:UIControlStateSelected];
                [btn addTarget:self action:@selector(choiceDigit:) forControlEvents:UIControlEventTouchUpInside];
                [self.ballNmWindow addSubview:btn];
                if (i==0) {
                    _geBtn=btn;
                    _geBtn.selected=YES;
                    _digitTypeStr=@"1";
                }else if (i==1){
                    _shiBtn=btn;
                }else if(i==2){
                    _baiBtn=btn;
                }
            }
        }
    }
    
    UIButton *btnContent;
    for (int j = 0; j < [arrCount count]; j++) {
        btnContent = [UIButton buttonWithType:UIButtonTypeCustom];
        btnContent.clipsToBounds = YES;
        btnContent.tag=100+j;
        btnContent.titleLabel.font = FONTTHIRTY;
        btnContent.titleLabel.textAlignment = NSTextAlignmentCenter;
        btnContent.layer.cornerRadius = 15;
        [btnContent setTitle:[NSString stringWithFormat:@"%@",arrCount[j]] forState:normal];
        if (_frontOrBack==1) {
            btnContent.frame = CGRectMake(14+j%6*42,40+j/6*42,30,30);
        }else if (_frontOrBack==2) {
            btnContent.frame = CGRectMake(14+j%6*42,40+j/6*42,30,30);
        }
        if (_szcType==2||_szcType==3) {
            if(![self.alertType isEqualToString:@"21"]){
                btnContent.frame = CGRectMake(25+j%4*51,51+(j/4)*51+disFordigitToBall,30,30);
            }else
                btnContent.frame = CGRectMake(7+j%6*38,35+j/6*38,30,30);
            btnContent.titleLabel.textColor = BLACK_EIGHTYSEVER;
        }
        [self.ballNmWindow addSubview:btnContent];
        
        NSString *iStr = [NSString stringWithFormat:@"%@",btnContent.titleLabel.text];
        if ([self.alertType isEqualToString:@"1"]) {
            if (_szcType==0||_szcType==1) {
                if (_szcType==0) {
                    nameLab.text = @"红球20码";
                    countLab.text = @"请选出20个红球";
                }else if (_szcType==1) {
                    nameLab.text = @"前区20码";
                    countLab.text = @"请选出20个红球";
                }
                [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
                [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
            }else if(_szcType==2||_szcType==3){
                nameLab.text = @"独胆";
                countLab.text = @"请选出1个红球";
                [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
                [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
            }
            [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
        }else if([self.alertType isEqualToString:@"3"]){
            if (_szcType==0||_szcType==1) {
                if (_szcType==0) {
                    nameLab.text = @"红球12码";
                    countLab.text = @"请选出12个红球";
                }
                if (_szcType==1) {
                    nameLab.text = @"前区10码";
                    countLab.text = @"请选出10个红球";
                }
                [self setBtn:btnContent normalColor:TEXTWITER_COLOR selectedColor:TEXTWITER_COLOR];
                if(![self.firstRowArr containsObject:iStr]) {
                    [self setBtn:btnContent normalName:@"灰球-不在选择范围" selectedName:@"灰球-不在选择范围"];
                }else{
                    [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
                    [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                    [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
                }
            }else if (_szcType==2||_szcType==3) {
                nameLab.text = @"双胆";
                countLab.text = @"请选出1个红球";
                if ([self.firstRowArr containsObject:iStr]) {
                    [self.secRowArr addObject:iStr];
                    [self setBtn:btnContent normalName:@"红球" selectedName:@"红球"];
                    [self setBtn:btnContent normalColor:TEXTWITER_COLOR selectedColor:TEXTWITER_COLOR];
                }else {
                    [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
                    [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                    [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }else if([self.alertType isEqualToString:@"5"]){
            if(_szcType==0||_szcType==1){
                if (_szcType==0) {
                    nameLab.text = @"红球3胆";
                    countLab.text = @"请选出3个红球";
                }
                if (_szcType==1) {
                    nameLab.text = @"前区3胆";
                    countLab.text = @"请选出3个红球";
                }
                [self setBtn:btnContent normalColor:TEXTWITER_COLOR selectedColor:TEXTWITER_COLOR];
                if (![self.firstRowArr containsObject:iStr]) {
                    [self setBtn:btnContent normalName:@"灰球-不在选择范围" selectedName:@"灰球-不在选择范围"];
                }else{
                    [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
                    [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                    [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
                }
            }else if (_szcType==2||_szcType==3) {
                nameLab.text = @"三胆";
                countLab.text = @"请选出1个红球";
                if ([self.secRowArr containsObject:iStr]) {
                    [self.thirdRowArr addObject:iStr];
                    [self setBtn:btnContent normalName:@"红球" selectedName:@"红球"];
                }else{
                    [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
                    [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                    [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }else if([self.alertType isEqualToString:@"7"]){
            if (_szcType==0||_szcType==1) {
                if (_szcType==0) {
                    nameLab.text = @"红球独胆";
                    countLab.text = @"请选出1个红球";
                }else if (_szcType==1) {
                    nameLab.text = @"前区独胆";
                    countLab.text = @"请选出1个红球";
                }
                [self setBtn:btnContent normalColor:TEXTWITER_COLOR selectedColor:TEXTWITER_COLOR];
                if (![self.thirdRowArr containsObject:iStr]) {
                    [self setBtn:btnContent normalName:@"灰球-不在选择范围" selectedName:@"灰球-不在选择范围"];
                }else{
                    [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
                    if (_szcType==0) {
                        [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                    }
                    if (_szcType==1) {
                        [self setBtn:btnContent normalColor:[UIColor blackColor] selectedColor:TEXTWITER_COLOR];
                    }
                    [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
                }
            }else if(_szcType==2||_szcType==3){
                nameLab.text = @"杀一码";
                countLab.text = @"请选出1个黑球";
                [self setBtn:btnContent normalColor:TEXTWITER_COLOR selectedColor:TEXTWITER_COLOR];
                if ([self.thirdRowArr containsObject:iStr]) {
                    [self setBtn:btnContent normalName:@"灰球-不在选择范围" selectedName:@"灰球-不在选择范围"];
                }else{
                    [self setBtn:btnContent normalName:@"球-默认" selectedName:@"黑球-杀码"];
                    [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                    [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }else if([self.alertType isEqualToString:@"9"]){
            if (_szcType==0||_szcType==1) {
                if (_szcType==0) {
                    nameLab.text = @"红球杀6码";
                    countLab.text = @"请选出6个黑球";
                }
                if (_szcType==1) {
                    nameLab.text = @"前区杀6码";
                    countLab.text = @"请选出6个黑球";
                }
                [self setBtn:btnContent normalColor:TEXTWITER_COLOR selectedColor:TEXTWITER_COLOR];
                if ([self.firstRowArr containsObject:iStr]) {
                    [self setBtn:btnContent normalName:@"灰球-不在选择范围" selectedName:@"灰球-不在选择范围"];
                }else{
                    [self setBtn:btnContent normalName:@"球-默认" selectedName:@"黑球-杀码"];
                    if (_szcType==0) {
                        [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                    }
                    if (_szcType==1) {
                        [self setBtn:btnContent normalColor:[UIColor blackColor] selectedColor:TEXTWITER_COLOR];
                    }
                    [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
                }
            }else if(_szcType==2||_szcType==3){
                nameLab.text = @"5码复式";
                countLab.text = @"请选出5个红球";
                [self setBtn:btnContent normalColor:TEXTWITER_COLOR selectedColor:TEXTWITER_COLOR];
                if ([self.thirdRowArr containsObject:iStr]) {
                    [self.fiveRowArr addObject:iStr];
                    [self setBtn:btnContent normalName:@"红球" selectedName:@"红球"];
                }else{
                    [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
                    [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                    [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }else if([self.alertType isEqualToString:@"11"]){
            if (_szcType==0||_szcType==1) {
                nameLab.text = @"龙头";
                countLab.text = @"请选出1个红球";
                if(![self.firstRowArr containsObject:iStr]) {
                    [self setBtn:btnContent normalName:@"灰球-不在选择范围" selectedName:@"灰球-不在选择范围"];
                }else{
                    [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
                    [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                    if (_szcType==1) {
                        [self setBtn:btnContent normalColor:[UIColor blackColor] selectedColor:TEXTWITER_COLOR];
                    }
                    if ([iStr isEqualToString:[self.firstRowArr objectAtIndex:0]]) {
                        [self.sixRowArr addObject:[self.firstRowArr objectAtIndex:0]];
                        [self setBtn:btnContent normalName:@"红球" selectedName:@"球-默认"];
                        [self setBtn:btnContent normalColor:TEXTWITER_COLOR selectedColor:TEXTWITER_COLOR];
                    }else{
                        [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
                    }
                }
            }else if(_szcType==2||_szcType==3){
                nameLab.text = @"6码复式";
                countLab.text = @"请选出6个红球";
                if ([self.fiveRowArr containsObject:iStr]) {
                    [self.sixRowArr addObject:iStr];
                    [self setBtn:btnContent normalName:@"红球" selectedName:@"红球"];
                }else{
                    [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
                    [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                    [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }else if ([self.alertType isEqualToString:@"13"]) {
            if (_szcType==0||_szcType==1) {
                nameLab.text = @"凤尾";
                countLab.text = @"请选出1个红球";
                if(![self.firstRowArr containsObject:iStr]) {
                    [self setBtn:btnContent normalName:@"灰球-不在选择范围" selectedName:@"灰球-不在选择范围"];
                }else{
                    [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
                    [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                    if (_szcType==1) {
                        [self setBtn:btnContent normalColor:[UIColor blackColor] selectedColor:TEXTWITER_COLOR];
                    }
                    if ([iStr isEqualToString:[self.firstRowArr objectAtIndex:[self.firstRowArr count]-1]]) {
                        [self.severRowArr addObject:[self.firstRowArr objectAtIndex:[self.firstRowArr count]-1]];
                        [self setBtn:btnContent normalName:@"红球" selectedName:@"球-默认"];
                        [self setBtn:btnContent normalColor:TEXTWITER_COLOR selectedColor:TEXTWITER_COLOR];
                    }else{
                        [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
                    }
                }
            }else if(_szcType==2||_szcType==3){
                nameLab.text = @"3跨度";
                countLab.text = @"请选出3个红球";
                [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
                [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }else if([self.alertType isEqualToString:@"15"]){
            if (_szcType==0||_szcType==1) {
                if (_szcType==0) {
                    nameLab.text = @"蓝球3码";
                    countLab.text = @"请选出3个蓝球";
                }else if (_szcType==1) {
                    nameLab.text = @"后区3码";
                    countLab.text = @"请选出3个蓝球";
                }
                nameLab.backgroundColor = [UIColor colorWithRed:21.0/255 green:136.0/255 blue:218.0/255 alpha:0.9];
                [self setBtn:btnContent normalName:@"球-默认" selectedName:@"蓝球"];
                [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
            }else if(_szcType==2||_szcType==3){
                nameLab.text = @"百位";
                countLab.text = @"请选出5个红球";
                [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
                [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }else if([self.alertType isEqualToString:@"17"]){
            if (_szcType==0||_szcType==1) {
                if (_szcType==0) {
                    nameLab.text = @"蓝球杀3码";
                    countLab.text = @"请选出3个蓝球";
                }else if (_szcType==1) {
                    nameLab.text = @"后区杀6码";
                    countLab.text = @"请选出6个蓝球";
                }
                nameLab.backgroundColor = [UIColor colorWithRed:21.0/255 green:136.0/255 blue:218.0/255 alpha:0.9];
                [self setBtn:btnContent normalColor:TEXTWITER_COLOR selectedColor:TEXTWITER_COLOR];
                if ([self.eightRowArr containsObject:iStr]) {
                    [self setBtn:btnContent normalName:@"灰球-不在选择范围" selectedName:@"灰球-不在选择范围"];
                }else{
                    [self setBtn:btnContent normalName:@"球-默认" selectedName:@"黑球-杀码"];
                    [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                    [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
                }
            }else if(_szcType==2||_szcType==3){
                nameLab.text = @"十位";
                countLab.text = @"请选出5个红球";
                [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
                [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
                [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }else if([self.alertType isEqualToString:@"19"]){
            nameLab.text = @"个位";
            countLab.text = @"请选出5个红球";
            [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
            [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
            [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
        } else if([self.alertType isEqualToString:@"21"]){
            nameLab.text = @"和值";
            countLab.text = @"请选择4个红球";
            [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
            [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
            [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
        } else if([self.alertType isEqualToString:@"23"]){
            nameLab.text = @"包星";
            countLab.text = @"请选择2个红球";
            [self setBtn:btnContent normalName:@"球-默认" selectedName:@"红球"];
            [self setBtn:btnContent normalColor:BLACK_EIGHTYSEVER selectedColor:TEXTWITER_COLOR];
            [btnContent addTarget:self action:@selector(seletctBallClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    CGRect btnRect,redBtnRect;
    btnRect.size.width=36;
    btnRect.size.height=45;
    redBtnRect.size.width=32;
    redBtnRect.size.height=40;
    if (_frontOrBack==1) {
        btnRect.origin.x=ORIGIN_X(btnContent)+20;
        btnRect.origin.y=btnContent.frame.origin.y;
        redBtnRect.origin.x=ORIGIN_X(btnContent)+10.5;
        redBtnRect.origin.y=btnContent.frame.origin.y-6;
    }else if(_frontOrBack==2){
        if (_szcType==0) {
            btnRect.origin.x=ORIGIN_X(btnContent)+20;
            btnRect.origin.y=btnContent.frame.origin.y;
            redBtnRect.origin.x=ORIGIN_X(btnContent)+10.5;
            redBtnRect.origin.y=btnContent.frame.origin.y-6;
        }else if (_szcType==1) {
            btnRect.origin.x=12;
            btnRect.origin.y=ORIGIN_Y(btnContent);
            redBtnRect.origin.x=17.5;
            redBtnRect.origin.y=ORIGIN_Y(btnContent)+6;
        }
    }
    if (_szcType==2||_szcType==3) {
        btnRect.origin.x=ORIGIN_X(btnContent)+20;
        btnRect.origin.y=btnContent.frame.origin.y+disFordigitToBall;
        redBtnRect.origin.x=ORIGIN_X(btnContent)+19.5;
        if([self.alertType isEqualToString:@"21"]){
            redBtnRect.origin.x=ORIGIN_X(btnContent)+6.5;
        }
        redBtnRect.origin.y=btnContent.frame.origin.y-6;
    }
    GifButton * redTrashButton;
    redTrashButton = [[GifButton alloc] initTrashCanWithFrame:btnRect];
    [redTrashButton setFrame:redBtnRect];
    redTrashButton.tag = 333;
    redTrashButton.delegate = self;
    [redTrashButton.gifView setFrame:CGRectMake(8, 0, 24, 32)];
    [self.ballNmWindow addSubview:redTrashButton];
    
    UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleBtn.frame = CGRectMake(0, self.ballNmWindow.frame.size.height-44, self.ballNmWindow.frame.size.width/2, 44);
    deleBtn.backgroundColor = V2LINE_COLOR;
    [deleBtn addTarget:self action:@selector(hideSelectBallView:) forControlEvents:UIControlEventTouchUpInside];
    [deleBtn setTitle:@"取消" forState:normal];
    [self.ballNmWindow addSubview:deleBtn];
    
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    certainBtn.frame = CGRectMake(self.ballNmWindow.frame.size.width/2, self.ballNmWindow.frame.size.height-44, self.ballNmWindow.frame.size.width/2, 44);
    certainBtn.backgroundColor = [UIColor colorWithRed:21.0/255 green:136.0/255 blue:218.0/255 alpha:0.9];
    [certainBtn setTitle:@"确定" forState:normal];
    [certainBtn addTarget:self action:@selector(hideSelectBallView:) forControlEvents:UIControlEventTouchUpInside];
    [self.ballNmWindow addSubview:certainBtn];
    
    if (_szcType==2||_szcType==3) {
        if ([_alertType intValue]>=1&&[_alertType intValue]<=11&&[_alertType intValue]%2!=0) {
            deleBtn.frame = CGRectMake(0, self.ballNmWindow.frame.size.height-50, self.ballNmWindow.frame.size.width/2, 44);
            certainBtn.frame = CGRectMake(self.ballNmWindow.frame.size.width/2, self.ballNmWindow.frame.size.height-50, self.ballNmWindow.frame.size.width/2, 44);
        }
    }
    
    UIImageView *touYing=[[UIImageView alloc]initWithFrame:CGRectMake(0, ORIGIN_Y(deleBtn), self.ballNmWindow.frame.size.width, 2.5)];
    touYing.image=[UIImage imageNamed:@"touying"];
    [self.ballNmWindow addSubview:touYing];
    
    if ([self.alertType isEqualToString:@"1"]) {
        [self setDelTag:10001 cerTag:10002 delBtn:deleBtn cerBtn:certainBtn];
    }else if([self.alertType isEqualToString:@"3"]){
        [self setDelTag:10003 cerTag:10004 delBtn:deleBtn cerBtn:certainBtn];
    }else if([self.alertType isEqualToString:@"5"]){
        [self setDelTag:10005 cerTag:10006 delBtn:deleBtn cerBtn:certainBtn];
    }else if([self.alertType isEqualToString:@"7"]){
        [self setDelTag:10007 cerTag:10008 delBtn:deleBtn cerBtn:certainBtn];
    }else if([self.alertType isEqualToString:@"9"]){
        [self setDelTag:10009 cerTag:10010 delBtn:deleBtn cerBtn:certainBtn];
    }else if([self.alertType isEqualToString:@"11"]){
        [self setDelTag:10011 cerTag:10012 delBtn:deleBtn cerBtn:certainBtn];
    }else if([self.alertType isEqualToString:@"13"]){
        [self setDelTag:10013 cerTag:10014 delBtn:deleBtn cerBtn:certainBtn];
    }else  if([self.alertType isEqualToString:@"15"]){
        [self setDelTag:10015 cerTag:10016 delBtn:deleBtn cerBtn:certainBtn];
    }else  if([self.alertType isEqualToString:@"17"]){
        [self setDelTag:10017 cerTag:10018 delBtn:deleBtn cerBtn:certainBtn];
    }else  if([self.alertType isEqualToString:@"19"]){
        [self setDelTag:10019 cerTag:10020 delBtn:deleBtn cerBtn:certainBtn];
    }else  if([self.alertType isEqualToString:@"21"]){
        [self setDelTag:10021 cerTag:10022 delBtn:deleBtn cerBtn:certainBtn];
    }else  if([self.alertType isEqualToString:@"23"]){
        [self setDelTag:10023 cerTag:10024 delBtn:deleBtn cerBtn:certainBtn];
    }
}

- (void)setDelTag:(NSInteger)delTag cerTag:(NSInteger)cerTag delBtn:(UIButton *)delbtn cerBtn:(UIButton *)cerBtn{
    delbtn.tag = delTag;
    cerBtn.tag = cerTag;
}

#pragma mark -----------收起弹窗-----------------

- (void)hideAndScroll{
    if ([self.alertType intValue]>2) {
        [UIView transitionWithView:_tableView duration:0.5 options:0 animations:^{
//            CGFloat contentOff=[[DEFAULTS objectForKey:@"contentOff"] floatValue];
//            [_tableView setContentOffset:CGPointMake(0, contentOff)];
        } completion:^(BOOL finished) {
            
        }];
    }
    _ltBtn.userInteractionEnabled=YES;
    _tableView.scrollEnabled = YES;
    _tableView.userInteractionEnabled=YES;
    self.ballNmWindow.hidden = YES;
}

- (void)hideAndReload:(NSString *)type{
    self.alertType = type;
    [_tableView reloadData];
    [self hideAndScroll];
}

- (NSMutableArray *)setArrSort:(NSMutableArray *)arr{
    for (int j=0; j<[arr count]-1; j++) {
        for (int i=0; i<[arr count]-j-1; i++) {
            NSString *fStr=[arr objectAtIndex:i];
            NSString *bStr=[arr objectAtIndex:i+1];
            int ft=[fStr intValue];
            int bt=[bStr intValue];
            if (ft>bt) {
                NSString *noStr=[fStr copy];
                [arr replaceObjectAtIndex:i withObject:bStr];
                [arr replaceObjectAtIndex:i+1 withObject:noStr];
            }
        }
    }
    return arr;
}

-(void)alertActionDissmiss:(UIAlertView *)alert{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
}

- (void)showAlert{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"选号不足,请继续选择" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    [self performSelector:@selector(alertActionDissmiss:) withObject:alert afterDelay:1];
    return;
}

- (void)hideAlertAndSetRowData:(NSInteger)count dataArr:(NSMutableArray *)dataArr type:(NSString *)type{
    if (dataArr.count<count) {
        [self showAlert];
    }else if(dataArr.count==count){
        if([type isEqualToString:@"24"]){
            _commitBtn.userInteractionEnabled = YES;
            [_commitBtn setBackgroundImage:[UIImage imageNamed:@"通用-信息填写后"] forState:normal];
        }
        dataArr=[self setArrSort:dataArr];
        [self hideAndReload:type];
    }
}

- (void)cancleHide:(NSString *)type rowArr:(NSMutableArray *)rowArr{
    self.alertType = type;
    [rowArr removeAllObjects];
}

-(void)hideSelectBallView:(UIButton *)btn
{
    if (btn.tag>=10001&&btn.tag<=10023&&btn.tag%2==1) {
        for (UIView *subViews in self.ballNmWindow.subviews) {
            [subViews removeFromSuperview];
        }
        [self hideAndScroll];
    }
    NSInteger oneNo=0;
    NSInteger twno=0;
    NSInteger fiveNo=0;
    NSInteger sixNo=0;
    NSInteger sevenNo=0;
    NSInteger eightNo=0;
    NSInteger nineNo=0;
    if (_szcType==0) {
        twno=12;
        nineNo=3;
    }else if (_szcType==1){
        twno=10;
        nineNo=6;
    }
    if(_szcType==0||_szcType==1){
        oneNo=20;
        fiveNo=6;
        sixNo=2;
        sevenNo=2;
        eightNo=3;
    }else if(_szcType==2||_szcType==3){
        oneNo=1;
        twno=2;
        fiveNo=5;
        sixNo=6;
        sevenNo=3;
        eightNo=5;
        nineNo=5;
    }
    if (btn.tag == 10001) {
        [self cancleHide:@"" rowArr:self.firstRowArr];
    }else if (btn.tag == 10002){
        [self hideAlertAndSetRowData:oneNo dataArr:self.firstRowArr type:@"2"];
    }else if (btn.tag == 10003){
        [self cancleHide:@"2" rowArr:self.secRowArr];
    }else if(btn.tag == 10004){
        [self hideAlertAndSetRowData:twno dataArr:self.secRowArr type:@"4"];
    }else if (btn.tag == 10005){
        [self cancleHide:@"4" rowArr:self.thirdRowArr];
    }else if(btn.tag == 10006){
        [self hideAlertAndSetRowData:3 dataArr:self.thirdRowArr type:@"6"];
    }else if (btn.tag == 10007){
        [self cancleHide:@"6" rowArr:self.fourRowArr];
    }else if(btn.tag == 10008){
        [self hideAlertAndSetRowData:1 dataArr:self.fourRowArr type:@"8"];
    }else if (btn.tag == 10009){
        [self cancleHide:@"8" rowArr:self.fiveRowArr];
    }else if(btn.tag == 10010){
        [self hideAlertAndSetRowData:fiveNo dataArr:self.fiveRowArr type:@"10"];
    }else if (btn.tag == 10011){
        [self cancleHide:@"10" rowArr:self.sixRowArr];
    }else if(btn.tag == 10012){
        [self hideAlertAndSetRowData:sixNo dataArr:self.sixRowArr type:@"12"];
    }else if (btn.tag == 10013){
        [self cancleHide:@"12" rowArr:self.severRowArr];
    }else if(btn.tag == 10014){
        [self hideAlertAndSetRowData:sevenNo dataArr:self.severRowArr type:@"14"];
    }else if (btn.tag == 10015){
        [self cancleHide:@"14" rowArr:self.eightRowArr];
    }else if(btn.tag == 10016){
        [self hideAlertAndSetRowData:eightNo dataArr:self.eightRowArr type:@"16"];
    }else if (btn.tag == 10017){
        [self cancleHide:@"16" rowArr:self.nineRowArr];
    }else if(btn.tag == 10018){
        [self hideAlertAndSetRowData:nineNo dataArr:self.nineRowArr type:@"18"];
        if (_szcType==0||_szcType==1) {
            _commitBtn.userInteractionEnabled = YES;
            [_commitBtn setBackgroundImage:[UIImage imageNamed:@"通用-信息填写后"] forState:normal];
        }
    }else if (btn.tag == 10019){
        [self cancleHide:@"18" rowArr:self.tenRowArr];
     }else if(btn.tag == 10020){
        [self hideAlertAndSetRowData:5 dataArr:self.tenRowArr type:@"20"];
    }else if (btn.tag == 10021){
        [self cancleHide:@"20" rowArr:self.elevenRowArr];
    }else if(btn.tag == 10022){
        [self hideAlertAndSetRowData:4 dataArr:self.elevenRowArr type:@"22"];
    }else if (btn.tag == 10023){
        [self cancleHide:@"22" rowArr:self.twelveRowArr];
        _digitGeStr=@"";
        _digitShiStr=@"";
        _digitBaiStr=@"";
        _digitTypeStr=@"1";
    }else if(btn.tag == 10024){
        if (![_digitGeStr isEqualToString:@""]&&![self.twelveRowArr containsObject:_digitGeStr]) {
            [self.twelveRowArr addObject:_digitGeStr];
        }
        if (![_digitShiStr isEqualToString:@""]&&![self.twelveRowArr containsObject:_digitShiStr]) {
            [self.twelveRowArr addObject:_digitShiStr];
        }
        if (![_digitBaiStr isEqualToString:@""]&&![self.twelveRowArr containsObject:_digitBaiStr]) {
            [self.twelveRowArr addObject:_digitBaiStr];
        }

        [self hideAlertAndSetRowData:2 dataArr:self.twelveRowArr type:@"24"];
    }
}

#pragma mark ----------选球事件-----------

- (void)selBtn:(UIButton *)selBtn rowArr:(NSMutableArray *)rowArr count:(NSInteger)count{
    if (selBtn.selected == YES) {
        [rowArr removeObject:selBtn.titleLabel.text];
        selBtn.selected = NO;
    }else{
        if (rowArr.count>=count) {
            selBtn.selected = NO;
        }else{
            [rowArr addObject:selBtn.titleLabel.text];
            selBtn.selected = YES;
        }
    }
}

- (void)reelectBtn:(UIButton *)reelectBtn rowArr:(NSMutableArray *)rowArr{
    for (int i=100;i<110;i++){
        UIButton *btn = (UIButton *)[self.ballNmWindow viewWithTag:i];
        if (btn.selected==YES) {
            [rowArr removeObject:btn.titleLabel.text];
            btn.selected = NO;
        }
    }
    reelectBtn.selected = YES;
    [rowArr addObject:reelectBtn.titleLabel.text];
}

- (void)seletctBallClick:(UIButton *)btn
{
    NSInteger secRwNm=0;
    NSInteger fiveRwNm=0;
    NSInteger sixRwNm=0;
    NSInteger sevenRwNm=0;
    NSInteger eightRwNm=0;
    NSInteger nineRowNm=0;
    if (_szcType==0) {
        secRwNm=12;
        nineRowNm=3;
    }else if (_szcType==1) {
        secRwNm=10;
        nineRowNm=6;
    }
    if(_szcType==0||_szcType==1){
        fiveRwNm=6;
        sixRwNm=2;
        sevenRwNm=2;
        eightRwNm=3;
    }else if(_szcType==2||_szcType==3){
        fiveRwNm=5;
        sixRwNm=6;
        sevenRwNm=3;
        eightRwNm=5;
        nineRowNm=5;
    }

    if ([self.alertType isEqualToString:@"1"]) {
        if(_szcType==0||_szcType==1){
            [self selBtn:btn rowArr:self.firstRowArr count:20];
        }else if(_szcType==2||_szcType==3){
            [self reelectBtn:btn rowArr:self.firstRowArr];
        }
    }else if([self.alertType isEqualToString:@"3"]){
        if(_szcType==0||_szcType==1){
            [self selBtn:btn rowArr:self.secRowArr count:secRwNm];
        }else if(_szcType==2||_szcType==3){
            [self reelectBtn:btn rowArr:self.secRowArr];
        }
    }else if([self.alertType isEqualToString:@"5"]){
        if(_szcType==0||_szcType==1){
            [self selBtn:btn rowArr:self.thirdRowArr count:3];
        }else if(_szcType==2||_szcType==3){
            [self reelectBtn:btn rowArr:self.thirdRowArr];
        }
    }else if ([self.alertType isEqualToString:@"7"]) {
        if(_szcType==0||_szcType==1){
            [self selBtn:btn rowArr:self.fourRowArr count:1];
        }else if(_szcType==2||_szcType==3){
            [self reelectBtn:btn rowArr:self.fourRowArr];
        }
    }else if ([self.alertType isEqualToString:@"9"]) {
        [self selBtn:btn rowArr:self.fiveRowArr count:fiveRwNm];
    }else if ([self.alertType isEqualToString:@"11"]) {
        [self selBtn:btn rowArr:self.sixRowArr count:sixRwNm];
    }else if ([self.alertType isEqualToString:@"13"]) {
        [self selBtn:btn rowArr:self.severRowArr count:sevenRwNm];
    }else if ([self.alertType isEqualToString:@"15"]) {
        [self selBtn:btn rowArr:self.eightRowArr count:eightRwNm];
    }else if ([self.alertType isEqualToString:@"17"]) {
        [self selBtn:btn rowArr:self.nineRowArr count:nineRowNm];
    }else if ([self.alertType isEqualToString:@"19"]) {
        [self selBtn:btn rowArr:self.tenRowArr count:5];
    }else if ([self.alertType isEqualToString:@"21"]) {
        [self selBtn:btn rowArr:self.elevenRowArr count:4];
    }else if ([self.alertType isEqualToString:@"23"]) {
        NSInteger digitNo=0;
        if (![_digitGeStr isEqualToString:@""]&&_digitGeStr!=nil) {
            digitNo++;
        }
        if (![_digitShiStr isEqualToString:@""]&&_digitShiStr!=nil) {
            digitNo++;
        }
        if (![_digitBaiStr isEqualToString:@""]&&_digitBaiStr!=nil) {
            digitNo++;
        }
        if (digitNo<2||(digitNo>=2&&(([_digitTypeStr isEqualToString:@"1"]&&![_digitGeStr isEqualToString:@""])||([_digitTypeStr isEqualToString:@"2"]&&![_digitShiStr isEqualToString:@""])||([_digitTypeStr isEqualToString:@"3"]&&![_digitBaiStr isEqualToString:@""])))) {
            if (btn.selected == YES) {
                NSString *str=@"";
                if ([_digitTypeStr isEqualToString:@"1"]) {
                    str=[NSString stringWithFormat:@"**%@", btn.titleLabel.text];
                    _digitGeStr=@"";
                }else if ([_digitTypeStr isEqualToString:@"2"]) {
                    str=[NSString stringWithFormat:@"*%@*", btn.titleLabel.text];
                    _digitShiStr=@"";
                }else if ([_digitTypeStr isEqualToString:@"3"]) {
                    str=[NSString stringWithFormat:@"%@**", btn.titleLabel.text];
                    _digitBaiStr=@"";
                }
                [self.twelveRowArr removeObject:str];
                btn.selected = NO;
            }else{
                for (int i=100;i<110;i++){
                    UIButton *otherbtn = (UIButton *)[self.ballNmWindow viewWithTag:i];
                    if (otherbtn.selected==YES) {
                        otherbtn.selected = NO;
                        NSString *str=@"";
                        if ([_digitTypeStr isEqualToString:@"1"]) {
                            str=[NSString stringWithFormat:@"**%@", otherbtn.titleLabel.text];
                        }else if ([_digitTypeStr isEqualToString:@"2"]) {
                            str=[NSString stringWithFormat:@"*%@*", otherbtn.titleLabel.text];
                        }else if ([_digitTypeStr isEqualToString:@"3"]) {
                            str=[NSString stringWithFormat:@"%@**", otherbtn.titleLabel.text];
                        }
                        [self.twelveRowArr removeObject:str];
                    }
                }
                btn.selected = YES;
                if ([_digitTypeStr isEqualToString:@"1"]) {
                    _digitGeStr=[NSString stringWithFormat:@"**%@", btn.titleLabel.text];
                }else if ([_digitTypeStr isEqualToString:@"2"]) {
                    _digitShiStr=[NSString stringWithFormat:@"*%@*", btn.titleLabel.text];
                }else if ([_digitTypeStr isEqualToString:@"3"]) {
                    _digitBaiStr=[NSString stringWithFormat:@"%@**", btn.titleLabel.text];
                }
            }
        }
    }
    
    NSInteger selNum = 0;
    GifButton *gifBtn = (GifButton *)[self.ballNmWindow viewWithTag:333];
    NSInteger num=0;
    if (_szcType==0||_szcType==1) {
        if([self.alertType intValue]>=1&&[self.alertType intValue]<=13&&[self.alertType intValue]%2!=0){
            if(_szcType==0){
                num=33;
            }else if(_szcType==1){
                num=35;
            }
        }else if ([self.alertType isEqualToString:@"15"]||[self.alertType isEqualToString:@"17"]) {
            if(_szcType==0){
                num=16;
            }else if(_szcType==1){
                num=12;
            }
        }
    }else if(_szcType==2||_szcType==3){
        num=10;
        if ([self.alertType isEqualToString:@"21"]) {
            num=28;
        }
    }
    for (int k = 0; k < num; k++) {
        UIButton *ball = (UIButton *)[self.ballNmWindow viewWithTag:100+k];
        if ([ball isKindOfClass:[UIButton class]]&& ball.isSelected) {
            selNum += 1;
        }
    }
    if (selNum!=0&&![self.alertType isEqualToString:@"23"]) {
        gifBtn.hidden=NO;
    }else
        gifBtn.hidden=YES;
}

#pragma mark ----------UITableViewDelegate------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==501) {
        return 40;
    }else{
        if (indexPath.section == 0) {
            if (indexPath.row==0) {
                return 41;
            }
            return 40;
        }else{
            return 120;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (tableView.tag==501) {
        NSString *choiceLTStr=[_ltArr objectAtIndex:indexPath.row];
        _szcType=indexPath.row;
        self.rowNameArr=nil;
        self.totalBallNmArr=nil;
        if (_szcType==0) {
            self.rowNameArr = @[@"红球\n20码",@"红球\n12码",@"红球\n3胆",@"红球\n独胆",@"红球\n杀6码",@"龙头",@"凤尾",@"蓝球\n3码",@"蓝球\n杀3码",@"12+3\n复式单"];
            self.totalBallNmArr = [[NSArray alloc] initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",nil];
            self.qsDic=self.resDic1;
        }else if (_szcType==1) {
            self.rowNameArr = @[@"前区\n20码",@"前区\n10码",@"前区\n3胆",@"前区\n独胆",@"前区\n杀6码",@"龙头",@"凤尾",@"后区\n3码",@"后区\n杀6码",@"10+3\n复式单"];
            self.totalBallNmArr = [[NSArray alloc] initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",nil];
            self.qsDic=self.resDic2;
        }else if(_szcType==2||_szcType==3){
            self.rowNameArr = @[@"独胆",@"双胆",@"三胆",@"杀一码",@"5码复式",@"6码复式",@"3跨度",@"5码定位\n(百位)",@"5码定位\n(十位)",@"5码定位\n(个位)",@"和值",@"包星"];
            if(_szcType==2){
                self.qsDic=self.resDic3;
            }else if(_szcType==3){
                self.qsDic=self.resDic4;
            }
        }
        [self resetData];
        [UIView transitionWithView:_tableView duration:0.5 options:0 animations:^{
            [_tableView setContentOffset:CGPointMake(0, 0)];
        } completion:^(BOOL finished) {
            
        }];
        [_tableView reloadData];
        
        _ltBtn.tag=201;
        [_ltBtn setTitle:choiceLTStr forState:UIControlStateNormal];
        [_ltBtn setTitle:choiceLTStr forState:UIControlStateHighlighted];
        
        CGSize btnsize=[PublicMethod setNameFontSize:_ltBtn.titleLabel.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [_ltBtn setTitleEdgeInsets:UIEdgeInsetsMake(11.5, MyWidth/2-(btnsize.width+6*MyWidth/320+10)/2, 11.5, MyWidth/2-(btnsize.width+6*MyWidth/320+10)/2+6*MyWidth/320+10)];
        
        _tableView.alpha=1.0;
        self.view.backgroundColor=TEXTWITER_COLOR;
        _LTTable.hidden=YES;
        for(UIView *view in [_ltBtn subviews]){
            if([view isKindOfClass:[UIImageView class]]){
                UIImageView *imgV=(UIImageView *)view;
                imgV.image=[UIImage imageNamed:@"triangle-selected-down"];
                [imgV setFrame:CGRectMake(MyWidth/2+(btnsize.width+6*MyWidth/320)/2-5, 15, 10, 5)];
            }
        }
        CGRect rect=_LTTable.frame;
        rect.size.height=0;
        [_LTTable setFrame:rect];
        [_LTTable reloadData];
    }
}

#pragma mark -----------UITableViewDataSource---------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==501) {
        return 4;
    }else{
        if (section == 0) {
            return [self.rowNameArr count]+1;
        }
        return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    if (tableView.tag==501) {
        return 1;
    }else
        return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==501) {
        CGSize labSize=[PublicMethod setNameFontSize:[_ltArr objectAtIndex:indexPath.row] andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        ClassifyCell *cell=[ClassifyCell classifyCellWithTView:tableView indexPath:indexPath];
        [cell.txtLabel setFrame:CGRectMake(36*MyWidth/320, 0, labSize.width, 40)];
        cell.txtLabel.text=[_ltArr objectAtIndex:indexPath.row];
        if([cell.txtLabel.text isEqualToString:_ltBtn.titleLabel.text]){
            cell.selectImgV.hidden=NO;
            cell.txtLabel.textColor=[UIColor colorWithRed:21.0/255.0 green:136.0/255.0 blue:218.0/255.0 alpha:1.0];
        }
        if (indexPath.row == 0) {
            if ([self.todayPubNumDic[@"publish_SHUANGSEQIU"] isEqualToString:@"0"]) {
                cell.backgroundColor = [UIColor whiteColor];
            }else{
                cell.userInteractionEnabled = NO;
                cell.selectImgV.hidden=YES;
                cell.txtLabel.textColor = [UIColor lightGrayColor];
            }
        }else if (indexPath.row ==1){
            if ([self.todayPubNumDic[@"publish_DALETOU"] isEqualToString:@"0"]) {
                cell.backgroundColor = [UIColor whiteColor];
            }else{
                cell.userInteractionEnabled = NO;
                cell.selectImgV.hidden=YES;
                cell.txtLabel.textColor = [UIColor lightGrayColor];
            }
        }else if (indexPath.row ==2){
            if ([self.todayPubNumDic[@"publish_SanD"] isEqualToString:@"0"]) {
                cell.backgroundColor = [UIColor whiteColor];
            }else{
                cell.userInteractionEnabled = NO;
                cell.selectImgV.hidden=YES;
                cell.txtLabel.textColor = [UIColor lightGrayColor];
            }
        }else if (indexPath.row ==3){
            if ([self.todayPubNumDic[@"publish_PaiLieSan"] isEqualToString:@"0"]) {
                cell.backgroundColor = [UIColor whiteColor];
            }else{
                cell.userInteractionEnabled = NO;
                cell.selectImgV.hidden=YES;
                cell.txtLabel.textColor = [UIColor lightGrayColor];
            }
        }
        return cell;
    }else{
        if (indexPath.section==0) {
            NSString *identifier = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
            if (indexPath.row==0) {
                UITableViewCell *tableCell=[tableView dequeueReusableCellWithIdentifier:identifier];
                NSString *str=[NSString stringWithFormat:@"当前第%@期",self.qishu];
                CGSize size=[PublicMethod setNameFontSize:str andFont:[UIFont systemFontOfSize:11] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
                if(!tableCell){
                    tableCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                    
                    UIView *topDiv=[[UIView alloc] initWithFrame:CGRectMake(15, 10, MyWidth-30, 1)];
                    [topDiv setBackgroundColor:SEPARATORCOLOR];
                    [tableCell addSubview:topDiv];
                    
                    UIView *leftDiv=[[UIView alloc] initWithFrame:CGRectMake(15, 10, 1, 31)];
                    [leftDiv setBackgroundColor:SEPARATORCOLOR];
                    [tableCell addSubview:leftDiv];
                    
                    UIView *rightDiv=[[UIView alloc] initWithFrame:CGRectMake(MyWidth-16, 10, 1, 31)];
                    [rightDiv setBackgroundColor:SEPARATORCOLOR];
                    [tableCell addSubview:rightDiv];
                    
                    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(26, 19, 11.5, 12.5)];
                    imgView.image=[UIImage imageNamed:@"当前期次提示"];
                    imgView.backgroundColor=[UIColor clearColor];
                    [tableCell addSubview:imgView];
                    
                    UILabel *lab=[[UILabel alloc] init];
                    lab.font=[UIFont systemFontOfSize:11];
                    lab.textColor=BLACK_SEVENTY;
                    [tableCell addSubview:lab];
                    _qsLab=lab;
                }
                _qsLab.text=str;
                [_qsLab setFrame:CGRectMake(42.5, 25.5-size.height/2, size.width, size.height)];
                tableCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return tableCell;
            }else{
                SZCCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell) {
                    cell = [[SZCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                }
                cell.countNameLab.delegate = self;
                cell.countNameLab.tag = indexPath.row-1+100;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.ballNameLab.text = [self.rowNameArr objectAtIndex:indexPath.row-1];
                
                if(_szcType==0||_szcType==1){
                    if (indexPath.row==10) {
                        [cell.bigView addSubview:cell.lowLine];
                    }
                }else if(_szcType==2||_szcType==3){
                    if (indexPath.row==10) {
                        [cell.lowLine removeFromSuperview];
                    }
                    if (indexPath.row==12) {
                        [cell.bigView addSubview:cell.lowLine];
                    }
                    cell.textLabel.textAlignment = NSTextAlignmentLeft;
                }
                
                NSString *rowText=@"";
                if (indexPath.row==1) {
                    if (self.firstRowArr.count!=0) {
                        rowText=[self.firstRowArr componentsJoinedByString:@","];
                        self.oneStr=rowText;
                        cell.countNameLab.textColor=BLACK_EIGHTYSEVER;
                    }else{
                        if (_szcType==0) {
                            rowText = @"推荐20个数字(1~33之间)";
                        }else if (_szcType==1) {
                            rowText = @"推荐20个数字(1~35之间)";
                        }else if(_szcType==2||_szcType==3){
                            rowText = @"推荐一个数字(0~9)之间";
                        }
                        cell.countNameLab.textColor = BLACK_TWENTYSIX;
                    }
                }else if (indexPath.row==2) {
                    if (self.secRowArr.count!=0) {
                        rowText=[self.secRowArr componentsJoinedByString:@","];
                        self.twoStr=rowText;
                        cell.countNameLab.textColor=BLACK_EIGHTYSEVER;
                    }else{
                        if (_szcType==0) {
                            rowText = @"推荐12个数字(1~33之间应包含红球20码内)";
                        }else if (_szcType==1) {
                            rowText = @"推荐10个数字(1~35之间应包含前区20码内)";
                        }else if(_szcType==2||_szcType==3){
                            rowText = @"推荐2个数字(0~9之间且必须包含独胆)";
                        }
                        cell.countNameLab.textColor = BLACK_TWENTYSIX;
                    }
                }else if (indexPath.row==3) {
                    if (self.thirdRowArr.count!=0) {
                        rowText=[self.thirdRowArr componentsJoinedByString:@","];
                        self.threeStr=rowText;
                        cell.countNameLab.textColor=BLACK_EIGHTYSEVER;
                    }else{
                        if (_szcType==0) {
                            rowText = @"推荐3个数字(1~33之间应包含红球20码内)";
                        }else if (_szcType==1) {
                            rowText = @"推荐3个数字(1~35之间应包含前区20码内)";
                        }else if(_szcType==2||_szcType==3){
                            rowText = @"推荐3个数字(0~9之间且必须包含双胆)";
                        }
                        cell.countNameLab.textColor = BLACK_TWENTYSIX;
                    }
                }else if (indexPath.row==4) {
                    if (self.fourRowArr.count!=0) {
                        rowText=[self.fourRowArr componentsJoinedByString:@","];
                        self.fourStr=rowText;
                        cell.countNameLab.textColor=BLACK_EIGHTYSEVER;
                    }else{
                        if (_szcType==0) {
                            rowText = @"推荐1个数字(1~33之间应包含红球3胆内)";
                        }else if (_szcType==1) {
                            rowText = @"推荐1个数字(1~35之间应包含前区3码内)";
                        }else if(_szcType==2||_szcType==3){
                            rowText = @"推荐1个数字(0~9之间不应包含三胆)";
                        }
                        cell.countNameLab.textColor = BLACK_TWENTYSIX;
                    }
                }else if (indexPath.row==5) {
                    if (self.fiveRowArr.count!=0) {
                        rowText=[self.fiveRowArr componentsJoinedByString:@","];
                        self.fiveStr=rowText;
                        cell.countNameLab.textColor=BLACK_EIGHTYSEVER;
                    }else{
                        if (_szcType==0) {
                            rowText = @"推荐6个数字(1~33之间不应包含红球20码内)";
                        }else if (_szcType==1) {
                            rowText = @"推荐6个数字(1~35之间不应包含前区20码内)";
                        }else if(_szcType==2||_szcType==3){
                            rowText = @"推荐5个数字(0~9之间且必须包含三胆)";
                        }
                        cell.countNameLab.textColor = BLACK_TWENTYSIX;
                    }
                }else if (indexPath.row==6) {
                    if (self.sixRowArr.count!=0) {
                        rowText=[self.sixRowArr componentsJoinedByString:@","];
                        self.sixStr=rowText;
                        cell.countNameLab.textColor=BLACK_EIGHTYSEVER;
                    }else{
                        if (_szcType==0) {
                            rowText = @"推荐2个数字(1~33之间应包含红球20码内,并包含红球20码第一个数字)";
                        }else if (_szcType==1) {
                            rowText = @"推荐2个数字(1~35之间应包含前区20码内,并包含前区20码第一个数字)";
                        }else if(_szcType==2||_szcType==3){
                            rowText = @"推荐6个数字(0~9之间且必须包含五码复式)";
                        }
                        cell.countNameLab.textColor = BLACK_TWENTYSIX;
                    }
                }else if (indexPath.row==7) {
                    if (self.severRowArr.count!=0) {
                        rowText=[self.severRowArr componentsJoinedByString:@","];
                        self.sevenStr=rowText;
                        cell.countNameLab.textColor=BLACK_EIGHTYSEVER;
                    }else{
                        if(_szcType==0){
                            rowText = @"推荐2个数字(1~33之间应包含红球20码内,并包含红球20码最后一个数字)";
                        }else if (_szcType==1) {
                            rowText = @"推荐2个数字(1~35之间应包含前区20码内,并包含前区20码最后一个数字)";
                        }else if(_szcType==2||_szcType==3){
                            rowText = @"推荐3个跨度值(0~9之间)";
                        }
                        cell.countNameLab.textColor = BLACK_TWENTYSIX;
                    }
                }else if (indexPath.row==8) {
                    if (self.eightRowArr.count!=0) {
                        rowText=[self.eightRowArr componentsJoinedByString:@","];
                        self.eightStr=rowText;
                        cell.countNameLab.textColor=BLACK_EIGHTYSEVER;
                    }else{
                        if (_szcType==0) {
                            rowText = @"推荐3个数字(01~16之间)";
                        }else if (_szcType==1) {
                            rowText = @"推荐3个数字(01~12之间)";
                        }else if(_szcType==2||_szcType==3){
                            rowText = @"百位推荐5个数值(0~9之间)";
                        }
                        cell.countNameLab.textColor = BLACK_TWENTYSIX;
                    }
                }else if (indexPath.row==9) {
                    if (self.nineRowArr.count!=0) {
                        rowText=[self.nineRowArr componentsJoinedByString:@","];
                        self.nineStr=rowText;
                        cell.countNameLab.textColor=BLACK_EIGHTYSEVER;
                    }else{
                        if (_szcType==0) {
                            rowText = @"推荐3个数字(01~16之间且不应包含在蓝球3码内)";
                        }else if (_szcType==1) {
                            rowText = @"推荐6个数字(01~12之间且不应包含在后区3码内)";
                        }else if(_szcType==2||_szcType==3){
                            rowText = @"十位推荐5个数值(0~9之间)";
                        }
                        cell.countNameLab.textColor = BLACK_TWENTYSIX;
                    }
                }else if (indexPath.row == 10) {
                    if (self.tenRowArr.count!=0) {
                        rowText=[self.tenRowArr componentsJoinedByString:@","];
                        self.tenStr = rowText;
                        cell.countNameLab.textColor=BLACK_EIGHTYSEVER;
                    }else{
                        if (_szcType==0) {
                            rowText = @"由红球12码与篮球3码自动生成";
                        }else if (_szcType==1) {
                            rowText = @"由前区10码与后区3码自动生成";
                        }else if(_szcType==2||_szcType==3){
                            rowText = @"个位推荐5个数值(0~9之间)";
                        }
                        cell.countNameLab.textColor = BLACK_TWENTYSIX;

                        if (_szcType==0||_szcType==1) {
                            if (![self.eightStr isEqualToString:@""]&&self.eightStr!=nil) {
                                rowText=[NSString stringWithFormat:@"%@+%@",self.twoStr,self.eightStr];
                                self.tenStr = [NSString stringWithFormat:@"%@*%@",self.twoStr,self.eightStr];
                                cell.countNameLab.textColor=BLACK_EIGHTYSEVER;
                            }
                        }
                    }
                }else if (indexPath.row == 11) {
                    if (self.elevenRowArr.count!=0) {
                        rowText =[self.elevenRowArr componentsJoinedByString:@","];
                        self.elvenStr = rowText;
                        cell.countNameLab.textColor=BLACK_EIGHTYSEVER;
                    }else{
                        rowText = @"推荐4个和值(0~27之间)";
                        cell.countNameLab.textColor = BLACK_TWENTYSIX;
                    }
                }else if (indexPath.row == 12) {
                    if (self.twelveRowArr.count!=0) {
                        rowText =[self.twelveRowArr componentsJoinedByString:@","];
                        self.twelveStr = rowText;
                        cell.countNameLab.textColor=BLACK_EIGHTYSEVER;
                    }else{
                        rowText = @"选出2组值(百位、十位、个位中选出2个数字)";
                        cell.countNameLab.textColor = BLACK_TWENTYSIX;
                    }
                }
                cell.countNameLab.text = rowText;
                cell.countNameLab.scrollEnabled = NO;
                cell.backgroundColor = [UIColor colorWithHexString:@"fcfcfc"];
                return cell;
            }
        }else if(indexPath.section == 1){
            static NSString * identifier = @"cell";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                _commitBtn.frame = CGRectMake(15, 20, 290, 40);
                _commitBtn.tag = 101;
                _commitBtn.userInteractionEnabled = NO;
                [_commitBtn setBackgroundImage:[UIImage imageNamed:@"通用-信息填写前"] forState:normal];
                [_commitBtn setTitle:@"下一步" forState:normal];
                [_commitBtn addTarget:self action:@selector(pushSuceess) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:_commitBtn];
            }
            cell.backgroundColor =  [UIColor colorWithHexString:@"fcfcfc"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    return nil;
}

#pragma mark--------------下一步---------

-(void)pushSuceess
{
    NSMutableArray *countBigArr = [[NSMutableArray alloc] initWithObjects:self.oneStr,self.twoStr,self.threeStr,self.fourStr,self.fiveStr,self.sixStr,self.sevenStr,nil];
    if (_szcType==0||_szcType==1) {
        [countBigArr addObject:self.eightStr];
        [countBigArr addObject:self.nineStr];
        [countBigArr addObject:self.tenStr];
    }else if (_szcType==2||_szcType==3) {
        NSString *lastSty = [NSString stringWithFormat:@"%@*%@*%@",self.eightStr,self.nineStr,self.tenStr];
        [countBigArr addObject:lastSty];
        [countBigArr addObject:self.elvenStr];
        [countBigArr addObject:self.twelveStr];
    }
    SZCSbViewController *comVC = [[SZCSbViewController alloc]init];
    if (_szcType==0) {
        comVC.disLotteryStr = @"differentTwoColor";
    }else if (_szcType==1) {
        comVC.disLotteryStr = @"differentHappay";
    }else if (_szcType==2) {
        comVC.disLotteryStr = @"differentLotteryD";
    }else if(_szcType==3){
        comVC.disLotteryStr = @"differentLotteryArrang";
    }
    comVC.countBigArr = countBigArr;
    comVC.dataDic = _qsDic;
    [self.navigationController pushViewController:comVC animated:YES];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    