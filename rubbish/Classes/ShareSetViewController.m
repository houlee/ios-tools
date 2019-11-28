//
//  ShareSetViewController.m
//  CPgaopin
//
//  Created by houchenguang on 13-9-11.
//
//

#import "ShareSetViewController.h"
#import "Info.h"
#import "NetURL.h"
#import "JSON.h"
#import "SinaBindViewController.h"
#import "MobClick.h"

@interface ShareSetViewController ()

@end

@implementation ShareSetViewController
@synthesize httpRequest;

- (void)dealloc{
    
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
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

- (void)deleteUnionWithType:(NSInteger)type{
    typeSorce = type;
    [self.httpRequest clearDelegatesAndCancel];
    
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL deleteUnionUserShareWithType:[NSString stringWithFormat:@"%d", (int)type]]];
    [httpRequest setTimeOutSeconds:20.0];
    [httpRequest setDidFinishSelector:@selector(reqDeletaeFinished:)];
    [httpRequest setDidFailSelector:@selector(reqlDeletaeUnionFail:)];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];
}

- (void)reqDeletaeFinished:(ASIHTTPRequest *)request{

    NSString *responseStr = [request responseString];
    NSLog(@"responsestr = %@", responseStr);
    if (responseStr) {
        
        NSDictionary * dict = [responseStr JSONValue];
        NSString * code = [dict objectForKey:@"code"];
        if ([code isEqualToString:@"1"]) {
            if (typeSorce == 1) {
                typeLabels.text = @"未绑定";
                typeLabels.textColor = [UIColor lightGrayColor];
                [MobClick event:@"event_wodecaipiao_fenxiang_xinlang_jiebang"];
            }else if(typeSorce == 3){
//                typeLabelz.text = @"未绑定";
//                typeLabelz.textColor = [UIColor lightGrayColor];
            }else if(typeSorce == 2){
                typeLabelx.text = @"未绑定";
                typeLabelx.textColor = [UIColor lightGrayColor];
                [MobClick event:@"event_wodecaipiao_fenxiang_tengxun_jiebang"];
            }else if (typeSorce == 4){
                typeLabelw.text = @"未绑定";
                typeLabelw.textColor = [UIColor lightGrayColor];
            }
            
            NSHTTPCookie *cookie;
            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (cookie in [storage cookies]) {
                [storage deleteCookie:cookie];
            }

        }else{
        
            CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"解除绑定失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
        
        
    }
    
}

- (void)reqlDeletaeUnionFail:(ASIHTTPRequest *)request{



}

- (void)statusRequest{//全部状态请求
    
    if (!loadview) {
         loadview = [[UpLoadView alloc] init];
    }
   
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];

    [self.httpRequest clearDelegatesAndCancel];
    
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL getUnionNickNameWithUserId]];
    [httpRequest setTimeOutSeconds:20.0];
    [httpRequest setDidFinishSelector:@selector(reqUnionFinished:)];
    [httpRequest setDidFailSelector:@selector(reqlUnionFail:)];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];
}

- (void)reqlUnionFail:(ASIHTTPRequest *)request{

    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    typeLabels.text = @"未绑定";
    typeLabels.textColor = [UIColor lightGrayColor];
//    typeLabelz.text = @"未绑定";
//    typeLabelz.textColor = [UIColor lightGrayColor];
    typeLabelx.text = @"未绑定";
    typeLabelx.textColor = [UIColor lightGrayColor];
    typeLabelw.text = @"未绑定";
    typeLabelw.textColor = [UIColor lightGrayColor];
}

