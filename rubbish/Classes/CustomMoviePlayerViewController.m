//
//  SearchInfo.m
//  LeTV.com
//
//  Created by QQ on 10-9-4.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CustomMoviePlayerViewController.h"
#import "Info.h"
#import "caiboAppDelegate.h"
#import "MobClick.h"

@implementation CustomMoviePlayerViewController
//@synthesize mp;
@synthesize content;

- (id)initWithPath:(NSString *)movieurl
{
	// Initialize and create movie URL
	if (self = [super init])
	{
		//
		//movieurl = @"http://t.live.cntv.cn/m3u8/cctv-news.m3u8";
		movieURL = [NSURL URLWithString:movieurl];    
		[movieURL retain];
		isFull = NO;
		canChange= NO;
        self.wantsFullScreenLayout = NO;
		//[self.navigationController setNavigationBarHidden:NO];
	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
//        NSLog(@"h =%f,y =%f",caiboappdelegate.window.frame.size.height,caiboappdelegate.window.frame.origin.y);
//        caiboappdelegate.window.frame =  CGRectMake(0,0,caiboappdelegate.window.frame.size.width,caiboappdelegate.window.frame.size.height -20);
//    }
    [self.navigationController setNavigationBarHidden:NO];
    CGFloat ios7Pianyi = 0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        ios7Pianyi = 40;
    }
    
#ifdef isCaiPiaoForIPad

		mpbackView.frame = CGRectMake(0 + 35, 50, 320, 243);
		infoLable.frame = CGRectMake(10 +35, 0, 300, 50);
            BackimageView.frame = CGRectMake(0, 0, 390, 748);
		introBack.frame = CGRectMake(10 +35, 305, 300, 95);
		introLable.frame = CGRectMake(15 + 35, 310, 290, 73);
#else
     UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown ) {
		mpbackView.frame = CGRectMake(0 , 50 + ios7Pianyi, 320, 243);
		infoLable.frame = CGRectMake(10, 0 + ios7Pianyi, 300, 50);
        if (IS_IPHONE_5) {
            BackimageView.frame = CGRectMake(0, 0 + ios7Pianyi, 320,568);
        }
        else {
            BackimageView.frame = CGRectMake(0, 0 + ios7Pianyi, 320, 480);
        }
		
		introBack.frame = CGRectMake(10, 305 + ios7Pianyi, 300, 95);
		introLable.frame = CGRectMake(15, 310 + ios7Pianyi, 290, 73);
	}
	else {
		mpbackView.frame = CGRectMake(5, 10 + ios7Pianyi, 320, 243);
		infoLable.frame = CGRectMake(330, 10 + ios7Pianyi, 150, 75);
		if (IS_IPHONE_5) {
            BackimageView.frame = CGRectMake(0, 0 + ios7Pianyi * 0.8, 568, 320);
        }
        else {
            BackimageView.frame = CGRectMake(0, 0 + ios7Pianyi * 0.8, 480, 320);
        }
		introBack.frame = CGRectMake(330, 95 + ios7Pianyi, 145, 160);
		introLable.frame = CGRectMake(340, 100 + ios7Pianyi, 125, 150);
		NSLog(@"222");
	}
#endif

}


- (void)playBtn {
    [MobClick event:@"ecent_saishizhibo_bofang"];
	self.moviePlayer.contentURL = movieURL;
    loadingImage.hidden = YES;
	[self.moviePlayer prepareToPlay];
	
	[self.moviePlayer play];
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
    NSString * diyistr = [devicestr substringToIndex:1];
    if ([diyistr intValue] >= 5) {
        [self.navigationController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"SDH960.png") forBarMetrics:UIBarMetricsDefault];
    }
	self.title = @"八方视频";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
#ifdef isCaiPiaoForIPad
    self.view.frame = CGRectMake(0, 0, 390, 748);
