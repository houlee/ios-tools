//
//  CPselfServiceViewController.m
//  caibo
//
//  Created by houchenguang on 14-5-6.
//
//

#import "CPselfServiceViewController.h"
#import "Info.h"
#import "CPSlefHelpTableViewCell.h"
#import "caiboAppDelegate.h"
#import "FAQView.h"
#import "Xieyi365ViewController.h"
#import "RelievePhoneViewController.h"
#import "ModifyAccountViewController.h"
#import "ReplaceAccountViewController.h"
#import "ReplaceBankCardsViewController.h"
#import "NetURL.h"
#import "JSON.h"

#import "KFMessageViewController.h"
#import "QuestionViewController.h"
#import "CP_UIAlertView.h"
#import "User.h"
#import "ASIHTTPRequest.h"
#import "ProvingViewCotroller.h"
#import "UserInfo.h"
#import "MLNavigationController.h"
#import "caiboAppDelegate.h"
@interface CPselfServiceViewController ()

@end

@implementation CPselfServiceViewController
@synthesize password;
@synthesize reqUserInfo;
@synthesize mMobile;
@synthesize mBankName;
@synthesize mBankIdCard;
@synthesize mNickName;
@synthesize mTrueName;
@synthesize mUserIdCard, dataArray, myTableView;
@synthesize isBank;
@synthesize httpRequest;


- (void)dealloc{
    [dataArray release];
    [myTableView release];

    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)doBack{

    [self.navigationController popViewControllerAnimated:YES];
}


