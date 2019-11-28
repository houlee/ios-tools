//
//  DaLeTouViewController.m
//  caibo
//
//  Created by 姚福玉 on 12-7-12.
//  Copyright (c) 2012年 第一视频. All rights reserved.
//

#import "DaLeTouViewController.h"
#import "ShakeView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Info.h"
#import "GC_LotteryUtil.h"
#import "caiboAppDelegate.h"
#import "Xieyi365ViewController.h"
#import "LoginViewController.h"
#import "GC_HttpService.h"
#import "LotteryListViewController.h"
#import "GCHeMaiInfoViewController.h"
#import "MobClick.h"
#import "NetURL.h"
#import "JSON.h"
#import "YiLouUnderGCBallView.h"
#import "YiLouChartData.h"
#import "ChartTitleScrollView.h"
#import "ChartYiLouScrollView.h"
#import "ChartDefine.h"
#import "SharedMethod.h"

#define LOTTERY_ID @"113"

@implementation DaLeTouViewController

@synthesize myissueRecord;
@synthesize isHemai;
@synthesize myRequest;
@synthesize daleTouType;
@synthesize jiangchi;
@synthesize myHttpRequest;
@synthesize wangQi;
@synthesize qihaoReQuest;
@synthesize yiLouRequest;
@synthesize yiLouDataArray;
@synthesize allYiLouRequest;

- (void)headButtonFunc{
    if (headbgImage) {
        return;
    }
    headbgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, DEFAULT_TOPVIEW_HEIGHT_SHUANG)];
    headbgImage.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    headbgImage.userInteractionEnabled = YES;
//    headbgImage.image = [UIImageGetImageFromName(@"yiloudaohang.png") stretchableImageWithLeftCapWidth:8 topCapHeight:22];
    [headYiLouView addSubview:headbgImage];
    [headbgImage release];
    
    UIButton * redButton = [UIButton buttonWithType:UIButtonTypeCustom];//70*3  320- 210 110
    redButton.frame = CGRectMake(0, 0, 107, DEFAULT_TOPVIEW_HEIGHT_SHUANG);
    redButton.tag = 1;
    redButton.backgroundColor = [UIColor clearColor];
    [redButton addTarget:self action:@selector(pressRedButton:) forControlEvents:UIControlEventTouchUpInside];
    [headbgImage addSubview:redButton];
    
    UIImageView * redImage = [[UIImageView alloc] initWithFrame:CGRectMake(27, (redButton.frame.size.height - 21)/2, 20, 20)];
    redImage.backgroundColor = [UIColor clearColor];
    redImage.tag = 10;
    redImage.image = UIImageGetImageFromName(@"redssqImage_1.png");
    [redButton addSubview:redImage];
    [redImage release];
    
    UILabel * redLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(redImage) + 5, 0, 40, redButton.frame.size.height)];
    redLabel.backgroundColor = [UIColor  clearColor];
    redLabel.font = [UIFont systemFontOfSize:15];
    redLabel.textColor = DEFAULT_TOPVIEW_TEXT_COLOR_1;
    redLabel.text = @"前区";
    redLabel.tag = 100;
    [redButton addSubview:redLabel];
    [redLabel release];
    
    
    UIButton * blueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    blueButton.frame = CGRectMake(ORIGIN_X(redButton), 0, 107, DEFAULT_TOPVIEW_HEIGHT_SHUANG);
    blueButton.tag = 2;
    [blueButton addTarget:self action:@selector(pressRedButton:) forControlEvents:UIControlEventTouchUpInside];
    blueButton.backgroundColor = [UIColor clearColor];
    [headbgImage addSubview:blueButton];
    
    UIImageView * blueImage = [[UIImageView alloc] initWithFrame:CGRectMake(27, (blueButton.frame.size.height - 21)/2, 20, 20)];
    blueImage.backgroundColor = [UIColor clearColor];
    blueImage.tag = 10;
    blueImage.image = UIImageGetImageFromName(@"bluessqimage.png");
    [blueButton addSubview:blueImage];
    [blueImage release];
    
    UILabel * blueLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(blueImage) + 5, 0, 40, blueButton.frame.size.height)];
    blueLabel.backgroundColor = [UIColor  clearColor];
    blueLabel.font = [UIFont systemFontOfSize:15];
    blueLabel.textColor = DEFAULT_TOPVIEW_TEXT_COLOR;
    blueLabel.text = @"后区";
    blueLabel.tag = 101;
    [blueButton addSubview:blueLabel];
    [blueLabel release];
    
    UIButton * dataButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dataButton.frame = CGRectMake(ORIGIN_X(blueButton), 0, 106, DEFAULT_TOPVIEW_HEIGHT_SHUANG);
    [dataButton addTarget:self action:@selector(pressRedButton:) forControlEvents:UIControlEventTouchUpInside];
    dataButton.tag = 3;
    dataButton.backgroundColor = [UIColor clearColor];
    [headbgImage addSubview:dataButton];
    
    UIImageView * dataImage = [[UIImageView alloc] initWithFrame:CGRectMake(27, (dataButton.frame.size.height - 21)/2, 20, 20)];
    dataImage.backgroundColor = [UIColor clearColor];
    dataImage.tag = 10;
    dataImage.image = UIImageGetImageFromName(@"datassqimage.png");
    [dataButton addSubview:dataImage];
    [dataImage release];
    
    UILabel * dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(dataImage) + 5, 0, 40, dataButton.frame.size.height)];
    dataLabel.backgroundColor = [UIColor  clearColor];
    dataLabel.font = [UIFont systemFontOfSize:15];
    dataLabel.textColor = DEFAULT_TOPVIEW_TEXT_COLOR;
    dataLabel.text = @"数据";
    dataLabel.tag = 102;
    [dataButton addSubview:dataLabel];
    [dataLabel release];
//    
//    UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(redButton.frame.origin.x, 41, 76, 3)];
//    lineImage.backgroundColor = [UIColor colorWithRed:7/255.0 green:174/255.0 blue:222/255.0 alpha:1];
//    lineImage.tag = 111;
//    [headbgImage addSubview:lineImage];
//    [lineImage release];
    
    
}

- (void)pressRedButton:(UIButton *)sender{
    
    UIButton * showButton1 = (UIButton *)[headbgImage viewWithTag:1];
    UIButton * showButton2 = (UIButton *)[headbgImage viewWithTag:2];
    UIButton * showButton3 = (UIButton *)[headbgImage viewWithTag:3];
    
    UIImageView * showImage1 = (UIImageView *)[showButton1 viewWithTag:10];
    UIImageView * showImage2 = (UIImageView *)[showButton2 viewWithTag:10];
    UIImageView * showImage3 = (UIImageView *)[showButton3 viewWithTag:10];
    
    UILabel * showLabel = (UILabel *)[showButton1 viewWithTag:100];
    UILabel * showLabel1 = (UILabel *)[showButton2 viewWithTag:101];
    UILabel * showLabel2 = (UILabel *)[showButton3 viewWithTag:102];
    
    if (sender.tag == 1) {
        
        showImage1.image = UIImageGetImageFromName(@"redssqImage_1.png");
        showImage2.image = UIImageGetImageFromName(@"bluessqimage.png");
        showImage3.image = UIImageGetImageFromName(@"datassqimage.png");
        titleYiLou1.hidden = NO;
        titleYiLou2.hidden = YES;
        titleYiLou3.hidden = YES;
        redraw1.hidden = NO;
        redraw2.hidden = YES;
        redraw3.hidden = YES;
        
        showLabel.textColor = DEFAULT_TOPVIEW_TEXT_COLOR_1;
        showLabel1.textColor = DEFAULT_TOPVIEW_TEXT_COLOR;
        showLabel2.textColor = DEFAULT_TOPVIEW_TEXT_COLOR;
        
    }else if (sender.tag == 2){
        
        showImage1.image = UIImageGetImageFromName(@"redssqImage.png");
        showImage2.image = UIImageGetImageFromName(@"bluessqimage_1.png");
        showImage3.image = UIImageGetImageFromName(@"datassqimage.png");
        
        titleYiLou1.hidden = YES;
        titleYiLou2.hidden = NO;
        titleYiLou3.hidden = YES;
        redraw1.hidden = YES;
        redraw2.hidden = NO;
        redraw3.hidden = YES;
        
        showLabel.textColor = DEFAULT_TOPVIEW_TEXT_COLOR;
        showLabel1.textColor = DEFAULT_TOPVIEW_TEXT_COLOR_1;
        showLabel2.textColor = DEFAULT_TOPVIEW_TEXT_COLOR;
        
    }else if (sender.tag == 3){
        
        showImage1.image = UIImageGetImageFromName(@"redssqImage.png");
        showImage2.image = UIImageGetImageFromName(@"bluessqimage.png");
        showImage3.image = UIImageGetImageFromName(@"datassqimage_1.png");
        titleYiLou1.hidden = YES;
        titleYiLou2.hidden = YES;
        titleYiLou3.hidden = NO;
        redraw1.hidden = YES;
        redraw2.hidden = YES;
        redraw3.hidden = NO;
        
        showLabel.textColor = DEFAULT_TOPVIEW_TEXT_COLOR;
        showLabel1.textColor = DEFAULT_TOPVIEW_TEXT_COLOR;
        showLabel2.textColor = DEFAULT_TOPVIEW_TEXT_COLOR_1;
    }
    
//    UIImageView * lineImage = (UIImageView *)[headbgImage viewWithTag:111];
//    [UIView beginAnimations:nil context:nil];
//	[UIView setAnimationDuration:0.2];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    lineImage.frame = CGRectMake(sender.frame.origin.x, lineImage.frame.origin.y, lineImage.frame.size.width, lineImage.frame.size.height);
//    [UIView commitAnimations];
    
    
    
}

- (void)renXuanYiLouFunc:(NSMutableArray *)allArray {
    
    
    
    [self headButtonFunc];
    
    
    ChartFormatData * chartFormatData1 = [[ChartFormatData alloc] initWithAllArray:yiLouDataArray lottoryType:LeTouQian];
    chartFormatData1.numberOfLines = 35;
    chartFormatData1.linesWidth = 23.5;
    chartFormatData1.drawType = TwoColorCircle;
    
    CGRect redrawFrame1 = CGRectMake(0, headbgImage.frame.size.height, 320, headYiLouView.frame.size.height);
    CGRect redrawFrame = CGRectMake(0, 0, 320, yiLouView.frame.size.height);
    if (!titleYiLou1) {
        titleYiLou1 = [[UITitleYiLouView alloc] initWithFrame:redrawFrame1 chartFormatData:chartFormatData1];
        titleYiLou1.hidden = NO;
        titleYiLou1.delegate = self;
        [headYiLouView addSubview:titleYiLou1];
        [titleYiLou1 release];
        
        redraw1 = [[redrawView alloc] initWithFrame:redrawFrame chartFormatData:chartFormatData1]; //基本
        redraw1.hidden = NO;
        redraw1.delegate =self;
        [yiLouView addSubview:redraw1];
        [redraw1 release];
    }
    
    
    [chartFormatData1 release];
    
    ChartFormatData * chartFormatData2 = [[ChartFormatData alloc] initWithAllArray:yiLouDataArray lottoryType:LeTouHou];
    
    chartFormatData2.numberOfLines = 12;
    chartFormatData2.drawType = BlueCircle;
//    chartFormatData2.lineColor = BlueLine;
    if (!titleYiLou2) {
        titleYiLou2 = [[UITitleYiLouView alloc] initWithFrame:redrawFrame1 chartFormatData:chartFormatData2];
        titleYiLou2.hidden = YES;
        titleYiLou2.delegate = self;
        [headYiLouView addSubview:titleYiLou2];
        [titleYiLou2 release];
        
        redraw2 = [[redrawView alloc] initWithFrame:redrawFrame chartFormatData:chartFormatData2]; //基本
        redraw2.hidden = YES;
        redraw2.delegate = self;
        [yiLouView addSubview:redraw2];
        [redraw2 release];
    }
        
   
    
    [chartFormatData2 release];
    
    
    ChartFormatData * chartFormatData3 = [[ChartFormatData alloc] initWithAllArray:yiLouDataArray lottoryType:LeTouData];
    
    chartFormatData3.displayYiLou = All;
    chartFormatData3.rightTitleArray = @[@"前区",@"后区"];
    chartFormatData3.rightTitleProportion = @"4:2";
    chartFormatData3.titleHeight = 18.5;
    chartFormatData3.linesTitleArray = [NSArray arrayWithObjects:@"和值", @"尾和",@"大小比",@"奇偶比",@"和值", @"尾和", nil];
    if (!titleYiLou3) {
        titleYiLou3 = [[UITitleYiLouView alloc] initWithFrame:redrawFrame1 chartFormatData:chartFormatData3];
        titleYiLou3.hidden = YES;
        [headYiLouView addSubview:titleYiLou3];
        [titleYiLou3 release];
        
        redraw3 = [[redrawView alloc] initWithFrame:redrawFrame chartFormatData:chartFormatData3]; //基本
        redraw3.hidden = YES;
        [yiLouView addSubview:redraw3];
        [redraw3 release];
        
    }
    [chartFormatData3 release];

}

