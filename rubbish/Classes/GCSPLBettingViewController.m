//
//  BettingViewController.m
//  caibo
//
//  Created by yao on 12-4-11.
//  Copyright 2012 第一视频. All rights reserved.
//

#import "GCSPLBettingViewController.h"
#import "GC_BetInfo.h"
#import "GC_IssueInfo.h"
#import "GC_IssueList.h"
#import "GC_HttpService.h"
#import "GC_ASIHTTPRequest+Header.h"
#import "GC_FootballMatch.h"
#import "caiboAppDelegate.h"
#import "NewAroundViewController.h"
#import "GC_ShengfuInfoViewController.h"
#import "GC_LotteryUtil.h"
#import "GC_ExplainViewController.h"
#import "NetURL.h"
#import "Info.h"
#import "TopicThemeListViewController.h"
#import "NSStringExtra.h"
#import "Xieyi365ViewController.h"
#import "GCHeMaiInfoViewController.h"
#import "GuoGuanViewController.h"

//投注界面
@implementation GCSPLBettingViewController
@synthesize request;
@synthesize betArray;
@synthesize dataArray;
@synthesize httpRequest;
@synthesize matchList;
@synthesize issueDetails;
@synthesize bettingstype;
@synthesize issString;
@synthesize issueFuWu;
@synthesize jiezhistring;
- (void)NewAroundViewShowFunc:(GC_BetData *)betdata indexPath:(NSIndexPath *)indexPath{//八方预测
    
    FootballForecastViewController * forecast = [[FootballForecastViewController alloc] init];
    forecast.delegate =self;
    forecast.lotteryType = shengfucaitype;
    forecast.betData = betdata;
    forecast.gcIndexPath = indexPath;
    if (castButton.enabled == NO) {
        forecast.matchShowType = fjieqiType;
    }else{
        if ([betdata.zlcString rangeOfString:@"-"].location != NSNotFound) {
            
            if ([betdata.zlcString rangeOfString:@"True"].location != NSNotFound) {
                forecast.matchShowType = fzhonglichangType;
            }else{
                forecast.matchShowType = fjiaohuanType;
            }
            
        }else{
            
            forecast.matchShowType = fsfcshengpingfuType;
            
        }
        
    }
    
    
    
    [self.navigationController pushViewController:forecast animated:YES];
    [forecast release];
    
}
#pragma mark -
#pragma mark Initialization


- (NSString *)objectKeyStringSaveDuiZhen{//生成钥匙
    NSString * keystring = @"";
    if (bettingstype == bettingStypeRenjiu) {
        keystring = [NSString stringWithFormat:@"301%@DZ", issString];//@"301";
    }else   if (bettingstype == bettingStypeShisichang) {
        keystring = [NSString stringWithFormat:@"300%@DZ", issString];//@"300";
    }
    
    return keystring;
}

- (NSString *)objectKeyStringSaveHuanCun{//生成钥匙
    NSString * keystring = @"";
    if (bettingstype == bettingStypeRenjiu) {
        keystring = [NSString stringWithFormat:@"301%@HC", issString];//@"301";
    }else   if (bettingstype == bettingStypeShisichang) {
        keystring = [NSString stringWithFormat:@"300%@HC", issString];//@"300";
    }
    
    return keystring;
}

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/
- (void)stopTimeUpData{
    
    if (bettingstype == bettingStypeRenjiu) {
        
        BOOL danYN = NO;
        for (int i = 0; i < [bettingArray count]; i++) {
            GC_BetData * bet = [bettingArray objectAtIndex:i];
            if (bet.dandan) {
                danYN = YES;
                break;
            }
        }
        
        NSInteger xcont = 0;
        for (int i = 0; i < [ issueTypeArray count]; i++) {
            IssueDetail * detail = [issueTypeArray objectAtIndex:i];
            if ([detail.issue isEqualToString:issString]) {
                xcont = i;
                break;
            }
        }
        IssueDetail * isdetail = [issueTypeArray objectAtIndex:xcont];
        
        
        if (one == 14) {
            
            jiezhistring = isdetail.stopTime;
           jiezhilabel.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
        }else if (danYN){
            
            jiezhistring = isdetail.danTuoTime;
            jiezhilabel.textColor = [UIColor redColor];
            
        }else {
            
            jiezhistring = isdetail.stopTime;
           jiezhilabel.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
        }
        
        NSArray * zongArr = [jiezhistring componentsSeparatedByString:@" "];
        if (zongArr.count < 2) {
            zongArr = [NSArray arrayWithObjects:@"- -",@":", nil];
        }
        NSArray * nianArr = [[zongArr objectAtIndex:0] componentsSeparatedByString:@"-"];
        if (nianArr.count < 3) {
            nianArr = [NSArray arrayWithObjects:@"",@"",@"", nil];
        }
        NSArray * shiArr = [[zongArr objectAtIndex:1] componentsSeparatedByString:@":"];
        if (shiArr.count < 2) {
            shiArr = [NSArray arrayWithObjects:@"",@"", nil];
        }
        
        NSString * stringText = [NSString stringWithFormat:@"%@期截止 %@月%@日 %@:%@", issString, [nianArr objectAtIndex:1], [nianArr objectAtIndex:2], [shiArr objectAtIndex:0], [shiArr objectAtIndex:1]];
        
        jiezhilabel.text = stringText;
        
    }else{
        
        NSInteger xcont = 0;
        for (int i = 0; i < [ issueTypeArray count]; i++) {
            IssueDetail * detail = [issueTypeArray objectAtIndex:i];
            if ([detail.issue isEqualToString:issString]) {
                xcont = i;
                break;
            }
        }
        IssueDetail * isdetail = [issueTypeArray objectAtIndex:xcont];
        
        
        
        jiezhistring = isdetail.stopTime;
        jiezhilabel.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
        
        
        NSArray * zongArr = [jiezhistring componentsSeparatedByString:@" "];
        if (zongArr.count < 2) {
            zongArr = [NSArray arrayWithObjects:@"- -",@":", nil];
        }
        NSArray * nianArr = [[zongArr objectAtIndex:0] componentsSeparatedByString:@"-"];
        if (nianArr.count < 3) {
            nianArr = [NSArray arrayWithObjects:@"",@"",@"", nil];
        }
        NSArray * shiArr = [[zongArr objectAtIndex:1] componentsSeparatedByString:@":"];
        if (shiArr.count < 2) {
            shiArr = [NSArray arrayWithObjects:@"",@"", nil];
        }

       
        
        NSString * stringText = [NSString stringWithFormat:@"%@期截止 %@月%@日 %@:%@", issString, [nianArr objectAtIndex:1], [nianArr objectAtIndex:2], [shiArr objectAtIndex:0], [shiArr objectAtIndex:1]];
        
        jiezhilabel.text = stringText;
    }
    
}

- (void)doBack{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[caiboAppDelegate getAppDelegate] showInSencondView:nil ViewControllor:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
  //  self.title = @"pk赛投注";
    countjishuqi = 0;
    staArray = [[NSMutableArray alloc] initWithCapacity:0];
     ContentOffDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    issueTypeArray = [[NSMutableArray alloc] initWithCapacity:0];
      kongzhiType = [[NSMutableArray alloc] initWithCapacity:0];
    UIImageView * bg = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
//    bg.image= UIImageGetImageFromName(@"bdbgimage.png");
    bg.backgroundColor = [UIColor colorWithRed:246/255.0 green:243/255.0 blue:228/255.0 alpha:1];
    [self.mainView addSubview:bg];
    [bg release];

    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardNotification:) 
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardNotification:) 
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    betInfo = [[GC_BetInfo alloc] init];
    issueArray = [[NSMutableArray alloc] initWithCapacity:0];
    bettingArray = [[NSMutableArray alloc] initWithCapacity:0];
	UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
	
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];

    
    myTableView = [[CP_CanOpenTableView alloc] initWithFrame:CGRectMake(0, 28, 320, self.mainView.bounds.size.height - 83-28) style:UITableViewStylePlain];
 //   myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:myTableView];
    
    [self tabBarView];//下面长方块view 确定投注的view
    

    oneLabel.text = [NSString stringWithFormat:@"%d", one];
    twoLabel.text = [NSString stringWithFormat:@"%d", two];
    [self getIssueListRequest];
    //
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, 260, 44)];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 34)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];//阴影
//    titleLabel.shadowOffset = CGSizeMake(0, 1.0);
    
    UIButton * titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(10, 5, 180, 34);
    [titleButton addTarget:self action:@selector(pressTitleButton:) forControlEvents:UIControlEventTouchUpInside];

        titleButton.enabled = YES;

    [titleButton addSubview:titleLabel];
//    sanjiaolabel = [[UILabel alloc] init];
//    sanjiaolabel.backgroundColor = [UIColor clearColor];
//    sanjiaolabel.textAlignment = NSTextAlignmentCenter;
//    sanjiaolabel.font = [UIFont systemFontOfSize:14];
//    sanjiaolabel.text = @"▼";
//    sanjiaolabel.textColor = [UIColor whiteColor];
//    sanjiaolabel.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];//阴影
//    sanjiaolabel.shadowOffset = CGSizeMake(0, 1.0);
//    [titleButton addSubview:sanjiaolabel];
//    [sanjiaolabel release];
    
    [titleView addSubview:titleButton];
    
    sanjiaoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]];
    [titleButton addSubview:sanjiaoImageView];
    
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width + 3, 9, 17, 17);
    
    //玩法等按钮菜单
//    UIButton *titleButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    titleButton2.frame = CGRectMake(210, 5, 50, 44);
//    titleButton2.backgroundColor = [UIColor clearColor];
//    [titleButton2 addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
//    UIImageView *butbg2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 23, 23)];
//    butbg2.image = UIImageGetImageFromName(@"GCIZL-960.png");
//    [titleButton2 addSubview:butbg2];
//    [butbg2 release];
//    [titleView addSubview:titleButton2];
    
    self.CP_navigation.titleView = titleView;
    [titleView release];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(20, 0, 40, 44);
    
//        [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
        [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.png") forState:UIControlStateHighlighted];

        [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
        //        butbg2.image = UIImageGetImageFromName(@"GCIZL-960.png");
    
//    [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
    txtImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.mainView.bounds.size.height-81, 320, 44)];
    txtImage.image = UIImageGetImageFromName(@"gc_titBg7.png");
    txtImage.backgroundColor = [UIColor clearColor];
    
    fbTextView = [[UITextField alloc] initWithFrame:CGRectMake(20, self.mainView.bounds.size.height-76, 280, 30)];
    fbTextView.borderStyle = UITextBorderStyleRoundedRect;
    fbTextView.delegate = self;
    [fbTextView setReturnKeyType:UIReturnKeyDone];
   fbTextView.placeholder = @"写预测";
    [self.mainView addSubview:txtImage];
    [self.mainView addSubview:fbTextView];
    
    [fbTextView becomeFirstResponder];
    [fbTextView resignFirstResponder];
    
