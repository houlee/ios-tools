//
//  CJBNoActivateViewController.m
//  caibo
//
//  Created by houchenguang on 14-4-22.
//
//

#import "CJBNoActivateViewController.h"
#import "GC_HttpService.h"
#import "Info.h"
#import "YearActivateData.h"
#import "caiboAppDelegate.h"
#import "CJBHelpViewController.h"

@interface CJBNoActivateViewController ()

@end

@implementation CJBNoActivateViewController
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if (myScrollView) {
        NSInteger page = (scrollView.contentOffset.x + scrollView.frame.size.width/2)/scrollView.frame.size.width;
        
        myPageControl.currentPage = page;
    }
    
    
}

- (void)httpRequestFunc{
    
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] yearEarningsWithUserName:[[Info getInstance] userName]];
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
		YearActivateData *br = [[YearActivateData alloc] initWithResponseData:[request responseData] WithRequest:request];
        
    
        if ([br.typeString isEqualToString:@"1"]) {
            
            yearLabel.hidden = YES;
            yearLabel2.hidden = YES;
            yearLabel3.hidden = YES;
            yearLabel4.hidden = YES;
            yearLabel5.hidden = NO;

            
        }else if ([br.typeString isEqualToString:@"2"]){
            
            yearLabel.hidden = NO;
            yearLabel2.hidden = NO;
            yearLabel3.hidden = NO;
            yearLabel4.hidden = NO;
            yearLabel5.hidden = YES;
            
            if (br.dateString&&[br.dateString length] > 0) {
                yearLabel.text = [NSString stringWithFormat:@"年化收益率（%@）", br.dateString];
            }else{
                yearLabel.text = @"";
            }
            
            if (br.sevenData && [br.sevenData length] > 0) {
                yearLabel2.text = br.sevenData;
            }else{
                yearLabel2.text = @"";
            }
            
            if (br.activity && [br.activity length] > 0) {
                yearLabel4.text = br.activity;
                yearLabel3.text = @"+";
            }else{
                yearLabel3.text = @"";
                yearLabel4.text = @"";
            }
            
        }else{
            yearLabel.hidden = YES;
            yearLabel2.hidden = YES;
            yearLabel3.hidden = YES;
            yearLabel4.hidden = YES;
            yearLabel5.hidden = YES;
        
        }
        
        
        
       
        
        
        [br release];
        
    }
    [self showLabelFrameFunc];

}

- (void)showLabelFrameFunc{

   
    CGSize oneSize = [yearLabel2.text sizeWithFont:yearLabel2.font constrainedToSize:CGSizeMake(320, 25) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize twoSize = [yearLabel3.text sizeWithFont:yearLabel3.font constrainedToSize:CGSizeMake(320, 25) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize threeSize = [yearLabel4.text sizeWithFont:yearLabel4.font constrainedToSize:CGSizeMake(320, 25) lineBreakMode:NSLineBreakByWordWrapping];

    
    
    

    
    if (IS_IPHONE_5) {
        yearLabel2.frame = CGRectMake((self.mainView.frame.size.width - oneSize.width - twoSize.width - threeSize.width)/2, 377,oneSize.width, 25);
        
        yearLabel3.frame = CGRectMake(yearLabel2.frame.origin.x+yearLabel2.frame.size.width, 377, twoSize.width, 25);
        
        yearLabel4.frame = CGRectMake(yearLabel3.frame.origin.x+yearLabel3.frame.size.width, 377, threeSize.width, 25);
    }else   {
    
        yearLabel2.frame = CGRectMake((self.mainView.frame.size.width - oneSize.width - twoSize.width - threeSize.width)/2, 377- 15,oneSize.width, 25);
        
        yearLabel3.frame = CGRectMake(yearLabel2.frame.origin.x+yearLabel2.frame.size.width, 377 - 15, twoSize.width, 25);
        
        yearLabel4.frame = CGRectMake(yearLabel3.frame.origin.x+yearLabel3.frame.size.width, 377- 15, threeSize.width, 25);
    }
}


- (void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
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

    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height)];
    myScrollView.backgroundColor = [UIColor clearColor];
    myScrollView.bounces = NO;
    myScrollView.delegate = self;
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(self.mainView.frame.size.width*3, self.mainView.frame.size.height);
    [self.mainView addSubview:myScrollView];
    [myScrollView release];
    
    myPageControl = [[New_PageControl alloc] initWithFrame:CGRectMake((320 - (25*3))/2+10, myScrollView.frame.origin.y+myScrollView.frame.size.height - 36, 25*3, 12)];
    myPageControl.cjbBool = YES;
    myPageControl.tag = 30 ;
    myPageControl.currentPage = 0;
    myPageControl.numberOfPages = 3;
    [self.mainView addSubview:myPageControl];
    [myPageControl release];
    
    UIImageView * oneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.hidden)];
    oneImageView.backgroundColor = [UIColor clearColor];
    [myScrollView addSubview:oneImageView];
    [oneImageView release];
    
    
    UIImageView * bigImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 205)];
    bigImage.backgroundColor = [UIColor clearColor];
    bigImage.image = UIImageGetImageFromName(@"cjbbigimage.png");
    [oneImageView addSubview:bigImage];
    [bigImage release];
    
    
    UIImageView * zhongImage = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 245)/2, 230, 245, 63)];
    zhongImage.backgroundColor = [UIColor clearColor];
    zhongImage.image = UIImageGetImageFromName(@"fanbeiimage.png");
    [oneImageView addSubview:zhongImage];
    [zhongImage release];
    
    
