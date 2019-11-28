//
//  CJBActivateViewController.m
//  caibo
//
//  Created by houchenguang on 14-4-22.
//
//

#import "CJBActivateViewController.h"
#import "GC_HttpService.h"
#import "Info.h"
#import "ActivateInfoData.h"
#import "CP_UIAlertView.h"
#import "caiboAppDelegate.h"
#import "CJBHelpViewController.h"


@interface CJBActivateViewController ()

@end

@implementation CJBActivateViewController
@synthesize httpRequest;

- (void)dealloc{
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = nil;
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
- (void)httpRequestFunc{
    
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] earningsInfoWithUserName:[[Info getInstance] userName] date:7];
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(activateRequestFinish:)];
    [httpRequest setDidFailSelector:@selector(activateFail:)];
    [httpRequest startAsynchronous];
    
    
}
- (void)activateFail:(ASIHTTPRequest *)request{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
}

- (void)activateRequestFinish:(ASIHTTPRequest *)request{
    
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    if ([request responseData]) {
		ActivateInfoData *br = [[ActivateInfoData alloc] initWithResponseData:[request responseData] WithRequest:request];
        
        
        
//        NSMutableArray * aaa = [[NSMutableArray alloc] initWithCapacity:0];
//        [aaa addObject:@"10-28|5.234"];
//        [aaa addObject:@"10-28|4.234"];
//        [aaa addObject:@"10-28|3.234"];
//        [aaa addObject:@"10-28|5.234"];
//        [aaa addObject:@"10-28|6.234"];
//        br.yieldRateArray = aaa;
//        [aaa release];
        
        generalAssetsLabel.text = br.total;//总资产
        yesterdayLabel.text = br.yesterday;
        historyLabel.text = br.history;
        myriadLabel.text = br.myriad;
        bonusLabel.text = br.award;
        
        if (br.dateYear == 0) {
            nhLabel.hidden = YES;
            jjrLabel.hidden = YES;
        }else {
            nhLabel.hidden = NO;
            jjrLabel.hidden = NO;
        }
        
        statisticsView.infoData = br;
        [br release];
    }
    
    
}

- (void)doBack{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pressWWButton:(UIButton *)sender{

    CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:@"总资产不包含彩金奖励" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [aler show];
    [aler release];
}

- (void)pressbluewhButton:(UIButton *)sender{
    
    CP_UIAlertView * aler = [[CP_UIAlertView alloc] initWithTitle:nil message:@"法定节假日不显示收益和收益率，收益金额会在节假日过后的第一个工作日一并发放" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [aler show];
    [aler release];

}
- (void)helpFunc{
    CJBHelpViewController * helpView = [[CJBHelpViewController alloc] init];
    [self.navigationController pushViewController:helpView animated:YES];
    [helpView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.CP_navigation.title = @"365理财";
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = left;
    
    UIButton * exitLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitLoginButton setBounds:CGRectMake(0, 0, 70, 40)];
    [exitLoginButton addTarget:self action:@selector(helpFunc) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(40, (40-23)/2+2, 24, 23)];
    imagevi.backgroundColor = [UIColor clearColor];
    imagevi.image = UIImageGetImageFromName(@"helpcjb.png") ;
    [exitLoginButton addSubview:imagevi];
    [imagevi release];
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:exitLoginButton];
    self.CP_navigation.rightBarButtonItem = barBtnItem;
    [barBtnItem release];
    
    UIScrollView * myScrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
    myScrollView.backgroundColor = [UIColor clearColor];
    myScrollView.bounces = NO;
    myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, 504);
    [self.mainView addSubview:myScrollView];
    [myScrollView release];
    
    UIImageView * upImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width, 117)];
    upImageView.backgroundColor = [UIColor colorWithRed:13/255.0 green:195/255.0 blue:236/255.0 alpha:1];
    upImageView.userInteractionEnabled = YES;
    [myScrollView addSubview:upImageView];
    [upImageView release];
    
    
    UILabel * zzcLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 50, 10)];
    zzcLabel.textColor = [UIColor whiteColor];
    zzcLabel.font = [UIFont systemFontOfSize:10];
    zzcLabel.backgroundColor = [UIColor clearColor];
    zzcLabel.text = @"总资产(元)";
    [upImageView addSubview:zzcLabel];
    [zzcLabel release];
    
    UIImageView * whiteWHImage = [[UIImageView alloc] initWithFrame:CGRectMake(67, 27.5, 15, 15)];
    whiteWHImage.backgroundColor = [UIColor clearColor];
    whiteWHImage.image = UIImageGetImageFromName(@"whitewenhao.png");
    [upImageView addSubview:whiteWHImage];
    [whiteWHImage release];
    
    
   
    
    
    generalAssetsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 55, 320 - 15, 36)];
    generalAssetsLabel.textColor = [UIColor whiteColor];
    generalAssetsLabel.font = [UIFont systemFontOfSize:36];
    generalAssetsLabel.backgroundColor = [UIColor clearColor];
