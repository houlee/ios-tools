//
//  ZhuiHaoInfoViewController.m
//  caibo
//
//  Created by houchenguang on 13-12-13.
//
//

#import "ZhuiHaoInfoViewController.h"
#import "Info.h"
#import "GC_HttpService.h"
#import "LotterySalesCell.h"
#import "caiboAppDelegate.h"
#import "UserInfo.h"


@interface ZhuiHaoInfoViewController ()

@end

@implementation ZhuiHaoInfoViewController
@synthesize httpRequest, schemeID, zhuihaodata;
@synthesize moreCell, delegate;

- (void)dealloc{
    [zhuihaodata release];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [schemeID release];
    self.moreCell = nil;
    [super dealloc];
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void)returnTypeAnswer:(NSInteger)answer{
    if (answer == 1) {
        typeAnswer = 1;
        [self.zhuihaodata.infoList removeAllObjects];
        self.zhuihaodata = nil;
        if (!loadview) {
          loadview = [[UpLoadView alloc] init];  
        }
        
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:loadview];
        [loadview release];
        [self requestInfoFunc:1];
    }
}
-(void)requestFailed:(ASIHTTPRequest*)mrequest{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    [self.moreCell spinnerStopAnimating];
}
- (void)showFunc{

    if ([self.zhuihaodata.zhuiHaoType intValue] == 0 && [self.zhuihaodata.awardType intValue] == 2) {//当追号全部完成,显示该追号总中奖金额,如所有方 案均未中奖,则隐藏总中奖金额区域。
        awardView.hidden = NO;
        // 12+46+12
        myTableView.frame = CGRectMake(0, 64, 320, self.mainView.bounds.size.height - 64);
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        
        [UIView commitAnimations];
        
    }else{
        awardView.hidden = YES;
        //
        myTableView.frame = self.mainView.bounds;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView commitAnimations];
    }
    
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
        if ([br.infoList count] == 0) {
            [moreCell setType:MSG_TYPE_LOAD_NODATA];
        }
        
        
        changciView.text = [NSString stringWithFormat:@"总<%@>元", self.zhuihaodata.zhuihaoMoney];//总共多少钱
        CGSize size = [self.zhuihaodata.zhuihaoMoney sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(150, 20)];
        changciView.frame = CGRectMake(15, changciView.frame.origin.y, size.width+30, changciView.frame.size.height);
        
        
        changciView2.text = [NSString stringWithFormat:@"已付<%@>元", self.zhuihaodata.yiFuAmount];//已付多少钱
        CGSize size2 = [changciView2.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(150, 20)];
        changciView2.frame = CGRectMake(changciView.frame.origin.x + changciView.frame.size.width + 50, changciView2.frame.origin.y, size2.width, changciView2.frame.size.height);

        percentage.text = [NSString stringWithFormat:@"%d/%d", (int)self.zhuihaodata.yiZhuiIssue, (int)self.zhuihaodata.zhuiHaoIssue];//几分之几
        
        
