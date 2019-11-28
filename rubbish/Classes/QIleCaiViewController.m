//
//  QIleCaiViewController.m
//  caibo
//
//  Created by yaofuyu on 12-9-18.
//
//

#import "QIleCaiViewController.h"
#import "ShakeView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Info.h"
#import "GC_LotteryUtil.h"
#import "caiboAppDelegate.h"
#import "Xieyi365ViewController.h"
#import "LoginViewController.h"
#import "LotteryListViewController.h"
#import "GCHeMaiInfoViewController.h"
#import "MobClick.h"
#import "NetURL.h"
#import "JSON.h"
#import "YiLouUnderGCBallView.h"

#import "SharedMethod.h"

#define LOTTERY_ID @"003"

@interface QIleCaiViewController ()

@end

@implementation QIleCaiViewController

@synthesize myissueRecord;
@synthesize isHemai;
@synthesize myRequest;
@synthesize qilecaiType;
@synthesize jiangchi;
@synthesize myHttpRequest;
@synthesize wangQi;
@synthesize qihaoReQuest;

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
    if ( self) {
        isHemai = NO;
        redNum = 7;
        wanArray = [[NSArray alloc] initWithObjects:@"普通投注",@"胆拖投注",nil];
//        isBackScrollView = YES;
        isVerticalBackScrollView = YES;
    }
    return self;
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
#pragma mark-
#pragma Action

- (void)changeTitle {

    //title
    
#ifdef isCaiPiaoForIPad
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(50 + 35, 0, 270, 44)];
#else
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(50+15, 0, 270, 44)];
#endif
    titleView.backgroundColor = [UIColor clearColor];
    titleView.userInteractionEnabled = YES;
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    if (qilecaiType == QileCaiTypePuTong) {
        titleLabel.text = @"普通投注";
    }
    else {
        titleLabel.text = @"胆拖投注";
    }
    if (self.myissueRecord) {
//        titleLabel.text = [NSString stringWithFormat:@"%@-%@期",titleLabel.text,self.myissueRecord.curIssue];
        titleLabel.text = [NSString stringWithFormat:@"%@-%@期",titleLabel.text,[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]];
    }
    titleLabel.textColor = [UIColor whiteColor];
    
    CGSize labelSize = [titleLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:UILineBreakModeCharacterWrap];
    
//    UILabel *JTLabel = [[UILabel alloc] init];
//    JTLabel.backgroundColor = [UIColor clearColor];
//    JTLabel.textAlignment = NSTextAlignmentCenter;
//    JTLabel.font = [UIFont systemFontOfSize:12];
//    JTLabel.text = @"▼";
//    JTLabel.textColor = [UIColor whiteColor];
//    JTLabel.shadowColor = [UIColor blackColor];
//    JTLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    
    sanjiaoImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]] autorelease];
    sanjiaoImageView.tag=567;
    [titleView addSubview:sanjiaoImageView];
    
    if ([[[Info getInstance] userId] intValue] == 0) {
        
        titleLabel.frame = CGRectMake(20, 0, 220, 44);
        sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + labelSize.width - 1, 14, 17, 17);
        
        //        titleLabel.frame = CGRectMake(15, 0, 220, 44);
        //        JTLabel.frame = CGRectMake(173, 1, 20, 44);
        
    }else {
        
        
        titleLabel.frame = CGRectMake(30, 0, 220, 44);
        sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + labelSize.width + 2, 14, 17, 17);
        //        titleLabel.frame = CGRectMake(20, 0, 220, 44);
        //        JTLabel.frame = CGRectMake(180, 1, 20, 44);
        
    }
    
//    [titleView addSubview:JTLabel];
//    [JTLabel release];
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(0, 0, 270, 44);
    titleButton.backgroundColor = [UIColor clearColor];
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleButton addTarget:self action:@selector(pressTitleButton1:) forControlEvents:UIControlEventTouchDown];
    [titleButton addTarget:self action:@selector(pressTitleButton2:) forControlEvents:UIControlEventTouchCancel];

    [titleView addSubview:titleLabel];
    [titleView addSubview:titleButton];
    self.CP_navigation.titleView = titleView;
    [titleLabel release];
    [titleView release];
    [self guanbidonghua];
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
            [self zhankaidonghua];
            alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"玩法选择" ShuziNameArray:wanArray shuziArray:nil];
            
            alert2.duoXuanBool = NO;
            alert2.tag = 101;
            alert2.delegate = self;
            isShowing = YES;
            alert2.isClearBtnCanPress = NO;
            [self.view addSubview:self.CP_navigation];
            [alert2 show];
            self.CP_navigation.frame = CGRectMake(0, 20, 320, 44);
            [self.CP_navigation.window addSubview:alert2];
            [self.CP_navigation.window addSubview:self.CP_navigation];
            

            for (CP_XZButton *btn in alert2.backScrollView.subviews) {
                if ([btn isKindOfClass:[UIButton class]] && btn.tag == qilecaiType) {
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

#pragma mark -
#pragma mark CP_KindsOfChooseDelegate
- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt {
    
    if (chooseView.tag == 101) {
    
//        if (buttonIndex == 1) {


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
        }
    }
    
    if(buttonIndex == 0)
    {
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, backView.frame.size.height);
    }
    else
    {
        backScrollView.frame = CGRectMake(backScrollView.frame.origin.x, backScrollView.frame.origin.y, backScrollView.frame.size.width, backScrollView.contentSize.height + 10);
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, backScrollView.frame.size.height);
    }
    cpLowermostScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(_mainView) + 44 + isIOS7Pianyi);
    
}