- (void)allView:(NSMutableArray *)chartDataArray{
    if (yiLouView) {
        
        [self renXuanYiLouFunc:chartDataArray];
        
    }
    
    
}


- (void)requestShuangSeQiuYiLou{
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [allYiLouRequest clearDelegatesAndCancel];
    self.allYiLouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:LOTTERY_ID itemNum:YiLOU_COUNT issue:nil]];
    [allYiLouRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [allYiLouRequest setDelegate:self];
    [allYiLouRequest setDidFinishSelector:@selector(allYiLouRequestFinish:)];
    [allYiLouRequest setDidFailSelector:@selector(allYiLouRequestFail:)];
    [allYiLouRequest startAsynchronous];
    
    
}
- (void)allYiLouRequestFail:(ASIHTTPRequest *)marequest{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    self.showYiLou = NO;
}

- (void)allYiLouRequestFinish:(ASIHTTPRequest *)mrequest{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
    NSString *responseStr = [mrequest responseString];
    NSLog(@"resp = %@", responseStr);
    
    
    //	NSString *responseStr = [mrequest responseString];
    if (responseStr&&![responseStr isEqualToString:@"fail"]) {
        
        NSDictionary * alldict = [responseStr JSONValue];
        
        NSArray * array = [alldict objectForKey:@"list"];
        NSMutableArray * chartDataArray = [[[NSMutableArray alloc] init] autorelease];
        for (int i = (int)array.count - 1; i >= 0; i--) {
            YiLouChartData * chartData = [[YiLouChartData alloc] initWithDictionary:[array objectAtIndex:i]];
            
            NSDictionary * dict = [array objectAtIndex:i];
            
            if ([dict objectForKey:@"periodNumber"]) {
                chartData.issueNumber = [[dict objectForKey:@"periodNumber"] substringWithRange:NSMakeRange([[dict objectForKey:@"periodNumber"] length]-3, 3)];
                
            }
            
            chartData.lotteryNumber = [dict objectForKey:@"result"];
            
            [chartDataArray addObject:chartData];
            [chartData release];
            
        }
        if ([array count] == 0){
            self.showYiLou = NO;
        }else{
            self.yiLouDataArray = chartDataArray;
            [self allView:chartDataArray];
        }
       
    }else{
        self.showYiLou = NO;
    }
    
}


- (void)yiLouFunc{
    
    if (daleTouType == DaleTouTypeDantuo) {
        if (backScrollView.contentSize.height > self.view.frame.size.height - 44 - isIOS7Pianyi) {
            backScrollView.frame = CGRectMake(backScrollView.frame.origin.x, backScrollView.frame.origin.y, backScrollView.frame.size.width, backScrollView.contentSize.height + 10);
            _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, backScrollView.frame.size.height);
        }else{
            _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, self.view.frame.size.height - 44 - isIOS7Pianyi);
        }

    }else{
        if (normalScrollView.contentSize.height > self.view.frame.size.height - 44 - isIOS7Pianyi) {
            normalScrollView.frame = CGRectMake(normalScrollView.frame.origin.x, normalScrollView.frame.origin.y, normalScrollView.frame.size.width, normalScrollView.contentSize.height + 10);
            _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, normalScrollView.frame.size.height);
        }else{
            _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, self.view.frame.size.height - 44 - isIOS7Pianyi);
        }
    }
    cpLowermostScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(_mainView) + 44 + isIOS7Pianyi);

//    _cpbackScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(_mainView) + 44 + isIOS7Pianyi);
//    UIImageView * imagebar = (UIImageView *)[self.view viewWithTag:1201];
//    imagebar.frame = CGRectMake(0, imagebar.frame.origin.y, imagebar.frame.size.width,imagebar.frame.size.height);
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isHemai = NO;
        daleTouType = DaleTouTypePuTong;
        redNum = [[[NSUserDefaults standardUserDefaults] valueForKey:@"DaLeTouJiXuanSetRedNumber"] integerValue];
        blueNum = [[[NSUserDefaults standardUserDefaults] valueForKey:@"DaLeTouJiXuanSetBlueNumber"] integerValue];
        if(!redNum)
            redNum = 5;
        if(!blueNum)
            blueNum = 2;
        wanArray = [[NSArray alloc] initWithObjects:@"普通投注",@"胆拖投注",nil];
//        isBackScrollView = YES;
        isVerticalBackScrollView = YES;
        self.cpLotteryName = daleTouType;
        
        self.headHight = DEFAULT_TOPVIEW_HEIGHT_SHUANG + DEFAULT_ISSUE_HEIGHT + 1;
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark-
#pragma Action 

- (void)changeTitle {

    //title
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 270, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.userInteractionEnabled = YES;
#ifdef isCaiPiaoForIPad
    titleView.frame = CGRectMake(50 + 35, 0, 270, 44);
#endif
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    if (self.myissueRecord) {
        titleLabel.text = [NSString stringWithFormat:@"%@%@期",[wanArray objectAtIndex:daleTouType],[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]];
    }
    else {
        titleLabel.text =[NSString stringWithFormat:@"大乐透%@",[wanArray objectAtIndex:daleTouType]];
    }
    
    titleLabel.textColor = [UIColor whiteColor];    
//    UILabel *JTLabel = [[UILabel alloc] init];
//    JTLabel.backgroundColor = [UIColor clearColor];
//    JTLabel.textAlignment = NSTextAlignmentCenter;
//    JTLabel.font = [UIFont systemFontOfSize:12];
//    JTLabel.text = @"▼";
//    JTLabel.textColor = [UIColor whiteColor];
//    JTLabel.shadowColor = [UIColor blackColor];
//    JTLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    
    sanjiaoImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]] autorelease];
    sanjiaoImageView.tag = 567;
    [titleView addSubview:sanjiaoImageView];
    titleLabel.frame = CGRectMake(45, 0, 220, 44);
    sanjiaoImageView.frame = CGRectMake(160, 14, 17, 17);
    [titleView addSubview:sanjiaoImageView];
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(0, 0, 270, 44);
    titleButton.backgroundColor = [UIColor clearColor];
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleButton addTarget:self action:@selector(pressTitleButton1:) forControlEvents:UIControlEventTouchDown];
    [titleButton addTarget:self action:@selector(pressTitleButton2:) forControlEvents:UIControlEventTouchCancel];

    [titleButton addSubview:titleLabel];
    [titleView addSubview:titleButton];
    self.CP_navigation.titleView = titleView;
    [titleLabel release];
    [titleView release];

    [self yiLouFunc];
}

//历史开奖
- (void)toHistory
{
    [MobClick event:@"event_goucai_chakangengduo_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
    [MobClick event:@"event_goucai_lishikaijiang_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
    LotteryListViewController *controller = [[LotteryListViewController alloc] init];
    controller.lotteryId = LOTTERY_ID;
    controller.lotteryName = @"超级大乐透";
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}
- (void)pressTitleButton1:(UIButton *)sender{

    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.4];
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao_selected.png");
}
- (void)pressTitleButton2:(UIButton *)sender{
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao.png");
}
- (void)pressTitleButton:(UIButton *)sender{
    
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    sanjiaoImageView.image = UIImageGetImageFromName(@"SanJiao.png");
    if(titleBtnIsCanPress)
    {
        if ([infoViewController.dataArray count] != 0) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"不支持多玩法同时投注" message:@"您需要删除已选号码才可切换" delegate:self cancelButtonTitle:@"删除已选" otherButtonTitles:@"知道了",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 1109;
            [alert show];
            [alert release];
            return;
        }
        if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"不支持多玩法同时投注" message:@"您需要删除已选号码才可切换" delegate:self cancelButtonTitle:@"删除已选" otherButtonTitles:@"知道了",nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.tag = 1109;
            [alert show];
            [alert release];
            return;
        }
        titleBtnIsCanPress = NO;
        if(!isShowing)
        {
            UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
            [SharedMethod sanJiaoKai:sanjiao];
            
            alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"玩法选择" ShuziNameArray:wanArray shuziArray:nil];
            
            alert2.duoXuanBool = NO;
            alert2.tag = 101;
            alert2.delegate = self;
            isShowing = YES;
            alert2.isClearBtnCanPress = NO;
            [alert2 show];
            [self.view addSubview:self.CP_navigation];
            self.CP_navigation.frame = CGRectMake(0, 20, 320, 44);
            [self.CP_navigation.window addSubview:alert2];
            [self.CP_navigation.window addSubview:self.CP_navigation];
            

            for (CP_XZButton *btn in alert2.backScrollView.subviews) {
                if ([btn isKindOfClass:[UIButton class]] && btn.tag == daleTouType) {
                    btn.selected = YES;
                    btn.buttonName.textColor = [UIColor whiteColor];
                }
            }
        }
        else
        {
            UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
            [SharedMethod sanJiaoGuan:sanjiao];
            
            [alert2 disMissWithPressOtherFrame];
        }
    }

}

