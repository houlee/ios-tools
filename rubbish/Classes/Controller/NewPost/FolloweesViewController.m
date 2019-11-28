//
//  FolloweesViewController.m
//  caibo
//
//  Created by jeff.pluto on 11-6-2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FolloweesViewController.h"
#import "AttenList.h"
#import "FolloweeCell.h"
#import "pinyin.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "Followee.h"
#import "YtTheme.h"
#import "DataBase.h"
#import "Info.h"
#import "UserInfo.h"
#import "HotYtThemeViewController.h"
#import "FansViewController.h"
#import "SearchFansController.h"

@implementation FolloweesViewController

@synthesize contentType;
@synthesize mController;
@synthesize requestData;
@synthesize filteredArray;
@synthesize nikeNameArray;
@synthesize sectionArray;
@synthesize followeeArray;
@synthesize request;
@synthesize shixin,yaoqin, delegate;

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [mFriendsView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
//    UIBarButtonItem *leftItem = [Info itemInitWithTitle:@"返 回" Target:self action:@selector(actionBack:)];
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(actionBack:)];
//    self.view.backgroundColor = [UIColor redColor];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
        self.mainView.frame = CGRectMake(0, 43, 320, self.view.frame.size.height-43);
    }else{
    
        self.mainView.frame = CGRectMake(0, 43, 320, self.view.frame.size.height-43);
    }
    
#ifdef isCaiPiaoForIPad
    
    if(shixin){

        self.view.backgroundColor = [UIColor clearColor];
        [self.navigationController setNavigationBarHidden:YES];
        
        [self.CP_navigation setLeftBarButtonItem:leftItem];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 390, self.view.frame.size.height);
        
        mSearchBar.frame = CGRectMake(0, 0, 390, 44);
        mFriendsView.frame = CGRectMake(0, 44, 390,1024);
        mFriendsView.backgroundColor = [UIColor clearColor];
        [self.mainView insertSubview:mFriendsView atIndex:10000];
        [self.mainView insertSubview:mSearchBar atIndex:10009];

    }else{
        [self.navigationController setNavigationBarHidden:YES];
        self.view.layer.masksToBounds = YES;
        self.view.layer.cornerRadius = 7;
        self.CP_navigation.image = UIImageGetImageFromName(@"daohangtiao.png");
        self.CP_navigation.frame = CGRectMake(0, 0, 540, 44);
        
        self.view.backgroundColor = [UIColor clearColor];
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 540, 620);
        self.mainView.frame = CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y, 540, 620);
        [self.CP_navigation setLeftBarButtonItem:leftItem];
        mFriendsView.frame = CGRectMake(0, 44, 540,620 - 44 - 44-20);
        [self.mainView insertSubview:mFriendsView atIndex:10000];
        [self.mainView insertSubview:mSearchBar atIndex:10009];
    }
   
    
    
#else
    [self.CP_navigation setLeftBarButtonItem:leftItem];
#endif
    
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 540, 620)];
//    backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    backImage.userInteractionEnabled = YES;
//    backImage.backgroundColor = [UIColor clearColor];
	mFriendsView.backgroundView = backImage;
    [backImage release];


    // 搜索栏
	mSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	mSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	mSearchBar.delegate = self;
	
	// 搜索栏控制器
	searchDC = [[UISearchDisplayController alloc] initWithSearchBar:mSearchBar contentsController:self];
	searchDC.searchResultsDataSource = self;
	searchDC.searchResultsDelegate = self;
//    [mFriendsView setTableHeaderView:mSearchBar];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
#ifdef isHaoLeCai
        mSearchBar.frame = CGRectMake(0, 0, 320, 44);
#else
        mSearchBar.frame = CGRectMake(0, 20, 320, 44);
