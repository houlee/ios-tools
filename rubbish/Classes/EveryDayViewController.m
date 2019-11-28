//
//  EveryDayViewController.m
//  caibo
//
//  Created by GongHe on 13-12-30.
//
//

#import "EveryDayViewController.h"
#import "Info.h"
#import "ColorView.h"
#import "NewPostViewController.h"
#import "LoginViewController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "NetURL.h"
#import "EveryDayCellModel.h"
#import "DetailedViewController.h"
#import "TopicThemeListViewController.h"
#import "SendMicroblogViewController.h"
#import "MobClick.h"

#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)


@interface EveryDayViewController ()

@end

@implementation EveryDayViewController
@synthesize contentRequest,issueRequest,niceWeiBoRequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithIssue:(NSString *)issue
{
    self = [super init];
    if (self) {
        curIssue = issue;
        curIssue1 = issue;
        allIssueArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [mainTableView release];
    [blackView release];
    [backImageV release];
    [contentRequest clearDelegatesAndCancel];
    [issueRequest clearDelegatesAndCancel];
    [niceWeiBoRequest clearDelegatesAndCancel];
    [cellModel release];
    [allIssueArray release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.titleLabel.font = [UIFont boldSystemFontOfSize:17];
//    self.CP_navigation.titleLabel.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//    self.CP_navigation.titleLabel.shadowOffset = CGSizeMake(0, 1);
    
    UIImageView * bgview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgview.backgroundColor = [UIColor clearColor];
    bgview.image = UIImageGetImageFromName(@"login_bgn.png");
    [self.mainView addSubview:bgview];
    [bgview release];
    
    UIButton * titleButton = [[[UIButton alloc] init] autorelease];
    titleButton.backgroundColor = [UIColor clearColor];
    titleButton.tag = 1000;
    [titleButton addTarget:self action:@selector(changeTitle) forControlEvents:UIControlEventTouchUpInside];
    [self.CP_navigation addSubview:titleButton];
    
    UILabel * mainTitleLabel = [[[UILabel alloc] init] autorelease];
    mainTitleLabel.backgroundColor = [UIColor clearColor];
    mainTitleLabel.textColor = [UIColor whiteColor];
    mainTitleLabel.font = [UIFont boldSystemFontOfSize:17];
    mainTitleLabel.shadowColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    mainTitleLabel.shadowOffset = CGSizeMake(0, 1.0);
    mainTitleLabel.tag = 1001;
    mainTitleLabel.text = [NSString stringWithFormat:@"天天竞彩%@期",curIssue];
    [titleButton addSubview:mainTitleLabel];
    CGSize mainTitleLabelSize = [mainTitleLabel.text sizeWithFont:mainTitleLabel.font constrainedToSize:CGSizeMake(1000,44) lineBreakMode:NSLineBreakByWordWrapping];
    mainTitleLabel.frame = CGRectMake(0, 0, mainTitleLabelSize.width, 44);
    
    UIImageView * sanjiaoImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SanJiao.png"]] autorelease];
    sanjiaoImageView.tag = 1002;
    sanjiaoImageView.frame = CGRectMake(ORIGIN_X(mainTitleLabel) + 2, 14.5, 17, 17);
    [titleButton addSubview:sanjiaoImageView];
    
    titleButton.frame = CGRectMake((320 - ORIGIN_X(sanjiaoImageView))/2, 0, ORIGIN_X(sanjiaoImageView) + 2, 44);
    
    if ([curIssue length] > 0) {
        [self getContent];
        [self getIssue];
    }else{
    
        [self getIssue];
    
    }
    
    
//    [self aaa];
}

-(void)aaa
{
    NSString * ttwdStr = @"多德勒支继续领跑榜首  拉普学生主场强悍可期:1.66^斯文登^沃尔索^18^斯文登近期状态不错，主场10轮不败，欲全取三分/1.62^拉普学生^基而梅^68^拉普学生主场非常强悍，本赛季主场未败，本场主队会全力以赴";

    cellModel = [[EveryDayCellModel alloc] initWithString:ttwdStr];
    
    mainTableView = [[UITableView alloc] initWithFrame:self.mainView.bounds];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    [self.mainView addSubview:mainTableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (ttwdArr) {
//        if (section == 0) {
//            return [[ttwdArr objectAtIndex:1] componentsSeparatedByString:@"/"].count + 2;
//        }
//    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    
    EveryDayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[EveryDayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexPath:indexPath] autorelease];
    }
    cell.titleLabel1.text = cellModel.titleStr;
    return cell;
}

- (void)pressWriteButton:(UIButton *)sender{
//    NewPostViewController *publishController = [[NewPostViewController alloc] init];
//	publishController.publishType = kNewTopicController;// 自发彩博
//    [self.navigationController pushViewController:publishController animated:YES];
//	[publishController release];
    
    [MobClick event:@"event_gonglue_tiantian_faweibo"];
    SendMicroblogViewController *publishController = [[SendMicroblogViewController alloc] init];
    publishController.microblogType = NewTopicController;// 自发彩博
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:publishController];
    [self presentViewController:nav animated: YES completion:nil];
    [publishController release];
    [nav release];
}

- (void)hasLogin {
    [self changeTitleButtonFrame:320];
    
    UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthItem.bounds = CGRectMake(0, 0, 60, 44);
    [rigthItem setImage:UIImageGetImageFromName(@"wb_write_normal.png") forState:UIControlStateNormal];
    [rigthItem setImage:UIImageGetImageFromName(@"wb_write_selected.png") forState:UIControlStateHighlighted];
    [rigthItem addTarget:self action:@selector(pressWriteButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rigthItemButton = [[[UIBarButtonItem alloc] initWithCustomView:rigthItem] autorelease];
    self.CP_navigation.rightBarButtonItem = rigthItemButton;
}

-(void)changeTitleButtonFrame:(float)width
{
    UIButton * titleButton = (UIButton *)[self.CP_navigation viewWithTag:1000];
    UILabel * titleLabel = (UILabel *)[self.CP_navigation viewWithTag:1001];
    UIImageView * sanjiaoImageView = (UIImageView *)[self.CP_navigation viewWithTag:1002];
    
    CGSize titleLabelSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(1000,44) lineBreakMode:NSLineBreakByWordWrapping];
    titleLabel.frame = CGRectMake(0, 0, titleLabelSize.width, 44);
    sanjiaoImageView.frame = CGRectMake(ORIGIN_X(titleLabel) + 2, 14.5, 17, 17);
    titleButton.frame = CGRectMake((width - ORIGIN_X(sanjiaoImageView))/2, 0, ORIGIN_X(sanjiaoImageView) + 2, 44);
}

-(void)changeTitle
{
    if (!blackView) {
        blackView = [[UIView alloc] initWithFrame:self.mainView.window.frame];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.7;
    }
    [self.mainView.window addSubview:blackView];
    
    if (!backImageV) {
        backImageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, 300, 465)];
        if (IS_IOS7) {
            backImageV.frame = CGRectMake(10, 20, 300, 465);
        }
        backImageV.image = UIImageGetImageFromName(@"TYHBG960-1.png");
        backImageV.userInteractionEnabled = YES;
        
        UIImageView *titleImage = [[[UIImageView alloc] initWithFrame:CGRectMake(87.5, -3, 125, 30)] autorelease];
        titleImage.image = UIImageGetImageFromName(@"TYCD960.png");
        [backImageV addSubview:titleImage];
        
        UILabel *titleLable = [[[UILabel alloc] initWithFrame:titleImage.bounds] autorelease];
        titleLable.text = @"期数选择";
        [titleImage addSubview:titleLable];
        titleLable.textAlignment = 1;
        titleLable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        titleLable.font = [UIFont boldSystemFontOfSize:12];
        titleLable.shadowColor = [UIColor whiteColor];
        titleLable.shadowOffset = CGSizeMake(0, 1.0);
        titleLable.backgroundColor = [UIColor clearColor];
        
        UIImageView *infoImage = [[[UIImageView alloc] initWithFrame:CGRectMake(22, 50, 256, 338)] autorelease];
        infoImage.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        infoImage.tag = 111;
        infoImage.userInteractionEnabled = YES;
        [backImageV addSubview:infoImage];
        
        float height = 20;
        
        if (allIssueArray.count == 0) {
            
        }else{
            for (int i = 0; i < allIssueArray.count; i++) {
                UIButton * periodButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20 + i * 53, 216, 33)];
                periodButton.tag = [[allIssueArray objectAtIndex:i] integerValue];
                periodButton.adjustsImageWhenHighlighted = NO;
                [periodButton setTitle:[NSString stringWithFormat:@"天天竞彩%ld期",(long)periodButton.tag] forState:UIControlStateNormal];
                if ([[NSString stringWithFormat:@"天天竞彩%@期",curIssue] isEqualToString:periodButton.titleLabel.text]) {
                    periodButton.selected = YES;
                }
                periodButton.titleLabel.font = [UIFont systemFontOfSize:12];
                [periodButton setTitleColor:[UIColor colorWithRed:9/255.0 green:57/255.0 blue:72/255.0 alpha:1] forState:UIControlStateNormal];
                [periodButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [periodButton setBackgroundImage:UIImageGetImageFromName(@"PeriodButton.png") forState:UIControlStateNormal];
                [periodButton setBackgroundImage:UIImageGetImageFromName(@"PeriodButton_HL.png") forState:UIControlStateSelected];
                [periodButton addTarget:self action:@selector(changePeriod:) forControlEvents:UIControlEventTouchUpInside];
                [infoImage addSubview:periodButton];
                [periodButton release];
                
                height = ORIGIN_Y(periodButton) + 20;
            }
        }
        infoImage.frame = CGRectMake(22, 50, 256, height);
        
        CP_PTButton * cancelButton = [[[CP_PTButton alloc] initWithFrame:CGRectMake(30, ORIGIN_Y(infoImage) + 20, 110, 33)] autorelease];
        [cancelButton loadButonImage:@"TYD960.png" LabelName:@"取消"];
        [cancelButton addTarget:self action:@selector(cancelChange) forControlEvents:UIControlEventTouchUpInside];
        [backImageV addSubview:cancelButton];
        
        CP_PTButton * finishButton = [[[CP_PTButton alloc] initWithFrame:CGRectMake(160, ORIGIN_Y(infoImage) + 20, 110, 33)] autorelease];
        [finishButton loadButonImage:@"TYD960.png" LabelName:@"完成"];
        [finishButton addTarget:self action:@selector(finishChange) forControlEvents:UIControlEventTouchUpInside];
        [backImageV addSubview:finishButton];
        
        backImageV.frame = CGRectMake(10, 40, 300, ORIGIN_Y(cancelButton) + 20);
        titleImage.frame = CGRectMake(87.5, -2, 125, 30);
    }
    [self.mainView.window addSubview:backImageV];
}

