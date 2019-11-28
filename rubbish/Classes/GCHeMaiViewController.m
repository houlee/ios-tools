//
//  GCHeMaiViewController.m
//  caibo
//
//  Created by  on 12-6-25.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "GCHeMaiViewController.h"
#import "Info.h"
#import "UINavigationController+Category.h"
#import "caiboAppDelegate.h"
#import "GCHeMaiInfoViewController.h"
#import "GCBettingViewController.h"
#import "GCJCBetViewController.h"
#import "GouCaiShuangSeQiuViewController.h"
#import "GCHeMaiListViewController.h"
#import "MyLottoryViewController.h"
#import "GC_BJDanChangViewController.h"
#import "DaLeTouViewController.h"
#import "FuCai3DViewController.h"
#import "FansViewController.h"
#import "PaiWuOrQiXingViewController.h"
#import "22Xuan5ViewController.h"
#import "QIleCaiViewController.h"
#import "Pai3ViewController.h"


@implementation GCHeMaiViewController
@synthesize seachTextListarry;
@synthesize systimestr;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

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
- (void)titleViewSearch{
    UIView * titlev = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    titlev.hidden = NO;
    titlev.backgroundColor = [UIColor clearColor];
    
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 30)];
    titleLabel.text = @"合买彩票";
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.adjustsFontSizeToFitWidth=YES;
    titleLabel.textAlignment = NSTextAlignmentRight;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    [titlev addSubview:titleLabel];
    [titleLabel release];
    
    UIButton * seabut = [UIButton buttonWithType:UIButtonTypeCustom];
    seabut.frame = CGRectMake(160, 12, 41, 19);
    [seabut setImage:UIImageGetImageFromName(@"sachet_2.png") forState:UIControlStateNormal];
    [seabut addTarget:self action:@selector(pressSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    [titlev addSubview:seabut];
    // [titlev addSubview:seabut];
    self.navigationItem.titleView = titlev;
    
    [titlev release];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isQuxiao = NO;
}
#pragma mark -
#pragma mark UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isQuxiao = YES;
	[searchDC.searchResultsTableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    if (PKsearchBar.superview && isQuxiao) {
        [PKsearchBar resignFirstResponder];
        [PKsearchBar removeFromSuperview];
    }
}

-(void)sendSeachRequest:(NSString*)keywords
{	
    isQuxiao = NO;
	FansViewController * seachPerson = [[FansViewController alloc] initWithKeywords:keywords];
	[seachPerson setHidesBottomBarWhenPushed:YES];
	seachPerson.cpthree = YES;
    seachPerson.titlestring = keywords;
    seachPerson.titlebool = YES;
	[self.navigationController pushViewController:seachPerson animated:NO];
	[seachPerson release];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	if ([searchBar text]&&![searchBar.text  isEqualToString:@""]) {
		[self.seachTextListarry removeObject:searchBar.text];
		if ([self.seachTextListarry count]==10) {
			
			[seachTextListarry lastObject];
			
		}
		[self.seachTextListarry insertObject:searchBar.text atIndex:0]; 
		NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
		NSString *path=[paths    objectAtIndex:0];
		NSString *plistPath = [path stringByAppendingPathComponent:@"CPThree"];
		[self.seachTextListarry writeToFile:plistPath atomically:YES];
		[self.searchDisplayController.searchResultsTableView reloadData];
		
	}
	[self sendSeachRequest:searchBar.text];
	isQuxiao = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    isQuxiao = YES;
    [PKsearchBar resignFirstResponder];
	[PKsearchBar removeFromSuperview];
}


- (void)pressSearch:(id)sender{
    if (!PKsearchBar) {
		PKsearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
		[self.view addSubview:PKsearchBar];
		PKsearchBar.delegate = self;
		PKsearchBar.showsCancelButton = YES;
		searchDC = [[UISearchDisplayController alloc] initWithSearchBar:PKsearchBar contentsController:self];
		searchDC.searchResultsDataSource = self;
		searchDC.searchResultsDelegate = self;
	}
    isQuxiao = NO;
	[self.view addSubview:PKsearchBar];
	[PKsearchBar becomeFirstResponder];
    
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.title = @"合买彩票";
    
    
    UIBarButtonItem *right = [Info longItemInitWithTitle:@"普通模式" Target:self action:@selector(myInfo)];
	self.navigationItem.rightBarButtonItem = right;
    
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    self.navigationItem.leftBarButtonItem = left;
    
    self.title = @"合买彩票";
//	[self titleViewSearch];
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgimage.image = UIImageGetImageFromName(@"login_bg.png");
    [self.view addSubview:bgimage];
    [bgimage release];
    
    
    imageArr = [[NSArray alloc] initWithObjects:@"gc_jczq.png", @"gc_sfc.png", @"gc_rxj.png", @"gc_bjdc.png",@"gc_jclq.png", @"gcscjq.png",  @"gc_lcbqc.png", nil];
    
    shuziArr = [[NSArray alloc] initWithObjects:@"gc_hmscq.png", @"gc_hmfc3d_0.png", @"gc_hmcjdlt_0.png", @"gc_hmqlc_0.png", @"hemaipailie5.png", @"hemaiqixingcai.png", @"gc_hm22x5_0.png", @"hmpai3.png", nil];
    
    
    zulancaiBut = [UIButton buttonWithType:UIButtonTypeCustom];
    zulancaiBut.frame = CGRectMake(52, 8, 72, 32);
    zulancaiBut.selected = YES;
    zulancaiBut.tag = 100;
    [zulancaiBut setImage:UIImageGetImageFromName(@"GouCaibtn4_0.png") forState:UIControlStateSelected];
	[zulancaiBut setImage:UIImageGetImageFromName(@"GouCaibtn4_1.png") forState:UIControlStateHighlighted];
	[zulancaiBut setImage:UIImageGetImageFromName(@"GouCaibtn4.png") forState:UIControlStateNormal];
    [zulancaiBut addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * zulanlabel = [[UILabel alloc] initWithFrame:zulancaiBut.bounds];
    zulanlabel.text = @"足篮彩";
    zulanlabel.textAlignment = NSTextAlignmentCenter;
    zulanlabel.backgroundColor = [UIColor clearColor];
    zulanlabel.textColor = [UIColor whiteColor];
    zulanlabel.font = [UIFont systemFontOfSize:15];
    [zulancaiBut addSubview:zulanlabel];
    [zulanlabel release];
    [self.view addSubview:zulancaiBut];
    
    shuzicaiBut = [UIButton buttonWithType:UIButtonTypeCustom];
    shuzicaiBut.frame = CGRectMake(124, 8, 72, 32);
    shuzicaiBut.tag = 101;
    [shuzicaiBut setImage:UIImageGetImageFromName(@"GouCaibtn5_0.png") forState:UIControlStateSelected];
	[shuzicaiBut setImage:UIImageGetImageFromName(@"GouCaibtn5.png") forState:UIControlStateNormal];
	[shuzicaiBut setImage:UIImageGetImageFromName(@"GouCaibtn5_1.png") forState:UIControlStateHighlighted];
    [shuzicaiBut addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * shuzilabel = [[UILabel alloc] initWithFrame:shuzicaiBut.bounds];
    shuzilabel.text = @"数字彩";
    shuzilabel.textAlignment = NSTextAlignmentCenter;
    shuzilabel.backgroundColor = [UIColor clearColor];
    shuzilabel.textColor = [UIColor whiteColor];
    shuzilabel.font = [UIFont systemFontOfSize:15];
    [shuzicaiBut addSubview:shuzilabel];
    [shuzilabel release];
    [self.view addSubview:shuzicaiBut];
    
    myhemaiBut = [UIButton buttonWithType:UIButtonTypeCustom];
    myhemaiBut.frame = CGRectMake(196, 8, 72, 32);
    myhemaiBut.tag = 102;
    [myhemaiBut setImage:UIImageGetImageFromName(@"GouCaibtn6_0.png") forState:UIControlStateSelected];
	[myhemaiBut setImage:UIImageGetImageFromName(@"GouCaibtn6.png") forState:UIControlStateNormal];
	[myhemaiBut setImage:UIImageGetImageFromName(@"GouCaibtn6_1.png") forState:UIControlStateHighlighted];
    [myhemaiBut addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * myhemailabel = [[UILabel alloc] initWithFrame:myhemaiBut.bounds];
    myhemailabel.text = @"我的合买";
    myhemailabel.textAlignment = NSTextAlignmentCenter;
    myhemailabel.backgroundColor = [UIColor clearColor];
    myhemailabel.textColor = [UIColor whiteColor];
    myhemailabel.font = [UIFont systemFontOfSize:15];
    [myhemaiBut addSubview:myhemailabel];
    [myhemailabel release];
    [self.view addSubview:myhemaiBut];
    
    
    myTableViewCai = [[UITableView alloc] initWithFrame:CGRectMake(14, 47, 72, self.view.bounds.size.height -47)];
    myTableViewCai.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableViewCai.delegate = self;
    myTableViewCai.dataSource = self;
    myTableViewCai.tag = 77;
    myTableViewCai.backgroundColor = [UIColor clearColor];
    [myTableViewCai setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableViewCai.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableViewCai];
    
    myTableViewHeFa = [[UITableView alloc] initWithFrame:CGRectMake(86, 47, 220, self.view.bounds.size.height - 47)];
    myTableViewHeFa.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableViewHeFa.delegate = self;
    myTableViewHeFa.dataSource = self;
    myTableViewHeFa.tag = 88;
    myTableViewHeFa.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableViewHeFa.backgroundColor = [UIColor clearColor];
    myTableViewHeFa.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableViewHeFa];
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"CPThree"];
    NSMutableArray * array = [ [ NSMutableArray alloc ] initWithContentsOfFile:plistPath ];
    if (array) {
        self.seachTextListarry = array;
    }
    else {
        self.seachTextListarry =[NSMutableArray array];
    }
    [array release];
    
}

#pragma mark - 三个按钮的点击事件
- (void)pressButton:(UIButton *)sender{
    if (sender.tag == 102) {
		MyLottoryViewController * hemai = [[MyLottoryViewController alloc] init];
		hemai.myLottoryType = MyLottoryTypeMeHe;
		hemai.title = @"我的合买";
		[self.navigationController pushViewController:hemai animated:YES];
		[hemai release];
		return;
	}
	
    zulancaiBut.selected = NO;
    shuzicaiBut.selected = NO;
    myhemaiBut.selected = NO;
    sender.selected = YES;
    
    [myTableViewCai reloadData];
    [myTableViewHeFa reloadData];
}


#pragma mark - UIBarButtonItem
- (void)doBack{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}


- (void)myInfo{
    [self.navigationController popViewControllerAnimatedWithTransition:UIViewAnimationTransitionFlipFromRight];
    
}


#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		return [self.seachTextListarry count];
	}

    
    if (zulancaiBut.selected == YES) {
        if ([tableView isEqual:myTableViewCai]) {
            return [imageArr count];
        }
        if ([tableView isEqual:myTableViewHeFa]) {
            return 14;
        }
        
    }
    
    if (shuzicaiBut.selected == YES) {
        if ([tableView isEqual:myTableViewCai]) {
            return 8;
        }
        if ([tableView isEqual:myTableViewHeFa]) {
            return 16;
        }
        
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		return 44;
	}
    if ([tableView isEqual:myTableViewCai]) {
        return 84;
    }
    if ([tableView isEqual:myTableViewHeFa]) {
        return 42;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        static NSString *CellIdentifier = @"SearchCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        
        NSString *text = [self.seachTextListarry objectAtIndex:indexPath.row]; 
        
        cell.textLabel.text =text ;
        
        return cell;
        
        
    }else if ([tableView isEqual:myTableViewCai]) {
        NSString * cellid = @"caizhong";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            UIImageView * cellbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 72, 82)];
            cellbgimage.tag = 102;
            [cell.contentView addSubview:cellbgimage];
            
            [cellbgimage release];
        }
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        NSString * imagestr = @"";
        if (zulancaiBut.selected == YES) {
            imagestr  = [imageArr objectAtIndex:indexPath.row];
        }else if(shuzicaiBut.selected == YES){
            imagestr  = [shuziArr objectAtIndex:indexPath.row];
        }
        
        
        UIImageView * cellbgimage = (UIImageView *)[cell.contentView viewWithTag:102];
        cellbgimage.image = UIImageGetImageFromName(imagestr);
        
        return cell;
    }
    if ([tableView isEqual:myTableViewHeFa]) {
        NSString * cellid = @"hemai";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            UIImageView * cellimagebg = [[UIImageView alloc] init];
            [cell.contentView addSubview:cellimagebg];
            cellimagebg.tag = 101;
            cellimagebg.backgroundColor = [UIColor clearColor];
            [cellimagebg release];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        UIImageView *cellimagebg = (UIImageView *)[cell.contentView viewWithTag:101];
        if (indexPath.row % 2 == 0) {
            cellimagebg.frame = CGRectMake(0, 6, 220, 36);
            cellimagebg.image = UIImageGetImageFromName(@"gc_hmdt.png");
        }else {
            cellimagebg.frame = CGRectMake(0, 0, 220, 36);
            cellimagebg.image = UIImageGetImageFromName(@"gc_fqhm.png");
        }
        
        return cell;
    }
    return nil;
}

