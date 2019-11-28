//
//  FAQView.m
//  caibo
//
//  Created by zhang on 5/27/13.
//
//

#import "FAQView.h"
#import "caiboAppDelegate.h"
#import "KFMessageBoxView.h"
#import <QuartzCore/QuartzCore.h>
#import "RedactPrivLetterController.h"
#import "Info.h"
#import "LoginViewController.h"
#import "KFMessageBoxView.h"
#import "UserListMailController.h"

#define PROPOSAL_ID @"522537"
#define COMPLAINTS_ID @"433535"

@implementation FAQView

@synthesize faqdingwei;

- (void)dealloc
{
    [clearScrollView release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PrivateLetterBack" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CancelPrivateLetter" object:nil];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame superView:(KFMessageBoxView *)superView
{
    
    self = [super initWithFrame:frame];
    if(self){
        kFMessageBoxView = superView;

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSelf) name:@"PrivateLetterBack" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelPrivateLetter) name:@"CancelPrivateLetter" object:nil];
    }
    return self;
}

-(void)cancelPrivateLetter
{
    [self removeFromSuperview];
}

-(void)showSelf
{
    self.hidden = NO;
    kFMessageBoxView.hidden = NO;
}

- (void)scorto:(UIWebView *)infoText {
    //定位高亮显示
    if (faqdingwei == Weichupiao) {
        [infoText.scrollView setContentOffset:CGPointMake(0, 955) animated:NO];
        dingwei.hidden = NO;
        dingwei.frame = CGRectMake(5, infoText.scrollView.contentOffset.y, 280, 275);
        
    }else if (faqdingwei == Zhongjiang) {

        [infoText.scrollView setContentOffset:CGPointMake(0, 592) animated:NO];
        dingwei.hidden = NO;
        dingwei.frame = CGRectMake(5, infoText.scrollView.contentOffset.y, 280, 106);
        
    }else if (faqdingwei == Paijiangqian) {
        
//        dingwei.hidden = NO;
//        dingwei.frame = CGRectMake(5, 225, 280, 230);
        
        [infoText.scrollView setContentOffset:CGPointMake(0, 830) animated:NO];
        dingwei.hidden = NO;
        dingwei.frame = CGRectMake(5, infoText.scrollView.contentOffset.y, 280, 125);
        
    }else if (faqdingwei == Other) {
        
        dingwei.hidden = YES;
        infoText.scrollView.scrollsToTop = YES;
    }else if(faqdingwei == Chongzhi){
//        
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//            [infoText.scrollView setContentOffset:CGPointMake(0, 370) animated:NO];
//        }
//        else {
            [infoText.scrollView setContentOffset:CGPointMake(0, 1502) animated:NO];
//        }
        
        dingwei.hidden = NO;
        dingwei.frame = CGRectMake(5, infoText.scrollView.contentOffset.y, 280, 94);
    }
    else if (faqdingwei == JiangJinYouHua) {
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//            NSRange loc;
//            loc.length = 200;
//            loc.location = 2100;
////            [infoText scrollRangeToVisible:loc];
//        }
//        else {
            [infoText.scrollView setContentOffset:CGPointMake(0, 2414) animated:NO];
        
        dingwei.hidden = NO;
        dingwei.frame = CGRectMake(5, 2533, 280, 182);
//        }
        
    }else if(faqdingwei == JiangJinJiSuan){
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//            NSRange loc;
//            loc.length = 200;
//            loc.location = 1360;
//            [infoText.scrollView scrollRangeToVisible:loc];
//        }
//        else {
           [infoText.scrollView setContentOffset:CGPointMake(0, 2243) animated:NO];
//        }
        dingwei.hidden = NO;
        dingwei.frame = CGRectMake(5, infoText.scrollView.contentOffset.y, 280, 283);
    }else if (faqdingwei == dongJie){
    
        [infoText.scrollView setContentOffset:CGPointMake(0, 2243+283+10) animated:NO];
        dingwei.hidden = NO;
        dingwei.frame = CGRectMake(5, infoText.scrollView.contentOffset.y, 280, 283);

    }
    else if(faqdingwei == jiangLiHuoDong) {
        [infoText.scrollView setContentOffset:CGPointMake(0, 367) animated:NO];
        dingwei.hidden = NO;
        dingwei.frame = CGRectMake(5, infoText.scrollView.contentOffset.y, 280, 140);
    }
    infoText.scrollView.scrollEnabled = YES;
}

