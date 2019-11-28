//
//  FuCai3DViewController.m
//  caibo
//
//  Created by 姚福玉 on 12-7-13.
//  Copyright (c) 2012年 第一视频. All rights reserved.
//

#import "FuCai3DViewController.h"
#import "ShakeView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Info.h"
#import "GC_LotteryUtil.h"
#import "caiboAppDelegate.h"
#import "Xieyi365ViewController.h"
#import "LoginViewController.h"
#import "ShiJiHaoJieXi.h"
#import "LotteryListViewController.h"
#import "GCHeMaiInfoViewController.h"
#import "MobClick.h"
#import "NetURL.h"
#import "JSON.h"
#import "YiLouUnderGCBallView.h"
#import "UpLoadView.h"
#import "YiLouChartData.h"
#import "ChartFormatData.h"
#import "New_PageControl.h"
#import "SharedMethod.h"
#import "DetailedViewController.h"

#define LOTTERY_ID @"002"

@implementation FuCai3DViewController

@synthesize myissueRecord;
@synthesize isHemai;
@synthesize myRequest;
@synthesize qihaoReQuest;
@synthesize wangQi;
@synthesize modetype;
@synthesize fucaiedtype;
@synthesize yilouRequest;
@synthesize yilouDic;
@synthesize allYiLouRequest;
@synthesize yiLouDataArray;
//@synthesize upgradeRequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)init {
    self = [super init];
    if (self) {
    	[self initWithModeType:ThreeDzhixuanfushi];
    }
    return self;
}

- (id)initWithModeType:(ModeTYPE)modeType
{
    self = [super init];
    if (self) {
        lotterytype = TYPE_3D;
        modetype = modeType;
        isVerticalBackScrollView = YES;
        self.headHight = DEFAULT_ISSUE_HEIGHT + NEW_PAGECONTROL_HEIGHT + 1;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Action 

- (void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clearBalls {
	for (int i = 0; i < 6; i++) {
		UIView *ballView = [self.mainView viewWithTag:1010+i];
		for (GCBallView *ball in ballView.subviews) {
			if ([ball isKindOfClass:[GCBallView class]]) {
				ball.selected = NO;
			}
		}
	}
//	zhushuLabel.text = [NSString stringWithFormat:@"%d",0];
//	jineLabel.text = [NSString stringWithFormat:@"%d",2*0];
//	senBtn.enabled = NO;
    [self ballSelectChange:nil];
}

- (NSString *)seletNumber {
    NSString *number_s = @"", *selectNumber_s = @",";
    
    NSMutableString *_selectNumber = [NSMutableString string];
    int b = 3;
    int a = 0;
    if (modetype == ThreeDzusanfushi || modetype == ThreeDzuliufushi) {
        b = 1;
    }
    else if (modetype == ThreeDzhixuanhezhi) {
        b = 4;
        a = 3;
    }
    else if (modetype == ThreeDzusanHezhi) {
        a = 4,b = 5;
    }
    else if (modetype == ThreeDzuliuHezhi) {
        a = 5,b = 6;
    }
    else if (modetype == ThreeDzusanDantuo || modetype == ThreeDzuliuDantuo || modetype == ThreeDzusandanshi) {
        b = 2;
    }
    
    for (int i = a; i < b; i++) {
        UIView *ballsCon = [self.mainView viewWithTag:1010+i];
        GifButton * trashButton = (GifButton *)[ballsCon viewWithTag:333];

        NSMutableString *num = [NSMutableString string];
        for (GCBallView *ballV in ballsCon.subviews) {
            if ([ballV isKindOfClass:[GCBallView class]] && ballV.selected) {

                if ((modetype == ThreeDzhixuanhezhi || modetype == ThreeDzusanHezhi || modetype == ThreeDzuliuHezhi) && [num length]) {
                    [num appendString:@"%"];
                    [num appendFormat:@"04#%@",ballV.numLabel.text];
                }
                else if ((modetype == ThreeDzusanDantuo || modetype == ThreeDzuliuDantuo) && [num length]) {
                    [num appendString:@"%"];
                    [num appendFormat:@"03#%@",ballV.numLabel.text];
                }
                else if (modetype == ThreeDzusandanshi && i == 0) {
                    [num appendString:[NSString stringWithFormat:@"%@,%@",ballV.numLabel.text,ballV.numLabel.text]];
                }
                else {
                    [num appendString:[NSString stringWithFormat:@"%@",ballV.numLabel.text]];
                }
                [num appendString:number_s];
            }
        }
        if ([num length] == 0) {
            [num appendString:@"e"];
            
            trashButton.hidden = YES;
        }
        else {
            trashButton.hidden = NO;
        }
        
        [_selectNumber appendString:num];
        
        if ((i == 0 || i == 1)&&b!= 1) {
            if (i == 1 && (modetype == ThreeDzusanDantuo || modetype == ThreeDzuliuDantuo || modetype == ThreeDzusandanshi)) {
                
            }else{
                [_selectNumber appendString:selectNumber_s];
            }
        }
    } 
    
    return [_selectNumber length] > 0 ? _selectNumber : nil;
}

- (void)send {
    [MobClick event:@"event_goucai_xuanhaole_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
//    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
    if ([senBtn.titleLabel.text isEqualToString:@"机选"] && [zhushuLabel.text integerValue] == 0) {
        [self randBalls];
        return;
    }
    
//    if ([zhushuLabel.text intValue] == 6 && modetype == ThreeDzhixuandantuo) {
//        [[caiboAppDelegate getAppDelegate] showMessage:@"胆码和拖码和要大于等于4个"];
//        return;
//    }
	if ([jineLabel.text intValue] > 20000) {
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
		[cai showMessage:@"单注投注额不能超过20000元"];
		return;
	}
    if (modetype == ThreeDzhixuanfushi) {
        int b = 0;
        int s = 0;
        int g = 0;
        UIView *Rview = [self.mainView viewWithTag:1010];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                }
            }
        
        }
        UIView *Bview = [self.mainView viewWithTag:1011];
        for (GCBallView *bt2 in Bview.subviews) {
            if ([bt2 isKindOfClass:[GCBallView class]]) {
            if (bt2.selected == YES) {
                s++;
            }
            }
        }
        UIView *Gview = [self.mainView viewWithTag:1012];
        for (GCBallView *bt3 in Gview.subviews) {
            if ([bt3 isKindOfClass:[GCBallView class]]) {
            if (bt3.selected == YES) {
                g++;
            }
            }
        }
        if (b < 1 || s < 1 || g < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"每位至少选择一个号码"];
            return;
        }
    }
    else if (modetype == ThreeDzusanfushi) {
        int b = 0;
        UIView *Rview = [self.mainView viewWithTag:1010];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                }
            }
            
        }
        if (b < 2) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择2个号码"];
            return;
        }
    }
    else if (modetype == ThreeDzuliufushi) {
        int b = 0;
        UIView *Rview = [self.mainView viewWithTag:1010];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                }
            }
            
        }
        if (b < 3) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择3个号码"];
            return;
        }
    }
    else if (modetype == ThreeDzusandanshi) {
        int b = 0;
        int s = 0;
        UIView *Rview = [self.mainView viewWithTag:1010];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                }
            }
        }
        UIView *Bview = [self.mainView viewWithTag:1011];
        for (GCBallView *bt2 in Bview.subviews) {
            if ([bt2 isKindOfClass:[GCBallView class]]) {
                if (bt2.selected == YES) {
                    s++;
                }
            }
        }

        if (!b) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"请选择重号"];
            return;
        }
        if (!s) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"请选择单号"];
            return;
        }
    }
    else if (modetype == ThreeDzusanDantuo || modetype == ThreeDzuliuDantuo) {
        int a = 0,b = 0;
        UIView *Rview = [self.mainView viewWithTag:1010];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    a++;
                }
            }
            
        }
        if (a < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择1个胆码"];
            return;
        }
        
        UIView *Rview1 = [self.mainView viewWithTag:1011];
        for (GCBallView *bt in Rview1.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                }
            }
        }
        if (b < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择1个拖码"];
            return;
        }
    }
    if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
        GouCaiShuZiInfoViewController *infoV = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
        NSString *selet = [self seletNumber];
        if (modetype == ThreeDzhixuanhezhi || modetype == ThreeDzusanHezhi || modetype == ThreeDzuliuHezhi) {
            selet = [NSString stringWithFormat:@"04#%@",selet];
        }
        else if (modetype == ThreeDzusanDantuo || modetype == ThreeDzuliuDantuo) {
            selet = [NSString stringWithFormat:@"03#%@",selet];
        }
        else if ([zhushuLabel.text intValue] == 1) {
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
        infoV.lotteryType = lotterytype;
        infoV.modeType = modetype;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        if (!infoViewController) {
            infoViewController = [[GouCaiShuZiInfoViewController alloc] init];
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeFuCai3D;
            infoViewController.isHeMai = self.isHemai;
        }
        infoViewController.lotteryType = lotterytype;
        infoViewController.modeType = modetype;
        infoViewController.betInfo.issue = self.myissueRecord.curIssue;
        NSString *selet = [self seletNumber];
        if (modetype == ThreeDzhixuanhezhi || modetype == ThreeDzusanHezhi || modetype == ThreeDzuliuHezhi) {
            selet = [NSString stringWithFormat:@"04#%@",selet];
        }
        else if (modetype == ThreeDzusanDantuo || modetype == ThreeDzuliuDantuo) {
            selet = [NSString stringWithFormat:@"03#%@",selet];
        }
        else if ([zhushuLabel.text intValue] == 1) {
            selet = [NSString stringWithFormat:@"01#%@",selet];
            selet = [selet stringByReplacingOccurrencesOfString:@"," withString:@""];
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

	[self clearBalls];
}


- (void)randBalls {
    
    if (modetype == ThreeDzhixuanfushi) {
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *redBalls2 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        NSMutableArray *redBalls3 = [GC_LotteryUtil getRandBalls:1 start:0 maxnum:9];
        UIView *redView = [self.mainView viewWithTag:1010];
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
        UIView *redView2 = [self.mainView viewWithTag:1011];
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
        UIView *redView3 = [self.mainView viewWithTag:1012];
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
        [self ballSelectChange:nil];
    }
    else if (modetype == ThreeDzusanfushi) {
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:2 start:0 maxnum:9];
        UIView *redView = [self.mainView viewWithTag:1010];
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
    }
    else if (modetype == ThreeDzuliufushi) {
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:3 start:0 maxnum:9];
        UIView *redView = [self.mainView viewWithTag:1010];
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
    }
    else if (modetype == ThreeDzusandanshi) {
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:2 start:0 maxnum:9];
        
        UIView *redView = [self.mainView viewWithTag:1010];
        for (GCBallView *ball in redView.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([[redBalls objectAtIndex:0] isEqualToString:ball.numLabel.text]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
        
        UIView *redView2 = [self.mainView viewWithTag:1011];
        for (GCBallView *ball in redView2.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([[redBalls objectAtIndex:1] isEqualToString:ball.numLabel.text]) {
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

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
	if ( event.subtype == UIEventSubtypeMotionShake )
    {
        [MobClick event:@"event_goucai_yaoyiyao_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];

        [self randBalls];
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];

        if (modetype == ThreeDzhixuanhezhi || modetype == ThreeDzusanHezhi || modetype == ThreeDzuliuHezhi || modetype == ThreeDzusanDantuo || modetype == ThreeDzuliuDantuo) {
            NSArray * titleArray = [titleLabel.text componentsSeparatedByString:@"-"];
            NSString * showTitle = [[titleArray objectAtIndex:0] substringFromIndex:2];
            NSString * showTitle1 = [[titleArray objectAtIndex:0] substringToIndex:2];
            [cai showMessage:[NSString stringWithFormat:@"3D%@%@玩法不支持随机选号",showTitle,showTitle1]];
            return;
        }

		AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }
	[super motionEnded:motion withEvent:event];
}

- (void)wanfaInfo {
    [MobClick event:@"event_goucai_wanfashuoming_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];

	Xieyi365ViewController *xie= [[Xieyi365ViewController alloc] init];
    xie.ALLWANFA = FuCai3D;
	[self.navigationController pushViewController:xie animated:YES];
//	NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"fucai3d.txt"];
//	NSData *fileData = [fileManager contentsAtPath:path];
//    if (fileData) {
//		NSString *str = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
//		xie.infoText.text = str;
//		[str release];
//	}
//	xie.infoText.scrollEnabled = NO;
//	xie.infoText.font = [UIFont systemFontOfSize:11];
//	xie.title = @"福彩3D玩法介绍";
	[xie release];
	
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
            //    CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"玩法选择" ChangCiTitle:@"" DataInfo:wanArray kongtype:controlArray];
            //    alert2.duoXuanBool = NO;
            //    alert2.is3D = YES;
            //    alert2.delegate = self;
            //    [alert2 show];
            //    [alert2 release];
            
            UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
            [SharedMethod sanJiaoKai:sanjiao];
            
            alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"玩法选择" ShuziNameWithTitleArray:wanArray shuziArray:nil];
            alert2.duoXuanBool = NO;
            alert2.tag = 101;
            alert2.delegate = self;
            alert2.isHaveTitle = YES;
            isShowing = YES;
            alert2.isClearBtnCanPress = NO;
            [alert2 show];
            [self.view addSubview:self.CP_navigation];
            self.CP_navigation.frame = CGRectMake(0, 20, 320, 44);
            [self.CP_navigation.window addSubview:alert2];
            [self.CP_navigation.window addSubview:self.CP_navigation];
            
            
            for (CP_XZButton *btn in alert2.backScrollView.subviews) {
                
                if(modetype == ThreeDzhixuanfushi)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 100) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == ThreeDzusandanshi)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 101) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == ThreeDzusanfushi)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 102) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == ThreeDzuliufushi)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 103) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == ThreeDzhixuanhezhi)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 200) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == ThreeDzusanHezhi)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 201) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == ThreeDzuliuHezhi)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 202) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == ThreeDzusanDantuo)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 300) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == ThreeDzuliuDantuo)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 301) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
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