//    UIImageView *  upimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 26)];
////    upimageview.backgroundColor = [UIColor clearColor];
////    upimageview.image = UIImageGetImageFromName(@"zucaititleimage.png");
//     upimageview.backgroundColor = [UIColor colorWithRed:16/255.0 green:95/255.0 blue:180/255.0 alpha:1];
//    [self.mainView addSubview:upimageview];
//    [upimageview release];
//    
//    UILabel * saishila = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 59, 26)];
//    saishila.backgroundColor = [UIColor clearColor];
//    saishila.font = [UIFont systemFontOfSize:13];
//    saishila.textColor = [UIColor whiteColor];
//    saishila.textAlignment = NSTextAlignmentCenter;
//    saishila.text = @"赛事";
//    [upimageview addSubview:saishila];
//    [saishila release];
//    
//    
//    UIImageView * shuimage = [[UIImageView alloc] initWithFrame:CGRectMake(59, 6, 1, 14)];
//    shuimage.backgroundColor = [UIColor whiteColor];
//    [upimageview addSubview:shuimage];
//    [shuimage release];
//    
//    UILabel * shengla = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 89, 26)];
//    shengla.backgroundColor = [UIColor clearColor];
//    shengla.font = [UIFont systemFontOfSize:13];
//    shengla.textColor = [UIColor whiteColor];
//    shengla.textAlignment = NSTextAlignmentCenter;
//    shengla.text = @"3";
//    [upimageview addSubview:shengla];
//    [shengla release];
//    
//    UIImageView * shuimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(149, 6, 1, 15)];
//    shuimage2.backgroundColor = [UIColor whiteColor];
//    [upimageview addSubview:shuimage2];
//    [shuimage2 release];
//    
//    UILabel * pingla = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 68, 26)];
//    pingla.backgroundColor = [UIColor clearColor];
//    pingla.font = [UIFont systemFontOfSize:13];
//    pingla.textColor = [UIColor whiteColor];
//    pingla.textAlignment = NSTextAlignmentCenter;
//    pingla.text = @"1";
//    [upimageview addSubview:pingla];
//    [pingla release];
//    
//    UIImageView * shuimage3 = [[UIImageView alloc] initWithFrame:CGRectMake(218, 6, 1, 14)];
//    shuimage3.backgroundColor = [UIColor whiteColor];
//    [upimageview addSubview:shuimage3];
//    [shuimage3 release];
//    
//    UILabel * fula = [[UILabel alloc] initWithFrame:CGRectMake(219, 0, 320-229, 26)];
//    fula.backgroundColor = [UIColor clearColor];
//    fula.font = [UIFont systemFontOfSize:13];
//    fula.textColor = [UIColor whiteColor];
//    fula.textAlignment = NSTextAlignmentCenter;
//    fula.text = @"0";
//    [upimageview addSubview:fula];
//    [fula release];
    
    
        
    
    titleJieqi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 52)];
    titleJieqi.backgroundColor = [UIColor colorWithRed:10/255.0 green:117/255.0 blue:193/255.0 alpha:1];
    
    
    jiezhilabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, 320, 20)];
    jiezhilabel.font = [UIFont systemFontOfSize:15];
    jiezhilabel.textAlignment = NSTextAlignmentCenter;
    jiezhilabel.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    jiezhilabel.backgroundColor = [UIColor clearColor];
    jiezhilabel.text = jiezhistring;
    [titleJieqi addSubview:jiezhilabel];
    [jiezhilabel release];
    
    
    
    UILabel * numlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    numlabel.font = [UIFont systemFontOfSize:17];
    numlabel.textAlignment = NSTextAlignmentCenter;
    numlabel.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    numlabel.backgroundColor = [UIColor clearColor];
    numlabel.text = @"3";
    [titleJieqi addSubview:numlabel];
    [numlabel release];
    
    UILabel * zhulabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    zhulabel.font = [UIFont systemFontOfSize:12];
    zhulabel.textAlignment = NSTextAlignmentCenter;
    zhulabel.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    zhulabel.backgroundColor = [UIColor clearColor];
    zhulabel.text = @"主队胜";
    [titleJieqi addSubview:zhulabel];
    [zhulabel release];
    
    
    CGSize oneSize = [numlabel.text sizeWithFont:numlabel.font constrainedToSize:CGSizeMake(82, 20) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize twoSize = [zhulabel.text sizeWithFont:zhulabel.font constrainedToSize:CGSizeMake(82, 20) lineBreakMode:NSLineBreakByWordWrapping];
    numlabel.frame = CGRectMake(10+(82 - oneSize.width - twoSize.width - 3)/2, 29, oneSize.width, 20);
    zhulabel.frame = CGRectMake(numlabel.frame.origin.x + numlabel.frame.size.width+3, 30, twoSize.width, 20);
    
    
    UIImageView * shuimage1 = [[UIImageView alloc] initWithFrame:CGRectMake(92, 30, 0.5, 17)];
    shuimage1.backgroundColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    [titleJieqi addSubview:shuimage1];
    [shuimage1 release];
    
    
    
    UILabel * numlabeltwo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    numlabeltwo.font = [UIFont systemFontOfSize:17];
    numlabeltwo.textAlignment = NSTextAlignmentCenter;
    numlabeltwo.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    numlabeltwo.backgroundColor = [UIColor clearColor];
    numlabeltwo.text = @"1";
    [titleJieqi addSubview:numlabeltwo];
    [numlabeltwo release];
    
    UILabel * zhulabeltwo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    zhulabeltwo.font = [UIFont systemFontOfSize:12];
    zhulabeltwo.textAlignment = NSTextAlignmentCenter;
    zhulabeltwo.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    zhulabeltwo.backgroundColor = [UIColor clearColor];
    zhulabeltwo.text = @"两队平";
    [titleJieqi addSubview:zhulabeltwo];
    [zhulabeltwo release];
    
    
    CGSize oneSizetwo = [numlabeltwo.text sizeWithFont:numlabeltwo.font constrainedToSize:CGSizeMake(82, 20) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize twoSizetwo = [zhulabeltwo.text sizeWithFont:zhulabeltwo.font constrainedToSize:CGSizeMake(82, 20) lineBreakMode:NSLineBreakByWordWrapping];
    numlabeltwo.frame = CGRectMake(92+(82 - oneSizetwo.width - twoSizetwo.width - 3)/2, 29, oneSizetwo.width, 20);
    zhulabeltwo.frame = CGRectMake(numlabeltwo.frame.origin.x + numlabeltwo.frame.size.width+3, 30, twoSizetwo.width, 20);
    
    
    UIImageView * shuimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(174, 30, 0.5, 17)];
    shuimage2.backgroundColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    [titleJieqi addSubview:shuimage2];
    [shuimage2 release];
    
    
    UILabel * numlabelthree = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    numlabelthree.font = [UIFont systemFontOfSize:17];
    numlabelthree.textAlignment = NSTextAlignmentCenter;
    numlabelthree.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    numlabelthree.backgroundColor = [UIColor clearColor];
    numlabelthree.text = @"0";
    [titleJieqi addSubview:numlabelthree];
    [numlabelthree release];
    
    UILabel * zhulabelthree = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    zhulabelthree.font = [UIFont systemFontOfSize:12];
    zhulabelthree.textAlignment = NSTextAlignmentCenter;
    zhulabelthree.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    zhulabelthree.backgroundColor = [UIColor clearColor];
    zhulabelthree.text = @"主队负";
    [titleJieqi addSubview:zhulabelthree];
    [zhulabelthree release];
    
    
    CGSize oneSizethree = [numlabelthree.text sizeWithFont:numlabelthree.font constrainedToSize:CGSizeMake(82, 20) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize twoSizethree = [zhulabelthree.text sizeWithFont:zhulabelthree.font constrainedToSize:CGSizeMake(82, 20) lineBreakMode:NSLineBreakByWordWrapping];
    numlabelthree.frame = CGRectMake(174+(82 - oneSizethree.width - twoSizethree.width - 3)/2, 29, oneSizethree.width, 20);
    zhulabelthree.frame = CGRectMake(numlabelthree.frame.origin.x + numlabelthree.frame.size.width+3, 30, twoSizethree.width, 20);
    
    
    UIImageView * shuimage3 = [[UIImageView alloc] initWithFrame:CGRectMake(174+82, 30, 0.5, 17)];
    shuimage3.backgroundColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    [titleJieqi addSubview:shuimage3];
    [shuimage3 release];
    
    UILabel * zhulabelfour = [[UILabel alloc] initWithFrame:CGRectMake(174+82, 30, 54, 20)];
    zhulabelfour.font = [UIFont systemFontOfSize:12];
    zhulabelfour.textAlignment = NSTextAlignmentCenter;
    zhulabelfour.textColor = [UIColor colorWithRed:66/255.0 green:165/255.0 blue:236/255.0 alpha:1];
    zhulabelfour.backgroundColor = [UIColor clearColor];
    zhulabelfour.text = @"分析";
    [titleJieqi addSubview:zhulabelfour];
    [zhulabelfour release];
    
    [self.mainView addSubview:titleJieqi];
    [titleJieqi release];
        
    myTableView.frame = CGRectMake(0, 52, 320, self.mainView.bounds.size.height - 83-52);
        


    
}
- (void)otherLottoryViewController:(NSInteger)indexd title:(NSString *)titleStr lotteryType:(NSInteger)lotype lotteryId:(NSString *)loid{
    if ([[[Info getInstance] userId] intValue] == 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
        return;
    }
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
    
    tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    tabc.selectedIndex = indexd;
    tabc.delegateCP = self;
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
//菜单按钮
- (void)pressMenubutton:(UIButton *)sender{
    
    NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
    //    [allimage addObject:@"15.png"];
    [allimage addObject:@"shijianxuanzhe.png"];
    [allimage addObject:@"menuggtj.png"];
//    [allimage addObject:@"menuhmdt.png"];
    [allimage addObject:@"GC_sanjiShuoming.png"];
    
    NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
    //    [alltitle addObject:@"联赛筛选"];
    [alltitle addObject:@"期号选择"];
    [alltitle addObject:@"中奖排行"];
//    [alltitle addObject:@"合买大厅"];
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
- (void)ggOtherLottoryViewController:(NSInteger)indexd renjiuOrshengfu:(renJiuOrShengFu)rensheng{
    if ([[[Info getInstance] userId] intValue] == 0) {
        [[caiboAppDelegate getAppDelegate] showMessage:@"登录后可用"];
        return;
    }
    GuoGuanViewController *my = [[GuoGuanViewController alloc] init];
    my.ggType = shengFuCaiType;
    
    GuoGuanViewController *my2 = [[GuoGuanViewController alloc] init];
    my2.ggType = renXuanJiuType;
    
    GuoGuanViewController * my3 = [[GuoGuanViewController alloc] init];
    my3.ggType = WoDeGuoGuanType;
    my3.renorsheng = rensheng;
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:my, my2, my3, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"胜负彩"];
    [labearr addObject:@"任选9"];
    [labearr addObject:@"我的中奖"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"ggssc.png"];
    [imagestring addObject:@"ggrxq.png"];
    [imagestring addObject:@"ggwdcp.png"];
    
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"ggssc_1.png"];
    [imageg addObject:@"ggrxq_1.png"];
    [imageg addObject:@"ggwdcp_1.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    tabc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    tabc.selectedIndex = indexd;
    tabc.delegateCP = self;
    // tabc.backgroundImage.image = [UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    [self.navigationController pushViewController:tabc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [tabc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [my2 release];
    [my3 release];
    [my release];
}

- (void)returnSelectIndex:(NSInteger)index{
    if(index == 0){
        
        [self pressTitleButton:nil];
        
    }else if(index == 2){
        [self pressHelpButton:nil];
    }else if(index == 1){
        if (bettingstype == bettingStypeShisichang) {
            [self ggOtherLottoryViewController:0 renjiuOrshengfu:shengfu];
        }else{
            [self ggOtherLottoryViewController:1 renjiuOrshengfu:renjiu];
        }
    }
//    else if(index == 2){
//        if (bettingstype == bettingStypeShisichang) {
//            [self otherLottoryViewController:0 title:@"胜负彩合买" lotteryType:13 lotteryId:@"300"];
//        }else{
//            [self otherLottoryViewController:0 title:@"任选九合买" lotteryType:14 lotteryId:@"301"];
//        }
//    }
}

- (void)keyboardNotification:(NSNotification *)notification {
    if ([[notification name] isEqualToString:UIKeyboardWillShowNotification]) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             //       [self.view setFrame:CGRectMake(0, -216, 320, 460)];
                             
                             NSValue * kvalue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
                             CGSize keysize = [kvalue CGRectValue].size;
//
                             txtImage.frame = CGRectMake(0, self.mainView.frame.size.height - keysize.height - 37, 320, 44);
                             fbTextView.frame = CGRectMake(20, self.mainView.frame.size.height - keysize.height - 32, 280, 30);
                             
                             NSInteger xcont = 0;
                             for (int i = 0; i < [ issueTypeArray count]; i++) {
                                 IssueDetail * detail = [issueTypeArray objectAtIndex:i];
                                 if ([detail.issue isEqualToString:issString]) {
                                     xcont = i;
                                     break;
                                 }
                             }
                             IssueDetail * isdetail = [issueTypeArray objectAtIndex:xcont];
                             if ([isdetail.status isEqualToString:@"1"]) {
                                 jiezhilabel.hidden = NO;
                              
                             }else{
                                 jiezhilabel.hidden = YES;
                                 
                             }
                             
                             
                         } completion:NULL];
    } else {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseInOut 
                         animations:^{
                             //            [self.view setFrame:CGRectMake(0, 0, 320, 460)];
//
                             txtImage.frame = CGRectMake(0, self.mainView.frame.size.height - 81, 320, 44);
                             fbTextView.frame = CGRectMake(20, self.mainView.frame.size.height - 76, 280, 30);
                             //    txtImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 337, 320, 44)];
                             NSInteger xcont = 0;
                             for (int i = 0; i < [ issueTypeArray count]; i++) {
                                 IssueDetail * detail = [issueTypeArray objectAtIndex:i];
                                 if ([detail.issue isEqualToString:issString]) {
                                     xcont = i;
                                     break;
                                 }
                             }
                             IssueDetail * isdetail = [issueTypeArray objectAtIndex:xcont];
                             if ([isdetail.status isEqualToString:@"1"]) {
                              
                                 jiezhilabel.hidden = NO;
                             }else{
                                 jiezhilabel.hidden = YES;
                             }

                             
                         } completion:NULL];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{ 
    
    
    
    [textField resignFirstResponder]; 
    
    return YES;
    
}
- (void) keyboardWillDisapper:(id)sender
{
    //[self.mMessage setSelectedRange:NSMakeRange(0, 0)];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        
    [UIView beginAnimations:nil context:nil];  
    [UIView setAnimationDuration:0.3f];  
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    self.mainView.frame = CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height -20);
    [UIView commitAnimations];  
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisapper:) name:UIKeyboardWillHideNotification object:nil];
    
    
}
//- (void) keyboardWillShow:(id)sender
//{
//	//[self.mMessage setSelectedRange:NSMakeRange(0, 0)];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    CGRect keybordFrame;
//    [[[((NSNotification *)sender) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keybordFrame];
//    //   CGFloat keybordHeight = CGRectGetHeight(keybordFrame);
//    
//    //  self.view.frame = frame;  
//    [UIView beginAnimations:nil context:nil];  
//    [UIView setAnimationDuration:0.3f]; 
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    self.mainView.frame = CGRectMake(0, -216, 320, [UIScreen mainScreen].bounds.size.height -20);
//    [UIView commitAnimations];
//    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//}  