- (void)createBackScrollView {
    if (!backScrollView) {
        backScrollView  = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
        [self.mainView insertSubview:backScrollView atIndex:3];
#ifdef isCaiPiaoForIPad
        backScrollView.frame = CGRectMake(35, 0, self.mainView.bounds.size.width - 70, self.mainView.bounds.size.height);
#endif
        [backScrollView release];
        backScrollView.hidden = YES;
        
        UIView * lastView;
        if (backScrollView) {
            
            UIView * topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, TOPVIEW_HEIGHT)] autorelease];
            topView.backgroundColor = [UIColor whiteColor];
            [backScrollView addSubview:topView];
            
            UIView * topShadowView = [[[UIView alloc] initWithFrame:CGRectMake(0, topView.frame.size.height, 320, 0.5)] autorelease];
            topShadowView.backgroundColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
            [topView addSubview:topShadowView];
            
            //上期开奖
            UILabel *sqkaijiang = [[UILabel alloc] init];
            sqkaijiang.backgroundColor = [UIColor clearColor];
            sqkaijiang.font = [UIFont systemFontOfSize:14];
            sqkaijiang.text = @"上期开奖";
            CGSize sqKaiJiangSize = [sqkaijiang.text sizeWithFont:sqkaijiang.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];
            sqkaijiang.frame = CGRectMake(14, 0, sqKaiJiangSize.width, topView.frame.size.height);
            sqkaijiang.textColor = [UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
            [topView addSubview:sqkaijiang];
            [sqkaijiang release];
            
            ColorView *sqkaijiang2 = [[ColorView alloc] initWithFrame:CGRectMake(ORIGIN_X(sqkaijiang) + 12, 9.5, 200, 17)];
            sqkaijiang2.tag = 1101;
            sqkaijiang2.textAlignment = NSTextAlignmentLeft;
            sqkaijiang2.backgroundColor = [UIColor clearColor];
            sqkaijiang2.font = [UIFont systemFontOfSize:14];
            sqkaijiang2.changeColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
            sqkaijiang2.textColor = [UIColor colorWithRed:255/255.0 green:36/255.0 blue:36/255.0 alpha:1];
            if (self.myissueRecord) {
                sqkaijiang2.text = [NSString stringWithFormat:@"%@>",[[self.myissueRecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"+" withString:@" <"] stringByReplacingOccurrencesOfString:@"," withString:@" "]];
                if ([sqkaijiang2.text componentsSeparatedByString:@"#"].count > 1) {
                    sqkaijiang2.text = [[sqkaijiang2.text componentsSeparatedByString:@"#"] objectAtIndex:1];
                }
            }
            [backScrollView addSubview:sqkaijiang2];
            [sqkaijiang2 release];
            
            //红球背景
            UIImageView *backImageV2 = [[UIImageView alloc] init];
            if (SWITCH_ON) {
                backImageV2.frame = CGRectMake(0, ORIGIN_Y(topView) + 18, 320, 390);
            }else{
                backImageV2.frame = CGRectMake(0, ORIGIN_Y(topView) + 18, 320, 310);
            }
            backImageV2.tag = 800;
            backImageV2.userInteractionEnabled = YES;
            [backScrollView addSubview:backImageV2];
            backImageV2.backgroundColor = [UIColor clearColor];
            [backImageV2 release];
            
            UIImageView * redTitleImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 21.5)] autorelease];
            redTitleImageView.image = UIImageGetImageFromName(@"LeftTitleRed.png");
            [backImageV2 addSubview:redTitleImageView];
            
            UILabel * redTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, redTitleImageView.frame.size.width - 10, redTitleImageView.frame.size.height)] autorelease];
            redTitleLabel.backgroundColor = [UIColor clearColor];
            redTitleLabel.font = [UIFont systemFontOfSize:14];
            redTitleLabel.textColor = [UIColor whiteColor];
            [redTitleImageView addSubview:redTitleLabel];
            redTitleLabel.text = @"前区胆码";
            
            UILabel * redDescLabel = [[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(redTitleImageView) + 10, redTitleImageView.frame.origin.y, 250, redTitleImageView.frame.size.height)] autorelease];
            redDescLabel.backgroundColor = [UIColor clearColor];
            redDescLabel.font = [UIFont systemFontOfSize:12];
            redDescLabel.textColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
            [backImageV2 addSubview:redDescLabel];
            redDescLabel.text = @"我认为必出的号，最多4个";
            
            UIImageView * louImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(redTitleImageView) + 14 + 36 + 1.5, 18, 14)] autorelease];
            louImageView.image = UIImageGetImageFromName(@"LeftTitleYilou.png");
            louImageView.tag = 111;
            [backImageV2 addSubview:louImageView];
            if (!SWITCH_ON) {
                louImageView.hidden = YES;
            }
            
            UILabel * louLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, louImageView.frame.size.width, louImageView.frame.size.height)] autorelease];
            louLabel.backgroundColor = [UIColor clearColor];
            louLabel.font = [UIFont systemFontOfSize:11];
            louLabel.textAlignment = 1;
            louLabel.tag =
            louLabel.textColor = [UIColor whiteColor];
            [louImageView addSubview:louLabel];
            louLabel.text = @"漏";
            
            CGRect ballRect;
            GCBallView * lastRedBallView;

            UIView *redView = [[UIView alloc] init];
            redView.tag = 2010;
            redView.backgroundColor = [UIColor clearColor];
            redView.frame = CGRectMake(0, ORIGIN_Y(redTitleImageView) + 14, backImageV2.frame.size.width, backImageV2.frame.size.height - (ORIGIN_Y(redTitleImageView) + 14));
            redView.userInteractionEnabled = YES;

            for (int i = 0; i<35; i++) {
                int a= i/6,b = i%6;
                NSString *num = [NSString stringWithFormat:@"%d",i+1];
                if (i+1<10) {
                    num = [NSString stringWithFormat:@"0%d",i+1];
                }
                
                if (SWITCH_ON) {
                    ballRect = CGRectMake(b*51 + 15, a*61, 36, 36);
                }else{
                    ballRect = CGRectMake(b*51 + 15, a*47, 36, 36);
                }
                GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorRed];
                [redView addSubview:im];
                im.tag = i;
                im.gcballDelegate = self;
                if (!SWITCH_ON) {
                    im.ylLable.hidden = YES;
                }
                lastRedBallView = im;
                [im release];
            }
            [backImageV2 addSubview:redView];
            [redView release];
            
            GifButton * redTrashButton = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(ORIGIN_X(lastRedBallView) + 15, lastRedBallView.frame.origin.y, 0, 0)] autorelease];
            redTrashButton.tag = 333;
            redTrashButton.delegate = self;
            [redView addSubview:redTrashButton];
            
            //红球背景2
            UIImageView *backImageV23 = [[UIImageView alloc] init];
            if (SWITCH_ON) {
                backImageV23.frame = CGRectMake(0, ORIGIN_Y(backImageV2) + 22, 320, 390);
            }else{
                backImageV23.frame = CGRectMake(0, ORIGIN_Y(backImageV2) + 22, 320, 310);
            }
            backImageV23.userInteractionEnabled = YES;
            backImageV23.tag = 801;
            backImageV23.backgroundColor = [UIColor clearColor];
            [backScrollView addSubview:backImageV23];
            [backImageV23 release];
            
            UIImageView * redTitleImageView1 = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 21.5)] autorelease];
            redTitleImageView1.image = UIImageGetImageFromName(@"LeftTitleRed.png");
            [backImageV23 addSubview:redTitleImageView1];
            
            UILabel * redTitleLabel1 = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, redTitleImageView1.frame.size.width - 10, redTitleImageView1.frame.size.height)] autorelease];
            redTitleLabel1.backgroundColor = [UIColor clearColor];
            redTitleLabel1.font = [UIFont systemFontOfSize:14];
            redTitleLabel1.textColor = [UIColor whiteColor];
            [redTitleImageView1 addSubview:redTitleLabel1];
            redTitleLabel1.text = @"前区拖码";
            
            UILabel * redDescLabel1 = [[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(redTitleImageView1) + 10, redTitleImageView1.frame.origin.y, 250, redTitleImageView1.frame.size.height)] autorelease];
            redDescLabel1.backgroundColor = [UIColor clearColor];
            redDescLabel1.font = [UIFont systemFontOfSize:12];
            redDescLabel1.textColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
            [backImageV23 addSubview:redDescLabel1];
            redDescLabel1.text = @"我认为可能出的号，至少2个,最多16个";
            
            UIView *red2View = [[UIView alloc] init];
            red2View.tag = 2011;
            red2View.backgroundColor = [UIColor clearColor];
            red2View.frame = CGRectMake(0, ORIGIN_Y(redTitleImageView1) + 14, backImageV23.frame.size.width, backImageV23.frame.size.height - (ORIGIN_Y(redTitleImageView1) + 14));
            red2View.userInteractionEnabled = YES;
            
            GCBallView * lastRedBallView1;

            for (int i = 0; i<35; i++) {
                int a= i/6,b = i%6;
                NSString *num = [NSString stringWithFormat:@"%d",i+1];
                if (i+1<10) {
                    num = [NSString stringWithFormat:@"0%d",i+1];
                }
                
                if (SWITCH_ON) {
                    ballRect = CGRectMake(b*51 + 15, a*61, 36, 36);
                }else{
                    ballRect = CGRectMake(b*51 + 15, a*47, 36, 36);
                }
                GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorRed];
                [red2View addSubview:im];
                im.tag = i;
                im.gcballDelegate = self;
                if (!SWITCH_ON) {
                    im.ylLable.hidden = YES;
                }
                [im release];
                lastRedBallView1 = im;
            }
            [backImageV23 addSubview:red2View];
            [red2View release];
            
            GifButton * redTrashButton1 = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(ORIGIN_X(lastRedBallView1) + 15, lastRedBallView1.frame.origin.y, 0, 0)] autorelease];
            redTrashButton1.tag = 333;
            redTrashButton1.delegate = self;
            [red2View addSubview:redTrashButton1];
            
            //蓝球背景
            UIImageView *backImageV21 = [[UIImageView alloc] init];
            if (SWITCH_ON) {
                backImageV21.frame = CGRectMake(0, ORIGIN_Y(backImageV23) + 22, 320, 210);
            }else{
                backImageV21.frame = CGRectMake(0, ORIGIN_Y(backImageV23) + 22, 320, 170);
            }
            backImageV21.userInteractionEnabled = YES;
            backImageV21.tag = 802;
            backImageV21.backgroundColor = [UIColor clearColor];
            [backScrollView addSubview:backImageV21];
            [backImageV21 release];
            
            UIImageView * blueTitleImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 21.5)] autorelease];
            blueTitleImageView.image = UIImageGetImageFromName(@"LeftTitleBlue.png");
            [backImageV21 addSubview:blueTitleImageView];
            
            UILabel * blueTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, blueTitleImageView.frame.size.width - 10, blueTitleImageView.frame.size.height)] autorelease];
            blueTitleLabel.backgroundColor = [UIColor clearColor];
            blueTitleLabel.font = [UIFont systemFontOfSize:14];
            blueTitleLabel.textColor = [UIColor whiteColor];
            [blueTitleImageView addSubview:blueTitleLabel];
            blueTitleLabel.text = @"后区胆码";
            
            UILabel * blueDescLabel = [[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(blueTitleImageView) + 10, blueTitleImageView.frame.origin.y, 200, blueTitleImageView.frame.size.height)] autorelease];
            blueDescLabel.backgroundColor = [UIColor clearColor];
            blueDescLabel.font = [UIFont systemFontOfSize:12];
            blueDescLabel.textColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
            [backImageV21 addSubview:blueDescLabel];
            blueDescLabel.text = @"我认为必出的号，最多1个";
            
            UIView *blueView = [[UIView alloc] init];
            blueView.tag = 2012;
            blueView.backgroundColor = [UIColor clearColor];
            blueView.frame = CGRectMake(0, ORIGIN_Y(blueTitleImageView) + 14, backImageV21.frame.size.width, backImageV21.frame.size.height - (ORIGIN_Y(blueTitleImageView) + 14));
            blueView.userInteractionEnabled = YES;
            
            GCBallView * lastBlueBallView;
            
            for (int i = 0; i<12; i++) {
                int a= i/6,b = i%6;
                NSString *num = [NSString stringWithFormat:@"%d",i+1];
                if (i+1<10) {
                    num = [NSString stringWithFormat:@"0%d",i+1];
                }
                
                if (SWITCH_ON) {
                    ballRect = CGRectMake(b*51 + 15, a*61, 36, 36);
                }else{
                    ballRect = CGRectMake(b*51 + 15, a*47, 36, 36);
                }
                GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorBlue];
                [blueView addSubview:im];
                im.tag = i;
                im.gcballDelegate = self;
                if (!SWITCH_ON) {
                    im.ylLable.hidden = YES;
                }
                if (a == 1 && b == 0) {
                    lastBlueBallView = im;
                }
                [im release];
            }
            [backImageV21 addSubview:blueView];
            [blueView release];
            
            GifButton * blueTrashButton = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(lastBlueBallView.frame.origin.x, ORIGIN_Y(lastBlueBallView) + ballRect.origin.y - 36, 0, 0)] autorelease];
            blueTrashButton.tag = 333;
            blueTrashButton.delegate = self;
            [blueView addSubview:blueTrashButton];
            
            //蓝球背景
            UIImageView *backImageV211 = [[UIImageView alloc] init];
            if (SWITCH_ON) {
                backImageV211.frame = CGRectMake(0, ORIGIN_Y(backImageV21) + 22, 320, 210);
            }else{
                backImageV211.frame = CGRectMake(0, ORIGIN_Y(backImageV21) + 22, 320, 170);
            }
            backImageV211.userInteractionEnabled = YES;
            lastView = backImageV211;
            backImageV211.tag = 803;
            backImageV211.backgroundColor = [UIColor clearColor];
            [backScrollView addSubview:backImageV211];
            [backImageV211 release];
            
            UIImageView * blueTitleImageView1 = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 21.5)] autorelease];
            blueTitleImageView1.image = UIImageGetImageFromName(@"LeftTitleBlue.png");
            [backImageV211 addSubview:blueTitleImageView1];
            
            UILabel * blueTitleLabel1 = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, blueTitleImageView1.frame.size.width - 10, blueTitleImageView1.frame.size.height)] autorelease];
            blueTitleLabel1.backgroundColor = [UIColor clearColor];
            blueTitleLabel1.font = [UIFont systemFontOfSize:14];
            blueTitleLabel1.textColor = [UIColor whiteColor];
            [blueTitleImageView1 addSubview:blueTitleLabel1];
            blueTitleLabel1.text = @"后区拖码";
            
            UILabel * blueDescLabel1 = [[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(blueTitleImageView1) + 10, blueTitleImageView1.frame.origin.y, 200, blueTitleImageView1.frame.size.height)] autorelease];
            blueDescLabel1.backgroundColor = [UIColor clearColor];
            blueDescLabel1.font = [UIFont systemFontOfSize:12];
            blueDescLabel1.textColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
            [backImageV211 addSubview:blueDescLabel1];
            blueDescLabel1.text = @"我认为可能出的号，至少2个";
            
            UIView *blue2View = [[UIView alloc] init];
            blue2View.tag = 2013;
            blue2View.frame = CGRectMake(0, ORIGIN_Y(blueTitleImageView1) + 14, backImageV211.frame.size.width, backImageV211.frame.size.height - (ORIGIN_Y(blueTitleImageView1) + 14));
            
            GCBallView * lastBlueBallView1;

            for (int i = 0; i<12; i++) {
                int a= i/6,b = i%6;
                NSString *num = [NSString stringWithFormat:@"%d",i+1];
                if (i+1<10) {
                    num = [NSString stringWithFormat:@"0%d",i+1];
                }
                
                if (SWITCH_ON) {
                    ballRect = CGRectMake(b*51 + 15, a*61, 36, 36);
                }else{
                    ballRect = CGRectMake(b*51 + 15, a*47, 36, 36);
                }
                GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorBlue];
                [blue2View addSubview:im];
                im.tag = i;
                im.gcballDelegate = self;
                if (!SWITCH_ON) {
                    im.ylLable.hidden = YES;
                }
                if (a == 1 && b == 0) {
                    lastBlueBallView1 = im;
                }
                [im release];
            }
            [backImageV211 addSubview:blue2View];
            [blue2View release];
            
            GifButton * blueTrashButton1 = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(lastBlueBallView1.frame.origin.x, ORIGIN_Y(lastBlueBallView1) + ballRect.origin.y - 36, 0, 0)] autorelease];
            blueTrashButton1.tag = 333;
            blueTrashButton1.delegate = self;
            [blue2View addSubview:blueTrashButton1];
        }
        
        endTimelable1 = [[ColorView alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(lastView) + 12, 150, 20)];
        [backScrollView addSubview:endTimelable1];
        endTimelable1.backgroundColor = [UIColor clearColor];
        endTimelable1.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
        endTimelable1.font = [UIFont systemFontOfSize:12];
        if (self.myissueRecord) {
            endTimelable1.text = [NSString stringWithFormat:@"截止时间 %@",[SharedMethod changeDateToNoYearNoSecond:self.myissueRecord.curEndTime]];
        }
        
        backScrollView.contentSize = CGSizeMake(320, ORIGIN_Y(endTimelable1) + 10 + 44);

        jiangchiMoney1 = [[ColorView alloc] init];
        jiangchiMoney1.changeColor = [UIColor redColor];
        jiangchiMoney1.backgroundColor = [UIColor clearColor];
        jiangchiMoney1.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
        jiangchiMoney1.font = [UIFont systemFontOfSize:12];
        if(self.jiangchi) {
            jiangchiMoney1.text = [NSString stringWithFormat:@"奖池金额：<%@> 元",self.jiangchi.JiangChi];
        }
        [backScrollView addSubview:jiangchiMoney1];
    }
    
    [self requestJiangchiMoney];//请求奖池金额
    
    NSDictionary *yilou_Dic = [[NSUserDefaults standardUserDefaults] valueForKey:LOTTERY_ID];
    
    if([yilou_Dic objectForKey:self.myissueRecord.curIssue]){
        [self ShowYilouByHuancun:[yilou_Dic objectForKey:self.myissueRecord.curIssue]];
        return;
    }

    [yiLouRequest clearDelegatesAndCancel];
    self.yiLouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:LOTTERY_ID itemNum:@"1" issue:nil]];
    [yiLouRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [yiLouRequest setDelegate:self];
    [yiLouRequest setDidFinishSelector:@selector(getYiLou:)];
    [yiLouRequest startAsynchronous];
}

