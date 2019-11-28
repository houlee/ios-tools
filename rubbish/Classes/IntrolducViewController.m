    //
//  IntrolducViewController.m
//  caibo
//
//  Created by yao on 11-12-7.
//  Copyright 2011 第一视频. All rights reserved.
//

#import "IntrolducViewController.h"
#import "Info.h"
#import "QuartzCore/QuartzCore.h"

@implementation IntrolducViewController

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//self.navigationController.title = @"功能介绍与评分";
	self.title = @"功能介绍";
	UIImageView *contentView = [[UIImageView alloc] initWithFrame: CGRectMake(10.0, 10.0, 300.0, 350.0)];
	[contentView setUserInteractionEnabled: NO];
	[self.view addSubview: contentView];
	contentView.layer.masksToBounds = YES;
	contentView.layer.cornerRadius = 5.0;
	contentView.layer.borderWidth = 1.2;
	contentView.layer.borderColor = [[UIColor grayColor] CGColor];
	[contentView release];
	self.view.backgroundColor = [UIColor whiteColor];
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	[self.navigationItem setLeftBarButtonItem:leftItem];
	
	infoTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 305, 340)];
	[self.view addSubview:infoTextView];
	infoTextView.backgroundColor = [UIColor clearColor];
	infoTextView.text = @"开奖：数字彩与足彩开奖信息，微博模式更快捷，比全国其他网站快5-10分钟。\n\n比分：与足球竞猜赛程同步，免费进球提醒，还有实时盘口赔率和最新赛事动态。\n\n过关：国内首款“过关统计”免费提醒手机客户端，随时随地获知过关详情。 \n\n提醒：小秘书提醒，免费定制比分直播，过关统计，最新开奖和中奖提醒等服务。 \n\n推荐：每天为您倾情奉献数字彩和足彩专家的预测推荐，助您中大奖！\n\n彩讯：最新鲜的体育彩票、福利彩票新闻资讯和彩票花絮。";
	infoTextView.font = [UIFont systemFontOfSize:16];
	
		
	//infoTextView.backgroundColor = [UIColor clearColor];
}


- (void)doBack {
	[self.navigationController popViewControllerAnimated:YES];
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
}


- (void)dealloc {
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    