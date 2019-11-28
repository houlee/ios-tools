//
//  KuaiLePuKeViewController.m
//  caibo
//
//  Created by yaofuyu on 14-3-18.
//
//

#import "KuaiLePuKeViewController.h"
#import "caiboAppDelegate.h"
#import "Info.h"
#import "Xieyi365ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "GC_LotteryUtil.h"
#import "ShakeView.h"
#import "GouCaiShuZiInfoViewController.h"
#import "GC_LotteryUtil.h"
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "LotteryListViewController.h"
#import "MobClick.h"
#import "n115yilouViewController.h"
#import "CP_PTButton.h"
#import "MyLottoryViewController.h"
#import "GC_AccountManage.h"
#import "GC_UserInfo.h"
#import "NetURL.h"
#import "JSON.h"
#import "HomeViewController.h"
#import "YiLouUnderGCBallView.h"
#import "SharedMethod.h"

#define LOTTERY_ID @"122"
#define ANIMATE_TIME 0.3
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7

#define HISTORY_LINE_HEIGHT 38.5
#define HISTORY_LINE_COUNT 7
#define HISTORY_FONT [UIFont systemFontOfSize:14]


@interface KuaiLePuKeViewController ()

@end

@implementation KuaiLePuKeViewController
@synthesize lotterytype;
@synthesize modetype;
@synthesize myRequest;
@synthesize qihaoReQuest;
@synthesize yilouRequest;
@synthesize issue;
@synthesize myTimer;
@synthesize yilouDic;
@synthesize myIssrecord;

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
        wanDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
  @[@"普通",@"胆拖"],@"title",
  @[@"任一",@"任二",@"任三",@"任四",@"任五",@"任六",@"同花",@"同花顺",@"顺子",@"豹子",@"对子"],@"wanArray",
  @[@"奖金9-80元", @"奖金240元",@"奖金40元",@"奖金80元",@"奖金15元",@"奖金10元",@"奖金40元",@"奖金8元",@"奖金100元"],@"wanMoneyArray",
                         @[@[@"1,2,3"],@[@"3,3,3"], @[@"6,6,6"], @[@"1,1,3"], @[@"3,3"], @[@"1,2,3"], @[@"3,6,5"], @[@"3,6"]],@"diceArray" ,nil];
        
        wanArray = [wanDictionary objectForKey:@"wanArray"];
        modetype = KuaiLePuKeRen1;
        lotterytype = TYPE_KuaiLePuKe;
        NSInteger type = [[[NSUserDefaults standardUserDefaults] valueForKey:@"KuaiLePuKeDefaultModetype"] integerValue];
        if ( KuaiLePuKeRen1 <= type && KuaiLePuKeDuiZi >= type) {
            modetype = (int)type;
        }
        //        isBackScrollView = YES;
        isVerticalBackScrollView = YES;
        cpLotteryName = kuailePukeType;
        yanchiTime = 90;
        showing = NO;
        
        hasYiLou = NO;
        canRefreshYiLou = YES;
    }
    return  self;
}

- (void)dealloc {
    [editeView removeFromSuperview];
    [self.myRequest clearDelegatesAndCancel];
    self.myRequest = nil;
    //    self.wangQi = nil;
    [self.qihaoReQuest clearDelegatesAndCancel];
    self.qihaoReQuest = nil;
    [self.yilouRequest clearDelegatesAndCancel];
    self.yilouRequest = nil;
    self.yilouDic = nil;
    self.myIssrecord = nil;
    [infoViewController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    [qingbutton release];
    //    [wanInfo release];
    [wanDictionary release];
    
    //    [bang release];
    [expectationView release];
    [topWanfaLabel release];
    
    [qingbutton release];
    
    [super dealloc];
}

- (NSString *)changeModetypeToString:(ModeTYPE)mode {
    if (mode == KuaiLePuKeRen1) {
        return @"任一";
    }
    else if (mode == KuaiLePuKeRen2){
        return @"任二";
    }
    else if (mode == KuaiLePuKeRen3){
        return @"任三";
    }
    else if (mode == KuaiLePuKeRen4){
        return @"任四";
    }
    else if (mode == KuaiLePuKeRen5){
        return @"任五";
    }
    else if (mode == KuaiLePuKeRen6){
        return @"任六";
    }
    else if (mode == KuaiLePuKeTongHua){
        return @"同花";
    }
    else if (mode == KuaiLePuKeTongHuaShun){
        return @"同花顺";
    }
    else if (mode == KuaiLePuKeShunZi) {
        return @"顺子";
    }
    else if (mode == KuaiLePuKeBaoZi) {
        return @"豹子";
    }
    else if (mode == KuaiLePuKeDuiZi) {
        return @"对子";
    }
    
    return nil;
}

-(ModeTYPE)changeStringToMode:(NSString *)str {
    if ([str isEqualToString:@"任二"]) {
        return KuaiLePuKeRen2;
    }
    else if ([str isEqualToString:@"任三"]){
        return KuaiLePuKeRen3;
    }
    else if ([str isEqualToString:@"任四"]){
        return KuaiLePuKeRen4;
    }
    else if ([str isEqualToString:@"任五"]){
        return KuaiLePuKeRen5;
    }
    else if ([str isEqualToString:@"任六"]){
        return KuaiLePuKeRen6;
    }
    else if ([str isEqualToString:@"同花"]){
        return KuaiLePuKeTongHua;
    }
    else if ([str isEqualToString:@"同花顺"]){
        return KuaiLePuKeTongHuaShun;
    }
    else if ([str isEqualToString:@"顺子"]){
        return KuaiLePuKeShunZi;
    }
    else if ([str isEqualToString:@"豹子"]){
        return KuaiLePuKeBaoZi;
    }
    else if ([str isEqualToString:@"对子"]) {
        return KuaiLePuKeDuiZi;
    }
    
    return KuaiLePuKeRen1;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    isAppear = NO;
    [self.myTimer invalidate];
    self.myTimer = nil;
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getIssueInfo) object:nil];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]){
        self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:nil Target:self action:@selector(doBack) ImageName:@"HC_gouwuche.png"];
        [self.CP_navigation setHidesBackButton:YES];
    }
    //    [self refreshAccunt];
    isAppear = YES;
    changePage = NO;
    [self changeShuoMing];
    [self performSelector:@selector(getIssueInfo)];
    [self ballSelectChange:nil];
}

