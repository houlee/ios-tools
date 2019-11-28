//
//  联系人&插入话题
//  caibo
//
//  Created by jeff.pluto on 11-6-2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPostViewController.h"
#import "ASIHTTPRequest.h"
#import "CPViewController.h"
typedef enum {
	kAddTopicController,
	kLinkManController,
    kLinkManEachOther
}ContentType;

@interface FolloweesViewController : CPViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, ASIHTTPRequestDelegate> {


    
    IBOutlet UITableView *mFriendsView;
    IBOutlet UISearchBar *mSearchBar;
    UISearchDisplayController *searchDC;
    
    UIViewController *mController;
    ContentType contentType;
    
    NSArray *requestData;// 服务器返回数据集合
    NSMutableArray *sectionArray;// tabView集合:每个字母中有几行(行:NSArray集合)
    NSMutableArray *filteredArray;// 搜索结果过滤数组集合
	NSMutableArray *nikeNameArray;// 服务器返回昵称集合
    NSMutableArray *followeeArray;// 联系人集合
	NSString *sectionName;
    
    ASIHTTPRequest *request;
    BOOL shixin;
    BOOL yaoqin;
    id delegate;
}

@property (nonatomic,retain) ASIHTTPRequest *request;

@property (nonatomic,retain) NSArray *requestData;
@property (nonatomic,retain) NSMutableArray *sectionArray;
@property (nonatomic,retain) NSMutableArray *filteredArray;
@property (nonatomic,retain) NSMutableArray *nikeNameArray;
@property (nonatomic,retain) NSMutableArray *followeeArray;

@property (nonatomic, assign) ContentType contentType;
@property (nonatomic, assign) UIViewController *mController;
@property (nonatomic, assign) BOOL shixin,yaoqin;
@property (nonatomic, assign)id delegate;

- (void) initData;
+ (BOOL) searchResult:(NSString *)nikeName searchText:(NSString *)searchText;

@end

@protocol FolloweesDelegate

- (void)returnDoBack;


@end