- (void)ShowYilouByHuancun:(NSDictionary *)dic {
    
    [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1010] dictionary:dic typeStr:@"rt" keyType:HasZero yiLouTag:1];
    [YiLouUnderGCBallView addYiLouTextOnView:[backScrollView viewWithTag:2010] dictionary:dic typeStr:@"rt" keyType:HasZero yiLouTag:1];
    [YiLouUnderGCBallView addYiLouTextOnView:[backScrollView viewWithTag:2011] dictionary:dic typeStr:@"rt" keyType:HasZero yiLouTag:1];
    
    [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1011] dictionary:dic typeStr:@"lt" keyType:HasZero yiLouTag:1];
    [YiLouUnderGCBallView addYiLouTextOnView:[backScrollView viewWithTag:2012] dictionary:dic typeStr:@"lt" keyType:HasZero yiLouTag:1];
    [YiLouUnderGCBallView addYiLouTextOnView:[backScrollView viewWithTag:2013] dictionary:dic typeStr:@"lt" keyType:HasZero yiLouTag:1];
}
//遗漏
-(void)getYiLou:(ASIHTTPRequest *)request {
	NSString *responseStr = [request responseString];
    if (responseStr&&![responseStr isEqualToString:@"fail"]) {
        NSArray * array = [[responseStr JSONValue] valueForKey:@"list"];
        if (array.count != 0) {
            NSDictionary * dic = [array objectAtIndex:0];
            
            //删除旧的遗漏值
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOTTERY_ID];
            if (self.myissueRecord.curIssue) {
                NSDictionary *yilouHuancunDic = [NSDictionary dictionaryWithObjectsAndKeys:dic,self.myissueRecord.curIssue, nil];
                [[NSUserDefaults standardUserDefaults] setValue:yilouHuancunDic forKey:LOTTERY_ID];
            }
            
            [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1010] dictionary:dic typeStr:@"rt" keyType:HasZero yiLouTag:1];
            [YiLouUnderGCBallView addYiLouTextOnView:[backScrollView viewWithTag:2010] dictionary:dic typeStr:@"rt" keyType:HasZero yiLouTag:1];
            [YiLouUnderGCBallView addYiLouTextOnView:[backScrollView viewWithTag:2011] dictionary:dic typeStr:@"rt" keyType:HasZero yiLouTag:1];
            
            [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1011] dictionary:dic typeStr:@"lt" keyType:HasZero yiLouTag:1];
            [YiLouUnderGCBallView addYiLouTextOnView:[backScrollView viewWithTag:2012] dictionary:dic typeStr:@"lt" keyType:HasZero yiLouTag:1];
            [YiLouUnderGCBallView addYiLouTextOnView:[backScrollView viewWithTag:2013] dictionary:dic typeStr:@"lt" keyType:HasZero yiLouTag:1];
        }
    }
}


- (void)send {
    [MobClick event:@"event_goucai_xuanhaole_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
//    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
    if ([senBtn.titleLabel.text isEqualToString:@"机选"] && [zhushuLabel.text integerValue] == 0) {
        [self randBalls];
        return;
    }
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
    if (daleTouType == DaleTouTypePuTong) {
        int Pred = 0;
        int Pblue = 0;
        UIView *Rview = [normalScrollView viewWithTag:1010];
        for (UIButton *bt in Rview.subviews) {
            if (bt.selected == YES) {
                Pred++;
            }
        }
        UIView *Bview = [normalScrollView viewWithTag:1011];
        for (UIButton *bt2 in Bview.subviews) {
            if (bt2.selected == YES) {
                Pblue++;
            }
        }
        if (Pred < 5 || Pblue < 2) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择5个红球+2个蓝球"];
            return;
        }
    }
    if (daleTouType == DaleTouTypeDantuo) {
        int DanMa = 0;
        int TuoMa = 0;
        int blue = 0;
        int blue2 = 0;
        UIView *qian = [backScrollView viewWithTag:2010];
        UIView *hou = [backScrollView viewWithTag:2011];
        UIView *hou2 = [backScrollView viewWithTag:2012];
        UIView *hou3 = [backScrollView viewWithTag:2013];
        for (UIButton *btn in qian.subviews) {
            if (btn.selected == YES) {
                DanMa++;
            }
        }
        for (UIButton *btn2 in hou.subviews) {
            if (btn2.selected == YES) {
                TuoMa++;
            }
        }
        for (UIButton *btn3 in hou2.subviews) {
            if (btn3.selected == YES) {
                blue++;
            }
        }
        for (UIButton *btn4 in hou3.subviews) {
            if (btn4.selected == YES) {
                blue2++;
            }
        }
        if (DanMa < 1 && blue < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"您现在没有选择胆码"];
            return;
        }
        if (blue2 < 2) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"后区托码至少选择2个"];
            return;
        }
        if ((DanMa + TuoMa) < 6 && DanMa > 0) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"前区胆码+拖码不能少于6个"];
            return;
        }
        if (DanMa == 0 && TuoMa < 5) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"前区号码不能少于5个"];
            return;
        }
        
    }
    if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
        GouCaiShuZiInfoViewController *infoV = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
        NSString *selet = [self seletNumber];
        if (daleTouType == DaleTouTypeDantuo) {
            selet  = [NSString stringWithFormat:@"03#%@",selet];
        }
        
        else if ([zhushuLabel.text intValue] == 1) {
            selet = [NSString stringWithFormat:@"01#%@",selet];
        }
        else {
            selet = [NSString stringWithFormat:@"02#%@",selet];
        }
        
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
        infoV.lotteryType = TYPE_DALETOU;
        
        if (daleTouType == DaleTouTypePuTong) {
            infoV.modeType = Daletoufushi;
        }
        else {
            infoV.modeType = Daletoudantuo;
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        if (!infoViewController) {
            infoViewController = [[GouCaiShuZiInfoViewController alloc] init];
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeDaleTou;
            infoViewController.isHeMai = self.isHemai;
        }
        infoViewController.lotteryType = TYPE_DALETOU;
        
        if (daleTouType == DaleTouTypePuTong) {
            infoViewController.modeType = Daletoufushi;
        }
        else {
            infoViewController.modeType = Daletoudantuo;
        }
        infoViewController.betInfo.issue = self.myissueRecord.curIssue;
        NSString *selet = [self performSelector:@selector(seletNumber)];
        
        if (daleTouType == DaleTouTypeDantuo) {
            selet  = [NSString stringWithFormat:@"03#%@",selet];
        }
        
        else if ([zhushuLabel.text intValue] == 1) {
            selet = [NSString stringWithFormat:@"01#%@",selet];
        }
        else {
            selet = [NSString stringWithFormat:@"02#%@",selet];
        }
        
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

	[self performSelector:@selector(clearBalls)];
	//senBtn.enabled = NO;
}

- (void)clearBalls {
    
	UIView *redView = [normalScrollView viewWithTag:1010];
	UIView *blueView = [normalScrollView viewWithTag:1011];
	for (GCBallView *ball in redView.subviews) {
		if ([ball isKindOfClass:[GCBallView class]]) {
			ball.selected = NO;
		}
	}
	for (GCBallView *ball in blueView.subviews) {
		if ([ball isKindOfClass:[GCBallView class]]) {
			ball.selected = NO;
		}
	}
    for (int i = 0; i<4; i++) {
        UIView *v = [backScrollView viewWithTag:2010+i];
        for (GCBallView *ball in v.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                ball.selected = NO;
                [ball chanetoNomore];
            }
        }
    }
    [self ballSelectChange:nil];
}

- (void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)seletNumber{
    NSString *number_s = @"_", *selectNumber_s = @"_:_";
    NSMutableString *_selectNumber = [NSMutableString string];
    if (daleTouType == DaleTouTypePuTong) {
        for (int i = 0; i < 2; i++) {
            UIView *ballsCon = [normalScrollView viewWithTag:1010+i];
            GifButton * trashButton = (GifButton *)[ballsCon viewWithTag:333];

            NSMutableString *num = [NSMutableString string];
            for (GCBallView *ballV in ballsCon.subviews) {
                if ([ballV isKindOfClass:[GCBallView class]] && ballV.selected) {
                    [num appendString:ballV.numLabel.text];
                    [num appendString:number_s];
                }
            }
            if ([num length] == 0) {
                [num appendString:@"e"];
                
                trashButton.hidden = YES;
            }
            else {
                NSRange rang;
                rang.length = 1;
                rang.location = [num length] -1;
                [num deleteCharactersInRange:rang];
                
                trashButton.hidden = NO;
            }
            
            [_selectNumber appendString:num];
            if (i == 0) {
                [_selectNumber appendString:selectNumber_s];
            }
        } 
        
        return [_selectNumber length] > 0 ? _selectNumber : nil;
    }
    else {
        for (int i = 0; i < 4; i++) {
            UIView *ballsCon = [backScrollView viewWithTag:2010+i];
            GifButton * trashButton = (GifButton *)[ballsCon viewWithTag:333];

            NSMutableString *num = [NSMutableString string];
            for (GCBallView *ballV in ballsCon.subviews) {
                if ([ballV isKindOfClass:[GCBallView class]] && ballV.selected) {
                    [num appendString:ballV.numLabel.text];
                    [num appendString:number_s];
                }
            }
            if ([num length] == 0) {
                [num appendString:@""];
                
                trashButton.hidden = YES;
            }
            else {
                NSRange rang;
                rang.length = 1;
                rang.location = [num length] -1;
                [num deleteCharactersInRange:rang];
                
                trashButton.hidden = NO;
            }
            
            [_selectNumber appendString:num];
            if ((i == 0 && num.length) ||(i == 2 && num.length)) {
                [_selectNumber appendString:@"_,_"];
            }
            else if( i == 1) {
                [_selectNumber appendString:selectNumber_s];
            }
        } 
        return [_selectNumber length] > 0 ? _selectNumber : nil;
    }
    return nil;
}

