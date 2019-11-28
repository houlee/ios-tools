//
//  BettingViewController.m
//  caibo
//
//  Created by yao on 12-4-11.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "BettingViewController.h"
#import "GC_BetData.h"
#import "Xieyi365ViewController.h"
#import "MobClick.h"


//投注界面
@implementation BettingViewController
@synthesize request;
@synthesize betArray;
@synthesize dataArray;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (void)doBack{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"pk赛投注";
    
	self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
	self.mainView.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"login_bgn.png")];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.png") forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(20, 0, 40, 44);
    [btn addTarget:self action:@selector(pressMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    
    [rightItem release];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    myTableView = [[CP_CanOpenTableView alloc] initWithFrame:CGRectMake(0, 2, 320, self.mainView.bounds.size.height -46) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:myTableView];
    [myTableView release];
    [self tabBarView];//下面长方块view 确定投注的view
    
    
    oneLabel.text = [NSString stringWithFormat:@"%d", two];
    twoLabel.text = [NSString stringWithFormat:@"%d", one];
    
    UIImageView *  upimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 26)];
//    upimageview.backgroundColor = [UIColor clearColor];
//    upimageview.image = UIImageGetImageFromName(@"zucaititleimage.png");
     upimageview.backgroundColor = [UIColor colorWithRed:16/255.0 green:95/255.0 blue:180/255.0 alpha:1];
    [self.mainView addSubview:upimageview];
    [upimageview release];
    
    UILabel * saishila = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 59, 26)];
    saishila.backgroundColor = [UIColor clearColor];
    saishila.font = [UIFont systemFontOfSize:13];
    saishila.textColor = [UIColor whiteColor];
    saishila.textAlignment = NSTextAlignmentCenter;
    saishila.text = @"赛事";
    [upimageview addSubview:saishila];
    [saishila release];
    
    
    UIImageView * shuimage = [[UIImageView alloc] initWithFrame:CGRectMake(59, 6, 1, 14)];
    shuimage.backgroundColor = [UIColor whiteColor];
    [upimageview addSubview:shuimage];
    [shuimage release];
    
    UILabel * shengla = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 89, 26)];
    shengla.backgroundColor = [UIColor clearColor];
    shengla.font = [UIFont systemFontOfSize:13];
    shengla.textColor = [UIColor whiteColor];
    shengla.textAlignment = NSTextAlignmentCenter;
    shengla.text = @"3";
    [upimageview addSubview:shengla];
    [shengla release];
    
    UIImageView * shuimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(149, 6, 1, 15)];
    shuimage2.backgroundColor = [UIColor whiteColor];
    [upimageview addSubview:shuimage2];
    [shuimage2 release];
    
    UILabel * pingla = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 68, 26)];
    pingla.backgroundColor = [UIColor clearColor];
    pingla.font = [UIFont systemFontOfSize:13];
    pingla.textColor = [UIColor whiteColor];
    pingla.textAlignment = NSTextAlignmentCenter;
    pingla.text = @"1";
    [upimageview addSubview:pingla];
    [pingla release];
    
    UIImageView * shuimage3 = [[UIImageView alloc] initWithFrame:CGRectMake(218, 6, 1, 14)];
    shuimage3.backgroundColor = [UIColor whiteColor];
    [upimageview addSubview:shuimage3];
    [shuimage3 release];
    
    UILabel * fula = [[UILabel alloc] initWithFrame:CGRectMake(219, 0, 320-229, 26)];
    fula.backgroundColor = [UIColor clearColor];
    fula.font = [UIFont systemFontOfSize:13];
    fula.textColor = [UIColor whiteColor];
    fula.textAlignment = NSTextAlignmentCenter;
    fula.text = @"0";
    [upimageview addSubview:fula];
    [fula release];
    
    
    myTableView.frame = CGRectMake(0, 28, 320, self.mainView.bounds.size.height - 71);
    
    self.request = [ASIHTTPRequest requestWithURL:[NetURL pkMatchInfo:[self.betArray objectAtIndex:0]]]; 
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(dateDidFinishSelector:)];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startAsynchronous];

   

    oneLabel.text = [NSString stringWithFormat:@"%d", one];
    twoLabel.text = [NSString stringWithFormat:@"%d", two];
    //
}

- (void)dateDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSDictionary * dict = [str JSONValue];
    NSLog(@"dict = %@", dict);
    NSArray * array = [dict objectForKey:@"data"];
    for (NSDictionary * di in array) {
        GC_BetData * pkbet = [[GC_BetData alloc] initWithDic:di];
        [dataArray addObject:pkbet];
        [pkbet release];
    }
    [myTableView reloadData];
}

