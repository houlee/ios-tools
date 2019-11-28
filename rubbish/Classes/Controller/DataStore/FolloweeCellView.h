//
//  FolloweeCellView.h
//  caibo
//
//  Created by jeff.pluto on 11-6-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FolloweeCellView.h"
#import <UIKit/UIKit.h>
#import "Followee.h"

#define ListYtTheme 1
#define AttenList 2
#define SearchListYtTheme 3 // 插入话题搜索无结果
#define SearchAttenList 4 // @联系人无结果
#define SearchMailList 5 // 写私信联系人无结果
#define SearchUser 6
#define FansAttenPrivater 7 // 粉丝列表;关注列表;
#define SiXin 8 //私信列表

@interface FolloweeCellView : UIView {
    Followee *followee;
}

@property(nonatomic, retain) Followee *followee;

@end