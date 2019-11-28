//
//  DrawalRecordViewController.m
//  caibo
//
//  Created by cp365dev on 14-8-11.
//
//

#import "DrawalRecordViewController.h"
#import "Info.h"
#import "caiboAppDelegate.h"
#import "GC_HttpService.h"
#import "ASIHTTPRequest.h"
#import "ColorView.h"
#import "GC_Withdrawals.h"
#import "DrawalMessageViewController.h"
@interface DrawalRecordViewController ()

@end

@implementation DrawalRecordViewController
@synthesize httpRequest;
@synthesize drawalinfo;
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
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 15, 320, self.mainView.frame.size.height-30) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.mainView addSubview:myTableView];
    [myTableView release];
    
    [self reqListWithPage:1];
    
    
}
-(void)dealloc
{
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = nil;
    [super dealloc ];

}
-(void)reqListWithPage:(int)page
{
    
    nowPage = page;
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] reWithdrawals:0
                                                                       state:0
                                                                   startTime:@"-"
                                                                     endTime:@"-"
                                                                   sortField:@"-"
                                                                   sortStyle:@"desc"
                                                                 countOfPage:15
                                                                 currentPage:page];
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(drawalListFinished:)];
    [httpRequest setDidFailSelector:@selector(drawalListFailed:)];
    [httpRequest startAsynchronous];
}
-(void)drawalListFinished:(ASIHTTPRequest *)myrequest
{
    [moreCell spinnerStopAnimating];

    
    GC_Withdrawals *drawals = [[GC_Withdrawals alloc] initWithResponseData:[myrequest responseData] WithRequest:myrequest];
    if(drawals.returnId != 3000){
    
        
        if(self.drawalinfo){
            if(drawals.reRecordNum > 0 && nowPage > self.drawalinfo.curPage){
                self.drawalinfo.curPage = nowPage;
                [self.drawalinfo.wInforArray addObjectsFromArray:drawals.wInforArray];
                myTableView.contentSize = CGSizeMake(320, self.drawalinfo.wInforArray.count*60);
            }
            if([drawals.wInforArray count] < 15){
                [moreCell setInfoText:@"加载完毕"];
                [moreCell setType:MSG_TYPE_LOAD_NODATA];
                
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"加载完毕"];
            }


        }
        else{
            self.drawalinfo = drawals;
        }
        
        
        if(self.drawalinfo.wInforArray.count == 0){
        
            [self showNoMessageView];
        }

        [myTableView reloadData];
    
    }
    [drawals release];

}
-(void)drawalListFailed:(ASIHTTPRequest *)myrequest
{
    
}
#pragma mark UIScrollView Delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (myTableView.contentSize.height-scrollView.contentOffset.y<=360) {
        if (moreCell && moreCell.type != MSG_TYPE_LOAD_NODATA) {
            [moreCell spinnerStartAnimating];
            [self reqListWithPage:(int)self.drawalinfo.curPage+1];
        }
	}
}
#pragma mark - UITableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.drawalinfo.wInforArray count])
        return [self.drawalinfo.wInforArray count]+1;
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(self.drawalinfo.wInforArray.count == 0)
        return 0;
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(self.drawalinfo.wInforArray.count == 0)
        return nil;
    UIImageView *upxian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    return [upxian autorelease];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == self.drawalinfo.wInforArray.count) {
        static NSString *CellIdentifier = @"Cell2";
        moreCell = (MoreLoadCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!moreCell) {
            moreCell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            [moreCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [moreCell setInfoText:@"加载更多"];
        }
        
        moreCell.backgroundColor = [UIColor clearColor];
        return moreCell;
    }
    
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
        
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, 135, 15)];
        timeLabel.tag = 100;
        timeLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:timeLabel];
        [timeLabel release];
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(timeLabel)+10.5, 90, 15)];
        typeLabel.tag = 101;
        typeLabel.textColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
        typeLabel.backgroundColor = [UIColor clearColor];
        typeLabel.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:typeLabel];
        [typeLabel release];
        
        UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(timeLabel)+30, 12.5, 104, 15)];
        resultLabel.tag = 102;
        resultLabel.backgroundColor = [UIColor clearColor];
        resultLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        resultLabel.textAlignment = NSTextAlignmentRight;
        resultLabel.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:resultLabel];
        [resultLabel release];
        
        UILabel *yuanLabel = [[UILabel alloc] initWithFrame:CGRectMake(320-37.5-13, ORIGIN_Y(resultLabel)+11.5, 13, 12)];
        yuanLabel.tag = 103;
        yuanLabel.backgroundColor = [UIColor clearColor];
        yuanLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        yuanLabel.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:yuanLabel];
        [yuanLabel release];
        
        UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(320-37.5-13-5-30, ORIGIN_Y(resultLabel)+10.5, 30, 16)];
        moneyLabel.tag = 1033;
        moneyLabel.textColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:48/255.0 alpha:1];
        moneyLabel.backgroundColor = [UIColor clearColor];
        moneyLabel.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:moneyLabel];
        [moneyLabel release];
        
        UILabel *yuanLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(moneyLabel.frame.origin.x-5-12, ORIGIN_Y(resultLabel)+11.5, 12, 12)];
        yuanLabel1.tag = 10333;
        yuanLabel1.backgroundColor = [UIColor clearColor];
        yuanLabel1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        yuanLabel1.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:yuanLabel1];
        [yuanLabel1 release];
        
        
        
        UIImageView *upxian = [[UIImageView alloc] initWithFrame:CGRectMake(15, 59, 320, 1)];
        upxian.tag = 104;
        [cell.contentView addSubview:upxian];
        [upxian release];
        
        UIImageView *jiantouImage =[[UIImageView alloc] initWithFrame:CGRectMake(296, 24, 9, 13)];
        jiantouImage.tag = 105;
        jiantouImage.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:jiantouImage];
        [jiantouImage release];
        
    }
    
    UILabel *timeLabel = (UILabel *)[cell.contentView viewWithTag:100];
    UILabel *typeLabel = (UILabel *)[cell.contentView viewWithTag:101];
    UILabel *resultLabel = (UILabel *)[cell.contentView viewWithTag:102];
    UIImageView *upxian = (UIImageView *)[cell.contentView viewWithTag:104];
    UIImageView *jiantouImage = (UIImageView *)[cell.contentView viewWithTag:105];

    
    UILabel *yuanLabel = (UILabel *)[cell.contentView viewWithTag:103];
    UILabel *moneyLabel = (UILabel *)[cell.contentView viewWithTag:1033];
    UILabel *yuanLabel1 = (UILabel *)[cell.contentView viewWithTag:10333];
    
    
    
    WithdrawalsInfor *lsdInfo = nil;
    
    if(indexPath.row < self.drawalinfo.wInforArray.count){
        
        lsdInfo = [self.drawalinfo.wInforArray objectAtIndex:indexPath.row];
    }
    
    
    UIFont * font = [UIFont systemFontOfSize:16];
    CGSize  size = CGSizeMake(320, 16);
    CGSize labelSize = [lsdInfo.award sizeWithFont:font constrainedToSize:size];
    
    moneyLabel.frame =CGRectMake(320-37.5-13-5-labelSize.width, ORIGIN_Y(resultLabel)+10.5, labelSize.width, 16);
    yuanLabel1.frame =CGRectMake(moneyLabel.frame.origin.x-5-12, ORIGIN_Y(resultLabel)+11.5, 12, 12);

    
    timeLabel.text = lsdInfo.operDate;
    typeLabel.text = lsdInfo.type;
    resultLabel.text = lsdInfo.state;
    yuanLabel.text = @"元";
    yuanLabel1.text = @"￥";
    moneyLabel.text = lsdInfo.award;
    jiantouImage.image = UIImageGetImageFromName(@"yinlianjiantou.png");
    upxian.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];

    
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)showNoMessageView
{
    
    
    // 480-800.png
    UIImageView *imageJia=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button-100_1.png"]];
    imageJia.frame=CGRectMake(108, 80, 100, 100);
    [self.mainView addSubview:imageJia];
    [imageJia release];

    
    UILabel *labelJia=[[UILabel alloc]initWithFrame:CGRectMake(125, 200, 80, 30)];
    labelJia.text=@"暂无相关记录";
    labelJia.backgroundColor=[UIColor clearColor];
    labelJia.font=[UIFont systemFontOfSize:12.0];
    labelJia.textColor=[UIColor grayColor];
    [self.mainView addSubview:labelJia];
    [labelJia release];
    return;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row >= self.drawalinfo.wInforArray.count)
    {
        [moreCell spinnerStartAnimating];
        [self reqListWithPage:(int)self.drawalinfo.curPage+1];
    }
    else
    {
        WithdrawalsInfor * lsdInfo = [self.drawalinfo.wInforArray objectAtIndex:indexPath.row];
        NSString * str1 = lsdInfo.operDate;
        NSString * str2 = [NSString stringWithFormat:@"￥%@元",lsdInfo.award];
        NSString * str3 = lsdInfo.type;
        NSString * str4 = lsdInfo.state;
        NSString * str5 = lsdInfo.remarks;
        NSString * str6 = lsdInfo.orderNo;
        NSArray *arrayinfo = [NSArray  arrayWithObjects:str1, str2, str3, str4, str5, str6, nil];

        DrawalMessageViewController *drawalViewController = [[DrawalMessageViewController alloc] init];
        drawalViewController.infoArray = arrayinfo;
        [self.navigationController pushViewController:drawalViewController animated:YES];
        [drawalViewController release];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)pressHome
{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
    [httpRequest clearDelegatesAndCancel];
}
-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
    [httpRequest clearDelegatesAndCancel];
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