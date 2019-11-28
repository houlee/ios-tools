//
//  AddBankCardViewController.m
//  caibo
//
//  Created by cp365dev on 14-8-4.
//
//

#import "AddBankCardViewController.h"
#import "Info.h"
#import "MyPickerView.h"
#import "ASIHTTPRequest.h"
#import "GC_AddBankCardInfo.h"
#import "GC_HttpService.h"
#import "NetURL.h"
#import "JSON.h"
#import "CP_UIAlertView.h"
#import "GC_AddBankCardInfo.h"


#define IS_IPHONE_4 [UIScreen mainScreen].bounds.size.height == 480

@interface AddBankCardViewController ()
{
    UILabel *messageLabel;
    
    
    UIButton *cellPhoneBtn;
    UILabel *phoneNumber;
    
    
    UITapGestureRecognizer *_tapGestureRec;

}
@end

@implementation AddBankCardViewController
@synthesize provinceArray;
@synthesize cityArray;
@synthesize allcityArray;
@synthesize isHuiBoChongZ;
@synthesize cellPhoneDic;
@synthesize bankPhone;
@synthesize addBindBankCardReq;
@synthesize password,true_name,id_num;
@synthesize reqUserInfo;
@synthesize bankIDDic;
@synthesize bankArray;
@synthesize bank_Name;
@synthesize bank_Num;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(isHuiBoChongZ){
        self.CP_navigation.title = @"完善信息";

    }
    else{
        self.CP_navigation.title = @"添加银行卡";

    }
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
//    isHuiBoChongZ = YES;
    choosePro = 0;
    selectedCity = 0;
    selectedBank = 0;
    
    self.bankArray = [NSArray arrayWithObjects:@"中国工商银行",@"中国建设银行",@"中国农业银行",@"招商银行",@"交通银行",@"兴业银行",@"中国民生银行",@"中国光大银行",@"上海浦东发展银行",@"广东发展银行",@"平安银行",@"中国银行",@"中国邮政储蓄银行",@"中信银行",@"华夏银行",@"国家开发银行",@"中国进出口银行", nil];
    
    self.cellPhoneDic = [NSDictionary dictionaryWithObjects:@[@"95588",@"95533",@"95599",@"95555",@"95559",@"95561",@"95568",@"95595",@"95528",@"400-830-8003",@"95501",@"95566",@"95580",@"95558",@"95577",@"010-68306688",@"010-83579988"] forKeys:@[@"中国工商银行",@"中国建设银行",@"中国农业银行",@"招商银行",@"交通银行",@"兴业银行",@"中国民生银行",@"中国光大银行",@"上海浦东发展银行",@"广东发展银行",@"平安银行",@"中国银行",@"中国邮政储蓄银行",@"中信银行",@"华夏银行",@"国家开发银行",@"中国进出口银行"]];
    
    self.bankIDDic = [NSDictionary dictionaryWithObjects:@[@"102",@"103",@"104",@"105",@"201",@"202",@"301",@"302",@"303",@"304",@"305",@"306",@"307",@"308",@"309",@"310",@"403"] forKeys:@[@"中国工商银行",@"中国农业银行",@"中国银行",@"中国建设银行",@"国家开发银行",@"中国进出口银行",@"交通银行",@"中信银行",@"中国光大银行",@"华夏银行",@"中国民生银行",@"广东发展银行",@"平安银行",@"招商银行",@"兴业银行",@"上海浦东发展银行",@"中国邮政储蓄银行"]];
    
    [self loadIphone];
    
    [self loadUserTrueNameandID];
}
-(void)dealloc
{
//    [allcityArray release];
//    [cityArray release];
//    [provinceArray release];
//    [bankArray release];

    [addBindBankCardReq clearDelegatesAndCancel];
    self.addBindBankCardReq = nil;
    [reqUserInfo clearDelegatesAndCancel];
    self.reqUserInfo = nil;
    
    [super dealloc];

}
-(void)loadIphone
{
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
    if(isHuiBoChongZ){
        myScrollView.contentSize = CGSizeMake(320, 620);

    }else{
        myScrollView.contentSize = CGSizeMake(320, 570);

    }
    myScrollView.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
    myScrollView.delegate = self;
    myScrollView.showsVerticalScrollIndicator = NO;
    [self.mainView addSubview:myScrollView];
    [myScrollView release];
    
    
    
    _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)];
    _tapGestureRec.enabled = NO;
    [myScrollView addGestureRecognizer:_tapGestureRec];
    [_tapGestureRec release];
    

    if(isHuiBoChongZ)
    {
        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 290, 52)];
        messageLabel.text = @"请完善开户银行全称";
        messageLabel.textColor = [UIColor colorWithRed:255/255.0 green:36/255.0 blue:36/255.0 alpha:1];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.numberOfLines = 0;
        messageLabel.font = [UIFont systemFontOfSize:12];
        [myScrollView addSubview:messageLabel];
        [messageLabel release];
    }
    
    if(isHuiBoChongZ){
        bankTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(messageLabel), 320, 135) style:UITableViewStylePlain];
        
    }
    else{
        bankTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 15, 320, 135) style:UITableViewStylePlain];
    }
    bankTableView.delegate = self;
    bankTableView.dataSource = self;
    bankTableView.scrollEnabled = NO;
    bankTableView.tag = 100;
    bankTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [myScrollView addSubview:bankTableView];
    [bankTableView release];
    
    

    cellPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cellPhoneBtn setBackgroundColor:[UIColor clearColor]];
    cellPhoneBtn.frame = CGRectMake(0, ORIGIN_Y(bankTableView), 290, 45);
    cellPhoneBtn.hidden = YES;
    [cellPhoneBtn addTarget:self action:@selector(phoneToBank:) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:cellPhoneBtn];
    
    UIImageView *cellphoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 20, 20)];
    cellphoneImage.image = UIImageGetImageFromName(@"drawal_cellphone.png");
    [cellPhoneBtn addSubview:cellphoneImage];
    [cellphoneImage release];
    
    phoneNumber = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(cellphoneImage)+15, 0, 200, 45)];
    phoneNumber.text = @"- -";
    phoneNumber.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    phoneNumber.backgroundColor = [UIColor clearColor];
    [phoneNumber setFont:[UIFont systemFontOfSize:19]];
    [cellPhoneBtn addSubview:phoneNumber];
    [phoneNumber release];
    
    bankIdTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(bankTableView)+45, 320, 90) style:UITableViewStylePlain];
    bankIdTableView.delegate = self;
    bankIdTableView.dataSource = self;
    bankIdTableView.tag = 101;
    bankIdTableView.scrollEnabled = NO;
    bankIdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [myScrollView addSubview:bankIdTableView];
    [bankIdTableView release];

    
    UILabel *jiejika = [[UILabel alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(bankIdTableView), 290, 45)];
    jiejika.backgroundColor = [UIColor clearColor];
    jiejika.text = @"提款目前仅支持借记卡,无需开通网银";
    jiejika.font = [UIFont systemFontOfSize:12];
    jiejika.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
    [myScrollView addSubview:jiejika];
    [jiejika release];

    
    
    cardNameTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(jiejika), 320, 90) style:UITableViewStylePlain];
    cardNameTableView.delegate = self;
    cardNameTableView.dataSource = self;
    cardNameTableView.tag = 102;
    cardNameTableView.scrollEnabled = NO;
    cardNameTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [myScrollView addSubview:cardNameTableView];
    [cardNameTableView release];

    
    UILabel *cardNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(cardNameTableView), 290, 45)];
    cardNameLabel.text = @"持卡人姓名和身份证号要和投注站账户填写的一致";
    cardNameLabel.backgroundColor =[UIColor clearColor];
    cardNameLabel.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
    cardNameLabel.font = [UIFont systemFontOfSize:12];
    [myScrollView addSubview:cardNameLabel];
    [cardNameLabel release];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(15, ORIGIN_Y(cardNameLabel)+30, 290, 45);
    [submitBtn setBackgroundImage:[UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateNormal];
    if(isHuiBoChongZ){
        [submitBtn setTitle:@"完 成" forState:UIControlStateNormal];

    }else{
        [submitBtn setTitle:@"提交绑定" forState:UIControlStateNormal];

    }
    [submitBtn addTarget:self action:@selector(subMit:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [myScrollView addSubview:submitBtn];
    
    
    gckeyView = [[GC_UIkeyView alloc] initWithFrame:self.mainView.bounds withType:upShowKey];
    gckeyView.tag =111;
    gckeyView.delegate = self;
    [self.mainView addSubview:gckeyView];
    [gckeyView release];
    
    gckeyView1 = [[GC_UIkeyView alloc] initWithFrame:self.mainView.bounds withType:upShowKey];
    gckeyView1.tag = 222;
    gckeyView1.delegate = self;
    [self.mainView addSubview:gckeyView1];
    [gckeyView1 release];

}
-(void)loadUserTrueNameandID{
    NSString * type;
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
        type = @"0";
    }else{
        type = @"1";
    }

    NSString * passwstr = @"";
    if(self.password){
        passwstr = self.password;
    }
    [reqUserInfo clearDelegatesAndCancel];
    self.reqUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CPThreeGetAuthentication:[[Info getInstance] nickName] userpassword:passwstr type:type]];
    [reqUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
    [reqUserInfo setDidFinishSelector:@selector(reqUserInfoFinished:)];
    [reqUserInfo setDelegate:self];
    [reqUserInfo startAsynchronous];
}