//    UILabel * cjbLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 230, 320, 25)];
//    cjbLabel.backgroundColor = [UIColor clearColor];
//    cjbLabel.text = @"彩金宝";
//    cjbLabel.textColor = [UIColor colorWithRed:255/255.0 green:136/255.0 blue:31/255.0 alpha:1];
//    cjbLabel.textAlignment = NSTextAlignmentCenter;
//    cjbLabel.font = [UIFont boldSystemFontOfSize:25];
//    [oneImageView addSubview:cjbLabel];
//    [cjbLabel release];
    
    UILabel * gnLabel = [[UILabel alloc] initWithFrame:CGRectMake(63, 303, 250, 16)];
    gnLabel.backgroundColor = [UIColor clearColor];
    gnLabel.text = @"正常基金收益 + 等额 “彩票” 奖励";
    gnLabel.textColor = [UIColor colorWithRed:6/255.0 green:6/255.0 blue:6/255.0 alpha:1];
    gnLabel.textAlignment = NSTextAlignmentLeft;
    gnLabel.font = [UIFont systemFontOfSize:15];
    [oneImageView addSubview:gnLabel];
    [gnLabel release];
    
    
    UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 339, 320, 1)];
    lineImage.backgroundColor = [UIColor clearColor];
    lineImage.image = UIImageGetImageFromName(@"xuxiancjb.png");
    [oneImageView addSubview:lineImage];
    [lineImage release];
    
    
    
    
    yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 352, self.mainView.frame.size.width, 15)];
    yearLabel.backgroundColor = [UIColor clearColor];
//    yearLabel.text = @"年化收益率（2014.04.18）";
    yearLabel.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1];
    yearLabel.textAlignment = NSTextAlignmentCenter;
    yearLabel.font = [UIFont systemFontOfSize:13];
    [oneImageView addSubview:yearLabel];
    [yearLabel release];
    
    yearLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 377, 0, 0)];
    yearLabel2.backgroundColor = [UIColor clearColor];
//    yearLabel2.text = @"5.252%";
    yearLabel2.hidden = YES;
    yearLabel2.textColor = [UIColor colorWithRed:227/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    yearLabel2.textAlignment = NSTextAlignmentCenter;
    yearLabel2.font = [UIFont systemFontOfSize:24];
    [oneImageView addSubview:yearLabel2];
    [yearLabel2 release];
    
    yearLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 377, 0, 0)];
    yearLabel3.backgroundColor = [UIColor clearColor];
//    yearLabel3.text = @"+";
    yearLabel3.hidden = YES;
    yearLabel3.textColor = [UIColor colorWithRed:255/255.0 green:209/255.0 blue:13/255.0 alpha:1];
    yearLabel3.textAlignment = NSTextAlignmentCenter;
    yearLabel3.font = [UIFont systemFontOfSize:24];
    [oneImageView addSubview:yearLabel3];
    [yearLabel3 release];
    
    yearLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 377, 0, 0)];
    yearLabel4.backgroundColor = [UIColor clearColor];