//选择期数的ui
- (void)pressTitleButton:(UIButton *)sender{
    
    NSMutableArray * array = [NSMutableArray array];
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"期号",@"title", issueArray,@"choose", nil];
    
    
    if ([kongzhiType count] == 0) {
        NSMutableArray * issarr = [NSMutableArray array];
        for (int i = 0; i < [issueArray count]; i++) {
            NSString * str = [issueArray objectAtIndex:i];
            if ([str isEqualToString:issString]) {
                [issarr addObject:@"1"];
            }else{
                [issarr addObject:@"0"];
            }
            
        }
        
        NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"期号",@"title",issarr,@"choose", nil];
        
        [kongzhiType addObject:type1];
        
    }
    
    
    [array addObject:dic];
    
    
    
    CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"期号选择" ChangCiTitle:@"" DataInfo:array kongtype:kongzhiType];
    alert2.delegate = self;
    alert2.tag = 20;
    [alert2 show];
    [alert2 release];
    
    
}

//九宫格按钮
- (void)pressjiugongge:(UIButton *)sender{
    if (sender.tag > [issueArray count]) {
        return;
    }
 //   if (but[sender.tag] == 0) {
        UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
        image.hidden = NO;
        UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
        imagebg.image = UIImageGetImageFromName(@"gc_hover.png");
     //   sender.backgroundColor  = [UIColor blueColor];
        but[sender.tag] = 1;
        for (int i = 1; i < 13; i++) {
            if (i == sender.tag) {
                continue;
            }
//             UIButton * vi = (UIButton *)[imgev viewWithTag:i];
//            vi.enabled = NO;
        }
         [self performSelector:@selector(pressBgButton:) withObject:nil afterDelay:.0];
//    }else{
//        for (int i = 1; i < 13; i++) {
//           
//            UIButton * vi = (UIButton *)[imgev viewWithTag:i];
//            vi.enabled = YES;
//        }
//        UIImageView * image = (UIImageView *)[sender viewWithTag:sender.tag * 10];
//        image.hidden = YES;
//        UIImageView * imagebg = (UIImageView *)[sender viewWithTag:sender.tag * 100];
//        imagebg.image = nil;
//      //  sender.backgroundColor = [UIColor whiteColor];
//        but[sender.tag] = 0;
//    }
    
}
//选择期数 和背景点击消失
- (void)pressBgButton:(UIButton *)sender{
    
    int n;
    for (int i = 1; i < 13; i++) {
        if (but[i] == 1) {
            n = i;
            NSLog(@"i = %d", i);
            break;
        }
    }
    NSLog(@"n = %d", n);
    
    if ((n-1) < [issueArray count]) {
        titleLabel.text =[NSString stringWithFormat:@"胜负彩%@期", [issueArray objectAtIndex:n-1]];
        UIFont * font = titleLabel.font;
        CGSize  size = CGSizeMake(180, 34);
        CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
        sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width + 3, 9, 17, 17);
        [self getFootballMatchRequest:[issueArray objectAtIndex:n-1]];
        [self pressQingButton:nil];
        issString = [issueArray objectAtIndex:n-1];
		betInfo.issue = issString;
        NSLog(@"iss = %@", issString);
        but[n] = 0;
    }
    
    [bgview performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.4];
}

//请求期号
- (void)getIssueListRequest
{
    // 1 北京单场；4 进球彩； 6 六场半全；10 竞彩足球； 14 胜负彩
    int lotteryType = 14;
    if (betInfo.lotteryType == TYPE_ZC_BANQUANCHANG) {
        lotteryType = 6;
    } else if (betInfo.lotteryType == TYPE_ZC_JINQIUCAI) {
        lotteryType = 4;
    }
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqGetZucaiJingcaiIssueList:lotteryType];
    NSLog(@"lotter = %d", lotteryType);
    NSLog(@"url = %@", [GC_HttpService sharedInstance].hostUrl);
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(reqIssueListFinished:)];
    [httpRequest startAsynchronous];
}