-(void)CP_KindsOfChooseViewAlreadyShowed:(CP_KindsOfChoose *)chooseView
{
    titleBtnIsCanPress = YES;
}
-(void)disMissWithPressOtherFrame:(CP_KindsOfChoose *)chooseView
{
    [self guanbidonghua];
    isShowing = NO;
    [alert2 release];
    [self addNavAgain];
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
- (void)createBackScrollView {
    if (!backScrollView) {
        backScrollView  = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
        [self.mainView insertSubview:backScrollView atIndex:3];
        [backScrollView release];
#ifdef isCaiPiaoForIPad
        backScrollView.frame = CGRectMake(35, 0, 320,self.mainView.bounds.size.height);
        
#endif
        backScrollView.hidden = YES;
        if (backScrollView) {
            
            backScrollView.contentSize = CGSizeMake(320, 520);
            
            
//            UIImageView *image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 10, 190, 47)];
            UIImageView *image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 37)];
            [backScrollView addSubview:image1BackView];
//            image1BackView.image = [UIImageGetImageFromName(@"GC_sqkjback.png")stretchableImageWithLeftCapWidth:5 topCapHeight:5];
            image1BackView.layer.masksToBounds = YES;
            image1BackView.backgroundColor = [UIColor whiteColor];
            [image1BackView release];
            
//            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 23, 195, 2)];
//            imageV.image = UIImageGetImageFromName(@"SZTG960.png");
//            [image1BackView addSubview:imageV];
//            [imageV release];
            
            //上期开奖
//            UILabel *sqkaijiang = [[UILabel alloc] initWithFrame:CGRectMake(125, 19, 48, 11)];
            UILabel *sqkaijiang = [[UILabel alloc] initWithFrame:CGRectMake(14, 11, 60, 15)];
            sqkaijiang.backgroundColor = [UIColor clearColor];
            sqkaijiang.font = [UIFont boldSystemFontOfSize:13];
            sqkaijiang.text = @"上期开奖";
            sqkaijiang.textColor = [UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
            [backScrollView addSubview:sqkaijiang];
            [sqkaijiang release];
//            ColorView *sqkaijiang2 = [[ColorView alloc] initWithFrame:CGRectMake(165, 17, 155, 12)];
            ColorView *sqkaijiang2 = [[ColorView alloc] initWithFrame:CGRectMake(80, 11, 165, 15)];
            sqkaijiang2.tag = 1101;
            sqkaijiang2.textAlignment = NSTextAlignmentLeft;
            sqkaijiang2.backgroundColor = [UIColor clearColor];
            sqkaijiang2.font = [UIFont boldSystemFontOfSize:13];
            sqkaijiang2.changeColor = [UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
            if (self.myissueRecord) {
                NSArray *array = [self.myissueRecord.lastLotteryNumber componentsSeparatedByString:@"#"];
                sqkaijiang2.text = [NSString stringWithFormat:@"%@>",[[self.myissueRecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"+" withString:@" <"] stringByReplacingOccurrencesOfString:@"," withString:@" "]];
                if ([array count] > 1) {
                    sqkaijiang2.text = [NSString stringWithFormat:@"%@>",[[[array objectAtIndex:1] stringByReplacingOccurrencesOfString:@"+" withString:@" <"] stringByReplacingOccurrencesOfString:@"," withString:@" "]];
                }

            }
            sqkaijiang2.textColor = [UIColor redColor];
            [backScrollView addSubview:sqkaijiang2];
            [sqkaijiang2 release];
            
//            endTimelable2 = [[ColorView alloc] initWithFrame:CGRectMake(25, 30, 150, 20)];
            endTimelable2 = [[ColorView alloc] init];
            endTimelable2.frame=CGRectMake(15+165, backView.frame.size.height-64, 200, 20);
            [backScrollView addSubview:endTimelable2];
            endTimelable2.backgroundColor = [UIColor clearColor];
            endTimelable2.font = [UIFont boldSystemFontOfSize:12];
            endTimelable2.textColor=[UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
//            endTimelable2.colorfont = [UIFont boldSystemFontOfSize:12];
            if (self.myissueRecord) {
//                endTimelable2.text = [NSString stringWithFormat:@"截止时间 %@",self.myissueRecord.curEndTime];
                endTimelable2
                .text = [NSString stringWithFormat:@"截止时间 %@",[SharedMethod changeDateToNoYearNoSecond:self.myissueRecord.curEndTime]];
            }
            [endTimelable2 release];
            
            //红球背景
//            UIImageView *backImageV2 = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"TZAHDSSQBG960.png")];
            UIImageView *backImageV2 = [[UIImageView alloc] init];
//            if (SWITCH_ON) {
//                backImageV2.frame = CGRectMake(10, 37 + 30, 300.5, 276);
//            }else{
                backImageV2.frame = CGRectMake(0, 37+18, 320, 350);
//            }
            backImageV2.tag = 800;
            backImageV2.userInteractionEnabled = YES;
            backImageV2.backgroundColor=[UIColor clearColor];
            [backScrollView addSubview:backImageV2];
            [backImageV2 release];
            
            UIImageView *imaHong=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 54, 22)];
            imaHong.backgroundColor=[UIColor clearColor];
            imaHong.tag=10010;
            imaHong.image=[UIImage imageNamed:@"LeftTitleRed.png"];
            [backImageV2 addSubview:imaHong];
            [imaHong release];
            
            UILabel *desLabel1 = [[UILabel alloc] init];
            desLabel1.backgroundColor=[UIColor clearColor];
            desLabel1.textColor=[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
//            desLabel1.frame=CGRectMake(60, 2, 200, 22);
            desLabel1.frame=CGRectMake(60, 2, 240, 22);
            desLabel1.tag=2800;
//            desLabel1.text=@"选1-6个球,胆码+拖码至少选8个";
            desLabel1.text=@"我认为必出的号，至少选1个，最多6个";
            desLabel1.font=[UIFont systemFontOfSize:12];
            [backImageV2 addSubview:desLabel1];
            [desLabel1 release];
            
            UILabel *hqlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 54, 22)];
            hqlabel.backgroundColor = [UIColor clearColor];
            hqlabel.text = @"胆码";
            hqlabel.textAlignment=NSTextAlignmentCenter;
            hqlabel.textColor = [UIColor whiteColor];
            hqlabel.font = [UIFont boldSystemFontOfSize:15];
//            hqlabel.shadowColor = [UIColor blackColor];
//            hqlabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
            [backImageV2 addSubview:hqlabel];
            [hqlabel release];
//            UILabel *hqlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(9, 37, 20, 16)];
//            hqlabel2.backgroundColor = [UIColor clearColor];
//            hqlabel2.text = @"码";
//            hqlabel2.textColor = [UIColor whiteColor];
//            hqlabel2.font = [UIFont boldSystemFontOfSize:15];
//            hqlabel2.shadowColor = [UIColor blackColor];
//            hqlabel2.shadowOffset = CGSizeMake(0.0f, 1.0f);
//            [backImageV2 addSubview:hqlabel2];
//            [hqlabel2 release];
//            UILabel *hqlabel3 = [[UILabel alloc] initWithFrame:CGRectMake(6, 52, 23, 23)];
//            hqlabel3.backgroundColor = [UIColor clearColor];
//            hqlabel3.text = @"1-6";
//            hqlabel3.textColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
//            hqlabel3.font = [UIFont systemFontOfSize:13];
//            [backImageV2 addSubview:hqlabel3];
//            [hqlabel3 release];
            
            CGRect ballRect;

            UIView *redView = [[UIView alloc] init];
            redView.tag = 2010;
            redView.backgroundColor = [UIColor clearColor];
//            redView.frame = CGRectMake(37, 8, backImageV2.frame.size.width - 40, backImageV2.frame.size.height - 16);
            redView.frame = CGRectMake(0, 30, 320, backImageV2.frame.size.height-30);
            redView.userInteractionEnabled = YES;
            for (int i = 0; i<30; i++) {
                int a= i/6,b = i%6;
                NSString *num = [NSString stringWithFormat:@"%d",i+1];
                if (i+1<10) {
                    num = [NSString stringWithFormat:@"0%d",i+1];
                }
                
//                if (SWITCH_ON) {
//                    ballRect = CGRectMake(b*42 + 6, a*51+ 5, 35, 36);
//                }else{
//                    ballRect = CGRectMake(b*42 + 6, a*37, 35, 36);
                ballRect = CGRectMake(b*51+14, a*52, 35, 35);
//                }
                GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorRed];
                [redView addSubview:im];
                im.tag = i;
                im.isBlack = YES;
                im.gcballDelegate = self;
//                if (!SWITCH_ON) {
//                    im.ylLable.hidden = YES;
//                }
                [im release];
            }
            GifButton * redTrashButton = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(13, 5*52-5, 35, 35)] autorelease];
            redTrashButton.tag = 333;
            redTrashButton.delegate=self;
            [redView addSubview:redTrashButton];
            
            [backImageV2 addSubview:redView];
            [redView release];
            
            //红球背景2