#endif
//        mFriendsView.frame = CGRectMake(0, 44, 320, self.mainView.frame.size.height - 44);
        mFriendsView.frame = CGRectMake(0, 44+20, 320, self.mainView.frame.size.height - 44-20);
    }
    
    
    NSMutableArray *filterearray = [[NSMutableArray alloc] init];
	self.filteredArray = filterearray;
	[filterearray release];
	
	NSMutableArray *nameArray = [[NSMutableArray alloc] init];
	self.nikeNameArray = nameArray;
	[nameArray release];
    
    NSMutableArray *contactArray = [[NSMutableArray alloc] init];
	self.followeeArray = contactArray;
	[contactArray release];
    
    if (contentType == kAddTopicController) {// 插入话题
#ifdef isCaiPiaoForIPad
        [self.CP_navigation setTitle:@"插入话题"];
#else
        [self.CP_navigation setTitle:@"插入话题"];
#endif
        
        mFriendsView.backgroundColor = [UIColor clearColor];
        // ２.３０获取话题
        [request clearDelegatesAndCancel];
        [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBlistYtTheme:@"1" pageSize:@"30"]]];
        [request setUsername:@"theme"];
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setDelegate:self];
        [request setTimeOutSeconds:20.0];
        [request startAsynchronous];
    } else if(contentType == kLinkManController) {// 常用联系人
#ifdef isCaiPiaoForIPad
         [self.CP_navigation setTitle:@"常用联系人"];
#else
         [self.CP_navigation setTitle:@"常用联系人"];
#endif
       
        // ２.１９我的关注列表请求
        mFriendsView.backgroundColor = [UIColor clearColor];
        [request clearDelegatesAndCancel];
        [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetMyAttenList:[[Info getInstance] userId] pageNum:@"1" pageSize:@"300" myUserId:[[Info getInstance] userId]]]];
        [request setUsername:@"atten"];
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request setDelegate:self];
        [request setTimeOutSeconds:20.0];
        [request startAsynchronous];
    } else if(contentType == kLinkManEachOther) {// 获取相互关注私信列表人
#ifdef isCaiPiaoForIPad
         [self.CP_navigation setTitle:@"联系人"];
#else
         [self.CP_navigation setTitle:@"联系人"];
#endif
       
        [self setRequest:[ASIHTTPRequest requestWithURL:[NetURL CBgetMaillist1:[[Info getInstance] userId] pageNum:@"1" pageSize:@"300"]]];
        [request setDelegate:self];
        [request setUsername:@"getMailLinkMan"];
        [request setTimeOutSeconds:20.0];
        [request setDefaultResponseEncoding:NSUTF8StringEncoding];
        [request startAsynchronous];
    }
    
    for (UIView *view in [mSearchBar subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            [((UITextField *) view) setEnabled:NO];
        }
    }
}

// 接收服务器返回JSON数据
- (void)requestFinished:(ASIHTTPRequest *)req {
    NSString *responseString = [req responseString];
    if ([[req username] isEqualToString:@"theme"]) {
        YtTheme *list = [[YtTheme alloc] init];
        [self setRequestData:[list arrayWithParse:responseString]];
        [list release];
    } else {
        AttenList *list = [[AttenList alloc] init];
        [self setRequestData:[list arrayWithParse:responseString]];
        [list release];
    }
 
    
    if([requestData count] < 1) {
		[nikeNameArray removeAllObjects];
        [followeeArray removeAllObjects];
		for (int i = 0; i < 27; i++) {
            [self.sectionArray replaceObjectAtIndex:i withObject:[NSMutableArray array]];
        }
		return;
	}
    
	[nikeNameArray removeAllObjects];
    [followeeArray removeAllObjects];
    
    if (contentType == kAddTopicController) {// 插入话题
        for(YtTheme *contact in requestData) {
            if([contact.name length] > 0) {
                [nikeNameArray addObject:contact.name];
                
                Followee *followee = [[Followee alloc] init];
                followee.mTag = 1;
                followee.name = contact.name;
                [followeeArray addObject:followee];
                [followee release];
            }
        }
    } else {
        for(UserInfo *contact in requestData) {
            if([contact.nick_name length] > 0) {
                [nikeNameArray addObject:contact.nick_name];
                
                Followee *followee = [[Followee alloc] init];
                followee.mTag = 2;
                followee.userId = contact.userId;
                followee.name = contact.nick_name;
				followee.vip = contact.vip;
                followee.imageUrl = contact.mid_image;
                followee.is_relation = contact.is_relation;
                [followeeArray addObject:followee];
                [followee release];
            }
        }
    }
    
    [self initData];
    [mFriendsView reloadData];
    
    for (UIView *view in [mSearchBar subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            [((UITextField *) view) setEnabled:YES];
        }
    }
}

// 视图即将可见时调用
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
	[mFriendsView reloadData];
}

// 载入数据
- (void) initData {
	self.sectionArray = [NSMutableArray array];
	for (int i = 0; i < 27; i++) {
        // 加入一个NSMutableArray数组
        [self.sectionArray addObject:[NSMutableArray array]];
    }
	for (Followee *followee in followeeArray) {
        if([FolloweesViewController searchResult:followee.name searchText:mSearchBar.text]) {
            if ([mSearchBar.text length] == 0) {
                sectionName = @"";
            }else{
                sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([mSearchBar.text characterAtIndex:0])] uppercaseString];
            }
			
        } else {
            sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([followee.name characterAtIndex:0])] uppercaseString];
        }
        
		NSUInteger firstLetter = 0;
        if ([sectionName length] == 0) {
            firstLetter = [ALPHA rangeOfString:[sectionName substringToIndex:0]].location;
        }else{
            firstLetter = [ALPHA rangeOfString:[sectionName substringToIndex:1]].location;
        }
		if (firstLetter != NSNotFound) {
            [[self.sectionArray objectAtIndex:firstLetter] addObject:followee];
        } else {
            // 昵称不以英文字母开头,加入到属于“#”集合中
            [[self.sectionArray objectAtIndex:26] addObject:followee];
        }
	}
}

