//
//  SZCSbViewController.m
//  Experts
//
//  Created by mac on 15/10/29.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "SZCSbViewController.h"
#import "MBProgressHUD+MJ.h"

@interface SZCSbViewController ()

@property(nonatomic,strong)V1PickerView* picker;

@property(nonatomic,strong)UILabel *contentLab;//期号北京View
@property(nonatomic,strong)UIView *proTitleView;//方案标题整行背景View
@property(nonatomic,strong)UIView *refundView;//不中退款背景View
@property(nonatomic,strong)UILabel *refundlab;//不中退款背景Lable
@property(nonatomic,strong)UITextView *proTitTxtView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *commitCountBtn;

@property(nonatomic,strong)NSString *sourceStr;//区分不同的专家类型

@property(nonatomic,strong)NSString *supRefundOrNo;//标记是不支持不中退款

@property(nonatomic,strong)NSMutableArray *priceArr;//价格数组
@property(nonatomic,strong)NSMutableArray *discountArr;//折扣数组
@property(nonatomic,strong)NSArray *dataPriceArr;//价格列表

@property(nonatomic,strong)NSString *definePriceStr;//选中价格
@property(nonatomic,strong)NSString *defineDiscountStr;//选中折扣

@property(nonatomic,strong)NSString *priceOrDiscount;//选择的是价格还是折扣
@property(nonatomic,strong)NSString *priceIsZero;//无折扣的时候不能点击

@property(nonatomic,strong)UIAlertView *alterViewFail;


@end

@implementation SZCSbViewController

CGSize remSize;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title_nav = @"发布方案";
    [self creatNavView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"ecedf1"];
    
    if ([DEFAULTS objectForKey:@"resultDic"] && [[DEFAULTS objectForKey:@"resultDic"] isKindOfClass:[NSDictionary class]] && [[DEFAULTS objectForKey:@"resultDic"] allKeys]!= nil&&
        ![[DEFAULTS objectForKey:@"resultDic"] isEqualToDictionary:[NSDictionary dictionary]]) {
        NSDictionary *sourceDic = [DEFAULTS objectForKey:@"resultDic"];
        self.sourceStr =sourceDic[@"source"];
    }
//    [self creatTimeContent];
    [self createTextView];
    [self creatConTabView];
    
    self.dataPriceArr = [NSArray array];
    self.priceArr = [NSMutableArray array];
    self.discountArr = [NSMutableArray array];
    
    self.definePriceStr=@"";
    self.priceOrDiscount=@"";
    
    _supRefundOrNo=@"0";
    
    [self requestDisCountData];
    [self requestPriceData];
}

-(void)creatTimeContent{
    NSString *labStr = [NSString stringWithFormat:@"第 %@ 期",self.dataDic[@"NAME"]];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:labStr];
    NSRange range =[labStr rangeOfString:[NSString stringWithFormat:@"%@",self.dataDic[@"NAME"]]];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range];
    
    CGSize  labSize = [PublicMethod setNameFontSize:labStr andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.contentLab = [[UILabel alloc]initWithFrame:CGRectMake(MyWidth/2-labSize.width/2,21-labSize.height/2+HEIGHTBELOESYSSEVER+44, labSize.width, labSize.height)];
    self.contentLab.font = FONTTWENTY_FOUR;
    self.contentLab.attributedText = attStr;
    [self.view addSubview:self.contentLab];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(10, 20.5+HEIGHTBELOESYSSEVER+44, MyWidth/2-labSize.width/2-20, 1)];
    line1.backgroundColor = SEPARATORCOLOR;
    [self.view addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(10+MyWidth/2+labSize.width/2, 20.5+HEIGHTBELOESYSSEVER+44, MyWidth/2-labSize.width/2-20, 1)];
    line2.backgroundColor = SEPARATORCOLOR;
    [self.view addSubview:line2];
}

