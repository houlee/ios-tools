//
//  SearchFansController.h
//  caibo
//
//  Created by jeff.pluto on 11-7-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "UserInfo.h"
#import "LoadCell.h"
#import "MoreLoadCell.h"

typedef enum {
	Link_Man,
    Priv_Letter
}returnType;

@interface SearchFansController : UITableViewController {
    ASIHTTPRequest *mRequest;
    UIViewController *mController;
    NSMutableArray *mUsers;
    
    NSString *keyWord;
    LoadCell *loadCell;
    MoreLoadCell *moreCell;
    
    int index;
    
    returnType Type;
}

@property (nonatomic,retain) ASIHTTPRequest *mRequest;
@property (nonatomic,retain) NSString *keyWord;
@property (nonatomic,assign) UIViewController *mController;
@property (nonatomic,assign) returnType Type;

-(id)initWithNickName:(NSString *)nickName;

@end