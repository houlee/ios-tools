//
//  LanQiuBianhuaAroundViewController.m
//  caibo
//
//  Created by yaofuyu on 13-12-15.
//
//

#import "LanQiuBianhuaAroundViewController.h"
#import "Info.h"
#import "AsEuCell.h"

@interface LanQiuBianhuaAroundViewController ()

@end

@implementation LanQiuBianhuaAroundViewController
@synthesize isOuPei;
@synthesize cid;
@synthesize dataArray;
@synthesize dataDic;

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
    self.title = self.title;
    //    self.mainView.frame = CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y, 320, self.mainView.frame.size.height);
    //    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 320, self.view.frame.size.height);
    //    self.CP_navigation.frame = CGRectMake(self.CP_navigation.frame.origin.x, self.CP_navigation.frame.origin.y, 320, self.CP_navigation.frame.size.height);
#ifdef isCaiPiaoForIPad
    UIBarButtonItem *right = [Info itemInitWithTitle:nil Target:self action:@selector(goTalk) ImageName:@"kf-quxiao2.png"];
    self.CP_navigation.rightBarButtonItem = right;
#else	
	UIBarButtonItem *left = [Info backItemTarget:self action:@selector(goback)];
	self.CP_navigation.leftBarButtonItem =left;
#endif
    
    UIImageView *touBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 111)];
    touBack.image = UIImageGetImageFromName(@"lanqiuyuceback.png");
    [self.mainView addSubview:touBack];
    [touBack release];
    
    UIImageView *homeBack = [[UIImageView alloc] initWithFrame:CGRectMake(234, 12, 72, 72)];
    homeBack.image = UIImageGetImageFromName(@"yucelogo.png");
    [self.mainView addSubview:homeBack];
    [homeBack release];
        
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
    
	[homeImageView setImageWithURL:[dataDic objectForKey:@"host_logo"]];
	[visitImageView setImageWithURL:[dataDic objectForKey:@"guest_logo"]];
	timeLabel.text = [dataDic objectForKey:@"match_time"];
	nameLabe.text = [dataDic objectForKey:@"league_name"];
    
    tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 111, 320, self.mainView.bounds.size.height - 111) style:UITableViewStylePlain];
	tableView1.backgroundColor = [UIColor clearColor];
	[tableView1 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	tableView1.delegate = self;
	tableView1.dataSource = self;
	[self.mainView addSubview:tableView1];
	[tableView1 release];
	// Do any additional setup after loading the view.
}

- (void)goback {
    [self.navigationController popViewControllerAnimated:YES];
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
        cell1.isLanQiu = YES;
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
    if (indexPath.row == 0) {
        return 30;
    }
	return 50;
}

- (void)dealloc {
    self.cid = nil;
    self.dataArray = nil;
    self.dataDic = nil;
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    