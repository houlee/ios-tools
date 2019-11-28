//
//  PaiWuOrQiXingViewController.m
//  caibo
//
//  Created by houchenguang on 12-9-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PaiWuOrQiXingViewController.h"
#import "ShakeView.h"
#import "GouCaiShuZiInfoViewController.h"
#import "Info.h"
#import "GC_LotteryUtil.h"
#import "caiboAppDelegate.h"
#import "Xieyi365ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "LoginViewController.h"
#import "LotteryListViewController.h"
#import "GCHeMaiInfoViewController.h"
#import "MobClick.h"
#import "JiangChiJieXi.h"


@implementation PaiWuOrQiXingViewController
@synthesize qixingorpaiwu;
@synthesize myissueRecord;
@synthesize myRequest;
@synthesize isHemai;
@synthesize wangQi;
@synthesize qihaoReQuest;
@synthesize jiangchi;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        isBackScrollView = YES;
        isVerticalBackScrollView = YES;
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]){
        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(doBack) ImageName:@"HC_gouwuche.png"];
        [self.CP_navigation setHidesBackButton:YES];
    }
}

//请求奖池金额
- (void)requestJiangchiMoney {
    if (qixingorpaiwu == shuZiCaiQiXing) {
        NSMutableData *postData = [[GC_HttpService sharedInstance] JiangChi:@"110" other:@""];
        [self.jiangChiRequest clearDelegatesAndCancel];
        self.jiangChiRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [self.jiangChiRequest setRequestMethod:@"POST"];
        [self.jiangChiRequest addCommHeaders];
        [self.jiangChiRequest setPostBody:postData];
        [self.jiangChiRequest setDidFinishSelector:@selector(requestJiangchi:)];
        [self.jiangChiRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [self.jiangChiRequest setDelegate:self];
        [self.jiangChiRequest startAsynchronous];
    }

    
}
- (void)requestJiangchi:(ASIHTTPRequest *)request {
    if ([request responseData]) {
        JiangChiJieXi *info = [[JiangChiJieXi alloc] initWithResponseData:[request responseData]WithRequest:request];
        if ([info.JiangChi intValue]) {
            jiangchiLable.text = [NSString stringWithFormat:@"奖池金额：<%@> 元",info.JiangChi];
        }
        else {
            jiangchiLable.text = @"统计中...";
        }
        if ([jiangchiLable.text isEqualToString:@"统计中..."]) {
            jiangchiLable.frame = CGRectMake(180 - info.JiangChi.length *4, jiangchiLable.frame.origin.y, 140, 20);
            
        }else{
            jiangchiLable.frame = CGRectMake(180 - info.JiangChi.length *4, jiangchiLable.frame.origin.y, 140, 20);
            
            
        }
        [info release];
        
    }
}

- (void)LoadIphoneView {
    backScrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
    [self.mainView addSubview:backScrollView];
    backScrollView.backgroundColor = [UIColor clearColor];
    [backScrollView release];
    if (qixingorpaiwu == shuZiCaiPaiWu) {
        
        
        backScrollView.contentSize = CGSizeMake(320, 550);
        
    }else if(qixingorpaiwu == shuZiCaiQiXing){
        jiangchiLable = [[ColorView alloc] init];
        jiangchiLable.changeColor = [UIColor redColor];
        jiangchiLable.textAlignment=NSTextAlignmentRight;
        jiangchiLable.backgroundColor = [UIColor clearColor];
        jiangchiLable.font = [UIFont systemFontOfSize:12];
        [backScrollView addSubview:jiangchiLable];
        NSString *str=jiangchi;
//        if(str.length>5)
//        {
//            str=[str substringFromIndex:5];
//            NSLog(@"%@",str);
//        }
        jiangchiLable.text=[NSString stringWithFormat:@"奖池金额：<%@>元",str];
        jiangchiLable.changeColor=[UIColor redColor];
//        jiangchiLable.text=jiangchi;
        NSLog(@"%@",jiangchi);
        backScrollView.contentSize = CGSizeMake(320, 730);
        jiangchiLable.frame = CGRectMake(180 - str.length *4, 660, 140, 20);
        [jiangchiLable release];
    }
    
//    UIImageView *image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(140, 10, 170, 47)];
    UIImageView *image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 37)];
	[backScrollView addSubview:image1BackView];
//    image1BackView.image = [UIImageGetImageFromName(@"GC_sqkjback.png")stretchableImageWithLeftCapWidth:5 topCapHeight:5];
	image1BackView.layer.masksToBounds = YES;
	image1BackView.backgroundColor = [UIColor whiteColor];
	[image1BackView release];
    
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 23, 195, 2)];
//    imageV.image = UIImageGetImageFromName(@"SZTG960.png");
//    [image1BackView addSubview:imageV];
//    [imageV release];
    UIImageView *yaoImage = [[UIImageView alloc] init];
	yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
	yaoImage.frame =CGRectMake(285, 8, 21, 19);
	[backScrollView addSubview:yaoImage];
	[yaoImage release];
    
//    sqkaijiang = [[ColorView alloc] initWithFrame:CGRectMake(155, 19, 180, 20)];
    sqkaijiang = [[ColorView alloc] initWithFrame:CGRectMake(14, 11, 180, 15)];
    if (qixingorpaiwu == shuZiCaiPaiWu) {
//        sqkaijiang.frame = CGRectMake(165, 19, 180, 20);
        sqkaijiang.frame = CGRectMake(14, 11, 180, 15);
    }
//    sqkaijiang.textAlignment = NSTextAlignmentRight;
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.font = [UIFont systemFontOfSize:14];
    sqkaijiang.changeColor = [UIColor redColor];
    sqkaijiang.text = [NSString stringWithFormat:@"上期开奖：<%@>",[self.myissueRecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"," withString:@" "]];
    sqkaijiang.textColor = [UIColor blackColor];
    [backScrollView addSubview:sqkaijiang];
	[sqkaijiang release];
    
//    endTimelable = [[ColorView alloc] initWithFrame:CGRectMake(10, 30, 150, 20)];
    endTimelable = [[ColorView alloc] initWithFrame:CGRectMake(15, backScrollView.frame.size.height-64, 200, 20)];
    [backScrollView addSubview:endTimelable];
    endTimelable.backgroundColor = [UIColor clearColor];
//    endTimelable.changeColor = [UIColor lightGrayColor];
    endTimelable.font = [UIFont boldSystemFontOfSize:12];
