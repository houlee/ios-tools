//
//  FolloweeCell.m
//  caibo
//
//  Created by jeff.pluto on 11-6-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FolloweeCell.h"
#import "FolloweeCellView.h"
#import <QuartzCore/QuartzCore.h>
#import "MyProfileViewController.h"
#import "ProfileViewController.h"
#import "caiboAppDelegate.h"
#import "NSStringExtra.h"
#import "Info.h"
#import "SBJSON.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "CheckNetwork.h"

@implementation FolloweeCell

@synthesize attButton, userId;
@synthesize shixin,yaoqing;
@synthesize lianxi;
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
#ifdef isCaiPiaoForIPad
        
        cellView = [[[FolloweeCellView alloc] initWithFrame:CGRectMake(30, 10, 520, 60)] autorelease];
        cellView.backgroundColor = [UIColor clearColor];
        cellView.userInteractionEnabled = YES;
        
        bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 515, 60)];
        bgImage.image = UIImageGetImageFromName(@"LBT960.png");
        bgImage.image = [bgImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        bgImage.backgroundColor = [UIColor clearColor];
        bgImage.userInteractionEnabled = YES;
        [self.contentView insertSubview:bgImage atIndex:0];
        [bgImage release];
        
        attButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(370, 13, 80, 30)];
        [attButton loadButonImage:@"TYD960.png" LabelName:@"关注"];
        attButton.buttonImage.image = [attButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [attButton setContentMode:UIViewContentModeCenter];//扩大响应区域
        [attButton addTarget:self action:@selector(noticeChanged:) forControlEvents:UIControlEventTouchUpInside];
        //attButton.frame = CGRectMake(230, 14, 60, 30);
        attButton.backgroundColor = [UIColor clearColor];
        [cellView addSubview:attButton];
        [self.contentView addSubview:cellView];
        //[self.contentView addSubview:attButton];
        
        xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png");
        [self addSubview:xian];
        [xian release];


#else
        
        cellView = [[[FolloweeCellView alloc] initWithFrame:CGRectMake(20, 10, 300, 60)] autorelease];
        cellView.backgroundColor = [UIColor clearColor];//goucai_cellbg.png
        
//        bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 60)];
        bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(-5, 5, 340, 75)];