-(void)reqUserInfoFinished:(ASIHTTPRequest *)mrequest
{
    NSString *responseStr = [mrequest responseString];
    
    if(responseStr && responseStr.length){
    
        NSDictionary * dict = [responseStr JSONValue];
        self.true_name = [dict objectForKey:@"true_name"];
        self.id_num = [dict objectForKey:@"user_id_card"];
        self.bank_Num = [dict objectForKey:@"bankNo"];
        self.bank_Name = [dict objectForKey:@"bankName"];
        
        
        NSMutableString *name = [NSMutableString stringWithString:self.true_name];
        NSRange rang = NSMakeRange(1, name.length-1);
        [name replaceCharactersInRange:rang withString:@"**"];
        trueNameLabel.text = name;
        
        NSMutableString *idnum = [NSMutableString stringWithString:self.id_num];
        NSRange rang1 = NSMakeRange(2, idnum.length-6);
        [idnum replaceCharactersInRange:rang1 withString:@"************"];
        idNumLabel.text = idnum;


        
        
        if(isHuiBoChongZ){
            [bankNameField setTitle:self.bank_Name forState:UIControlStateDisabled];
            bankCardField.text = self.bank_Num;
            sureBankCardField.text = self.bank_Num;
            self.bankPhone = [self.cellPhoneDic objectForKey:bank_Name];
            phoneNumber.text = bankPhone;
            cellPhoneBtn.hidden = NO;
            
        }
        

    }
}
-(void)subMit:(UIButton *)sender
{
    NSLog(@"subMit");
    
    NSLog(@"银行:%@  省:%@  市:%@  全称:%@  银行卡号:%@  确认银行卡号:%@",bankNameField.titleLabel.text,kaihuCityField.titleLabel.text,kaihuCity1Field.titleLabel.text,kaihuQuanNameField.text,bankCardField.text,sureBankCardField.text);
    
    if([bankNameField.titleLabel.text isEqualToString:@"请选择银行"] || [kaihuCityField.titleLabel.text isEqualToString:@"请选择"] || [kaihuCity1Field.titleLabel.text isEqualToString:@"请选择"] || !kaihuQuanNameField.text || !bankCardField.text || !sureBankCardField.text)
    {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"您还有未填写的信息." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.delegate = self;
        [alert show];
        [alert release];
    }
    else{
        if(![bankCardField.text isEqualToString:sureBankCardField.text]){
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"您两次输入的银行卡号不一致." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.delegate = self;
            [alert show];
            [alert release];

        }else{
        
            [self subMitBindCardReq];
        }
    }
    

    
}
-(void)subMitBindCardReq
{
    NSString *binkid = [self.bankIDDic objectForKey:bankNameField.titleLabel.text];
    
    NSMutableData *reqData = [[GC_HttpService sharedInstance] addBankCardWithTrueName:self.true_name idCard:self.id_num bankNum:bankCardField.text bankPro:kaihuCityField.titleLabel.text bankCity:kaihuCity1Field.titleLabel.text bankID:binkid bankAllName:kaihuQuanNameField.text];
    
    
    [addBindBankCardReq clearDelegatesAndCancel];
    self.addBindBankCardReq = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [addBindBankCardReq addCommHeaders];
    [addBindBankCardReq setRequestMethod:@"POST"];
    [addBindBankCardReq setPostBody:reqData];
    [addBindBankCardReq setDefaultResponseEncoding:NSUTF8StringEncoding];
    [addBindBankCardReq setDelegate:self];
    [addBindBankCardReq setTimeOutSeconds:30];
    [addBindBankCardReq setDidFinishSelector:@selector(addBankCardFinished:)];
    [addBindBankCardReq setDidFailSelector:@selector(addbankCardFailed:)];
    [addBindBankCardReq startAsynchronous];
}

