    //
//  tuisongtongzhiButtonController.m
//  caibo
//
//  Created by user on 11-6-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TuisongtongzhiButtonController.h"
#import "PickerView.h"
#import "datafile.h"

#import "NetURL.h"
#import "Info.h"
#import "SBJSON.h"
#import "JSON.h"
#import "HongBaoInfo.h"
#import "CP_PrizeView.h"

@implementation TuisongtongzhiButtonController
@synthesize listData, kaiJiangData,statusData,string, sw1value, sw2value,myTableView;
@synthesize mrequest;
@synthesize asirequest;
@synthesize chekrequest;
UISwitch *switchView1;
UISwitch *switchView2;
UISwitch *switchView3;
UISwitch *switchView4;
NSString *str_comment;
NSString *str_mention;
NSString *str_private_letter;
NSString *str_new_fans;
NSString *str_zhongjiang;
NSString *str_kaijiang;
UILabel *time_label;
NSString *begin_time;
NSString *end_time;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil SwitchArray:(NSMutableArray *)sarray{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        
        
            switchArray = [[NSMutableArray alloc] initWithCapacity:0];
        NSLog(@"sarray = %@", sarray);
        if ([sarray count]>0) {
            [switchArray removeAllObjects];
            [switchArray addObjectsFromArray:sarray];
        }
        
    
    }
    return self;
}


- (void)requestChekNew{
    
    self.chekrequest = [ASIHTTPRequest requestWithURL:[NetURL CbGetUnreadPushNum:[[Info getInstance] userId]]];
    //  [self setMrequest:[ASIHTTPRequest requestWithURL:[NetURL CbGetUnreadPushNum:[[Info getInstance] userId]]]];
    [chekrequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [chekrequest setDelegate:self];
    [chekrequest setDidFinishSelector:@selector(unReadPushNumData:)];
    //   [chekrequest setDidFailSelector:@selector(unReadPushNumDatafail:)];
    [chekrequest setNumberOfTimesToRetryOnTimeout:2];
    [chekrequest setShouldContinueWhenAppEntersBackground:YES];
    [chekrequest startAsynchronous];
    
}

- (void)unReadPushNumData:(ASIHTTPRequest *)mreque{
    
    
//    NSString * str = [mreque responseString];
//    NSLog(@"str = %@", str);
    
    
    
    NSString *message = [[NSString alloc] initWithFormat: @"您的账号已经激活推送服务"];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"提示"
                          message: message
                          delegate: self
                          cancelButtonTitle: @"取消"
                          otherButtonTitles: nil];
    [alert show];
    [alert release];
    [message release];

}
- (void)tableReturnIndexPathSection:(NSInteger)section indexPathRow:(NSInteger)row{
    
    if (section == 3&& row == 0) {
         [pView show];
        
        
        
    }else if(section == 3&& row == 1){
//        NSString *message = [[NSString alloc] initWithFormat: @"您的账号已经激活推送服务"];
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle: @"提示"
//                              message: message
//                              delegate: self
//                              cancelButtonTitle: @"取消"
//                              otherButtonTitles: nil];
//        [alert show];
//        [alert release];
//        [message release];
    
    [self requestChekNew];
        
    }
    
    
}

- (void)tableSwitchArray:(NSMutableArray *)array{
    NSLog(@"array = %@", array);
    switchArray = array;

}

