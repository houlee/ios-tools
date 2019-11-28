//
//  Pai3ViewController.m
//  caibo
//
//  Created by zhang on 11/7/12.
//
//

#import "Pai3ViewController.h"
#import "ShakeView.h"
#import "Info.h"
#import "LoginViewController.h"
#import "GC_LotteryUtil.h"
#import "caiboAppDelegate.h"
#import "Xieyi365ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
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

#define LOTTERY_ID @"108"

@interface Pai3ViewController ()

@end

@implementation Pai3ViewController
@synthesize myissueRecord;
@synthesize isHeMai;
@synthesize lotteryType;
@synthesize myRequest;
@synthesize modetype;
@synthesize wangQi;
@synthesize qihaoReQuest;
@synthesize allYiLouRequest;
@synthesize yiLouDataArray;
@synthesize yilouDic;
@synthesize yilouRequest;

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

- (id)initWithModetype:(ModeTYPE *)type
{
    self = [super init];
    if (self) {
        lotteryType = TYPE_PAILIE3;
        modetype = type;
        isVerticalBackScrollView = YES;
        //        isBackScrollView = YES;
        self.headHight = DEFAULT_ISSUE_HEIGHT + NEW_PAGECONTROL_HEIGHT + 1;
    }
    return self;
}

- (id)init {

    self = [super init];
    if (self) {
    	[self initWithModetype:Array3zhixuanfushi];
    }
    return self;

}

- (void)LoadIphoneView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 270, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.userInteractionEnabled = YES;
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.tag = 789;
//    if (modetype == Array3zhixuanfushi) {
//        titleLabel.text = @"直选";
//    }
//    else if (modetype == Array3zuliufushi) {
//        titleLabel.text = @"组六复式";
//    }
//    else if (modetype == Array3zusanfushi){
//        titleLabel.text = @"组三复式";
//    }
//    
//    else if (modetype == Array3zuxuandanshi){
//        
//        titleLabel.text = @"组选单式";
//    }
//    if (self.myissueRecord) {
//        titleLabel.text = [NSString stringWithFormat:@"%@-%@期",titleLabel.text,self.myissueRecord.curIssue];
//    }
    titleLabel.textColor = [UIColor whiteColor];
    
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
    sanjiaoImageView.tag = 567;
    [titleView addSubview:sanjiaoImageView];
    
    if ([[[Info getInstance] userId] intValue] == 0) {
        titleLabel.frame = CGRectMake(45, 0, 220, 44);
        sanjiaoImageView.frame = CGRectMake(153, 14.5, 17, 17);
    }else {
        
        titleLabel.frame = CGRectMake(60, 0, 220, 44);
        sanjiaoImageView.frame = CGRectMake(167, 14.5, 17, 17);
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
    
    normalScrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
    [self.mainView addSubview:normalScrollView];
    
    UIView * topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, TOPVIEW_HEIGHT)] autorelease];
    topView.backgroundColor = [UIColor whiteColor];
    [normalScrollView addSubview:topView];
    
    UIView * topShadowView = [[[UIView alloc] initWithFrame:CGRectMake(0, topView.frame.size.height, 320, 0.5)] autorelease];
    topShadowView.backgroundColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
    [topView addSubview:topShadowView];

    sqkaijiang = [[ColorView alloc] initWithFrame:CGRectMake(14, 9.5, 165 - 14, 17)];
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.font = [UIFont systemFontOfSize:14];
    if (self.myissueRecord) {
        sqkaijiang.text = [[NSString stringWithFormat:@"上期开奖  <%@>",self.myissueRecord.lastLotteryNumber] stringByReplacingOccurrencesOfString:@"," withString:@"  "];
    }
    sqkaijiang.textColor = [UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
    sqkaijiang.colorfont = [UIFont systemFontOfSize:14];
    sqkaijiang.changeColor = [UIColor colorWithRed:255/255.0 green:36/255.0 blue:36/255.0 alpha:1];
    [normalScrollView addSubview:sqkaijiang];
	[sqkaijiang release];
    
    
    sqkaijiangY = ORIGIN_Y(topView) + 16;
    sqkaijiangView = [[UIView alloc] initWithFrame:CGRectMake(0, sqkaijiangY, 300, 19)];
    [normalScrollView addSubview:sqkaijiangView];
    sqkaijiangView.backgroundColor = [UIColor clearColor];
    
    //摇一注
    yaoImage = [[UIImageView alloc] init];
    yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
    yaoImage.frame = CGRectMake(20, 0, 21, 19);
    [sqkaijiangView addSubview:yaoImage];
    
    //单注奖金提示
    colorLabel = [[ColorView alloc] initWithFrame:CGRectMake(ORIGIN_X(yaoImage) + 2, 1, sqkaijiangView.frame.size.width - (ORIGIN_X(yaoImage) + 1), sqkaijiangView.frame.size.height - 1)];
    colorLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
	colorLabel.font = [UIFont systemFontOfSize:14];
	colorLabel.colorfont = [UIFont systemFontOfSize:14];
	colorLabel.backgroundColor = [UIColor clearColor];
	colorLabel.changeColor = [UIColor colorWithRed:255/255.0 green:36/255.0 blue:36/255.0 alpha:1];
	[sqkaijiangView addSubview:colorLabel];
    
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

                //            CGRectMake(b*42+65, a*37+7, 35, 36)
                GCBallView *im = [[GCBallView alloc] initWithFrame:ballRect Num:num ColorType:GCBallViewColorRed];
                [firstView addSubview:im];
                im.tag = j;
                im.isBlack = YES;
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
        }else{
            UIImageView *firstView = [[UIImageView alloc] init];
            firstView.tag = 1010 + i;
            firstView.backgroundColor = [UIColor clearColor];
            
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
    [im addSubview:senBtn];
    senBtn.backgroundColor = [UIColor clearColor];
    [senBtn setTitle:@"机选" forState:UIControlStateNormal];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    
    [senBtn setTitleColor:[UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [senBtn setTitleColor:[UIColor colorWithRed:63/255.0 green:59/255.0 blue:47/255.0 alpha:1] forState:UIControlStateDisabled];

    senBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [im release];
    
}

- (void)LoadIpadView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(50 + 35, 0, 270, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.userInteractionEnabled = YES;
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
//    if (modetype == Array3zhixuanfushi) {
//        titleLabel.text = @"直选";
//    }
//    else if (modetype == Array3zuliufushi) {
//        titleLabel.text = @"组六复式";
//    }
//    else if (modetype == Array3zusanfushi){
//        titleLabel.text = @"组三复式";
//    }
//    
//    else if (modetype == Array3zuxuandanshi){
//        
//        titleLabel.text = @"组选单式";
//    }
//    if (self.myissueRecord) {
//        titleLabel.text = [NSString stringWithFormat:@"%@-%@期",titleLabel.text,self.myissueRecord.curIssue];
//    }
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.shadowColor = [UIColor blackColor];
    titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    
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
        titleLabel.frame = CGRectMake(45, 0, 220, 44);
        JTLabel.frame = CGRectMake(148, 1, 20, 44);
    }else {
        
        titleLabel.frame = CGRectMake(60, 0, 220, 44);
        JTLabel.frame = CGRectMake(162, 1, 20, 44);
    }
    [titleView addSubview:JTLabel];
    [JTLabel release];
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(0, 0, 270, 44);
    titleButton.backgroundColor = [UIColor clearColor];
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:titleLabel];
    [titleView addSubview:titleButton];
    self.CP_navigation.titleView = titleView;
    [titleLabel release];
    [titleView release];
    
    //摇一注
    yaoImage = [[UIImageView alloc] init];
    yaoImage.image = UIImageGetImageFromName(@"YIY960.png");
    yaoImage.frame =CGRectMake(15 + 35, 12, 15, 15);
    [self.mainView addSubview:yaoImage];
    
    //单注奖金提示
    colorLabel = [[ColorView alloc] init];
	colorLabel.frame = CGRectMake(27 + 35, 12, 100, 15);
	colorLabel.textColor = [UIColor blackColor];
	colorLabel.font = [UIFont systemFontOfSize:11];
	colorLabel.colorfont = [UIFont boldSystemFontOfSize:11];
	colorLabel.backgroundColor = [UIColor clearColor];
	colorLabel.changeColor = [UIColor redColor];
	[self.mainView addSubview:colorLabel];
	colorLabel.text = @"单注奖金<1000>元";
    colorLabel.wordWith = 10;
	[colorLabel release];
    
    //上期开奖
    UILabel *sqkjLabel = [[UILabel alloc] initWithFrame:CGRectMake(190 + 35, 15, 50, 11)];
    sqkjLabel.backgroundColor = [UIColor clearColor];
    sqkjLabel.text = @"上期开奖：";
    sqkjLabel.textColor = [UIColor blackColor];
    sqkjLabel.font = [UIFont boldSystemFontOfSize:9];
    [self.mainView addSubview:sqkjLabel];
    [sqkjLabel release];
    
    sqkaijiang = [[ColorView alloc] initWithFrame:CGRectMake(240 + 35, 14, 135, 12)];
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.font = [UIFont boldSystemFontOfSize:11];
    if (self.myissueRecord) {
        sqkaijiang.text = [[NSString stringWithFormat:@"上期开奖  <%@>",self.myissueRecord.lastLotteryNumber] stringByReplacingOccurrencesOfString:@"," withString:@"  "];
    }
    sqkaijiang.textColor = [UIColor redColor];
    [self.mainView addSubview:sqkaijiang];
	[sqkaijiang release];
    
    
	NSArray *array = [NSArray arrayWithObjects:@"百",@"十",@"个",nil];
    NSArray *array2 = [NSArray arrayWithObjects:@"①",@"①",@"①",nil];
	for (int i = 0; i<3; i++) {
		UIImageView *firstView = [[UIImageView alloc] init];
		firstView.tag = 1010 +i;
        firstView.backgroundColor = [UIColor clearColor];
		firstView.frame = CGRectMake(10 + 35, 37 + i*96, 300.5, 91.5);
        firstView.image = UIImageGetImageFromName(@"TZAHBG960.png");
		firstView.userInteractionEnabled = YES;
        UILabel *label = [[UILabel alloc] init];
		label.backgroundColor = [UIColor clearColor];
        label.text = [array objectAtIndex:i];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:15];
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
			im.tag = j;
            im.isBlack = YES;
			im.gcballDelegate = self;
			[im release];
		}
		[self.mainView addSubview:firstView];
		[firstView release];
	}
    
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