//            UIImageView *backImageV23 = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"TZAHDSSQBG960.png")];
            UIImageView *backImageV23 = [[UIImageView alloc] init];
//            if (SWITCH_ON) {
//                backImageV23.frame = CGRectMake(10, ORIGIN_Y(backImageV2) + 3.5, 300.5, 276);
//            }else{
                backImageV23.frame = CGRectMake(0, backImageV2.frame.size.height+backImageV2.frame.origin.y, 320, 350);
//            }
            backImageV23.tag = 801;
            backImageV23.userInteractionEnabled = YES;
            backImageV23.backgroundColor=[UIColor clearColor];
            [backScrollView addSubview:backImageV23];
            [backImageV23 release];
            
            UIImageView *imaHong2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 54, 22)];
            imaHong2.backgroundColor=[UIColor clearColor];
            imaHong2.tag=10010;
            imaHong2.image=[UIImage imageNamed:@"LeftTitleRed.png"];
            [backImageV23 addSubview:imaHong2];
            [imaHong2 release];
            
            UILabel *desLabel2 = [[UILabel alloc] init];
            desLabel2.backgroundColor=[UIColor clearColor];
            desLabel2.textColor=[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
            desLabel2.frame=CGRectMake(60, 2, 200, 22);
            desLabel2.tag=2800;
//            desLabel2.text=@"至少选1个球,胆码+拖码至少选8个";
            desLabel2.text=@"我认为可能出的号，至少选2个";
            desLabel2.font=[UIFont systemFontOfSize:12];
            [backImageV23 addSubview:desLabel2];
            [desLabel2 release];
            
//            UILabel *hqlabel11 = [[UILabel alloc] initWithFrame:CGRectMake(9, 20, 20, 16)];
            UILabel *hqlabel11 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 54, 22)];
            hqlabel11.backgroundColor = [UIColor clearColor];
            hqlabel11.text = @"拖码";
            hqlabel11.textAlignment=NSTextAlignmentCenter;
            hqlabel11.textColor = [UIColor whiteColor];
            hqlabel11.font = [UIFont boldSystemFontOfSize:15];
//            hqlabel11.shadowColor = [UIColor blackColor];
//            hqlabel11.shadowOffset = CGSizeMake(0.0f, 1.0f);
            [backImageV23 addSubview:hqlabel11];
            [hqlabel11 release];
//            UILabel *hqlabel211 = [[UILabel alloc] initWithFrame:CGRectMake(9, 37, 20, 16)];
//            hqlabel211.backgroundColor = [UIColor clearColor];
//            hqlabel211.text = @"码";
//            hqlabel211.textColor = [UIColor whiteColor];
//            hqlabel211.font = [UIFont boldSystemFontOfSize:15];
//            hqlabel211.shadowColor = [UIColor blackColor];
//            hqlabel211.shadowOffset = CGSizeMake(0.0f, 1.0f);
//            [backImageV23 addSubview:hqlabel211];
//            [hqlabel211 release];
//            UILabel *hqlabel31 = [[UILabel alloc] initWithFrame:CGRectMake(8, 53, 23, 23)];
//            hqlabel31.backgroundColor = [UIColor clearColor];
//            hqlabel31.text = @"②";
//            hqlabel31.textColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
//            hqlabel31.font = [UIFont boldSystemFontOfSize:16];
//            [backImageV23 addSubview:hqlabel31];
//            [hqlabel31 release];
            
            UIView *red2View = [[UIView alloc] init];
            red2View.tag = 2011;
            red2View.backgroundColor = [UIColor clearColor];
//            red2View.frame = CGRectMake(37, 8, backImageV23.frame.size.width - 40, backImageV23.frame.size.height - 16);
            red2View.frame = CGRectMake(0, 30, 320, backImageV23.frame.size.height-30);
            for (int i = 0; i<30; i++) {
                int a= i/6,b = i%6;
                NSString *num = [NSString stringWithFormat:@"%d",i+1];
                if (i+1<10) {
                    num = [NSString stringWithFormat:@"0%d",i+1];
                }
                
//                if (SWITCH_ON) {
//                    ballRect = CGRectMake(b*42 + 6, a*51+ 5, 35, 36);
//                }else{
//                    ballRect = CGRectMake(b*42 + 6, a*37, 35, 36);
                ballRect = CGRectMake(b*51+14, a*52, 35, 35);
//                }
                GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorRed];
                [red2View addSubview:im];
                im.tag = i;
                im.isBlack = YES;
                im.gcballDelegate = self;
//                if (!SWITCH_ON) {
//                    im.ylLable.hidden = YES;
//                }
                [im release];
            }
            GifButton * redTrashButton2 = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(13, 5*52-5, 35, 35)] autorelease];
            redTrashButton2.tag = 333;
            redTrashButton2.delegate=self;
            [red2View addSubview:redTrashButton2];
            
            [backImageV23 addSubview:red2View];
            [red2View release];
            
            
            backScrollView.contentSize = CGSizeMake(320, ORIGIN_Y(backImageV23) + 10 + 44);
            endTimelable2.frame=CGRectMake(15+165, backScrollView.contentSize.height-64+10, 200, 20);
        }
    }
    
}
//玩法的九宫格
- (void)pressjiugongge:(UIButton *)sender{
    if (qilecaiType != sender.tag - 1) {
        [self performSelector:@selector(clearBalls)];
    }
    // if (buf[sender.tag] == 0) {
	UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
	image.hidden = NO;
	UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
	imagebg.image = UIImageGetImageFromName(@"gc_hover.png");
    //    buf[sender.tag] = 1;
	titleLabel.text = [NSString  stringWithFormat:@"%@", [wanArray objectAtIndex:sender.tag - 1]];
    qilecaiType = (int)sender.tag - 1;
    if (sender.tag == 1) {
        backScrollView.hidden = YES;
        backView.hidden = NO;
    }
    else {
        backScrollView.hidden = NO;
        backView.hidden = YES;
    }
	[self performSelector:@selector(pressBgButton:) withObject:sender afterDelay:.1];
	
    
}

