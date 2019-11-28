//
//  AboutOurInfoController.m
//  caibo
//
//  Created by  on 12-6-2.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "AboutOurInfoController.h"
#import "Info.h"
@implementation AboutOurInfoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
- (void)LoadiPhoneView {

//    [self.navigationController setNavigationBarHidden:NO];
    
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = left;
    
    
    for (int i = 0; i < 12; i++) {
        for (int j = 0; j < 9; j++) {
            UIImageView * textbg = [[UIImageView alloc] initWithFrame:CGRectMake(j*40, i*40, 40, 40)];
            textbg.image = UIImageGetImageFromName(@"gc_wenli.png") ;
            textbg.backgroundColor = [UIColor clearColor];
            [self.mainView addSubview:textbg];
            [textbg release];
        }
    }
    
    
    self.mainView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, 310, self.mainView.frame.size.height)];
    textView.editable = NO;
    textView.backgroundColor = [UIColor clearColor];
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    // textView.textColor = [UIColor whiteColor];
    // textView.font = [UIFont fontWithName:@"Arial" size:12];
    
    textView.font = [UIFont boldSystemFontOfSize:16];
#ifdef  isJinShanIphone
#ifdef isJinShanIphoneNew
    self.title = @"关于彩票专家";
    textView.text = @"  彩票专家，是金山与第一视频集团旗下投注站联合推出的一款安全彩票软件。软件依托金山和第一视频集团资源优势，融合视频直播、比分直播、八方预测、手机购彩及微博互动等功能，是国内首个综合型手机彩票工具。\n  第一视频集团(0082.HK)是国有控股上市公司，是目前国内拥有资质和许可证最为齐全的新媒体产业集团，主要业务覆盖互联网和移动终端，主要产品包括第一视频网、彩票、手机游戏等。彩票业务包含“中国足彩网”、 “第一彩”和“投注站”，覆盖中国福利与体育彩票5000万用户，是目前国内最具影响力的彩票服务提供商。\n客服电话：QQ：3254056760\n官方网站：caipiao365.com";
#else
    self.title = @"关于金山投注站";
    textView.text = @"  金山投注站，是金山与第一视频集团旗下投注站联合推出的一款安全彩票软件。软件依托金山和第一视频集团资源优势，融合视频直播、比分直播、八方预测、手机购彩及微博互动等功能，是国内首个综合型手机彩票工具。\n  第一视频集团(0082.HK)是国有控股上市公司，是目前国内拥有资质和许可证最为齐全的新媒体产业集团，主要业务覆盖互联网和移动终端，主要产品包括第一视频网、彩票、手机游戏等。彩票业务包含“中国足彩网”、 “第一彩”和“投注站”，覆盖中国福利与体育彩票5000万用户，是目前国内最具影响力的彩票服务提供商。\n客服电话：QQ：3254056760\n官方网站：caipiao365.com";
#endif

#else
    self.title = @"关于投注站";
    textView.text = @"       投注站，是国内首个下载突破1000万的手机彩票应用。由直属于民政部中国社工协会，业内唯一国有控股上市公司第一视频集团(0082.HK)运营。作为中国唯一融合手机视频直播，足球比分直播，独家八方预测，全国彩票开奖及安全手机购彩等功能于一体的手机客户端产品。\n\n大事记    \n2012-06-14 投注站在中国电信“天翼空间”首发    \n2012-08-27 投注站获工信部“2012运营商终端与应用创新奖”    \n2012-09-11 工信部部长苗圩参观投注站    \n2012-10-16 投注站成为国内首个下载突破300万的手机彩票应用    \n2012-10-31 投注站获“91全球移动应用世界2012金掌奖”    \n2012-12-25 投注站获“2012年度优秀移动应用奖”    \n2013-01-16 投注站在北京钓鱼台国宾馆获“2012中国十大服务创新奖”\n2013-04-12 投注站成为“辽宁足球队”最大赞助商\n2013-05-11 投注站获中国电信2012年度“优秀作品奖”\n2013-08-13 投注站获中国互联网协会2013年度“中国互联网生活创想之星\n\n";
    UIButton * checkButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 545, 80, 40)] autorelease];
    [textView addSubview:checkButton];
    [checkButton setTitle:@"查看图文" forState:UIControlStateNormal];
    checkButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [checkButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
#endif
    
    
    //NSLog(@"%f", textView.contentSize.height);
    
    [self.mainView addSubview:textView];
    
//    UIButton * checkButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 565, 80, 40)] autorelease];
//    [textView addSubview:checkButton];
//    [checkButton setTitle:@"查看图文" forState:UIControlStateNormal];
//    checkButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [checkButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [checkButton addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    
    [textView release];

}