- (void)LoadIphoneView {
    
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.tag = 999;
    titleView.userInteractionEnabled = YES;
    self.CP_navigation.titleView = titleView;
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:19];
    titleLabel.tag = 789;
    titleLabel.textColor = [UIColor colorWithRed:182/255.0 green:193/255.0 blue:201/255.0 alpha:1];
    
    sanjiaoImageView = [[[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"pukeWanFaQieHuan.png")] autorelease];
    [titleView addSubview:sanjiaoImageView];
    sanjiaoImageView.tag = 567;
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.tag = 998;
    titleButton.backgroundColor = [UIColor clearColor];
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleButton addTarget:self action:@selector(pressTitleButton1:) forControlEvents:UIControlEventTouchDown];
    [titleButton addTarget:self action:@selector(pressTitleButton2:) forControlEvents:UIControlEventTouchCancel];

    [titleView addSubview:titleLabel];
    [titleView addSubview:titleButton];
    [titleView release];
    
    UIImageView *cpLowermostBG = (UIImageView *)[self.view viewWithTag:5566];
    cpLowermostBG.image = UIImageGetImageFromName(@"kuailepukeback.jpg");
    
    
    timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 54)];
    [self.mainView addSubview:timeImage];
    timeImage.image = [UIImageGetImageFromName(@"pukekaijiangback.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    [timeImage release];
    
    sqkaijiang = [[ColorView alloc] initWithFrame:CGRectMake(15, 18, 150, 23)];
    [self.mainView addSubview:sqkaijiang];
    sqkaijiang.font = [UIFont systemFontOfSize:12];
    sqkaijiang.backgroundColor = [UIColor clearColor];
    sqkaijiang.textColor = [UIColor colorWithRed:199/255.0 green:242/255.0 blue:255.0/255.0 alpha:1.0];
    [sqkaijiang release];

    
    UIImageView * shakeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(timeImage) + 10, 20.5, 19)];
    [backScrollView addSubview:shakeImageView];
    shakeImageView.backgroundColor = [UIColor clearColor];
    shakeImageView.image = UIImageGetImageFromName(@"pukeshake.png");

    topWanfaLabel = [[ColorView alloc] initWithFrame:CGRectMake(ORIGIN_X(shakeImageView) + 2, shakeImageView.frame.origin.y + 2, 260, shakeImageView.frame.size.height)];
    topWanfaLabel.font = [UIFont systemFontOfSize:14];
    topWanfaLabel.colorfont = topWanfaLabel.font;
    topWanfaLabel.textColor = [UIColor colorWithRed:97/255.0 green:161/255.0 blue:184/255.0 alpha:1];
    topWanfaLabel.changeColor = [UIColor colorWithRed:255/255.0 green:240/255.0 blue:3/255.0 alpha:1];
    topWanfaLabel.backgroundColor = [UIColor clearColor];
    [backScrollView addSubview:topWanfaLabel];
    
    typeTitleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(shakeImageView) + 9, 49, 19)];
    typeTitleImageView.image = [UIImageGetImageFromName(@"pukeContentTitle.png") stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    [backScrollView addSubview:typeTitleImageView];
    
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 34, 19)];
    nameLabel.text = @"任选";
    nameLabel.textColor = [UIColor colorWithRed:133/255.0 green:211/255.0 blue:233/255.0 alpha:1];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:13];
    [typeTitleImageView addSubview:nameLabel];
    nameLabel.tag = 457;
    [nameLabel release];
    
    ColorView * descriptionLabel = [[ColorView alloc] initWithFrame:CGRectMake(ORIGIN_X(typeTitleImageView) + 4, typeTitleImageView.frame.origin.y + 2, 260, typeTitleImageView.frame.size.height)];
    descriptionLabel.font = [UIFont systemFontOfSize:13];
    descriptionLabel.colorfont = descriptionLabel.font;
    descriptionLabel.textColor = [UIColor colorWithRed:147/255.0 green:191/255.0 blue:220/255.0 alpha:1];
    descriptionLabel.changeColor = [UIColor colorWithRed:255/255.0 green:240/255.0 blue:3/255.0 alpha:1];
    descriptionLabel.backgroundColor = [UIColor clearColor];
    [backScrollView addSubview:descriptionLabel];
    descriptionLabel.tag = 458;
    [descriptionLabel release];
    

    for (int i = 0; i< 4; i++) {
		UIImageView *firstView = [[UIImageView alloc] init];
		firstView.tag = 1000 +i;
        firstView.userInteractionEnabled = YES;

        firstView.backgroundColor = [UIColor clearColor];

        if (i == 0) {
            firstView.frame = CGRectMake(0, 0, 320, 345);
            NSArray *name = [NSArray arrayWithObjects:@"⑴",@"⑵",@"⑶",@"⑷",@"⑸",@"⑹",@"⑺",@"⑻",@"⑼",@"⒂",@"⑾",@"⑿",@"⒀", nil];
            
            GCBallView * lastBallView;
            for (int j = 0; j < 13; j ++) {
                int a = j/5,b = j%5;
                GCBallView *ball = [[GCBallView alloc] initWithFrame:CGRectMake(27 + 57.5 *b, 10 + 89 * a, 37.5, 52) Num:[name objectAtIndex:j] ColorType:GCBallViewKuaiLePukePutong];
                [firstView addSubview:ball];
                [ball setBackgroundImage:UIImageGetImageFromName(@"pukeSelect.png") forState:UIControlStateSelected];
                [ball setBackgroundImage:UIImageGetImageFromName(@"pukeNomor.png") forState:UIControlStateNormal];
                ball.gcballDelegate = self;
                ball.numLabel.font = [UIFont fontWithName:@"TRENDS" size:19];
                ball.numLabel.frame = CGRectMake(4, 0, ball.frame.size.width - 4, ball.frame.size.height - 10);
                ball.tag = j;
                [ball release];
                
                lastBallView = ball;
            }
            for (int j = 0; j < 5; j ++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(30 + 57.5 * j , ORIGIN_Y(lastBallView) + 66, 32.5, 32);
                [firstView addSubview:btn];
                btn.tag = 100 + j;
                NSString *name1 = [NSString stringWithFormat:@"PukeRenXuan_%d.png",j + 1];
                NSString *name2 = [NSString stringWithFormat:@"PukeRenXuan_%d.png",j + 6];
                btn.adjustsImageWhenHighlighted = NO;
                [btn setImage:UIImageGetImageFromName(name2) forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(daxiaodanshuangChange:) forControlEvents:UIControlEventTouchUpInside];
                [btn setImage:UIImageGetImageFromName(name1) forState:UIControlStateSelected];
            }
            
        }
        else if (i == 1) {
            firstView.frame = CGRectMake(0, 0, 320, 290);

            NSArray *nameArray = [NSArray arrayWithObjects:@"hei",@"hong",@"hua",@"pian",@"包", nil];
            for (int j = 0; j < 5; j ++) {
                int a = j/4,b = j%4;
                GCBallView *ball = [[GCBallView alloc] initWithFrame:CGRectMake(12 + 76 *b, 23.5 + 128 * a, 54, 72.5) Num:[nameArray objectAtIndex:j] ColorType:GCBallViewKuaiLePuKeTonghua];
                [firstView addSubview:ball];
                if (a == 1) {
//                    ball.nomorFrame = ball.frame;
                    ball.ylLable.frame = CGRectMake(0, 95, 157.5, 10);
                }
                ball.numLabel.textColor = [UIColor blackColor];
                ball.numLabel.font = [UIFont systemFontOfSize:13];
                ball.gcballDelegate = self;
                ball.tag = j;
                [ball release];
                
                if (a == 0 && b == 0) {
                    UIImageView * typeTitleImageView1 = [[[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(ball) + 40, 49, 19)] autorelease];
                    typeTitleImageView1.image = [UIImageGetImageFromName(@"pukeContentTitle.png") stretchableImageWithLeftCapWidth:5 topCapHeight:0];
                    [firstView addSubview:typeTitleImageView1];
                    
                    UILabel * nameLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 34, 19)];
                    nameLabel1.text = @"包选";
                    nameLabel1.textColor = [UIColor colorWithRed:133/255.0 green:211/255.0 blue:233/255.0 alpha:1];
                    nameLabel1.backgroundColor = [UIColor clearColor];
                    nameLabel1.font = [UIFont systemFontOfSize:13];
                    [typeTitleImageView1 addSubview:nameLabel1];
                    [nameLabel1 release];
                    
                    ColorView * descriptionLabel1 = [[ColorView alloc] initWithFrame:CGRectMake(ORIGIN_X(typeTitleImageView1) + 4, typeTitleImageView1.frame.origin.y + 2, 260, typeTitleImageView1.frame.size.height)];
                    descriptionLabel1.font = [UIFont systemFontOfSize:13];
                    descriptionLabel1.colorfont = descriptionLabel.font;
                    descriptionLabel1.textColor = [UIColor colorWithRed:147/255.0 green:191/255.0 blue:220/255.0 alpha:1];
                    descriptionLabel1.changeColor = [UIColor colorWithRed:255/255.0 green:240/255.0 blue:3/255.0 alpha:1];
                    descriptionLabel1.backgroundColor = [UIColor clearColor];
                    [firstView addSubview:descriptionLabel1];
                    descriptionLabel1.tag = 459;
                    [descriptionLabel1 release];
                }
            }
        }
        else if (i == 2) {
            firstView.frame = CGRectMake(0, 0, 320, 440);

            NSArray *nameArray = [NSArray arrayWithObjects:@"⑴⒁⑴",@"⑵⒁⑵",@"⑶⒁⑶",@"⑷⒁⑷",@"⑸⒁⑸",@"⑹⒁⑹",@"⑺⒁⑺",@"⑻⒁⑻",@"⑼⒁⑼",@"⒂⒁⒂",@"⑾⒁⑾",@"⑿⒁⑿",@"⒀⒁⒀",@"包", nil];
            for (int j = 0; j < 14; j ++) {
                int a = j/3,b = j%3;
                GCBallView *ball = [[GCBallView alloc] initWithFrame:CGRectMake(19 + 108 *b, 10 + 74 * a, 66, 47.5) Num:[nameArray objectAtIndex:j] ColorType:GCBallViewKuaiLePukePutong];
                [firstView addSubview:ball];
                ball.gcballDelegate = self;
                if ([ball.numLabel.text isEqualToString:@"包"]) {
                    [ball setBackgroundImage:UIImageGetImageFromName(@"pukeputongbaoxuan_1.png") forState:UIControlStateSelected];
                    [ball setBackgroundImage:UIImageGetImageFromName(@"pukeputongbaoxuan.png") forState:UIControlStateNormal];
                }else{
                    [ball setBackgroundImage:UIImageGetImageFromName(@"pukeSelect3.png") forState:UIControlStateSelected];
                    [ball setBackgroundImage:UIImageGetImageFromName(@"pukeNomor3.png") forState:UIControlStateNormal];
                }
                
                ball.numLabel.backgroundColor = [UIColor clearColor];
                ball.numLabel.frame = CGRectMake(0, 10, 66, 20);
                ball.ylLable.frame = CGRectMake(0, 55, 66, 10);
                ball.tag = j;
                [ball release];
                
                if (a == 4 && b == 0) {
                    UIImageView * typeTitleImageView1 = [[[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(ball) + 40, 49, 19)] autorelease];
                    typeTitleImageView1.image = [UIImageGetImageFromName(@"pukeContentTitle.png") stretchableImageWithLeftCapWidth:5 topCapHeight:0];
                    typeTitleImageView1.tag = 460;
                    [firstView addSubview:typeTitleImageView1];
                    
                    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 34, 19)];
                    nameLabel.text = @"包选";
                    nameLabel.textColor = [UIColor colorWithRed:133/255.0 green:211/255.0 blue:233/255.0 alpha:1];
                    nameLabel.backgroundColor = [UIColor clearColor];
                    nameLabel.font = [UIFont systemFontOfSize:13];
                    [typeTitleImageView1 addSubview:nameLabel];
                    [nameLabel release];
                    
                    ColorView * descriptionLabel = [[ColorView alloc] initWithFrame:CGRectMake(ORIGIN_X(typeTitleImageView1) + 4, typeTitleImageView1.frame.origin.y + 2, 260, typeTitleImageView1.frame.size.height)];
                    descriptionLabel.font = [UIFont systemFontOfSize:13];
                    descriptionLabel.colorfont = descriptionLabel.font;
                    descriptionLabel.textColor = [UIColor colorWithRed:147/255.0 green:191/255.0 blue:220/255.0 alpha:1];
                    descriptionLabel.changeColor = [UIColor colorWithRed:255/255.0 green:240/255.0 blue:3/255.0 alpha:1];
                    descriptionLabel.backgroundColor = [UIColor clearColor];
                    [firstView addSubview:descriptionLabel];
                    descriptionLabel.tag = 459;
                    [descriptionLabel release];
                }
            }
        }
        else if (i == 3) {
            firstView.frame = CGRectMake(0, 0, 320, 480);

            NSArray *name = [NSArray arrayWithObjects:@"⑴ ⑴",@"⑵ ⑵",@"⑶ ⑶",@"⑷ ⑷",@"⑸ ⑸",@"⑹ ⑹",@"⑺ ⑺",@"⑻ ⑻",@"⑼ ⑼",@"⒂⒂",@"⑾ ⑾",@"⑿ ⑿",@"⒀ ⒀",@"包", nil];
            
            for (int j = 0; j < 14; j ++) {
                int a = j/4,b = j%4;
                GCBallView *ball = [[GCBallView alloc] initWithFrame:CGRectMake(18 + 77.5 *b, 10 + 81.5 * a, 51.5, 47.5) Num:[name objectAtIndex:j] ColorType:GCBallViewKuaiLePukePutong];
                [firstView addSubview:ball];
                if ([ball.numLabel.text isEqualToString:@"包"]) {
                    [ball setBackgroundImage:UIImageGetImageFromName(@"pukeputongbaoxuan_1.png") forState:UIControlStateSelected];
                    [ball setBackgroundImage:UIImageGetImageFromName(@"pukeputongbaoxuan.png") forState:UIControlStateNormal];
                }else{
                    [ball setBackgroundImage:UIImageGetImageFromName(@"pukeSelect2.png") forState:UIControlStateSelected];
                    [ball setBackgroundImage:UIImageGetImageFromName(@"pukeNomor2.png") forState:UIControlStateNormal];
                }
                ball.gcballDelegate = self;
                ball.numLabel.frame = CGRectMake(1, 6, ball.frame.size.width - 6, ball.frame.size.height/2);
                if (j == 9) {
                    ball.numLabel.frame = CGRectMake(4, 6, ball.frame.size.width - 6, ball.frame.size.height/2);
                }
                ball.ylLable.frame = CGRectMake(0, 55, 51.5, 10);
                ball.numLabel.font = [UIFont fontWithName:@"TRENDS" size:17];
                ball.tag = j;
                [ball release];
                
                if (a == 3 && b == 0) {
                    UIImageView * typeTitleImageView1 = [[[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(ball) + 40, 49, 19)] autorelease];
                    typeTitleImageView1.image = [UIImageGetImageFromName(@"pukeContentTitle.png") stretchableImageWithLeftCapWidth:5 topCapHeight:0];
                    [firstView addSubview:typeTitleImageView1];
                    
                    UILabel * nameLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 34, 19)];
                    nameLabel1.text = @"包选";
                    nameLabel1.textColor = [UIColor colorWithRed:133/255.0 green:211/255.0 blue:233/255.0 alpha:1];
                    nameLabel1.backgroundColor = [UIColor clearColor];
                    nameLabel1.font = [UIFont systemFontOfSize:13];
                    [typeTitleImageView1 addSubview:nameLabel1];
                    [nameLabel1 release];
                    
                    ColorView * descriptionLabel1 = [[ColorView alloc] initWithFrame:CGRectMake(ORIGIN_X(typeTitleImageView1) + 4, typeTitleImageView1.frame.origin.y + 2, 260, typeTitleImageView1.frame.size.height)];
                    descriptionLabel1.font = [UIFont systemFontOfSize:13];
                    descriptionLabel1.colorfont = descriptionLabel.font;
                    descriptionLabel1.textColor = [UIColor colorWithRed:147/255.0 green:191/255.0 blue:220/255.0 alpha:1];
                    descriptionLabel1.changeColor = [UIColor colorWithRed:255/255.0 green:240/255.0 blue:3/255.0 alpha:1];
                    descriptionLabel1.backgroundColor = [UIColor clearColor];
                    [firstView addSubview:descriptionLabel1];
                    descriptionLabel1.tag = 459;
                    [descriptionLabel1 release];
                }
            }
        }

        [backScrollView addSubview:firstView];
		[firstView release];
    }
    
    expectationView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 25)];
    [self.view addSubview:expectationView];
    expectationView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    
    UILabel * expectationLabel = [[[UILabel alloc] initWithFrame:expectationView.bounds] autorelease];
    expectationLabel.backgroundColor = [UIColor clearColor];
    expectationLabel.textColor = [UIColor yellowColor];
    expectationLabel.textAlignment = 1;
    expectationLabel.font = [UIFont systemFontOfSize:12];
    expectationLabel.tag = 10;
    [expectationView addSubview:expectationLabel];
    
    
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
	[self.view addSubview:im];
    im.userInteractionEnabled = YES;
	im.image = UIImageGetImageFromName(@"pukeBottomBG.jpg");
	
    //清按钮
    qingbutton = [[UIButton alloc] initWithFrame:CGRectMake(12, 7, 30, 30)];
    [qingbutton setImage:UIImageGetImageFromName(@"pukeTrash.png") forState:UIControlStateNormal];
    [qingbutton setImage:UIImageGetImageFromName(@"pukeTrash_1.png") forState:UIControlStateDisabled];
    [qingbutton addTarget:self action:@selector(clearBalls) forControlEvents:UIControlEventTouchUpInside];
    [im addSubview:qingbutton];
    
    //注数背景
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(52, 9, 62, 30)];
    zhubg.image = UIImageGetImageFromName(@"pukeZhuShu.png");
    zhubg.userInteractionEnabled = YES;
    [im addSubview:zhubg];
    //    zhubg.hidden = YES;
    [zhubg release];
    
	zhushuLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 2.5, 40, 11)];
	[zhubg addSubview:zhushuLabel];
	zhushuLabel.text = @"0";
    zhushuLabel.backgroundColor = [UIColor clearColor];
	zhushuLabel.font = [UIFont boldSystemFontOfSize:12];
	zhushuLabel.textAlignment = NSTextAlignmentCenter;
    zhushuLabel.textColor = [UIColor colorWithRed:182/255.0 green:193/255.0 blue:201/255.0 alpha:1];
	[zhushuLabel release];
	
	UILabel *zhu = [[UILabel alloc] initWithFrame:CGRectMake(40, 2.5, 20, 11)];
	zhu.text = @"注";
	zhu.backgroundColor = [UIColor clearColor];
	zhu.font = [UIFont systemFontOfSize:12];
	zhu.textColor = [UIColor colorWithRed:182/255.0 green:193/255.0 blue:201/255.0 alpha:1];
	[zhubg addSubview:zhu];
    [zhu release];
    
	
	jineLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 17.5, 40, 11)];
	[zhubg addSubview:jineLabel];
	jineLabel.text = @"0";
	jineLabel.font = [UIFont boldSystemFontOfSize:12];
    jineLabel.backgroundColor = [UIColor clearColor];
	jineLabel.textAlignment = NSTextAlignmentCenter;
    jineLabel.textColor = [UIColor whiteColor];
	[jineLabel release];
	
	UILabel *jin = [[UILabel alloc] initWithFrame:CGRectMake(40, 17.5, 20, 11)];
	jin.text = @"元";
	jin.font = [UIFont systemFontOfSize:12];
	jin.textColor = [UIColor whiteColor];
	jin.backgroundColor = [UIColor clearColor];
	[zhubg addSubview:jin];
    [jin release];
	
	senBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[senBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
	senBtn.frame = CGRectMake(235, 7, 80, 30);
    
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [senBtn setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_d.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateDisabled];
    
    [senBtn setTitle:@"机选" forState:UIControlStateNormal];
    [senBtn setTitleColor:[UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [senBtn setTitleColor:[UIColor colorWithRed:63/255.0 green:59/255.0 blue:47/255.0 alpha:1] forState:UIControlStateDisabled];
    
	[im addSubview:senBtn];
    
//    UIImageView *senImage = [[UIImageView alloc] initWithFrame:senBtn.bounds];
//    senImage.image = UIImageGetImageFromName(@"pukeButton.png");
//    [senBtn addSubview:senImage];
//    [senImage release];
//    
//    UILabel *senLabel = [[UILabel alloc] initWithFrame:senBtn.bounds];
//    senLabel.backgroundColor = [UIColor clearColor];
//    senLabel.textAlignment = NSTextAlignmentCenter;
//    senLabel.text = @"机选";
//    senLabel.textColor = [UIColor whiteColor];
//    senLabel.tag = 1101;
//    senLabel.font = [UIFont systemFontOfSize:15];
//    [senBtn addSubview:senLabel];
//    [senLabel release];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(320 - 90, 7, 60, 10)];
	[self.mainView addSubview:timeLabel];
    if ([self.issue length]) {
        timeLabel.text = [NSString stringWithFormat:@"距%@期截止",self.issue];
    }
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textAlignment = NSTextAlignmentLeft;
	timeLabel.textColor = [UIColor colorWithRed:186/255.0 green:215/255.0 blue:233/255.0 alpha:1];
	timeLabel.font = [UIFont systemFontOfSize:9];
	[timeLabel release];
	
	mytimeLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(320 - 100, 23, 80, 24)];
	[self.mainView addSubview:mytimeLabel3];
	mytimeLabel3.textColor = [UIColor colorWithRed:186/255.0 green:215/255.0 blue:233/255.0 alpha:1];
	mytimeLabel3.backgroundColor = [UIColor clearColor];
	mytimeLabel3.font = [UIFont fontWithName:@"Quartz" size:28];
	[mytimeLabel3 release];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(295, 18, 11, 20)];
    [timeImage addSubview:imageV];
    imageV.tag = 1103;
    imageV.image = UIImageGetImageFromName(@"pukejiantou.png");
    [imageV release];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(280, 0, 40, 50);
    [btn addTarget:self action:@selector(jiantouClicke) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:btn];
    
    [self switchChange];
}