- (void)reqIssueListFinished:(ASIHTTPRequest*)_request
{
    
    
    if ([_request responseData]) {
        GC_IssueList *issuelist = [[GC_IssueList alloc] initWithResponseData:[_request responseData]WithRequest:_request];
        self.issueDetails = issuelist.details;
        if (self.issString) {
            if ([self.issString length] <= 0 ) {
                self.issString = issuelist.defaultIssue;
            }
        }
        
        NSLog(@"%@", issuelist.details);
        if (issuelist.returnId == 3000) {
            [issuelist release];
            return;
        }
        
        
        
        if (issuelist.issueCount == 0) {
            [bettingArray removeAllObjects];
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"赛程更新中，请稍后再试"];
            [myTableView reloadData];
        }
        
        if (issuelist.issueCount > 0 && [issuelist.details count] == 0) {
            if (countjishuqi < 3) {
                countjishuqi += 1;
                [self getIssueListRequest];
                
            }else{
                countjishuqi = 0;
                caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                [cai showMessage:@"网络原因，请稍后再试"];
                [myTableView reloadData];
            }
            [issuelist release];
            return;
            
        }
        
        
        if (issuelist.details.count > 0) {
            // NSMutableArray *issues = [NSMutableArray arrayWithCapacity:issuelist.details.count];
            [issueTypeArray removeAllObjects];
            for (IssueDetail *_detail in issuelist.details) {
                
                // if ([_detail.status isEqualToString:@"1"]) {
                [issueArray addObject:_detail.issue];
                [staArray addObject:_detail.status];
                [issueTypeArray addObject:_detail];
                //  }
                
                if (![_detail.status isEqualToString:@"1"]) {//如果不是当前期的 清一下缓存
                    
                    NSString * keystring = @"";
                    if (bettingstype == bettingStypeRenjiu) {
                        keystring = [NSString stringWithFormat:@"301%@", _detail.issue];//@"301";
                    }else   if (bettingstype == bettingStypeShisichang) {
                        keystring = [NSString stringWithFormat:@"300%@", _detail.issue];//@"300";
                    }
                    
                    NSMutableArray * saveArray = [[NSMutableArray alloc] initWithCapacity:0];
                    [[NSUserDefaults standardUserDefaults] setValue:saveArray forKey:keystring];
                    [saveArray release];
                }
                
                
                NSLog(@"issue = %@", _detail.issue);
                NSLog(@"id = %@", _detail.stopTime);
                NSLog(@"idsd = %@", _detail.status);
            }
            
//            if (isHemai) {
//                for (IssueDetail *_detail in issuelist.details) {
//                    
//                    if ([_detail.status isEqualToString:@"1"]) {
//                        self.issString = _detail.issue;
//                        saveDangQianIssue = issString;
//                    }
//                    
//                }
//                
//            }
            
            //  issueComboBox.popUpBoxDatasource = issues;
            //  issueComboBox.text = issuelist.defaultIssue;
            //        [self updateStopTimeLabel];
            //  //暂时
            //            [self getFootballMatchRequest:[issueArray objectAtIndex:0]];//传入期次 要传当前期 如果没有的话 就传最近预售期
            //            titleLabel.text =[NSString stringWithFormat:@"胜负彩%@期", [issueArray objectAtIndex:0]];
            
            //正式的
            //            issString = nil;
            //            [issueArray removeAllObjects];
            if (!issString||[issString isEqualToString:@""]||[issString isEqualToString:@"null"]||[issString length]==0||issString == nil||![issString isAllNumber]) {
                [self getFootballMatchRequest:[issueArray objectAtIndex:0]];
                titleLabel.text =[NSString stringWithFormat:@"胜负彩%@期", [issueArray objectAtIndex:0]];
                UIFont * font = titleLabel.font;
                CGSize  size = CGSizeMake(180, 34);
                CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
                sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 2, 9.5, 17, 17);
                //                sanjiaolabel.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width, 2, 20, 34);
				self.issString = [issueArray objectAtIndex:0];
                
                
                //                titleJieqi.hidden = NO;

                
                if (![[staArray objectAtIndex:0] isEqualToString:@"1"]) {
                    caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
                    [cai showMessage:@"本期不能购买"];
                    castButton.enabled = NO;
                    castButton.alpha = 0.5;
                    //                    titleJieqi.hidden = YES;
               
                    
                }
                
            }else{
                NSLog(@"iss = %@", issString);
                castButton.enabled = YES;
                castButton.alpha = 1;
                
                
                //                NSInteger xcont = 0;
                //                for (int i = 0; i < [ issueTypeArray count]; i++) {
                //                    IssueDetail * detail = [issueTypeArray objectAtIndex:i];
                //                    if ([detail.issue isEqualToString:issString]) {
                //                        xcont = i;
                //                        break;
                //                    }
                //                }
                //                IssueDetail * isdetail = [issueTypeArray objectAtIndex:xcont];
                //                jiezhistring = isdetail.stopTime;
                //                jiezhilabel.text = jiezhistring;
                
                [self stopTimeUpData];
                
                [self getFootballMatchRequest:issString];//传入期次 要传当前期 如果没有的话 就传最近预售期
                if (bettingstype == bettingStypeRenjiu) {
                    titleLabel.text =[NSString stringWithFormat:@"任选九%@期", issString];
                }
                if (bettingstype == bettingStypeShisichang) {
                    titleLabel.text =[NSString stringWithFormat:@"胜负彩%@期", issString];
                }
                UIFont * font = titleLabel.font;
                CGSize  size = CGSizeMake(180, 34);
                CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
                sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 2, 9.5, 17, 17);
                //                sanjiaolabel.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width, 2, 20, 34);
       
            }
            
            [myTableView reloadData];
            
            
        }
        [issuelist release];
    }else{
        
        [self getIssueListRequest];
    }
}


//请求比赛
- (void)getFootballMatchRequest:(NSString *)_issue
{
    if (!loadview) {
         loadview = [[UpLoadView alloc] init];
    }
   
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    NSLog(@"iss = %@", _issue);
    if (!_issue || _issue.length <= 0) return;
    // 1 北京单场；4 进球彩； 6 六场半全；10 竞彩足球； 14 胜负彩
    int lotteryType = 13;
    if (betInfo.lotteryType == TYPE_ZC_BANQUANCHANG) {
        lotteryType = 6;
    } else if (betInfo.lotteryType == TYPE_ZC_JINQIUCAI) {
        lotteryType = 4;
    }
    //    BOOL youfoubool = NO;
    NSString *issueStatus = nil;
    for (IssueDetail *issueDetail in self.issueDetails) {
        if ([issueDetail.issue isEqualToString:_issue]) {
            // if ([issueStatus isEqualToString:@"1"]) {
            issueStatus = issueDetail.status;
            //   }
            //            youfoubool = YES;
            NSLog(@"status = %@", issueStatus);
            NSLog(@"_issue = %@", _issue);
        }
        
        
    }
    // issueStatus = nil;
    //测试
    // issueStatus = @"1";
    
    
    if (![issueStatus isEqualToString:@"1"]) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"本期不能购买"];
        castButton.enabled = NO;
        castButton.alpha = 0.5;
        if (!issueStatus) {
            IssueDetail *issueDetail = [self.issueDetails objectAtIndex:1];
            issueStatus = issueDetail.status;
            _issue = issueDetail.issue;
            issString = _issue;
            
            
        }
        //        IssueDetail * iss = [self.issueDetails objectAtIndex:0];
        //        issueStatus = iss.issue;
        //        issString = iss.issue;
        
        
        //        if (!youfoubool) {
        //            IssueDetail *issueDetail = [self.issueDetails objectAtIndex:1];
        //            issueStatus = issueDetail.status;
        //            _issue = issueDetail.issue;
        //            issString = _issue;
        //        }
        
        
        
        
        
    }else{
        castButton.enabled = YES;
        castButton.alpha = 1;
    }
    
    if (bettingstype == bettingStypeRenjiu) {
        titleLabel.text =[NSString stringWithFormat:@"任选九%@期", _issue];
    }
    if (bettingstype == bettingStypeShisichang) {
        titleLabel.text =[NSString stringWithFormat:@"胜负彩%@期", _issue];
    }
    
    NSInteger xcont = 0;
    for (int i = 0; i < [ issueTypeArray count]; i++) {
        IssueDetail * detail = [issueTypeArray objectAtIndex:i];
        if ([detail.issue isEqualToString:_issue]) {
            xcont = i;
            break;
        }
    }
    IssueDetail * isdetail = [issueTypeArray objectAtIndex:xcont];
    
    if ([isdetail.status isEqualToString:@"1"]) {
        jiezhilabel.hidden = NO;
        
    }else{
        jiezhilabel.hidden = YES;
        
    }
    [self stopTimeUpData];

    
    UIFont * font = titleLabel.font;
    CGSize  size = CGSizeMake(180, 34);
    CGSize labelSize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    titleLabel.frame = CGRectMake((180-labelSize.width- 20)/2, 0, labelSize.width, 34);
    sanjiaoImageView.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width + 3, 9, 17, 17);
    NSLog(@"iss = %@, issueStatus = %@", _issue, issueStatus);
    NSString * hcDateKey = @"";
//    hcDateKey = [self  objectKeyStringSaveHuanCun];//在期号后面拼@时间戳
    
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:[self objectKeyStringSaveHuanCun]]) {
        hcDateKey = [NSString stringWithFormat:@"%@@%@", _issue,[[NSUserDefaults standardUserDefaults] valueForKey:[self objectKeyStringSaveHuanCun]]];
    }else{
        
        hcDateKey = [NSString stringWithFormat:@"%@@", _issue];
        
    }
    
    
    
    NSLog(@"hcdate = %@", hcDateKey);
    
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] reqGetZucaiJingcaiMatch:lotteryType issue:hcDateKey isStop:@"-" match:@"-"];
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setPostBody:postData];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(reqFootballMatchFinished:)];
    [httpRequest setDidFailSelector:@selector(requestFailed:)];
    [httpRequest setUserInfo:[NSDictionary dictionaryWithObject:issueStatus forKey:@"issue"]];
    [httpRequest startAsynchronous];
}

