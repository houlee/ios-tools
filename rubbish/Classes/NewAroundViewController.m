//
//  NewAroundViewController.m
//  caibo
//
//  Created by yao on 12-5-2.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "NewAroundViewController.h"
#import "LotteryPreferenceView.h"
#import "ZhanjiCell.h"
#import "FaceHistoryCell.h"
#import "NearRankCell.h"
#import "JSON.h"
#import "TopicThemeListViewController.h"
#import "Info.h"
#import "AsEuCell.h"
#import "tzPerCell.h"
#import "NetURL.h"
#import "MobClick.h"


@implementation NewAroundViewController

@synthesize tableView1;
@synthesize tableView2;
@synthesize tableView3;
@synthesize tableView4;
@synthesize rootScroll;
@synthesize homeLabel;
@synthesize visitLabel;
//@synthesize homeImageView;
//@synthesize visitImageView;
@synthesize refreshHeaderView2;
@synthesize refreshHeaderView3;
@synthesize dataDic;
@synthesize timeLabel;
@synthesize nameLabe;
@synthesize mrequest;
@synthesize playID;

#pragma mark -
#pragma mark Initialization


- (id)init{
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super init];
    if (self) {
        // Custom initialization.
    }
    return self;
}


#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == tableView2) {
        [refreshHeaderView2 CBRefreshScrollViewDidScroll:scrollView];
    }
    else if (scrollView == tableView3){
        [refreshHeaderView3 CBRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if (scrollView == rootScroll) {
		UIView *v = [self.mainView viewWithTag:1101];
		[UIView setAnimationDuration:0.5];
		NSLog(@"%f",scrollView.contentOffset.x);
		v.frame = CGRectMake(scrollView.contentOffset.x/4, v.frame.origin.y, v.frame.size.width, v.frame.size.height);
		[UIView commitAnimations];
        if (v.frame.origin.x == 0) {
            [MobClick event:@"event_goumai_zulancai_bafangyuce_fenxi"];
        }
        else if (v.frame.origin.x == 80) {
            [MobClick event:@"event_goumai_zulancai_bafangyuce_oupei"];
        }
        else if (v.frame.origin.x == 160) {
            [MobClick event:@"event_goumai_zulancai_bafangyuce_yapei"];
        }
        else if (v.frame.origin.x == 240) {
            [MobClick event:@"event_goumai_zulancai_bafangyuce_daxiao"];
        }
	}

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == tableView2) {
        [refreshHeaderView2 CBRefreshScrollViewDidEndDragging:scrollView];
    }
    else if (scrollView == tableView3){
        [refreshHeaderView3 CBRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark -
#pragma mark Action

- (void)scrollBtn:(UIButton *)btn {
	UIView *v = [self.mainView viewWithTag:1101];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	v.frame = btn.frame;
	[UIView commitAnimations];
	
	[rootScroll scrollRectToVisible:CGRectMake(btn.tag *320, 0, 320, 320) animated:YES];
    if (v.frame.origin.x == 0) {
        [MobClick event:@"event_goumai_zulancai_bafangyuce_fenxi"];
    }
    else if (v.frame.origin.x == 80) {
        [MobClick event:@"event_goumai_zulancai_bafangyuce_oupei"];
    }
    else if (v.frame.origin.x == 160) {
        [MobClick event:@"event_goumai_zulancai_bafangyuce_yapei"];
    }
    else if (v.frame.origin.x == 240) {
        [MobClick event:@"event_goumai_zulancai_bafangyuce_daxiao"];
    }
}

- (void)goTalk {
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] showInSencondView:nil ViewControllor:nil];
    
#else
    if ([[[ Info getInstance] userId] intValue] == 0) {
        [[caiboAppDelegate getAppDelegate]showMessage:@"登录后可用"];
        return;
    }
    if ([[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"HostTeamName"]) {
		NSString *st = [NSString stringWithFormat:@"#%@VS%@#",[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"HostTeamName"],[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"GuestTeamName"]];
		TopicThemeListViewController *themeTopic = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:nil	themeName:st];
		[self.navigationController pushViewController:themeTopic animated:YES];
		[themeTopic release];
	}
#endif

}

- (void)goback {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshASIA {
    if (self.dataDic ) {
        isLoading = YES;
		[self.mrequest clearDelegatesAndCancel];
		self.mrequest = nil;
		self.mrequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetBFYC:playID]];
		[mrequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mrequest setDelegate:self];
        [mrequest setDidFinishSelector:@selector(ASIAFinish:)];
        [mrequest startAsynchronous];
	}
}

- (void)refreshEURO {
    if (self.dataDic ) {
        isLoading = YES;
		[self.mrequest clearDelegatesAndCancel];
		self.mrequest = nil;
		self.mrequest = [ASIHTTPRequest requestWithURL:[NetURL refreshEURO:playID]];
		[mrequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mrequest setDelegate:self];
        [mrequest setDidFinishSelector:@selector(EUROFinish:)];
        [mrequest startAsynchronous];
	}
}

#pragma mark -
#pragma mark View lifecycle

- (void)LoadIphoneView {
}

- (void)LoadIpadView {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
	isLoading = YES;
//    [MobClick event:@"event_goumai_zulancai_bafangyuce"];
	self.title = @"八方预测";
    self.mainView.frame = CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y, 320, self.mainView.frame.size.height);
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 320, self.view.frame.size.height);
    self.CP_navigation.frame = CGRectMake(self.CP_navigation.frame.origin.x, self.CP_navigation.frame.origin.y, 320, self.CP_navigation.frame.size.height);
