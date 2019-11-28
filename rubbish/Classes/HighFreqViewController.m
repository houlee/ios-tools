//
//  HighFreqViewController.m
//  caibo
//
//  Created by  on 12-6-13.
//  Copyright (c) 2012年 vodone. All rights reserved.
//

#import "HighFreqViewController.h"
#import "caiboAppDelegate.h"
#import "Info.h"
#import "Xieyi365ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "GC_LotteryUtil.h"
#import "ShakeView.h"
#import "GouCaiShuZiInfoViewController.h"
#import "GC_LotteryUtil.h"
#import "GC_IssueInfo.h"
#import "WangqiKaJiangList.h"
#import "WangQiZhongJiang.h"
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
//#import "n115yilouViewController.h"
#import "LotteryListViewController.h"
#import "MobClick.h"
#import "NetURL.h"
#import "JSON.h"
#import "YiLouUnderGCBallView.h"
#import "redrawView.h"
#import "YiLouChartData.h"
#import "New_PageControl.h"
#import "UITitleYiLouView.h"
#import "ChartDefine.h"
#import "SharedMethod.h"
#import "SharedDefine.h"

@implementation HighFreqViewController

@synthesize issue;
@synthesize myRequest,qihaoReQuest;
@synthesize myTimer,runTimer;
@synthesize zhongJiang;
@synthesize lotterytype;
@synthesize yilouRequest;
@synthesize yilouDic, httpRequest, yiLouDataArray;
@synthesize myIssrecord;
@synthesize modetype;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (id)initWithElevenType:(ElevenType)elevenType
{
	self = [super init];
    if (self) {
        myElevenType = elevenType;
        
        NSInteger type = 0;
        
        int count = 0;
        
        if (myElevenType == ShanDong11) {
            myLotteryID = LOTTERY_ID_SHANDONG_11;
            type = [[[NSUserDefaults standardUserDefaults] valueForKey:@"11Xuan5DefaultModetype"] integerValue];
        }
        else if (myElevenType == GuangDong11) {
            myLotteryID = LOTTERY_ID_GUANGDONG_11;
            type = [[[NSUserDefaults standardUserDefaults] valueForKey:@"GD11Xuan5DefaultModetype"] integerValue];
            count = 1000;
        }
        else if (myElevenType == JiangXi11) {
            myLotteryID = LOTTERY_ID_JIANGXI_11;
            type = [[[NSUserDefaults standardUserDefaults] valueForKey:@"JX11Xuan5DefaultModetype"] integerValue];
            count = 2000;
        }
        else if (myElevenType == HeBei11) {
            myLotteryID = LOTTERY_ID_HEBEI_11;
            type = [[[NSUserDefaults standardUserDefaults] valueForKey:@"HB11Xuan5DefaultModetype"] integerValue];
            count = 3000;
        }
        else if (myElevenType == ShanXi11) {
            myLotteryID = LOTTERY_ID_SHANXI_11;
            type = [[[NSUserDefaults standardUserDefaults] valueForKey:@"ShanXi11Xuan5DefaultModetype"] integerValue];
            count = 4000;
        }
        
        eleven5_1 = TYPE_11XUAN5_1 + count;
        eleven5_2 = TYPE_11XUAN5_2 + count;
        eleven5_3 = TYPE_11XUAN5_3 + count;
        eleven5_4 = TYPE_11XUAN5_4 + count;
        eleven5_5 = TYPE_11XUAN5_5 + count;
        eleven5_6 = TYPE_11XUAN5_6 + count;
        eleven5_7 = TYPE_11XUAN5_7 + count;
        eleven5_8 = TYPE_11XUAN5_8 + count;
        eleven5_Q2Zhi = TYPE_11XUAN5_Q2ZHI + count;
        eleven5_Q3Zhi = TYPE_11XUAN5_Q3ZHI + count;
        eleven5_Q2Zu = TYPE_11XUAN5_Q2ZU + count;
        eleven5_Q3Zu = TYPE_11XUAN5_Q3ZU + count;
        eleven5_R2DanTuo = TYPE_11XUAN5_R2DaTuo + count;
        eleven5_R3DanTuo = TYPE_11XUAN5_R3DaTuo + count;
        eleven5_R4DanTuo = TYPE_11XUAN5_R4DaTuo + count;
        eleven5_R5DanTuo = TYPE_11XUAN5_R5DaTuo + count;
        eleven5_Q2DanTuo = TYPE_11XUAN5_Q2DaTuo + count;
        eleven5_Q3DanTuo = TYPE_11XUAN5_Q3DaTuo + count;

        lotterytype = eleven5_5;
        
        modetype = M11XUAN5dingwei;
        wanArray = [[NSArray alloc] initWithObjects:@"任选二", @"任选三", @"任选四", @"任选五", @"任选六", @"任选七", @"任选八",@"前一直选", @"前二直选", @"前三直选",@"前二组选",@"前三组选", @"任选二胆拖", @"任选三胆拖", @"任选四胆拖", @"任选五胆拖",@"前二组选胆拖", @"前三组选胆拖", nil];
        
        if (type >= eleven5_1 && type <= eleven5_Q3DanTuo) {
            lotterytype = (int)type;
        }

        isVerticalBackScrollView = YES;
        self.cpLotteryName = shiyixuanwuType;
        self.headHight = DEFAULT_ISSUE_HEIGHT + NEW_PAGECONTROL_HEIGHT + 1;
        yanchiTime = 90;
        
        hasYiLou = NO;
        
        canRefreshYiLou = YES;
    }
    return self;
}

#pragma mark -
#pragma mark CP_ThreeLevelNavDelegate

