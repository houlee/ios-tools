//
//  DrawalMessageViewController.m
//  caibo
//
//  Created by cp365dev on 14-8-11.
//
//

#import "DrawalMessageViewController.h"
#import "Info.h"
#import "caiboAppDelegate.h"
@interface DrawalMessageViewController ()

@end

@implementation DrawalMessageViewController
@synthesize infoArray;
@synthesize titleArray;
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
    
    self.CP_navigation.title = @"提款记录";
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
    
    UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"首页" Target:self action:@selector(pressHome) ImageName:nil Size:CGSizeMake(70, 30)];
    self.CP_navigation.rightBarButtonItem = rightItem;
    
    self.mainView.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];

    
    self.titleArray = [NSArray arrayWithObjects:@"提款时间",@"提款金额",@"提款类型",@"状态",@"备注",@"订单号", nil];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 15, 320, 296) style:UITableViewStylePlain];
    myTableView.scrollEnabled = NO;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainView addSubview:myTableView];
    [myTableView release];
}
-(void)dealloc
{
    
    [titleArray release];
    [super dealloc];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 4)
        return 76;
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIImageView *upxian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    return [upxian autorelease];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *upxian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    return [upxian autorelease];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 66, 44)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.tag = 100;
        titleLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
        [cell.contentView addSubview:titleLabel];
        [titleLabel release];
        
        UILabel *mesLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(titleLabel)+17, 0, 207, 44)];
        mesLabel.backgroundColor = [UIColor clearColor];
        mesLabel.font = [UIFont systemFontOfSize:16];
        mesLabel.tag = 101;
        mesLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        [cell.contentView addSubview:mesLabel];
        [mesLabel release];
        
        UIImageView *upxian = [[UIImageView alloc] initWithFrame:CGRectMake(15, 42, 320, 1)];
        upxian.tag = 102;
        [cell.contentView addSubview:upxian];
        [upxian release];
    }
    
    
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:100];
    titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    
    UILabel *mesLabel = (UILabel *)[cell.contentView viewWithTag:101];
    mesLabel.text = [self.infoArray objectAtIndex:indexPath.row];
    
    UIImageView *upxian = (UIImageView *)[cell.contentView viewWithTag:102];
    upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    if(indexPath.row == 4){
        upxian.frame= CGRectMake(15, 75, 320, 1);
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pressHome
{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}
-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    