// 返回TabView标题总数"字母总数",默认为1
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return tableView == mFriendsView ? 27 : 1;
}

// 返回TabView标题内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == mFriendsView) {
		if ([[self.sectionArray objectAtIndex:section] count] == 0) {// 每个字母行数集合为０直接返回
            return nil;
        } else {
//            return [NSString stringWithFormat:@"%@", [[ALPHA substringFromIndex:section] substringToIndex:1]];
            return nil;
        }
	} else {
        return nil;
    }
}

// 返回每个标题字母的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Normal table
	if (tableView == mFriendsView) {
        return [[self.sectionArray objectAtIndex:section] count];
    }

    // Search table
    [filteredArray removeAllObjects];// 移除上一次的搜索结果
	for(Followee *followee in followeeArray) {
        NSString *nikeName = followee.name;
		NSString *firstLetter = @"";
		for (int i = 0; i < [nikeName length]; i++) {
			if([firstLetter length] < 1) {
				firstLetter = [NSString stringWithFormat:@"%c",pinyinFirstLetter([nikeName characterAtIndex:i])];
            } else {
				firstLetter = [NSString stringWithFormat:@"%@%c",firstLetter,pinyinFirstLetter([nikeName characterAtIndex:i])];
            }
		}
        // 根据单词首字母查询
		if ([FolloweesViewController searchResult:firstLetter searchText:mSearchBar.text]) {
			[filteredArray addObject:followee];
        } else {
            // 根据整个单词查找
			if ([FolloweesViewController searchResult:nikeName searchText:mSearchBar.text]) {
				[filteredArray addObject:followee];
            } else {
                // 不是通过昵称也不是通过单词首字母查询
            }
		}
	}

    // 没有符合的搜索结果
    if (filteredArray.count == 0) {
        Followee *nullFollowee = [[Followee alloc] init];
        Followee *temp = [[Followee alloc] init];// @:在网络上搜索; #:热门话题
        nullFollowee.imageUrl = nil;
        nullFollowee.name = [mSearchBar text];
        if (contentType == kAddTopicController) {// 插入话题
            nullFollowee.mTag = 3;
            temp.mTag = 3;
            temp.name = @"热门话题";
        } else if (contentType == kLinkManController) {// @联系人
            nullFollowee.mTag = 4;
            temp.mTag = 4;
            temp.name =@"在网络上搜索";
        } else if (contentType == kLinkManEachOther) {// 写私信查找联系人
//            nullFollowee.mTag = 5;
//            nullFollowee.name = @"无结果";
            temp.mTag = 5;
            temp.name = @"在粉丝中搜索";
        }
        if (contentType != kLinkManEachOther) {
            [filteredArray addObject:nullFollowee];
        }
//         [filteredArray addObject:nullFollowee];
        [filteredArray addObject:temp];
        [temp release];
        [nullFollowee release];
    } else {
        if (contentType == kLinkManEachOther) {
            Followee *temp = [[Followee alloc] init];
            temp.mTag = 5;
            temp.name = @"在粉丝中搜索";
            [filteredArray addObject:temp];
            [temp release];
        }
    }
	return filteredArray.count;
}

// 每个cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FolloweeCell";
    
	FolloweeCell *cell = (FolloweeCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
        cell = [[[FolloweeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier] autorelease];
#ifdef isCaiPiaoForIPad
        if (shixin) {
          cell.lianxi = shixintype;  
        }
        if (yaoqin) {
            cell.lianxi = yaoqintype;
        }
        
#endif
    }
#ifdef isCaiPiaoForIPad
    
    if (shixin) {
        cell.lianxi = shixintype;
    }
    if (yaoqin) {
        cell.lianxi = yaoqintype;
    }
#endif
    
    Followee *followee;
	if (tableView == mFriendsView) {
		followee = [[sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    } else {
		followee = [self.filteredArray objectAtIndex:indexPath.row];
        if (contentType == kLinkManEachOther && ![followee.name isEqualToString:@"在粉丝中搜索"]) {
            
        } else {
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;// 右箭头样式
        }
    }
    
    [cell setFollowee:followee];
	return cell;
}

// 每个Cell的高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (contentType == kAddTopicController) {
        return 63;
    }
    if (contentType == kLinkManController) {
//        return 75;
        return 80;
    }
    return 75;
}

////　侧边栏字母条集合
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    // regular table
//    if (tableView == mFriendsView) {
//		NSMutableArray *indices = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
//		for (int i = 0; i < 27; i++) {
//            // 字母集合中的行数不等于０再添加
//			if ([[self.sectionArray objectAtIndex:i] count] != 0) {
//				[indices addObject:[[ALPHA substringFromIndex:i] substringToIndex:1]];
//            }
//        }
//		return indices;
//	} else {
//        return nil; // search table
//    }
//}