- (void)wanfaInfo {
    [MobClick event:@"event_goucai_wanfashuoming_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];

	Xieyi365ViewController *xie= [[Xieyi365ViewController alloc] init];
    xie.ALLWANFA = DaLeTou;
	[self.navigationController pushViewController:xie animated:YES];
	[xie release];
	
}

- (void)pressBgButton:(UIButton *)sender{
    if (daleTouType != sender.tag) {
        [self performSelector:@selector(clearBalls)];
    }
	titleLabel.text = [NSString  stringWithFormat:@"%@%@期", [wanArray objectAtIndex:sender.tag],[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]];
    daleTouType = (int)sender.tag;
    if (sender.tag == 0) {
        backScrollView.hidden = YES;
        normalScrollView.hidden = NO;
    }
    else {
        backScrollView.hidden = NO;
        normalScrollView.hidden = YES;
        [senBtn setTitle:@"选好了" forState:UIControlStateNormal];
        senBtn.enabled = NO;
        senBtn.alpha = 1;
    }
    [self ballSelectChange:nil];
    [self yiLouFunc];
}

- (void)randBalls {
    if (daleTouType == DaleTouTypePuTong) {
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:redNum start:1 maxnum:35];
		NSMutableArray *blueBalls = [GC_LotteryUtil getRandBalls:blueNum start:1 maxnum:12];
        UIView *redView = [normalScrollView viewWithTag:1010];
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
        
        UIView *blueView = [normalScrollView viewWithTag:1011];
        for (GCBallView *ball in blueView.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([blueBalls containsObject:ball.numLabel.text]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
            
        }
        //AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        [self ballSelectChange:nil];
    }
    else {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"胆拖模式不支持随机选号"];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if ( event.subtype == UIEventSubtypeMotionShake )
    {
        [MobClick event:@"event_goucai_yaoyiyao_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];

        [self randBalls];
    }
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
	[super motionEnded:motion withEvent:event];
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
    [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
}

- (void)getWanqi {
    NSMutableData *postData = [[GC_HttpService sharedInstance] reWangqiWithLottery:LOTTERY_ID countOfPage:5];
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

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

- (void)LoadIphoneView {
    self.mainView.backgroundColor = [UIColor clearColor];
    normalScrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
    [self.mainView addSubview:normalScrollView];
    
    UIView * lastView = nil;

    if (normalScrollView) {
        UIView * topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 37.5)] autorelease];
        topView.backgroundColor = [UIColor whiteColor];
        [normalScrollView addSubview:topView];
        
        UIView * topShadowView = [[[UIView alloc] initWithFrame:CGRectMake(0, topView.frame.size.height, 320, 0.5)] autorelease];
        topShadowView.backgroundColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
        [topView addSubview:topShadowView];
        
        //摇一注
        UIImageView *yaoImage = [[UIImageView alloc] init];
        yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
        yaoImage.frame = CGRectMake(320 - 21 - 15, 9, 21, 19);
        [normalScrollView addSubview:yaoImage];
        [yaoImage release];
        
        //上期开奖
        UILabel *sqkaijiang = [[UILabel alloc] init];
        sqkaijiang.backgroundColor = [UIColor clearColor];
        sqkaijiang.font = [UIFont systemFontOfSize:14];
        sqkaijiang.text = @"上期开奖";
        sqkaijiang.textColor = [UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
        CGSize sqKaiJiangSize = [sqkaijiang.text sizeWithFont:sqkaijiang.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];
        sqkaijiang.frame = CGRectMake(14, 0, sqKaiJiangSize.width, topView.frame.size.height);
        [topView addSubview:sqkaijiang];
        [sqkaijiang release];
        
        ColorView *sqkaijiang2 = [[ColorView alloc] initWithFrame:CGRectMake(ORIGIN_X(sqkaijiang) + 12, 9.5, 200, 17)];
        sqkaijiang2.tag = 1101;
        sqkaijiang2.textAlignment = NSTextAlignmentLeft;
        sqkaijiang2.backgroundColor = [UIColor clearColor];
        sqkaijiang2.font = [UIFont systemFontOfSize:14];
        sqkaijiang2.changeColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
        sqkaijiang2.textColor = [UIColor colorWithRed:255/255.0 green:36/255.0 blue:36/255.0 alpha:1];
        if (self.myissueRecord) {
            sqkaijiang2.text = [NSString stringWithFormat:@"%@>",[[self.myissueRecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"+" withString:@" <"] stringByReplacingOccurrencesOfString:@"," withString:@" "]];
        }
        [normalScrollView addSubview:sqkaijiang2];
        [sqkaijiang2 release];

        
        //红球背景
        UIImageView *backImageV2 = [[UIImageView alloc] init];
        if (SWITCH_ON) {
            backImageV2.frame = CGRectMake(0, ORIGIN_Y(topView) + 18, 320, 390);
        }else{
            backImageV2.frame = CGRectMake(0, ORIGIN_Y(topView) + 18, 320, 310);
        }
        backImageV2.tag = 800;
        backImageV2.userInteractionEnabled = YES;
        [normalScrollView addSubview:backImageV2];
        backImageV2.backgroundColor = [UIColor clearColor];
        [backImageV2 release];

        UIImageView * redTitleImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53.5, 21.5)] autorelease];
        redTitleImageView.image = UIImageGetImageFromName(@"LeftTitleRed.png");
        [backImageV2 addSubview:redTitleImageView];
        
        UILabel * redTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(14, 0, redTitleImageView.frame.size.width - 14, redTitleImageView.frame.size.height)] autorelease];
        redTitleLabel.backgroundColor = [UIColor clearColor];
        redTitleLabel.font = [UIFont systemFontOfSize:14];
        redTitleLabel.textColor = [UIColor whiteColor];
        [redTitleImageView addSubview:redTitleLabel];
        redTitleLabel.text = @"前区";
        
        UILabel * redDescLabel = [[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(redTitleImageView) + 10, redTitleImageView.frame.origin.y, 200, redTitleImageView.frame.size.height)] autorelease];
        redDescLabel.backgroundColor = [UIColor clearColor];
        redDescLabel.font = [UIFont systemFontOfSize:12];
        redDescLabel.textColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
        [backImageV2 addSubview:redDescLabel];
        redDescLabel.text = @"至少选5个红球";
        
        UIImageView * louImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(redTitleImageView) + 14 + 36 + 1.5, 18, 14)] autorelease];
        louImageView.image = UIImageGetImageFromName(@"LeftTitleYilou.png");
        louImageView.tag = 111;
        [backImageV2 addSubview:louImageView];
        if (!SWITCH_ON) {
            louImageView.hidden = YES;
        }
        
        UILabel * louLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, louImageView.frame.size.width, louImageView.frame.size.height)] autorelease];
        louLabel.backgroundColor = [UIColor clearColor];
        louLabel.font = [UIFont systemFontOfSize:11];
        louLabel.textAlignment = 1;
        louLabel.tag = 112;
        louLabel.textColor = [UIColor whiteColor];
        [louImageView addSubview:louLabel];
        louLabel.text = @"漏";
        
        //蓝球背景
        UIImageView *backImageV21 = [[UIImageView alloc] init];
        if (SWITCH_ON) {
            backImageV21.frame = CGRectMake(0, ORIGIN_Y(backImageV2) + 22, 320, 210);
        }else{
            backImageV21.frame = CGRectMake(0, ORIGIN_Y(backImageV2) + 22, 320, 170);
        }
        backImageV21.userInteractionEnabled = YES;
        backImageV21.tag = 801;
        backImageV21.backgroundColor = [UIColor clearColor];
        [normalScrollView addSubview:backImageV21];
        [backImageV21 release];
        
        UIImageView * blueTitleImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53.5, 21.5)] autorelease];
        blueTitleImageView.image = UIImageGetImageFromName(@"LeftTitleBlue.png");
        [backImageV21 addSubview:blueTitleImageView];
        
        UILabel * blueTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(14, 0, blueTitleImageView.frame.size.width - 14, blueTitleImageView.frame.size.height)] autorelease];
        blueTitleLabel.backgroundColor = [UIColor clearColor];
        blueTitleLabel.font = [UIFont systemFontOfSize:14];
        blueTitleLabel.textColor = [UIColor whiteColor];
        [blueTitleImageView addSubview:blueTitleLabel];
        blueTitleLabel.text = @"后区";
        
        UILabel * blueDescLabel = [[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(blueTitleImageView) + 10, blueTitleImageView.frame.origin.y, 200, blueTitleImageView.frame.size.height)] autorelease];
        blueDescLabel.backgroundColor = [UIColor clearColor];
        blueDescLabel.font = [UIFont systemFontOfSize:12];
        blueDescLabel.textColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
        [backImageV21 addSubview:blueDescLabel];
        blueDescLabel.text = @"至少选2个蓝球";
    
        CGRect ballRect;
        GCBallView * lastRedBallView;

        UIView *redView = [[UIView alloc] init];
        redView.tag = 1010;
        redView.backgroundColor = [UIColor clearColor];
        redView.frame = CGRectMake(0, ORIGIN_Y(redTitleImageView) + 14, backImageV2.frame.size.width, backImageV2.frame.size.height - (ORIGIN_Y(redTitleImageView) + 14));
        for (int i = 0; i<35; i++) {
            int a= i/6,b = i%6;
            NSString *num = [NSString stringWithFormat:@"%d",i+1];
            if (i+1<10) {
                num = [NSString stringWithFormat:@"0%d",i+1];
            }
            
            if (SWITCH_ON) {
                ballRect = CGRectMake(b*51 + 15, a*61, 36, 36);
            }else{
                ballRect = CGRectMake(b*51 + 15, a*47, 36, 36);
            }
            GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorRed];
            [redView addSubview:im];
            im.tag = i;
            im.gcballDelegate = self;
            if (!SWITCH_ON) {
                im.ylLable.hidden = YES;
            }
            lastRedBallView = im;
            [im release];
        }
        [backImageV2 addSubview:redView];
        [redView release];
        
        GifButton * redTrashButton = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(ORIGIN_X(lastRedBallView) + 15, lastRedBallView.frame.origin.y, 0, 0)] autorelease];
        redTrashButton.tag = 333;
        redTrashButton.delegate = self;
        [redView addSubview:redTrashButton];
        
        UIView *blueView = [[UIView alloc] init];
        blueView.tag = 1011;
        blueView.backgroundColor = [UIColor clearColor];
        blueView.frame = CGRectMake(0, ORIGIN_Y(blueTitleImageView) + 14, backImageV21.frame.size.width, backImageV21.frame.size.height - (ORIGIN_Y(blueTitleImageView) + 14));
        
        GCBallView * lastBlueBallView;

        for (int i = 0; i<12; i++) {
            int a= i/6,b = i%6;
            NSString *num = [NSString stringWithFormat:@"%d",i+1];
            if (i+1<10) {
                num = [NSString stringWithFormat:@"0%d",i+1];
            }
            
            if (SWITCH_ON) {
                ballRect = CGRectMake(b*51 + 15, a*61, 36, 36);
            }else{
                ballRect = CGRectMake(b*51 + 15, a*47, 36, 36);
            }
            GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorBlue];
            [blueView addSubview:im];
            im.tag = i;
            im.gcballDelegate = self;
            if (!SWITCH_ON) {
                im.ylLable.hidden = YES;
            }
            [im release];
            if (a == 1 && b == 0) {
                lastBlueBallView = im;
            }
        }
        [backImageV21 addSubview:blueView];
        [blueView release];
        
        GifButton * blueTrashButton = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(lastBlueBallView.frame.origin.x, ORIGIN_Y(lastBlueBallView) + ballRect.origin.y - 36, 0, 0)] autorelease];
        blueTrashButton.tag = 333;
        blueTrashButton.delegate = self;
        [blueView addSubview:blueTrashButton];
        
        lastView = backImageV21;
    }
    
    
    if (daleTouType == DaleTouTypePuTong) {
        [self performSelector:@selector(createBackScrollView) withObject:nil afterDelay:0.1];
        backScrollView.hidden = YES;
        normalScrollView.hidden = NO;
    }
    else {
        [self performSelector:@selector(createBackScrollView) withObject:nil];
        normalScrollView.hidden = YES;
        normalScrollView.hidden = NO;
    }
    
    endTimelable = [[ColorView alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(lastView) + 12, 150, 20)];
    [normalScrollView addSubview:endTimelable];
    endTimelable.backgroundColor = [UIColor clearColor];
    endTimelable.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
//    endTimelable.changeColor = [UIColor lightGrayColor];
    endTimelable.font = [UIFont systemFontOfSize:12];
//    endTimelable.colorfont = [UIFont boldSystemFontOfSize:9];
    if (self.myissueRecord) {
        endTimelable.text = [NSString stringWithFormat:@"截止时间 %@",[SharedMethod changeDateToNoYearNoSecond:self.myissueRecord.curEndTime]];
    }
    [endTimelable release];
    
    normalScrollView.contentSize = CGSizeMake(320, ORIGIN_Y(endTimelable) + 44);
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height -44, 320, 44)];
	[self.view addSubview:im];
    im.tag = 1201;
    im.backgroundColor = [UIColor colorWithRed:20/255.0 green:19/255.0 blue:19/255.0 alpha:1];
	im.userInteractionEnabled = YES;
    
    jiangchiMoney = [[ColorView alloc] init];
//    jiangchiMoney.frame = CGRectMake(222, jiangchiLabel.frame.origin.y - 2, 80, 12);
    jiangchiMoney.changeColor = [UIColor redColor];
    jiangchiMoney.backgroundColor = [UIColor clearColor];
    jiangchiMoney.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
    jiangchiMoney.font = [UIFont systemFontOfSize:12];
    if(self.jiangchi) {
        jiangchiMoney.text = [NSString stringWithFormat:@"奖池金额：<%@> 元",self.jiangchi.JiangChi];
    }
    [normalScrollView addSubview:jiangchiMoney];
    [jiangchiMoney release];
    