//    generalAssetsLabel.text = @"23,306.008";
    [upImageView addSubview:generalAssetsLabel];
    [generalAssetsLabel release];
    
    
    
    UIImageView * middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 117, self.mainView.frame.size.width, 182)];
    middleImageView.userInteractionEnabled = YES;
    middleImageView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [myScrollView addSubview:middleImageView];
    [middleImageView release];
    
    UILabel * zrsyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 60, 10)];
    zrsyLabel.textColor = [UIColor colorWithRed:173/255.0 green:173/255.0 blue:173/255.0 alpha:1];
    zrsyLabel.font = [UIFont systemFontOfSize:10];
    zrsyLabel.backgroundColor = [UIColor clearColor];
    zrsyLabel.text = @"昨日收益(元)";
    [middleImageView addSubview:zrsyLabel];
    [zrsyLabel release];
    
    
    UIImageView * blueWHImage = [[UIImageView alloc] initWithFrame:CGRectMake(75, 27.5, 15, 15)];
    blueWHImage.backgroundColor = [UIColor clearColor];
    blueWHImage.image = UIImageGetImageFromName(@"bluewenhao.png");
    [middleImageView addSubview:blueWHImage];
    [blueWHImage release];
    
    
    
    
    UILabel * lsljLabel = [[UILabel alloc] initWithFrame:CGRectMake(174, 30, 90, 10)];
    lsljLabel.textColor = [UIColor colorWithRed:173/255.0 green:173/255.0 blue:173/255.0 alpha:1];
    lsljLabel.font = [UIFont systemFontOfSize:10];
    lsljLabel.backgroundColor = [UIColor clearColor];
    lsljLabel.text = @"历史累计收益(元)";
    [middleImageView addSubview:lsljLabel];
    [lsljLabel release];
    
    
    UILabel * wfsyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 109, 60, 10)];
    wfsyLabel.textColor = [UIColor colorWithRed:173/255.0 green:173/255.0 blue:173/255.0 alpha:1];
    wfsyLabel.font = [UIFont systemFontOfSize:10];
    wfsyLabel.backgroundColor = [UIColor clearColor];
    wfsyLabel.text = @"万份收益(元)";
    [middleImageView addSubview:wfsyLabel];
    [wfsyLabel release];
    
    
    UILabel * cjjlLabel = [[UILabel alloc] initWithFrame:CGRectMake(174, 109, 90, 10)];
    cjjlLabel.textColor = [UIColor colorWithRed:173/255.0 green:173/255.0 blue:173/255.0 alpha:1];
    cjjlLabel.font = [UIFont systemFontOfSize:10];
    cjjlLabel.backgroundColor = [UIColor clearColor];
    cjjlLabel.text = @"彩金奖励总计(元)";
    [middleImageView addSubview:cjjlLabel];
    [cjjlLabel release];
    
    
    yesterdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 55, 140, 24)];
    yesterdayLabel.textColor = [UIColor colorWithRed:255/255.0 green:190/255.0 blue:16/255.0 alpha:1];
    yesterdayLabel.font = [UIFont systemFontOfSize:24];
    yesterdayLabel.backgroundColor = [UIColor clearColor];
//    yesterdayLabel.text = @"23.08";
    [middleImageView addSubview:yesterdayLabel];
    [yesterdayLabel release];
    
    historyLabel = [[UILabel alloc] initWithFrame:CGRectMake(174, 55, 140, 24)];
    historyLabel.textColor = [UIColor colorWithRed:255/255.0 green:190/255.0 blue:16/255.0 alpha:1];
    historyLabel.font = [UIFont systemFontOfSize:24];
    historyLabel.backgroundColor = [UIColor clearColor];
//    historyLabel.text = @"23.30";
    [middleImageView addSubview:historyLabel];
    [historyLabel release];
    
    
    myriadLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 134, 140, 24)];
    myriadLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    myriadLabel.font = [UIFont systemFontOfSize:24];
    myriadLabel.backgroundColor = [UIColor clearColor];
//    myriadLabel.text = @"1.088";
    [middleImageView addSubview:myriadLabel];
    [myriadLabel release];
    
    bonusLabel = [[UILabel alloc] initWithFrame:CGRectMake(174, 134, 140, 24)];
    bonusLabel.textColor = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:0/255.0 alpha:1];
    bonusLabel.font = [UIFont systemFontOfSize:24];
    bonusLabel.backgroundColor = [UIColor clearColor];
//    bonusLabel.text = @"23.30";
    [middleImageView addSubview:bonusLabel];
    [bonusLabel release];
    
    
    nhLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 117 + 182 + 20, 80, 10)];
    nhLabel.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];
    nhLabel.font = [UIFont systemFontOfSize:10];
    nhLabel.backgroundColor = [UIColor clearColor];
    nhLabel.text = @"年化收益率(%)";
    [myScrollView addSubview:nhLabel];
    [nhLabel release];
    
    jjrLabel = [[UILabel alloc] initWithFrame:CGRectMake(86, 117 + 182 + 20, 150, 10)];
    jjrLabel.textColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    jjrLabel.font = [UIFont systemFontOfSize:10];
    jjrLabel.backgroundColor = [UIColor clearColor];
    jjrLabel.text = @"节假日不显示收益率";
    [myScrollView addSubview:jjrLabel];
    [jjrLabel release];
    
    statisticsView = [[UIStatisticsView alloc] initWithFrame:CGRectMake(0, 117 + 182 + 45, 320, 140)];
    [myScrollView addSubview:statisticsView];
    [statisticsView release];
    
    
    UIButton * wwhButton = [UIButton buttonWithType:UIButtonTypeCustom];
    wwhButton.frame = CGRectMake(45, 15, 50, 50);
    [wwhButton addTarget:self action:@selector(pressWWButton:) forControlEvents:UIControlEventTouchUpInside];
    [upImageView addSubview:wwhButton];
    
    UIButton * bluewhButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bluewhButton.frame = CGRectMake(55, 15, 50, 50);
    [bluewhButton addTarget:self action:@selector(pressbluewhButton:) forControlEvents:UIControlEventTouchUpInside];
    [middleImageView addSubview:bluewhButton];
    
    
    [self httpRequestFunc];
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