-(void)toHistory
{
    [MobClick event:@"event_goucai_chakangengduo_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];
    [MobClick event:@"event_goucai_lishikaijiang_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];
    LotteryListViewController *controller = [[LotteryListViewController alloc] init];
    
    controller.lotteryId = myLotteryID;
    if (myElevenType == ShanDong11) {
        controller.lotteryName = @"山东11选5";
    }
    else if (myElevenType == GuangDong11) {
        controller.lotteryName = @"广东11选5";
    }
    else if (myElevenType == JiangXi11) {
        controller.lotteryName = @"江西11选5";
    }
    else if (myElevenType == HeBei11) {
        controller.lotteryName = @"河北11选5";
    }
    else if (myElevenType == ShanXi11) {
        controller.lotteryName = @"新11选5";
    }
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)returnSelectIndex:(NSInteger)index{
    if (index == 0) {
        [self gofenxi];
    }
    if (index == 1) {
        [self toHistory];
    }
    else if (index == 2) {
        [MobClick event:@"event_goucai_wanfaxuanze_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];
        [self pressTitleButton:nil];
    }
    else if (index == 3) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",![[[NSUserDefaults standardUserDefaults] valueForKey:@"YiLouSwitch"] integerValue]] forKey:@"YiLouSwitch"];
        [self switchChange];
        [self changeTitle];

        NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
        [alltitle addObject:@"走势图"];
        [alltitle addObject:@"历史开奖"];
        [alltitle addObject:@"玩法选择"];
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

#pragma mark - switchChange

-(void)switchChange
{
    float heght =85;
    for (int i = 1000;i<1004;i++) {
        if(i<1003)
        {
            UIView *v = [mainScrollVIew viewWithTag:i];
            
            GifButton * trashButton = (GifButton *)[v viewWithTag:333];
            GCBallView * lastBallView;
            
            UIImageView * louImageView = (UIImageView *)[v viewWithTag:111];
            
            if (SWITCH_ON) {
                v.frame = CGRectMake(0, heght, 320, 150);
                louImageView.hidden = NO;
            }else{
                v.frame = CGRectMake(0, heght, 320, 120);
                louImageView.hidden = YES;
            }
            
            for (int j = 0; j < 11; j++) {
                int a= j/6,b = j%6;
                GCBallView * ballView = (GCBallView *)[v viewWithTag:j];
                if (SWITCH_ON) {
                    ballView.frame = CGRectMake(b*51+14, a*52+35, 35, 35);
                    ballView.ylLable.hidden = NO;
                }else{
                    ballView.frame = CGRectMake(b*51+14, a*40+35, 35, 35);
                    ballView.ylLable.hidden = YES;
                }
                lastBallView=ballView;
            }
            trashButton.frame = CGRectMake(ORIGIN_X(lastBallView) + 15, lastBallView.frame.origin.y - 8, 36, 45);
            heght = heght + v.bounds.size.height-1;
        }
        else
        {
            UIView *v = [mainScrollVIew viewWithTag:i];
            
            GifButton * trashButton = (GifButton *)[v viewWithTag:333];
            GCBallView * lastBallView;
            GifButton * trashButton2 = (GifButton *)[v viewWithTag:444];
            
            UIImageView * louImageView = (UIImageView *)[v viewWithTag:111];
            UIImageView * quanIma = (UIImageView *)[v viewWithTag:2020];
            
            if (SWITCH_ON) {
                v.frame = CGRectMake(0, 85, 320, 200);
                louImageView.hidden=NO;
            }else{
                v.frame = CGRectMake(0, 85, 320, 160);
                louImageView.hidden=YES;
            }
            
            for (int j = 0; j < 11; j++) {
                int a= j/5,b = j%5;
                GCBallView * ballView = (GCBallView *)[v viewWithTag:j];
                if (SWITCH_ON) {
                    ballView.frame = CGRectMake(b*63+14, a*52+35, 35, 35);
                    ballView.ylLable.hidden = NO;
                }else{
                    ballView.frame = CGRectMake(b*63+14, a*40+35, 35, 35);
                    ballView.ylLable.hidden = YES;
                }
                lastBallView=ballView;
            }
            trashButton.frame = CGRectMake(ORIGIN_X(lastBallView) + 27, lastBallView.frame.origin.y - 8, 36, 45);

            if (SWITCH_ON)
            {
                quanIma.frame=CGRectMake(63+14+9, 2*52+35+9, 19, 19);
            }
            else
            {
                quanIma.frame=CGRectMake(63+14+9, 2*40+35+9, 19, 19);
            }
            trashButton2.frame = CGRectMake(ORIGIN_X(quanIma) + 27+7, quanIma.frame.origin.y - 9-8, 36, 45);
        }
    }
}

- (void)LoadIphoneView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(50+20, 0, 270, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.userInteractionEnabled = YES;
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.tag = 789;
    
    sanjiaoImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]] autorelease];
    [titleView addSubview:sanjiaoImageView];
    sanjiaoImageView.tag = 567;
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = titleView.bounds;
    titleButton.backgroundColor = [UIColor clearColor];
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleButton addTarget:self action:@selector(pressTitleButton1:) forControlEvents:UIControlEventTouchDown];
    [titleButton addTarget:self action:@selector(pressTitleButton2:) forControlEvents:UIControlEventTouchCancel];

    [titleView addSubview:titleLabel];
    [titleView addSubview:titleButton];
    self.CP_navigation.titleView = titleView;
    [titleView release];
    
    image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, TOPVIEW_HEIGHT)];
	[mainScrollVIew addSubview:image1BackView];

    image1BackView.backgroundColor = [UIColor whiteColor];
	image1BackView.layer.masksToBounds = YES;

    sqkaijiang = [[ColorView alloc] initWithFrame:CGRectMake(15, 11, 280, 15)];
    
    [mainScrollVIew addSubview:sqkaijiang];
    sqkaijiang.changeColor = [UIColor redColor];
    sqkaijiang.font = [UIFont systemFontOfSize:14];
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.textColor = [UIColor blackColor];
    [sqkaijiang release];

    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(226, 0, 55, 17)];//下期期号
    
	[mainScrollVIew addSubview:timeLabel];
    timeLabel.text = [NSString stringWithFormat:@"距%@",[SharedMethod getLastTwoStr:self.issue]];
    timeLabel.textAlignment = NSTextAlignmentRight;
	timeLabel.textColor = [UIColor blackColor];
	timeLabel.backgroundColor = [UIColor clearColor];
	timeLabel.font = [UIFont systemFontOfSize:8];
	[timeLabel release];
	
    mytimeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(245, 0, 60, 17)];
    mytimeLabel2.textAlignment=NSTextAlignmentRight;
    
	[mainScrollVIew addSubview:mytimeLabel2];
	mytimeLabel2.text = @"期截止";
    mytimeLabel2.textColor=[UIColor blackColor];
	mytimeLabel2.backgroundColor = [UIColor clearColor];
	mytimeLabel2.font = [UIFont systemFontOfSize:8];
	[mytimeLabel2 release];

    mytimeLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(225, 17, 80, 20)];
    mytimeLabel3.textAlignment=NSTextAlignmentRight;
    
	[mainScrollVIew addSubview:mytimeLabel3];
	mytimeLabel3.textColor = [UIColor blackColor];
	mytimeLabel3.backgroundColor = [UIColor clearColor];
    mytimeLabel3.font = [UIFont fontWithName:@"Quartz" size:20];
	[mytimeLabel3 release];

	yaoImage = [[UIImageView alloc] init];
	yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
	yaoImage.frame =CGRectMake(15, 53, 21, 19);
    
	[mainScrollVIew addSubview:yaoImage];
    
	colorLabel = [[ColorView alloc] init];
    colorLabel.frame = CGRectMake(40, 53, 265, 19);
	colorLabel.font = [UIFont systemFontOfSize:14];
	colorLabel.colorfont = [UIFont boldSystemFontOfSize:14];
	colorLabel.backgroundColor = [UIColor clearColor];
    colorLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
    colorLabel.changeColor = [UIColor colorWithRed:255/255.0 green:36/255.0 blue:36/255.0 alpha:1];
	[mainScrollVIew addSubview:colorLabel];
    colorLabel.text = @"按位猜中前3个开奖号即奖<1170>元";
	[colorLabel release];
    
    for (int i = 0; i<4; i++) {
        if(i<3)
        {
            UIImageView *firstView = [[UIImageView alloc] init];
            firstView.tag = 1000 +i;
            ColorView *label = [[ColorView alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.changeColor = [UIColor whiteColor];
            label.font=[UIFont systemFontOfSize:14];
            label.jianjuHeight = 1;
            label.tag = 100;

            if (i == 0) {
                label.text = @"一位";
            }
            else if (i == 1) {
                label.text = @"二位";
                label.tag = 110;
            }
            else if (i == 2) {
                label.text = @"三位";
            }
            label.textColor = [UIColor whiteColor];
            
            UIImageView *imaHong=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 54, 22)];
            imaHong.backgroundColor=[UIColor clearColor];
            imaHong.tag=10010;
            imaHong.image=[UIImage imageNamed:@"LeftTitleRed.png"];
            [firstView addSubview:imaHong];
            [imaHong release];
            
            if(i==0)
            {
                UIImageView * louImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 70+2, 18, 13)] autorelease];
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
            
            ColorView *desLabel = [[ColorView alloc] init];
            desLabel.backgroundColor=[UIColor clearColor];
            desLabel.textColor=[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
            desLabel.frame=CGRectMake(60, 2, 250, 22);
            desLabel.tag=2000;
            desLabel.font=[UIFont systemFontOfSize:12];
            [firstView addSubview:desLabel];
            
            
            [firstView addSubview:label];
            label.textAlignment = NSTextAlignmentCenter;
            label.frame = CGRectMake(5, 1, 54, 22);
            
            [label release];
            [desLabel release];
            firstView.backgroundColor = [UIColor clearColor];
            if (SWITCH_ON) {
                firstView.frame = CGRectMake(0, 85 + i*150, 320, 150);
            }else{
                firstView.frame = CGRectMake(0, 85 + i*120, 320, 120);
            }
            firstView.userInteractionEnabled = YES;
            GCBallView *lastRedBallView;
            for (int j = 0; j<11; j++) {
                int a= j/6,b = j%6;
                NSString *num = [NSString stringWithFormat:@"%d",j+1];
                if (j+1<10) {
                    num = [NSString stringWithFormat:@"0%d",j+1];
                }
                CGRect ballRect;
                if (SWITCH_ON) {
                    ballRect = CGRectMake(b*51+14, a*52+35, 35, 35);
                }else{
                    ballRect = CGRectMake(b*51+14, a*40+35, 35, 35);
                }
                
                GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorRed];
                im.isBlack = YES;
                [firstView addSubview:im];
                im.tag = j;
                im.gcballDelegate = self;
                if (SWITCH_ON) {
                    im.ylLable.hidden = NO;
                }else{
                    im.ylLable.hidden = YES;
                }
                lastRedBallView=im;
                [im release];
            }
            
            GifButton * redTrashButton = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(ORIGIN_X(lastRedBallView) + 15, lastRedBallView.frame.origin.y, 0, 0)] autorelease];
            redTrashButton.tag = 333;
            redTrashButton.delegate=self;
            [firstView addSubview:redTrashButton];
            
            [mainScrollVIew addSubview:firstView];
            [firstView release];
        }
        else
        {
            UIImageView *firstView = [[UIImageView alloc] init];
            firstView.tag = 1000 +i;
            ColorView *label = [[ColorView alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.changeColor = [UIColor whiteColor];
            label.font=[UIFont systemFontOfSize:14];
            label.jianjuHeight = 1;
            label.text = @"任选";
            label.textColor = [UIColor whiteColor];
            
            UIImageView *imaHong=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 54, 22)];
            imaHong.backgroundColor=[UIColor clearColor];
            imaHong.tag=10010;
            imaHong.image=[UIImage imageNamed:@"LeftTitleRed.png"];
            [firstView addSubview:imaHong];
            [imaHong release];
            
            UIImageView * louImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 70+2, 18, 13)] autorelease];
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
            
            ColorView *desLabel = [[ColorView alloc] init];
            desLabel.backgroundColor=[UIColor clearColor];
            desLabel.textColor=[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
            desLabel.frame=CGRectMake(60, 2, 250, 22);
            desLabel.tag=2000;
            desLabel.font=[UIFont systemFontOfSize:12];
            [firstView addSubview:desLabel];
            
            [firstView addSubview:label];
            label.tag = 100;
            label.textAlignment = NSTextAlignmentCenter;
            label.frame = CGRectMake(5, 1, 54, 22);
            
            [label release];
            [desLabel release];
            firstView.backgroundColor = [UIColor clearColor];
            if (SWITCH_ON) {
                firstView.frame = CGRectMake(0, 85 , 320, 200);
            }else{
                firstView.frame = CGRectMake(0, 85 , 320, 160);
            }
            firstView.userInteractionEnabled = YES;
            GCBallView *lastRedBallView;
            for (int j = 0; j<11; j++) {
                int a= j/5,b = j%5;
                NSString *num = [NSString stringWithFormat:@"%d",j+1];
                if (j+1<10) {
                    num = [NSString stringWithFormat:@"0%d",j+1];
                }
                CGRect ballRect;
                if (SWITCH_ON) {
                    ballRect = CGRectMake(b*63+14, a*52+35, 35, 35);
                }else{
                    ballRect = CGRectMake(b*63+14, a*40+35, 35, 35);
                }
                
                GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorRed];
                im.isBlack = YES;
                [firstView addSubview:im];
                im.tag = j;
                im.gcballDelegate = self;
                if (SWITCH_ON) {
                    im.ylLable.hidden = NO;
                }else{
                    im.ylLable.hidden = YES;
                }
                lastRedBallView=im;
                [im release];
            }
            GifButton * redTrashButton = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(ORIGIN_X(lastRedBallView) + 27, lastRedBallView.frame.origin.y, 0, 0)] autorelease];
            redTrashButton.tag = 333;
            redTrashButton.delegate=self;
            [firstView addSubview:redTrashButton];
            
            UIImageView *quanIma=[[UIImageView alloc]init];
            if (SWITCH_ON)
            {
                quanIma.frame=CGRectMake(63+14+9, 2*52+35+9, 19, 19);
            }
            else
            {
                quanIma.frame=CGRectMake(63+14+9, 2*40+35+9, 19, 19);
            }
            
            GifButton * redTrashButton2 = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(ORIGIN_X(quanIma) + 27+6, quanIma.frame.origin.y-9, 0, 0)] autorelease];
            redTrashButton2.tag = 444;
            redTrashButton2.delegate=self;
            [firstView addSubview:redTrashButton2];
            
            quanIma.tag=2020;
            UITapGestureRecognizer *quanTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(quanAction)];
            [quanIma addGestureRecognizer:quanTap];
            [quanTap release];
            quanIma.userInteractionEnabled=YES;
            if(lotterytype == eleven5_8)
            {
                quanIma.hidden=NO;
            }
            else
            {
                quanIma.hidden=YES;
            }
            quanIma.image=[UIImage imageNamed:@"quan.png"];
            [firstView addSubview:quanIma];
            [quanIma release];
            
            [mainScrollVIew addSubview:firstView];
            [firstView release];
        }
	}
    
    
    descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.textColor = [UIColor darkGrayColor];
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.font = [UIFont systemFontOfSize:12];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.lineBreakMode = 0;
    
	zaixianLabel = [[ColorView alloc] initWithFrame:CGRectMake(10, 346, 150, 30)];
	zaixianLabel.text = nil;
	zaixianLabel.changeColor = [UIColor redColor];
    zaixianLabel.font = [UIFont systemFontOfSize:10];
    zaixianLabel.colorfont = [UIFont systemFontOfSize:12];
	zaixianLabel.backgroundColor = [UIColor clearColor];
	[mainScrollVIew addSubview:zaixianLabel];
	[zaixianLabel release];
	
	imageruan = [[UIImageView alloc] initWithFrame:CGRectMake(103, 343, 205, 25)];
	[mainScrollVIew addSubview:imageruan];
    imageruan.backgroundColor=[UIColor clearColor];
    imageruan.layer.cornerRadius=4.0;
    
    imageruan.layer.masksToBounds = YES;
	
	ranLabel = [[ColorView alloc] initWithFrame:CGRectMake(0, 5, 260, 16)];
	ranLabel.text = @"";
    ranLabel.textAlignment = NSTextAlignmentCenter;
	ranLabel.font = [UIFont systemFontOfSize:10];
	ranLabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
	ranLabel.changeColor = [UIColor redColor];
	ranLabel.backgroundColor = [UIColor clearColor];
	[imageruan addSubview:ranLabel];
    
    ranNameLabel = [[ UILabel alloc] initWithFrame:CGRectMake(0, 1, 30, 16)];
    ranNameLabel.text = @"";
    ranNameLabel.textAlignment = NSTextAlignmentCenter;
	ranNameLabel.font = [UIFont systemFontOfSize:10];
    ranNameLabel.backgroundColor = [UIColor clearColor];
	ranNameLabel.textColor = [UIColor blackColor];
	[imageruan addSubview:ranNameLabel];
    [ranNameLabel release];
    
	[ranLabel release];
	[imageruan release];
	
	
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height -44, 320, 44)];
	[self.view addSubview:im];
    im.userInteractionEnabled = YES;
    im.backgroundColor=[UIColor colorWithRed:22/255.0 green:23/255.0 blue:25/255.0 alpha:1];

    
    //注数背景
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 68, 30)];
    zhubg.image = UIImageGetImageFromName(@"SRK960.png");
    zhubg.backgroundColor=[UIColor clearColor];
    zhubg.layer.masksToBounds=YES;
    zhubg.layer.cornerRadius=3.0;
    
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
	jineLabel.font = [UIFont boldSystemFontOfSize:12];
    jineLabel.backgroundColor = [UIColor clearColor];
	jineLabel.textAlignment = NSTextAlignmentCenter;
    jineLabel.textColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1];
	[jineLabel release];
	
	UILabel *jin = [[UILabel alloc] initWithFrame:CGRectMake(40, 17.5, 20, 11)];
	jin.text = @"元";
	jin.font = [UIFont systemFontOfSize:12];
	jin.textColor = [UIColor blackColor];
	jin.backgroundColor = [UIColor clearColor];
    jin.textColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1];
	[zhubg addSubview:jin];
    [jin release];
	
	senBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[senBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
	senBtn.frame = CGRectMake(230, 7, 80, 33);
	[im addSubview:senBtn];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    
    
    UILabel *senLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 33)];
    senLabel.backgroundColor = [UIColor clearColor];
    senLabel.textAlignment = NSTextAlignmentCenter;
    senLabel.text = @"机选";
    senLabel.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    senLabel.font = [UIFont systemFontOfSize:18];
    
    senLabel.tag = 1101;
    [senBtn addSubview:senLabel];
    [senLabel release];
}

-(void)quanAction
{
    if (lotterytype > eleven5_1 && lotterytype < eleven5_Q2Zhi) {
        
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:lotterytype - (eleven5_1 - 1) + 3 start:1 maxnum:11];
        UIView *redView = [self.mainView viewWithTag:1003];
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
    [self ballSelectChange:nil];
}

