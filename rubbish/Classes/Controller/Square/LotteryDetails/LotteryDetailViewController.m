//
//  LotteryDetailViewController.m
//  caibo
//
//  Created by user on 11-10-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LotteryDetailViewController.h"
#import "Info.h"
#import "InsertView.h"
#import "LotteryDetail.h"
#import "CheckNetwork.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"


@implementation LotteryDetailViewController
@synthesize lotteryId, issue, status, lotteryName;
@synthesize mTableView, lotteryDetail, tempDetail, lotteryImage, bottomView;
@synthesize preButton, lateButton;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	NSLog(@"self.lotteryName = %@\n", self.lotteryName);
	self.navigationItem.title = self.lotteryName;
	
	//返回
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(back:)];
	self.navigationItem.leftBarButtonItem = leftItem;
    
	mTableView.separatorStyle = UITableViewCellSeparatorStyleNone; //分隔线
	[self initBottomButton];
	
	receiver = [[ImageStoreReceiver alloc] init];
	self.lotteryDetail = nil;
	self.status = @"0";
	
	[self sendMatchDetailRequest:self.status];
}


- (void)initBottomButton
{
	UIButton *pButton = [[UIButton alloc] initWithFrame:CGRectMake(48, 365, 72, 37)];
	self.preButton = pButton;
	self.preButton.enabled = YES;
	[preButton setImage:UIImageGetImageFromName(@"pre.png") forState:UIControlStateNormal];
	[preButton addTarget:self action:@selector(toPre) forControlEvents:UIControlEventTouchUpInside];
	
	[pButton release];
	
	UIButton *lButton = [[UIButton alloc] initWithFrame:CGRectMake(198, 365, 72, 37)];
	self.lateButton = lButton;
	self.lateButton.enabled = YES;
	[lateButton setImage:UIImageGetImageFromName(@"late.png") forState:UIControlStateNormal];
	[lateButton addTarget:self action:@selector(toLate) forControlEvents:UIControlEventTouchUpInside];
	
	[lButton release];
	
}


- (void)back: (id)sender
{
	[self.navigationController popViewControllerAnimated: YES];
}


- (void)addBottomView
{
	//self.navigationItem.title = lotteryDetail.lotteryName;
	
	mTableView.indicatorStyle = UIScrollViewIndicatorStyleDefault; //滚动条类型
	[mTableView setScrollIndicatorInsets:UIEdgeInsetsMake(0,0,0,-10)];//滚动条隐藏 
	mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine; //分隔线
	mTableView.separatorColor = [UIColor lightGrayColor]; //分隔线颜色
	
	UIImageView *bView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 350, 294, 67)];
	self.bottomView = bView;
	[self.view addSubview:bView];
	[bView release];
	
	[self.view addSubview:preButton];
	[self.view addSubview:lateButton];
}


- (void)toPre
{
	[self sendMatchDetailRequest:@"1"];
}


- (void)toLate
{
	[self sendMatchDetailRequest:@"2"];
}

//发送开奖详情请求
- (void)sendMatchDetailRequest:(NSString *)statu
{
	preButton.enabled = NO;
	lateButton.enabled = NO;
	NSLog(@"\n\nsend data :  id = %@ issue = %@ statu = %@\n\n", self.lotteryId, self.issue, statu);
	if ([CheckNetwork isExistenceNetwork])
	{
		ASIHTTPRequest *httpReuqest = [ASIHTTPRequest requestWithURL: 
									   [NetURL synLotteryDetails: self.lotteryId 
														   issue: self.issue 
														  status: statu 
														  userId:[[Info getInstance] userId]]];
		
		[httpReuqest setDefaultResponseEncoding:NSUTF8StringEncoding];
		[httpReuqest setDelegate:self];
		[httpReuqest setDidFinishSelector:@selector(LoadingTableViewData:)];
		[httpReuqest setNumberOfTimesToRetryOnTimeout:2];
		[httpReuqest startAsynchronous];
	}
}


//开奖详情请求成功回调
-(void)LoadingTableViewData:(ASIHTTPRequest*)request
{
	NSString *responseString = [request responseString];
	NSLog(@"\n\n\n...xx...responseString = %@\n", responseString);
   	
	if (responseString != nil && ![responseString isEqualToString:@"{}"])
	{
		LotteryDetail *lDetail = [[LotteryDetail alloc] initWithParse: responseString];
		
		self.lotteryDetail = nil;
		self.lotteryDetail = lDetail;
		[lDetail release];
	
		self.lotteryId = lotteryDetail.lotteryId;
		self.issue = lotteryDetail.issue;
		[self addBottomView];
		[self.mTableView reloadData];
	}
	else {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil 
															message:@"已经是最新期" 
														   delegate:self 
												  cancelButtonTitle:@"确定" 
												  otherButtonTitles:nil];
		[alertView show];
		[alertView release];
	}

	self.preButton.enabled = YES;
	self.lateButton.enabled = YES;
}