//        NSInteger allMoney = [changciView.text intValue];//[[NSString stringWithFormat:@"<%@>",self.zhuihaodata.zhuihaoMoney] intValue];
//        NSInteger paidMoney = [changciView2.text intValue];//[[NSString stringWithFormat:@"<%@>",self.zhuihaodata.yiFuAmount] intValue];
//        surplusLabel.text = [NSString stringWithFormat:@"剩余  %d",allMoney - paidMoney];
//        NSLog(@"============================>%@",surplusLabel.text);
//        surplusLabel.backgroundColor = [UIColor greenColor];
       
       
        UIImageView *syuView = (UIImageView *)[zhanKaiView viewWithTag:888888];

      if (self.zhuihaodata.shengyu > 0) {//剩余 按钮
           Btn.hidden = NO;
          [Btn loadButonImage:nil LabelName:[NSString stringWithFormat:@"剩余%d", (int)self.zhuihaodata.shengyu]];
          Btn.buttonName.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
          Btn.buttonName.backgroundColor = [UIColor clearColor];
          Btn.buttonName.font = [UIFont systemFontOfSize:16];
          syuView.hidden = NO;
          [Btn addTarget:self action:@selector(GenDan) forControlEvents:UIControlEventTouchUpInside];
      }else{
            Btn.buttonName.backgroundColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
            [Btn addTarget:self action:@selector(GenDan) forControlEvents:UIControlEventTouchUpInside];
            Btn.hidden = YES;
            syuView.hidden = YES;
        }
       
        zhuiView.text = [NSString stringWithFormat:@"追<%d>期  已追<%d>期", (int)self.zhuihaodata.zhuiHaoIssue, (int)self.zhuihaodata.yiZhuiIssue];//追多少 已经追多少
        
        timeLabelText.text = self.zhuihaodata.betTime;//投注时间
        typeLabel.text = self.zhuihaodata.zhuiHaoTypeString;//状态
        NOLabelText.text = self.schemeID;

        
        awardMoney.text = self.zhuihaodata.awardAmount;
        
        CGSize size3 = [zhongjiangLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake(200, 20)];
        CGSize size4 = [yuanLable.text sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake(200, 20)];
        CGSize size5 = [awardMoney.text sizeWithFont:awardMoney.font constrainedToSize:CGSizeMake(200, 20) ];
        
        zhongjiangLabel.frame = CGRectMake((300 - size3.width - size4.width - size5.width)/2, 13, size3.width, 20);
        awardMoney.frame = CGRectMake(zhongjiangLabel.frame.origin.x+zhongjiangLabel.frame.size.width, 13, size5.width, 20);
        yuanLable.frame = CGRectMake(awardMoney.frame.origin.x+awardMoney.frame.size.width, 13, size4.width, 20);
        

        zhanKaiView.hidden = NO;
        myTableView.hidden = NO;
        [self showFunc];
        
        
        
        [br release];
    }
    [myTableView setTableHeaderView:zhanKaiView];
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




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgimage.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:bgimage];
    [bgimage release];
    
    
    
    
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = left;
    
    
    
    
    // 展开
    zhanKaiView = [[CPZhanKaiView alloc] init];
    zhanKaiView.frame = CGRectMake(0, 0, 320, 65+65);
    zhanKaiView.normalHeight = 130;
    zhanKaiView.tag = 3;
    zhanKaiView.hidden = YES;
    zhanKaiView.zhankaiHeight = 130;
    zhanKaiView.zhankaiDelegate = self;