-(void)createTextView{
    _proTitleView=[[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44+10, MyWidth, 46)];
    _proTitleView.layer.masksToBounds=YES;
    _proTitleView.layer.borderWidth=0.5;
    _proTitleView.layer.borderColor=SEPARATORCOLOR.CGColor;
    [_proTitleView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_proTitleView];
    
    NSString  *remStr = @"方案标题";
    remSize = [PublicMethod  setNameFontSize:remStr andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    UILabel *planLab = [[UILabel alloc]initWithFrame:CGRectMake(15,23-remSize.height/2,remSize.width,remSize.height)];
    planLab.font = FONTTHIRTY;
    planLab.text = remStr;
    planLab.textColor = BLACK_FIFITYFOUR;
    [_proTitleView addSubview:planLab];
    
    _proTitTxtView = [[UITextView  alloc]initWithFrame:CGRectMake(30+remSize.width, 6, MyWidth-45-remSize.width, 34)];
    _proTitTxtView.font = FONTTHIRTY;
    _proTitTxtView.backgroundColor=[UIColor clearColor];
    _proTitTxtView.text = @"请输入标题20字以内";
    _proTitTxtView.textColor = BLACK_TWENTYSIX;
    _proTitTxtView.delegate = self;
    _proTitTxtView.tag = 1;
    [_proTitleView addSubview:_proTitTxtView];
    
    [self willMoveToSuperview:_proTitTxtView];
    
    //回收键盘
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, MyWidth, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    topView.tintColor=[UIColor whiteColor];
    if (IS_IOS7) {
        topView.barTintColor=[UIColor colorWithRed:21.0/255 green:136.0/255 blue:218.0/255 alpha:1.0];
    }
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    
    _proTitTxtView.inputView.backgroundColor=[UIColor clearColor];
    [_proTitTxtView setInputAccessoryView:topView];
}

-(void)creatConTabView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_proTitleView.frame)+10, MyWidth, 92) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorColor=SEPARATORCOLOR;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        _tableView.separatorInset=UIEdgeInsetsMake(0,0,0,0);
    }
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyWidth, 0.5)];
    line.backgroundColor = SEPARATORCOLOR;
    [_tableView addSubview:line];
    
    _refundView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame)+10, MyWidth, 47)];
    _refundView.layer.borderWidth=0.5;
    _refundView.layer.borderColor=SEPARATORCOLOR.CGColor;
    [_refundView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_refundView];
    
    _refundlab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0.5, MyWidth, 46)];
    _refundlab.text=@"    是否参加不中退款活动";
    _refundlab.font=FONTTHIRTY;
    _refundlab.textColor=BLACK_EIGHTYSEVER;
    [_refundlab setBackgroundColor:[UIColor clearColor]];
    [_refundView addSubview:_refundlab];
    
    UIImageView *swImg=[[UIImageView alloc] initWithFrame:CGRectMake(MyWidth-85, 8, 69.5, 31)];
    swImg.image=[UIImage imageNamed:@"swoff.png"];
    swImg.backgroundColor=[UIColor clearColor];
    [_refundView addSubview:swImg];
    
    UITapGestureRecognizer *swGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapeSprtOrNo:)];
    swImg.userInteractionEnabled=YES;
    _refundView.userInteractionEnabled=YES;
    [swImg addGestureRecognizer:swGesture];
    
    _commitCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitCountBtn.frame = CGRectMake(15, CGRectGetMaxY(_refundView.frame)+30, 290, 45);
    [_commitCountBtn setBackgroundImage:[UIImage imageNamed:@"通用-信息填写前"] forState:UIControlStateNormal];
    [_commitCountBtn setBackgroundImage:[UIImage imageNamed:@"通用-信息填写后"] forState:UIControlStateSelected];
    [_commitCountBtn setTitle:@"提交方案" forState:UIControlStateNormal];
    [_commitCountBtn setTitle:@"提交方案" forState:UIControlStateSelected];
    [_commitCountBtn addTarget:self action:@selector(commitcountLotery) forControlEvents:UIControlEventTouchUpInside];
    _commitCountBtn.userInteractionEnabled = NO;
    [self.view addSubview:_commitCountBtn];
}

#pragma mark ---------提交方案按钮--------

-(void)alertActionDissmiss{
    [_alterViewFail dismissWithClickedButtonIndex:[_alterViewFail cancelButtonIndex] animated:YES];
}

-(void)commitcountLotery
{
    if (_proTitTxtView.text.length > 0&&_proTitTxtView.text.length<21) {
        [self requestCountLotteryData];
    }else{
        _alterViewFail = [[UIAlertView alloc]initWithTitle:nil message:@"方案标题字数不符合要求" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alterViewFail show];
        [self performSelector:@selector(alertActionDissmiss) withObject:self afterDelay:1];
    }
}

