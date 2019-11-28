    //
//  TongbuSetitngViewController.m
//  caibo
//
//  Created by yao on 12-3-13.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "TongbuSetitngViewController.h"
#import "Info.h"
#import "JSON.h"
#import "NetURL.h"


@implementation TongbuSetitngViewController

@synthesize mRequest;

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

- (void)goBackTo {
	[self.mRequest clearDelegatesAndCancel];
	self.mRequest = nil;
	self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBsetSysBlogForUnionUser:[[Info getInstance] userId] LoginSource:@"1" Status:[NSString stringWithFormat:@"%d",sinaBlind]]];
	[self.mRequest setDelegate:self ];
	[self.mRequest setDidFailSelector:@selector(SetFail:)];
	[self.mRequest setDidFinishSelector:@selector(SetFinish:)];
	[mRequest startAsynchronous];
	//[self.navigationController popViewControllerAnimated:YES];
}

- (void)doSave {
	[self.mRequest clearDelegatesAndCancel];
	self.mRequest = nil;
	self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBsetSysBlogForUnionUser:[[Info getInstance] userId] LoginSource:@"1" Status:[NSString stringWithFormat:@"%d",sinaBlind]]];
	[self.mRequest setDelegate:self ];
	[self.mRequest setDidFailSelector:@selector(SetFail:)];
	[self.mRequest setDidFinishSelector:@selector(SetFinish:)];
	[mRequest startAsynchronous];
}
- (void)SetFinish:(ASIHTTPRequest *)request {
	NSString *responseStr = [request responseString];
	NSDictionary *dic = [responseStr JSONValue];
	if ([[dic objectForKey:@"code"] intValue] == 0) {
		[self.navigationController popViewControllerAnimated:YES];
	}
	else {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//		[alert show];
//		[alert release];
		[self.navigationController popViewControllerAnimated:YES];
	}

	
}
- (void)SetFail:(ASIHTTPRequest *)request {
	[self.navigationController popViewControllerAnimated:YES];
	
}

- (void)recivedFail:(ASIHTTPRequest *)request {
	
}

- (void)recivedFinish:(ASIHTTPRequest *)request {
	NSString *responseStr = [request responseString];
	NSDictionary *dic = [responseStr JSONValue];
	sinaBlind = [[dic objectForKey:@"code"] boolValue];
	[myTableView reloadData];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(goBackTo)] ;
//	UIBarButtonItem *rightItem = [Info longItemInitWithTitle:@"保存" Target:self action:@selector(doSave)];
	self.navigationItem.leftBarButtonItem = leftItem;
//	self.navigationItem.rightBarButtonItem = rightItem;
	
	self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetSysBlogForUnionUser:[[Info getInstance] userId] LoginSource:@"1"]];
	[self.mRequest setDelegate:self ];
	[self.mRequest setDidFailSelector:@selector(recivedFail:)];
	[self.mRequest setDidFinishSelector:@selector(recivedFinish:)];
	[mRequest startAsynchronous];
	
	myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 400) style:UITableViewStyleGrouped];
	[self.view addSubview:myTableView];
	myTableView.delegate = self;
	myTableView.dataSource = self;
	[myTableView release];
	
	dataArray = [[NSMutableArray alloc] initWithObjects:@"新浪微博",nil];
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
	[mRequest clearDelegatesAndCancel];
	self.mRequest = nil;
	[dataArray release];
    [super dealloc];
}


- (void)changeTongbu:(UISwitch *)sw {
		sinaBlind=sw.on;
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
	for (UIView *v in cell.contentView.subviews) {
		[v removeFromSuperview];
	}
	cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
	cell.textLabel.backgroundColor = [UIColor clearColor];
	UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(200, 7, 60, 30)];
	[cell.contentView addSubview:sw];
	sw.tag = indexPath.row;
	sw.on = sinaBlind;
	[sw addTarget:self action:@selector(changeTongbu:) forControlEvents:UIControlEventValueChanged];
	[sw release];
	return cell;
}



#pragma mark -
#pragma mark Table view delegate


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    