- (void)jiantouClicke {
    if (cpLowermostScrollView.contentOffset.y == 0) {
        [cpLowermostScrollView setContentOffset:CGPointMake(0, cpHistoryBGImageView.frame.size.height) animated:YES];
    }
    else {
        [cpLowermostScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
}


-(void)createLabel:(UILabel *)label i:(int)i x:(float)x width:(float)width
{
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor colorWithRed:118/255.0 green:154/255.0 blue:111/255.0 alpha:1];
    //    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000,30) lineBreakMode:NSLineBreakByWordWrapping];
    //28  29  45  34  52
    label.frame = CGRectMake(x, i*30, width, 30);
    [cpHistoryBGImageView addSubview:label];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.CP_navigation.image = UIImageGetImageFromName(@"pukeNavBG.jpg");
    self.CP_navigation.titleLabel.textColor = [UIColor colorWithRed:182/255.0 green:193/255.0 blue:201/255.0 alpha:1];
    cpHistoryBGImageView.image = nil;

    if (cpHistoryBGImageView.frame.size.width != HISTORY_LINE_HEIGHT * HISTORY_LINE_COUNT) {
        cpHistoryBGImageView.frame = CGRectMake(0, 0, 320, HISTORY_LINE_HEIGHT * HISTORY_LINE_COUNT);
        _mainView.frame = CGRectMake(0, ORIGIN_Y(cpHistoryBGImageView), 320, self.view.frame.size.height - 44 - isIOS7Pianyi);

        [cpLowermostScrollView setContentOffset:CGPointMake(0, cpHistoryBGImageView.frame.size.height) animated:YES];
    }
    [MobClick event:@"event_goumai_gaopincai_kuailepuke"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getIssueInfo) name:@"BecomeActive" object:nil];
    
    
    ShakeView *shakeView = [[ShakeView alloc] init];
	[self.mainView addSubview:shakeView];
	[shakeView becomeFirstResponder];
	[shakeView release];
	   
    backScrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
    backScrollView.backgroundColor = [UIColor clearColor];
    backScrollView.scrollEnabled = YES;
    [self.mainView addSubview:backScrollView];
    [backScrollView release];
    
    

        UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack) normalImage:@"pukeBackArrow.png" highlightedImage:@"pukeBackArrow.png"];
        self.CP_navigation.leftBarButtonItem = left;
    
        if ([[[Info getInstance] userId] intValue] == 0) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
            UIBarButtonItem *right = [Info itemInitWithTitle:@"登录" Target:self action:@selector(doLogin) ImageName:nil Size:CGSizeMake(70,30) titleColor:[UIColor colorWithRed:146/255.0 green:169/255.0 blue:192/255.0 alpha:1]];
            self.CP_navigation.rightBarButtonItem = right;
        }
        else {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
            [btn setImage:UIImageGetImageFromName(@"kuaipuke_navBtn_normal.png") forState:UIControlStateNormal];
            [btn setImage:UIImageGetImageFromName(@"kuaipuke_navBtn_selected.png") forState:UIControlStateHighlighted];            btn.frame = CGRectMake(0, 0, 60, 44);
            [btn addTarget:self action:@selector(pressMenu) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            rightItem.enabled = YES;
            [self.CP_navigation setRightBarButtonItem:rightItem];
            [rightItem release];
        }
    [self LoadIphoneView];
    [self changeTitle];
    [self clearBalls];
    [self getWangqi];
    
    titleBtnIsCanPress = YES;
	// Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

- (BOOL)shouldAutorotate {
#ifdef  isCaiPiaoForIPad
    return YES;
#else
    return NO;
#endif
    
}

#pragma mark -
#pragma mark CP_ThreeLevelNavDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == cpLowermostScrollView) {
        UIImageView *imV = (UIImageView *)[timeImage viewWithTag:1103];
        if (cpLowermostScrollView.contentOffset.y > 10) {
            imV.image = UIImageGetImageFromName(@"pukejiantou.png");
        }
        else {
            imV.image = UIImageGetImageFromName(@"pukejiantou2.png");
        }
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
- (void)returnSelectIndex:(NSInteger)index{
    NSLog(@"returnSelectIndex");
    if (index == 0) {
        [self goHistory];
    }
    else if (index == 1) {
        [MobClick event:@"event_goucai_wanfaxuanze_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
        [self pressTitleButton:nil];
    }
    else if (index == 2) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",![[[NSUserDefaults standardUserDefaults] valueForKey:@"YiLouSwitch"] integerValue]] forKey:@"YiLouSwitch"];
        [self switchChange];
        [self changeTitle];

        NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
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
    else if (index == 3) {
        [self wanfaInfo];
    }
}

#pragma mark - switchChange

-(void)switchChange
{
    float heght =70;
    for (int i = 1000;i<1004;i++) {
        UIView *v = [backScrollView viewWithTag:i];
//        if (SWITCH_ON) {
//            v.frame = CGRectMake(0, heght, 320, 560);
//        }else{
//            v.frame = CGRectMake(0, heght, 320, 500);
//        }
    for (int j = 0; j < 14; j++) {
            int a = j/4,b = j%4;
            if (i == 1000) {
                a = j/5;
            }else if (i == 1002) {
                a = j/3,b = j%3;
            }
            GCBallView * ballView = (GCBallView *)[v viewWithTag:j];
            if ([ballView isKindOfClass:[GCBallView class]]) {
                if (SWITCH_ON) {
                    ballView.ylLable.hidden = NO;
                }else{
                    ballView.ylLable.hidden = YES;
                }
                if (i == 1000) {
                    ballView.frame = CGRectMake(ballView.frame.origin.x, 10 + 89 * a, 37.5, 52);
                }
                else if (i == 1001 && a == 1) {
                    ballView.frame = CGRectMake(81, 10 + 165 * a, 157.5, 88);
                }
                else if (i == 1002) {
                    ballView.frame = CGRectMake(19 + 108 *b, 10 + 74 * a, 66, 47.5);
                    if (a == 4 && b == 1) {
                        ballView.frame = CGRectMake(100, 10 + 105 * a, 126, 69.5);
                        ballView.ylLable.frame = CGRectMake(0, 80, 126, 10);
                    }
                }
                else if (i == 1003) {
                    ballView.frame = CGRectMake(ballView.frame.origin.x, 10 + 81.5 * a, 51.5, 47.5);
                    if (a == 3 && b == 1) {
                        ballView.frame = CGRectMake(100, 10 + 125 * 3, 126, 69.5);
                        ballView.ylLable.frame = CGRectMake(0, 80, 126, 10);
                    }
                }
                else{
                    ballView.frame = CGRectMake(ballView.frame.origin.x, 10 + 128 * a, 70, 100);
                }
            }
            ballView.nomorFrame = ballView.frame;
        ballView.selected = !ballView.selected;
        ballView.selected = !ballView.selected;
        }
        
        if (i == 1000) {
            for (int j = 100; j < 105; j ++) {
                UIButton *btn = (UIButton *)[v viewWithTag:j];
                if (SWITCH_ON) {
                    GCBallView * lastBallView = (GCBallView *)[v viewWithTag:12];
                    btn.frame = CGRectMake(30 + 57.5 * (j - 100) , ORIGIN_Y(lastBallView) + 66, 32.5, 32);
                }
                else {
                    //                    btn.frame = CGRectMake(12 + 60 * (j - 100) , 470, 45, 45);
                    GCBallView * lastBallView = (GCBallView *)[v viewWithTag:12];
                    btn.frame = CGRectMake(30 + 57.5 * (j - 100) , ORIGIN_Y(lastBallView) + 66, 32.5, 32);
                }
            }
            UIView *yilou = [v viewWithTag:332];
            yilou.hidden = !SWITCH_ON;
        }

        heght = heght + v.bounds.size.height-1;
    }
}

#pragma mark -
#pragma mark CP_KindsOfChooseDelegate

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt {
//    if (buttonIndex == 1) {
    isShowing = NO;


    if ([returnarry count] == 1) {
        UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
        [SharedMethod sanJiaoGuan:sanjiao];

        NSString *wanfaname = [returnarry objectAtIndex:0];
        NSInteger tag = [wanArray indexOfObject:wanfaname];
        if (tag >= 0 && tag < 100) {
            UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
            sender.tag =tag;
            [self pressBgButton:sender];
            [self clearBalls];
        }
    }
    
//    }
}

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView chuanButtonIndex:(NSInteger)buttonIndex button:(CP_XZButton*)sender {
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
#pragma mark -
#pragma mark Action

- (NSArray *)getPukeViewBy:(NSArray *)numArray {//
    if ([numArray count] < 3) {
        NSArray *retunArray = [NSArray arrayWithObjects:nil];
        return retunArray;
    }
    NSArray *name = [NSArray arrayWithObjects:@"",@"⑴",@"⑵",@"⑶",@"⑷",@"⑸",@"⑹",@"⑺",@"⑻",@"⑼",@"⒂",@"⑾",@"⑿",@"⒀", nil];
    NSArray *array1 = [[numArray objectAtIndex:0] componentsSeparatedByString:@":"];
    NSArray *array2 = [[numArray objectAtIndex:1] componentsSeparatedByString:@":"];
    NSArray *array3 = [[numArray objectAtIndex:2] componentsSeparatedByString:@":"];
    int a,b,c,a1,b1,c1;
    a = (int)[[array1 objectAtIndex:0] integerValue];
    b = (int)[[array2 objectAtIndex:0] integerValue];
    c = (int)[[array3 objectAtIndex:0] integerValue];
    a1 = (int)[[array1 objectAtIndex:1] integerValue];
    b1 = (int)[[array2 objectAtIndex:1] integerValue];
    c1 = (int)[[array3 objectAtIndex:1] integerValue];
    NSString *leixing = @"";
    int smal = 100,mid = 0,big = 0;
    if (smal > a) {
        smal = a;
    }
    if (smal > b) {
        smal = b;
    }
    if (smal > c) {
        smal = c;
    }
    if (big < a) {
        big = a;
    }
    if (big < b) {
        big = b;
    }
    if (big < c) {
        big = c;
    }
    mid = a + b + c - smal - big;
    if (a == b && b == c) {
        leixing = @"豹子";
    }
    else if (a == b || b == c || a == c) {
        leixing = @"对子";
    }
    else if (a1 == b1 && b1 == c1) {
        leixing = @"同花";
        if (smal + 1 == mid && mid + 1 ==big) {
            leixing = @"同花顺";
        }
    }
    else if (smal + 1 == mid && mid + 1 ==big) {
        leixing = @"顺子";
    }

    NSString *pic1 = [NSString stringWithFormat:@"puke_%d.png",a1];
    NSString *pic2 = [NSString stringWithFormat:@"puke_%d.png",b1];
    NSString *pic3 = [NSString stringWithFormat:@"puke_%d.png",c1];
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 26)];
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 26)];
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 26)];
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.frame = CGRectMake(1, 0, 16, 16);
    lab1.font = [UIFont fontWithName:@"TRENDS" size:14];
    if (a1%2 == 0) {
        lab1.textColor = [UIColor colorWithRed:255/255.0 green:29/255.0 blue:37/255.0 alpha:1];
    }else{
        lab1.textColor = [UIColor blackColor];
    }
    lab1.backgroundColor = [UIColor clearColor];
    lab1.tag = 101;
    lab1.text = [name objectAtIndex:a];
    lab1.autoresizingMask = 111111;
    [image1 addSubview:lab1];
    [lab1 release];
    
    UILabel *lab2 = [[UILabel alloc] init];
    lab2.frame = CGRectMake(1, 0, 16, 16);
    lab2.font = [UIFont fontWithName:@"TRENDS" size:14];
    if (b1%2 == 0) {
        lab2.textColor = [UIColor colorWithRed:255/255.0 green:29/255.0 blue:37/255.0 alpha:1];
    }else{
        lab2.textColor = [UIColor blackColor];
    }
    lab2.backgroundColor = [UIColor clearColor];
    lab2.tag = 101;
    lab2.text = [name objectAtIndex:b];
    lab2.autoresizingMask = 111111;
    [image2 addSubview:lab2];
    [lab2 release];
    
    UILabel *lab3 = [[UILabel alloc] init];
    lab3.frame = CGRectMake(1, 0, 16, 16);
    lab3.font = [UIFont fontWithName:@"TRENDS" size:14];
    if (c1%2 == 0) {
        lab3.textColor = [UIColor colorWithRed:255/255.0 green:29/255.0 blue:37/255.0 alpha:1];
    }else{
        lab3.textColor = [UIColor blackColor];
    }
    lab3.backgroundColor = [UIColor clearColor];
    lab3.tag = 101;
    lab3.text = [name objectAtIndex:c];
    lab3.autoresizingMask = 111111;
    [image3 addSubview:lab3];
    [lab3 release];
    
    image1.image = UIImageGetImageFromName(pic1);
    image2.image = UIImageGetImageFromName(pic2);
    image3.image = UIImageGetImageFromName(pic3);
    NSArray *retunArray = [NSArray arrayWithObjects:image1,image2,image3,leixing,nil];
    [image1 release];
    [image2 release];
    [image3 release];
    return retunArray;
    
}

- (void)changeNumToShaiZi:(NSArray *)numArray {
    if ([numArray count] < 3) {
        return;
    }
    NSArray *name = [NSArray arrayWithObjects:@"",@"⑴",@"⑵",@"⑶",@"⑷",@"⑸",@"⑹",@"⑺",@"⑻",@"⑼",@"⒂",@"⑾",@"⑿",@"⒀", nil];
    NSArray *array1 = [[numArray objectAtIndex:0] componentsSeparatedByString:@":"];
    NSArray *array2 = [[numArray objectAtIndex:1] componentsSeparatedByString:@":"];
    NSArray *array3 = [[numArray objectAtIndex:2] componentsSeparatedByString:@":"];
    int a,b,c,a1,b1,c1;
    a = (int)[[array1 objectAtIndex:0] integerValue];
    b = (int)[[array2 objectAtIndex:0] integerValue];
    c = (int)[[array3 objectAtIndex:0] integerValue];
    a1 = (int)[[array1 objectAtIndex:1] integerValue];
    b1 = (int)[[array2 objectAtIndex:1] integerValue];
    c1 = (int)[[array3 objectAtIndex:1] integerValue];
    NSString *pic1 = [NSString stringWithFormat:@"puke_%d.png",a1];
    NSString *pic2 = [NSString stringWithFormat:@"puke_%d.png",b1];
    NSString *pic3 = [NSString stringWithFormat:@"puke_%d.png",c1];
    UILabel *lab1 = (UILabel *)[shaizi1View viewWithTag:101];
    UILabel *lab2 = (UILabel *)[shaizi2View viewWithTag:101];
    UILabel *lab3 = (UILabel *)[shaizi3View viewWithTag:101];
    lab1.font = [UIFont fontWithName:@"TRENDS" size:21];
    lab2.font = [UIFont fontWithName:@"TRENDS" size:21];
    lab3.font = [UIFont fontWithName:@"TRENDS" size:21];

    lab1.frame = CGRectMake(2, 2, 20, 20);
    lab2.frame = CGRectMake(2, 2, 20, 20);
    lab3.frame = CGRectMake(2, 2, 20, 20);

    if (a < [name count]) {
        lab1.text = [name objectAtIndex:a];
    }
    if (b < [name count]) {
        lab2.text = [name objectAtIndex:b];
    }
    if (c < [name count]) {
        lab3.text = [name objectAtIndex:c];
    }
    if (a1 %2) {
        lab1.textColor = [UIColor blackColor];
    }
    else {
        lab1.textColor = [UIColor redColor];
    }
    
    if (b1 %2) {
        lab2.textColor = [UIColor blackColor];
    }
    else {
        lab2.textColor = [UIColor redColor];
    }
    
    if (c1 % 2) {
        lab3.textColor = [UIColor blackColor];
    }
    else {
        lab3.textColor = [UIColor redColor];
    }
    shaizi1View.frame = CGRectMake(65, -10, 30, 40);
    shaizi2View.frame = CGRectMake(100, -10, 30, 40);
    shaizi3View.frame = CGRectMake(135, -10, 30, 40);
    shaizi1View.image = UIImageGetImageFromName(pic1);
    shaizi2View.image = UIImageGetImageFromName(pic2);
    shaizi3View.image = UIImageGetImageFromName(pic3);
}

- (void)changeShuoMing {
    //不同玩法的说明修改

    ColorView * descriptionLabel = (ColorView *)[backScrollView viewWithTag:458];
    ColorView * descriptionLabel1 = (ColorView *)[[backScrollView viewWithTag:1001] viewWithTag:459];
    ColorView * shunZiDescription = (ColorView *)[[backScrollView viewWithTag:1002] viewWithTag:459];
    ColorView * duiziDescription = (ColorView *)[[backScrollView viewWithTag:1003] viewWithTag:459];
    
    UILabel * nameLabel = (UILabel *)[typeTitleImageView viewWithTag:457];
    nameLabel.text = @"任选";

    GCBallView * tongHuaBao = (GCBallView *)[[backScrollView viewWithTag:1001] viewWithTag:4];
    tongHuaBao.numLabel.frame = CGRectMake(0, 0, tongHuaBao.frame.size.width, tongHuaBao.frame.size.height/2);
    
    GCBallView * baoZiBao = (GCBallView *)[[backScrollView viewWithTag:1002] viewWithTag:13];
    baoZiBao.numLabel.frame = CGRectMake(0, 0, baoZiBao.frame.size.width, baoZiBao.frame.size.height/2);

    GCBallView * duiZiBao = (GCBallView *)[[backScrollView viewWithTag:1003] viewWithTag:13];
    duiZiBao.numLabel.font = [UIFont systemFontOfSize:13];
    duiZiBao.numLabel.frame = CGRectMake(0, 0, duiZiBao.frame.size.width, duiZiBao.frame.size.height/2);

    switch (modetype) {
        case KuaiLePuKeRen1:
            descriptionLabel.text = @"至少选1张牌";
            topWanfaLabel.text = @"猜中开奖号任意1个(不分花色)即奖<5>元";
            break;
        case KuaiLePuKeRen2:
            descriptionLabel.text = @"至少选2张牌";
            topWanfaLabel.text = @"猜中开奖号任意2个(不分花色)即奖<33>元";
            break;
        case KuaiLePuKeRen3:
            descriptionLabel.text = @"至少选3张牌";
            topWanfaLabel.text = @"猜中开奖号任意3个(不分花色)即奖<116>元";
            break;
        case KuaiLePuKeRen4:
            descriptionLabel.text = @"至少选4张牌";
            topWanfaLabel.text = @"猜中开奖号任意4个(不分花色)即奖<46>元";
            break;
        case KuaiLePuKeRen5:
            descriptionLabel.text = @"至少选5张牌";
            topWanfaLabel.text = @"猜中全部开奖号(不分花色)即奖<22>元";
            break;
        case KuaiLePuKeRen6:
            descriptionLabel.text = @"至少选6张牌";
            topWanfaLabel.text = @"猜中全部开奖号(不分花色)即奖<12>元";
            break;
        case KuaiLePuKeTongHua:
            descriptionLabel.text = @"开出同花且为所选花色即奖<90>元";
            descriptionLabel1.text = @"任意花色,只要开出同花即奖<22>元";
            tongHuaBao.numLabel.text = @"同花包选";
            topWanfaLabel.text = @"猜同花";
            nameLabel.text = @"单选";

            break;
        case KuaiLePuKeTongHuaShun:
            descriptionLabel.text = @"开出同花顺且为所选花色即奖<2150>元";
            descriptionLabel1.text = @"任意花色,只要开出同花顺即奖<535>元";
            tongHuaBao.numLabel.text = @"同花顺包选";
            topWanfaLabel.text = @"猜同花顺";
            nameLabel.text = @"单选";

            break;
        case KuaiLePuKeShunZi:
            descriptionLabel.text = @"所选的顺子开出(不分花色) 即奖<400>元";
            shunZiDescription.text = @"猜开奖的2个不同号码";
            baoZiBao.numLabel.text = @"顺子包选";
            topWanfaLabel.text = @"猜顺子";
            nameLabel.text = @"单选";
            
            break;
        case KuaiLePuKeBaoZi:
            descriptionLabel.text = @"所选的豹子开出(不分花色)即奖<6400>元";
            shunZiDescription.text = @"任意数字,只要开出豹子即奖<500>元";
            baoZiBao.numLabel.text = @"豹子包选";
            topWanfaLabel.text = @"猜豹子";
            nameLabel.text = @"单选";
            
            break;
        case KuaiLePuKeDuiZi:
            descriptionLabel.text = @"所选的对子开出(不分花色)即奖<88>元";
            duiziDescription.text = @"任意数字,只要开出对子即奖<7>元";
            duiZiBao.numLabel.text = @"对子包选";
            topWanfaLabel.text = @"猜对子";
            nameLabel.text = @"单选";
            
            break;
        default:
            break;
    }
    
//    float shakeX = 8;
//    if (shakeImageView.hidden == NO) {
//        shakeX = ORIGIN_X(shakeImageView) + 5;
//    }
//    if (modetype < KuaiLePuKeTongHua) {
//       shuomingLabel.frame = CGRectMake(shakeX, shakeImageView.frame.origin.y , 300, 18);
//    }
//    else {
//        shuomingLabel.frame = CGRectMake(shakeX, shakeImageView.frame.origin.y - 8, 300, 30);
//    }
    
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
        UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
        [SharedMethod sanJiaoGuan:sanjiao];
        
        [alert2 disMissWithPressOtherFrame];
    }
    else
    {
        NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
        [allimage addObject:@"GC_sanjilishi.png"];
        [allimage addObject:@"GC_sanjiWanfaxuanze.png"];
        [allimage addObject:@"yiLouSwIcon.png"];
        [allimage addObject:@"GC_sanjiShuoming.png"];
        
        NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
        [alltitle addObject:@"历史开奖"];
        [alltitle addObject:@"玩法选择"];
        if (SWITCH_ON) {
            [alltitle addObject:@"隐藏遗漏"];
        }else{
            [alltitle addObject:@"显示遗漏"];
        }
        [alltitle addObject:@"玩法说明"];
        
        caiboAppDelegate *app = (caiboAppDelegate *)[UIApplication sharedApplication].delegate;
//        if (!tln) {
            tln = [[CP_ThreeLevelNavigationView alloc] initWithFrame:CGRectMake(0, -20, 320, app.window.frame.size.height) AllImageName:allimage setAllTitle:alltitle type:PuKeMenu];
//        }
        
        tln.delegate = self;
        [self.view addSubview:tln];
        [tln show];
        [tln release];

        [allimage release];
        [alltitle release];
    }

}

