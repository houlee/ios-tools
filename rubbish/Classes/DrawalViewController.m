//
//  DrawalViewController.m
//  caibo
//
//  Created by cp365dev on 14-8-4.
//
//

#import "DrawalViewController.h"
#import "Info.h"
#import "ColorView.h"
#import "MyPickerView.h"
#import "AddBankCardViewController.h"
#import "CP_UIAlertView.h"
#import "Info.h"
#import "caiboAppDelegate.h"
#import "GC_HttpService.h"
#import "GC_DataReadStream.h"
#import "GC_RspError.h"
#import "GC_CardListInfo.h"
#import "GC_SetDefaultBankCardInfo.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "JSON.h"
#import "ChongZhiData.h"
#import "MobClick.h"


@implementation DrawalViewController
@synthesize drawal_yue;
@synthesize bankNumArray;
@synthesize bankCardArray;
@synthesize cardListRequest,subMitRequest;
@synthesize drawal_canTiKuan;

@synthesize cardMessage;
@synthesize bankIDDic;
@synthesize password;
@synthesize drawal_jiangli;
@synthesize yinLianBackSucc;
@synthesize userBankRequest;
@synthesize mytableView;
@synthesize bankCardIdArray;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestUserCardList) name:@"BecomeActive" object:nil];
    // Do any additional setup after loading the view.
    self.CP_navigation.title = @"网上银行提款";
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
    
    UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"首页" Target:self action:@selector(pressHome) ImageName:nil Size:CGSizeMake(70, 30)];
    self.CP_navigation.rightBarButtonItem = rightItem;
    
    self.bankIDDic = [NSDictionary dictionaryWithObjects:@[@"中国工商银行",@"中国农业银行",@"中国银行",@"中国建设银行",@"国家开发银行",@"中国进出口银行",@"中国农业发展银行",@"交通银行",@"中信银行",@"中国光大银行",@"华夏银行",@"中国民生银行",@"广东发展银行",@"平安银行",@"招商银行",@"兴业银行",@"上海浦东发展银行",@"城市商业银行",@"中国邮政储蓄银行"] forKeys:@[@"102",@"103",@"104",@"105",@"201",@"202",@"203",@"301",@"302",@"303",@"304",@"305",@"306",@"307",@"308",@"309",@"310",@"313",@"403"]];
  
    self.bankCardArray = [NSMutableArray arrayWithCapacity:0];
    self.bankNumArray = [NSMutableArray arrayWithCapacity:0];
    self.bankCardIdArray = [NSMutableArray arrayWithCapacity:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(referenceBankList:) name:@"AddBankCardSuccNeedRefreshList" object:nil];
    
    
    isNextAddBank = NO;
    
    [self loadIphone];
    
    if(yinLianBackSucc){
        [self yinLianUserCarkReq];//请求银联回拨用户的银行卡信息
        
    }
    [self requestUserCardList];


}
-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [gckeyView dissKeyFunc];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(isNextAddBank){
    
        self.bankCardArray = [NSMutableArray arrayWithCapacity:0];
        self.bankNumArray = [NSMutableArray arrayWithCapacity:0];
        self.bankCardIdArray = [NSMutableArray arrayWithCapacity:0];
        
        addBankBtn.hidden = YES;
        addBankLabel.hidden = YES;
        submitBtn.hidden =YES;
        submitLabel.hidden = YES;
        tishiBtn.hidden = YES;
        
        [self requestUserCardList];
    }


}

-(void)pressHome
{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}
-(void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BecomeActive" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AddBankCardSuccNeedRefreshList" object:nil];
    [bankCardArray release];
    [bankNumArray release];
    [bankCardIdArray release];
    
    [cardListRequest clearDelegatesAndCancel];
    self.cardListRequest = nil;
    [subMitRequest clearDelegatesAndCancel];
    self.subMitRequest = nil;
    [userBankRequest clearDelegatesAndCancel];
    self.userBankRequest = nil;
    
    [super dealloc];

}