- (void)LoadiPadView {

    [self.navigationController setNavigationBarHidden:NO];
    
    self.title = @"关于投注站";
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBackForiPad)];
    self.navigationItem.leftBarButtonItem = left;
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -10, 540, 620)];
    bgimage.image = UIImageGetImageFromName(@"bejing.png");
    [self.mainView addSubview:bgimage];
    [bgimage release];

    UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 45, 450, 20)];
    kjTime2.backgroundColor = [UIColor clearColor];
    kjTime2.text = @"本产品，由网络购彩行业权威人物，带领追求理想，热情洋溢的";
    kjTime2.font = [UIFont systemFontOfSize:16];
    kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [self.mainView addSubview:kjTime2];
    [kjTime2 release];
    
    UILabel *kjTime3 = [[UILabel alloc] initWithFrame:CGRectMake(35, 70, 200, 20)];
    kjTime3.backgroundColor = [UIColor clearColor];
    kjTime3.text = @"研发团队，倾情奉献。";
    kjTime3.font = [UIFont systemFontOfSize:16];
    kjTime3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [self.mainView addSubview:kjTime3];
    [kjTime3 release];
    
    UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(50, 110, 450, 20)];
    kjTime.backgroundColor = [UIColor clearColor];
    kjTime.text = @"独家特色功能：猜猜猜PK赛(有奖竞猜游戏)";
    kjTime.font = [UIFont systemFontOfSize:16];
    [self.mainView addSubview:kjTime];
    [kjTime release];
    
    UILabel *kjTime11 = [[UILabel alloc] initWithFrame:CGRectMake(160, 135, 250, 20)];
    kjTime11.backgroundColor = [UIColor clearColor];
    kjTime11.text = @"赛事直播(视频)";
    kjTime11.font = [UIFont systemFontOfSize:16];
    [self.mainView addSubview:kjTime11];
    [kjTime11 release];
    
    UILabel *kjTime12 = [[UILabel alloc] initWithFrame:CGRectMake(160, 160, 250, 20)];
    kjTime12.backgroundColor = [UIColor clearColor];
    kjTime12.text = @"看图投注(边分析边投注)";
    kjTime12.font = [UIFont systemFontOfSize:16];
    [self.mainView addSubview:kjTime12];
    [kjTime12 release];
    
    UILabel *kjTime13 = [[UILabel alloc] initWithFrame:CGRectMake(160, 185, 250, 20)];
    kjTime13.backgroundColor = [UIColor clearColor];
    kjTime13.text = @"与购彩工具融合的话题互动";
    kjTime13.font = [UIFont systemFontOfSize:16];
    [self.mainView addSubview:kjTime13];
    [kjTime13 release];
    
    UILabel *kjTime14 = [[UILabel alloc] initWithFrame:CGRectMake(160, 210, 250, 20)];
    kjTime14.backgroundColor = [UIColor clearColor];
    kjTime14.text = @"写足彩图标预测";
    kjTime14.font = [UIFont systemFontOfSize:16];
    [self.mainView addSubview:kjTime14];
    [kjTime14 release];
    
    UILabel *kjTime15 = [[UILabel alloc] initWithFrame:CGRectMake(160, 235, 250, 20)];
    kjTime15.backgroundColor = [UIColor clearColor];
    kjTime15.text = @"分享投注方案";
    kjTime15.font = [UIFont systemFontOfSize:16];
    [self.mainView addSubview:kjTime15];
    [kjTime15 release];
    
    UILabel *kjTime21 = [[UILabel alloc] initWithFrame:CGRectMake(50, 280, 450, 20)];
    kjTime21.backgroundColor = [UIColor clearColor];
    kjTime21.text = @"投注站为中国足彩网的客户端产品，隶属于民政部中国社工协";
    kjTime21.font = [UIFont systemFontOfSize:16];
    kjTime21.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [self.mainView addSubview:kjTime21];
    [kjTime21 release];
    
    UILabel *kjTime31 = [[UILabel alloc] initWithFrame:CGRectMake(35, 305, 300, 20)];
    kjTime31.backgroundColor = [UIColor clearColor];
    kjTime31.text = @"会国企上市公司第一视频集团旗下。";
    kjTime31.font = [UIFont systemFontOfSize:16];
    kjTime31.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [self.mainView addSubview:kjTime31];
    [kjTime31 release];


}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

#ifdef isCaiPiaoForIPad
    [self LoadiPadView];
#else
    
    [self LoadiPhoneView];
#endif
}

-(void)check
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://wap.dingdingcai.com/wap/diyicai/active/EventRecord.jsp"]];
}

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doBackForiPad{
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    