//// 选中侧边字母条
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    if (title == UITableViewIndexSearch) {
//		[mFriendsView scrollRectToVisible:mSearchBar.frame animated:NO];
//		return -1;
//	}
//	return [ALPHA rangeOfString:title].location;
//}

// 选中cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    Followee *followee;
	if (tableView == mFriendsView) {
		followee = [[self.sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    } else {
		followee = [self.filteredArray objectAtIndex:indexPath.row];
    }
    if (followee.mTag == 1 || followee.mTag == 2 ) {// || indexPath.row == 0; row == 0选中自行输入的内容     //|| (indexPath.row == 0 && ![followee.name isEqualToString:@"无结果"])
        NSMutableString *textBuffer = [[NSMutableString alloc] init];
        if (contentType == kLinkManController) {
            [textBuffer appendString:@"@"];
            [textBuffer appendString:followee.name];
            [textBuffer appendString:@" "];
        } else if(contentType == kAddTopicController) {
            [textBuffer appendString:@"#"];
            [textBuffer appendString:followee.name];
            [textBuffer appendString:@"#"];
        } else if(contentType == kLinkManEachOther) {
            [textBuffer appendString:followee.name];
            [textBuffer appendString:@":"];
            [textBuffer appendString:followee.userId];
        }
        if ([mController respondsToSelector:@selector(friendsViewDidSelectFriend:)]) {
            [mController performSelector:@selector(friendsViewDidSelectFriend:) withObject:textBuffer];
        }
        [textBuffer release];
        if (shixin) {
            [self dismissViewControllerAnimated: YES completion: nil];
        }else{
            [self.navigationController popViewControllerAnimated:NO];
        }
        

//        [[self parentViewController] dismissViewControllerAnimated: YES completion: nil];
        

        
    } else {
        // 在网络上搜索或者跳转到热门话题
        if (followee.mTag == 3) {// 跳转到热门话题
            HotYtThemeViewController *hotView = [[HotYtThemeViewController alloc] init];
            [self.navigationController pushViewController:hotView animated:YES];
            [hotView release];
        } else if (followee.mTag == 4) {// 在网络上搜索
            SearchFansController *seachPerson = [[SearchFansController alloc] initWithNickName:mSearchBar.text];
            seachPerson.Type = Link_Man;
            seachPerson.mController = mController;
			[self.navigationController pushViewController:seachPerson animated:YES];
			[seachPerson release];
        } else if (followee.mTag == 5) {// 写私信:在粉丝中搜索
            if ([followee.name isEqualToString:@"无结果"]) {
                return;
            }
            SearchFansController *userView = [[SearchFansController alloc] initWithNickName:mSearchBar.text];
            userView.Type = Priv_Letter;
            userView.mController = mController;
            [self.navigationController pushViewController:userView animated:YES];
            [userView release];
        }
    }
}

//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    FansViewController * seachPerson = [[FansViewController alloc] initWithKeywords:mSearchBar.text];
//    [self.navigationController pushViewController:seachPerson animated:YES];
//    [seachPerson release];
//}

/* UISearchBar delegates */
//- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    self.mSearchBar.prompt = @"输入字母或汉字搜索";
//}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [mSearchBar setText:@""];
	mSearchBar.prompt = nil;
    mSearchBar.frame = CGRectMake(0, 20, 320, 44);
//	[mSearchBar setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
}

- (void)searchBar:(UISearchBar *)aSearchBar textDidChange:(NSString *)searchText {
    
}

// 根据昵称和搜索单词查询是否存在相似联系人
+ (BOOL) searchResult:(NSString *)nikeName searchText:(NSString *)searchText {
    NSComparisonResult result = [nikeName compare:searchText options:NSCaseInsensitiveSearch
											   range:NSMakeRange(0, searchText.length)];
	if (result == NSOrderedSame) {
		return YES;
    } else {
		return NO;
    }
}

// 返回
- (void) actionBack:(id)sender {
#ifdef isCaiPiaoForIPad
    [self.navigationController popViewControllerAnimated:YES];
#else
    
    if (delegate && [delegate respondsToSelector:@selector(returnDoBack)]) {
        [delegate returnDoBack];
    }
    if (shixin) {
        [self dismissViewControllerAnimated: YES completion: nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
   
//    [self dismissViewControllerAnimated: YES completion: nil];
#endif
  }

- (void)dealloc {
    [request clearDelegatesAndCancel];
	[request release];
    
    [requestData release];
    [sectionArray release];
    [filteredArray release];
    [nikeNameArray release];
    [followeeArray release];
    
    [searchDC release];
    [mSearchBar release];
    [mFriendsView release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    