//    yearLabel4.text = @"5.252%";
    yearLabel4.hidden = YES;
    yearLabel4.textColor = [UIColor colorWithRed:0/255.0 green:40/255.0 blue:170/255.0 alpha:1];
    yearLabel4.textAlignment = NSTextAlignmentCenter;
    yearLabel4.font = [UIFont systemFontOfSize:24];
    [oneImageView addSubview:yearLabel4];
    [yearLabel4 release];
    
    yearLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 355, self.mainView.frame.size.width, 28)];
    yearLabel5.backgroundColor = [UIColor clearColor];
    yearLabel5.text = @"已售罄";
    yearLabel5.textColor = [UIColor colorWithRed:216/255.0 green:39/255.0 blue:28/255.0 alpha:1];
    yearLabel5.textAlignment = NSTextAlignmentCenter;
    yearLabel5.hidden = YES;
    yearLabel5.font = [UIFont systemFontOfSize:28];
    [oneImageView addSubview:yearLabel5];
    [yearLabel5 release];
    
    
    UIImageView * twoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(320, 0, 320, self.mainView.hidden)];
    twoImageView.backgroundColor = [UIColor clearColor];
    [myScrollView addSubview:twoImageView];
    [twoImageView release];
    
    
    UIImageView * twoBigImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 205)];
    twoBigImage.backgroundColor = [UIColor clearColor];
    twoBigImage.image = UIImageGetImageFromName(@"cjbtwobigimage.png");
    [twoImageView addSubview:twoBigImage];
    [twoBigImage release];

    UIImageView * twoZhongImage = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 192)/2, 230, 192, 39)];
    twoZhongImage.backgroundColor = [UIColor clearColor];
    twoZhongImage.image = UIImageGetImageFromName(@"cjbanquanimage.png");
    [twoImageView addSubview:twoZhongImage];
    [twoZhongImage release];
    
    
    UILabel * mzLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 303 - 24, 320, 15)];
    mzLabel.backgroundColor = [UIColor clearColor];
    mzLabel.text = @"由民政部社工协会直属单位投注站";
    mzLabel.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1];
    mzLabel.textAlignment = NSTextAlignmentCenter;
    mzLabel.font = [UIFont systemFontOfSize:12];
    [twoImageView addSubview:mzLabel];
    [mzLabel release];
    
    UILabel * yfdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 324- 24, 320, 15)];
    yfdLabel.backgroundColor = [UIColor clearColor];
    yfdLabel.text = @"与易方达基金管理有限公司";
    yfdLabel.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1];
    yfdLabel.textAlignment = NSTextAlignmentCenter;
    yfdLabel.font = [UIFont systemFontOfSize:12];
    [twoImageView addSubview:yfdLabel];
    [yfdLabel release];
    
    UILabel * kjqLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 345- 24, 320, 15)];
    kjqLabel.backgroundColor = [UIColor clearColor];
    kjqLabel.text = @"(资产管理总规模近2400亿元)跨界强强合作";
    kjqLabel.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1];
    kjqLabel.textAlignment = NSTextAlignmentCenter;
    kjqLabel.font = [UIFont systemFontOfSize:12];
    [twoImageView addSubview:kjqLabel];
    [kjqLabel release];

    UIImageView * twoLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 371- 24, 320, 1)];
    twoLineImage.backgroundColor = [UIColor clearColor];
    twoLineImage.image = UIImageGetImageFromName(@"xuxiancjb.png");
    [twoImageView addSubview:twoLineImage];
    [twoLineImage release];

    UILabel * kfLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 387- 24, 320, 15)];
    kfLabel.backgroundColor = [UIColor clearColor];
    kfLabel.text = @"7*24小时客服电话";
    kfLabel.textColor = [UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1];
    kfLabel.textAlignment = NSTextAlignmentCenter;
    kfLabel.font = [UIFont systemFontOfSize:12];
    [twoImageView addSubview:kfLabel];
    [kfLabel release];
    
    UILabel * dhLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 408- 24, 320, 18)];
    dhLabel.backgroundColor = [UIColor clearColor];
    dhLabel.text = @"QQ：3254056760";
    dhLabel.textColor = [UIColor colorWithRed:32/255.0 green:151/255.0 blue:242/255.0 alpha:1];
    dhLabel.textAlignment = NSTextAlignmentCenter;
    dhLabel.font = [UIFont systemFontOfSize:18];
    [twoImageView addSubview:dhLabel];
    [dhLabel release];
    
    
    UIImageView * threeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(640, 0, 320, self.mainView.hidden)];
    threeImageView.backgroundColor = [UIColor clearColor];
    [myScrollView addSubview:threeImageView];
    [threeImageView release];
    
    
    UIImageView * threeBigImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 205)];
    threeBigImage.backgroundColor = [UIColor clearColor];
    threeBigImage.image = UIImageGetImageFromName(@"cjbthreebigimage.png");
    [threeImageView addSubview:threeBigImage];
    [threeBigImage release];
    
    UIImageView * threeZhongImage = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 198)/2, 230, 198, 39)];
    threeZhongImage.backgroundColor = [UIColor clearColor];
    threeZhongImage.image = UIImageGetImageFromName(@"cjblinghuoiamge.png");
    [threeImageView addSubview:threeZhongImage];
    [threeZhongImage release];
    
    UILabel * yyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 279, 320, 15)];
    yyLabel.backgroundColor = [UIColor clearColor];
    yyLabel.text = @"1元起购";
    yyLabel.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1];
    yyLabel.textAlignment = NSTextAlignmentCenter;
    yyLabel.font = [UIFont systemFontOfSize:15];
    [threeImageView addSubview:yyLabel];
    [yyLabel release];
    
    UILabel * ssdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, 320, 15)];
    ssdLabel.backgroundColor = [UIColor clearColor];
    ssdLabel.text = @"随时网上消费或提现";
    ssdLabel.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1];
    ssdLabel.textAlignment = NSTextAlignmentCenter;
    ssdLabel.font = [UIFont systemFontOfSize:15];
    [threeImageView addSubview:ssdLabel];
    [ssdLabel release];
    
    
    UIImageView * threeLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 325, 320, 1)];
    threeLineImage.backgroundColor = [UIColor clearColor];
    threeLineImage.image = UIImageGetImageFromName(@"xuxiancjb.png");
    [threeImageView addSubview:threeLineImage];
    [threeLineImage release];
    
    
    UILabel * ckLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 342, 320, 15)];
    ckLabel.backgroundColor = [UIColor clearColor];
    ckLabel.text = @"查看详细介绍及认购请登录投注站官方网站";
    ckLabel.textColor = [UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1];
    ckLabel.textAlignment = NSTextAlignmentCenter;
    ckLabel.font = [UIFont systemFontOfSize:12];
    [threeImageView addSubview:ckLabel];
    [ckLabel release];
    
    UILabel * wwwLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 367, 320, 18)];
    wwwLabel.backgroundColor = [UIColor clearColor];
    wwwLabel.text = @"www.caipiao365.com";
    wwwLabel.textColor = [UIColor colorWithRed:32/255.0 green:151/255.0 blue:242/255.0 alpha:1];
    wwwLabel.textAlignment = NSTextAlignmentCenter;
    wwwLabel.font = [UIFont systemFontOfSize:18];
    [threeImageView addSubview:wwwLabel];
    [wwwLabel release];
    
    
    if (IS_IPHONE_5) {
        
    }else{
        myPageControl.frame = CGRectMake((320 - (25*3))/2+10, myScrollView.frame.origin.y+myScrollView.frame.size.height - 19, 25*3, 12);
        //one view
        NSInteger hight = 15;
        zhongImage.frame = CGRectMake((320 - 245)/2, 230 - hight, 245, 63);
        gnLabel.frame = CGRectMake(63, 303 - hight, 250, 16);
        lineImage.frame = CGRectMake(0, 339 - hight, 320, 1);
        yearLabel.frame = CGRectMake(0, 352 - hight, self.mainView.frame.size.width, 15);
        yearLabel2.frame = CGRectMake(0, 377 - hight, 0, 0);
        yearLabel3.frame = CGRectMake(0, 377 - hight, 0, 0);
        yearLabel4.frame = CGRectMake(0, 377 - hight, 0, 0);
        yearLabel5.frame = CGRectMake(0, 352 - hight, self.mainView.frame.size.width, 28);
     
     //two view
       
        twoZhongImage.frame = CGRectMake((320 - 192)/2, 230- hight, 192, 39);
        mzLabel.frame = CGRectMake(0, 303 - 24- hight, 320, 15);
        yfdLabel.frame = CGRectMake(0, 324- 24- hight, 320, 15);
        kjqLabel.frame = CGRectMake(0, 345- 24- hight, 320, 15);
        twoLineImage.frame = CGRectMake(0, 371- 24- hight, 320, 1);
        kfLabel.frame = CGRectMake(0, 387- 24- hight, 320, 15);
        dhLabel.frame = CGRectMake(0, 408- 24- hight, 320, 18);
        
        //three view
        
        threeZhongImage.frame = CGRectMake((320 - 198)/2, 230- hight, 198, 39);
        yyLabel.frame = CGRectMake(0, 279- hight, 320, 15);
        ssdLabel.frame = CGRectMake(0, 300- hight, 320, 15);
        threeLineImage.frame = CGRectMake(0, 325- hight, 320, 1);
        ckLabel.frame = CGRectMake(0, 342- hight, 320, 15);
        wwwLabel.frame = CGRectMake(0, 367- hight, 320, 18);
        
        
    }
    
    
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