- (void)LoadiPhoneView {

    if (!switchArray) {
        switchArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    UIImageView * bgview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgview.backgroundColor = [UIColor clearColor];
    // bgview.image = [UIImage imageNamed:@"login_bgn.png"];
    bgview.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:bgview];
    [bgview release];
    
    
    
    
	self.CP_navigation.title = @"推送设置";
	self.statusData = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
	self.kaiJiangData = [NSMutableArray arrayWithObjects:@"双色球",@"3D",@"七乐彩",@"大乐透",@"排列3/排列5",@"七星彩", @"胜负彩", @"六场半全场", @"四场进球",nil];
    
   
    
    alltitle = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray * title = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray * title1 = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray * title2 = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray * title3 = [[NSMutableArray alloc] initWithCapacity:0];
    [title addObject:@"声音推送"];
    [title1 addObject:@"中奖通知"];
    [title2 addObject:@"双色球"];
    [title2 addObject:@"福彩3D"];
    [title2 addObject:@"七乐彩"];
    [title2 addObject:@"大乐透"];
    [title2 addObject:@"排列3/排列5"];
    [title2 addObject:@"七星彩"];
    [title2 addObject:@"胜负彩"];
    [title2 addObject:@"六场半全场"];
    [title2 addObject:@"四场进球"];
    
    
   
    
    NSMutableString *time = [[NSMutableString alloc] init];
    begin_time = [datafile getDataByKey: KEY_BEGIN_TIME];
    end_time = [datafile getDataByKey: KEY_END_TIME];
    
    if ((begin_time == nil) || (end_time == nil)) {
        begin_time = @"9:00";
        end_time = @"21:00";
    }
    
    [time appendString: begin_time];
    [time appendString: @"--"];
    [time appendString: end_time];
    [title3 addObject:time];
    
    
    [title3 addObject:@"检测推送服务"];
    [alltitle addObject:title];
    [alltitle addObject:title1];
    [alltitle addObject:title2];
    [alltitle addObject:title3];
    [title release];
    [title1 release];
    [title2 release];
    [title3 release];
    [time release];
    myTableView.hidden = YES;
    
   
    
    
    
    ntableview = [[CP_NTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.frame.size.height)];
    ntableview.CP_TableViewStyle = CP_TableViewSwitchStyle;
    ntableview.delegate = self;
    ntableview.titleArray = alltitle;
    
    //ntableview.switchArray = ;
    
    [self.mainView addSubview:ntableview];
    
    
    
    //	UIImage *image = UIImageGetImageFromName(@"btn_arrowL_bg.png");
    //	UIButton *back = [[[UIButton alloc] initWithFrame: CGRectMake(0, 0, image.size.width, image.size.height)] autorelease];
    //	[back setBackgroundImage: image forState: UIControlStateNormal];
    //	[self setButtonStyle: back style: 1];
    //	UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] initWithCustomView: back];
    //	self.navigationItem.leftBarButtonItem = backbutton;
    //	[backbutton release];
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
	
	
    //	UIButton *done = [[[UIButton alloc] initWithFrame: CGRectMake(0, 0, 56, 30)] autorelease];
    //	[self setButtonStyle: done style: 2];
    //	UIBarButtonItem *donebutton = [[UIBarButtonItem alloc] initWithCustomView: done];
    //	self.navigationItem.rightBarButtonItem = donebutton;
    //	[donebutton release];
    
    //    UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"完成" Target:self action:@selector(done:)];
    //    [self.navigationItem setRightBarButtonItem:rightItem];
    
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBounds:CGRectMake(0, 0, 70, 40)];
    UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
    imagevi.backgroundColor = [UIColor clearColor];
    // imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    [btn addSubview:imagevi];
    [imagevi release];
    
    
    
    
    UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 10, 58, 26)];
    lilable.textColor = [UIColor whiteColor];
    lilable.backgroundColor = [UIColor clearColor];
    lilable.textAlignment = NSTextAlignmentCenter;
    lilable.font = [UIFont systemFontOfSize:18];
    
    lilable.text = @"完成";
    [btn addSubview:lilable];
    [lilable release];
    [btn addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.CP_navigation.rightBarButtonItem = barBtnItem;
    [barBtnItem release];//    UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"完成" Target:self action:@selector(pressWriteButton:)];
    //    [self.navigationItem httptem:rightItem];
    //    [rightItem release];
    
	NSArray *array = [[NSArray alloc] initWithObjects:@"中奖通知",nil];
    self.listData = array;
	[array release];
	self.string = @"检测推送服务";
	
    
    
    
    
	pView = [PickerView getInstance];
	[pView setDelegate: self];
	[self.mainView addSubview: pView];
    
    if ([switchArray count] == 0 || !switchArray) {
        [self getPushStatus];
    }else{
        ntableview.switchArray = switchArray;
    }
    
    
    
    
    
    
    
}

