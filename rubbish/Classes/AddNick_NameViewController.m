    //
//  AddNick_NameViewController.m
//  caibo
//
//  Created by yao on 12-3-12.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "AddNick_NameViewController.h"
#import "JSON.h"
#import "Info.h"
#import "NetURL.h"
#import "GC_HttpService.h"
#import "UserInfo.h"
#ifdef isCaiPiaoForIPad
#import "IpadRootViewController.h"
#endif
#import "MobClick.h"

@implementation AddNick_NameViewController
@synthesize mRequest;
@synthesize unionId;
@synthesize nickName;
@synthesize dataDic;
@synthesize unNitionLoginType;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)goBackTo {
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
}

- (void)LoadIpadView {
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0 + 110, 40, 320, 80) style:UITableViewStyleGrouped];
	myTableView.dataSource = self;
	myTableView.delegate = self;
    myTableView.backgroundView.backgroundColor = self.mainView.backgroundColor;
	myTableView.backgroundColor = [UIColor clearColor];
	myTableView.scrollEnabled = NO;
	[self.mainView addSubview:myTableView];
	[myTableView release];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 +110, 15, 140, 25)];
	label.font = [UIFont boldSystemFontOfSize:15];
	label.text =@"设置用户名";
	label.backgroundColor = [UIColor clearColor];
	[self.mainView addSubview:label];
	[label release];
	
	UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(150 +110, 18, 140, 20)];
	label2.font = [UIFont systemFontOfSize:12];
	label2.textColor = [UIColor lightGrayColor];
	label2.text =@"设置后将不能修改";
	label2.backgroundColor = [UIColor clearColor];
	[self.mainView addSubview:label2];
	[label2 release];
	
	btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn setTitle:@"确定" forState:UIControlStateNormal];
	[btn setTitle:@"确定" forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn setBackgroundImage:[UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(doNext) forControlEvents:UIControlEventTouchUpInside];
	[self.mainView addSubview:btn];
	btn.frame = CGRectMake(64 +110, 125, 190, 44);
}

- (void)LoadIphoneView {
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 80) style:UITableViewStyleGrouped];
	myTableView.dataSource = self;
	myTableView.delegate = self;
    myTableView.backgroundView.backgroundColor = self.mainView.backgroundColor;
	myTableView.backgroundColor = [UIColor clearColor];
	myTableView.scrollEnabled = NO;
	[self.mainView addSubview:myTableView];
	[myTableView release];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 140, 25)];
	label.font = [UIFont boldSystemFontOfSize:15];
	label.text =@"设置用户名";
	label.backgroundColor = [UIColor clearColor];
	[self.mainView addSubview:label];
	[label release];
	
	UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(150, 18, 140, 20)];
	label2.font = [UIFont systemFontOfSize:12];
	label2.textColor = [UIColor lightGrayColor];
	label2.text =@"设置后将不能修改";
	label2.backgroundColor = [UIColor clearColor];
	[self.mainView addSubview:label2];
	[label2 release];
	
	btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitle:@"确定" forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn setBackgroundImage:[UIImageGetImageFromName(@"dengluanniu_1.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(doNext) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:btn];
	btn.frame = CGRectMake(64, 125, 190, 44);
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"完善资料";
	isTongbu = NO;
	self.mainView.backgroundColor = [UIColor colorWithRed:255/255.0 green:247/255.0 blue:232/255.0 alpha:1];
	//UIBarButtonItem *leftItem = [[Info backItemTarget:self action:@selector(goBackTo)] autorelease];
//	UIBarButtonItem *rightItem = [Info itemInitWithTitle:@"完成" Target:self action:@selector(doNext) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
//	[self.CP_navigation setRightBarButtonItem:rightItem];
	//[self.navigationItem setLeftBarButtonItem:leftItem];
	[self.CP_navigation setHidesBackButton:YES];
#ifdef isCaiPiaoForIPad
    [self LoadIpadView];
    
#else
    [self LoadIphoneView];
#endif
	
}

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [nickNameText becomeFirstResponder];
}