//玩法界面切换
- (void)titleCHange {
    NSInteger wanfa = 0;
    if (modetype == ThreeDzhixuanfushi) {
        wanfa = 100;
        sqkaijiang211.text = @"按位猜中3个开奖号即奖<1040>元";
        [self displayZhiXuanYiLou];
    }
    else if (modetype == ThreeDzusandanshi) {
        sqkaijiang211.text = @"猜中全部开奖号(顺序不限)即奖<346>元";
        wanfa = 101;
        [self displayZuDan];
    }
    else if (modetype == ThreeDzusanfushi) {
        sqkaijiang211.text = @"猜中全部开奖号(顺序不限)即奖<346>元";
        wanfa = 102;
        [self displayZuDan];
    }
    else if (modetype == ThreeDzuliufushi) {
        wanfa = 103;
        sqkaijiang211.text = @"猜中全部开奖号(顺序不限)即奖<173>元";
        [self displayZuDan];
    }
    else if (modetype == ThreeDzhixuanhezhi) {
        wanfa = 200;
        sqkaijiang211.text = @"猜中开奖号相加之和即奖<1040>元";
        [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1013] dictionary:self.yilouDic typeStr:@"hzhyl"];
    }
    else if (modetype == ThreeDzusanHezhi) {
        wanfa = 201;
        sqkaijiang211.text = @"猜中开奖号相加之和即奖<346>元";
        [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1014] dictionary:self.yilouDic typeStr:@"hzhyl"firstAtIndex:1 segmentation:27 arrayTag:0];
    }
    else if (modetype == ThreeDzuliuHezhi) {
        wanfa = 202;
        sqkaijiang211.text = @"猜中开奖号相加之和即奖<173>元";
        [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1015] dictionary:self.yilouDic typeStr:@"hzhyl"firstAtIndex:3 segmentation:25 arrayTag:0];
    }
    else if (modetype == ThreeDzusanDantuo) {
        wanfa = 300;
        sqkaijiang211.text = @"320";
        [self displayZuDan];
    }
    else if (modetype == ThreeDzuliuDantuo) {
        wanfa = 301;
        sqkaijiang211.text = @"160";
        [self displayZuDan];
    }

    
    if (self.myissueRecord.curIssue) {
        if (wanfa >= 200) {
            titleLabel.text = [NSString  stringWithFormat:@"%@%@%@期",[[[wanArray objectAtIndex:wanfa/100 - 1] valueForKey:@"choose"] objectAtIndex:wanfa%100],[[[wanArray objectAtIndex:wanfa/100 - 1] valueForKey:@"title"] substringToIndex:2], [SharedMethod getLastThreeStr:self.myissueRecord.curIssue]];
        }else{
            titleLabel.text = [NSString  stringWithFormat:@"%@%@期",[[[wanArray objectAtIndex:wanfa/100 - 1] valueForKey:@"choose"] objectAtIndex:wanfa%100],[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]];
        }
    }
    else {
        titleLabel.text = [NSString  stringWithFormat:@"%@%@", [[[wanArray objectAtIndex:wanfa/100 - 1] valueForKey:@"choose"] objectAtIndex:wanfa%100],[[[wanArray objectAtIndex:wanfa/100 - 1] valueForKey:@"title"] substringToIndex:2]];
    }
    
    UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
    UILabel *jt = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
    CGSize labelSize = [tl.text sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:UILineBreakModeCharacterWrap];
    
    tl.frame = CGRectMake((320 - labelSize.width - 17 - 1)/2 - self.CP_navigation.titleView.frame.origin.x, 0, labelSize.width, 44);
    if ([[[Info getInstance] userId] intValue] == 0) {
        jt.frame = CGRectMake(tl.frame.origin.x + labelSize.width - 2, 15, 15.5, 15.5);
    }else {
        jt.frame = CGRectMake(tl.frame.origin.x + labelSize.width + 2, 14, 18, 18);
    }
    
    [self endTimelableChange];
    [self changeFrame];
}


- (void)pressBgButton:(UIButton *)sender{
    
    UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
    UILabel *jt = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
    
    UIView * firstView = [normalScrollView viewWithTag:1010];
    UIView * secondView = [normalScrollView viewWithTag:1011];
    UIView * ThirdView = [normalScrollView viewWithTag:1012];
    
    UIView * zhiXuanHeZhiView = [normalScrollView viewWithTag:1013];
    UIView * zuSanHeZhiView = [normalScrollView viewWithTag:1014];
    UIView * zuLiuHeZhiView = [normalScrollView viewWithTag:1015];
    
    UILabel * firstTitleLabel = (UILabel *)[firstView viewWithTag:107];
    UILabel * firstDescLabel = (UILabel *)[firstView viewWithTag:108];
    
    UILabel * secondTitleLabel = (UILabel *)[secondView viewWithTag:107];
    UILabel * secondDescLabel = (UILabel *)[secondView viewWithTag:108];
    

    CGSize labelSize = [tl.text sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:UILineBreakModeCharacterWrap];
    
    tl.frame = CGRectMake((320 - labelSize.width - 17 - 1)/2 - self.CP_navigation.titleView.frame.origin.x, 0, labelSize.width, 44);
    jt.frame = CGRectMake(ORIGIN_X(tl) + 1, 14, 17, 17);
    
    if (sender.tag == 100) {
        if (modetype != ThreeDzhixuanfushi) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = ThreeDzhixuanfushi;
        
        firstTitleLabel.text = [redTitleArray objectAtIndex:0];
        firstDescLabel.text = [redDescArray objectAtIndex:0];
//        redTitleImageView.frame = CGRectMake(0, 0, 53.5, 21.5);
//        firstTitleLabel.frame = CGRectMake(14, 0, redTitleImageView.frame.size.width - 14, redTitleImageView.frame.size.height);
//        firstDescLabel.frame = CGRectMake(ORIGIN_X(redTitleImageView) + 10, redTitleImageView.frame.origin.y, 200, redTitleImageView.frame.size.height);
        
        secondTitleLabel.text = [redTitleArray objectAtIndex:1];
        secondDescLabel.text = [redDescArray objectAtIndex:1];
        
        firstView.hidden = NO;
        secondView.hidden = NO;
        ThirdView.hidden = NO;
        zhiXuanHeZhiView.hidden = YES;
        zuSanHeZhiView.hidden = YES;
        zuLiuHeZhiView.hidden = YES;
        
        yaoImage.hidden = NO;
        sqkaijiangView.frame = CGRectMake(0, sqkaijiangY, 300, 19);
    }
    else if (sender.tag == 101) {
        if (modetype != ThreeDzusandanshi) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = ThreeDzusandanshi;
        
        firstTitleLabel.text = @"重号";
        firstDescLabel.text = @"选1个重号";
        
        secondTitleLabel.text = @"单号";
        secondDescLabel.text = @"选1个单号";
        
        firstView.hidden = NO;
        secondView.hidden = NO;
        ThirdView.hidden = YES;
        zhiXuanHeZhiView.hidden = YES;
        zuSanHeZhiView.hidden = YES;
        zuLiuHeZhiView.hidden = YES;
        
        yaoImage.hidden = NO;
        sqkaijiangView.frame = CGRectMake(0, sqkaijiangY, 300, 19);
    }
    else if (sender.tag == 102) {
        if (modetype != ThreeDzusanfushi) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = ThreeDzusanfushi;
        
        firstTitleLabel.text = @"组三";
        firstDescLabel.text = @"至少选2个号";
        
        firstView.hidden = NO;
        secondView.hidden = YES;
        ThirdView.hidden = YES;
        zhiXuanHeZhiView.hidden = YES;
        zuSanHeZhiView.hidden = YES;
        zuLiuHeZhiView.hidden = YES;
        
        yaoImage.hidden = NO;
        sqkaijiangView.frame = CGRectMake(0, sqkaijiangY, 300, 19);
    }
    else if (sender.tag == 103) {
        if (modetype != ThreeDzuliufushi) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = ThreeDzuliufushi;
        
        firstTitleLabel.text =@"组六";
        firstDescLabel.text = @"至少选3个号";

        firstView.hidden = NO;
        secondView.hidden = YES;
        ThirdView.hidden = YES;
        zhiXuanHeZhiView.hidden = YES;
        zuSanHeZhiView.hidden = YES;
        zuLiuHeZhiView.hidden = YES;
        
        yaoImage.hidden = NO;
        sqkaijiangView.frame = CGRectMake(0, sqkaijiangY, 300, 19);
    }
    else if (sender.tag == 200) {
        if (modetype != ThreeDzhixuanhezhi) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = ThreeDzhixuanhezhi;
        
        firstView.hidden = YES;
        secondView.hidden = YES;
        ThirdView.hidden = YES;
        zhiXuanHeZhiView.hidden = NO;
        zuSanHeZhiView.hidden = YES;
        zuLiuHeZhiView.hidden = YES;
        
        yaoImage.hidden = YES;
        sqkaijiangView.frame = CGRectMake(-25, sqkaijiangY, 300, 19);
    }
    else if (sender.tag == 201) {
        if (modetype != ThreeDzusanHezhi) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = ThreeDzusanHezhi;
//        
//        firstTitleLabel.text =@"和值";
//        firstDescLabel.text = @"①";
        
        firstView.hidden = YES;
        secondView.hidden = YES;
        ThirdView.hidden = YES;
        zhiXuanHeZhiView.hidden = YES;
        zuSanHeZhiView.hidden = NO;
        zuLiuHeZhiView.hidden = YES;
        
        yaoImage.hidden = YES;
        sqkaijiangView.frame = CGRectMake(-25, sqkaijiangY, 300, 19);
    }
    else if (sender.tag == 202) {
        if (modetype != ThreeDzuliuHezhi) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = ThreeDzuliuHezhi;
        
        firstView.hidden = YES;
        secondView.hidden = YES;
        ThirdView.hidden = YES;
        zhiXuanHeZhiView.hidden = YES;
        zuSanHeZhiView.hidden = YES;
        zuLiuHeZhiView.hidden = NO;
        
        yaoImage.hidden = YES;
        sqkaijiangView.frame = CGRectMake(-25, sqkaijiangY, 300, 19);

    }
    else if (sender.tag == 300) {
        if (modetype != ThreeDzusanDantuo) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = ThreeDzusanDantuo;
        
        firstTitleLabel.text =@"胆码";
        firstDescLabel.text = @"①";
        
        secondTitleLabel.text =@"拖码";
        secondDescLabel.text = @"①";
        
        firstView.hidden = NO;
        secondView.hidden = NO;
        ThirdView.hidden = YES;
        zhiXuanHeZhiView.hidden = YES;
        zuSanHeZhiView.hidden = YES;
        zuLiuHeZhiView.hidden = YES;
        
        yaoImage.hidden = YES;
        sqkaijiangView.frame = CGRectMake(-25, sqkaijiangY, 300, 19);

    }
    else if (sender.tag == 301) {
        if (modetype != ThreeDzuliuDantuo) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = ThreeDzuliuDantuo;
        
        firstTitleLabel.text =@"胆码";
        firstDescLabel.text = @"1-2";
        
        secondTitleLabel.text =@"拖码";
        secondDescLabel.text = @"①";
        
        firstView.hidden = NO;
        secondView.hidden = NO;
        ThirdView.hidden = YES;
        zhiXuanHeZhiView.hidden = YES;
        zuSanHeZhiView.hidden = YES;
        zuLiuHeZhiView.hidden = YES;
        
        yaoImage.hidden = YES;
        sqkaijiangView.frame = CGRectMake(-25, sqkaijiangY, 300, 19);

    }
    [self titleCHange];
    [self ballSelectChange:nil];
//    [self endTimelableChange];
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

- (void)getShijiHao {
    NSMutableData *postData = [[GC_HttpService sharedInstance] getShiJiHaoByCaiZhong:self.myissueRecord.lotteryId issue:self.myissueRecord.curIssue Other:@""];
    
    [myRequest clearDelegatesAndCancel];
    self.myRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [myRequest setRequestMethod:@"POST"];
    [myRequest addCommHeaders];
    [myRequest setPostBody:postData];
    [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myRequest setDelegate:self];
    [myRequest setDidFinishSelector:@selector(reqgetShijiHaoFinished:)];
    [myRequest startAsynchronous];
    
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
        NSMutableArray *allimage = [[NSMutableArray alloc] initWithCapacity:0];
        [allimage addObject:@"GC_sanjizoushi.png"];
        [allimage addObject:@"GC_sanjilishi.png"];
        [allimage addObject:@"GC_sanjiWanfaxuanze.png"];
//        [allimage addObject:@"menuhmdt.png"];
        [allimage addObject:@"yiLouSwIcon.png"];
        [allimage addObject:@"GC_sanjiShuoming.png"];
        
        NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
        [alltitle addObject:@"走势图"];
        [alltitle addObject:@"历史开奖"];
        [alltitle addObject:@"玩法选择"];
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

        [self changeFrame];
        self.showYiLou = YES;
        if ([self.yiLouDataArray count] > 0) {
            [self allView:self.yiLouDataArray];
            threeDScrollView.contentOffset = CGPointMake(threeDScrollView.contentOffset.x, threeDScrollView.contentSize.height - threeDScrollView.frame.size.height);
            threeDScrollView1.contentOffset = CGPointMake(threeDScrollView1.contentOffset.x, threeDScrollView1.contentSize.height - threeDScrollView1.frame.size.height);
        }else{
            [self request3DYiLouWithType:2];
        }
    }
    else if (index == 1) {
        [self performSelector:@selector(toHistory)];
    }
    else if (index == 2) {
        [MobClick event:@"event_goucai_wanfaxuanze_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
        [self performSelector:@selector(pressTitleButton:)];
    }
//    else if (index == 3) {
//        [MobClick event:@"event_goucai_hemaidating_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
//        [self otherLottoryViewController:0 title:@"福彩3D合买" lotteryType:2 lotteryId:LOTTERY_ID];
//    }
    else if (index == 3) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",![[[NSUserDefaults standardUserDefaults] valueForKey:@"YiLouSwitch"] integerValue]] forKey:@"YiLouSwitch"];
        [self switchChange];

        NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
        [alltitle addObject:@"走势图"];
        [alltitle addObject:@"历史开奖"];
        [alltitle addObject:@"玩法选择"];
//        [alltitle addObject:@"合买大厅"];
        if (SWITCH_ON) {
            [alltitle addObject:@"隐藏遗漏"];
        }else{
            [alltitle addObject:@"显示遗漏"];
        }
        [alltitle addObject:@"玩法说明"];
        tln.titleArr = alltitle;
        [alltitle release];

    }
    else if (index == 4) {
        [self wanfaInfo];
    }
    
    
}

