//
//  GC_ ExplainViewController.m
//  caibo
//
//  Created by  on 12-5-17.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GC_ExplainViewController.h"
#import "Info.h"

@implementation GC_ExplainViewController

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

- (void)doBack {
	[self.navigationController popViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	UIBarButtonItem *left =	[Info backItemTarget:self action:@selector(doBack)];
	self.navigationItem.leftBarButtonItem = left;	
	
    for (int i = 0; i < 12; i++) {
        for (int j = 0; j < 9; j++) {
            UIImageView * textbg = [[UIImageView alloc] initWithFrame:CGRectMake(j*40, i*40, 40, 40)];
            textbg.image = UIImageGetImageFromName(@"gc_wenli.png") ;
            textbg.backgroundColor = [UIColor clearColor];
            [self.view addSubview:textbg];
            [textbg release];
        }
    }
    self.title = @"玩法";
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, 310, 400)];
    textView.userInteractionEnabled = NO;
    textView.userInteractionEnabled = NO;
    textView.font = [UIFont boldSystemFontOfSize:16]; 
    textView.text = @"       选定1场比赛,对主队在全场90分钟(含伤停补时)的“胜”、“平”、“负”结果进行投注。竞彩胜平负时用3、1、0分别代表主队胜、主客战平和主队负。\n       当两只球队实力悬殊较大时,采取让球的方式确定双方胜平负关系.让球的数量确定后将维持不变。";
    textView.backgroundColor = [UIColor clearColor];
    textView.textColor = [UIColor blackColor];
    [self.view addSubview:textView];
    
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