-(void)addBankCardFinished:(ASIHTTPRequest *)myrequest
{
    if(myrequest.responseData){
    
        GC_AddBankCardInfo *info  =[[GC_AddBankCardInfo alloc] initWithResponseData:myrequest.responseData WithRequest:myrequest];
        
        if(info.returnID != 3000){
            
            if(info.code == 0)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AddBankCardSuccNeedRefreshList" object:nil];
                
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"操作成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.delegate = self;
                alert.tag = 400;
                [alert show];
                [alert release];
            }
            else
            {
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:info.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.delegate = self;
                [alert show];
                [alert release];
            }

            }
        [info release];
    }
}
-(void)addbankCardFailed:(ASIHTTPRequest *)myrequest
{
    NSLog(@"addbankCardFailed");
    
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"添加银行卡失败,请重新操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alert.delegate = self;
    [alert show];
    [alert release];
}



- (void)phoneToBank:(UIButton *)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否要拨打:" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.bankPhone, nil];
    [actionSheet showInView:self.mainView];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        actionSheet.frame = CGRectMake(0, self.mainView.frame.size.height - actionSheet.frame.size.height + 60, 320, actionSheet.frame.size.height);
    }
    [actionSheet release];
}
- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    NSMutableString *mutableString = [NSMutableString stringWithString:self.bankPhone];
    
    NSRange range = [mutableString rangeOfString:@"-"];
    
    if(range.location != NSNotFound){
        [mutableString replaceCharactersInRange:range withString:@""];
    }
    
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",mutableString]]];
    }
}
#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 100)
        return 3;
    else
        return 2;
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIImageView *upxian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    return [upxian autorelease];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *upxian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    return [upxian autorelease];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(!cell){
        cell  = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
    }
    
    if(tableView.tag==100){
        
        if(indexPath.row == 0){
            UILabel *kaihuBank = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 45)];
            kaihuBank.text = @"开户银行";
            kaihuBank.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
            kaihuBank.backgroundColor = [UIColor clearColor];
            kaihuBank.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:kaihuBank];
            [kaihuBank release];

            bankNameField = [UIButton buttonWithType:UIButtonTypeCustom];
            bankNameField.frame =CGRectMake(ORIGIN_X(kaihuBank)+25, 0, 170, 45);
            if(isHuiBoChongZ){
                [bankNameField setTitleColor:[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1] forState:UIControlStateNormal];
                bankNameField.enabled = NO;
                
            }else
            {
                [bankNameField setTitle:@"请选择银行" forState:UIControlStateNormal];
                [bankNameField setTitleColor:[UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1] forState:UIControlStateNormal];
                bankNameField.enabled = YES;
                [bankNameField addTarget:self action:@selector(bankChoose) forControlEvents:UIControlEventTouchUpInside];
                
                UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(295, 18, 10, 10)];
                arrowImage.image = UIImageGetImageFromName(@"drawal_arrow.png");
                arrowImage.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:arrowImage];
                [arrowImage release];
            }

            bankNameField.backgroundColor =[UIColor clearColor];
            bankNameField.titleLabel.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:bankNameField];

            

                
            
            UIImageView *upxian = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44, 320, 1)];
            upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
            [cell.contentView addSubview:upxian];
            [upxian release];
            
        }
        if(indexPath.row == 1){
            UILabel *kaihuPlace = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 45)];
            kaihuPlace.text = @"开户地点";
            kaihuPlace.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
            kaihuPlace.backgroundColor = [UIColor clearColor];
            kaihuPlace.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:kaihuPlace];
            [kaihuPlace release];
            
            kaihuCityField = [UIButton buttonWithType:UIButtonTypeCustom];
            kaihuCityField.frame = CGRectMake(ORIGIN_X(kaihuPlace)+25, 0, 75, 45);
            if(isHuiBoChongZ){
                [kaihuCityField setTitleColor:[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1] forState:UIControlStateNormal];
                kaihuCityField.enabled = NO;
            }else
            {
                [kaihuCityField setTitle:@"请选择" forState:UIControlStateNormal];
                [kaihuCityField setTitleColor:[UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1] forState:UIControlStateNormal];
                kaihuCityField.enabled = YES;
                [kaihuCityField addTarget:self action:@selector(kaihuCityPress:) forControlEvents:UIControlEventTouchUpInside];
                UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(kaihuCityField), 18, 10, 10)];
                arrowImage.image = UIImageGetImageFromName(@"drawal_arrow.png");
                arrowImage.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:arrowImage];
                [arrowImage release];
            }

            kaihuCityField.backgroundColor = [UIColor clearColor];
            kaihuCityField.titleLabel.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:kaihuCityField];
            


            
            UIImageView *middlexian = [[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(kaihuCityField)+20, 14.5, 1, 21)];
            middlexian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
            [cell.contentView addSubview:middlexian];
            [middlexian release];
            
            kaihuCity1Field = [UIButton buttonWithType:UIButtonTypeCustom];
            kaihuCity1Field.frame =CGRectMake(ORIGIN_X(middlexian)+5, 0, 75, 45);
            if(isHuiBoChongZ){
                [kaihuCity1Field setTitleColor:[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1] forState:UIControlStateNormal];
                kaihuCity1Field.enabled = NO;
                
            }else
            {
                [kaihuCity1Field setTitle:@"请选择" forState:UIControlStateNormal];
                [kaihuCity1Field setTitleColor:[UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1] forState:UIControlStateNormal];
                kaihuCity1Field.enabled = YES;
                [kaihuCity1Field addTarget:self action:@selector(kaihuCityPress1:) forControlEvents:UIControlEventTouchUpInside];
                
                UIImageView *arrowImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(kaihuCity1Field), 18, 10, 10)];
                arrowImage1.image = UIImageGetImageFromName(@"drawal_arrow.png");
                arrowImage1.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:arrowImage1];
                [arrowImage1 release];
            }

            kaihuCity1Field.backgroundColor = [UIColor clearColor];
            kaihuCity1Field.titleLabel.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:kaihuCity1Field];
            

            
            UIImageView *upxian = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44, 320, 1)];
            upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
            [cell.contentView addSubview:upxian];
            [upxian release];
        }
        if(indexPath.row == 2){
            UILabel *kaihuBankName = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 45)];
            kaihuBankName.text = @"开户行全称";
            kaihuBankName.font = [UIFont systemFontOfSize:16];
            kaihuBankName.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
            kaihuBankName.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:kaihuBankName];
            [kaihuBankName release];
            
            kaihuQuanNameField = [[UITextField alloc] initWithFrame:CGRectMake(ORIGIN_X(kaihuBankName)+25, 13, 200, 18)];
            kaihuQuanNameField.enabled = YES;
            kaihuQuanNameField.tag = 500;
            kaihuQuanNameField.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            kaihuQuanNameField.backgroundColor = [UIColor clearColor];
            kaihuQuanNameField.delegate  = self;
            kaihuQuanNameField.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:kaihuQuanNameField];
            [kaihuQuanNameField release];
        }

        
        
    }
    if(tableView.tag == 101){
        if(indexPath.row == 0){
            UILabel *kaihuBank = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 45)];
            kaihuBank.text = @"银行卡号";
            kaihuBank.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
            kaihuBank.backgroundColor = [UIColor clearColor];
            kaihuBank.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:kaihuBank];
            [kaihuBank release];
            
            UIButton *keyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [keyBtn setFrame:CGRectMake(ORIGIN_X(kaihuBank)+25, 13, 200, 18)];
            [keyBtn addTarget:self action:@selector(pressKey:) forControlEvents:UIControlEventTouchUpInside];
            [keyBtn setBackgroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:keyBtn];
            
            bankCardField = [[UITextField alloc] initWithFrame:CGRectMake(ORIGIN_X(kaihuBank)+25, 13, 200, 18)];
            if(isHuiBoChongZ){
                bankCardField.text = @"- -";
            }
            else{
                bankCardField.placeholder = @"不支持信用卡";
            }
            bankCardField.tag = 501;
            bankCardField.enabled = NO;
            bankCardField.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            bankCardField.backgroundColor = [UIColor clearColor];
            bankCardField.font = [UIFont systemFontOfSize:16];
            bankCardField.keyboardType = UIKeyboardTypeNumberPad;
            bankCardField.delegate = self;
            [cell.contentView addSubview:bankCardField];
            [bankCardField release];
            
            UIImageView *upxian = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44, 320, 1)];
            upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
            [cell.contentView addSubview:upxian];
            [upxian release];
            
        }
        if(indexPath.row == 1){
            UILabel *kaihuPlace = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 45)];
            
            kaihuPlace.text = @"确认银行卡号";
            kaihuPlace.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
            kaihuPlace.backgroundColor = [UIColor clearColor];
            kaihuPlace.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:kaihuPlace];
            [kaihuPlace release];
            
            UIButton *keyBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [keyBtn1 setFrame:CGRectMake(ORIGIN_X(kaihuPlace)+5, 13, 200, 18)];
            [keyBtn1 addTarget:self action:@selector(pressKey1:) forControlEvents:UIControlEventTouchUpInside];
            [keyBtn1 setBackgroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:keyBtn1];
            
            sureBankCardField = [[UITextField alloc] initWithFrame:CGRectMake(ORIGIN_X(kaihuPlace)+5, 13, 200, 18)];
            if(isHuiBoChongZ){
                sureBankCardField.text = @"- -";
            }

            sureBankCardField.enabled = NO;
            sureBankCardField.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            sureBankCardField.backgroundColor = [UIColor clearColor];
            sureBankCardField.font = [UIFont systemFontOfSize:16];
            sureBankCardField.keyboardType =UIKeyboardTypeNumberPad;
            sureBankCardField.delegate = self;
            [cell.contentView addSubview:sureBankCardField];
            [sureBankCardField release];

        }
    
    }
    if(tableView.tag == 102){
    
        if(indexPath.row == 0){
            UILabel *kaihuBank = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 45)];
            kaihuBank.text = @"持卡人姓名";
            kaihuBank.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
            kaihuBank.backgroundColor = [UIColor clearColor];
            kaihuBank.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:kaihuBank];
            [kaihuBank release];
            
            trueNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(kaihuBank)+25, 0, 99, 45)];
            trueNameLabel.text = @"- -";
            trueNameLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            trueNameLabel.backgroundColor = [UIColor clearColor];
            trueNameLabel.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:trueNameLabel];
            [trueNameLabel release];
            
            UIImageView *upxian = [[UIImageView alloc] initWithFrame:CGRectMake(15, 44, 320, 1)];
            upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
            [cell.contentView addSubview:upxian];
            [upxian release];
            
        }
        if(indexPath.row == 1){
            UILabel *kaihuPlace = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 45)];
            kaihuPlace.text = @"身份证号";
            kaihuPlace.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
            kaihuPlace.backgroundColor = [UIColor clearColor];
            kaihuPlace.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:kaihuPlace];
            [kaihuPlace release];
            
            idNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(kaihuPlace)+25, 0, 200, 45)];
            idNumLabel.text = @"- -";
            idNumLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            idNumLabel.backgroundColor = [UIColor clearColor];
            idNumLabel.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:idNumLabel];
            [idNumLabel release];
            
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.userInteractionEnabled = YES;
    
    return cell;
}


