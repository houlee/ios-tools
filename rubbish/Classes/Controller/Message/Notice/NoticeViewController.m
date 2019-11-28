//
//  NoticeViewController.m
//  caibo
//
//  Created by jacob on 11-7-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NoticeViewController.h"
#import "MailList.h"

#import "Info.h"

#import "ProgressBar.h"

#import "ASIHTTPRequest.h"

#import "Result.h"

#import "NetURL.h"

#import "Info.h"

#import "ProfileViewController.h"

#import "MyWebViewController.h"
#import "PreJiaoDianTabBarController.h"
#import "CP_LieBiaoView.h"
#import "ShuangSeQiuInfoViewController.h"
#import "DetailedViewController.h"

@implementation NoticeViewController

@synthesize mlist;

@synthesize textView;

@synthesize request;

@synthesize nickName;

@synthesize colorLabel;
-(id)initWithNoticeMessage:(MailList*)list{
	
	if (self =[super init]) {
		
		self.mlist = list;
        [self handleNickName:list.content];
		
	}

	return self;	
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/
- (void)handleNickName:(NSString *)content
{
    
    NSInteger length = (NSInteger)[content length];
    NSInteger location = 0;
    
    NSRange range =NSMakeRange(location, length);
    
    NSInteger finder = (NSInteger)[content rangeOfString:@"@" options:NSLiteralSearch range:range].location;
    if (finder != NSNotFound) {
        
        length = length - finder;
    }
	else {
		finder = (int)[content rangeOfString:@"'>" options:NSLiteralSearch range:range].location;;
		NSRange againRange = NSMakeRange(0, length);
		
		NSInteger againFinder = [content rangeOfString:@"</a>" options:NSLiteralSearch range:againRange].location;
		
		if (againFinder != NSNotFound) {
			length = againFinder - finder;
			NSRange againFinderRange = NSMakeRange(finder + 2, length-2);
			self.nickName = [content substringWithRange:againFinderRange];
			NSLog(@"self.nickName = %@",self.nickName);
		}
		return;
	}

    
    NSRange againRange = NSMakeRange(finder, length);
    
    NSInteger againFinder = [content rangeOfString:@"<" options:NSLiteralSearch range:againRange].location;
    
    if (againFinder != NSNotFound) {
        length = againFinder - finder;
        NSRange againFinderRange = NSMakeRange(finder + 1, length -1);
        self.nickName = [content substringWithRange:againFinderRange];
        NSLog(@"self.nickName = %@",self.nickName);
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
#ifdef isCaiPiaoForIPad
    self.view.backgroundColor = [UIColor clearColor];
    textView.backgroundColor = [UIColor clearColor];
#endif
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.userInteractionEnabled = YES;
//    backImage.backgroundColor = [UIColor clearColor];
    backImage.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
	//tableView.backgroundView = backImage;
    [self.mainView addSubview:backImage];
    [backImage release];
    

	
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(backAction)];

	// 添加 右边 发送 写微博 按钮
	
//	UIImage *image = UIImageGetImageFromName(@"wb_fin.png");
//	UIButton *rlesebutton = [UIButton buttonWithType:UIButtonTypeCustom];
//	rlesebutton.bounds = CGRectMake(0, 0,image.size.width/2, image.size.height/2);
//	[rlesebutton setBackgroundImage:image forState:UIControlStateNormal];
//	[rlesebutton setTitle:@"删除" forState:UIControlStateNormal];
//	rlesebutton.titleLabel.font = [UIFont systemFontOfSize:14];
//	[rlesebutton addTarget:self action:@selector(deleteMessage) forControlEvents:UIControlEventTouchUpInside];
//	
//	UIBarButtonItem *sendbutton = [[UIBarButtonItem alloc] initWithCustomView:rlesebutton];
//	self.CP_navigation.rightBarButtonItem = sendbutton;
//	[sendbutton release];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBounds:CGRectMake(0, 0, 70, 40)];
    UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
    imagevi.backgroundColor = [UIColor clearColor];
//    imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    [btn addSubview:imagevi];
    [imagevi release];
    
    UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
    lilable.textColor = [UIColor whiteColor];
    lilable.backgroundColor = [UIColor clearColor];
    lilable.textAlignment = NSTextAlignmentCenter;
//    lilable.font = [UIFont boldSystemFontOfSize:13];
    lilable.font = [UIFont boldSystemFontOfSize:15];
//    lilable.shadowColor = [UIColor blackColor];//阴影
//    lilable.shadowOffset = CGSizeMake(0, 1.0);
    lilable.text = @"删除";
    [btn addSubview:lilable];
    [lilable release];
    [btn addTarget:self action:@selector(deleteMessage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.CP_navigation.rightBarButtonItem = barBtnItem;
    [barBtnItem release];

	
	self.CP_navigation.title =@"通知";
//	self.textView.text = mlist.mcontent;
     ColorLabel *mLabel = [[ColorLabel alloc] initWithText:mlist.content];
//    mLabel.scrollView.showsVerticalScrollIndicator = NO;
//    mLabel.scrollView.exclusiveTouch = NO;
   
#ifdef isCaiPiaoForIPad
    backImage.frame=  CGRectMake(0, 0, 768, 1024);
    [mLabel setMaxWidth:390];
#else
     [mLabel setMaxWidth:320];
#endif
    [self.mainView addSubview:mLabel];
    self.colorLabel = mLabel;
	self.colorLabel.colorLabeldelegate = self;
    [mLabel release];
    
    UIButton *tmpButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 45)];
    [tmpButton addTarget:self action:@selector(goToUserInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:tmpButton];
     [tmpButton release];
    
//    [self loadNewView];
    
}
-(void)loadNewView
{
    UIImageView *headIma=[[UIImageView alloc]init];
    headIma.backgroundColor=[UIColor clearColor];
    headIma.image=[UIImage imageNamed:@"zhongjiang1.png"];
    headIma.frame=CGRectMake(0, 0, 320, 127);
    [self.mainView addSubview:headIma];
    [headIma release];
    
    UIImageView *babyIma=[[UIImageView alloc]init];
    babyIma.backgroundColor=[UIColor clearColor];
    babyIma.image=[UIImage imageNamed:@"zhongjiang3.png"];
    babyIma.frame=CGRectMake(30, 127+50, 115, 202);
    [self.mainView addSubview:babyIma];
    [babyIma release];
    
    UIImageView *contentIma=[[UIImageView alloc]init];
    contentIma.backgroundColor=[UIColor clearColor];
    contentIma.image=[UIImage imageNamed:@"zhongjiang2.png"];
    contentIma.frame=CGRectMake(140, 127, 170, 170);
    [self.mainView addSubview:contentIma];
    [contentIma release];
    
    UILabel *contentLab=[[UILabel alloc]init];
    contentLab.backgroundColor=[UIColor clearColor];
    contentLab.frame=CGRectMake(15, 35, 140, 100);
    contentLab.text=mlist.content;
    contentLab.numberOfLines=0;
    contentLab.font=[UIFont systemFontOfSize:15];
    contentLab.textColor=[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [contentIma addSubview:contentLab];
    [contentLab release];
}
- (void)clikeOrderIdURL:(NSURLRequest *)request1 {
    if ([[NSString stringWithFormat:@"%@",[request1 URL]] hasPrefix:@"http://caipiao365.com"]) {
        NSString *topic = [[NSString stringWithFormat:@"%@",[request1 URL]] stringByReplacingOccurrencesOfString:@"http://caipiao365.com/" withString:@""];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSArray *array = [topic componentsSeparatedByString:@"&"];
        for (int i = 0; i < [array count]; i ++) {
            NSString *st = [array objectAtIndex:i];
            NSArray *array2 = [st componentsSeparatedByString:@"="];
            if ([array2 count] >= 2) {
                [dic setValue:[array2 objectAtIndex:1] forKey:[array2 objectAtIndex:0]];
            }
        }
        if ([dic objectForKey:@"wbxq"]) {
            [request clearDelegatesAndCancel];
            [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:[dic objectForKey:@"wbxq"]]]];
            [request setDefaultResponseEncoding:NSUTF8StringEncoding];
            [request setDelegate:self];
            [request setTimeOutSeconds:20.0];
            [request startAsynchronous];
            return;
        }
        else if ([[dic objectForKey:@"faxq"] length]) {
            ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
            info.orderId = [dic objectForKey:@"faxq"];
            UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
            [NV setNavigationBarHidden:NO];
            [info.navigationController setNavigationBarHidden:NO];
            if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
                PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
                NSLog(@"%@",VC);
                
                [VC.selectedViewController.navigationController pushViewController:info animated:YES];
            }
            else {
                [NV pushViewController:info animated:YES];
            }
            
            [info release];
            return;
        }
        
    }
	MyWebViewController *my = [[MyWebViewController alloc] init];
	[my LoadRequst:request1];
	[my setHidesBottomBarWhenPushed:YES];
    UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
    if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
        PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
        NSLog(@"%@",VC);
        
        [VC.selectedViewController.navigationController pushViewController:my animated:YES];
        if (VC.selectedIndex == 0) {
            [my.navigationController setNavigationBarHidden:NO];
        }
    }
    else {
        [NV pushViewController:my animated:YES];
    }
	[my release];
}