- (void)send {
//    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
//    if ([labe.text isEqualToString:@"机选"] && [zhushuLabel.text integerValue] == 0) {
    if ([senBtn.titleLabel.text isEqualToString:@"机选"] && [zhushuLabel.text integerValue] == 0) {
        [self randBalls];
        return;
    }
    [MobClick event:@"event_goucai_xuanhaole_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
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
    if (qilecaiType == QileCaiTypePuTong) {
        int Pred = 0;
        UIView *Rview = [backView viewWithTag:1010];
        for (UIButton *bt in Rview.subviews) {
            if (bt.selected == YES) {
                Pred++;
            }
        }
        if (Pred < 7) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少选择7个号码"];
            return;
        }

    }
    if (qilecaiType == QileCaiTypeDantuo) {
        int DanMa = 0;
        int TuoMa = 0;
        UIView *qian = [backScrollView viewWithTag:2010];
        UIView *hou = [backScrollView viewWithTag:2011];
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
        if (DanMa < 1 || TuoMa < 2 || (DanMa + TuoMa) < 8) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"胆码选择1-6个,拖码+胆码>7个"];
            return;
        }
                
    }
    if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
        GouCaiShuZiInfoViewController *infoV = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
        NSString *selet = [self seletNumber];
        if (qilecaiType == QileCaiTypeDantuo) {
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
        infoViewController.lotteryType = TYPE_7LECAI;
        if (qilecaiType == QileCaiTypePuTong) {
            infoViewController.modeType = Qilecaifushi;
        }
        else {
            infoViewController.modeType = Qilecaidantuo;
        }
        infoViewController.betInfo.issue = self.myissueRecord.curIssue;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        if (!infoViewController) {
            infoViewController = [[GouCaiShuZiInfoViewController alloc] init];
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeQiLeCai;
            infoViewController.isHeMai = self.isHemai;
        }
        infoViewController.lotteryType = TYPE_7LECAI;
        if (qilecaiType == QileCaiTypePuTong) {
            infoViewController.modeType = Qilecaifushi;
        }
        else {
            infoViewController.modeType = Qilecaidantuo;
        }
        infoViewController.betInfo.issue = self.myissueRecord.curIssue;
        NSString *selet = [self performSelector:@selector(seletNumber)];
        
        if (qilecaiType == QileCaiTypeDantuo) {
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
}

- (void)clearBalls {
    
	UIView *redView = [backView viewWithTag:1010];
	for (GCBallView *ball in redView.subviews) {
		if ([ball isKindOfClass:[GCBallView class]]) {
			ball.selected = NO;
		}
	}
    for (int i = 0; i<2; i++) {
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
    NSString *number_s = @"_", *selectNumber_s = @"_,_";
    NSMutableString *_selectNumber = [NSMutableString string];
    if (qilecaiType == QileCaiTypePuTong) {
        for (int i = 0; i < 1; i++) {
            UIView *ballsCon = [backView viewWithTag:1010+i];
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
                trashButton.hidden=YES;
            }
            else {
                NSRange rang;
                rang.length = 1;
                rang.location = [num length] -1;
                [num deleteCharactersInRange:rang];
                trashButton.hidden=NO;
            }
            
            [_selectNumber appendString:num];
        }
        
        return [_selectNumber length] > 0 ? _selectNumber : nil;
    }
    else {
        for (int i = 0; i < 2; i++) {
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
                [num appendString:@"e"];
                trashButton.hidden=YES;
            }
            else {
                NSRange rang;
                rang.length = 1;
                rang.location = [num length] -1;
                [num deleteCharactersInRange:rang];
                trashButton.hidden=NO;
            }
            
            [_selectNumber appendString:num];
            if (i == 0 ) {
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
    xie.ALLWANFA = QiLeCai;
	[self.navigationController pushViewController:xie animated:YES];
//    xie.infoText.text = @"开奖时间\n每周一、三、五晚开奖。    \n\n玩法规则 \n共有号码30个.从01-30中选择7个号码为单式投注, 从01-30中选择8-16个号码为复式投注。每注2元。\n\n奖项设置\n\n一等奖:\n7个基本号码完全相同(顺序不限,下同) 奖金:当期高奖等奖金的70% \n二等奖:6个基本号码及特别号码相同 \n奖金:当期高奖等奖金的20% \n三等奖:6个基本号码相同 \n奖金:当期高奖等奖金的10% \n四等奖:5个基本号码及特别号码相同\n奖金:200元 \n五等奖:5个基本号码相同 \n奖金:50元 \n六等奖:4个基本号码及特别号码相同 \n奖金:10元 七等奖:4个基本号码相同\n奖金:5元    \n七乐彩单注奖金的最高限额为500万元。";
//	xie.infoText.scrollEnabled = NO;
//	xie.infoText.font = [UIFont systemFontOfSize:11];
	[xie release];
	
}

- (void)pressBgButton:(UIButton *)sender{
	    
    if (qilecaiType != sender.tag) {
        [self performSelector:@selector(clearBalls)];
    }
//	titleLabel.text = [NSString  stringWithFormat:@"%@-%@期", [wanArray objectAtIndex:sender.tag],self.myissueRecord.curIssue];
    titleLabel.text = [NSString  stringWithFormat:@"%@-%@期", [wanArray objectAtIndex:sender.tag],[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]];
    qilecaiType = (int)sender.tag;
    if (sender.tag == 0) {
        backScrollView.hidden = YES;
        backView.hidden = NO;
    }
    else {
        backScrollView.hidden = NO;
        backView.hidden = YES;
//        UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
//        labe.text = @"选好了";
        [senBtn setTitle:@"选好了" forState:UIControlStateNormal];
        senBtn.enabled = NO;
        senBtn.alpha = 1;
    }
    [self ballSelectChange:nil];

}

- (void)randBalls {
    if (qilecaiType == QileCaiTypePuTong) {
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:7 start:1 maxnum:30];
        UIView *redView = [backView viewWithTag:1010];
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
    NSMutableData *postData = [[GC_HttpService sharedInstance] reWangqiWithLottery:LOTTERY_ID countOfPage:20];
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

- (void)LoadIphoneView {
    backView = [[UIView alloc] initWithFrame:self.mainView.bounds];
    [self.mainView addSubview:backView];
    backView.backgroundColor = [UIColor clearColor];
    
    if (backView) {
//        UIImageView *image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 10, 190, 47)];
        UIImageView *image1BackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 37)];
        [backView addSubview:image1BackView];
//        image1BackView.image = [UIImageGetImageFromName(@"GC_sqkjback.png")stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        image1BackView.layer.masksToBounds = YES;
        image1BackView.backgroundColor = [UIColor whiteColor];
        [image1BackView release];
        
        //摇一注
        UIImageView *yaoImage = [[UIImageView alloc] init];
        yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
        yaoImage.frame =CGRectMake(285, 8, 21, 19);
        [backView addSubview:yaoImage];
        [yaoImage release];
        
//        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 23, 195, 2)];
//        imageV.image = UIImageGetImageFromName(@"SZTG960.png");
//        [image1BackView addSubview:imageV];
//        [imageV release];
        
        //上期开奖
//        UILabel *sqkaijiang = [[UILabel alloc] initWithFrame:CGRectMake(125, 19, 48, 11)];
        UILabel *sqkaijiang = [[UILabel alloc] initWithFrame:CGRectMake(14, 11, 60, 15)];
        sqkaijiang.backgroundColor = [UIColor clearColor];
        sqkaijiang.font = [UIFont boldSystemFontOfSize:13];
        sqkaijiang.text = @"上期开奖";
        sqkaijiang.textColor = [UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
        [backView addSubview:sqkaijiang];
        [sqkaijiang release];
        ColorView *sqkaijiang2 = [[ColorView alloc] initWithFrame:CGRectMake(80, 11, 165, 15)];
        sqkaijiang2.tag = 1101;
        sqkaijiang2.textAlignment = NSTextAlignmentLeft;
        sqkaijiang2.backgroundColor = [UIColor clearColor];
        sqkaijiang2.font = [UIFont boldSystemFontOfSize:13];
        sqkaijiang2.changeColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:218.0/255.0 alpha:1];
        if (self.myissueRecord) {
            sqkaijiang2.text = [NSString stringWithFormat:@"%@>",[[self.myissueRecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"+" withString:@" <"] stringByReplacingOccurrencesOfString:@"," withString:@" "]];
        }
        sqkaijiang2.textColor = [UIColor redColor];
        [backView addSubview:sqkaijiang2];
        [sqkaijiang2 release];
        
        endTimelable1 = [[ColorView alloc] initWithFrame:CGRectMake(15+165, backView.frame.size.height-64, 200, 20)];
//        [image1BackView addSubview:endTimelable1];
        [backView addSubview:endTimelable1];
        endTimelable1.backgroundColor = [UIColor clearColor];
        endTimelable1.font = [UIFont boldSystemFontOfSize:12];
//        endTimelable1.colorfont = [UIFont boldSystemFontOfSize:12];
        endTimelable1.textColor=[UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
        if (self.myissueRecord) {
//            endTimelable1.text = [NSString stringWithFormat:@"截止时间 %@",self.myissueRecord.curEndTime];
            endTimelable1.text = [NSString stringWithFormat:@"截止时间 %@",[SharedMethod changeDateToNoYearNoSecond:self.myissueRecord.curEndTime]];
        }
        [endTimelable1 release];
        
        jiangchiMoney=[[ColorView alloc]init];
        jiangchiMoney.frame=CGRectMake(160, backView.frame.size.height-64, 160, 20);
//        [backView addSubview:jiangchiMoney];
//        jiangchiMoney.backgroundColor=[UIColor cyanColor];
//        jiangchiMoney.textColor=[UIColor magentaColor];
        jiangchiMoney.textAlignment=NSTextAlignmentRight;
        
        //红球背景
//        UIImageView *backImageV2 = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"TZAHDSSQBG960.png")];
        UIImageView *backImageV2 = [[UIImageView alloc] init];
//        if (SWITCH_ON) {
//            backImageV2.frame = CGRectMake(10, 37 + 30, 300.5, 276);
//        }else{
            backImageV2.frame = CGRectMake(0, 37+18, 320, 350);
//        }
        backImageV2.userInteractionEnabled = YES;
        backImageV2.tag = 800;
        backImageV2.backgroundColor=[UIColor clearColor];
        [backView addSubview:backImageV2];
        [backImageV2 release];
        
        UIImageView *imaHong=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 54, 22)];
        imaHong.backgroundColor=[UIColor clearColor];
        imaHong.tag=10010;
        imaHong.image=[UIImage imageNamed:@"LeftTitleRed.png"];
        [backImageV2 addSubview:imaHong];
        [imaHong release];
        
        UILabel *desLabel = [[UILabel alloc] init];
        desLabel.backgroundColor=[UIColor clearColor];
        desLabel.textColor=[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1.0];
        desLabel.frame=CGRectMake(60, 2, 200, 22);
        desLabel.tag=2000;
        desLabel.text=@"至少选7个号";
        desLabel.font=[UIFont systemFontOfSize:12];
        [backImageV2 addSubview:desLabel];
        [desLabel release];
        
        UILabel *hqlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 54, 22)];
        hqlabel.backgroundColor = [UIColor clearColor];
        hqlabel.text = @"红球";
        hqlabel.textColor = [UIColor whiteColor];
        hqlabel.font = [UIFont boldSystemFontOfSize:15];
        hqlabel.textAlignment=NSTextAlignmentCenter;
//        hqlabel.shadowColor = [UIColor blackColor];
//        hqlabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        [backImageV2 addSubview:hqlabel];
        [hqlabel release];
//        UILabel *hqlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(9, 37, 20, 16)];
//        hqlabel2.backgroundColor = [UIColor clearColor];
//        hqlabel2.text = @"球";
//        hqlabel2.textColor = [UIColor whiteColor];
//        hqlabel2.font = [UIFont boldSystemFontOfSize:15];
//        hqlabel2.shadowColor = [UIColor blackColor];
//        hqlabel2.shadowOffset = CGSizeMake(0.0f, 1.0f);
//        [backImageV2 addSubview:hqlabel2];
//        [hqlabel2 release];
//        UILabel *hqlabel3 = [[UILabel alloc] initWithFrame:CGRectMake(8, 53, 23, 23)];
//        hqlabel3.backgroundColor = [UIColor clearColor];
//        hqlabel3.text = @"⑦";
//        hqlabel3.textColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
//        hqlabel3.font = [UIFont boldSystemFontOfSize:16];
//        [backImageV2 addSubview:hqlabel3];
//        [hqlabel3 release];
        
        UIView *redView = [[UIView alloc] init];
        redView.tag = 1010;
        redView.backgroundColor = [UIColor clearColor];
//        redView.frame = CGRectMake(37, 8, backImageV2.frame.size.width - 40, backImageV2.frame.size.height - 16);
        redView.frame = CGRectMake(0, 30, 320, backImageV2.frame.size.height-30);
        redView.userInteractionEnabled = YES;
        for (int i = 0; i<30; i++) {
            int a= i/6,b = i%6;
            NSString *num = [NSString stringWithFormat:@"%d",i+1];
            if (i+1<10) {
                num = [NSString stringWithFormat:@"0%d",i+1];
            }
            CGRect ballRect;
//            if (SWITCH_ON) {
//                ballRect = CGRectMake(b*42 + 6, a*51+ 5, 35, 36);
//            }else{
//                ballRect = CGRectMake(b*42 + 6, a*37, 35, 36);
            ballRect = CGRectMake(b*51+14, a*52, 35, 35);
//            }
            GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorRed];
            [redView addSubview:im];
            im.tag = i;
            im.isBlack = YES;
            im.gcballDelegate = self;
//            if (!SWITCH_ON) {
//                im.ylLable.hidden = YES;
//            }
            [im release];
        }
        GifButton * redTrashButton = [[[GifButton alloc] initTrashCanWithFrame:CGRectMake(13, 5*52-5, 35, 35)] autorelease];
        redTrashButton.tag = 333;
        redTrashButton.delegate=self;
        [redView addSubview:redTrashButton];
        
        [backImageV2 addSubview:redView];
        [redView release];
        
    }
    
    if (qilecaiType == QileCaiTypePuTong) {
        [self performSelector:@selector(createBackScrollView) withObject:nil afterDelay:0.1];
        backScrollView.hidden = YES;
        backView.hidden = NO;
    }
    else {
        [self performSelector:@selector(createBackScrollView) withObject:nil];
        backView.hidden = YES;
        backScrollView.hidden = NO;
    }
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height -44, 320, 44)];
	[self.view addSubview:im];
