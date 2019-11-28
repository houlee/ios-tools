//
//  MatchDetailViewController.m
//  caibo
//
//  Created by user on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MatchDetailViewController.h"
#import "MatchDetailCell.h"
#import "MatchDetail.h"
#import "GoalNotice.h"
#import "QuartzCore/QuartzCore.h"
#import "Info.h"
#import "CheckNetwork.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "ResultString.h"
#import "MobClick.h"

#define GOALNOTICE         @"加入我的关注"
#define CANCELGOALNOTICE   @"从我的关注移除"


@implementation MatchDetailViewController

@synthesize mTableView, matchDetail, strGoalNotice; 
@synthesize mNoticeButton, mMatchDetailArray;
@synthesize userId, matchId, lotteryId, issue, start;
@synthesize matchType;
@synthesize shouldShowSwitch;
@synthesize mRequest;
@synthesize section_id;
NSString *dataGoalNotice = nil;


- (void)viewDidLoad
{
	[super viewDidLoad];
	[self sendMatchDetailRequest];
	
    [self.CP_navigation setTitle:@"赛事详情"];
    
	//返回
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(back:)];
	self.CP_navigation.leftBarButtonItem = leftItem;
	
	//刷新
	UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"刷新" Target:self action:@selector(refresh) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
	self.CP_navigation.rightBarButtonItem = rightItem;
	
	[self.mainView setBackgroundColor: [UIColor colorWithPatternImage: UIImageGetImageFromName(@"bg_scorelive.jpg")]];
   
    
    //判断赛事在pptv是否存在，存在则播放
     #ifdef  isCaiPiao365AndPPTV
    if ([section_id length]) {
        
        UIButton *pptvButton = [UIButton buttonWithType:UIButtonTypeCustom];
        pptvButton.frame = CGRectMake(250, 10, 52, 29.5);
        [pptvButton setImage:UIImageGetImageFromName(@"JRGZLOGO960.png") forState:UIControlStateNormal];
        [pptvButton addTarget:self action:@selector(goPPTV) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:pptvButton];
    }

#else
#endif
    
    
    
	//表格
	UITableView *tableView = [[UITableView alloc] initWithFrame: CGRectMake(8, 57, 304, 337) 
														  style: UITableViewStylePlain];
//	tableView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
#ifdef isCaiPiaoForIPad
    tableView.frame = CGRectMake(43, 57, 304, 337);
    self.mainView.backgroundColor = [UIColor whiteColor];
#endif
	tableView.layer.masksToBounds = YES;
	tableView.layer.cornerRadius = 8.0;
	tableView.layer.borderWidth = 1.2;
	tableView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	tableView.opaque = NO;
	tableView.delegate = self;
	tableView.dataSource = self;
	[tableView reloadData];
	tableView.bounces = NO;
	self.mTableView = tableView;
	[self.mainView addSubview: self.mTableView];
	[tableView release];
}

//pptv播放
//- (void)pptvPlay{
//
//    
//    NSURL *pptvURL = [NSURL URLWithString:[NSString stringWithFormat:@"pptvsports://from=caipiao365&sectionid=%@",@"111"]];
//    BOOL b = [[UIApplication sharedApplication] canOpenURL:pptvURL];
//    if (b) {
//        [[UIApplication sharedApplication] openURL:pptvURL];
//    }
//    else if (b) {
//        NSURL *pptvURL = [NSURL URLWithString:@"pptvsports://from=caipiao365"];
//        [[UIApplication sharedApplication] openURL:pptvURL];
//    }
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/pptv-zui-xin-dian-ying-dian/id574381581?mt=8"]];
//    
//
//}
- (IBAction)back: (id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
	[self dismissViewControllerAnimated: YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)noticeSwtichChanged:(UISwitch *)sender {
	if (sender.on) {
		[self sendAddGoalNotice];
	}
	else {
		[self sendCancelGoalNotice];
	}

}

- (void)goPPTV {
    NSURL *pptvURL = [NSURL URLWithString:[NSString stringWithFormat:@"pptvsports://from=caipiao365&sectionid=%@",self.section_id]];

    if ([[UIApplication sharedApplication] canOpenURL:pptvURL]) {
        [[UIApplication sharedApplication] openURL:pptvURL];
    }
    else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/pptv-zui-xin-dian-ying-dian/id574381581?mt=8"]];
    }
    
}

