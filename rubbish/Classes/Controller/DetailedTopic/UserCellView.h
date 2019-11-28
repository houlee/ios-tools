//
//  用户信息界面：包含用户头像和用户昵称
//  caibo
//
//  Created by jeff.pluto on 11-6-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageStoreReceiver.h"
#import "YtTopic.h"
#import "ASIHTTPRequest.h"
#import "CP_UIAlertView.h"

@interface UserCellView : UIView <UITextFieldDelegate,ASIHTTPRequestDelegate, CP_UIAlertViewDelegate> {
    NSString *imageUrl;
    ImageStoreReceiver *receiver;
    
    UIImage *mUserFace;
    YtTopic *mUserInfo;
    BOOL ishome;
    ASIHTTPRequest *myRequest;
    NSString * passWord;
    
//    NSString * userID;

}

@property (nonatomic, retain) YtTopic *mUserInfo;
@property (nonatomic,retain) UIImage *mUserFace;
@property (nonatomic, assign)BOOL ishome;
@property (nonatomic,retain)ASIHTTPRequest *myRequest;
@property (nonatomic, retain)NSString * passWord;
- (id) initWithUserInfo:(YtTopic *)userInfo homebool:(BOOL)homeb;

@end