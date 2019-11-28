//
//  CommentViewController.m
//  caibo
//
//  Created by jeff.pluto on 11-6-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CommentViewController.h"
#import "NewPostViewController.h"
#import "ProfileViewController.h"
#import "caiboAppDelegate.h"
#import "ASIHTTPRequest.h"
#import "TopicComment.h"
#import "CommentCell.h"
#import "ProgressBar.h"
#import "DataUtils.h"
#import "JSON.h"
#import "NetURL.h"
#import "Info.h"
#import "DetailedView.h"
#import "SendMicroblogViewController.h"
#import "SendMicroblogViewController.h"

@implementation CommentViewController

@synthesize mCommentArray, mRequest, mStatus,autoHeight;

- (id) initWithMessage:(YtTopic *)message {
    self = [super init];
    [self setMStatus:message];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	UIBarButtonItem *backButton = [Info backItemTarget:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = backButton;    
    UIImage *image = UIImageGetImageFromName(@"btn_bind_bg.png");
	UIButton *tempBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
	[tempBtn1 setFrame: CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
	[tempBtn1 setBackgroundImage:image forState:UIControlStateNormal];
	[tempBtn1 setTitle:@"发布评论" forState:UIControlStateNormal];
	[tempBtn1.titleLabel setFont:[UIFont systemFontOfSize:14]];
	[tempBtn1 setTitleEdgeInsets: UIEdgeInsetsMake(0, 10, 0, 5)];
    [tempBtn1 addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithCustomView:tempBtn1];
	[editButton setStyle: UIBarButtonItemStylePlain];
	self.navigationItem.rightBarButtonItem = editButton;
	[editButton release];
    
	if (mRefreshView == nil) {
		mRefreshView = [[CBRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -480, 320, 480)];
		[mRefreshView setDelegate:self];
		[self.view addSubview:mRefreshView];
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;    
    loadCell = [[LoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoComment"];
    [loadCell setType:MSG_TYPE_NO_COMMENT];
    
    moreCell = [[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreLoadCell"];
    
    index = 1;
}
- (void)reloadDataView
{
    [self.tableView reloadData];
}

// 视图即将可见时调用
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self CBRefreshTableHeaderDidTriggerRefresh:mRefreshView];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	NSString *responseString = [request responseString];
	
    // 删除评论
    if ([request.username isEqualToString:@"deleteComment"]) {
        NSDictionary *resultDict = [responseString JSONValue];
        if ([[resultDict objectForKey:RESULT] isEqualToString:RESULT_SUCC]) {
            [mCommentArray removeObjectAtIndex:mSection];
            [self.tableView reloadData];
             self.autoHeight = self.tableView.frame.size.height;
            [[ProgressBar getProgressBar] setTitle:@"删除成功!"];
        } else {
            [[ProgressBar getProgressBar] setTitle:@"删除失败!"];
        }
        [NSTimer scheduledTimerWithTimeInterval:0.7
                                         target:self
                                       selector:@selector(dismissDialog:)
                                       userInfo:nil
                                        repeats:NO];
        return;
    }
    
	if (responseString) {
        TopicComment *list = [[TopicComment alloc] init];   
        [self setMCommentArray: [list arrayWithParse:responseString]];
        [list release];	}
	
    index = 1;
	[self.tableView reloadData];
     self.autoHeight = self.tableView.frame.size.height;
	self.navigationItem.rightBarButtonItem.enabled = YES;
    [self performSelector:@selector(doneLoadedTableViewData) withObject:nil afterDelay:0.2];
}

- (void) requestFailed:(ASIHTTPRequest *)request {
    self.navigationItem.rightBarButtonItem.enabled = YES;
	mReloading = NO;
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
    [loadCell setType:MSG_TYPE_NO_COMMENT];
    [loadCell.spinner stopAnimating];
}

- (void) dismissDialog : (id) sender {
    [[ProgressBar getProgressBar] dismiss];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = (int)[mCommentArray count];
    return count == 0 ? 1 : count + 1;
}

- (CGSize) getTextSize : (NSString *) text {
    UIFont *font = [UIFont systemFontOfSize:16];
    CGSize size = CGSizeMake(200, 480);
    CGSize labelsize = [text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return labelsize;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellHeigth;
	if ([mCommentArray count] == 0 || indexPath.row == [mCommentArray count]) {
		cellHeigth = 50;
	} else {
		TopicComment *comment = [mCommentArray objectAtIndex:indexPath.row];
		cellHeigth = [self getTextSize:comment.content].height + 50;
	}
    self.autoHeight = self.tableView.frame.size.height;
	return cellHeigth;  
}

- (BOOL) isMe : (NSString *) nickName {
    if ([nickName isEqualToString:[[Info getInstance] nickName]]) {
        return YES;
    }
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 暂无评论
    if (0 == [mCommentArray count]) {
        return loadCell;
    }
    
    // 更多
	if (indexPath.row == [mCommentArray count]) {
        return moreCell;
	} else {
        static NSString *CellIdentifier = @"CommentCell";
        
        CommentCell *cell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        TopicComment *mComment = [mCommentArray objectAtIndex:indexPath.row];
        [cell setComment:mComment];
        
        if (indexPath.row % 2) {
            [cell.contentView setBackgroundColor:[UIColor colorWithRed:232 / 255.0 green: 241 / 255.0 blue: 250 / 255.0 alpha:1.0]];
        } else {
            [cell.contentView setBackgroundColor:[UIColor clearColor]];
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    // 暂无评论
    if (0 == [mCommentArray count]) {
        [loadCell setType:MSG_TYPE_LOAD_COMMENT];
        [loadCell.spinner startAnimating];
        
        [mRequest clearDelegatesAndCancel];
        [self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBgetYtTopicCommentList:[[Info getInstance] userId] topicId:mStatus.topicid pageNum:@"1" pageSize:@"20"]]];
        [mRequest setDelegate:self];
        [mRequest setTimeOutSeconds:20.0];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest startAsynchronous];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        return;
    }
    
    // 更多
    if (indexPath.row == [mCommentArray count]) {
        if ([self respondsToSelector:@selector(getMoreComment)]) {
            MoreLoadCell *cell = (MoreLoadCell *)[tableView cellForRowAtIndexPath:indexPath];
            [cell spinnerStartAnimating];
            [self performSelector:@selector(getMoreComment) withObject:nil afterDelay:0.5];
        }
	} else {
        mSection = (int)indexPath.row;
        
        UIActionSheet *actionSheet = nil;
        NSString *userId = [[mCommentArray objectAtIndex:mSection] userId];
        if ([userId isEqualToString:[[Info getInstance] userId]]) {
            actionSheet = [[UIActionSheet alloc]
                           initWithTitle:@"请选择需要的操作"
                           delegate:self
                           cancelButtonTitle:@"取消"
                           destructiveButtonTitle:@"删除该评论"
                           otherButtonTitles:@"他的资料", @"回复此评论", @"复制此评论",nil];
        } else {
            actionSheet = [[UIActionSheet alloc]
                           initWithTitle:@"请选择需要的操作"
                           delegate:self
                           cancelButtonTitle:@"取消"
                           destructiveButtonTitle:nil
                           otherButtonTitles:@"他的资料", @"回复此评论", @"复制此评论",nil];
        }
        [actionSheet showInView:self.view.superview];
        [actionSheet release];
    }
}

// 点击更多
- (void) getMoreComment {
    ++index;
    [mRequest clearDelegatesAndCancel];
    [self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBgetYtTopicCommentList:[[Info getInstance] userId] topicId:mStatus.topicid pageNum:[NSString stringWithFormat:@"%d", index] pageSize:@"20"]]];
    [mRequest setDelegate:self];
    [mRequest setTimeOutSeconds:20.0];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDidFinishSelector:@selector(moreDataFinished:)];
    [mRequest startAsynchronous];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void) moreDataFinished:(ASIHTTPRequest*)request {
    NSString *responseString = [request responseString];
    mReloading = NO;
    TopicComment *list = [[TopicComment alloc] init];
    if (mCommentArray) {
        
        if ([[list arrayWithParse:responseString] count]>0) {
            [mCommentArray addObjectsFromArray:[list arrayWithParse:responseString]];
        }else{
            [moreCell setType:MSG_TYPE_LOAD_NODATA];
			
        }
    }
    [list release];
    
    [moreCell spinnerStopAnimating];
    [self.tableView reloadData];
    self.autoHeight = self.tableView.frame.size.height;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    if (moreCell.type == MSG_TYPE_LOAD_NODATA) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"加载完毕"];
        [moreCell spinnerStopAnimating];
        [moreCell setInfoText:@"加载完毕"];
    }
}