- (void)tapeSprtOrNo:(UITapGestureRecognizer *)sender{
    UIImageView *imgView=(UIImageView *)sender.view;
    if ([_supRefundOrNo isEqualToString:@"0"]) {
        imgView.image=[UIImage imageNamed:@"swon.png"];
        _supRefundOrNo=@"1";
    }else if([_supRefundOrNo isEqualToString:@"1"]){
        imgView.image=[UIImage imageNamed:@"swoff.png"];
        _supRefundOrNo=@"0";
    }
}

-(void)dismissKeyBoard
{
    if (_proTitTxtView.text.length == 0) {
        _proTitTxtView.text = @"请输入标题20字以内";
        _proTitTxtView.textColor = V2LINE_COLOR;
        _proTitTxtView.font = [UIFont systemFontOfSize:15];
    }
    [self.view endEditing:YES];;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangedView:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)removeFromSuperview
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)textDidChangedView:(NSNotification *)notif
{
    UITextView *txtView=(UITextView *)notif.object;
    if ([txtView.text isEqualToString:@""]||txtView.text==nil) {
        _commitCountBtn.selected= NO;
        _commitCountBtn.userInteractionEnabled = NO;
    }
    CGSize contentSize = txtView.contentSize;

    if (txtView.tag==1&&contentSize.height>140) {
        return;
    }
    
    CGRect selfFrame = txtView.frame;
    CGFloat selfHeight = contentSize.height;
    selfFrame.size.height = selfHeight;
    txtView.frame = selfFrame;
    
    [_proTitleView setFrame:CGRectMake(0, HEIGHTBELOESYSSEVER+44+10, MyWidth, txtView.frame.size.height+12)];
    [_tableView setFrame:CGRectMake(0,CGRectGetMaxY(_proTitleView.frame)+10, MyWidth, 92)];
    [_refundView setFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame)+10, MyWidth, 46)];
    [_commitCountBtn setFrame:CGRectMake(10, CGRectGetMaxY(_refundView.frame)+30, MyWidth-30, 45)];
}

#pragma mark ----------增加按钮的方法-------------
-(void)btnMenthChangesBlu
{
    if (![_proTitTxtView.text isEqualToString:@"请输入标题20字以内"]&&_proTitTxtView.text!=nil&&![_proTitTxtView.text isEqualToString:@""]&&self.definePriceStr.length!=0&&self.defineDiscountStr.length!=0) {
        if (_proTitTxtView.text.length!=0&&self.definePriceStr.length!=0&&self.defineDiscountStr.length!=0) {
            _commitCountBtn.userInteractionEnabled = YES;
            _commitCountBtn.selected=YES;
        }
    }
}

#pragma mark -----------UITextViewDelegate---------
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if (_proTitTxtView.text.length == 0) {
        _proTitTxtView.text = @"请输入标题20字以内";
        _proTitTxtView.textColor = BLACK_TWENTYSIX;
        _proTitTxtView.font = FONTTHIRTY;
    }
    if ([textView.text isEqualToString:@"请输入标题20字以内"]) {
        textView.text = @"";
        textView.textColor = BLACK_TWENTYSIX;
    }else{
        textView.textColor = [UIColor blackColor];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [self btnMenthChangesBlu];
}

-(void)textViewDidChange:(UITextView *)textView{
    if ([_proTitTxtView.text isEqualToString:@"请输入标题20字以内"]) {
        _proTitTxtView.textColor = BLACK_TWENTYSIX;
    }else{
        _proTitTxtView.textColor = [UIColor blackColor];
    }
    [self willMoveToSuperview:textView];
}