-(void)finishChange
{
    for (CP_PTButton * btn in [[backImageV viewWithTag:111] subviews]) {
        if (btn.selected == 1) {
            if (btn.tag != [curIssue integerValue]) {
                curIssue1 = [[NSString stringWithFormat:@"%ld",(long)btn.tag] retain];
                [self getContent];
            }
        }
    }
    [self cancelChange];
}

-(void)cancelChange
{
    [blackView removeFromSuperview];
    [backImageV removeFromSuperview];
}

-(void)changePeriod:(UIButton *)button
{
    UIImageView * infoImage = (UIImageView *)[backImageV viewWithTag:111];
    for (UIButton * selectedButton in infoImage.subviews) {
        if (selectedButton.tag == button.tag) {
            selectedButton.selected = YES;
        }else{
            selectedButton.selected = NO;
        }
    }
}

-(void)getIssue
{
    [issueRequest clearDelegatesAndCancel];
    self.issueRequest = [ASIHTTPRequest requestWithURL:[NetURL getEverydayIssue]];
    [issueRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [issueRequest setDelegate:self];
    [issueRequest setDidFinishSelector:@selector(getIssueFinish:)];
    [issueRequest setNumberOfTimesToRetryOnTimeout:2];
    [issueRequest startAsynchronous];
}

- (void)getContent{
    [contentRequest clearDelegatesAndCancel];
    self.contentRequest = [ASIHTTPRequest requestWithURL:[NetURL getEverydayContentWithIssue:curIssue1]];
    [contentRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [contentRequest setDelegate:self];
    [contentRequest setDidFinishSelector:@selector(getContentFinish:)];
    [contentRequest setNumberOfTimesToRetryOnTimeout:2];
    [contentRequest startAsynchronous];
}

-(void)getIssueFinish:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    if(responseString){
        NSMutableArray *array = [responseString JSONValue];
        for (NSDictionary * dic in array) {
            [allIssueArray addObject:[dic valueForKey:@"issue"]];
        }
//        [allIssueArray addObject:@"20140116"];
//        [allIssueArray addObject:@"20140116"];
//        [allIssueArray addObject:@"20140116"];
//        [allIssueArray addObject:@"20140116"];
//        [allIssueArray addObject:@"20140116"];
        
        if ([curIssue length] == 0) {
            if ([allIssueArray count] > 0) {
                curIssue = [allIssueArray objectAtIndex:0];
                curIssue1 = [allIssueArray objectAtIndex:0];
                [self getContent];
            }
            
        }
        
    }
}

-(void)getContentFinish:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSLog(@"%@",responseString);
    if (responseString) {
        curIssue = curIssue1;
        
        NSDictionary *responseDic = [responseString JSONValue];
        NSLog(@"responseDic =   %@",responseDic);
        
        NSString * ttwdStr = [responseDic valueForKey:@"ttwd"];//天天稳胆
        NSArray * ttwdArr = [ttwdStr componentsSeparatedByString:@":"];
        NSString * ttwdTitleStr = @"";
        NSMutableArray * ttwdContentArr = [[[NSMutableArray alloc] init] autorelease];
        if (ttwdArr.count > 1) {
            ttwdTitleStr = [ttwdArr objectAtIndex:0];
            for (NSString * str in [[ttwdArr objectAtIndex:1] componentsSeparatedByString:@"/"]) {
                if (![str isEqualToString:@""] && [[str componentsSeparatedByString:@"^"] count] > 4) {
                    [ttwdContentArr addObject:[str componentsSeparatedByString:@"^"]];
                }
            }
        }
        
        NSString * chuanStr = [responseDic valueForKey:@"mr4x1"];
//        NSString * chuanStr = @"周一竞彩4串1：厄斯特保级期 斯塔费主场不败:周一001^沙尔克^切尔西^平 3.35   负 2.05/周一003^AC米兰^巴萨^胜 2.10/周一008^AC米兰^巴萨^负 1.40/周一010^考文垂^东方^平 3.35   负 2.05";
        NSArray * chuanArr = [chuanStr componentsSeparatedByString:@":"];
        NSString * chuanTitleStr = @"";
        NSMutableArray * chuanContentArr = [[[NSMutableArray alloc] init] autorelease];
        if (chuanArr.count > 1) {
            chuanTitleStr = [chuanArr objectAtIndex:0];
            for (NSString * str in [[chuanArr objectAtIndex:1] componentsSeparatedByString:@"/"]) {
                if (![str isEqualToString:@""] && [[str componentsSeparatedByString:@"^"] count] > 3) {
                    [chuanContentArr addObject:[str componentsSeparatedByString:@"^"]];
                }
            }
        }
        
        NSString * lmssStr = [responseDic valueForKey:@"lmss"];
        NSArray * lmssArr = [lmssStr componentsSeparatedByString:@":"];
        NSString * lmssTitleStr = @"";
        NSMutableArray * lmssContentArr = [[[NSMutableArray alloc] init] autorelease];
        if (lmssArr.count > 1) {
            lmssTitleStr = [lmssArr objectAtIndex:0];
            for (NSString * str in [[lmssArr objectAtIndex:1] componentsSeparatedByString:@"/"]) {
                if (![str isEqualToString:@""] && [[str componentsSeparatedByString:@"^"] count] > 4) {
                    [lmssContentArr addObject:[str componentsSeparatedByString:@"^"]];
                }
            }
        }
        
        NSString * tthdStr = [responseDic valueForKey:@"tthd"];
        NSArray * tthdArr = [tthdStr componentsSeparatedByString:@":"];
        
        //    NSString * issue = @"20140113";
        //    curIssue = [NSString stringWithFormat:@"天天竞彩%@期",issue];
        float originY = 0;
        
        UILabel * titleLabel = (UILabel *)[self.CP_navigation viewWithTag:1001];
        titleLabel.text = [NSString stringWithFormat:@"天天竞彩%@期",curIssue];
        
        Info *info1 = [Info getInstance];
        if (![info1.userId intValue]) {
            [self changeTitleButtonFrame:300];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasLogin) name:@"hasLogin" object:nil];
            
            self.CP_navigation.rightBarButtonItem = [Info itemInitWithTitle:@"登录注册" Target:self action:@selector(presszhuce:) ImageName:@"anniubgimage.png"Size:CGSizeMake(70,30)];
        }
        else {
            [self hasLogin];
        }
        
        if ([self.mainView viewWithTag:2014]) {
            [[self.mainView viewWithTag:2014] removeFromSuperview];
        }

        UIScrollView * mainScrollView = [[[UIScrollView alloc] initWithFrame:self.mainView.bounds] autorelease];
        mainScrollView.tag = 2014;
        [self.mainView addSubview:mainScrollView];
        
        UIImageView * wenTopImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(12, 11, 296, 25)] autorelease];
        wenTopImageView.image = UIImageGetImageFromName(@"WenDanTop.png");
        [mainScrollView addSubview:wenTopImageView];
        
        UILabel * wenTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(23, 0, 100, 25)] autorelease];
        wenTitleLabel.text = @"天天稳胆";
        wenTitleLabel.font = [UIFont systemFontOfSize:15];
        wenTitleLabel.textColor = [UIColor whiteColor];
        wenTitleLabel.textAlignment = 0;
        wenTitleLabel.backgroundColor = [UIColor clearColor];
        [wenTopImageView addSubview:wenTitleLabel];
        
        UIImageView * wenTitleImageView = [[[UIImageView alloc] init] autorelease];
        wenTitleImageView.image = UIImageGetImageFromName(@"EverydayWhiteBG.png");
        [mainScrollView addSubview:wenTitleImageView];
        wenTitleImageView.backgroundColor = [UIColor clearColor];
        
        UILabel * wenTitleLabel1 = [[[UILabel alloc] init] autorelease];
        wenTitleLabel1.textAlignment = 0;
        wenTitleLabel1.font = [UIFont boldSystemFontOfSize:12];
        wenTitleLabel1.lineBreakMode = 0;
        wenTitleLabel1.numberOfLines = 0;
        wenTitleLabel1.backgroundColor = [UIColor clearColor];
        [wenTitleImageView addSubview:wenTitleLabel1];
        wenTitleLabel1.text = ttwdTitleStr;
        CGSize wenTitleLabelSize = [wenTitleLabel1.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(275,2000) lineBreakMode:NSLineBreakByWordWrapping];
        wenTitleLabel1.frame = CGRectMake(9.5, 10, 275, wenTitleLabelSize.height);
        
        wenTitleImageView.frame = CGRectMake(12, ORIGIN_Y(wenTopImageView), 296, ORIGIN_Y(wenTitleLabel1) + 10);
        
        UIImageView * wenVerticalImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 1.5, 3, wenTitleImageView.frame.size.height - 1.5)] autorelease];
        wenVerticalImageView.image = UIImageGetImageFromName(@"WenDanVerticalLine.png");
        [wenTitleImageView addSubview:wenVerticalImageView];
        
        UIImageView * wenHorizontalLine = [[[UIImageView alloc] initWithFrame:CGRectMake(11, wenTitleImageView.frame.size.height - 0.5, 274, 0.5)] autorelease];
        wenHorizontalLine.image = UIImageGetImageFromName(@"CommonHorizontal.png");
        [wenTitleImageView addSubview:wenHorizontalLine];
        
        if (ttwdContentArr.count != 0) {
            for (int i = 0; i < ttwdContentArr.count; i++) {
                UIImageView * wenDetailImageView = [[UIImageView alloc] init];
                wenDetailImageView.backgroundColor = [UIColor clearColor];
                wenDetailImageView.image = UIImageGetImageFromName(@"EverydayWhiteBG.png");
                [mainScrollView addSubview:wenDetailImageView];
                [wenDetailImageView release];
                
                NSArray * winArr = [[[ttwdContentArr objectAtIndex:i] objectAtIndex:0] componentsSeparatedByString:@","];
                NSMutableArray * winArr1 = [[NSMutableArray alloc] init];
                for (NSString * str in winArr) {
                    if (![str isEqualToString:@""]) {
                        [winArr1 addObject:str];
                    }
                }
                for (int j = 0; j < winArr1.count; j++) {
                    if (j <= 1) {
                        UIImageView * winImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 8.5 + j * 20, 42.5, 16)];
                        if (winArr1.count == 1) {
                            winImageView.frame = CGRectMake(11, 21, 42.5, 16);
                        }
                        winImageView.image = UIImageGetImageFromName(@"EverydayWin.png");
                        [wenDetailImageView addSubview:winImageView];
                        [winImageView release];
                        
                        UILabel * winLabel = [[UILabel alloc] initWithFrame:winImageView.bounds];
                        [winImageView addSubview:winLabel];
                        winLabel.textColor = [UIColor whiteColor];
                        winLabel.backgroundColor = [UIColor clearColor];
                        winLabel.textAlignment = 1;
                        winLabel.font = [UIFont systemFontOfSize:11];
                        winLabel.text = [winArr1 objectAtIndex:j];
                        [winLabel release];
                    }
                }
                
                
                UILabel * vsLabel = [[UILabel alloc] initWithFrame:CGRectMake(138, 23, 20, 14)];
                [wenDetailImageView addSubview:vsLabel];
                vsLabel.textColor = [UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1];
                vsLabel.backgroundColor = [UIColor clearColor];
                vsLabel.textAlignment = 1;
                vsLabel.font = [UIFont systemFontOfSize:11];
                vsLabel.text = @"VS";
                [vsLabel release];
                
                UILabel * teamNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 19, 85, 20)];
                [wenDetailImageView addSubview:teamNameLabel];
                teamNameLabel.textColor = [UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1];
                teamNameLabel.backgroundColor = [UIColor clearColor];
                teamNameLabel.textAlignment = 2;
                teamNameLabel.font = [UIFont systemFontOfSize:14];
                teamNameLabel.text = [[ttwdContentArr objectAtIndex:i] objectAtIndex:1];
                [teamNameLabel release];
                
                UILabel * teamNameLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(156, 19, 85, 20)];
                [wenDetailImageView addSubview:teamNameLabel1];
                teamNameLabel1.textColor = [UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1];
                teamNameLabel1.backgroundColor = [UIColor clearColor];
                teamNameLabel1.textAlignment = 0;
                teamNameLabel1.font = [UIFont systemFontOfSize:14];
                teamNameLabel1.text = [[ttwdContentArr objectAtIndex:i] objectAtIndex:2];
                [teamNameLabel1 release];
                
                UIImageView * probabilityImageView = [[UIImageView alloc] initWithFrame:CGRectMake(240, 6.5, 39.5, 39.5)];
                probabilityImageView.image = UIImageGetImageFromName(@"ProbabilityBlue.png");
                if (i == 1) {
                    probabilityImageView.image = UIImageGetImageFromName(@"ProbabilityOrange.png");
                }
                [wenDetailImageView addSubview:probabilityImageView];
                [probabilityImageView release];
                
                UILabel * percentNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 10, 25, 20)];
                [probabilityImageView addSubview:percentNumLabel];
                percentNumLabel.textColor = [UIColor whiteColor];
                percentNumLabel.backgroundColor = [UIColor clearColor];
                percentNumLabel.textAlignment = 0;
                percentNumLabel.font = [UIFont boldSystemFontOfSize:22];
                NSString * percentStr = [[ttwdContentArr objectAtIndex:i] objectAtIndex:3];
                if ([[percentStr substringFromIndex:[percentStr length] - 1] isEqualToString:@"%"]) {
                    percentNumLabel.text = [percentStr substringToIndex:[percentStr length] - 1];
                }else{
                    percentNumLabel.text = percentStr;
                }
                [percentNumLabel release];
                
                UILabel * percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 13, 15, 15)];
                [probabilityImageView addSubview:percentLabel];
                percentLabel.textColor = [UIColor whiteColor];
                percentLabel.backgroundColor = [UIColor clearColor];
                percentLabel.textAlignment = 1;
                percentLabel.font = [UIFont systemFontOfSize:9];
                percentLabel.text = @"%";
                [percentLabel release];
                
                UILabel * explanationLabel1 = [[UILabel alloc] init];
                [wenDetailImageView addSubview:explanationLabel1];
                explanationLabel1.backgroundColor = [UIColor clearColor];
                explanationLabel1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                explanationLabel1.font = [UIFont systemFontOfSize:11];
                explanationLabel1.lineBreakMode = NSLineBreakByWordWrapping;
                explanationLabel1.numberOfLines = 0;
                explanationLabel1.text = [NSString stringWithFormat:@"%@",[[ttwdContentArr objectAtIndex:i] objectAtIndex:4]];
                CGSize explanationSize = [explanationLabel1.text sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(274,2000) lineBreakMode:NSLineBreakByWordWrapping];
                explanationLabel1.frame = CGRectMake(11, 52, 274, explanationSize.height);
                [explanationLabel1 release];
                
                wenDetailImageView.frame = CGRectMake(12, ORIGIN_Y(wenTitleImageView) + originY, 296, 60.5 + explanationLabel1.frame.size.height);
                if (i == ttwdContentArr.count - 1) {
                    wenDetailImageView.image = [UIImageGetImageFromName(@"EverydayWhiteBG1.png") stretchableImageWithLeftCapWidth:1 topCapHeight:8];
                }else{
                    UIImageView * dottedlineImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(11, wenDetailImageView.frame.size.height - 0.5, 274, 0.5)];
                    dottedlineImageVIew.image = UIImageGetImageFromName(@"Dottedline.png");
                    [wenDetailImageView addSubview:dottedlineImageVIew];
                    [dottedlineImageVIew release];
                }
                
                originY += wenDetailImageView.frame.size.height;
            }
            originY += wenTopImageView.frame.size.height + wenTitleImageView.frame.size.height  + 30.5;
        }else{
            originY = 11;
        }
        
        UIImageView * chuanTopImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(12, originY, 296, 25)] autorelease];
        chuanTopImageView.image = UIImageGetImageFromName(@"ChuanTop.png");
        [mainScrollView addSubview:chuanTopImageView];
        
        UILabel * chuanTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(23, 0, 100, 25)] autorelease];
        chuanTitleLabel.text = @"每日四串一";
        chuanTitleLabel.font = [UIFont systemFontOfSize:15];
        chuanTitleLabel.textColor = [UIColor whiteColor];
        chuanTitleLabel.textAlignment = 0;
        chuanTitleLabel.backgroundColor = [UIColor clearColor];
        [chuanTopImageView addSubview:chuanTitleLabel];
        
        UIImageView * chuanTitleImageView = [[[UIImageView alloc] init] autorelease];
        chuanTitleImageView.image = UIImageGetImageFromName(@"EverydayWhiteBG.png");
        [mainScrollView addSubview:chuanTitleImageView];
        chuanTitleImageView.backgroundColor = [UIColor clearColor];
        
        UILabel * chuanTitleLabel1 = [[[UILabel alloc] init] autorelease];
        chuanTitleLabel1.textAlignment = 0;
        chuanTitleLabel1.font = [UIFont boldSystemFontOfSize:12];
        chuanTitleLabel1.lineBreakMode = 0;
        chuanTitleLabel1.numberOfLines = 0;
        chuanTitleLabel1.backgroundColor = [UIColor clearColor];
        [chuanTitleImageView addSubview:chuanTitleLabel1];
        chuanTitleLabel1.text = chuanTitleStr;
        CGSize chuanTitleLabelSize = [chuanTitleLabel1.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(275,2000) lineBreakMode:NSLineBreakByWordWrapping];
        chuanTitleLabel1.frame = CGRectMake(9.5, 10, 275, chuanTitleLabelSize.height);
        
        chuanTitleImageView.frame = CGRectMake(12, ORIGIN_Y(chuanTopImageView), 296, ORIGIN_Y(chuanTitleLabel1) + 10);
        
        UIImageView * chuanVerticalImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 1.5, 3, chuanTitleImageView.frame.size.height - 1.5)] autorelease];
        chuanVerticalImageView.image = UIImageGetImageFromName(@"ChuanVerticalLine.png");
        [chuanTitleImageView addSubview:chuanVerticalImageView];
        
        if (chuanContentArr.count != 0) {
            for (int i = 0; i < 5; i++) {
                UIImageView * chuanDetailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(chuanTitleImageView) + 35 *i, 296, 35)];
                chuanDetailImageView.image = UIImageGetImageFromName(@"ChuanBG.png");
                if (i == 4) {
                    chuanDetailImageView.image = UIImageGetImageFromName(@"ChuanBG1.png");
                }
                [mainScrollView addSubview:chuanDetailImageView];
                [chuanDetailImageView release];
                
                UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 25, 28)];
                timeLabel.font = [UIFont systemFontOfSize:11];
                timeLabel.numberOfLines = 0;
                timeLabel.lineBreakMode = 0;
                timeLabel.textAlignment = 1;
                timeLabel.backgroundColor = [UIColor clearColor];
                timeLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                if (i == 0) {
                    timeLabel.textColor = [UIColor colorWithRed:255/255.0 green:0 blue:0 alpha:1];
                    timeLabel.text = @"时间";
                }else{
                    if ([chuanContentArr count] > i - 1) {
                        timeLabel.text = [[chuanContentArr objectAtIndex:i - 1] objectAtIndex:0];
                    }
                    
                }
                [chuanDetailImageView addSubview:timeLabel];
                [timeLabel release];
                
                UILabel * vsLabel = [[UILabel alloc] initWithFrame:CGRectMake(103.5, 8, 20, 20)];
                vsLabel.font = [UIFont systemFontOfSize:10];
                vsLabel.textAlignment = 1;
                vsLabel.backgroundColor = [UIColor clearColor];
                vsLabel.text = @"VS";
                vsLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                if (i == 0) {
                    vsLabel.textColor = [UIColor colorWithRed:255/255.0 green:0 blue:0 alpha:1];
                }
                [chuanDetailImageView addSubview:vsLabel];
                [vsLabel release];
                
                UILabel * hostName = [[UILabel alloc] initWithFrame:CGRectMake(45, 8.5, 57, 20)];
                hostName.font = [UIFont systemFontOfSize:11];
                hostName.textAlignment = 2;
                hostName.backgroundColor = [UIColor clearColor];
                hostName.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                if (i == 0) {
                    hostName.textColor = [UIColor colorWithRed:255/255.0 green:0 blue:0 alpha:1];
                    hostName.text = @"主";
                }else{
                    if ([chuanContentArr count] > i - 1 && [[chuanContentArr objectAtIndex:i - 1] count] > 1) {
                        hostName.text = [[chuanContentArr objectAtIndex:i - 1] objectAtIndex:1];
                    }
                    
                }
                [chuanDetailImageView addSubview:hostName];
                [hostName release];
                
                UILabel * awayName = [[UILabel alloc] initWithFrame:CGRectMake(126, 8.5, 57, 20)];
                awayName.font = [UIFont systemFontOfSize:11];
                awayName.textAlignment = 0;
                awayName.backgroundColor = [UIColor clearColor];
                awayName.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                if (i == 0) {
                    awayName.textColor = [UIColor colorWithRed:255/255.0 green:0 blue:0 alpha:1];
                    awayName.text = @"客";
                }else{
                    if ([chuanContentArr count] > i -1 && [[chuanContentArr objectAtIndex:i - 1] count] > 2) {
                        awayName.text = [[chuanContentArr objectAtIndex:i - 1] objectAtIndex:2];
                    }
                    
                }
                [chuanDetailImageView addSubview:awayName];
                [awayName release];
                
                UILabel * recommendLabel = [[UILabel alloc] initWithFrame:CGRectMake(198.5, 1, 83, 34)];
                recommendLabel.font = [UIFont systemFontOfSize:11];
                recommendLabel.textAlignment = 1;
                recommendLabel.lineBreakMode = 0;
                recommendLabel.numberOfLines = 0;
                recommendLabel.backgroundColor = [UIColor clearColor];
                recommendLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                if (i == 0) {
                    recommendLabel.textColor = [UIColor colorWithRed:255/255.0 green:0 blue:0 alpha:1];
                    recommendLabel.text = @"投注推荐(主队)";
                }else{
                    if ([chuanContentArr count] > i -1 && [[chuanContentArr objectAtIndex:i - 1] count] > 3) {
                        recommendLabel.text = [[chuanContentArr objectAtIndex:i - 1] objectAtIndex:3];
                    }
                    
                }
                [chuanDetailImageView addSubview:recommendLabel];
                [recommendLabel release];
                
                originY += chuanDetailImageView.frame.size.height;
            }
            originY += chuanTopImageView.frame.size.height + chuanTitleImageView.frame.size.height + 19.5;
        }
        
        UIImageView * lengTopImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(12, originY, 296, 25)] autorelease];
        lengTopImageView.image = UIImageGetImageFromName(@"LengTop.png");
        [mainScrollView addSubview:lengTopImageView];
        
        UILabel * lengTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(23, 0, 100, 25)] autorelease];
        lengTitleLabel.text = @"冷门搜索";
        lengTitleLabel.font = [UIFont systemFontOfSize:15];
        lengTitleLabel.textColor = [UIColor whiteColor];
        lengTitleLabel.textAlignment = 0;
        lengTitleLabel.backgroundColor = [UIColor clearColor];
        [lengTopImageView addSubview:lengTitleLabel];
        
        UIImageView * lengTitleImageView = [[[UIImageView alloc] init] autorelease];
        lengTitleImageView.image = UIImageGetImageFromName(@"EverydayWhiteBG.png");
        [mainScrollView addSubview:lengTitleImageView];
        lengTitleImageView.backgroundColor = [UIColor clearColor];
        
        UILabel * lengTitleLabel1 = [[[UILabel alloc] init] autorelease];
        lengTitleLabel1.textAlignment = 0;
        lengTitleLabel1.font = [UIFont boldSystemFontOfSize:12];
        lengTitleLabel1.lineBreakMode = 0;
        lengTitleLabel1.numberOfLines = 0;
        lengTitleLabel1.backgroundColor = [UIColor clearColor];
        [lengTitleImageView addSubview:lengTitleLabel1];
        lengTitleLabel1.text = lmssTitleStr;
        CGSize lengTitleLabelSize = [lengTitleLabel1.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(275,2000) lineBreakMode:NSLineBreakByWordWrapping];
        lengTitleLabel1.frame = CGRectMake(9.5, 10, 275, lengTitleLabelSize.height);
        
        lengTitleImageView.frame = CGRectMake(12, ORIGIN_Y(lengTopImageView), 296, ORIGIN_Y(lengTitleLabel1) + 10);
        
        UIImageView * lengVerticalImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 1.5, 3, lengTitleImageView.frame.size.height - 1.5)] autorelease];
        lengVerticalImageView.image = UIImageGetImageFromName(@"LengVerticalLine.png");
        [lengTitleImageView addSubview:lengVerticalImageView];
        
        UIImageView * lengHorizontalLine = [[[UIImageView alloc] initWithFrame:CGRectMake(11, lengTitleImageView.frame.size.height - 0.5, 274, 0.5)] autorelease];
        lengHorizontalLine.image = UIImageGetImageFromName(@"CommonHorizontal.png");
        [lengTitleImageView addSubview:lengHorizontalLine];
        
        for (int i = 0; i < lmssContentArr.count; i++) {
            UIImageView * lengDetailImageView = [[UIImageView alloc] init];
            lengDetailImageView.backgroundColor = [UIColor clearColor];
            lengDetailImageView.image = UIImageGetImageFromName(@"EverydayWhiteBG.png");
            [mainScrollView addSubview:lengDetailImageView];
            [lengDetailImageView release];
            
            NSArray * winArr = [[[lmssContentArr objectAtIndex:i] objectAtIndex:0] componentsSeparatedByString:@","];
            NSMutableArray * winArr1 = [[NSMutableArray alloc] init];
            for (NSString * str in winArr) {
                if (![str isEqualToString:@""]) {
                    [winArr1 addObject:str];
                }
            }
            for (int j = 0; j < winArr1.count; j++) {
                if (j <= 1) {
                    UIImageView * winImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 8.5 + j * 20, 42.5, 16)];
                    if (winArr1.count == 1) {
                        winImageView.frame = CGRectMake(11, 21, 42.5, 16);
                    }
                    winImageView.image = UIImageGetImageFromName(@"EverydayWin.png");
                    [lengDetailImageView addSubview:winImageView];
                    [winImageView release];
                    
                    UILabel * winLabel = [[UILabel alloc] initWithFrame:winImageView.bounds];
                    [winImageView addSubview:winLabel];
                    winLabel.textColor = [UIColor whiteColor];
                    winLabel.backgroundColor = [UIColor clearColor];
                    winLabel.textAlignment = 1;
                    winLabel.font = [UIFont systemFontOfSize:11];
                    winLabel.text = [winArr1 objectAtIndex:j];
                    [winLabel release];
                }
            }
            [winArr1 release];
            UILabel * vsLabel = [[UILabel alloc] initWithFrame:CGRectMake(138, 23, 20, 14)];
            [lengDetailImageView addSubview:vsLabel];
            vsLabel.textColor = [UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1];
            vsLabel.backgroundColor = [UIColor clearColor];
            vsLabel.textAlignment = 1;
            vsLabel.font = [UIFont systemFontOfSize:11];
            vsLabel.text = @"VS";
            [vsLabel release];
            
            UILabel * teamNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 19, 85, 20)];
            [lengDetailImageView addSubview:teamNameLabel];
            teamNameLabel.textColor = [UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1];
            teamNameLabel.backgroundColor = [UIColor clearColor];
            teamNameLabel.textAlignment = 2;
            teamNameLabel.font = [UIFont systemFontOfSize:14];
            teamNameLabel.text = [[lmssContentArr objectAtIndex:i] objectAtIndex:1];
            [teamNameLabel release];
            
            UILabel * teamNameLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(156, 19, 85, 20)];
            [lengDetailImageView addSubview:teamNameLabel1];
            teamNameLabel1.textColor = [UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1];
            teamNameLabel1.backgroundColor = [UIColor clearColor];
            teamNameLabel1.textAlignment = 0;
            teamNameLabel1.font = [UIFont systemFontOfSize:14];
            teamNameLabel1.text = [[lmssContentArr objectAtIndex:i] objectAtIndex:2];
            [teamNameLabel1 release];
            
            UIImageView * probabilityImageView = [[UIImageView alloc] initWithFrame:CGRectMake(240, 6.5, 39.5, 39.5)];
            probabilityImageView.image = UIImageGetImageFromName(@"ProbabilityYellow.png");
            if (i == 1) {
                probabilityImageView.image = UIImageGetImageFromName(@"ProbabilityGreen.png");
            }
            [lengDetailImageView addSubview:probabilityImageView];
            [probabilityImageView release];
            
            UILabel * percentNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 10, 25, 20)];
            [probabilityImageView addSubview:percentNumLabel];
            percentNumLabel.textColor = [UIColor whiteColor];
            percentNumLabel.backgroundColor = [UIColor clearColor];
            percentNumLabel.textAlignment = 0;
            percentNumLabel.font = [UIFont boldSystemFontOfSize:22];
            NSString * percentStr = [[lmssContentArr objectAtIndex:i] objectAtIndex:3];
            if ([[percentStr substringFromIndex:[percentStr length] - 1] isEqualToString:@"%"]) {
                percentNumLabel.text = [percentStr substringToIndex:[percentStr length] - 1];
            }else{
                percentNumLabel.text = percentStr;
            }
            [percentNumLabel release];
            
            UILabel * percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 13, 15, 15)];
            [probabilityImageView addSubview:percentLabel];
            percentLabel.textColor = [UIColor whiteColor];
            percentLabel.backgroundColor = [UIColor clearColor];
            percentLabel.textAlignment = 1;
            percentLabel.font = [UIFont systemFontOfSize:9];
            percentLabel.text = @"%";
            [percentLabel release];
            
            UILabel * explanationLabel1 = [[UILabel alloc] init];
            [lengDetailImageView addSubview:explanationLabel1];
            explanationLabel1.backgroundColor = [UIColor clearColor];
            explanationLabel1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            explanationLabel1.font = [UIFont systemFontOfSize:11];
            explanationLabel1.lineBreakMode = NSLineBreakByWordWrapping;
            explanationLabel1.numberOfLines = 0;
            explanationLabel1.text = [NSString stringWithFormat:@"%@",[[lmssContentArr objectAtIndex:i] objectAtIndex:4]];
            CGSize explanationSize = [explanationLabel1.text sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(274,2000) lineBreakMode:NSLineBreakByWordWrapping];
            explanationLabel1.frame = CGRectMake(11, 52, 274, explanationSize.height);
            [explanationLabel1 release];
            
            lengDetailImageView.frame = CGRectMake(12, lengTopImageView.frame.size.height + lengTitleImageView.frame.size.height + originY, 296, 60.5 + explanationLabel1.frame.size.height);
            if (i == ttwdContentArr.count - 1) {
                lengDetailImageView.image = [UIImageGetImageFromName(@"EverydayWhiteBG1.png") stretchableImageWithLeftCapWidth:1 topCapHeight:8];
            }else{
                UIImageView * dottedlineImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(11, lengDetailImageView.frame.size.height - 0.5, 274, 0.5)];
                dottedlineImageVIew.image = UIImageGetImageFromName(@"Dottedline.png");
                [lengDetailImageView addSubview:dottedlineImageVIew];
                [dottedlineImageVIew release];
            }
            originY += lengDetailImageView.frame.size.height;
        }
        originY += lengTopImageView.frame.size.height + lengTitleImageView.frame.size.height + 19.5;
        
        UIImageView * niceTopImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(12, originY, 296, 25)] autorelease];
        niceTopImageView.image = UIImageGetImageFromName(@"NiceTop.png");
        [mainScrollView addSubview:niceTopImageView];
        
        UILabel * niceTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(23, 0, 100, 25)] autorelease];
        niceTitleLabel.text = @"天天好单";
        niceTitleLabel.font = [UIFont systemFontOfSize:15];
        niceTitleLabel.textColor = [UIColor whiteColor];
        niceTitleLabel.textAlignment = 0;
        niceTitleLabel.backgroundColor = [UIColor clearColor];
        [niceTopImageView addSubview:niceTitleLabel];
        
        UIButton * niceDetailButton = [[UIButton alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(niceTopImageView), 296, 52)];
        [mainScrollView addSubview:niceDetailButton];
        [niceDetailButton setBackgroundImage:[UIImageGetImageFromName(@"EverydayWhiteBG1.png") stretchableImageWithLeftCapWidth:1 topCapHeight:8] forState:UIControlStateNormal];
        if (tthdArr.count >= 2) {
            niceDetailButton.tag = [[tthdArr objectAtIndex:1] integerValue];
        }else{
            niceDetailButton.tag = 999;
        }
        [niceDetailButton addTarget:self action:@selector(toNiceWeiBo:) forControlEvents:UIControlEventTouchUpInside];
        [niceDetailButton release];
        
        UILabel * niceDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(31.5, 0, 202.5, 50)];
        niceDetailLabel.font = [UIFont systemFontOfSize:14];
        niceDetailLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        niceDetailLabel.backgroundColor = [UIColor clearColor];
        niceDetailLabel.textAlignment = 1;
        if (tthdArr.count >= 2) {
            niceDetailLabel.text = [tthdArr objectAtIndex:0];
        }else{
            niceDetailLabel.text = @"";
        }
        [niceDetailButton addSubview:niceDetailLabel];
        [niceDetailLabel release];
        
        UIImageView * niceArrow = [[UIImageView alloc] initWithFrame:CGRectMake(257.5, 19.5, 8.5, 13)];
        niceArrow.image = UIImageGetImageFromName(@"NiceArrow.png");
        [niceDetailButton addSubview:niceArrow];
        [niceArrow release];
        
        originY += niceDetailButton.frame.size.height;
        