-(void)loadIphone
{
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
    myScrollView.contentSize = CGSizeMake(320, self.mainView.frame.size.height);
    myScrollView.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
    myScrollView.delegate = self;
    myScrollView.showsVerticalScrollIndicator = NO;
    [self.mainView addSubview:myScrollView];
    [myScrollView release];
    
    _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)];
    [myScrollView addGestureRecognizer:_tapGestureRec];
    _tapGestureRec.enabled = NO;
    [_tapGestureRec release];
    

    
    backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 127)];
    backImage.image = UIImageGetImageFromName(@"drawal_background.png");
    [myScrollView addSubview:backImage];
    [backImage release];
    
    
    
    
    UIFont * font33 = [UIFont systemFontOfSize:12];
    CGSize  size33 = CGSizeMake(320, 12);
    CGSize labelSize33 = [[[Info getInstance] nickName] sizeWithFont:font33 constrainedToSize:size33];
    //用户名
    UILabel *usernamelabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 38, labelSize33.width, 14)];
    usernamelabel.text =[[Info getInstance] nickName];
    usernamelabel.font = [UIFont systemFontOfSize:12];
    usernamelabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    usernamelabel.backgroundColor = [UIColor clearColor];
    [backImage addSubview:usernamelabel];
    [usernamelabel release];
    
    //余额
    yueLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(usernamelabel)+16, 40, 150, 12)];
    yueLabel.text = @"余额 -- 元";
    yueLabel.backgroundColor = [UIColor clearColor];
    yueLabel.font = [UIFont systemFontOfSize:12];
    yueLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [backImage addSubview:yueLabel];
    [yueLabel release];
    
    //可提款
    canDrawal = [[ColorView alloc] initWithFrame:CGRectMake(18, ORIGIN_Y(usernamelabel) + 9, 300, 35)];
    canDrawal.text = @"可提款 <--> 元";
    canDrawal.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    canDrawal.changeColor = [UIColor colorWithRed:255/255.0 green:252/255.0 blue:10/255.0 alpha:1];
    canDrawal.backgroundColor = [UIColor clearColor];
    canDrawal.font = [UIFont systemFontOfSize:24];
    canDrawal.colorfont = [UIFont systemFontOfSize:30];
    [backImage addSubview:canDrawal];
    [canDrawal release];
    
    //奖励账户
    jiangliLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, ORIGIN_Y(canDrawal) + 7.5, 300, 12)];
    jiangliLabel.textColor = [UIColor colorWithRed:137/255.0 green:205/255.0 blue:255/255.0 alpha:1];
    jiangliLabel.font = [UIFont systemFontOfSize:12];
    jiangliLabel.hidden = YES;
    jiangliLabel.backgroundColor = [UIColor clearColor];
    [backImage addSubview:jiangliLabel];
    [jiangliLabel release];
    
    gckeyView = [[GC_UIkeyView alloc] initWithFrame:self.mainView.bounds withType:upShowKey];
    gckeyView.delegate = self;
    [self.mainView addSubview:gckeyView];
    [gckeyView release];
    
}

-(void)drawFieldAndTable
{
    //提款金额
    
    UIImageView *upxian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 148, 320, 1)];
    upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [myScrollView addSubview:upxian];
    [upxian release];
    
    UIImageView *downxian = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(upxian)+45, 320, 1)];
    downxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [myScrollView addSubview:downxian];
    [downxian release];
    
    UIImageView *whiteView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(upxian)+1, 320, 44)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.userInteractionEnabled = YES;
    [myScrollView addSubview:whiteView];
    [whiteView release];
    
    UIButton *keyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    keyBtn.frame = CGRectMake(0, 0, 320, 44);
    keyBtn.backgroundColor  =[UIColor clearColor];
    [keyBtn addTarget:self action:@selector(PressKey:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:keyBtn];
    
    usertextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 13, 290, 16)];
    usertextField.backgroundColor = [UIColor clearColor];
    usertextField.delegate = self;
    usertextField.placeholder = @"提款金额";
    usertextField.enabled = NO;
    usertextField.font = [UIFont systemFontOfSize:14];
    usertextField.keyboardType = UIKeyboardTypeNumberPad;
    [whiteView addSubview:usertextField];
    [usertextField release];
    
    
    //银行卡列表
    mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(downxian)+19, 320, self.bankCardArray.count * 47) style:UITableViewStylePlain];
    mytableView.delegate = self;
    mytableView.dataSource = self;
    mytableView.showsVerticalScrollIndicator = NO;
    mytableView.scrollEnabled = NO;
    [mytableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myScrollView addSubview:mytableView];
    [mytableView release];


}
-(void)PressKey:(UIButton *)sender{

    [gckeyView showKeyFunc];
}