//    endTimelable.colorfont = [UIFont boldSystemFontOfSize:9];
    endTimelable.textColor=[UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
    if (self.myissueRecord) {
//        endTimelable.text = [NSString stringWithFormat:@"截止时间 %@",self.myissueRecord.curEndTime];
        if (qixingorpaiwu == shuZiCaiQiXing) {
            endTimelable.text = [NSString stringWithFormat:@"截止时间 %@",[SharedMethod changeDateToNoYearNoSecond:self.myissueRecord.curEndTime]];
            if(self.myissueRecord.curEndTime.length>15)
            {
                endTimelable.text = [endTimelable.text substringToIndex:11];
            }
        }else{
            endTimelable.text = [NSString stringWithFormat:@"截止时间 %@",self.myissueRecord.curEndTime];
        }

    }
    [endTimelable release];
    
    
    
    NSArray *array2 = nil;
    countci = 1;
    if (qixingorpaiwu == shuZiCaiPaiWu) {
        array2 = [NSArray arrayWithObjects:@"万位",@"千位",@"百位",@"十位",@"个位",nil];
        countci = 5;
    }else if(qixingorpaiwu == shuZiCaiQiXing){
        array2 = [NSArray arrayWithObjects:@"第一位",@"第二位",@"第三位",@"第四位",@"第五位", @"第六位", @"第七位",nil];
        countci = 7;
    }
    CGRect ballRect;
    UIView * lastView;
	for (int i = 0; i<countci; i++) {
		UIImageView *firstView = [[UIImageView alloc] init];
		firstView.tag = 1010 +i;
		ColorView *label = [[ColorView alloc] init];
		label.backgroundColor = [UIColor clearColor];
        label.text = [array2 objectAtIndex:i];
		label.textColor = [UIColor whiteColor];
		label.tag = 100;
        label.textAlignment = NSTextAlignmentCenter;
        
        label.textColor = [UIColor whiteColor];
		
        if (qixingorpaiwu == shuZiCaiPaiWu) {
            label.frame = CGRectMake(5, 1, 54, 22);
//            label.frame = CGRectMake(7, 22, 20, 60);
            label.font = [UIFont systemFontOfSize:14];
//            label.jianjuHeight = 3;
//            label.colorfont = [UIFont boldSystemFontOfSize:14];
        }
        else {
            label.frame = CGRectMake(5, 1, 54, 22);
//            label.frame = CGRectMake(7, 13, 20, 60);
            label.font = [UIFont systemFontOfSize:14];
//            label.colorfont = [UIFont boldSystemFontOfSize:12];
        }
        
        UIImageView *imaHong=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 54, 22)];
        imaHong.backgroundColor=[UIColor clearColor];
        imaHong.tag=10010;
        imaHong.image=[UIImage imageNamed:@"LeftTitleRed.png"];
        [firstView addSubview:imaHong];
        [imaHong release];
        [firstView addSubview:label];
        [label release];
        
        ColorView *desLabel = [[ColorView alloc] init];
        desLabel.backgroundColor=[UIColor clearColor];
        desLabel.textColor=[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
        desLabel.frame=CGRectMake(60, 2, 200, 22);
        desLabel.tag=2000;
        desLabel.font=[UIFont systemFontOfSize:12];
        [firstView addSubview:desLabel];
        desLabel.text=@"至少选择1个号";
        [desLabel release];
        
		firstView.backgroundColor = [UIColor clearColor];
//        if (SWITCH_ON) {
//            firstView.frame = CGRectMake(10, 30 + 30 + i*130, 300.5, 130);
//        }else{
//            firstView.frame = CGRectMake(10, 30 + 30 + i*96, 300.5, 91.5);
        firstView.frame = CGRectMake(0, 37 + 18 + i*120, 320, 119);
//        }
//		firstView.image = UIImageGetImageFromName(@"TZAHBG960.png");
		firstView.userInteractionEnabled = YES;
        lastView = firstView;
        GCBallView *lastRedBallView;

		for (int j = 0; j<10; j++) {
//			int a= j/5,b = j%5;
            int a= j/6,b = j%6;
			NSString *num = [NSString stringWithFormat:@"%d",j];
//            if (SWITCH_ON) {
//                ballRect = CGRectMake(b*50+48, a*52+11, 35, 35);
//            }else{
//                ballRect = CGRectMake(b*50+48, a*37+7.5, 35, 35);
            ballRect = CGRectMake(b*51+14, a*40+35, 35, 35);
//            }
			GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorRed];
			[firstView addSubview:im];
			im.tag = j;
            im.isBlack = YES;
			im.gcballDelegate = self;
//            if (!SWITCH_ON) {
//                im.ylLable.hidden = YES;
//            }
            lastRedBallView=im;
			[im release];
		}
        GifButton * redTrashButton = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(ORIGIN_X(lastRedBallView) + 15, lastRedBallView.frame.origin.y, 0, 0)] autorelease];
        redTrashButton.tag = 333;
        redTrashButton.delegate=self;
        [firstView addSubview:redTrashButton];
        
		[backScrollView addSubview:firstView];
		[firstView release];
	}
    
    backScrollView.contentSize = CGSizeMake(320, ORIGIN_Y(lastView) + 10 + 44+10);
//    endTimelable.frame=CGRectMake(15+165, backScrollView.contentSize.height-64+10, 200, 20);
    endTimelable.frame=CGRectMake(15, backScrollView.contentSize.height-64+10, 200, 20);
//    jiangchiLable.frame = CGRectMake(180, backScrollView.contentSize.height-64+10, 120, 20);
    jiangchiLable.frame = CGRectMake(160, backScrollView.contentSize.height-64+10, 160, 20);
    
    backScrollView.frame = CGRectMake(backScrollView.frame.origin.x, backScrollView.frame.origin.y, backScrollView.frame.size.width, backScrollView.contentSize.height + 10);
    _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, backScrollView.frame.size.height);
    
    cpLowermostScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(_mainView) + 44 + isIOS7Pianyi);
    
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height -44, 320, 44)];
	[self.view addSubview:im];
    im.userInteractionEnabled = YES;
    im.backgroundColor=[UIColor colorWithRed:22/255.0 green:23/255.0 blue:25/255.0 alpha:1];
//	im.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
	
	
//    //清按钮
//    UIButton *qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//    qingbutton.frame = CGRectMake(12, 10, 30, 30);
//    //[qingbutton setImage:UIImageGetImageFromName(@"gc_fb_14.png") forState:UIControlStateNormal];
//    [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
//    [qingbutton addTarget:self action:@selector(clearBalls) forControlEvents:UIControlEventTouchUpInside];
//    [im addSubview:qingbutton];
    
    //注数背景