//    zhanKaiView.userInteractionEnabled = YES;
    zhanKaiView.backgroundColor = [UIColor clearColor];
    zhanKaiView.backgroundColor = [UIColor magentaColor];

    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.frame = CGRectMake(0, 0, 320, 64+25);
    imageView.userInteractionEnabled = YES;
    [zhanKaiView addSubview:imageView];
    imageView.frame = CGRectMake(0, 0, 320, 65);
    [imageView release];
    
    UIView *line = [[[UIView alloc] init] autorelease];
    line.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    line.frame = CGRectMake(0, 65, 320, 0.5);
    [zhanKaiView addSubview:line];
    
    

    
    
    
    
    
    // 百分比
    percentage = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 140, 20)];
    percentage.textAlignment = NSTextAlignmentLeft;
    percentage.font = [UIFont  boldSystemFontOfSize:16];
    percentage.backgroundColor = [UIColor clearColor];
    percentage.textColor = [UIColor blackColor];
    [imageView addSubview:percentage];
    [percentage release];
    
    
    
    // 总金
    changciView = [[ColorView alloc] init];
    changciView.font = [UIFont systemFontOfSize:12];
    changciView.colorfont = [UIFont systemFontOfSize:16];
    changciView.backgroundColor = [UIColor clearColor];
    changciView.textAlignment = NSTextAlignmentLeft;
    changciView.frame = CGRectMake(15, 27+9, 70, 20);
    [imageView addSubview:changciView];
    changciView.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    changciView.changeColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    changciView.pianyiy = 1;
    [changciView release];
    
    
    // 已付
    changciView2 = [[ColorView alloc] init];
    changciView2.font = [UIFont systemFontOfSize:12];
    changciView2.colorfont = [UIFont systemFontOfSize:16];
    changciView2.backgroundColor = [UIColor clearColor];
    changciView2.frame = CGRectMake(105, 27+9, 70, 20);
    [imageView addSubview:changciView2];
    changciView2.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    changciView2.changeColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    [changciView2 release];
    
   
   
    // 剩余
    Btn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    Btn.frame = CGRectMake(211, 18, 75, 27);
    [Btn setBackgroundImage:[UIImageGetImageFromName(@"tongyonglan.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(GenDan) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:Btn];
    
    
    
    
  
    
    // 展开图片
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    imageView2.frame = CGRectMake(0, 40+20+25, 320, 67);
    imageView2.frame = CGRectMake(0, 65, 320, 65);
    imageView2.tag = 302;
    imageView2.userInteractionEnabled = YES;
    [zhanKaiView insertSubview:imageView2 belowSubview:imageView];
    [imageView2 release];

    
    
    
    
    // 追期
    zhuiView = [[ColorView alloc] init];
    zhuiView.font = [UIFont systemFontOfSize:12];
    zhuiView.colorfont = [UIFont systemFontOfSize:12];
    zhuiView.backgroundColor = [UIColor clearColor];
    zhuiView.frame = CGRectMake(15, 15, 130, 20);
    [imageView2 addSubview:zhuiView];
    zhuiView.textColor = [UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1];
    zhuiView.changeColor = [UIColor colorWithRed:255.0/255.0 green:61.0/255.0 blue:48.0/255.0 alpha:1];
    [zhuiView release];
    
    
    
    
    

    
    
    // 时间
    timeLabelText = [[UILabel alloc] initWithFrame:CGRectMake(158, 13, 125, 20)];
    timeLabelText.textAlignment = NSTextAlignmentLeft;
    timeLabelText.font = [UIFont  systemFontOfSize:12];
    timeLabelText.backgroundColor = [UIColor clearColor];
    timeLabelText.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
    [imageView2 addSubview:timeLabelText];
    [timeLabelText release];
    
    
    typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 36, 130, 20)];
    typeLabel.textAlignment = NSTextAlignmentLeft;
    typeLabel.font = [UIFont  systemFontOfSize:12];
    typeLabel.backgroundColor = [UIColor clearColor];
    typeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [imageView2 addSubview:typeLabel];
    [typeLabel  release];
    
    
    
    UILabel * NOLabel = [[UILabel alloc] initWithFrame:CGRectMake(138+20, 36, 50, 20)];
    NOLabel.text = @"订单号";
    NOLabel.textAlignment = NSTextAlignmentLeft;
    NOLabel.font = [UIFont  systemFontOfSize:12];
    NOLabel.backgroundColor = [UIColor clearColor];
    NOLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [imageView2 addSubview:NOLabel];
    [NOLabel release];
    
    NOLabelText = [[UILabel alloc] initWithFrame:CGRectMake(200, 37, 100, 20)];
//    NOLabelText.text = @"1242352353245";
    NOLabelText.textAlignment = NSTextAlignmentLeft;
    NOLabelText.font = [UIFont  systemFontOfSize:12];
    NOLabelText.backgroundColor = [UIColor clearColor];
    NOLabelText.textColor = [UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1];
    [imageView2 addSubview:NOLabelText];
    [NOLabelText release];
    
    
//    UIImageView *imageView3 = [[UIImageView alloc] init];
//    imageView3.image = UIImageGetImageFromName(@"XQCYHMSBG-1960.png");
//    zhanKaiView.fengeImageView = imageView3;
//    imageView3.frame = CGRectMake(0, zhanKaiView.frame.size.height - 5, 320, 5);
//    [zhanKaiView addSubview:imageView3];
//    imageView3.backgroundColor = [UIColor yellowColor];
//    [imageView3 release];
    
    
    
    
    [self.mainView addSubview:zhanKaiView];
    [zhanKaiView release];
    
    
    
    awardView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12, 320, 46)];//中奖图片
    awardView.backgroundColor = [UIColor clearColor];
    awardView.hidden = YES;
    [self.mainView addSubview:awardView];
    [awardView release];
    