- (void)shaiziShan{
    CABasicAnimation* rotationAnimation =
    
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    
    rotationAnimation.toValue = [NSNumber numberWithFloat:-(2 * M_PI) * 3];
    rotationAnimation.duration = 3.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [shaizi1View.layer addAnimation:rotationAnimation forKey:@"run"];
    [shaizi2View.layer addAnimation:rotationAnimation forKey:@"run"];
    [shaizi3View.layer addAnimation:rotationAnimation forKey:@"run"];
    [UIView animateWithDuration:1.5f animations:^{
        shaizi1View.frame = CGRectMake(72.5, 0, 15, 20);
        shaizi2View.frame = CGRectMake(107.5, 0, 15, 20);
        shaizi3View.frame = CGRectMake(142.5, 0, 15, 20);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5f animations:^{
            shaizi1View.frame = CGRectMake(65, -10, 30, 40);
            shaizi2View.frame = CGRectMake(100, -10, 30, 40);
            shaizi3View.frame = CGRectMake(135, -10, 30, 40);
        } completion:^(BOOL finished) {
            
        }];
    }];
}


- (void)kaiJiangDonghua {
    NSString *last = @"";
    if ([[self.myIssrecord.lastLotteryNumber componentsSeparatedByString:@"#"] count] > 0) {
        last = [[self.myIssrecord.lastLotteryNumber componentsSeparatedByString:@"#"] objectAtIndex:0];
    }
    last = [self getLastTwoStr:last];//
    sqkaijiang.text = [NSString stringWithFormat:@"%@期开奖",last];
    shaizi1View.frame = CGRectMake(82, -10, 30, 40);
    shaizi2View.frame = CGRectMake(117, -10, 30, 40);
    shaizi3View.frame = CGRectMake(152, -10, 30, 40);
    shaizi1View.hidden = NO;
    shaizi2View.hidden = NO;
    shaizi3View.hidden = NO;
    NSArray *array1 = [myIssrecord.lastLotteryNumber componentsSeparatedByString:@"#"];
    if ([array1 count] > 1) {
            NSArray *numArray = [[array1 objectAtIndex:1] componentsSeparatedByString:@","];
            if ([numArray count] >= 3) {
                [self changeNumToShaiZi:numArray];
            }
    }
    
    [self shaiziShan];
}

- (void)timeChange {
	seconds = seconds - 1;
    if (seconds < 0) {
        [self getIssueInfo];
		[self.myTimer invalidate];
		self.myTimer = nil;
        return;
    }
    if ((!isKaiJiang && seconds <= 600 - yanchiTime && seconds % 5 == 0)) {
        canRefreshYiLou = NO;
        [self getIssueInfo];
    }
    
    mytimeLabel3.text = [NSString stringWithFormat:@"%02d:%02d",(int)seconds/60,(int)seconds%60];
    if (seconds <= 60) {
        mytimeLabel3.textColor = [UIColor yellowColor];
    }else{
        mytimeLabel3.textColor = [UIColor colorWithRed:186/255.0 green:215/255.0 blue:233/255.0 alpha:1];
    }
    
    if (isKaiJiang) {
        NSString * str = [self getLastTwoStr:self.issue];
        timeLabel.text = [NSString stringWithFormat:@"距%@期截止",str];
        if ([sqkaijiang.text hasSuffix:@"等待开奖"]) {
            [self kaiJiangDonghua];
            [self performSelector:@selector(getWangqi) withObject:nil afterDelay:60];
        }
    }
    else {
        
        NSString * str = [NSString stringWithFormat:@"%lld",[self.myIssrecord.curIssue longLongValue] - 1 ];
        str = [self getLastTwoStr:str];
        sqkaijiang.text = [NSString stringWithFormat:@"%@期等待开奖",str];
        shaizi1View.image = UIImageGetImageFromName(@"pukewenhao.png");
        shaizi2View.image = UIImageGetImageFromName(@"pukewenhao.png");
        shaizi3View.image = UIImageGetImageFromName(@"pukewenhao.png");
        shaizi1View.frame = CGRectMake(82, -10, 30, 40);
        shaizi2View.frame = CGRectMake(117, -10, 30, 40);
        shaizi3View.frame = CGRectMake(152, -10, 30, 40);
        UILabel *lab1 = (UILabel *)[shaizi1View viewWithTag:101];
        UILabel *lab2 = (UILabel *)[shaizi2View viewWithTag:101];
        UILabel *lab3 = (UILabel *)[shaizi3View viewWithTag:101];
        lab1.text = @"";
        lab2.text = @"";
        lab3.text = @"";
        
    }
    
    //    if (seconds < 120) {
    ////        sqkaijiang.text = [NSString stringWithFormat:@"%@期截止 %02d:%02d",self.issue,seconds/60,seconds%60];
    //        NSString * str = [self getLastTwoStr:self.issue];
    //        sqkaijiang.text = [NSString stringWithFormat:@"%@期截止 %02d:%02d",str,seconds/60,seconds%60];
    //        shaizi1View.hidden = YES;
    //        shaizi2View.hidden = YES;
    //        shaizi3View.hidden = YES;
    //        if (seconds <= 10) {
    //            if (seconds %2 == 0) {
    //                timeImage.hidden = YES;
    //            }
    //            else {
    //                timeImage.hidden = NO;
    //            }
    //        }
    //    }
    //    else {
    //        shaizi1View.hidden = NO;
    //        shaizi2View.hidden = NO;
    //        shaizi3View.hidden = NO;
    //    }
}


- (void)quxiaoWanqi {
    editeView.alpha = 1;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    editeView.alpha = 0;
    [UIView commitAnimations];

}

- (void)getWangqi {
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

- (void)getIssueInfo {
    // 高频：0 数字彩：1 足彩：2 全部：3
    if (isAppear) {
        NSMutableData *postData = [[GC_HttpService sharedInstance] getCaiZhongInfo:LOTTERY_ID];
        
        [myRequest clearDelegatesAndCancel];
        self.myRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
        [myRequest setRequestMethod:@"POST"];
        [myRequest addCommHeaders];
        [myRequest setPostBody:postData];
        [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [myRequest setDelegate:self];
        [myRequest setDidFinishSelector:@selector(reqLotteryInfoFinished:)];
        [myRequest setDidFailSelector:@selector(reqLotteryInfoFailed:)];
        [myRequest performSelector:@selector(startAsynchronous) withObject:nil afterDelay:0.1];
    }
    
}

- (void)doLogin {
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] LoginForIpad];
#else
    changePage = YES;
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
    [btn setImage:UIImageGetImageFromName(@"kuaipuke_navBtn_normal.png") forState:UIControlStateNormal];
    [btn setImage:UIImageGetImageFromName(@"kuaipuke_navBtn_selected.png") forState:UIControlStateHighlighted];    btn.frame = CGRectMake(0, 0, 60, 44);
    [btn addTarget:self action:@selector(pressMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
}

- (void)clearBalls {
    //    if (self.modetype == KuaiLePuKeRen2 || self.modetype == KuaiLePuKeTongHuaShun) {
    //        return;
    //    }
	for (int i = 0; i < 9; i++) {
        //        if (i != 4) {
        UIView *ballView = [backScrollView viewWithTag:1000+i];
        for (GCBallView *ball in ballView.subviews) {
            if ([ball isKindOfClass:[UIButton class]]) {
                ball.selected = NO;
            }
            //            }
        }
        
	}
	zhushuLabel.text = [NSString stringWithFormat:@"%d",0];
	jineLabel.text = [NSString stringWithFormat:@"%d",2*0];
	[self ballSelectChange:nil];
}

- (NSString *)seletNumber {
	
	NSMutableString *mStr = [[[NSMutableString alloc] init] autorelease];
    for (int i = 0; i < 4; i++) {
        UIView *ballView = [backScrollView viewWithTag:1000+i];
        if (ballView.hidden == NO) {
            for (GCBallView *ball in ballView.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]&& ball.isSelected) {
                    if (ball.tag >= 100) {
                        
                    }
                    else if (self.modetype >= KuaiLePuKeRen1 && self.modetype <= KuaiLePuKeRen6) {
                        NSString * number = [NSString stringWithFormat:@"%d",(int)ball.tag + 1];
                        if (ball.tag + 1 < 10) {
                            number = [NSString stringWithFormat:@"0%d",(int)ball.tag + 1];
                        }
                        if ([number length]) {
                            if ([mStr length]) {
                                [mStr appendFormat:@",%@",number];
                            }
                            else {
                                [mStr appendString:number];
                            }
                        }
                    }
                    else if (self.modetype >= KuaiLePuKeTongHua && self.modetype <= KuaiLePuKeTongHuaShun){
                        NSString * number = [NSString stringWithFormat:@"0%d",(int)ball.tag + 1];
                        if (ball.tag == 4) {
                            number = @"00";
                        }
                        if ([number length]) {
                            if ([mStr length]) {
                                [mStr appendFormat:@",%@",number];
                            }
                            else {
                                [mStr appendString:number];
                            }
                        }
                        
                    }
                    else if (self.modetype >= KuaiLePuKeShunZi){
                        NSString * number = [NSString stringWithFormat:@"0%d",(int)ball.tag + 1];
                        if (ball.tag + 1 >= 10) {
                            number = [NSString stringWithFormat:@"%d",(int)ball.tag + 1];
                        }
                        if (ball.tag == 13) {
                            
                            number = @"00";
                        }
                        if ([number length]) {
                            if ([mStr length]) {
                                [mStr appendFormat:@",%@",number];
                            }
                            else {
                                [mStr appendString:number];
                            }
                        }
                        
                    }
                }
                
            }
        }
    }
	return (NSString *)mStr;
}

- (void)send {
    
//    if ([[[Info getInstance] userId] intValue] == 0) {
//        [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
//#ifdef isCaiPiaoForIPad
//        [[caiboAppDelegate getAppDelegate] LoginForIpad];
//#endif
//        return;
//    }
    //    if ([infoViewController.dataArray count] != 0 && ([[self seletNumber] isEqualToString:@"e"]||[[self seletNumber] isEqualToString:@"e|e"])) {
    //        [self.navigationController pushViewController:infoViewController animated:YES];
    //        return;
    //    }
//    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
    if ([senBtn.titleLabel.text isEqualToString:@"机选"] && [zhushuLabel.text integerValue] == 0) {
        [self randBalls];
        return;
    }
    [MobClick event:@"event_goucai_xuanhaole_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
	if ([jineLabel.text intValue] > 20000) {
		caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
		[cai showMessage:@"单注投注额不能超过20000元"];
		return;
	}
    
    if ([zhushuLabel.text intValue] < 1) {
        if (modetype <= KuaiLePuKeRen6) {
            [[caiboAppDelegate getAppDelegate] showMessage:[NSString stringWithFormat:@"请至少选择%d个号码。",modetype - KuaiLePuKeRen1 + 1]];
            return;
        }
    }
    
    
    if ([[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] isKindOfClass:[GouCaiShuZiInfoViewController class]]) {
        NSString *selet = [self seletNumber];
        GouCaiShuZiInfoViewController *infoV = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
        infoV.lotteryType = lotterytype;
        infoV.modeType = modetype;
        infoV.betInfo.issue = issue;
        if (self.modetype >= KuaiLePuKeRen1 && self.modetype <= KuaiLePuKeRen6) {
            if ([zhushuLabel.text intValue] == 1) {
                selet = [NSString stringWithFormat:@"01#%@",selet];
            }
            else {
                selet = [NSString stringWithFormat:@"02#%@",selet];
            }
            
        }
        else if (self.modetype >= KuaiLePuKeShunZi) {
            NSString *select2 = [selet stringByReplacingOccurrencesOfString:@"00" withString:@""];
            if ([select2 isEqualToString:selet]) {
                
            }
            else {
                if ([infoV.dataArray count] >=50) {
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"投注列表已有50条记录，当前记录无法保存，是否继续？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 201;
                    [alert show];
                    [alert release];
                    return;
                }
                [infoV.dataArray addObject:@"03#00"];
                if ([select2 length]) {
                    selet = [selet stringByReplacingOccurrencesOfString:@",00" withString:@""];
                }
                else {
                    selet = @"e";
                }
            }
            NSInteger bets = [GC_LotteryUtil getBets:selet LotteryType:lotterytype ModeType:modetype];
            if (bets == 1) {
                selet = [NSString stringWithFormat:@"01#%@",selet];
            }
            else if (bets == 0) {
                selet = @"e";
            }
            else {
                selet = [NSString stringWithFormat:@"02#%@",selet];
            }
        }
        else if (self.modetype <= KuaiLePuKeTongHuaShun && self.modetype >= KuaiLePuKeTongHua) {
            if ([infoV.dataArray count] >=50) {
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"投注列表已有50条记录，当前记录无法保存，是否继续？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.tag = 201;
                [alert show];
                [alert release];
                return;
            }
            NSArray *array = [selet componentsSeparatedByString:@","];
            NSMutableArray *array2 = [NSMutableArray array];
            for (NSString *st in array) {
                if ([st isEqualToString:@"00"]) {
                    [array2 addObject:@"02#00"];
                }
                else {
                    [array2 addObject:[NSString stringWithFormat:@"01#%@",st]];
                }
            }
            selet = @"e";
            [infoViewController.dataArray addObjectsFromArray:array2];
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
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        if (!infoViewController) {
            infoViewController = [[GouCaiShuZiInfoViewController alloc] init];
            infoViewController.goucaishuziinfotype = GouCaiShuZiInfoTypeKuaiLePuke;
        }
        //        infoViewController.danzhuJiangjin = colorLabel.text;
        infoViewController.lotteryType = lotterytype;
        infoViewController.modeType = modetype;
        infoViewController.betInfo.issue = issue;
        NSString *selet = [self seletNumber];
        
        if (self.modetype >= KuaiLePuKeRen1 && self.modetype <= KuaiLePuKeRen6) {
            if ([zhushuLabel.text intValue] == 1) {
                selet = [NSString stringWithFormat:@"01#%@",selet];
            }
            else {
                selet = [NSString stringWithFormat:@"02#%@",selet];
            }
            
        }
        else if (self.modetype >= KuaiLePuKeShunZi) {
            NSString *select2 = [selet stringByReplacingOccurrencesOfString:@"00" withString:@""];
            if ([select2 isEqualToString:selet]) {
                
            }
            else {
                if ([infoViewController.dataArray count] >=50) {
                    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"投注列表已有50条记录，当前记录无法保存，是否继续？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                    alert.shouldRemoveWhenOtherAppear = YES;
                    alert.tag = 201;
                    [alert show];
                    [alert release];
                    return;
                }
                [infoViewController.dataArray addObject:@"03#00"];
                if ([select2 length]) {
                    selet = [selet stringByReplacingOccurrencesOfString:@",00" withString:@""];
                }
                else {
                    selet = @"e";
                }
            }
            NSInteger bets = [GC_LotteryUtil getBets:selet LotteryType:lotterytype ModeType:modetype];
            if (bets == 1) {
                selet = [NSString stringWithFormat:@"01#%@",selet];
            }
            else if (bets == 0) {
                selet = @"e";
            }
            else {
                selet = [NSString stringWithFormat:@"02#%@",selet];
            }
        }
        else if (self.modetype <= KuaiLePuKeTongHuaShun && self.modetype >= KuaiLePuKeTongHua) {
            if ([infoViewController.dataArray count] >=50) {
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"投注列表已有50条记录，当前记录无法保存，是否继续？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.tag = 201;
                [alert show];
                [alert release];
                return;
            }
            NSArray *array = [selet componentsSeparatedByString:@","];
            NSMutableArray *array2 = [NSMutableArray array];
            for (NSString *st in array) {
                if ([st isEqualToString:@"00"]) {
                    [array2 addObject:@"02#00"];
                }
                else {
                    [array2 addObject:[NSString stringWithFormat:@"01#%@",st]];
                }
            }
            selet = @"e";
            [infoViewController.dataArray addObjectsFromArray:array2];
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
    if (modetype == KuaiLePuKeRen1 ) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:1 start:1 maxnum:13];
        UIView *v = [backScrollView viewWithTag:1000];
        for (GCBallView *ball in v.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                NSString *num = [NSString stringWithFormat:@"%d",(int)ball.tag + 1];
                if (ball.tag + 1 < 10) {
                    num = [NSString stringWithFormat:@"0%d",(int)ball.tag + 1];
                }
                if ([randArray containsObject:num]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
            
        }
    }
    else if (modetype == KuaiLePuKeRen2) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:2 start:1 maxnum:13];
        UIView *v = [backScrollView viewWithTag:1000];
        for (GCBallView *ball in v.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                NSString *num = [NSString stringWithFormat:@"%d",(int)ball.tag + 1];
                if (ball.tag + 1 < 10) {
                    num = [NSString stringWithFormat:@"0%d",(int)ball.tag + 1];
                }
                if ([randArray containsObject:num]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
        
    }
    else if (modetype == KuaiLePuKeRen3) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:3 start:1 maxnum:13];
        UIView *v = [backScrollView viewWithTag:1000];
        for (GCBallView *ball in v.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                NSString *num = [NSString stringWithFormat:@"%d",(int)ball.tag + 1];
                if (ball.tag + 1 < 10) {
                    num = [NSString stringWithFormat:@"0%d",(int)ball.tag + 1];
                }
                if ([randArray containsObject:num]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
        
    }
    else if (modetype == KuaiLePuKeRen4) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:4 start:1 maxnum:13];
        UIView *v = [backScrollView viewWithTag:1000];
        for (GCBallView *ball in v.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                NSString *num = [NSString stringWithFormat:@"%d",(int)ball.tag + 1];
                if (ball.tag + 1 < 10) {
                    num = [NSString stringWithFormat:@"0%d",(int)ball.tag + 1];
                }
                if ([randArray containsObject:num]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
    }
    else if (modetype == KuaiLePuKeRen5) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:5 start:1 maxnum:13];
        UIView *v = [backScrollView viewWithTag:1000];
        for (GCBallView *ball in v.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                NSString *num = [NSString stringWithFormat:@"%d",(int)ball.tag + 1];
                if (ball.tag + 1 < 10) {
                    num = [NSString stringWithFormat:@"0%d",(int)ball.tag + 1];
                }
                if ([randArray containsObject:num]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
    }
    else if (modetype == KuaiLePuKeRen6) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:6 start:1 maxnum:13];
        UIView *v = [backScrollView viewWithTag:1000];
        for (GCBallView *ball in v.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                NSString *num = [NSString stringWithFormat:@"%d",(int)ball.tag + 1];
                if (ball.tag + 1 < 10) {
                    num = [NSString stringWithFormat:@"0%d",(int)ball.tag + 1];
                }
                if ([randArray containsObject:num]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
    }
    else if (modetype == KuaiLePuKeTongHua ||modetype == KuaiLePuKeTongHuaShun) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:1 start:1 maxnum:5];
        UIView *v = [backScrollView viewWithTag:1001];
        for (GCBallView *ball in v.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                NSString *num = [NSString stringWithFormat:@"%d",(int)ball.tag + 1];
                if ([randArray containsObject:num]) {
                    ball.selected = YES;
                }
                else {
                    ball.selected = NO;
                }
            }
        }
    }
    else if (modetype >= KuaiLePuKeShunZi) {
        NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:1 start:1 maxnum:14];
        UIView *v = [backScrollView viewWithTag:1002];
        if (modetype == KuaiLePuKeDuiZi) {
            v = [backScrollView viewWithTag:1003];
        }
        for (GCBallView *ball in v.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                NSString *num = [NSString stringWithFormat:@"%d",(int)ball.tag + 1];
                if (ball.tag + 1 < 10) {
                    num = [NSString stringWithFormat:@"0%d",(int)ball.tag + 1];
                }
                if ([randArray containsObject:num] && ball.hidden == NO) {
                    if (ball.hidden) {
                        GCBallView *ball2 = (GCBallView *)[v viewWithTag:ball2.tag + 1];
                        if ([ball2 isKindOfClass:[GCBallView class]]) {
                            ball2.selected = YES;
                        }
                    }
                    else {
                        ball.selected = YES;
                    }
                }
                else {
                    ball.selected = NO;
                }
            }
        }
        
    }
	[self ballSelectChange:nil];
}

