//
//  NewAroundViewController.m
//  caibo
//
//  Created by yao on 12-5-2.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "LanQiuAroundViewController.h"
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
#import "LanQiuPaiMingViewController.h"
#import "LanQiuBianhuaAroundViewController.h"


@implementation LanQiuAroundViewController

@synthesize tableView1;
@synthesize tableView2;
@synthesize tableView3;
@synthesize tableView4;
@synthesize rootScroll;
//@synthesize homeImageView;
//@synthesize visitImageView;
@synthesize refreshHeaderView2;
@synthesize refreshHeaderView3;
@synthesize dataDic;
@synthesize mrequest;
@synthesize playID;

#pragma mark -
#pragma mark Initialization

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 self = [super initWithStyle:style];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == tableView2) {
        [refreshHeaderView2 CBRefreshScrollViewDidScroll:scrollView];
    }
    else if (scrollView == tableView3){
        [refreshHeaderView3 CBRefreshScrollViewDidScroll:scrollView];
    }
    if (scrollView == self.rootScroll) {
        UIView *v = [self.mainView viewWithTag:1101];
        v.frame = CGRectMake(scrollView.contentOffset.x/4 + 10, v.frame.origin.y, v.frame.size.width, v.frame.size.height);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if (scrollView == rootScroll) {
		UIView *v = [self.mainView viewWithTag:1101];
		[UIView setAnimationDuration:0.5];
		NSLog(@"%f",scrollView.contentOffset.x);
		v.frame = CGRectMake(scrollView.contentOffset.x/4 + 10, v.frame.origin.y, v.frame.size.width, v.frame.size.height);
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
    v.frame = CGRectMake(btn.frame.origin.x + 10, v.frame.origin.y, v.frame.size.width, v.frame.size.height);
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

- (void)goRank {
    LanQiuPaiMingViewController *cont = [[LanQiuPaiMingViewController alloc] init];
    cont.hostId = [dataDic objectForKey:@"host_id"];
    cont.playId = self.playID;
    cont.guestId = [dataDic objectForKey:@"guest_id"];
    cont.isNBA = [[dataDic objectForKey:@"is_nba"] boolValue];
    [self.navigationController pushViewController:cont animated:YES];
    [cont release];
}

- (void)goTalk {
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] showInSencondView:nil ViewControllor:nil];
    
#else
    if ([[[ Info getInstance] userId] intValue] == 0) {
        [[caiboAppDelegate getAppDelegate]showMessage:@"登录后可用"];
        return;
    }
    if ([dataDic objectForKey:@"host_name"]) {
		NSString *st = [NSString stringWithFormat:@"#%@VS%@#",[dataDic objectForKey:@"host_name"],[dataDic objectForKey:@"guest_name"]];
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
//    self.mainView.frame = CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y, 320, self.mainView.frame.size.height);
//    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 320, self.view.frame.size.height);
//    self.CP_navigation.frame = CGRectMake(self.CP_navigation.frame.origin.x, self.CP_navigation.frame.origin.y, 320, self.CP_navigation.frame.size.height);
#ifdef isCaiPiaoForIPad
    UIBarButtonItem *right = [Info itemInitWithTitle:nil Target:self action:@selector(goTalk) ImageName:@"kf-quxiao2.png"];
    self.CP_navigation.rightBarButtonItem = right;
#else
//    UIBarButtonItem *right = [Info itemInitWithTitle:@"微博讨论" Target:self action:@selector(goTalk) ImageName:@"anniubgimage.png"Size:CGSizeMake(80,30)];
//    self.CP_navigation.rightBarButtonItem = right;
	
	UIBarButtonItem *left = [Info backItemTarget:self action:@selector(goback)];
	self.CP_navigation.leftBarButtonItem =left;
#endif
    
    UIImageView *touBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 111)];
    touBack.image = UIImageGetImageFromName(@"lanqiuyuceback.png");
    [self.mainView addSubview:touBack];
    [touBack release];
	if ([self.dataDic count] == 0) {
		[self.mrequest clearDelegatesAndCancel];
		self.mrequest = nil;
		self.mrequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetLanQiuBFYC:self.playID]];
		[mrequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mrequest setDelegate:self];
        [mrequest startAsynchronous];
	}
	
	if (!lists) {
		lists = [[NSMutableArray alloc] init];
		NSArray *array = [NSMutableArray arrayWithObjects:@"积分排名",@"近期战绩",@"历史交锋",@"未来赛事",nil];
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
	UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 150, 320, self.mainView.bounds.size.height - 150)];
    sc.alwaysBounceVertical = NO;
	
	self.rootScroll = sc;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7) {
        rootScroll.frame = CGRectMake(0, 150, 320, self.mainView.bounds.size.height - 150);
    }
    sc.contentSize = CGSizeMake(320 * 4, rootScroll.bounds.size.height );
	rootScroll.delegate = self;
	rootScroll.pagingEnabled = YES;
	[rootScroll setShowsHorizontalScrollIndicator:NO];
	[self.mainView addSubview:self.rootScroll];
	rootScroll.backgroundColor = [UIColor clearColor];
	self.mainView.backgroundColor =[UIColor colorWithPatternImage:UIImageGetImageFromName(@"yucebifen.png")];
	[sc release];
	
    UIImageView *homeBack = [[UIImageView alloc] initWithFrame:CGRectMake(234, 12, 72, 72)];
    homeBack.image = UIImageGetImageFromName(@"yucelogo.png");
    [self.mainView addSubview:homeBack];
    [homeBack release];
    
    CP_PTButton *lianBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    lianBtn.frame = CGRectMake(109, 79, 102, 29);
    [lianBtn loadButonImage:@"yuceliansai.png" LabelName:@"联赛排名"];
    [lianBtn addTarget:self action:@selector(goRank) forControlEvents:UIControlEventTouchUpInside];
    lianBtn.buttonImage.image = UIImageGetImageFromName(@"yuceliansai.png");
    [self.mainView addSubview:lianBtn];
    
	homeImageView = [[DownLoadImageView alloc] initWithFrame:CGRectMake(237, 15, 66, 66)];
	[self.mainView addSubview:homeImageView];
    homeImageView.backgroundColor = [UIColor clearColor];
    homeImageView.layer.masksToBounds = YES;
    homeImageView.layer.cornerRadius = 33;
    [homeImageView release];
    
	gameImageView = [[DownLoadImageView alloc] initWithFrame:CGRectMake(125, 10, 25, 25)];
	[self.mainView addSubview:gameImageView];
    
	gameImageView.backgroundColor = [UIColor clearColor];
    [gameImageView release];
	
	homeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 85, 60, 18)];
	[self.mainView addSubview:homeLabel];
    homeLabel.textColor = [UIColor whiteColor];
	homeLabel.textAlignment = NSTextAlignmentRight;
	homeLabel.backgroundColor = [UIColor clearColor];
	homeLabel.font = [UIFont systemFontOfSize:14];
    homeLabel.layer.masksToBounds = NO;
    UILabel *homeOther = [[UILabel alloc] init];
    homeOther.frame = CGRectMake(65, 1, 30, 18);
    homeOther.font = [UIFont systemFontOfSize:9];
    homeOther.backgroundColor = [UIColor clearColor];
    homeOther.textColor = [UIColor whiteColor];
    homeOther.text = @"(主)";
    [homeLabel addSubview:homeOther];
    [homeOther release];
    
    [homeLabel release];
    
    
	
    
    UIImageView *visitBack = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 72, 72)];
    visitBack.image = UIImageGetImageFromName(@"yucelogo.png");
    [self.mainView addSubview:visitBack];
    [visitBack release];
	
	visitImageView = [[DownLoadImageView alloc] initWithFrame:CGRectMake(18, 15, 66, 66)];
	[self.mainView addSubview:visitImageView];
    visitImageView.layer.masksToBounds = YES;
    visitImageView.layer.cornerRadius = 33;
    [visitImageView release];
		
	visitLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 85, 60, 18)];
	[self.mainView addSubview:visitLabel];
    visitLabel.textColor = [UIColor whiteColor];
	visitLabel.backgroundColor = [UIColor clearColor];
	visitLabel.textAlignment = NSTextAlignmentRight;
	visitLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *visitOther = [[UILabel alloc] init];
    visitOther.frame = CGRectMake(65, 1, 30, 18);
    visitOther.font = [UIFont systemFontOfSize:9];
    visitOther.backgroundColor = [UIColor clearColor];
    visitOther.textColor = [UIColor whiteColor];
    visitOther.text = @"(客)";
    visitLabel.layer.masksToBounds = NO;
    [visitLabel addSubview:visitOther];
    [visitOther release];
    [visitLabel release];
	
	
	timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 45, 140, 20)];
	[self.mainView addSubview:timeLabel];
	timeLabel.backgroundColor = [UIColor clearColor];
	timeLabel.textAlignment = NSTextAlignmentCenter;
	timeLabel.textColor = [UIColor whiteColor];
	timeLabel.font = [UIFont systemFontOfSize:14];
    [timeLabel release];
	
    
	
	nameLabe = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, 100, 25)];
	[self.mainView addSubview:nameLabe];
    nameLabe.textColor = [UIColor whiteColor];
    nameLabe.textAlignment = NSTextAlignmentCenter;
    nameLabe.font = [UIFont boldSystemFontOfSize:25];
	nameLabe.backgroundColor = [UIColor clearColor];
    [nameLabe release];
	
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
    [tableView2 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[rootScroll addSubview:self.tableView2];
	[table2 release];
    
    if (refreshHeaderView2==nil) {
		
//		CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView2.frame.size.height, self.tableView2.frame.size.width, self.tableView2.frame.size.height)];
//		
//		headerview.delegate = self;
//		
//		[self.tableView2 addSubview:headerview];
//		
//		self.refreshHeaderView2 = headerview;
//		
//		[headerview release];
		
	}
    
	UITableView *table3 = [[UITableView alloc] initWithFrame:CGRectMake(640, 1, 320, self.rootScroll.bounds.size.height) style:UITableViewStylePlain];
	self.tableView3 = table3;
	table3.delegate = self;
	table3.dataSource = self;
    [table3 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	table3.backgroundColor = [UIColor whiteColor];
	[rootScroll addSubview:self.tableView3];
	[table3 release];
    
    if (refreshHeaderView3==nil) {
		
//		CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView3.frame.size.height, self.tableView3.frame.size.width, self.tableView3.frame.size.height)];
//		
//		headerview.delegate = self;
//		
//		[self.tableView3 addSubview:headerview];
//		
//		self.refreshHeaderView3 = headerview;
//		
//		[headerview release];
		
	}
    
	UITableView *table4 = [[UITableView alloc] initWithFrame:CGRectMake(960, 1, 320, rootScroll.bounds.size.height) style:UITableViewStylePlain];
	self.tableView4 = table4;
	table4.delegate = self;
	table4.dataSource = self;
    [tableView4 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	table4.backgroundColor = [UIColor whiteColor];
	[rootScroll addSubview:self.tableView4];
	[table4 release];
	
	NSArray *array1 = [NSMutableArray arrayWithObjects:@"分析",@"欧赔",@"亚赔",@"大小",nil];
    UIImageView *fenxiImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 111, 320, 40)];
    fenxiImage.image = [UIImageGetImageFromName(@"yucefenxiback.png") stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    [self.mainView addSubview:fenxiImage];
    [fenxiImage release];
	for (int i = 0; i < [array1 count]; i++) {
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = CGRectMake(i*80, 111, 80, 40);
		btn.tag = i;
        btn.backgroundColor = [UIColor clearColor];
		[self.mainView addSubview:btn];
		[btn addTarget:self action:@selector(scrollBtn:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*80, 112, 80, 38)];
		[self.mainView addSubview:label];
		label.backgroundColor = [UIColor clearColor];
		label.text = [array1 objectAtIndex:i];
		label.textColor = [UIColor blackColor];
		label.textAlignment = NSTextAlignmentCenter;
		[label release];
	}
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 148, 59, 3)];
	imageView.tag = 1101;
	imageView.image = UIImageGetImageFromName(@"yucelanxian.png");
	[self.mainView addSubview:imageView];
	[imageView release];
	
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
				return 12;
			}
			if (section == 1) {
				if (self.dataDic) {
                    NSArray *array1 = [[dataDic objectForKey:@"analysis"] objectForKey:@"host_recent"];
                    NSArray *array2 = [[dataDic objectForKey:@"analysis"] objectForKey:@"guest_recent"];
                    if ([array1 count] >= 1) {
                        array1 = [[array1 objectAtIndex:0] objectForKey:@"data"];
                    }
                    if ([array2 count] >= 1) {
                        array2 = [[array2 objectAtIndex:0] objectForKey:@"data"];
                    }
                    if ([array1 count] + [array2 count] == 0) {
                        return 0;
                    }
					return 4 + [array1 count] + [array2 count];
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
                NSArray *array1 = [[dataDic objectForKey:@"analysis"] objectForKey:@"history"];
                if (![array1 isKindOfClass:[NSArray class]]) {
                    return 0;
                }
                if ([array1 count] >= 1) {
                    array1 = [[array1 objectAtIndex:0] objectForKey:@"data"];
                }
                if ([array1 count] >= 1) {
                    return [array1 count] +1;
                }
                return 0;
                
			}
			if (section == 3 ) {
                NSArray *array1 = [[dataDic objectForKey:@"analysis"] objectForKey:@"host_future"];
                NSArray *array2 = [[dataDic objectForKey:@"analysis"] objectForKey:@"guest_future"];
                if ([array1 count] >= 1) {
                    array1 = [[array1 objectAtIndex:0] objectForKey:@"data"];
                }
                if ([array2 count] >= 1) {
                    array2 = [[array2 objectAtIndex:0] objectForKey:@"data"];
                }
                if ([array1 count] + [array2 count] == 0) {
                    return 0;
                }
                return 4 + [array1 count] + [array2 count];
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
        if ([[dataDic objectForKey:@"detail"] objectForKey:@"europe"]) {
            return [[[dataDic objectForKey:@"detail"] objectForKey:@"europe"] count] + 1;
        }
		return 0;
	}
	if (tableView == tableView3) {
        if ([[dataDic objectForKey:@"detail"] objectForKey:@"asian"]) {
            return [[[dataDic objectForKey:@"detail"] objectForKey:@"asian"] count] + 1;
        }
        
		return 0;
	}
	if (tableView == tableView4) {
        
		
        if ([[dataDic objectForKey:@"detail"] objectForKey:@"over_down"]) {
            return [[[dataDic objectForKey:@"detail"] objectForKey:@"over_down"] count] + 1;
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
			static NSString *CellIdentifier1 = @"积分";
			NearRankCell *cell1 = (NearRankCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            
            NSArray *array = [[dataDic objectForKey:@"analysis"] objectForKey:@"order"];
            if ([array count] >= 1) {
                if (indexPath.row > 5) {
                    array = [[array objectAtIndex:0] objectForKey:@"guest"];
                }
                else {
                    array = [[array objectAtIndex:0] objectForKey:@"host"];
                }
                
            }
            if ([array count] >= 1) {
                array = [[array objectAtIndex:0] objectForKey:@"data"];
            }
            NSDictionary *dic = nil;
			if (!cell1) {
				cell1 = [[[NearRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
				cell1.isLanQiu = YES;
			}
			if (indexPath.row == 0 ) {
				[cell1 LoadData:nil WithName:[dataDic objectForKey:@"host_name"] isTitle:YES];
			}
            else if (indexPath.row == 1 ) {
                [cell1 LoadData:nil WithName:nil isTitle:YES];
            }
			else if (indexPath.row == 2) {
                if ([array count] >= 1) {
                    dic = [array objectAtIndex:0];
                }
				[cell1 LoadData:dic WithName:@"总" isTitle:NO];
			}
			else if (indexPath.row == 3) {
                if ([array count] >= 2) {
                    dic = [array objectAtIndex:1];
                }
				[cell1 LoadData:dic WithName:@"主场" isTitle:NO];
			}
			else if (indexPath.row == 4) {
                if ([array count] >= 3) {
                    dic = [array objectAtIndex:2];
                }
				[cell1 LoadData:dic WithName:@"客场" isTitle:NO];
			}
            else if (indexPath.row == 5) {
                if ([array count] >= 4) {
                    dic = [array objectAtIndex:3];
                }
				[cell1 LoadData:dic WithName:@"近10" isTitle:NO];
			}
            else if (indexPath.row == 6) {
				[cell1 LoadData:nil WithName:[dataDic objectForKey:@"guest_name"]  isTitle:YES];
			}
            else if (indexPath.row == 7 ) {
                [cell1 LoadData:nil WithName:nil isTitle:YES];
            }
			else if (indexPath.row == 8) {
                if ([array count] >= 1) {
                    dic = [array objectAtIndex:0];
                }
				[cell1 LoadData:dic WithName:@"总" isTitle:NO];
			}
			else if (indexPath.row == 9) {
                if ([array count] >= 2) {
                    dic = [array objectAtIndex:1];
                }
				[cell1 LoadData:dic WithName:@"主场" isTitle:NO];
			}
			else if (indexPath.row == 10) {
                if ([array count] >= 3) {
                    dic = [array objectAtIndex:2];
                }
				[cell1 LoadData:dic WithName:@"客场" isTitle:NO];
			}
            else if (indexPath.row == 11) {
                if ([array count] >= 4) {
                    dic = [array objectAtIndex:3];
                }
				[cell1 LoadData:dic WithName:@"近10" isTitle:NO];
			}
            
			return cell1;
			
		}
		else if(indexPath.section ==1) {
			static NSString *CellIdentifier1 = @"战绩";
			FaceHistoryCell *cell1 = (FaceHistoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
			if (!cell1) {
				cell1 = [[[FaceHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
                cell1.isLanqiu = YES;
                
			}
            cell1.isZongjie = NO;
			NSArray *array1 = [[dataDic objectForKey:@"analysis"] objectForKey:@"host_recent"];
			NSArray *array2 = [[dataDic objectForKey:@"analysis"] objectForKey:@"guest_recent"];
            if ([array1 count] >= 1) {
                array1 = [[array1 objectAtIndex:0] objectForKey:@"data"];
            }
            if ([array2 count] >= 1) {
                array2 = [[array2 objectAtIndex:0] objectForKey:@"data"];
            }
			if (indexPath.row ==  0) {
				[cell1 LoadData:nil withName:[dataDic objectForKey:@"host_name"] withType:FaceHistoryCellTypeNear];
			}
            else if (indexPath.row == 1) {
                [cell1 LoadData:nil withName:nil withType:FaceHistoryCellTypeNear];
            }
			else if(indexPath.row ==[array1 count]+1) {
                cell1.isZongjie = YES;
                [cell1 LoadData:[array1 objectAtIndex:indexPath.row -2] withName:[dataDic objectForKey:@"host_name"] withType:FaceHistoryCellTypeNear];
			}
            else if (indexPath.row == [array1 count] + 2) {
                [cell1 LoadData:nil withName:[dataDic objectForKey:@"guest_name"] withType:FaceHistoryCellTypeNear];

            }
            else if (indexPath.row == [array1 count] + 3) {
                [cell1 LoadData:nil withName:nil withType:FaceHistoryCellTypeNear];
            }
            else if (indexPath.row == [array1 count] + [array2 count] + 3) {
                cell1.isZongjie = YES;
                [cell1 LoadData:[array2 objectAtIndex:indexPath.row - [array1 count]-4] withName:[dataDic objectForKey:@"guest_name"] withType:FaceHistoryCellTypeNear];
            }
			
			else {
				if (indexPath.row <[array1 count]+2) {
                    cell1.hostName = [dataDic objectForKey:@"host_name"];
					[cell1 LoadData:[array1 objectAtIndex:indexPath.row -2] withName:nil withType:FaceHistoryCellTypeNear];
				}
				else {
                    cell1.hostName = [dataDic objectForKey:@"guest_name"];
					[cell1 LoadData:[array2 objectAtIndex:indexPath.row - [array1 count]- 4] withName:nil withType:FaceHistoryCellTypeNear];
                    
				}
			}
			return cell1;
		}
        else if (indexPath.section ==2) {
            static NSString *CellIdentifier1 = @"历史交锋";
			FaceHistoryCell *cell1 = (FaceHistoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
			if (!cell1) {
				cell1 = [[[FaceHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
                cell1.isLanqiu = YES;
                cell1.hostName = [dataDic objectForKey:@"host_name"];
			}
            cell1.isZongjie = NO;
			NSArray *array1 = [[dataDic objectForKey:@"analysis"] objectForKey:@"history"];
            if ([array1 count] >= 1) {
                array1 = [[array1 objectAtIndex:0] objectForKey:@"data"];
            }
            if (indexPath.row == 0) {
                [cell1 LoadData:nil withName:nil withType:FaceHistoryCellTypeFace];
            }
			else if(indexPath.row ==[array1 count]) {
                cell1.isZongjie = YES;
                [cell1 LoadData:[array1 objectAtIndex:indexPath.row -1] withName:[dataDic objectForKey:@"host_name"] withType:FaceHistoryCellTypeFace];
			}
			else {
                [cell1 LoadData:[array1 objectAtIndex:indexPath.row -1] withName:nil withType:FaceHistoryCellTypeFace];
			}
			return cell1;
        }
		else if(indexPath.section ==3) {
			static NSString *CellIdentifier1 = @"未来";
			FaceHistoryCell *cell1 = (FaceHistoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
			if (!cell1) {
				cell1 = [[[FaceHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
                cell1.isLanqiu = YES;
                cell1.hostName = [dataDic objectForKey:@"host_name"];
			}
			NSArray *array1 = [[dataDic objectForKey:@"analysis"] objectForKey:@"host_future"];
			NSArray *array2 = [[dataDic objectForKey:@"analysis"] objectForKey:@"guest_future"];
            if ([array1 count] >= 1) {
                array1 = [[array1 objectAtIndex:0] objectForKey:@"data"];
            }
            if ([array2 count] >= 1) {
                array2 = [[array2 objectAtIndex:0] objectForKey:@"data"];
            }
			if (indexPath.row ==  0) {
				[cell1 LoadData:nil withName:[dataDic objectForKey:@"host_name"] withType:FaceHistoryCellTypeFuture];
			}
            else if (indexPath.row == 1) {
                [cell1 LoadData:nil withName:nil withType:FaceHistoryCellTypeFuture];
            }
            else if (indexPath.row == [array1 count] + 2) {
                [cell1 LoadData:nil withName:[dataDic objectForKey:@"guest_name"] withType:FaceHistoryCellTypeFuture];
                
            }
            else if (indexPath.row == [array1 count] + 3) {
                [cell1 LoadData:nil withName:nil withType:FaceHistoryCellTypeFuture];
            }
			else {
				if (indexPath.row <[array1 count]+2) {
					[cell1 LoadData:[array1 objectAtIndex:indexPath.row -2] withName:[dataDic objectForKey:@"host_name"] withType:FaceHistoryCellTypeFuture];
				}
				else {
					[cell1 LoadData:[array2 objectAtIndex:indexPath.row - [array1 count]- 4] withName:[dataDic objectForKey:@"guest_name"] withType:FaceHistoryCellTypeFuture];
				}
			}
			return cell1;
		}
	}
    // Configure the cell...
    else if (tableView == tableView2) {
		static NSString *CellIdentifier1 = @"EuCell";
        AsEuCell *cell1 = (AsEuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (!cell1) {
			cell1 = [[[AsEuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
            cell1.isOuPei = YES;
            cell1.isBafangYuceLanqiu = YES;
		}
        NSDictionary *dic = [[dataDic objectForKey:@"detail"] objectForKey:@"europe"];
        if (indexPath.row == 0) {
            [cell1 LoadData:nil isTitle:YES CId:nil isFoot:NO isBianHua:NO];
            return cell1;
        }
        else {
            NSArray *array = [dic allKeys];
            if (indexPath.row -1< [dic count]) {
                [cell1 LoadData:[dic objectForKey:[array objectAtIndex:indexPath.row -1]] isTitle:NO CId:[array objectAtIndex:indexPath.row -1] isFoot:NO isBianHua:YES];
            }
            else {
                [cell1 LoadData:nil isTitle:NO];
                cell1.contentView.backgroundColor = [UIColor whiteColor];
                
            }
            return cell1;
        }
	}
	else if (tableView == tableView3) {
		static NSString *CellIdentifier1 = @"asCell";
        AsEuCell *cell1 = (AsEuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (!cell1) {
			cell1 = [[[AsEuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
            cell1.isOuPei = NO;
            cell1.isBafangYuceLanqiu = YES;
		}
        NSDictionary *dic = [[dataDic objectForKey:@"detail"] objectForKey:@"asian"];
        if (indexPath.row == 0) {
            [cell1 LoadData:nil isTitle:YES CId:nil isFoot:NO isBianHua:NO];
            return cell1;
        }
        else {
            NSArray *array = [dic allKeys];
            if (indexPath.row -1< [dic count]) {
                [cell1 LoadData:[dic objectForKey:[array objectAtIndex:indexPath.row -1]] isTitle:NO CId:[array objectAtIndex:indexPath.row -1] isFoot:NO isBianHua:YES];
            }
            else {
                [cell1 LoadData:nil isTitle:NO];
                cell1.contentView.backgroundColor = [UIColor whiteColor];
                
            }
            return cell1;
        }
		
	}
	else if (tableView == tableView4) {
		static NSString *CellIdentifier1 = @"ballCell";
        AsEuCell *cell1 = (AsEuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (!cell1) {
			cell1 = [[[AsEuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
            cell1.isOuPei = NO;
            cell1.isBafangYuceLanqiu = YES;
		}
        NSDictionary *dic = [[dataDic objectForKey:@"detail"] objectForKey:@"over_down"];
        if (indexPath.row == 0) {
            [cell1 LoadData:nil isTitle:YES CId:nil isFoot:NO isBianHua:NO];
            return cell1;
        }
        else {
            NSArray *array = [dic allKeys];
            if (indexPath.row -1< [dic count]) {
                [cell1 LoadData:[dic objectForKey:[array objectAtIndex:indexPath.row -1]] isTitle:NO CId:[array objectAtIndex:indexPath.row -1] isFoot:NO isBianHua:YES];
            }
            else {
                [cell1 LoadData:nil isTitle:NO];
                cell1.contentView.backgroundColor = [UIColor whiteColor];
                
            }
            return cell1;
        }

	}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (tableView == tableView1) {
		return 37;
	}
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == tableView1) {
		if (indexPath.section == 0) {
			return 30;
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
	}
    if (tableView == tableView2) {
        if (indexPath.row != 0) {
            return 50;
        }
    }
    if (tableView == tableView3) {
        if (indexPath.row != 0) {
            return 50;
        }
    }
    if (tableView == tableView4) {
        if (indexPath.row != 0) {
            return 50;
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
        sectionHeaderView.frame = CGRectMake(0, 0, 320, 37);
        
        UIButton *tmpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tmpButton setFrame:CGRectMake(280, -2, 35, 35)];
        [tmpButton setImage:UIImageGetImageFromName(@"yuceshang.png")forState:UIControlStateNormal];
        [tmpButton setImage:UIImageGetImageFromName(@"yucexia.png") forState:UIControlStateSelected];
        tmpButton.tag = section;
        sectionHeaderView.tag = section;
        [sectionHeaderView addTarget:self action:@selector(openChange:) forControlEvents:UIControlEventTouchUpInside];
        tmpButton.userInteractionEnabled = NO;
        [tmpButton setSelected:buffer[section]];
        [sectionHeaderView addSubview:tmpButton];
		sectionHeaderView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"yucezhanji.png")];
        
        UILabel *tmpLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 300, 36)];
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
    if (indexPath.row == 0) {
        return;
    }
    if (tableView == tableView2) {
        NSDictionary *dic = [[dataDic objectForKey:@"detail"] objectForKey:@"europe"];
        NSArray *array = [dic allKeys];
        NSDictionary *dic2 = [[dataDic objectForKey:@"detail"] objectForKey:@"europe_change"] ;
        NSArray *array2 = [dic2 objectForKey:[array objectAtIndex:indexPath.row -1]];
        if ([array2 count]) {
            LanQiuBianhuaAroundViewController *info = [[LanQiuBianhuaAroundViewController alloc] init];
            info.dataDic = self.dataDic;
            info.dataArray = array2;
            info.isOuPei = YES;
            info.cid = [array objectAtIndex:indexPath.row -1];
            [self.navigationController pushViewController:info animated:YES];
            info.title = @"欧赔-赔率变化";
            [info release];
        }
        
    }
    else if (tableView == tableView3) {
        NSDictionary *dic = [[dataDic objectForKey:@"detail"] objectForKey:@"asian"];
        NSArray *array = [dic allKeys];
        NSDictionary *dic2 = [[dataDic objectForKey:@"detail"] objectForKey:@"asian_change"];
        NSArray *array2 = [dic2 objectForKey:[array objectAtIndex:indexPath.row -1]];
        if ([array2 count]) {
            LanQiuBianhuaAroundViewController *info = [[LanQiuBianhuaAroundViewController alloc] init];
            info.dataDic = self.dataDic;
            info.dataArray = array2;
            info.isOuPei = NO;
            info.cid = [array objectAtIndex:indexPath.row -1];
            [self.navigationController pushViewController:info animated:YES];
            info.title = @"亚赔-赔率变化";
            [info release];
        }
        
    }
    else if (tableView == tableView4) {
        NSDictionary *dic = [[dataDic objectForKey:@"detail"] objectForKey:@"over_down"];
        NSArray *array = [dic allKeys];
        NSDictionary *dic2 = [[dataDic objectForKey:@"detail"] objectForKey:@"over_down_change"];
        NSArray *array2 = [dic2 objectForKey:[array objectAtIndex:indexPath.row -1]];
        if ([array2 count]) {
            LanQiuBianhuaAroundViewController *info = [[LanQiuBianhuaAroundViewController alloc] init];
            info.dataDic = self.dataDic;
            info.isOuPei = NO;
            info.dataArray = array2;
            info.cid = [array objectAtIndex:indexPath.row -1];
            [self.navigationController pushViewController:info animated:YES];
            info.title = @"大小-赔率变化";
            [info release];
        }
        
    }
    
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
    NSString *host = [dataDic objectForKey:@"host_name"];
    if ([host length] > 4) {
        host = [host substringToIndex:4];
    }
    homeLabel.text = host;
    homeLabel.frame = CGRectMake(200 + [homeLabel.text sizeWithFont:homeLabel.font].width/2, 85, 60, 18);
    
    NSString *guest = [dataDic objectForKey:@"guest_name"];
    if ([guest length] > 4) {
        guest = [guest substringToIndex:4];
    }
    visitLabel.text = guest;
    visitLabel.frame = CGRectMake(-15 +  [visitLabel.text sizeWithFont:visitLabel.font].width/2, 85, 60, 18);
    
	HostTeamId = [[dataDic objectForKey:@"host_id"]intValue];
	GuestTeamId = [[dataDic objectForKey:@"guest_id"]intValue];;
	[homeImageView setImageWithURL:[dataDic objectForKey:@"host_logo"]];
	[visitImageView setImageWithURL:[dataDic objectForKey:@"guest_logo"]];
	timeLabel.text = [dataDic objectForKey:@"match_time"];
	nameLabe.text = [dataDic objectForKey:@"league_name"];
	[tableView1 reloadData];
	[tableView2 reloadData];
	[tableView3 reloadData];
	[tableView4 reloadData];
	
	
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
	self.dataDic = nil;
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