#pragma mark ------UITableViewDataSource-------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if ([self.definePriceStr isEqualToString:@"免费"]) {
        self.priceIsZero = @"0";
        self.defineDiscountStr=@"无折扣";
    }
    
    if (indexPath.row == 0) {
        if (self.definePriceStr.length != 0) {
            cell.textLabel.textColor = [UIColor redColor];
            if ([self.definePriceStr isEqualToString:@"免费"]) {
                cell.textLabel.text = self.definePriceStr;
            }else {
                cell.textLabel.text = [NSString stringWithFormat:@"￥%@",self.definePriceStr];
                cell.textLabel.alpha = 0.87;
            }
        }else{
            cell.textLabel.text = @"请选择方案价格";
            cell.textLabel.font = FONTTHIRTY;
            cell.textLabel.alpha = 0.87;
        }
    }else{
        if ([self.definePriceStr isEqualToString:@"免费"]) {
            cell.textLabel.text = self.defineDiscountStr;
            cell.backgroundColor = [UIColor colorWithHexString:@"fcfcfc"];
            cell.userInteractionEnabled = NO;
        }else{
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.alpha = 0.87;
            cell.userInteractionEnabled = YES;
            if (self.defineDiscountStr.length != 0) {
                cell.textLabel.text = self.defineDiscountStr;
            }else{
                _commitCountBtn.selected=NO;
                cell.textLabel.text = @"请选择方案折扣";
                cell.textLabel.font = FONTTHIRTY;
            }
        }
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userInteractionEnabled = YES;
    [self btnMenthChangesBlu];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

#pragma mark ------UITableViewDelegate------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (indexPath.row == 0) {
        self.priceIsZero=@"1";
        self.priceOrDiscount = @"1";
        if (self.priceArr.count != 0) {
            //[_picker setFrame:CGRectMake(0, MyHight-260, MyWidth, 260)];
            //[_picker.pickerView setFrame:CGRectMake(0, 45, MyWidth, _picker.frame.size.height-50)];
            [self addPicker];
            [_picker.pickerView reloadAllComponents];
        }
    }else{
        if ([self.priceIsZero isEqualToString:@"0"]) {
            return;
        }
        self.priceOrDiscount = @"2";
        if (self.discountArr.count != 0) {
            //[_picker setFrame:CGRectMake(0, MyHight-260, MyWidth, 260)];
            //[_picker.pickerView setFrame:CGRectMake(0, 45, MyWidth, _picker.frame.size.height-50)];
            [self addPicker];
            [_picker.pickerView reloadAllComponents];
        }
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark -------------------cell分割线显示完全--------------
-(void)viewDidLayoutSubviews{
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

-(void)addPicker{
    _picker=[[V1PickerView alloc] initWithFrame:CGRectMake(0, MyHight-260, MyWidth, 260)];
    _picker.pickerView.dataSource = self;
    _picker.pickerView.delegate = self;
    _picker.delegate=self;
    [self.view addSubview:_picker];
}

#pragma mark ----------V1PickerViewDelegate------------

-(void)sure:(id)sender
{
    if ([self.priceOrDiscount isEqualToString:@"1"]) {
        self.definePriceStr = [self.priceArr objectAtIndex:[_picker.pickerView selectedRowInComponent:0]];
    } else{
        self.defineDiscountStr = [self.discountArr objectAtIndex:[_picker.pickerView selectedRowInComponent:0]];
    }
    [_tableView reloadData];
    
    [UIView animateWithDuration:0.1 animations:^{
        [_picker setFrame:CGRectMake(0, MyHight, _picker.frame.size.width, 0)];
        [_picker removeFromSuperview];
        _picker=nil;
    }];
}

-(void)cancle:(id)sender
{
    [UIView animateWithDuration:0.1 animations:^{
        [_picker setFrame:CGRectMake(0, MyHight, _picker.frame.size.width, 0)];
        [_picker removeFromSuperview];
        _picker=nil;
    }];
}

#pragma mark ------UIPickerViewDelegate------

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([self.priceOrDiscount isEqualToString:@"1"]) {
        return [NSString stringWithFormat:@"%@",[self.priceArr objectAtIndex:row]];
    }else if([self.priceOrDiscount isEqualToString:@"2"]){
        return [NSString stringWithFormat:@"%@",[self.discountArr objectAtIndex:row]];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //[pickerView reloadComponent:1];
}

#pragma mark ------UIPickerViewDataSource------

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([self.priceOrDiscount isEqualToString:@"1"]) {
        return self.priceArr.count;
    }else if([self.priceOrDiscount isEqualToString:@"2"]){
        return self.discountArr.count;
    }
    return 0;
}

#pragma mark ------------------调接口----------------

#pragma mark ------请求折扣的数据接口------

-(void)requestDisCountData{
    NSMutableDictionary  *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"commonExpertService",@"methodName":@"getPlanDiscountList",@"parameters":parametersDic}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject) {
        NSDictionary *dataDic = respondObject;
        if ([dataDic[@"resultCode"]isEqualToString:@"0000"]) {
            NSArray  *resultArr = dataDic[@"result"];
            NSMutableArray *disArr=[NSMutableArray arrayWithCapacity:[resultArr count]];
            for (NSDictionary *priceData  in resultArr) {
                [disArr addObject:priceData[@"discountName"]];
            }
            self.discountArr=disArr;
        }
    } failure:^(NSError *error) {
        NSLog(@"error==%@",error);
    }];
}

