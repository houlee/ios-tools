//
//  PKGameExplainViewController.m
//  caibo
//
//  Created by  on 12-4-18.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "PKGameExplainViewController.h"

@implementation PKGameExplainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.CP_navigation.title = @"活动说明";
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    ImageView.image = UIImageGetImageFromName(@"login_bgn.png");
    [self.mainView addSubview:ImageView];
    [ImageView release];
    
    UILabel *kjTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 250, 13)];
    kjTime.backgroundColor = [UIColor clearColor];
    kjTime.text = @"对应每期的足彩设立的模拟比赛。";
    kjTime.font = [UIFont boldSystemFontOfSize:13];
    [self.mainView addSubview:kjTime];
    [kjTime release];

    UILabel *jjfd = [[UILabel alloc] initWithFrame:CGRectMake(20, 63, 150, 11)];
    jjfd.backgroundColor = [UIColor clearColor];
    jjfd.text = @"1.每个方案上限512注。";
    jjfd.font = [UIFont boldSystemFontOfSize:11];
    jjfd.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
    [self.mainView addSubview:jjfd];
    [jjfd release];
    UILabel *jjf2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 85, 180, 11)];
    jjf2.backgroundColor = [UIColor clearColor];
    jjf2.text = @"2.每人每期只能投注一个方案。";
    jjf2.font = [UIFont boldSystemFontOfSize:11];
    jjf2.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
    [self.mainView addSubview:jjf2];
    [jjf2 release];
    UILabel *jjf3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 106, 150, 11)];
    jjf3.backgroundColor = [UIColor clearColor];
    jjf3.text = @"3.奖级设置：";
    jjf3.font = [UIFont boldSystemFontOfSize:11];
    jjf3.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
    [self.mainView addSubview:jjf3];
    [jjf3 release];
    
    UILabel *kjTime2 = [[UILabel alloc] initWithFrame:CGRectMake(25, 129, 300, 11)];
    kjTime2.backgroundColor = [UIColor clearColor];
    kjTime2.text = @"1)设一等奖奖池（中14场）为1000元，二等奖奖池（中";
    kjTime2.font = [UIFont systemFontOfSize:11];
    kjTime2.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [self.mainView addSubview:kjTime2];
    [kjTime2 release];
    
    UILabel *kjTime3 = [[UILabel alloc] initWithFrame:CGRectMake(25, 150, 270, 11)];
    kjTime3.backgroundColor = [UIColor clearColor];
    kjTime3.text = @"13场）为1000元。同一奖级中奖者均分奖池。";
    kjTime3.font = [UIFont systemFontOfSize:11];
    kjTime3.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [self.mainView addSubview:kjTime3];
    [kjTime3 release];
    
    UILabel *kjTime4 = [[UILabel alloc] initWithFrame:CGRectMake(25, 173, 280, 11)];
    kjTime4.backgroundColor = [UIColor clearColor];
    kjTime4.text = @"2)若该期无人中出14场或13场者，则对应奖金滚存进入下期一";
    kjTime4.font = [UIFont systemFontOfSize:10];
    kjTime4.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [self.mainView addSubview:kjTime4];
    [kjTime4 release];
    
    UILabel *kjTime5 = [[UILabel alloc] initWithFrame:CGRectMake(25, 196, 270, 11)];
    kjTime5.backgroundColor = [UIColor clearColor];
    kjTime5.text = @"等奖池。";
    kjTime5.font = [UIFont systemFontOfSize:11];
    kjTime5.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [self.mainView addSubview:kjTime5];
    [kjTime5 release];
    
    UILabel *kjTime6 = [[UILabel alloc] initWithFrame:CGRectMake(25, 217, 280, 11)];
    kjTime6.backgroundColor = [UIColor clearColor];
    kjTime6.text = @"3)单人获奖上限为2000元，若奖池仍有盈余则继续滚入";
    kjTime6.font = [UIFont systemFontOfSize:11];
    kjTime6.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [self.mainView addSubview:kjTime6];
    [kjTime6 release];
    
    UILabel *kjTime7 = [[UILabel alloc] initWithFrame:CGRectMake(25, 240, 270, 11)];
    kjTime7.backgroundColor = [UIColor clearColor];
    kjTime7.text = @"下期奖池。";
    kjTime7.font = [UIFont systemFontOfSize:11];
    kjTime7.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [self.mainView addSubview:kjTime7];
    [kjTime7 release];
    
    
    UILabel *kjTime9 = [[UILabel alloc] initWithFrame:CGRectMake(25, 263, 270, 11)];
    kjTime9.backgroundColor = [UIColor clearColor];
    kjTime9.text = @"4)奖金可在www.diyicai.com和www.zgzcw.com上使用";
    kjTime9.font = [UIFont systemFontOfSize:11];
    kjTime9.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
    [self.mainView addSubview:kjTime9];
    [kjTime9 release];




}

- (void)doBack{
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