- (IBAction)noticeChanged: (id)sender
{
	if ([[[Info getInstance] userId] isEqualToString:CBGuiteID]||[[[Info getInstance] userId] intValue] == 0) {
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
		[cai showMessage:@"登录后可用"];
		return;
	}
	if ([strGoalNotice isEqual: GOALNOTICE]){
        if ([matchDetail.lotteryId isEqualToString:@"300"]) {
            [MobClick event:@"event_bifenzhibo_zucai_xiangqing_guanzhu"];
        }
        else if ([matchDetail.lotteryId isEqualToString:@"201"]) {
            [MobClick event:@"event_bifenzhibo_jingcai_xiangqing_guanzhu"];
        }
        else if ([matchDetail.lotteryId isEqualToString:@"400"]) {
            [MobClick event:@"event_bifenzhibo_beidan_xiangqing_guanzhu"];
        }
		[self sendAddAttention];
		//strGoalNotice = GOALNOTICE;
	}
	else if([strGoalNotice isEqual: CANCELGOALNOTICE]){
        if ([matchDetail.lotteryId isEqualToString:@"300"]) {
            [MobClick event:@"event_bifenzhibo_zucai_xiangqing_yichu"];
        }
		[self sendCancelAttention];
		//[self sendAddGoalNotice];
		//strGoalNotice = CANCELGOALNOTICE;
	}
	
	//[mNoticeButton setTitle: strGoalNotice forState: UIControlStateNormal];
	
	//[mNoticeButton addTarget: self action: @selector(noticeChanged:) forControlEvents: UIControlEventTouchUpInside];
}


- (IBAction)refresh{
	
	[self sendMatchDetailRequest];
	
	[self.mTableView reloadData];
}


#pragma mark AttentionRequest