- (void)requestFailed:(ASIHTTPRequest *)mrequest{
    
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }

}
- (void)reqFootballMatchFinished:(ASIHTTPRequest*)_request
{
    [bettingArray removeAllObjects];
    NSLog(@"reqFootballMatchFinished = %@", [_request responseData]);
    if ([_request responseData]) {        
        GC_FootballMatch *footballMatch = [[GC_FootballMatch alloc] initWithResponseData:[_request responseData]WithRequest:_request];
        
        
        NSString *issueStatus = [_request.userInfo objectForKey:@"issue"];
        
        NSString *issueS = nil;
        for (IssueDetail *issueDetail in self.issueDetails) {
            if ([issueDetail.issue isEqualToString:issueStatus]) {
                // if ([issueStatus isEqualToString:@"1"]) {
                issueS = issueDetail.status;
                //   }
                //            youfoubool = YES;
                NSLog(@"status = %@", issueS);
                NSLog(@"_issue = %@", issueStatus);
            }
            
            
        }
        
        if ([issueS isEqualToString:@"1"]||[issueS isEqualToString:@"0"]) {
            
            if (footballMatch.update == 1) {
                
                
                [[NSUserDefaults standardUserDefaults] setValue:footballMatch.dateString forKey:[self  objectKeyStringSaveHuanCun]];
                [[NSUserDefaults standardUserDefaults] setValue:[_request responseData] forKey:[self  objectKeyStringSaveDuiZhen]];
                
            }
            
            if (footballMatch.update == 0) {
                
                NSLog(@"xxxx = %@", [[NSUserDefaults standardUserDefaults] objectForKey:[self  objectKeyStringSaveDuiZhen]]);
                NSData *responseData2 = [[NSUserDefaults standardUserDefaults] objectForKey:[self  objectKeyStringSaveDuiZhen]] ;
                
                GC_FootballMatch *duizhen2 = [[GC_FootballMatch alloc] initWithResponseData:responseData2 WithRequest:request];
                self.matchList = duizhen2.matchList;
                [duizhen2 release];
                
                
            }else{
                
                self.matchList = footballMatch.matchList;
                
            }
            
            
            
        }else{
            self.matchList = footballMatch.matchList;
        }

        
        
        
        
        
        
        
        
        NSLog(@"footballmatch = %@", self.matchList);
        [footballMatch release];
        NSLog(@"fotballmatch ");
       
        for (GC_MatchInfo *matchInfo in self.matchList) {
            matchInfo.issueStatus = issueStatus;
            NSLog(@"%@", self.matchList);
            GC_BetData * betdata = [[GC_BetData alloc] init];
            betdata.event = matchInfo.leagueName;
            NSLog(@"event = %@", betdata.event);
            NSArray * timedata = [matchInfo.startTime componentsSeparatedByString:@" "];
            if (timedata.count < 2) {
                timedata = [NSArray arrayWithObjects:@"",@"", nil];
            }
            betdata.date = [timedata objectAtIndex:0];
            NSLog(@"date = %@",betdata.date);
            betdata.time = [timedata objectAtIndex:1];
            betdata.team = [NSString stringWithFormat:@"%@,%@,%@", matchInfo.home, matchInfo.away, matchInfo.assignCount];
            betdata.saishiid = matchInfo.identifier;
            betdata.bifen = matchInfo.endScore;
            betdata.caiguo = matchInfo.caiguo;
            betdata.zlcString = matchInfo.zlcString;
//            betdata.zlcString = @"-True";
            NSLog(@"team = %@", betdata.team);
            NSLog(@"eurpei = %@", matchInfo.eurPei);
            if ([matchInfo.eurPei length] > 1) {
                NSRange  kongge = [matchInfo.eurPei rangeOfString:@" "];
                if (kongge.location != NSNotFound) {
                    NSArray * butarray = [matchInfo.eurPei componentsSeparatedByString:@" "];//ccc
                    if (butarray.count > 2) {
                        betdata.but1 = [butarray objectAtIndex:0];//ccc
                        // NSLog(@"but = %@", betdata.but1);
                        betdata.but2 = [butarray objectAtIndex:1];
                        betdata.but3 = [butarray objectAtIndex:2];//ccc
                    }
                }
                
            }
            
            [bettingArray addObject:betdata];
            [betdata release];
        }
        //  if (matchList.count > 0) [self updateUI];
        
    }
   
    [myTableView reloadData];
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }

}


- (void)pressRightButton:(id)sender{
    PKGameExplainViewController * pkevc = [[PKGameExplainViewController alloc] init];
    [self.navigationController pushViewController:pkevc animated:YES];
    [pkevc release];

}
- (void)pressQingButton:(UIButton *)sender{
    
    for (int i = 0; i < [bettingArray count]; i++) {
        GC_BetData * bet = [bettingArray objectAtIndex:i];
        bet.selection1 = NO;
        bet.selection2 = NO;
        bet.selection3 = NO;
        [bettingArray replaceObjectAtIndex:i withObject:bet];
    }
    
    oneLabel.text = @"0";
    twoLabel.text = @"0";
    one = 0;
    two = 0;
    [myTableView reloadData];
}


- (void)tabBarView{
#ifdef isHaoLeCai
    tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 392, 320, 44)];
    
    if (IS_IPHONE_5) {
        tabView.frame = CGRectMake(0, 480, 320, 44);
    }
#else
    tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 372, 320, 44)];
    
    if (IS_IPHONE_5) {
        tabView.frame = CGRectMake(0, 460, 320, 44);
    }
#endif

    UIImageView * tabBack = [[UIImageView alloc] initWithFrame:tabView.bounds];
//    tabBack.image =[UIImageGetImageFromName(@"XDH960.png") stretchableImageWithLeftCapWidth:9 topCapHeight:11];
    tabBack.backgroundColor =  [UIColor blackColor];
    
    //已选
    UILabel * pitchLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 20, 10)];
    pitchLabel.text = @"";
    pitchLabel.textAlignment = NSTextAlignmentCenter;
    pitchLabel.font = [UIFont systemFontOfSize:9];
    pitchLabel.backgroundColor = [UIColor clearColor];
    
    //已投
    UILabel * castLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 20, 10)];
    castLabel.text = @"";
    castLabel.textAlignment = NSTextAlignmentCenter;
    castLabel.font = [UIFont systemFontOfSize:9];
    castLabel.backgroundColor = [UIColor clearColor];
    
    
    UIButton * qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    qingbutton.frame = CGRectMake(12, 8, 30, 30);
    [qingbutton setImage:UIImageGetImageFromName(@"LJT960.png") forState:UIControlStateNormal];
    [qingbutton addTarget:self action:@selector(pressQingButton:) forControlEvents:UIControlEventTouchUpInside];
//    UILabel * qinglabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 26, 29)];
//    qinglabel.text = @"清";
//    qinglabel.font = [UIFont boldSystemFontOfSize:15];
//    qinglabel.textAlignment = NSTextAlignmentCenter;
//    qinglabel.backgroundColor = [UIColor clearColor];
//    qinglabel.textColor = [UIColor colorWithRed:25/255.0 green:114/255.0 blue:176/255.0 alpha:1];
//    
//    
//    [qingbutton addSubview:qinglabel];
//    [qinglabel release];

    
    //放图片 图片上放label 显示投多少场
//    UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 12, 25, 10)];
//    imageView1.image = UIImageGetImageFromName(@"b_03.png");
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(52, 8, 62, 30)];
    zhubg.image = UIImageGetImageFromName(@"SRK960.png");
    zhubg.userInteractionEnabled = YES;
    
    
    
    
    //放图片 图片上放label 显示投多少场
    //    UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 12, 25, 10)];
    //    imageView1.image = UIImageGetImageFromName(@"b_03.png");
    
    oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, 40, 13)];
    oneLabel.backgroundColor = [UIColor clearColor];
    oneLabel.textAlignment = NSTextAlignmentCenter;
    oneLabel.font = [UIFont systemFontOfSize:12];
    oneLabel.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133.0/255.0 alpha:1.0];;
    //   oneLabel.text = @"14";
    
    [zhubg addSubview:oneLabel];
    
    //放图片 图片上放label 显示投多少注
    //    UIImageView * imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 27, 25, 10)];
    //    imageView2.image = UIImageGetImageFromName(@"b_03.png");
    
    twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 18, 40, 13)];
    twoLabel.backgroundColor = [UIColor clearColor];
    twoLabel.textAlignment = NSTextAlignmentCenter;
    twoLabel.font = [UIFont systemFontOfSize:12];
    twoLabel.textColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1.0];
//    twoLabel.hidden = YES;
    //  twoLabel.text = @"512";
    
    [zhubg addSubview:twoLabel];
    
    //场字
    UILabel *  fieldLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 3, 20, 13)];
    fieldLable.text = @"注";
    fieldLable.textAlignment = NSTextAlignmentCenter;
    fieldLable.font = [UIFont systemFontOfSize:12];
    fieldLable.backgroundColor = [UIColor clearColor];
    fieldLable.textColor = [UIColor colorWithRed:182/255.0 green:172/255.0 blue:133.0/255.0 alpha:1.0];
    [zhubg addSubview:fieldLable];
    //注字
    UILabel * pourLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 18, 20, 13)];
    pourLable.text = @"元";
//    pourLable.hidden = YES;
    pourLable.textAlignment = NSTextAlignmentCenter;
    pourLable.font = [UIFont systemFontOfSize:12];
    pourLable.backgroundColor = [UIColor clearColor];
    pourLable.textColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:244/255.0 alpha:1.0];
    [zhubg addSubview:pourLable];
    
    //投注按钮背景
    UIImageView * backButton = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,63, 30)];
    backButton.image = UIImageGetImageFromName(@"gc_footerBtn.png");
    UIImageView * backButton2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 29)];
    backButton2.image = UIImageGetImageFromName(@"GC_icon8.png");

    
        
    
    //    UILabel * buttonLabel2 = [[UILabel alloc] initWithFrame:backButton2.bounds];
    //    buttonLabel2.text = @"玩 法";
    //    buttonLabel2.textAlignment = NSTextAlignmentCenter;
    //    buttonLabel2.backgroundColor = [UIColor clearColor];
    
    
    //投注按钮
    castButton = [UIButton buttonWithType:UIButtonTypeCustom];
    castButton.frame = CGRectMake(230, 6, 80, 33);
