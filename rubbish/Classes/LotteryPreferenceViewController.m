//
//  LotteryPreferenceViewController.m
//  caibo
//
//  Created by  on 12-2-15.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "LotteryPreferenceViewController.h"
#import "YrbList.h"
#import "YrbSectionHeaderView.h"
#import "ColorUtils.h"
#import "LotteryPreferenceCell.h"
#import "Info.h"
#import "NetURL.h"
#import "SBJSON.h"
#import "RegisterViewController.h"

@implementation LotteryPreferenceViewController
@synthesize lists,lpTableView,typeDictionary,request,keepIndex;
- (void)dealloc
{
    if (self.request) {
        [self.request clearDelegatesAndCancel];
        [request release];
    }
    [keepIndex release];
    [typeDictionary release];
    [lpTableView release];
    [lists release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)loadLikeDidFail:(ASIHTTPRequest*)aRequest {
//	NSString *responseString = [aRequest responseString];
	
}

- (void)loadLikeDidFinish:(ASIHTTPRequest*)aRequest {
	NSString *responseString = [aRequest responseString];
    
    SBJSON *json = [[SBJSON alloc]init];
    NSDictionary *dictionary = [json objectWithString:responseString error:nil];
	if ([[dictionary objectForKey:@"code"] intValue]) {
		UIAlertView *alet = [[UIAlertView alloc] initWithTitle:nil message:@"获取偏好设置异常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alet show];
		[alet release];
	}
	NSMutableArray *arraylist = [dictionary objectForKey:@"list"];
	if ([arraylist count]>0) {
		for (int z= 0; z < [arraylist count]; z ++) {
			NSArray *array = [self.typeDictionary objectForKey:@"LotteryType"];
			for (int i = 0; i < [array count]; i ++) {
				NSDictionary *dictionary = [array objectAtIndex:i];
				NSArray *detailArray = [dictionary objectForKey:@"columnArray"];
				for (int j = 0; j < [detailArray count]; j ++) {
					NSDictionary *detailDictionary = [detailArray objectAtIndex:j];
					if ([[[detailDictionary objectForKey:@"columnId"] stringValue] isEqualToString:[arraylist objectAtIndex:z]]) {
						[detailDictionary setValue:@"1" forKey:@"isMarked"];
					}
				}
			}
		}
	}
	NSMutableArray *array = [self.typeDictionary objectForKey:@"LotteryType"];
	NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
	for (int i = 0; i < [array count]; i ++) {
		YrbList *list = [[YrbList alloc]initWithDictionary:[array objectAtIndex:i]];
		[mutableArray insertObject:list atIndex:i];
		[list release];
	}
	[json release];
	self.lists = mutableArray;
    [mutableArray release];
	[self.lpTableView reloadData];
}

- (void)loadPreferenceData
{
	NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSMutableString *path = [pathArray objectAtIndex:0];
	NSString *detailPath = [path stringByAppendingPathComponent:@"yrbList.plist"];
	NSString *buddlePath = [[NSBundle mainBundle]pathForResource:@"yrbList" ofType:@"plist"];
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:buddlePath];
	self.typeDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary];
	[self.typeDictionary writeToFile:detailPath atomically:YES];
	NSMutableArray *array = [dictionary objectForKey:@"LotteryType"];
	NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
	for (int i = 0; i < [array count]; i ++) {
		YrbList *list = [[YrbList alloc]initWithDictionary:[array objectAtIndex:i]];
		[mutableArray insertObject:list atIndex:i];
		[list release];
	}
	self.lists = mutableArray;
    [mutableArray release];
	if ([self.title isEqualToString:@"偏好设置"]) {
		if (self.request) {
			[self.request clearDelegatesAndCancel];
		}
		ASIHTTPRequest *tmpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetLikeLotteryByUserId:[[Info getInstance]userId]]];
		[tmpRequest setDelegate:self];
		[tmpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		[tmpRequest setDidFailSelector:@selector(loadLikeDidFail:)];
		[tmpRequest setDidFinishSelector:@selector(loadLikeDidFinish:)];
		self.request = tmpRequest;
		[tmpRequest startAsynchronous];
		return;
	}

}