//        for (int i = 0; i < tthdArr.count; i++) {
//            UIButton * niceDetailButton = [[UIButton alloc] initWithFrame:CGRectMake(12, ORIGIN_Y(niceTopImageView) + 52 * i, 296, 52)];
//            [mainScrollView addSubview:niceDetailButton];
//            if (i == tthdArr.count - 1) {
//                [niceDetailButton setBackgroundImage:[UIImageGetImageFromName(@"EverydayWhiteBG1.png") stretchableImageWithLeftCapWidth:1 topCapHeight:8] forState:UIControlStateNormal];
//            }else{
//                [niceDetailButton setBackgroundImage:UIImageGetImageFromName(@"EverydayWhiteBG.png") forState:UIControlStateNormal];
//                
//                UIImageView * niceLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, niceDetailButton.frame.size.height - 0.5, 296, 0.5)];
//                niceLine.image = UIImageGetImageFromName(@"NiceHorizontal.png");
//                [niceDetailButton addSubview:niceLine];
//                [niceLine release];
//            }
//            niceDetailButton.tag = [[[tthdArr objectAtIndex:i] componentsSeparatedByString:@":"] objectAtIndex:1];
//            [niceDetailButton addTarget:self action:@selector(toNiceWeiBo:) forControlEvents:UIControlEventTouchUpInside];
//            [niceDetailButton release];
//            
//            UILabel * niceDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(31.5, 0, 202.5, 50)];
//            niceDetailLabel.font = [UIFont systemFontOfSize:14];
//            niceDetailLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//            niceDetailLabel.backgroundColor = [UIColor clearColor];
//            niceDetailLabel.textAlignment = 1;
//            niceDetailLabel.text = [[[tthdArr objectAtIndex:i] componentsSeparatedByString:@":"] objectAtIndex:0];
//            [niceDetailButton addSubview:niceDetailLabel];
//            [niceDetailLabel release];
//            
//            UIImageView * niceArrow = [[UIImageView alloc] initWithFrame:CGRectMake(257.5, 19.5, 8.5, 13)];
//            niceArrow.image = UIImageGetImageFromName(@"NiceArrow.png");
//            [niceDetailButton addSubview:niceArrow];
//            [niceArrow release];
//            
//            originY += niceDetailButton.frame.size.height;
//        }
        originY += niceTopImageView.frame.size.height + 34;
        
        UIView *  hotView = [[[UIView alloc] initWithFrame:CGRectMake(11, originY, 296, 87.5)] autorelease];
        hotView.backgroundColor = [UIColor clearColor];
        [mainScrollView addSubview:hotView];
        
        UIImageView * hotDotImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(11.5, 5.5, 5.5, 5.5)] autorelease];
        hotDotImageView.image = UIImageGetImageFromName(@"HotDot.png");
        [hotView addSubview:hotDotImageView];
        
        UILabel * hotTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(23, 0, 60, 15)] autorelease];
        hotTitleLabel.text = @"微博热议";
        hotTitleLabel.font = [UIFont systemFontOfSize:15];
        hotTitleLabel.textAlignment = 0;
        hotTitleLabel.backgroundColor = [UIColor clearColor];
        [hotView addSubview:hotTitleLabel];
        
        UIImageView * hotHorizontalLine = [[[UIImageView alloc] initWithFrame:CGRectMake(88.5, 8.5, 205, 0.5)] autorelease];
        hotHorizontalLine.image = UIImageGetImageFromName(@"HotHorizontal.png");
        [hotView addSubview:hotHorizontalLine];
        
        UIButton * hotButton = [[[UIButton alloc] initWithFrame:CGRectMake(40.5, 45, 217, 42.5)] autorelease];
        [hotButton setBackgroundImage:UIImageGetImageFromName(@"HotButton.png") forState:UIControlStateNormal];
        hotButton.titleLabel.font = [UIFont systemFontOfSize:15];
        hotButton.tag = curIssue;
        [hotButton setTitle:[NSString stringWithFormat:@"#天天竞彩%@#",curIssue] forState:UIControlStateNormal];
        [hotView addSubview:hotButton];
        [hotButton addTarget:self action:@selector(toHot:) forControlEvents:UIControlEventTouchUpInside];
        
        mainScrollView.contentSize = CGSizeMake(320, ORIGIN_Y(hotView) + 61);
    }
}