- (void)LoadiPadView {
    self.view.backgroundColor= [UIColor clearColor];
    [self.navigationController setNavigationBarHidden:YES];
    self.CP_navigation.image = UIImageGetImageFromName(@"daohangtiao.png");//更换导航栏
    self.CP_navigation.frame = CGRectMake(0, 0, 540, 44);
    self.CP_navigation.title = @"推送设置";
    
    if (!switchArray) {
        switchArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    
    UIImageView *bgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, 540, 600)];
    bgview.backgroundColor = [UIColor clearColor];
    bgview.image = [UIImage imageNamed:@"bejing.png"];
    [self.mainView addSubview:bgview];
    [bgview release];
    
	self.statusData = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
	self.kaiJiangData = [NSMutableArray arrayWithObjects:@"双色球",@"3D",@"七乐彩",@"大乐透",@"排列3/排列5",@"七星彩",@"22选5", @"胜负彩", @"六场半全场", @"四场进球",nil];
    
    
    alltitle = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray * title1 = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray * title2 = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray * title3 = [[NSMutableArray alloc] initWithCapacity:0];
    [title1 addObject:@"中奖通知"];
    [title2 addObject:@"双色球"];
    [title2 addObject:@"3D"];
    [title2 addObject:@"七乐彩"];
    [title2 addObject:@"大乐透"];
    [title2 addObject:@"排列3/排列5"];
    [title2 addObject:@"七星彩"];
    [title2 addObject:@"22选5"];
    [title2 addObject:@"胜负彩"];
    [title2 addObject:@"六场半全场"];
    [title2 addObject:@"四场进球"];
    
    
    NSMutableString *time = [[NSMutableString alloc] init];
    begin_time = [datafile getDataByKey: KEY_BEGIN_TIME];
    end_time = [datafile getDataByKey: KEY_END_TIME];
    
    if ((begin_time == nil) || (end_time == nil)) {
        begin_time = @"9:00";
        end_time = @"21:00";
    }
    
    [time appendString: begin_time];
    [time appendString: @"--"];
    [time appendString: end_time];
    [title3 addObject:time];
    
    
    [title3 addObject:@"检测推送服务"];
    [alltitle addObject:title1];
    [alltitle addObject:title2];
    [alltitle addObject:title3];
    [title1 release];
    [title2 release];
    [title3 release];
    [time release];
    myTableView.hidden = YES;
    
    ntableview = [[CP_NTableView alloc] initWithFrame:CGRectMake(0, 0, 540, 570)];
    ntableview.backgroundColor = [UIColor clearColor];
    ntableview.CP_TableViewStyle = CP_TableViewSwitchStyle;
    ntableview.delegate = self;
    ntableview.titleArray = alltitle;
    [self.mainView addSubview:ntableview];
    self.mainView.frame = CGRectMake(0, 44, 540, 570);
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
	
    
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBounds:CGRectMake(0, 0, 70, 40)];
    UIImageView * imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(6, 7, 58, 26)];
    imagevi.backgroundColor = [UIColor clearColor];
    imagevi.image = [UIImageGetImageFromName(@"anniubgimage.png") stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    [btn addSubview:imagevi];
    [imagevi release];
    
    UILabel * lilable = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 58, 26)];
    lilable.textColor = [UIColor whiteColor];
    lilable.backgroundColor = [UIColor clearColor];
    lilable.textAlignment = NSTextAlignmentCenter;
    lilable.font = [UIFont boldSystemFontOfSize:14];
    lilable.shadowColor = [UIColor blackColor];//阴影
    lilable.shadowOffset = CGSizeMake(0, 1.0);
    lilable.text = @"完成";
    [btn addSubview:lilable];
    [lilable release];
    [btn addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.CP_navigation.rightBarButtonItem = barBtnItem;
    [barBtnItem release];

    
	NSArray *array = [[NSArray alloc] initWithObjects:@"中奖",nil];
    self.listData = array;
	[array release];
	
	self.string = @"检测推送服务";
	
	pView = [PickerView getInstance];
	[pView setDelegate: self];
	[self.mainView addSubview: pView];
    
    if ([switchArray count] == 0 || !switchArray) {
        [self getPushStatus];
    }else{
        ntableview.switchArray = switchArray;
    }
    
    
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
  //  myTableView.hidden = YES;

    
#ifdef isCaiPiaoForIPad
    
    [self LoadiPadView];
    
#else
    
    [self LoadiPhoneView];
    
#endif

    
}

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getPushStatus
{
    [asirequest clearDelegatesAndCancel];
   self.asirequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetPushStatus:[[Info getInstance] userId]]];
   //NSLog(@"url = %@",[NetURL CBgetPushStatus:[[Info getInstance] userId]] );
    [asirequest setDefaultResponseEncoding:NSUTF8StringEncoding];
	[asirequest setDelegate:self];
	[asirequest setDidFinishSelector:@selector(parseSwitchStatu:)];
	//[request setNumberOfTimesToRetryOnTimeout:2];
	[asirequest startAsynchronous];


}
- (void)parseSwitchStatu:(ASIHTTPRequest *)request
{

    NSString *responseString = [request responseString];
	SBJSON *jsonParse = [[SBJSON alloc]init];
    NSLog(@"respo = %@", responseString);
	NSDictionary *dic = [jsonParse objectWithString:responseString];
    NSLog(@"dic = %@", dic);
//    NSString *switch2Value=[dic objectForKey:@"kj"];
//    NSString *switch1Value=[dic objectForKey:@"zj"];
	isPushZj = [[dic objectForKey:@"zj"] boolValue];
	[statusData removeAllObjects];
	[statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"ssqkj"] intValue]]];
	[statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"sdkj"] intValue]]];
	[statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"qlckj"] intValue]]];
	[statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"dltkj"] intValue]]];
	[statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"pskj"] intValue]]];
	[statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"qxckj"] intValue]]];