//    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(52, 10, 62, 30)];
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 68, 30)];
    zhubg.image = UIImageGetImageFromName(@"SRK960.png");
    zhubg.userInteractionEnabled = YES;
    [im addSubview:zhubg];
    [zhubg release];
    
	zhushuLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 2.5, 40, 11)];
	[zhubg addSubview:zhushuLabel];
	zhushuLabel.text = @"0";
    zhushuLabel.backgroundColor = [UIColor clearColor];
	zhushuLabel.font = [UIFont boldSystemFontOfSize:12];
	zhushuLabel.textAlignment = NSTextAlignmentCenter;
    zhushuLabel.textColor=[UIColor colorWithRed:182/255.0 green:172/255.0 blue:133/255.0 alpha:1];
	[zhushuLabel release];
	
	UILabel *zhu = [[UILabel alloc] initWithFrame:CGRectMake(40, 2.5, 20, 11)];
	zhu.text = @"注";
	zhu.backgroundColor = [UIColor clearColor];
	zhu.font = [UIFont systemFontOfSize:12];
	zhu.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133/255.0 alpha:1];
	[zhubg addSubview:zhu];
    [zhu release];
	
	jineLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 17.5, 40, 11)];
	[zhubg addSubview:jineLabel];
	jineLabel.text = @"0";
	jineLabel.font = [UIFont boldSystemFontOfSize:9];
    jineLabel.backgroundColor = [UIColor clearColor];
	jineLabel.textAlignment = NSTextAlignmentCenter;
    jineLabel.textColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1];
	[jineLabel release];
	
	UILabel *jin = [[UILabel alloc] initWithFrame:CGRectMake(40, 17.5, 20, 11)];
	jin.text = @"元";
	jin.font = [UIFont systemFontOfSize:12];
	jin.textColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1];
	jin.backgroundColor = [UIColor clearColor];
	[zhubg addSubview:jin];
    [jin release];
	
	senBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[senBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
	senBtn.frame = CGRectMake(230, 7, 80, 33);
	[im addSubview:senBtn];
    
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    
    UIImageView *senImage = [[UIImageView alloc] initWithFrame:senBtn.bounds];
//    senImage.image = [UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [senBtn addSubview:senImage];
    [senImage release];
    
    UILabel *senLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 33)];
    senLabel.backgroundColor = [UIColor clearColor];
    senLabel.textAlignment = NSTextAlignmentCenter;
    senLabel.text = @"机选";
    senLabel.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    senLabel.tag = 1101;
    senLabel.font = [UIFont systemFontOfSize:18];
    [senBtn addSubview:senLabel];
    [senLabel release];
}