// 弹出框取消事件
- (void)prograssBarBtnDeleate:(NSInteger) type {
    [mRequest clearDelegatesAndCancel];
    [[ProgressBar getProgressBar] dismiss];
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"删除该评论"]) {// 删除该评论
        [mRequest clearDelegatesAndCancel];
        [self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBdeleteCommentById:[[Info getInstance] userId] commentId:[[mCommentArray objectAtIndex:mSection] ycid]]]];
        [mRequest setUsername:@"deleteComment"];
        [mRequest setDelegate:self];
        [mRequest setTimeOutSeconds:20.0];
        [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [mRequest startAsynchronous];
        [[ProgressBar getProgressBar] show:@"正在删除评论..." view:self.view];
        [ProgressBar getProgressBar].mDelegate = self;
        
    } else if ([title isEqualToString:@"他的资料"]) {// 他的资料
        [[Info getInstance] setHimId:[[mCommentArray objectAtIndex:mSection] userId]];
        ProfileViewController *followeesController = [[ProfileViewController alloc] init];
        [self.navigationController pushViewController:followeesController animated:YES];
        [followeesController release];
    } else if ([title isEqualToString:@"回复此评论"]) {// 回复此评论
#ifdef isCaiPiaoForIPad
        YtTopic *mRevert = [[YtTopic alloc] init];
        mRevert.topicid = [[mCommentArray objectAtIndex:mSection] ycid];

        
        [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kCommentRevert mStatus:mRevert];
        
        [mRevert release];
#else
        
        SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
        publishController.microblogType = CommentRevert;// 自发彩博
        YtTopic *mRevert = [[YtTopic alloc] init];
        mRevert.topicid = [[mCommentArray objectAtIndex:mSection] ycid];
        publishController.mStatus = mRevert;
        [mRevert release];

        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
        [self presentViewController:nav animated: YES completion:nil];
        [publishController release];
        [nav release];
        
//        NewPostViewController *publishController = [[NewPostViewController alloc] init];
//        YtTopic *mRevert = [[YtTopic alloc] init];
//        mRevert.topicid = [[mCommentArray objectAtIndex:mSection] ycid];
//        publishController.mStatus = mRevert;
//        publishController.publishType = kCommentRevert;// 回复评论
//        [self.navigationController pushViewController:publishController animated:YES];
//        [mRevert release];
//        [publishController release];
#endif
    } else if ([title isEqualToString:@"复制此评论"]) {// 复制此评论
        UIPasteboard *generalPasteBoard = [UIPasteboard generalPasteboard];
        [generalPasteBoard setString:[[mCommentArray objectAtIndex:mSection] content]];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
													   message:@"评论内容已复制!"
													  delegate:self
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

// 返回
- (void) back: (id)sender {
    
    [mRequest clearDelegatesAndCancel];
    
	[self.navigationController popViewControllerAnimated: YES];
}

// 评论
- (void) comment : (id) sender {
#ifdef isCaiPiaoForIPad
   
    
    
    [[caiboAppDelegate getAppDelegate] WriteWeiBoForiPad:kCommentTopicController mStatus:mStatus];
    

#else
//    NewPostViewController *publishController = [[NewPostViewController alloc] init];
//    publishController.mStatus = mStatus;
//    publishController.publishType = kCommentTopicController;// 评论
//    [self.navigationController pushViewController:publishController animated:YES];
//	[publishController release];
    
    
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.mStatus = mStatus;
    publishController.microblogType = kCommentTopicController;// 评
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
#endif
}

- (void)dealloc {
    [mRefreshView release];
    
    [mRequest clearDelegatesAndCancel];
	[mRequest release];
    
    [mStatus release];
    [mCommentArray release];
    
    [moreCell release];
    [loadCell release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

/****** 顶部刷新条相关 *******/
- (void)CBRefreshTableHeaderDidTriggerRefresh:(CBRefreshTableHeaderView *)view {
	// 设置顶部菜单栏左右两个按钮在更新时为不可用状态
	self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [mRefreshView setState:CBPullRefreshLoading];
    self.tableView.contentInset = UIEdgeInsetsMake(80, 0.0f, 0.0f, 0.0f);
	
    // 发送获取微博评论接口
    [mRequest clearDelegatesAndCancel];
    [self setMRequest: [ASIHTTPRequest requestWithURL:[NetURL CBgetYtTopicCommentList:[[Info getInstance] userId] topicId:mStatus.topicid pageNum:@"1" pageSize:@"20"]]];
    [mRequest setDelegate:self];
    [mRequest setTimeOutSeconds:20.0];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest startAsynchronous];
    
    // 正在更新数据
    mReloading = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[mRefreshView CBRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[mRefreshView CBRefreshScrollViewDidEndDragging:scrollView];
}

-(void)doneLoadedTableViewData {
	mReloading = NO;
	[mRefreshView CBRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [loadCell setType:MSG_TYPE_NO_COMMENT];
    [loadCell.spinner stopAnimating];
}

- (BOOL)CBRefreshTableHeaderDataSourceIsLoading:(CBRefreshTableHeaderView*)view {
	return mReloading;
}

- (NSDate*)CBRefreshTableHeaderDataSourceLastUpdated:(CBRefreshTableHeaderView*)view {
	return [NSDate date];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    