- (void)requestFinished:(ASIHTTPRequest *)request1 {
    NSString *result = [request1 responseString];
    YtTopic *mStatus2 = [[YtTopic alloc] initWithParse:result];
    
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus2 arrayList] objectAtIndex:0]];
    UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
    if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
        PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
        NSLog(@"%@",VC);
        
        [VC.selectedViewController.navigationController pushViewController:detailed animated:YES];
    }
    else {
        [NV pushViewController:detailed animated:YES];
    }
    [detailed setHidesBottomBarWhenPushed:YES];
    [detailed release];
    
    [mStatus2 release];
}

- (void)goToUserInfo:(id)sender
{
//     [[Info getInstance] setNickName:self.nickName];
//
//    ProfileViewController *controller = [[[ProfileViewController alloc] init]autorelease];
//    [controller setHidesBottomBarWhenPushed:YES];
//    
//    [self.navigationController pushViewController:controller animated:YES];
	if ([self.nickName length]) {
		[[Info getInstance] setHimId:nil];
		ProfileViewController *followeesController = [[ProfileViewController alloc] init];
		[followeesController setHimNickName:self.nickName];
		[self.navigationController pushViewController:followeesController animated:YES];
		[followeesController release];
	}

}
-(void)backAction
{	
	[self.navigationController popViewControllerAnimated:YES];	
}