- (void)LoadIpadView {
    backScrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
    [self.mainView addSubview:backScrollView];
    backScrollView.frame = CGRectMake(35, 0, 320, self.mainView.bounds.size.height);
    backScrollView.backgroundColor = [UIColor clearColor];
    [backScrollView release];
    if (qixingorpaiwu == shuZiCaiPaiWu) {
        
        
        backScrollView.contentSize = CGSizeMake(320, 550);
        
    }else if(qixingorpaiwu == shuZiCaiQiXing){
        jiangchiLable = [[ColorView alloc] init];
        jiangchiLable.changeColor = [UIColor redColor];
        jiangchiLable.backgroundColor = [UIColor clearColor];
        jiangchiLable.font = [UIFont systemFontOfSize:12];
        [backScrollView addSubview:jiangchiLable];
        backScrollView.contentSize = CGSizeMake(320, 660);
        jiangchiLable.frame = CGRectMake(160, 660, 140, 20);
        [jiangchiLable release];
    }
    
    sqkaijiang = [[ColorView alloc] initWithFrame:CGRectMake(160, 6, 180, 20)];
    sqkaijiang.textAlignment = NSTextAlignmentRight;
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.font = [UIFont systemFontOfSize:11];
    sqkaijiang.changeColor = [UIColor redColor];
    sqkaijiang.text = [NSString stringWithFormat:@"上期开奖：<%@>",[self.myissueRecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"," withString:@" "]];
    sqkaijiang.textColor = [UIColor blackColor];
    [backScrollView addSubview:sqkaijiang];
	[sqkaijiang release];
    
    
	UIImageView *yaoImage = [[UIImageView alloc] init];
	yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
	yaoImage.frame =CGRectMake(10, 8, 15, 15);
	[backScrollView addSubview:yaoImage];
	[yaoImage release];
    
    
    
    NSArray *array2 = nil;
    countci = 1;
    if (qixingorpaiwu == shuZiCaiPaiWu) {
        array2 = [NSArray arrayWithObjects:@"万①",@"千①",@"百①",@"十①",@"个①",nil];
        countci = 5;
    }else if(qixingorpaiwu == shuZiCaiQiXing){
        array2 = [NSArray arrayWithObjects:@"第一位①",@"第二位①",@"第三位①",@"第四位①",@"第五位①", @"第六位①", @"第七位①",nil];
        countci = 7;
    }
    
	for (int i = 0; i<countci; i++) {
		UIImageView *firstView = [[UIImageView alloc] init];
		firstView.tag = 1010 +i;
		ColorView *label = [[ColorView alloc] init];
		label.backgroundColor = [UIColor clearColor];
        label.text = [array2 objectAtIndex:i];
		label.textColor = [UIColor whiteColor];
		[firstView addSubview:label];
		label.tag = 100;
        label.textAlignment = NSTextAlignmentCenter;
        
        label.textColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
		
        if (qixingorpaiwu == shuZiCaiPaiWu) {
            label.frame = CGRectMake(7, 22, 20, 60);
            label.font = [UIFont systemFontOfSize:14];
            label.jianjuHeight = 3;
            label.colorfont = [UIFont boldSystemFontOfSize:14];
        }
        else {
            label.frame = CGRectMake(7, 13, 20, 60);
            label.font = [UIFont systemFontOfSize:12];
            label.colorfont = [UIFont boldSystemFontOfSize:12];
        }
		[label release];
		firstView.backgroundColor = [UIColor clearColor];
		firstView.frame = CGRectMake(10, 30 + i*90, 300, 91);
		firstView.image = UIImageGetImageFromName(@"TZAHBG960.png");
		firstView.userInteractionEnabled = YES;
		for (int j = 0; j<10; j++) {
			int a= j/5,b = j%5;
			NSString *num = [NSString stringWithFormat:@"%d",j];
			GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*43+60, a*37+10, 35, 35) Num:num ColorType:GCBallViewColorRed];
			[firstView addSubview:im];
			im.tag = j;
            im.isBlack = YES;
			im.gcballDelegate = self;
			[im release];
		}
		[backScrollView addSubview:firstView];
		[firstView release];
	}
    
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 748 - 88, 390, 44)];
	[self.mainView addSubview:im];
    im.userInteractionEnabled = YES;
	im.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
	[im release];
	
    //清按钮
    UIButton *qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    qingbutton.frame = CGRectMake(12 + 35, 10, 30, 30);
    //[qingbutton setImage:UIImageGetImageFromName(@"gc_fb_14.png") forState:UIControlStateNormal];
    [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
    [qingbutton addTarget:self action:@selector(clearBalls) forControlEvents:UIControlEventTouchUpInside];
    [im addSubview:qingbutton];
    
    //注数背景
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(52 + 35, 10, 62, 30)];
    zhubg.image = UIImageGetImageFromName(@"SRK960.png");
    zhubg.userInteractionEnabled = YES;
    [im addSubview:zhubg];
    [zhubg release];
    
	zhushuLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 4, 40, 11)];
	[zhubg addSubview:zhushuLabel];
	zhushuLabel.text = @"0";
    zhushuLabel.backgroundColor = [UIColor clearColor];
	zhushuLabel.font = [UIFont boldSystemFontOfSize:9];
	zhushuLabel.textAlignment = NSTextAlignmentCenter;
	[zhushuLabel release];
	
	UILabel *zhu = [[UILabel alloc] initWithFrame:CGRectMake(40, 4, 20, 11)];
	zhu.text = @"注";
	zhu.backgroundColor = [UIColor clearColor];
	zhu.font = [UIFont systemFontOfSize:9];
	zhu.textColor = [UIColor blackColor];
	[zhubg addSubview:zhu];
    [zhu release];
	
	jineLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 19, 40, 11)];
	[zhubg addSubview:jineLabel];
	jineLabel.text = @"0";
	jineLabel.font = [UIFont boldSystemFontOfSize:9];
    jineLabel.backgroundColor = [UIColor clearColor];
	jineLabel.textAlignment = NSTextAlignmentCenter;
	[jineLabel release];
	
	UILabel *jin = [[UILabel alloc] initWithFrame:CGRectMake(40, 19, 20, 11)];
	jin.text = @"元";
	jin.font = [UIFont systemFontOfSize:9];
	jin.textColor = [UIColor blackColor];
	jin.backgroundColor = [UIColor clearColor];
	[zhubg addSubview:jin];
    [jin release];
	
	senBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[senBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
	senBtn.frame = CGRectMake(230 + 35, 7, 80, 33);
	[im addSubview:senBtn];
    
    UIImageView *senImage = [[UIImageView alloc] initWithFrame:senBtn.bounds];
    senImage.image = [UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [senBtn addSubview:senImage];
    [senImage release];
    
    UILabel *senLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 33)];
    senLabel.backgroundColor = [UIColor clearColor];
    senLabel.textAlignment = NSTextAlignmentCenter;
    senLabel.text = @"机选";
    senLabel.textColor = [UIColor colorWithRed:11.0/255.0 green:107.0/255.0 blue:172.0/255.0 alpha:1];
    senLabel.tag = 1101;
    senLabel.font = [UIFont systemFontOfSize:15];
    [senBtn addSubview:senLabel];
    [senLabel release];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.CP_navigation.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    self.CP_navigation.titleLabel.textColor = [UIColor whiteColor];
    if (qixingorpaiwu == shuZiCaiQiXing) {
        self.CP_navigation.title = @"七星彩";
    }
    else {
        self.CP_navigation.title = @"排列5";
    }
    
    UIButton * historyButton = (UIButton *)[cpHistoryBGImageView viewWithTag:800];
    [historyButton addTarget:self action:@selector(toHistory) forControlEvents:UIControlEventTouchUpInside];
    
    ShakeView *shakeView = [[ShakeView alloc] init];
	[self.mainView addSubview:shakeView];
	[shakeView becomeFirstResponder];
	[shakeView release];
    
    UIImageView * bgimageview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    bgimageview.image = UIImageGetImageFromName(@"login_bgn.png");
    [self.mainView addSubview:bgimageview];
    [bgimageview release];

        if ([[[Info getInstance] userId] intValue] == 0) {
     		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
//            UIBarButtonItem *right = [Info itemInitWithTitle:@"登录注册" Target:self action:@selector(doLogin) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
            UIBarButtonItem *right = [Info itemInitWithTitle:@"登录" Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30)];
            self.CP_navigation.rightBarButtonItem = right;
        }
        else {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
            [btn setImage:UIImageGetImageFromName(@"chaodancaidan.png") forState:UIControlStateNormal];
            [btn setImage:UIImageGetImageFromName(@"chaodancaidan_1.png") forState:UIControlStateHighlighted];

            btn.frame = CGRectMake(0, 0, 60, 44);
            [btn addTarget:self action:@selector(pressMenu) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            rightItem.enabled = YES;
            [self.CP_navigation setRightBarButtonItem:rightItem];
            [rightItem release];
        }
    

        UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = left;
#ifdef isCaiPiaoForIPad
    [self LoadIpadView];
#else
    [self LoadIphoneView];
#endif
    myLotteryID = @"109";
    if (qixingorpaiwu == shuZiCaiQiXing) {
        myLotteryID = @"110";
    }
        NSMutableData *postData = [[GC_HttpService sharedInstance] getCaiZhongInfo:myLotteryID];
    
        [myRequest clearDelegatesAndCancel];
        self.myRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [myRequest setRequestMethod:@"POST"];
        [myRequest addCommHeaders];
        [myRequest setPostBody:postData];
        [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [myRequest setDelegate:self];
        [myRequest setDidFinishSelector:@selector(reqLotteryInfoFinished:)];
        [myRequest performSelector:@selector(startAsynchronous)];
    
    [self getWanqi];

    [self requestJiangchiMoney];
}

- (void)pressMenu {
    NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
    [allimage addObject:@"GC_sanjilishi.png"];
//    [allimage addObject:@"menuhmdt.png"];
//    [allimage addObject:@"yiLouSwIcon.png"];
    [allimage addObject:@"GC_sanjiShuoming.png"];

    NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
    [alltitle addObject:@"历史开奖"];
//    [alltitle addObject:@"合买大厅"];
//    [alltitle addObject:@"显示遗漏"];
    [alltitle addObject:@"玩法说明"];

    caiboAppDelegate *app = (caiboAppDelegate *)[UIApplication sharedApplication].delegate;
//    if (!tln) {
        tln = [[CP_ThreeLevelNavigationView alloc] initWithFrame:CGRectMake(0, -20, 320, app.window.frame.size.height) AllImageName:allimage setAllTitle:alltitle];
//    }
    
    tln.delegate = self;
    [self.view addSubview:tln];
    [tln show];
    [tln release];

    [allimage release];
    [alltitle release];
}

- (void)wanfaInfo {
    [MobClick event:@"event_goucai_wanfashuoming_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];

    Xieyi365ViewController * exp = [[Xieyi365ViewController alloc] init];
    //exp.title = @"玩法";
    
    if (qixingorpaiwu == shuZiCaiPaiWu) {
        exp.ALLWANFA = Pai5;
//        exp.infoText.text = @"开奖时间\n每晚20:45开奖。\n\n玩法规则\n从00000-99999的数字中选取1个5位数为投注号码进行投注，每注2元。\n\n所选号码与中奖号码全部相同且顺序一致。例如：中奖号码为43751，则排列5的中奖结果为：43751。\n\n奖项设置\n共设1个奖项，单注固定奖金100000元";
        
                
    }else if(qixingorpaiwu == shuZiCaiQiXing){
        exp.ALLWANFA = QiXinCai;
//        exp.infoText.text =@"开奖时间\n每周二、五、日晚开奖。\n\n玩法规则\n七星彩是指从0000000-9999999中选择任意7位自然数进行的投注，一组7位数的排列称为一注，每注2元。\n\n奖项设置\n一等奖：号码全部相符且排列一致奖金：浮动，最高500万\n二等奖：有连续相同位置的6位号码相同奖金：当期奖金额减去固定奖总额后的10%\n三等奖：有连续相同位置的5位号码相同奖金：1800元\n四等奖：有连续相同位置的4位号码相同奖金：300元\n五等奖：有连续相同位置的3位号码相同奖金：20元\n六等奖：有连续相同位置的2位号码相同奖金：5元\n\n七星彩单注彩票中奖奖金最高限额500万元";
    }
    
    //exp.infoText.font = [UIFont boldSystemFontOfSize:13];
    
    // GC_ExplainViewController * exp = [[GC_ExplainViewController  alloc] init];
    [self.navigationController pushViewController:exp animated:YES];
    [exp release];	
}


- (void)randBalls {
    if (qixingorpaiwu == shuZiCaiPaiWu) {
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *redBalls2 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *redBalls3 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
         NSMutableArray *redBalls4 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
         NSMutableArray *redBalls5 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        UIView *redView = [backScrollView viewWithTag:1010];
        for (GCBallView *ball in redView.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([redBalls containsObject:ball.numLabel.text]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
        UIView *redView2 = [backScrollView viewWithTag:1011];
        for (GCBallView *ball in redView2.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([redBalls2 containsObject:ball.numLabel.text]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
        UIView *redView3 = [backScrollView viewWithTag:1012];
        for (GCBallView *ball in redView3.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([redBalls3 containsObject:ball.numLabel.text]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
        UIView *redView4 = [backScrollView viewWithTag:1013];
        for (GCBallView *ball in redView4.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([redBalls4 containsObject:ball.numLabel.text]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
        UIView *redView5 = [backScrollView viewWithTag:1014];
        for (GCBallView *ball in redView5.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([redBalls5 containsObject:ball.numLabel.text]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }

      //  [self ballSelectChange:nil];
    }else if(qixingorpaiwu == shuZiCaiQiXing){
        
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *redBalls2 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *redBalls3 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *redBalls4 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *redBalls5 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *redBalls6 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *redBalls7 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        
        UIView *redView = [backScrollView viewWithTag:1010];
        for (GCBallView *ball in redView.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([redBalls containsObject:ball.numLabel.text]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
        UIView *redView2 = [backScrollView viewWithTag:1011];
        for (GCBallView *ball in redView2.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([redBalls2 containsObject:ball.numLabel.text]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
        UIView *redView3 = [backScrollView viewWithTag:1012];
        for (GCBallView *ball in redView3.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([redBalls3 containsObject:ball.numLabel.text]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
        UIView *redView4 = [backScrollView viewWithTag:1013];
        for (GCBallView *ball in redView4.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([redBalls4 containsObject:ball.numLabel.text]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
        UIView *redView5 = [backScrollView viewWithTag:1014];
        for (GCBallView *ball in redView5.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([redBalls5 containsObject:ball.numLabel.text]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
        UIView *redView6 = [backScrollView viewWithTag:1015];
        for (GCBallView *ball in redView6.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([redBalls6 containsObject:ball.numLabel.text]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }

        UIView *redView7 = [backScrollView viewWithTag:1016];
        for (GCBallView *ball in redView7.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([redBalls7 containsObject:ball.numLabel.text]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }


    
    }
    
    [self ballSelectChange:nil];
}
- (NSString *)seletNumber {
    NSString *number_s = @"", *selectNumber_s = @"*";
    
    NSMutableString *_selectNumber = [NSMutableString string];
    int b = 0;
    if (qixingorpaiwu == shuZiCaiPaiWu) {
        
        b = 5;
    }else if(qixingorpaiwu == shuZiCaiQiXing){
        b = 7;
    }
//    if (modetype == ThreeDzusanfushi || modetype == ThreeDzuliufushi) {
//        b = 1;
//    }
    for (int i = 0; i < b; i++) {
        UIView *ballsCon = [backScrollView viewWithTag:1010+i];
        GifButton * trashButton = (GifButton *)[ballsCon viewWithTag:333];
        NSMutableString *num = [NSMutableString string];
        for (GCBallView *ballV in ballsCon.subviews) {
            if ([ballV isKindOfClass:[GCBallView class]] && ballV.selected) {
                [num appendString:[NSString stringWithFormat:@"%d",[ballV.numLabel.text intValue]]];
                [num appendString:number_s];
            }
        }
        if ([num length] == 0) {
            [num appendString:@"e"];
            trashButton.hidden=YES;
        }
        else {
            trashButton.hidden=NO;
        }
        
        [_selectNumber appendString:num];
        if (qixingorpaiwu == shuZiCaiPaiWu) {
            if ((i == 0 || i == 1||i == 2 || i == 3)&&b!= 1) {
                [_selectNumber appendString:selectNumber_s];
            }
        }else if(qixingorpaiwu == shuZiCaiQiXing){
            if ((i == 0 || i == 1||i == 2 || i == 3 ||i == 4|| i == 5)&&b!= 1) {
                [_selectNumber appendString:selectNumber_s];
            }
        }
        
    } 
    NSLog(@"sele = %@", _selectNumber);
    return [_selectNumber length] > 0 ? _selectNumber : nil;
}

- (void)ballSelectChange:(UIButton *)imageView {
    int bets = 0;
    NSLog(@"%@",self.view.subviews);
    if (qixingorpaiwu == shuZiCaiQiXing) {
        bets = (int)[GC_LotteryUtil getBets:[self seletNumber] LotteryType:TYPE_QIXINGCAI ModeType:fushi];
    }else if(qixingorpaiwu == shuZiCaiPaiWu){
        bets = (int)[GC_LotteryUtil getBets:[self seletNumber] LotteryType:TYPE_PAILIE5 ModeType:fushi];
    }
    
    
	zhushuLabel.text = [NSString stringWithFormat:@"%d",bets];
	jineLabel.text = [NSString stringWithFormat:@"%d",2*bets];
    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
    NSString *str =[[[self seletNumber] stringByReplacingOccurrencesOfString:@"*" withString:@""] stringByReplacingOccurrencesOfString:@"e" withString:@""] ;
    if ([str length] == 0) {
        labe.text = @"机选";
        labe.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
        senBtn.enabled = YES;
    }
    else {
        labe.text = @"选好了";
        labe.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
        senBtn.enabled = YES;
    }

}
- (void)clearBalls {
    NSInteger countqing = 0;
    if (qixingorpaiwu == shuZiCaiPaiWu) {
        countqing = 5;
    }else if(qixingorpaiwu == shuZiCaiQiXing){
        countqing = 7;
    }
    
	for (int i = 0; i < countqing; i++) {
		UIView *ballView = [self.mainView viewWithTag:1010+i];
		for (GCBallView *ball in ballView.subviews) {
			if ([ball isKindOfClass:[GCBallView class]]) {
				ball.selected = NO;
			}
		}
	}
	zhushuLabel.text = [NSString stringWithFormat:@"%d",0];
	jineLabel.text = [NSString stringWithFormat:@"%d",2*0];
    [self ballSelectChange:nil];
}

- (void)send {
    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
    if ([labe.text isEqualToString:@"机选"] && [zhushuLabel.text integerValue] == 0) {
        [self randBalls];
        return;
    }
    [MobClick event:@"event_goucai_xuanhaole_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];
//    if ([[[Info getInstance] userId] intValue] == 0) {
//        [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
//#ifdef isCaiPiaoForIPad
//        [[caiboAppDelegate getAppDelegate] LoginForIpad];
//#endif
//        return;
//    }
	if ([jineLabel.text intValue] > 20000) {
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
		[cai showMessage:@"单注投注额不能超过20000元"];
		return;
	}
    if (qixingorpaiwu == shuZiCaiPaiWu) {
        int DanMa = 0;
        int TuoMa = 0;
        int blue = 0;
        int blue2 = 0;
        int blue3 = 0;
        UIView *qian = [backScrollView viewWithTag:1010];
        UIView *hou = [backScrollView viewWithTag:1011];
        UIView *hou2 = [backScrollView viewWithTag:1012];
        UIView *hou3 = [backScrollView viewWithTag:1013];
        UIView *hou4 = [backScrollView viewWithTag:1014];
        for (GCBallView *bt in qian.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    DanMa++;
                }
            }
            
        }
        for (GCBallView *bt2 in hou.subviews) {
            if ([bt2 isKindOfClass:[GCBallView class]]) {
                if (bt2.selected == YES) {
                    TuoMa++;
                }
            }
            
        }
        for (GCBallView *bt3 in hou2.subviews) {
            if ([bt3 isKindOfClass:[GCBallView class]]) {
                if (bt3.selected == YES) {
                    blue++;
                }
            }
            
        }
        for (GCBallView *bt4 in hou3.subviews) {
            if ([bt4 isKindOfClass:[GCBallView class]]) {
                if (bt4.selected == YES) {
                    blue2++;
                }
            }
            
        }
        for (GCBallView *bt5 in hou4.subviews) {
            if ([bt5 isKindOfClass:[GCBallView class]]) {
                if (bt5.selected == YES) {
                    blue3++;
                }
            }
            
        }
        if (DanMa < 1 || TuoMa < 1 || blue < 1 || blue2 < 1 || blue3 < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"每位至少选择1个号码"];
            return;
        }
        
    }
    if (qixingorpaiwu == shuZiCaiQiXing) {
        int DanMa = 0;
        int TuoMa = 0;
        int blue = 0;
        int blue2 = 0;
        int blue3 = 0;
        int blue4 = 0;
        int blue5 = 0;
        UIView *qian = [backScrollView viewWithTag:1010];
        UIView *hou = [backScrollView viewWithTag:1011];
        UIView *hou2 = [backScrollView viewWithTag:1012];
        UIView *hou3 = [backScrollView viewWithTag:1013];
        UIView *hou4 = [backScrollView viewWithTag:1014];
        UIView *hou5 = [backScrollView viewWithTag:1015];
        UIView *hou6 = [backScrollView viewWithTag:1016];
        for (GCBallView *bt in qian.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    DanMa++;
                }
            }
            
        }
        for (GCBallView *bt2 in hou.subviews) {
            if ([bt2 isKindOfClass:[GCBallView class]]) {
                if (bt2.selected == YES) {
                    TuoMa++;
                }
            }
            
        }
        for (GCBallView *bt3 in hou2.subviews) {
            if ([bt3 isKindOfClass:[GCBallView class]]) {
                if (bt3.selected == YES) {
                    blue++;
                }
            }
            
        }
        for (GCBallView *bt4 in hou3.subviews) {
            if ([bt4 isKindOfClass:[GCBallView class]]) {
                if (bt4.selected == YES) {
                    blue2++;
                }
            }
            
        }
        for (GCBallView *bt5 in hou4.subviews) {
            if ([bt5 isKindOfClass:[GCBallView class]]) {
                if (bt5.selected == YES) {
                    blue3++;
                }
            }
            
        }
        for (GCBallView *bt6 in hou5.subviews) {
            if ([bt6 isKindOfClass:[GCBallView class]]) {
                if (bt6.selected == YES) {
                    blue4++;
                }
            }
            
        }
        for (GCBallView *bt7 in hou6.subviews) {
            if ([bt7 isKindOfClass:[GCBallView class]]) {
                if (bt7.selected == YES) {
                    blue5++;
                }
            }
            
        }
        if (DanMa < 1 || TuoMa < 1 || blue < 1 || blue2 < 1 || blue3 < 1 || blue4 < 1 || blue5 < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"每位至少选择1个号码"];
            return;
        }
        
    }
    
    if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
        GouCaiShuZiInfoViewController *infoV = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
        NSString *selet = [self seletNumber];
        
        if ([zhushuLabel.text intValue] == 1) {
            selet = [NSString stringWithFormat:@"01#%@",selet];
            selet = [selet stringByReplacingOccurrencesOfString:@"," withString:@""];
        }
        else {
            selet = [NSString stringWithFormat:@"02#%@",selet];
        }
        NSLog(@"%@",selet);
        if ([selet rangeOfString:@"e"].location == NSNotFound) {
            if ([infoV.dataArray count] >=50) {
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"投注列表已有50条记录，当前记录无法保存，是否继续？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.tag = 201;
                [alert show];
                [alert release];
                return;
            }
            [infoV.dataArray addObject:selet];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        if (!infoViewController) {
            infoViewController = [[GouCaiShuZiInfoViewController alloc] init];
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeFuCai3D;
            if (qixingorpaiwu == shuZiCaiQiXing) {
                infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeQiXingCai;
            }else if(qixingorpaiwu == shuZiCaiPaiWu){
               infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypePaiLie5;
            }
            infoViewController.isHeMai = self.isHemai;
        }
        if (qixingorpaiwu == shuZiCaiQiXing) {
            infoViewController.lotteryType = TYPE_QIXINGCAI;
        }else if(qixingorpaiwu == shuZiCaiPaiWu){
            infoViewController.lotteryType = TYPE_PAILIE5;
        }
        infoViewController.modeType = fushi;
        infoViewController.betInfo.issue = self.myissueRecord.curIssue;
        NSString *selet = [self seletNumber];
        
        if ([zhushuLabel.text intValue] == 1) {
            selet = [NSString stringWithFormat:@"01#%@",selet];
            selet = [selet stringByReplacingOccurrencesOfString:@"," withString:@""];
        }
        else {
            selet = [NSString stringWithFormat:@"02#%@",selet];
        }
        NSLog(@"%@",selet);
        if ([selet rangeOfString:@"e"].location == NSNotFound) {
            if ([infoViewController.dataArray count] >=50) {
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"投注列表已有50条记录，当前记录无法保存，是否继续？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.tag = 201;
                [alert show];
                [alert release];
                return;
            }
            [infoViewController.dataArray addObject:selet];
        }
        [self.navigationController pushViewController:infoViewController animated:YES];
    }
    
	[self clearBalls];
}

- (void)getWanqi {
//    NSString *lotoryid = @"110";
//    if (qixingorpaiwu == shuZiCaiPaiWu) {
//        lotoryid = @"109";
//    }

    NSMutableData *postData = [[GC_HttpService sharedInstance] reWangqiWithLottery:myLotteryID countOfPage:20];
    [qihaoReQuest clearDelegatesAndCancel];
    self.qihaoReQuest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [qihaoReQuest setRequestMethod:@"POST"];
    [qihaoReQuest addCommHeaders];
    [qihaoReQuest setPostBody:postData];
    [qihaoReQuest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [qihaoReQuest setDelegate:self];
    [qihaoReQuest setDidFinishSelector:@selector(reqWangQiKaiJiang:)];
    [qihaoReQuest startAsynchronous];
}

#pragma mark -
#pragma mark CP_ThreeLevelNavDelegate

-(void)toHistory
{
    [MobClick event:@"event_goucai_chakangengduo_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];
    [MobClick event:@"event_goucai_lishikaijiang_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];
    LotteryListViewController *controller = [[LotteryListViewController alloc] init];
    
    controller.lotteryId =self.myissueRecord.lotteryId;
    controller.lotteryName = self.myissueRecord.lotteryName;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)returnSelectIndex:(NSInteger)index{
    
    if (index == 0) {
        [self toHistory];
    }
//    else if (index == 1) {
//        [MobClick event:@"event_goucai_hemaidating_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];
//
//        if (qixingorpaiwu == shuZiCaiPaiWu) {
//            [self otherLottoryViewController:0 title:@"排列5合买" lotteryType:TYPE_PAILIE5 lotteryId:myLotteryID];
//        }
//        else {
//            [self otherLottoryViewController:0 title:@"七星彩合买" lotteryType:TYPE_QIXINGCAI lotteryId:myLotteryID];
//        }
//        
//    }
//    else if (index == 2) {
//        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"遗漏值显示" message:@"显示" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
//        alert.shouldRemoveWhenOtherAppear = YES;
//        alert.tag = 999;
//        alert.alertTpye = switchType;
//        alert.delegate = self;
//        [alert show];
//        [alert release];
//    }
    else if (index == 1) {
        [self wanfaInfo];
    }
}

#pragma mark - switchChange

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 999) {
        if (buttonIndex == 1) {
            CP_SWButton * swBtn = (CP_SWButton *)[alertView viewWithTag:99];
            swBtn.onImageName = @"heji2-640_10.png";
            swBtn.offImageName = @"heji2-640_11.png";
            if (![[NSString stringWithFormat:@"%d",swBtn.on] isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"YiLouSwitch"]]) {
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",swBtn.on] forKey:@"YiLouSwitch"];
                [self switchChange];
            }
        }
    }else if (alertView.tag == 201) {
		if (buttonIndex == 1) {
			if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                [self clearBalls];
                
                [self.navigationController pushViewController:infoViewController animated:YES];
            }
		}
	}
}

-(void)switchChange
{
    float heght =60;
    int count = 0;
    int number = 0;
    for (int i = 1010;i<1010 + countci;i++) {
        UIView *v = [backScrollView viewWithTag:i];
        if (SWITCH_ON) {
            v.frame = CGRectMake(10, heght, 300.5, 130);
        }else{
            v.frame = CGRectMake(10, heght, 300.5, 91.5);
        }
        count = 10;
        number = 5;
        
        for (int j = 0; j < count; j++) {
            int a= j/number,b = j%number;
            if ([[v viewWithTag:j] isKindOfClass:[GCBallView class]]) {
                GCBallView * ballView = (GCBallView *)[v viewWithTag:j];
                if (SWITCH_ON) {
                    ballView.frame = CGRectMake(b*50+48, a*52+11, 35, 35);
                    ballView.ylLable.hidden = NO;
                }else{
                    ballView.frame = CGRectMake(b*50+48, a*37+7.5, 35, 35);
                    ballView.ylLable.hidden = YES;
                }
            }
        }
        heght = heght + v.bounds.size.height-1;
    }
    backScrollView.contentSize = CGSizeMake(320, ORIGIN_Y([backScrollView viewWithTag:1010 + countci - 1]) + 10 + 44);
}

#pragma mark -

- (void)otherLottoryViewController:(NSInteger)indexd title:(NSString *)titleStr lotteryType:(NSInteger)lotype lotteryId:(NSString *)loid{
    
    GCHeMaiInfoViewController * hemaiinfo = [[GCHeMaiInfoViewController alloc] init];
    hemaiinfo.title = titleStr;
    hemaiinfo.lotteryType = lotype;
    hemaiinfo.lotteryId = loid;
    hemaiinfo.paixustr = @"DD";
    
    
    GCHeMaiInfoViewController * hemaiinfotwo = [[GCHeMaiInfoViewController alloc] init];
    hemaiinfotwo.title = titleStr;
    hemaiinfotwo.lotteryType = lotype;
    hemaiinfotwo.lotteryId = loid;
    hemaiinfotwo.paixustr = @"AD";
    
    GCHeMaiInfoViewController * hongren = [[GCHeMaiInfoViewController alloc] init];
    hongren.title = titleStr;
    hongren.lotteryType = lotype;
    hongren.lotteryId = loid;
    hongren.paixustr = @"HR";
    
    
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:hemaiinfo, hemaiinfotwo,hongren, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"最新"];
    [labearr addObject:@"人气"];
    [labearr addObject:@"红人榜"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"ggzx.png"];
    [imagestring addObject:@"ggrq.png"];
    [imagestring addObject:@"gghrb.png"];
    
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"ggzx_1.png"];
    [imageg addObject:@"ggrq_1.png"];
    [imageg addObject:@"gghrb_1.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    CP_TabBarViewController *tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    tabc.selectedIndex = indexd;
    // tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    [self.navigationController pushViewController:tabc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [tabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [hemaiinfo release];
    [hemaiinfotwo release];
    [hongren release];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if ( event.subtype == UIEventSubtypeMotionShake )
    {
        [MobClick event:@"event_goucai_yaoyiyao_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];

        [self randBalls];
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }
	[super motionEnded:motion withEvent:event];
}

- (void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doLogin {
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
    [loginVC release];
#endif
}
- (void)hasLogin {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan.png") forState:UIControlStateNormal];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan_1.png") forState:UIControlStateHighlighted];

    btn.frame = CGRectMake(0, 0, 60, 44);
    [btn addTarget:self action:@selector(pressMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

- (void)dealloc{
    self.myissueRecord = nil;
    [self.jiangChiRequest clearDelegatesAndCancel];
    self.jiangChiRequest = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [myRequest clearDelegatesAndCancel];
    [myRequest release];
    [infoViewController release];
    [self.qihaoReQuest clearDelegatesAndCancel];
    self.qihaoReQuest = nil;
    self.wangQi = nil;
    [super dealloc];
    NSLog(@"dealloc");
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)reqWangQiKaiJiang:(ASIHTTPRequest*)request {
	if ([request responseData]) {
		WangqiKaJiangList *wang = [[WangqiKaJiangList alloc] initWithResponseData:[request responseData] WithRequest:request];
        
        NSMutableArray * historyArr = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
        [historyArr addObject:@[@"期号",@"开奖号"]];
        for (int i = 0; i < 5; i++) {
            NSMutableArray * dataArray = [[NSMutableArray alloc] initWithCapacity:10];
            KaiJiangInfo * info = [wang.brInforArray objectAtIndex:i];
            
            [dataArray addObject:[NSString stringWithFormat:@"%@期",[SharedMethod getLastThreeStr:info.issue]]];
            
            NSArray * aaa = [[info.num stringByReplacingOccurrencesOfString:@"," withString:@" "] componentsSeparatedByString:@"+"];
            //            [dataArray addObject:[info.num stringByReplacingOccurrencesOfString:@"," withString:@" "]];
            if ([aaa count] == 0) {
                aaa = [NSArray arrayWithObjects:@"", nil];
            }
            [dataArray addObject:[aaa objectAtIndex:0]];
//            [dataArray addObject:[NSString stringWithFormat:@"+%@",[aaa objectAtIndex:1]]];
            
            
            [historyArr addObject:dataArray];
            
            [dataArray release];
        }
        [self addHistoryWithArray:historyArr];
        
//		self.wangQi = wang;
//        [_cpTableView reloadData];
        [wang release];
	}
}


- (void)reqLotteryInfoFinished:(ASIHTTPRequest*)request {
	if ([request responseData]) {
		
		IssueRecord *issrecord = [[IssueRecord alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (issrecord.returnId == 3000) {
            [issrecord release];
            return;
        }
        self.myissueRecord = issrecord;
//        self.CP_navigation.title = [NSString stringWithFormat:@"%@%@期", issrecord.lotteryName,issrecord.curIssue];
        self.CP_navigation.title = [NSString stringWithFormat:@"%@%@期", issrecord.lotteryName,[SharedMethod getLastThreeStr:issrecord.curIssue]];
        NSLog(@"content==%@",self.myissueRecord.content);
        if ([self.myissueRecord.content length]) {
//            jiangchiLable.text = [NSString stringWithFormat:@"%@>元",[self.myissueRecord.content stringByReplacingOccurrencesOfString:@":" withString:@":<"]];
        }
        NSArray *array = [self.myissueRecord.lastLotteryNumber componentsSeparatedByString:@"#"];
        if ([array count] > 1) {
            sqkaijiang.text = [NSString stringWithFormat:@"上期开奖 <%@>",[[array objectAtIndex:1] stringByReplacingOccurrencesOfString:@"," withString:@" "]];
        }
        else {
            sqkaijiang.text = [NSString stringWithFormat:@"上期开奖 <%@>",[self.myissueRecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"," withString:@" "]];
        }
        if ([array count] >= 1) {
            float a = [self.myissueRecord.curIssue floatValue] - [[array objectAtIndex:0] floatValue];
            if (a > 1 && a < 100) {
                NSString *key = nil;
                
                if (qixingorpaiwu == shuZiCaiPaiWu) {
                    key = @"paiwujieqi";
                }
                else {
                    key = @"qingxingjieqi";
                }
                if (![[[NSUserDefaults standardUserDefaults] valueForKey:key] isEqualToString:self.myissueRecord.curIssue]) {
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"为了保证您购彩成功，网络购彩会比官方截期时间早，今日开奖期次销售已截止，您将购买%@期，祝您中奖！",[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                    [[NSUserDefaults standardUserDefaults] setValue:self.myissueRecord.curIssue forKey:key];
                }
                else {

                    [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"为了保证您购彩成功，网络购彩会比官方截期时间早，今日开奖期次销售已截止，您将购买%@期，祝您中奖！",[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]]];
                }
            }
        }
        [issrecord release];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _cpTableView) {
        UIView *v = [[[UIView alloc] init] autorelease];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
        label1.text = @"期号";
        label1.font = [UIFont boldSystemFontOfSize:14];
        label1.textColor = [UIColor whiteColor];
        label1.backgroundColor = [UIColor clearColor];
        label1.textAlignment = NSTextAlignmentCenter;
        [v addSubview:label1];
        [label1 release];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 180, 20)];
        label2.text = @"历史开奖";
        label2.textColor = [UIColor whiteColor];
        label2.font = [UIFont boldSystemFontOfSize:14];
        label2.backgroundColor = [UIColor clearColor];
        label2.textAlignment = NSTextAlignmentCenter;
        [v addSubview:label2];
        [label2 release];
        v.backgroundColor = [UIColor colorWithRed:33/255.0 green:100/255.0 blue:151/255.0 alpha:1.0];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(80, 0 , 1, 35)];
        [v addSubview:line];
        line.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
        [line release];
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 34 , 260, 1)];
        [v addSubview:line2];
        line2.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
        [line2 release];
        return v;
    }
    return nil;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _cpTableView) {
        return 35;
    }
    return 0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.wangQi.brInforArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _cpTableView) {
        static NSString *CellIdentifier = @"Cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
            label1.font = [UIFont systemFontOfSize:13];
            label1.backgroundColor = [UIColor colorWithRed:33/255.0 green:100/255.0 blue:151/255.0 alpha:1.0];
            label1.tag = 101;
            label1.textAlignment = NSTextAlignmentCenter;
            label1.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:label1];
            [label1 release];
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 180, 35)];
            label2.font = [UIFont systemFontOfSize:13];
            label2.textColor = [UIColor whiteColor];
            label2.tag = 102;
            label2.backgroundColor = [UIColor colorWithRed:67/255.0 green:144/255.0 blue:186/255.0 alpha:1.0];
            [cell.contentView addSubview:label2];
            label2.textAlignment = NSTextAlignmentCenter;
            [label2 release];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(80, 0 , 1, 35)];
            [cell.contentView addSubview:line];
            line.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
            [line release];
            
            UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , 260, 1)];
            [cell.contentView addSubview:line2];
            line2.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
            [line2 release];
            cell.contentView.backgroundColor = [UIColor clearColor];
            
        }
        
        UILabel *l1 = (UILabel *)[cell.contentView viewWithTag:101];
        UILabel *l2 = (UILabel *)[cell.contentView viewWithTag:102];
        KaiJiangInfo *info = [self.wangQi.brInforArray objectAtIndex:indexPath.row];
        l1.text = info.issue;
        l2.text = info.num;
        return  cell;
        
    }
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 33)];
        label1.font = [UIFont systemFontOfSize:13];
        label1.backgroundColor = [UIColor clearColor];
        label1.tag = 101;
        [cell.contentView addSubview:label1];
        [label1 release];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, 100, 33)];
        label2.font = [UIFont systemFontOfSize:13];
        label2.textColor = [UIColor redColor];
        label2.tag = 102;
        label2.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:label2];
        label2.textAlignment = NSTextAlignmentCenter;
        [label2 release];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(1, 33, 254, 2)];
        imageV.image = UIImageGetImageFromName(@"SZTG960.png");
        [cell.contentView addSubview:imageV];
        cell.backgroundColor = [UIColor clearColor];
        [imageV release];
        
	}
    UILabel *l1 = (UILabel *)[cell.contentView viewWithTag:101];
    UILabel *l2 = (UILabel *)[cell.contentView viewWithTag:102];
    KaiJiangInfo *info = [self.wangQi.brInforArray objectAtIndex:indexPath.row];
    l1.text = info.issue;
    l2.text = info.num;
    return  cell;
}
-(void)animationCompleted:(GifButton *)gifButton
{
    [self ballSelectChange:nil];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    