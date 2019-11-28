//
//  JingPinTuiJianViewController.m
//  caibo
//
//  Created by zhang on 1/9/13.
//
//

#import "JingPinTuiJianViewController.h"
#import "Info.h"
#import "JinPinTuiJianCell.h"
#import "NetURL.h"
#import "JSON.h"
#import "JinPinTuiJianData.h"

@interface JingPinTuiJianViewController ()

@end

@implementation JingPinTuiJianViewController

@synthesize moreCell;
@synthesize mRefreshView;
@synthesize httprequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    isAllRefresh = NO;
    JPdataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.CP_navigation.title = @"精品推荐";
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    [self requestHttpApp];//网络请求
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height - 15) style:UITableViewStylePlain];
    myTableView.autoresizesSubviews = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.mainView addSubview:myTableView];
    
    //下拉刷新
    CBRefreshTableHeaderView *headerview = [[CBRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -(myTableView.frame.size.height), myTableView.frame.size.width, myTableView.frame.size.height)];
	self.mRefreshView = headerview;
	mRefreshView.backgroundColor = [UIColor clearColor];
	mRefreshView.delegate = self;
	[myTableView addSubview:mRefreshView];
	[headerview release];
            
}

- (void)doBack
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark myTableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [JPdataArray count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (!(indexPath.row == [JPdataArray count])) {
        return 50.0;
    }else{
    
        return 50.0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!(indexPath.row == [JPdataArray count])) {
        
        NSString *CellIdentifier = @"JPTJCell";
        JinPinTuiJianCell *cell =(JinPinTuiJianCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil) {
            
            cell = [[[JinPinTuiJianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        JinPinTuiJianData * jpdata = [JPdataArray objectAtIndex:indexPath.row];
        cell.jpdata = jpdata;

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;

    }else{
    
        NSString *CellIdentifier = @"MoreLoadCell";
		MoreLoadCell *cell1 = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell1 == nil) {
			cell1 = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			[cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
		}
		if (moreCell == nil) {
			self.moreCell = cell1;
		}
        if([tableView numberOfRowsInSection:indexPath.section] > 1)
        {
            [moreCell spinnerStartAnimating];
            [self requestHttpApp];
        }
        
		
		return cell1;
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (!(indexPath.row == [JPdataArray count])) {
        
        JinPinTuiJianData *jpdata = [JPdataArray objectAtIndex:indexPath.row];
        NSLog(@"%@",jpdata.appPath);
        NSURL *jpURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",jpdata.appPath]];
        [[UIApplication sharedApplication] openURL:jpURL];
        
//        NSURL *jpURL = [NSURL URLWithString:[NSString stringWithFormat:@"appPath=%@",jpdata.appPath]];
//        BOOL b = [[UIApplication sharedApplication] canOpenURL:jpURL];
//        if (b) {
//            
//            [[UIApplication sharedApplication] openURL:jpURL];
//        }else {
//        
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn"]];
//            //[[UIApplication sharedApplication] openURL:jpURL];
//        }
        
    }else{
    
        [moreCell spinnerStartAnimating];
        [self requestHttpApp];
    }
    
}

#pragma mark requestHttpApp
- (void)requestHttpApp {
    
    page = page+1;
    if (isLoading) {
        
        page = 1;
        
    }
    
    NSString *pagesize;
    if (page ==1) {
        pagesize = @"25";
    }else{
        pagesize = @"20";
    }
    
    
    [httprequest clearDelegatesAndCancel];
//    NSString * userid = @"";
//    if ([[[Info getInstance] userId] intValue] == 0) {
//        userid = @"";
//    }else{
//        userid =[[Info getInstance] userId];
//    }
    self.httprequest = [ASIHTTPRequest requestWithURL:[NetURL CPgetAppInfoList:[[Info getInstance] userId] pageNum:[NSString stringWithFormat:@"%d", (int)page] app_type:@"1" pageSize:pagesize]];
    [httprequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httprequest setDelegate:self];
    [httprequest setDidFinishSelector:@selector(redRequesDidFinishSelector:)];
    [httprequest setNumberOfTimesToRetryOnTimeout:2];
    [httprequest startAsynchronous];
    
}


- (void)redRequesDidFinishSelector:(ASIHTTPRequest *)request{
    
    NSString *responseString = [request responseString];
    if (responseString && ![responseString isEqualToString:@"fail"]) {
    if (isLoading) {
        
        [JPdataArray removeAllObjects];
        
    }

    
        NSDictionary *JPDic = [responseString JSONValue];
        NSArray * array = nil;
        if (JPDic.count) {
            array = [JPDic objectForKey:@"appList"];
            //NSString * jpfee = [JPDic objectForKey:@"fee"];
            
            for (NSDictionary *dic in array) {
                JinPinTuiJianData *JPdata = [[JinPinTuiJianData alloc] init];
                JPdata.appName = [dic objectForKey:@"appName"];
                JPdata.reMark = [dic objectForKey:@"remark"];
                JPdata.rewardFee = [dic objectForKey:@"rewardFee"];
                JPdata.logoMidPath = [dic objectForKey:@"logoMidPath"];
                JPdata.appInfoId = [dic objectForKey:@"appInfoId"];
                JPdata.appFileSize = [dic objectForKey:@"appFileSize"];
                JPdata.appPath = [dic objectForKey:@"appPath"];
                
                [JPdataArray addObject:JPdata];
                [JPdata release];
            }
            [myTableView reloadData];
        }
        
    
        
//    [myTableView reloadData];
    [moreCell spinnerStopAnimating];
    [mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
    isAllRefresh = NO;
    isLoading = NO;
    if ([array count] == 0) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [moreCell spinnerStopAnimating];
        [moreCell setInfoText:@"加载完毕"];
    }
    
    }
}



#pragma mark CBRefreshTableHeaderDelegate

// 刷新发送请求
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView*)view
{
    isAllRefresh = YES;
    isLoading = YES;
    [self requestHttpApp];//网络请求
}


// 判断是否正在刷新状态
- (BOOL)CBRefreshTableHeaderDataSourceIsLoading:(CBRefreshTableHeaderView*)view
{
	return isLoading; // should return if data source model is reloading
}

// 最近更新时间
- (NSDate*)CBRefreshTableHeaderDataSourceLastUpdated:(CBRefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed
}

// 数据接收完成调用
- (void)dismissRefreshTableHeaderView
{
    isLoading = NO;
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:myTableView];
}


#pragma mark SvrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	
	[mRefreshView CBRefreshScrollViewDidScroll:scrollView];
	
}


// 下拉结束时调用 停在正在更新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (myTableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
        if (!isAllRefresh) {
			[self performSelector:@selector(requestHttpApp) withObject:nil afterDelay:0.5];//网络请求
            [moreCell spinnerStartAnimating];
        }
	}
	[mRefreshView CBRefreshScrollViewDidEndDragging:scrollView];
	
}



- (void)dealloc {
    [httprequest clearDelegatesAndCancel];
    [httprequest release];
    [JPdataArray release];
    [myTableView release];
    [mRefreshView release];
    
    [super dealloc];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    