//    UIImageView * chuanimage1 = [[UIImageView alloc] initWithFrame:castButton.bounds];
//    chuanimage1.backgroundColor = [UIColor clearColor];
//    chuanimage1.image = [UIImageGetImageFromName(@"QHWZBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//    [castButton addSubview:chuanimage1];
//    [chuanimage1 release];

    [castButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [castButton setBackgroundImage:[UIImageGetImageFromName(@"kuaisanSenBtn_1.png") stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [castButton addTarget:self action:@selector(pressCastButton:) forControlEvents:UIControlEventTouchUpInside];
 
    //[castButton setImage:UIImageGetImageFromName(@"gc_footerBtn.png") forState:UIControlStateHighlighted];
    //玩法按钮
//    UIButton * helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    helpButton.frame = CGRectMake(282, 11, 26, 29);
//    [helpButton addTarget:self action:@selector(pressHelpButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // [castButton addSubview:backButton];
    
    //按钮上的字
    UILabel * buttonLabel1 = [[UILabel alloc] initWithFrame:castButton.bounds];
    buttonLabel1.text = @"选好了";
    buttonLabel1.textAlignment = NSTextAlignmentCenter;
    buttonLabel1.backgroundColor = [UIColor clearColor];
    buttonLabel1.textColor = [UIColor colorWithRed:87/255.0 green:21/255.0 blue:0/255.0 alpha:1];
    //  buttonLabel1.textColor = [UIColor whiteColor];
    buttonLabel1.font = [UIFont boldSystemFontOfSize:22];

    
//    [helpButton addSubview:backButton2];
    [castButton addSubview:buttonLabel1];
    // [helpButton addSubview:buttonLabel2];
    [backButton release];
    [backButton2 release];
    [buttonLabel1 release];
    //  [buttonLabel2 release];
    
    [tabView addSubview:tabBack];
    [tabView addSubview:pitchLabel];
    [tabView addSubview:castLabel];
    [zhubg addSubview:fieldLable];
    [zhubg addSubview:pourLable];
    [tabView addSubview:zhubg];
    [zhubg release];
//    [tabView addSubview:imageView2];
    [tabView addSubview:castButton];
    
    [tabView addSubview:qingbutton];
    [self.mainView addSubview:tabView];
    
    
    [pitchLabel release];
    [castLabel release];
    [fieldLable release];
    [pourLable release];
//    [imageView1 release];
//    [imageView2 release];
    
    [tabBack release];
}




- (void)pressCastButton:(UIButton *)button{
    
    if (bettingstype == bettingStypeShisichang) {
        
        
        if (one < 14) {
            
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"至少需要对14场比赛进行投注" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alert show];
//            [alert release];
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"至少需要选择14场"];
        }else

            {
        
            
            NSString * string = @"";
            for (GC_BetData * data in bettingArray) {
                if (data.selection1) {
                    string = [string stringByAppendingFormat:@"3"];
                }
                if (data.selection2) {
                    string = [string stringByAppendingFormat:@"1"];
                }
                if (data.selection3) {
                    string = [string stringByAppendingFormat:@"0"];
                }
                string = [string stringByAppendingFormat:@"*"];
            }
            string = [string substringToIndex:[string length] - 1];
            NSLog(@"string = %@", string);
            
            //      int bets = [GC_LotteryUtil getBets:string LotteryType:betInfo.lotteryType ModeType:fushi];
            //  DD_LOG(@"注数：%i", bets);
            betInfo.modeType = (two > 1) ? fushi:danshi;
            //  DD_LOG(@"玩法：%i", betInfo.modeType);
            betInfo.bets = two;
            betInfo.price = two * 2;
            NSLog(@"jine = %i", betInfo.price);
            betInfo.zhuihaoType = 0;
            betInfo.betNumber = string;
            
            NSLog(@"%i", two);
            
            betInfo.issue = issString;
            
            if (fbTextView.text == nil) {
                fbTextView.text = @"";
            }
            
            NSString * ssss = issString;
            NSString * stringstr = [NSString stringWithFormat:@"#胜负彩14场_%@期预测# #足彩预测# #%@预测#%@", issString, [[Info getInstance] nickName], fbTextView.text];
              NSLog(@"url = %@", [NetURL CPThreeSendPreditTopicIssue:ssss userid:[[Info getInstance] userId] lotteryId:@"13" lotteryNumber:betInfo.betNumber content:stringstr endtime:@""]);
            self.request = [ASIHTTPRequest requestWithURL:[NetURL CPThreeSendPreditTopicIssue:ssss userid:[[Info getInstance] userId] lotteryId:@"13" lotteryNumber:betInfo.betNumber content:stringstr endtime:@""]]; 
            [request setDefaultResponseEncoding:NSUTF8StringEncoding];
            [request setDelegate:self];
            [request setTimeOutSeconds:20.0];
            [request startAsynchronous];
            
            [[ProgressBar getProgressBar] show:@"正在发送微博..." view:self.mainView];
            [ProgressBar getProgressBar].mDelegate = self;


            
            
//            // if (betInfo.bets > 0) {
//            //     if (betInfo.price <= 20000) {
//            GC_ShengfuInfoViewController * sheng = [[GC_ShengfuInfoViewController alloc] initWithBetInfo:betInfo];
//            sheng.bettingArray = bettingArray;
//            sheng.moneynum = twoLabel.text;
//            sheng.zhushu = oneLabel.text;
//            sheng.fenzhong = shisichangpiao;
//            [self.navigationController pushViewController:sheng animated:YES];
//            [sheng release]; 
            //    }
            
            //   }
        }
        
    }else if(bettingstype == bettingStypeRenjiu){
    
        if (one < 9 || one > 9) {
            
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"至少需要对9场比赛进行投注" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.shouldRemoveWhenOtherAppear = YES;
            [alert show];
            [alert release];
            
        }else

            {
            //      int st = [self.betArray count] - 1;
            
            NSString * string = @"";
            for (GC_BetData * data in bettingArray) {
                if (data.selection1 || data.selection2 || data.selection3) {
                    if (data.selection1) {
                        string = [string stringByAppendingFormat:@"3"];
                    }
                    if (data.selection2) {
                        string = [string stringByAppendingFormat:@"1"];
                    }
                    if (data.selection3) {
                        string = [string stringByAppendingFormat:@"0"];
                    }
                    
                }else{
                    string = [string stringByAppendingFormat:@"4"];
                }
                string = [string stringByAppendingFormat:@"*"];
            }
            string = [string substringToIndex:[string length] - 1];
            NSLog(@"string = %@", string);
            
            //      int bets = [GC_LotteryUtil getBets:string LotteryType:betInfo.lotteryType ModeType:fushi];
            //  DD_LOG(@"注数：%i", bets);
            betInfo.modeType = (two > 1) ? fushi:danshi;
            //  DD_LOG(@"玩法：%i", betInfo.modeType);
            betInfo.bets = two;
            betInfo.price = two * 2;
            NSLog(@"jine = %i", betInfo.price);
            betInfo.zhuihaoType = 0;
            betInfo.betNumber = string;
            
            NSLog(@"%i", two);
            
            betInfo.issue = issString;
            betInfo.lotteryType = TYPE_ZC_RENXUAN9;
            // if (betInfo.bets > 0) {
            //     if (betInfo.price <= 20000) {
            GC_ShengfuInfoViewController * sheng = [[GC_ShengfuInfoViewController alloc] initWithBetInfo:betInfo];
            sheng.fenzhong = renjiupiao;
            sheng.bettingArray = bettingArray;
            sheng.moneynum = twoLabel.text;
            sheng.zhushu = oneLabel.text;
            [self.navigationController pushViewController:sheng animated:YES];
            [sheng release]; 
        }
    }
}
    
- (void)requestFinished:(ASIHTTPRequest *)mrequest {
    NSString *result = [mrequest responseString];
    NSDictionary *resultDict = [result JSONValue];
    
    if([[resultDict objectForKey:@"code"] isEqualToString:@"0"]){
        [[ProgressBar getProgressBar] setTitle:@"微博发布成功!"];
        [NSTimer scheduledTimerWithTimeInterval:0.8
                                         target:self
                                       selector:@selector(onTimer:)
                                       userInfo:nil
                                        repeats:NO];
    }else {
        [[ProgressBar getProgressBar] setTitle:@"微博发布失败!"];
    }
    
    
}
- (void) onTimer : (id) sender {
    [[ProgressBar getProgressBar] dismiss];
    [self dismissSelf:YES];
    NSString * stringstr = [NSString stringWithFormat:@"#胜负彩14场_%@期预测#", issString];
    
    TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:@"" themeName:stringstr];
    topicThemeListVC.cpsanliu = CpSanLiuWuyes;
    topicThemeListVC.jinnang = YES;
    [self.navigationController pushViewController:topicThemeListVC animated:YES];
    [topicThemeListVC release];
    
    
    
}
- (void)dismissSelf:(BOOL)animated {
    [self dismissViewControllerAnimated: animated completion:nil];
}

- (void)FaBiaoDidFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString * str = [mrequest responseString];
    NSLog(@"str = %@", str);
    NSDictionary * dict = [str JSONValue];
    NSString * ss = [dict objectForKey:@"code"];
    if ([ss isEqualToString:@"0"]) {
        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:nil message:@"发表成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [aler show];
        [aler release];
    }
   
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 101) {
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"my" object:self];
    }
}

- (void)pressHelpButton:(UIButton *)button{
//    NSLog(@"wan fa");
//    GC_ExplainViewController * exp = [[GC_ExplainViewController alloc] init];
    Xieyi365ViewController *exp = [[Xieyi365ViewController alloc] init];
    exp.ALLWANFA = ShenFuCai;
    [self.navigationController pushViewController:exp animated:YES];
    [exp release];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"zcrx9.txt"];
//	NSData *fileData = [fileManager contentsAtPath:path];
//    if (fileData) {
//        NSString *text = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
//        ruleTextView.text = text;
//        [text release];

}





#pragma mark -
#pragma mark Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if ([bettingArray count] > 14) {
        return 14;
    }
    return [bettingArray count];
  //  return 14;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (zhankai[indexPath.row] == 1) {
//        return 55+56;
//    }
	return 99;

}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    GC_BetCell *cell = (GC_BetCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[GC_BetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:@"1" chaodan:NO] autorelease];
        
        //        if (bettingstype == bettingStypeShisichang) {
        //             [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil]];
        //            cell.butTitle.text = @"析";
        //        }else if (bettingstype == bettingStypeRenjiu){
        //         [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆",@"八方预测", nil]];
        //            cell.butTitle.text = @"析  胆";
        //        }
        
        
        cell.cp_canopencelldelegate = self;
#ifdef isCaiPiaoForIPad
        cell.xzhi  = 9.5+35;
#else
        cell.xzhi = 9.5;
#endif
        
        cell.otherImageView.image = UIImageGetImageFromName(@"xialabg.png");
        cell.normalHight = 50;
        cell.selectHight = 50+56;
        cell.xialabianImge.image = UIImageGetImageFromName(@"xialabian24.png");
    }
    if (castButton.enabled == NO) {
        cell.wangqibool = YES;
        [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil]];
        cell.butTitle.text = @"析";
    }else{
        if (bettingstype == bettingStypeShisichang) {
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"八方预测", nil]];
            cell.butTitle.text = @"析";
        }else if (bettingstype == bettingStypeRenjiu){
            [cell setButonImageArray:[NSArray arrayWithObjects:@"bfyczucai.png",@"danzucai.png",nil] TitileArray:[NSArray arrayWithObjects:@"胆",@"八方预测", nil]];
            cell.butTitle.text = @"析  胆";
        }
        
        cell.wangqibool = NO;
    }
    // Configure the cell...
//    if (zhankai[indexPath.row] == 1) {
//        [cell showButonScollWithAnime:NO];
//    }
//    if (zhankai[indexPath.row] == 0) {
//        [cell hidenButonScollWithAnime:NO];
//    }
    cell.row = indexPath.row;
