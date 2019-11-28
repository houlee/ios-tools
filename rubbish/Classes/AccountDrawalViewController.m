//
//  AccountDrawalViewController.m
//  caibo
//
//  Created by cp365dev on 14-8-6.
//
//

#import "AccountDrawalViewController.h"
#import "Info.h"
#import "DrawalViewController.h"
#import "GCXianJinLiuShuiController.h"
#import "GC_HttpService.h"
#import "GC_YinLianBackInfo.h"
#import "AddBankCardViewController.h"
#import "ProvingViewCotroller.h"
#import "DrawalRecordViewController.h"
#import "NetURL.h"
#import "UserInfo.h"
@interface AccountDrawalViewController ()

@end

@implementation AccountDrawalViewController
@synthesize yinLianRequest;
@synthesize password;
@synthesize isNotPer;
@synthesize httpRequest;
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
    
    self.CP_navigation.title = @"账户提款";
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
    
    self.mainView.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 15, 320, 120) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.userInteractionEnabled = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.scrollEnabled= NO;
    [self.mainView addSubview:myTableView];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(myTableView)+15, 290, 12)];
    messageLabel.text = @"账户提款不能使用信用卡";
    messageLabel.font = [UIFont systemFontOfSize:12];
    messageLabel.backgroundColor =  [UIColor clearColor];
    messageLabel.textColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1];
    [self.mainView addSubview:messageLabel];
    [messageLabel release];
    
    [self getYinLianBackInfo];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"authentication"] integerValue]==0)
    {
        self.isNotPer = NO;
    }
    else
    {
        self.isNotPer = YES;
    }
}
-(void)getYinLianBackInfo
{
    [yinLianRequest clearDelegatesAndCancel];
    
    NSMutableData *reqData = [[GC_HttpService sharedInstance] yinLianBackIsSucc];
    self.yinLianRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [yinLianRequest setRequestMethod:@"POST"];
    [yinLianRequest addCommHeaders];
    [yinLianRequest setPostBody:reqData];
    [yinLianRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [yinLianRequest setDelegate:self];
    [yinLianRequest setDidFinishSelector:@selector(getYinLianBackInfoFinished:)];
    [yinLianRequest setDidFailSelector:@selector(getYinLianBackInfoFailed:)];
    [yinLianRequest startAsynchronous];
}
-(void)dealloc
{
    [myTableView release];
    [yinLianRequest clearDelegatesAndCancel];
    self.yinLianRequest = nil;
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = nil;
    [super dealloc];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIImageView *upxian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    return [upxian autorelease];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIImageView *upxian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    return [upxian autorelease];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
    }
    
    if(indexPath.row == 0){
        UIImageView *bankImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 18, 28, 28)];
        bankImage.image = UIImageGetImageFromName(@"drawal_bankdrawal.png");
        bankImage.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:bankImage];
        [bankImage release];
        
        UILabel *bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(bankImage)+15, 22.5, 150, 16)];
        bankLabel.text = @"网上银行提款";
        bankLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        bankLabel.font = [UIFont systemFontOfSize:16];
        bankLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:bankLabel];
        [bankLabel release];
        
        
        UIImageView *jiantouImage =[[UIImageView alloc] initWithFrame:CGRectMake(296, 25, 9, 13)];
        jiantouImage.image = UIImageGetImageFromName(@"yinlianjiantou.png");
        jiantouImage.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:jiantouImage];
        [jiantouImage release];
        
        UIImageView *upxian1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 59, 305, 1)];
        upxian1.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        [cell.contentView addSubview:upxian1];
        [upxian1 release];

    }
    else{
        UIImageView *bankImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 18, 28, 28)];
        bankImage.image = UIImageGetImageFromName(@"drawal_record.png");
        bankImage.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:bankImage];
        [bankImage release];
        
        UILabel *bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(bankImage)+15, 22.5, 150, 16)];
        bankLabel.text = @"提款记录";
        bankLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        bankLabel.font = [UIFont systemFontOfSize:16];
        bankLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:bankLabel];
        [bankLabel release];
        
        
        UIImageView *jiantouImage =[[UIImageView alloc] initWithFrame:CGRectMake(296, 25, 9, 13)];
        jiantouImage.image = UIImageGetImageFromName(@"yinlianjiantou.png");
        jiantouImage.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:jiantouImage];
        [jiantouImage release];
    
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        
        if(isNotPer)
        {
            ProvingViewCotroller *proving = [[ProvingViewCotroller alloc] init];
            proving.passWord = self.password;
            [self.navigationController pushViewController:proving animated:YES];
            [proving release];
        }
        else{
            //第三方登陆 不需输入密码
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isUnion"] intValue] == 1) {
                
                DrawalViewController *drawal = [[DrawalViewController alloc] init];
                drawal.password = self.password;
                drawal.yinLianBackSucc = isYinLianBack;
                [self.navigationController pushViewController:drawal animated:YES];
                [drawal release];
                
            }
            else
            {
                if(self.password && self.password.length)
                {
                    DrawalViewController *drawal = [[DrawalViewController alloc] init];
                    drawal.password = self.password;
                    drawal.yinLianBackSucc = isYinLianBack;
                    [self.navigationController pushViewController:drawal animated:YES];
                    [drawal release];
                    
                }
                else
                {
                    CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"为了您的账户资金安全" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alert.alertTpye = passWordType;
                    alert.tag = 100;
                    [alert show];
                    [alert release];
                }
            }
 
        }


    }
    else{
        DrawalRecordViewController *xianjin = [[DrawalRecordViewController alloc] init];
        [self.navigationController pushViewController:xianjin animated:YES];
        [xianjin release];
    }
}
#pragma mark - ASIHttpRequest Delegate
-(void)getYinLianBackInfoFinished:(ASIHTTPRequest *)myRequest
{
    GC_YinLianBackInfo *info = [[GC_YinLianBackInfo alloc] initWithResponseData:myRequest.responseData WithRequest:myRequest];
    if(info.returnID != 3000)
    {
        if(info.code == 0){
            isYinLianBack = YES;

        }
        else{
            isYinLianBack = NO;
        }
    }
    
    myTableView.userInteractionEnabled= YES;
    
    [info release];
}
- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message{

    if (buttonIndex == 1) {
        self.password = message;
        [self.httpRequest clearDelegatesAndCancel];
        NSString *name = [[Info getInstance] login_name];
        //            NSString *password = self.passWord;
        self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBlogin:name passWord:self.password]];
        [httpRequest setTimeOutSeconds:20.0];
        [httpRequest setDidFinishSelector:@selector(recivedLoginFinish:)];
        [httpRequest setDidFailSelector:@selector(recivedFail:)];
        [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [httpRequest setDelegate:self];
        [httpRequest startAsynchronous];
        
    }


}

-(void)recivedLoginFinish:(ASIHTTPRequest *)requests
{
    
    NSString *responseString  = requests.responseString;
    if ([responseString isEqualToString:@"fail"])
    {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您输入的密码不正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [alert show];
        alert.tag = 100;
        [alert release];
    }
    else {
        UserInfo *userInfo = [[UserInfo alloc] initWithParse:responseString DIC:nil];
        if (!userInfo) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您输入的密码不正确" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
            [alert show];
            alert.tag = 100;
            [alert release];
            return;
        }
        
        else
        {
            DrawalViewController *drawal = [[DrawalViewController alloc] init];
            drawal.password = self.password;
            drawal.yinLianBackSucc = isYinLianBack;
            [self.navigationController pushViewController:drawal animated:YES];
            [drawal release];
        }
        [userInfo release];
    }

}

-(void)getYinLianBackInfoFailed:(ASIHTTPRequest *)myRequest
{
    myTableView.userInteractionEnabled= YES;

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