- (void)otherLottoryViewController:(NSInteger)indexd title:(NSString *)titleStr lotteryType:(NSInteger)lotype lotteryId:(NSString *)loid{
    if ([[[Info getInstance] userId] intValue] == 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
        return;
    }
    GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
    hemaiinfo.title = titleStr;
    hemaiinfo.lotteryType = lotype;
    hemaiinfo.lotteryId = loid;
    hemaiinfo.paixustr = @"DD";
    
    
    GCHeMaiInfoViewController * hemaiinfotwo = [[GCHeMaiInfoViewController alloc] init];
    hemaiinfotwo.title = titleStr;
    hemaiinfotwo.lotteryType = lotype;
    hemaiinfotwo.lotteryId = loid;
    hemaiinfotwo.paixustr = @"AD";
    
    GCHeMaiInfoViewController * hongren = [[GCHeMaiInfoViewController alloc] init];
    hongren.title = titleStr;
    hongren.lotteryType = lotype;
    hongren.lotteryId = loid;
    hongren.paixustr = @"HR";
    
   
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:hemaiinfo, hemaiinfotwo,hongren, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"最新"];
    [labearr addObject:@"人气"];
    [labearr addObject:@"红人榜"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"ggzx.png"];
    [imagestring addObject:@"ggrq.png"];
    [imagestring addObject:@"gghrb.png"];
    
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"ggzx_1.png"];
    [imageg addObject:@"ggrq_1.png"];
    [imageg addObject:@"gghrb_1.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    tabc.selectedIndex = indexd;
    tabc.delegateCP = self;
    // tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    [self.navigationController pushViewController:tabc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [tabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [hemaiinfo release];
    [hemaiinfotwo release];
    [hongren release];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchDisplayController.searchResultsTableView == tableView) {
		[self sendSeachRequest:[self.seachTextListarry objectAtIndex:indexPath.row]];
		return;
	}
    
    if ([tableView isEqual:myTableViewHeFa]) {//选择响应
        if (zulancaiBut.selected == YES) { //足篮彩
            
            if (indexPath.row == 0) {
                
//                GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
//                hemaiinfo.lotteryType = 106;
//                hemaiinfo.title = @"竞彩足球合买";
//                hemaiinfo.lotteryId = @"201";
//                [self.navigationController pushViewController:hemaiinfo animated:YES];
//                [hemaiinfo release];
                [self otherLottoryViewController:0 title:@"竞彩足球合买" lotteryType:106 lotteryId:@"201"];
            }else if(indexPath.row == 1){
				GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:1];
                gcjc.systimestr = systimestr;
				gcjc.isHeMai = YES;
				[self.navigationController pushViewController:gcjc animated:YES];
				[gcjc release];
                
            }else if(indexPath.row == 2){
                
//                GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
//                hemaiinfo.title = @"胜负彩合买";
//                hemaiinfo.lotteryType = 13;
//                hemaiinfo.lotteryId = @"300";
//                [self.navigationController pushViewController:hemaiinfo animated:YES];
//                [hemaiinfo release];
                 [self otherLottoryViewController:0 title:@"胜负彩合买" lotteryType:13 lotteryId:@"300"];
            }else if(indexPath.row == 3){
				GCBettingViewController* bet = [[GCBettingViewController alloc] init];
				bet.bettingstype = bettingStypeShisichang;
				bet.isHemai = YES;
				[self.navigationController pushViewController:bet animated:YES];
				[bet release];
                
            }else if(indexPath.row == 4){
                
//                GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
//                hemaiinfo.title = @"任选九合买";
//                hemaiinfo.lotteryType = 14;
//                hemaiinfo.lotteryId = @"301";
//                [self.navigationController pushViewController:hemaiinfo animated:YES];
//                [hemaiinfo release];
                [self otherLottoryViewController:0 title:@"任选九合买" lotteryType:14 lotteryId:@"301"];
                
            }else if(indexPath.row == 5){
                GCBettingViewController* bet = [[GCBettingViewController alloc] init];
				bet.bettingstype = bettingStypeRenjiu;
				bet.isHemai = YES;
				[self.navigationController pushViewController:bet animated:YES];
				[bet release];
            }else if(indexPath.row == 6){
//                GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
//                hemaiinfo.title = @"北京单场合买";
//                hemaiinfo.lotteryType = 200;
//                hemaiinfo.lotteryId = @"400";
//                [self.navigationController pushViewController:hemaiinfo animated:YES];
//                [hemaiinfo release];
                [self otherLottoryViewController:0 title:@"任选九合买" lotteryType:200 lotteryId:@"400"];
            
            }else if(indexPath.row == 7){
                GC_BJDanChangViewController * beijingdan = [[GC_BJDanChangViewController alloc] initWithLotteryID:1];
                beijingdan.isHeMai = YES;
                [self.navigationController pushViewController:beijingdan animated:YES];
                [beijingdan release];
            }else if(indexPath.row == 8){
//                GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
//                hemaiinfo.lotteryType = 105;
//                hemaiinfo.title = @"竞彩篮球合买";
//                hemaiinfo.lotteryId = @"200";
//                [self.navigationController pushViewController:hemaiinfo animated:YES];
//                [hemaiinfo release];
                [self otherLottoryViewController:0 title:@"竞彩篮球合买" lotteryType:105 lotteryId:@"200"];
            }else if(indexPath.row == 9){
                GCJCBetViewController * gcjc = [[GCJCBetViewController alloc] initWithLotteryID:9];
                gcjc.lanqiubool = YES;
                gcjc.systimestr = systimestr;
				gcjc.isHeMai = YES;
                
				[self.navigationController pushViewController:gcjc animated:YES];
				[gcjc release];
            }
            
            
            if (indexPath.row > 9) {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"稍后上线敬请期待"];
            }
            
            
        }
        
        if (shuzicaiBut.selected == YES) {//数字彩
            
            
            if(indexPath.row == 0){
                
//                GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
//                hemaiinfo.title = @"双色球合买";
//                hemaiinfo.lotteryType = 1;
//                hemaiinfo.lotteryId = @"001";
//                [self.navigationController pushViewController:hemaiinfo animated:YES];
//                [hemaiinfo release];
                
                [self otherLottoryViewController:0 title:@"双色球合买" lotteryType:1 lotteryId:@"001"];
            }else if(indexPath.row == 1){
				GouCaiShuangSeQiuViewController *shuang = [[GouCaiShuangSeQiuViewController alloc] init];
				[self.navigationController pushViewController:shuang animated:YES];
				shuang.isHeMai = YES;
				//shuang.title = @"双色球合买";
				[shuang release];
			
            }else if(indexPath.row == 2){
//                GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
//                hemaiinfo.title = @"福彩3D合买";
//                hemaiinfo.lotteryType = 2;
//                hemaiinfo.lotteryId = @"002";
//                [self.navigationController pushViewController:hemaiinfo animated:YES];
//                [hemaiinfo release];
                [self otherLottoryViewController:0 title:@"福彩3D合买" lotteryType:2 lotteryId:@"002"];
            
            }else if(indexPath.row == 3){
            //福彩3D透合买
                FuCai3DViewController *fu = [[FuCai3DViewController alloc] init];
                fu.isHemai = YES;
                [self.navigationController pushViewController:fu animated:YES];
                [fu release];
            }else if(indexPath.row == 4){
//                GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
//                hemaiinfo.title = @"超级大乐透合买";
//                hemaiinfo.lotteryType = 4;
//                hemaiinfo.lotteryId = @"113";
//                [self.navigationController pushViewController:hemaiinfo animated:YES];
//                [hemaiinfo release];
                
                [self otherLottoryViewController:0 title:@"超级大乐透合买" lotteryType:4 lotteryId:@"113"];
            
            }else if(indexPath.row == 5){
            //超级大乐透合买
                DaLeTouViewController *dale = [[DaLeTouViewController alloc] init];
                dale.isHemai = YES;
                [self.navigationController pushViewController:dale animated:YES];
                [dale release];
            }else if(indexPath.row == 6){
//                GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
//                hemaiinfo.title = @"七乐彩合买";
//                hemaiinfo.lotteryType = TYPE_7LECAI;
//                hemaiinfo.lotteryId = @"003";
//                [self.navigationController pushViewController:hemaiinfo animated:YES];
//                [hemaiinfo release];
                 [self otherLottoryViewController:0 title:@"七乐彩合买" lotteryType:TYPE_7LECAI lotteryId:@"003"];
                
            }else if(indexPath.row == 7){
              //  GouCaiCell *cell = (GouCaiCell *) [shuziTableView cellForRowAtIndexPath:indexPath];
                QIleCaiViewController *con = [[QIleCaiViewController alloc] init];
             //   con.myissueRecord = cell.myrecord;
                con.isHemai = YES;
                [self.navigationController pushViewController:con animated:YES];
                [con release];
                
            }else if(indexPath.row == 8){
//                GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
//                hemaiinfo.title = @"排列5合买";
//                hemaiinfo.lotteryType = TYPE_PAILIE5;
//                hemaiinfo.lotteryId = @"109";
//                [self.navigationController pushViewController:hemaiinfo animated:YES];
//                [hemaiinfo release];
                [self otherLottoryViewController:0 title:@"排列5合买" lotteryType:TYPE_PAILIE5 lotteryId:@"109"];
            }else if(indexPath.row  == 9){
                
                PaiWuOrQiXingViewController * paiqi = [[PaiWuOrQiXingViewController alloc] init];
                paiqi.isHemai = YES;
                paiqi.qixingorpaiwu = shuZiCaiPaiWu;
                [self.navigationController pushViewController:paiqi animated:YES];
                [paiqi release];
                
            }else if(indexPath.row == 10){
//                GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
//                hemaiinfo.title = @"七星彩合买";
//                hemaiinfo.lotteryType = TYPE_QIXINGCAI;
//                hemaiinfo.lotteryId = @"110";
//                [self.navigationController pushViewController:hemaiinfo animated:YES];
//                [hemaiinfo release];
//
                 [self otherLottoryViewController:0 title:@"七星彩合买" lotteryType:TYPE_QIXINGCAI lotteryId:@"110"];
            }else if(indexPath.row == 11){
                PaiWuOrQiXingViewController * paiqi = [[PaiWuOrQiXingViewController alloc] init];
                paiqi.isHemai = YES;
                paiqi.qixingorpaiwu = shuZiCaiQiXing;
                [self.navigationController pushViewController:paiqi animated:YES];
                [paiqi release];
            }else if(indexPath.row == 12){
//                GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
//                hemaiinfo.title = @"22选5合买";
//                hemaiinfo.lotteryType = TYPE_22XUAN5;
//                hemaiinfo.lotteryId = @"111";
//                [self.navigationController pushViewController:hemaiinfo animated:YES];
//                [hemaiinfo release];
             [self otherLottoryViewController:0 title:@"22选5合买" lotteryType:TYPE_22XUAN5 lotteryId:@"111"];
            }else if(indexPath.row == 13){
                _22Xuan5ViewController *control = [[_22Xuan5ViewController alloc] init];
                control.isHeMai = YES;
                [self.navigationController pushViewController:control animated:YES];
                
                [control release];
            }
            else if(indexPath.row == 14){
//                GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
//                hemaiinfo.title = @"排列三合买";
//                hemaiinfo.lotteryType = 5;
//                hemaiinfo.lotteryId = @"108";
//                [self.navigationController pushViewController:hemaiinfo animated:YES];
//                [hemaiinfo release];
                [self otherLottoryViewController:0 title:@"排列三合买" lotteryType:5 lotteryId:@"108"];
            }else if(indexPath.row == 15){
                Pai3ViewController *pai3 = [[Pai3ViewController alloc] init];
                pai3.isHeMai = YES;
                [self.navigationController pushViewController:pai3 animated:YES];
                [pai3 release];
            }
            else{
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"稍后上线敬请期待"];
            }
            
        }
        
        
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == myTableViewCai) {
        myTableViewHeFa.contentOffset = scrollView.contentOffset;
    }
    else {
        myTableViewCai.contentOffset = scrollView.contentOffset;
    }
}

- (void)dealloc{
    [searchDC release];
    [PKsearchBar release];
    [seachTextListarry release];

    [shuziArr release];
    [imageArr release];
    [myTableViewCai release];
    [myTableViewHeFa release];
    [super dealloc];
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