#endif
	UIView *v = [[UIView alloc] initWithFrame:self.view.bounds];
	self.view = v;
	BackimageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
	[v addSubview:BackimageView];
    
	BackimageView.image = UIImageGetImageFromName(@"login_bgn.png");
	[BackimageView release];
	[v release];
	UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
	self.navigationItem.leftBarButtonItem = left;
	
	self.view.backgroundColor = [UIColor clearColor];
	infoLable = [[UILabel alloc] init];
	infoLable.frame = CGRectMake(10, 0, 300, 50);
	infoLable.text = content;
    infoLable.font = [UIFont systemFontOfSize:15];
	infoLable.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
	infoLable.backgroundColor = [UIColor clearColor];
	infoLable.numberOfLines = 0;
	infoLable.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:infoLable];
	[infoLable release];
		
	introLable = [[UILabel alloc] init];
	introLable.frame = CGRectMake(15, 310, 290, 73);
	introLable.text = content;
    introLable.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
	introLable.font = [UIFont systemFontOfSize:10];
	introLable.text = @"八方视频 十分精彩！中国足彩网以其特有的足球篮球比赛视频直播为基础，为广大球迷提供当期最精彩的足球篮球赛事，把握欧陆体坛风云，点亮赛场直击精华，一切精彩就在中国足彩网八方视频直播。";
	introLable.backgroundColor = [UIColor clearColor];
	introLable.numberOfLines = 0;
//	introLable.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:introLable];
	[introLable release];
	
	
	mpbackView = [[UIView alloc] init];
	mpbackView.frame = CGRectMake(0, 50, 320, 243);
	[self.view addSubview:mpbackView];
//	self.moviePlayer =  [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
	
	//[self.moviePlayer.view removeFromSuperview];
	[self.moviePlayer setControlStyle:MPMovieControlStyleEmbedded];
    self.moviePlayer.shouldAutoplay = YES;
//	[self.moviePlayer setBackgroundColor:[UIColor blackColor]];
	[self.moviePlayer setFullscreen:NO animated:YES];
	self.moviePlayer.view.frame = CGRectMake(0, 0, 320, 240);

	mpbackView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:mpbackView];
	[mpbackView addSubview:self.moviePlayer.view];
	self.moviePlayer.backgroundView.backgroundColor = [UIColor blackColor];
	loadingImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 245)];
	[mpbackView addSubview:loadingImage];
	loadingImage.image = UIImageGetImageFromName(@"BFSP_80.png");
	loadingImage.userInteractionEnabled = YES;
    loadingImage.backgroundColor = [UIColor clearColor];

	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[loadingImage addSubview:btn];
	[btn setImage:UIImageGetImageFromName(@"BFSP_91.png") forState:UIControlStateNormal];
	btn.frame = CGRectMake(68, 0, 68, 68);
	btn.center = CGPointMake(loadingImage.frame.size.width/2, loadingImage.frame.size.height/2);
	[btn addTarget:self action:@selector(playBtn) forControlEvents:UIControlEventTouchUpInside];
	[loadingImage release];
	
    UIInterfaceOrientation toInterfaceOrientation =self.interfaceOrientation;
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ) {
		mpbackView.frame = CGRectMake(0, 50, 320, 243);
		infoLable.frame = CGRectMake(10, 0, 300, 50);
		BackimageView.frame = self.view.bounds;
		introBack.frame = CGRectMake(10, 305, 300, 95);
		introLable.frame = CGRectMake(15, 310, 290, 73);
        //		NSLog(@"111");
        //		infoLable.frame = CGRectMake(10, 50, 300, 50);
        
	}
	else {
		mpbackView.frame = CGRectMake(5, 10, 320, 243);
		infoLable.frame = CGRectMake(330, 10, 150, 75);
		BackimageView.frame = CGRectMake(0, 0, 480, 320);
		introBack.frame = CGRectMake(330, 95, 145, 160);
		introLable.frame = CGRectMake(340, 100, 125, 150);
		NSLog(@"222");
	}
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(moviePlayBackDidFinish:) 
												 name:MPMoviePlayerPlaybackDidFinishNotification 
											   object:self.moviePlayer];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(LoadStateDidChangeNotification:) 
												 name:MPMoviePlayerLoadStateDidChangeNotification 
											   object:self.moviePlayer];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(WillExitFullscreenNotification:) 
												 name:MPMoviePlayerWillExitFullscreenNotification 
											   object:self.moviePlayer];
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(WillEnterFullscreenNotification:) 
												 name:MPMoviePlayerWillEnterFullscreenNotification 
											   object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(DidEnterFullscreenNotification:)
												 name:MPMoviePlayerDidExitFullscreenNotification
											   object:self.moviePlayer];
}