- (void)pressRightButton:(id)sender{
    PKGameExplainViewController * pkevc = [[PKGameExplainViewController alloc] init];
    [self.navigationController pushViewController:pkevc animated:YES];
    [pkevc release];

}
- (void)pressMenu {
    NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
    [allimage addObject:@"GC_sanjiShuoming.png"];
    [allimage addObject:@"PKInfo.png"];
    NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
    [alltitle addObject:@"玩法说明"];
    [alltitle addObject:@"活动说明"];
    caiboAppDelegate *app = (caiboAppDelegate *)[UIApplication sharedApplication].delegate;
//    if (!tln) {
        tln = [[CP_ThreeLevelNavigationView alloc] initWithFrame:CGRectMake(0, -20, 320, app.window.frame.size.height) AllImageName:allimage setAllTitle:alltitle];
//    }
    
    tln.delegate = self;
    [self.view addSubview:tln];
    [tln show];
    [tln release];

    [allimage release];
    [alltitle release];
    
}

- (void)tabBarView{
#ifdef isHaoLeCai
    tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 392, 320, 44)];
    if (IS_IPHONE_5) {
        tabView.frame = CGRectMake(0, 480, 320, 44);
    }
#else
    tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 372, 320, 44)];
    if (IS_IPHONE_5) {
        tabView.frame = CGRectMake(0, 460, 320, 44);
    }