- (void)LoadIpadView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(50 + 35, 0, 270, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.userInteractionEnabled = YES;
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.tag = 789;
    
    UILabel *JTLabel = [[UILabel alloc] init];
    JTLabel.backgroundColor = [UIColor clearColor];
    JTLabel.textAlignment = NSTextAlignmentCenter;
    JTLabel.font = [UIFont systemFontOfSize:12];
    JTLabel.text = @"▼";
    JTLabel.textColor = [UIColor whiteColor];
    JTLabel.shadowColor = [UIColor blackColor];
    JTLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    JTLabel.tag = 567;
    if ([[[Info getInstance] userId] intValue] == 0) {
        titleLabel.frame = CGRectMake(10, 0, 220, 44);
        JTLabel.frame = CGRectMake(173, 1, 20, 44);
    }else {
        
        titleLabel.frame = CGRectMake(27, 0, 220, 44);
        JTLabel.frame = CGRectMake(190, 1, 20, 44);
    }
    [titleView addSubview:JTLabel];
    [JTLabel release];
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = titleView.bounds;
    titleButton.backgroundColor = [UIColor clearColor];
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:titleLabel];
    [titleView addSubview:titleButton];
    self.CP_navigation.titleView = titleView;
    [titleView release];
    
    image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(115 + 35, 13, 195, 47)];
	[self.mainView addSubview:image1BackView];
    image1BackView.image = [UIImageGetImageFromName(@"GC_sqkjback.png")stretchableImageWithLeftCapWidth:5 topCapHeight:5];
	image1BackView.layer.masksToBounds = YES;
	image1BackView.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 23, 195, 2)];
    imageV.image = UIImageGetImageFromName(@"SZTG960.png");
    [image1BackView addSubview:imageV];
    [imageV release];
    
    sqkaijiang = [[ColorView alloc] initWithFrame:CGRectMake(130 + 35, 20, 150, 23)];
    [self.mainView addSubview:sqkaijiang];
    sqkaijiang.changeColor = [UIColor redColor];
    sqkaijiang.font = [UIFont systemFontOfSize:10];
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.textColor = [UIColor blackColor];
    [sqkaijiang release];
    
	timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120 + 35, 36, 55, 23)];
	[self.mainView addSubview:timeLabel];
    timeLabel.text = self.issue;
    timeLabel.textAlignment = NSTextAlignmentRight;
	timeLabel.textColor = [UIColor blackColor];
	timeLabel.backgroundColor = [UIColor clearColor];
	timeLabel.font = [UIFont systemFontOfSize:10];
	[timeLabel release];
	
	mytimeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(180 + 35, 36, 60, 23)];
	[self.mainView addSubview:mytimeLabel2];
	mytimeLabel2.text = @"期截止还有";
	mytimeLabel2.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
	mytimeLabel2.backgroundColor = [UIColor clearColor];
	mytimeLabel2.font = [UIFont systemFontOfSize:10];
	[mytimeLabel2 release];
	
	mytimeLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(240 + 35, 36, 33, 23)];
	[self.mainView addSubview:mytimeLabel3];
	mytimeLabel3.textColor = [UIColor blackColor];
	mytimeLabel3.backgroundColor = [UIColor clearColor];
	mytimeLabel3.font = [UIFont systemFontOfSize:10];
	[mytimeLabel3 release];
	
	yaoImage = [[UIImageView alloc] init];
	yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
	yaoImage.frame =CGRectMake(10 + 35, 40, 15, 15);
	[self.mainView addSubview:yaoImage];
    
	colorLabel = [[ColorView alloc] init];
	colorLabel.frame = CGRectMake(27 + 35, 40, 100, 15);
	colorLabel.textColor = [UIColor blackColor];
	colorLabel.font = [UIFont systemFontOfSize:11];
	colorLabel.colorfont = [UIFont boldSystemFontOfSize:11];
	colorLabel.backgroundColor = [UIColor clearColor];
	colorLabel.changeColor = [UIColor redColor];
	[self.mainView addSubview:colorLabel];
	colorLabel.text = @"单注奖金<1170>元";
    colorLabel.wordWith = 10;
	[colorLabel release];
    
	for (int i = 0; i<3; i++) {
		UIImageView *firstView = [[UIImageView alloc] init];
		firstView.tag = 1000 +i;
		ColorView *label = [[ColorView alloc] init];
		label.backgroundColor = [UIColor clearColor];
        label.changeColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
        label.colorfont = [UIFont boldSystemFontOfSize:14];
        label.jianjuHeight = 3;
        if (i == 0) {
            label.text = @"一位<①>";
        }
        else if (i == 1) {
            label.text = @"二位<①>";
        }
        else if (i == 2) {
            label.text = @"三位<①>";
        }
		label.textColor = [UIColor whiteColor];
		[firstView addSubview:label];
		label.tag = 100;
        label.textAlignment = NSTextAlignmentCenter;
		label.frame = CGRectMake(7, 15, 20, 60);
		[label release];
		firstView.backgroundColor = [UIColor clearColor];
		firstView.frame = CGRectMake(10 + 35, 70 + i*90, 300, 91);
		firstView.image = UIImageGetImageFromName(@"TZAHBG960.png");
		firstView.userInteractionEnabled = YES;
		for (int j = 0; j<11; j++) {
			int a= j/7,b = j%7;
			NSString *num = [NSString stringWithFormat:@"%d",j+1];
			if (j+1<10) {
				num = [NSString stringWithFormat:@"0%d",j+1];
			}
			
			GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*37+35, a*37+8, 35, 35) Num:num ColorType:GCBallViewColorRed];
            im.isBlack = YES;
			[firstView addSubview:im];
			im.tag = j;
			im.gcballDelegate = self;
			[im release];
		}
		[self.mainView addSubview:firstView];
		[firstView release];
	}
	
	zaixianLabel = [[ColorView alloc] initWithFrame:CGRectMake(10 + 35, 346, 150, 30)];
	zaixianLabel.text = nil;
	zaixianLabel.changeColor = [UIColor redColor];
    zaixianLabel.font = [UIFont systemFontOfSize:10];
    zaixianLabel.colorfont = [UIFont systemFontOfSize:12];
	zaixianLabel.backgroundColor = [UIColor clearColor];
	[self.mainView addSubview:zaixianLabel];
	[zaixianLabel release];
	
	imageruan = [[UIImageView alloc] initWithFrame:CGRectMake(103 + 35, 343, 205, 25)];
	[self.mainView addSubview:imageruan];
    imageruan.image = [UIImageGetImageFromName(@"GC_sqkjback.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    
    imageruan.layer.masksToBounds = YES;
	
	ranLabel = [[ColorView alloc] initWithFrame:CGRectMake(0, 5, 260, 16)];
	ranLabel.text = @"";
    ranLabel.textAlignment = NSTextAlignmentCenter;
	ranLabel.font = [UIFont systemFontOfSize:10];
	ranLabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
	ranLabel.changeColor = [UIColor redColor];
	ranLabel.backgroundColor = [UIColor clearColor];
	[imageruan addSubview:ranLabel];
    
    ranNameLabel = [[ UILabel alloc] initWithFrame:CGRectMake(0, 1, 30, 16)];
    ranNameLabel.text = @"";
    ranNameLabel.textAlignment = NSTextAlignmentCenter;
	ranNameLabel.font = [UIFont systemFontOfSize:10];
    ranNameLabel.backgroundColor = [UIColor clearColor];
	ranNameLabel.textColor = [UIColor blackColor];
	[imageruan addSubview:ranNameLabel];
    [ranNameLabel release];
    
	[ranLabel release];
	[imageruan release];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 addTarget:self action:@selector(gofenxi) forControlEvents:UIControlEventTouchUpInside];
    btn2.frame = CGRectMake(340, 0, 50, 50);
    xiimageview = [[UIImageView alloc] initWithFrame:CGRectMake(350, 10, 30, 30)];
    xiimageview.image = UIImageGetImageFromName(@"gc_xl_12_1.png");
    [self.mainView addSubview:xiimageview];
    [self.mainView addSubview:btn2];
    [xiimageview release];
	
	
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 748- 44 - 44, 390, 44)];
    im.userInteractionEnabled = YES;
	im.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
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
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    
    UIImageView *senImage = [[UIImageView alloc] initWithFrame:senBtn.bounds];
    senImage.image = [UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [senBtn addSubview:senImage];
    [senImage release];
    
    UILabel *senLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 33)];
    senLabel.backgroundColor = [UIColor clearColor];
    senLabel.textAlignment = NSTextAlignmentCenter;
    senLabel.text = @"机选";
    senLabel.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    senLabel.tag = 1101;
    senLabel.font = [UIFont systemFontOfSize:15];
    [senBtn addSubview:senLabel];
    [senLabel release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.showYiLou = NO;
    self.yiLouViewHight = self.view.frame.size.height - 44 - 44 - isIOS7Pianyi - self.headHight - TOPVIEW_HEIGHT;

	showXiaoxi = YES;
	[MobClick event:@"event_goumai_gaopincai_11xuan5"];
	ShakeView *shakeView = [[ShakeView alloc] init];
	[self.mainView addSubview:shakeView];
	[shakeView becomeFirstResponder];
	[shakeView release];
    
    UIButton * historyButton = (UIButton *)[cpHistoryBGImageView viewWithTag:800];
    [historyButton addTarget:self action:@selector(toHistory) forControlEvents:UIControlEventTouchUpInside];
	
    UIImageView * bgimageview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    [self.mainView addSubview:bgimageview];
    [bgimageview release];
    
    mainScrollVIew = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
    [self.mainView addSubview:mainScrollVIew];
    

        UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = left;
        if ([[[Info getInstance] userId] intValue] == 0) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
            UIBarButtonItem *right = [Info itemInitWithTitle:@"登录" Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30)];
            
            self.CP_navigation.rightBarButtonItem = right;
        }
        else {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:UIImageGetImageFromName(@"chaodancaidan.png") forState:UIControlStateNormal];
            [btn setImage:UIImageGetImageFromName(@"chaodancaidan_1.png") forState:UIControlStateHighlighted];

            btn.frame = CGRectMake(0, 0, 60, 44);
            [btn addTarget:self action:@selector(pressMenu) forControlEvents:UIControlEventTouchUpInside];
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
    
    UIButton * sender = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (lotterytype >= eleven5_R2DanTuo) {
        sender.tag = lotterytype - eleven5_R2DanTuo + 12;
    }
    else {
        sender.tag = lotterytype - eleven5_1 - 1 ;
        if (lotterytype >= eleven5_Q2Zhi) {
            sender.tag = lotterytype - eleven5_1;
        }
        else if (lotterytype == eleven5_1) {
            sender.tag = 7;
        }
    }
    [self pressBgButton:sender];
    [self getWangqi];
	[self ballSelectChange:sender];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    isAppear = NO;
    [self.myTimer invalidate];
    self.myTimer = nil;
    [self.runTimer invalidate];
	self.runTimer = nil;
    [myRequest clearDelegatesAndCancel];
    self.myRequest = nil;
    imageruan.alpha = 0;
    [[caiboAppDelegate getAppDelegate] showInSencondView:nil ViewControllor:nil];
    if (entRunLoopRef) {
        CFRunLoopStop(entRunLoopRef);
        entRunLoopRef = nil;
    }
    if(isShowing)
    {
        [alert2 removeFromSuperview];
        [self addNavAgain];
    }
}