//- (void)getResqult {
//}
- (void)pressTitleButton1:(UIButton *)sender{
    
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.4];
    sanjiaoImageView.image = UIImageGetImageFromName(@"pukeWanFaQieHuan_selected.png");
}
- (void)pressTitleButton2:(UIButton *)sender{
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    sanjiaoImageView.image = UIImageGetImageFromName(@"pukeWanFaQieHuan.png");
}
- (void)pressTitleButton:(UIButton *)sender{
    
    titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    sanjiaoImageView.image = UIImageGetImageFromName(@"pukeWanFaQieHuan.png");
    
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
        
        wanFaType = [wanArray indexOfObject:[self changeModetypeToString:modetype]];
        titleBtnIsCanPress = NO;
        if(!isShowing)
        {
            UILabel *sanjiao = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
            [SharedMethod sanJiaoKai:sanjiao];
            
            alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"玩法选择" ShuziNameArray:wanArray shuziArray:nil];
            alert2.isKuaiLePuKe = YES;
            alert2.duoXuanBool = NO;
            alert2.delegate = self;
            isShowing = YES;
            alert2.isClearBtnCanPress = NO;
            [self.view addSubview:self.CP_navigation];
            self.CP_navigation.frame = CGRectMake(0, 20, 320, 44);
            [self.CP_navigation.window addSubview:alert2];
            [self.CP_navigation.window addSubview:self.CP_navigation];
            [alert2 show];

            for (CP_XZButton *btn in alert2.backScrollView.subviews) {
                if ([btn isKindOfClass:[CP_XZButton class]]) {
                    if([btn.buttonName.text isEqualToString:[self changeModetypeToString:modetype]])
                    {
                        btn.selected = YES;
                        btn.buttonName.textColor = [UIColor colorWithRed:134/255.0 green:213/255.0 blue:235/255.0 alpha:1];
                    }
                    else
                    {
                        btn.buttonName.textColor = [UIColor colorWithRed:147/255.0 green:191/255.0 blue:220/255.0 alpha:1];
                 
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

- (void)changeTitle {
    for (int i = 1000;i<1004;i++) {
        UIView *v = [backScrollView viewWithTag:i];
        v.hidden = YES;
    }
    randBtn.hidden = NO;
    if (self.issue) {
        //        titleLabel.text = [NSString stringWithFormat:@"%@ %@期",[self changeModetypeToString:modetype],self.issue];
        NSString * str = [self getLastTwoStr:self.issue];
        titleLabel.text = [NSString stringWithFormat:@"%@ %@期",[self changeModetypeToString:modetype],str];
    }
    else {
        titleLabel.text = [NSString stringWithFormat:@"%@",[self changeModetypeToString:modetype]];
    }
    //⓪ ① ② ③ ④ ⑤ ⑥ ⑦ ⑧
    UIView * bg = (UIView *)[self.CP_navigation.titleView viewWithTag:999];
    UILabel *tl = (UILabel *)[self.CP_navigation.titleView viewWithTag:789];
    UILabel *la = (UILabel *)[self.CP_navigation.titleView viewWithTag:567];
    
    CGSize tlSize = [tl.text sizeWithFont:tl.font constrainedToSize:CGSizeMake(1000,44) lineBreakMode:NSLineBreakByWordWrapping];
    tl.frame = CGRectMake(0, 0, tlSize.width, 44);
    la.frame = CGRectMake(ORIGIN_X(tl) + 2, 12, 20.5, 20);
    bg.frame = CGRectMake((320 - ORIGIN_X(la))/2, 0, ORIGIN_X(la) + 2, 44);
    
    switch (modetype) {
        case KuaiLePuKeRen1:
        {
            
            UIView *v = [backScrollView viewWithTag:1000];
            v.hidden = NO;
            
            [YiLouUnderGCBallView addYiLouTextOnView:[backScrollView viewWithTag:1000] dictionary:self.yilouDic typeStr:@"rt" firstAtIndex:1 normalColor:[UIColor colorWithRed:97/255.0 green:161/255.0 blue:184/255.0 alpha:1] maxColor:[UIColor yellowColor]];
        }
            break;
        case KuaiLePuKeRen2:
        {
            UIView *v = [backScrollView viewWithTag:1000];
            v.hidden = NO;
            
            [YiLouUnderGCBallView addYiLouTextOnView:[backScrollView viewWithTag:1000] dictionary:self.yilouDic typeStr:@"rt" firstAtIndex:1 normalColor:[UIColor colorWithRed:97/255.0 green:161/255.0 blue:184/255.0 alpha:1] maxColor:[UIColor yellowColor]];
        }
            break;
        case KuaiLePuKeRen3:
        {
            UIView *v = [backScrollView viewWithTag:1000];
            v.hidden = NO;
            
            [YiLouUnderGCBallView addYiLouTextOnView:[backScrollView viewWithTag:1000] dictionary:self.yilouDic typeStr:@"rt" firstAtIndex:1 normalColor:[UIColor colorWithRed:97/255.0 green:161/255.0 blue:184/255.0 alpha:1] maxColor:[UIColor yellowColor]];
        }
            break;
        case KuaiLePuKeRen4:
        {
            UIView *v = [backScrollView viewWithTag:1000];
            v.hidden = NO;
            
            [YiLouUnderGCBallView addYiLouTextOnView:[backScrollView viewWithTag:1000] dictionary:self.yilouDic typeStr:@"rt" firstAtIndex:1 normalColor:[UIColor colorWithRed:97/255.0 green:161/255.0 blue:184/255.0 alpha:1] maxColor:[UIColor yellowColor]];
        }
            break;
        case KuaiLePuKeRen5:
        {
            UIView *v = [backScrollView viewWithTag:1000];
            v.hidden = NO;
            
            [YiLouUnderGCBallView addYiLouTextOnView:[backScrollView viewWithTag:1000] dictionary:self.yilouDic typeStr:@"rt" firstAtIndex:1 normalColor:[UIColor colorWithRed:97/255.0 green:161/255.0 blue:184/255.0 alpha:1] maxColor:[UIColor yellowColor]];
            
        }
            break;
        case KuaiLePuKeRen6:
        {
            
            UIView *v = [backScrollView viewWithTag:1000];
            v.hidden = NO;
            
            [YiLouUnderGCBallView addYiLouTextOnView:[backScrollView viewWithTag:1000] dictionary:self.yilouDic typeStr:@"rt" firstAtIndex:1 normalColor:[UIColor colorWithRed:97/255.0 green:161/255.0 blue:184/255.0 alpha:1] maxColor:[UIColor yellowColor]];
        }
            break;
        case KuaiLePuKeTongHua:
        {
            UIView *v = [backScrollView viewWithTag:1001];
            v.hidden = NO;
            NSArray *ylkey = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"baoxuan", nil];
            for (GCBallView *ball in v.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]) {
                    ball.ylLable.text = @"-";
                    ball.ylLable.textColor = [UIColor colorWithRed:97/255.0 green:161/255.0 blue:184/255.0 alpha:1];

                    if (ball.tag < [ylkey count]) {
                        if ([[self.yilouDic objectForKey:@"tht"] valueForKey:[ylkey objectAtIndex:ball.tag]]) {
                            ball.ylLable.text = [NSString stringWithFormat:@"%@",[[[self.yilouDic objectForKey:@"tht"] valueForKey:[ylkey objectAtIndex:ball.tag]] valueForKey:@"yl"]];
                        }
                        if ([ball.ylLable.text isEqualToString:[[self.yilouDic objectForKey:@"tht"] valueForKey:@"theBig"]] && [self.yilouDic objectForKey:@"tht"]) {
                            ball.ylLable.textColor = [UIColor yellowColor];
                        }
                    }
                }
            }
        }
            break;
            
        case KuaiLePuKeTongHuaShun:
        {
            UIView *v = [backScrollView viewWithTag:1001];
            v.hidden = NO;
            NSArray *ylkey = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"baoxuan", nil];
            for (GCBallView *ball in v.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]) {
                    ball.ylLable.text = @"-";
                    ball.ylLable.textColor = [UIColor colorWithRed:97/255.0 green:161/255.0 blue:184/255.0 alpha:1];

                    if (ball.tag < [ylkey count]) {
                        if ([[self.yilouDic objectForKey:@"tst"] valueForKey:[ylkey objectAtIndex:ball.tag]]) {
                            ball.ylLable.text = [NSString stringWithFormat:@"%@",[[[self.yilouDic objectForKey:@"tst"] valueForKey:[ylkey objectAtIndex:ball.tag]] valueForKey:@"yl"]];
                            if ([ball.ylLable.text isEqualToString:[[self.yilouDic objectForKey:@"tst"] valueForKey:@"theBig"]] && [self.yilouDic objectForKey:@"tst"]) {
                                ball.ylLable.textColor = [UIColor yellowColor];
                            }
                        }
                    }
                }
            }
        }
            break;
        case KuaiLePuKeShunZi:
        {
            UIView *v = [backScrollView viewWithTag:1002];
            v.hidden = NO;
            v.frame = CGRectMake(0, 0, 320, 460);

            UIImageView * typeTitle = (UIImageView *)[v viewWithTag:460];
            typeTitle.frame = CGRectMake(0, 320, 49, 19);
            GCBallView * baoZiBao = (GCBallView *)[v viewWithTag:459];
            baoZiBao.frame = CGRectMake(ORIGIN_X(typeTitle) + 4, typeTitle.frame.origin.y, 260, 19);

            NSArray *nameArray = [NSArray arrayWithObjects:@"⑴  ⑵  ⑶",@"⑵  ⑶  ⑷",@"⑶  ⑷  ⑸",@"⑷  ⑸  ⑹",@"⑸  ⑹  ⑺",@"⑹  ⑺  ⑻",@"⑺  ⑻  ⑼",@"⑻  ⑼  ⒂",@"⑼  ⒂  ⑾",@"⒂  ⑾  ⑿",@"⑾  ⑿  ⒀",@"⑿  ⒀  ⑴",@"",@"包",nil];
            NSArray *ylkey = [NSArray arrayWithObjects:@"A23",@"234",@"345",@"456",@"567",@"678",@"789",@"8910",@"910J",@"10JQ",@"JQK",@"QKA",@" ",@"baoxuan", nil];
            for (GCBallView *ball in v.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]) {
                    ball.ylLable.text = @"-";
                    ball.numLabel.font = [UIFont fontWithName:@"TRENDS" size:13];
                    if (ball.tag < [nameArray count]) {
                        if (ball.tag == 12) {
                            ball.hidden = YES;
                            ball.selected = NO;
                        }
                        else if (ball.tag == 13) {
                            ball.frame = CGRectMake(100, 10 + 115 * 3, ball.bounds.size.width, ball.bounds.size.height);
                            ball.nomorFrame = ball.frame;
                            ball.selected = ball.selected;
                        }
                        else if (ball.tag == 9) {
                            ball.numLabel.text = [nameArray objectAtIndex:ball.tag];

                            UILabel * tenLabel = (UILabel *)[ball.numLabel viewWithTag:1110];
                            UILabel * tenLabel1 = (UILabel *)[ball.numLabel viewWithTag:1111];
                            UILabel * tenLabel2 = (UILabel *)[ball.numLabel viewWithTag:1112];
                            
                            tenLabel.hidden = YES;
                            tenLabel1.hidden = YES;
                            tenLabel2.hidden = YES;
                        }
                        else {
                            ball.numLabel.text = [nameArray objectAtIndex:ball.tag];
//                            [ball setBackgroundImage:UIImageGetImageFromName(@"pekeSelect.png") forState:UIControlStateSelected];
//                            [ball setBackgroundImage:UIImageGetImageFromName(@"pukeNomor.png") forState:UIControlStateNormal];
                        }
                        ball.ylLable.textColor = [UIColor colorWithRed:97/255.0 green:161/255.0 blue:184/255.0 alpha:1];

                        if (ball.tag != 12 && ball.tag < [ylkey count]) {
                            if ([[[self.yilouDic objectForKey:@"szt"] valueForKey:[ylkey objectAtIndex:ball.tag]] valueForKey:@"yl"]) {
                                ball.ylLable.text = [NSString stringWithFormat:@"%@",[[[self.yilouDic objectForKey:@"szt"] valueForKey:[ylkey objectAtIndex:ball.tag]] valueForKey:@"yl"]];
                            }
                            if ([ball.ylLable.text intValue] == [[[self.yilouDic objectForKey:@"szt"] valueForKey:@"theBig"] intValue] && [self.yilouDic objectForKey:@"szt"]) {
                                ball.ylLable.textColor = [UIColor yellowColor];
                            }
                            
                        }
                    }
                }
            }
            
        }
            break;
        case KuaiLePuKeBaoZi:
        {
            UIView *v = [backScrollView viewWithTag:1002];
            v.hidden = NO;
            v.frame = CGRectMake(0, 0, 320, 540);
            
            UIImageView * typeTitle = (UIImageView *)[v viewWithTag:460];
            typeTitle.frame = CGRectMake(0, 393.5, 49, 19);
            GCBallView * baoZiBao = (GCBallView *)[v viewWithTag:459];
            baoZiBao.frame = CGRectMake(ORIGIN_X(typeTitle) + 4, typeTitle.frame.origin.y, 260, 19);
            
            NSArray *nameArray = [NSArray arrayWithObjects:@"⑴  ⑴  ⑴",@"⑵  ⑵  ⑵",@"⑶  ⑶  ⑶",@"⑷  ⑷  ⑷",@"⑸  ⑸  ⑸",@"⑹  ⑹  ⑹",@"⑺  ⑺  ⑺",@"⑻  ⑻  ⑻",@"⑼  ⑼  ⑼",@"⒂  ⒂  ⒂",@"⑾  ⑾  ⑾",@"⑿  ⑿  ⑿",@"⒀  ⒀  ⒀",@"包", nil];
            NSArray *ylkey = [NSArray arrayWithObjects:@"AAA",@"222",@"333",@"444",@"555",@"666",@"777",@"888",@"999",@"101010",@"JJJ",@"QQQ",@"KKK",@"baoxuan", nil];
            for (GCBallView *ball in v.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]) {
                    ball.numLabel.font = [UIFont fontWithName:@"TRENDS" size:13];
                    if (ball.tag < [nameArray count]) {
                        ball.ylLable.text = @"-";
                        if (ball.tag == 12) {
                            ball.numLabel.text = [nameArray objectAtIndex:ball.tag];
                            ball.hidden = NO;
                        }
                        else if (ball.tag == 13) {
                            ball.frame = CGRectMake(100, 430, ball.bounds.size.width, ball.bounds.size.height);
                            ball.nomorFrame = ball.frame;
                            ball.selected = ball.selected;
                        }
                        else if (ball.tag == 9) {
                            ball.numLabel.text = @"";
                            
                            UILabel * tenLabel = (UILabel *)[ball.numLabel viewWithTag:1110];
                            UILabel * tenLabel1 = (UILabel *)[ball.numLabel viewWithTag:1111];
                            UILabel * tenLabel2 = (UILabel *)[ball.numLabel viewWithTag:1112];
                            
                            if (!tenLabel) {
                                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(5.5, 0, 10, ball.numLabel.frame.size.height)];
                                label.font = [UIFont fontWithName:@"TRENDS" size:13];
                                label.textColor = [UIColor blackColor];
                                label.text = @"⒂";
                                label.tag = 1110;
                                label.backgroundColor = [UIColor clearColor];
                                [ball.numLabel addSubview:label];
                                [label release];
                                
                                UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(label) + 12, label.frame.origin.y, label.frame.size.width, label.frame.size.height)];
                                label1.font = [UIFont fontWithName:@"TRENDS" size:13];
                                label1.textColor = [UIColor blackColor];
                                label1.text = @"⒂";
                                label1.tag = 1111;
                                label1.backgroundColor = [UIColor clearColor];
                                [ball.numLabel addSubview:label1];
                                [label1 release];
                                
                                UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X(label1) + 13, label.frame.origin.y, label.frame.size.width, label.frame.size.height)];
                                label2.font = [UIFont fontWithName:@"TRENDS" size:13];
                                label2.textColor = [UIColor blackColor];
                                label2.text = @"⒂";
                                label2.tag = 1112;
                                label2.backgroundColor = [UIColor clearColor];
                                [ball.numLabel addSubview:label2];
                                [label2 release];
                            }else{
                                tenLabel.hidden = NO;
                                tenLabel1.hidden = NO;
                                tenLabel2.hidden = NO;
                            }
                        }
                        else {
                            ball.numLabel.text = [nameArray objectAtIndex:ball.tag];
//                            [ball setBackgroundImage:UIImageGetImageFromName(@"pekeSelect.png") forState:UIControlStateSelected];
//                            [ball setBackgroundImage:UIImageGetImageFromName(@"pukeNomor.png") forState:UIControlStateNormal];
                        }
                        ball.ylLable.textColor = [UIColor colorWithRed:97/255.0 green:161/255.0 blue:184/255.0 alpha:1];
                        if (ball.tag < [ylkey count]) {
                            if ([[[self.yilouDic objectForKey:@"bzt"] valueForKey:[ylkey objectAtIndex:ball.tag]] valueForKey:@"yl"]) {
                                ball.ylLable.text = [NSString stringWithFormat:@"%@",[[[self.yilouDic objectForKey:@"bzt"] valueForKey:[ylkey objectAtIndex:ball.tag]] valueForKey:@"yl"]];
                            }
                            
                            if ([ball.ylLable.text intValue] == [[[self.yilouDic objectForKey:@"bzt"] valueForKey:@"theBig"] intValue] && [self.yilouDic objectForKey:@"bzt"]) {
                                ball.ylLable.textColor = [UIColor yellowColor];
                            }
                        }
                    
                    }
                    
                }
            }
        }
            break;
        case KuaiLePuKeDuiZi:
        {
            UIView *v = [backScrollView viewWithTag:1003];
            v.hidden = NO;
            NSArray *nameArray = [NSArray arrayWithObjects:@"⑴ ⑴",@"⑵ ⑵",@"⑶ ⑶",@"⑷ ⑷",@"⑸ ⑸",@"⑹ ⑹",@"⑺ ⑺",@"⑻ ⑻",@"⑼ ⑼",@"⒂ ⒂",@"⑾ ⑾",@"⑿ ⑿",@"⒀ ⒀", @"包",nil];
            NSArray *ylkey = [NSArray arrayWithObjects:@"AA",@"22",@"33",@"44",@"55",@"66",@"77",@"88",@"99",@"1010",@"JJ",@"QQ",@"KK",@"baoxuan", nil];
            for (GCBallView *ball in v.subviews) {
                if ([ball isKindOfClass:[GCBallView class]]) {
                    ball.numLabel.font = [UIFont fontWithName:@"TRENDS" size:17];
                    if (ball.tag < [nameArray count]) {
                        ball.ylLable.text = @"-";
                        if (ball.tag == 12) {
                            ball.numLabel.text = [nameArray objectAtIndex:ball.tag];
                            ball.hidden = NO;
                        }
                        else if (ball.tag == 13) {
//                            ball.frame = CGRectMake(100, ball.nomorFrame.origin.y, ball.bounds.size.width, ball.bounds.size.height);
//                            ball.nomorFrame = ball.frame;
                            ball.selected = ball.selected;
                        }
                        else {
                            ball.numLabel.text = [nameArray objectAtIndex:ball.tag];
//                            [ball setBackgroundImage:UIImageGetImageFromName(@"pekeSelect2.png") forState:UIControlStateSelected];
//                            [ball setBackgroundImage:UIImageGetImageFromName(@"pukeNomor2.png") forState:UIControlStateNormal];
                        }
                        ball.ylLable.textColor = [UIColor colorWithRed:97/255.0 green:161/255.0 blue:184/255.0 alpha:1];

                        if (ball.tag < [ylkey count]) {
                            if ([[[self.yilouDic objectForKey:@"dzt"] valueForKey:[ylkey objectAtIndex:ball.tag]] valueForKey:@"yl"]) {
                                ball.ylLable.text = [NSString stringWithFormat:@"%@",[[[self.yilouDic objectForKey:@"dzt"] valueForKey:[ylkey objectAtIndex:ball.tag]] valueForKey:@"yl"]];
                            }
                            
                            if ([ball.ylLable.text intValue] == [[[self.yilouDic objectForKey:@"dzt"] valueForKey:@"theBig"] intValue] && [self.yilouDic objectForKey:@"dzt"]) {
                                ball.ylLable.textColor = [UIColor yellowColor];
                            }
                        }
                    }
                }

            }
            
        }
            break;
        default:
            break;
    }
    UIView * btn = (UIView *)[self.CP_navigation.titleView viewWithTag:998];
    btn.frame = bg.bounds;
    
    float heght = ORIGIN_Y(typeTitleImageView);
    for (int i = 1000;i<1004;i++) {
        UIView *v = [backScrollView viewWithTag:i];
        if (v && v.hidden == NO) {
            v.frame = CGRectMake(v.frame.origin.x,heght , v.bounds.size.width, v.bounds.size.height);
            heght = ORIGIN_Y(v);
        }
    }
    [self changeShuoMing];
    
    backScrollView.contentSize = CGSizeMake(320,heght);
    
    if (backScrollView.contentSize.height > self.view.frame.size.height - 44 - 44 - isIOS7Pianyi) {
        backScrollView.frame = CGRectMake(backScrollView.frame.origin.x, backScrollView.frame.origin.y, backScrollView.frame.size.width, backScrollView.contentSize.height + 10);
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, backScrollView.frame.size.height);
    }else{
        _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, _mainView.frame.size.width, self.view.frame.size.height - 44 - 44 - isIOS7Pianyi);
    }
    cpLowermostScrollView.contentSize = CGSizeMake(0, ORIGIN_Y(_mainView) + 44 + 44 + isIOS7Pianyi);
}