- (void)doNext {
    self.CP_navigation.rightBarButtonItem.enabled = NO;
    btn.userInteractionEnabled = NO;
    if (unNitionLoginType == UnNitionLoginTypeSina) {
        [MobClick event:@"event_disanfangdenglu_adnickname" label:@"新浪"];
    }
    else if (unNitionLoginType == UnNitionLoginTypeAlipay) {
        [MobClick event:@"event_disanfangdenglu_adnickname" label:@"淘宝"];
    }
    else if (unNitionLoginType == UnNitionLoginTypeTeng) {
        [MobClick event:@"event_disanfangdenglu_adnickname" label:@"腾讯微博"];
    }
    else if (unNitionLoginType == UnNitionLoginTypeQQ) {
        [MobClick event:@"event_disanfangdenglu_adnickname" label:@"QQ"];
    }
    else if (unNitionLoginType == UnNitionLoginTypeWX) {
        [MobClick event:@"event_disanfangdenglu_adnickname" label:@"微信"];
    }
    [nickNameText resignFirstResponder];
    NSString *name =  nickNameText.text;
//    if ([name length] == 0) {
//        name = nickNameText.placeholder;
//    }
	if ([nickNameText.text length] == 0) {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"用户名不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alert.delegate = self;
        [alert show];
        [alert release];
        self.CP_navigation.rightBarButtonItem.enabled = YES;
        btn.userInteractionEnabled = YES;
        return;

	}
    NSString *partenerid=@"300";
    NSString *loginSoure = @"1";
    if (unNitionLoginType == UnNitionLoginTypeTeng) {
        partenerid = @"301";
        loginSoure = @"2";
    }
    else if (unNitionLoginType == UnNitionLoginTypeQQ) {
        partenerid = @"311";
        loginSoure = @"3";
    }else if (unNitionLoginType == UnNitionLoginTypeAlipay){
        partenerid = @"102";
        loginSoure = @"4";
    }
    else if (unNitionLoginType == UnNitionLoginTypeWX) {
        partenerid = @"326";
        loginSoure = @"10";
    }
    
	self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL CBsetNickNameForUnionUser:unionId NickName:name Status:[NSString stringWithFormat:@"%d",isTongbu] Partnerid:partenerid LoginSoure:(NSString *)loginSoure]];
	[self.mRequest setDelegate:self ];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
	[self.mRequest setDidFailSelector:@selector(recivedFail:)];
	[self.mRequest setDidFinishSelector:@selector(recivedFinish:)];
	[mRequest startAsynchronous];

}

- (void)recivedFail:(ASIHTTPRequest *)request {
    self.CP_navigation.rightBarButtonItem.enabled = YES;
    btn.userInteractionEnabled = YES;
}

- (void)recivedFinish:(ASIHTTPRequest *)request {
    self.CP_navigation.rightBarButtonItem.enabled = YES;
    btn.userInteractionEnabled = YES;
	NSString *responseStr = [request responseString];
	if ([responseStr isEqualToString:@"fail"] ||[responseStr isEqualToString:@"error"]) {
		CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"设置昵称失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.delegate = self;
		[alert show];
		[alert release];
		return;
	}
	NSDictionary *dic = [responseStr JSONValue];
    NSLog(@"_+_+_+%@_+_+_",dic);
	if ([[dic objectForKey:@"code"] intValue] == 0) {
		Info *info = [Info getInstance];
		info.userId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"userId"]];
		info.nickName = nickNameText.text;
        if ([nickNameText.text length] == 0) {
            if ([info.nickName length] == 0) {
                info.nickName = [dic objectForKey:@"nick_name"];
            }
            
        }
		info.userName = [dic objectForKey:@"user_name"];
        info.authentication = [NSString stringWithFormat:@"%d", [[dic objectForKey:@"authentication"] intValue] ];
        if ([dic objectForKey:@"accesstoken"]) {
            info.accesstoken = [dic objectForKey:@"accesstoken"];
        }
//        info.accesstoken = [dic objectForKey:@"accesstoken"];
		UserInfo *user = [[UserInfo alloc] init];
		user.userId = info.userId;
		user.nick_name = nickNameText.text;
		user.unionStatus = @"1";
        user.isbindmobile = @"0";
        user.authentication = [NSString stringWithFormat:@"%d", [[dic objectForKey:@"authentication"] intValue] ];
		user.unionId = [dic objectForKey:@"unionId"];
		user.partnerid = [dic objectForKey:@"partnerid"];
		user.user_name = [dic objectForKey:@"user_name"];
        if ([dic objectForKey:@"accesstoken"]) {
            user.accesstoken = [dic objectForKey:@"accesstoken"];
        }
        
		info.mUserInfo = user;
        NSMutableArray * infoarr = [[NSMutableArray alloc] initWithCapacity:0];
        [infoarr addObject:info.login_name];
        [infoarr addObject:info.userId];
        [infoarr addObject:info.nickName];
        [infoarr addObject:info.userName];
        [infoarr addObject:info.mUserInfo];
        [infoarr addObject:@""];//info.isbindmobile];
        [infoarr addObject:info.authentication];
        [infoarr addObject:@""];//info.password];
        [infoarr addObject:@""];//userInfo.unionStatus];
        [infoarr addObject:@""];//userInfo.partnerid];
        [infoarr addObject:@""];//userInfo.unionId];
        
            if (info.accesstoken) {
                [infoarr addObject:info.accesstoken];
            }else{
                [infoarr addObject:@""];
            }
        
       
        
        
        NSString *st = [infoarr componentsJoinedByString:@";"];
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isbindmobile"];
        [[NSUserDefaults standardUserDefaults] setValue:st forKey:@"logincp"];
        [[NSUserDefaults standardUserDefaults]  synchronize];
        NSString *newst = [[NSUserDefaults standardUserDefaults] valueForKey:@"logincp"];
        if (![newst isEqualToString:st]) {
            [Info showDialogWithTitle:@"提示"  BtnTitle:@"确定" Msg:@"用户名或密码不正确" :self];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"logincp"];
            [infoarr release];
            [user release];
            return;
        }
        
        [infoarr release];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isunDoLongTime"];
