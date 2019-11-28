//
//  CheDanZhuiViewController.m
//  caibo
//
//  Created by houchenguang on 13-12-13.
//
//

#import "CheDanZhuiViewController.h"
#import "Info.h"
#import "LotterySalesCell.h"
#import "GC_HttpService.h"
#import "caiboAppDelegate.h"
#import "CheDanData.h"
#import "UserInfo.h"


@interface CheDanZhuiViewController ()

@end

@implementation CheDanZhuiViewController
@synthesize httpRequest, zhuihaodata, moreCell, schemeID, delegate;

- (void)dealloc{
    [schemeID release];
    self.moreCell = nil;
    [zhuihaodata release];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [super dealloc];
}

- (void)requestInfoFunc:(NSInteger)type{//追号详情的请求
    
    NSInteger page = 0;
    if ([self.zhuihaodata.infoList count] == 0) {
        page = 1;
    }
    else {
        if ([self.zhuihaodata.infoList count]%20 > 0) {
            page = [self.zhuihaodata.infoList count]/20 +2;
        }else{
            page = [self.zhuihaodata.infoList count]/20 +1;
        }
        
    }
    //0，全部；1，已追期次；2，未开始期次
    NSMutableData *postData = [[GC_HttpService sharedInstance] ZhuihaoInfoWithID:schemeID showType:type count:20 page:page];
    SEL Finish = @selector(zhuihaoInfoRequestFinish:);
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:Finish];
    [httpRequest startAsynchronous];
    
}
-(void)requestFailed:(ASIHTTPRequest*)mrequest{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    [self.moreCell spinnerStopAnimating];
}
- (void)zhuihaoInfoRequestFinish:(ASIHTTPRequest *)request{
    if ([request responseData]) {
		zhuiHaoData *br = [[zhuiHaoData alloc] initWithResponseData:[request responseData] WithRequest:request type:1];
        if (br.sysId == 3000) {
            [br release];
            if (loadview) {
                [loadview stopRemoveFromSuperview];
                loadview = nil;
            }
            [self.moreCell spinnerStopAnimating];
            return;
        }
        
        if (self.zhuihaodata) {
			[self.zhuihaodata.infoList addObjectsFromArray:br.infoList];
			
		}
		else {
			self.zhuihaodata = br;
		}
        if([br.infoList count] == 0){
            [moreCell setType:MSG_TYPE_LOAD_NODATA];
        }
        changciView2.text = [NSString stringWithFormat:@"当前剩余<%d>期", (int)self.zhuihaodata.shengyu];
        if ([self.zhuihaodata.infoList count] == 0) {
            myTableView.hidden = YES;
            Btn.hidden = YES;
            changciView2.hidden = YES;
            jiluLabel.hidden = NO;
            jiluImage.hidden = NO;
            
        }else{
            
            
            changciView2.hidden = NO;
            Btn.hidden = NO;
            myTableView.hidden = NO;
            jiluLabel.hidden = YES;
            jiluImage.hidden = YES;
        }
        

        
        
        
        [br release];
    }
    [myTableView reloadData];
    [self.moreCell spinnerStopAnimating];
    if (moreCell.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [moreCell spinnerStopAnimating];
        [moreCell setInfoText:@"加载完毕"];
    }
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
}