//-(void)setNameLabelFrameWithView:(UIView *)imageView nameText:(NSString *)nameText name1Text:(NSString *)name1Text
//{
//    UIImageView * nameImageView = (UIImageView *)[imageView viewWithTag:10];
//    UILabel * nameLabel = (UILabel *)[nameImageView viewWithTag:20];
//    UILabel * nameLabel1 = (UILabel *)[nameImageView viewWithTag:30];
//    
//    nameLabel.text = nameText;
//    CGSize titleLabelSize = [nameText sizeWithFont:nameLabel.font constrainedToSize:CGSizeMake(100, 25.5)];
//    nameLabel.frame = CGRectMake(6, 0, titleLabelSize.width, 27);
//    
//    nameImageView.frame = CGRectMake(0, 0, nameLabel.frame.size.width + 20, 27);
//    
//    nameLabel1.text = name1Text;
//    CGSize nameLabelSize1 = [name1Text sizeWithFont:nameLabel1.font constrainedToSize:CGSizeMake(200, 25.5)];
//    nameLabel1.frame = CGRectMake(ORIGIN_X(nameImageView) + 5, nameLabel.frame.origin.y, nameLabelSize1.width, 25.5);
//}

- (void)pressBgButton:(UIButton *)sender{
    NSString *str = [wanArray objectAtIndex:sender.tag];
    modetype = [self changeStringToMode:str];
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",modetype] forKey:@"KuaiLePuKeDefaultModetype"];
    [self clearBalls];
	[self changeTitle];
	[self ballSelectChange:nil];
}


