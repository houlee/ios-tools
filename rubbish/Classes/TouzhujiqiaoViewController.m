//
//  TouzhujiqiaoViewController.m
//  caibo
//
//  Created by zhang on 5/29/13.
//
//

#import "TouzhujiqiaoViewController.h"
#import "Info.h"

@interface TouzhujiqiaoViewController ()

@end

@implementation TouzhujiqiaoViewController

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
    self.CP_navigation.title = @"投注技巧";
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(goBackTo)];
	self.CP_navigation.leftBarButtonItem =left;
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.frame = CGRectMake(0, 44, backImage.frame.size.width, backImage.frame.size.height);
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor clearColor];
	[self.view insertSubview:backImage atIndex:0];
    self.mainView.backgroundColor = [UIColor clearColor];
    [backImage release];
    
    backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 92, self.mainView.bounds.size.height)];
    backScrollView.backgroundColor = [UIColor clearColor];
    backScrollView.userInteractionEnabled = YES;
    backScrollView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
    [backScrollView setContentSize:CGSizeMake(92, 600)];
    [self.mainView addSubview:backScrollView];
    backScrollView.scrollEnabled = NO;
    [backScrollView release];
    
    web = [[UIWebView alloc] initWithFrame:CGRectMake(50, 0, 228 + 84, self.mainView.frame.size.height)];
#ifdef isCaiPiaoForIPad
    web.frame = CGRectMake(50, 0, 298 + 84, self.mainView.frame.size.height);