- (void)DidEnterFullscreenNotification:(NSNotification*)notification {
#ifdef isCaiPiaoForIPad
    [caiboAppDelegate getAppDelegate].window.rootViewController.view.frame = CGRectMake(0, 63, 748, 390);
#endif
}

- (void)WillEnterFullscreenNotification:(NSNotification*)notification {
	isFull = YES;
	
	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
		UITouch *touch = [touches anyObject];
		
		NSTimeInterval delaytime = 0.4;//自己根据需要调整
		
		switch (touch.tapCount) {
			case 1:
				[self performSelector:@selector(singleTap) withObject:nil afterDelay:delaytime];
				break;
			case 2:{
				[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTap) object:self.moviePlayer];
				[self performSelector:@selector(doubleTap)];
				//[self doubleTap];
			}
				break;
			default:
				break;
		}
	}

- (void)WillExitFullscreenNotification:(NSNotification*)notification {
	isFull = NO;

	[self.moviePlayer play];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
#ifdef isHaoLeCai
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
#else
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
#endif
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO];

}

- (void)setFull {

	[self.moviePlayer setFullscreen:YES animated:YES];
}

- (void)setnotFull {
	[self.moviePlayer setFullscreen:NO animated:YES];
	canChange = YES;
	canChange = NO;
#ifdef isCaiPiaoForIPad
    [caiboAppDelegate getAppDelegate].window.rootViewController.view.frame = CGRectMake(0, 63, 748, 390);
#endif

}