- (void)doBack {
    changePage = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

//新手指南
//- (void)toGuide
//{
//    NSLog(@"新手指南~~");
//
//    kuaisanShuoming *kuaishuo=[[kuaisanShuoming alloc]init];
//    kuaishuo.title=@"快3新手入门";
//    [self.navigationController pushViewController:kuaishuo animated:YES];
//    [kuaishuo release];
//
//}

//玩法介绍
- (void)wanfaInfo {
    [MobClick event:@"event_goucai_wanfashuoming_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];

	Xieyi365ViewController *xie= [[Xieyi365ViewController alloc] init];
    xie.ALLWANFA = kuailepuke;
	[self.navigationController pushViewController:xie animated:YES];
	[xie release];
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if ( event.subtype == UIEventSubtypeMotionShake )
    {
        [MobClick event:@"event_goucai_yaoyiyao_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];

            [self randBalls];
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        
    }
	[super motionEnded:motion withEvent:event];
}

- (void)getYilou {
    self.yilouDic = nil;
    [self changeTitle];
    
    NSDictionary *yilou_Dic = [[NSUserDefaults standardUserDefaults] valueForKey:LOTTERY_ID];
    
    if([yilou_Dic objectForKey:self.issue]){
        [self ShowYilouByHuancun:[yilou_Dic objectForKey:self.issue]];
        return;
    }
    
    [self.yilouRequest clearDelegatesAndCancel];
    
    if (!self.myIssrecord.curIssue) {
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:LOTTERY_ID itemNum:@"1" issue:self.myIssrecord.curIssue]];
    }else{
        self.yilouRequest = [ASIHTTPRequest requestWithURL:[NetURL ssqAndddtLotteryid:LOTTERY_ID itemNum:@"1" issue:self.myIssrecord.curIssue cacheable:YES]];
    }
    
    [yilouRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [yilouRequest setDelegate:self];
    [yilouRequest setDidFinishSelector:@selector(reqYilouFinished:)];
    [yilouRequest setDidFailSelector:@selector(rebuyFail:)];
    [yilouRequest startAsynchronous];
}

- (void)rebuyFail:(ASIHTTPRequest *)mrequest{
    hasYiLou = NO;
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
    [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
}


- (void)goHistory {
    [MobClick event:@"event_goucai_chakangengduo_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];

        [MobClick event:@"event_goucai_lishikaijiang_caizhong" label:[GC_LotteryType lotteryNameWithLotteryID:LOTTERY_ID]];
    LotteryListViewController *controller = [[LotteryListViewController alloc] init];
    
    controller.lotteryId =LOTTERY_ID;
    controller.lotteryName = @"快乐扑克";
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
    
}

- (void)daxiaodanshuangChange:(UIButton *)sender {
    sender.selected = !sender.selected;
    UIButton *quan = (UIButton *)[[backScrollView viewWithTag:1000] viewWithTag:100];
    UIButton *daBall = (UIButton *)[[backScrollView viewWithTag:1000] viewWithTag:101];
    UIButton *xiaoBall = (UIButton *)[[backScrollView viewWithTag:1000] viewWithTag:102];
    UIButton *danBall = (UIButton *)[[backScrollView viewWithTag:1000] viewWithTag:103];
    UIButton *shuangBall = (UIButton *)[[backScrollView viewWithTag:1000] viewWithTag:104];
    if (quan == sender) {
        daBall.selected = NO;
        xiaoBall.selected = NO;
        danBall.selected = NO;
        shuangBall.selected = NO;
    }
    if (sender == daBall) {
        quan.selected = NO;
        xiaoBall.selected = NO;
    }
    else if (sender == xiaoBall) {
        quan.selected = NO;
        daBall.selected = NO;
    }
    else if (sender == danBall) {
        quan.selected = NO;
        shuangBall.selected = NO;
    }
    else if (sender == shuangBall) {
        quan.selected = NO;
        danBall.selected = NO;
    }
    UIView *ballView = [backScrollView viewWithTag:1000];
    if (quan.selected) {
        for (GCBallView *ball in ballView.subviews) {
            if ([ball isKindOfClass:[GCBallView class]]) {
                if (ball.tag >= 0 && ball.tag <= 12) {
                    ball.selected = YES;
                }
            }
        }
        [self ballSelectChange:nil];
        return;
    }
    for (GCBallView *ball in ballView.subviews) {
        if ([ball isKindOfClass:[GCBallView class]]) {
            if (ball.tag >= 0 && ball.tag <= 12) {
                if (daBall.selected) {
                    if (danBall.selected) {
                        if (ball.tag >= 6) {
                            if (ball.tag %2 == 0) {
                                ball.selected = YES;
                            }
                            else {
                                ball.selected = NO;
                            }
                            
                        }
                        else {
                            ball.selected = NO;
                        }
                        
                    }
                    else if (shuangBall.selected) {
                        if (ball.tag >= 6) {
                            if (ball.tag %2 == 1) {
                                ball.selected = YES;
                            }
                            else {
                                ball.selected = NO;
                            }
                            
                        }
                        else {
                            ball.selected = NO;
                        }
                    }
                    else {
                        if (ball.tag >= 6) {
                            ball.selected = YES;
                        }
                        else
                        {
                            ball.selected = NO;
                        }
                    }
                }
                else if (xiaoBall.selected){
                    if (danBall.selected) {
                        if (ball.tag < 6) {
                            if (ball.tag %2 == 0) {
                                ball.selected = YES;
                            }
                            else {
                                ball.selected = NO;
                            }
                        }
                        else {
                            ball.selected = NO;
                        }
                        
                    }
                    else if (shuangBall.selected) {
                        if (ball.tag < 6) {
                            if (ball.tag %2 == 1) {
                                ball.selected = YES;
                            }
                            else {
                                ball.selected = NO;
                            }
                            
                        }
                        else {
                            ball.selected = NO;
                        }
                    }
                    else {
                        if (ball.tag < 6) {
                            ball.selected = YES;
                        }
                        else
                        {
                            ball.selected = NO;
                        }
                    }
                }
                else {
                    if (danBall.selected) {
                        if (ball.tag %2 == 0) {
                            ball.selected = YES;
                        }
                        else {
                            ball.selected = NO;
                        }
                        
                    }
                    else if (shuangBall.selected) {
                        if (ball.tag %2 == 1) {
                            ball.selected = YES;
                        }
                        else {
                            ball.selected = NO;
                        }
                    }
                    else {
                        ball.selected = NO;
                    }
                }
            }
            
            
        }
    }
    [self ballSelectChange:nil];
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
    if (imageView) {
        UIButton *quan = (UIButton *)[[backScrollView viewWithTag:1000] viewWithTag:100];
        UIButton *daBall = (UIButton *)[[backScrollView viewWithTag:1000] viewWithTag:101];
        UIButton *xiaoBall = (UIButton *)[[backScrollView viewWithTag:1000] viewWithTag:102];
        UIButton *danBall = (UIButton *)[[backScrollView viewWithTag:1000] viewWithTag:103];
        UIButton *shuangBall = (UIButton *)[[backScrollView viewWithTag:1001] viewWithTag:104];
        quan.selected = NO;
        daBall.selected = NO;
        xiaoBall.selected = NO;
        danBall.selected = NO;
        shuangBall.selected = NO;
    }
	NSUInteger bets = [GC_LotteryUtil getBets:[self seletNumber] LotteryType:lotterytype ModeType:modetype];
    NSLog(@"seletNumber = %@", [self seletNumber]);
//    bets = [GC_LotteryUtil getBets:[self seletNumber] LotteryType:lotterytype ModeType:modetype];
    UILabel * expectationLabel = (UILabel *)[expectationView viewWithTag:10];
    
    if (bets > 0) {
        NSString * bonus = @"0";
        switch (modetype) {
            case KuaiLePuKeRen1:
                bonus = @"5";
                break;
            case KuaiLePuKeRen2:
                bonus = @"33";
                break;
            case KuaiLePuKeRen3:
                bonus = @"116";
                break;
            case KuaiLePuKeRen4:
                bonus = @"46";
                break;
            case KuaiLePuKeRen5:
                bonus = @"22";
                break;
            case KuaiLePuKeRen6:
                bonus = @"12";
                break;
            case KuaiLePuKeTongHua:
                bonus = @"22-90";
                break;
            case KuaiLePuKeTongHuaShun:
                bonus = @"535-2150";
                break;
            case KuaiLePuKeShunZi:
                bonus = @"33-400";
                break;
            case KuaiLePuKeBaoZi:
                bonus = @"500-6400";
                break;
            case KuaiLePuKeDuiZi:
                bonus = @"7-88";
                break;
            default:
                break;
        }
        NSString * profit = [NSString stringWithFormat:@"%d",(int)[bonus integerValue] - (int)bets * 2];
        if (modetype <= KuaiLePuKeRen6) {
            if (modetype == KuaiLePuKeRen1) {
                if (bets == 1) {
                    expectationLabel.text = [NSString stringWithFormat:@"若中奖：奖金5 元，盈利3 元"];
                }
                else if (bets <=3) {
                    expectationLabel.text = [NSString stringWithFormat:@"若中奖：奖金5至%d 元，盈利%d至%d元",(int)bets * 5,5-(int) bets * 2,(int)bets *3];
                }
                else {
                    expectationLabel.text = [NSString stringWithFormat:@"若中奖：奖金5至15 元，盈利%d至%d元",5- (int)bets * 2,15 - (int)bets * 2];
                }
                
            }
            else if (modetype == KuaiLePuKeRen2) {
                if (bets == 1) {
                    expectationLabel.text = [NSString stringWithFormat:@"若中奖：奖金33 元，盈利31 元"];
                }
                else {
                    expectationLabel.text = [NSString stringWithFormat:@"若中奖：奖金33至99 元，盈利%d至%d元",33- (int)bets * 2,99 - (int)bets * 2];
                }
            }
            else {
                expectationLabel.text = [NSString stringWithFormat:@"若中奖：奖金%@元，盈利%@元",bonus,profit];
            }
            
        }
        else {
            NSArray *array = [bonus componentsSeparatedByString:@"-"];
            if (bets == 1 && [[self seletNumber] rangeOfString:@"00"].location != NSNotFound) {
                if ([array count] >= 2) {
                    expectationLabel.text = [NSString stringWithFormat:@"若中奖：奖金%@元，盈利%d",[array objectAtIndex:0],(int)[[array objectAtIndex:0] intValue] - (int)bets * 2];
                }
            }
            else if ([[self seletNumber] rangeOfString:@"00"].location != NSNotFound) {
                if ([array count] >= 2) {
                    expectationLabel.text = [NSString stringWithFormat:@"若中奖：奖金%@至%d 元，盈利%d至%d元",[array objectAtIndex:0],(int)[[array objectAtIndex:0] intValue] + (int)[[array objectAtIndex:1] intValue],(int)[[array objectAtIndex:0] intValue] - (int)bets * 2,(int)[[array objectAtIndex:0] intValue] + (int)[[array objectAtIndex:1] intValue] - (int)bets * 2];
                }
            }
            else {
                if ([array count] >= 2) {
                    expectationLabel.text = [NSString stringWithFormat:@"若中奖：奖金%@元，盈利%d元",[array objectAtIndex:1],(int)[[array objectAtIndex:1] intValue] - (int)bets * 2];
                }
            }
            
        }
        
        
        [UIView animateWithDuration:ANIMATE_TIME animations:^{
            expectationView.frame = CGRectMake(0, self.view.frame.size.height - 44 -25, 320, 25);
        } completion:^(BOOL finished) {
            
        }];
        
        
    }
    else {
        [UIView animateWithDuration:ANIMATE_TIME animations:^{
            expectationView.frame = CGRectMake(0, self.view.frame.size.height - 44, 320, 25);
        } completion:^(BOOL finished) {
            expectationLabel.text = @"";
        }];
    }
    zhushuLabel.text = [NSString stringWithFormat:@"%d",(int)bets];
	jineLabel.text = [NSString stringWithFormat:@"%d",2*(int)bets];
//    UILabel *labe = (UILabel *)[senBtn viewWithTag:1101];
    senBtn.enabled = YES;
    NSString *str =[[[[self seletNumber] stringByReplacingOccurrencesOfString:@"," withString:@""] stringByReplacingOccurrencesOfString:@"e" withString:@""] stringByReplacingOccurrencesOfString:@"|" withString:@""];
    if ([str length] == 0) {
        [senBtn setTitle:@"机选" forState:UIControlStateNormal];
        senBtn.enabled = YES;
        qingbutton.enabled = NO;
    }
    else {
        [senBtn setTitle:@"选好了" forState:UIControlStateNormal];
        senBtn.enabled = YES;
        qingbutton.enabled = YES;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 101) {
        if (buttonIndex == 1) {
            [infoViewController.dataArray removeAllObjects];
            
            [self changeShuoMing];
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


#pragma mark -
#pragma mark ASIHTTPRequestDelegate


- (void)reqWangQiKaiJiang:(ASIHTTPRequest*)request {
	if ([request responseData]) {
        WangqiKaJiangList *wang = [[[WangqiKaJiangList alloc] initWithResponseData:[request responseData] WithRequest:request] autorelease];
        NSMutableArray * historyArr = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
        //		self.wangQi = wang;
        [historyArr addObject:@[@"期号",@"开奖号码",@"类型"]];
        for (int i = 0; i < 5 && i < [wang.brInforArray count]; i++) {
            NSMutableArray * dataArray = [[NSMutableArray alloc] initWithCapacity:10];
            KaiJiangInfo * info = [wang.brInforArray objectAtIndex:i];
            
            [dataArray addObject:[NSString stringWithFormat:@"%@期",[self getLastTwoStr:info.issue]]];
            
            NSArray * numberArray = [info.num componentsSeparatedByString:@","];
            [dataArray addObjectsFromArray:[self getPukeViewBy:numberArray]];
            [historyArr addObject:dataArray];
            
            [dataArray release];
        }
        [self addHistoryWithArray:historyArr];
	}
}

-(void)addHistoryWithArray:(NSArray *)historyArray
{
    for (UIView *im in cpHistoryBGImageView.subviews) {
            [im removeFromSuperview];
    }
    
    UIImageView * bgImageView = [[[UIImageView alloc] initWithFrame:cpHistoryBGImageView.frame] autorelease];
    bgImageView.image = [UIImageGetImageFromName(@"pukeHistoryBG.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    bgImageView.userInteractionEnabled = YES;
    [cpHistoryBGImageView addSubview:bgImageView];

    UIImageView * historyTopImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bgImageView.frame.size.width, HISTORY_LINE_HEIGHT)] autorelease];
    historyTopImageView.image = UIImageGetImageFromName(@"pukekaijiangshen.png");
    [bgImageView addSubview:historyTopImageView];
    
    UILabel * topLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, cpHistoryBGImageView.frame.size.width, HISTORY_LINE_HEIGHT)] autorelease];
    topLabel.text = @"点击以下开奖号区域可查看更多";
    topLabel.font = HISTORY_FONT;
    topLabel.textColor = [UIColor whiteColor];
    topLabel.textAlignment = 1;
    [bgImageView addSubview:topLabel];
    topLabel.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i < historyArray.count; i++) {
        if (i == 0) {
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, HISTORY_LINE_HEIGHT, 320, HISTORY_LINE_HEIGHT)];
            [bgImageView addSubview:imageV];
            imageV.image = [UIImageGetImageFromName(@"pukeqihaoback.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5];
            imageV.tag = 1344;
            [imageV release];
        }
        else {
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, HISTORY_LINE_HEIGHT + HISTORY_LINE_HEIGHT * i, 320, HISTORY_LINE_HEIGHT)];
            [cpHistoryBGImageView addSubview:imageV];
            if (i%2 != 0 && !isKuaiSan) {
                imageV.image = UIImageGetImageFromName(@"pukekaijiangshen.png");
            }
            imageV.tag = 1344;
            [cpHistoryBGImageView sendSubviewToBack:imageV];
            [imageV release];
        }
        if (i == 0) {
            
            UILabel * label = [[UILabel alloc] init];
            label.font = HISTORY_FONT;
            label.backgroundColor = [UIColor clearColor];
            label.tag = 1344;
            label.textColor = [UIColor colorWithRed:182/255.0 green:218/255.0 blue:229/255.0 alpha:1.0];
            label.frame = CGRectMake(12, HISTORY_LINE_HEIGHT, 100, HISTORY_LINE_HEIGHT);
            label.text = [[historyArray objectAtIndex:i] objectAtIndex:0];
            [bgImageView addSubview:label];
            [label release];
            
            UILabel * label2 = [[UILabel alloc] init];
            label2.font = HISTORY_FONT;
            label2.backgroundColor = [UIColor clearColor];
            label2.tag = 1344;
            label2.textColor = [UIColor colorWithRed:182/255.0 green:218/255.0 blue:229/255.0 alpha:1.0];
            label2.frame = CGRectMake(132, HISTORY_LINE_HEIGHT, 100, HISTORY_LINE_HEIGHT);
            label2.text = [[historyArray objectAtIndex:i] objectAtIndex:1];
            [bgImageView addSubview:label2];
            [label2 release];
            
            UILabel * label3 = [[UILabel alloc] init];
            label3.font = HISTORY_FONT;
            label3.backgroundColor = [UIColor clearColor];
            label3.tag = 1344;
            label3.textColor = [UIColor colorWithRed:182/255.0 green:218/255.0 blue:229/255.0 alpha:1.0];
            label3.frame = CGRectMake(280, HISTORY_LINE_HEIGHT, 100, HISTORY_LINE_HEIGHT);
            label3.text = [[historyArray objectAtIndex:i] objectAtIndex:2];
            [bgImageView addSubview:label3];
            [label3 release];

        }
        else {
            for (int j = 0; j < [[historyArray objectAtIndex:i] count]; j++) {
                if (j == 0) {
                    UILabel * label = [[UILabel alloc] init];
                    label.font = HISTORY_FONT;
                    label.backgroundColor = [UIColor clearColor];
                    label.tag = 1344;
                    label.textColor = [UIColor colorWithRed:182/255.0 green:218/255.0 blue:229/255.0 alpha:1.0];
                    label.frame = CGRectMake(12, HISTORY_LINE_HEIGHT + HISTORY_LINE_HEIGHT * i, 100, HISTORY_LINE_HEIGHT);
                    label.text = [[historyArray objectAtIndex:i] objectAtIndex:j];
                    [bgImageView addSubview:label];
                    [label release];
                }
                else if (j == 4) {
                    UILabel * label = [[UILabel alloc] init];
                    label.font = HISTORY_FONT;
                    label.backgroundColor = [UIColor clearColor];
                    label.tag = 1344;
                    label.textColor = [UIColor colorWithRed:182/255.0 green:218/255.0 blue:229/255.0 alpha:1.0];
                    label.frame = CGRectMake(278, HISTORY_LINE_HEIGHT + HISTORY_LINE_HEIGHT * i, 100, HISTORY_LINE_HEIGHT);
                    label.text = [[historyArray objectAtIndex:i] objectAtIndex:j];
                    [bgImageView addSubview:label];
                    [label release];
                }
                else {
                    UIImageView *image1 = [[historyArray objectAtIndex:i] objectAtIndex:j];
                    if ([image1 isKindOfClass:[UIImageView class]]) {
                        image1.tag = 1344;
                    }
                    image1.center = CGPointMake(111 +j * 24, HISTORY_LINE_HEIGHT + 19 + HISTORY_LINE_HEIGHT *i);
                    [bgImageView addSubview:image1];
                    
                }
                
            }
        }
    }
    
    UIButton * historyButton = [[[UIButton alloc] initWithFrame:bgImageView.bounds] autorelease];
    [bgImageView addSubview:historyButton];
    historyButton.backgroundColor = [UIColor clearColor];
    [historyButton addTarget:self action:@selector(goHistory) forControlEvents:UIControlEventTouchUpInside];

}

