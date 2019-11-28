//
//  FolloweeCell.h
//  caibo
//
//  Created by jeff.pluto on 11-6-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileImageCell.h"
#import "Followee.h"
#import "CP_PTButton.h"

typedef enum {

    shixintype,
    yaoqintype
}LianXiType;
@class FolloweeCellView;

@interface FolloweeCell : ProfileImageCell 
{
    FolloweeCellView*   cellView;
    
    UIImageView *bgImage;
	
	CP_PTButton *attButton;
	BOOL isAtt;
	UIImage *image;
	NSString *userId;
	//UIImageView *pImageView;
    UIImageView *xian;
    
    BOOL shixin;
    BOOL yaoqing;
    
    LianXiType lianxi;
  
}

@property(nonatomic,retain) UIButton *attButton;
@property(nonatomic,retain) NSString *userId;
@property (nonatomic, assign)BOOL shixin,yaoqing;
@property (nonatomic, assign)LianXiType lianxi;

//@property (nonatomic, retain) UIImageView *pImageView;

- (void) setFollowee : (Followee *) followee;
- (void)addAtt;
- (void)cancelAtt;
- (void)setBaHiden;
- (void)setXianHiden;


@end