//    im.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    im.backgroundColor=[UIColor colorWithRed:22/255.0 green:23/255.0 blue:25/255.0 alpha:1];
	im.userInteractionEnabled = YES;
    
//    //清按钮
//    UIButton *qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//    qingbutton.frame = CGRectMake(12, 10, 30, 30);
//    [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
//    [qingbutton addTarget:self action:@selector(clearBalls) forControlEvents:UIControlEventTouchUpInside];
//    [im addSubview:qingbutton];
    
    //注数背景
//    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(52, 10, 62, 30)];
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 68, 30)];
    zhubg.image = UIImageGetImageFromName(@"SRK960.png");
    zhubg.backgroundColor=[UIColor clearColor];
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
	jin.textColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1];
	jin.backgroundColor = [UIColor clearColor];
	[zhubg addSubview:jin];
    [jin release];
    
    senBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[senBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
	senBtn.frame = CGRectMake(235, 7, 80, 33);
    senBtn.backgroundColor = [UIColor clearColor];
    
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    
    if (qilecaiType == QileCaiTypePuTong) {
        [senBtn setTitle:@"机选" forState:UIControlStateNormal];
    }else{
        [senBtn setTitle:@"选好了" forState:UIControlStateNormal];
    }
//    [senBtn setTitleColor:[UIColor colorWithRed:182/255.0 green:172/255.0 blue:133/255.0 alpha:1] forState:UIControlStateNormal];
    [senBtn setTitleColor:[UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    senBtn.titleLabel.font = [UIFont systemFontOfSize:18];
	[im addSubview:senBtn];
	
//	senBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//	[senBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
//	senBtn.frame = CGRectMake(230, 7, 80, 33);
//    [im addSubview:senBtn];
//    UIImageView *senImage = [[UIImageView alloc] initWithFrame:senBtn.bounds];
////    senImage.image = [UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:0];
//    senImage.tag = 1108;
//    [senBtn addSubview:senImage];
//    [senImage release];
//    UILabel *senLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 33)];
//    senLabel.backgroundColor = [UIColor clearColor];
//    senLabel.textAlignment = NSTextAlignmentCenter;
//    senLabel.text = @"机选";
////    senLabel.font = [UIFont systemFontOfSize:15];
////    senLabel.textColor = [UIColor colorWithRed:11.0/255.0 green:107.0/255.0 blue:172.0/255.0 alpha:1];
//    senLabel.textColor = [UIColor colorWithRed:202.0/255.0 green:194.0/255.0 blue:164.0/255.0 alpha:1];
//    senLabel.tag = 1101;
//    [senBtn addSubview:senLabel];
//    [senLabel release];
//    [im release];
    
//    if (qilecaiType == QileCaiTypeDantuo) {
//        UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
//        labe.text = @"选好了";
//        senBtn.enabled = NO;
//        [self ballSelectChange:nil];
//    }
}

- (void)LoadIpadView {
    backView = [[UIView alloc] initWithFrame:self.mainView.bounds];
    [self.mainView addSubview:backView];
    backView.frame = CGRectMake(35, 0, 320, self.mainView.bounds.size.height);
    backView.backgroundColor = [UIColor clearColor];
    [backView release];
    
    if (backView) {
        
        //摇一注
        UIImageView *yaoImage = [[UIImageView alloc] init];
        yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
        yaoImage.frame =CGRectMake(20, 10, 15, 15);
        [backView addSubview:yaoImage];
        [yaoImage release];
        
        //上期开奖
        UILabel *sqkaijiang = [[UILabel alloc] initWithFrame:CGRectMake(128, 13, 48, 11)];
        sqkaijiang.backgroundColor = [UIColor clearColor];
        sqkaijiang.font = [UIFont boldSystemFontOfSize:9];
        sqkaijiang.text = @"上期开奖";
        sqkaijiang.textColor = [UIColor blackColor];
        [backView addSubview:sqkaijiang];
        [sqkaijiang release];
        ColorView *sqkaijiang2 = [[ColorView alloc] initWithFrame:CGRectMake(168, 11, 155, 12)];
        sqkaijiang2.tag = 1101;
        sqkaijiang2.textAlignment = NSTextAlignmentLeft;
        sqkaijiang2.backgroundColor = [UIColor clearColor];
        sqkaijiang2.font = [UIFont boldSystemFontOfSize:11];
        sqkaijiang2.changeColor = [UIColor blueColor];
        if (self.myissueRecord) {
            sqkaijiang2.text = [NSString stringWithFormat:@"%@>",[[self.myissueRecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"+" withString:@" <"] stringByReplacingOccurrencesOfString:@"," withString:@" "]];
        }
        sqkaijiang2.textColor = [UIColor redColor];
        [backView addSubview:sqkaijiang2];
        [sqkaijiang2 release];
        
        //红球背景
        UIImageView *backImageV2 = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"TZAHDSSQBG960.png")];
        backImageV2.frame = CGRectMake(10, 37, 300.5, 202.5);
        backImageV2.userInteractionEnabled = YES;
        [backView addSubview:backImageV2];
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
        hqlabel3.text = @"⑦";
        hqlabel3.textColor = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
        hqlabel3.font = [UIFont boldSystemFontOfSize:16];
        [backImageV2 addSubview:hqlabel3];
        [hqlabel3 release];
        
        UIView *redView = [[UIView alloc] init];
        redView.tag = 1010;
        redView.backgroundColor = [UIColor clearColor];
        redView.frame = CGRectMake(46, 45, 265, 190);
        redView.userInteractionEnabled = YES;
        for (int i = 0; i<30; i++) {
            int a= i/7,b = i%7;
            NSString *num = [NSString stringWithFormat:@"%d",i+1];
            if (i+1<10) {
                num = [NSString stringWithFormat:@"0%d",i+1];
            }
            
            GCBallView *im = [[GCBallView alloc] initWithFrame:CGRectMake(b*37, a*37, 35, 36) Num:num ColorType:GCBallViewColorRed];
            [redView addSubview:im];
            im.tag = i;
            im.isBlack = YES;
            im.gcballDelegate = self;
            [im release];
        }
        [backView addSubview:redView];
        [redView release];
        
    }
    
    if (qilecaiType == QileCaiTypePuTong) {
        [self performSelector:@selector(createBackScrollView) withObject:nil afterDelay:0.1];
        backScrollView.hidden = YES;
        backView.hidden = NO;
    }
    else {
        [self performSelector:@selector(createBackScrollView) withObject:nil];
        backView.hidden = YES;
        backScrollView.hidden = NO;
    }
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 748 - 88, 390, 44)];
	[self.mainView addSubview:im];
	
    im.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
	im.userInteractionEnabled = YES;
    
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
    
    if (qilecaiType == QileCaiTypeDantuo) {
        UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
        labe.text = @"选好了";
        senBtn.enabled = NO;
        [self ballSelectChange:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    ShakeView *shakeView = [[ShakeView alloc] init];
	[self.mainView addSubview:shakeView];
	[shakeView becomeFirstResponder];
	[shakeView release];
	
    UIButton * historyButton = (UIButton *)[cpHistoryBGImageView viewWithTag:800];
    [historyButton addTarget:self action:@selector(toHistory) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *bgimageview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    bgimageview.image = UIImageGetImageFromName(@"login_bgn.png");
    [self.mainView addSubview:bgimageview];
    [bgimageview release];
    
    [self changeTitle];
    
//    jiangchiMoney=[[ColorView alloc]init];
    
    [self requestJiangchiMoney];//请求奖池金额
    

        UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
        self.CP_navigation.leftBarButtonItem = left;
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
        [myRequest performSelector:@selector(startAsynchronous)];
    [self getWanqi];
}

//菜单按钮
- (void)pressMenubutton:(UIButton *)sender{
    
    if(isShowing)
    {
        [self guanbidonghua];
        [alert2 disMissWithPressOtherFrame];
    }
    else
    {
        NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
        [allimage addObject:@"GC_sanjilishi.png"];
        [allimage addObject:@"GC_sanjiWanfaxuanze.png"];
//        [allimage addObject:@"menuhmdt.png"];
        //    [allimage addObject:@"yiLouSwIcon.png"];
        [allimage addObject:@"GC_sanjiShuoming.png"];
        
        NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
        [alltitle addObject:@"历史开奖"];
        [alltitle addObject:@"玩法选择"];
//        [alltitle addObject:@"合买大厅"];
        //    [alltitle addObject:@"显示遗漏"];
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
        [self performSelector:@selector(toHistory)];
    }
    else if (index == 1) {
        [MobClick event:@"event_goucai_wanfaxuanze_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
        [self performSelector:@selector(pressTitleButton:)];
    }
//    else if (index == 2) {
//        [MobClick event:@"event_goucai_hemaidating_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
//        [self otherLottoryViewController:0 title:@"七乐彩合买" lotteryType:TYPE_7LECAI lotteryId:LOTTERY_ID];
//    }
//    else if (index == 3) {
//        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"遗漏值显示" message:@"显示" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
//        alert.shouldRemoveWhenOtherAppear = YES;
//        alert.tag = 999;
//        alert.alertTpye = switchType;
//        alert.delegate = self;
//        [alert show];
//        [alert release];
//    }
    else if (index == 2) {
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

-(void)switchChange
{
    NSArray * tagArray = @[@[@"1010"],@[@"2010",@"2011"]];
    
//    UIView * lastView = nil;
    UIView *  lastView1 = nil;
    for (int i = 0; i < tagArray.count; i++) {
        int heght = 67;
        for (int j = 0; j < [[tagArray objectAtIndex:i] count]; j++) {
            UIView *v;
            if (i == 0) {
                v = [backView viewWithTag:j + 800];
//                lastView = v;
            }else{
                v = [backScrollView viewWithTag:j + 800];
                lastView1 = v;
            }
            GifButton * trashButton = (GifButton *)[v viewWithTag:333];
            int count = 30;
            if (SWITCH_ON) {
                v.frame = CGRectMake(10, heght, 300.5, 276);
            }else{
                v.frame = CGRectMake(10, heght, 300.5, 202.5);
            }
            for (int k = 0; k < count; k++) {
                int a= k/6,b = k%6;
                GCBallView * ballView = (GCBallView *)[[v viewWithTag:[[[tagArray objectAtIndex:i] objectAtIndex:j] integerValue]] viewWithTag:k];
                if (SWITCH_ON) {
                    ballView.frame = CGRectMake(b*42 + 6, a*51+ 5, 35, 36);
                    ballView.ylLable.hidden = NO;
                }else{
                    ballView.frame = CGRectMake(b*42 + 6, a*37, 35, 36);
                    ballView.ylLable.hidden = YES;
                }
            }
            trashButton.frame = CGRectMake(13, 5*52-5, 35, 35);
            heght += v.bounds.size.height + 3.5;
        }
    }
    
    backScrollView.contentSize = CGSizeMake(320, ORIGIN_Y(lastView1) + 10 + 44);
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
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"机选红球",@"title",[NSArray arrayWithObjects:@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",nil],@"choose", nil];
    [randArray addObject:dic1];
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

    [choose release];
    
}

//历史开奖
- (void)toHistory
{
    [MobClick event:@"event_goucai_chakangengduo_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];

    [MobClick event:@"event_goucai_lishikaijiang_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
    LotteryListViewController *controller = [[LotteryListViewController alloc] init];
    controller.lotteryId = LOTTERY_ID;
    controller.lotteryName = @"七乐彩";
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
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
            jiangchiMoney.text = [NSString stringWithFormat:@"奖池金额 <%@>",info.JiangChi];
            NSLog(@"%@",jiangchiMoney.text);
        }
        else {
            jiangchiMoney.text = @"统计中...";
        }
        NSLog(@"%@",jiangchiMoney.text);
        self.jiangchi = info;
        [info release];
        
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)dealloc {
    
    [myHttpRequest clearDelegatesAndCancel];
    self.myHttpRequest = nil;
    [infoViewController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [myRequest clearDelegatesAndCancel];
    [myRequest release];
    [wanArray  release];
    [myissueRecord release];
    [self.qihaoReQuest clearDelegatesAndCancel];
    self.qihaoReQuest = nil;
    self.wangQi = nil;
    [backView release];
    [super dealloc];
}

#pragma mark - GCBallViewDelegate

- (void)ballSelectChange:(UIButton *)imageView {
    ModeTYPE type = Qilecaifushi;
    if (qilecaiType == QileCaiTypeDantuo) {
        type = Qilecaidantuo;
        UIView *v = nil;
        if (imageView.superview.tag == 2010) {
            v = [backScrollView viewWithTag:2011];
        }
        else {
            v= [backScrollView viewWithTag:2010];
        }
        int totle = 0;
        UIView *v1 = [backScrollView viewWithTag:2010];
        UIView *v2 = [backScrollView viewWithTag:2011];
        for (UIButton *btn in v1.subviews) {
            if (btn.selected == YES) {
                totle ++;
            }
        }
        if (totle>6) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"胆码所选号码不能超过6个"];
            imageView.selected = NO;
            return;
        }
        
        for (UIButton *btn in v2.subviews) {
            if (btn.selected == YES) {
                totle ++;
            }
        }
        if (totle>20) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"胆码和拖码之和不能超过20个"];
            imageView.selected = NO;
            return;
        }
        
        UIButton *btn = (UIButton *)[v viewWithTag:imageView.tag];
        if (btn.selected == YES) {
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"胆码和拖码不能相同"];
            imageView.selected = NO;
            return;
        }
        
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
        GCBallView *btn2 = (GCBallView *)[v1 viewWithTag:imageView.tag];
        GCBallView *btn3 = (GCBallView *)[v2 viewWithTag:imageView.tag];
        if (!btn2.selected && btn3.selected) {
            [btn2 changetolight];
        }
        else {
            [btn2 chanetoNomore];
        }
    }
    NSUInteger bets = [GC_LotteryUtil getBets:[self seletNumber] LotteryType:TYPE_7LECAI ModeType:type];
    
	zhushuLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)bets];
	jineLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)2*bets];