- (void)allView:(NSMutableArray *)chartDataArray{
    if (yiLouView) {
        int a = 1;
        if (modetype == ThreeDzhixuanfushi) {
            a = 0;
        }
        [self renXuanYiLouFunc:chartDataArray type:a];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [super scrollViewDidScroll:scrollView];
//    if (self.showYiLou == NO) {
//        UIImageView * imagebar = (UIImageView *)[self.view viewWithTag:1201];
//        imagebar.frame = CGRectMake(260 - _cpbackScrollView.contentOffset.x, imagebar.frame.origin.y, imagebar.frame.size.width,imagebar.frame.size.height);
//    }
    
    if (scrollView == threeDScrollView) {
        
        titleScrollView.contentOffset = CGPointMake(threeDScrollView.contentOffset.x, titleScrollView.contentOffset.y);
    }else if (scrollView == titleScrollView){
        
        threeDScrollView.contentOffset = CGPointMake(titleScrollView.contentOffset.x, threeDScrollView.contentOffset.y);
        
    }else if (scrollView == titleScrollView1){
        
        threeDScrollView1.contentOffset = CGPointMake(titleScrollView1.contentOffset.x, threeDScrollView1.contentOffset.y);
    }else if (scrollView == threeDScrollView1){
        
        titleScrollView1.contentOffset = CGPointMake(threeDScrollView1.contentOffset.x, titleScrollView1.contentOffset.y);
    }
    
}

-(void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView{
    
    
    if (scrollView == threeDScrollView || scrollView == threeDScrollView1) {
        [scrollView setContentOffset:scrollView.contentOffset animated:NO];
    }
    
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
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == threeDScrollView) {
        
        NSInteger page = myPageControl.currentPage;
        float x = page *320;
        if (scrollView.contentOffset.x > x + scrollView.frame.size.width * 1/4) {
            page ++;
        }
        else if (scrollView.contentOffset.x < x -scrollView.frame.size.width * 1/4) {
            page --;
        }
        if (x != page *320) {
            myPageControl.currentPage = page;
            [self pageControlFunc:myPageControl];
        }
        else if (scrollView.contentOffset.x != page *320) {
            [self pageControlFunc:myPageControl];
        }
    }else if (scrollView == titleScrollView){
        
        //        elevenScrollView.contentOffset = CGPointMake(titleScrollView.contentOffset.x, elevenScrollView.contentOffset.y);
        NSInteger page = myPageControl.currentPage;
        float x = page *320;
        if (scrollView.contentOffset.x > x + scrollView.frame.size.width * 1/4) {
            page ++;
        }
        else if (scrollView.contentOffset.x < x -scrollView.frame.size.width * 1/4) {
            page --;
        }
        if (x != page *320) {
            myPageControl.currentPage = page;
            [self pageControlFunc:myPageControl];
        }
        else if (scrollView.contentOffset.x != page *320) {
            [self pageControlFunc:myPageControl];
        }
    }else if (scrollView == titleScrollView1){
        
        //        twoElevenScrollView.contentOffset = CGPointMake(twoTitleScrollView.contentOffset.x, twoElevenScrollView.contentOffset.y);
        NSInteger page = myPageControl1.currentPage;
        float x = page *320;
        if (scrollView.contentOffset.x > x + scrollView.frame.size.width * 1/4) {
            page ++;
        }
        else if (scrollView.contentOffset.x < x -scrollView.frame.size.width * 1/4) {
            page --;
        }
        if (x != page *320) {
            myPageControl1.currentPage = page;
            [self pageControlFunc:myPageControl1];
        }
        else if (scrollView.contentOffset.x != page *320) {
            [self pageControlFunc:myPageControl1];
        }
    }else if (scrollView == threeDScrollView1){
        
        //        twoTitleScrollView.contentOffset = CGPointMake(twoElevenScrollView.contentOffset.x, twoTitleScrollView.contentOffset.y);
        NSInteger page = myPageControl1.currentPage;
        float x = page *320;
        if (scrollView.contentOffset.x > x + scrollView.frame.size.width * 1/4) {
            page ++;
        }
        else if (scrollView.contentOffset.x < x -scrollView.frame.size.width * 1/4) {
            page --;
        }
        if (x != page *320) {
            myPageControl1.currentPage = page;
            [self pageControlFunc:myPageControl1];
        }
        else if (scrollView.contentOffset.x != page *320) {
            [self pageControlFunc:myPageControl1];
        }
        
    }

}

- (void)pageControlFunc:(New_PageControl *)pageControl
{
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.2];
    
    
    if (pageControl == myPageControl) {
        threeDScrollView.contentOffset = CGPointMake(320*myPageControl.currentPage, threeDScrollView.contentOffset.y);
    }else if (pageControl == myPageControl1){
        threeDScrollView1.contentOffset = CGPointMake(320*myPageControl1.currentPage, threeDScrollView1.contentOffset.y);
    }
    
    [UIView commitAnimations];
    
}

