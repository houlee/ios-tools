//
//  PeiLvChangeViewController.m
//  caibo
//
//  Created by yaofuyu on 13-10-29.
//
//

#import "PeiLvChangeViewController.h"
#import "Info.h"
#import "AsEuCell.h"

@interface PeiLvChangeViewController ()

@end

@implementation PeiLvChangeViewController

@synthesize isOuPei;
@synthesize cid;
@synthesize dataArray;
@synthesize myMacthInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
    self.mainView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
    self.CP_navigation.title = self.myMacthInfo.leagueName;
    
    homeBack = [[DownLoadImageView alloc] initWithFrame:CGRectMake(10, 15, 79, 64)];
    homeBack.image = UIImageGetImageFromName(@"bifenflagBack.png");
	[self.mainView addSubview:homeBack];
    [homeBack release];
    
    homeImageView = [[DownLoadImageView alloc] initWithFrame:CGRectMake(10, 15, 79, 64)];
	[self.mainView addSubview:homeImageView];
    [homeImageView release];
    
	
	homeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 85, 85, 11)];
	[self.mainView addSubview:homeLabel];
	homeLabel.textAlignment = NSTextAlignmentCenter;
	homeLabel.backgroundColor = [UIColor clearColor];
	homeLabel.font = [UIFont systemFontOfSize:9];
    [homeLabel release];
	
    visitBack = [[DownLoadImageView alloc] initWithFrame:CGRectMake(235, 15, 79, 64)];
    visitBack.image = UIImageGetImageFromName(@"bifenflagBack.png");
	[self.mainView addSubview:visitBack];
    [visitBack release];
	
	visitImageView = [[DownLoadImageView alloc] initWithFrame:CGRectMake(235, 15, 79, 64)];
	[self.mainView addSubview:visitImageView];
    [visitImageView release];
	
	
	visitLabel = [[UILabel alloc] initWithFrame:CGRectMake(235, 85, 85, 11)];
	[self.mainView addSubview:visitLabel];
	visitLabel.backgroundColor = [UIColor clearColor];
	visitLabel.textAlignment = NSTextAlignmentCenter;
	visitLabel.font = [UIFont systemFontOfSize:9];
    [visitLabel release];
    
    bifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 29, 70, 17)];
	[self.mainView addSubview:bifenLabel];
	bifenLabel.backgroundColor = [UIColor clearColor];
	bifenLabel.textAlignment = NSTextAlignmentRight;
	bifenLabel.font = [UIFont boldSystemFontOfSize:15];
    bifenLabel.textColor = [UIColor redColor];
    [bifenLabel release];
    
    statueLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 30, 70, 17)];
	[self.mainView addSubview:statueLabel];
	statueLabel.backgroundColor = [UIColor clearColor];
	statueLabel.textAlignment = NSTextAlignmentLeft;
	statueLabel.font = [UIFont boldSystemFontOfSize:9];
    statueLabel.textColor = [UIColor redColor];
    [statueLabel release];
    
	
	
	timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 53, 140, 12)];
	[self.mainView addSubview:timeLabel];
	timeLabel.backgroundColor = [UIColor clearColor];
	timeLabel.textAlignment = NSTextAlignmentCenter;
	timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
	timeLabel.font = [UIFont systemFontOfSize:9];
    [timeLabel release];
	
    
	
	peiLvLabe = [[UILabel alloc] initWithFrame:CGRectMake(90, 67, 140, 11)];
	[self.mainView addSubview:peiLvLabe];
	peiLvLabe.backgroundColor = [UIColor clearColor];
    peiLvLabe.font = [UIFont systemFontOfSize:9];
    peiLvLabe.textAlignment = NSTextAlignmentCenter;
	peiLvLabe.textColor = [UIColor blackColor];
    
    homeLabel.text = [NSString stringWithFormat:@"%@ （主）",self.myMacthInfo.home];
    visitLabel.text = [NSString stringWithFormat:@"%@ （客）",self.myMacthInfo.away];
    timeLabel.text = self.myMacthInfo.matchTime;
    if (self.myMacthInfo.spWin) {
        peiLvLabe.text = [NSString stringWithFormat:@" %@ 欧赔 %@",self.myMacthInfo.spLose,self.myMacthInfo.spWin];
    }
    
    homeImageView.frame = CGRectMake(237, 17, 75, 60);
    homeBack.frame = CGRectMake(235, 15, 79, 64);
    visitImageView.frame = CGRectMake(12, 17, 75, 60);
    visitBack.frame = CGRectMake(10, 15, 79, 64);
    homeLabel.frame = CGRectMake(225, 85, 99, 11);
    visitLabel.frame = CGRectMake(0, 85, 99, 11);
    [homeImageView setImageWithURL:self.myMacthInfo.HostTeamFlag DefautImage:UIImageGetImageFromName(@"bifenzhiboZhulogo.png")];
    [visitImageView setImageWithURL:self.myMacthInfo.GuestTeamFlag DefautImage:UIImageGetImageFromName(@"bifenzhiboKelogo.png")];
    statueLabel.text= self.myMacthInfo.status;
    statueLabel.frame = CGRectMake(110, 35, 100, 20);
    statueLabel.textAlignment = NSTextAlignmentCenter;
    [myTableView reloadData];
    bifenLabel.frame = CGRectMake(110, 20, 100, 20);
    bifenLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.frame = CGRectMake(110, 50, 100, 15);
    if ([self.myMacthInfo.state isEqualToString:@"0"]) {
        bifenLabel.text = @"VS";
    }
    else {
        bifenLabel.text = [NSString stringWithFormat:@"%d:%d",(int)[self.myMacthInfo.awayHost integerValue],(int)[self.myMacthInfo.scoreHost integerValue]];
    }
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, 320, self.mainView.bounds.size.height - 120) style:UITableViewStylePlain];
	myTableView.backgroundColor = [UIColor clearColor];
	myTableView.delegate = self;
	myTableView.dataSource = self;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.mainView addSubview:myTableView];
	[myTableView release];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return [dataArray count] + 1;
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier1 = @"Cell";
    AsEuCell *cell1 = (AsEuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (!cell1) {
        cell1 = [[[AsEuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
        cell1.isOuPei = self.isOuPei;
    }
    NSString *cid1 = @"";
    if (indexPath.row == 1) {
        cid1 = self.cid;
    }
    if (indexPath.row == 0) {
        [cell1 LoadBianHuaData:nil isTitle:YES CId:cid1 isFoot:NO];
    }

    else if (indexPath.row == [dataArray count]) {
        [cell1 LoadBianHuaData:[dataArray objectAtIndex:indexPath.row - 1] isTitle:NO CId:cid1 isFoot:YES];
    }
    else {
        [cell1 LoadBianHuaData:[dataArray objectAtIndex:indexPath.row - 1] isTitle:NO CId:cid1 isFoot:NO];    }
    
    
    return cell1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 33;
}

- (void)dealloc {
    self.cid = nil;
    self.dataArray = nil;
    self.myMacthInfo = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    