-(void)deleteMessage{
	
//	UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择需要的操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除",nil];
//	
//	[sheet showInView:self.mainView.superview];
//	
//	[sheet release];
    CP_LieBiaoView *lb = [[CP_LieBiaoView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    lb.delegate = self;
    lb.tag = 104;
    [lb LoadButtonName:[NSArray arrayWithObjects:@"删除",nil]];
    [lb show];
    [lb release];

}


- (void)CP_liebiao:(CP_LieBiaoView *)liebiaoView didDismissWithButtonIndex:(NSInteger)buttonIndex {

    if (liebiaoView.tag == 104) {
        if (buttonIndex == 0) {
            [[ProgressBar getProgressBar] show:@"正在删除数据..." view:self.colorLabel];
            
            [ProgressBar getProgressBar].mDelegate = self;
            
            [request clearDelegatesAndCancel];
            
            [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBdelUsersMailById:self.mlist.ytMailId userId:[[Info getInstance]userId]]]];
            [request setDefaultResponseEncoding:NSUTF8StringEncoding];
            [request setDelegate:self];
            [request setDidFinishSelector:@selector(delUsersMailListBack:)];
            [request setNumberOfTimesToRetryOnTimeout:2];
            [request startAsynchronous];// 异步获取

        }
    }
}
#pragma mark  UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
 
	if(buttonIndex!=[actionSheet cancelButtonIndex]){
		
				
		[[ProgressBar getProgressBar] show:@"正在删除数据..." view:self.colorLabel];
		
		[ProgressBar getProgressBar].mDelegate = self;
		
		[request clearDelegatesAndCancel];
        
		[self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBdelUsersMailById:self.mlist.ytMailId userId:[[Info getInstance]userId]]]];
		[request setDefaultResponseEncoding:NSUTF8StringEncoding];
		[request setDelegate:self];
		[request setDidFinishSelector:@selector(delUsersMailListBack:)];
		[request setNumberOfTimesToRetryOnTimeout:2];
		[request startAsynchronous];// 异步获取
		
	
	}

}


- (void)prograssBarBtnDeleate:(NSInteger) type{

    [[ProgressBar getProgressBar]dismiss];
	
	[request clearDelegatesAndCancel];
	
}

// 接收服务器返回删除私信记录结果
-(void)delUsersMailListBack:(ASIHTTPRequest*)mrequest{
	NSString *responseString = [mrequest responseString];
	if (responseString) {
		Result *result = [[Result alloc] initWithParse:responseString];
		if ([result.result isEqualToString:@"succ"]) {
			[[ProgressBar getProgressBar] dismiss];
			[self.navigationController popViewControllerAnimated:YES];
		} else {
			[[ProgressBar getProgressBar] setTitle:@"删除失败"];
			[self performSelector:@selector(dismissProgressBar) withObject:nil afterDelay:1.0];
		}
		[result release];
	}
}


// 关闭ProgressBar
-(void)dismissProgressBar{
    [[ProgressBar getProgressBar] dismiss];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.nickName = nil;
	self.mlist =nil;
	self.textView =nil;
	self.request =nil;
    self.colorLabel = nil;
}


- (void)dealloc {
	[colorLabel release];
    [nickName release];
	[request clearDelegatesAndCancel];
	[request release];
	[textView release];
	[mlist release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    