//    cell.pkbetdata = [dataArray objectAtIndex:indexPath.row];
    cell.count = indexPath.row;
    cell.delegate = self;
//    cell.pkbetdata = [bettingArray objectAtIndex:indexPath.row];
    GC_BetData * pkbet = [bettingArray objectAtIndex:indexPath.row];
    pkbet.donghuarow = indexPath.row;
    cell.pkbetdata = pkbet;
    
    //self.matchList
    
    return cell;
}
- (void)deleteContentOff:(NSString *)equal{
    
    NSArray * keys = [ContentOffDict allKeys];
    if (keys > 0) {
        for (NSString * keyStr in keys) {
            NSArray * strarr = [keyStr componentsSeparatedByString:@" "];
            if (strarr.count < 2) {
                return;
            }
            NSIndexPath * index = [NSIndexPath indexPathForRow:[[strarr objectAtIndex:1] intValue] inSection:[[strarr objectAtIndex:0] intValue]];
            
            if (![keyStr isEqualToString:equal]) {
                [UIView beginAnimations:@"ndd" context:NULL];
                [UIView setAnimationDuration:.3];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                CP_CanOpenCell *cell2 = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:index];
                cell2.butonScrollView.contentOffset = CGPointMake(0, cell2.butonScrollView.contentOffset.y);
                [UIView commitAnimations];
                
                
                //                GC_JCBetCell * jccell = (GC_JCBetCell *)cell2;
                //                if (matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchenumBanQuanChang) {
                //                    jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
                //                }else if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBiFenGuoguan){
                //                    jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
                //
                //                }
                //                if (matchType == MatchJinQiuShu || matchType == matchBanQuanChang) {
                //                    jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
                //                }else if (matchType == MatchShangXiaDanShuang || matchType == MatchBiFen){
                //                    jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
                //
                //                }else if (matchType == MatchRangQiuShengPingFu){
                //
                //                    jccell.XIDANImageView.image = UIImageGetImageFromName(@"bdsfxidanimage.png");
                //                }else if (matchType == MatchShengFuGuoGan) {
                //
                //                }
            }
            
            
            
        }
        [ContentOffDict removeAllObjects];
    }
    
}
- (void)returnCellContentOffsetString:(NSIndexPath *)index remove:(BOOL)yn{
    
    //    [ContentOffArray addObject:index];
    GC_BetCell *cell2 = (GC_BetCell *)[myTableView cellForRowAtIndexPath:index];
    NSString * str = @"";
    if (cell2.wangqibool) {
        str = [NSString stringWithFormat:@"%d %d", (int)index.section, (int)index.row];
    }else{
        str = [NSString stringWithFormat:@"%d %d", (int)index.section+2, (int)index.row];
    }
    
    if (yn == NO) {
        [self deleteContentOff:str];
        [ContentOffDict setObject:@"1" forKey:str];
        
    }else{
        [ContentOffDict removeObjectForKey:str];
    }
    
    
    
}

- (void)sleepOpenCell:(CP_CanOpenCell *)cell{
    
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    NSInteger xcount = 0;
    
    if (bettingstype == bettingStypeRenjiu) {
        if ([[cell.allTitleArray objectAtIndex:0] isEqualToString:@"胆"]) {
            xcount = 35+ ([cell.allTitleArray count]-1)*70;
        }else {
            xcount =[cell.allTitleArray count]*70;
            
        }
    }else{
        xcount =[cell.allTitleArray count]*70;
    }
    
    
    NSLog(@"!11111111111111111");
    cell.butonScrollView.contentOffset = CGPointMake( xcount, cell.butonScrollView.contentOffset.y);
    [UIView commitAnimations];
    
    //    GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
    //    if (matchenum == matchenumZongJinQiuShu || matchenum == matchEnumZongJinQiuShuDanGuan ) {
    //        jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanhuakai.png");
    //    }
    //    if (matchType == MatchJinQiuShu || matchType == matchBanQuanChang ) {
    //        jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanhuakai.png");
    //    }else if (matchType == MatchShangXiaDanShuang || matchType == MatchBiFen){
    //        jccell.XIDANImageView.image = UIImageGetImageFromName(@"dakaixidanimage.png");
    //
    //    }else if (matchType == MatchRangQiuShengPingFu){
    //        jccell.XIDANImageView.image = UIImageGetImageFromName(@"rangqiukai.png");
    //    }else if (matchType == MatchShengFuGuoGan){
    //        jccell.XIDANImageView.image = UIImageGetImageFromName(@"bdsfxidanimage_1.png");
    //    }
}


- (void)openCell:(CP_CanOpenCell *)cell{
    
    NSLog(@"6666666666666666");
    if (cell.butonScrollView.contentOffset.x > 0) {
        //        buttonBool = YES;
        NSLog(@"%f,%f",cell.butonScrollView.contentSize.width,cell.butonScrollView.contentSize.height);
        
        //            if ([cell.allTitleArray count] > 2) {
        [UIView beginAnimations:@"ndd" context:NULL];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        NSLog(@"!@222222222222222222222");
        cell.butonScrollView.contentOffset = CGPointMake( 0, cell.butonScrollView.contentOffset.y);
        [UIView commitAnimations];
        
        //        GC_JCBetCell * jccell = (GC_JCBetCell *)cell;
        //
        //        if (matchenum == matchEnumZongJinQiuShuDanGuan || matchenum == matchenumZongJinQiuShu || matchenum == matchEnumBanQuanChangDanGuan || matchenum == matchenumBanQuanChang) {
        //            jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
        //        }else if (matchenum == matchEnumBiFenDanGuan || matchenum == matchEnumBiFenGuoguan){
        //            jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
        //
        //        }
        
        
        //        if (matchType == MatchJinQiuShu || matchType == matchBanQuanChang ) {
        //            jccell.XIDANImageView.image = UIImageGetImageFromName(@"xidanguanbi.png");
        //        }else if (matchType == MatchShangXiaDanShuang|| matchType == MatchBiFen ){
        //            jccell.XIDANImageView.image = UIImageGetImageFromName(@"guanbixidanimage.png");
        //
        //        }else if (matchType == MatchRangQiuShengPingFu){
        //
        //            jccell.XIDANImageView.image = UIImageGetImageFromName(@"rangqiuguan.png");
        //        }else if (matchType == MatchShengFuGuoGan){
        //            jccell.XIDANImageView.image = UIImageGetImageFromName(@"bdsfxidanimage.png");
        //
        //        }
        
    }else{
        [self performSelector:@selector(sleepOpenCell:) withObject:cell afterDelay:0.1];
    }
    return;
    
}
- (void)neutralityMatchViewDelegate:(NeutralityMatchView *)view withBetData:(GC_BetData *)be{
    
    NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
    //        sachet.playID = @"234028"; //传入这两个对比赛的id
    
    sachet.playID = be.saishiid;
#ifdef isCaiPiaoForIPad
    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
#else
    [self.navigationController pushViewController:sachet animated:YES];
#endif
    [sachet release];
}


- (void)returncellrownum:(NSInteger)num{
    GC_BetData * be = [bettingArray objectAtIndex:num];
    [self NewAroundViewShowFunc:be indexPath:num];
    
//     GC_BetData * be = [bettingArray objectAtIndex:num];
//    if (castButton.enabled == YES) {
//        if ([be.zlcString rangeOfString:@"-"].location != NSNotFound) {
//            NeutralityMatchView * neutrality = [[NeutralityMatchView alloc] initWithBetData:be number:[NSString stringWithFormat:@"%d", num+1]] ;
//            
//            neutrality.delegate = self;
//            [neutrality show];
//            [neutrality release];
//            return;
//        }
//    }
   

    
//            NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
//  
//    
//            sachet.playID = be.saishiid;
//#ifdef isCaiPiaoForIPad
//    [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
//#else
//    [self.navigationController pushViewController:sachet animated:YES];
//#endif
//            [sachet release];
}


- (void)returnCellInfo:(NSInteger)index buttonBoll1:(BOOL)selection1 buttonBoll:(BOOL)selection2 buttonBoll:(BOOL)selection3 dan:(BOOL)booldan{
    //    NSLog(@"666666666666666");
    //    NSLog(@"index6666 = %d", index);
    GC_BetData  * da = [bettingArray objectAtIndex:index];
    da.count = index;
    da.selection1 = selection1;
    da.selection2 = selection2;
    da.selection3 = selection3;
    da.dandan = booldan;
    if (selection1 == NO || selection2 == NO || selection3 == NO) {
        da.dandan = NO;
    }
    
    [bettingArray replaceObjectAtIndex:index withObject:da];
    
    two = 1;
    one = 0;
 //   [m_shedanArr removeAllObjects];
    if (bettingstype == bettingStypeShisichang) {
        for (GC_BetData * pkb in bettingArray) {
            if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
                one++;
                
            }
            
            two = two *(pkb.selection1+pkb.selection2+pkb.selection3);
        }
        
    }else if(bettingstype == bettingStypeRenjiu){
        
        
        
        for (GC_BetData * pkb in bettingArray) {
            if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
                one++;
                
            }
        }
        if (one == 9) {//9场的金额算法
            for (GC_BetData * pkb in bettingArray) {
                if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
                    two = two *(pkb.selection1+pkb.selection2+pkb.selection3);
                }
            }
            
        }else {
            two = 0;
        }
        
        
    }
    if (one < 14) {
        oneLabel.text = @"0";
        twoLabel.text = @"0";
    }else{
        oneLabel.text = [NSString stringWithFormat:@"%d", two];
        twoLabel.text = [NSString stringWithFormat:@"%d", two * 2];
    }
//    oneLabel.text = [NSString stringWithFormat:@"%d", two];
//    twoLabel.text = [NSString stringWithFormat:@"%d", two * 2];
    
    
    