//获取图片
- (UIImage *)LoadImageWithUrl:(NSString *) url
{
    if (imageUrl != url) {
        [imageUrl release];
    }
    imageUrl = [url copy];

	ImageDownloader *store = [caiboAppDelegate getAppDelegate].imageDownloader;
    UIImage *image = [store fetchImage:imageUrl Delegate:receiver Big:NO];
    receiver.imageContainer = self;
	
	return image;
}


//更新图片
- (void)updateImage:(UIImage*)image {
	lotteryImage = image;
	[self.mTableView reloadData];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSString *nStr = lotteryDetail.lotteryName;

	if ([nStr isEqualToString:@"胜负任九"] || [nStr isEqualToString:@"进球彩"] || [nStr isEqualToString:@"半全场"]) 
	{
		return 5;
	}
	else {
		return 3;
	}
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *nStr = lotteryDetail.lotteryName;
	
	if (indexPath.row == 0) {
		return 70;//固定
	}
	else if (indexPath.row == 1)
	{
		if ([nStr isEqualToString:@"胜负任九"] || [nStr isEqualToString:@"进球彩"] || [nStr isEqualToString:@"半全场"])
		{
			if ([nStr isEqualToString:@"胜负任九"])
			{
				return ([lotteryDetail.sales_rx9 isEqualToString:@""]) ? 110 :136;
			}
			else {
				return (lotteryDetail.buyamont != nil) ? 110 : 84;
			}
		}
		else {
			return (lotteryDetail.buyamont != nil) ? 84 : 62;
		}
	}
	
	else if (indexPath.row == 2)
	{
		rowHeightWithAwards = 0;
		if (lotteryDetail.buyamont == nil) {
			rowHeightWithAwards += 22;
		}
		
		if(lotteryDetail.reListArray != nil)
		{
			if ([nStr isEqualToString:@"胜负任九"] || [nStr isEqualToString:@"进球彩"] || [nStr isEqualToString:@"半全场"])
			{
				return (28+[lotteryDetail.reListArray count]*24);;
			}
			else {
				NSInteger num = [lotteryDetail.reListArray count];
				if (num > 7) {
					return (26+num*24);
				}
				else {
					return (196+rowHeightWithAwards);
				}
			}
		}
		else {
			return (196+rowHeightWithAwards);
		}
	}

	if ([nStr isEqualToString:@"胜负任九"] || [nStr isEqualToString:@"进球彩"] || [nStr isEqualToString:@"半全场"])
	{
		if (indexPath.row == 3)
		{
			return 30;//固定
		}
		else if (indexPath.row == 4)
		{
			if (lotteryDetail.reAgainstList != nil)
			{
				NSInteger num = [lotteryDetail.reAgainstList count];
				return (26+num*24);
			}
			else {
				return 0;
			}

		}
		else {
			return 0;
		}
	}

	return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	NSInteger row = [indexPath row];
	
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	if (self.lotteryDetail != nil)
	{
		if (lotteryDetail.picUrl != nil) {
			self.lotteryImage = [self LoadImageWithUrl: lotteryDetail.picUrl] ;
		}
		
		if (row == 0)
		{
			cell.imageView.image = self.lotteryImage;
			[cell.contentView addSubview:[InsertView insertLottery:lotteryDetail.lotteryName 
															 issue:lotteryDetail.issue]];
		}
		else if (row == 1)
		{
			[cell.contentView addSubview:[InsertView insertdate:self.lotteryDetail]];
		}
		else if (row == 2)
		{
			[cell.contentView addSubview:[InsertView insertAwards:lotteryDetail.reListArray]];
		}
		
		if ([lotteryDetail.lotteryName isEqualToString:@"胜负任九"] 
			|| [lotteryDetail.lotteryName isEqualToString:@"进球彩"] 
			|| [lotteryDetail.lotteryName isEqualToString:@"半全场"])
		{
			if (row == 3)
			{
				[cell.contentView addSubview:[InsertView insertAgainstName:lotteryDetail.againstName]];
			}
			else if (row == 4)
			{
				[cell.contentView addSubview:[InsertView insertAgainstNamesList:lotteryDetail.againstNamesList 
																	againstList:lotteryDetail.reAgainstList]];
			}
		}
	}
	
	return cell;
}


- (void)viewDidUnload
{
	self.lotteryId = nil;
	self.issue = nil;
	self.status = nil;
	self.lotteryName = nil;
	self.mTableView = nil;
	self.lotteryDetail = nil;
	self.lotteryImage = nil;
	
    [super viewDidUnload];
}


- (void)dealloc
{
	[lotteryId release];
	[issue release];
	[status release];
	[lotteryName release];
	[mTableView release];
	[lotteryDetail release];
	[tempDetail release];
	[lotteryImage release];
	[bottomView release];
	receiver.imageContainer = nil;
    ImageDownloader *store = [caiboAppDelegate getAppDelegate].imageDownloader;
    [store removeDelegate:receiver forURL:imageUrl];
    [imageUrl release];
	[receiver release];
	[preButton release];
	[lateButton release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    