- (void)presszhuce:(UIButton *)sender{
    LoginViewController * loginVC = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
    [loginVC setIsShowDefultAccount:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
}

-(void)toNiceWeiBo:(UIButton *)button
{
    if (button.tag != 999) {
        [MobClick event:@"event_gonglue_tiantian_xiqun"];
        [niceWeiBoRequest clearDelegatesAndCancel];
        self.niceWeiBoRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:[NSString stringWithFormat:@"%ld",(long)button.tag]]];
        [niceWeiBoRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [niceWeiBoRequest setDelegate:self];
        [niceWeiBoRequest setDidFinishSelector:@selector(niceWeiBoInfo:)];
        [niceWeiBoRequest setTimeOutSeconds:20.0];
        [niceWeiBoRequest startAsynchronous];
    }
    return;
}

-(void)niceWeiBoInfo:(ASIHTTPRequest *)request
{
    NSString *result = [request responseString];
    YtTopic *mStatus = [[YtTopic alloc] initWithParse:result];
    
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus arrayList] objectAtIndex:0]];
    [detailed setHidesBottomBarWhenPushed:NO];
    [self.navigationController pushViewController:detailed animated:YES];
    [detailed release];
    
    [mStatus release];
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

-(void)toHot:(UIButton *)button
{
    Info *info2 = [Info getInstance];
    if (![info2.userId intValue]) {;
        [self doLogin];
        return;
    }
    [MobClick event:@"event_gonglue_tiantian_reyi"];
    TopicThemeListViewController *topicThemeListVC = [[TopicThemeListViewController alloc] initWithUserId:[[Info getInstance] userId] themeId:[NSString stringWithFormat:@"%d",(int)button.tag] themeName:button.titleLabel.text];
    topicThemeListVC.cpsanliu = CpSanLiuWuyes;
    
    [self.navigationController pushViewController:topicThemeListVC animated:YES];
    [topicThemeListVC release];
}

-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    