//        [[NSUserDefaults standardUserDefaults] setValue:user.isbindmobile forKey:@"isbindmobile"];
        [[NSUserDefaults standardUserDefaults] setValue:user.authentication forKey:@"authentication"];
		[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isUnion"];
        if (self.unNitionLoginType == UnNitionLoginTypeAlipay) {
            [[NSUserDefaults standardUserDefaults] setValue:@"4" forKey:@"isAlipay"];
        }else if (self.unNitionLoginType == UnNitionLoginTypeSina) {
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isUnionType"];
        }else {
            [[NSUserDefaults standardUserDefaults] setValue:@"2" forKey:@"isUnionType"];
        }
        [user release];
//		[GC_HttpService sharedInstance].sessionId = [dic objectForKey:@"session_id"];
//        [[caiboAppDelegate getAppDelegate] switchToHomeView];
//		[self.navigationController popToRootViewControllerAnimated:YES];
//		LotteryPreferenceViewController *lot = [[LotteryPreferenceViewController alloc] init];
//		lot.title = @"彩票偏好设置";
//		[self.navigationController pushViewController:lot animated:YES];
//		[lot release];
        
        #ifdef isCaiPiaoForIPad
        caiboAppDelegate * appcaibo = [caiboAppDelegate getAppDelegate];
        UIView * backview = (UIView *)[appcaibo.window viewWithTag:10212];
        [backview removeFromSuperview];
        
        UINavigationController *a = (UINavigationController *)appcaibo.window.rootViewController;
        NSArray * views = a.viewControllers;
        UIViewController * newhome = [views objectAtIndex:0];

        if ([newhome isKindOfClass:[IpadRootViewController class]]) {
            UIButton * hobutton = [UIButton buttonWithType:UIButtonTypeCustom];
            hobutton.tag = 1;
            [(IpadRootViewController *)newhome pressMenuButton:hobutton];
        }
#else
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CancelPrivateLetter" object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
#endif
        
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
      
        [appDelegate DologinSave];
        
        
	}
	else if ([[dic objectForKey:@"code"] intValue] == 1){
		CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"昵称已存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.delegate = self;
		[alert show];
		[alert release];
	}
	else if ([[dic objectForKey:@"code"] intValue] == 2){
		CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.delegate = self;
		[alert show];
		[alert release];
	}
    else {
        NSLog(@"%@",[[dic objectForKey:@"msg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[dic objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.delegate = self;
		[alert show];
		[alert release];
    }


}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mRequest clearDelegatesAndCancel];
	self.mRequest = nil;
	self.unionId = nil;
	self.nickName = nil;
	[nickNameText release];
    [super dealloc];
}

- (void)changeTongbu:(UISwitch *)sw{
	isTongbu = sw.on;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
	for (UIView *v in cell.contentView.subviews) {
		[v removeFromSuperview];
	}
	cell.textLabel.backgroundColor = [UIColor clearColor];
	switch (indexPath.row) {
		case 0:
		{
			cell.textLabel.text= nil;
			nickNameText = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, 280, 30)];
			[nickNameText setBorderStyle:UITextBorderStyleRoundedRect];
			nickNameText.font = [UIFont systemFontOfSize:20];
            nickNameText.placeholder = @"用户名请输入6-16位字符";
//            if (unNitionLoginType == UnNitionLoginTypeQQ) {
//                nickNameText.text = nil;
//                nickNameText.placeholder = nil;
//            }
			nickNameText.delegate = self;
			[nickNameText becomeFirstResponder];
			[cell.contentView addSubview:nickNameText];
		}
			break;
		case 1:
		{
            if (unNitionLoginType == UnNitionLoginTypeTeng) {
                cell.textLabel.text = @"同步到腾讯微博";
            }
            else if (unNitionLoginType == UnNitionLoginTypeQQ) {
                cell.textLabel.text = @"同步到QQ空间";
            }
            else {
                cell.textLabel.text = @"同步到新浪微博";
            }
			
			UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(200, 7, 60, 30)];
			[cell.contentView addSubview:sw];
			sw.on = isTongbu;
			[sw addTarget:self action:@selector(changeTongbu:) forControlEvents:UIControlEventValueChanged];
			[sw release];
			
		}
			break;
		default:
			break;
	}
	return cell;
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    