- (void)getIssue{
    if (isAppear) {
        NSMutableData *postData = [[GC_HttpService sharedInstance] getCaiZhongInfo:myLotteryID];
        
        [myRequest clearDelegatesAndCancel];
        self.myRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [myRequest setRequestMethod:@"POST"];
        [myRequest addCommHeaders];
        [myRequest setPostBody:postData];
        [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [myRequest setDelegate:self];
        [myRequest setDidFinishSelector:@selector(reqLotteryInfoFinished:)];
        [myRequest setDidFailSelector:@selector(reqLotteryInfoFailed:)];
        [myRequest startAsynchronous];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
	// 高频：0 数字彩：1 足彩：2 全部：3
    [super viewWillAppear:animated];
    if ([[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]){
        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(doBack) ImageName:@"HC_gouwuche.png"];
        [self.CP_navigation setHidesBackButton:YES];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getIssue) name:@"BecomeActive" object:nil];
    isAppear = YES;
	[self performSelector:@selector(getIssue) withObject:nil afterDelay:0.01];
    [self.runTimer invalidate];
    self.runTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showranLabel) userInfo:nil repeats:YES];
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
    self.myIssrecord =nil;
    [yiLouDataArray release];
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = nil;
	self.issue = nil;
	[self.qihaoReQuest clearDelegatesAndCancel];
	self.qihaoReQuest = nil;
	[self.myRequest clearDelegatesAndCancel];
	self.myRequest = nil;
    self.zhongJiang = nil;
    [wanArray release];
    [titleLabel release];
	[infoViewController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [descriptionLabel release];
    [mainScrollVIew release];
    [self.yilouRequest clearDelegatesAndCancel];
    self.yilouRequest = nil;
    self.yilouDic = nil;
    
    [yaoImage release];
    
    [image1BackView release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark View 遗漏


- (void)renXuanYiLouFunc:(NSMutableArray *)allArray type:(int)cztype{
    
   
    if (cztype == 1) {
         NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:10] ;
        if (twoElevenScrollView) {
            twoElevenScrollView.hidden = YES;
        }
        if (twoTitleScrollView) {
            twoTitleScrollView.hidden = YES;
        }
        if (twomyPageControl) {
            twomyPageControl.hidden = YES;
        }
        
        [array addObject:[NSString stringWithFormat:@"%d",ElevenBasic]];
        [array addObject:[NSString stringWithFormat:@"%d",ElevenDaXiao]];
        [array addObject:[NSString stringWithFormat:@"%d",ElevenJiOu]];
        [array addObject:[NSString stringWithFormat:@"%d",ElevenZhiHe]];
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
            [titleScrollView release];
            
            
            elevenScrollView = [[UIScrollView alloc] initWithFrame:yiLouView.bounds];
            elevenScrollView.backgroundColor = [UIColor clearColor];
            elevenScrollView.directionalLockEnabled = YES;
            elevenScrollView.showsHorizontalScrollIndicator = NO;
            elevenScrollView.delegate = self;
            elevenScrollView.bounces = NO;
            elevenScrollView.tag = 10 ;
            [yiLouView addSubview:elevenScrollView];
            [elevenScrollView release];
            
            NSArray * titleArray = @[@[@"大小比"],@[@"奇偶比"],@[@"质合比"]];
            
            for (int j = 0; j < [array count]; j++) {
                ChartFormatData * chartFormatData = [[ChartFormatData alloc] initWithAllArray:yiLouDataArray lottoryType:(int)[[array objectAtIndex:j] integerValue] isEleven:YES];
                if (j != 0) {
                    chartFormatData.rightTitleArray = [titleArray objectAtIndex:j - 1];
                    chartFormatData.linesTitleArray = @[@"0 : 5",@"1 : 4",@"2 : 3",@"3 : 2",@"4 : 1",@"5 : 0"];
                    chartFormatData.titleHeight = 18.5;
                }else{
                    chartFormatData.numberOfLines = 11;
                }
                CGRect redrawFrame1 = CGRectMake(320 * j, 0, 320, 42);
                CGRect redrawFrame = CGRectMake(320 * j, 0, 320, REDRAW_FRAME(chartFormatData));
                
                UITitleYiLouView * titleYiLou = [[UITitleYiLouView alloc] initWithFrame:redrawFrame1 chartFormatData:chartFormatData];
                [titleScrollView addSubview:titleYiLou];
                [titleYiLou release];
                
                redrawView * redraw = [[redrawView alloc] initWithFrame:redrawFrame chartFormatData:chartFormatData]; //基本
                redraw.tag = (j+1)*10;
                [elevenScrollView addSubview:redraw];
                [redraw release];
                
                [chartFormatData release];
                
                 elevenScrollView.contentSize = CGSizeMake(elevenScrollView.frame.size.width * [array count], 0.5+(chartFormatData.linesHeight * chartFormatData.allArray.count) + 0.5 * chartFormatData.allArray.count + 0.5);
                elevenScrollView.contentOffset = CGPointMake(0, elevenScrollView.contentSize.height - elevenScrollView.frame.size.height);

            }
            
            myPageControl = [[New_PageControl alloc] initWithFrame:CGRectMake(0, 0, 320, NEW_PAGECONTROL_HEIGHT)];
            myPageControl.yilouBool = YES;
            myPageControl.backgroundColor = [UIColor colorWithRed:30/255.0 green:92/255.0 blue:137/255.0 alpha:1];
            myPageControl.tag = 30 ;
            myPageControl.currentPage = 0;
            myPageControl.numberOfPages = [array count];
            [headYiLouView addSubview:myPageControl];
            [myPageControl release];
        }else{
            elevenScrollView.hidden = NO;
            titleScrollView.hidden = NO;
            myPageControl.hidden = NO;
            
        }
        [array release];
    }else if(cztype == 2){
        NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:10] ;
        if (titleScrollView) {
            titleScrollView.hidden = YES;
        }
        if (elevenScrollView) {
            elevenScrollView.hidden = YES;
            
        }
        if (myPageControl) {
            myPageControl.hidden = YES;
        }
        [array addObject:[NSString stringWithFormat:@"%d",ElevenQianOne]];
        [array addObject:[NSString stringWithFormat:@"%d",ElevenQianTwo]];
        [array addObject:[NSString stringWithFormat:@"%d",ElevenQianThree]];
        
        NSArray * titleArray = @[@[@"第一位"],@[@"第二位"],@[@"第三位"]];

        if (!twoTitleScrollView) {
            twoTitleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NEW_PAGECONTROL_HEIGHT, 320, DEFAULT_ISSUE_HEIGHT + 1)];
            twoTitleScrollView.backgroundColor = [UIColor clearColor];
            twoTitleScrollView.contentSize = CGSizeMake(twoTitleScrollView.frame.size.width * [array count], twoTitleScrollView.frame.size.height);
            twoTitleScrollView.userInteractionEnabled = NO;
            twoTitleScrollView.pagingEnabled = YES;
            twoTitleScrollView.showsHorizontalScrollIndicator = NO;
            twoTitleScrollView.delegate = self;
            twoTitleScrollView.bounces = NO;
            twoTitleScrollView.tag = 11 ;
            [headYiLouView addSubview:twoTitleScrollView];
            [twoTitleScrollView release];
            
            
            twoElevenScrollView = [[UIScrollView alloc] initWithFrame:yiLouView.bounds];
            twoElevenScrollView.backgroundColor = [UIColor clearColor];
            twoElevenScrollView.showsHorizontalScrollIndicator = NO;
            twoElevenScrollView.delegate = self;
            twoElevenScrollView.bounces = NO;
            twoElevenScrollView.directionalLockEnabled = YES;
            twoElevenScrollView.tag = 10 ;
            [yiLouView addSubview:twoElevenScrollView];
            [twoElevenScrollView release];
            
            for (int j = 0; j < [array count]; j++) {
                
                ChartFormatData * chartFormatData = [[ChartFormatData alloc] initWithAllArray:yiLouDataArray lottoryType:(int)[[array objectAtIndex:j] integerValue] isEleven:YES];
                chartFormatData.lottoryWidth = DEFAULT_LOTTORY_WIDTH_ELEVEN;
                chartFormatData.issueWidth = 22;
                chartFormatData.numberOfLines = 11;
                chartFormatData.titleHeight = 18.5;
                chartFormatData.rightTitleArray = [titleArray objectAtIndex:j];
                chartFormatData.lottoryColor = j + 3;
                
                CGRect redrawFrame1 = CGRectMake( 320 * j, 0, 320, 42);
                CGRect redrawFrame = CGRectMake(320 * j, 0, 320, REDRAW_FRAME(chartFormatData));

                
                UITitleYiLouView * titleYiLou = [[UITitleYiLouView alloc] initWithFrame:redrawFrame1 chartFormatData:chartFormatData];
                [twoTitleScrollView addSubview:titleYiLou];
                [titleYiLou release];
                
                
                redrawView * redraw = [[redrawView alloc] initWithFrame:redrawFrame chartFormatData:chartFormatData]; //基本
                redraw.tag = (j+1)*10;
                [twoElevenScrollView addSubview:redraw];
                [redraw release];
                
                [chartFormatData release];
                 twoElevenScrollView.contentSize = CGSizeMake(twoElevenScrollView.frame.size.width * [array count], 0.5+(chartFormatData.linesHeight * chartFormatData.allArray.count) + 0.5 * chartFormatData.allArray.count + 0.5);
                twoElevenScrollView.contentOffset = CGPointMake(0, twoElevenScrollView.contentSize.height - twoElevenScrollView.frame.size.height);
            }
            
           twomyPageControl = [[New_PageControl alloc] initWithFrame:CGRectMake(0, 0, 320, NEW_PAGECONTROL_HEIGHT)];
            twomyPageControl.yilouBool = YES;
            twomyPageControl.backgroundColor = [UIColor colorWithRed:30/255.0 green:92/255.0 blue:137/255.0 alpha:1];
            twomyPageControl.tag = 30 ;
            twomyPageControl.currentPage = 0;
            twomyPageControl.numberOfPages = [array count];
            [headYiLouView addSubview:twomyPageControl];
            [twomyPageControl release];
        }else{
            twoTitleScrollView.hidden = NO;
            twoElevenScrollView.hidden = NO;
            twomyPageControl.hidden = NO;
            
        }
        [array release];
    }
    
    
    
    
}
- (void)pageControlFunc:(New_PageControl *)pageControl{


    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.2];
    
    
        if (pageControl == myPageControl) {
            elevenScrollView.contentOffset = CGPointMake(320*myPageControl.currentPage, elevenScrollView.contentOffset.y);
        }else if (pageControl == twomyPageControl){
            twoElevenScrollView.contentOffset = CGPointMake(320*twomyPageControl.currentPage, twoElevenScrollView.contentOffset.y);
        }

    [UIView commitAnimations];
    
}


- (void)sleepScrollViewFunc:(UIScrollView *)scrollView{

   
    if (scrollView == elevenScrollView) {
        
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
    }else if (scrollView == twoTitleScrollView){
        
        NSInteger page = twomyPageControl.currentPage;
        float x = page *320;
        if (scrollView.contentOffset.x > x + scrollView.frame.size.width * 1/4) {
            page ++;
        }
        else if (scrollView.contentOffset.x < x -scrollView.frame.size.width * 1/4) {
            page --;
        }
        if (x != page *320) {
        twomyPageControl.currentPage = page;
        [self pageControlFunc:twomyPageControl];
        }
        else if (scrollView.contentOffset.x != page *320) {
            [self pageControlFunc:twomyPageControl];
        }
    }else if (scrollView == twoElevenScrollView){
        
        NSInteger page = twomyPageControl.currentPage;
        float x = page *320;
        if (scrollView.contentOffset.x > x + scrollView.frame.size.width * 1/4) {
            page ++;
        }
        else if (scrollView.contentOffset.x < x -scrollView.frame.size.width * 1/4) {
            page --;
        }
        if (x != page *320) {
            twomyPageControl.currentPage = page;
            [self pageControlFunc:twomyPageControl];
        }
        else if (scrollView.contentOffset.x != page *320) {
            [self pageControlFunc:twomyPageControl];
        }
        
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];

        [self sleepScrollViewFunc:scrollView];

}

int _lastPosition;    //A variable define in headfile

-(void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView{
    
    
    if (scrollView == elevenScrollView || scrollView == twoElevenScrollView) {
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [super scrollViewDidScroll:scrollView];
    
    if (scrollView == elevenScrollView) {
        titleScrollView.contentOffset = CGPointMake(elevenScrollView.contentOffset.x, titleScrollView.contentOffset.y);
    }else if (scrollView == titleScrollView){
        elevenScrollView.contentOffset = CGPointMake(titleScrollView.contentOffset.x, elevenScrollView.contentOffset.y);
    }else if (scrollView == twoTitleScrollView){
         twoElevenScrollView.contentOffset = CGPointMake(twoTitleScrollView.contentOffset.x, twoElevenScrollView.contentOffset.y);
    }else if (scrollView == twoElevenScrollView){
         twoTitleScrollView.contentOffset = CGPointMake(twoElevenScrollView.contentOffset.x, twoTitleScrollView.contentOffset.y);
    }
}

-(void)upDateYiLou
{
    if (titleScrollView) {
        [titleScrollView removeFromSuperview];
        [elevenScrollView removeFromSuperview];
        titleScrollView = nil;
        elevenScrollView = nil;
    }
    if (twoTitleScrollView) {
        [twoTitleScrollView removeFromSuperview];
        [twoElevenScrollView removeFromSuperview];
        twoTitleScrollView = nil;
        twoElevenScrollView = nil;
    }
    [self runCharRequest];
}

- (void)runCharRequest{
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:myLotteryID itemNum:YiLOU_COUNT issue:nil]];

    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(reqBuyLotteryFinished:)];
    [httpRequest setDidFailSelector:@selector(rebuyFail:)];
    [httpRequest startAsynchronous];
    
    
}