//    //清按钮
//    UIButton *qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//    qingbutton.frame = CGRectMake(12, 10, 30, 30);
//    [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
//    [qingbutton addTarget:self action:@selector(clearBalls) forControlEvents:UIControlEventTouchUpInside];
//    [im addSubview:qingbutton];
    
    //注数背景
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 68, 30)];
    zhubg.image = UIImageGetImageFromName(@"SRK960.png");
    zhubg.userInteractionEnabled = YES;
    [im addSubview:zhubg];
    [zhubg release];
    
	zhushuLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 2.5, 40, 11)];
	[zhubg addSubview:zhushuLabel];
	zhushuLabel.text = @"0";
    zhushuLabel.backgroundColor = [UIColor clearColor];
	zhushuLabel.font = [UIFont systemFontOfSize:12];
	zhushuLabel.textAlignment = NSTextAlignmentCenter;
    zhushuLabel.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133/255.0 alpha:1];
	
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
	jineLabel.font = [UIFont systemFontOfSize:12];
    jineLabel.backgroundColor = [UIColor clearColor];
	jineLabel.textAlignment = NSTextAlignmentCenter;
    jineLabel.textColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1];
	
	UILabel *jin = [[UILabel alloc] initWithFrame:CGRectMake(40, 17.5, 20, 11)];
	jin.text = @"元";
	jin.font = [UIFont systemFontOfSize:12];
	jin.textColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1];
	jin.backgroundColor = [UIColor clearColor];
	[zhubg addSubview:jin];
    [jin release];
	
	senBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[senBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
	senBtn.frame = CGRectMake(235, 6, 80, 33);
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    if (daleTouType == DaleTouTypeDantuo) {
        [senBtn setTitle:@"选好了" forState:UIControlStateNormal];
    }else{
        [senBtn setTitle:@"机选" forState:UIControlStateNormal];
    }
    [senBtn setTitleColor:[UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    senBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [im addSubview:senBtn];
    [im release];
}

- (void)LoadIpadView {
    normalScrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
    [self.mainView addSubview:normalScrollView];
    
    if (normalScrollView) {
        //红球背景
        UIImageView *backImageV2 = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"TZAHDSSQBG960.png")];
        backImageV2.frame = CGRectMake(10, 37, 300.5, 202.5);
        backImageV2.userInteractionEnabled = YES;
        [normalScrollView addSubview:backImageV2];
        [backImageV2 release];
        UILabel *hqlabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 20, 20, 16)];
        hqlabel.backgroundColor = [UIColor clearColor];
        hqlabel.text = @"红";
        hqlabel.textColor = [UIColor whiteColor];
        hqlabel.font = [UIFont boldSystemFontOfSize:15];
        hqlabel.shadowColor = [UIColor blackColor];
        hqlabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        [backImageV2 addSubview:hqlabel];
        [hqlabel release];
        UILabel *hqlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(9, 37, 20, 16)];
        hqlabel2.backgroundColor = [UIColor clearColor];
        hqlabel2.text = @"球";
        hqlabel2.textColor = [UIColor whiteColor];
        hqlabel2.font = [UIFont boldSystemFontOfSize:15];
        hqlabel2.shadowColor = [UIColor blackColor];
        hqlabel2.shadowOffset = CGSizeMake(0.0f, 1.0f);
        [backImageV2 addSubview:hqlabel2];
        [hqlabel2 release];
        UILabel *hqlabel3 = [[UILabel alloc] initWithFrame:CGRectMake(8, 53, 23, 23)];
        hqlabel3.backgroundColor = [UIColor clearColor];
        hqlabel3.text = @"⑤";
        hqlabel3.textColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
        hqlabel3.font = [UIFont boldSystemFontOfSize:16];
        [backImageV2 addSubview:hqlabel3];
        [hqlabel3 release];
        
        //蓝球背景
        UIImageView *backImageV21 = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"TZABG960.png")];
        backImageV21.frame = CGRectMake(10, 250, 300.5, 91.5);
        backImageV21.userInteractionEnabled = YES;
        [normalScrollView addSubview:backImageV21];
        [backImageV21 release];
        UILabel *lqlabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 20, 20, 16)];
        lqlabel.backgroundColor = [UIColor clearColor];
        lqlabel.text = @"蓝";
        lqlabel.textColor = [UIColor whiteColor];
        lqlabel.font = [UIFont boldSystemFontOfSize:15];
        lqlabel.shadowColor = [UIColor blackColor];
        lqlabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        [backImageV21 addSubview:lqlabel];
        [lqlabel release];
        UILabel *lqlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(9, 37, 20, 16)];
        lqlabel2.backgroundColor = [UIColor clearColor];
        lqlabel2.text = @"球";
        lqlabel2.textColor = [UIColor whiteColor];
        lqlabel2.font = [UIFont boldSystemFontOfSize:15];
        lqlabel2.shadowColor = [UIColor blackColor];
        lqlabel2.shadowOffset = CGSizeMake(0.0f, 1.0f);
        [backImageV21 addSubview:lqlabel2];
        [lqlabel2 release];
        UILabel *lqlabel3 = [[UILabel alloc] initWithFrame:CGRectMake(8, 53, 23, 23)];
        lqlabel3.backgroundColor = [UIColor clearColor];
        lqlabel3.text = @"②";
        lqlabel3.textColor = [UIColor colorWithRed:191.0/255.0 green:241.0/255.0 blue:255.0/255.0 alpha:1];
        lqlabel3.font = [UIFont boldSystemFontOfSize:16];
        [backImageV21 addSubview:lqlabel3];
        [lqlabel3 release];
        
        
        //摇一注
        UIImageView *yaoImage = [[UIImageView alloc] init];
        yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
        yaoImage.frame =CGRectMake(20, 10, 15, 15);
        [normalScrollView addSubview:yaoImage];
        [yaoImage release];
        
        //上期开奖
        UILabel *sqkaijiang = [[UILabel alloc] initWithFrame:CGRectMake(148, 15, 48, 11)];
        sqkaijiang.backgroundColor = [UIColor clearColor];
        sqkaijiang.font = [UIFont boldSystemFontOfSize:9];
        sqkaijiang.text = @"上期开奖";
        sqkaijiang.textColor = [UIColor blackColor];
        [normalScrollView addSubview:sqkaijiang];
        [sqkaijiang release];
        ColorView *sqkaijiang2 = [[ColorView alloc] initWithFrame:CGRectMake(187, 13, 135, 12)];
        sqkaijiang2.tag = 1101;
        sqkaijiang2.textAlignment = NSTextAlignmentLeft;
        sqkaijiang2.backgroundColor = [UIColor clearColor];
        sqkaijiang2.font = [UIFont boldSystemFontOfSize:11];
        sqkaijiang2.changeColor = [UIColor blueColor];
        if (self.myissueRecord) {
            sqkaijiang2.text = [NSString stringWithFormat:@"%@>",[[self.myissueRecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"+" withString:@" <"] stringByReplacingOccurrencesOfString:@"," withString:@" "]];
        }
        
        sqkaijiang2.textColor = [UIColor redColor];
        [normalScrollView addSubview:sqkaijiang2];
        [sqkaijiang2 release];
        
        UIView *redView = [[UIView alloc] init];
        redView.tag = 1010;
        redView.backgroundColor = [UIColor clearColor];
        redView.frame = CGRectMake(46, 45, 270, 200);
        for (int i = 0; i<35; i++) {
            int a= i/7,b = i%7;
            NSString *num = [NSString stringWithFormat:@"%d",i+1];
            if (i+1<10) {
                num = [NSString stringWithFormat:@"0%d",i+1];
            }
            
            GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*37, a*37, 35, 36) Num:num ColorType:GCBallViewColorRed];
            [redView addSubview:im];
            im.tag = i;
            im.gcballDelegate = self;
            [im release];
        }
        [normalScrollView addSubview:redView];
        [redView release];
        
        
        UIView *blueView = [[UIView alloc] init];
        blueView.tag = 1011;
        blueView.backgroundColor = [UIColor clearColor];
        blueView.frame = CGRectMake(46, 258, 270, 200);
        for (int i = 0; i<12; i++) {
            int a= i/7,b = i%7;
            NSString *num = [NSString stringWithFormat:@"%d",i+1];
            if (i+1<10) {
                num = [NSString stringWithFormat:@"0%d",i+1];
            }
            
            GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*37, a*37, 35, 36) Num:num ColorType:GCBallViewColorBlue];
            [blueView addSubview:im];
            im.tag = i;
            im.gcballDelegate = self;
            [im release];
        }
        [normalScrollView addSubview:blueView];
        [blueView release];
        
    }
    
    
    if (daleTouType == DaleTouTypePuTong) {
        [self performSelector:@selector(createBackScrollView) withObject:nil afterDelay:0.1];
        backScrollView.hidden = YES;
        normalScrollView.hidden = NO;
    }
    else {
        [self performSelector:@selector(createBackScrollView) withObject:nil];
        normalScrollView.hidden = YES;
        backScrollView.hidden = NO;
    }
    
    endTimelable = [[ColorView alloc] initWithFrame:CGRectMake(10 + 35, 350, 150, 20)];
    [normalScrollView addSubview:endTimelable];
    endTimelable.backgroundColor = [UIColor clearColor];
    endTimelable.changeColor = [UIColor lightGrayColor];
    endTimelable.font = [UIFont boldSystemFontOfSize:9];
    endTimelable.colorfont = [UIFont boldSystemFontOfSize:9];
    if (self.myissueRecord) {
        endTimelable.text = [NSString stringWithFormat:@"截止时间 %@",self.myissueRecord.curEndTime];
    }
    [endTimelable release];
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 748 - 88, 390, 44)];
	[self.mainView addSubview:im];	
    im.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
	im.userInteractionEnabled = YES;
    
    //奖池金额