//        bgImage.image = UIImageGetImageFromName(@"LBT960.png");
//        bgImage.image = UIImageGetImageFromName(@"goucai_cellbg.png");
        bgImage.image = [bgImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        bgImage.backgroundColor = [UIColor whiteColor];
        bgImage.userInteractionEnabled = YES;
        [self.contentView insertSubview:bgImage atIndex:0];
        [bgImage release];
        
//        cellView.backgroundColor=[UIColor cyanColor];
//        attButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(155, 13, 80, 30)];
//        attButton = [[CP_PTButton alloc] initWithFrame:CGRectMake(228-60, 32.5-15, 77, 30)];
//        [attButton loadButonImage:@"TYD960.png" LabelName:@"关注"];
        [attButton loadButonImage:@"wb_addgz.png" LabelName:nil];
        attButton.buttonImage.image = [attButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [attButton setContentMode:UIViewContentModeCenter];//扩大响应区域
        [attButton addTarget:self action:@selector(noticeChanged:) forControlEvents:UIControlEventTouchUpInside];
        //attButton.frame = CGRectMake(230, 14, 60, 30);
        attButton.backgroundColor = [UIColor clearColor];
        [cellView addSubview:attButton];
        [self.contentView addSubview:cellView];
        //[self.contentView addSubview:attButton];
        
        xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        xian.backgroundColor  = [UIColor clearColor];
        xian.image = UIImageGetImageFromName(@"SZTG960.png");
        [self addSubview:xian];
        [xian release];

#endif
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)didTouchHeadImageButton:(id)sender
{
    UIViewController *controller;
    if ([cellView.followee.userId isUserself]) {
        controller = [[MyProfileViewController alloc] initWithType:1];
    } else {
        [[Info getInstance] setHimId:cellView.followee.userId];
        controller = [[ProfileViewController alloc] init];
        [controller setHidesBottomBarWhenPushed:YES];
    }
    caiboAppDelegate *delegate = [caiboAppDelegate getAppDelegate];
    [delegate.window.rootViewController.navigationController pushViewController:controller animated:YES];
    
    [controller release];
}

- (void) setFollowee:(Followee *) followee {
    [cellView setFollowee: followee];
    [cellView setNeedsDisplay];// 通知重画
    if (followee.imageUrl && [followee.imageUrl length] > 0) {
        [self fetchProfileImage:followee.imageUrl];// 获取图片
    } else {
        [imageButton setImage:nil forState:(UIControlStateNormal)];
        [imageButton.layer setBorderColor:[UIColor clearColor].CGColor];
    }
	
	//添加V字图
	if ([followee.vip intValue] == 1)
	{
		self.pImageView.frame = CGRectMake(44, 43, 14, 14);
	}
	else {
		self.pImageView.frame = CGRectMake(0, 0, 0, 0);
	}
	
	self.userId = followee.userId;
    if (![followee.userId isEqualToString:[[Info getInstance] userId]]) {
        
        
    
     NSLog(@"id = %@ , my id = %@", self.userId, [[Info getInstance] userId]);
    
	//关注按钮
	if (followee.is_relation) {
		if ([followee.is_relation intValue] == 0 || [followee.is_relation intValue] == 2){
			//image = UIImageGetImageFromName(@"wb21.png");
            //[attButton setImage:image forState:UIControlStateNormal];
//            [attButton loadButonImage:@"TYD960.png" LabelName:@"关注"];
            [attButton loadButonImage:@"wb_addgz.png" LabelName:nil];
            attButton.buttonImage.image = [attButton.buttonImage.image stretchableImageWithLeftCapWidth:11 topCapHeight:5];
			isAtt = NO;
		} 
		else if([followee.is_relation intValue] == 1 || [followee.is_relation intValue] == 3)
		{
			//image = UIImageGetImageFromName(@"wb20.png");
//            [attButton loadButonImage:@"TYD960.png" LabelName:@"取消关注"];
            [attButton loadButonImage:@"wb_cancelgz.png" LabelName:nil];
            attButton.buttonImage.image = [attButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
			isAtt = YES;
            //[attButton setImage:image forState:UIControlStateNormal];
		}
	}

    }
    
     NSLog(@"id = %@ , my id = %@", self.userId, [[Info getInstance] userId]);
	
}


- (void)noticeChanged: (id)sender
{
	if (!isAtt){
		[self addAtt];
		isAtt = YES;
		//[attButton setImage:UIImageGetImageFromName(@"wb21.png") forState:UIControlStateNormal];
        
        
//        [attButton loadButonImage:@"TYD960.png" LabelName:@"取消关注"];
        [attButton loadButonImage:@"wb_cancelgz.png" LabelName:nil];
        attButton.buttonName.font = [UIFont boldSystemFontOfSize:13];
        attButton.buttonImage.image = [attButton.buttonImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
	}
	else if(isAtt){
		[self cancelAtt];
		isAtt = NO;
		//[attButton setImage:UIImageGetImageFromName(@"wb20.png") forState:UIControlStateNormal];
//        [attButton loadButonImage:@"TYD960.png" LabelName:@"关注"];
        [attButton loadButonImage:@"wb_addgz.png" LabelName:nil];
        attButton.buttonName.font = [UIFont boldSystemFontOfSize:13];
        attButton.buttonImage.image = [attButton.buttonImage.image stretchableImageWithLeftCapWidth:11 topCapHeight:5];
	}
	
	//[attButton addTarget: self action: @selector(noticeChanged:) forControlEvents: UIControlEventTouchUpInside];
	
}


- (void)addAtt
{
	ASIHTTPRequest *addAttHttp = [ASIHTTPRequest requestWithURL:[NetURL CBsaveAttention:[[Info getInstance] userId] attUserId:userId]]; // 添加关注
	[addAttHttp setDefaultResponseEncoding:NSUTF8StringEncoding];
    [addAttHttp setDelegate:self];
    [addAttHttp setDidFinishSelector:@selector(reqaddAtt:)];
	[addAttHttp setNumberOfTimesToRetryOnTimeout:2];
    [addAttHttp startAsynchronous];
}


- (void)reqaddAtt:(ASIHTTPRequest *)httpRequest
{
    NSString *responseStr = [httpRequest responseString];
	
    if (![responseStr isEqualToString:@"fail"]) 
    {
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSDictionary *dic = [jsonParse objectWithString:responseStr];
        if (dic) 
        {
            NSString *result = [dic valueForKey:@"result"];
            if ([result isEqualToString:@"succ"]) 
            {
                NSLog(@"add att succ!\n");
            }
        }
        [jsonParse release];
    }
}

- (void)setBaHiden {
    bgImage.hidden = YES;
}

- (void)setXianHiden{

    xian.hidden = YES;
}
- (void)cancelAtt
{
	ASIHTTPRequest *cancelAttHttp = [ASIHTTPRequest requestWithURL:[NetURL CBcancelAttention:[[Info getInstance] userId] attUserId:userId]];
	[cancelAttHttp setDefaultResponseEncoding:NSUTF8StringEncoding];
    [cancelAttHttp setDelegate:self];
    [cancelAttHttp setDidFinishSelector:@selector(reqcancelAtt:)];
	[cancelAttHttp setNumberOfTimesToRetryOnTimeout:2];
    [cancelAttHttp startAsynchronous];
}


- (void)reqcancelAtt:(ASIHTTPRequest *)httpRequest
{
    NSString *responseStr = [httpRequest responseString];
	
    if (![responseStr isEqualToString:@"fail"]) 
    {
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSDictionary *dic = [jsonParse objectWithString:responseStr];
        if (dic) 
        {
            NSString *result = [dic valueForKey:@"result"];
            if ([result isEqualToString:@"succ"]) 
            {
                NSLog(@"cancel att succ!\n");
            }
        }
        [jsonParse release];
    }
}



- (void)dealloc 
{
	[userId release];
	//[pImageView release];
    [super dealloc];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    imageButton.frame = CGRectMake(LEFT + 15, TOP * 4, IMAGE_WIDTH, IMAGE_HEIGTH);
    imageButton.frame = CGRectMake(LEFT + 10, TOP - 15+3, IMAGE_WIDTH+5, IMAGE_HEIGTH+5);
    if (cellView.followee.mTag == ListYtTheme || cellView.followee.mTag == SearchListYtTheme || cellView.followee.mTag == SearchAttenList || cellView.followee.mTag == SearchMailList) {
        cellView.frame = CGRectMake(LEFT, TOP, CELL_WIDTH+30, 70);
    }
    if (cellView.followee.mTag == FansAttenPrivater) {
        cellView.frame = CGRectMake(IMAGE_WIDTH + LEFT +18, TOP +8, CELL_WIDTH+30, 70);
#ifdef isCaiPiaoForIPad
        cellView.frame = CGRectMake(IMAGE_WIDTH + LEFT +18, TOP +8, CELL_WIDTH_PAD+50, 70);
        xian.frame = CGRectMake(10, cellView.frame.size.height, 370, 2);
        attButton.frame = CGRectMake(155, 13, 80, 30);
#endif
        if([userId isEqualToString:[[Info getInstance] userId]]) {
            attButton.hidden = YES;
        }
        else {
            attButton.hidden = NO;
        }
    }
    else if (cellView.followee.mTag == SiXin) {
        cellView.frame = CGRectMake(IMAGE_WIDTH + LEFT +18, TOP +8, CELL_WIDTH+50, 63);
//        xian.frame = CGRectMake(10, cellView.frame.size.height, 300, 2);
        xian.frame = CGRectMake(15, 74.5, 300, 1);
        bgImage.frame=CGRectMake(-20, 0, 360, 75);
        imageButton.frame = CGRectMake(LEFT + 10, TOP - 15, IMAGE_WIDTH+5, IMAGE_HEIGTH+5);
#ifdef isCaiPiaoForIPad
        cellView.frame = CGRectMake(IMAGE_WIDTH + LEFT +18, TOP +8, CELL_WIDTH_PAD+50, 70);
        xian.frame = CGRectMake(10, cellView.frame.size.height, 370, 2);
#endif
    }
    else if(cellView.followee.mTag == SearchMailList){
        cellView.frame = CGRectMake(IMAGE_WIDTH + LEFT, TOP, CELL_WIDTH+30, 70);
        attButton.hidden = YES;
//        bgImage.image = nil;
//        bgImage.image = UIImageGetImageFromName(@"LBT960.png");
//        bgImage.image = UIImageGetImageFromName(@"goucai_cellbg.png");
        bgImage.image = [bgImage.image stretchableImageWithLeftCapWidth:10 topCapHeight:10];

    }else if(cellView.followee.mTag == AttenList){
#ifdef isCaiPiaoForIPad
        if (lianxi == shixintype) {
            cellView.frame = CGRectMake(IMAGE_WIDTH + LEFT, TOP, 370, 70);
            bgImage.Frame = CGRectMake(10, 10, 370, 60);
            attButton.hidden = NO;
            attButton.Frame = CGRectMake(240, 13, 80, 30);
            
        }else if (lianxi == yaoqintype) {
        
            cellView.frame = CGRectMake(IMAGE_WIDTH + LEFT, TOP, 500, 70);
            bgImage.Frame = CGRectMake(10, 10, 500, 60);
            attButton.hidden = NO;
            attButton.Frame = CGRectMake(370, 13, 80, 30);
        }else {
        
            cellView.frame = CGRectMake(IMAGE_WIDTH + LEFT, TOP, 500, 70);
            attButton.hidden = NO;
        }
        
#else
        
        cellView.frame = CGRectMake(IMAGE_WIDTH + LEFT, TOP, CELL_WIDTH+30, 70);
        attButton.hidden = NO;
#endif
                
    }else if(cellView.followee.mTag == SearchUser){
#ifdef isCaiPiaoForIPad
        
        cellView.frame = CGRectMake(IMAGE_WIDTH + LEFT, TOP, 500, 70);
#else
        
        cellView.frame = CGRectMake(IMAGE_WIDTH + LEFT, TOP, CELL_WIDTH+30, 70);
#endif
        
    }else if(cellView.followee.mTag == SearchAttenList){
        cellView.frame = CGRectMake(IMAGE_WIDTH + LEFT, TOP, CELL_WIDTH+30, 70);
        if ([cellView.followee.name isEqualToString:@"在网络上搜索"]) {
            attButton.hidden = YES;
        }
        
    }else{
        cellView.frame = CGRectMake(IMAGE_WIDTH + LEFT, TOP, CELL_WIDTH+30, 70);
//        attButton.hidden = YES;
//        bgImage.image = nil;
    }
    cellView.frame = CGRectMake(15+IMAGE_WIDTH + LEFT, 10, CELL_WIDTH+30+30, 70);//60,15,224,70
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    