- (void)rebuyFail:(ASIHTTPRequest *)mrequest{
    
    self.showYiLou = NO;
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    hasYiLou = NO;
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
    [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
}


- (void)allView:(NSMutableArray *)chartDataArray{
    if (yiLouView) {
        if ([titleLabel.text length] > 0) {
            if ([[titleLabel.text substringToIndex:1] isEqualToString:@"前"]) {
                [self renXuanYiLouFunc:chartDataArray type:2];
            }else  if ([[titleLabel.text substringToIndex:1] isEqualToString:@"任"]){
                [self renXuanYiLouFunc:chartDataArray type:1];
                
            }
        }
        
        
        
    }
    
    
}

- (void)reqBuyLotteryFinished:(ASIHTTPRequest *)request {
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
	NSString *responseStr = [request responseString];
    if (responseStr&&![responseStr isEqualToString:@"fail"]) {
        NSArray * array = [[responseStr JSONValue] objectForKey:@"list"];
        NSMutableArray * chartDataArray = [[[NSMutableArray alloc] init] autorelease];
        for (int i = (int)array.count - 1; i >= 0; i--) {
            YiLouChartData * chartData = [[YiLouChartData alloc] initWithN115Dictionary:[array objectAtIndex:i]];
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


#pragma mark -
#pragma mark View action
- (void)gofenxi {
    [MobClick event:@"event_goucai_zoushitu_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];

    self.showYiLou = YES;
   
    if ([self.yiLouDataArray count] > 0) {
        [self allView:self.yiLouDataArray];
        elevenScrollView.contentOffset = CGPointMake(elevenScrollView.contentOffset.x, elevenScrollView.contentSize.height - elevenScrollView.frame.size.height);
        twoElevenScrollView.contentOffset = CGPointMake(twoElevenScrollView.contentOffset.x, twoElevenScrollView.contentSize.height - twoElevenScrollView.frame.size.height);
    }else{
        [self runCharRequest];
    }
    
    
}

- (void)donghuaxizi{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.52f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:xiimageview cache:YES];
    [UIView commitAnimations];
}

- (void)pressMenu {
    if(isShowing)
    {
        [self guanbidonghua];
        [alert2 disMissWithPressOtherFrame];
    }
    else
    {
        NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
        [allimage addObject:@"GC_sanjizoushi.png"];
        [allimage addObject:@"GC_sanjilishi.png"];
        [allimage addObject:@"GC_sanjiWanfaxuanze.png"];
        [allimage addObject:@"yiLouSwIcon.png"];
        [allimage addObject:@"GC_sanjiShuoming.png"];
        
        NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
        [alltitle addObject:@"走势图"];
        [alltitle addObject:@"历史开奖"];
        [alltitle addObject:@"玩法选择"];
        if (SWITCH_ON) {
            [alltitle addObject:@"隐藏遗漏"];
        }else{
            [alltitle addObject:@"显示遗漏"];
        }
        [alltitle addObject:@"玩法说明"];
        
        caiboAppDelegate *app = (caiboAppDelegate *)[UIApplication sharedApplication].delegate;
            tln = [[CP_ThreeLevelNavigationView alloc] initWithFrame:CGRectMake(0, -20, 320, app.window.frame.size.height) AllImageName:allimage setAllTitle:alltitle];
            
        tln.delegate = self;
        [self.view addSubview:tln];
        [tln show];
        [tln release];

        [allimage release];
        [alltitle release];
    }

    
}

- (void)showranLabel {
    [self donghuaxizi];
	if ([self.zhongJiang.brInforArray count] != 0) {
        imageruan.alpha = 1;
		runCount = runCount%[self.zhongJiang.brInforArray count];
		ranLabel.alpha = 1;
        ranNameLabel.alpha = 1;
        NSArray *array = [[self.zhongJiang.brInforArray objectAtIndex:runCount] componentsSeparatedByString:@"@"];
        if ([array count] == 2) {

            
            ranNameLabel.frame = CGRectMake(205, 3, [ranNameLabel.text sizeWithFont:ranNameLabel.font].width, 16);
            ranLabel.frame = CGRectMake(ranNameLabel.frame.origin.x+ranNameLabel.frame.size.width, 5, 260, 16);
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            if ([ranNameLabel.text sizeWithFont:ranNameLabel.font].width + 5 + [ranLabel.text sizeWithFont:ranLabel.font].width > 205) {
                ranNameLabel.frame = CGRectMake(200 - [ranNameLabel.text sizeWithFont:ranNameLabel.font].width -[ranLabel.text sizeWithFont:ranLabel.font].width, 3, [ranNameLabel.text sizeWithFont:ranNameLabel.font].width, 16);
            }
            else {
                ranNameLabel.frame = CGRectMake(5, 3, [ranNameLabel.text sizeWithFont:ranNameLabel.font].width, 16);
            }
            
            ranLabel.frame = CGRectMake(ranNameLabel.frame.origin.x+ranNameLabel.frame.size.width, 5, 260, 16);
            [UIView commitAnimations];
            [self performSelector:@selector(hidenranLabel) withObject:nil afterDelay:2];
            runCount ++;
        }
        
	}
	else {
		ranLabel.frame = CGRectMake(205, 5, 260, 16);
        ranNameLabel.frame = CGRectZero;
	}
    
}

- (void)hidenranLabel {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
	ranNameLabel.alpha = 0;
	ranLabel.alpha = 0;
	[UIView commitAnimations];
}

- (void)getWangqi {
    NSMutableData *postData = [[GC_HttpService sharedInstance] reWangqiWithLottery:myLotteryID countOfPage:5];
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


- (void)timeChange {
	seconds = seconds - 1;
    if (seconds < 0) {
        [self getIssue];
		[self.myTimer invalidate];
		self.myTimer = nil;
        return;
    }
    if (!isKaiJiang) {
        colorLabel.text = @"上期等待开奖...";
        if ((seconds <= 600 - yanchiTime && seconds % 5 == 0)) {
            canRefreshYiLou = NO;
            [self getIssue];
        }
    }

    timeLabel.text = [NSString stringWithFormat:@"距%@",[SharedMethod getLastTwoStr:self.issue]];
    mytimeLabel3.text = [NSString stringWithFormat:@"%02d:%02d",seconds/60,seconds%60];
    if(seconds/60 == 0)
    {
        mytimeLabel3.textColor=[UIColor colorWithRed:250/255.0 green:208/255.0 blue:5/255.0 alpha:1];
    }
    else
    {
        mytimeLabel3.textColor=[UIColor blackColor];
    }
}

- (void)clearBalls {
    for (int i = 0; i < 4; i++) {
		UIView *ballView = [self.mainView viewWithTag:1000+i];
		for (GCBallView *ball in ballView.subviews) {
			if ([ball isKindOfClass:[GCBallView class]]) {
				ball.selected = NO;
                [ball chanetoNomore];
			}
		}
	}
	zhushuLabel.text = [NSString stringWithFormat:@"%d",0];
	jineLabel.text = [NSString stringWithFormat:@"%d",2*0];
    [self ballSelectChange:nil];
}

- (NSString *)seletNumber {
	NSString *st = @",", *sr = @"|";
	
	NSMutableString *mStr = [[[NSMutableString alloc] init] autorelease];
	int t = 1;
	if (lotterytype == eleven5_Q2Zhi) {
		t= 2;
	}
	if (lotterytype == eleven5_Q3Zhi) {
		t = 3;
	}
    if (lotterytype >= eleven5_R2DanTuo) {
        t = 2;
        sr = @"|";
    }
	for (int i = 0; i < t; i++) {
		if (lotterytype >= eleven5_1 && lotterytype <= eleven5_Q3DanTuo) {//11选5
			if (i > 0) {
				[mStr appendString:sr];
			}
		}
		UIView *ballView = [self.mainView viewWithTag:1000+i];

        if (lotterytype > eleven5_1 && lotterytype < eleven5_Q2Zhi)
        {
            ballView = [self.mainView viewWithTag:1003];
        }
        GifButton * trashButton = (GifButton *)[ballView viewWithTag:333];
        GifButton * trashButton2 = (GifButton *)[ballView viewWithTag:444];
        
		NSInteger selNum = 0;
		for (int k = 0; k < 11; k++) {
			GCBallView *ball = (GCBallView *)[ballView viewWithTag:k];
            
			if (ball.isSelected) {
				[mStr appendString:ball.numLabel.text];
				[mStr appendString:st];
				selNum += 1;
			}
			if (k == 10) {//删掉末尾的st
				if (selNum > 0) {
					[mStr deleteCharactersInRange:NSMakeRange([mStr length]-1, 1)];
				}
			}
		}
        if(selNum!=0)
        {
            if(lotterytype == eleven5_8)
            {
                trashButton.hidden=YES;
                trashButton2.hidden=NO;
            }
            else
            {
                trashButton.hidden=NO;
                trashButton2.hidden=YES;
            }
        }
        else
        {
            trashButton.hidden=YES;
            trashButton2.hidden=YES;
        }
    }
	return (NSString *)mStr;
}

- (void)send {
    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
    if ([labe.text isEqualToString:@"机选"] && [zhushuLabel.text integerValue] == 0) {
        [self randBalls];
        return;
    }
    [MobClick event:@"event_goucai_xuanhaole_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];
	if ([jineLabel.text intValue] > 20000) {
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
		[cai showMessage:@"单注投注额不能超过20000元"];
		return;
	}
    if (lotterytype == eleven5_2) {
        int b = 0;
        UIView *Rview = [self.mainView viewWithTag:1003];
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
    else if (lotterytype == eleven5_3) {
        int b = 0;
        UIView *Rview = [self.mainView viewWithTag:1003];
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
    else if (lotterytype == eleven5_4) {
        int b = 0;
        UIView *Rview = [self.mainView viewWithTag:1003];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                }
            }
            
        }
        if (b < 4) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择4个号码"];
            return;
        }
    }
    else if (lotterytype == eleven5_5) {
        int b = 0;
        UIView *Rview = [self.mainView viewWithTag:1003];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                }
            }
            
        }
        if (b < 5) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择5个号码"];
            return;
        }
    }
    else if (lotterytype == eleven5_6) {
        int b = 0;
        UIView *Rview = [self.mainView viewWithTag:1003];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                }
            }
            
        }
        if (b < 6) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择6个号码"];
            return;
        }
    }
    else if (lotterytype == eleven5_7) {
        int b = 0;
        UIView *Rview = [self.mainView viewWithTag:1003];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                }
            }
            
        }
        if (b < 7) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择7个号码"];
            return;
        }
    }
    else if (lotterytype == eleven5_8) {
        int b = 0;
        UIView *Rview = [self.mainView viewWithTag:1003];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                }
            }
            
        }
        if (b < 8) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择8个号码"];
            return;
        }
    }
    else if (lotterytype == eleven5_Q2Zhi) {
        int b = 0;
        int d = 0;
        UIView *Rview = [self.mainView viewWithTag:1000];
        UIView *Dview = [self.mainView viewWithTag:1001];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                }
            }
            
        }
        for (GCBallView *bt2 in Dview.subviews) {
            if ([bt2 isKindOfClass:[GCBallView class]]) {
                if (bt2.selected == YES) {
                    d++;
                }
            }
            
        }
        if (b < 1 || d < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"每位至少选择1个号码"];
            return;
        }
    }
    else if (lotterytype == eleven5_Q3Zhi) {
        int b = 0;
        int d = 0;
        int f = 0;
        UIView *Rview = [self.mainView viewWithTag:1000];
        UIView *Dview = [self.mainView viewWithTag:1001];
        UIView *Fview = [self.mainView viewWithTag:1002];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                }
            }
            
        }
        for (GCBallView *bt2 in Dview.subviews) {
            if ([bt2 isKindOfClass:[GCBallView class]]) {
                if (bt2.selected == YES) {
                    d++;
                }
            }
            
        }
        for (GCBallView *bt3 in Fview.subviews) {
            if ([bt3 isKindOfClass:[GCBallView class]]) {
                if (bt3.selected == YES) {
                    f++;
                }
            }
            
        }
        if (b < 1 || d < 1 || f < 1) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"每位至少选择1个号码"];
            return;
        }
    }
    else if (lotterytype == eleven5_Q2Zu) {
        int b = 0;
        UIView *Rview = [self.mainView viewWithTag:1000];
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
    else if (lotterytype == eleven5_Q3Zu) {
        int b = 0;
        UIView *Rview = [self.mainView viewWithTag:1000];
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
    else if (lotterytype >= eleven5_R2DanTuo) {
        int b = 0;
        int d = 0;
        UIView *Rview = [self.mainView viewWithTag:1000];
        UIView *Dview = [self.mainView viewWithTag:1001];
        for (GCBallView *bt in Rview.subviews) {
            if ([bt isKindOfClass:[GCBallView class]]) {
                if (bt.selected == YES) {
                    b++;
                }
            }
            
        }
        for (GCBallView *bt2 in Dview.subviews) {
            if ([bt2 isKindOfClass:[GCBallView class]]) {
                if (bt2.selected == YES) {
                    d++;
                }
            }
            
        }

        int a = 3;
        if (lotterytype >= eleven5_R2DanTuo && lotterytype <= eleven5_R5DanTuo) {
            a = lotterytype - eleven5_R2DanTuo + 3;
            
        }
        
        if (lotterytype >= eleven5_Q2DanTuo) {
            a = lotterytype - eleven5_Q2DanTuo + 3;
        }
        if (b > a -2) {
            [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"最多选择%d个胆码",a - 2]];
            return;
        }
        if (b <= 0) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"请选择胆码"];
            return;
        }
        if (d < 1) {
            [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"请选择拖码"]];
            return;
        }
        if (b + d < a) {
            [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"胆码+拖码个数不少于%d个",a]];
            return;
        }
    }
    
    if ([zhushuLabel.text integerValue] == 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"至少选择1注"];
        return;
    }
    if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
        NSString *selet = [self seletNumber];
        GouCaiShuZiInfoViewController *infoV = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
        if ([zhushuLabel.text intValue] == 1) {
            selet = [NSString stringWithFormat:@"01#%@",selet];
        }
        else if (lotterytype == eleven5_Q2Zhi ||lotterytype == eleven5_Q3Zhi) {
            selet = [NSString stringWithFormat:@"05#%@",selet];
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
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",zhushuLabel.text,@"ZhuShu",[NSString stringWithFormat:@"%d",lotterytype],@"lotterytype",nil];
            [infoV.dataArray addObject:dic];
            [dic release];
        }
        infoV.lotteryType = lotterytype;
        infoV.modeType = modetype;
        infoV.betInfo.issue = issue;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        if (!infoViewController) {
            infoViewController = [[GouCaiShuZiInfoViewController alloc] init];
            if (myElevenType == ShanDong11) {
                infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeShiXuanWu;
            }
            else if (myElevenType == GuangDong11) {
                infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeGDShiXuanWu;
            }
            else if (myElevenType == JiangXi11) {
                infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeJXShiXuanWu;
            }
            else if (myElevenType == HeBei11) {
                infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeHBShiXuanWu;
            }
            else if (myElevenType == ShanXi11) {
                infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeShanXiShiXuanWu;
            }
        }
        infoViewController.lotteryType = lotterytype;
        infoViewController.modeType = modetype;
        infoViewController.betInfo.issue = issue;
        
        NSString *selet = [self seletNumber];
        
        if (lotterytype >= eleven5_R2DanTuo) {
            selet = [NSString stringWithFormat:@"03#%@",selet];
        }
        else if ([zhushuLabel.text intValue] == 1) {
            selet = [NSString stringWithFormat:@"01#%@",selet];
        }
        else if (lotterytype == eleven5_Q2Zhi ||lotterytype == eleven5_Q3Zhi) {
            selet = [NSString stringWithFormat:@"05#%@",selet];
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
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:selet,@"Num",zhushuLabel.text,@"ZhuShu",[NSString stringWithFormat:@"%d",lotterytype],@"lotterytype",nil];
            [infoViewController.dataArray addObject:dic];
            [dic release];
        }
        [self.navigationController pushViewController:infoViewController animated:YES];
    }
    
	[self clearBalls];
}