- (void)reqUnionFinished:(ASIHTTPRequest *)request{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    

    NSString *responseStr = [request responseString];
     NSLog(@"responsestr = %@", responseStr);
    if (responseStr) {
       
        NSArray * array = [responseStr JSONValue];
      
            typeLabels.text = @"未绑定";
            typeLabels.textColor = [UIColor lightGrayColor];
//            typeLabelz.text = @"未绑定";
//            typeLabelz.textColor = [UIColor lightGrayColor];
            typeLabelx.text = @"未绑定";
            typeLabelx.textColor = [UIColor lightGrayColor];
        
        for (NSDictionary * dict in array) {
            NSString * SOURCE = [dict objectForKey:@"SOURCE"];
            NSString * NICKNAME = [dict objectForKey:@"NICKNAME"];
//            NSLog(@"nick = %@", NICKNAME);
            if ([SOURCE isEqualToString:@"1"] && ![[dict objectForKey:@"NICKNAME"] isKindOfClass:[NSNull class]] && NICKNAME) {
                if (![NICKNAME isEqualToString:@""]) {
                    typeLabels.text = [dict objectForKey:@"NICKNAME"];
                    typeLabels.textColor = [UIColor blackColor];
                    continue;
                }
                
            }
            
            if ([SOURCE isEqualToString:@"3"]&& ![[dict objectForKey:@"NICKNAME"] isKindOfClass:[NSNull class]] && NICKNAME) {
                
                if (![NICKNAME isEqualToString:@""]) {
//                    typeLabelz.text = [dict objectForKey:@"NICKNAME"];
//                    typeLabelz.textColor = [UIColor blackColor];
                     continue;
                }
               
            }
            
            if ([SOURCE isEqualToString:@"2"]&& ![[dict objectForKey:@"NICKNAME"] isKindOfClass:[NSNull class]] && NICKNAME) {
                if (![NICKNAME isEqualToString:@""]) {
                    typeLabelx.text = [dict objectForKey:@"NICKNAME"];
                    typeLabelx.textColor = [UIColor blackColor];
                     continue;
                }
               
            }
            
            
            
            if ([SOURCE isEqualToString:@"3"]&& ![[dict objectForKey:@"NICKNAME"] isKindOfClass:[NSNull class]] && NICKNAME) {
                if (![NICKNAME isEqualToString:@""]) {
                    typeLabelw.text = [dict objectForKey:@"NICKNAME"];
                    typeLabelw.textColor = [UIColor blackColor];
                    continue;
                }
                
            }
            
            
        }
        
        
    }
   
   

}

- (void)goChange:(NSNotification *)notification{

//    if (typeSorce == 1) {
//        typeLabels.text = @"清醒";
//        typeLabels.textColor = [UIColor blackColor];
//    }else if(typeSorce == 3){
//        typeLabelz.text = @"清醒";
//        typeLabelz.textColor = [UIColor blackColor];
//    }else if(typeSorce == 2){
//        typeLabelx.text = @"清醒";
//        typeLabelx.textColor = [UIColor blackColor];
//    }
    [self statusRequest];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.CP_navigation.title = @"分享设置";
    
    UIImageView * bgview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgview.backgroundColor = [UIColor clearColor];
    // bgview.image = [UIImage imageNamed:@"login_bgn.png"];
    bgview.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:bgview];
    [bgview release];
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goChange:) name:@"bindingStatus" object:nil];
    
   
    