-(void)viewDidAppear:(BOOL)animated
{
    [self contentSizeChange];
    [super viewDidAppear:animated];
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
                @{@"title": @"普通投注", @"choose": @[@"直选", @"组三", @"组六复式", @"组选单式"]},
                @{@"title": @"和值投注", @"choose": @[@"直选", @"组三", @"组六"]}, nil];
//                @{@"title": @"胆拖投注", @"choose": @[@"组三", @"组六"]}, nil];
    
    NSMutableArray * conArray = [NSMutableArray arrayWithObjects:@"1",@"0",@"0",@"0", nil];
    NSMutableArray * conArray1 = [NSMutableArray arrayWithObjects:@"0",@"0",@"0", nil];
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
//    [self titleCHange];

    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
    if (modetype == Array3zhixuanfushi) {
        sender.tag = 100;
    }
    else if (modetype == Array3zusanfushi) {
        sender.tag = 101;
    }
    else if (modetype == Array3zuliufushi) {
        sender.tag = 102;
    }
    else if (modetype == Array3zuxuandanshi) {
        sender.tag = 103;
    }
    else if (modetype == Array3zhixuanHezhi) {
        sender.tag = 200;
    }
    else if (modetype == Array3zusanHezhi) {
        sender.tag = 201;
    }
    else if (modetype == Array3zuliuHezhi) {
        sender.tag = 202;
    }
    [self pressBgButton:sender];
    
    [self getWanqi];
}