- (void)reloadPreferenceData
{
    self.lists = nil;
    NSMutableArray *array = [self.typeDictionary objectForKey:@"LotteryType"];
    NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < [array count]; i ++) {
        YrbList *list = [[YrbList alloc]initWithDictionary:[array objectAtIndex:i]];
        list.indexPaths = [self.keepIndex objectAtIndex:i];
        [mutableArray insertObject:list atIndex:i];
        [list release];
    }
    self.lists = mutableArray;
    [mutableArray release];

}
#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView
//{
//
//}
//


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
    self.lists = tmpArray;
    [tmpArray release];
    [self loadPreferenceData];
    NSNull *myNull = [NSNull null];
    NSMutableArray *arrayKeep = [[NSMutableArray alloc]initWithObjects:myNull,myNull,myNull,myNull, nil];
    self.keepIndex = arrayKeep;
    [arrayKeep release];

    UITableView *tmpTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 420) style:UITableViewStylePlain];
    [tmpTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tmpTableView setShowsVerticalScrollIndicator:NO];
    [tmpTableView setDelegate:self];
    [tmpTableView setDataSource:self];
    [tmpTableView setBackgroundColor:[UIColor cellBackgroundColor]];
    self.lpTableView = tmpTableView;
    [self.view addSubview:tmpTableView];
    [tmpTableView release];
	UIBarButtonItem *rightButton = [Info longItemInitWithTitle:@"跳过" Target:self action:@selector(finishButton:)];
	self.navigationItem.rightBarButtonItem = rightButton;
	if([self.title isEqualToString:@"彩票偏好设置"]) {
		self.navigationItem.hidesBackButton = YES;
	}
	else {
		UIBarButtonItem *left = [Info backItemTarget:self action:@selector(goback:)];
		self.navigationItem.leftBarButtonItem = left;
	}
}

- (void)goback:(id)sender {
	[self.navigationController popViewControllerAnimated: YES];
}

- (void)touch {
	[self.navigationController setNavigationBarHidden:NO animated:NO];
	RegisterViewController *registerVC = [[RegisterViewController alloc] init];
	[self.navigationController pushViewController:registerVC animated:YES];
	registerVC.title = @"步骤2：账号注册";
	[registerVC release];
	UIView *v = [self.view viewWithTag:11123];
	[v removeFromSuperview];
}

- (void)finishButton:(id)sender
{
//	LotteryPreferenceImageViewController *VC = [[LotteryPreferenceImageViewController alloc] init];
//	[self.navigationController pushViewController:VC animated:YES];
//	[VC release];
	if ([self.title isEqualToString:@"偏好设置"]||[self.title isEqualToString:@"彩票偏好设置"]) {
		NSMutableArray *mutableArray = [NSMutableArray array];
		NSArray *array = [self.typeDictionary objectForKey:@"LotteryType"];
		for (int i = 0; i < [array count]; i ++) {
			NSDictionary *dictionary = [array objectAtIndex:i];
			NSArray *detailArray = [dictionary objectForKey:@"columnArray"];
			for (int j = 0; j < [detailArray count]; j ++) {
				NSDictionary *detailDictionary = [detailArray objectAtIndex:j];
				if ([[detailDictionary objectForKey:@"isMarked"] boolValue]) {
					[mutableArray addObject:[detailDictionary objectForKey:@"columnId"]];
				}
			}
		}
		NSString *string = [mutableArray componentsJoinedByString:@","];
		NSLog(@"string = %@",string);
		if (self.request) {
			[self.request clearDelegatesAndCancel];
		}
		ASIHTTPRequest *tmpRequest = [ASIHTTPRequest requestWithURL:[NetURL CBsetLikeLotteryByUserId:[[Info getInstance]userId] lotteryTypes:string]];
		[tmpRequest setDelegate:self];
		[tmpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
		[tmpRequest setDidFailSelector:@selector(preferenceDidFail:)];
		[tmpRequest setDidFinishSelector:@selector(preferenceDidFinsh:)];
		self.request = tmpRequest;
		[tmpRequest startAsynchronous];
		return;
	}

	UIView *V = [[UIView alloc] initWithFrame:CGRectMake(320, 0, 320, 480)];
	[self.view addSubview:V];
	V.tag = 11123;
	V.backgroundColor = [UIColor colorWithPatternImage:UIImageGetImageFromName(@"xihaoSetting.jpg")];
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touch)];
	[V addGestureRecognizer:tapGesture];
	[tapGesture release];
	[self.navigationController setNavigationBarHidden:YES animated:NO];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	V.frame = self.view.bounds;
	[UIView commitAnimations];
	[V release];