#endif
    web.dataDetectorTypes = UIDataDetectorTypePhoneNumber|UIDataDetectorTypeLink;
    web.backgroundColor = [UIColor clearColor];
    web.opaque = NO;
    web.delegate = self;
    web.scalesPageToFit = YES;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5) {
        web.scrollView.showsHorizontalScrollIndicator = NO;
        web.scrollView.showsVerticalScrollIndicator = NO;
    }

    NSString *jsCommand = [NSString stringWithFormat:@"document.getElementsByTagName_r('body')[0].style.webkitTextSizeAdjust='150%%;"];
    
    
    [web stringByEvaluatingJavaScriptFromString:jsCommand];
    [self.mainView insertSubview:web belowSubview:backScrollView];
    [web release];

    UIImageView *touImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 91.5, 417)];
    touImage.image = UIImageGetImageFromName(@"touzhujiqiao-2.png");
    touImage.userInteractionEnabled = YES;
    touImage.backgroundColor = [UIColor clearColor];
    touImage.tag = 2999;
    [backScrollView addSubview:touImage];
    [touImage release];

    NSArray *nameArr = [NSArray arrayWithObjects:@"竞彩足球",@"足彩",@"竞彩篮球",@"北京单场",@"11选5",@"时时彩",@"快乐十分",@"双色球",@"大乐透",@"福彩3D",@"排列三",@"排列五",@"七星彩",@"七乐彩",@"快3", nil];
    for (int i = 0; i < nameArr.count; i++) {
        
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*26, 91.5, 26.5)];
        bgImage.image = UIImageGetImageFromName(@"touzhujiqiao-1.png");
        bgImage.userInteractionEnabled = YES;
        bgImage.backgroundColor = [UIColor clearColor];
        bgImage.tag = 4000 +i;
        bgImage.hidden = NO;
        [touImage addSubview:bgImage];
        [bgImage release];
        
        UIButton *touBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        touBtn.frame = CGRectMake(0, i*26, 91.5, 25);
        touBtn.backgroundColor = [UIColor clearColor];
        [touBtn addTarget:self action:@selector(pressTouzhujiqiao:) forControlEvents:UIControlEventTouchUpInside];
        touBtn.tag = 3000 +i;
        [touImage addSubview:touBtn];
        
        UILabel *touNam = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 91.5, 25)];
        touNam.backgroundColor = [UIColor clearColor];
        touNam.text = [nameArr objectAtIndex:i];
        touNam.font = [UIFont systemFontOfSize:12];
        touNam.textAlignment = NSTextAlignmentCenter;
        [touBtn addSubview:touNam];
        [touNam release];
        
    }
    [self Jiqiao:mycaizhong];

}
- (void)Jiqiao:(Caizhong)cazhong{
    
    mycaizhong = cazhong;
    UIImageView *ima = (UIImageView *)[backScrollView viewWithTag:2999];
    if (!ima) {
        return;
    }
    if (cazhong == daletou) {
        UIButton *btn = (UIButton *)[ima viewWithTag:3008];
        btn.selected = YES;
        
        [self pressTouzhujiqiao:btn];

    }else if (cazhong == qilecai) {
        UIButton *btn = (UIButton *)[ima viewWithTag:3013];
        btn.selected = YES;
        
        [self pressTouzhujiqiao:btn];
    }else if (cazhong == shiyixuan5) {
    
        UIButton *btn = (UIButton *)[ima viewWithTag:3004];
        btn.selected = YES;
        [self pressTouzhujiqiao:btn];
    }else if (cazhong == shishicai) {
        
        UIButton *btn = (UIButton *)[ima viewWithTag:3005];
        btn.selected = YES;
        [self pressTouzhujiqiao:btn];
    }else if (cazhong == fucai3d) {
        
        UIButton *btn = (UIButton *)[ima viewWithTag:3009];
        btn.selected = YES;
        [self pressTouzhujiqiao:btn];
    }else if (cazhong == bjdanchang) {
        
        UIButton *btn = (UIButton *)[ima viewWithTag:3003];
        btn.selected = YES;
        [self pressTouzhujiqiao:btn];
    }else if (cazhong == jincaizuqiu) {
        
        UIButton *btn = (UIButton *)[ima viewWithTag:3000];
        btn.selected = YES;
        [self pressTouzhujiqiao:btn];
    }else if (cazhong == pai3) {
        
        UIButton *btn = (UIButton *)[ima viewWithTag:3010];
        btn.selected = YES;
        [self pressTouzhujiqiao:btn];
    }else if (cazhong == pai5) {
        
        UIButton *btn = (UIButton *)[ima viewWithTag:3011];
        btn.selected = YES;
        [self pressTouzhujiqiao:btn];
    }else if (cazhong == kuaileshifen) {
        
        UIButton *btn = (UIButton *)[ima viewWithTag:3006];
        btn.selected = YES;
        [self pressTouzhujiqiao:btn];
    }else if (cazhong == shuangsheqiu) {
        
        UIButton *btn = (UIButton *)[ima viewWithTag:3007];
        btn.selected = YES;
        [self pressTouzhujiqiao:btn];
    }else if (cazhong == jingcailanqiu) {
        
        UIButton *btn = (UIButton *)[ima viewWithTag:3002];
        btn.selected = YES;
        [self pressTouzhujiqiao:btn];
    }else if (cazhong == qixincai) {
        
        UIButton *btn = (UIButton *)[ima viewWithTag:3012];
        btn.selected = YES;
        [self pressTouzhujiqiao:btn];
    }else if (cazhong == ticai) {
        
        UIButton *btn = (UIButton *)[ima viewWithTag:3001];
        btn.selected = YES;
        [self pressTouzhujiqiao:btn];
    }
//    else if (cazhong == ererX5) {
//        
//        UIButton *btn = (UIButton *)[ima viewWithTag:3014];
//        btn.selected = YES;
//        [self pressTouzhujiqiao:btn];
//    }
    else if (cazhong == k3) {
        
        UIButton *btn = (UIButton *)[ima viewWithTag:3014];
        btn.selected = YES;
        [self pressTouzhujiqiao:btn];
    }

}
- (void)goBackTo {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.mainView.userInteractionEnabled = YES;
}

