//
//  GCSearchViewController.m
//  caibo
//
//  Created by houchenguang on 12-11-22.
//
//

#import "GCSearchViewController.h"
#import "FansViewController.h"
#import "caiboAppDelegate.h"
#import "MobClick.h"

@interface GCSearchViewController ()

@end    

@implementation GCSearchViewController
@synthesize seachTextListarry;
@synthesize PKsearchBar;
-(NSUInteger)supportedInterfaceOrientations{
#ifdef  isCaiPiaoForIPad
    return UIInterfaceOrientationMaskLandscapeRight;
#else
    return (1 << UIInterfaceOrientationPortrait);
#endif
}

- (BOOL)shouldAutorotate {
#ifdef  isCaiPiaoForIPad
    return YES;
#else
    return NO;
#endif
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
#ifdef  isCaiPiaoForIPad
    return interfaceOrientation == UIInterfaceOrientationLandscapeRight;
#else
    return NO;
#endif
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)LoadiPhoneView {

    [MobClick event:@"event_sousuo"];
	// Do any additional setup after loading the view.
    Cancelbool = NO;
   
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, self.view.frame.size.height - 40)];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    myTableView.delegate = self;
    myTableView.dataSource = self;

    [self.view addSubview:myTableView];
    
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
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
#ifdef isHaoLeCai
        myTableView.frame = CGRectMake(-8, 40, 320, self.view.frame.size.height - 40);
#else
        myTableView.frame = CGRectMake(-8, 60, 320, self.view.frame.size.height - 60);
#endif
    }

}

- (void)LoadiPadView {

    [MobClick event:@"event_sousuo"];
	// Do any additional setup after loading the view.
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgimage.backgroundColor = [UIColor yellowColor];
    bgimage.image = UIImageGetImageFromName(@"login_bgn.png");
    [self.view addSubview:bgimage];
    [bgimage release];
    
    
    Cancelbool = NO;
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 380, self.view.frame.size.height - 40)];
    //myTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    //myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myTableView];
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#ifdef  isCaiPiaoForIPad
    [self LoadiPadView];
#else
    [self LoadiPhoneView];
#endif
    
}

#pragma mark - 搜索调用
- (void)searchbegin{

#ifdef  isCaiPiaoForIPad
    if (!PKsearchBar) {
		PKsearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 390, 44)];
        PKsearchBar.backgroundColor = [UIColor clearColor];
        PKsearchBar.backgroundImage = UIImageGetImageFromName(@"shoushuobg1.png");
		[self.view addSubview:PKsearchBar];
		PKsearchBar.delegate = self;
		PKsearchBar.showsCancelButton = NO;
        
		searchDC = [[UISearchDisplayController alloc] initWithSearchBar:PKsearchBar contentsController:self];
		searchDC.searchResultsDataSource = self;
		searchDC.searchResultsDelegate = self;
	}
    isQuxiao = NO;
	[self.view addSubview:PKsearchBar];
    
    for(id cc in [PKsearchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            btn.enabled = YES;
            [btn addTarget:self action:@selector(pressCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
	//[PKsearchBar becomeFirstResponder];
    
    [myTableView reloadData];

#else
    if (!PKsearchBar) {
		PKsearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
#ifndef isHaoLeCai
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
            PKsearchBar.frame = CGRectMake(0, 20, 320, 40);
        }
#endif

        PKsearchBar.backgroundColor = [UIColor clearColor];
		[self.view addSubview:PKsearchBar];
		PKsearchBar.delegate = self;
		PKsearchBar.showsCancelButton = YES;
        
		searchDC = [[UISearchDisplayController alloc] initWithSearchBar:PKsearchBar contentsController:self];
		searchDC.searchResultsDataSource = self;
		searchDC.searchResultsDelegate = self;
	}
    isQuxiao = NO;
	[self.view addSubview:PKsearchBar];
    
    for(id cc in [PKsearchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            btn.enabled = YES;
            [btn addTarget:self action:@selector(pressCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
	//[PKsearchBar becomeFirstResponder];
    
    [myTableView reloadData];

#endif

    
}
#pragma mark -
#pragma mark UISearchBarDelegate

- (void)pressCancelButton:(UIButton *)sender{
    if (Cancelbool == NO) {
        [PKsearchBar resignFirstResponder];
        [PKsearchBar removeFromSuperview];
#ifndef isCaiPiaoForIPad
        [self.navigationController popViewControllerAnimated:YES];
#endif
    }
   
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isQuxiao = NO;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isQuxiao = YES;
	[searchDC.searchResultsTableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if (PKsearchBar.superview && isQuxiao) {
        Cancelbool = YES;
        [PKsearchBar resignFirstResponder];
#ifndef isCaiPiaoForIPad
        [PKsearchBar removeFromSuperview];
        if (backBool) {
            return;
        }
        [self.navigationController popViewControllerAnimated:YES];
#endif
        
    }
}

-(void)sendSeachRequest:(NSString*)keywords
{
    isQuxiao = NO;
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
	FansViewController * seachPerson = [[FansViewController alloc] initWithKeywords:keywords cpthree:YES];
	[seachPerson setHidesBottomBarWhenPushed:YES];
    
	seachPerson.cpthree = YES;
    seachPerson.titlestring = keywords;
    seachPerson.titlebool = YES;
	
	[self.navigationController pushViewController:seachPerson animated:YES];
	[seachPerson release];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	if ([searchBar text]&&![searchBar.text  isEqualToString:@""]) {
        
        if([searchBar.text rangeOfString:@" "].location != NSNotFound){
        
            searchBar.text = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        
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
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
        backBool = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
    
   // [PKsearchBar resignFirstResponder];
	//[PKsearchBar removeFromSuperview];
    
}
#pragma mark - 搜索按钮点击事件
//- (void)pressSearch:(id)sender{
//    if (!PKsearchBar) {
//		PKsearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
//		[self.view addSubview:PKsearchBar];
//		PKsearchBar.delegate = self;
//		PKsearchBar.showsCancelButton = YES;
//		searchDC = [[UISearchDisplayController alloc] initWithSearchBar:PKsearchBar contentsController:self];
//		searchDC.searchResultsDataSource = self;
//		searchDC.searchResultsDelegate = self;
//	}
//    isQuxiao = YES;
//	[self.view addSubview:PKsearchBar];
//	[PKsearchBar becomeFirstResponder];
//    
//}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (self.searchDisplayController.searchResultsTableView == tableView) {
		return [self.seachTextListarry count];
    
//	}
//    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.searchDisplayController.searchResultsTableView == tableView) {
    
		[self sendSeachRequest:[self.seachTextListarry objectAtIndex:indexPath.row]];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
         [PKsearchBar resignFirstResponder];
    }
   
//		return;
//	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 //   if (self.searchDisplayController.searchResultsTableView == tableView) {
		return 44;
//    }
//    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

#ifdef  isCaiPiaoForIPad
    
    NSString * CellIdentifier = @"cellid";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    NSString *text = [self.seachTextListarry objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text =text ;
    
//    UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(5, 42, 380, 2)];
//    xian.backgroundColor  = [UIColor clearColor];
//    xian.image = [UIImage imageNamed:@"SZTG960.png"];
//    [cell addSubview:xian];

    return cell;

#else
    
    NSString * CellIdentifier = @"cellid";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSString *text = [self.seachTextListarry objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text =text ;
    
    return cell;

#endif
        
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)dealloc{
    [seachTextListarry release];
    [myTableView release];
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#ifdef isHaoLeCai
- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}
#endif

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    