- (void)renXuanYiLouFunc:(NSMutableArray *)allArray type:(int)cztype{
    
    
    if (cztype == 1) {
        NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:10] ;
        if (threeDScrollView1) {
            threeDScrollView1.hidden = YES;
        }
        if (titleScrollView1) {
            titleScrollView1.hidden = YES;
        }
        if (myPageControl1) {
            myPageControl1.hidden = YES;
        }
        
        [array addObject:[NSString stringWithFormat:@"%d",threeDBasic]];
        [array addObject:[NSString stringWithFormat:@"%d",threeDType]];
        [array addObject:[NSString stringWithFormat:@"%d",threeDDaXiaoJiOu]];
        if (!titleScrollView) {
            titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NEW_PAGECONTROL_HEIGHT, 320, DEFAULT_ISSUE_HEIGHT + 1)];
            titleScrollView.backgroundColor = [UIColor clearColor];
            titleScrollView.contentSize = CGSizeMake(titleScrollView.frame.size.width * [array count], titleScrollView.frame.size.height);
            titleScrollView.pagingEnabled = YES;
            titleScrollView.userInteractionEnabled = NO;
            titleScrollView.directionalLockEnabled = YES;
            titleScrollView.showsHorizontalScrollIndicator = NO;
            titleScrollView.delegate = self;
            titleScrollView.bounces = NO;
            titleScrollView.tag = 11 ;
            [headYiLouView addSubview:titleScrollView];
            
            threeDScrollView = [[UIScrollView alloc] initWithFrame:yiLouView.bounds];
            threeDScrollView.backgroundColor = [UIColor clearColor];
            threeDScrollView.directionalLockEnabled = YES;
            threeDScrollView.showsHorizontalScrollIndicator = NO;
            threeDScrollView.delegate = self;
            threeDScrollView.bounces = NO;
            threeDScrollView.tag = 10 ;
            [yiLouView addSubview:threeDScrollView];
            
            NSArray * titleArray = @[@[@"类型",@""],@[@"大小比",@"奇偶比"]];
            
            for (int j = 0; j < [array count]; j++) {
                ChartFormatData * chartFormatData = [[ChartFormatData alloc] initWithAllArray:yiLouDataArray lottoryType:[[array objectAtIndex:j] intValue]];
                if (j != 0) {
                    chartFormatData.rightTitleArray = [titleArray objectAtIndex:j - 1];
                    chartFormatData.titleHeight = 18.5;
                    
                    if (j == 1) {
                        chartFormatData.linesTitleArray = [NSArray arrayWithObjects:@"组三", @"组六",@"豹子",@"和值",@"跨度", nil];
                        chartFormatData.differentYiLouTypeArray = @[@(Last),@(Last),@(Last),@(All),@(All)];
                        chartFormatData.rightTitleProportion = @"3:2";
                        chartFormatData.differentTitleHeightArray = @[@0,@0,@0,@1,@1];
                        chartFormatData.drawType = DifferentColorSquare;
                        chartFormatData.differentColorTypeArray = @[@(YellowSquare),@(RedSquare),@(BlueSquare)];
                    }else{
                        chartFormatData.drawType = DifferentColorSquare;
                        chartFormatData.linesTitleArray = [NSArray arrayWithObjects:@"0 : 3", @"1 : 2",@"2 : 1", @"3 : 0",@"0 : 3", @"1 : 2",@"2 : 1", @"3 : 0", nil];
                        chartFormatData.differentColorTypeArray = @[@(GreenSquare),@(GreenSquare),@(GreenSquare),@(GreenSquare),@(YellowSquare),@(YellowSquare),@(YellowSquare),@(YellowSquare)];
                    }
                }else{
                    chartFormatData.lottoryWidth = 52;
                    chartFormatData.numberOfLines = 10;
                    chartFormatData.drawType = ThreeColorCircle;
                    chartFormatData.lottoryColor = ThreeColor;
                }
                CGRect redrawFrame1 = CGRectMake(320 * j, 0, 320, 38);
                CGRect redrawFrame = CGRectMake(320 * j, 0, 320, REDRAW_FRAME(chartFormatData));
                
                UITitleYiLouView * titleYiLou = [[UITitleYiLouView alloc] initWithFrame:redrawFrame1 chartFormatData:chartFormatData];
                [titleScrollView addSubview:titleYiLou];
                [titleYiLou release];
                
                redrawView * redraw = [[redrawView alloc] initWithFrame:redrawFrame chartFormatData:chartFormatData]; //基本
                redraw.tag = (j+1)*10;
                [threeDScrollView addSubview:redraw];
                [redraw release];
                
                [chartFormatData release];
                
                threeDScrollView.contentSize = CGSizeMake(threeDScrollView.frame.size.width * [array count], REDRAW_FRAME(chartFormatData));
                threeDScrollView.contentOffset = CGPointMake(0, threeDScrollView.contentSize.height - threeDScrollView.frame.size.height);
                
            }
            
            myPageControl = [[New_PageControl alloc] initWithFrame:CGRectMake(0, 0, 320, NEW_PAGECONTROL_HEIGHT)];
            myPageControl.yilouBool = YES;
            myPageControl.tag = 30 ;
            myPageControl.currentPage = 0;
            myPageControl.numberOfPages = [array count];
            [headYiLouView addSubview:myPageControl];
        }else{
            threeDScrollView.hidden = NO;
            titleScrollView.hidden = NO;
            myPageControl.hidden = NO;
            
        }
        [array release];
    }else if(cztype == 0){
        NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:10] ;
        if (titleScrollView) {
            titleScrollView.hidden = YES;
        }
        if (threeDScrollView) {
            threeDScrollView.hidden = YES;
            
        }
        if (myPageControl) {
            myPageControl.hidden = YES;
        }
        [array addObject:[NSString stringWithFormat:@"%d",threeDOne]];
        [array addObject:[NSString stringWithFormat:@"%d",threeDTwo]];
        [array addObject:[NSString stringWithFormat:@"%d",threeDThree]];
        
        NSArray * titleArray = @[@[@"百位号码"],@[@"十位号码"],@[@"个位号码"]];
        
        if (!titleScrollView1) {
            titleScrollView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NEW_PAGECONTROL_HEIGHT, 320, DEFAULT_ISSUE_HEIGHT + 1)];
            titleScrollView1.backgroundColor = [UIColor clearColor];
            titleScrollView1.contentSize = CGSizeMake(titleScrollView1.frame.size.width * [array count], titleScrollView1.frame.size.height);
            titleScrollView1.userInteractionEnabled = NO;
            titleScrollView1.pagingEnabled = YES;
            titleScrollView1.showsHorizontalScrollIndicator = NO;
            titleScrollView1.delegate = self;
            titleScrollView1.bounces = NO;
            titleScrollView1.tag = 11 ;
            [headYiLouView addSubview:titleScrollView1];
            
            
            threeDScrollView1 = [[UIScrollView alloc] initWithFrame:yiLouView.bounds];
            threeDScrollView1.backgroundColor = [UIColor clearColor];
            threeDScrollView1.showsHorizontalScrollIndicator = NO;
            threeDScrollView1.delegate = self;
            threeDScrollView1.bounces = NO;
            threeDScrollView1.directionalLockEnabled = YES;
            threeDScrollView1.tag = 10 ;
            [yiLouView addSubview:threeDScrollView1];
            
            for (int j = 0; j < [array count]; j++) {
                
                ChartFormatData * chartFormatData = [[ChartFormatData alloc] initWithAllArray:yiLouDataArray lottoryType:[[array objectAtIndex:j] intValue]];
                chartFormatData.lottoryWidth = 52;
//                chartFormatData.issueWidth = 22;
                chartFormatData.numberOfLines = 10;
                chartFormatData.titleHeight = 18.5;
                chartFormatData.rightTitleArray = [titleArray objectAtIndex:j];
                chartFormatData.lottoryColor = j + 3;
                chartFormatData.lineColor = j + 1;
                chartFormatData.drawType = j;
                
                CGRect redrawFrame1 = CGRectMake( 320 * j, 0, 320, 42);
                CGRect redrawFrame = CGRectMake(320 * j, 0, 320, REDRAW_FRAME(chartFormatData));
                
                UITitleYiLouView * titleYiLou = [[UITitleYiLouView alloc] initWithFrame:redrawFrame1 chartFormatData:chartFormatData];
                [titleScrollView1 addSubview:titleYiLou];
                [titleYiLou release];
                
                
                redrawView * redraw = [[redrawView alloc] initWithFrame:redrawFrame chartFormatData:chartFormatData]; //基本
                redraw.tag = (j+1)*10;
                [threeDScrollView1 addSubview:redraw];
                [redraw release];
                
                [chartFormatData release];
                threeDScrollView1.contentSize = CGSizeMake(threeDScrollView1.frame.size.width * [array count], REDRAW_FRAME(chartFormatData));
                threeDScrollView1.contentOffset = CGPointMake(0, threeDScrollView1.contentSize.height - threeDScrollView1.frame.size.height);
            }
            
            myPageControl1 = [[New_PageControl alloc] initWithFrame:CGRectMake(0, 0, 320, NEW_PAGECONTROL_HEIGHT)];
            myPageControl1.yilouBool = YES;
            myPageControl1.backgroundColor = [UIColor colorWithRed:30/255.0 green:92/255.0 blue:137/255.0 alpha:1];
            myPageControl1.tag = 30 ;
            myPageControl1.currentPage = 0;
            myPageControl1.numberOfPages = [array count];
            [headYiLouView addSubview:myPageControl1];
        }else{
            threeDScrollView1.hidden = NO;
            titleScrollView1.hidden = NO;
            myPageControl1.hidden = NO;
            
        }
        [array release];
    }
}

- (void)headButtonFunc{
    if (headbgImage) {
        return;
    }
    headbgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    headbgImage.backgroundColor = [UIColor clearColor];
    headbgImage.userInteractionEnabled = YES;
    headbgImage.image = [UIImageGetImageFromName(@"yiloudaohang.png") stretchableImageWithLeftCapWidth:8 topCapHeight:22];
    [headYiLouView addSubview:headbgImage];
    
    UIButton * redButton = [UIButton buttonWithType:UIButtonTypeCustom];//70*3  320- 210 110
    redButton.frame = CGRectMake(46, 0, 76, 44);
    redButton.tag = 1;
    [redButton addTarget:self action:@selector(pressRedButton:) forControlEvents:UIControlEventTouchUpInside];
    [headbgImage addSubview:redButton];
    
    UIImageView * redImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, (redButton.frame.size.height - 21)/2, 20, 21)];
    redImage.backgroundColor = [UIColor clearColor];
    redImage.tag = 10;
    redImage.image = UIImageGetImageFromName(@"redssqImage_1.png");
    [redButton addSubview:redImage];
    [redImage release];
    
    UILabel * redLabel = [[UILabel alloc] initWithFrame:CGRectMake(34, 0, 40, redButton.frame.size.height)];
    redLabel.backgroundColor = [UIColor  clearColor];
    redLabel.font = [UIFont systemFontOfSize:15];
    redLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    redLabel.text = @"红球";
    [redButton addSubview:redLabel];
    [redLabel release];
    
    
    UIButton * blueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    blueButton.frame = CGRectMake(122, 0, 76, 44);
    blueButton.tag = 2;
    [blueButton addTarget:self action:@selector(pressRedButton:) forControlEvents:UIControlEventTouchUpInside];
    [headbgImage addSubview:blueButton];
    
    UIImageView * blueImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, (blueButton.frame.size.height - 21)/2, 20, 21)];
    blueImage.backgroundColor = [UIColor clearColor];
    blueImage.tag = 10;
    blueImage.image = UIImageGetImageFromName(@"bluessqimage.png");
    [blueButton addSubview:blueImage];
    [blueImage release];
    
    UILabel * blueLabel = [[UILabel alloc] initWithFrame:CGRectMake(34, 0, 40, blueButton.frame.size.height)];
    blueLabel.backgroundColor = [UIColor  clearColor];
    blueLabel.font = [UIFont systemFontOfSize:15];
    blueLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    blueLabel.text = @"蓝球";
    [blueButton addSubview:blueLabel];
    [blueLabel release];
    
    UIButton * dataButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dataButton.frame = CGRectMake(198, 0, 76, 44);
    [dataButton addTarget:self action:@selector(pressRedButton:) forControlEvents:UIControlEventTouchUpInside];
    dataButton.tag = 3;
    [headbgImage addSubview:dataButton];
    
    UIImageView * dataImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, (dataButton.frame.size.height - 21)/2, 20, 21)];
    dataImage.backgroundColor = [UIColor clearColor];
    dataImage.tag = 10;
    dataImage.image = UIImageGetImageFromName(@"datassqimage.png");
    [dataButton addSubview:dataImage];
    [dataImage release];
    
    UILabel * dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(34, 0, 40, dataButton.frame.size.height)];
    dataLabel.backgroundColor = [UIColor  clearColor];
    dataLabel.font = [UIFont systemFontOfSize:15];
    dataLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    dataLabel.text = @"数据";
    [dataButton addSubview:dataLabel];
    [dataLabel release];
    
    UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(redButton.frame.origin.x, 41, 76, 3)];
    lineImage.backgroundColor = [UIColor colorWithRed:7/255.0 green:174/255.0 blue:222/255.0 alpha:1];
    lineImage.tag = 111;
    [headbgImage addSubview:lineImage];
    [lineImage release];
    
}

- (void)pressRedButton:(UIButton *)sender{
    
    if (sender.tag == 1) {
        UIButton * showButton1 = (UIButton *)[headbgImage viewWithTag:1];
        UIButton * showButton2 = (UIButton *)[headbgImage viewWithTag:2];
        UIButton * showButton3 = (UIButton *)[headbgImage viewWithTag:3];
        
        UIImageView * showImage1 = (UIImageView *)[showButton1 viewWithTag:10];
        UIImageView * showImage2 = (UIImageView *)[showButton2 viewWithTag:10];
        UIImageView * showImage3 = (UIImageView *)[showButton3 viewWithTag:10];
        
        showImage1.image = UIImageGetImageFromName(@"redssqImage_1.png");
        showImage2.image = UIImageGetImageFromName(@"bluessqimage.png");
        showImage3.image = UIImageGetImageFromName(@"datassqimage.png");
        titleYiLou1.hidden = NO;
        //        ChartTitleScrollView * titlyilou = (ChartTitleScrollView *)[titleYiLou1 viewWithTag:1101];
        //        titlyilou.contentOffset = CGPointMake(0, titlyilou.contentOffset.y);
        titleYiLou2.hidden = YES;
        titleYiLou3.hidden = YES;
        redraw1.hidden = NO;
        redraw2.hidden = YES;
        redraw3.hidden = YES;
        
    }else if (sender.tag == 2){
        
        UIButton * showButton1 = (UIButton *)[headbgImage viewWithTag:1];
        UIButton * showButton2 = (UIButton *)[headbgImage viewWithTag:2];
        UIButton * showButton3 = (UIButton *)[headbgImage viewWithTag:3];
        
        UIImageView * showImage1 = (UIImageView *)[showButton1 viewWithTag:10];
        UIImageView * showImage2 = (UIImageView *)[showButton2 viewWithTag:10];
        UIImageView * showImage3 = (UIImageView *)[showButton3 viewWithTag:10];
        
        showImage1.image = UIImageGetImageFromName(@"redssqImage.png");
        showImage2.image = UIImageGetImageFromName(@"bluessqimage_1.png");
        showImage3.image = UIImageGetImageFromName(@"datassqimage.png");
        
        titleYiLou1.hidden = YES;
        titleYiLou2.hidden = NO;
        titleYiLou3.hidden = YES;
        redraw1.hidden = YES;
        redraw2.hidden = NO;
        redraw3.hidden = YES;
        
    }else if (sender.tag == 3){
        
        UIButton * showButton1 = (UIButton *)[headbgImage viewWithTag:1];
        UIButton * showButton2 = (UIButton *)[headbgImage viewWithTag:2];
        UIButton * showButton3 = (UIButton *)[headbgImage viewWithTag:3];
        
        UIImageView * showImage1 = (UIImageView *)[showButton1 viewWithTag:10];
        UIImageView * showImage2 = (UIImageView *)[showButton2 viewWithTag:10];
        UIImageView * showImage3 = (UIImageView *)[showButton3 viewWithTag:10];
        
        showImage1.image = UIImageGetImageFromName(@"redssqImage.png");
        showImage2.image = UIImageGetImageFromName(@"bluessqimage.png");
        showImage3.image = UIImageGetImageFromName(@"datassqimage_1.png");
        titleYiLou1.hidden = YES;
        titleYiLou2.hidden = YES;
        titleYiLou3.hidden = NO;
        redraw1.hidden = YES;
        redraw2.hidden = YES;
        redraw3.hidden = NO;
    }
    
    UIImageView * lineImage = (UIImageView *)[headbgImage viewWithTag:111];
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    lineImage.frame = CGRectMake(sender.frame.origin.x, lineImage.frame.origin.y, lineImage.frame.size.width, lineImage.frame.size.height);
    [UIView commitAnimations];
    
}

