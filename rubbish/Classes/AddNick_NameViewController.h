//
//  AddNick_NameViewController.h
//  caibo
//
//  Created by yao on 12-3-12.
//  Copyright 2012 第一视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CP_UIAlertView.h"
#import "CPViewController.h"

typedef enum
{
    UnNitionLoginTypeSina,
	UnNitionLoginTypeTeng,
    UnNitionLoginTypeQQ,
    UnNitionLoginTypeAlipay,
    UnNitionLoginTypeWX,
}UnNitionLoginType;

@interface AddNick_NameViewController : CPViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,CP_UIAlertViewDelegate> {
	ASIHTTPRequest *mRequest;
	NSString *unionId;
	UITextField *nickNameText;
	NSString *nickName;
	NSDictionary *dataDic;
	BOOL isTongbu;
    UIButton *btn;
    UnNitionLoginType unNitionLoginType;
}
@property(nonatomic, retain) ASIHTTPRequest *mRequest;
@property(nonatomic,copy)NSString *unionId;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,retain)NSDictionary *dataDic;
@property (nonatomic)UnNitionLoginType unNitionLoginType;

@end