- (void)pressTouzhujiqiao:(UIButton *)sender {
    self.mainView.userInteractionEnabled = NO;
    UIImageView *ima = (UIImageView *)[backScrollView viewWithTag:2999];
    for (UIButton *btn in ima.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.selected = NO;
        }
        
    }
    sender.selected = YES;
    
    for (UIImageView *mag in ima.subviews) {
        if ([mag isKindOfClass:[UIImageView class]]) {
            mag.hidden = YES;
        }
        
    }
    
    NSLog(@"%ld",(long)sender.tag);
    if (sender.tag == 3000) {
        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3000];
        btn.selected = YES;
        
        UIImageView *im = (UIImageView *)[ima viewWithTag:4000];
        im.hidden = NO;

        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"竞彩足球投注技巧.doc"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [web loadRequest:request];
        
    }else if (sender.tag == 3001) {
    
        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3001];
        btn.selected = YES;
        
        UIImageView *im = (UIImageView *)[ima viewWithTag:4001];
        im.hidden = NO;

        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"体彩投注技巧.doc"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [web loadRequest:request];

    }else if (sender.tag == 3002) {
    
        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3002];
        btn.selected = YES;
        
        UIImageView *im = (UIImageView *)[ima viewWithTag:4002];
        im.hidden = NO;

        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"篮球投注技巧.doc"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [web loadRequest:request];

    }
    else if (sender.tag == 3003) {
        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3003];
        btn.selected = YES;
        
        UIImageView *im = (UIImageView *)[ima viewWithTag:4003];
        im.hidden = NO;
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"北京单场投注技巧.doc"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [web loadRequest:request];

    }else if (sender.tag == 3004) {
        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3004];
        btn.selected = YES;
        
        UIImageView *im = (UIImageView *)[ima viewWithTag:4004];
        im.hidden = NO;
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"11选5投注技巧.doc"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [web loadRequest:request];

    }else if (sender.tag == 3005) {
    
        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3005];
        btn.selected = YES;
        
        UIImageView *im = (UIImageView *)[ima viewWithTag:4005];
        im.hidden = NO;
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"时时彩投注技巧.doc"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [web loadRequest:request];

    }else if (sender.tag == 3006) {
    
        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3006];
        btn.selected = YES;
        
        UIImageView *im = (UIImageView *)[ima viewWithTag:4006];
        im.hidden = NO;
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"快乐十分投注技巧.doc"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [web loadRequest:request];

    }else if (sender.tag ==3007) {
    
        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3007];
        btn.selected = YES;
        
        UIImageView *im = (UIImageView *)[ima viewWithTag:4007];
        im.hidden = NO;
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"双色球投注技巧.doc"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [web loadRequest:request];
    }else if (sender.tag == 3008) {
        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3008];
        btn.selected = YES;
        
        UIImageView *im = (UIImageView *)[ima viewWithTag:4008];
        im.hidden = NO;
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"大乐透投注技巧.doc"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [web loadRequest:request];

    }else if (sender.tag == 3009) {
    
        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3009];
        btn.selected = YES;
        
        UIImageView *im = (UIImageView *)[ima viewWithTag:4009];
        im.hidden = NO;
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"福彩3D投注技巧.doc"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [web loadRequest:request];
        

    }else if (sender.tag == 3010) {
    
        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3010];
        btn.selected = YES;
        
        UIImageView *im = (UIImageView *)[ima viewWithTag:4010];
        im.hidden = NO;
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"排列三投注技巧.doc"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [web loadRequest:request];
        
    }else if (sender.tag == 3011) {
    
        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3011];
        btn.selected = YES;
        
        UIImageView *im = (UIImageView *)[ima viewWithTag:4011];
        im.hidden = NO;
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"排列五投注技巧.doc"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [web loadRequest:request];

    }else if (sender.tag == 3012) {
    
        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3012];
        btn.selected = YES;
        
        UIImageView *im = (UIImageView *)[ima viewWithTag:4012];
        im.hidden = NO;
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"七星彩投注技巧.doc"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [web loadRequest:request];

    }else if (sender.tag == 3013) {
        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3013];
        btn.selected = YES;
        
        UIImageView *im = (UIImageView *)[ima viewWithTag:4013];
        im.hidden = NO;
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"七乐彩投注技巧.doc"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [web loadRequest:request];

    }
//    else if (sender.tag == 3014) {
//        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3014];
//        btn.selected = YES;
//        
//        UIImageView *im = (UIImageView *)[ima viewWithTag:4014];
//        im.hidden = NO;
//        
//        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"22选5投注技巧.doc"];
//        NSURL *fileURL = [NSURL fileURLWithPath:path];
//        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
//        [web loadRequest:request];
//        
//    }
    else if (sender.tag == 3014) {
        UIButton *btn = (UIButton *)[backScrollView viewWithTag:3014];
        btn.selected = YES;
        
        UIImageView *im = (UIImageView *)[ima viewWithTag:4014];
        im.hidden = NO;
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"快3投注技巧.doc"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
        [web loadRequest:request];
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    