- (void)changeFrame
{
    if (normalScrollView.contentSize.height > self.view.frame.size.height - 44 - isIOS7Pianyi) {
        normalScrollView.frame = CGRectMake(normalScrollView.frame.origin.x, normalScrollView.frame.origin.y, normalScrollView.frame.size.width, normalScrollView.contentSize.height + 10);
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, normalScrollView.frame.size.height);
    }else{
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, self.view.frame.size.height - 44 - isIOS7Pianyi);
    }
    cpLowermostScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(_mainView) + 44 + isIOS7Pianyi);
    
//    _cpbackScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(_mainView) + 44 + isIOS7Pianyi);
//    UIImageView * imagebar = (UIImageView *)[self.view viewWithTag:1201];
//    imagebar.frame = CGRectMake(0, imagebar.frame.origin.y, imagebar.frame.size.width,imagebar.frame.size.height);
}

- (void)request3DYiLouWithType:(int)type
{
    if (type == 1) {
        
        NSDictionary *yilou_Dic = [[NSUserDefaults standardUserDefaults] valueForKey:LOTTERY_ID];
        
        if([yilou_Dic objectForKey:self.myissueRecord.curIssue]){
            [self ShowYilouByHuancun:[yilou_Dic objectForKey:self.myissueRecord.curIssue]];
            return;
        }
        
        [yilouRequest clearDelegatesAndCancel];
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:LOTTERY_ID itemNum:@"1" issue:nil]];
        [yilouRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [yilouRequest setDelegate:self];
        [yilouRequest setDidFinishSelector:@selector(yiLouRequestFinish:)];
        [yilouRequest startAsynchronous];
        
    }else{
        if (!loadview) {
            loadview = [[UpLoadView alloc] init];
        }
        caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:loadview];
        
        [allYiLouRequest clearDelegatesAndCancel];
        self.allYiLouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:LOTTERY_ID itemNum:@"30" issue:nil]];
        [allYiLouRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [allYiLouRequest setDelegate:self];
        [allYiLouRequest setDidFinishSelector:@selector(allYiLouRequestFinish:)];
        [allYiLouRequest setDidFailSelector:@selector(allYiLouRequestFail:)];
        [allYiLouRequest startAsynchronous];
    }
}

- (void)ShowYilouByHuancun:(NSDictionary *)responseDic {
    
    self.yilouDic = responseDic;
    
    [self titleCHange];
    
}

- (void)yiLouRequestFinish:(ASIHTTPRequest *)request
{
    NSString *responseStr = [request responseString];
    if (responseStr&&![responseStr isEqualToString:@"fail"]) {
        if ([[[responseStr JSONValue] objectForKey:@"list"] count]) {
            
            self.yilouDic = [[[responseStr JSONValue] objectForKey:@"list"] objectAtIndex:0];

            //删除旧的遗漏值
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOTTERY_ID];
            if (self.myissueRecord.curIssue) {
                NSDictionary *yilouHuancunDic = [NSDictionary dictionaryWithObjectsAndKeys:yilouDic,self.myissueRecord.curIssue, nil];
                [[NSUserDefaults standardUserDefaults] setValue:yilouHuancunDic forKey:LOTTERY_ID];
            }

            
            [self titleCHange];
        }
    }
}

- (void)allYiLouRequestFail:(ASIHTTPRequest *)marequest{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    self.showYiLou = NO;
}

- (void)allYiLouRequestFinish:(ASIHTTPRequest *)request{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
	NSString *responseStr = [request responseString];
        if (responseStr&&![responseStr isEqualToString:@"fail"]) {
            NSDictionary * dic = [responseStr JSONValue];
            NSArray * array = [dic objectForKey:@"list"];
            NSMutableArray * chartDataArray = [[[NSMutableArray alloc] init] autorelease];
            for (int i = (int)array.count - 1; i >= 0; i--) {
                YiLouChartData * chartData = [[YiLouChartData alloc] initWith3DDictionary:[array objectAtIndex:i]];
                [chartDataArray addObject:chartData];
                [chartData release];
            }
            if ([array count] == 0) {
                self.showYiLou = NO;
            }else{
                self.yiLouDataArray = chartDataArray;
                [self allView:chartDataArray];
            }
            
        }else{
            self.showYiLou = NO;
        }
}

#pragma mark - switchChange

-(void)switchChange
{
    float heght = firstViewY;
    
    int count = 0;
    int number = 0;
    for (int i = 1010;i<1016;i++) {
        UIView *v = [normalScrollView viewWithTag:i];
        
        UIImageView * louImageView = (UIImageView *)[v viewWithTag:111];

        if (i < 1013) {
            if (SWITCH_ON) {
                louImageView.hidden = NO;
                v.frame = CGRectMake(0, heght, 320, 150);
            }else{
                louImageView.hidden = YES;
                v.frame = CGRectMake(0, heght, 320, 122);
            }
            count = 10;
            number = 6;
        }else{
            if (SWITCH_ON) {
                louImageView.hidden = NO;
                
                if (i == 1015) {
                    v.frame = CGRectMake(0, firstViewY, 320, 274);
                }else{
                    v.frame = CGRectMake(0, firstViewY, 320, 335);
                }
            }else{
                louImageView.hidden = YES;
                
                if (i == 1015) {
                    v.frame = CGRectMake(0, firstViewY, 320, 216);
                }else{
                    v.frame = CGRectMake(0, firstViewY, 320, 263);
                }
            }
            count = 28;
            number = 6;
        }

        UIImageView * redTitleImageView = (UIImageView *)[v viewWithTag:200];

        GifButton * trashButton = (GifButton *)[v viewWithTag:333];
        GCBallView * lastBallView;
        
        for (int j = 0; j < count; j++) {
            int a= j/number,b = j%number;
            if ([[v viewWithTag:j] isKindOfClass:[GCBallView class]]) {
                GCBallView * ballView = (GCBallView *)[v viewWithTag:j];
                if (SWITCH_ON) {
                    if (number == 6) {
                        ballView.frame = CGRectMake(b * 51 + 15, a * 61+ ORIGIN_Y(redTitleImageView) + 14, 36, 36);
                    }else{
                        ballView.frame = CGRectMake(b*50+48, a*52+11, 35, 35);
                    }
                    ballView.ylLable.hidden = NO;
                }else{
                    if (number == 6) {
                        ballView.frame = CGRectMake(b * 51 + 15, a * 47 + ORIGIN_Y(redTitleImageView) + 14, 36, 36);
                    }else{
                        ballView.frame = CGRectMake(b*50+48, a*37+7.5, 35, 35);
                    }
                    ballView.ylLable.hidden = YES;
                }
                lastBallView = ballView;
            }
        }
        trashButton.frame = CGRectMake(ORIGIN_X(lastBallView) + 15, lastBallView.frame.origin.y - 8, 36, 45);
        heght += v.bounds.size.height + 23;
        [self endTimelableChange];
    }
    
    [self changeFrame];

    if (self.showYiLou) {
        self.showYiLou = YES;
    }
}

-(void)endTimelableChange
{
//    normalScrollView.contentSize = CGSizeZero;
    if (modetype == ThreeDzusanfushi || modetype == ThreeDzuliufushi) {
        endTimelable.frame = CGRectMake(175, ORIGIN_Y([normalScrollView viewWithTag:1010]) + 12, 150, 20);
    }
    else if (modetype == ThreeDzhixuanfushi) {
        endTimelable.frame = CGRectMake(175, ORIGIN_Y([normalScrollView viewWithTag:1012]) + 12, 150, 20);
    }
    else if (modetype == ThreeDzuliuHezhi) {
        endTimelable.frame = CGRectMake(175, ORIGIN_Y([normalScrollView viewWithTag:1015]) + 12, 150, 20);
    }
    else{
        endTimelable.frame = CGRectMake(175, ORIGIN_Y([normalScrollView viewWithTag:1013]) + 12, 150, 20);
    }
    normalScrollView.contentSize = CGSizeMake(320, ORIGIN_Y(endTimelable) + 10 + 44);
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

//历史开奖
- (void)toHistory
{
    [MobClick event:@"event_goucai_chakangengduo_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
    [MobClick event:@"event_goucai_lishikaijiang_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
    LotteryListViewController *controller = [[LotteryListViewController alloc] init];
    controller.lotteryId = LOTTERY_ID;
    controller.lotteryName = @"福彩3D";
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


- (void)LoadIphoneView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 270, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.userInteractionEnabled = YES;
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
//    if (modetype == ThreeDzhixuanfushi) {
//        titleLabel.text = @"直选";
//    }
//    else if (modetype == ThreeDzhixuanhezhi) {
//        titleLabel.text = @"直选和值";
//    }
//    else if (modetype == ThreeDzhixuandantuo) {
//        titleLabel.text = @"直选胆拖";
//    }
//    else if (modetype == ThreeDzuliufushi) {
//        titleLabel.text = @"组六";
//    }
//    else {
//        titleLabel.text = @"组三";
//    }
    
    if (self.myissueRecord) {
        if ([self.myissueRecord.curIssue length] == 5) {
            self.myissueRecord.curIssue = [NSString stringWithFormat:@"20%@", self.myissueRecord.curIssue];
        }
        else {
            self.myissueRecord.curIssue = self.myissueRecord.curIssue;
        }
        
        titleLabel.text = [NSString stringWithFormat:@"%@%@期",titleLabel.text,[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]];
    }
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.tag = 789;
    
    CGSize labelSize = [titleLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:UILineBreakModeCharacterWrap];
    
//    UILabel *JTLabel = [[UILabel alloc] init];
//    JTLabel.backgroundColor = [UIColor clearColor];
//    JTLabel.textAlignment = NSTextAlignmentCenter;
//    JTLabel.font = [UIFont systemFontOfSize:12];
//    JTLabel.text = @"▼";
//    JTLabel.textColor = [UIColor whiteColor];
//    JTLabel.shadowColor = [UIColor blackColor];
//    JTLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
//    JTLabel.tag = 567;
    
    sanjiaoImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]] autorelease];
    [titleView addSubview:sanjiaoImageView];
    sanjiaoImageView.tag = 567;
    
    if ([[[Info getInstance] userId] intValue] == 0) {
        titleLabel.frame = CGRectMake(45, 0, 220, 44);
        sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + labelSize.width + 1, 14, 17, 17);
    }else {
        
        titleLabel.frame = CGRectMake(45, 0, 220, 44);
        sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + labelSize.width + 1, 13.5, 18, 18);
    }
//    [titleView addSubview:sanjiaoImageView];
//    [JTLabel release];
    
    UIButton *titleButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton3.frame = CGRectMake(0, 0, 270, 44);
    titleButton3.backgroundColor = [UIColor clearColor];
    [titleButton3 addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleButton3 addTarget:self action:@selector(pressTitleButton1:) forControlEvents:UIControlEventTouchDown];
    [titleButton3 addTarget:self action:@selector(pressTitleButton2:) forControlEvents:UIControlEventTouchCancel];

    [titleButton3 addSubview:titleLabel];
    [titleView addSubview:titleButton3];
    self.CP_navigation.titleView = titleView;
    [titleLabel release];
    [titleView release];
    
    
    normalScrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
    normalScrollView.delegate = self;
    [self.mainView addSubview:normalScrollView];
    
    UIView * topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, TOPVIEW_HEIGHT)] autorelease];
    topView.backgroundColor = [UIColor whiteColor];
    [normalScrollView addSubview:topView];
    
    UIView * topShadowView = [[[UIView alloc] initWithFrame:CGRectMake(0, topView.frame.size.height, 320, 0.5)] autorelease];
    topShadowView.backgroundColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
    [topView addSubview:topShadowView];
    
