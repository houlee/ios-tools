//
//  HomeCell.m
//  caibo
//
//  Created by jacob on 11-6-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "HomeCell.h"
#import "ColorUtils.h"
//#import "BubbleView.h"
#import "NSStringExtra.h"
#import "caiboAppDelegate.h"
#import "datafile.h"
#import "MyProfileViewController.h"
#import "ProfileViewController.h"
#import "Info.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LotteryPreferenceViewController.h"
#import "TouZhuShowView.h"
#import "PreJiaoDianTabBarController.h"
#import "ClassicViewController.h"
#import "KFMessageViewController.h"
#import "SharedMethod.h"
#import "SharedDefine.h"

@implementation HomeCell
@synthesize ishome;
@synthesize xian;
@synthesize status;//, pImageView;
@synthesize homeCellDelegate;

- (void)setStatus:(YtTopic *)_status{

    if (status!= _status) {
        [status release];
        status = [_status retain];
    }
    
    if(status.isAuto)
        grayView.hidden = NO;
    else
        grayView.hidden = YES;
    
//    if ([mStatus.vip intValue] == 1) {
//        imageView.frame = CGRectMake(42, 44, 14, 14);
//    }
//    else {
//        imageView.frame = CGRectMake(0, 0, 0, 0);
//    }
    
    if ([status.vip intValue] == 1) {
        self.pImageView.frame = CGRectMake(WEIBO_USERIMAGE_WIDTH - 14, WEIBO_USERIMAGE_WIDTH - 14, 14, 14);
    }else{
        self.pImageView.frame = CGRectMake(0, 0, 0, 0);
    }
    NSLog(@"xxx = %d, x = %f, y= %f , w = %f h=%f", self.pImageView.hidden, self.pImageView.frame.origin.x, self.pImageView.frame.origin.y, self.pImageView.frame.size.width, self.pImageView.frame.size.height);
}

- (YtTopic *)status{
    return status;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.backgroundColor = WEIBO_BG_COLOR;
        self.contentView.backgroundColor = WEIBO_BG_COLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        detailedView = [[HomeDetailedView alloc] initWithFrame:CGRectZero];
        detailedView.delegate = self;
        [self.contentView addSubview:detailedView];
        //        bubble = [[BubbleView alloc] init];
        
        [self.contentView bringSubviewToFront:imageButton];
        [self.contentView bringSubviewToFront:pImageView];
        
        
        xian = [[UIImageView alloc] init];
        xian.backgroundColor  = [SharedMethod getColorByHexString:@"dddddd"];
        [self.contentView addSubview:xian];
        
        grayView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 296, 30)];
        grayView.hidden = YES;
        grayView.userInteractionEnabled = YES;
        grayView.backgroundColor = [UIColor clearColor];
        grayView.image = UIImageGetImageFromName(@"autoReport_background.png");
        [self.contentView addSubview:grayView];
        
        
        NSArray *titleArray = [NSArray arrayWithObjects:@"近期问题",@"经典问题",@"在线客服",nil];
        for(int i = 0 ;i<3;i++)
        {
            UIButton *jinqiBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
            [jinqiBtn setFrame:CGRectMake(0.5 + 74*i, 0, 73.5, 29)];
            if(i==3){
                [jinqiBtn setFrame:CGRectMake(0.5 + 74*i, 0, 73, 29)];

            }
            [jinqiBtn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [jinqiBtn setBackgroundColor:[UIColor clearColor]];
            
            if(i==0){
                
                [jinqiBtn setBackgroundImage:[UIImageGetImageFromName(@"autoReport_btn_left.png") stretchableImageWithLeftCapWidth:7 topCapHeight:14] forState:UIControlStateHighlighted];
                
            }
            else if(i==3){
                
                [jinqiBtn setBackgroundImage:[UIImageGetImageFromName(@"autoReport_btn_right.png") stretchableImageWithLeftCapWidth:7 topCapHeight:14] forState:UIControlStateHighlighted];
                
            }
            else{
                [jinqiBtn setBackgroundImage:UIImageGetImageFromName(@"autoReport_btn_middle.png") forState:UIControlStateHighlighted];
                
            }
            [jinqiBtn setTitleColor:[UIColor colorWithRed:25/255.0 green:113/255.0 blue:209/255.0 alpha:1] forState:UIControlStateNormal];
            [jinqiBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateHighlighted];
            
            jinqiBtn.tag = 111+i;
            [jinqiBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
            [jinqiBtn addTarget:self action:@selector(pressJinQiQuestion:) forControlEvents:UIControlEventTouchUpInside];
            [grayView addSubview:jinqiBtn];
        }
        
        bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:bottomView];
        
        UIView * lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)] autorelease];
        lineView.backgroundColor = [SharedMethod getColorByHexString:@"dddddd"];
        [bottomView addSubview:lineView];
        
        for (int i = 0; i < 3; i++) {
            if (i != 1) {
                UIButton * bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(i * WEIBO_BOTTOMBUTTON_WIDTH, 0, WEIBO_BOTTOMBUTTON_WIDTH, WEIBO_BOTTOMBUTTON_HEIGHT)];
                bottomButton.backgroundColor = [UIColor clearColor];
                [bottomView addSubview:bottomButton];
                bottomButton.tag = i + 100;
                [bottomButton addTarget:self action:@selector(bottomButton:) forControlEvents:UIControlEventTouchUpInside];
                [bottomButton release];
                
                if (i == 2) {
                    UIImageView * likeImageView = [[UIImageView alloc] init];
                    likeImageView.tag = 200;
                    [bottomButton addSubview:likeImageView];
                    [likeImageView release];
                    
                    UILabel * likeCountLabel = [[UILabel alloc] init];
                    likeCountLabel.tag = 201;
                    [bottomButton addSubview:likeCountLabel];
                    likeCountLabel.backgroundColor = [UIColor clearColor];
                    likeCountLabel.font = WEIBO_ZHUANFA_FONT;
                    [likeCountLabel release];
                }
            }
        }
    }
	return self;
}