- (void)Show {
    
    
    UIView *faqView = [[UIView alloc] initWithFrame:CGRectMake(0, 48, 320, 600)];
    faqView.backgroundColor = [UIColor clearColor];
    faqView.userInteractionEnabled = YES;
    faqView.tag = 2001;
    
    UIImageView *bgkemage = [[UIImageView alloc] initWithFrame:faqView.bounds];
    bgkemage.image = UIImageGetImageFromName(@"DBG960.png");
    bgkemage.backgroundColor = [UIColor clearColor];
    bgkemage.userInteractionEnabled = YES;
    
//    UIButton *kbutton2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    kbutton2.frame = CGRectMake(15, 13, 151, 29);
//    kbutton2.backgroundColor = [UIColor clearColor];
//    [kbutton2 setImage:UIImageGetImageFromName(@"SBT960.png") forState:UIControlStateNormal];
//    [kbutton2 setImage:UIImageGetImageFromName(@"SBT960-1.png") forState:UIControlStateHighlighted];
//    [kbutton2 addTarget:self action:@selector(pressPhoneButton:) forControlEvents:UIControlEventTouchUpInside];
//    [bgkemage addSubview:kbutton2];
    
    //取消按钮
    UIButton *CancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [CancelButton setImage:UIImageGetImageFromName(@"XX960.png") forState:UIControlStateNormal];
    CancelButton.frame = CGRectMake(262, 14, 42, 28);
    [CancelButton addTarget:self action:@selector(pressCancel) forControlEvents:UIControlEventTouchUpInside];
    [bgkemage addSubview:CancelButton];
    
    
    UIImageView *takimage = [[UIImageView alloc] initWithFrame:CGRectMake(13, 46, 289, 474)];
    takimage.image = UIImageGetImageFromName(@"DBB960.png");
    takimage.backgroundColor = [UIColor clearColor];
    takimage.userInteractionEnabled = YES;
    [bgkemage addSubview:takimage];
    [takimage release];
    
    clearScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 5, 289, self.frame.size.height - 105)];
    clearScrollView.backgroundColor = [UIColor clearColor];
    [takimage addSubview:clearScrollView];
    
    //高亮显示
    dingwei = [[UILabel alloc] initWithFrame:CGRectMake(5, 27, 280, 120)];
    dingwei.backgroundColor = [UIColor colorWithRed:184.0/255.0 green:232.0/255.0 blue:246.0/255.0 alpha:1];
    [clearScrollView addSubview:dingwei];
    dingwei.hidden = YES;
    
    UIWebView * webView = [[[UIWebView alloc] initWithFrame:clearScrollView.bounds] autorelease];
    webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber|UIDataDetectorTypeLink;
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    webView.scrollView.bounces = NO;
    webView.scrollView.bouncesZoom = NO;
    webView.scrollView.delegate = self;
    webView.scrollView.scrollEnabled = NO;
    
    NSString *jsCommand = [NSString stringWithFormat:@"document.getElementsByTagName_r('body')[0].style.webkitTextSizeAdjust='150%%;"];
    [webView stringByEvaluatingJavaScriptFromString:jsCommand];
    [takimage addSubview:webView];
    
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"365FAQ.doc"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    [webView loadRequest:request];
    
    UIButton * proposalButton = [[[UIButton alloc] initWithFrame:CGRectMake(40, 8, 100, 15)] autorelease];
    [proposalButton setTitle:@"产品改进建议" forState:UIControlStateNormal];
    proposalButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [proposalButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    proposalButton.backgroundColor = [UIColor clearColor];
    proposalButton.tag = 10;
    [proposalButton addTarget:self action:@selector(toSiXin:) forControlEvents:UIControlEventTouchUpInside];
    [webView.scrollView addSubview:proposalButton];
    
    UIView * blueLine = [[[UIView alloc] initWithFrame:CGRectMake(13, proposalButton.frame.size.height - 1, proposalButton.frame.size.width - 26, 1)] autorelease];
    blueLine.backgroundColor = [UIColor blueColor];
    [proposalButton addSubview:blueLine];
    
    UIButton * complaintsButton = [[[UIButton alloc] initWithFrame:CGRectMake(ORIGIN_X(proposalButton) + 10, proposalButton.frame.origin.y, 100, proposalButton.frame.size.height)] autorelease];
    [complaintsButton setTitle:@"服务投诉" forState:UIControlStateNormal];
    complaintsButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [complaintsButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    complaintsButton.backgroundColor = [UIColor clearColor];
    complaintsButton.tag = 20;
    [complaintsButton addTarget:self action:@selector(toSiXin:) forControlEvents:UIControlEventTouchUpInside];
    [webView.scrollView addSubview:complaintsButton];
    
    UIView * blueLine1 = [[[UIView alloc] initWithFrame:CGRectMake(24, complaintsButton.frame.size.height - 1, complaintsButton.frame.size.width - 48, 1)] autorelease];
    blueLine1.backgroundColor = [UIColor blueColor];
    [complaintsButton addSubview:blueLine1];
    
//    //常见问题内容
//    UITextView *infoText = [[UITextView alloc] initWithFrame:CGRectMake(0, 5, 289, self.frame.size.height - 125)];
//    infoText.backgroundColor = [UIColor clearColor];
//    infoText.font = [UIFont systemFontOfSize:13];
//    infoText.editable = NO;
//    infoText.dataDetectorTypes = UIDataDetectorTypePhoneNumber | UIDataDetectorTypeLink;//自动将电话，网址转换成可点击状态。
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"365FAQ.txt"];
//    NSData *fileData = [fileManager contentsAtPath:path];
//    if (fileData) {
//        
//        NSString *str = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
//        infoText.text = str;
//        [str release];
//    }
//    [takimage addSubview:infoText];

    [dingwei release];
//    [infoText release];
    
    [faqView addSubview:bgkemage];
    
    [self addSubview:faqView];
    
    [bgkemage release];
    [faqView release];
    
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
    
#ifdef isCaiPiaoForIPad
    self.frame = CGRectMake(170, -126, 390, 768);
    infoText.frame = CGRectMake(0, 5, 289, 457);
    
    takimage.frame = CGRectMake(15, 46, 289, 470);
    faqView.frame = CGRectMake(35, 48, 320, 600);
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
    rotationAnimation.duration = 0.0f;
    
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:rotationAnimation forKey:@"run"];
    self.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