#endif
    UIImageView * tabBack = [[UIImageView alloc] initWithFrame:tabView.bounds];
    tabBack.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    
    
    //已选
    UILabel * pitchLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 20, 10)];
    pitchLabel.text = @"";
    pitchLabel.textAlignment = NSTextAlignmentCenter;
    pitchLabel.font = [UIFont systemFontOfSize:9];
    pitchLabel.backgroundColor = [UIColor clearColor];
    
    //已投
    UILabel * castLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 20, 10)];
    castLabel.text = @"";
    castLabel.textAlignment = NSTextAlignmentCenter;
    castLabel.font = [UIFont systemFontOfSize:9];
    castLabel.backgroundColor = [UIColor clearColor];
    
    
    UIButton * qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    qingbutton.frame = CGRectMake(12, 8, 30, 30);
    [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
    [qingbutton addTarget:self action:@selector(pressQingButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //放图片 图片上放label 显示投多少场
    
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(52, 7, 62, 30)];
    zhubg.image = UIImageGetImageFromName(@"SRK960.png");
    zhubg.userInteractionEnabled = YES;
    
    oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 4, 40, 11)];
    oneLabel.backgroundColor = [UIColor clearColor];
    oneLabel.textAlignment = NSTextAlignmentCenter;
    oneLabel.font = [UIFont systemFontOfSize:9];
    oneLabel.textColor = [UIColor blackColor];
    //   oneLabel.text = @"14";
    
    [zhubg addSubview:oneLabel];
        
    twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 19, 40, 11)];
    twoLabel.backgroundColor = [UIColor clearColor];
    twoLabel.textAlignment = NSTextAlignmentCenter;
    twoLabel.font = [UIFont systemFontOfSize:9];
    twoLabel.textColor = [UIColor blackColor];
    
    [zhubg addSubview:twoLabel];
    
    //场字
    UILabel *fieldLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 4, 20, 11)];
    fieldLable.text = @"注";
    fieldLable.textAlignment = NSTextAlignmentCenter;
    fieldLable.font = [UIFont systemFontOfSize:9];
    fieldLable.backgroundColor = [UIColor clearColor];
    fieldLable.textColor = [UIColor blackColor];
    [zhubg addSubview:fieldLable];
    //注字
    UILabel * pourLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 19, 20, 11)];
    pourLable.text = @"场";
    pourLable.textAlignment = NSTextAlignmentCenter;
    pourLable.font = [UIFont systemFontOfSize:9];
    pourLable.backgroundColor = [UIColor clearColor];
    pourLable.textColor = [UIColor blackColor];
    [zhubg addSubview:pourLable];
    
    //投注按钮背景
    UIImageView * backButton = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 63, 30)];
    backButton.image = UIImageGetImageFromName(@"gc_footerBtn.png");
    UIImageView * backButton2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 29)];
    backButton2.image = UIImageGetImageFromName(@"GC_icon8.png");
    
    
    
    //投注按钮
    UIButton *castButton = [UIButton buttonWithType:UIButtonTypeCustom];
    castButton.frame = CGRectMake(230, 6, 80, 33);
    UIImageView * chuanimage1 = [[UIImageView alloc] initWithFrame:castButton.bounds];
    chuanimage1.backgroundColor = [UIColor clearColor];
    chuanimage1.image = [UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [castButton addSubview:chuanimage1];
    [chuanimage1 release];
    [castButton addTarget:self action:@selector(pressCastButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //按钮上的字
    UILabel * buttonLabel1 = [[UILabel alloc] initWithFrame:castButton.bounds];
    buttonLabel1.text = @"选好了";
    buttonLabel1.textAlignment = NSTextAlignmentCenter;
    buttonLabel1.backgroundColor = [UIColor clearColor];
    buttonLabel1.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    buttonLabel1.font = [UIFont boldSystemFontOfSize:15];
    
    [castButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [castButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    
    [castButton addSubview:buttonLabel1];

    [backButton release];
    [backButton2 release];
    [buttonLabel1 release];
    
    [tabView addSubview:tabBack];
    [tabView addSubview:pitchLabel];
    [tabView addSubview:castLabel];
    [tabView addSubview:zhubg];
    [zhubg release];
    [tabView addSubview:castButton];
    [tabView addSubview:qingbutton];
    [self.mainView addSubview:tabView];
    
    
    [pitchLabel release];
    [castLabel release];
    [fieldLable release];
    [pourLable release];
    [tabBack release];
}

- (void)pressCastButton:(UIButton *)button{
    NSLog(@"xuan hao  le");
    if (one < 14) {
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"至少需要对14场比赛进行投注" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.shouldRemoveWhenOtherAppear = YES;
        [alert show];
        [alert release];
        
    }else if (two > 512){
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"投注方案不能超过512注" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.shouldRemoveWhenOtherAppear = YES;
        [alert show];
        [alert release];
        
    }else {
 //       int st = [self.betArray count] - 1;
        NSString * string = @"";
        for (GC_BetData * data in dataArray) {
            if (data.selection1) {
                string = [string stringByAppendingFormat:@"3"];
            }
            if (data.selection2) {
                string = [string stringByAppendingFormat:@"1"];
            }
            if (data.selection3) {
                string = [string stringByAppendingFormat:@"0"];
            }
            string = [string stringByAppendingFormat:@"*"];
        }
        string = [string substringToIndex:[string length] - 1];
        NSLog(@"url = %@", [NetURL pkBuyLotterybetNumber:string userid:[[Info getInstance] userId] betCount:[NSString stringWithFormat:@"%d", two] issue:[self.betArray objectAtIndex:0]]);
        
#ifdef  isYueYuBan
        self.request = [ASIHTTPRequest requestWithURL:[NetURL pkZhiJieBuyLotterybetNumber:string userid:[[Info getInstance] userId] betCount:[NSString stringWithFormat:@"%d", two] issue:[self.betArray objectAtIndex:0]]];
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(pkDidFinishSelector:)];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
        
#else
#ifdef  isCaiPiao365ForIphone5
        [[UIApplication sharedApplication] openURL:[NetURL pkBuyLotterybetNumber:string userid:[[Info getInstance] userId] betCount:[NSString stringWithFormat:@"%d", two] issue:[self.betArray objectAtIndex:0]]];
#else
        self.request = [ASIHTTPRequest requestWithURL:[NetURL pkZhiJieBuyLotterybetNumber:string userid:[[Info getInstance] userId] betCount:[NSString stringWithFormat:@"%d", two] issue:[self.betArray objectAtIndex:0]]];
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(pkDidFinishSelector:)];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
#endif
#endif
    }
    
    
    

}

- (void)pkDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSDictionary * dict = [str JSONValue];
    NSLog(@"dict = %@", dict);
   
    NSString * strstr = [dict objectForKey:@"msg"];
 
    NSString * string = [NSString stringWithFormat:@"%d",[[dict objectForKey:@"code"] intValue]];
    
    if ([string isEqualToString:@"0"]) {
        
        CP_UIAlertView *alert1 = [[CP_UIAlertView alloc] initWithTitle:nil message:strstr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        alert1.shouldRemoveWhenOtherAppear = YES;
        [alert1 show];
        alert1.tag = 101;
        [alert1 release];
    }
    else {
        
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:strstr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        alert.shouldRemoveWhenOtherAppear = YES;
        [alert show];
        [alert release];
    }
    
}

-(void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101) {
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"my" object:self];
    }
}

- (void)pressHelpButton:(UIButton *)button{
    Xieyi365ViewController *xie = [[Xieyi365ViewController alloc] init];
    xie.ALLWANFA = PKSai;
    [self.navigationController pushViewController:xie animated:YES];
    [xie release];
}

#pragma mark -
#pragma mark CP_ThreeLevelNavDelegate

- (void)returnSelectIndex:(NSInteger)index{
    NSLog(@"returnSelectIndex");
    if (index == 0) {
        [self pressHelpButton:nil];
    }
    else if (index == 1) {
        PKGameExplainViewController *pk  = [[PKGameExplainViewController alloc] init];
        [self.navigationController pushViewController:pk animated:YES];
        [pk release];
    }
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}


