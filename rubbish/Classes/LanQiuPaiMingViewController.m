//
//  LanQiuPaiMingViewController.m
//  caibo
//
//  Created by yaofuyu on 13-12-13.
//
//

#import "LanQiuPaiMingViewController.h"
#import "JSON.h"
#import "Info.h"
#import "NetURL.h"
#import "LanQiuRankCell.h"

@interface LanQiuPaiMingViewController ()

@end

@implementation LanQiuPaiMingViewController
@synthesize hostId,guestId,playId;
@synthesize isNBA;
@synthesize mrequest;
@synthesize dataDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isDongbu = YES;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(goback)];
	self.CP_navigation.leftBarButtonItem =left;
    self.mainView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"yuceback.png")];
    myTableView = [[UITableView alloc] init];
    myTableView.delegate = self;
    myTableView.dataSource = self;
//0765d4  07 101 212
    if (isNBA) {
        self.title = @"联赛排名";
        
        rootScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 102, 290, self.mainView.frame.size.height - 102)];
        rootScroll.alwaysBounceVertical = NO;
        
        rootScroll.contentSize = CGSizeMake(290 * 2, rootScroll.bounds.size.height );
        
        rootScroll.delegate = self;
        rootScroll.pagingEnabled = YES;
        [rootScroll setShowsHorizontalScrollIndicator:NO];
        [self.mainView addSubview:rootScroll];
        [rootScroll release];
        
        UIImageView *touBack = [[UIImageView alloc] initWithFrame:CGRectMake(70, 9, 96, 47)];
        touBack.image = UIImageGetImageFromName(@"yucebangdan.png");
        [self.mainView addSubview:touBack];
        [touBack release];
        myTableView.frame = CGRectMake(0, 0, 290, rootScroll.bounds.size.height);
        [rootScroll addSubview:myTableView];
        
        myTableView2 = [[UITableView alloc] init];
        myTableView2.delegate = self;
        myTableView2.dataSource = self;
        myTableView2.frame = CGRectMake(290, 0, 290, rootScroll.bounds.size.height);
        [rootScroll addSubview:myTableView2];
        
        
        NSArray *array1 = [NSMutableArray arrayWithObjects:@"东部",@"西部",nil];
        UIImageView *fenxiImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 64, 290, 38)];
        fenxiImage.image = [UIImageGetImageFromName(@"yucefenxiback.png") stretchableImageWithLeftCapWidth:10 topCapHeight:0];
        [self.mainView addSubview:fenxiImage];
        [fenxiImage release];
        for (int i = 0; i < [array1 count]; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*80 + 80, 64, 80, 38);
            btn.tag = 100 + i;
            btn.backgroundColor = [UIColor clearColor];
            [self.mainView addSubview:btn];
            [btn addTarget:self action:@selector(scrollBtn:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *label = [[UILabel alloc] initWithFrame:btn.bounds];
            [btn addSubview:label];
            label.tag = 300;
            if (i == 0) {
                label.textColor = [UIColor colorWithRed:7/255.0 green:101/255.0 blue:212/255.0 alpha:1.0];
            }
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont boldSystemFontOfSize:19];
            label.text = [array1 objectAtIndex:i];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            [label release];
        }
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 100, 60, 3)];
        imageView.tag = 1101;
        imageView.image = UIImageGetImageFromName(@"yucelanxian.png");
        [self.mainView addSubview:imageView];
        [imageView release];
    }
    else {
        self.title = @"赛季积分榜";
        UIImageView *touBack = [[UIImageView alloc] initWithFrame:CGRectMake(60, 8, 159, 48)];
        touBack.image = UIImageGetImageFromName(@"yuecequanbu.png");
        [self.mainView addSubview:touBack];
        [touBack release];
        myTableView.frame = CGRectMake(15, 64, 290, self.mainView.frame.size.height - 64);
        [self.mainView addSubview:myTableView];
    }
    
    [myTableView release];
    [self.mrequest clearDelegatesAndCancel];
    self.mrequest = nil;
    self.mrequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetLanQiuBFYCHB:self.playId]];
    [mrequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mrequest setDelegate:self];
    [mrequest startAsynchronous];
	// Do any additional setup after loading the view.
}