//	[statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"eekj"] intValue]]];
	[statusData addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"zckj"] intValue]]];
    [statusData addObject:[NSString stringWithFormat:@"%d", [[dic objectForKey:@"lcbqckj"] intValue]]];
    [statusData addObject:[NSString stringWithFormat:@"%d", [[dic objectForKey:@"scjqkj"] intValue]]];
	[myTableView reloadData];
//   NSLog(@"switch1Value====%@", switch1Value);
//    NSLog(@"switch2Value====%@", switch2Value);
//    [datafile setdata: switch1Value forkey:KEY_ZHONGJIANG];
//    [datafile setdata: switch2Value   forkey:KEY_KAIJIANG];
//    if (dic) {
//        UISwitch *switch1=(UISwitch *)[self.view  viewWithTag:SWITCH1NUM];
//        [switch1 setOn:[switch1Value boolValue]];
//        UISwitch *switch2=(UISwitch *)[self.view  viewWithTag:SWITCH2NUM];
//        [switch2 setOn:[switch2Value boolValue]];
//        
//    }
    [switchArray removeAllObjects];
    NSMutableArray * soundArray = [[NSMutableArray alloc] initWithCapacity:0];
    [soundArray addObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"pushSound"]];
    
    NSMutableArray * arrayzhong = [[NSMutableArray alloc] initWithCapacity:0];
    [arrayzhong addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"zj"] intValue]]];
    
    [switchArray addObject:soundArray];
    [switchArray addObject:arrayzhong];
    [switchArray addObject:statusData];
    [arrayzhong release];
    [soundArray release];
    ntableview.switchArray = switchArray;
    [[NSUserDefaults standardUserDefaults] setValue:switchArray forKey:@"tuisongshezhi"];
    [jsonParse release];


}

- (void)setButtonStyle: (UIButton *)button style: (NSInteger)n
{
	if (n == 1) {
		[button setTitle: @"返 回" forState: UIControlStateNormal];
		button.titleLabel.font = [UIFont systemFontOfSize: 13];
		button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 4);
		[button addTarget: self action: @selector(cancel:) forControlEvents: UIControlEventTouchUpInside];		
	}
	else if(n == 2){
        UILabel * wanchenglabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 56, 30)];
        wanchenglabel.text = @"完成";
        wanchenglabel.textAlignment = NSTextAlignmentCenter;
        wanchenglabel.textColor = [UIColor whiteColor];
        wanchenglabel.backgroundColor = [UIColor clearColor];
        
		[button setImage: UIImageGetImageFromName(@"wb_fin.png") forState: UIControlStateNormal];
		[button addTarget: self action: @selector(done:) forControlEvents: UIControlEventTouchUpInside];
        [button addSubview:wanchenglabel];
        [wanchenglabel release];
	}
}