#pragma mark -
#pragma mark Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if ([dataArray count] > 14) {
        return 14;
    }
    return [dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (zhankai[indexPath.row] == 1) {
        return 55+56;
    }
	return 55.0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    PK_TableCell *cell = (PK_TableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[PK_TableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil]];
        

            cell.wangqibool = NO;
        
        cell.cp_canopencelldelegate = self;
        cell.xzhi = 9.5;
        
        cell.otherImageView.image = UIImageGetImageFromName(@"xialabg.png");
        cell.normalHight = 50;
        cell.selectHight = 50+56;
        cell.xialabianImge.image = UIImageGetImageFromName(@"xialabian24.png");
    }
    
    UIButton * cellbutton = (UIButton *)[cell.butonScrollView viewWithTag:1];

        cellbutton.hidden = NO;
        cell.wangqibool = NO;
    if (zhankai[indexPath.row] == 1) {
        [cell showButonScollWithAnime:NO];
    }
    if (zhankai[indexPath.row] == 0) {
        [cell hidenButonScollWithAnime:NO];
    }
    // Configure the cell...
    cell.row = indexPath.row;
    cell.count = indexPath.row;
    cell.delegate = self;
    GC_BetData * pkbet = [dataArray objectAtIndex:indexPath.row];
    pkbet.donghuarow = indexPath.row;
    cell.pkbetdata = pkbet;
    cell.renjiubool = NO;

    [cell hidenXieBtn];
    return cell;
}

//- (void)returnCellInfo:(NSInteger)index buttonBoll1:(BOOL)selection1 buttonBoll:(BOOL)selection2 buttonBoll:(BOOL)selection3{
//    //    NSLog(@"666666666666666");
//    //    NSLog(@"index6666 = %d", index);
//    NSLog(@"1111111111111111index = %d   button1 = %d  button2 = %d  button3 = %d", index, selection1, selection2, selection3);
//    PKBetData  * da = [dataArray objectAtIndex:index];
//    da.count = index;
//    da.selection1 = selection1;
//    da.selection2 = selection2;
//    da.selection3 = selection3;
//    [dataArray replaceObjectAtIndex:index withObject:da];
//    NSLog(@"1111111111111111index = %d   button1 = %d  button2 = %d  button3 = %d", da.count, da.selection1, da.selection2, da.selection3);
//    two = 1;
//    one = 0;
//    for (PKBetData * pkb in dataArray) {
//        if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
//            one++;
//           
//        }
//
//        two = two *(pkb.selection1+pkb.selection2+pkb.selection3); 
//    }
//    NSLog(@"two = %d", two);
//    oneLabel.text = [NSString stringWithFormat:@"%d", one];
//    twoLabel.text = [NSString stringWithFormat:@"%d", two];
//    
//
//    
//}

- (void)returnCellInfo:(NSInteger)index buttonBoll1:(BOOL)selection1 buttonBoll:(BOOL)selection2 buttonBoll:(BOOL)selection3 dan:(BOOL)booldan{
    //    NSLog(@"666666666666666");
    //    NSLog(@"index6666 = %d", index);
    GC_BetData  * da = [dataArray objectAtIndex:index];
    da.count = index;
    da.selection1 = selection1;
    da.selection2 = selection2;
    da.selection3 = selection3;
    da.dandan = booldan;
    //    if (selection1 == NO || selection2 == NO || selection3 == NO) {
    //         da.dandan = NO;
    //    }
    if (selection1 == NO && selection2 == NO && selection3 == NO) {
        da.dandan = NO;
    }
    
    [dataArray replaceObjectAtIndex:index withObject:da];
    
    two = 1;
    one = 0;
    
    [self upDateFunc];
    
    
    
    
    [myTableView reloadData];
    
    
}

- (void)pressQingButton:(UIButton *)sender {
    for (GC_BetData * pkb in dataArray) {
        pkb.selection1 = NO;
        pkb.selection2 = NO;
        pkb.selection3 = NO;
    }
    [myTableView reloadData];
    [self upDateFunc];
}

- (void)upDateFunc{
    two = 1;
    one = 0;
        for (GC_BetData * pkb in dataArray) {
            if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
                one++;
                
            }
            
            two = two *(pkb.selection1+pkb.selection2+pkb.selection3);
        }
    
    
    
        oneLabel.text = [NSString stringWithFormat:@"%d", two];
        twoLabel.text = [NSString stringWithFormat:@"%d", one];
    
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    [super viewDidUnload];
}


- (void)dealloc {
    myTableView.delegate = nil;
    [tabView release];
    [dataArray release];
    [betArray release];
    [request clearDelegatesAndCancel];
    self.request = nil;
    [oneLabel release];
    [twoLabel release];
    [super dealloc];
}


@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    