#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


-(void)bankChoose
{
    [self closeKeyBoard];

    MyPickerView * pickerView = [[MyPickerView alloc] initWithContentArray:self.bankArray];
    pickerView.tag = 200;
    pickerView.delegate = self;
    [pickerView showWithTitle:[self.bankArray objectAtIndex:selectedBank]];
    [pickerView release];


}
-(void)kaihuCityPress:(UIButton *)sender
{
    [self closeKeyBoard];
    self.allcityArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
    self.provinceArray = [NSMutableArray arrayWithCapacity:0];
    for(int i = 0;i<[allcityArray count];i++){
        [self.provinceArray addObject:[[allcityArray objectAtIndex:i] objectForKey:@"state"]];
    }
    
    MyPickerView * pickerView = [[MyPickerView alloc] initWithContentArray:self.provinceArray];
    pickerView.tag = 201;
    pickerView.delegate = self;
    [pickerView showWithTitle:[self.provinceArray objectAtIndex:choosePro]];
    [pickerView release];


    
}
-(void)kaihuCityPress1:(UIButton *)sender
{
    [self closeKeyBoard];

    if(self.allcityArray)
    {
        self.cityArray = [[self.allcityArray objectAtIndex:choosePro] objectForKey:@"cities"];
        
        MyPickerView * pickerView = [[MyPickerView alloc] initWithContentArray:self.cityArray];
        pickerView.tag = 202;
        pickerView.delegate = self;
        [pickerView showWithTitle:[self.cityArray objectAtIndex:selectedCity]];
        [pickerView release];

    }

}
#pragma mark - MyPickerView Delegate