#pragma mark - Action

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
    [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
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
            
            alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"玩法选择" ShuziNameWithTitleArray:wanArray shuziArray:nil];
            alert2.duoXuanBool = NO;
            alert2.tag = 101;
            alert2.delegate = self;
            alert2.isHaveTitle = YES;
            isShowing = YES;
            alert2.isClearBtnCanPress = NO;
            [self.view addSubview:self.CP_navigation];
            [alert2 show];
            self.CP_navigation.frame = CGRectMake(0, 20, 320, 44);
            [self.CP_navigation.window addSubview:alert2];
            [self.CP_navigation.window addSubview:self.CP_navigation];
            
            for (CP_XZButton *btn in alert2.backScrollView.subviews) {
                
                if(modetype == Array3zhixuanfushi)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 100) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == Array3zusanfushi)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 101) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == Array3zuliufushi)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 102) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == Array3zuxuandanshi)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 103) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == Array3zhixuanHezhi)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 200) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == Array3zusanHezhi)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 201) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == Array3zuliuHezhi)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 202) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == Array3zusandantuo)
                {
                    if ([btn isKindOfClass:[UIButton class]] && btn.tag == 300) {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor whiteColor];
                    }
                }
                if(modetype == Array3zuliudantuo)
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

- (void)pressBgButton:(UIButton *)sender{
    
#ifdef isCaiPiaoForIPad
      NSInteger pianyi = 0;
    pianyi = 35;
#else
#endif
    
    UIView * firstView = [normalScrollView viewWithTag:1010];
    UIView * secondView = [normalScrollView viewWithTag:1011];
    UIView * ThirdView = [normalScrollView viewWithTag:1012];
    
    UIView * zhiXuanHeZhiView = [normalScrollView viewWithTag:1013];
    UIView * zuSanHeZhiView = [normalScrollView viewWithTag:1014];
    UIView * zuLiuHeZhiView = [normalScrollView viewWithTag:1015];
    
    UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
    UILabel *jt = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
    
    UILabel * firstTitleLabel = (UILabel *)[firstView viewWithTag:107];
    UILabel * firstDescLabel = (UILabel *)[firstView viewWithTag:108];
    
    UILabel * secondTitleLabel = (UILabel *)[secondView viewWithTag:107];
    UILabel * secondDescLabel = (UILabel *)[secondView viewWithTag:108];

    if (self.myissueRecord.curIssue) {
        if (sender.tag >= 200) {
            titleLabel.text = [NSString  stringWithFormat:@"%@%@%@期",[[[wanArray objectAtIndex:sender.tag/100 - 1] valueForKey:@"choose"] objectAtIndex:sender.tag%100],[[[wanArray objectAtIndex:sender.tag/100 - 1] valueForKey:@"title"] substringToIndex:2], [SharedMethod getLastThreeStr:self.myissueRecord.curIssue]];
        }else{
            titleLabel.text = [NSString  stringWithFormat:@"%@%@期",[[[wanArray objectAtIndex:sender.tag/100 - 1] valueForKey:@"choose"] objectAtIndex:sender.tag%100],[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]];
        }
    }
    else {
        if (sender.tag >= 200) {
            titleLabel.text = [NSString  stringWithFormat:@"%@%@", [[[wanArray objectAtIndex:sender.tag/100 - 1] valueForKey:@"choose"] objectAtIndex:sender.tag%100],[[[wanArray objectAtIndex:sender.tag/100 - 1] valueForKey:@"title"] substringToIndex:2]];
        }else{
            titleLabel.text = [NSString  stringWithFormat:@"%@", [[[wanArray objectAtIndex:sender.tag/100 - 1] valueForKey:@"choose"] objectAtIndex:sender.tag%100]];
        }
    }
    
    CGSize labelSize = [tl.text sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(200, 20) lineBreakMode:UILineBreakModeCharacterWrap];
    tl.frame = CGRectMake((320 - labelSize.width - 17 - 1)/2 - self.CP_navigation.titleView.frame.origin.x, 0, labelSize.width, 44);
    jt.frame = CGRectMake(ORIGIN_X(tl) + 1, 14, 17, 17);
    
    if (sender.tag == 100) {
        if (modetype != Array3zhixuanfushi) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = Array3zhixuanfushi;
        
        colorLabel.text = @"按位猜中3个开奖号即奖<1040>元";

        firstTitleLabel.text = [redTitleArray objectAtIndex:0];
        firstDescLabel.text = [redDescArray objectAtIndex:0];
        
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
        
        [self displayZhiXuanYiLou];
    }
    
    if (sender.tag == 101) {
        if (modetype != Array3zusanfushi) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = Array3zusanfushi;
        colorLabel.text = @"猜中3个开奖号(顺序不限)即奖<346>元";
        
        firstTitleLabel.text =@"组三";
        firstDescLabel.text = @"至少选2个号";
        
        firstView.hidden = NO;
        secondView.hidden = YES;
        ThirdView.hidden = YES;
        zhiXuanHeZhiView.hidden = YES;
        zuSanHeZhiView.hidden = YES;
        zuLiuHeZhiView.hidden = YES;
        
        yaoImage.hidden = NO;
        sqkaijiangView.frame = CGRectMake(0, sqkaijiangY, 300, 19);
        
        [self displayZuDanYiLou];
    }
    
    if (sender.tag == 102) {
        if (modetype != Array3zuliufushi) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = Array3zuliufushi;
        colorLabel.text = @"猜中3个开奖号(顺序不限)即奖<173>元";
        
        firstTitleLabel.text =@"组六";
        firstDescLabel.text = @"至少选4个号";
        
        firstView.hidden = NO;
        secondView.hidden = YES;
        ThirdView.hidden = YES;
        zhiXuanHeZhiView.hidden = YES;
        zuSanHeZhiView.hidden = YES;
        zuLiuHeZhiView.hidden = YES;
        
        yaoImage.hidden = NO;
        sqkaijiangView.frame = CGRectMake(0, sqkaijiangY, 300, 19);
        
        [self displayZuDanYiLou];

    }
    if (sender.tag == 103) {
        if (modetype != Array3zuxuandanshi) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = Array3zuxuandanshi;
        colorLabel.text = @"猜中3个开奖号(顺序不限)即奖<173/346>元";
        
        firstTitleLabel.text = [redTitleArray objectAtIndex:0];
        firstDescLabel.text = [redDescArray objectAtIndex:0];
        
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
        
        [self displayZhiXuanYiLou];
    }
    else if (sender.tag == 200) {
        if (modetype != Array3zhixuanHezhi) {
            [self performSelector:@selector(clearBalls)];
        }
        colorLabel.text = @"猜中开奖号相加之和即奖<1040>元";
        
        modetype = Array3zhixuanHezhi;
        
        firstView.hidden = YES;
        secondView.hidden = YES;
        ThirdView.hidden = YES;
        zhiXuanHeZhiView.hidden = NO;
        zuSanHeZhiView.hidden = YES;
        zuLiuHeZhiView.hidden = YES;
        
        yaoImage.hidden = YES;
        sqkaijiangView.frame = CGRectMake(-25, sqkaijiangY, 300, 19);
        
        [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1013] dictionary:self.yilouDic typeStr:@"hzhyl"];

    }
    else if (sender.tag == 201) {
        if (modetype != Array3zusanHezhi) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = Array3zusanHezhi;
        
        colorLabel.text = @"猜中开奖号相加之和即奖<346>元";

        firstTitleLabel.text =@"和值";
        firstDescLabel.text = @"至少选1个号";
        
        firstView.hidden = YES;
        secondView.hidden = YES;
        ThirdView.hidden = YES;
        zhiXuanHeZhiView.hidden = YES;
        zuSanHeZhiView.hidden = NO;
        zuLiuHeZhiView.hidden = YES;
        
        yaoImage.hidden = YES;
        sqkaijiangView.frame = CGRectMake(-25, sqkaijiangY, 300, 19);
        
        [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1014] dictionary:self.yilouDic typeStr:@"hzhyl"firstAtIndex:1 segmentation:27 arrayTag:0];

    }
    else if (sender.tag == 202) {
        if (modetype != Array3zuliuHezhi) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = Array3zuliuHezhi;
        
        colorLabel.text = @"猜中开奖号相加之和即奖<173>元";

        firstTitleLabel.text =@"和值";
        firstDescLabel.text = @"至少选1个号";
        
        firstView.hidden = YES;
        secondView.hidden = YES;
        ThirdView.hidden = YES;
        zhiXuanHeZhiView.hidden = YES;
        zuSanHeZhiView.hidden = YES;
        zuLiuHeZhiView.hidden = NO;
        
        yaoImage.hidden = YES;
        sqkaijiangView.frame = CGRectMake(-25, sqkaijiangY, 300, 19);
        
        [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1015] dictionary:self.yilouDic typeStr:@"hzhyl"firstAtIndex:3 segmentation:25 arrayTag:0];

    }
    else if (sender.tag == 300) {
        if (modetype != Array3zusandantuo) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = Array3zusandantuo;
        
        colorLabel.text = @"单注奖金<320>元";

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
        
        [self displayZuDanYiLou];
    }
    else if (sender.tag == 301) {
        if (modetype != Array3zuliudantuo) {
            [self performSelector:@selector(clearBalls)];
        }
        modetype = Array3zuliudantuo;
        
        colorLabel.text = @"单注奖金<160>元";
        
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
        
        [self displayZuDanYiLou];
    }
    
	UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
	image.hidden = NO;
	UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
	imagebg.image = UIImageGetImageFromName(@"gc_hover.png");
    //    buf[sender.tag] = 1;
	
    [self ballSelectChange:nil];