- (void)ShowYilouByHuancun:(NSDictionary *)responseDic {
    
    self.yilouDic = responseDic;
    
    if ([[yilouDic objectForKey:@"rt"] count]) {
        
        hasYiLou = YES;
        
    }else{
        hasYiLou = NO;
        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(getYilou) object:nil];
        [self performSelector:@selector(getYilou) withObject:nil afterDelay:30];
    }
    
    [self changeTitle];
    
}
- (void)reqYilouFinished:(ASIHTTPRequest*)request {
    NSString *responseStr = [request responseString];
    if (responseStr&&![responseStr isEqualToString:@"fail"]) {
        NSDictionary *dic = [responseStr JSONValue];
        if ([[dic objectForKey:@"list"] count] > 0) {
            self.yilouDic = [[dic objectForKey:@"list"] objectAtIndex:0];
        }
        NSDictionary *renXuanDic = [self.yilouDic objectForKey:@"rt"];
        NSInteger renxuanBig = 0;
        for (int i = 1; i <= 13; i ++) {
            NSDictionary *dic = [renXuanDic objectForKey:[NSString stringWithFormat:@"%d",i]];
            if ([dic isKindOfClass:[NSDictionary class]]) {
                if (renxuanBig < [[dic valueForKey:@"yl"] integerValue]) {
                    renxuanBig = [[dic valueForKey:@"yl"] integerValue];
                }
            }
        }
        [[self.yilouDic objectForKey:@"rt"] setValue:[NSString stringWithFormat:@"%d",(int)renxuanBig] forKey:@"theBig"];
        
        NSDictionary *tonghuaDic = [self.yilouDic objectForKey:@"tht"];//同花遗漏
        NSInteger tonghuaBig = 0;
        for (int i = 0; i <= 4; i ++) {
            NSDictionary *dic = [tonghuaDic objectForKey:[NSString stringWithFormat:@"%d",i]];
            if ([dic isKindOfClass:[NSDictionary class]]) {
                if (tonghuaBig < [[dic valueForKey:@"yl"] integerValue]) {
                    tonghuaBig = [[dic valueForKey:@"yl"] integerValue];
                }
            }
        }
        [[self.yilouDic objectForKey:@"tht"] setValue:[NSString stringWithFormat:@"%d",(int)tonghuaBig] forKey:@"theBig"];
        
        NSDictionary *dztDic = [self.yilouDic objectForKey:@"dzt"];//对子遗漏
        NSInteger dzBig = 0;
        for (int i = 1; i <= 13; i ++) {
            NSDictionary *dic = [dztDic objectForKey:[NSString stringWithFormat:@"%d%d",i,i]];
            if (i == 1) {
                dic = [dztDic objectForKey:@"AA"];
            }
            else if (i == 11) {
                dic = [dztDic objectForKey:@"JJ"];
            }
            else if (i == 12) {
                dic = [dztDic objectForKey:@"QQ"];
            }
            else if (i == 13) {
                dic = [dztDic objectForKey:@"KK"];
            }
            if ([dic isKindOfClass:[NSDictionary class]]) {
                if (dzBig < [[dic valueForKey:@"yl"] integerValue]) {
                    dzBig = [[dic valueForKey:@"yl"] integerValue];
                }
            }
        }
        [[self.yilouDic objectForKey:@"dzt"] setValue:[NSString stringWithFormat:@"%d",(int)dzBig] forKey:@"theBig"];
        
        NSDictionary *bztDic = [self.yilouDic objectForKey:@"bzt"];//豹子遗漏
        NSInteger bztBig = 0;
        for (int i = 1; i <= 13; i ++) {
            NSDictionary *dic = [bztDic objectForKey:[NSString stringWithFormat:@"%d%d%d",i,i,i]];
            if (i == 1) {
                dic = [bztDic objectForKey:@"AAA"];
            }
            else if (i == 11) {
                dic = [bztDic objectForKey:@"JJJ"];
            }
            else if (i == 12) {
                dic = [bztDic objectForKey:@"QQQ"];
            }
            else if (i == 13) {
                dic = [dztDic objectForKey:@"KKK"];
            }
            if ([dic isKindOfClass:[NSDictionary class]]) {
                if (bztBig < [[dic valueForKey:@"yl"] integerValue]) {
                    bztBig = [[dic valueForKey:@"yl"] integerValue];
                }
            }
        }
        [[self.yilouDic objectForKey:@"bzt"] setValue:[NSString stringWithFormat:@"%d",(int)bztBig] forKey:@"theBig"];
        
        NSDictionary *sztDic = [self.yilouDic objectForKey:@"szt"];//顺子遗漏
        NSInteger sztBig = 0;
        for (int i = 1; i <= 12; i ++) {
            NSDictionary *dic = [sztDic objectForKey:[NSString stringWithFormat:@"%d%d%d",i,i+1,i+2]];
            if (i == 1) {
                dic = [sztDic objectForKey:@"A23"];
            }
            else if (i== 9) {
                dic = [sztDic objectForKey:@"910J"];
            }
            else if (i== 10) {
                dic = [sztDic objectForKey:@"10JQ"];
            }
            else if (i == 11) {
                dic = [sztDic objectForKey:@"JQK"];
            }
            else if (i == 12) {
                dic = [sztDic objectForKey:@"QKA"];
            }
            if ([sztDic isKindOfClass:[NSDictionary class]]) {
                if (sztBig < [[dic valueForKey:@"yl"] integerValue]) {
                    sztBig = [[dic valueForKey:@"yl"] integerValue];
                }
            }
        }
        [[self.yilouDic objectForKey:@"szt"] setValue:[NSString stringWithFormat:@"%d",(int)sztBig] forKey:@"theBig"];
        
        NSDictionary *tstDic = [self.yilouDic objectForKey:@"tst"];//同花顺遗漏
        NSInteger tstBig = 0;
        for (int i = 1; i <= 4; i ++) {
            NSDictionary *dic = [tstDic objectForKey:[NSString stringWithFormat:@"%d",i]];
            if ([tstDic isKindOfClass:[NSDictionary class]]) {
                if (tstBig < [[dic valueForKey:@"yl"] integerValue]) {
                    tstBig = [[dic valueForKey:@"yl"] integerValue];
                }
            }
        }
        
        [[self.yilouDic objectForKey:@"tst"] setValue:[NSString stringWithFormat:@"%d",(int)tstBig] forKey:@"theBig"];
        
        NSDictionary *thtDic = [self.yilouDic objectForKey:@"tst"];//同花顺遗漏
        NSInteger thtBig = 0;
        for (int i = 1; i <= 4; i ++) {
            NSDictionary *dic = [thtDic objectForKey:[NSString stringWithFormat:@"%d",i]];
            if ([dic isKindOfClass:[NSDictionary class]]) {
                if (thtBig < [[dic valueForKey:@"yl"] integerValue]) {
                    thtBig = [[dic valueForKey:@"yl"] integerValue];
                }
            }
        }
        
        [[self.yilouDic objectForKey:@"tst"] setValue:[NSString stringWithFormat:@"%d",(int)thtBig] forKey:@"theBig"];
        
        if (renXuanDic.count) {
            
            //删除旧的遗漏值
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOTTERY_ID];
            NSDictionary *yilouHuancunDic = [NSDictionary dictionaryWithObjectsAndKeys:yilouDic,self.issue, nil];
            [[NSUserDefaults standardUserDefaults] setValue:yilouHuancunDic forKey:LOTTERY_ID];
            
            hasYiLou = YES;
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
        if (issrecord) {
            
            NSArray *timearray = [issrecord.remainingTime componentsSeparatedByString:@":"];
            if ([timearray count] == 3) {
                seconds = 60*[[timearray objectAtIndex:1]intValue]+[[timearray objectAtIndex:2] intValue];
                if (seconds%2 == 1) {
                    seconds = seconds + 1;
                }
                //                timeLabel.text = [NSString stringWithFormat:@"%@",issrecord.curIssue];
                timeLabel.text = [NSString stringWithFormat:@"%@",[self getLastTwoStr:issrecord.curIssue]];
            }
            if (!shaizi1View) {
                shaizi1View = [[UIImageView alloc] initWithFrame:CGRectMake(80, -2, 30, 40)];
                [sqkaijiang addSubview:shaizi1View];
                UILabel *lab1 = [[UILabel alloc] init];
                lab1.frame = CGRectMake(2, 2, 15, 15);
                lab1.font = [UIFont fontWithName:@"TRENDS" size:10];
                lab1.backgroundColor = [UIColor clearColor];
                lab1.tag = 101;
                lab1.autoresizingMask = 111111;
                [shaizi1View addSubview:lab1];
                [lab1 release];
                [shaizi1View release];
                
                shaizi2View = [[UIImageView alloc] initWithFrame:CGRectMake(105, -2, 30, 40)];
                [sqkaijiang addSubview:shaizi2View];
                UILabel *lab2 = [[UILabel alloc] init];
                lab2.frame = CGRectMake(2, 2, 15, 15);
                lab2.backgroundColor = [UIColor clearColor];
                lab2.tag = 101;
                lab2.autoresizingMask = 111111;
                lab2.font = [UIFont fontWithName:@"TRENDS" size:10];
                [shaizi2View addSubview:lab2];
                [lab2 release];
                [shaizi2View release];
                
                shaizi3View = [[UIImageView alloc] initWithFrame:CGRectMake(130, -2, 30, 40)];
                [sqkaijiang addSubview:shaizi3View];
                UILabel *lab3 = [[UILabel alloc] init];
                lab3.frame = CGRectMake(2, 2, 15, 15);
                lab3.backgroundColor = [UIColor clearColor];
                lab3.tag = 101;
                lab3.autoresizingMask = 111111;
                lab3.font = [UIFont fontWithName:@"TRENDS" size:10];
                [shaizi3View addSubview:lab3];
                [lab3 release];
                [shaizi3View release];
            }
            
            NSArray *array1 = [issrecord.lastLotteryNumber componentsSeparatedByString:@"#"];
            if (!sqkaijiang.text) {
                if ([array1 count]) {
                    //                    sqkaijiang.text = [NSString stringWithFormat:@"%@期",[array1 objectAtIndex:0]];
                    NSString * str = [self getLastTwoStr:[array1 objectAtIndex:0]];
                    sqkaijiang.text = [NSString stringWithFormat:@"%@期开奖",str];
                }
                if ([array1 count] > 1) {
                    NSArray *numArray = [[array1 objectAtIndex:1] componentsSeparatedByString:@","];
                    if ([numArray count] >= 3) {
                        [self changeNumToShaiZi:numArray];
                    }
                }
                
            }
            else {
            }
            yanchiTime = [issrecord.lotteryStatus intValue];
            //            NSLog(@"%lld",[[array1 objectAtIndex:0] longLongValue]);
            
            if ([self.issue length] > 2 && ![self.issue isEqualToString:issrecord.curIssue] && isAppear) {
                NSString * shortIssue = [self.issue substringFromIndex:self.issue.length - 2];
                NSString * shortCurIssue = [issrecord.curIssue substringFromIndex:issrecord.curIssue.length - 2];
                
                NSLog(@"%@~~%@",shortIssue,shortCurIssue);
                NSLog(@"%@",[NSString stringWithFormat:@"%@已截止\n当前期%@",shortIssue,shortCurIssue]);
                
                CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"               <%@期已截止>\n当前期是%@期，投注时请注意期次",shortIssue,shortCurIssue] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.shouldRemoveWhenOtherAppear = YES;
                alert.alertTpye = jieQiType;
                [alert show];
                [alert release];
                
            }
            //            self.issue = [issrecord.curIssue substringFromIndex:issrecord.curIssue.length - 2];
            self.issue = issrecord.curIssue;
            
            if ([issrecord.curIssue longLongValue] - [[array1 objectAtIndex:0] longLongValue] >= 2 && [issrecord.curIssue longLongValue] - [[array1 objectAtIndex:0] longLongValue] <= 10) {
                isKaiJiang = NO;
                //                timeLabel.text = [NSString stringWithFormat:@"距%lld期开奖",[issrecord.curIssue longLongValue] - 1];
                NSString * str = [self getLastTwoStr:issrecord.curIssue];
                timeLabel.text = [NSString stringWithFormat:@"距%d期截止",(int)[str integerValue] - 1];
                
                if (canRefreshYiLou) {
                    self.yilouDic = nil;
                    [self changeTitle];
                    hasYiLou = NO;
                }

            }
            else {
                isKaiJiang = YES;
                
                if (![self.myIssrecord.curIssue isEqualToString:issrecord.curIssue]) {
                    [self getYilou];
                }else if (!hasYiLou && canRefreshYiLou) {
                    [self getYilou];
                }
                canRefreshYiLou = YES;
                
            }
            self.myIssrecord = issrecord;

            
            NSString * str = [self getLastTwoStr:issrecord.curIssue];
            timeLabel.text = [NSString stringWithFormat:@"距%@期截止",str];

            [self performSelectorInBackground:@selector(createTimer) withObject:nil];
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

-(NSString *)getLastTwoStr:(NSString *)str
{
    if ([str length] > 2) {
        return [str substringFromIndex:str.length - 2];
    }
    return @"";
}

#pragma mark -
#pragma mark UITableViewDataSource

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (tableView == _cpTableView) {
//        UIView *v = [[[UIView alloc] init] autorelease];
//        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
//        label1.text = @"期号";
//        label1.font = [UIFont boldSystemFontOfSize:14];
//        label1.textColor = [UIColor whiteColor];
//        label1.backgroundColor = [UIColor clearColor];
//        label1.textAlignment = NSTextAlignmentCenter;
//        [v addSubview:label1];
//        [label1 release];
//
//        CP_PTButton *backBtn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//        [v addSubview:backBtn];
//        [backBtn loadButonImage:@"QHWZBG960.png" LabelName:@"历史开奖"];
//        backBtn.buttonName.textColor = [UIColor blackColor];
//        backBtn.buttonName.shadowColor = [UIColor clearColor];
//        backBtn.frame = CGRectMake(83, 2, 128, 30);
//        [backBtn addTarget:self action:@selector(goHistory) forControlEvents:UIControlEventTouchUpInside];
//
//        CP_PTButton *backBtn2 = [CP_PTButton buttonWithType:UIButtonTypeCustom];
//        [v addSubview:backBtn2];
//        [backBtn2 loadButonImage:@"QHWZBG960.png" LabelName:@"图\n表"];
//        backBtn2.buttonName.numberOfLines = 0;
//        backBtn2.buttonName.font = [UIFont systemFontOfSize:10];
//        backBtn2.buttonName.textAlignment = NSTextAlignmentRight;
//        backBtn2.buttonName.textColor = [UIColor blackColor];
//        backBtn2.buttonName.shadowColor = [UIColor clearColor];
//        UIImageView *imagV = [[UIImageView alloc] initWithFrame: CGRectMake(5, 5, 20, 20)];
//        backBtn2.otherImage = imagV;
//        backBtn2.otherImage.image = UIImageGetImageFromName(@"zoushitu.png");
//        [imagV release];
//        backBtn2.frame = CGRectMake(216, 2, 40, 30);
//        backBtn2.buttonName.frame = CGRectMake(0, 0, 37, 30);
//        [backBtn2 addTarget:self action:@selector(gofenxi) forControlEvents:UIControlEventTouchUpInside];
//
//        v.backgroundColor = [UIColor colorWithRed:33/255.0 green:100/255.0 blue:151/255.0 alpha:1.0];
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(80, 0 , 1, 35)];
//        [v addSubview:line];
//        line.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
//        [line release];
//        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 34 , 260, 1)];
//        [v addSubview:line2];
//        line2.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
//        [line2 release];
//        return v;
//    }
//    return nil;
//}

//- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
////    if (tableView == _cpTableView) {
////        return 35;
////    }
//    return 0;
//
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.wangQi.brInforArray count];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 35;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
////    if (tableView == _cpTableView) {
////        static NSString *CellIdentifier = @"Cell1";
////        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
////        if (!cell) {
////            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
////            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
////
////            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
////            label1.font = [UIFont systemFontOfSize:13];
////            label1.backgroundColor = [UIColor colorWithRed:33/255.0 green:100/255.0 blue:151/255.0 alpha:1.0];
////            label1.tag = 101;
////            label1.textAlignment = NSTextAlignmentCenter;
////            label1.textColor = [UIColor whiteColor];
////            [cell.contentView addSubview:label1];
////            [label1 release];
////
////            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 180, 35)];
////            label2.font = [UIFont systemFontOfSize:13];
////            label2.textColor = [UIColor whiteColor];
////            label2.tag = 102;
////            label2.backgroundColor = [UIColor colorWithRed:67/255.0 green:144/255.0 blue:186/255.0 alpha:1.0];
////            [cell.contentView addSubview:label2];
////            label2.textAlignment = NSTextAlignmentCenter;
////            [label2 release];
////
////            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(80, 0 , 1, 35)];
////            [cell.contentView addSubview:line];
////            line.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
////            [line release];
////
////            UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , 260, 1)];
////            [cell.contentView addSubview:line2];
////            line2.backgroundColor = [UIColor colorWithRed:99/255.0 green:180/255.0 blue:224/255.0 alpha:1.0];
////            [line2 release];
////            cell.contentView.backgroundColor = [UIColor clearColor];
////            
////        }
////        
////        UILabel *l1 = (UILabel *)[cell.contentView viewWithTag:101];
////        UILabel *l2 = (UILabel *)[cell.contentView viewWithTag:102];
////        KaiJiangInfo *info = [self.wangQi.brInforArray objectAtIndex:indexPath.row];
////        l1.text = info.issue;
////        NSArray *array = [info.num componentsSeparatedByString:@","];
////        if ([array count] >= 3) {
////            NSString *daxiao = @"";
////            NSString *danshuang = @"";
////            int a= [[array objectAtIndex:0] integerValue];
////            int b= [[array objectAtIndex:1] integerValue];
////            int c= [[array objectAtIndex:2] integerValue];
////            if (a + b + c > 11) {
////                daxiao = @"大";
////            }
////            else {
////                daxiao = @"小";
////            }
////            if ((a + b + c) % 2 == 0) {
////                danshuang = @"双";
////            }
////            else {
////                danshuang = @"单";
////            }
////            l2.text = [NSString stringWithFormat:@"%@  和值:%d  %@  %@",info.num, a+b+c,daxiao,danshuang];
////        }
////        else {
////            l2.text = info.num;
////        }
////        
////        return  cell;
////        
////    }
//    
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//	if (!cell) {
//		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
//		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        
//        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 33)];
//        label1.font = [UIFont systemFontOfSize:13];
//        label1.backgroundColor = [UIColor clearColor];
//        label1.tag = 101;
//        [cell.contentView addSubview:label1];
//        [label1 release];
//        
//        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 100, 33)];
//        label2.font = [UIFont systemFontOfSize:13];
//        label2.textColor = [UIColor redColor];
//        label2.tag = 102;
//        label2.backgroundColor = [UIColor clearColor];
//        label2.textAlignment = NSTextAlignmentCenter;
//        [cell.contentView addSubview:label2];
//        [label2 release];
//        
//        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 100, 33)];
//        label3.font = [UIFont systemFontOfSize:13];
//        label3.textColor = [UIColor blueColor];
//        label3.tag = 103;
//        label3.backgroundColor = [UIColor clearColor];
//        label3.textAlignment = NSTextAlignmentCenter;
//        [cell.contentView addSubview:label3];
//        [label3 release];
//        
//        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(1, 33, 254, 2)];
//        imageV.image = UIImageGetImageFromName(@"SZTG960.png");
//        [cell.contentView addSubview:imageV];
//        cell.backgroundColor = [UIColor clearColor];
//        [imageV release];
//        
//	}
//    UILabel *l1 = (UILabel *)[cell.contentView viewWithTag:101];
//    UILabel *l2 = (UILabel *)[cell.contentView viewWithTag:102];
//    UILabel *l3 = (UILabel *)[cell.contentView viewWithTag:103];
//    KaiJiangInfo *info = [self.wangQi.brInforArray objectAtIndex:indexPath.row];
//    l1.text = info.issue;
//    if ([[info.kaijiangTime componentsSeparatedByString:@" "] count] > 1) {
//        l2.text = [[info.kaijiangTime componentsSeparatedByString:@" "] objectAtIndex:1];
//    }
//    l3.text = [info.num stringByReplacingOccurrencesOfString:@"," withString:@" "];
//    return  cell;
//}

//-(void)addYiLouTextOnView:(UIView *)view typeStr:(NSString *)typeStr
//{
//    NSArray * numberArr =[self.yilouDic objectForKey:typeStr];
//    NSString * maxNum = @"111";
//    if (numberArr.count != 0) {
//        for (GCBallView *ball in view.subviews) {
//            if ([ball isKindOfClass:[GCBallView class]]) {
//                ball.ylLable.text = [NSString stringWithFormat:@"%@",[numberArr objectAtIndex:ball.tag - 1]];
//                if ([maxNum isEqualToString:ball.ylLable.text]) {
//                    ball.ylLable.textColor = [UIColor yellowColor];
//                }
//                else {
//                    ball.ylLable.textColor = [UIColor colorWithRed:97/255.0 green:161/255.0 blue:184/255.0 alpha:1];
//                }
//            }
//        }
//    }
//}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    