#endif
    
    
    
}

-(void)toSiXin:(UIButton *)button
{
    UINavigationController * nav = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
//    [self.window addSubview:nav.view];
    
    if ([[[Info getInstance] userId] intValue] == 0) {
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [loginVC setHidesBottomBarWhenPushed:YES];
        [loginVC setIsShowDefultAccount:YES];
        [nav pushViewController:loginVC animated:YES];
        [loginVC release];
        
        self.hidden = YES;
        return;
    }
    UserListMailController * userListMailController = [[[UserListMailController alloc] init] autorelease];
//    RedactPrivLetterController * redactPrivLetter = [[[RedactPrivLetterController alloc] init] autorelease];
////    UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:redactPrivLetter] autorelease];
////	navController.navigationBarHidden = YES;
    MailList *mList = [[[MailList alloc] init] autorelease];
    if (button.tag == 10) {
        userListMailController.senderId = PROPOSAL_ID;
        mList.nickName = @"wjcm";
    }else{
        userListMailController.senderId = COMPLAINTS_ID;
        mList.nickName = @"魏贵磊";
    }
    userListMailController.mList = mList;

//    [self.window.rootViewController.navigationController pushViewController:redactPrivLetter animated:YES];
     [nav pushViewController:userListMailController animated:YES];
    self.hidden = YES;
    kFMessageBoxView.hidden = YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"~~~%f~~~",scrollView.contentOffset.y);
    [clearScrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
}