// 取消关注
- (void)sendCancelAttention
{
	if ([CheckNetwork isExistenceNetwork])
	{
		[[ProgressBar getProgressBar] show:@"正在取消关注..." view:self.mainView];
        [ProgressBar getProgressBar].mDelegate = self;
        
        if ([self mRequest])
        {
            [mRequest clearDelegatesAndCancel];
        }
        self.userId = [[Info getInstance] userId];
        self.mRequest = [ASIHTTPRequest requestWithURL: [NetURL CBcancelAttentionMatch:userId MatchId:matchId LotteryId:lotteryId Issue:issue]];
		[mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		[mRequest setDelegate:self];
		[mRequest setDidFinishSelector:@selector(didCancelAttention:)];
		[mRequest setNumberOfTimesToRetryOnTimeout:2];
		[mRequest startAsynchronous];
	}
}

- (void)didCancelAttention:(ASIHTTPRequest*)request 
{
	NSString* responseString = [request responseString];
	NSString *result = [ResultString resultStringByParsing:responseString];
	if ([result isEqualToString:@"succ"]) 
    {
		strGoalNotice = GOALNOTICE;
        [[ProgressBar getProgressBar] setTitle:@"取消成功！"];
        [self performSelector:@selector(dismissProgressBar) withObject:nil afterDelay:1];
    }
    else 
    {
		strGoalNotice = CANCELGOALNOTICE;
        [[ProgressBar getProgressBar] setTitle:@"取消失败！"];
        [self performSelector:@selector(dismissProgressBar) withObject:nil afterDelay:1];
    }
	[mNoticeButton setTitle: strGoalNotice forState: UIControlStateNormal];
}

- (void)prograssBarBtnDeleate:(NSInteger)type
{
    [[ProgressBar getProgressBar]  dismiss];
}

// 关闭进度条
- (void) dismissProgressBar
{
    [[ProgressBar getProgressBar]  dismiss];
}

// 关注
- (void)sendAddAttention
{
	if ([CheckNetwork isExistenceNetwork])
	{
        [[ProgressBar getProgressBar]  show:@"正在添加关注..." view:self.mainView];
        [ProgressBar getProgressBar].mDelegate = self;
        
		if ([self mRequest])
        {
            [mRequest clearDelegatesAndCancel];
        }
		self.userId = [[Info getInstance] userId];
        self.mRequest = [ASIHTTPRequest requestWithURL: [NetURL CBattentionMatch:userId MatchId:matchId LotteryId:lotteryId Issue:issue]];
		[mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		[mRequest setDelegate:self];
		[mRequest setDidFinishSelector:@selector(didAddAttention:)];
		[mRequest setNumberOfTimesToRetryOnTimeout:2];
		[mRequest startAsynchronous];
	}
}

-(void)didAddAttention:(ASIHTTPRequest*)request
{
	NSString* responseString = [request responseString];
	NSString *result = [ResultString resultStringByParsing:responseString];
    if ([result isEqualToString:@"succ"]) 
    {
        strGoalNotice = CANCELGOALNOTICE;
        [[ProgressBar getProgressBar] setTitle:@"关注成功！"];
        [self performSelector:@selector(dismissProgressBar) withObject:nil afterDelay:1];
    }
    else 
    {
		strGoalNotice = GOALNOTICE;
        [[ProgressBar getProgressBar] setTitle:@"关注失败！"];
        [self performSelector:@selector(dismissProgressBar) withObject:nil afterDelay:1];
    }
	[mNoticeButton setTitle: strGoalNotice forState: UIControlStateNormal];
}

//发送增加进球通知
- (void)sendAddGoalNotice
{
	if ([CheckNetwork isExistenceNetwork])
	{

		self.mRequest = [ASIHTTPRequest requestWithURL:
									   [NetURL CBaddGoalNotice: [[Info getInstance] userId] 
													   MatchId: self.matchId 
													 lotteryId: self.lotteryId 
														 issue: self.issue]];
		
		[self.mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		
		[self.mRequest setDelegate:self];
		
		[self.mRequest setDidFinishSelector:@selector(returnAddGoalNoticeData:)];
		
		[self.mRequest setNumberOfTimesToRetryOnTimeout:2];
		
		[self.mRequest startAsynchronous];
	}
}


-(void)returnAddGoalNoticeData:(ASIHTTPRequest*)request
{
	NSString *responseString = [request responseString];
	
	goalNotice = [[GoalNotice alloc] initWithParse: responseString];
	
	if ([goalNotice.goalNoticeStatus isEqual: @"succ"]) {
		
		NSLog(@"AddGoalNotice successfully!\n");
	}
	else if([goalNotice.goalNoticeStatus isEqual: @"fail"]){
		
		NSLog(@"AddGoalNotice fail!\n");
	}

	[goalNotice release];
}


//取消进球通知
- (void)sendCancelGoalNotice
{
	if ([CheckNetwork isExistenceNetwork])
	{
        if ([self mRequest])
        {
            [mRequest clearDelegatesAndCancel];
        }
		
		self.mRequest = [ASIHTTPRequest requestWithURL:
									   [NetURL CBcancelGoalNotice: [[Info getInstance] userId] 
														  MatchId: self.matchId 
														lotteryId: self.lotteryId 
															issue: self.issue]];
		
		[self.mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		
		[self.mRequest setDelegate:self];
		
		[self.mRequest setDidFinishSelector:@selector(returnCancelGoalNoticeData:)];
		
		[self.mRequest setNumberOfTimesToRetryOnTimeout:2];
		
		[self.mRequest startAsynchronous];
	}
	
}


-(void)returnCancelGoalNoticeData:(ASIHTTPRequest*)request
{
	NSString *responseString = [request responseString];
	
	goalNotice = [[GoalNotice alloc] initWithParse: responseString];
	
	if ([goalNotice.goalNoticeStatus isEqual: @"succ"]) {
		
		NSLog(@"CancelGoalNotice successfully!\n");
	}
	else if([goalNotice.goalNoticeStatus isEqual: @"fail"]){
		
		NSLog(@"CancelGoalNotice fail!\n");
	}
	
	[goalNotice release];
}


//发送赛事详情请求
- (void)sendMatchDetailRequest
{
	if ([CheckNetwork isExistenceNetwork])
	{
        if ([self mRequest])
        {
            [mRequest clearDelegatesAndCancel];
        }
		
		self.mRequest = [ASIHTTPRequest requestWithURL:
									   [NetURL CBgetMatchInfo: [[Info getInstance] userId]
													  MatchId: self.matchId
													  LotteryId: self.lotteryId 
													  Issue: self.issue]];
		
		[self.mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		
		[self.mRequest setDelegate:self];
		
		[self.mRequest setDidFinishSelector:@selector(LoadingTableViewData:)];
		
		[self.mRequest setNumberOfTimesToRetryOnTimeout:2];
		
		[self.mRequest startAsynchronous];
	}
}


//赛事详情请求成功回调
-(void)LoadingTableViewData:(ASIHTTPRequest*)request
{
	NSString *responseString = [request responseString];
   	
	if (responseString) {
		
		MatchDetail *mDetail = [[MatchDetail alloc] initWithParse: responseString];

		self.matchDetail = mDetail;
        NSLog(@"oddsWin = %@",self.matchDetail.oddsWin);
		if ([self.matchDetail.oddsWin isEqualToString:@""]) {
            
            self.matchType = MatchTypeNormal;
        }else
            {
            self.matchType = MatchTypeOne;
            }
		[mDetail release];
		
		if (matchDetail.isGoalNotice)
		{
			strGoalNotice = CANCELGOALNOTICE;
		}
		else {
			strGoalNotice = GOALNOTICE;
		}
		
		
		//通知按钮设置
		if (shouldShowSwitch) {
			UIView *V1 = [self.mainView viewWithTag:12311];
			if (!V1) {
				UIView *V = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
				V.backgroundColor = [UIColor clearColor];
				V.tag = 12311;
				UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 100, 30)];
				l.text = @"进球提醒";
				[V addSubview:l];
				l.backgroundColor = [UIColor clearColor];
				[l release];
				UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(140, 10, 40, 30)];
				sw.on = self.matchDetail.isGoalNotice;
				[V addSubview:sw];
				[sw addTarget:self action:@selector(noticeSwtichChanged:) forControlEvents:UIControlEventValueChanged];
				[sw release];
				[self.mainView addSubview:V];
				[V release];
				
			}
		}
		else {
			UIButton *noticeButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 13, 150, 29)];
#ifdef isCaiPiaoForIPad
            noticeButton.frame = CGRectMake(55, 13, 150, 29);
#endif
			if ([self.start isEqual: @"2"]) {
				
				noticeButton.hidden = NO;
			}
			else {
				[self.mNoticeButton removeFromSuperview];
				noticeButton.layer.cornerRadius = 7.0;
				[noticeButton setBackgroundColor: [UIColor colorWithRed:(90)/255.0 green:(120)/255.0 blue:(170)/255.0 alpha:1]];
				[noticeButton setTitle: strGoalNotice forState: UIControlStateNormal];
				[noticeButton.titleLabel setFont: [UIFont fontWithName: @"Helvetica" size: 14]];
				[noticeButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
				[noticeButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
				[noticeButton addTarget: self action: @selector(noticeChanged:) forControlEvents: UIControlEventTouchUpInside];
				self.mNoticeButton = noticeButton;
				[self.mainView addSubview: self.mNoticeButton];
                
			}
			
			[noticeButton release];
		}
		
		[self.mTableView reloadData];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            [mTableView scrollRectToVisible:CGRectMake(0, 20, 304, 337) animated:NO];
            mTableView.scrollEnabled = NO;
        }

	}
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) {
		return 33;
	}
	else if (indexPath.row == 1) {
        if (self.matchType == MatchTypeNormal || !self.matchDetail.oddsWin) {
            return 64;
        }
		return 96;
	}
	else if (indexPath.row == 2) {
		return 30;
	}
	else if (indexPath.row == 3) {
        if (self.matchType == MatchTypeNormal || !self.matchDetail.oddsWin) {
            return 180;
        }
		return 148;
	}
	return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	NSInteger row = [indexPath row];
	NSLog(@"self.matchDetail.oddsWin = %@",self.matchDetail.oddsWin);
	//根据行出入对应表单
	switch (row) {
		case 0:
			CellIdentifier = @"leagueTimeCell";
			break;
		case 1:
            if (self.matchType == MatchTypeNormal || (self.matchDetail.oddsWin == nil)) {
                CellIdentifier = @"asianEurCell";
            }else{
                CellIdentifier = @"asianEurCellWithOdds";
            }
			break;
		case 2:
			CellIdentifier = @"homeAndAwayCell";
			break;
		case 3:
            if (self.matchType == MatchTypeNormal || (self.matchDetail.oddsWin == nil)) {
                CellIdentifier = @"homeAndAwayListCell";
            }else{
                CellIdentifier = @"homeAndAwayListCellWithOdds";
            }
			break;
		case 4:
			CellIdentifier = @"typeCell";
			break;
		default:
			break;
	}
	
	MatchDetailCell *cell = [[[MatchDetailCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	if (self.matchDetail) {
		
		cell.leagueNameLabel.text = matchDetail.leagueName;
		cell.matchTimeLabel.text = matchDetail.matchTime;
		
        if (![matchDetail.asianHome isEqualToString:@""]) {
            cell.asianHomeLabel.text = matchDetail.asianHome;
            cell.asianRangqiuLabel.text = matchDetail.asianRangqiu;
            cell.asianAwayLabel.text = matchDetail.asianAway;
        }else
            {
            cell.asianAwayLabel.text = @"无数据";
            cell.asianRangqiuLabel.text = @"无数据";
            cell.asianAwayLabel.text = @"无数据";
            cell.asianHomeLabel.font = [UIFont fontWithName: @"Helvetica" size: 12];
            cell.asianRangqiuLabel.font = [UIFont fontWithName: @"Helvetica" size: 12];
            cell.asianAwayLabel.font = [UIFont fontWithName: @"Helvetica" size: 12];
            }
       if (![matchDetail.eurWin isEqualToString:@""]) 
           {
           cell.eurWinLabel.text = matchDetail.eurWin;
           cell.eurDrawLabel.text = matchDetail.eurDraw;
           cell.eurLostLabel.text = matchDetail.eurLost;
           }
        else
            {
            cell.eurWinLabel.text = @"无数据";
            cell.eurDrawLabel.text = @"无数据";
            cell.eurLostLabel.text = @"无数据";
            cell.eurWinLabel.font = [UIFont fontWithName: @"Helvetica" size: 12];
            cell.eurDrawLabel.font = [UIFont fontWithName: @"Helvetica" size: 12];
            cell.eurLostLabel.font = [UIFont fontWithName: @"Helvetica" size: 12];
            }
		
		cell.homeLabel.text = matchDetail.home;
		cell.scoreHostLabel.text = matchDetail.scoreHost;
		cell.awayHostLabel.text = matchDetail.awayHost;
		cell.awayLabel.text = matchDetail.away;
        NSLog(@"match = %@1",matchDetail.oddsWin);
        if (![matchDetail.oddsWin isEqualToString:@""]) {
            cell.oddsWinLabel.text = matchDetail.oddsWin;
            cell.oddsDrawLabel.text = matchDetail.oddsDraw;
            cell.oddsLostLabel.text = matchDetail.oddsLost;
        }else
        {
        cell.oddsWinLabel.text = @"无数据";
        cell.oddsDrawLabel.text = @"无数据";
        cell.oddsLostLabel.text = @"无数据";
        cell.oddsWinLabel.font = [UIFont fontWithName: @"Helvetica" size: 12];
        cell.oddsDrawLabel.font = [UIFont fontWithName: @"Helvetica" size: 12];
        cell.oddsLostLabel.font = [UIFont fontWithName: @"Helvetica" size: 12];
        }

	}
	if (row == 3) {
		
		NSInteger homeMsgListCount = [self.matchDetail.homeMsgListArray count];  //主队比赛事件数
		
		if (homeMsgListCount) {
			
			NSInteger leftScrollViewHeight = [self heightByMsgListCount: homeMsgListCount];
			
			[cell.leftScrollView setContentSize:CGSizeMake(152, leftScrollViewHeight)];
			
			for (int i = 0; i < homeMsgListCount; i++) {
				
				MatchDetail *mDetail = [matchDetail.homeMsgListArray objectAtIndex: i];
				
				NSInteger hType = mDetail.homeType;
				UIImageView *imageView = [cell ImageWithFrame: CGRectMake(10, (6 + (6 + 16)*i), 16, 16) 
															image: [self returnImageByType: hType]];
				[cell.leftScrollView addSubview: imageView];
				
				NSInteger hOffset = 0;
				NSString *hStr = [NSString stringWithFormat: @"%@'", mDetail.homeMins];
				if ([hStr length] > 3) {
					hOffset += 6;
				}
				UILabel *homeMinsLabel = [cell LabelWithFrame: CGRectMake(29, 9 + ((6 + 16)*i), 20+hOffset, 16) fontSize: 13 color: [UIColor clearColor]];
				homeMinsLabel.text = hStr;
				[cell.leftScrollView addSubview: homeMinsLabel];
				
				UILabel *homeNameLabel = [cell LabelWithFrame: CGRectMake(50+hOffset, 9 + ((6 + 16)*i), 96, 16) fontSize: 13 color: [UIColor clearColor]];
				homeNameLabel.text = mDetail.homeName;
				[cell.leftScrollView addSubview: homeNameLabel];
			}
		}
				
		NSInteger awayMsgListCount = [self.matchDetail.awayMsgListArray count];  //客队比赛事件数
		
		if (awayMsgListCount) {
			
			NSInteger rightScrollViewHeight = [self heightByMsgListCount: awayMsgListCount];
			
			[cell.rightScrollView setContentSize:CGSizeMake(152, rightScrollViewHeight)];
			
			for (int j = 0; j < awayMsgListCount; j++) {
				
				MatchDetail *aDetail = [matchDetail.awayMsgListArray objectAtIndex: j];
				
				NSInteger aType = aDetail.awayType;
				UIImageView *awayImageView = [cell ImageWithFrame: CGRectMake(10, (6 + (6 + 16)*j), 16, 16) 
															image: [self returnImageByType: aType]];
				[cell.rightScrollView addSubview: awayImageView];
				
				NSInteger aOffset = 0;
				NSString *aStr = [NSString stringWithFormat: @"%@'", aDetail.awayMins];
				if ([aStr length] > 3) {
					aOffset += 6;
				}
				UILabel *awayMinsLabel = [cell LabelWithFrame: CGRectMake(29, 9 + ((6 + 16)*j), 20+aOffset, 16) fontSize: 13 color: [UIColor clearColor]];
				awayMinsLabel.text = aStr;
				[cell.rightScrollView addSubview: awayMinsLabel];
            
				
				UILabel *awayNameLabel = [cell LabelWithFrame: CGRectMake(50+aOffset, 9 + ((6 + 16)*j), 96, 16) fontSize: 13 color: [UIColor clearColor]];
				awayNameLabel.text = aDetail.awayName;
				[cell.rightScrollView addSubview: awayNameLabel];
			}
		}
	}
	
	return cell;
}



//根据比赛事件个数计算UIScrollView视图高度
- (NSInteger)heightByMsgListCount: (NSInteger)count
{
	return (12 + 16*count + 6*(count - 1));
}


//根据获取的type设置图像
- (UIImage *)returnImageByType: (NSInteger)type
{
	NSString *strImageName = @"";
	
	switch (type) {
		case 0:
			strImageName = IMAGE_JINQIU;
			break;
		case 1:
			strImageName = IMAGE_DIANQIU;
			break;
		case 2:
			strImageName = IMAGE_WULONG;
			break;
		case 3:
			strImageName = IMAGE_HUANGPAI;
			break;
		case 4:
			strImageName = IMAGE_HONGPAI;
			break;
		default:
			break;
	}
	
	UIImage *image = UIImageGetImageFromName(strImageName);
	
	[strImageName release];
	
	return image;
}



- (void)dealloc 
{	
	[self.mRequest clearDelegatesAndCancel];
	self.mRequest = nil;
    mTableView.delegate = nil;
	[mTableView release];
	[matchDetail release];
	[mMatchDetailArray release];
	[mNoticeButton release];
	[strGoalNotice release];
	
	[userId release];
	[matchId release];
	[lotteryId release];
	[issue release];
	[start release];
    
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    