- (void)cheDanFunc:(NSInteger)type{//0, 追号方案整体撤单；1，单个追号方案2，合买方案撤单

    NSMutableData *postData = [[GC_HttpService sharedInstance] chedanWithID:schemeID type:type];
    SEL Finish = @selector(cheDanFinsh:);
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:Finish];
    [httpRequest startAsynchronous];
}
- (void)cheDanFinsh:(ASIHTTPRequest *)request{

    if ([request responseData]) {
		CheDanData *br = [[CheDanData alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (br.sysid == 3000) {
            [br release];
            return;
        }
        typeAnswer = br.chedan;
        if (br.chedan == 1) {//成功
            
            myTableView.hidden = YES;
            Btn.hidden = YES;
            changciView2.hidden = YES;
            
            jiluLabel.hidden = NO;
            jiluImage.hidden = NO;
            
        }else{
            jiluLabel.hidden = YES;
            jiluImage.hidden = YES;
            myTableView.hidden = NO;
            Btn.hidden = NO;
            changciView2.hidden = NO;
            
        }
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:br.msgchedan delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.delegate = self;
        alert.tag = 102;
        [alert show];
        [alert release];
        [br release];
    }
    
   
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)allViewFunc{

    changciView2 = [[ColorView alloc] init];
    changciView2.font = [UIFont systemFontOfSize:12];
    changciView2.colorfont = [UIFont systemFontOfSize:12];
    changciView2.backgroundColor = [UIColor clearColor];
    changciView2.frame = CGRectMake(15, 17, 200, 20);
    [self.mainView addSubview:changciView2];
    changciView2.hidden=  YES;
    changciView2.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    changciView2.changeColor = [UIColor redColor];
//    changciView2.text = @"当前剩余<234234>期";
    [changciView2 release];
    
    
    Btn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    Btn.frame = CGRectMake(320-10-77, 10, 77, 28);
    [Btn loadButonImage:nil LabelName:[NSString stringWithFormat:@"全部撤单"]];
    [Btn setBackgroundImage:[UIImageGetImageFromName(@"tongyonglan.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    Btn.hidden = YES;
    Btn.buttonName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
    Btn.buttonName.font = [UIFont systemFontOfSize:16];
    [Btn addTarget:self action:@selector(GenDan) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:Btn];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 51, self.mainView.frame.size.width, self.mainView.frame.size.height - 51) style:UITableViewStylePlain];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.hidden = YES;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:myTableView];
    [myTableView release];
    
    UIView *lineView = [[[UIView alloc] init] autorelease];
    lineView.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
    lineView.frame= CGRectMake(0, 0, 320, 0.5);
    [myTableView addSubview:lineView];
    
    
    

}

- (void)GenDan{
    
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"是否全部撤销追号?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.delegate = self;
    alert.tag = 101;
    [alert show];
    [alert release];
    
//    [self cheDanFunc:0];
    
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101) {
        if (buttonIndex == 1) {
            [self cheDanFunc:0];
        }
    }
    if (alertView.tag == 102){
        if (typeAnswer == 1) {
            
           
        }
        
        
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
   
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    // bgimage.image = UIImageGetImageFromName(@"login_bgn.png");
    bgimage.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:bgimage];
    [bgimage release];
    
    
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = left;
    
    jiluImage = [[UIImageView alloc] initWithFrame:CGRectMake((self.mainView.frame.size.width-99)/2, 80, 99, 94)];
    jiluImage.backgroundColor = [UIColor clearColor];
    jiluImage.image = UIImageGetImageFromName(@"button-100_1.png");
    jiluImage.hidden = YES;
    [self.mainView addSubview:jiluImage];
    [jiluImage release];
    
    jiluLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.mainView.frame.size.width-129)/2, 80+94+30, 129, 20)];
    jiluLabel.textAlignment = NSTextAlignmentCenter;
    jiluLabel.text = @"无相关记录";
    jiluLabel.hidden=  YES;
    jiluLabel.textColor = [UIColor colorWithRed:194/255.0 green:192/255.0 blue:187/255.0 alpha:1];
    jiluLabel.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:jiluLabel];
    [jiluLabel release];
    
    
    loadview = [[UpLoadView alloc] init];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    [self allViewFunc];
    
    [self requestInfoFunc:2];
    
    
}

#pragma mark tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.zhuihaodata) {
        return [self.zhuihaodata.infoList count]+1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 76;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{\
    
    NSInteger count = 0;
    if (self.zhuihaodata.infoList) {
        count = [self.zhuihaodata.infoList count];
    }
    if (indexPath.row == count) {
		
        NSString * CellIdentifier = @"MoreLoadCell";
		
		MoreLoadCell *cell1 = (MoreLoadCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
		if (cell1 == nil) {
			cell1 = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			[cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
			//moreCell.backgroundColor = [UIColor clearColor];
		}
		
		if (moreCell == nil) {
			self.moreCell = cell1;
		}
		
		return cell1;
	}else{
        
        NSString * cellid = @"cellid";
        
        LotterySalesCell *cell1 = (LotterySalesCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
        
        if (cell1 == nil) {
            // cell1 = [[[LotterySalesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            cell1 = [[[LotterySalesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid withIndex:indexPath withCellCount:[self.zhuihaodata.infoList count]] autorelease];
            [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
            //moreCell.backgroundColor = [UIColor clearColor];
        }
        if (self.zhuihaodata) {
            cell1.infoData = self.zhuihaodata;
            cell1.infoListData = [self.zhuihaodata.infoList objectAtIndex:indexPath.row];
            
        }
        
        
        
        return cell1;
    }
    
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == [self.zhuihaodata.infoList count]) {
        [moreCell spinnerStartAnimating];
        [self requestInfoFunc:2];
    }else{
    
        ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
        info.delegate = self;
        info.nikeName = [[[Info getInstance] mUserInfo] user_name] ;
        
        zhuiHaoDataInfo * zh = [self.zhuihaodata.infoList objectAtIndex:indexPath.row];
        
        info.orderId = zh.zhuiHaoID;
        NSLog(@"gggggggggggggg= %@", zh.zhuiHaoID);
        info.issure = zh.lotteryIssue;
        [self.navigationController pushViewController:info animated:YES];
        [info release];
    }
    
}

- (void)returnTypeAnswer:(NSInteger)answer{

    if (answer == 1) {
        typeAnswer = 1;
        [self.zhuihaodata.infoList removeAllObjects];
        self.zhuihaodata = nil;
//        [self.zhuihaodata.infoList removeAllObjects];
         [self requestInfoFunc:2];
    }

}

- (void)doBack{

    [self.navigationController popViewControllerAnimated:YES];
    if (delegate && [delegate respondsToSelector:@selector(returnTypeAnswer:)]) {
        [delegate returnTypeAnswer:typeAnswer];
    }
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