- (void)randBalls {
	if (lotterytype >= eleven5_R2DanTuo) {
        return;
    }
	if (lotterytype > eleven5_1 && lotterytype < eleven5_Q2Zhi) {
		NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:lotterytype - (eleven5_1 - 1) start:1 maxnum:11];
        
        UIView *redView = [self.mainView viewWithTag:1003];
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
    else if (lotterytype >= eleven5_Q2Zu) {
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:lotterytype - eleven5_Q2Zhi start:1 maxnum:11];
		UIView *redView = [self.mainView viewWithTag:1000];
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
	else {
		int b = random()%3;
		NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:3 start:1 maxnum:11];
		for (int i =0 ; i<3; i++) {
			UIView *redView = [self.mainView viewWithTag:1000+i];
			if (redView.hidden == YES) {
				
			}
			else {
				for (GCBallView *ball in redView.subviews) {
					if ([ball isKindOfClass:[GCBallView class]]) {
						if ([[redBalls objectAtIndex:(i +b)%3] isEqualToString: ball.numLabel.text]) {
							ball.selected = YES;
						}
						else {
							ball.selected = NO;
						}
					}
				}
			}
		}
		
	}
	[self ballSelectChange:nil];
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
//        NSArray *array = [titleLabel.text componentsSeparatedByString:@"-"];
//        NSString *wanfa = [array objectAtIndex:0];
//        if ([wanfa isEqualToString:@"山东11选5"]) {
//
//        }
        titleBtnIsCanPress = NO;
        
        if(!isShowing)
        {
            [self zhankaidonghua];
            
            alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"玩法选择" ShuziNameArray:wanArray shuziArray:nil];
            alert2.duoXuanBool = NO;
            alert2.delegate = self;
            isShowing = YES;
            alert2.isClearBtnCanPress = NO;
            [alert2 show];
            [self.view addSubview:self.CP_navigation];
            self.CP_navigation.frame = CGRectMake(0, 20, 320, 44);
            [self.CP_navigation.window addSubview:alert2];
            [self.CP_navigation.window addSubview:self.CP_navigation];
            NSInteger type = 0;
            if (lotterytype == eleven5_Q2Zhi) {
                type = 8;
            }
            else if (lotterytype == eleven5_1) {
                type = 7;
            }
            else if (lotterytype == eleven5_Q3Zhi) {
                type = 9;
            }
            else if (lotterytype == eleven5_Q2Zu) {
                type = 10;
            }
            else if (lotterytype == eleven5_Q3Zu) {
                type = 11;
            }
            else {
                if (lotterytype >= eleven5_R2DanTuo) {
                    type =  lotterytype - eleven5_1;
                }else{
                    type =  lotterytype - (eleven5_1 + 1);
                }
            }
            for (CP_XZButton *btn in alert2.backScrollView.subviews) {
                if ([btn isKindOfClass:[UIButton class]] &&btn.tag == type) {
                    btn.selected = YES;
                    btn.buttonName.textColor = [UIColor whiteColor];
                }
            }
            
        }
        else
        {
            [self guanbidonghua];
            [alert2 disMissWithPressOtherFrame];
        }
        
        

    }
    
}


- (void)changeTitle {
    UIView *V0 = [self.mainView viewWithTag:1000];
    UIView *v1 = [self.mainView viewWithTag:1001];
    UIView *v2= [self.mainView viewWithTag:1002];
    
    UIView *v3= [self.mainView viewWithTag:1003];
    UIView *quan=[v3 viewWithTag:2020];
    
    ColorView *lable = (ColorView *)[V0 viewWithTag:100];
    lable.textColor=[UIColor whiteColor];
    ColorView *desLabel1 = (ColorView *)[V0 viewWithTag:2000];
    desLabel1.textColor=[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
    ColorView *desLabel2 = (ColorView *)[v1 viewWithTag:2000];
    desLabel2.textColor=[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
    ColorView *desLabel3 = (ColorView *)[v2 viewWithTag:2000];
    desLabel3.textColor=[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
    ColorView *desLabel4 = (ColorView *)[v3 viewWithTag:2000];
    desLabel4.textColor=[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
    
    ColorView * label1 = (ColorView *)[v1 viewWithTag:110];
    label1.text = @"二位";
    
    yaoImage.hidden = NO;
    colorLabel.frame = CGRectMake(40, 53, 265, 19);

    if (lotterytype == eleven5_Q2Zhi) {

        colorLabel.text = @"按位猜中前2个开奖号即奖<130>元";
        descriptionLabel.text = @"每位至少选1个号，与开奖号前2位相同（且顺序一致）即中奖";
        descriptionLabel.frame = CGRectMake(15, ORIGIN_Y(v1), 290, 40);
        mainScrollVIew.contentSize = CGSizeZero;
        zaixianLabel.frame = CGRectMake(10, ORIGIN_Y(descriptionLabel) + 5, 150, 30);
        imageruan.frame = CGRectMake(103, zaixianLabel.frame.origin.y - 3, 205, 25);
        
		v1.hidden = NO;
		v2.hidden = YES;
        V0.hidden = NO;
        v3.hidden = YES;
        quan.hidden=YES;
        
        lable.text = @"一位";
        desLabel1.text=@"至少选1个号";
        desLabel2.text=@"至少选1个号";
        desLabel3.text=@"至少选1个号";
        desLabel4.text=@"至少选1个号";
        if (self.issue) {
            titleLabel.text = [NSString stringWithFormat:@"前二直选%@期",[SharedMethod getLastTwoStr:self.issue]];
        }
        else {
            titleLabel.text = @"11选5前二直选";
        }
        [YiLouUnderGCBallView addYiLouTextOnView:V0 dictionary:[self.yilouDic objectForKey:@"qet"] typeStr:@"一" keyType:HasZero yiLouTag:1];
        [YiLouUnderGCBallView addYiLouTextOnView:v1 dictionary:[self.yilouDic objectForKey:@"qet"] typeStr:@"二" keyType:HasZero yiLouTag:1];

	}
	else if(lotterytype == eleven5_Q3Zhi){
        if (self.issue) {
            titleLabel.text = [NSString stringWithFormat:@"前三直选%@期",[SharedMethod getLastTwoStr:self.issue]];
        }
        else {
            titleLabel.text = @"11选5前三直选";
        }

        lable.text = @"一位";
        desLabel1.text=@"至少选1个号";
        desLabel2.text=@"至少选1个号";
        desLabel3.text=@"至少选1个号";
        desLabel4.text=@"至少选1个号";

        colorLabel.text = @"按位猜中前3个开奖号即奖<1170>元";
        descriptionLabel.text = @"每位至少选1个号，与开奖号前3位相同（且顺序一致）即中奖";
        descriptionLabel.frame = CGRectMake(15, ORIGIN_Y(v2), 290, 40);
        zaixianLabel.frame = CGRectMake(10, ORIGIN_Y(descriptionLabel) + 5, 150, 30);
        imageruan.frame = CGRectMake(103, zaixianLabel.frame.origin.y - 3, 205, 25);
        mainScrollVIew.contentSize = CGSizeMake(320, ORIGIN_Y(imageruan) + 5);
        
		v1.hidden = NO;
		v2.hidden = NO;
        V0.hidden = NO;
        v3.hidden = YES;
        quan.hidden=YES;
        
        [YiLouUnderGCBallView addYiLouTextOnView:V0 dictionary:[self.yilouDic objectForKey:@"qst"] typeStr:@"一" keyType:HasZero yiLouTag:1];
        [YiLouUnderGCBallView addYiLouTextOnView:v1 dictionary:[self.yilouDic objectForKey:@"qst"] typeStr:@"二" keyType:HasZero yiLouTag:1];
        [YiLouUnderGCBallView addYiLouTextOnView:v2 dictionary:[self.yilouDic objectForKey:@"qst"] typeStr:@"三" keyType:HasZero yiLouTag:1];
        
	}
    else if(lotterytype == eleven5_Q2Zu){
        if (self.issue) {
            titleLabel.text = [NSString stringWithFormat:@"前二组选%@期",[SharedMethod getLastTwoStr:self.issue]];

        }
        else {
            titleLabel.text = @"11选5前二组选";
        }

        lable.text = @"前二";
        desLabel1.text=@"至少选2个号";
        desLabel2.text=@"至少选2个号";
        desLabel3.text=@"至少选2个号";
        desLabel4.text=@"至少选2个号";

        colorLabel.text = @"猜中开奖号前2位(顺序不限)即奖<65>元";
        descriptionLabel.text = @"猜中开奖号前2位（顺序不限）即中奖";
        descriptionLabel.frame = CGRectMake(20, ORIGIN_Y(V0), 300, 20);
        mainScrollVIew.contentSize = CGSizeZero;
        zaixianLabel.frame = CGRectMake(10, 346, 150, 30);
        imageruan.frame = CGRectMake(103, 343, 205, 25);
        
		v1.hidden = YES;
		v2.hidden = YES;
        V0.hidden = NO;
        v3.hidden = YES;
        quan.hidden=YES;
        
        
        [YiLouUnderGCBallView addYiLouTextOnView:V0 dictionary:[self.yilouDic objectForKey:@"qet"] typeStr:@"zs" keyType:HasZero yiLouTag:1];
        
	}
    else if(lotterytype == eleven5_Q3Zu){
        if (self.issue) {
            titleLabel.text = [NSString stringWithFormat:@"前三组选%@期",[SharedMethod getLastTwoStr:self.issue]];
        }
        else {
            titleLabel.text = @"11选5前三组选";
        }

        lable.text = @"前三";
        desLabel1.text=@"至少选3个号";
        desLabel2.text=@"至少选3个号";
        desLabel3.text=@"至少选3个号";
        desLabel4.text=@"至少选3个号";

        colorLabel.text = @"猜中开奖号前3位(顺序不限)即奖<195>元";
        descriptionLabel.text = @"猜中开奖号前3位（顺序不限）即中奖";
        descriptionLabel.frame = CGRectMake(20, ORIGIN_Y(V0), 300, 20);
        mainScrollVIew.contentSize = CGSizeZero;
        zaixianLabel.frame = CGRectMake(10, 346, 150, 30);
        imageruan.frame = CGRectMake(103, 343, 205, 25);
        
		v1.hidden = YES;
		v2.hidden = YES;
        V0.hidden = NO;
        v3.hidden = YES;
        quan.hidden=YES;
        
        [YiLouUnderGCBallView addYiLouTextOnView:V0 dictionary:[self.yilouDic objectForKey:@"qst"] typeStr:@"zs" keyType:HasZero yiLouTag:1];

	}
	else if(lotterytype == eleven5_1){
        if (self.issue) {
            titleLabel.text = [NSString stringWithFormat:@"前一直选%@期",[SharedMethod getLastTwoStr:self.issue]];
        }
        else {
            titleLabel.text = @"11选5前一直选";
        }

        lable.text = @"一位";
        desLabel1.text=@"至少选1个号";
        desLabel2.text=@"至少选1个号";
        desLabel3.text=@"至少选1个号";
        desLabel4.text=@"至少选1个号";

        colorLabel.text = @"猜中开奖号第1位即奖<13>元";
        descriptionLabel.text = @"至少选1个号，与开奖号第1位相同即中奖";
        descriptionLabel.frame = CGRectMake(20, ORIGIN_Y(V0), 300, 20);
        mainScrollVIew.contentSize = CGSizeZero;
        zaixianLabel.frame = CGRectMake(10, 346, 150, 30);
        imageruan.frame = CGRectMake(103, 343, 205, 25);
		v1.hidden = YES;
		v2.hidden = YES;
        V0.hidden = NO;
        v3.hidden = YES;
        quan.hidden=YES;
        
        [YiLouUnderGCBallView addYiLouTextOnView:V0 dictionary:[self.yilouDic objectForKey:@"qet"] typeStr:@"一" keyType:HasZero yiLouTag:1];

	}
    else if (lotterytype >= eleven5_R2DanTuo) {

        yaoImage.hidden = YES;
        colorLabel.frame = CGRectMake(19, 53, 265, 19);

        NSInteger a = lotterytype - eleven5_R2DanTuo + 12;
        if (a< 0) {
            a = 0;
        }
        if (a >= [wanArray count]) {
            a = [wanArray count]-1;
        }
        if (self.issue) {
            titleLabel.text = [NSString stringWithFormat:@"%@%@期",[wanArray objectAtIndex:a],[SharedMethod getLastTwoStr:self.issue]];
        }
        else {
            titleLabel.text = [NSString  stringWithFormat:@"11选5%@", [wanArray objectAtIndex:a]];
        }

		v1.hidden = NO;
		v2.hidden = YES;
        V0.hidden = NO;
        v3.hidden = YES;
        quan.hidden=YES;
        
        mainScrollVIew.contentSize = CGSizeZero;

        NSArray * titleArray = [NSArray arrayWithObjects:@"猜中开奖号任意2个即奖<6>元",@"猜中开奖号任意3个即奖<19>元",@"猜中开奖号任意4个即奖<78>元",@"猜中全部5个开奖号即奖<540>元",@"猜中开奖号前2位(顺序不限)即奖<65>元",@"猜中开奖号前3位(顺序不限)即奖<195>元",nil];
        colorLabel.text = [NSString stringWithFormat:@"%@",[titleArray objectAtIndex:a - 12]];
        
        NSArray * titleArr = @[@"我认为必出的号码选1个",@"我认为必出的号码至少选1个,最多2个",@"我认为必出的号码至少选1个,最多3个",@"我认为必出的号码至少选1个,最多4个",@"我认为必出的号码选1个",@"我认为必出的号码至少选1个,最多2个"];
        
        lable.text = @"胆码";
        desLabel1.text = [NSString stringWithFormat:@"%@",[titleArr objectAtIndex:a - 12]];
        
        label1.text = @"拖码";
        desLabel2.text = @"我认为可能出的号码";
        
        if (lotterytype == eleven5_Q2DanTuo) {
            [YiLouUnderGCBallView addYiLouTextOnView:V0 dictionary:[self.yilouDic objectForKey:@"qet"] typeStr:@"zs" keyType:HasZero yiLouTag:1];
            [YiLouUnderGCBallView addYiLouTextOnView:v1 dictionary:[self.yilouDic objectForKey:@"qet"] typeStr:@"zs" keyType:HasZero yiLouTag:1];
        }
        else if (lotterytype == eleven5_Q3DanTuo) {
            [YiLouUnderGCBallView addYiLouTextOnView:V0 dictionary:[self.yilouDic objectForKey:@"qst"] typeStr:@"zs" keyType:HasZero yiLouTag:1];
            [YiLouUnderGCBallView addYiLouTextOnView:v1 dictionary:[self.yilouDic objectForKey:@"qst"] typeStr:@"zs" keyType:HasZero yiLouTag:1];
        }
        else {
            [YiLouUnderGCBallView addYiLouTextOnView:V0 dictionary:self.yilouDic typeStr:@"rt" keyType:HasZero yiLouTag:1];
            [YiLouUnderGCBallView addYiLouTextOnView:v1 dictionary:self.yilouDic typeStr:@"rt" keyType:HasZero yiLouTag:1];
        }
        
    }
    else {

        NSInteger a = lotterytype - (eleven5_1 + 1);
        if (a< 0) {
            a = 0;
        }
        if (a>= [wanArray count]) {
            a = [wanArray count]-1;
        }
        if (self.issue) {
            titleLabel.text = [NSString stringWithFormat:@"%@%@期",[wanArray objectAtIndex:a],[SharedMethod getLastTwoStr:self.issue]];
        }
        else {
            titleLabel.text = [NSString  stringWithFormat:@"11选5%@", [wanArray objectAtIndex:a]];
        }

        NSArray *jineArray = [NSArray arrayWithObjects:@"6",@"19",@"78",@"540",@"90",@"26",@"9", nil];
        colorLabel.text = [NSString stringWithFormat:@"单注奖金<%@>元",[jineArray objectAtIndex:a]];
        
        [YiLouUnderGCBallView addYiLouTextOnView:v3 dictionary:self.yilouDic typeStr:@"rt" keyType:HasZero yiLouTag:1];

        if (lotterytype == eleven5_2) {
            colorLabel.text = @"猜中开奖号任意2个即奖<6>元";
            lable.text = @"任选";
            desLabel1.text=@"至少选2个号";
            desLabel2.text=@"至少选2个号";
            desLabel3.text=@"至少选2个号";
            desLabel4.text=@"至少选2个号";
            descriptionLabel.text = @"至少选2个号，猜中开奖号任意2个即中奖";
            descriptionLabel.frame = CGRectMake(20, ORIGIN_Y(V0), 300, 20);
            mainScrollVIew.contentSize = CGSizeZero;
            zaixianLabel.frame = CGRectMake(10, 346, 150, 30);
            imageruan.frame = CGRectMake(103, 343, 205, 25);
        }
        else if (lotterytype == eleven5_3) {
            colorLabel.text = @"猜中开奖号任意3个即奖<19>元";
            lable.text = @"任选";
            desLabel1.text=@"至少选3个号";
            desLabel2.text=@"至少选3个号";
            desLabel3.text=@"至少选3个号";
            desLabel4.text=@"至少选3个号";
            descriptionLabel.text = @"至少选3个号，猜中开奖号任意3个即中奖";
            descriptionLabel.frame = CGRectMake(20, ORIGIN_Y(V0), 300, 20);
            mainScrollVIew.contentSize = CGSizeZero;
            zaixianLabel.frame = CGRectMake(10, 346, 150, 30);
            imageruan.frame = CGRectMake(103, 343, 205, 25);
        }
        else if (lotterytype == eleven5_4) {
            colorLabel.text = @"猜中开奖号任意4个即奖<78>元";
            lable.text = @"任选";
            desLabel1.text=@"至少选4个号";
            desLabel2.text=@"至少选4个号";
            desLabel3.text=@"至少选4个号";
            desLabel4.text=@"至少选4个号";
            descriptionLabel.text = @"至少选4个号，猜中开奖号任意4个即中奖";
            descriptionLabel.frame = CGRectMake(20, ORIGIN_Y(V0), 300, 20);
            mainScrollVIew.contentSize = CGSizeZero;
            zaixianLabel.frame = CGRectMake(10, 346, 150, 30);
            imageruan.frame = CGRectMake(103, 343, 205, 25);
        }
        else if (lotterytype == eleven5_5) {
            colorLabel.text = @"猜中全部5个开奖号即奖<540>元";
            lable.text = @"任选";
            desLabel1.text=@"至少选5个号";
            desLabel2.text=@"至少选5个号";
            desLabel3.text=@"至少选5个号";
            desLabel4.text=@"至少选5个号";
            descriptionLabel.text = @"至少选5个号，猜中全部开奖号即中奖";
            descriptionLabel.frame = CGRectMake(20, ORIGIN_Y(V0), 300, 20);
            mainScrollVIew.contentSize = CGSizeZero;
            zaixianLabel.frame = CGRectMake(10, 346, 150, 30);
            imageruan.frame = CGRectMake(103, 343, 205, 25);
        }
        else if (lotterytype == eleven5_6) {
            colorLabel.text = @"猜中全部5个开奖号即奖<90>元";
            lable.text = @"任选";
            desLabel1.text=@"至少选6个号";
            desLabel2.text=@"至少选6个号";
            desLabel3.text=@"至少选6个号";
            desLabel4.text=@"至少选6个号";
            descriptionLabel.text = @"至少选6个号，任意5个与开奖号一致即中奖";
            descriptionLabel.frame = CGRectMake(20, ORIGIN_Y(V0), 300, 20);
            mainScrollVIew.contentSize = CGSizeZero;
            zaixianLabel.frame = CGRectMake(10, 346, 150, 30);
            imageruan.frame = CGRectMake(103, 343, 205, 25);
        }
        else if (lotterytype == eleven5_7) {
            colorLabel.text = @"猜中全部5个开奖号即奖<26>元";
            lable.text = @"任选";
            desLabel1.text=@"至少选7个号";
            desLabel2.text=@"至少选7个号";
            desLabel3.text=@"至少选7个号";
            desLabel4.text=@"至少选7个号";
            descriptionLabel.text = @"至少选7个号，任意5个与开奖号一致即中奖";
            descriptionLabel.frame = CGRectMake(20, ORIGIN_Y(V0), 300, 20);
            mainScrollVIew.contentSize = CGSizeZero;
            zaixianLabel.frame = CGRectMake(10, 346, 150, 30);
            imageruan.frame = CGRectMake(103, 343, 205, 25);
        }
        else if (lotterytype == eleven5_8) {
            colorLabel.text = @"猜中全部5个开奖号即奖<9>元";
            lable.text = @"任选";
            desLabel1.text=@"至少选8个号";
            desLabel2.text=@"至少选8个号";
            desLabel3.text=@"至少选8个号";
            desLabel4.text=@"至少选8个号";
            descriptionLabel.text = @"至少选8个号，任意5个与开奖号一致即中奖";
            descriptionLabel.frame = CGRectMake(20, ORIGIN_Y(V0), 300, 20);
            mainScrollVIew.contentSize = CGSizeZero;
            zaixianLabel.frame = CGRectMake(10, 346, 150, 30);
            imageruan.frame = CGRectMake(103, 343, 205, 25);
        }

		v1.hidden = YES;
		v2.hidden = YES;
        V0.hidden = YES;
        v3.hidden = NO;
        if(lotterytype == eleven5_8)
        {
            quan.hidden=NO;
        }
        else
        {
            quan.hidden=YES;
        }
    }

    UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
    UILabel *jt = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
    CGSize labelSize = [tl.text sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:UILineBreakModeCharacterWrap];
    
    tl.frame = CGRectMake((320 - labelSize.width - 17 - 1)/2 - self.CP_navigation.titleView.frame.origin.x, 0, labelSize.width, 44);
    jt.frame = CGRectMake(tl.frame.origin.x + labelSize.width + 2, 14.5, 17, 17);

    if (mainScrollVIew.contentSize.height > self.view.frame.size.height - 44 - isIOS7Pianyi) {
        mainScrollVIew.frame = CGRectMake(mainScrollVIew.frame.origin.x, mainScrollVIew.frame.origin.y, mainScrollVIew.frame.size.width, mainScrollVIew.contentSize.height + 10);
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, mainScrollVIew.frame.size.height);
    }else{
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, self.view.frame.size.height - 44 - isIOS7Pianyi);
    }
    cpLowermostScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(_mainView) + 44 + isIOS7Pianyi);
    if (self.showYiLou) {
        self.showYiLou = YES;
    }
    [self guanbidonghua];
}

- (void)pressBgButton:(UIButton *)sender{
    
	if (sender.tag < 7)  {
		lotterytype = eleven5_1 + (int)sender.tag +1;
	}
	
	else  if (sender.tag == 8) {
        
		lotterytype = eleven5_Q2Zhi;
		
	}
	else if(sender.tag == 9){
		lotterytype = eleven5_Q3Zhi;
	}
	else if(sender.tag == 7){
		lotterytype = eleven5_1;
        
	}
    else if (sender.tag == 10) {
        lotterytype = eleven5_Q2Zu;
    }
    else if (sender.tag == 11) {
        lotterytype = eleven5_Q3Zu;
    }
    else if (sender.tag > 11) {
		lotterytype = eleven5_R2DanTuo + (int)sender.tag - 12;
    }
    if (myElevenType == ShanDong11) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",lotterytype] forKey:@"11Xuan5DefaultModetype"];
    }
    else if (myElevenType == GuangDong11) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",lotterytype] forKey:@"GD11Xuan5DefaultModetype"];
    }
    else if (myElevenType == JiangXi11) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",lotterytype] forKey:@"JX11Xuan5DefaultModetype"];
    }
    else if (myElevenType == HeBei11) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",lotterytype] forKey:@"HB11Xuan5DefaultModetype"];
    }
    else if (myElevenType == ShanXi11) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",lotterytype] forKey:@"ShanXi11Xuan5DefaultModetype"];
    }
    [self changeTitle];
}