- (IBAction)cancel: (id)sender
{
	[self.navigationController popViewControllerAnimated: YES];
	[pView disappear];
}


- (IBAction)done: (id)sender
{
	[pView disappear];
    
    [datafile setdata: str_zhongjiang forkey:KEY_ZHONGJIANG];
    [datafile setdata: str_kaijiang   forkey:KEY_KAIJIANG];
	
    [[NSUserDefaults standardUserDefaults] setValue:[[switchArray objectAtIndex:0] objectAtIndex:0] forKey:@"pushSound"];
    if ([[[switchArray objectAtIndex:0] objectAtIndex:0] isEqualToString:@"1"]) {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                                 settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                                 categories:nil]];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
        else  {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];
            
        }
    }else{
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                                 settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                                 categories:nil]];
            
            
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
        else {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert];
        }
    }

    NSMutableArray * arrayzj = [switchArray objectAtIndex:1];
    NSMutableArray * arraykj = [switchArray objectAtIndex:2];
    
     NSLog(@"data = %@, zj = %@", arraykj ,[arrayzj objectAtIndex:0]);
    
    [mrequest clearDelegatesAndCancel];
    self.mrequest = [ASIHTTPRequest requestWithURL:[NetURL CBsetPushStatus:[[Info getInstance] userId] kj:arraykj zj:[arrayzj objectAtIndex:0]]];
    
    [mrequest setDefaultResponseEncoding:NSUTF8StringEncoding];
	[mrequest setDelegate:self];
	[mrequest setDidFinishSelector:@selector(parseInfoStatu:)];
	//[request setNumberOfTimesToRetryOnTimeout:2];
	[mrequest startAsynchronous];
    
    
    /*
	[datafile setdata: str_comment forkey: KEY_COMMENT];
	[datafile setdata: str_mention forkey: KEY_MENTION];
	[datafile setdata: str_private_letter forkey: KEY_PRIVATE_LETTER];
	[datafile setdata: str_new_fans forkey: KEY_NEW_FANS];
     */

	
}

- (void)parseInfoStatu:(ASIHTTPRequest *)request 
{
    
    NSString * str = [request responseString];
    NSDictionary * dict = [str JSONValue];
    if ([[dict objectForKey:@"result"] isEqualToString:@"succ"]) {
        [[NSUserDefaults standardUserDefaults] setValue:switchArray forKey:@"tuisongshezhi"];
    }
    
    [self.navigationController popViewControllerAnimated: YES];
}

// Return the number of sections.
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 3;
//}