- (void)buttonRemovButton:(GC_UIkeyView *)keyView{
    [gckeyView dissKeyFunc];
}

- (void)keyViewDelegateView:(GC_UIkeyView *)keyView jianPanClicke:(NSInteger)sender{
    
    if (sender == 11) {
        [gckeyView dissKeyFunc];
    }
    else if (sender == 10) {
        usertextField.text = [NSString stringWithFormat:@"%ld",(long)[usertextField.text intValue]/10];
    }
    else {
    
        usertextField.text = [NSString stringWithFormat:@"%ld",(long)[usertextField.text intValue] * 10 + sender];
        
    }
    
    if([usertextField.text floatValue] > [self.drawal_canTiKuan floatValue])
    {
        usertextField.text = self.drawal_canTiKuan;
    }
 
    
}

-(void)drawView
{
    
    if(self.bankCardArray.count >=1)
    {
        [self drawFieldAndTable];
    }
    
    
    //添加银行卡
    if(self.bankCardArray.count < 5 && !yinLianBackSucc)
    {
        addBankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if(self.bankCardArray.count >= 1){
            addBankBtn.frame = CGRectMake(15, ORIGIN_Y(mytableView)+17, 290, 45);
            
        }
        else{
            addBankBtn.frame = CGRectMake(15, 148, 290, 45);
            
        }
        [addBankBtn setBackgroundImage:[UIImageGetImageFromName(@"tongyonglan.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        [addBankBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
        [addBankBtn setTitleColor:[UIColor colorWithRed:32/255.0 green:142/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        [addBankBtn addTarget:self action:@selector(addBank:) forControlEvents:UIControlEventTouchUpInside];
        [myScrollView addSubview:addBankBtn];
        
    }
    if(self.bankCardArray.count < 5 && !yinLianBackSucc){
        addBankLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(addBankBtn)+12, 290, 12)];

    }
    else{
        addBankLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(mytableView)+12, 290, 12)];
    }
    
    if(yinLianBackSucc){
        addBankLabel.frame = CGRectMake(15, ORIGIN_Y(mytableView)+12, 290, 30);
        addBankLabel.lineBreakMode = NSLineBreakByWordWrapping;
        addBankLabel.numberOfLines = 0;
        addBankLabel.text = @"您之前使用过银联回拨充值,所绑定的银行卡同时用于提款,不能添加或修改";
    }
    else{
        if(self.bankCardArray.count >= 1){
            addBankLabel.text = @"最多可绑定5张银行卡,绑定成功后不可修改";
            
        }
        else{
            addBankLabel.text = @"提款最多可绑定5张银行卡";
            
        }
    }

    addBankLabel.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1];
    addBankLabel.backgroundColor = [UIColor clearColor];
    addBankLabel.font = [UIFont systemFontOfSize:12];
    [myScrollView addSubview:addBankLabel];
    [addBankLabel release];
    
    
    
    if(self.bankNumArray.count >= 1){
        submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if(self.bankCardArray.count == 5){
            submitBtn.frame = CGRectMake(15, ORIGIN_Y(mytableView)+32, 290, 45);
            
        }
        else{
            submitBtn.frame = CGRectMake(15, ORIGIN_Y(addBankLabel)+32, 290, 45);
            
        }
        [submitBtn setBackgroundImage:[UIImageGetImageFromName(@"btn_blue_selected.png") stretchableImageWithLeftCapWidth:9 topCapHeight:7] forState:UIControlStateNormal];
        [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(subMit:) forControlEvents:UIControlEventTouchUpInside];
        [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [myScrollView addSubview:submitBtn];
    }
    
    if(self.bankCardArray.count == 5){
        submitLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(submitBtn)+10, 290, 12)];
        
    }
    else{
        submitLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(addBankLabel)+87, 290, 12)];
        
    }
    submitLabel.text = @"10元以上不收手续费(10元及以下每笔收取2元手续费)";
    submitLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    submitLabel.font = [UIFont systemFontOfSize:12];
    submitLabel.backgroundColor = [UIColor clearColor];
    [myScrollView addSubview:submitLabel];
    [submitLabel release];
    
    //提示
    tishiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tishiBtn setFrame:CGRectMake(260, ORIGIN_Y(submitLabel)+35, 70, 30)];
    tishiBtn.backgroundColor = [UIColor clearColor];
    [tishiBtn addTarget:self action:@selector(tishiPress:) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:tishiBtn];
    
    UILabel *tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    tishiLabel.text = @"提示";
    tishiLabel.font = [UIFont systemFontOfSize:12];
    tishiLabel.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    tishiLabel.backgroundColor = [UIColor clearColor];
    [tishiBtn addSubview:tishiLabel];
    [tishiLabel release];
    
    UIImageView *tishiImage = [[UIImageView alloc] initWithFrame:CGRectMake(35, 9, 13, 13)];
    tishiImage.image = UIImageGetImageFromName(@"drawal_blue_questionmask.png");
    tishiImage.backgroundColor = [UIColor clearColor];
    [tishiBtn addSubview:tishiImage];
    [tishiImage release];
    
    myScrollView.contentSize = CGSizeMake(320, ORIGIN_Y(tishiBtn)+50);
    
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect rect =CGRectMake(0, 15, 100, 14);
    return rect;
}
#pragma mark - UITableView Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.bankCardArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
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
    UIImageView *upxian = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)] autorelease];
    upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    return upxian;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *upxian = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)] autorelease];
    upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    return upxian;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        
        UILabel *bankNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 106, 46)];
        bankNameLabel.font = [UIFont systemFontOfSize:16];
        bankNameLabel.tag = 300;
        bankNameLabel.textColor = [UIColor colorWithRed:114/255.0 green:114/255.0 blue:114/255.0 alpha:1];
        bankNameLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:bankNameLabel];
        [bankNameLabel release];
        
        UILabel *bankCardNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(bankNameLabel)+14, 0, 170, 46)];
        bankCardNumLabel.font = [UIFont systemFontOfSize:16];
        bankCardNumLabel.tag = 301;
        bankCardNumLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        bankCardNumLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:bankCardNumLabel];
        [bankCardNumLabel release];
        
        
        
    }
    
    if(indexPath.row < [bankCardArray count]-1)
    {
        UIImageView *upxian = [[UIImageView alloc] initWithFrame:CGRectMake(15, 46, 320, 1)];
        upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        [cell.contentView addSubview:upxian];
        [upxian release];
    }

    
    

    UILabel *bankNameLabel = (UILabel *)[cell.contentView viewWithTag:300];
    UILabel *bankCardNumLabel = (UILabel *)[cell.contentView viewWithTag:301];

    bankCardNumLabel.text = [bankNumArray objectAtIndex:indexPath.row];
    bankNameLabel.text = [bankCardArray objectAtIndex:indexPath.row];

    if(indexPath.row == selectedRow){
        cell.contentView.backgroundColor = [UIColor colorWithRed:255/255.0 green:171/255.0 blue:50/255.0 alpha:1];
        bankNameLabel.textColor = [UIColor whiteColor];
        bankCardNumLabel.textColor = [UIColor whiteColor];
    }
    else{
        cell.contentView.backgroundColor = [UIColor clearColor];
        bankNameLabel.textColor = [UIColor colorWithRed:114/255.0 green:114/255.0 blue:114/255.0 alpha:1];
        bankCardNumLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];

    }
    
    if(bankNameLabel.text.length >6)
    {
        bankNameLabel.frame =CGRectMake(15, 0, 136, 46);
        bankCardNumLabel.frame =CGRectMake(ORIGIN_X(bankNameLabel)+24, 0, 170, 46);
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userInteractionEnabled = YES;
    return cell;
        
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow = (int)indexPath.row;
    [tableView reloadData];

}
//请求银联回拨用户的银行卡信息
-(void)yinLianUserCarkReq
{
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
    [userBankRequest clearDelegatesAndCancel];
    self.userBankRequest = [ASIHTTPRequest requestWithURL:[NetURL CPThreeGetAuthentication:[[Info getInstance] nickName] userpassword:passwstr type:type]];
    [userBankRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [userBankRequest setDidFinishSelector:@selector(reqUserInfoFinished:)];
    [userBankRequest setDelegate:self];
    [userBankRequest startAsynchronous];
}


-(void)reqUserInfoFinished:(ASIHTTPRequest *)mrequest
{
    NSString *responseStr = [mrequest responseString];
    
    if(responseStr && responseStr.length){
        
        NSDictionary * dict = [responseStr JSONValue];
        
        NSMutableString *banknum = nil;
        
        if([dict objectForKey:@"bankNo"]){
            banknum = [NSMutableString stringWithString:[dict objectForKey:@"bankNo"]];
        }
        
        
        if([banknum rangeOfString:@"************"].location == NSNotFound){
            if(banknum.length > 6){
                NSRange range = NSMakeRange(2, banknum.length-6);
                [banknum replaceCharactersInRange:range withString:@"************"];
            }

        }
        if(banknum && banknum.length){
            [self.bankNumArray addObject:banknum];

        }
        if([dict objectForKey:@"bankName"]){
            [self.bankCardArray addObject:[dict objectForKey:@"bankName"]];

        }
        
        [self performSelectorOnMainThread:@selector(drawView) withObject:nil waitUntilDone:NO];


    }
}
//查询用户银行卡列表信息
-(void)requestUserCardList
{
    if(!yinLianBackSucc){
    
        if(self.bankNumArray.count){
            
            [self.bankNumArray removeAllObjects];
        }
        if(self.bankCardArray.count){
            
            [self.bankCardArray removeAllObjects];
        }
        if(self.bankCardIdArray.count){
            
            [self.bankCardIdArray removeAllObjects];
        }
        
    }

    
    
    [cardListRequest clearDelegatesAndCancel];
    NSMutableData *reqData = [[GC_HttpService sharedInstance] getUserBankCardList];
    self.cardListRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [cardListRequest setRequestMethod:@"POST"];
    [cardListRequest addCommHeaders];
    [cardListRequest setPostBody:reqData];
    [cardListRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    cardListRequest.delegate = self;
    [cardListRequest setDidFinishSelector:@selector(requestUserCardListFinished:)];
    [cardListRequest setDidFailSelector:@selector(requestUserCardListFailed:)];
    [cardListRequest setTimeOutSeconds:30];
    [cardListRequest startAsynchronous];
    
}

-(void)requestUserCardListFinished:(ASIHTTPRequest *)myRequest
{
    if(myRequest.responseData){
    
        GC_CardListInfo *info = [[GC_CardListInfo alloc] initWithResponseData:myRequest.responseData WithRequest:myRequest];
        
        if(info.returnID != 3000){
            
            self.drawal_yue = info.yueMoney;
            self.drawal_canTiKuan = info.canTiKMoney;
            self.drawal_jiangli = info.jiangLiMoney;
            yueLabel.text = [NSString stringWithFormat:@"余额 %@ 元",self.drawal_yue];
            canDrawal.text = [NSString stringWithFormat:@"可提款 <%@> 元",drawal_canTiKuan];
            if([self.drawal_jiangli intValue] > 0){
                jiangliLabel.text =[NSString stringWithFormat:@"奖励账户赠送的%@元彩金不能用于提款",self.drawal_jiangli];
                jiangliLabel.hidden = NO;
                
            }
    
            if(!yinLianBackSucc)
            {
                self.cardMessage = info.cardMess;
                NSArray *cardArray = [self.cardMessage componentsSeparatedByString:@"&"];
                for(int i = 0;i<[cardArray count];i++)
                {
                    NSString *oneMess = [cardArray objectAtIndex:i];
                    NSArray *message = [oneMess componentsSeparatedByString:@","];
                    if(message.count >=2){
                        
                        if([message objectAtIndex:2])
                        {
                            
                            NSMutableString *banknum = [NSMutableString stringWithString:[message objectAtIndex:2]];
                            if([banknum rangeOfString:@"************"].location == NSNotFound){
                                if(banknum.length > 6){
                                    NSRange range = NSMakeRange(2, banknum.length-6);
                                    [banknum replaceCharactersInRange:range withString:@"************"];
                                }
                                if(banknum && banknum.length){
                                    [self.bankNumArray addObject:banknum];
                                    
                                }
                                
                            }



                        }
                        if([self.bankIDDic objectForKey:[message objectAtIndex:1]])
                        {
                            [self.bankCardArray addObject:[self.bankIDDic objectForKey:[message objectAtIndex:1]]];

                        }
                        if([message objectAtIndex:0])
                        {
                            [self.bankCardIdArray addObject:[message objectAtIndex:0]];
                        }
                    }
                }
                
            }
            if(!isNextAddBank && !yinLianBackSucc){
                [self performSelectorOnMainThread:@selector(drawView) withObject:nil waitUntilDone:NO];

            }
            else{
                
                
                if(!mytableView){
                
                    [self drawFieldAndTable];
                }
                
                mytableView.frame = CGRectMake(0, mytableView.frame.origin.y, 320, self.bankCardArray.count * 47);
                [mytableView reloadData];
                myScrollView.contentSize = CGSizeMake(myScrollView.contentSize.width, myScrollView.contentSize.height+47);
                
                
                //添加银行卡
                if(self.bankCardArray.count < 5 && !yinLianBackSucc)
                {
                    if(self.bankCardArray.count >= 1){
                        addBankBtn.frame = CGRectMake(15, ORIGIN_Y(mytableView)+17, 290, 45);
                        
                    }
                    else{
                        addBankBtn.frame = CGRectMake(15, 148, 290, 45);
                        
                    }

                }
                else{
                    addBankBtn.hidden = YES;
                    myScrollView.contentSize = CGSizeMake(myScrollView.contentSize.width, myScrollView.contentSize.height-62);

                }
                if(self.bankCardArray.count < 5 && !yinLianBackSucc){
                    addBankLabel.frame =CGRectMake(15, ORIGIN_Y(addBankBtn)+12, 290, 12);
                }
                else{
                    addBankLabel.frame =CGRectMake(15, ORIGIN_Y(mytableView)+12, 290, 12);
                }
                
                if(yinLianBackSucc){
                    addBankLabel.frame = CGRectMake(15, ORIGIN_Y(mytableView)+12, 290, 30);
                }

                if(self.bankCardArray.count >= 1){
                    if(self.bankCardArray.count == 5){
                        submitBtn.frame = CGRectMake(15, ORIGIN_Y(mytableView)+32, 290, 45);
                        
                    }
                    else{
                        submitBtn.frame = CGRectMake(15, ORIGIN_Y(addBankLabel)+32, 290, 45);
                        
                    }
                }
                
                if(self.bankCardArray.count == 5){
                    submitLabel.frame =CGRectMake(15, ORIGIN_Y(submitBtn)+10, 290, 12);
                }
                else{
                    submitLabel.frame =CGRectMake(15, ORIGIN_Y(addBankLabel)+87, 290, 12);
                }

                //提示
                [tishiBtn setFrame:CGRectMake(260, ORIGIN_Y(submitLabel)+35, 70, 30)];

                if(self.bankCardArray.count < 5 && !yinLianBackSucc){
                    addBankBtn.hidden = NO;

                }
                addBankLabel.hidden = NO;
                
                submitBtn.hidden =NO;
                submitLabel.hidden = NO;
                tishiBtn.hidden = NO;
            }
        }
        
        [info release];

    }
    
}


-(void)requestUserCardListFailed:(ASIHTTPRequest *)myRequest
{
    NSLog(@"requestUserCardListFailed :%@",myRequest.responseString);
    
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"请求银行卡信息失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alert.delegate = self;
    [alert show];
    [alert release];
}



#pragma mark - 提交
-(void)subMit:(UIButton *)sender
{
    NSLog(@"提交");

    if([usertextField.text floatValue]<=0){
    
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"提款金额必须大于0" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.delegate = self;
        [alert show];
        [alert release];
    }
    else{
        
//        if(yinLianBackSucc && 1){
//            AddBankCardViewController *addbank = [[AddBankCardViewController alloc] init];
//            addbank.isHuiBoChongZ = YES;
//            addbank.password = self.password;
//            [self.navigationController pushViewController:addbank animated:YES];
//            [addbank release];
//        }
        
        if(yinLianBackSucc)
        {
            NSMutableData *postData = [[GC_HttpService sharedInstance] reqReturnSysTime];
            [subMitRequest clearDelegatesAndCancel];
            self.subMitRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
            [subMitRequest setRequestMethod:@"POST"];
            [subMitRequest addCommHeaders];
            [subMitRequest setPostBody:postData];
            [subMitRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [subMitRequest setDelegate:self];
            [subMitRequest setDidFinishSelector:@selector(returnTiXianSysTime:)];
            [subMitRequest startAsynchronous];
        }
        if(!yinLianBackSucc)
        {
        
            [subMitRequest clearDelegatesAndCancel];
            NSString *bankid = [self.bankCardIdArray objectAtIndex:selectedRow];
            NSMutableData *reqData = [[GC_HttpService sharedInstance] setDefaultBankCardWithBankID:bankid];
            self.subMitRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
            [subMitRequest addCommHeaders];
            [subMitRequest setRequestMethod:@"POST"];
            [subMitRequest setPostBody:reqData];
            [subMitRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            subMitRequest.delegate = self;
            [subMitRequest setDidFinishSelector:@selector(setDefaultBankCardFinished:)];
            [subMitRequest setDidFailSelector:@selector(setDefaultBankCardFailed:)];
            [subMitRequest setTimeOutSeconds:30];
            [subMitRequest startAsynchronous];
        }

    
    }

    
    
}
-(void)setDefaultBankCardFinished:(ASIHTTPRequest *)myrequest
{
    if(myrequest.responseData){
    
        GC_SetDefaultBankCardInfo *info = [[GC_SetDefaultBankCardInfo alloc] initWithResponseData:myrequest.responseData WithRequest:myrequest];
        if(info.returnID != 3000){
            NSInteger isSucc = info.code;
            NSString *message = info.message;
            NSString *systime = info.systime;
            
            
            NSLog(@"如果成功继续走wap : %d   %@",(int)isSucc,message);
            
            if(isSucc == 0){
                [self goWap:systime];
            }
            else{
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.delegate = self;
                [alert show];
                [alert release];
                
            }
            
        }
        
        [info release];

    
    }
}
-(void)returnTiXianSysTime:(ASIHTTPRequest *)myrequest
{
    if(myrequest.responseData){
        ChongZhiData * chongzhi = [[ChongZhiData alloc] initWithResponseData:[myrequest responseData] WithRequest:myrequest];
        
        [self goWap:chongzhi.systime];
        
        [chongzhi release];

    }

}
-(void)goWap:(NSString *)_time
{
    [MobClick event:@"event_wodecaipiao_tikuan_tijiao" label:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterBackground) name:@"EnterBackground" object:nil];
    [self performSelector:@selector(goLiuLanqi:) withObject:[[GC_HttpService sharedInstance] getMoneyUrlSysTime:_time withMoney:usertextField.text] afterDelay:1];
    [[UIApplication sharedApplication] openURL:[[GC_HttpService sharedInstance] getMoneyUrlSysTime:_time withMoney:usertextField.text]];
}

//成功跳转safari取消跳转其他浏览器
- (void)EnterBackground {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EnterBackground" object:nil];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
}


- (void)goLiuLanqi:(NSURL *)url {
    NSURL *newURl = [[GC_HttpService sharedInstance] changeURLToTheOther:url];
    if (newURl) {
        [[UIApplication sharedApplication] openURL:newURl];
    }
    else {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"如果不能切换到浏览器进一步操作，请修改“设置->通用->访问限制->Safari”为“开启”" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}
-(void)referenceBankList:(NSNotification *)notifation
{
    isNextAddBank = YES;
}

-(void)setDefaultBankCardFailed:(ASIHTTPRequest *)myrequest
{
    NSLog(@"setDefaultBankCardFailed");
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"提交失败,请重新操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alert.delegate = self;
    [alert show];
    [alert release];
}
#pragma mark - 添加银行卡
-(void)addBank:(UIButton *)sender
{
    AddBankCardViewController *addbank = [[AddBankCardViewController alloc] init];
    addbank.password = self.password;
    [self.navigationController pushViewController:addbank animated:YES];
    [addbank release];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _tapGestureRec.enabled = YES;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
//	[textField resignFirstResponder];
	return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@",textField.text);
    
    NSString *textString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    
    if([textString floatValue] > [self.drawal_canTiKuan floatValue])
    {
        textField.text = self.drawal_canTiKuan;
        return NO;
    }
    return YES;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [usertextField resignFirstResponder];
}
-(void)closeKeyBoard
{
    
    _tapGestureRec.enabled = NO;

    [usertextField resignFirstResponder];

}
#pragma mark - 提示Message
-(void)tishiPress:(UIButton *)sender
{
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"￼为了防止少数用户进行套现和洗钱行为,办理提款时涉嫌洗钱行为(充值预付款购彩不到30%),我们将拒绝办理,针对此类用户提款将加收10%的异常提款处理费用,同时,提款到帐日自提出申请之日起,不少于15天,充值资金(扣除充值手续费后)将原路退回." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alert.delegate = self;
//    alert.center = self.mainView.center;
    alert.alertTpye = explainType;
    [alert show];
    [alert release];
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