- (void)doBack {
    [self.myTimer invalidate];
	self.myTimer = nil;
	[self.runTimer invalidate];
	self.runTimer = nil;
	[self.navigationController popViewControllerAnimated:YES];
}

//玩法介绍
- (void)wanfaInfo {
    [MobClick event:@"event_goucai_wanfashuoming_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:myLotteryID]];

	Xieyi365ViewController *xie= [[[Xieyi365ViewController alloc] init] autorelease];
    if (myElevenType == ShanDong11) {
        xie.ALLWANFA = ShiYiXuan5;
    }
    else if (myElevenType == GuangDong11) {
        xie.ALLWANFA = GDShiYiXuan5;
    }
    else if (myElevenType == JiangXi11) {
        xie.ALLWANFA = JXShiYiXuan5;
    }
    else if (myElevenType == HeBei11) {
        xie.ALLWANFA = HBShiYiXuan5;
    }
    else if (myElevenType == ShanXi11) {
        xie.ALLWANFA = ShanXiShiYiXuan5;
    }
	[self.navigationController pushViewController:xie animated:YES];
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

    [btn setImage:UIImageGetImageFromName(@"chaodancaidan.png") forState:UIControlStateNormal];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan_1.png") forState:UIControlStateHighlighted];

    btn.frame = CGRectMake(0, 0, 60, 44);
    [btn addTarget:self action:@selector(pressMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
}

-(void)createTimer
{
    @autoreleasepool {
        if (!myTimer) {
            self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
            entRunLoopRef = CFRunLoopGetCurrent();
            CFRunLoopRun();
        }
    }
}


#pragma mark -
#pragma mark GCBallViewDelegate

- (void)ballSelectChange:(UIButton *)imageView {
	NSUInteger bets = 0;
	if (lotterytype == eleven5_Q2Zhi || lotterytype == eleven5_Q3Zhi ) {
        
        if (imageView) {
            for (int i = 1000; i <1003; i++) {
                if (imageView.superview.tag != i) {
                    UIView *v = [mainScrollVIew viewWithTag:i];
                    GCBallView *ball = (GCBallView *)[v viewWithTag:imageView.tag];
                    if ([ball isKindOfClass:[GCBallView class]] &&ball.selected == YES) {
                        imageView.selected = NO;
                        [[caiboAppDelegate getAppDelegate] showMessage:@"每一位不能重复"];
                        return;
                    }
                }
            }
        }
        
		bets = [GC_LotteryUtil getBets:[self seletNumber] LotteryType:lotterytype ModeType:M11XUAN5dingwei];
	}
	else if (lotterytype == eleven5_1) {
		bets = ([[self seletNumber]length]+1)/3;
	}
    else if (lotterytype == eleven5_8){

        bets = [GC_LotteryUtil getBets:[self seletNumber] LotteryType:lotterytype ModeType:M11XUAN5fushi];
    }
	else {
        UIView * v = nil;
        UIView * v2 = nil;
        if (imageView.superview.tag == 1000 ) {
            int i = 0;
            for (UIButton *btn in imageView.superview.subviews) {
                if ([btn isKindOfClass:[UIButton class]]&&btn.selected == YES) {
                    i++;
                }
            }
            int a = 1;
            if (lotterytype >= eleven5_R2DanTuo && lotterytype <= eleven5_R5DanTuo) {
                a = lotterytype - eleven5_R2DanTuo + 1;
            }
            if (lotterytype >= eleven5_Q2DanTuo) {
                a = lotterytype - eleven5_Q2DanTuo + 1;
            }
            if (imageView.selected && lotterytype >= eleven5_R2DanTuo && i>a) {
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:[NSString stringWithFormat:@"胆码最多选择%d个球",a]];
                imageView.selected = NO;
                [self ballSelectChange:nil];
                return;
            }

            v = [mainScrollVIew viewWithTag:1001];
            v2 = [mainScrollVIew viewWithTag:1000];
        }
        else if (imageView.superview.tag == 1001 ) {

            v = [mainScrollVIew viewWithTag:1000];
            v2 = [mainScrollVIew viewWithTag:1001];
        }
        if (lotterytype) {
            
        }
        GCBallView *btn2 = (GCBallView *)[v viewWithTag:imageView.tag];
        GCBallView *btn3 = (GCBallView *)[v2 viewWithTag:imageView.tag];
        if (!btn2.selected && btn3.selected) {
            [btn2 changetolight];
        }
        else {
            [btn2 chanetoNomore];
            
        }
        UIButton *btn = (UIButton *)[v viewWithTag:imageView.tag];
        if (lotterytype >= eleven5_R2DanTuo && [btn isKindOfClass:[UIButton class]]&&btn.selected == YES) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"胆码和拖码不能相同"];
            imageView.selected = NO;
            return;
        }
		bets = [GC_LotteryUtil getBets:[self seletNumber] LotteryType:lotterytype ModeType:M11XUAN5fushi];
        
	}
	
    zhushuLabel.text = [NSString stringWithFormat:@"%d",(int)bets];
	jineLabel.text = [NSString stringWithFormat:@"%d",2*(int)bets];
    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
    NSString *str = [[[self seletNumber] stringByReplacingOccurrencesOfString:@"|" withString:@""]                      stringByReplacingOccurrencesOfString:@"," withString:@""];
    if ([str length] == 0) {
        if (lotterytype < eleven5_R2DanTuo) {

            labe.text = @"机选";
            labe.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
        
            senBtn.enabled = YES;
        }
        else {
            labe.text = @"选好了";
            senBtn.enabled = NO;
            labe.textColor = [UIColor colorWithRed:63/255.0 green:59/255.0 blue:47/255.0 alpha:1];
        }
    }
    else {
        labe.text = @"选好了";
        labe.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
        
        senBtn.enabled = YES;
    }
    
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)reqLotteryInfoFailed:(ASIHTTPRequest*)request {
    [self.myTimer invalidate];
    self.myTimer = nil;
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    self.yilouDic = nil;
    [self changeTitle];
    hasYiLou = NO;
}