#ifdef isCaiPiaoForIPad
    UIBarButtonItem *right = [Info itemInitWithTitle:nil Target:self action:@selector(goTalk) ImageName:@"kf-quxiao2.png"];
    self.CP_navigation.rightBarButtonItem = right;
#else
//    UIBarButtonItem *right = [Info itemInitWithTitle:@"微博讨论" Target:self action:@selector(goTalk) ImageName:@"anniubgimage.png"Size:CGSizeMake(80,30)];
//    self.CP_navigation.rightBarButtonItem = right;
	
	UIBarButtonItem *left = [Info backItemTarget:self action:@selector(goback)];
	self.CP_navigation.leftBarButtonItem =left;
#endif

	
	if ([self.dataDic count] == 0) {
		[self.mrequest clearDelegatesAndCancel];
		self.mrequest = nil;
		self.mrequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetBFYC:playID]];
		[mrequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mrequest setDelegate:self];
        [mrequest startAsynchronous];
	}
	
	if (!lists) {
		lists = [[NSMutableArray alloc] init];
		NSArray *array = [NSMutableArray arrayWithObjects:@"战绩走势图",@"积分排名",@"近期战绩",@"历史交锋",@"八方预测",@"投注比例",nil];
		for (int i = 0; i<[array count]; i++) {
            
            if (i == 0) {
              buffer[i] = 1;
            }
            else {
                buffer[i] = 0;
            }
//			YrbList *a = [[YrbList alloc] init];
//			a.listName = [array objectAtIndex:i];
//			a.opened = NO;
//			if (i == 0) {
//				a.opened = YES;
//			}
			[lists addObject:[array objectAtIndex:i]];
//			[a  release];
		}
	}
	UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, self.mainView.bounds.size.height - 100)];
    sc.alwaysBounceVertical = NO;
	
	self.rootScroll = sc;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7) {
        rootScroll.frame = CGRectMake(0, 100, 320, self.mainView.bounds.size.height - 100);
    }
    sc.contentSize = CGSizeMake(320 * 4, rootScroll.bounds.size.height );
	rootScroll.delegate = self;
	rootScroll.pagingEnabled = YES;
	[rootScroll setShowsHorizontalScrollIndicator:NO];
	[self.mainView addSubview:self.rootScroll];
	rootScroll.backgroundColor = [UIColor colorWithRed:214/255.0 green:232/255.0 blue:245/255.0 alpha:1.0];
	self.mainView.backgroundColor =[UIColor colorWithRed:214/255.0 green:232/255.0 blue:245/255.0 alpha:1.0];
	[sc release];
	
	homeImageView = [[DownLoadImageView alloc] initWithFrame:CGRectMake(30, 5, 50, 50)];
	[self.mainView addSubview:homeImageView];
    [homeImageView release];

	gameImageView = [[DownLoadImageView alloc] initWithFrame:CGRectMake(125, 10, 25, 25)];
	[self.mainView addSubview:gameImageView];
	gameImageView.backgroundColor = [UIColor clearColor];
    [gameImageView release];
	
	homeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 55, 130, 18)];
	[self.mainView addSubview:homeLabel];
	homeLabel.textAlignment = NSTextAlignmentLeft;
	homeLabel.backgroundColor = [UIColor clearColor];
	homeLabel.font = [UIFont systemFontOfSize:14];
	
	
	visitImageView = [[DownLoadImageView alloc] initWithFrame:CGRectMake(240, 5, 50, 50)];
	[self.mainView addSubview:visitImageView];
    [visitImageView release];
	
	//DownLoadImageView = [[DownLoadImageView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
	
	visitLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 55, 140, 18)];
	[self.mainView addSubview:visitLabel];
	visitLabel.backgroundColor = [UIColor clearColor];
	visitLabel.textAlignment = NSTextAlignmentRight;
	visitLabel.font = [UIFont systemFontOfSize:14];
	
	
	timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 35, 140, 20)];
	[self.mainView addSubview:timeLabel];
	timeLabel.backgroundColor = [UIColor clearColor];
	timeLabel.textAlignment = NSTextAlignmentCenter;
	timeLabel.textColor = [UIColor lightGrayColor];
	timeLabel.font = [UIFont systemFontOfSize:14];
	

	
	nameLabe = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 25)];
	[self.mainView addSubview:nameLabe];
	nameLabe.backgroundColor = [UIColor clearColor];
	nameLabe.textColor = [UIColor colorWithRed:3/255.0 green:39/255.0 blue:79/255.0 alpha:1];
	
	UITableView *table1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, 320, rootScroll.bounds.size.height) style:UITableViewStylePlain];
	self.tableView1 = table1;
	table1.backgroundColor = [UIColor clearColor];
	[table1 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	table1.delegate = self;
	table1.dataSource = self;
	[rootScroll addSubview:self.tableView1];
	[table1 release];
	UITableView *table2 = [[UITableView alloc] initWithFrame:CGRectMake(320, 1, 320, rootScroll.bounds.size.height) style:UITableViewStylePlain];
	self.tableView2 = table2;
	table2.backgroundColor = [UIColor whiteColor];
	table2.delegate = self;
	table2.dataSource = self;
	[rootScroll addSubview:self.tableView2];
	[table2 release];
    
    if (refreshHeaderView2==nil) {
		
		CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView2.frame.size.height, self.tableView2.frame.size.width, self.tableView2.frame.size.height)];
		
		headerview.delegate = self;
		
		[self.tableView2 addSubview:headerview];
		
		self.refreshHeaderView2 = headerview;
		
		[headerview release];
		
	}
    
	UITableView *table3 = [[UITableView alloc] initWithFrame:CGRectMake(640, 1, 320, self.rootScroll.bounds.size.height) style:UITableViewStylePlain];
	self.tableView3 = table3;
	table3.delegate = self;
	table3.dataSource = self;
	table3.backgroundColor = [UIColor whiteColor];
	[rootScroll addSubview:self.tableView3];
	[table3 release];
    
    if (refreshHeaderView3==nil) {
		
		CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView3.frame.size.height, self.tableView3.frame.size.width, self.tableView3.frame.size.height)];
		
		headerview.delegate = self;
		
		[self.tableView3 addSubview:headerview];
		
		self.refreshHeaderView3 = headerview;
		
		[headerview release];
		
	}
    
	UITableView *table4 = [[UITableView alloc] initWithFrame:CGRectMake(960, 1, 320, rootScroll.bounds.size.height) style:UITableViewStylePlain];
	self.tableView4 = table4;
	table4.delegate = self;
	table4.dataSource = self;
	table4.backgroundColor = [UIColor whiteColor];
	[rootScroll addSubview:self.tableView4];
	[table4 release];
	
	NSArray *array1 = [NSMutableArray arrayWithObjects:@"分析",@"欧赔",@"亚赔",@"大小",nil];
	for (int i = 0; i < [array1 count]; i++) {
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = CGRectMake(i*80, 76, 80, 25);
		btn.tag = i;
		[self.mainView addSubview:btn];
		[btn setImage:UIImageGetImageFromName(@"buleBtn.png") forState:UIControlStateNormal];
		[btn addTarget:self action:@selector(scrollBtn:) forControlEvents:UIControlEventTouchUpInside];
	}
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 76, 80, 25)];
	imageView.tag = 1101;
	imageView.image = UIImageGetImageFromName(@"yellowBtn.png");
	[self.mainView addSubview:imageView];
	[imageView release];
	for (int i = 0; i < [array1 count]; i++) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*80, 77, 80, 23)];
		[self.mainView addSubview:label];
		label.backgroundColor = [UIColor clearColor];
		label.text = [array1 objectAtIndex:i];
		label.textColor = [UIColor blackColor];
		label.textAlignment = NSTextAlignmentCenter;
		[label release];
	}
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (tableView == tableView1) {
		if ([dataDic count]) {
			if (![dataDic objectForKey:@"bfyc"]) {
				return 6 - 1;
			}
			return 6;
		}
		return 4;
	}
	
	return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if ([dataDic count] == 0) {
		return 0;
	}
	if (tableView == tableView1) {
//		YrbList *yrbList = [lists objectAtIndex:section];
		if (buffer[section] == 1) {
			if (section == 0) {
				return 1;
			}
			if (section == 1) {
				if (self.dataDic) {
					if (![dataDic objectForKey:@"gradeAll_Host"]) {
						return 0;
					}
					return 8;
				}
			}
			if (section == 5) {
				NSInteger num = 0;
				NSDictionary *dic = [dataDic objectForKey:@"tzPer"];
				if ([[dic objectForKey:@"issuebd"] intValue]) {
					num = num+1;
				}
				if ([[dic objectForKey:@"issuezq"] intValue]) {
					num = num+1;
				}
				if ([[dic objectForKey:@"issuesf9"] intValue]||[[dic objectForKey:@"issuesf6"] intValue]) {
					num = num+1;
				}
				return num *4;
			}
			if (section == 2) {
                if ([[dataDic objectForKey:@"hostRecentPlay"] isKindOfClass:[NSArray class]]) {
                    				return [[[[dataDic objectForKey:@"hostRecentPlay"] objectAtIndex:0] objectForKey:@"play"] count]+[[[[dataDic objectForKey:@"guestRecentPlay"] objectAtIndex:0] objectForKey:@"play"] count]+2;
                }
                return 0;

			}
			if (section == 3 ) {
				if ([[dataDic objectForKey:@"playvs"] isKindOfClass:[NSArray class]]) {
					return [[[[dataDic objectForKey:@"playvs"] objectAtIndex:0] objectForKey:@"play"] count]+1;
				}
				return 0;
			}
			if (section ==4) {
				return 1;
			}
			return 10;
		}else
		{
			return 0;
		}
	}
	if (tableView == tableView2) {
		NSArray *array1 = [[[dataDic objectForKey:@"euro"] objectAtIndex:0] objectForKey:@"companyList"];
		if ([array1 isKindOfClass:[NSArray class]]) {
			NSArray *array = [[array1 objectAtIndex:0] objectForKey:@"c"];
			return [array count]+1;
		}
		return 0;
	}
	if (tableView == tableView3) {
		NSArray *array1 = [[[dataDic objectForKey:@"asia"] objectAtIndex:0] objectForKey:@"companyList"];
		if ([array1 isKindOfClass:[NSArray class]]) {
			NSArray *array = [[array1 objectAtIndex:0] objectForKey:@"c"];
			return [array count]+1;
		}
		return 0;
	}
	if (tableView == tableView4) {
		
		NSArray *array = [[[dataDic objectForKey:@"ball"] objectAtIndex:0] objectForKey:@"companyList"];
		if ([array isKindOfClass:[NSArray class]]) {
			return [[[array objectAtIndex:0] objectForKey:@"c"] count]+1;
		}
		else {
			return 0;
		}

						    
		
	}
	return 0;
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (tableView == tableView1) {
		if (indexPath.section == 0) {
			static NSString *CellIdentifier1 = @"走势";
			ZhanjiCell *cell1 = (ZhanjiCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
			if (!cell1) {
				cell1 = [[[ZhanjiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
				
			}
			NSArray *array1 = [self.dataDic objectForKey:@"hostLeaguePlay"];
			NSArray *array2 = [self.dataDic objectForKey:@"guestLeaguePlay"];
			if (![array1 isKindOfClass:[NSArray class]]||[array1 count] == 0) {
				array1 = nil;
			}
			if (![array2 isKindOfClass:[NSArray class]]||[array2 count] == 0) {
				array2 = nil;
			}
			[cell1 LoadData:[[array1 objectAtIndex:0] objectForKey:@"play"]
					  Array:[[array2 objectAtIndex:0] objectForKey:@"play"]
					 IsHome:YES 
					 WithID:HostTeamId 
					WithID2:GuestTeamId 
				   WithName:[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"HostTeamName"] 
				  WithName2:[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"GuestTeamName"]];
			//			if (indexPath.row == 0) {
//				[cell1 LoadData:[[[self.dataDic objectForKey:@"hostLeaguePlay"]objectAtIndex:0] objectForKey:@"play"] IsHome:YES WithID:HostTeamId With:homeLabel.text];
//			}
//			else {
//				[cell1 LoadData:[[[self.dataDic objectForKey:@"guestLeaguePlay"]objectAtIndex:0] objectForKey:@"play"] IsHome:NO WithID:GuestTeamId With:visitLabel.text];
//			}
			return cell1;
		}
		if (indexPath.section == 1) {
			static NSString *CellIdentifier1 = @"积分";
			NearRankCell *cell1 = (NearRankCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
			if (!cell1) {
				cell1 = [[[NearRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
				
			}
			if (indexPath.row == 0 ) {
				[cell1 LoadData:nil WithName:[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"HostTeamName"] isTitle:YES];
			}
			else if (indexPath.row == 4) {
				[cell1 LoadData:nil WithName:[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"GuestTeamName"] isTitle:YES];
			}
			else if (indexPath.row == 1) {
				[cell1 LoadData:[dataDic objectForKey:@"gradeAll_Host"] WithName:@"总" isTitle:NO];
			}
			else if (indexPath.row == 2) {
				[cell1 LoadData:[dataDic objectForKey:@"gradeHost_Host"] WithName:@"主场" isTitle:NO];
			}
			else if (indexPath.row == 3) {
				[cell1 LoadData:[dataDic objectForKey:@"gradeGuest_Host"] WithName:@"客场" isTitle:NO];
			}
			
			else if (indexPath.row == 5) {
				[cell1 LoadData:[dataDic objectForKey:@"gradeAll_Guest"] WithName:@"总" isTitle:NO];
			}
			else if (indexPath.row == 6) {
				[cell1 LoadData:[dataDic objectForKey:@"gradeHost_Guest"] WithName:@"主场" isTitle:NO];
			}
			else if (indexPath.row == 7) {
				[cell1 LoadData:[dataDic objectForKey:@"gradeGuest_Guest"] WithName:@"客场" isTitle:NO];
			}

			return cell1;
			
		}else if(indexPath.section ==5) {
			static NSString *CellIdentifier1 = @"投注";
			tzPerCell *cell1 = (tzPerCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
			if (!cell1) {
				cell1 = [[[tzPerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
			}
			NSDictionary *dic = [dataDic objectForKey:@"tzPer"];
			NSArray *array1 = [[dic objectForKey:@"jczq"] objectForKey:@"S20101"];
			NSArray *array2 = [[dic objectForKey:@"jczq"] objectForKey:@"S20103"];
			NSArray *array3 = [[dic objectForKey:@"jczq"] objectForKey:@"S20104"];
			NSArray *array4 = [[dic objectForKey:@"jczq"] objectForKey:@"S20105"];
			NSArray *array5 = [[dic objectForKey:@"bd"] objectForKey:@"S40001"];
			NSArray *array6 = [[dic objectForKey:@"bd"] objectForKey:@"S40003"];
			NSArray *array7 = [[dic objectForKey:@"bd"] objectForKey:@"S40002"];
			NSArray *array8 = [[dic objectForKey:@"bd"] objectForKey:@"S40005"];
			
			NSArray *array9 = [dic objectForKey:@"S300"];
			NSArray *array10 = [dic objectForKey:@"S301"];
			NSArray *array11 = [dic objectForKey:@"S302"];
			if (![array1 isKindOfClass:[NSArray class]]) {
				array1 = nil;
			}
			if (![array2 isKindOfClass:[NSArray class]]) {
				array2 = nil;
			}
			if (![array3 isKindOfClass:[NSArray class]]) {
				array3 = nil;
			}
			if (![array4 isKindOfClass:[NSArray class]]) {
				array4 = nil;
			}
			if (![array5 isKindOfClass:[NSArray class]]) {
				array5 = nil;
			}
			if (![array6 isKindOfClass:[NSArray class]]) {
				array6 = nil;
			}
			if (![array7 isKindOfClass:[NSArray class]]) {
				array7 = nil;
			}
			if (![array8 isKindOfClass:[NSArray class]]) {
				array8 = nil;
			}
			if (![array9 isKindOfClass:[NSArray class]]) {
				array9 = nil;
			}
			if (![array10 isKindOfClass:[NSArray class]]) {
				array10 = nil;
			}
			if (![array11 isKindOfClass:[NSArray class]]) {
				array11 = nil;
			}
			int a = (int)indexPath.row/4;//第几个分析组
			int b = indexPath.row%4;//分析组中的第几个；
			NSLog(@"%d %d",a,b);
			int c=a;
			if (![[dic objectForKey:@"issuezq"] intValue]) {
				c = c+1;
			}
			if (![[dic objectForKey:@"issuebd"] intValue]) {
				if (c > 0) {
					c = c+1;
				}
			}
			if (![[dic objectForKey:@"issuesf6"] intValue]&&![[dic objectForKey:@"issuesf9"] intValue]) {
			}
			
			if (b == 0) {
				
				switch (c) {
					case 0:
					{
						[cell1 LoadDataName1:@"竞彩"
									   Name2:@"胜平负"
									   Name3:@"总进球" 
									   Name4:@"半全场"
									   Name5:@"比分"
									 isTitle:YES];
					}
						break;
					case 1:
					{
						[cell1 LoadDataName1:@"单场"
									   Name2:@"胜平负"
									   Name3:@"总进球"
									   Name4:@"上下单双" 
									   Name5:@"比分" 
									 isTitle:YES];
					}
						break;
					case 2:
					{
						[cell1 LoadDataName1:@"足彩"
									   Name2:@"胜负彩票"
									   Name3:@"任九" 
									   Name4:@"半全场"
									   Name5:nil
									 isTitle:YES];
					}
						break;
					default:
						break;
				}
				
			}
			else {
				b= b-1;
				switch (c) {
					case 0:
					{
                        NSDictionary *dic1 = nil,*dic2 = nil,*dic3 = nil,*dic4 = nil;
                        if (b<[array1 count]) {
                            dic1 = [array1 objectAtIndex:b];
                        }
                        if (b<[array2 count]) {
                            dic2 = [array2 objectAtIndex:b];
                        }
                        if (b<[array3 count]) {
                            dic3 = [array3 objectAtIndex:b];
                        }
                        if (b<[array4 count]) {
                            dic4 = [array4 objectAtIndex:b];
                        }
                        [cell1 LoadDataDic1:nil
                                       Dic2:dic1
                                       Dic3:dic2
                                       Dic4:dic3
                                       Dic5:dic4
                                    isTitle:NO];
//						if (b<[array1 count]&&b<[array2 count]&&b<[array3 count]&&b<[array4 count]) {
//							[cell1 LoadDataDic1:nil
//										   Dic2:[array1 objectAtIndex:b] 
//										   Dic3:[array2 objectAtIndex:b]
//										   Dic4:[array3 objectAtIndex:b]
//										   Dic5:[array4 objectAtIndex:b] 
//										 isTitle:NO];
//							
//						}
//                        else{
//                            [cell1 LoadDataDic1:nil
//                                           Dic2:nil 
//                                           Dic3:nil
//                                           Dic4:nil
//                                           Dic5:nil 
//                                        isTitle:NO];
//                        }
					}
						break;
					case 1:
					{
						if (b<[array5 count]&&b<[array6 count]&&b<[array7 count]&&b<[array7 count]) {
							[cell1 LoadDataDic1:nil
										   Dic2:[array5 objectAtIndex:b] 
										   Dic3:[array6 objectAtIndex:b]
										   Dic4:[array7 objectAtIndex:b]
										   Dic5:[array8 objectAtIndex:b] 
										 isTitle:NO];
						}
                        else{
                            [cell1 LoadDataDic1:nil
                                           Dic2:nil 
                                           Dic3:nil
                                           Dic4:nil
                                           Dic5:nil 
                                        isTitle:NO];
                        }
					}
						break;
					case 2:
					{
						
//						if (b<[array9 count]&&b<[array10 count]&&b<[array11 count]) {
							[cell1 LoadDataDic1:nil
										   Dic2:[array9 objectAtIndex:b] 
										   Dic3:[array10 objectAtIndex:b]
										   Dic4:[array11 objectAtIndex:b]
										   Dic5:nil 
										 isTitle:NO];
//						}
					}
						break;
					default:

                        
						break;
				}
			}
			
			return cell1;
		}
		else if(indexPath.section ==2) {
			static NSString *CellIdentifier1 = @"战绩";
			FaceHistoryCell *cell1 = (FaceHistoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
			if (!cell1) {
				cell1 = [[[FaceHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
			}
			NSArray *array1 = [[[dataDic objectForKey:@"hostRecentPlay"] objectAtIndex:0] objectForKey:@"play"];
			NSArray *array2 = [[[dataDic objectForKey:@"guestRecentPlay"] objectAtIndex:0] objectForKey:@"play"];
			if (indexPath.row ==  0) {
				[cell1 LoadData:nil withName:[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"HostTeamName"] withType:FaceHistoryCellTypeNear];
				cell1.contentView.backgroundColor = [UIColor colorWithRed:168/255.0 green:207/255.0 blue:222/255.0 alpha:1.0];
			}
			else if(indexPath.row ==[array1 count]+1) {
				[cell1 LoadData:nil withName:[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"GuestTeamName"] withType:FaceHistoryCellTypeNear];
				cell1.contentView.backgroundColor = [UIColor colorWithRed:168/255.0 green:207/255.0 blue:222/255.0 alpha:1.0];
			}
			
			else {
				if (indexPath.row <[array1 count]+1) {
					[cell1 LoadData:[array1 objectAtIndex:indexPath.row -1] withName:nil withType:FaceHistoryCellTypeNear];
				}
				else {
					[cell1 LoadData:[array2 objectAtIndex:indexPath.row - [array1 count]-2] withName:[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"GuestTeamName"] withType:FaceHistoryCellTypeNear];
				}
			}
			return cell1;
		}
		else if(indexPath.section ==3) {
			static NSString *CellIdentifier1 = @"战绩";
			NSArray *array = [[[dataDic objectForKey:@"playvs"] objectAtIndex:0] objectForKey:@"play"];
			FaceHistoryCell *cell1 = (FaceHistoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
			if (!cell1) {
				cell1 = [[[FaceHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
			}
			if (indexPath.row == 0) {
				[cell1 LoadData:nil withName:nil withType:FaceHistoryCellTypeFace];
				cell1.contentView.backgroundColor = [UIColor colorWithRed:168/255.0 green:207/255.0 blue:222/255.0 alpha:1.0];
			}
			else {
				[cell1 LoadData:[array objectAtIndex:indexPath.row -1] withName:nil withType:FaceHistoryCellTypeFace];				
			}
			return cell1;
		}
		else if(indexPath.section == 4) {
			static NSString *CellIdentifier = @"Cell5";
			
			UITableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell5 == nil) {
				cell5 = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
				UITextView *text = [[UITextView alloc] init];
				[cell5.contentView addSubview:text];
				text.backgroundColor = [UIColor clearColor];
				text.tag = 1001;
				text.font = [UIFont systemFontOfSize:15];
				text.editable = NO;
				[text release];
			}
            if ([[dataDic objectForKey:@"bfyc"] isKindOfClass:[NSString class]]) {
                UITextView *v = (UITextView *)[cell5.contentView viewWithTag:1001];
                v.text = @"暂无预测";
                v.frame = CGRectMake(10, 0, 300, 25);
            }
            else {
                NSString *info = [[[dataDic objectForKey:@"bfyc"] objectAtIndex:0] objectForKey:@"description"];
                if (!info) {
                    NSArray *array = [[[dataDic objectForKey:@"bfyc"] objectAtIndex:0] objectForKey:@"item"];
                    info = @"";
                    for (int i = 0; i <[array count]; i++) {
                        info = [info stringByAppendingFormat:@"\n\n%@\n%@",[[array objectAtIndex:i] objectForKey:@"title"],[[array objectAtIndex:i] objectForKey:@"description"]];
                    }
                }
                info = [info stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
                UITextView *v = (UITextView *)[cell5.contentView viewWithTag:1001];
                v.text = info;
                v.frame = CGRectMake(10, 5, 300, 300);
                if ([v.text length] <10) {
                    v.frame = CGRectMake(10, 5, 300, 30);
                    v.text = @"暂无预测";
                }
            }
			//v.frame = CGRectMake(10, 5, 300, [info sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:constrainSize lineBreakMode:UILineBreakModeCharacterWrap].height);
			return cell5;
		}


	}
    // Configure the cell...
    else if (tableView == tableView2) {
		static NSString *CellIdentifier1 = @"EuCell";
		AsEuCell *cell1 = (AsEuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (!cell1) {
			cell1 = [[[AsEuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
			
		}
		NSArray *array = [[[[[dataDic objectForKey:@"euro"] objectAtIndex:0] objectForKey:@"companyList"] objectAtIndex:0] objectForKey:@"c"];
		if (indexPath.row == 0) {
			[cell1 LoadData:nil isTitle:YES];
		}
		else {
			if (indexPath.row -1< [array count]) {
				[cell1 LoadData:[array objectAtIndex:indexPath.row -1] isTitle:NO];
			}
			else {
				[cell1 LoadData:nil isTitle:NO];
				cell.contentView.backgroundColor = [UIColor whiteColor];
				return cell;
			}
		}
		return cell1;
	}
	else if (tableView == tableView3) {
		static NSString *CellIdentifier1 = @"asCell";
		AsEuCell *cell1 = (AsEuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (!cell1) {
			cell1 = [[[AsEuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
			
		}
		NSArray *array = [[[[[dataDic objectForKey:@"asia"] objectAtIndex:0] objectForKey:@"companyList"] objectAtIndex:0] objectForKey:@"c"];
		if (indexPath.row == 0) {
			[cell1 LoadData:nil isTitle:YES];
		}
		else {
			if (indexPath.row -1 < [array count]) {
				[cell1 LoadData:[array objectAtIndex:indexPath.row -1] isTitle:NO];
			}
			else {
				cell.contentView.backgroundColor = [UIColor whiteColor];
				return cell;
			}
		}
		return cell1;
	}
	else if (tableView == tableView4) {
		static NSString *CellIdentifier1 = @"ballCell";
		AsEuCell *cell1 = (AsEuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (!cell1) {
			cell1 = [[[AsEuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
			
		}
		NSArray *array = [[[[[dataDic objectForKey:@"ball"] objectAtIndex:0] objectForKey:@"companyList"] objectAtIndex:0] objectForKey:@"c"];
		if (indexPath.row == 0) {
			[cell1 LoadData:nil isTitle:YES];
		}
		else {
			if (indexPath.row-1 < [array count]) {
				[cell1 LoadData:[array objectAtIndex:indexPath.row -1] isTitle:NO];
			}
			else {
				cell.contentView.backgroundColor = [UIColor whiteColor];
				return cell;
			}
		}
		return cell1;
	}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (tableView == tableView1) {
		return 30;
	}
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == tableView1) {
		if (indexPath.section == 0) {
			return 265;
		}
		if (indexPath.section == 1) {
			return 30;
		}
		if (indexPath.section == 2) {
			return 30;
		}
		if (indexPath.section == 3) {
			return 30;
		}
		if (indexPath.section == 4) {
            if ([[dataDic objectForKey:@"bfyc"] isKindOfClass:[NSString class]]) {
                return 30;
            }
            NSString *info = [[[dataDic objectForKey:@"bfyc"] objectAtIndex:0] objectForKey:@"description"];
            if (!info) {
                NSArray *array = [[[dataDic objectForKey:@"bfyc"] objectAtIndex:0] objectForKey:@"item"];
                info = @"";
                for (int i = 0; i <[array count]; i++) {
                    info = [info stringByAppendingFormat:@"\n\n%@\n%@",[[array objectAtIndex:i] objectForKey:@"title"],[[array objectAtIndex:i] objectForKey:@"description"]];
                }
            }
            info = [info stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
            if ([info length] <10) {
                return 40;
            }
			return 300;
		}
	}
	return 30;
}

- (void)openChange:(UIButton *)sender {
    buffer[sender.tag] = !buffer[sender.tag];
    UIButton *tou = (UIButton *)[sender viewWithTag:sender.tag];
    tou.selected = !tou.selected;
    [tableView1 reloadData];
    if ([tableView1 numberOfRowsInSection:sender.tag]) {
        [tableView1 scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sender.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if (tableView == tableView1) {
        UIButton *sectionHeaderView = [UIButton buttonWithType:UIButtonTypeCustom];
        sectionHeaderView.frame = CGRectMake(0, 0, 320, 30);
                                       
        UIButton *tmpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tmpButton setFrame:CGRectMake(280, -2, 35, 35)];
        [tmpButton setImage:UIImageGetImageFromName(@"carat.png")forState:UIControlStateNormal];
        [tmpButton setImage:UIImageGetImageFromName(@"carat-open.png") forState:UIControlStateSelected];
        tmpButton.tag = section;
        sectionHeaderView.tag = section;
        [sectionHeaderView addTarget:self action:@selector(openChange:) forControlEvents:UIControlEventTouchUpInside];
        tmpButton.userInteractionEnabled = NO;
        [tmpButton setSelected:buffer[section]];
        [sectionHeaderView addSubview:tmpButton];
		sectionHeaderView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"xihaoSection.png")];
        
        UILabel *tmpLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 300, 30)];
        [tmpLabel setFont:[UIFont systemFontOfSize:17.0]];
        [tmpLabel setText:[lists objectAtIndex:section]];
        [tmpLabel setTextColor:[UIColor blackColor]];
        [tmpLabel setTextAlignment:NSTextAlignmentLeft];
        [tmpLabel setBackgroundColor:[UIColor clearColor]];
        [sectionHeaderView addSubview:tmpLabel];
        [tmpLabel release];
//		YrbList *list = [lists objectAtIndex:section];
//		
//		NSString *headString = [NSString stringWithFormat:@"%@",list.listName];
//		
//		YrbSectionHeaderView *sectionHeaderView = [[[YrbSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 30) 
//																						title:headString 
//																					 delegate:self 
//																					  section:section 
//																						 open:list.opened]autorelease];
		return sectionHeaderView;
	}
	
    return nil;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}

#pragma mark -
#pragma mark LotteryPreferenceView delegate
//-(void)sectionHeaderView:(YrbSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section
//{
//    if (!self.dataDic) {
//        sectionHeaderView.disclosureButton.selected = !sectionHeaderView.disclosureButton.selected;
//        return;
//        
//    }
//    YrbList *list = [lists objectAtIndex:section];
//    list.opened = !list.opened;
//    
//    if (list.indexPaths) {
//        [self.tableView1 insertRowsAtIndexPaths:list.indexPaths withRowAnimation:UITableViewRowAnimationTop];
//		[self.tableView1 scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    }
//	else {
//		[self.tableView1 reloadData];
//        if ([self.tableView1 numberOfRowsInSection:section]>0) {
//                    		[self.tableView1 scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//        }
//	}
//	
//}
//-(void)sectionHeaderView:(YrbSectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section {
//    if (!self.dataDic) {
//        sectionHeaderView.disclosureButton.selected = !sectionHeaderView.disclosureButton.selected;
//        return;
//        
//    }
//    YrbList *list = [lists objectAtIndex:section];
//    list.opened = !list.opened;
//    
//    
//    NSInteger countOfRowsToDelete = 0;
//	if (section == 0) {
//		if (dataDic) {
//			countOfRowsToDelete = 1;
//		}
//	}
//	if (section == 1) {
//		if (self.dataDic) {
//			countOfRowsToDelete = 8;
//		}
//	}
//	if (section == 5) {
//		if (self.dataDic) {
//			NSInteger num = 0;
//			NSDictionary *dic = [dataDic objectForKey:@"tzPer"];
//			if ([[dic objectForKey:@"issuebd"] intValue]) {
//				num = num+1;
//			}
//			if ([[dic objectForKey:@"issuezq"] intValue]) {
//				num = num+1;
//			}
//			if ([[dic objectForKey:@"issuesf9"] intValue]||[[dic objectForKey:@"issuesf6"] intValue]) {
//				num = num+1;
//			}
//			countOfRowsToDelete = num *4;
//		}
//	}
//	if (section == 2) {
//		if (dataDic) {
//			countOfRowsToDelete = [[[[dataDic objectForKey:@"hostRecentPlay"] objectAtIndex:0] objectForKey:@"play"] count]+[[[[dataDic objectForKey:@"guestRecentPlay"] objectAtIndex:0] objectForKey:@"play"] count]+2;
//		}
//	}
//	if (section == 3) {
//		if (dataDic) {
//			if ([[dataDic objectForKey:@"playvs"] isKindOfClass:[NSArray class]]) {
//				countOfRowsToDelete = [[[[dataDic objectForKey:@"playvs"] objectAtIndex:0] objectForKey:@"play"] count]+1;
//			}
//			else {
//				countOfRowsToDelete= 0;
//			}
//
//		}
//	}
//	if (section == 4) {
//		if (dataDic) {
//			countOfRowsToDelete = 1;
//		}
//	}
//    if (countOfRowsToDelete > 0) {
//        NSMutableArray *array = [[NSMutableArray alloc]init];
//        for (NSInteger i = 0; i < countOfRowsToDelete; i ++) {
//            if (i < [tableView1 numberOfRowsInSection:section]) {
//                [array addObject:[NSIndexPath indexPathForRow:i inSection:section]];
//            }
//        
//        }
//        list.indexPaths = array;
//        [array release];
//        if (list.indexPaths) {
//            [self.tableView1 deleteRowsAtIndexPaths:list.indexPaths withRowAnimation:UITableViewRowAnimationTop];
//			
//        }
//    }
//}
#pragma mark -
#pragma mark ASIHTTPRequestDelegate 

- (void) requestFinished:(ASIHTTPRequest *)request {
    isLoading = NO;
	NSString *responseStr = [request responseString];
    NSLog(@"res = %@", responseStr);
	self.dataDic = [NSMutableDictionary dictionaryWithDictionary:[responseStr JSONValue]];
	homeLabel.text = [NSString stringWithFormat:@"%@(%@)",[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"HostTeamName"],[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"HostOrder"]];
	HostTeamId = [[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"HostTeamId"] intValue];
	GuestTeamId = [[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"GuestTeamId"] intValue];
	[homeImageView setImageWithURL:[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"HostTeamFlag"]];
	[gameImageView setImageWithURL:[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"leagueImg"]];
	[visitImageView setImageWithURL:[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"GuestTeamFlag"]];
	visitLabel.text =[NSString stringWithFormat:@"%@(%@)", [[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"GuestTeamName"],[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"GuestOrder"]];
	timeLabel.text = [[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"PlayTime"];
	if (![[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"leagueImg"] length] ) {
		nameLabe.frame = CGRectMake(100, nameLabe.frame.origin.y, 120, nameLabe.frame.size.height);
		nameLabe.textAlignment = NSTextAlignmentCenter;
	}
    if ([[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"zhongli"] length]) {
        if (!zhongliLable) {
            zhongliLable = [[UILabel alloc] initWithFrame:CGRectMake(90, 35, 140, 20)];
            [self.mainView addSubview:zhongliLable];
            zhongliLable.backgroundColor = [UIColor clearColor];
            zhongliLable.text = @"中立场";
            zhongliLable.font = [UIFont systemFontOfSize:14];
            zhongliLable.textAlignment = NSTextAlignmentCenter;
            [zhongliLable release];
        }
        timeLabel.frame = CGRectMake(90, 53, 140, 20);
    }
	nameLabe.text = [[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"lb"];
	[tableView1 reloadData];
	[tableView2 reloadData];
	[tableView3 reloadData];
	[tableView4 reloadData];
	
	
	if (![[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"jinqiu90"] isEqualToString:@""]) {
		UILabel *scrolLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 55, 100, 18)];
		[self.mainView addSubview:scrolLabel];
		scrolLabel.text = [NSString stringWithFormat:@"%@:%@",[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"jinqiu90"],[[[dataDic objectForKey:@"playinfo"] objectAtIndex:0] objectForKey:@"shiqiu90"]];
		scrolLabel.textAlignment = NSTextAlignmentCenter;
		scrolLabel.backgroundColor = [UIColor clearColor];
		scrolLabel.font = [UIFont systemFontOfSize:14];
		[scrolLabel release];
	}
        [refreshHeaderView3 CBRefreshScrollViewDataSourceDidFinishedLoading:self.tableView3];
        [refreshHeaderView2 CBRefreshScrollViewDataSourceDidFinishedLoading:self.tableView2];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
}

- (void)ASIAFinish:(ASIHTTPRequest *)request {
    isLoading = NO;
	NSString *responseStr = [request responseString];
    [self.dataDic setValue:[[NSMutableDictionary dictionaryWithDictionary:[responseStr JSONValue]] objectForKey:@"asia"] forKey:@"asia"];
    [refreshHeaderView3 performSelector:@selector(CBRefreshScrollViewDataSourceDidFinishedLoading:) withObject:tableView3 afterDelay:.5];
    [self.tableView3 reloadData];
}

- (void)EUROFinish:(ASIHTTPRequest *)request {
    isLoading = NO;
	NSString *responseStr = [request responseString];
        [self.dataDic setValue:[[NSMutableDictionary dictionaryWithDictionary:[responseStr JSONValue]] objectForKey:@"euro"] forKey:@"euro"];
    [refreshHeaderView2 performSelector:@selector(CBRefreshScrollViewDataSourceDidFinishedLoading:) withObject:tableView2 afterDelay:.5];
    [self.tableView2 reloadData];
}

#pragma mark -
#pragma mark CBRefreshTableHeaderDelegate
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view{
    if (self.refreshHeaderView2 == view) {
        
        [self refreshEURO];
        
        [refreshHeaderView2 setState:CBPullRefreshLoading];
        
        self.tableView2.contentInset = UIEdgeInsetsMake(60, 0.0f, 0.0f, 0.0f);
    }
    else {
        [self refreshASIA];
        
        [refreshHeaderView3 setState:CBPullRefreshLoading];
        
        self.tableView3.contentInset = UIEdgeInsetsMake(60, 0.0f, 0.0f, 0.0f);
    }
}

- (BOOL)CBRefreshTableHeaderDataSourceIsLoading:(CBRefreshTableHeaderView*)view{
    return isLoading;
}

- (NSDate*)CBRefreshTableHeaderDataSourceLastUpdated:(CBRefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    [super viewDidUnload];
}


- (void)dealloc {
	[mrequest clearDelegatesAndCancel];
	self.mrequest = nil;
	self.tableView1 = nil;
	self.tableView2 = nil;
	self.tableView3 = nil;
	self.tableView4 = nil;
	self.rootScroll = nil;
	self.homeLabel = nil;
	self.visitLabel = nil;
	self.dataDic = nil;
	self.timeLabel = nil;
	self.nameLabe = nil;
	self.playID = nil;
    self.refreshHeaderView2 = nil;
    self.refreshHeaderView3 = nil;
    [super dealloc];
}


@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    