-(void)myPickerView:(MyPickerView *)myPickerView content:(NSString *)content
{
    NSLog(@"%@",content);
    
    
    if(myPickerView.tag == 200)
    {
        [bankNameField setTitle:content forState:UIControlStateNormal];
        [bankNameField setTitleColor:[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1] forState:UIControlStateNormal];
        
        self.bankPhone = [self.cellPhoneDic objectForKey:content];
        phoneNumber.text = bankPhone;
        cellPhoneBtn.hidden = NO;
        
        selectedBank = (int)[self.bankArray indexOfObject:content];

    }
    else if(myPickerView.tag == 201){
        int pro = (int)[self.provinceArray indexOfObject:content];
        if(pro != choosePro){
            selectedCity=0;
            [kaihuCity1Field setTitle:@"请选择" forState:UIControlStateNormal];
            [kaihuCity1Field setTitleColor:[UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1] forState:UIControlStateNormal];

        }
        
        choosePro = [self.provinceArray indexOfObject:content];
        [kaihuCityField setTitle:content forState:UIControlStateNormal];
        [kaihuCityField setTitleColor:[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1] forState:UIControlStateNormal];

    }else{
        selectedCity = (int)[self.cityArray indexOfObject:content];
        [kaihuCity1Field setTitle:content forState:UIControlStateNormal];
        [kaihuCity1Field setTitleColor:[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1] forState:UIControlStateNormal];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [gckeyView dissKeyFunc];
    [gckeyView1 dissKeyFunc];
    
}
#pragma mark - CP_UIAlertView Delegate
-(void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
    
        if(alertView.tag == 400){
            [self.navigationController popViewControllerAnimated:YES];
        }
    
    }
}

