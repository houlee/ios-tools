//
//  GqFillPhoneNoVC.m
//  caibo
//
//  Created by zhoujunwang on 16/5/27.
//
//

#import "GqFillPhoneNoVC.h"
#import "ProjectDetailViewController.h"
#import "NSStringExtra.h"

@interface GqFillPhoneNoVC ()<UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UITextField *txtField;

@end

@implementation GqFillPhoneNoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNavView];
    self.title_nav=@"填写号码";
    self.view.backgroundColor = [UIColor colorWithHexString:@"ecedf1"];
    
    NSString *str=@"请您填写手机号码，最新推荐方案详情将通过手机号码发送至您的手机，也可在已购方案一方案详情页面查看推荐内容";
    CGSize gqSize=[PublicMethod setNameFontSize:str andFont:FONTTWENTY andMaxSize:CGSizeMake(290, MAXFLOAT)];
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(15, HEIGHTBELOESYSSEVER+59, 290, gqSize.height)];
    lab.text=str;
    lab.textColor=BLACK_FIFITYFOUR;
    lab.font=FONTTWENTY;
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    lab.numberOfLines=0;
    lab.backgroundColor=[UIColor clearColor];
    [self.view addSubview:lab];
    
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame)+15, 320, 40)];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    
    str=@"手机号";
    gqSize=[PublicMethod setNameFontSize:str andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    UILabel *sjLab=[[UILabel alloc] initWithFrame:CGRectMake(15, 20-gqSize.height/2, gqSize.width, gqSize.height)];
    sjLab.text=str;
    sjLab.textColor=BLACK_EIGHTYSEVER;
    sjLab.font=FONTTWENTY_FOUR;
    [bgView addSubview:sjLab];
    
    _txtField=[[UITextField alloc] initWithFrame:CGRectMake(ORIGIN_X(sjLab)+20, 9, 200, 22)];
    _txtField.delegate=self;
    _txtField.returnKeyType=UIReturnKeyDone;
    _txtField.keyboardType=UIKeyboardTypePhonePad;
    _txtField.textAlignment=NSTextAlignmentLeft;
    _txtField.backgroundColor=[UIColor clearColor];
    _txtField.placeholder = @"请填写11位手机号码";
    _txtField.textColor = BLACK_EIGHTYSEVER;
    _txtField.font = FONTTWENTY_FOUR;
    [bgView addSubview:_txtField];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, CGRectGetMaxY(bgView.frame)+20, 290, 45);
    [btn setBackgroundImage:[UIImage imageNamed:@"通用-信息填写后"] forState:UIControlStateNormal];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitle:@"提交" forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(commitClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.userInteractionEnabled = YES;
    [self.view addSubview:btn];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getMobile];
}

- (void)commitClick:(UIButton *)btn{
    if ([_txtField.text isEqualToString:@""]||_txtField.text==nil||[_txtField.text isEqualToString:@"请填写11位手机号码"]||![_txtField.text isPhoneNumber]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"请输入有效的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSMutableDictionary  *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"userName":[[Info getInstance] userName],@"agintOrderId":_agOrderId,@"userMobile":_txtField.text}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"zjtjIndexService",@"methodName":@"saveUserMobile",@"parameters":parametersDic}];
    [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
        NSLog(@"respondObject==%@",respondObject);
        NSDictionary *dataDic = respondObject;
        if ([dataDic[@"resultCode"] isEqualToString:@"0000"]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"手机号码提交成功，请注意查收短信提交后如5分钟内没有收到短信请联系客服" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    } failure:^(NSError *error) {
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        ProjectDetailViewController *vc=[[ProjectDetailViewController alloc] init];
        vc.sign=@"0";
        vc.erAgintOrderId=_agOrderId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getMobile{
    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"userName":[[Info getInstance] userName]}];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"serviceName": @"zjtjIndexService",@"methodName":@"getUserMobile",@"parameters":parametersDic}];
    [RequestEntity  requestDatapartWithJsonBodyDic:bodyDic success:^(id respondObject){
        NSLog(@"respondObject==%@",respondObject);
        NSDictionary *dataDic = respondObject;
        if ([dataDic[@"resultCode"] isEqualToString:@"0000"]) {
            NSString *mobileNo = dataDic[@"result"][@"userMobile"];
            if (![mobileNo isEqualToString:@""]&&mobileNo!=nil) {
                _txtField.text=mobileNo;
                _txtField.textColor = BLACK_EIGHTYSEVER;
                if([_txtField.text isEqualToString:@"请填写11位手机号码"]){
                    _txtField.textColor = BLACK_FIFITYFOUR;
                }
            }
        }else{
            
        }
    } failure:^(NSError *error) {
    }];
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