//    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
//    UIImageView *ima = (UIImageView *)[senBtn viewWithTag:1108];
    NSString *str = [[[[self seletNumber] stringByReplacingOccurrencesOfString:@"e" withString:@""] stringByReplacingOccurrencesOfString:@"_" withString:@""] stringByReplacingOccurrencesOfString:@"," withString:@""];
    if (bets > 1 || (qilecaiType == QileCaiTypeDantuo && [str length])) {
		senBtn.enabled = YES;
	}
	else {
		senBtn.enabled = NO;
	}
    
    if (qilecaiType == QileCaiTypePuTong) {
        if ([str length] == 0) {
//            ima.alpha = 1;
//            labe.text = @"机选";
//            labe.textColor = [UIColor colorWithRed:11.0/255.0 green:107.0/255.0 blue:172.0/255.0 alpha:1];
            senBtn.enabled = YES;
            senBtn.alpha=1;
            [senBtn setTitle:@"机选" forState:UIControlStateNormal];
        }
        else {
//            ima.alpha = 1;
//            labe.text = @"选好了";
//            labe.textColor = [UIColor blackColor];
            senBtn.enabled = YES;
            senBtn.alpha=1;
            [senBtn setTitle:@"选好了" forState:UIControlStateNormal];
        }
    }
    if (qilecaiType == QileCaiTypeDantuo) {
        
        if (!([str length] == 0)) {
            
//            ima.alpha = 1;
//            labe.textColor = [UIColor blackColor];
            senBtn.alpha = 1;
            
        }else if ([str length] == 0) {
            
//            ima.alpha = 0.5;
//            labe.textColor = [UIColor colorWithRed:97.0/255.0 green:97.0/255.0 blue:97.0/255.0 alpha:1];
            senBtn.alpha = 0.27;
            
        }
    }


	
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
            if ([aaa count] >= 2) {
                [dataArray addObject:[aaa objectAtIndex:0]];
                [dataArray addObject:[NSString stringWithFormat:@"+%@",[aaa objectAtIndex:1]]];
                
                
                [historyArr addObject:dataArray];
            }
            
            
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
//        titleLabel.text = [NSString stringWithFormat:@"%@-%@期",[wanArray objectAtIndex:qilecaiType],self.myissueRecord.curIssue];
        titleLabel.text = [NSString stringWithFormat:@"%@-%@期",[wanArray objectAtIndex:qilecaiType],[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]];
        [self changeTitle];
        ColorView *sqkaijiang1 = (ColorView *)[backScrollView viewWithTag:1101];
        ColorView *sqkaijiang2 = (ColorView *)[backView viewWithTag:1101];
        NSLog(@"%@",self.myissueRecord.lastLotteryNumber);
        NSArray *array = [self.myissueRecord.lastLotteryNumber componentsSeparatedByString:@"#"];
        sqkaijiang2.text = [NSString stringWithFormat:@"%@>",[[self.myissueRecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"+" withString:@" <"] stringByReplacingOccurrencesOfString:@"," withString:@" "]];
        if ([array count] > 1) {
            sqkaijiang1.text = [NSString stringWithFormat:@"%@>",[[[array objectAtIndex:1] stringByReplacingOccurrencesOfString:@"+" withString:@" <"] stringByReplacingOccurrencesOfString:@"," withString:@" "]];
            sqkaijiang2.text = [NSString stringWithFormat:@"%@>",[[[array objectAtIndex:1] stringByReplacingOccurrencesOfString:@"+" withString:@" <"] stringByReplacingOccurrencesOfString:@"," withString:@" "]];
        }
        if (self.myissueRecord) {
//            endTimelable1.text = [NSString stringWithFormat:@"截止时间 %@",self.myissueRecord.curEndTime];
            endTimelable1.text = [NSString stringWithFormat:@"截止时间 %@",[SharedMethod changeDateToNoYearNoSecond:self.myissueRecord.curEndTime]];
//            endTimelable2.text = [NSString stringWithFormat:@"截止时间 %@",self.myissueRecord.curEndTime];
            endTimelable2.text = [NSString stringWithFormat:@"截止时间 %@",[SharedMethod changeDateToNoYearNoSecond:self.myissueRecord.curEndTime]];
        }
        if ([array count] >= 1) {
            float a = [self.myissueRecord.curIssue floatValue] - [[array objectAtIndex:0] floatValue];
            if (a > 1 && a < 100) {
                if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"qilejieqi"] isEqualToString:self.myissueRecord.curIssue]) {
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"为了保证您购彩成功，网络购彩会比官方截期时间早，今日开奖期次销售已截止，您将购买%@期，祝您中奖！",[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                    [[NSUserDefaults standardUserDefaults] setValue:self.myissueRecord.curIssue forKey:@"qilejieqi"];
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
    UIView *v1 = nil;
    if(gifButton.superview.tag == 2010)
    {
        v1 = [backScrollView viewWithTag:2011];
    }
    else if(gifButton.superview.tag == 2011)
    {
        v1 = [backScrollView viewWithTag:2010];
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
        CGAffineTransform transForm = CGAffineTransformMakeRotation(M_PI * 1);
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