#if 0
    
    // 微信
    UIImageView * bgimages0 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35, 320, 45)];
    bgimages0.backgroundColor = [UIColor whiteColor];
    bgimages0.userInteractionEnabled = YES;
    // bgimages.image = [UIImageGetImageFromName(@"SZT-S-960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:8];
    [self.mainView addSubview:bgimages0];
    [bgimages0 release];
    
    // 头像 Login_SinaWeibo
    UIImageView * heaimages0 = [[UIImageView alloc] initWithFrame:CGRectMake(20, (45-21)/2, 21, 21)];
    heaimages0.backgroundColor = [UIColor clearColor];
    heaimages0.image = UIImageGetImageFromName(@"share_SinaWeibo_1.png");
    [bgimages0 addSubview:heaimages0];
    [heaimages0 release];
    
    
    
    // 线
    UIView *xianView0 = [[[UIView alloc]init] autorelease];
    xianView0.frame = CGRectMake(0, 0, 320, 0.5);
    xianView0.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    [bgimages0 addSubview:xianView0];
    
    UIView *xianView01 = [[[UIView alloc] initWithFrame:CGRectMake(54, 44.5, 320, 0.5)] autorelease];
    xianView01.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1 ];
    [xianView0 addSubview:xianView01];
    
    
    
    // 微信
    UILabel * textLabelw = [[UILabel alloc] initWithFrame:CGRectMake(50, 7, 200, 30)];
    textLabelw.textAlignment = NSTextAlignmentLeft;
    textLabelw.backgroundColor = [UIColor clearColor];
    textLabelw.textColor = [UIColor blackColor];
    textLabelw.font = [UIFont systemFontOfSize:16];
    textLabelw.text = @"微信";
    [xianView0 addSubview:textLabelw];
    [textLabelw release];
    
    
    typeLabelw = [[UILabel alloc] initWithFrame:CGRectMake(300-19-80-15-40, 7, 120, 30)];
    typeLabelw.textAlignment = NSTextAlignmentRight;
    typeLabelw.backgroundColor = [UIColor clearColor];
    typeLabelw.textColor = [UIColor lightGrayColor];
    typeLabelw.font =  [UIFont systemFontOfSize:16];
    typeLabelw.text = @"未绑定";
    [xianView0 addSubview:typeLabelw];
    [typeLabelw release];
    
    
    // 箭头JTD960.png
    UIImageView * hou1w = [[UIImageView alloc] initWithFrame:CGRectMake(300-19, (44-14)/2, 9, 14)];
    hou1w.image = UIImageGetImageFromName(@"jiantou_1.png");
    [xianView0 addSubview:hou1w];
    [hou1w release];
    
    UIButton * buttonw = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonw.frame = xianView0.bounds;
    [buttonw addTarget:self action:@selector(pressWeiXinButton:) forControlEvents:UIControlEventTouchUpInside];
    [xianView0 addSubview:buttonw];
    
    #endif
    
    
    ///新浪微博
    UIImageView * bgimages = [[UIImageView alloc] initWithFrame:CGRectMake(1, 35, 320, 45)];
    bgimages.backgroundColor = [UIColor clearColor];
    bgimages.backgroundColor = [UIColor whiteColor];
    bgimages.userInteractionEnabled = YES;
    // bgimages.image = [UIImageGetImageFromName(@"SZT-S-960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:8];
    [self.mainView addSubview:bgimages];
    [bgimages release];
    
    // 头像 Login_SinaWeibo
    UIImageView * heaimages = [[UIImageView alloc] initWithFrame:CGRectMake(20, (44-21)/2, 21, 21)];
    heaimages.backgroundColor = [UIColor clearColor];
    heaimages.image = UIImageGetImageFromName(@"share_SinaWeibo_1.png");
    [bgimages addSubview:heaimages];
    [heaimages release];
   
    
    
    
    // 线
    UIView *xianView0 = [[[UIView alloc]init] autorelease];
    xianView0.frame = CGRectMake(0, 0, 320, 0.5);
    xianView0.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    [bgimages addSubview:xianView0];
    
    
    // 线
    UIView *xianView = [[[UIView alloc]init] autorelease];
    xianView.frame = CGRectMake(54, 44.5, 320-55, 0.5);
    xianView.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    [bgimages addSubview:xianView];
    
    

   
    
    // 新浪微博
    UILabel * textLabels = [[UILabel alloc] initWithFrame:CGRectMake(50, 7, 200, 30)];
    textLabels.textAlignment = NSTextAlignmentLeft;
    textLabels.backgroundColor = [UIColor clearColor];
    textLabels.textColor = [UIColor blackColor];
    textLabels.font = [UIFont systemFontOfSize:16];
    textLabels.text = @"新浪微博";
    [bgimages addSubview:textLabels];
    [textLabels release];
    
    
    typeLabels = [[UILabel alloc] initWithFrame:CGRectMake(300-19-80-15-40, 7, 120, 30)];
    typeLabels.textAlignment = NSTextAlignmentRight;
    typeLabels.backgroundColor = [UIColor clearColor];
    typeLabels.textColor = [UIColor lightGrayColor];
    typeLabels.font =  [UIFont systemFontOfSize:16];
    typeLabels.text = @"未绑定";
    [bgimages addSubview:typeLabels];
    [typeLabels release];
    
    
    // 箭头JTD960.png
    UIImageView * hou1s = [[UIImageView alloc] initWithFrame:CGRectMake(300-19, (44-14)/2, 9, 14)];
    hou1s.image = UIImageGetImageFromName(@"jiantou_1.png");
    [bgimages addSubview:hou1s];
    [hou1s release];
    
    UIButton * buttons = [UIButton buttonWithType:UIButtonTypeCustom];
    buttons.frame = bgimages.bounds;
    [buttons addTarget:self action:@selector(pressSinaButton:) forControlEvents:UIControlEventTouchUpInside];
    [bgimages addSubview:buttons];
    
    
    ///qq空间