//	RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
//	[self.navigationController pushViewController:registerVC animated:YES];
//	[registerVC release];
    
    

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

#pragma mark UITableView delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YrbList *yrbList = [lists objectAtIndex:section];
    if ([yrbList opened]) {
        return ([yrbList.columnArray count]/2 + 1);
    }else
        {
        return 0;
        }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.lists count];
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = nil;
    YrbList *list = [lists objectAtIndex:indexPath.section];
    YrbColumn *column =[list.columnArray objectAtIndex:indexPath.row];

    if (indexPath.row == 0) {
        CellIdentifier = @"CellOne";
        LotteryPreferenceCell *cell = (LotteryPreferenceCell *)[self.lpTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[LotteryPreferenceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier customStyle:CustomStyleOne]autorelease];
        }
        [cell setCustomStyle:CustomStyleOne];
        
        [cell.preferenceOneView setDelegate:self];
        [cell.preferenceOneView setSection:[indexPath section]];
        [cell.preferenceOneView.nameLabel setText:column.columnName];
        [cell.preferenceOneView.markButton setSelected:column.isMarked];
        [cell.preferenceOneView setMarked:column.isMarked];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else
        {
        CellIdentifier = @"CellTwo";
        LotteryPreferenceCell *cell = (LotteryPreferenceCell *)[self.lpTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        YrbColumn *columnOne = [list.columnArray objectAtIndex:2 * [indexPath row] - 1];
        YrbColumn *columnTwo = [list.columnArray objectAtIndex:2 * [indexPath row]];
        if (cell == nil) {
            cell = [[[LotteryPreferenceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier customStyle:CustomStyleTwo]autorelease];
        }
        [cell setCustomStyle:CustomStyleTwo];
        
        [cell.preferenceOneView setDelegate:self];
        [cell.preferenceOneView setSection:[indexPath section]];
        [cell.preferenceOneView.nameLabel setText:columnOne.columnName];
        [cell.preferenceOneView.markButton setSelected:columnOne.isMarked];
        [cell.preferenceOneView setMarked:columnOne.isMarked];

        
        [cell.preferenceTwoView setDelegate:self];
        [cell.preferenceTwoView setSection:[indexPath section]];
        [cell.preferenceTwoView.nameLabel setText:columnTwo.columnName];
        [cell.preferenceTwoView.markButton setSelected:columnTwo.isMarked];
        [cell.preferenceTwoView setMarked:columnTwo.isMarked];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YrbList *list = [lists objectAtIndex:section];
    int markedCount = 0;
    for (YrbColumn * column in list.columnArray) {
        if (column.isMarked) {
            markedCount ++;
        }
    }
    NSString *headString = [NSString stringWithFormat:@"%@ [%d/%d] ",list.listName,markedCount,(int)[list.columnArray count]];
    
    YrbSectionHeaderView *sectionHeaderView = [[[YrbSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 30) 
                                                                                   title:headString 
                                                                                delegate:self 
                                                                                 section:section 
                                                                                     open:list.opened]autorelease];
	
    return sectionHeaderView;
}
#pragma mark YrbSectionHeaderView delegate

-(void)sectionHeaderView:(YrbSectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section
{    
    NSString *openString;
    YrbList *list = [lists objectAtIndex:section];
    list.opened = !list.opened;
    if (list.opened) {
        openString = @"1";
    }else
        {
        openString = @"0";
        }
    
    NSMutableDictionary *dic =[[self.typeDictionary objectForKey:@"LotteryType"]objectAtIndex:section];
    [dic setObject:openString forKey:@"opened"];
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableString *path = [pathArray objectAtIndex:0];
    NSString *detailPath = [path stringByAppendingPathComponent:@"yrbList.plist"];
    [self.typeDictionary writeToFile:detailPath atomically:YES];

    
    NSInteger countOfRowsToDelete = [self.lpTableView numberOfRowsInSection:section];
    if (countOfRowsToDelete > 0) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i ++) {
            [array addObject:[NSIndexPath indexPathForRow:i inSection:section]];
        }
        list.indexPaths = array;
        [self.keepIndex replaceObjectAtIndex:section withObject:list.indexPaths];
        [array release];
        if (list.indexPaths) {
            [self.lpTableView deleteRowsAtIndexPaths:list.indexPaths withRowAnimation:UITableViewRowAnimationTop];

        }
    }
    // [self reloadPreferenceData];
}

-(void)sectionHeaderView:(YrbSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section

{
    NSString *openString;
    YrbList *list = [lists objectAtIndex:section];
    list.opened = !list.opened;
    if (list.opened) {
        openString = @"1";
    }else
        {
        openString = @"0";
        }
    
    NSMutableDictionary *dic =[[self.typeDictionary objectForKey:@"LotteryType"]objectAtIndex:section];
    [dic setObject:openString forKey:@"opened"];
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableString *path = [pathArray objectAtIndex:0];
    NSString *detailPath = [path stringByAppendingPathComponent:@"yrbList.plist"];
    [self.typeDictionary writeToFile:detailPath atomically:YES];
    if (list.indexPaths) {
        [self.lpTableView insertRowsAtIndexPaths:list.indexPaths withRowAnimation:UITableViewRowAnimationBottom];
		[self.lpTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    //[self reloadPreferenceData];
}

#pragma mark LotteryPreferenceView delegate
-(void)lotteryPreferenceView:(LotteryPreferenceView*)preferenceView marked:(BOOL)isMarked title:(NSString *)aTitle section:(NSInteger)aSection
{
    NSString *string;
	UIBarButtonItem *rightButton = [Info longItemInitWithTitle:@"完成" Target:self action:@selector(finishButton:)];
	self.navigationItem.rightBarButtonItem = rightButton;
    if (isMarked) {
        string = @"1";
    }else
        {
        string = @"0";
        }
    NSString *openString;
    YrbList *list = [lists objectAtIndex:aSection];
    if (list.opened) {
        openString = @"1";
    }else
        {
         openString = @"0";
        }

    NSMutableDictionary *dic =[[self.typeDictionary objectForKey:@"LotteryType"]objectAtIndex:aSection];
    [dic setObject:openString forKey:@"opened"];
    NSMutableArray *array = [dic objectForKey:@"columnArray"];
    for (NSMutableDictionary *searchDictionary in array) {
        if ([[searchDictionary objectForKey:@"columnName"] isEqualToString:aTitle]) {
            [searchDictionary setObject:string forKey:@"isMarked"];
        }
    }
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableString *path = [pathArray objectAtIndex:0];
    NSString *detailPath = [path stringByAppendingPathComponent:@"yrbList.plist"];
    [self.typeDictionary writeToFile:detailPath atomically:YES];
    [self reloadPreferenceData];
    [self.lpTableView reloadData];
	[self.lpTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:aSection] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

#pragma mark requestFinish
- (void)preferenceDidFail:(ASIHTTPRequest*)aRequest
{
    NSLog(@"w = %@",[aRequest responseString]);

}

- (void)preferenceDidFinsh:(ASIHTTPRequest *)aRequest
{
	 if([self.title isEqualToString:@"彩票偏好设置"]) {
		 caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
		 appDelegate.lastAccount = YES;
		 
		 [appDelegate switchToHomeView];
		 return;
	}
    NSString *responseString = [aRequest responseString];
    
    SBJSON *json = [[SBJSON alloc]init];
    NSDictionary *dictionary = [json objectWithString:responseString error:nil];
    if ([[dictionary objectForKey:@"result"] isEqualToString:@"succ"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		alert.tag = 100;
		[alert release];
    }else
        {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
			[alert show];
			alert.tag = 101;
			[alert release];
        }
	[json release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 100) {
		[self.navigationController popViewControllerAnimated:YES];
		
	}
	else if(alertView.tag == 101) {
		
	}

}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    