- (void)dataFunc{

    
    // 修改图片
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSMutableArray * rowArray1 = [[NSMutableArray alloc] initWithCapacity:0];
    CPSlefHelpData * selfHelpdata = [[CPSlefHelpData alloc] init];
    selfHelpdata.headImageName = @"480_03_1.png";
    selfHelpdata.headSelectedImage = @"480_03-1.png";

    selfHelpdata.labelName = @"解绑手机号码";
    // SZT-S-960.png
    selfHelpdata.bgImageName = @"";
    selfHelpdata.lineName = @"SZTG960.png";
    [rowArray1 addObject:selfHelpdata];
    [selfHelpdata release];
    
    // xiugaizhanghuimage
    CPSlefHelpData * selfHelpdata2 = [[CPSlefHelpData alloc] init];
    selfHelpdata2.headImageName = @"480_06_1.png";
    selfHelpdata2.headSelectedImage = @"480_06-1";
    selfHelpdata2.labelName = @"修改账户真实信息";
    //
    selfHelpdata2.bgImageName = @"SZT-Z-960.png";
    // SZTG960.png
    selfHelpdata2.lineName = @"SZTG960.png";
    [rowArray1 addObject:selfHelpdata2];
    [selfHelpdata2 release];
    
    // genggaizhuanghuimage
    CPSlefHelpData * selfHelpdata3 = [[CPSlefHelpData alloc] init];
    selfHelpdata3.headImageName = @"480_08_1.png";
    selfHelpdata3.labelName = @"更换账户真实信息";
    selfHelpdata3.bgImageName = @"SZT-Z-960.png";
    selfHelpdata3.lineName = @"SZTG960.png";
//    [rowArray1 addObject:selfHelpdata3];
    [selfHelpdata3 release];
    
   
    // yinhangkaimage
    CPSlefHelpData * selfHelpdata4 = [[CPSlefHelpData alloc] init];
    selfHelpdata4.headImageName = @"480_10_1.png";
    selfHelpdata4.labelName = @"更换银行卡";
    selfHelpdata4.bgImageName = @"SZT-X-960.png";
    selfHelpdata4.lineName = nil;
    [rowArray1 addObject:selfHelpdata4];
    [selfHelpdata4 release];
    
    
    
    [dataArray addObject:rowArray1];
    [rowArray1 release];
    
    NSMutableArray * rowArray2 = [[NSMutableArray alloc] initWithCapacity:0];
    
    // jisuanjiangjinima
    CPSlefHelpData * selfHelpdata5 = [[CPSlefHelpData alloc] init];
    selfHelpdata5.headImageName = @"480_12_1.png";
    selfHelpdata5.labelName = @"计算奖金";
    selfHelpdata5.bgImageName = @"SZT-S-960.png";
    selfHelpdata5.lineName = @"SZTG960.png";
    [rowArray2 addObject:selfHelpdata5];
    [selfHelpdata5 release];
    
   
    
    // shijianchaxunimage
    CPSlefHelpData * selfHelpdata6 = [[CPSlefHelpData alloc] init];
    selfHelpdata6.headImageName = @"480_14_1.png";
    selfHelpdata6.labelName = @"开奖派奖时间查询";
    selfHelpdata6.bgImageName = @"SZT-X-960.png";
    selfHelpdata6.lineName = nil;
    [rowArray2 addObject:selfHelpdata6];
    [selfHelpdata6 release];
    
    [dataArray addObject:rowArray2];
    [rowArray2 release];
    
    
    NSMutableArray * rowArray3 = [[NSMutableArray alloc] initWithCapacity:0];
    // zaixiankefuimage
    CPSlefHelpData * selfHelpdata7 = [[CPSlefHelpData alloc] init];
    selfHelpdata7.headImageName = @"480_16_1.png";
    selfHelpdata7.labelName = @"在线客服";
    selfHelpdata7.bgImageName = @"SZT960.png";
    selfHelpdata7.lineName = nil;
    selfHelpdata7.imageHidder = NO;
    

   
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"]) {
        NSDictionary * chekdict = [[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"];
//        NSString * kfsx = [chekdict objectForKey:@"kfsx"];
        if ([[chekdict objectForKey:@"kfsx"] intValue] == 1) {
            selfHelpdata7.imageHidder = YES;
        }
        
    }
    
   
    
    [rowArray3 addObject:selfHelpdata7];
    [selfHelpdata7 release];
    
    [dataArray addObject:rowArray3];
    [rowArray3 release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.CP_navigation.title = @"自助服务";
    
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = left;
    
    
    
    [self createUI];
    [self dataFunc];
//    [self loadUserInfo];
    
}

- (void)createUI
{
    // 整背景
    UIImageView * backi = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    // backi.image = UIImageGetImageFromName(@"login_bgn.png");
    backi.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    backi.userInteractionEnabled = YES;
    [self.mainView addSubview:backi];
    [backi release];
    
    
    
    // 背景
//    UIView *backView = [[[UIView alloc] initWithFrame:CGRectMake(0, 15, 320, 45*4)] autorelease];
//    backView.backgroundColor = [UIColor clearColor];
//    backView.userInteractionEnabled = YES;
//    [self.mainView addSubview:backView];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height) style:UITableViewStylePlain];
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.scrollEnabled = NO;
    [backi addSubview:myTableView];
    
  
    
}



//请求用户信息
-(void)loadUserInfo
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
    NSLog(@"url = %@", [NetURL CPThreeGetAuthentication:[[Info getInstance] nickName] userpassword:passwstr type:type]);
    self.reqUserInfo = [ASIHTTPRequest requestWithURL:[NetURL CPThreeGetAuthentication:[[Info getInstance] nickName] userpassword:passwstr type:type]];
    [reqUserInfo setDefaultResponseEncoding:NSUTF8StringEncoding];
    [reqUserInfo setDidFinishSelector:@selector(reqUserInfoFinished:)];
    [reqUserInfo setDelegate:self];
    [reqUserInfo startAsynchronous];
}




-(void)reqUserInfoFinished:(ASIHTTPRequest *)requests
{
    NSLog(@"requests.responseString : %@",requests.responseString);
    NSString *responseString = requests.responseString;
    NSDictionary *result = [responseString JSONValue];
    if(responseString && ![responseString isEqualToString:@"fail"])
    {
        self.mNickName = [result objectForKey:@"nick_name"];
        self.mMobile = [result objectForKey:@"mobile"];
        self.mTrueName = [result objectForKey:@"true_name"];
        self.mUserIdCard = [result objectForKey:@"user_id_card"];
        self.mBankIdCard = [result objectForKey:@"bankNo"];
        self.mBankName = [result objectForKey:@"bankName"];
        self.isBank = [result objectForKey:@"bankBindStatus"];

    }

    
    [self.myTableView reloadData];
    
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

   
    UIView * headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width, 10)] autorelease];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 2;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString * cellid = @"cellid";
    CPSlefHelpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[[CPSlefHelpTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid] autorelease];
        
    }
    NSLog(@"是否绑定手机: %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"]);
    NSLog(@"是否实名信息: %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"]);
    
    

    if(indexPath.section == 0)
    {
        cell.nameLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];        
        
        cell.userInteractionEnabled = NO;
      
        if (indexPath.row == 0) {
            UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 5, 320, 0.5)] autorelease];
            lineView.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
            [cell addSubview:lineView];
            
        }
        
        
        // 分割线
        if (indexPath.row == 3) {
            
            UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, 0.5)] autorelease];
            lineView.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
            [cell addSubview:lineView];
        }
        
    }
    
    else if (indexPath.section == 1)
    {
    
        if (indexPath.row == 0) {
            UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 5, 320, 0.5)] autorelease];
            lineView.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
            [cell addSubview:lineView];
        }
        if (indexPath.row == 1) {
            
            UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, 0.5)] autorelease];
            lineView.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
            [cell addSubview:lineView];
        }
        
        cell.nameLabel.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
        // cell.nameLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];


    }
    else if (indexPath.section == 2)
    {
        UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 5, 320, 0.5)] autorelease];
        lineView.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
        [cell addSubview:lineView];

    
        UIView *lineView2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, 0.5)] autorelease];
        lineView2.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
        [cell addSubview:lineView2];
        cell.nameLabel.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
        // cell.nameLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];

    }
    
  
    
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isbindmobile"] intValue] == 1)
    {
        if(indexPath.section == 0 && indexPath.row == 0)
        {
            cell.nameLabel.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
            cell.userInteractionEnabled = YES;
           
            
            
        }
    }
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] intValue] == 0)
    {
        if(indexPath.section == 0 && indexPath.row == 1)
        {
            cell.nameLabel.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
            cell.userInteractionEnabled = YES;

        }
    }
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isBindBankCard"] intValue] == 1)
    {
        if(indexPath.section == 0 && indexPath.row == 2)
        {
            cell.nameLabel.textColor = [UIColor colorWithRed:58.0/255.0 green:58.0/255.0 blue:58.0/255.0 alpha:1];
            cell.userInteractionEnabled = YES;
        }
    }
    
    
    
    cell.cellIndexPath = indexPath;
    if ([dataArray count] > indexPath.section) {
        NSMutableArray * nmArray = [dataArray objectAtIndex:indexPath.section];
        if([nmArray count] > indexPath.row){
            cell.selfHelpData = [nmArray objectAtIndex:indexPath.row];
        }
    }
   
    
    
    return cell;
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message
{
    self.password = message;
    
    if(buttonIndex == 1){
        
        if (![message isEqualToString:[[User getLastUser] password] ]) {
            if (alertView.tag == 1) {
                
            }else{
                [self.httpRequest clearDelegatesAndCancel];
                NSString *name = [[Info getInstance] login_name];
                self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:message]];
                [httpRequest setTimeOutSeconds:20.0];
                [httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
                [httpRequest setDidFailSelector:@selector(recivedFail:)];
                [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
                [httpRequest setDelegate:self];
                [httpRequest startAsynchronous];

            }
            
            
        }else{
            ProvingViewCotroller *proving = [[ProvingViewCotroller alloc] init];
            [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:proving animated:YES];
            [proving release];
        }
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        selectedRow = (int)indexPath.row;
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 0) {
            
            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertTpye = passWordType;
            alert.tag = indexPath.row+100;
            [alert show];
            [alert release];
            
		}
        else{
        
            
            if (indexPath.row == 0) {//解绑手机号码
                
                RelievePhoneViewController *relieve = [[RelievePhoneViewController alloc] init];
                [self.navigationController pushViewController:relieve animated:YES];
                [relieve release];
                
                
            }else if (indexPath.row == 1){//修改账户真实信息
                
                
                ModifyAccountViewController *modify = [[ModifyAccountViewController alloc] init];
                [self.navigationController pushViewController:modify animated:YES];
                [modify release];
                
            }
//            else if (indexPath.row == 2){//更换账户真实信息
//                
//                ReplaceAccountViewController *replace  = [[ReplaceAccountViewController alloc] init];
//                [self.navigationController pushViewController:replace animated:YES];
//                [replace release];
//                
//            }
            else if (indexPath.row == 2){//更换银行卡
                
                
                ReplaceBankCardsViewController *replace = [[ReplaceBankCardsViewController alloc] init];
                [self.navigationController pushViewController:replace animated:YES];
                [replace release];
            }

        }
        
        
    }else if (indexPath.section == 1){
    
        if (indexPath.row == 0) {//计算奖金
//            FAQView *faq = [[[FAQView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
//            faq.faqdingwei = JiangJinJiSuan;
//            [faq Show];
            
            QuestionViewController *qvc=[[QuestionViewController alloc]init];
            qvc.question = JiangJinJiSuanType;
            [self.navigationController pushViewController:qvc animated:YES];
            [qvc release];
        }else if (indexPath.row == 1){//开奖派奖时间查询
            Xieyi365ViewController *xie= [[[Xieyi365ViewController alloc] init] autorelease];
            xie.ALLWANFA = SendAwardTime;
            [self.navigationController pushViewController:xie animated:YES];
        }
        
    }else if (indexPath.section == 2){
        
        
        
        if (indexPath.row == 0) {//在线客服
            
            
            
            caiboAppDelegate * appDelegate = [caiboAppDelegate getAppDelegate];
            
            KFMessageViewController *kfmBox=[KFMessageViewController alloc];
            
            kfmBox.showBool = YES;
            
            [kfmBox tsInfo];//调用提示信息
            
            [kfmBox returnSiXinCount];
            
            
            [(UINavigationController *)appDelegate.window.rootViewController pushViewController:kfmBox animated:YES];

            [kfmBox release];
            
            if ([[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"]) {
                NSDictionary * chekdict = [[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"];
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:chekdict];
                [dic setValue:@"0" forKey:@"kfsx"];
                
                
                [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"cheknewpush"];
                caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
                caiboappdelegate.keFuButton.markbool = NO;
                caiboappdelegate.keFuButton.newkfbool = NO;
                
            }
             NSMutableArray * nmArray = [dataArray objectAtIndex:indexPath.section];
             CPSlefHelpData * data = [nmArray objectAtIndex:indexPath.row];
            data.imageHidder = NO;
            [nmArray replaceObjectAtIndex:indexPath.row withObject:data];
            [dataArray replaceObjectAtIndex:indexPath.section withObject:nmArray];
            [myTableView reloadData];
            
        }
    
    }
    
    

}

- (void)recivedLoginFinish:(ASIHTTPRequest*)request {
    
#ifdef  isCaiPiaoForIPad
    NSString *responseStr = [request responseString];
	
	if ([responseStr isEqualToString:@"fail"])
	{
		CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您输入的密码不正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [alert show];
        alert.tag = 100;
        [alert release];
	}
	else {
		UserInfo *userInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
		if (!userInfo) {
			CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您输入的密码不正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
            alert.tag = 100;
            [alert show];
            [alert release];
			return;
		}
        else{
            caiboAppDelegate *app = [caiboAppDelegate getAppDelegate];
            
            UIView *vi = [[UIView alloc] initWithFrame:app.window.bounds];
            vi.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            vi.tag = 10212;
            ProvingViewCotroller *pro = [[ProvingViewCotroller alloc] init];
            pro.passWord = text.text;
            UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:pro];
            nac.view.frame = CGRectMake(80, 180, 540, 680);
            [vi addSubview:nac.view];
            
            //旋转
            CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
            rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
            rotationAnimation.duration = 0.0f;
            rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [nac.view.layer addAnimation:rotationAnimation forKey:@"run"];
            nac.view.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
            
            [app.window addSubview:vi];
            [pro release];
            [vi release];
            
            
        }
        [userInfo release];
        
#else
        
        
        NSString *responseStr = [request responseString];
        if ([responseStr isEqualToString:@"fail"])
        {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您输入的密码不正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
            [alert show];
            alert.tag = 100;
            [alert release];
        }
        else {
            UserInfo *userInfo = [[UserInfo alloc] initWithParse:responseStr DIC:nil];
            if (!userInfo) {
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您输入的密码不正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
                [alert show];
                alert.tag = 100;
                [alert release];
                return;
            }
            else{
            
                switch (selectedRow) {
                    case 0:
                    {
                        RelievePhoneViewController *relieve = [[RelievePhoneViewController alloc] init];
                        relieve.password = self.password;
                        [self.navigationController pushViewController:relieve animated:YES];
                        [relieve release];
                        
                        break;
                        
                    }
                    case 1:
                    {
                        ModifyAccountViewController *modify = [[ModifyAccountViewController alloc] init];
                        modify.password = self.password;
                        [self.navigationController pushViewController:modify animated:YES];
                        [modify release];
                        
                        break;
                        
                    }
//                    case 2:
//                    {
//                        ReplaceAccountViewController *replace  = [[ReplaceAccountViewController alloc] init];
//                        replace.password = self.password;
//                        [self.navigationController pushViewController:replace animated:YES];
//                        [replace release];
//                        
//                        break;
//                        
//                    }
                    case 2:
                    {
                        ReplaceBankCardsViewController *replace = [[ReplaceBankCardsViewController alloc] init];
                        replace.password = self.password;
                        [self.navigationController pushViewController:replace animated:YES];
                        [replace release];
                        
                        break;
                        
                    }
                        
                    default:
                        break;
                }

            
            }
            [userInfo release];
            
#endif
            
            
        }
        
        
        
        
        
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