//    jiangchiLabel = [[UILabel alloc] init];
//    jiangchiLabel.frame = CGRectMake(177, 350, 55, 11);
//    jiangchiLabel.backgroundColor = [UIColor clearColor];
//    jiangchiLabel.textColor = [UIColor blackColor];
//    jiangchiLabel.font = [UIFont boldSystemFontOfSize:9];
//    jiangchiLabel.textAlignment = NSTextAlignmentLeft;
//    jiangchiLabel.text = @"奖池金额 :";
//    [normalScrollView addSubview:jiangchiLabel];
//    [jiangchiLabel release];
    jiangchiMoney = [[ColorView alloc] init];
    jiangchiMoney.frame = CGRectMake(222, 348, 80, 12);
    jiangchiMoney.changeColor = [UIColor redColor];
    jiangchiMoney.backgroundColor = [UIColor clearColor];
    jiangchiMoney.textColor = [UIColor redColor];
    jiangchiMoney.font = [UIFont boldSystemFontOfSize:11];
    if(self.jiangchi) {
        
        jiangchiMoney.text = [NSString stringWithFormat:@"<%@>",self.jiangchi.JiangChi];
    }
    [normalScrollView addSubview:jiangchiMoney];
    [jiangchiMoney release];
    
    UILabel *jiangchiLabel21 = [[UILabel alloc] init];
    jiangchiLabel21.frame = CGRectMake(300, 350, 15, 11);
    jiangchiLabel21.backgroundColor = [UIColor clearColor];
    jiangchiLabel21.textColor = [UIColor blackColor];
    jiangchiLabel21.font = [UIFont boldSystemFontOfSize:9];
    jiangchiLabel21.text = @"元";
    [normalScrollView addSubview:jiangchiLabel21];
    [jiangchiLabel21 release];
    
    //清按钮
    UIButton *qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    qingbutton.frame = CGRectMake(12 + 35, 10, 30, 30);
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
    senImage.image = [UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    senImage.tag = 1108;
    [senBtn addSubview:senImage];
    [senImage release];
    UILabel *senLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 33)];
    senLabel.backgroundColor = [UIColor clearColor];
    senLabel.textAlignment = NSTextAlignmentCenter;
    senLabel.text = @"机选";
    senLabel.font = [UIFont systemFontOfSize:15];
    senLabel.textColor = [UIColor colorWithRed:11.0/255.0 green:107.0/255.0 blue:172.0/255.0 alpha:1];
    senLabel.tag = 1101;
    [senBtn addSubview:senLabel];
    [senLabel release];
    [im release];
    if (daleTouType == DaleTouTypeDantuo) {
        UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
        labe.text = @"选好了";
        senBtn.enabled = NO;
        [self ballSelectChange:nil];
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.showYiLou = NO;
    self.yiLouViewHight = self.view.frame.size.height - 44 - 44 - isIOS7Pianyi - self.headHight - TOPVIEW_HEIGHT;

    ShakeView *shakeView = [[ShakeView alloc] init];
	[self.mainView addSubview:shakeView];
	[shakeView becomeFirstResponder];
	[shakeView release];
	
    UIButton * historyButton = (UIButton *)[cpHistoryBGImageView viewWithTag:800];
    [historyButton addTarget:self action:@selector(toHistory) forControlEvents:UIControlEventTouchUpInside];
    
//    UIImageView *bgimageview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    bgimageview.image = UIImageGetImageFromName(@"login_bgn.png");
//    [self.mainView insertSubview:bgimageview atIndex:0];
//    [bgimageview release];
    
    [self changeTitle];
    
    
        UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = left;
        if ([[[Info getInstance] userId] intValue] == 0) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
            UIBarButtonItem *right = [Info itemInitWithTitle:@"登录" Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30)];
            self.CP_navigation.rightBarButtonItem = right;
        }
        else {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
            [btn setImage:UIImageGetImageFromName(@"chaodancaidan.png") forState:UIControlStateNormal];
            [btn setImage:UIImageGetImageFromName(@"chaodancaidan_1.png") forState:UIControlStateHighlighted];

            btn.frame = CGRectMake(0, 0, 60, 44);
            [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            rightItem.enabled = YES;
            [self.CP_navigation setRightBarButtonItem:rightItem];
            [rightItem release];
        }
#ifdef isCaiPiaoForIPad
    [self LoadIpadView];
#else
    [self LoadIphoneView];
#endif
    
    
    titleBtnIsCanPress = YES;
        NSMutableData *postData = [[GC_HttpService sharedInstance] getCaiZhongInfo:LOTTERY_ID];
        
        [myRequest clearDelegatesAndCancel];
        self.myRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [myRequest setRequestMethod:@"POST"];
        [myRequest addCommHeaders];
        [myRequest setPostBody:postData];
        [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [myRequest setDelegate:self];
        [myRequest setDidFinishSelector:@selector(reqLotteryInfoFinished:)];
        [myRequest startAsynchronous];
    [self getWanqi];
}

//菜单按钮
- (void)pressMenubutton:(UIButton *)sender{
    
    if(isShowing)
    {
        UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
        [SharedMethod sanJiaoGuan:sanjiao];
        
        [alert2 disMissWithPressOtherFrame];
    }
    else
    {
        NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
        [allimage addObject:@"GC_sanjizoushi.png"];
        [allimage addObject:@"GC_sanjilishi.png"];
        [allimage addObject:@"GC_sanjiWanfaxuanze.png"];
        [allimage addObject:@"GC_sanjisetting.png"];
//        [allimage addObject:@"menuhmdt.png"];
        [allimage addObject:@"yiLouSwIcon.png"];
        [allimage addObject:@"GC_sanjiShuoming.png"];
        
        NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
        [alltitle addObject:@"走势图"];
        [alltitle addObject:@"历史开奖"];
        [alltitle addObject:@"玩法选择"];
        [alltitle addObject:@"机选设置"];
//        [alltitle addObject:@"合买大厅"];
        if (SWITCH_ON) {
            [alltitle addObject:@"隐藏遗漏"];
        }else{
            [alltitle addObject:@"显示遗漏"];
        }
        [alltitle addObject:@"玩法说明"];
        
        caiboAppDelegate *app = (caiboAppDelegate *)[UIApplication sharedApplication].delegate;
//        if (!tln) {
            tln = [[CP_ThreeLevelNavigationView alloc] initWithFrame:CGRectMake(0, -20, 320, app.window.frame.size.height) AllImageName:allimage setAllTitle:alltitle];
//        }
        tln.delegate = self;
        [self.view addSubview:tln];
        [tln show];
        [tln release];

        [allimage release];
        [alltitle release];
    }

}
- (void)returnSelectIndex:(NSInteger)index{
    if (index == 0) {
        [MobClick event:@"event_goucai_zoushitu_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];

        [self yiLouFunc];
        self.showYiLou = YES;
        if ([self.yiLouDataArray count] > 0) {
            [self allView:self.yiLouDataArray];
            if (!redraw1.hidden) {
                [redraw1 reduction];
            }else if (!redraw2.hidden) {
                [redraw2 reduction];
            }else if (!redraw3.hidden) {
                [redraw3 reduction];
            }
        }else{
            [self requestShuangSeQiuYiLou];
        }
    }else if (index == 1) {
        [self performSelector:@selector(toHistory)];
    }
    else if (index == 2) {
        [MobClick event:@"event_goucai_wanfaxuanze_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
        [self performSelector:@selector(pressTitleButton:)];
    }
    else if (index == 3) {
        [self jixuan];
    }
//    else if (index == 4) {
//        [MobClick event:@"event_goucai_hemaidating_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
//
//        [self otherLottoryViewController:0 title:@"超级大乐透合买" lotteryType:4 lotteryId:LOTTERY_ID];
//    }
    else if (index == 4) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",![[[NSUserDefaults standardUserDefaults] valueForKey:@"YiLouSwitch"] integerValue]] forKey:@"YiLouSwitch"];
        [self switchChange];
        
        NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
        [alltitle addObject:@"走势图"];
        [alltitle addObject:@"历史开奖"];
        [alltitle addObject:@"玩法选择"];
        [alltitle addObject:@"机选设置"];
        [alltitle addObject:@"合买大厅"];
        if (SWITCH_ON) {
            [alltitle addObject:@"隐藏遗漏"];
        }else{
            [alltitle addObject:@"显示遗漏"];
        }
        [alltitle addObject:@"玩法说明"];
        tln.titleArr = alltitle;
        [alltitle release];
    }
    else if (index == 5) {
        [self wanfaInfo];
    }
    
}

#pragma mark - switchChange

-(void)switchChange
{
    NSArray * tagArray = @[@[@"1010",@"1011"],@[@"2010",@"2011",@"2012",@"2013"]];
    
    UIView * lastView = nil;
    UIView * lastView1 = nil;
    for (int i = 0; i < tagArray.count; i++) {
        int heght = 37.5 + 18;
        for (int j = 0; j < [[tagArray objectAtIndex:i] count]; j++) {
            UIView *v;
            if (i == 0) {
                v = [normalScrollView viewWithTag:j + 800];
                lastView = v;
            }else{
                v = [backScrollView viewWithTag:j + 800];
                lastView1 = v;
            }
            int count = 35;
            int tag = 1;
            if (i == tagArray.count - 1) {
                tag = 2;
            }

            UIImageView * louImageView = (UIImageView *)[v viewWithTag:111];

            if (SWITCH_ON) {
                louImageView.hidden = NO;

                if (j >= [[tagArray objectAtIndex:i] count] - tag) {
                    v.frame = CGRectMake(0, heght, 320, 210);
                    count = 12;
                }else{
                    v.frame = CGRectMake(0, heght, 320, 390);
                }
            }else{
                louImageView.hidden = YES;

                if (j >= [[tagArray objectAtIndex:i] count] - tag) {
                    v.frame = CGRectMake(0, heght, 320, 170);
                    count = 12;
                }else{
                    v.frame = CGRectMake(0, heght, 320, 310);
                }
            }
            
            GifButton * trashButton = (GifButton *)[v viewWithTag:333];
            GCBallView * lastBallView;
            
            for (int k = 0; k < count; k++) {
                int a= k/6,b = k%6;
                GCBallView * ballView = (GCBallView *)[[v viewWithTag:[[[tagArray objectAtIndex:i] objectAtIndex:j] integerValue]] viewWithTag:k];
                if (SWITCH_ON) {
                    ballView.frame = CGRectMake(b*51 + 15, a*61, 36, 36);
                    ballView.ylLable.hidden = NO;
                }else{
                    ballView.frame = CGRectMake(b*51 + 15, a*47, 36, 36);
                    ballView.ylLable.hidden = YES;
                }
                if (count == 12) {
                    if (a == 1 && b == 0) {
                        lastBallView = ballView;
                    }
                }else{
                    lastBallView = ballView;
                }
            }
            if (count == 12) {
                trashButton.frame = CGRectMake(lastBallView.frame.origin.x, ORIGIN_Y(lastBallView) + lastBallView.frame.origin.y - 36 - 8, 36, 45);
            }else{
                trashButton.frame = CGRectMake(ORIGIN_X(lastBallView) + 15, lastBallView.frame.origin.y - 8, 36, 45);
            }

            heght += v.bounds.size.height + 22;
        }
    }
    
    endTimelable.frame = CGRectMake(10, ORIGIN_Y(lastView) + 12, 150, 20);
    endTimelable1.frame = CGRectMake(10, ORIGIN_Y(lastView1) + 12, 150, 20);

    CGSize jiangChiSize = [jiangchiMoney.text sizeWithFont:jiangchiMoney.font constrainedToSize:CGSizeMake(10000, 10000)];
    jiangchiMoney.frame = CGRectMake(320 - jiangChiSize.width - 1, endTimelable.frame.origin.y, jiangChiSize.width, endTimelable.frame.size.height);
    jiangchiMoney1.frame = CGRectMake(320 - jiangChiSize.width - 1, endTimelable1.frame.origin.y, jiangChiSize.width, endTimelable1.frame.size.height);

    normalScrollView.contentSize = CGSizeMake(320, ORIGIN_Y(endTimelable) + 44);
    backScrollView.contentSize = CGSizeMake(320, ORIGIN_Y(endTimelable1) + 44);
    
    [self yiLouFunc];

    if (self.showYiLou) {
        self.showYiLou = YES;
    }
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

- (void)jixuan {
    NSMutableArray *randArray = [NSMutableArray array];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"机选红球",@"title",[NSArray arrayWithObjects:@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16" ,nil],@"choose", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"机选蓝球",@"title",[NSArray arrayWithObjects:@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",nil],@"choose", nil];
    [randArray addObject:dic1];
    [randArray addObject:dic2];
    CP_KindsOfChoose *choose = [[CP_KindsOfChoose alloc] initWithTitle:@"机选设置" RandDataInfo:randArray cancelButtonTitle:@"取消" otherButtonTitle:@"完成"];
    
    choose.tag = 102;
    choose.delegate = self;
    [choose show];
    UIView *v1 = [choose.backScrollView viewWithTag:1000];
    for (CP_PTButton *pt in v1.subviews) {
        if ([pt isKindOfClass:[CP_PTButton class]] && [pt.buttonName.text intValue] == redNum) {
            pt.selected = YES;
        }
    }
    
    UIView *v2 = [choose.backScrollView viewWithTag:1001];
    for (CP_PTButton *pt in v2.subviews) {
        if ([pt isKindOfClass:[CP_PTButton class]] && [pt.buttonName.text intValue] == blueNum) {
            pt.selected = YES;
        }
    }
    
    [choose release];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]){
        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(doBack) ImageName:@"HC_gouwuche.png"];
        [self.CP_navigation setHidesBackButton:YES];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(isShowing)
    {
        [alert2 removeFromSuperview];
        [self addNavAgain];
    }
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

- (void)dealloc {
    [allYiLouRequest clearDelegatesAndCancel];
    self.allYiLouRequest = nil;
    [yiLouDataArray release];
    [myHttpRequest clearDelegatesAndCancel];
    self.myHttpRequest = nil;
    [infoViewController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [myRequest clearDelegatesAndCancel];
    [self.qihaoReQuest clearDelegatesAndCancel];
    self.qihaoReQuest = nil;
    self.wangQi = nil;
    [myRequest release];
    [wanArray  release];
    [myissueRecord release];
    self.jiangchi = nil;
    [yiLouRequest clearDelegatesAndCancel];
    self.yiLouRequest = nil;
    
    [zhushuLabel release];
	[jineLabel release];

    [endTimelable1 release];
    [jiangchiMoney1 release];
    [super dealloc];
}

#pragma mark -
#pragma mark CP_KindsOfChooseDelegate

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt {
    
    if (chooseView.tag == 101) {
//        if (buttonIndex == 1) {
        UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
        [SharedMethod sanJiaoGuan:sanjiao];
        
        self.showYiLou = NO;

        backScrollView.frame = CGRectMake(backScrollView.frame.origin.x, backScrollView.frame.origin.y, backScrollView.frame.size.width, _mainView.frame.size.height);
        normalScrollView.frame = CGRectMake(normalScrollView.frame.origin.x, normalScrollView.frame.origin.y, normalScrollView.frame.size.width, _mainView.frame.size.height);
        if ([returnarry count] == 1) {
            NSString *wanfaname = [returnarry objectAtIndex:0];
            NSInteger tag = [wanArray indexOfObject:wanfaname];
            if (tag >= 0 && tag < 100) {
                UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
                sender.tag =tag;
                [self pressBgButton:sender];
            }
            
//            }

    }
        
    }
    else if (chooseView.tag == 102) {
        if (buttonIndex == 1) {
            redNum = [[returnarry objectAtIndex:0] intValue];
            blueNum = [[returnarry objectAtIndex:1] intValue];
            
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%ld",(long)redNum] forKey:@"DaLeTouJiXuanSetRedNumber"];
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%ld",(long)blueNum] forKey:@"DaLeTouJiXuanSetBlueNumber"];

        }
    }
}
-(void)disMissWithPressOtherFrame:(CP_KindsOfChoose *)chooseView
{
    UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
    [SharedMethod sanJiaoGuan:sanjiao];
    
    isShowing = NO;
    [alert2 release];
    [self addNavAgain];
}
-(void)CP_KindsOfChooseViewAlreadyShowed:(CP_KindsOfChoose *)chooseView
{
    titleBtnIsCanPress = YES;
}
-(void)addNavAgain
{
    if (IS_IOS7) {
        self.CP_navigation.frame = CGRectMake(0, 20, 320, 44);
    }else{
        self.CP_navigation.frame = CGRectMake(0, 0, 320, 44);
    }
    [self.view addSubview:self.CP_navigation];
    titleBtnIsCanPress = YES;

}
#pragma mark - GCBallViewDelegate

- (void)ballSelectChange:(UIButton *)imageView {
    ModeTYPE type = Daletoufushi;
    int dantuohou =0, dantuoqian = 0;
    if (daleTouType == DaleTouTypeDantuo) {
        type = Daletoudantuo;
        UIView *v = nil;
        
        if (imageView.superview.tag == 2010 ) {
            int i = 0;
            for (UIButton *btn in imageView.superview.subviews) {
                if (btn.selected == YES) {
                    i++;
                }
            }
            if (i>4) {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"前区胆码最多只能选4个"];
                imageView.selected = NO;
                return;
            }
            v = [backScrollView viewWithTag:2011];
        }
        else if (imageView.superview.tag == 2011 ) {
            int i = 0;
            for (UIButton *btn in imageView.superview.subviews) {
                if (btn.selected == YES) {
                    i++;
                }
            }
            if (i>16) {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"前区拖码不能超过16个"];
                imageView.selected = NO;
                return;
            }
            v = [backScrollView viewWithTag:2010];
        }
        else if (imageView.superview.tag == 2012 ) {
            int i = 0;
            for (UIButton *btn in imageView.superview.subviews) {
                if (btn.selected == YES) {
                    i++;
                }
            }
            if (i>1) {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"后区胆码不能超过1个"];
                imageView.selected = NO;
                return;
            }
            v = [backScrollView viewWithTag:2013];
        }
        else if (imageView.superview.tag == 2013 ) {
            int i = 0;
            
            for (UIButton *btn in imageView.superview.subviews) {
                if (btn.selected == YES) {
                    i++;
                }
            }
            v = [backScrollView viewWithTag:2012];
        }
        UIButton *btn = (UIButton *)[v viewWithTag:imageView.tag];
        if (btn.selected == YES) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"胆码和拖码不能相同"];
            imageView.selected = NO;
            return;
        }
        UIView *qian = [backScrollView viewWithTag:2011];
        for (UIButton *btn in qian.subviews) {
            if (btn.selected == YES) {
                dantuoqian++;
            }
        }
        
        UIView *hou = [backScrollView viewWithTag:2013];
        for (UIButton *btn in hou.subviews) {
            if (btn.selected == YES) {
                dantuohou++;
            }
        }
        
        UIView * v1 = nil;
        UIView * v2 = nil;
        if(imageView.superview.tag == 2010)
        {
            v1 = [backScrollView viewWithTag:2011];
            v2 = [backScrollView viewWithTag:2010];
        }
        else if(imageView.superview.tag==2011)
        {
            v1 = [backScrollView viewWithTag:2010];
            v2 = [backScrollView viewWithTag:2011];
        }
        else if(imageView.superview.tag == 2012)
        {
            v1 = [backScrollView viewWithTag:2013];
            v2 = [backScrollView viewWithTag:2012];
        }
        else if(imageView.superview.tag==2013)
        {
            v1 = [backScrollView viewWithTag:2012];
            v2 = [backScrollView viewWithTag:2013];
        }
        GCBallView *btn2 = (GCBallView *)[v1 viewWithTag:imageView.tag];
        GCBallView *btn3 = (GCBallView *)[v2 viewWithTag:imageView.tag];
        if (!btn2.selected && btn3.selected) {
            [btn2 changetolight];
        }
        else {
            [btn2 chanetoNomore];
        }
        
    }
    NSUInteger bets = [GC_LotteryUtil getBets:[self seletNumber] LotteryType:TYPE_DALETOU ModeType:type];
	NSLog(@"%@,%d,%d",[self seletNumber],dantuohou,dantuoqian);
	    
	zhushuLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)bets];
	jineLabel.text = [NSString stringWithFormat:@"%lu",2*(unsigned long)bets];
    
    NSString *str = [[[[[self seletNumber] stringByReplacingOccurrencesOfString:@"e" withString:@""] stringByReplacingOccurrencesOfString:@":" withString:@""]
        stringByReplacingOccurrencesOfString:@"_" withString:@""]
                     stringByReplacingOccurrencesOfString:@"," withString:@""];
    if (bets > 1 || (daleTouType == DaleTouTypeDantuo && [str length])) {
		senBtn.enabled = YES;
	}
	else {
		senBtn.enabled = NO;
	}

    if (daleTouType == DaleTouTypePuTong) {
        if ([str length] == 0) {
            [senBtn setTitle:@"机选" forState:UIControlStateNormal];
        }
        else {
            [senBtn setTitle:@"选好了" forState:UIControlStateNormal];
        }
        senBtn.alpha = 1;
        senBtn.enabled = YES;
    }
    if (daleTouType == DaleTouTypeDantuo) {
        
        if (!([str length] == 0)) {
            senBtn.alpha = 1;
        }else if ([str length] == 0) {
            
            senBtn.alpha = 0.27;
            
        }
    }

    if (self.showYiLou) {
        [self yiLouFunc];
    }
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)reqWangQiKaiJiang:(ASIHTTPRequest*)request {
	if ([request responseData]) {
		WangqiKaJiangList *wang = [[[WangqiKaJiangList alloc] initWithResponseData:[request responseData] WithRequest:request] autorelease];
		
        NSMutableArray * historyArr = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
        [historyArr addObject:@[@"期号",@"开奖号"]];
        for (int i = 0; i < 5; i++) {
            NSMutableArray * dataArray = [[NSMutableArray alloc] initWithCapacity:10];
            KaiJiangInfo * info = [wang.brInforArray objectAtIndex:i];
            
            [dataArray addObject:[NSString stringWithFormat:@"%@期",[SharedMethod getLastThreeStr:info.issue]]];
            
            NSArray * numberArray = [[info.num stringByReplacingOccurrencesOfString:@"," withString:@" "] componentsSeparatedByString:@"+"];
            //            [dataArray addObject:[info.num stringByReplacingOccurrencesOfString:@"," withString:@" "]];

            [dataArray addObject:[numberArray objectAtIndex:0]];
            if (numberArray.count > 1) {
                [dataArray addObject:[NSString stringWithFormat:@"+%@",[numberArray objectAtIndex:1]]];
            }
            
            
            
            [historyArr addObject:dataArray];
            
            [dataArray release];
        }
        [self addHistoryWithArray:historyArr];}
}