- (void)dealloc {
    [mrequest clearDelegatesAndCancel];
	self.mrequest = nil;
    self.hostId = nil;
    self.guestId = nil;
    self.playId = nil;
    self.dataDic = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Action

- (void)scrollBtn:(UIButton *)btn {
	UIView *v = [self.mainView viewWithTag:1101];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
    v.frame = CGRectMake(btn.frame.origin.x + 10, v.frame.origin.y, v.frame.size.width, v.frame.size.height);
	[UIView commitAnimations];
    if (btn.tag == 100) {
        isDongbu = YES;
        [rootScroll scrollRectToVisible:CGRectMake(0, 0, 290, rootScroll.frame.size.height) animated:YES];
    }
    else {
        isDongbu = NO;
        [rootScroll scrollRectToVisible:CGRectMake(290, 0, 290, rootScroll.frame.size.height) animated:YES];
    }
    for (int i = 0; i < 2; i ++) {
        UIButton *btn2 = (UIButton *)[self.mainView viewWithTag:100 +i ];
        UILabel *lab = (UILabel *)[btn2 viewWithTag:300];
        if (btn == btn2) {
            lab.textColor = [UIColor colorWithRed:7/255.0 green:101/255.0 blue:212/255.0 alpha:1.0];
        }
        else {
            lab.textColor = [UIColor blackColor];
        }
        
    }
}

- (void)goback {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == rootScroll) {
        UIView *v = [self.mainView viewWithTag:1101];
        v.frame = CGRectMake(scrollView.contentOffset.x*80/290.0 + 90, v.frame.origin.y, v.frame.size.width, v.frame.size.height);
        if (scrollView.contentOffset.x < 290) {
            for (int i = 0; i < 2; i ++) {
                UIButton *btn2 = (UIButton *)[self.mainView viewWithTag:100 +i ];
                UILabel *lab = (UILabel *)[btn2 viewWithTag:300];
                if (btn2.tag == 100) {
                    lab.textColor = [UIColor colorWithRed:7/255.0 green:101/255.0 blue:212/255.0 alpha:1.0];
                }
                else {
                    lab.textColor = [UIColor blackColor];
                }
                
            }
        }else {
            for (int i = 0; i < 2; i ++) {
                UIButton *btn2 = (UIButton *)[self.mainView viewWithTag:100 +i ];
                UILabel *lab = (UILabel *)[btn2 viewWithTag:300];
                if (btn2.tag == 101) {
                    lab.textColor = [UIColor colorWithRed:7/255.0 green:101/255.0 blue:212/255.0 alpha:1.0];
                }
                else {
                    lab.textColor = [UIColor blackColor];
                }
                
            }
        }
    }
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void) requestFinished:(ASIHTTPRequest *)request {
	NSString *responseStr = [request responseString];
    NSLog(@"res = %@", responseStr);
    
    self.dataDic = [NSMutableDictionary dictionaryWithDictionary:[responseStr JSONValue]];
    self.hostId = [dataDic objectForKey:@"host_id"];
    self.guestId = [dataDic objectForKey:@"guest_id"];
    if ([[self.dataDic objectForKey:@"all"] count] + [[self.dataDic objectForKey:@"east"] count] == 0) {
        for (UIView *v in self.mainView.subviews) {
            v.hidden = YES;
        
        }
        self.mainView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
        
        UIImageView *noInfoImageV = [[UIImageView alloc] initWithFrame:CGRectMake(111, 110, 97, 97)];
        noInfoImageV.image = UIImageGetImageFromName(@"noInfoImage.png");
        [self.mainView addSubview:noInfoImageV];
        [noInfoImageV release];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-20, 105, 137, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"暂无比赛信息";
        label.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1.0];
        label.font =  [UIFont boldSystemFontOfSize:15];
        [noInfoImageV addSubview:label];
        [label release];
    }
    [myTableView reloadData];
    [myTableView2 reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImageView *im = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 40)] autorelease];
    im.image = [UIImageGetImageFromName(@"yucezhanji.png") stretchableImageWithLeftCapWidth:4 topCapHeight:4];
    
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.frame = CGRectMake(0, 0, 60, 40);
    lab1.text = @"排名";
    lab1.textAlignment = NSTextAlignmentCenter;
    lab1.backgroundColor = [UIColor clearColor];
    lab1.font = [UIFont systemFontOfSize:15];
    [im addSubview:lab1];
    [lab1 release];
    
    UILabel *lab2 = [[UILabel alloc] init];
    lab2.frame = CGRectMake(60, 0, 80, 40);
    lab2.text = @"球队";
    lab2.textAlignment = NSTextAlignmentLeft;
    lab2.backgroundColor = [UIColor clearColor];
    lab2.font = [UIFont systemFontOfSize:15];
    [im addSubview:lab2];
    [lab2 release];
    
    
    UILabel *lab3 = [[UILabel alloc] init];
    lab3.frame = CGRectMake(140, 0, 30, 40);
    lab3.text = @"胜";
    lab3.textAlignment = NSTextAlignmentCenter;
    lab3.backgroundColor = [UIColor clearColor];
    lab3.font = [UIFont systemFontOfSize:15];
    [im addSubview:lab3];
    [lab3 release];
    
    UILabel *lab4 = [[UILabel alloc] init];
    lab4.frame = CGRectMake(170, 0, 30, 40);
    lab4.text = @"负";
    lab4.textAlignment = NSTextAlignmentCenter;
    lab4.backgroundColor = [UIColor clearColor];
    lab4.font = [UIFont systemFontOfSize:15];
    [im addSubview:lab4];
    [lab4 release];
    
    UILabel *lab5 = [[UILabel alloc] init];
    lab5.frame = CGRectMake(200, 0, 45, 40);
    lab5.text = @"胜率";
    lab5.textAlignment = NSTextAlignmentCenter;
    lab5.backgroundColor = [UIColor clearColor];
    lab5.font = [UIFont systemFontOfSize:15];
    [im addSubview:lab5];
    [lab5 release];
    
    UILabel *lab6 = [[UILabel alloc] init];
    lab6.frame = CGRectMake(245, 0, 45, 40);
    lab6.text = @"胜差";
    lab6.textAlignment = NSTextAlignmentCenter;
    lab6.backgroundColor = [UIColor clearColor];
    lab6.font = [UIFont systemFontOfSize:15];
    [im addSubview:lab6];
    [lab6 release];
    return im;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    LanQiuRankCell *cell = (LanQiuRankCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[LanQiuRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    NSArray *array = nil;
    if (!isNBA) {
        array =[self.dataDic objectForKey:@"all"];
        
    }
    else if (tableView == myTableView) {
        array =[self.dataDic objectForKey:@"east"];
        
    }
    else {
        array =[self.dataDic objectForKey:@"west"];
    }
    cell.hostID = self.hostId;
    cell.guestID = self.guestId;
    if (indexPath.row < [array count]) {
        [cell LoadData:[array objectAtIndex:indexPath.row]];
    }
    else {
        [cell LoadData:nil];
    }
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!isNBA) {
        return [[self.dataDic objectForKey:@"all"] count];
    }
    else if (tableView == myTableView) {
        return [[self.dataDic objectForKey:@"east"] count];
    }
    else {
        return [[self.dataDic objectForKey:@"west"] count];
    }
    return 0;
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    