#pragma mark ------请求价格接口------
-(void)requestPriceData{
    NSString *codeStr = @"";
    if ([self.disLotteryStr isEqualToString:@"differentTwoColor"]) {//双色球
        codeStr = @"001";
    }else if([self.disLotteryStr isEqualToString:@"differentHappay"]){//大乐透
        codeStr = @"113";
    }else if([self.disLotteryStr isEqualToString:@"differentLotteryD"]){//3D和排列三
        codeStr = @"002";
    }else if([self.disLotteryStr isEqualToString:@"differentLotteryArrang"]) {
        codeStr = @"108";
    }
    NSMutableDictionary  *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"expertsName": [[Info getInstance] userName],@"lotteryClassCode":codeStr}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"commonExpertService",@"methodName":@"getPlanPriceList",@"parameters":parametersDic}];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject) {
        NSDictionary *dataDic = respondObject;
        if ([dataDic[@"resultCode"]isEqualToString:@"0000"]) {
            NSArray *arr=dataDic[@"result"];
            self.dataPriceArr=arr;
            NSMutableArray *priArr=[NSMutableArray arrayWithCapacity:[arr count]];
            for (NSDictionary *priceData in arr) {
                [priArr addObject:priceData[@"priceName"]];
            }
            self.priceArr=priArr;
        }
    } failure:^(NSError *error) {
        NSLog(@"error==%@",error);
    }];
}