-(void)pressKey:(UIButton *)sender{

    [gckeyView showKeyFunc];
    
    [bankNameField resignFirstResponder];//选择银行
    
    [kaihuQuanNameField resignFirstResponder]; //开户行全称
}
-(void)pressKey1:(UIButton *)sender{
    
    [gckeyView1 showKeyFunc];
    
    [bankNameField resignFirstResponder];//选择银行
    
    [kaihuQuanNameField resignFirstResponder]; //开户行全称

}

- (void)buttonRemovButton:(GC_UIkeyView *)keyView{
    if(keyView.tag == 111){
        [gckeyView dissKeyFunc];

    }
    if(keyView.tag == 222){
        [gckeyView1 dissKeyFunc];

    }
}

- (void)keyViewDelegateView:(GC_UIkeyView *)keyView jianPanClicke:(NSInteger)sender{
    
    if(keyView.tag == 111){
        
        if (sender == 11) {
            [gckeyView dissKeyFunc];
        }
        else if (sender == 10) {
            
            if(bankCardField.text.length>=1){
                
                bankCardField.text = [bankCardField.text substringToIndex:bankCardField.text.length-1];
                
            }
            
            //            bankCardField.text = [NSString stringWithFormat:@"%.lld",[bankCardField.text longLongValue]/10];
        }
        else {
            if ([bankCardField.text length]) {
                bankCardField.text = [NSString stringWithFormat:@"%@%d",bankCardField.text,(int)sender];
            }
            else {
                bankCardField.text = [NSString stringWithFormat:@"%d",(int)sender];
            }
        }
    }
    if(keyView.tag == 222){
        
        if (sender == 11) {
            [gckeyView1 dissKeyFunc];
        }
        else if (sender == 10) {
            if(sureBankCardField.text.length>=1){
                
                sureBankCardField.text = [sureBankCardField.text substringToIndex:sureBankCardField.text.length-1];
            }
            //            sureBankCardField.text = [NSString stringWithFormat:@"%.lld",[sureBankCardField.text longLongValue]/10];
        }
        else {
            
            if ([sureBankCardField.text length]) {
                sureBankCardField.text = [NSString stringWithFormat:@"%@%d",sureBankCardField.text,(int)sender];
            }
            else {
                sureBankCardField.text = [NSString stringWithFormat:@"%d",(int)sender];
            }
            
        }
    }
    
    
}


#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(IS_IPHONE_4){
    
        if(textField.tag == 500){
            [myScrollView scrollRectToVisible:CGRectMake(0, 0, 320, 480) animated:YES];
        }
        if(textField.tag == 501){
        
            [myScrollView scrollRectToVisible:CGRectMake(0, 0, 320, 540) animated:YES];

        }
    
    }
    _tapGestureRec.enabled = YES;

    cellPhoneBtn.enabled = NO;
    return YES;
}

-(void)closeKeyBoard
{
    _tapGestureRec.enabled = NO;
    
    cellPhoneBtn.enabled =YES;

    [bankNameField resignFirstResponder];//选择银行

    [kaihuQuanNameField resignFirstResponder]; //开户行全称
    

}
-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    