- (void)Show:(UIViewController *)showView{
    
    UIView *faqView = [[UIView alloc] initWithFrame:CGRectMake(0, 48, 320, 600)];
    faqView.backgroundColor = [UIColor clearColor];
    faqView.userInteractionEnabled = YES;
    faqView.tag = 2001;
    
    UIImageView *bgkemage = [[UIImageView alloc] initWithFrame:faqView.bounds];
    bgkemage.image = UIImageGetImageFromName(@"DBG960.png");
    bgkemage.backgroundColor = [UIColor clearColor];
    bgkemage.userInteractionEnabled = YES;
    
//    UIButton *kbutton2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    kbutton2.frame = CGRectMake(15, 13, 151, 29);
//    kbutton2.backgroundColor = [UIColor clearColor];
//    [kbutton2 setImage:UIImageGetImageFromName(@"SBT960.png") forState:UIControlStateNormal];
//    [kbutton2 setImage:UIImageGetImageFromName(@"SBT960-1.png") forState:UIControlStateHighlighted];
//    [kbutton2 addTarget:self action:@selector(pressPhoneButton:) forControlEvents:UIControlEventTouchUpInside];
//    [bgkemage addSubview:kbutton2];
    
    //取消按钮
    UIButton *CancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [CancelButton setImage:UIImageGetImageFromName(@"XX960.png") forState:UIControlStateNormal];
    CancelButton.frame = CGRectMake(262, 14, 42, 28);
    [CancelButton addTarget:self action:@selector(pressCancel) forControlEvents:UIControlEventTouchUpInside];
    [bgkemage addSubview:CancelButton];
    
    UIImageView *takimage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 46, 289, 470)];
    takimage.image = UIImageGetImageFromName(@"DBB960.png");
    takimage.backgroundColor = [UIColor clearColor];
    takimage.userInteractionEnabled = YES;
    [bgkemage addSubview:takimage];
    [takimage release];
    
    //高亮显示
    dingwei = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, 280, 110)];
    dingwei.backgroundColor = [UIColor colorWithRed:184.0/255.0 green:232.0/255.0 blue:246.0/255.0 alpha:1];
    [takimage addSubview:dingwei];
    dingwei.hidden = YES;

    //常见问题内容
    UITextView *infoText = [[UITextView alloc] initWithFrame:CGRectMake(0, 5, 289, self.frame.size.height - 125)];
    infoText.backgroundColor = [UIColor clearColor];
    infoText.font = [UIFont systemFontOfSize:13];
    infoText.editable = NO;
    infoText.dataDetectorTypes = UIDataDetectorTypePhoneNumber | UIDataDetectorTypeLink;//自动将电话，网址转换成可点击状态。
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"365FAQ.txt"];
    NSData *fileData = [fileManager contentsAtPath:path];
    if (fileData) {
        
        NSString *str = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
        infoText.text = str;
        [str release];
    }
    [takimage addSubview:infoText];
    
    //定位高亮显示
    if (faqdingwei == Weichupiao) {
        dingwei.hidden = NO;
        dingwei.frame = CGRectMake(5, 225, 280, 125);
        [infoText setContentOffset:CGPointMake(0, 1640) animated:YES];
        
    }else if (faqdingwei == Zhongjiang) {
    
        dingwei.hidden = NO;
        dingwei.frame = CGRectMake(5, 25, 280, 110);
        [infoText setContentOffset:CGPointMake(0, 750) animated:YES];
    }else if (faqdingwei == Paijiangqian) {
    
        dingwei.hidden = NO;
        dingwei.frame = CGRectMake(5, 225, 280, 230);
        [infoText setContentOffset:CGPointMake(0, 1720) animated:YES];

    }else if (faqdingwei == Other) {
    
        dingwei.frame = CGRectMake(5, 25, 280, 110);
        dingwei.hidden = YES;
        infoText.scrollsToTop = YES;
    }else if(faqdingwei == Chongzhi){
        
        dingwei.hidden = NO;
        dingwei.frame = CGRectMake(5, 25, 280, 110);
        [infoText setContentOffset:CGPointMake(0, 422) animated:YES];
    
    }else if(faqdingwei == dongJie){
    
        dingwei.hidden = NO;
        dingwei.frame = CGRectMake(5, 25, 280, 110);
        [infoText setContentOffset:CGPointMake(0, 1720+25) animated:YES];
    }
    [dingwei release];
    [infoText release];
    
    [faqView addSubview:bgkemage];
    
    [self addSubview:faqView];
    
    [bgkemage release];
    [faqView release];
    [showView.view addSubview:self];
//    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];

#ifdef isCaiPiaoForIPad
    self.frame = CGRectMake(0, 0, 390, 768);
    infoText.frame = CGRectMake(0, 5, 289, 457);
    
    takimage.frame = CGRectMake(15, 46, 289, 470);
    faqView.frame = CGRectMake(35, 48, 320, 600);
#endif
    
//    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
//    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI/2];
//    rotationAnimation.duration = 0.0f;
//    
//    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [self.layer addAnimation:rotationAnimation forKey:@"run"];
//    self.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0);
//
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self performSelector:@selector(scorto:) withObject:webView afterDelay:0.1];
}

- (void)pressCancel {
    [self removeFromSuperview];
}


- (void)pressPhoneButton:(UIButton *)sender{
    
//    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否要拨打客服电话:" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"QQ：3254056760", nil];
//    [actionSheet showInView:self];
//    [actionSheet release];
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://4008130001"]]) {
        //            showBool = NO;
        //        }
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008130001"]];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    