//    UILabel *sqkjLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 50, 11)];
//    sqkjLabel.backgroundColor = [UIColor clearColor];
//    sqkjLabel.text = @"上期开奖：";
//    sqkjLabel.font = [UIFont systemFontOfSize:9];
//    [topView addSubview:sqkjLabel];
//    [sqkjLabel release];
    
    sqkaijiang = [[ColorView alloc] initWithFrame:CGRectMake(14, 9.5, 165 - 14, 17)];
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.font = [UIFont systemFontOfSize:14];
    if (self.myissueRecord) {
        sqkaijiang.text = [[NSString stringWithFormat:@"上期开奖  <%@>",self.myissueRecord.lastLotteryNumber] stringByReplacingOccurrencesOfString:@"," withString:@"  "];
    }
    sqkaijiang.textColor = [UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
    sqkaijiang.colorfont = [UIFont systemFontOfSize:14];
    sqkaijiang.changeColor = [UIColor colorWithRed:255/255.0 green:36/255.0 blue:36/255.0 alpha:1];
    [topView addSubview:sqkaijiang];
	[sqkaijiang release];
    
    shijiHao = [[ColorView alloc] initWithFrame:CGRectMake(ORIGIN_X(sqkaijiang), sqkaijiang.frame.origin.y, 320 - 165, sqkaijiang.frame.size.height)];
    shijiHao.backgroundColor = [UIColor clearColor];
    shijiHao.font = [UIFont systemFontOfSize:14];
    shijiHao.textColor = [UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
    shijiHao.colorfont = [UIFont systemFontOfSize:14];
    shijiHao.changeColor = [UIColor colorWithRed:255/255.0 green:36/255.0 blue:36/255.0 alpha:1];
    shijiHao.text = @"试机号  - - -";
    [topView addSubview:shijiHao];
	[shijiHao release];
    
    sqkaijiangY = ORIGIN_Y(topView) + 16;
    sqkaijiangView = [[UIView alloc] initWithFrame:CGRectMake(0, sqkaijiangY, 300, 19)];
    [normalScrollView addSubview:sqkaijiangView];
    sqkaijiangView.backgroundColor = [UIColor clearColor];
    
    //摇一注
    yaoImage = [[UIImageView alloc] init];
    yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
    yaoImage.frame = CGRectMake(20, 0, 21, 19);
    [sqkaijiangView addSubview:yaoImage];
    
    sqkaijiang211 = [[ColorView alloc] initWithFrame:CGRectMake(ORIGIN_X(yaoImage) + 2, 1, sqkaijiangView.frame.size.width - (ORIGIN_X(yaoImage) + 1), sqkaijiangView.frame.size.height - 1)];
    sqkaijiang211.backgroundColor = [UIColor clearColor];
    sqkaijiang211.font = [UIFont systemFontOfSize:14];
    sqkaijiang211.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
    sqkaijiang211.colorfont = [UIFont systemFontOfSize:14];
    sqkaijiang211.changeColor = [UIColor colorWithRed:255/255.0 green:36/255.0 blue:36/255.0 alpha:1];
    [sqkaijiangView addSubview:sqkaijiang211];
	
	redTitleArray = [[NSArray alloc] initWithObjects:@"百位",@"十位",@"个位",@"和值",@"和值",@"和值", nil];
    redDescArray = [[NSArray alloc] initWithObjects:@"至少选1个号",@"至少选1个号",@"至少选1个号",@"至少选1个号",@"至少选1个号",@"至少选1个号", nil];
    
    CGRect ballRect;
    UIView * lastView;
    firstViewY = ORIGIN_Y(sqkaijiangView) + 13;
    
	for (int i = 0; i < 6; i++) {
        if (i < 3) {
            UIImageView *firstView = [[UIImageView alloc] init];
            firstView.tag = 1010 +i;
            firstView.backgroundColor = [UIColor clearColor];
            if (SWITCH_ON) {
                firstView.frame = CGRectMake(0, firstViewY + i * 173, 320, 150);
            }else{
                firstView.frame = CGRectMake(0, firstViewY + i * 145, 320, 122);
            }
//            firstView.image = UIImageGetImageFromName(@"TZAHBG960.png");
            firstView.userInteractionEnabled = YES;
            lastView = firstView;
            
            UIImageView * redTitleImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53.5, 21.5)] autorelease];
            redTitleImageView.tag = 200;
            redTitleImageView.image = UIImageGetImageFromName(@"LeftTitleRed.png");
            [firstView addSubview:redTitleImageView];
            
            UILabel * redTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(14, 0, redTitleImageView.frame.size.width - 14, redTitleImageView.frame.size.height)] autorelease];
            redTitleLabel.backgroundColor = [UIColor clearColor];
            redTitleLabel.font = [UIFont systemFontOfSize:14];
            redTitleLabel.textColor = [UIColor whiteColor];
            redTitleLabel.tag = 107;
            [redTitleImageView addSubview:redTitleLabel];
            redTitleLabel.text = [redTitleArray objectAtIndex:i];
            
            UILabel * redDescLabel = [[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(redTitleImageView) + 10, redTitleImageView.frame.origin.y, 200, redTitleImageView.frame.size.height)] autorelease];
            redDescLabel.backgroundColor = [UIColor clearColor];
            redDescLabel.font = [UIFont systemFontOfSize:12];
            redDescLabel.tag = 108;
            redDescLabel.textColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
            [firstView addSubview:redDescLabel];
            redDescLabel.text = [redDescArray objectAtIndex:i];
            
            if (i == 0) {
                UIImageView * louImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(redTitleImageView) + 14 + 36 + 1.5, 18, 14)] autorelease];
                louImageView.image = UIImageGetImageFromName(@"LeftTitleYilou.png");
                louImageView.tag = 111;
                [firstView addSubview:louImageView];
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
            }

            GCBallView * lastBallView;

            for (int j = 0; j<10; j++) {
                int a= j/6,b = j%6;
                NSString *num = [NSString stringWithFormat:@"%d",j];

                if (SWITCH_ON) {
                    ballRect = CGRectMake(b * 51 + 15, a * 61+ ORIGIN_Y(redTitleImageView) + 14, 36, 36);
                }else{
                    ballRect = CGRectMake(b * 51 + 15, a * 47 + ORIGIN_Y(redTitleImageView) + 14, 36, 36);
                }
                GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorRed];
                [firstView addSubview:im];
                im.isBlack = YES;
                im.tag = j;
                im.gcballDelegate = self;
                if (!SWITCH_ON) {
                    im.ylLable.hidden = YES;
                }
                lastBallView = im;
                [im release];
            }
            [normalScrollView addSubview:firstView];
            [firstView release];
            
            GifButton * trashButton = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(ORIGIN_X(lastBallView) + 15, lastBallView.frame.origin.y, 0, 0)] autorelease];
            trashButton.tag = 333;
            trashButton.delegate = self;
            [firstView addSubview:trashButton];
        }
        else{
            UIImageView *firstView = [[UIImageView alloc] init];
            firstView.tag = 1010 + i;
            
            UIImageView * redTitleImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53.5, 21.5)] autorelease];
            redTitleImageView.tag = 200;
            redTitleImageView.image = UIImageGetImageFromName(@"LeftTitleRed.png");
            [firstView addSubview:redTitleImageView];
            
            UILabel * redTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(14, 0, redTitleImageView.frame.size.width - 14, redTitleImageView.frame.size.height)] autorelease];
            redTitleLabel.backgroundColor = [UIColor clearColor];
            redTitleLabel.font = [UIFont systemFontOfSize:14];
            redTitleLabel.textColor = [UIColor whiteColor];
            redTitleLabel.tag = 500;
            [redTitleImageView addSubview:redTitleLabel];
            redTitleLabel.text = [redTitleArray objectAtIndex:i];
            
            UILabel * redDescLabel = [[[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(redTitleImageView) + 10, redTitleImageView.frame.origin.y, 200, redTitleImageView.frame.size.height)] autorelease];
            redDescLabel.backgroundColor = [UIColor clearColor];
            redDescLabel.font = [UIFont systemFontOfSize:12];
            redDescLabel.tag = 501;
            redDescLabel.textColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1];
            [firstView addSubview:redDescLabel];
            redDescLabel.text = [redDescArray objectAtIndex:i];
            
            UIImageView * louImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(redTitleImageView) + 14 + 36 + 1.5, 18, 14)] autorelease];
            louImageView.image = UIImageGetImageFromName(@"LeftTitleYilou.png");
            louImageView.tag = 111;
            [firstView addSubview:louImageView];
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
            
            if (SWITCH_ON) {
                if (i == 5) {
                    firstView.frame = CGRectMake(0, firstViewY, 320, 274);
                }else{
                    firstView.frame = CGRectMake(0, firstViewY, 320, 335);
                }
            }else{
                if (i == 5) {
                    firstView.frame = CGRectMake(0, firstViewY, 320, 216);
                }else{
                    firstView.frame = CGRectMake(0, firstViewY, 320, 263);
                }
            }
            
            firstView.backgroundColor = [UIColor clearColor];
            firstView.userInteractionEnabled = YES;
            
            CGRect ballRect;
            int number = 1;
            int count = 26;
            if (i == 3) {
                number = 0;
                count = 28;
            }else if (i == 5) {
                number = 3;
                count = 22;
            }
            
            GCBallView * lastBallView;

            for (int j = 0; j < count; j++) {
                int a= j/6,b = j%6;
                NSString *num2 = [NSString stringWithFormat:@"%d",j + number];
                if (j + number < 10) {
                    num2 = [NSString stringWithFormat:@"0%d",j + number];
                }
                
                if (SWITCH_ON) {
                    ballRect = CGRectMake(b * 51 + 15, a * 61+ ORIGIN_Y(redTitleImageView) + 14, 36, 36);
                }else{
                    ballRect = CGRectMake(b * 51 + 15, a * 47 + ORIGIN_Y(redTitleImageView) + 14, 36, 36);
                }
                
                GCBallView *im2 = [[GCBallView alloc] initWithFrame:ballRect Num:num2 ColorType:GCBallViewColorRed];
                [firstView addSubview:im2];
                im2.tag = j;
                im2.isBlack = YES;
                im2.gcballDelegate = self;
                if (!SWITCH_ON) {
                    im2.ylLable.hidden = YES;
                }
                [im2 release];
                lastBallView = im2;
            }
            [normalScrollView addSubview:firstView];
            [firstView release];
            
            GifButton * trashButton = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(ORIGIN_X(lastBallView) + 15, lastBallView.frame.origin.y, 0, 0)] autorelease];
            trashButton.tag = 333;
            trashButton.delegate = self;
            [firstView addSubview:trashButton];
        }
    }
    
//    UIButton * upgradeButton = [[[UIButton alloc] initWithFrame:CGRectMake(320 - 65 - 15, firstViewY, 65, 21)] autorelease];
//    [normalScrollView addSubview:upgradeButton];
//    [upgradeButton setBackgroundImage:UIImageGetImageFromName(@"3D_Upgrade.png") forState:UIControlStateNormal];
//    [upgradeButton addTarget:self action:@selector(upgradeButton) forControlEvents:UIControlEventTouchUpInside];
    
    endTimelable = [[ColorView alloc] initWithFrame:CGRectMake(175, ORIGIN_Y(lastView) + 12, 150, 20)];
    [normalScrollView addSubview:endTimelable];
    endTimelable.backgroundColor = [UIColor clearColor];
    endTimelable.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
    endTimelable.font = [UIFont systemFontOfSize:12];
    if (self.myissueRecord) {
        endTimelable.text = [NSString stringWithFormat:@"截止时间 %@",[SharedMethod changeDateToNoYearNoSecond:self.myissueRecord.curEndTime]];
    }
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height -44, 320, 44)];
	im.tag = 1201;
//---------------------------------------------------bianpimghua by sichuanlin
//    im.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    im.backgroundColor = [UIColor colorWithRed:20/255.0 green:19/255.0 blue:19/255.0 alpha:1];
	im.userInteractionEnabled = YES;
    [self.view addSubview:im];
    
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
    [im addSubview:senBtn];
    senBtn.backgroundColor = [UIColor clearColor];
    [senBtn setTitle:@"机选" forState:UIControlStateNormal];
    [senBtn setTitleColor:[UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [senBtn setTitleColor:[UIColor colorWithRed:63/255.0 green:59/255.0 blue:47/255.0 alpha:1] forState:UIControlStateDisabled];

    senBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [im release];
}

//-(void)upgradeButton
//{
//    [upgradeRequest clearDelegatesAndCancel];
//    self.upgradeRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:@"74851118"]];
//    [upgradeRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//    [upgradeRequest setDelegate:self];
//    [upgradeRequest setDidFinishSelector:@selector(upgradeFinished:)];
//    [upgradeRequest setTimeOutSeconds:20.0];
//    [upgradeRequest startAsynchronous];
//}

- (void)upgradeFinished:(ASIHTTPRequest *)request {
	NSString *responseStr = [request responseString];
    if (responseStr && ![responseStr isEqualToString:@"fail"]) {
        YtTopic *mStatus = [[YtTopic alloc] initWithParse:responseStr];
        
        DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus arrayList] objectAtIndex:0]];
        [detailed setHidesBottomBarWhenPushed:NO];
        [self.navigationController pushViewController:detailed animated:YES];
        [detailed release];
        
        [mStatus release];
    }
}