//    UIImageView * bgimagez = [[UIImageView alloc] initWithFrame:CGRectMake(10, 17+44, 300, 44)];
//    bgimagez.backgroundColor = [UIColor clearColor];
//    bgimagez.userInteractionEnabled = YES;
//    bgimagez.image = [[UIImage imageNamed:@"SZT-Z-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
//    [self.mainView addSubview:bgimagez];
//    [bgimagez release];
//    
//    UIImageView * heaimagez =  [[UIImageView alloc] initWithFrame:CGRectMake(20, (44-21)/2, 21, 21)];
//    heaimagez.backgroundColor = [UIColor clearColor];
//    heaimagez.image = UIImageGetImageFromName(@"Login_QQ.png");
//    [bgimagez addSubview:heaimagez];
//    [heaimagez release];
//    
//    UIImageView * xianImagez = [[UIImageView alloc] initWithFrame:CGRectMake(2, 42, 300-4, 2)];
//    xianImagez.backgroundColor = [UIColor clearColor];
//    xianImagez.image = UIImageGetImageFromName(@"SZTG960.png");
//    [bgimagez addSubview:xianImagez];
//    [xianImagez release];
//    
//    UILabel * textLabelz = [[UILabel alloc] initWithFrame:CGRectMake(50, 7, 200, 30)];
//    textLabelz.textAlignment = NSTextAlignmentLeft;
//    textLabelz.backgroundColor = [UIColor clearColor];
//    textLabelz.textColor = [UIColor blackColor];
//    textLabelz.font = [UIFont systemFontOfSize:16];
//    textLabelz.text = @"qq空间";
//    [bgimagez addSubview:textLabelz];
//    [textLabelz release];
//    
//    
//    typeLabelz = [[UILabel alloc] initWithFrame:CGRectMake(300-19-80-15-40, 7, 120, 30)];
//    typeLabelz.textAlignment = NSTextAlignmentRight;
//    typeLabelz.backgroundColor = [UIColor clearColor ];
//    typeLabelz.textColor = [UIColor lightGrayColor];
//    typeLabelz.font =  [UIFont systemFontOfSize:16];
//    typeLabelz.text = @"未绑定";
//    [bgimagez addSubview:typeLabelz];
//    [typeLabelz release];
//    
//    
//    UIImageView * hou1z = [[UIImageView alloc] initWithFrame:CGRectMake(300-19, (44-14)/2, 9, 14)];
//    hou1z.image = UIImageGetImageFromName(@"JTD960.png");
//    [bgimagez addSubview:hou1z];
//    [hou1z release];
//    
//    UIButton * buttonz = [UIButton buttonWithType:UIButtonTypeCustom];
//    buttonz.frame = bgimagez.bounds;
//    [buttonz addTarget:self action:@selector(pressQQButton:) forControlEvents:UIControlEventTouchUpInside];
//    [bgimagez addSubview:buttonz];
    
   
    
    
    ///腾讯微博 Login_TCWeibo
    UIImageView * bgimagex = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35+45, 320, 44)];
    bgimagex.backgroundColor = [UIColor clearColor];
    bgimagex.userInteractionEnabled = YES;
    // bgimagex.image = [[UIImage imageNamed:@"SZT-X-960.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:2];
    bgimagex.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:bgimagex];
    [bgimagex release];
    
    UIImageView * heaimagex =  [[UIImageView alloc] initWithFrame:CGRectMake(20, (44-21)/2, 21, 21)];
    heaimagex.backgroundColor = [UIColor clearColor];
    heaimagex.image = UIImageGetImageFromName(@"share_TCWeibo_1.png");
    [bgimagex addSubview:heaimagex];
    [heaimagex release];
    
    UILabel * textLabelx = [[UILabel alloc] initWithFrame:CGRectMake(50, 7, 200, 30)];
    textLabelx.textAlignment = NSTextAlignmentLeft;
    textLabelx.backgroundColor = [UIColor clearColor];
    textLabelx.textColor = [UIColor blackColor];
    textLabelx.font = [UIFont systemFontOfSize:16];
    textLabelx.text = @"腾讯微博";
    [bgimagex addSubview:textLabelx];
    [textLabelx release];
    
    
    UIView *xianView2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 44.5, 320, 0.5)] autorelease];
    xianView2.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
    [bgimagex addSubview:xianView2];
    
    
    typeLabelx = [[UILabel alloc] initWithFrame:CGRectMake(300-19-80-15-40, 7, 120, 30)];
    typeLabelx.textAlignment = NSTextAlignmentRight;
    typeLabelx.backgroundColor = [UIColor clearColor];
    typeLabelx.textColor = [UIColor lightGrayColor];
    typeLabelx.font =  [UIFont systemFontOfSize:16];
    typeLabelx.text = @"未绑定";
    [bgimagex addSubview:typeLabelx];
    [typeLabelx release];
    
    
    // 箭头JTD960
    UIImageView * hou1x = [[UIImageView alloc] initWithFrame:CGRectMake(300-19, (44-14)/2, 9, 14)];
    hou1x.image = UIImageGetImageFromName(@"jiantou_1.png");
    [bgimagex addSubview:hou1x];
    [hou1x release];
    
    UIButton * buttonx = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonx.frame = bgimagex.bounds;
    [buttonx addTarget:self action:@selector(pressTXWeiboButton:) forControlEvents:UIControlEventTouchUpInside];
    [bgimagex addSubview:buttonx];
    
    
    [self statusRequest];
    
}