-(void)bottomButton:(UIButton *)button
{
    if (homeCellDelegate && [homeCellDelegate respondsToSelector:@selector(touchHomeCellBottomButton:homeCell:ytTopic:)]) {
        [homeCellDelegate touchHomeCellBottomButton:button homeCell:self ytTopic:status];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 10001) {
		switch (buttonIndex) {
			case 1://注册
			{
			}	
				break;
			case 2://登录
			{
			}
				break;
				
			default:
				break;
		}
	}
}

// 点击头像
- (void)didTouchHeadImageButton:(id)sender
{
	Info *info = [Info getInstance];
	if ([info.userId isEqualToString:CBGuiteID]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请登录你的微博账户" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"注册",@"登录",nil];
		alert.tag = 10001;
		[alert show];
		[alert release];
		return;
	}
    UIViewController *controller;
    if ([status.userid isUserself]) {
        
       MyProfileViewController * ccontroller = [[MyProfileViewController alloc] initWithType:1];
        ccontroller.homebool = ishome;
        ccontroller.popyes = YES;
//        if (ishome) {
//             NSString * arr =@"1";
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"ishomepanduan" object:arr];
//        }else{
//              NSString * arr =@"0";
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"ishomepanduan" object:arr];
//        }
       
        
        UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
        if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
            
            if (!ishome) {
                [NV pushViewController:ccontroller animated:YES];
            }else{
                PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
                [(UINavigationController *)VC.selectedViewController pushViewController:ccontroller animated:YES];
            }
            
        }
        else {
            [NV pushViewController:ccontroller animated:YES];
        }
        //controller.navigationController.navigationBarHidden = NO;
        [ccontroller release];

          
       // controller.homebool = ishome;
    } else {
        [[Info getInstance] setHimId:status.userid];
        controller = [[ProfileViewController alloc] init];
        [controller setHidesBottomBarWhenPushed:YES];
        UINavigationController *NV = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
        if ([[[NV viewControllers] lastObject] isKindOfClass:[PreJiaoDianTabBarController class]]) {
            
            if (!ishome) {
                [NV pushViewController:controller animated:YES];
            }else{
                PreJiaoDianTabBarController *VC = [[NV viewControllers] lastObject];
                [(UINavigationController *)VC.selectedViewController pushViewController:controller animated:YES];
            }
            
        }
        else {
            [NV pushViewController:controller animated:YES];
        }
        //controller.navigationController.navigationBarHidden = NO;
        [controller release];

    }
 //   UINavigationController *nav = (UINavigationController*)[delegate.tabBarController.viewControllers objectAtIndex:delegate.tabBarController.selectedIndex];
 //   [nav pushViewController:controller animated:YES];
}

- (void) update : (UITableView *)tableView {
    // 获取头像
    [self fetchProfileImage:status.mid_image];

    [detailedView setStatus:status];
    
}


