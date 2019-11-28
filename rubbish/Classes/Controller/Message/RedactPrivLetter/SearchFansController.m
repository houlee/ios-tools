//
//  SearchFansController.m
//  caibo
//
//  Created by jeff.pluto on 11-7-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchFansController.h"
#import "Info.h"
#import "NetURL.h"
#import "FolloweeCell.h"
#import "Followee.h"
#import "FansList.h"
#import "LoadCell.h"
#import "MoreLoadCell.h"
#import "MyProfileViewController.h"
#import "ProfileViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation SearchFansController

@synthesize mRequest, mController, keyWord, Type;

-(id)initWithNickName:(NSString *)nickName {
	if ((self = [super init])) {
        index = 1;
        [self setKeyWord: nickName];
        mUsers = [[NSMutableArray alloc] init];
        loadCell = [[LoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchUser"];
        [loadCell setType:MSG_TYPE_LOAD_COMMENT];
        [loadCell.spinner startAnimating];
        
        moreCell = [[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreLoadCell"];
        
        [self setMRequest:[ASIHTTPRequest requestWithURL:[NetURL CBsearchUserList:nickName pageNum:@"1" pageSize:@"20"]]];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest setDelegate:self];
        [mRequest startAsynchronous];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
#ifdef isCaiPiaoForIPad
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.navigationController.navigationBar.layer.masksToBounds = YES;
    self.navigationController.navigationBar.layer.cornerRadius = 7;
    //更换导航栏
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 540, 44)];
    imageV.image = UIImageGetImageFromName(@"daohangtiao.png");
    [self.navigationController.navigationBar addSubview:imageV];
    [imageV release];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:imageV.bounds];
    titleLabel.text = @"用户搜索";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:titleLabel];
    [titleLabel release];
    
#endif
    [self.navigationController setNavigationBarHidden:NO];
    
    
    
    NSString * devicestr = [[UIDevice currentDevice] systemVersion];
   
    if ([devicestr floatValue] >= 6) {
        [self.navigationController.navigationBar setBackgroundImage:UIImageGetImageFromName(@"NavBackImage.png") forBarMetrics:UIBarMetricsDefault];
    }

    
    

    [self.navigationItem setTitle:(@"用户搜索")];
    UIBarButtonItem *backButton = [Info backItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	NSString *responseStr = [request responseString];
    
    FansList *fansList = (FansList *)[[FansList alloc] initWithParse:responseStr];
    if (fansList && fansList.arrayList) {
        if ([fansList.arrayList count] == 0) {
            [loadCell setType:MSG_TYPE_NO_USER];
            [loadCell.spinner stopAnimating];
        } else {
            for (FansList *fans in fansList.arrayList) {
                Followee *user = [[Followee alloc] init];
                user.mTag = 6;
                user.userId = fans.userId;
                user.name = fans.nick_name;
                user.imageUrl = fans.mid_image;
                user.fansCount = fans.fans;
                [mUsers addObject:user];
                [user release];
            }
        }
    }
    [fansList release];
    
    [self.tableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request {   
	NSError *error = [request error];
	if(error) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" 
                                                        message:@"网络有错误" 
                                                       delegate:self 
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
    [loadCell setType:MSG_TYPE_NO_USER];
    [loadCell.spinner stopAnimating];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = (int)[mUsers count];
    return count == 0 ? 1 : count + 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([mUsers count] == 0) {
		return 50;
	}
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 无用户
    if (0 == [mUsers count]) {
        return loadCell;
    }
    
    // 更多
	if (indexPath.row == [mUsers count]) {
        return moreCell;
	} else {
    // 用户列表
        static NSString *CellIdentifier = @"FolloweeCell";
        
        FolloweeCell *cell = (FolloweeCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[FolloweeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier] autorelease];
        }
        
        cell.imageView.layer.cornerRadius = 8.0;
		[cell.imageView.layer setBorderWidth:0.3];
        [cell.imageView.layer setBorderColor:[UIColor grayColor].CGColor];
        
        Followee *user = [mUsers objectAtIndex:indexPath.row];
        [cell setFollowee:user];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 无用户
    if (0 == [mUsers count]) {
        return;
    }
    
    // 更多
    if (indexPath.row == [mUsers count]) {
        if ([self respondsToSelector:@selector(getMoreUser)]) {
            MoreLoadCell *cell = (MoreLoadCell *)[tableView cellForRowAtIndexPath:indexPath];
            [cell spinnerStartAnimating];
            [self performSelector:@selector(getMoreUser) withObject:nil afterDelay:0.5];
        }
	} else {
    // 跳转到用户资料界面或者到私信界面
        Followee *user = [mUsers objectAtIndex:indexPath.row];
        if (user.userId && user.name) {
            if ([mController respondsToSelector:@selector(friendsViewDidSelectFriend:)]) {
                NSMutableString *textBuffer = [[NSMutableString alloc] init];
                if (Type == Link_Man) {// @功能
                    [textBuffer appendString:@"@"];
                    [textBuffer appendString:user.name];
                    [textBuffer appendString:@" "];
                } else if(Type == Priv_Letter) {// 私信
                    [textBuffer appendString:user.name];
                    [textBuffer appendString:@":"];
                    [textBuffer appendString:user.userId];
                }
                [mController performSelector:@selector(friendsViewDidSelectFriend:) withObject:textBuffer];
                [textBuffer release];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
    }
}

// 点击更多
- (void) getMoreUser {
    ++index;
    [self setMRequest:[ASIHTTPRequest requestWithURL:[NetURL CBsearchUserList:keyWord pageNum:[NSString stringWithFormat:@"%d", index] pageSize:@"10"]]];
    [mRequest setDelegate:self];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDidFinishSelector:@selector(moreDataFinished:)];
    [mRequest startAsynchronous];
}

-(void)moreDataFinished:(ASIHTTPRequest*)request {
    NSString *responseStr = [request responseString];
    FansList *fansList = (FansList *)[[FansList alloc] initWithParse:responseStr];
    if (fansList && fansList.arrayList) {
        if ([fansList.arrayList count] > 0) {
            for (FansList *fans in fansList.arrayList) {
                Followee *user = [[Followee alloc] init];
                user.mTag = 6;
                user.userId = fans.userId;
                user.name = fans.nick_name;
                user.imageUrl = fans.mid_image;
                user.fansCount = fans.fans;
                [mUsers addObject:user];
                [user release];
            }
        }
    }
    [fansList release];
    [moreCell spinnerStopAnimating];
    [self.tableView reloadData];
   }

// 返回
- (void) back: (id)sender {
    [self.navigationController setNavigationBarHidden:YES];
	[self.navigationController popViewControllerAnimated:YES];
    
}

- (void)dealloc {
    [mRequest clearDelegatesAndCancel];
    [mRequest release];
    
    [keyWord release];
    
    [mUsers release];
    [loadCell release];
    [moreCell release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.mRequest=nil;
	self.keyWord=nil;
	[mController release];
	mController=nil;
	mUsers=nil;
	loadCell=nil;
	moreCell=nil;
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    