- (void)reqLotteryInfoFinished:(ASIHTTPRequest*)request {
	if ([request responseData]) {
        
        IssueRecord *issrecord = [[IssueRecord alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (issrecord.returnId == 3000) {
            [issrecord release];
            return;
        }

        if ([issrecord.curIssue intValue] == 0) {
            [self.myTimer invalidate];
            self.myTimer = nil;
            sqkaijiang.text = @"当日截期";
            image1BackView.hidden = YES;
            [issrecord release];
            return;
        }
        else {
            image1BackView.hidden = NO;
        }
        yanchiTime = [issrecord.lotteryStatus intValue];
        if ([self.issue length] && ![self.issue isEqualToString:issrecord.curIssue] && isAppear == YES) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"               <%@期已截止>\n当前期是%@期，投注时请注意期次",[SharedMethod getLastTwoStr:self.issue],[SharedMethod getLastTwoStr:issrecord.curIssue]] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            alert.alertTpye = jieQiType;
            [alert show];
            [alert release];
        }
        
        self.issue = issrecord.curIssue;
        if ([[issrecord.lastLotteryNumber componentsSeparatedByString:@"#"] count] > 0) {
            if ([issrecord.curIssue longLongValue] - [[[issrecord.lastLotteryNumber componentsSeparatedByString:@"#"] objectAtIndex:0] longLongValue] >= 2) {
                isKaiJiang = NO;
                
                if (canRefreshYiLou) {
                    self.yilouDic = nil;
                    [self changeTitle];
                    hasYiLou = NO;
                }
            }
            else {
                isKaiJiang = YES;
                
                if (![myIssrecord isEqualToString:issrecord.curIssue]) {
                    if ([colorLabel.text isEqualToString:@"上期等待开奖..."]) {
                        [self performSelector:@selector(getWangqi) withObject:nil afterDelay:60];
                    }
                    [self getYilou];
                }else if (!hasYiLou && canRefreshYiLou) {
                    [self getYilou];
                }
                canRefreshYiLou = YES;
                
                self.myIssrecord = issrecord.curIssue;
            }
        }
        

        sqkaijiang.text = [NSString stringWithFormat:@"%@>",[issrecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"#" withString:@"期开奖 <"]];
        sqkaijiang.text = [sqkaijiang.text stringByReplacingOccurrencesOfString:@"," withString:@" "];

        if ([sqkaijiang.text length] >= 20) {
            sqkaijiang.text = [sqkaijiang.text substringFromIndex:sqkaijiang.text.length-22];
        }
        
        timeLabel.text = [NSString stringWithFormat:@"距%@",[SharedMethod getLastTwoStr:issrecord.curIssue]];
        mytimeLabel3.text = [NSString stringWithFormat:@"%02d:%02d",(int)seconds/60,(int)seconds%60];
        NSArray *array = [issrecord.remainingTime componentsSeparatedByString:@":"];
        if ([array count] == 3) {
            seconds = 60*[[array objectAtIndex:1]intValue]+[[array objectAtIndex:2] intValue];
            if (seconds%2 == 1) {
                seconds = seconds + 1;
            }
            [self.myTimer invalidate];
            self.myTimer = nil;
            [self performSelectorInBackground:@selector(createTimer) withObject:nil];
        }
        if (showXiaoxi && ( ![self.issue isEqualToString:issrecord.curIssue] || !self.zhongJiang)) {
            NSMutableData *postData = [[GC_HttpService sharedInstance] reZhongjiangWithLottery:myLotteryID iss:[NSString stringWithFormat:@"%d",[self.issue intValue] - 1] countOfPage:50];
            
            [myRequest clearDelegatesAndCancel];
            self.myRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
            [myRequest setRequestMethod:@"POST"];
            [myRequest addCommHeaders];
            [myRequest setPostBody:postData];
            [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
            [myRequest setDelegate:self];
            [myRequest setDidFinishSelector:@selector(reqZhongJiang:)];
//            [myRequest startAsynchronous];
        }
        else {
            
        }
		[issrecord release];
	}else{
        self.yilouDic = nil;
        [self changeTitle];
        hasYiLou = NO;
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
        [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
    }
}

- (void)getYilou {
    self.yilouDic = nil;
    [self changeTitle];
    
    NSDictionary *yilou_Dic = [[NSUserDefaults standardUserDefaults] valueForKey:myLotteryID];
    
    if([yilou_Dic objectForKey:self.issue]){
        [self ShowYilouByHuancun:[yilou_Dic objectForKey:self.issue]];
        return;
    }
    
    [self.yilouRequest clearDelegatesAndCancel];
    if (!myIssrecord) {
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:myLotteryID itemNum:@"1" issue:nil]];
    }else{
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:myLotteryID itemNum:@"1" issue:nil cacheable:YES]];
    }
    [yilouRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [yilouRequest setDelegate:self];
    [yilouRequest setDidFinishSelector:@selector(reqYilouFinished:)];
    [yilouRequest setDidFailSelector:@selector(rebuyFail:)];
    [yilouRequest startAsynchronous];
}

- (void)ShowYilouByHuancun:(NSDictionary *)responseDic {
    
    self.yilouDic = responseDic;
 
    if ([[yilouDic objectForKey:@"rt"] count]) {
        
        hasYiLou = YES;
        
        if (showYiLou) {
            [self upDateYiLou];
        }
    }else{
        hasYiLou = NO;
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
        [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
    }
    
    [self changeTitle];

 }

- (void)reqYilouFinished:(ASIHTTPRequest*)request {
    
    NSString *responseStr = [request responseString];
    if (responseStr && ![responseStr isEqualToString:@"fail"] && [responseStr length]) {
        
        NSDictionary * responseDic = [responseStr JSONValue];
       
        NSArray * resultArray = [responseDic objectForKey:@"list"];
        
        if (resultArray.count) {
            self.yilouDic = [resultArray objectAtIndex:0];
            if ([[yilouDic objectForKey:@"rt"] count]) {
                
                //删除旧的遗漏值
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:myLotteryID];
                NSDictionary *yilouHuancunDic = [NSDictionary dictionaryWithObjectsAndKeys:yilouDic,self.issue, nil];
                [[NSUserDefaults standardUserDefaults] setValue:yilouHuancunDic forKey:myLotteryID];
                
                hasYiLou = YES;
                if (showYiLou) {
                    [self upDateYiLou];
                }
            }else{
                hasYiLou = NO;
                [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
                [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
            }
        }else{
            hasYiLou = NO;
            [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
            [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
        }
        
    }else{
        self.yilouDic = nil;
        hasYiLou = NO;
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
        [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
    }
    [self changeTitle];
}

- (void)reqZhongJiang:(ASIHTTPRequest*)request {
	if ([request responseData]) {
		WangQiZhongJiang *wang = [[WangQiZhongJiang alloc] initWithResponseData:[request responseData] WithRequest:request];
		self.zhongJiang = wang;
		[self.runTimer invalidate];
		self.runTimer = nil;
//		zaixianLabel.text = [NSString stringWithFormat:@"在线<%d>人",wang.AllNum];
		[[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(hidenranLabel) object:nil];
		self.runTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showranLabel) userInfo:nil repeats:YES];
        [wang release];
	}
}

- (void)reqWangQiKaiJiang:(ASIHTTPRequest*)request {
	if ([request responseData]) {
		WangqiKaJiangList *wang = [[[WangqiKaJiangList alloc] initWithResponseData:[request responseData] WithRequest:request] autorelease];
//		self.wangQi = wang;
//        [mytableView reloadData];
//        [_cpTableView reloadData];
        
        NSMutableArray * historyArr = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
        [historyArr addObject:@[@"期号",@"开奖号",@"大小比",@"奇偶比"]];
        
        int count = 5;
        if (wang.brInforArray.count < 5) {
            count = (int)wang.brInforArray.count;
        }
        for (int i = 0; i < count; i++) {
            NSMutableArray * dataArray = [[NSMutableArray alloc] initWithCapacity:10];
            KaiJiangInfo * info = [wang.brInforArray objectAtIndex:i];
            
            [dataArray addObject:[NSString stringWithFormat:@"%@期",[SharedMethod getLastTwoStr:info.issue]]];

            NSArray * numberArray = [info.num componentsSeparatedByString:@" "];
            NSString * numberString = @"";
            int large = 0;
            int small = 0;
            int odd = 0;
            int even = 0;
            
            for (int j = 0; j < numberArray.count; j++) {
                if ([[numberArray objectAtIndex:j] integerValue] >= 6) {
                    large++;
                }else{
                    small++;
                }
                if ([[numberArray objectAtIndex:j] integerValue] %2 == 0) {
                    even++;
                }else{
                    odd++;
                }
                numberString =  [numberString stringByAppendingString:[numberArray objectAtIndex:j]];
                
                if (j != numberArray.count - 1) {
                    numberString =  [numberString stringByAppendingString:@" "];
                }
            }
            [dataArray addObject:numberString];
            [dataArray addObject:[NSString stringWithFormat:@"%d:%d",large,small]];
            [dataArray addObject:[NSString stringWithFormat:@"%d:%d",odd,even]];
            
            [historyArr addObject:dataArray];
            
            [dataArray release];
        }
        [self addHistoryWithArray:historyArr];
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
#pragma mark CP_KindsOfChooseDelegate

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt {

    self.showYiLou = NO;
    if ([returnarry count] == 1) {
        NSString *wanfaname = [returnarry objectAtIndex:0];
        NSInteger tag = [wanArray indexOfObject:wanfaname];
        if (tag >= 0 && tag < 100) {
            UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
            sender.tag =tag;
            [self pressBgButton:sender];
            [self clearBalls];
            [self changeTitle];
        }
    }
}

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView chuanButtonIndex:(NSInteger)buttonIndex button:(CP_XZButton*)sender {
}
-(void)disMissWithPressOtherFrame:(CP_KindsOfChoose *)chooseView
{
    [self guanbidonghua];
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

-(void)animationCompleted:(GifButton *)gifButton
{
    UIView *v1 = nil;
    if(gifButton.superview.tag == 1000)
    {
        v1 = [mainScrollVIew viewWithTag:1001];
    }
    else if(gifButton.superview.tag == 1001)
    {
        v1 = [mainScrollVIew viewWithTag:1000];
    }
    for (GCBallView *ball in v1.subviews) {
        if ([ball isKindOfClass:[GCBallView class]]) {
            [ball chanetoNomore];
        }
    }
    [self ballSelectChange:nil];
}

-(void)zhankaidonghua
{
    UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGAffineTransform transForm = CGAffineTransformMakeRotation(M_PI*1);
        sanjiao.transform = transForm;
    }];
}

-(void)guanbidonghua
{
    UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGAffineTransform transForm = CGAffineTransformMakeRotation(0);
        sanjiao.transform = transForm;
    }];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    