//    [self titleCHange];
    
    [self contentSizeChange];
}

- (void)randBalls {
    if (modetype == Array3zhixuanfushi) {
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
    else if (modetype == Array3zusanfushi) {
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
    else if (modetype == Array3zuliufushi) {
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:4 start:0 maxnum:9];
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
    else if (modetype == Array3zuxuandanshi) {
        NSMutableArray *redBalls = [GC_LotteryUtil getRandBalls:3 start:0 maxnum:9];
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
        UIView *redView3 = [self.mainView viewWithTag:1012];
        for (GCBallView *ball in redView3.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if ([[redBalls objectAtIndex:2] isEqualToString:ball.numLabel.text]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
        [self ballSelectChange:nil];
    }

    [self ballSelectChange:nil];
}

//选好了
- (void)send {
    
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
    if (modetype == Array3zhixuanfushi) {
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
    else if (modetype == Array3zusanfushi) {
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
    else if (modetype == Array3zuliufushi) {
        int b = 0;
        UIView *Rview = [self.mainView viewWithTag:1010];
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
    else if (modetype == Array3zuxuandanshi) {
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
    else if (modetype == Array3zusandantuo || modetype == Array3zuliudantuo) {
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
        
        if (modetype == Array3zhixuanHezhi || modetype == Array3zusanHezhi || modetype == Array3zuliuHezhi) {
            selet = [NSString stringWithFormat:@"04#%@",selet];
        }
        else if (modetype == Array3zusandantuo || modetype == Array3zuliudantuo) {
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
        infoV.lotteryType = lotteryType;
        infoV.modeType = modetype;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        if (!infoViewController) {
            infoViewController = [[GouCaiShuZiInfoViewController alloc] init];
            //infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeFuCai3D;
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypePaiLie3;
            infoViewController.isHeMai = self.isHeMai;
        }
        infoViewController.lotteryType = lotteryType;
        infoViewController.modeType = modetype;
        infoViewController.betInfo.issue = self.myissueRecord.curIssue;
        NSString *selet = [self seletNumber];
        
        if (modetype == Array3zhixuanHezhi || modetype == Array3zusanHezhi || modetype == Array3zuliuHezhi) {
            selet = [NSString stringWithFormat:@"04#%@",selet];
        }
        else if (modetype == Array3zusandantuo || modetype == Array3zuliudantuo) {
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

- (void)clearBalls {
	for (int i = 0; i < 6; i++) {
		UIView *ballView = [self.mainView viewWithTag:1010+i];
		for (GCBallView *ball in ballView.subviews) {
			if ([ball isKindOfClass:[GCBallView class]]) {
				ball.selected = NO;
			}
		}
	}
	//zhushuLabel.text = [NSString stringWithFormat:@"%d",0];
	//jineLabel.text = [NSString stringWithFormat:@"%d",2*0];
    [self ballSelectChange:nil];
	//senBtn.enabled = NO;
}


- (NSString *)seletNumber {
    NSString *number_s = @"", *selectNumber_s = @"*";
    
    NSMutableString *_selectNumber = [NSMutableString string];
    int b = 3;
    if (modetype == Array3zusanfushi || modetype == Array3zuliufushi) {
        b = 1;
        number_s = @"*";
        for (int i = 0; i < b; i++) {
            UIView *ballsCon = [self.mainView viewWithTag:1010+i];
            GifButton * trashButton = (GifButton *)[ballsCon viewWithTag:333];

            NSMutableString *num = [NSMutableString string];
            for (GCBallView *ballV in ballsCon.subviews) {
                if ([ballV isKindOfClass:[GCBallView class]] && ballV.selected) {
                    if ((modetype == Array3zhixuanHezhi || modetype == Array3zusanHezhi || modetype == Array3zuliuHezhi) && [num length]) {
                        [num appendString:@"%"];
                        [num appendFormat:@"04#%@",ballV.numLabel.text];
                    }
                    else if ((modetype == Array3zusandantuo || modetype == Array3zuliudantuo) && [num length]) {
                        [num appendString:@"%"];
                        [num appendFormat:@"03#%@",ballV.numLabel.text];
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
                [num setString:[num substringToIndex:[num length] -1]];
                
                trashButton.hidden = NO;
            }
            
            [_selectNumber appendString:num];
            if ((i == 0 || i == 1)&&b!= 1) {
                [_selectNumber appendString:selectNumber_s];
            }
        }
    }
    else {
        int a = 0;
        if (modetype == Array3zhixuanHezhi) {
            b = 4;
            a = 3;
        }
        else if (modetype == Array3zusanHezhi) {
            a = 4,b = 5;
        }
        else if (modetype == Array3zuliuHezhi) {
            a = 5,b = 6;
        }
        else if (modetype == Array3zusandantuo || modetype == Array3zuliudantuo) {
            b = 2;
        }
        for (int i = a; i < b; i++) {
            UIView *ballsCon = [self.mainView viewWithTag:1010+i];
            GifButton * trashButton = (GifButton *)[ballsCon viewWithTag:333];

            NSMutableString *num = [NSMutableString string];
            for (GCBallView *ballV in ballsCon.subviews) {
                if ([ballV isKindOfClass:[GCBallView class]] && ballV.selected) {
                    if ((modetype == Array3zhixuanHezhi || modetype == Array3zusanHezhi || modetype == Array3zuliuHezhi) && [num length]) {
                        [num appendString:@"%"];
                        [num appendFormat:@"04#%@",ballV.numLabel.text];
                    }
                    else if ((modetype == Array3zusandantuo || modetype == Array3zuliudantuo) && [num length]) {
                        [num appendString:@"%"];
                        [num appendFormat:@"03#%@",ballV.numLabel.text];
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
                [_selectNumber appendString:selectNumber_s];
            }
        }
    }

    
    return [_selectNumber length] > 0 ? _selectNumber : nil;
}

- (void)wanfaInfo {
    [MobClick event:@"event_goucai_wanfashuoming_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];

	Xieyi365ViewController *xie= [[Xieyi365ViewController alloc] init];
    xie.ALLWANFA = Pai3;
	[self.navigationController pushViewController:xie animated:YES];
	[xie release];
	
}

//- (void)titleCHange {
//    UIView *v = [self.mainView viewWithTag:1011];
//    UIView *v1 = [self.mainView viewWithTag:1012];
//    
//    UIView * zhiXuanHeZhiView = [normalScrollView viewWithTag:1013];
//    UIView * zuSanHeZhiView = [normalScrollView viewWithTag:1014];
//    UIView * zuLiuHeZhiView = [normalScrollView viewWithTag:1015];
//    
//    if (modetype == Array3zhixuanfushi) {
//        modetype = Array3zhixuanfushi;
//
//        v.hidden = NO;
//        v1.hidden = NO;
//        
//        zhiXuanHeZhiView.hidden = YES;
//        zuSanHeZhiView.hidden = YES;
//        zuLiuHeZhiView.hidden = YES;
//    }
//    else if (modetype == Array3zusanfushi) {
//        modetype = Array3zusanfushi;
//        
//        v.hidden = YES;
//        v1.hidden = YES;
//    }
//    else if (modetype == Array3zuliufushi){
//        modetype = Array3zuliufushi;
//        
//        v.hidden = YES;
//        v1.hidden = YES;
//    }
//    else if (modetype == Array3zuxuandanshi){
//        modetype = Array3zuliufushi;
//       
//        v.hidden = NO;
//        v1.hidden = NO;
//    }
//
//}

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

        [self contentSizeChange];
        self.showYiLou = YES;
        if ([self.yiLouDataArray count] > 0) {
            [self showChart:self.yiLouDataArray];
            pai3ScrollView.contentOffset = CGPointMake(pai3ScrollView.contentOffset.x, pai3ScrollView.contentSize.height - pai3ScrollView.frame.size.height);
            pai3ScrollView1.contentOffset = CGPointMake(pai3ScrollView1.contentOffset.x, pai3ScrollView1.contentSize.height - pai3ScrollView1.frame.size.height);
        }else{
            [self requestPai3YiLouWithType:2];
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
//        [self otherLottoryViewController:0 title:@"排列三合买" lotteryType:5 lotteryId:LOTTERY_ID];
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

#pragma mark - 遗漏

- (void)requestPai3YiLouWithType:(int)type
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
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    int type = 0;
    
    if (modetype == Array3zhixuanfushi) {
        type = 100;
    }
    else if (modetype == Array3zusanfushi) {
        type = 101;
    }
    else if (modetype == Array3zuliufushi) {
        type = 102;
    }
    else if (modetype == Array3zuxuandanshi) {
        type = 103;
    }
    else if (modetype == Array3zhixuanHezhi) {
        type = 200;
    }
    else if (modetype == Array3zusanHezhi) {
        type = 201;
    }
    else if (modetype == Array3zuliuHezhi) {
        type = 202;
    }
    else if (modetype == Array3zusandantuo) {
        type = 300;
    }
    else if (modetype == Array3zuliudantuo) {
        type = 301;
    }
    button.tag = type;
    [self pressBgButton:button];
    
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
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            int type = 0;
            
            if (modetype == Array3zhixuanfushi) {
                type = 100;
            }
            else if (modetype == Array3zusanfushi) {
                type = 101;
            }
            else if (modetype == Array3zuliufushi) {
                type = 102;
            }
            else if (modetype == Array3zuxuandanshi) {
                type = 103;
            }
            else if (modetype == Array3zhixuanHezhi) {
                type = 200;
            }
            else if (modetype == Array3zusanHezhi) {
                type = 201;
            }
            else if (modetype == Array3zuliuHezhi) {
                type = 202;
            }
            else if (modetype == Array3zusandantuo) {
                type = 300;
            }
            else if (modetype == Array3zuliudantuo) {
                type = 301;
            }
            button.tag = type;
            [self pressBgButton:button];
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
                [self showChart:chartDataArray];
            }
            
        }else{
            self.showYiLou = NO;
        }
}

-(void)displayZuDanYiLou
{
    [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1010] dictionary:[self.yilouDic objectForKey:@"dwt"] typeStr:@"zs"];
    [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1011] dictionary:[self.yilouDic objectForKey:@"dwt"] typeStr:@"zs"];
}

-(void)displayZhiXuanYiLou
{
    [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1012] dictionary:[self.yilouDic objectForKey:@"dwt"] typeStr:@"三"];
    [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1011] dictionary:[self.yilouDic objectForKey:@"dwt"] typeStr:@"二"];
    [YiLouUnderGCBallView addYiLouTextOnView:[normalScrollView viewWithTag:1010] dictionary:[self.yilouDic objectForKey:@"dwt"] typeStr:@"一"];
}

-(void)showChart:(NSMutableArray *)chartDataArray
{
    if (yiLouView) {
        int type = 1;
        if (modetype == Array3zhixuanfushi) {
            type = 0;
        }
        if (type == 1) {
            NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:10] ;
            if (pai3ScrollView1) {
                pai3ScrollView1.hidden = YES;
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
                
                pai3ScrollView = [[UIScrollView alloc] initWithFrame:yiLouView.bounds];
                pai3ScrollView.backgroundColor = [UIColor clearColor];
                pai3ScrollView.directionalLockEnabled = YES;
                pai3ScrollView.showsHorizontalScrollIndicator = NO;
                pai3ScrollView.delegate = self;
                pai3ScrollView.bounces = NO;
                pai3ScrollView.tag = 10 ;
                [yiLouView addSubview:pai3ScrollView];
                
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
                    CGRect redrawFrame1 = CGRectMake(320 * j, 0, 320, 42);
                    CGRect redrawFrame = CGRectMake(320 * j, 0, 320, REDRAW_FRAME(chartFormatData));
                    
                    UITitleYiLouView * titleYiLou = [[UITitleYiLouView alloc] initWithFrame:redrawFrame1 chartFormatData:chartFormatData];
                    [titleScrollView addSubview:titleYiLou];
                    [titleYiLou release];
                    
                    redrawView * redraw = [[redrawView alloc] initWithFrame:redrawFrame chartFormatData:chartFormatData]; //基本
                    redraw.tag = (j+1)*10;
                    [pai3ScrollView addSubview:redraw];
                    [redraw release];
                    
                    [chartFormatData release];
                    
                    pai3ScrollView.contentSize = CGSizeMake(pai3ScrollView.frame.size.width * [array count], REDRAW_FRAME(chartFormatData));
                    pai3ScrollView.contentOffset = CGPointMake(0, pai3ScrollView.contentSize.height - pai3ScrollView.frame.size.height);
                    
                }
                
                myPageControl = [[New_PageControl alloc] initWithFrame:CGRectMake(0, 0, 320, NEW_PAGECONTROL_HEIGHT)];
                myPageControl.yilouBool = YES;
                myPageControl.backgroundColor = [UIColor colorWithRed:30/255.0 green:92/255.0 blue:137/255.0 alpha:1];
                myPageControl.tag = 30 ;
                myPageControl.currentPage = 0;
                myPageControl.numberOfPages = [array count];
                [headYiLouView addSubview:myPageControl];
            }else{
                pai3ScrollView.hidden = NO;
                titleScrollView.hidden = NO;
                myPageControl.hidden = NO;
                
            }
            [array release];
        }else if(type == 0){
            NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:10] ;
            if (titleScrollView) {
                titleScrollView.hidden = YES;
            }
            if (pai3ScrollView) {
                pai3ScrollView.hidden = YES;
                
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
                
                
                pai3ScrollView1 = [[UIScrollView alloc] initWithFrame:yiLouView.bounds];
                pai3ScrollView1.backgroundColor = [UIColor clearColor];
                pai3ScrollView1.showsHorizontalScrollIndicator = NO;
                pai3ScrollView1.delegate = self;
                pai3ScrollView1.bounces = NO;
                pai3ScrollView1.directionalLockEnabled = YES;
                pai3ScrollView1.tag = 10 ;
                [yiLouView addSubview:pai3ScrollView1];
                
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
                    [pai3ScrollView1 addSubview:redraw];
                    [redraw release];
                    
                    [chartFormatData release];
                    pai3ScrollView1.contentSize = CGSizeMake(pai3ScrollView1.frame.size.width * [array count], REDRAW_FRAME(chartFormatData));
                    pai3ScrollView1.contentOffset = CGPointMake(0, pai3ScrollView1.contentSize.height - pai3ScrollView1.frame.size.height);
                }
                
                myPageControl1 = [[New_PageControl alloc] initWithFrame:CGRectMake(0, 0, 320, NEW_PAGECONTROL_HEIGHT)];
                myPageControl1.yilouBool = YES;
                myPageControl1.backgroundColor = [UIColor colorWithRed:30/255.0 green:92/255.0 blue:137/255.0 alpha:1];
                myPageControl1.tag = 30 ;
                myPageControl1.currentPage = 0;
                myPageControl1.numberOfPages = [array count];
                [headYiLouView addSubview:myPageControl1];
            }else{
                pai3ScrollView1.hidden = NO;
                titleScrollView1.hidden = NO;
                myPageControl1.hidden = NO;
                
            }
            [array release];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [super scrollViewDidScroll:scrollView];
//    if (self.showYiLou == NO) {
//        UIImageView * imagebar = (UIImageView *)[self.view viewWithTag:1201];
//        imagebar.frame = CGRectMake(260 - _cpbackScrollView.contentOffset.x, imagebar.frame.origin.y, imagebar.frame.size.width,imagebar.frame.size.height);
//    }
    
    if (scrollView == pai3ScrollView) {
        
        titleScrollView.contentOffset = CGPointMake(pai3ScrollView.contentOffset.x, titleScrollView.contentOffset.y);
    }else if (scrollView == titleScrollView){
        
        pai3ScrollView.contentOffset = CGPointMake(titleScrollView.contentOffset.x, pai3ScrollView.contentOffset.y);
        
    }else if (scrollView == titleScrollView1){
        
        pai3ScrollView1.contentOffset = CGPointMake(titleScrollView1.contentOffset.x, pai3ScrollView1.contentOffset.y);
    }else if (scrollView == pai3ScrollView1){
        
        titleScrollView1.contentOffset = CGPointMake(pai3ScrollView1.contentOffset.x, titleScrollView1.contentOffset.y);
    }
    
}

-(void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView{
    
    
    if (scrollView == pai3ScrollView || scrollView == pai3ScrollView1) {
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
    if (scrollView == pai3ScrollView) {
        
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
    }else if (scrollView == pai3ScrollView1){
        
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
        pai3ScrollView.contentOffset = CGPointMake(320*myPageControl.currentPage, pai3ScrollView.contentOffset.y);
    }else if (pageControl == myPageControl1){
        pai3ScrollView1.contentOffset = CGPointMake(320*myPageControl1.currentPage, pai3ScrollView1.contentOffset.y);
    }
    
    [UIView commitAnimations];
    
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
    }
    [self contentSizeChange];
    if (self.showYiLou) {
        self.showYiLou = YES;
    }
}

-(void)contentSizeChange
{
    if (modetype == Array3zusanfushi || modetype == Array3zuliufushi) {
        endTimelable.frame = CGRectMake(175, ORIGIN_Y([normalScrollView viewWithTag:1010]) + 11, 150, 20);
    }else if (modetype == Array3zhixuanfushi || modetype == Array3zuxuandanshi) {
        endTimelable.frame = CGRectMake(175, ORIGIN_Y([normalScrollView viewWithTag:1012]) + 11, 150, 20);
    }else{
        endTimelable.frame = CGRectMake(175, ORIGIN_Y([normalScrollView viewWithTag:1013]) + 11, 150, 20);
    }
    normalScrollView.contentSize = CGSizeMake(320, ORIGIN_Y(endTimelable) + 44);

    if (normalScrollView.contentSize.height > self.view.frame.size.height - 44 - 44 - isIOS7Pianyi) {
        normalScrollView.frame = CGRectMake(normalScrollView.frame.origin.x, normalScrollView.frame.origin.y, normalScrollView.frame.size.width, normalScrollView.contentSize.height + 10);
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, normalScrollView.frame.size.height);
    }else{
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, self.view.frame.size.height - 44 - isIOS7Pianyi);
    }
    cpLowermostScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(_mainView) + 44 + isIOS7Pianyi);

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
    controller.lotteryName = @"排列三";
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
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

//摇一注
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if ( event.subtype == UIEventSubtypeMotionShake )
    {
        [MobClick event:@"event_goucai_yaoyiyao_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];

        [self randBalls];
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        
        if (modetype == Array3zhixuanHezhi || modetype == Array3zusanHezhi || modetype == Array3zuliuHezhi || modetype == Array3zusandantuo || modetype == Array3zuliudantuo) {
            NSArray * titleArray = [titleLabel.text componentsSeparatedByString:@"-"];
            if ([titleArray count] >= 1) {
                NSString * showTitle = [[titleArray objectAtIndex:0] substringFromIndex:2];
                NSString * showTitle1 = [[titleArray objectAtIndex:0] substringToIndex:2];
                [cai showMessage:[NSString stringWithFormat:@"排列3%@%@玩法不支持随机选号",showTitle,showTitle1]];
            }
           
            return;
        }

		AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }
	[super motionEnded:motion withEvent:event];
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
    if (modetype == Array3zuxuandanshi) {
        for (UIButton *btn in imageView.superview.subviews) {
            if ([btn isKindOfClass:[UIButton class]] && btn.tag != imageView.tag && btn.selected) {
                [[caiboAppDelegate getAppDelegate] showMessage:@"每位只能选择一个球"];
                imageView.selected = NO;
                return;
            }
        }
        int sameCount = 0;
        for (int i = 0; i<3; i++) {
            UIView *v = [self.mainView viewWithTag:i+1010];
            UIButton *ball = (UIButton *)[v viewWithTag:imageView.tag];
            if (ball.selected && ball != imageView) {
                sameCount++;
            }
        }
        if (sameCount >=2) {
            [[caiboAppDelegate getAppDelegate] showMessage:@"三个球不能相同"];
            imageView.selected = NO;
        }
    }
    if (modetype == Array3zusandantuo || modetype == Array3zuliudantuo) {
        if (imageView.superview.tag == 1010) {
            NSInteger dan = 0;
            for (GCBallView *ball in imageView.superview.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]&& ball.selected) {
                    dan++;
                    if (dan>=2 && modetype == Array3zusandantuo) {
                        [[caiboAppDelegate getAppDelegate] showMessage:@"胆码最多选1个"];
                        imageView.selected = NO;
                    }
                    else if (dan > 2 && modetype == Array3zuliudantuo) {
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
        
    }
    NSUInteger bets = [GC_LotteryUtil getBets:[self seletNumber] LotteryType:lotteryType ModeType:modetype];

    zhushuLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)bets];
	jineLabel.text = [NSString stringWithFormat:@"%lu",2*(unsigned long)bets];
    
	if (bets < 1||(bets == 1 && modetype == Array3zuliufushi)) {
		senBtn.enabled = NO;
        zhushuLabel.text = @"0";
        jineLabel.text = @"0";
	}
	else {
		senBtn.enabled = YES;
	}

    NSString *str = [[[self seletNumber] stringByReplacingOccurrencesOfString:@"e" withString:@""] stringByReplacingOccurrencesOfString:@"*" withString:@""];
    if (modetype == Array3zhixuanHezhi || modetype == Array3zusanHezhi || modetype == Array3zuliuHezhi || modetype == Array3zusandantuo || modetype == Array3zuliudantuo) {
        [senBtn setTitle:@"选好了" forState:UIControlStateNormal];
        if (!([str length] == 0)) {
            
            senBtn.enabled = YES;
        }else if ([str length] == 0) {
            
            senBtn.enabled = NO;
        }
    }else{
        if ([str length] == 0) {
            [senBtn setTitle:@"机选" forState:UIControlStateNormal];
            senBtn.enabled = YES;
        }
        else {
            [senBtn setTitle:@"选好了" forState:UIControlStateNormal];
            senBtn.enabled = YES;
        }
    }
}


#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)reqWangQiKaiJiang:(ASIHTTPRequest*)request {
	if ([request responseData]) {
		WangqiKaJiangList *wang = [[[WangqiKaJiangList alloc] initWithResponseData:[request responseData] WithRequest:request] autorelease];
//		self.wangQi = wang;
//        [_cpTableView reloadData];
        
        NSMutableArray * historyArr = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
        [historyArr addObject:@[@"期号",@"开奖号",@"形态"]];
        for (int i = 0; i < 5; i++) {
            NSMutableArray * dataArray = [[NSMutableArray alloc] initWithCapacity:10];
            KaiJiangInfo * info = [wang.brInforArray objectAtIndex:i];
            
            [dataArray addObject:[NSString stringWithFormat:@"%@期",[SharedMethod getLastThreeStr:info.issue]]];
            
            NSString * numberString = [info.num stringByReplacingOccurrencesOfString:@"," withString:@"  "];
            [dataArray addObject:numberString];
            
            int sameCount = [SharedMethod getSortSameCountByArray:[numberString componentsSeparatedByString:@"  "]];
            
            if (sameCount == 0) {
                [dataArray addObject:@"组六"];
            }
            else if (sameCount == 1) {
                [dataArray addObject:@"组三"];
            }
            else if (sameCount == 2) {
                [dataArray addObject:@"豹子"];
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
        
        if (![myIssrecord isEqualToString:issrecord.curIssue]) {
            [self requestPai3YiLouWithType:1];
            myIssrecord = issrecord.curIssue;
        }
		if (issrecord) {
            endTimelable.text = [NSString stringWithFormat:@"截止时间 %@",[SharedMethod changeDateToNoYearNoSecond:issrecord.curEndTime]];
        }
        self.myissueRecord = issrecord;
        int type = 0;
        if (modetype == Array3zhixuanfushi) {
            type = 100;
        }
        else if (modetype == Array3zusanfushi) {
            type = 101;
        }
        else if (modetype == Array3zuliufushi) {
            type = 102;
        }
        else if (modetype == Array3zuxuandanshi) {
            type = 103;
        }
        else if (modetype == Array3zhixuanHezhi) {
            type = 200;
        }
        else if (modetype == Array3zusanHezhi) {
            type = 201;
        }
        else if (modetype == Array3zuliuHezhi) {
            type = 202;
        }

        
        if (self.myissueRecord) {
            titleLabel.text = [NSString stringWithFormat:@"%@%@期",titleLabel.text,[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]];
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = type;
            [self pressBgButton:button];
        }
        if (self.myissueRecord) {
            sqkaijiang.text = [[NSString stringWithFormat:@"上期开奖  <%@>",self.myissueRecord.lastLotteryNumber] stringByReplacingOccurrencesOfString:@"," withString:@"  "];
        }
        NSArray *array = [self.myissueRecord.lastLotteryNumber componentsSeparatedByString:@"#"];
        if ([array count] > 1) {
            sqkaijiang.text = [NSString stringWithFormat:@"上期开奖  <%@>",[[array objectAtIndex:1] stringByReplacingOccurrencesOfString:@"," withString:@" "]];
        }
        else {
            sqkaijiang.text = [NSString stringWithFormat:@"上期开奖  <%@>",[self.myissueRecord.lastLotteryNumber stringByReplacingOccurrencesOfString:@"," withString:@" "]];
        }
        if ([array count] >= 1) {
            float a = [self.myissueRecord.curIssue floatValue] - [[array objectAtIndex:0] floatValue];
            if (a > 1 && a < 100) {
                if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"paisanjieqi"] isEqualToString:self.myissueRecord.curIssue]) {
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"为了保证您购彩成功，网络购彩会比官方截期时间早，今日开奖期次销售已截止，您将购买%@期，祝您中奖！",[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                    [[NSUserDefaults standardUserDefaults] setValue:self.myissueRecord.curIssue forKey:@"paisanjieqi"];
                }
                else {

                    [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"为了保证您购彩成功，网络购彩会比官方截期时间早，今日开奖期次销售已截止，您将购买%@期，祝您中奖！",[SharedMethod getLastThreeStr:self.myissueRecord.curIssue]]];
                }
            }
        }
        [issrecord release];
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (void)dealloc{

    [infoViewController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.myissueRecord = nil;
    [myRequest clearDelegatesAndCancel];
    self.myRequest = nil;
    [self.qihaoReQuest clearDelegatesAndCancel];
    self.qihaoReQuest = nil;
    self.wangQi = nil;
    [normalScrollView release];
    [colorLabel release];

    [titleScrollView release];
    [pai3ScrollView release];
    
    [titleScrollView1 release];
    [pai3ScrollView1 release];
    
    [myPageControl release];
    [myPageControl1 release];
    
    [wanArray release];
    [controlArray release];
    
    [sqkaijiangView release];
    [yaoImage release];

    [yilouRequest clearDelegatesAndCancel];
    self.yilouRequest = nil;
    [allYiLouRequest clearDelegatesAndCancel];
    self.allYiLouRequest = nil;
    
    [loadview release];
    [endTimelable release];
    
    [redTitleArray release];
    [redDescArray release];
    
    [zhushuLabel release];
	[jineLabel release];

    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
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