- (void)reqLotteryInfoFinished:(ASIHTTPRequest*)request {
	if ([request responseData]) {
		
		IssueRecord *issrecord = [[IssueRecord alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (issrecord.returnId == 3000) {
            [issrecord release];
            return;
        }
        self.myissueRecord = issrecord;
        titleLabel.text = [NSString stringWithFormat:@"%@%@期",[wanArray objectAtIndex:daleTouType],[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]];
        [self changeTitle];
        ColorView *sqkaijiang1 = (ColorView *)[backScrollView viewWithTag:1101];
        ColorView *sqkaijiang2 = (ColorView *)[normalScrollView viewWithTag:1101];
        NSString *str = self.myissueRecord.lastLotteryNumber;
        NSArray *array = [str componentsSeparatedByString:@"#"];
        str = [array lastObject];
        sqkaijiang1.text = [NSString stringWithFormat:@"%@>",[[str stringByReplacingOccurrencesOfString:@"+" withString:@" <"] stringByReplacingOccurrencesOfString:@"," withString:@" "]];
        sqkaijiang2.text = [NSString stringWithFormat:@"%@>",[[str stringByReplacingOccurrencesOfString:@"+" withString:@" <"] stringByReplacingOccurrencesOfString:@"," withString:@" "]];
        [issrecord release];
        if (self.myissueRecord) {
            endTimelable.text = [NSString stringWithFormat:@"截止时间 %@",[SharedMethod changeDateToNoYearNoSecond:self.myissueRecord.curEndTime]];
            endTimelable1.text = endTimelable.text;
        }
        if ([array count] >= 1) {
            float a = [self.myissueRecord.curIssue floatValue] - [[array objectAtIndex:0] floatValue];
            if (a > 1 && a < 100) {
                if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"daletoujieqi"] isEqualToString:self.myissueRecord.curIssue]) {
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"为了保证您购彩成功，网络购彩会比官方截期时间早，今日开奖期次销售已截止，您将购买%@期，祝您中奖！",[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                    [[NSUserDefaults standardUserDefaults] setValue:self.myissueRecord.curIssue forKey:@"daletoujieqi"];
                }
                else {
                    [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"为了保证您购彩成功，网络购彩会比官方截期时间早，今日开奖期次销售已截止，您将购买%@期，祝您中奖！",[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]]];
                }
            }
        }
    }
    
}

//请求奖池金额
- (void)requestJiangchiMoney {

    NSMutableData *postData = [[GC_HttpService sharedInstance] JiangChi:LOTTERY_ID other:@""];
    [myHttpRequest clearDelegatesAndCancel];
    self.myHttpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [myHttpRequest setRequestMethod:@"POST"];
    [myHttpRequest addCommHeaders];
    [myHttpRequest setPostBody:postData];
    [myHttpRequest setDidFinishSelector:@selector(requestJiangchi:)];
    [myHttpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myHttpRequest setDelegate:self];
    [myHttpRequest startAsynchronous];

}
- (void)requestJiangchi:(ASIHTTPRequest *)request {
    if ([request responseData]) {
        JiangChiJieXi *info = [[JiangChiJieXi alloc] initWithResponseData:[request responseData]WithRequest:request];
        if ([info.JiangChi intValue]) {
            jiangchiMoney.text = [NSString stringWithFormat:@"奖池金额：<%@> 元",info.JiangChi];
            jiangchiMoney1.text = jiangchiMoney.text;
        }
        else {
            jiangchiMoney.text = @"统计中...";
            jiangchiMoney1.text = jiangchiMoney.text;
        }
        CGSize jiangChiSize = [jiangchiMoney.text sizeWithFont:jiangchiMoney.font constrainedToSize:CGSizeMake(10000, 10000)];
        if ([jiangchiMoney.text isEqualToString:@"统计中..."]) {
            jiangchiMoney.frame = CGRectMake(320 - jiangChiSize.width - 30, endTimelable.frame.origin.y, jiangChiSize.width, endTimelable.frame.size.height);
            
            jiangchiMoney1.frame = CGRectMake(320 - jiangChiSize.width - 30, endTimelable1.frame.origin.y, jiangChiSize.width, endTimelable1.frame.size.height);
            
        }else{
            jiangchiMoney.frame = CGRectMake(320 - jiangChiSize.width - 1, endTimelable.frame.origin.y, jiangChiSize.width, endTimelable.frame.size.height);
            
            jiangchiMoney1.frame = CGRectMake(320 - jiangChiSize.width - 1, endTimelable1.frame.origin.y, jiangChiSize.width, endTimelable1.frame.size.height);
            
        }
        
        self.jiangchi = info;
        [info release];
        
    }
}

-(void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 201) {
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
    else if (alertView.tag == 1109) {
        if (buttonIndex == 0) {
            if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
                GouCaiShuZiInfoViewController *infoV = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
                [infoV.dataArray removeAllObjects];
            }
            else{
                [infoViewController.dataArray removeAllObjects];
            }
            [self performSelector:@selector(pressTitleButton:)];
        }
        
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

- (void)returnScrollViewContOffSet:(CGPoint)point{
    
    if (redraw1) {
        if (redraw1.hidden == NO) {
            ChartTitleScrollView * titleScrollview = (ChartTitleScrollView *)[titleYiLou1 viewWithTag:1101];
            titleScrollview.contentOffset = CGPointMake(point.x, titleScrollview.contentOffset.y);
        }
    }
    
    if (redraw2) {
        if (redraw2.hidden == NO) {
            ChartTitleScrollView * titleScrollview = (ChartTitleScrollView *)[titleYiLou2 viewWithTag:1101];
            titleScrollview.contentOffset = CGPointMake(point.x, titleScrollview.contentOffset.y);
        }
    }
    
    
    
}

- (void)returnTitleScrollViewContOffSet:(CGPoint)point{
    if (redraw1) {
        if (redraw1.hidden == NO) {
            ChartYiLouScrollView * redrawScrollview = (ChartYiLouScrollView *)[redraw1 viewWithTag:1103];
            redrawScrollview.contentOffset = CGPointMake(point.x, redrawScrollview.contentOffset.y);
        }
    }
    
    if (redraw2) {
        if (redraw2.hidden == NO) {
            ChartYiLouScrollView * redrawScrollview = (ChartYiLouScrollView *)[redraw2 viewWithTag:1103];
            redrawScrollview.contentOffset = CGPointMake(point.x, redrawScrollview.contentOffset.y);
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [super scrollViewDidScroll:scrollView];
//    if (self.showYiLou == NO) {
//        UIImageView * imagebar = (UIImageView *)[self.view viewWithTag:1201];
//        imagebar.frame = CGRectMake(260 - _cpbackScrollView.contentOffset.x, imagebar.frame.origin.y, imagebar.frame.size.width,imagebar.frame.size.height);
//    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    if(isShowing)
    {
        scrollView.scrollEnabled = NO;
        
        if([alert2 isDescendantOfView:self.mainView])
        {
            
            [alert2 disMissWithPressOtherFrame];
            
            scrollView.scrollEnabled = YES;
            
            
        }
    }
}

-(void)animationCompleted:(GifButton *)gifButton
{
    UIView *v1 = nil;
    if(gifButton.superview.tag == 2010)
    {
        v1 = [backScrollView viewWithTag:2011];
    }
    else if(gifButton.superview.tag == 2011)
    {
        v1 = [backScrollView viewWithTag:2010];
    }
    else if(gifButton.superview.tag == 2012)
    {
        v1 = [backScrollView viewWithTag:2013];
    }
    else if(gifButton.superview.tag == 2013)
    {
        v1 = [backScrollView viewWithTag:2012];
    }
    for (GCBallView *ball in v1.subviews) {
        if ([ball isKindOfClass:[GCBallView class]]) {
            [ball chanetoNomore];
        }
    }
    [self ballSelectChange:nil];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    