- (void)layoutSubviews {
	[super layoutSubviews];
    if (!status) {
        return;
    }
    
    detailedView.frame = CGRectMake(0, WEIBO_CELL_SPACE, self.bounds.size.width, status.cellHeight - WEIBO_CELL_SPACE);
    imageButton.frame = WEIBO_USERIMAGE_FRAME;
    
    //赞
//    UIButton * likeButton = (UIButton *)[bottomView viewWithTag:102];
    UIImageView * likeImageView = (UIImageView *)[bottomView viewWithTag:200];
    UILabel * likeCountLabel = (UILabel *)[bottomView viewWithTag:201];
    
    NSMutableDictionary * weiBoLikeDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"weiBoLike"]];
    
    if ([weiBoLikeDic valueForKey:status.topicid]) {
        status.count_dz = [[weiBoLikeDic valueForKey:status.topicid] objectAtIndex:0];
        status.praisestate = [[weiBoLikeDic valueForKey:status.topicid] objectAtIndex:1];
    }
    
    float likeW = 0;
    if ([status.count_dz integerValue]) {
        likeW = [status.count_dz sizeWithFont:WEIBO_ZHUANFA_FONT].width;
        likeCountLabel.text = status.count_dz;
    }else{
        likeW = [@"赞" sizeWithFont:WEIBO_ZHUANFA_FONT].width;
        likeCountLabel.text = @"赞";
    }
    likeCountLabel.frame = CGRectMake((WEIBO_BOTTOMBUTTON_WIDTH - likeW - 13 - 5)/2 + 13 + 5, 0, likeW, WEIBO_BOTTOMBUTTON_HEIGHT);
    
    if ([status.praisestate integerValue]) {
        likeCountLabel.textColor = [SharedMethod getColorByHexString:@"f56a1d"];
        likeImageView.image = UIImageGetImageFromName(@"WeiBo_Like_1.png");
    }else{
        likeCountLabel.textColor = [SharedMethod getColorByHexString:@"929292"];
        likeImageView.image = UIImageGetImageFromName(@"WeiBo_Like.png");
    }
    likeImageView.frame = CGRectMake((WEIBO_BOTTOMBUTTON_WIDTH - likeW - 13 - 5)/2, (WEIBO_BOTTOMBUTTON_HEIGHT - 11.5)/2, 13, 11.5);

    
    if(self.status.isAuto)
    {
        xian.frame = CGRectMake(0, status.cellHeight - 0.5, 320, 0.5);
        grayView.frame = CGRectMake(12, status.cellHeight - 10 - 29, 296, 29);
        bottomView.hidden = YES;
    }
    else
    {
        xian.frame = CGRectMake(0, status.cellHeight - 0.5, 320, 0.5);
        bottomView.hidden = NO;
        bottomView.frame = CGRectMake(0, status.cellHeight - WEIBO_BOTTOMBUTTON_HEIGHT, 320, WEIBO_BOTTOMBUTTON_HEIGHT);
    }
    if (bottomView && status.caiboType == CAIBO_TYPE_COMMENT) {
        [bottomView removeFromSuperview];
    }
}
-(void)pressJinQiQuestion:(UIButton *)sender
{
    if(sender.tag == 111)
    {
        NSLog(@"近期问题");
        UINavigationController * nav = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
        ClassicViewController *classic = [[ClassicViewController alloc] init];
        classic.questionType = @"0";
        [nav pushViewController:classic animated:YES];
        [classic release];
    }
    else if(sender.tag == 112)
    {
        NSLog(@"经典问题");
        UINavigationController * nav = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
        ClassicViewController *classic = [[ClassicViewController alloc] init];
        classic.questionType = @"1";
        [nav pushViewController:classic animated:YES];
        [classic release];
    }
    else if(sender.tag == 113)
    {
        NSLog(@"在线客服");
        caiboAppDelegate * appDelegate = [caiboAppDelegate getAppDelegate];
        
        KFMessageViewController *kfmBox=[[KFMessageViewController alloc] init];
        
        kfmBox.showBool = YES;
        
        [kfmBox tsInfo];//调用提示信息
        
        [kfmBox returnSiXinCount];
        
        [(UINavigationController *)appDelegate.window.rootViewController pushViewController:kfmBox animated:YES];
        
        [kfmBox release];
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"]) {
            NSDictionary * chekdict = [[NSUserDefaults standardUserDefaults] valueForKey:@"cheknewpush"];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:chekdict];
            [dic setValue:@"0" forKey:@"kfsx"];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"cheknewpush"];
            caiboAppDelegate * caiboappdelegate = [caiboAppDelegate getAppDelegate];
            caiboappdelegate.keFuButton.markbool = NO;
            caiboappdelegate.keFuButton.newkfbool = NO;
            
        }
    }
    else
    {
        NSLog(@"客服电话");
//        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//        
//        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否要拨打客服电话:" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"QQ：3254056760", nil];
//        [actionSheet showInView:window];
//        [actionSheet release];
    }
}
- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 0) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008130001"]];
//    }
}


-(void)touchWebViewByYtTopic:(YtTopic *)ytTopic
{
    if ([homeCellDelegate respondsToSelector:@selector(touchColorViewByYtTopic:)]) {
        [homeCellDelegate touchColorViewByYtTopic:ytTopic];
    }
}

- (void)dealloc {
    [status release];
    [detailedView release];
//    [bubble release];
	//[pImageView release];
    [xian release];
    
    [grayView release];
    [bottomView release];
    
    [super dealloc];
}

@end
int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    