- (void)LoadIpadView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(50 + 35, 0, 270, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.userInteractionEnabled = YES;
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    if (modetype == ThreeDzhixuanfushi) {
        titleLabel.text = @"直选";
    }
    else if (modetype == ThreeDzhixuanhezhi) {
        titleLabel.text = @"直选和值";
    }
    else if (modetype == ThreeDzhixuandantuo) {
        titleLabel.text = @"直选胆拖";
    }
    else if (modetype == ThreeDzuliufushi) {
        titleLabel.text = @"组六";
    }
    else {
        titleLabel.text = @"组三";
    }
    
    if (self.myissueRecord) {
        if ([self.myissueRecord.curIssue length] == 5) {
            self.myissueRecord.curIssue = [NSString stringWithFormat:@"20%@", self.myissueRecord.curIssue];
        }
        else {
            self.myissueRecord.curIssue = self.myissueRecord.curIssue;
        }
        
        titleLabel.text = [NSString stringWithFormat:@"%@%@期",titleLabel.text,[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]];
    }
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.tag = 789;
    
//    CGSize labelSize = [titleLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:UILineBreakModeCharacterWrap];
    
//    UILabel *JTLabel = [[UILabel alloc] init];
//    JTLabel.backgroundColor = [UIColor clearColor];
//    JTLabel.textAlignment = NSTextAlignmentCenter;
//    JTLabel.font = [UIFont systemFontOfSize:12];
//    JTLabel.text = @"▼";
//    JTLabel.textColor = [UIColor whiteColor];
//    JTLabel.shadowColor = [UIColor blackColor];
//    JTLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
//    JTLabel.tag = 567;

     sanjiaoImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]] autorelease];
    [titleView addSubview:sanjiaoImageView];
    sanjiaoImageView.tag = 567;
    
    if ([[[Info getInstance] userId] intValue] == 0) {
        titleLabel.frame = CGRectMake(23, 0, 220, 44);
//        sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + labelSize.width + 1, 13.5, 18, 18);
    }else {
        
        titleLabel.frame = CGRectMake(38, 0, 220, 44);
//        sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + labelSize.width + 1, 13.5, 18, 18);
    }
//    [titleView addSubview:sanjiaoImageView];
//    [JTLabel release];
    
    UIButton *titleButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton3.frame = CGRectMake(0, 0, 270, 44);
    titleButton3.backgroundColor = [UIColor clearColor];
    [titleButton3 addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleButton3 addSubview:titleLabel];
    [titleView addSubview:titleButton3];
    self.CP_navigation.titleView = titleView;
    [titleLabel release];
    [titleView release];
    
    //摇一注
    yaoImage = [[UIImageView alloc] init];
    yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
    yaoImage.frame =CGRectMake(15 + 35, 42, 15, 15);
    [self.mainView addSubview:yaoImage];
    [yaoImage release];
    
    //单注奖金提示
    UILabel *sqkaijiang21 = [[UILabel alloc] initWithFrame:CGRectMake(37 + 35, 45, 48, 11)];
    sqkaijiang21.textAlignment = NSTextAlignmentLeft;
    sqkaijiang21.backgroundColor = [UIColor clearColor];
    sqkaijiang21.font = [UIFont boldSystemFontOfSize:9];
    sqkaijiang21.text = @"单注奖金";
    sqkaijiang21.textColor = [UIColor blackColor];
    [self.mainView addSubview:sqkaijiang21];
    [sqkaijiang21 release];
    
    sqkaijiang211 = [[ColorView alloc] initWithFrame:CGRectMake(76 + 35, 43, 48, 13)];
    sqkaijiang211.textAlignment = NSTextAlignmentLeft;
    sqkaijiang211.backgroundColor = [UIColor clearColor];
    sqkaijiang211.font = [UIFont boldSystemFontOfSize:12];
    sqkaijiang211.text = @"1000";
    sqkaijiang211.textColor = [UIColor redColor];
    [self.mainView addSubview:sqkaijiang211];
    [sqkaijiang211 release];
    UILabel *sqkaijiang2111 = [[UILabel alloc] initWithFrame:CGRectMake(105 + 35, 45, 48, 11)];
    sqkaijiang2111.textAlignment = NSTextAlignmentLeft;
    sqkaijiang2111.backgroundColor = [UIColor clearColor];
    sqkaijiang2111.font = [UIFont boldSystemFontOfSize:9];
    sqkaijiang2111.text = @"元";
    sqkaijiang2111.textColor = [UIColor blackColor];
    [self.mainView addSubview:sqkaijiang2111];
    [sqkaijiang2111 release];
	
    //上期开奖
    UIImageView *sqkjImage = [[UIImageView alloc] initWithFrame:CGRectMake(199 + 35, 15, 110, 45)];
    sqkjImage.image = [UIImageGetImageFromName(@"sqkjbg960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    sqkjImage.userInteractionEnabled = YES;
    [self.mainView addSubview:sqkjImage];
    [sqkjImage release];
    UIImageView *xian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 22.5, 110, 2)];
    xian.backgroundColor  = [UIColor clearColor];
    xian.image = [UIImage imageNamed:@"SZTG960.png"] ;
    [sqkjImage addSubview:xian];
    [xian release];
    UILabel *sqkjLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 50, 11)];
    sqkjLabel.backgroundColor = [UIColor clearColor];
    sqkjLabel.text = @"上期开奖：";
    sqkjLabel.font = [UIFont systemFontOfSize:9];
    [sqkjImage addSubview:sqkjLabel];
    [sqkjLabel release];
    sqkaijiang = [[ColorView alloc] initWithFrame:CGRectMake(60, 8, 80, 11)];
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.font = [UIFont boldSystemFontOfSize:9];
    NSLog(@"上期开奖：%@",self.myissueRecord.lastLotteryNumber);
    if (self.myissueRecord) {
        sqkaijiang.text = [[NSString stringWithFormat:@"%@",self.myissueRecord.lastLotteryNumber] stringByReplacingOccurrencesOfString:@"," withString:@"  "];
    }
    sqkaijiang.textColor = [UIColor redColor];
    [sqkjImage addSubview:sqkaijiang];
	[sqkaijiang release];
    
    UILabel *sjhLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 50, 11)];
    sjhLabel.backgroundColor = [UIColor clearColor];
    sjhLabel.text = @"试机号码：";
    sjhLabel.font = [UIFont systemFontOfSize:9];
    [sqkjImage addSubview:sjhLabel];
    [sjhLabel release];
    
    shijiHao = [[ColorView alloc] initWithFrame:CGRectMake(60, 30, 100, 11)];
    shijiHao.backgroundColor = [UIColor clearColor];
    shijiHao.font = [UIFont boldSystemFontOfSize:9];
    shijiHao.textColor = [UIColor redColor];
    [sqkjImage addSubview:shijiHao];
	[shijiHao release];
	
	NSArray *array = [NSArray arrayWithObjects:@"百",@"十",@"个",nil];
    NSArray *array2 = [NSArray arrayWithObjects:@"①",@"①",@"①",nil];
	for (int i = 0; i<3; i++) {
		UIImageView *firstView = [[UIImageView alloc] init];
		firstView.tag = 1010 +i;
        firstView.backgroundColor = [UIColor clearColor];
		firstView.frame = CGRectMake(10 + 35, 70 + i*96, 300.5, 91.5);
        firstView.image = UIImageGetImageFromName(@"TZAHBG960.png");
		firstView.userInteractionEnabled = YES;
        UILabel *label = [[UILabel alloc] init];
		label.backgroundColor = [UIColor clearColor];
        label.text = [array objectAtIndex:i];
        label.textColor = [UIColor whiteColor];
        label.shadowColor = [UIColor blackColor];
        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		[firstView addSubview:label];
		label.tag = 107;
        label.numberOfLines = 0;
		label.frame = CGRectMake(7, 5, 20, 60);
		[label release];
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(7, 50, 23, 23)];
        label2.backgroundColor = [UIColor clearColor];
        label2.text = [array2 objectAtIndex:i];
        label2.textColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
        label2.font = [UIFont boldSystemFontOfSize:16];
        label2.tag = 108;
        [firstView addSubview:label2];
        [label2 release];
		for (int j = 0; j<10; j++) {
			int a= j/5,b = j%5;
			NSString *num = [NSString stringWithFormat:@"%d",j];
			GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*42+65, a*37+7, 35, 36) Num:num ColorType:GCBallViewColorRed];
			[firstView addSubview:im];
            im.isBlack = YES;
			im.tag = j;
			im.gcballDelegate = self;
			[im release];
		}
		[self.mainView addSubview:firstView];
		[firstView release];
	}
    
    endTimelable = [[ColorView alloc] initWithFrame:CGRectMake(162 + 35, 355, 150, 20)];
    [self.mainView addSubview:endTimelable];
    endTimelable.backgroundColor = [UIColor clearColor];
    endTimelable.changeColor = [UIColor lightGrayColor];
    endTimelable.font = [UIFont boldSystemFontOfSize:9];
    endTimelable.colorfont = [UIFont boldSystemFontOfSize:9];
    if (self.myissueRecord) {
        endTimelable.text = [NSString stringWithFormat:@"截止时间 <%@>",self.myissueRecord.curEndTime];
    }
    [endTimelable release];
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 748 - 88, 390, 44)];
	
    im.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
	im.userInteractionEnabled = YES;
    [self.mainView addSubview:im];
    
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
	
        UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = left;
        if ([[[Info getInstance] userId] intValue] == 0) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
//---------------------------------------bianpinghua by sichuanlin
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
            [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            rightItem.enabled = YES;
            [self.CP_navigation setRightBarButtonItem:rightItem];
            [rightItem release];
        }
    
    
    wanArray = [[NSMutableArray alloc] initWithObjects:
                @{@"title": @"普通投注", @"choose": @[@"直选", @"组三单式", @"组三复式", @"组六"]},
                @{@"title": @"和值投注", @"choose": @[@"直选", @"组三", @"组六"]}, nil];
//                @{@"title": @"胆拖投注", @"choose": @[@"组三", @"组六"]}, nil];

    NSMutableArray * conArray = [NSMutableArray arrayWithObjects:@"1",@"0",@"0",@"0", nil];
    NSMutableArray * conArray1 = [NSMutableArray arrayWithObjects:@"0", @"0",@"0",nil];
//    NSMutableArray * conArray2 = [NSMutableArray arrayWithObjects:@"0",@"0", nil];
    controlArray = [[NSMutableArray alloc] initWithObjects:
                    @{@"title": @"普通投注", @"choose": conArray},
                    @{@"title": @"和值投注", @"choose": conArray1}, nil];