#pragma mark ------发送数字彩票------
-(void)requestCountLotteryData{
    NSString *codeStr = @"";
    NSString *agintStr = @"";
    if ([self.disLotteryStr isEqualToString:@"differentTwoColor"]) {//双色球
        agintStr = [NSString stringWithFormat:@"HONG_QIU_20_MA=%@;HONG_QIU_12_MA=%@;HONG_QIU_3_DAN=%@;HONG_QIU_DU_DAN=%@;HONG_QIU_SHA_6_MA=%@;LONG_TOU=%@;FENG_WEI=%@;LAN_QIU_3_MA=%@;LAN_QIU_SHA_3_MA=%@;FU_SHI_12_3=%@;",self.countBigArr[0],self.countBigArr[1],self.countBigArr[2],self.countBigArr[3],self.countBigArr[4],self.countBigArr[5],self.countBigArr[6],self.countBigArr[7],self.countBigArr[8],self.countBigArr[9]];
        codeStr = @"001";
    }else if ([self.disLotteryStr isEqualToString:@"differentHappay"]){        //大乐透
        agintStr = [NSString stringWithFormat:@"QIAN_QU_20_MA=%@;QIAN_QU_10_MA=%@;QIAN_QU_3_DAN=%@;QIAN_QU_DU_DAN=%@;QIAN_QU_SHA_6_MA=%@;LONG_TOU=%@;FENG_WEI=%@;HOU_QU_3_MA=%@;HOU_QU_SHA_6_MA=%@;FU_SHI_10_3=%@",self.countBigArr[0],self.countBigArr[1],self.countBigArr[2],self.countBigArr[3],self.countBigArr[4],self.countBigArr[5],self.countBigArr[6],self.countBigArr[7],self.countBigArr[8],self.countBigArr[9]];
        codeStr = @"113";
    }else {//3D和排列三
        if ([self.disLotteryStr isEqualToString: @"differentLotteryD"]) {
            agintStr = [NSString stringWithFormat:@"DU_DAN=%@;SHUANG_DAN=%@;SAN_DAN=%@;SHA_1_MA=%@;WU_MA_ZU_XUAN=%@;LIU_MA_ZU_XUAN=%@;SAN_KUA_DU=%@;WU_MA_DING_WEI=%@;HE_ZHI=%@;BAO_XING=%@",self.countBigArr[0],self.countBigArr[1],self.countBigArr[2],self.countBigArr[3],self.countBigArr[4],self.countBigArr[5],self.countBigArr[6],self.countBigArr[7],self.countBigArr[8],self.countBigArr[9]];
            codeStr = @"002";
        }else{
            agintStr = [NSString stringWithFormat:@"DU_DAN=%@;SHUANG_DAN=%@;SAN_DAN=%@;SHA_1_MA=%@;WU_MA_ZU_XUAN=%@;LIU_MA_ZU_XUAN=%@;SAN_KUA_DU=%@;WU_MA_DING_WEI=%@;HE_ZHI=%@;BAO_XING=%@",self.countBigArr[0],self.countBigArr[1],self.countBigArr[2],self.countBigArr[3],self.countBigArr[4],self.countBigArr[5],self.countBigArr[6],self.countBigArr[7],self.countBigArr[8],self.countBigArr[9]];
            codeStr = @"108";
        }
    }
    NSString *discountStr = @"";
    if (self.defineDiscountStr.length != 0&&self.definePriceStr.length != 0) {
        if ([self.defineDiscountStr isEqualToString:@"8折"]) {
            discountStr = @"0.8";
        }else if ([self.defineDiscountStr isEqualToString:@"5折"]){
            discountStr = @"0.5";
        }else{
            discountStr = @"1";
        }
    }else{
        discountStr = @"1";
    }
    NSString *priceId  = @"";
    for (NSDictionary *nameDic in self.dataPriceArr) {
        if ([self.definePriceStr  isEqualToString:@"免费"]) {
            if ([self.definePriceStr isEqualToString:nameDic[@"priceName"]]) {
                priceId = nameDic[@"price"];
            }
            discountStr = @"0";
        }else{
            if ([self.definePriceStr isEqualToString:nameDic[@"priceName"]]) {
                priceId = nameDic[@"price"];
            }
        }
    }
    
    NSMutableDictionary  *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"expertsName": [[Info getInstance] userName],@"recommendTitle":_proTitTxtView.text,@"price":priceId,@"free_status":_supRefundOrNo,@"erIssue":self.dataDic[@"NAME"],@"lotteryClassCode":codeStr,@"discount":discountStr,@"endTime":self.dataDic[@"END_TIME"],@"recommendExplain":@"",@"expertsClassCode":@"002",@"agintOrderBody":agintStr,@"clientType":@"2",@"publishVersion":APPVersion,@"isNew":@"1"}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"digitalExpertService",@"methodName":@"publishDigitalPlan",@"parameters":parametersDic}];
    [MBProgressHUD showMessage:@"正在加载..."];
    [RequestEntity requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject) {
        NSDictionary  *respondDic = respondObject;
        [MBProgressHUD hideHUD];
        if ([respondDic[@"resultCode"] isEqualToString:@"0000"]){
            if ([self.sourceStr isEqualToString:@"0"]||[self.sourceStr isEqualToString:@"11"]||[self.sourceStr isEqualToString:@"9"]) {//特邀专家
                UIAlertView  *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"恭喜您提交方案成功" delegate:self cancelButtonTitle:@"一会再说" otherButtonTitles:@"再发一场", nil];
                [alertView show];
            }else if ([self.sourceStr isEqualToString:@"1"]){//所有高手第三场的发布显示判断
                NSDictionary *dic = [DEFAULTS objectForKey:@"qihaodic"];
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
                if (i >= 3) {//所有高手第三场
                    UIAlertView  *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"恭喜您方案提交成功" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                    [alertView show];
                }else{//所有高手
                    UIAlertView  *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"恭喜您方案提交成功" delegate:self cancelButtonTitle:@"一会再说" otherButtonTitles:@"再发一场", nil];
                    [alertView show];
                }
            }
        } else{
            UIAlertView  *alertView = [[UIAlertView alloc]initWithTitle:nil message:respondDic[@"resultDesc"] delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alertView show];
        }
    } failure:^(NSError *error) {
        NSLog(@"error==%@",error);
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
    }];
}

#pragma mark ------------------UIAlertViewDelegate---------------

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
#if defined YUCEDI || defined DONGGEQIU
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:0] animated:YES];
#else
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
#endif
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    