- (void)cpUIAlertViewFunc:(NSInteger)type{


    CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"解除绑定？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = type;
    [alert show];
    [alert release];
    
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1 || alertView.tag == 2 || alertView.tag == 3) {
        if (buttonIndex == 1) {
            
            
            [self deleteUnionWithType:alertView.tag];
            }
    }

}

//新浪
- (void)pressSinaButton:(UIButton *)sender{
    typeSorce = 1;
    if (![typeLabels.text isEqualToString:@"未绑定"]) {
        [self cpUIAlertViewFunc:1];
    }else{
        [MobClick event:@"event_wodecaipiao_fenxiang_xinlang_bangding"];
        SinaBindViewController *sina = [[SinaBindViewController alloc] init];
        sina.sinaURL =[NetURL CBBangDing:@"1"];
        NSLog(@"%@",sina.sinaURL);
        sina.title = @"新浪绑定";
        sina.isBangDing = YES;
        sina.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:sina animated:YES];
        [sina release];
    
    }
}

// 微信
- (void)pressWeiXinButton:(UIButton *)sender{
    typeSorce = 4;
    if (![typeLabelw.text isEqualToString:@"未绑定"]) {
        [self cpUIAlertViewFunc:1];
    }else{
    
        SinaBindViewController *sina = [[SinaBindViewController alloc] init];
        sina.sinaURL =[NetURL CBBangDing:@"1"];
        NSLog(@"%@",sina.sinaURL);
        sina.title = @"新浪绑定";
        sina.isBangDing = YES;
        sina.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:sina animated:YES];
        [sina release];
        
    }
}


//qq空间
- (void)pressQQButton:(UIButton*)sender{
    typeSorce = 3;
    if (![typeLabelz.text isEqualToString:@"未绑定"]) {
        [self cpUIAlertViewFunc:3];
    }else{
        SinaBindViewController *sina = [[SinaBindViewController alloc] init];
        sina.sinaURL =[NetURL CBBangDing:@"3"];
        NSLog(@"%@",sina.sinaURL);
        sina.title = @"QQ空间绑定";
        sina.isBangDing = YES;
        sina.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:sina animated:YES];
        [sina release];
        
    }
}

//腾讯微博
- (void)pressTXWeiboButton:(UIButton *)sender{
    typeSorce = 2;
    if (![typeLabelx.text isEqualToString:@"未绑定"]) {
        [self cpUIAlertViewFunc:2];
    }else{
        [MobClick event:@"event_wodecaipiao_fenxiang_tengxun_bangding"];
        SinaBindViewController *sina = [[SinaBindViewController alloc] init];
        sina.sinaURL =[NetURL CBBangDing:@"2"];
        NSLog(@"%@",sina.sinaURL);
        sina.title = @"腾讯微博绑定";
        sina.isBangDing = YES;
        sina.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:sina animated:YES];
        [sina release];
        
    }
}

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
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