//    if (bettingstype == bettingStypeRenjiu) {
//        zhongjiecount = countchang;
//        countchang = 0;
//        for (int j = 0; j < [bettingArray count]; j++) {
//            GC_BetData * pkb = [bettingArray objectAtIndex:j];
//            if (pkb.selection1) {
//                countchang += 1;
//            }
//            if (pkb.selection2) {
//                countchang += 1;
//            }
//            if (pkb.selection3) {
//                countchang += 1;
//            }
//            if (pkb.selection1 || pkb.selection2 || pkb.selection3) {
//                if (one > 9) {
//                    pkb.nengdan = YES;
//                    
//                    
//                    
//                }else if(one == 9){
//                    //   oneLabel.text =
//                    fieldLable.text = @"注";
//                    pkb.nengdan = NO;
//                }else{
//                    pkb.nengdan = NO;
//                    
//                    oneLabel.text = [NSString stringWithFormat:@"%d", one];
//                    twoLabel.text = @"0";
//                    fieldLable.text = @"场";
//                    
//                    
//                    
//                }
//            }
//            
//            [bettingArray replaceObjectAtIndex:j withObject:pkb];
//            int gc = pkb.selection1+pkb.selection2 + pkb.selection3;
//            // NSString * string = [string stringByAppendingFormat:@"%d", gc];
//            [m_shedanArr addObject:[NSNumber numberWithInteger:gc]];
//        
//        }
//        if(one == 0){
//            
//            
//            
//            oneLabel.text = [NSString stringWithFormat:@"%d", one];
//            twoLabel.text = @"0";
//            fieldLable.text = @"场";
//            
//            
//            
//        }
//        
//        
//        if (one <= 9) {
//            
//            for (int j = 0; j < [bettingArray count]; j++) {
//                GC_BetData * bet = [bettingArray objectAtIndex:j];
//                bet.dandan = NO;
//                
//                [bettingArray replaceObjectAtIndex:j withObject:bet];
//            }
//            
//            //  NSLog(@"two = %d", one);
//            
//        }
//        if (one > 9) {
//            [self pressChuanJiuGongGe ];
//        }
//        
//    }
//    
//    [myTableView reloadData];
//    if (bettingstype == bettingStypeRenjiu) {
//        if (one  == 9) {
//            oneLabel.text = [NSString stringWithFormat:@"%d", two];
//            twoLabel.text = [NSString stringWithFormat:@"%d", two * 2];
//        }
//        
//    }else{
//        
//        oneLabel.text = [NSString stringWithFormat:@"%d", two];
//        twoLabel.text = [NSString stringWithFormat:@"%d", two * 2];
//    }
//    
    
    
    
}


//- (void)returnCellInfo:(NSInteger)index buttonBoll1:(BOOL)selection1 buttonBoll:(BOOL)selection2 buttonBoll:(BOOL)selection3{
//    //    NSLog(@"666666666666666");
//    //    NSLog(@"index6666 = %d", index);
//    NSLog(@"1111111111111111index = %d   button1 = %d  button2 = %d  button3 = %d", index, selection1, selection2, selection3);
//    GC_BetData  * da = [bettingArray objectAtIndex:index];
//    da.count = index;
//    da.selection1 = selection1;
//    da.selection2 = selection2;
//    da.selection3 = selection3;
//    [bettingArray replaceObjectAtIndex:index withObject:da];
//    NSLog(@"1111111111111111index = %d   button1 = %d  button2 = %d  button3 = %d", da.count, da.selection1, da.selection2, da.selection3);
//    two = 1;
//    one = 0;
//    if (bettingstype == bettingStypeShisichang) {
//        for (GC_BetData * pkb in bettingArray) {
//            if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
//                one++;
//                
//            }
//            
//            two = two *(pkb.selection1+pkb.selection2+pkb.selection3); 
//        }
//
//    }else if(bettingstype == bettingStypeRenjiu){
//        for (GC_BetData * pkb in bettingArray) {
//            if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
//                one++;
//                
//            }
//        }
//        if (one == 9) {
//            for (GC_BetData * pkb in bettingArray) {
//                if (pkb.selection1 || pkb.selection2 ||pkb.selection3) {
//                two = two *(pkb.selection1+pkb.selection2+pkb.selection3);
//                }
//            }
//            
//        }else {
//            two = 0;
//        }
//        
//
//    }
//       NSLog(@"two = %d", one);
//    oneLabel.text = [NSString stringWithFormat:@"%d", two];
//    twoLabel.text = [NSString stringWithFormat:@"%d", two * 2];
//    
//   
//    
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate
- (void)yanchiHiden:(NSIndexPath *)index {
    oldshowButnIndex = 0;
    UITableViewCell *cell= [myTableView cellForRowAtIndexPath:index];
    if (cell) {
        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationNone];
        CP_CanOpenCell *cell2 = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:index];
        
        [cell2 hidenButonScollWithAnime:YES];
    }
}

//- (void)openCell:(CP_CanOpenCell *)cell{
//    
//    NSIndexPath *indexPath = nil;
//    GC_BetCell * jccell = (GC_BetCell *)cell;
//    
//    indexPath = [NSIndexPath indexPathForRow:jccell.row inSection:0];
//    
//    
//    cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
//    if (cell.butonScrollView.hidden == NO) {
//        
////        zhankai[indexPath.row] = 0;
//        [cell showButonScollWithAnime:NO];
//        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
//        [cell showButonScollWithAnime:NO];
//        [cell hidenButonScollWithAnime:YES];
//    }
//    else {
//        
////        zhankai[indexPath.row] = 1;
//        [myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        cell = (CP_CanOpenCell *)[myTableView cellForRowAtIndexPath:indexPath];
//        [cell hidenButonScollWithAnime:NO];
//        [cell showButonScollWithAnime:YES];
//    }
//    return;
//    
//    
//}
- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt{
    
    if (buttonIndex == 1) {
        
        NSArray * isar = [returnarry objectAtIndex:0];
        NSString * issues = [isar objectAtIndex:0];
        [self getFootballMatchRequest:issues];
        [self pressQingButton:nil];
        
        for (int i = 0; i < [issueArray count]; i++) {
            NSString * _issue = [issueArray objectAtIndex:i];
            if ([_issue isEqualToString:issues]) {
                issString = [issueArray objectAtIndex:i];
            }
        }

        
//        for (int i = 0; i < 14; i++) {
//            zhankai[i] = 0;
//        }
        
        [kongzhiType removeAllObjects];
        [kongzhiType addObjectsFromArray:kongt];
        [self stopTimeUpData];
    }
    
    
}
#pragma mark - CP_CanOpenCellDelegate
- (void)CP_CanOpenSelect:(CP_CanOpenCell *)cell WithSelectButonIndex:(NSInteger)Index {
    
    
    
    
    GC_BetCell * jccell = (GC_BetCell *)cell;
    if (cell.butonScrollView.contentOffset.x > 0) {
        [UIView beginAnimations:@"ndd" context:NULL];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        NSLog(@"!666666666666666666666666666666");
        cell.butonScrollView.contentOffset = CGPointMake(0, cell.butonScrollView.contentOffset.y);
        [UIView commitAnimations];
        GC_BetCell * jccell = (GC_BetCell *)cell;
        jccell.XIDANImageView.image = UIImageGetImageFromName(@"rangqiuguan.png");
        
        
    }
    if ([[cell.allTitleArray objectAtIndex:Index] isEqualToString:@"八方预测"]) {
        
        GC_BetData * be = [bettingArray objectAtIndex:jccell.row];
        [self NewAroundViewShowFunc:be indexPath:[NSIndexPath indexPathForRow:jccell.row inSection:0]];
        
        
        //        GC_BetData * be = [bettingArray objectAtIndex:jccell.row];
        //        if (castButton.enabled == YES) {
        //            if ([be.zlcString rangeOfString:@"-"].location != NSNotFound) {
        //                NeutralityMatchView * neutrality = [[NeutralityMatchView alloc] initWithBetData:be number:[NSString stringWithFormat:@"%d", jccell.row+1]] ;
        //                neutrality.delegate = self;
        //                [neutrality show];
        //                [neutrality release];
        //                return;
        //            }
        //        }
        
        
        
        
        //        NewAroundViewController * sachet = [[NewAroundViewController alloc] init];
        //        //        sachet.playID = @"234028"; //传入这两个对比赛的id
        //        //    NSArray * allke = [kebianzidian allKeys];
        //
        //
        //
        //        NSLog(@"%@", be.saishiid);
        //        sachet.playID = be.saishiid;
        //#ifdef isCaiPiaoForIPad
        //        [[caiboAppDelegate getAppDelegate] showInSencondView:sachet.view ViewControllor:sachet];
        //#else
        //        [self.navigationController pushViewController:sachet animated:YES];
        //#endif
        //        [sachet release];
        
        
        
    }
    else if ([[cell.allTitleArray objectAtIndex:Index] isEqualToString:@"胆"]) {
        
        
        if (one > 9) {
            
            GC_BetData * be = [bettingArray objectAtIndex:jccell.row];
            if (be.dandan == YES) {
                be.dandan = NO;
                //                UIButton * danbutton = (UIButton *) [jccell.butonScrollView viewWithTag:Index];
                //                //            danbutton.backgroundColor = [UIColor blackColor];
                //                //            [danbutton setImage:UIImageGetImageFromName(@"danzucai.png") forState:UIControlStateNormal];
                //                UIImageView * btnImage = (UIImageView *)[danbutton viewWithTag:10];
                //                btnImage.image = UIImageGetImageFromName(@"danzucai.png");
            }else{
                
                be.dandan = YES;
                
                
            }
            
//            [self returnBoolDan:be.dandan row:Index selctCell:cell];
        }else{
            
            caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
            [cai showMessage:@"需要选择10场以上比赛，才可以进行设胆操作。"];
            
            
        }
        
        
        
    }
    
    
}
#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    [super viewDidUnload];
}


- (void)dealloc {
    [staArray release];
    [ContentOffDict release];
    [issueTypeArray release];
    [kongzhiType release];
    [txtImage release];
    [fbTextView release];
    [titleLabel release];
    [bettingArray release];
    [issueArray release];
    [imgev release];
    [bgview release];
    [httpRequest clearDelegatesAndCancel]; [httpRequest release];
    [tabView release];
    [dataArray release];
    [betArray release];
    [request clearDelegatesAndCancel];
    self.request = nil;
    
    [oneLabel release];
    [twoLabel release];
   [myTableView release];
    //[pkArray release];
   // [betdata release];
    [sanjiaoImageView release];
    [super dealloc];
}

-(void)footballForecastBetData:(GC_BetData *)_betData withType:(NSInteger)type indexPath:(NSIndexPath *)fIndexPatch{
    
    //    if (type == 1) {
    [self returnCellInfo:fIndexPatch.row buttonBoll1:_betData.selection1 buttonBoll:_betData.selection2 buttonBoll:_betData.selection3 dan:_betData.dandan];
    //    }else if(type == 2){
    //        [self returnbifenCellInfo:fIndexPatch shuzu:_betData.bufshuarr dan:_betData.dandan];
    //
    //
    //    }
    
}
@end


int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    