//                    @{@"title": @"胆拖投注", @"choose": conArray2}, nil];
    
    
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

    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
    if (modetype == ThreeDzhixuanfushi) {
        sender.tag = 100;
    }
    else if (modetype == ThreeDzusandanshi) {
        sender.tag = 101;
    }
    else if (modetype == ThreeDzusanfushi) {
        sender.tag = 102;
    }
    else if (modetype == ThreeDzuliufushi) {
        sender.tag = 103;
    }
    else if (modetype == ThreeDzhixuanhezhi) {
        sender.tag = 200;
    }
    else if (modetype == ThreeDzusanHezhi) {
        sender.tag = 201;
    }
    else if (modetype == ThreeDzuliuHezhi) {
        sender.tag = 202;
    }
    [self pressBgButton:sender];
    [self ballSelectChange:nil];
    [self getWanqi];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self changeFrame];
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
    [infoViewController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.myissueRecord = nil;
    self.wangQi = nil;
    [myRequest clearDelegatesAndCancel];
    [qihaoReQuest clearDelegatesAndCancel];
    self.qihaoReQuest = nil;
    [myRequest release];
    [normalScrollView release];
    [yilouRequest clearDelegatesAndCancel];
    self.yilouRequest = nil;
    self.yilouDic = nil;
    self.yiLouDataArray = nil;
    [allYiLouRequest clearDelegatesAndCancel];
    self.allYiLouRequest = nil;
    [titleYiLou1 release];
    [titleYiLou2 release];
    [titleYiLou3 release];
    [redraw1 release];
    [redraw2 release];
    [redraw3 release];
    [headbgImage release];
    
    [titleScrollView release];
    [threeDScrollView release];
    
    [titleScrollView1 release];
    [threeDScrollView1 release];
    
    [myPageControl release];
    [myPageControl1 release];

    [wanArray release];
    [controlArray release];
    
    [sqkaijiangView release];
    [yaoImage release];
    
    [loadview release];
    
    [redTitleArray release];
    [redDescArray release];
    
    [endTimelable release];
    [sqkaijiang211 release];

    [zhushuLabel release];
	[jineLabel release];

//    [upgradeRequest clearDelegatesAndCancel];
//    self.upgradeRequest = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark CP_KindsOfChooseDelegate

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt {
//    if (buttonIndex == 1) {
        self.showYiLou = NO;
//        for (int i = 0; i < returnarry.count; i++) {
//            for (int j = 0; j < [[returnarry objectAtIndex:i] count]; j++) {
//                if ([[[returnarry objectAtIndex:i] objectAtIndex:j] isEqualToString:@"1"]) {
//                    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
//                    sender.tag = (i + 1) * 100 + j;
//                    [self pressBgButton:sender];
//                }
//            }
//        }
    if ([returnarry count] == 1) {
        UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
        [SharedMethod sanJiaoGuan:sanjiao];

//        NSString *wanfaname = [returnarry objectAtIndex:0];
//        NSInteger tag = [wanfaArray indexOfObject:wanfaname];
//        if (tag >= 0 && tag < 100) {
            UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
            sender.tag =buttonIndex;
            [self pressBgButton:sender];
//        }
    }

//    }
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
    NSLog(@"~~~~~~%@",imageView);
    if (modetype == ThreeDzusanDantuo || modetype == ThreeDzuliuDantuo) {
        if (imageView.superview.tag == 1010) {
            NSInteger dan = 0;
            for (GCBallView *ball in imageView.superview.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]&& ball.selected) {
                    dan++;
                    if (dan>=2  && modetype == ThreeDzusanDantuo) {
                        [[caiboAppDelegate getAppDelegate] showMessage:@"胆码最多选1个"];
                        imageView.selected = NO;
                    }
                    else if (dan > 2 && modetype == ThreeDzuliuDantuo) {
                        [[caiboAppDelegate getAppDelegate] showMessage:@"胆码最多选2个"];
                        imageView.selected = NO;
                    }
                }
            }
            UIView *v = [self.mainView viewWithTag:1011];
            for (GCBallView *ball in v.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]&& ball.selected) {
                    if (ball.tag == imageView.tag) {
                        [[caiboAppDelegate getAppDelegate] showMessage:@"胆码与拖码球号不可重复选择"];
                        imageView.selected = NO;
                    }
                }
            }
        }
        else {
            UIView *v = [self.mainView viewWithTag:1010];
            for (GCBallView *ball in v.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]&& ball.selected) {
                    if (ball.tag == imageView.tag) {
                        [[caiboAppDelegate getAppDelegate] showMessage:@"胆码与拖码球号不可重复选择"];
                        imageView.selected = NO;
                    }
                }
            }
        }
        
    }else if (modetype == ThreeDzusandanshi) {
        int viewTag = 99999;
        if (imageView.superview.tag == 1010) {
            int i = 0;
            for (UIButton *btn in imageView.superview.subviews) {
                if ([btn isKindOfClass:[UIButton class]]&&btn.selected == YES) {
                    i++;
                    if (i > 1) {
                        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                        [cai showMessage:@"重号只能选1个"];
                        imageView.selected = NO;
                        return;
                    }
                }
            }
            viewTag = 1011;
        }else if (imageView.superview.tag == 1011){
            int i = 0;
            for (UIButton *btn in imageView.superview.subviews) {
                if ([btn isKindOfClass:[UIButton class]]&&btn.selected == YES) {
                    i++;
                    if (i > 1) {
                        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                        [cai showMessage:@"单号只能选1个"];
                        imageView.selected = NO;
                        return;
                    }
                }
            }
            viewTag = 1010;
        }
        GCBallView * ballView = (GCBallView *)[[normalScrollView viewWithTag:viewTag] viewWithTag:imageView.tag];
        if (ballView.selected) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"重号和单号不能重复"];
            imageView.selected = NO;
            return;
        }

    }
    NSUInteger bets = [GC_LotteryUtil getBets:[self seletNumber] LotteryType:TYPE_3D ModeType:modetype];
	if (bets < 1) {
		senBtn.enabled = NO;
	}
	else {
		senBtn.enabled = YES;
	}
    
	zhushuLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)bets];
	jineLabel.text = [NSString stringWithFormat:@"%lu",2*(unsigned long)bets];

    NSString *str = [[[self seletNumber] stringByReplacingOccurrencesOfString:@"e" withString:@""]                      stringByReplacingOccurrencesOfString:@"," withString:@""];
    if (modetype == ThreeDzusanfushi || modetype == ThreeDzhixuanfushi || modetype == ThreeDzuliufushi || modetype == ThreeDzusandanshi) {
        if ([str length] == 0) {
            [senBtn setTitle:@"机选" forState:UIControlStateNormal];
        }
        else {
            [senBtn setTitle:@"选好了" forState:UIControlStateNormal];
        }
        senBtn.enabled = YES;
    }
    if (modetype == ThreeDzhixuanhezhi || modetype == ThreeDzusanHezhi || modetype == ThreeDzuliuHezhi || modetype == ThreeDzusanDantuo || modetype == ThreeDzuliuDantuo) {
        [senBtn setTitle:@"选好了" forState:UIControlStateNormal];
        if (!([str length] == 0)) {
            senBtn.enabled = YES;
        }else if ([str length] == 0) {
            senBtn.enabled = NO;
        }
    }
    if (self.showYiLou) {
        [self changeFrame];
    }
}


#pragma mark -
#pragma mark ASIHTTPRequestDelegate 

- (void)reqWangQiKaiJiang:(ASIHTTPRequest*)request {
	if ([request responseData]) {
		WangqiKaJiangList *wang = [[WangqiKaJiangList alloc] initWithResponseData:[request responseData] WithRequest:request];
		self.wangQi = wang;
        if (self.myissueRecord) {
            KaiJiangInfo *info = [self.wangQi.brInforArray firstObject];
            if (info) {
                float a = [self.myissueRecord.curIssue floatValue] - [info.issue floatValue];
                if (a > 1 && a < 100) {
                    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"fucai3djieqi"] isEqualToString:self.myissueRecord.curIssue]) {
                        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"为了保证您购彩成功，网络购彩会比官方截期时间早，今日开奖期次销售已截止，您将购买%@期，祝您中奖！",[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                        [[NSUserDefaults standardUserDefaults] setValue:self.myissueRecord.curIssue forKey:@"fucai3djieqi"];
                    }
                    else {
                        
                        [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"为了保证您购彩成功，网络购彩会比官方截期时间早，今日开奖期次销售已截止，您将购买%@期，祝您中奖！",[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]]];
                    }
                }
            }
        }
        [_cpTableView reloadData];
        [wang release];
        
        NSMutableArray * historyArr = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
        [historyArr addObject:@[@"期号",@"开奖号",@"形态",@"试机号"]];
        for (int i = 0; i < 5; i++) {
            NSMutableArray * dataArray = [[NSMutableArray alloc] initWithCapacity:10];
            KaiJiangInfo * info = [wang.brInforArray objectAtIndex:i];
            
            [dataArray addObject:[NSString stringWithFormat:@"%@期",[SharedMethod getLastThreeStr:info.issue]]];
            NSString * numberString = [info.num stringByReplacingOccurrencesOfString:@"," withString:@"  "];
            NSArray * numberArray = [numberString componentsSeparatedByString:@"@"];
            if ([numberArray count]) {
                [dataArray addObject:[numberArray objectAtIndex:0]];
            }else{
                [dataArray addObject:@""];
            }

            int sameCount = 0;
            if (numberArray.count > 1) {
                sameCount = [SharedMethod getSortSameCountByArray:[[numberArray objectAtIndex:0] componentsSeparatedByString:@"  "]];
            }else{
                sameCount = [SharedMethod getSortSameCountByArray:[numberString componentsSeparatedByString:@"  "]];
            }
            
            if (sameCount == 0) {
                [dataArray addObject:@"组六"];
            }
            else if (sameCount == 1) {
                [dataArray addObject:@"组三"];
            }
            else if (sameCount == 2) {
                [dataArray addObject:@"豹子"];
            }
            if (numberArray.count > 1) {
                [dataArray addObject:[numberArray objectAtIndex:1]];
            }else{
                [dataArray addObject:@""];
            }
            
            [historyArr addObject:dataArray];
            [dataArray release];
        }
        [self addHistoryWithArray:historyArr];
	}
}

- (void)reqLotteryInfoFinished:(ASIHTTPRequest*)request {
	if ([request responseData]) {
		
		IssueRecord *issrecord = [[IssueRecord alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (issrecord.returnId == 3000) {
            [issrecord release];
            return;
        }
        [self.myRequest clearDelegatesAndCancel];
        
        if (![myIssrecord isEqualToString:issrecord.curIssue]) {
            [self request3DYiLouWithType:1];
//            [self getYilou];
            myIssrecord = issrecord.curIssue;
        }
        self.myissueRecord = issrecord;
        if ([self.myissueRecord.curIssue length] == 5) {
            self.myissueRecord.curIssue = [NSString stringWithFormat:@"20%@", self.myissueRecord.curIssue];
        }
        else {
            self.myissueRecord.curIssue = self.myissueRecord.curIssue;
        }

        NSArray *array = [self.myissueRecord.lastLotteryNumber componentsSeparatedByString:@"#"];
        NSString *num = @"";
        if ([array count] > 1) {
            num = [array objectAtIndex:1];
        }
        else {
            num = [array objectAtIndex:0];
        }
        sqkaijiang.text = [[NSString stringWithFormat:@"上期开奖  <%@>",num] stringByReplacingOccurrencesOfString:@"," withString:@"  "];
        if (self.myissueRecord) {
            endTimelable.text = [NSString stringWithFormat:@"截止时间 %@",[SharedMethod changeDateToNoYearNoSecond:self.myissueRecord.curEndTime]];
        }
        if ([self.wangQi.brInforArray count] > 0) {
            KaiJiangInfo *info = [self.wangQi.brInforArray firstObject];
            if (info) {
                float a = [self.myissueRecord.curIssue floatValue] - [info.issue floatValue];
                if (a > 1 && a < 100) {
                    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"fucai3djieqi"] isEqualToString:self.myissueRecord.curIssue]) {
                        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"为了保证您购彩成功，网络购彩会比官方截期时间早，今日开奖期次销售已截止，您将购买%@期，祝您中奖！",self.myissueRecord.curIssue] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                        [[NSUserDefaults standardUserDefaults] setValue:self.myissueRecord.curIssue forKey:@"fucai3djieqi"];
                    }
                    else {
                        
                        [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"为了保证您购彩成功，网络购彩会比官方截期时间早，今日开奖期次销售已截止，您将购买%@期，祝您中奖！",self.myissueRecord.curIssue]];
                    }
                }
            }
        }
        [issrecord release];
        [self titleCHange];
        [self getShijiHao];
    }
}

//- (void)getYilou {
//    [yilouRequest clearDelegatesAndCancel];
//    self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetYL:@"3d"  Item:@"1"]];
//    [yilouRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
//    [yilouRequest setDelegate:self];
//    [yilouRequest setDidFinishSelector:@selector(reqYilouFinished:)];
//    [yilouRequest startAsynchronous];
//}

//- (void)reqYilouFinished:(ASIHTTPRequest*)request {
//    NSString *responseStr = [request responseString];
//    if (responseStr&&![responseStr isEqualToString:@"fail"]) {
//        NSArray * array = [responseStr JSONValue];
//        NSLog(@"%@",array);
//        if ([array count] >= 1) {
//            self.yilouDic = [array objectAtIndex:0];
//        }
//    }
//    [self titleCHange];
//}

-(void)displayZuDan
{
    [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1011] dictionary:[self.yilouDic objectForKey:@"dwt"] typeStr:@"zs"];
    [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1010] dictionary:[self.yilouDic objectForKey:@"dwt"] typeStr:@"zs"];
}

-(void)displayZhiXuanYiLou
{
    [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1012] dictionary:[self.yilouDic objectForKey:@"dwt"] typeStr:@"三"];
    [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1011] dictionary:[self.yilouDic objectForKey:@"dwt"] typeStr:@"二"];
    [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1010] dictionary:[self.yilouDic objectForKey:@"dwt"] typeStr:@"一"];
}

- (void)reqgetShijiHaoFinished:(ASIHTTPRequest*)request {
    if ([request responseData]) {
		
		ShiJiHaoJieXi *shijihao = [[ShiJiHaoJieXi alloc] initWithResponseData:[request responseData] WithRequest:request];
		
        if (shijihao.returnId != 3000) {
			[self.myRequest clearDelegatesAndCancel];
            if ([shijihao.shiJiNum length]) {
                shijiHao.text = [NSString stringWithFormat:@"试机号  <%@>",shijihao.shiJiNum];
            }else{
                shijiHao.text = @"试机号  - - -";
            }
        }
        [shijihao release];
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

-(void)animationCompleted:(GifButton *)gifButton
{
    [self ballSelectChange:nil];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    