//    awardLabel = [[ColorView alloc] init];
//    awardLabel.font = [UIFont boldSystemFontOfSize:14];
//    awardLabel.colorfont = [UIFont boldSystemFontOfSize:18];
//    awardLabel.backgroundColor = [UIColor clearColor];
//     awardLabel.textAlignment = NSTextAlignmentCenter;
//    awardLabel.frame = CGRectMake(0, 13, 300, 20);
//    [awardView addSubview:awardLabel];
//    awardLabel.textColor = [UIColor blackColor];
//    awardLabel.changeColor = [UIColor redColor];
//    awardLabel.pianyiy = 1;
////    awardLabel.text = @"中奖<2325>元";
//    [awardLabel release];
    
    zhongjiangLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 13, 0, 0)];
    zhongjiangLabel.text = @"中奖";
    zhongjiangLabel.textAlignment = NSTextAlignmentLeft;
    zhongjiangLabel.font = [UIFont  boldSystemFontOfSize:14];
    zhongjiangLabel.backgroundColor = [UIColor clearColor];
    zhongjiangLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [awardView addSubview:zhongjiangLabel];
    [zhongjiangLabel release];
    
    yuanLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 13, 0, 0)];
    yuanLable.text = @"元";
    yuanLable.textAlignment = NSTextAlignmentLeft;
    yuanLable.font = [UIFont  boldSystemFontOfSize:14];
    yuanLable.backgroundColor = [UIColor clearColor];
    yuanLable.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [awardView addSubview:yuanLable];
    [yuanLable release];
    
    awardMoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 13, 0, 0)];
    awardMoney.textAlignment = NSTextAlignmentLeft;
    awardMoney.font = [UIFont  boldSystemFontOfSize:18];
    awardMoney.backgroundColor = [UIColor clearColor];
    awardMoney.textColor = [UIColor colorWithRed:255.0/255.0 green:59.0/255.0 blue:48.0/255.0 alpha:1];
    [awardView addSubview:awardMoney];
    [awardMoney release];
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, self.mainView.frame.size.width, self.mainView.frame.size.height - 65) style:UITableViewStylePlain];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.hidden = YES;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:myTableView];
    [myTableView release];
    
    UIView *tableViewLine = [[[UIView alloc] init] autorelease];
    tableViewLine.backgroundColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1];
    tableViewLine.frame = CGRectMake(0, 0, 320, 0.5);
    [myTableView addSubview:tableViewLine];
    
    loadview = [[UpLoadView alloc] init];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];

    [self requestInfoFunc:1];
}



- (void)GenDan{
    
    CheDanZhuiViewController * chedan = [[CheDanZhuiViewController alloc] init];
    chedan.delegate = self;
    chedan.schemeID = self.schemeID;
    chedan.title = [NSString stringWithFormat:@"%@剩余单",self.zhuihaodata.lotteryName];
    [self.navigationController pushViewController:chedan animated:YES];
    [chedan release];

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

    return 76.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{\
    
   
    NSInteger count = 0;
    if (self.zhuihaodata) {
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
		cell1.backgroundColor = [UIColor clearColor];
		return cell1;
	}else{
    
        NSString * cellid = @"cellid";
        
        LotterySalesCell *cell1 = (LotterySalesCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
        
        if (cell1 == nil) {
            // cell1 = [[[LotterySalesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
            
            cell1 = [[[LotterySalesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid withIndex:indexPath withCellCount:[self.zhuihaodata.infoList count]] autorelease];
            [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
            
       
        }
        
        
        if (self.zhuihaodata) {
            cell1.infoData = self.zhuihaodata;
            cell1.infoListData = [self.zhuihaodata.infoList objectAtIndex:indexPath.row];
            
        }
        
        
        cell1.backgroundColor = [UIColor clearColor];
        return cell1;
    }

    return nil;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == [self.zhuihaodata.infoList count]) {
        [moreCell spinnerStartAnimating];
        [self requestInfoFunc:1];
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
    
//        CheDanZhuiViewController * chedan = [[CheDanZhuiViewController alloc] init];
//        chedan.delegate = self;
//        chedan.schemeID = self.schemeID;
//        chedan.title = [NSString stringWithFormat:@"%@剩余单",self.zhuihaodata.lotteryName];
//        [self.navigationController pushViewController:chedan animated:YES];
//        [chedan release];
    }

}

#pragma mark CPZhankaiViewDelegte

- (void)ZhankaiViewClicke:(CPZhanKaiView *)_zhankaiView {
//    if (_zhankaiView.isOpen) {
////        [self resetHeadViewHeightWithHight:_zhankaiView.zhankaiHeight - _zhankaiView.normalHeight clickeView:_zhankaiView];
//    }
//    else {
////        [self resetHeadViewHeightWithHight: _zhankaiView.normalHeight - _zhankaiView.zhankaiHeight clickeView:_zhankaiView];
//    }
    [self showFunc];
   
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