// Customize the number of rows in the table view.
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//	if (section == 1) {
//		return 9;
//	}
//    return (section == 0) ? 1 : 2;
//}
//
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection: (NSInteger)section {
//	if (section == 0) {
//		return @"中奖消息";
//	}
//	else if (section == 1) {
//		return @"开奖消息";
//	}
//	else if(section == 2){
//		return @"通知接收时段";
//	}
//	return NULL;
//}



// Customize the appearance of table view cells.
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *CellIdentifier = @"Cell";
//	NSUInteger row = [indexPath row];
//	
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//    }
//    for (UIView *v in cell.contentView.subviews) {
//		[v removeFromSuperview];
//	}
//	// Configure the cell...
//	cell.accessoryType = UITableViewCellAccessoryNone;
//	cell.textLabel.textAlignment = NSTextAlignmentLeft;
//	cell.textLabel.backgroundColor = [UIColor clearColor];
//	if (indexPath.section == 0) {
//		cell.textLabel.text = [listData objectAtIndex: row];
//		BOOL temp = NO;
//		NSString *gdata = nil;
//		
//		//评论 开关 文件中标记为 "COMMENT_SWITCH_ON"
//        
//        if (row == 0)
//		{
//			switchView1 = [[UISwitch alloc] initWithFrame: CGRectMake(200, 10, 80, 40)];
//            switchView1.tag=SWITCH1NUM;
//			gdata = [datafile getDataByKey: KEY_ZHONGJIANG];
//			if (gdata == nil) {
//				temp = YES;
//                self.sw1value = [NSString stringWithFormat:@"%d",1];
//				[datafile setdata: ZHONGJIANG_SWITCH_ON forkey: KEY_ZHONGJIANG];
//				gdata = ZHONGJIANG_SWITCH_ON;
//			}
//			else if ([gdata isEqualToString: ZHONGJIANG_SWITCH_ON]) {
//				temp = YES;
//                self.sw1value = [NSString stringWithFormat:@"%d",1];
//			}
//			else {
//                self.sw1value = [NSString stringWithFormat:@"%d",0];
//				temp = NO;
//			}
//			str_comment = gdata;
//			[switchView1 setOn: temp animated: NO];
//			switchView1.on = isPushZj;
//			[switchView1 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
//			[cell.contentView addSubview: switchView1];
//			[switchView1 release];
//		}
//		//提到我的 开关 文件中标记为 "MENTION_SWITCH_ON"
//		else if(row == 1)
//		{
////			switchView2 = [[UISwitch alloc] initWithFrame: CGRectMake(180, 10, 80, 40)];
////            switchView2.tag=SWITCH2NUM;
////			gdata = [datafile getDataByKey: KEY_KAIJIANG];
////			if (gdata == nil) {
////				temp = YES;
////                self.sw2value = [NSString stringWithFormat:@"%d",1];
////				[datafile setdata: KAIJIANG_SWITCH_ON forkey: KEY_KAIJIANG];
////				gdata = KAIJIANG_SWITCH_ON;
////			}
////			else if ([gdata isEqualToString: KAIJIANG_SWITCH_ON]) {
////				temp = YES;
////                self.sw2value = [NSString stringWithFormat:@"%d",1];
////			}
////			else {
////				temp = NO;
////                self.sw2value = [NSString stringWithFormat:@"%d",0];
////			}
////			str_mention = gdata;
////			[switchView2 setOn: temp animated: NO];
////			[switchView2 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
////			[cell.contentView addSubview: switchView2];
////			[switchView2 release];
//		}
//
//        
//        /*
//		if (row == 0)
//		{
//			switchView1 = [[UISwitch alloc] initWithFrame: CGRectMake(200, 10, 80, 40)];
//			gdata = [datafile getDataByKey: KEY_COMMENT];
//			if (gdata == nil) {
//				temp = YES;
//				[datafile setdata: COMMENT_SWITCH_ON forkey: KEY_COMMENT];
//				gdata = COMMENT_SWITCH_ON;
//			}
//			else if ([gdata isEqualToString: COMMENT_SWITCH_ON]) {
//				temp = YES;
//			}
//			else {
//				temp = NO;
//			}
//			str_comment = gdata;
//			[switchView1 setOn: temp animated: NO];
//			[switchView1 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
//			[cell addSubview: switchView1];
//			[switchView1 release];
//		}
//		//提到我的 开关 文件中标记为 "MENTION_SWITCH_ON"
//		else if(row == 1)
//		{
//			switchView2 = [[UISwitch alloc] initWithFrame: CGRectMake(200, 10, 80, 40)];
//		
//			gdata = [datafile getDataByKey: KEY_MENTION];
//			if (gdata == nil) {
//				temp = YES;
//				[datafile setdata: MENTION_SWITCH_ON forkey: KEY_MENTION];
//				gdata = MENTION_SWITCH_ON;
//			}
//			else if ([gdata isEqualToString: MENTION_SWITCH_ON]) {
//				temp = YES;
//			}
//			else {
//				temp = NO;
//			}
//			str_mention = gdata;
//			[switchView2 setOn: temp animated: NO];
//			[switchView2 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
//			[cell addSubview: switchView2];
//			[switchView2 release];
//		}
//		//私信 开关 文件中标记为 "PRIVATE_LETTER_SWITCH_ON"
//		else if(row == 2)
//		{
//			switchView3 = [[UISwitch alloc] initWithFrame: CGRectMake(200, 10, 80, 40)];
//
//			gdata = [datafile getDataByKey: KEY_PRIVATE_LETTER];
//			if (gdata == nil) {
//				temp = YES;
//				[datafile setdata: PRIVATE_LETTER_SWITCH_ON forkey: KEY_PRIVATE_LETTER];
//				gdata = PRIVATE_LETTER_SWITCH_ON;
//			}
//			else if ([gdata isEqualToString: PRIVATE_LETTER_SWITCH_ON]) {
//				temp = YES;
//			}
//			else {
//				temp = NO;
//			}
//			str_private_letter = gdata;
//			[switchView3 setOn: temp animated: NO];
//			[switchView3 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
//			[cell addSubview: switchView3];
//			[switchView3 release];
//		}
//		//粉丝 开关 文件中标记为 "NEW_FANS_SWITCH_ON"
//		else if(row == 3)
//		{
//			switchView4 = [[UISwitch alloc] initWithFrame: CGRectMake(200, 10, 80, 40)];
//
//			gdata = [datafile getDataByKey: KEY_NEW_FANS];
//			if (gdata == nil) {
//				temp = YES;
//				[datafile setdata: NEW_FANS_SWITCH_ON forkey: KEY_NEW_FANS];
//				gdata = NEW_FANS_SWITCH_ON;
//			}
//			else if ([gdata isEqualToString: NEW_FANS_SWITCH_ON]) {
//				temp = YES;
//			}
//			else {
//				temp = NO;
//			}
//			str_new_fans = gdata;
//			[switchView4 setOn: temp animated: NO];
//			[switchView4 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
//			[cell addSubview: switchView4];
//			[switchView4 release];
//		}*/
//		cell.selectionStyle = UITableViewCellSelectionStyleNone;
//	}
//	if (indexPath.section == 1) {
//		cell.textLabel.text = [kaiJiangData objectAtIndex:indexPath.row];
//		UISwitch *mySwitch = [[UISwitch alloc] initWithFrame: CGRectMake(200, 10, 80, 40)];
//		mySwitch.tag = indexPath.row;
//		[mySwitch setOn: [[statusData objectAtIndex:indexPath.row] boolValue] animated: NO];
//		[mySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
//		[cell.contentView addSubview: mySwitch];
//		[mySwitch release];
//	}
////	else if(indexPath.section == 1){
//      if(indexPath.section == 2){
//		  cell.textLabel.text = nil;
//          if (row == 0) {
//              NSMutableString *time = [[NSMutableString alloc] init];
//              
//              begin_time = [datafile getDataByKey: KEY_BEGIN_TIME];
//              end_time = [datafile getDataByKey: KEY_END_TIME];
//              
//              if ((begin_time == nil) || (end_time == nil)) {
//                  begin_time = @"9:00";
//                  end_time = @"21:00";
//              }
//              
//              [time appendString: begin_time];
//              [time appendString: @"--"];
//              [time appendString: end_time];
//              
//              time_label = [[UILabel alloc] initWithFrame: CGRectMake(12, 0, 260, 44)];
//              [time_label setTextAlignment:NSTextAlignmentCenter];
//              [time_label setBackgroundColor: [UIColor clearColor]];
//              [time_label setText: time];
//              [time_label setFont:[UIFont fontWithName: @"Helvetica" size: 17]];
//              [cell.contentView addSubview: time_label];
//              [time release];
//			  [time_label release];
//              cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//              cell.selectionStyle = UITableViewCellSelectionStyleNone;
//          }
//          if (row == 1) {
//              cell.textLabel.text = self.string;
//              [cell.textLabel setTextAlignment: NSTextAlignmentCenter];
//          }
//	}
////	else {
////		cell.textLabel.text = self.string;
////		[cell.textLabel setTextAlignment: NSTextAlignmentCenter];
////	}
//	
//	[cell.textLabel setFont: [UIFont fontWithName: @"Helvetica" size: 17]];
//	return cell;
//}



- (void)updata_time: (NSString *)time
{
	[time_label setText: time];

    
  
    NSMutableArray * array3 = [alltitle objectAtIndex:3];
    NSLog(@"array3 = %@", array3);
    [array3 replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@", time]];
    [alltitle replaceObjectAtIndex:3 withObject:array3];
    NSLog(@"time = %@", time);
    NSLog(@"alltitle = %@", alltitle);
//    [time release];
    ntableview.titleArray = alltitle;
}


//开关状态设置
-(void)switchChanged: (UISwitch*)mswitch
{
	if (mswitch == switchView1) {
        isPushZj = mswitch.on;
    
		if (mswitch.on) {
            sw1value = @"1";
        
        } else {
            sw1value = @"0";
    
        }
	}
//    if (mswitch == switchView1) {
//		isPushZj = mswitch.on;
//	}
	else {
		if (mswitch.tag < [statusData count]) {
			NSString *b;
			if (mswitch.on) {
				b = @"1";
			}
			else {
				b = @"0";
			}

			[statusData replaceObjectAtIndex:mswitch.tag withObject:b];
		}
	}

/*	NSString *writedata = [[NSString alloc] init];
	BOOL b;
    if (switchView1 == mswitch)
	{
		if (mswitch.on){
			b = YES;
            self.sw1value = [NSString stringWithFormat:@"%d",1];
			writedata = ZHONGJIANG_SWITCH_ON;
		}
		else{
			b = NO;
            self.sw1value = [NSString stringWithFormat:@"%d",0];
			writedata = OTHER_SWITCH_OFF;
		}
		str_zhongjiang = writedata;
	}
	else if (switchView2 == mswitch)
	{
		if (mswitch.on){
			b = YES;
            self.sw2value = [NSString stringWithFormat:@"%d",1];
			writedata = KAIJIANG_SWITCH_ON;
		}
		else{
			b = NO;
            self.sw2value = [NSString stringWithFormat:@"%d",0];
			writedata = OTHER_SWITCH_OFF;
		}
		str_kaijiang = writedata;
	}

   */ 
    
    /*
	if (switchView1 == mswitch)
	{
		if (mswitch.on){
			b = YES;
			writedata = COMMENT_SWITCH_ON;
		}
		else{
			b = NO;
			writedata = OTHER_SWITCH_OFF;
		}
		str_comment = writedata;
	}
	else if (switchView2 == mswitch)
	{
		if (mswitch.on){
			b = YES;
			writedata = MENTION_SWITCH_ON;
		}
		else{
			b = NO;
			writedata = OTHER_SWITCH_OFF;
		}
		str_mention = writedata;
	}
	else if (switchView3 == mswitch)
	{
		if (mswitch.on){
			b = YES;
			writedata = PRIVATE_LETTER_SWITCH_ON;
		}
		else{
			b = NO;
			writedata = OTHER_SWITCH_OFF;
		}
		str_private_letter = writedata;
	}
	else if (switchView4 == mswitch)
	{
		if (mswitch.on){
			b = YES;
			writedata = NEW_FANS_SWITCH_ON;
		}
		else{
			b = NO;
			writedata = OTHER_SWITCH_OFF;
		}
		str_new_fans = writedata;
	}
	*/
//	[mswitch setOn: b animated: NO];
//	
//	[writedata release];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath: indexPath animated: YES];
	if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [pView show];
        }
		if (indexPath.row == 1) {
            NSString *message = [[NSString alloc] initWithFormat: @"您的账号已经激活推送服务"];
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"提示"
                                  message: message
                                  delegate: self
                                  cancelButtonTitle: @"取消"
                                  otherButtonTitles: nil];
            [alert show];
            [alert release];
            [message release];
            
            

        }
	}
}


- (void)viewDidUnload {
	self.listData = nil;
	self.string = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (void)dealloc {
    [chekrequest clearDelegatesAndCancel];
    [chekrequest release];
    [alltitle release];
    [switchArray release];
    [asirequest clearDelegatesAndCancel];
    [asirequest release];
    [mrequest clearDelegatesAndCancel];
    [mrequest release];
	[listData release];
	[string release];
    [sw2value release];
    [sw1value release];
    [ntableview release];

    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    