- (void)LoadStateDidChangeNotification:(NSNotification*)notification {
	if ([self.moviePlayer loadState] != MPMovieLoadStateUnknown) {
	}
	else {
	}
#ifdef isCaiPiaoForIPad
    [caiboAppDelegate getAppDelegate].window.rootViewController.view.frame = CGRectMake(0, 63, 748, 390);
#endif
	
	NSLog(@"%@",notification);
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
	NSLog(@"moviePlayBackDidFinish %@",[notification userInfo]);
    if ([[[notification userInfo] objectForKey:@"MPMoviePlayerPlaybackDidFinishReasonUserInfoKey"] intValue] == 2||notification == nil) {
		[[NSNotificationCenter defaultCenter] 
		 removeObserver:self
		 name:MPMoviePlayerPlaybackDidFinishNotification
		 object:self.moviePlayer];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7) {
            		[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        }

        [self.navigationController setNavigationBarHidden:YES];
#ifdef isCaiPiaoForIPad
        
        [self.navigationController popViewControllerAnimated:NO];
        [caiboAppDelegate getAppDelegate].window.rootViewController.view.frame = CGRectMake(0, 63, 748, 390);
#else
        UIImage *image = UIImageGetImageFromName(@"NavBackImage.png");
        if (image) {
            NSString * devicestr = [[UIDevice currentDevice] systemVersion];
            NSString * diyistr = [devicestr substringToIndex:1];
            if ([diyistr floatValue] >= 5) {
                
                [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
            }
        }
        
#endif
		
	}
	else if ([[[notification userInfo] objectForKey:@"MPMoviePlayerPlaybackDidFinishReasonUserInfoKey"] intValue] == 0) {
		naView.hidden = NO;
		[self.moviePlayer setContentURL:movieURL];
		[self.moviePlayer prepareToPlay];
		[self.moviePlayer play];
		NSLog(@"缓冲");
	}

	
}

- (void)doBack {
	[self moviePlayBackDidFinish:nil];
    [self.navigationController setNavigationBarHidden:YES];
    UIImage *image = UIImageGetImageFromName(@"NavBackImage.png");
    if (image && [[[UIDevice currentDevice] systemVersion] floatValue] >= 5) {
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        
//        caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
//        NSLog(@"h =%f,y =%f",caiboappdelegate.window.frame.size.height,caiboappdelegate.window.frame.origin.y);
//        caiboappdelegate.window.frame =  CGRectMake(0,20,caiboappdelegate.window.frame.size.width,caiboappdelegate.window.frame.size.height);
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
#ifdef isHaoLeCai
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
#else
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
#endif
    }
    [self.navigationController popViewControllerAnimated:YES];
#ifdef isCaiPiaoForIPad
    [caiboAppDelegate getAppDelegate].window.rootViewController.view.frame = CGRectMake(0, 63, 748, 390);
#endif
}

- (void)singleTap {
}

- (void)doubleTap {
	if (!isFull) {
		[self setFull];

	}
	else {
		[self setnotFull];
	}
}

#pragma mark interfaceOrientation

-(NSUInteger)supportedInterfaceOrientations{
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        return (1 << UIInterfaceOrientationPortrait);
//    }
    
    return ((1 << UIInterfaceOrientationPortrait) | (1 << UIInterfaceOrientationLandscapeLeft) | (1 << UIInterfaceOrientationLandscapeRight) | (1 << UIInterfaceOrientationPortraitUpsideDown));
    
}

- (BOOL)shouldAutorotate {
    return YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    // Overriden to allow any orientation.
	return YES;
//	if (isFull) {
//		return YES;
//	}
//	return canChange;
	return !UIDeviceOrientationIsLandscape(toInterfaceOrientation);  
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
    CGFloat ios7Pianyi = 0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        ios7Pianyi = 40;
    }
    
	if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ) {
		mpbackView.frame = CGRectMake(0 , 50 + ios7Pianyi, 320, 243);
		infoLable.frame = CGRectMake(10, 0 + ios7Pianyi, 300, 50);
        if (IS_IPHONE_5) {
            BackimageView.frame = CGRectMake(0, 0 + ios7Pianyi, 320,568);
        }
        else {
            BackimageView.frame = CGRectMake(0, 0 + ios7Pianyi, 320, 480);
        }
		
		introBack.frame = CGRectMake(10, 305 + ios7Pianyi, 300, 95);
		introLable.frame = CGRectMake(15, 310 + ios7Pianyi, 290, 73);
	}
	else {
		mpbackView.frame = CGRectMake(5, 10 + ios7Pianyi, 320, 243);
		infoLable.frame = CGRectMake(330, 10 + ios7Pianyi, 150, 75);
		if (IS_IPHONE_5) {
            BackimageView.frame = CGRectMake(0, 0 + ios7Pianyi * 0.8, 568, 320);
        }
        else {
            BackimageView.frame = CGRectMake(0, 0 + ios7Pianyi * 0.8, 480, 320);
        }
		introBack.frame = CGRectMake(330, 95 + ios7Pianyi, 145, 160);
		introLable.frame = CGRectMake(340, 100 + ios7Pianyi, 125, 150);
		NSLog(@"222");
	}
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	self.content = nil;
	[movieURL release];
	[self.moviePlayer stop];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerWillEnterFullscreenNotification object:self.moviePlayer];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerWillExitFullscreenNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerDidExitFullscreenNotification object:self.moviePlayer];
    
	

    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    