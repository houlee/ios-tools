//
//  footballLotteryInfoViewController.m
//  caibo
//
//  Created by houchenguang on 13-6-19.
//
//

#import "footballLotteryInfoViewController.h"
#import "Info.h"
#import "NetURL.h"
#import "JSON.h"
#import "allOddsData.h"
#import "ColorView.h"
#import "MobClick.h"

@interface footballLotteryInfoViewController ()

@end

@implementation footballLotteryInfoViewController
@synthesize mRequest;
@synthesize lotteryAll;
@synthesize issueString;
@synthesize selectButton;

- (void)titleLabelColoerFunc{
    
    NSInteger ncount = 0;
    if (lotteryAll == jingcaizuqiuType || lotteryAll == beijingdanchangType) {
        ncount = 5;
    }else if (lotteryAll == jingcailanqiuType){
        ncount = 4;
        
    }
    //选中对应的label变色
    for (int i = 0; i < ncount; i++){
        UILabel * allLabel = (UILabel *)[upimageview viewWithTag:i+1];
//        allLabel.textColor = [UIColor colorWithRed:157/255.0 green:230/255.0 blue:249/255.0 alpha:1];
        allLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    }
    
    
}

- (void)shaixuanzidian:(NSMutableArray *)arrayce{//排序
    if ([arrayce count] == 0) {
        return;
    }
    
    [dataArray removeAllObjects];
    
    footballLotterData * tistr = [arrayce objectAtIndex:0];
    
    NSMutableArray * timesarrstr = [[NSMutableArray alloc] initWithCapacity:0];
    NSString * timebijiao = [[tistr.endTime componentsSeparatedByString:@" "] objectAtIndex:0] ;
    
    [timesarrstr addObject:timebijiao];
    //                int timecout = 0;
    
    for (int i = 0; i < [arrayce count]; i++) {
        
        footballLotterData * betstr = [arrayce objectAtIndex:i];
        NSString * zhouji = [[betstr.endTime componentsSeparatedByString:@" "] objectAtIndex:0];//[betstr.numzhou substringToIndex:2];
        BOOL yiybool = NO;
        for (int j = 0; j < [timesarrstr count]; j++) {
            NSString * namezou = [timesarrstr objectAtIndex:j];
            if ([namezou isEqualToString:zhouji]) {
                yiybool = YES;
            }
        }
        if (![timebijiao isEqualToString:zhouji]) {
            if (yiybool == NO) {
                timebijiao = [[betstr.endTime componentsSeparatedByString:@" "] objectAtIndex:0];//[betstr.numzhou substringToIndex:2];
                
                [timesarrstr addObject:timebijiao];
                
            }
            
        }
        
        
    }
    //   NSMutableArray * arrtimezou = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    //    NSMutableArray * timecountarr = [[NSMutableArray alloc] initWithCapacity:0];
    NSLog(@"time = %lu", (unsigned long)[timesarrstr count]);
    for (int i = 0;  i < [timesarrstr count]; i++) {
        NSLog(@"tinme = %@", [timesarrstr objectAtIndex:i]);
        NSMutableArray * dicarr = [[NSMutableArray alloc] initWithCapacity:0];
        NSString * timestin = [timesarrstr  objectAtIndex:i];
        
        for (int j = 0; j < [arrayce count]; j++) {
            
            footballLotterData * betstr = [arrayce objectAtIndex:j];
            NSString * zhouji = [[betstr.endTime componentsSeparatedByString:@" "] objectAtIndex:0];//[betstr.numzhou substringToIndex:2];
            if ([timestin isEqualToString:zhouji]) {
                //                            timecout += 1;
                [dicarr addObject:betstr];
            }
            
        }
        if ([dicarr count] > 0) {
            NSLog(@"timestin = %@", timestin);
            //  [kebianzidian setObject:dicarr forKey:timestin];
            [dataArray addObject:dicarr];
            
            
        }
        [dicarr release];
        //                    [timecountarr addObject:[NSString stringWithFormat:@"%d", timecout]];
        
    }
    NSLog(@"time arr = %@", timesarrstr);
    
    [timesarrstr release];
    
    
}


//赛事筛选
- (void)saiShiScreen{
    [saiShiArray removeAllObjects];
    
    footballLotterData * betda = [allDataArray objectAtIndex:0];
    
    if([betda.shortMatchName length] > 5){
        
        betda.shortMatchName = [betda.shortMatchName substringToIndex:5];
    }
    [saiShiArray addObject:betda.shortMatchName];
    
    
    for (int i = 0; i < [allDataArray count]; i++) {
        BOOL xiangtong = NO;
        footballLotterData * begc = [allDataArray objectAtIndex:i];
        for (int j = 0; j < [saiShiArray count]; j++) {
            
            NSString * sai = [saiShiArray objectAtIndex:j];
            if([begc.shortMatchName length] > 5){
                
                begc.shortMatchName = [begc.shortMatchName substringToIndex:5];
            }
            if([sai length] > 5){
                
                sai = [sai substringToIndex:5];
            }
            
            if ([begc.shortMatchName isEqualToString:sai]) {
                xiangtong = YES;
            }
        }
        if (xiangtong != YES) {
            if([begc.shortMatchName length] > 5){
                
                begc.shortMatchName = [begc.shortMatchName substringToIndex:5];
            }
            [saiShiArray addObject:begc.shortMatchName];
        }
        
        
    }
    NSLog(@"saishi = %@", saiShiArray);
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString*)getLotteryId:(lotteryAllType)index
{
    //    if (index == 1) {
    //        return @"300";
    //    }
    //    else
    
    if (index == jingcaizuqiu) {
        return @"201_kaijiang";
    }
    else if (index == beijingdanchang) {
        return @"400_kaijiang";
    }else if(index == jingcailanqiu){
        return @"200_kaijiang";
    }
    return @"";
}

- (void)headLabelFunc{
    
    
//    upimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 26)];
    upimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    upimageview.backgroundColor = [UIColor clearColor];
//    upimageview.image = UIImageGetImageFromName(@"TopBlueBG.png");
    upimageview.backgroundColor=[UIColor colorWithRed:61/255.0 green:61/255.0 blue:61/255.0 alpha:1];
    [self.mainView addSubview:upimageview];
    [upimageview release];
    
    UILabel * saishila = [[UILabel alloc] init];
    saishila.backgroundColor = [UIColor clearColor];
    saishila.font = [UIFont systemFontOfSize:8];
//    saishila.font = [UIFont systemFontOfSize:10];
//    saishila.textColor = [UIColor colorWithRed:157/255.0 green:230/255.0 blue:249/255.0 alpha:1];
    saishila.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    saishila.textAlignment = NSTextAlignmentCenter;
    saishila.tag = 1;
    //    saishila.text = @"赛事";
    [upimageview addSubview:saishila];
    [saishila release];
    
    
//    UIImageView * shuimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopBlueShuXian.png"]];
    UIImageView * shuimage = [[UIImageView alloc] init];
    shuimage.backgroundColor=[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    [upimageview addSubview:shuimage];
    [shuimage release];
    
    UILabel * shengla = [[UILabel alloc] init];
    shengla.backgroundColor = [UIColor clearColor];
    shengla.font = [UIFont systemFontOfSize:8];
//    shengla.font = [UIFont systemFontOfSize:10];
    shengla.tag = 2;
//    shengla.textColor = [UIColor colorWithRed:157/255.0 green:230/255.0 blue:249/255.0 alpha:1];
    shengla.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    shengla.textAlignment = NSTextAlignmentCenter;
    //    shengla.text = @"胜";
    [upimageview addSubview:shengla];
    [shengla release];
    
//    UIImageView * shuimage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopBlueShuXian.png"]];
    UIImageView * shuimage2 = [[UIImageView alloc] init];
    shuimage2.backgroundColor=[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    [upimageview addSubview:shuimage2];
    [shuimage2 release];
    
    UILabel * pingla = [[UILabel alloc] init];
    pingla.backgroundColor = [UIColor clearColor];
    pingla.font = [UIFont systemFontOfSize:8];
//    pingla.font = [UIFont systemFontOfSize:10];
    pingla.tag = 3;
//    pingla.textColor = [UIColor colorWithRed:157/255.0 green:230/255.0 blue:249/255.0 alpha:1];
    pingla.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    pingla.textAlignment = NSTextAlignmentCenter;
    //    pingla.text = @"平(让球)";
    [upimageview addSubview:pingla];
    [pingla release];
    
//    UIImageView * shuimage3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopBlueShuXian.png"]];
    UIImageView * shuimage3 = [[UIImageView alloc] init];
    shuimage3.backgroundColor=[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    [upimageview addSubview:shuimage3];
    [shuimage3 release];
    
    UILabel * fula = [[UILabel alloc] init];
    fula.backgroundColor = [UIColor clearColor];
    fula.font = [UIFont systemFontOfSize:8];
//    fula.font = [UIFont systemFontOfSize:10];
    fula.tag = 4;
//    fula.textColor = [UIColor colorWithRed:157/255.0 green:230/255.0 blue:249/255.0 alpha:1];
    fula.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    fula.textAlignment = NSTextAlignmentCenter;
    //    fula.text = @"负";
    [upimageview addSubview:fula];
    [fula release];
    
//    UIImageView * shuimage4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopBlueShuXian.png"]];
    UIImageView * shuimage4 = [[UIImageView alloc] init];
    shuimage4.backgroundColor=[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    [upimageview addSubview:shuimage4];
    [shuimage4 release];
    
    UILabel * houla = [[UILabel alloc] init];
    houla.backgroundColor = [UIColor clearColor];
    houla.font = [UIFont systemFontOfSize:8];
//    houla.font = [UIFont systemFontOfSize:10];
    houla.tag = 5;
//    houla.textColor = [UIColor colorWithRed:157/255.0 green:230/255.0 blue:249/255.0 alpha:1];
    houla.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1];
    houla.textAlignment = NSTextAlignmentCenter;
    //    houla.text = @"负";
    [upimageview addSubview:houla];
    [houla release];
    
    //    lotteryAll = jingcailanqiuType;
    if (lotteryAll == jingcaizuqiuType) {
        
//        saishila.frame = CGRectMake(62, 0, 42, 26);
//        shuimage.frame = CGRectMake(106, 6, 1, 14);
//        shengla.frame = CGRectMake(109, 0, 42, 26);
//        shuimage2.frame =  CGRectMake(153, 6, 1, 14);
//        pingla.frame = CGRectMake(156, 0, 42, 26);
//        shuimage3.frame = CGRectMake(200, 6, 1, 14);
//        fula.frame = CGRectMake(203, 0, 42, 26);
//        shuimage4.frame = CGRectMake(247, 6, 1, 14);
//        houla.frame = CGRectMake(249, 0, 42, 26);
        saishila.frame = CGRectMake(62, 0, 42, 30);
        shuimage.frame = CGRectMake(106, 6, 1, 18);
        shengla.frame = CGRectMake(109, 0, 42, 30);
        shuimage2.frame =  CGRectMake(153, 6, 1, 18);
        pingla.frame = CGRectMake(156, 0, 42, 30);
        shuimage3.frame = CGRectMake(200, 6, 1, 18);
        fula.frame = CGRectMake(203, 0, 42, 30);
        shuimage4.frame = CGRectMake(247, 6, 1, 18);
        houla.frame = CGRectMake(249, 0, 50, 30);
        saishila.text = @"胜平负";
        shengla.text = @"让球胜平负";
        pingla.text = @"比   分";
        fula.text = @"总进球";
        houla.text = @"半全场胜平负";
        
    }else if (lotteryAll == jingcailanqiuType) {
        
//        saishila.frame = CGRectMake(61, 0, 55, 26);
//        shuimage.frame = CGRectMake(117, 6, 1, 14);
//        shengla.frame = CGRectMake(120, 0, 55, 26);
//        shuimage2.frame =  CGRectMake(177, 6, 1, 14);
//        pingla.frame = CGRectMake(181, 0, 55, 26);
//        shuimage3.frame = CGRectMake(237, 6, 1, 14);
//        fula.frame = CGRectMake(239, 0, 55, 26);
        saishila.frame = CGRectMake(61, 0, 55, 30);
        shuimage.frame = CGRectMake(117, 6, 1, 18);
        shengla.frame = CGRectMake(120, 0, 55, 30);
        shuimage2.frame =  CGRectMake(177, 6, 1, 18);
        pingla.frame = CGRectMake(181, 0, 55, 30);
        shuimage3.frame = CGRectMake(237, 6, 1, 18);
        fula.frame = CGRectMake(239, 0, 55, 30);
        //        shuimage4.frame = CGRectMake(218, 6, 1, 14);
        //        houla.frame = CGRectMake(219, 0, 9, 26);
        saishila.text = @"胜分差";
        shengla.text = @"大小分";
        pingla.text = @"让球胜负";
        fula.text = @"胜   负";
        //        houla.text = @"负";
        houla.hidden = YES;
        shuimage4.hidden = YES;
        
    }else if (lotteryAll == beijingdanchangType){
        
//        saishila.frame = CGRectMake(62, 0, 42, 26);
//        shuimage.frame = CGRectMake(106, 6, 1, 14);
//        shengla.frame = CGRectMake(108, 0, 42, 26);
//        shuimage2.frame =  CGRectMake(153, 6, 1, 14);
//        pingla.frame = CGRectMake(156, 0, 42, 26);
//        shuimage3.frame = CGRectMake(200, 6, 1, 14);
//        fula.frame = CGRectMake(203, 0, 42, 26);
//        shuimage4.frame = CGRectMake(247, 6, 1, 14);
//        houla.frame = CGRectMake(250, 0, 42, 26);
        saishila.frame = CGRectMake(62, 0, 42, 30);
        shuimage.frame = CGRectMake(106, 6, 1, 18);
        shengla.frame = CGRectMake(108, 0, 42, 30);
        shuimage2.frame =  CGRectMake(153, 6, 1, 18);
        pingla.frame = CGRectMake(156, 0, 42, 30);
        shuimage3.frame = CGRectMake(200, 6, 1, 18);
        fula.frame = CGRectMake(203, 0, 42, 30);
        shuimage4.frame = CGRectMake(247, 6, 1, 18);
        houla.frame = CGRectMake(250, 0, 42, 30);
        saishila.text = @"让球胜平负";
        shengla.text = @"上下盘单双";
        pingla.text = @"半全胜平负";
        fula.text = @"比   分";
        houla.text = @"总进球";
        
        
    }
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    oneBool = YES;
    
    if (lotteryAll == jingcailanqiuType) {
        self.CP_navigation.title = @"竞彩篮球开奖";
        [MobClick event:@"event_kaijiang_detail_caizhong" label:@"竞彩篮球"];
    }else if(lotteryAll == jingcaizuqiuType){
        self.CP_navigation.title = @"竞彩足球开奖";
        [MobClick event:@"event_kaijiang_detail_caizhong" label:@"竞彩足球"];
    }else if(lotteryAll == beijingdanchang){
        self.CP_navigation.title = @"北京单场开奖";
        [MobClick event:@"event_kaijiang_detail_caizhong" label:@"北京单场"];
    }
    
//    issueString = @"2013-06-17";
    selectButton = @"";
    buffer[0] = 1;
    issueDictArray = [[NSMutableArray alloc] initWithCapacity:0];
    dateStringArray = [[NSMutableArray alloc] initWithCapacity:0];
    kongzhiType = [[NSMutableArray alloc] initWithCapacity:0];
    issueArray = [[NSMutableArray alloc] initWithCapacity:0];
    duoXuanArr = [[NSMutableArray alloc] initWithCapacity:0];
    allDataArray = [[NSMutableArray alloc] initWithCapacity:0];
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    saiShiArray = [[NSMutableArray alloc] initWithCapacity:0];;
    //背景
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgImageView.backgroundColor = [UIColor clearColor];
//    bgImageView.image = UIImageGetImageFromName(@"login_bgn.png") ;
    bgImageView.backgroundColor=[UIColor colorWithRed:239/255.0 green:238/255.0 blue:226/255.0 alpha:1];
    [self.mainView addSubview:bgImageView];
    [bgImageView release];
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(20, 0, 40, 44);
    
    
//    [btn setImage:UIImageGetImageFromName(@"chaodancaidan_2.png") forState:UIControlStateSelected];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan1.png") forState:UIControlStateNormal];
    [btn setImage:UIImageGetImageFromName(@"chaodancaidan2.png") forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
    
   
  
    
    
    
//    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 26, 320, self.mainView.frame.size.height-26) style:UITableViewStylePlain];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, 320, self.mainView.frame.size.height-30) style:UITableViewStylePlain];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.mainView addSubview:myTableView];
    [myTableView release];
    
    //彩种ID（300-足彩，400单场，201竞彩）
    self.mRequest = [ASIHTTPRequest requestWithURL: [NetURL CBgetIssueList:[self getLotteryId:lotteryAll]]];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDelegate:self];
    [mRequest setDidFinishSelector:@selector(reqGetIssueListFinished:)];
    [mRequest setNumberOfTimesToRetryOnTimeout:2];
    [mRequest startAsynchronous];
    
    [self headLabelFunc];
    
    
    
    tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 36, 320, 23)];
    tishiLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
    tishiLabel.backgroundColor = [UIColor clearColor];
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    tishiLabel.font = [UIFont boldSystemFontOfSize:11];
    tishiLabel.text = @"当前日期没有比赛";
    tishiLabel.hidden = YES;
    [self.mainView addSubview:tishiLabel];
    [tishiLabel release];
    
}

- (void)matchFootball{
    //1是竟彩 2是足彩，3竟彩篮球
    NSLog(@"issuestring = %@", issueString);
    
    NSString * typestr = @"";
    if (lotteryAll == jingcaizuqiu) {
        typestr = @"4";
    }else if(lotteryAll == jingcailanqiu){
        typestr = @"5";
    }else if(lotteryAll == beijingdanchang){
        typestr = @"2";
    }
    
    if (oneBool) {//第一次进入 判断最近哪一期有数据 则请求哪一期数据
        for (int i = 0; i < [issueDictArray count]; i++) {
            NSString * firstDate = [[issueDictArray objectAtIndex:i] objectForKey:@"firstDate"];
            if (firstDate) {
                if ([firstDate isEqualToString:@"1"]) {
                    issueString = [[issueDictArray objectAtIndex:i] objectForKey:@"issue"];
                }
            }
        }
    }
    
    oneBool = NO;
    self.mRequest = [ASIHTTPRequest requestWithURL:[NetURL footballLotteryDatailType:typestr iussueString:issueString]];
    [mRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [mRequest setDelegate:self];
    [mRequest setDidFinishSelector:@selector(footballRequestFinsh:)];
    [mRequest setNumberOfTimesToRetryOnTimeout:2];
    [mRequest startAsynchronous];
    
}

- (void)reqGetIssueListFinished:(ASIHTTPRequest*)request
{
	NSString *responseStr = [request responseString];
	if (responseStr)
    {
        
        
        SBJSON *jsonParse = [[SBJSON alloc] init];
        NSArray *arr = [jsonParse objectWithString:responseStr];
        for (NSDictionary *dict in arr)
        {
            NSString *issue = [dict valueForKey:@"issue"];
            [issueArray addObject:issue];
            [issueDictArray addObject:dict];
        }
        [jsonParse release];
        NSLog(@"issue array = %@", issueArray);
        
        if (lotteryAll == jingcaizuqiuType || lotteryAll == jingcailanqiuType) {
            for (int i = 0; i < [issueArray count]; i++) {
                NSString * isstr = [issueArray objectAtIndex:i];
                NSArray * arraya = [isstr componentsSeparatedByString:@"-"];
                if (arraya.count < 3) {
                    arraya = [NSArray arrayWithObjects:@"",@"", nil];
                }
                NSString * datestr = [NSString stringWithFormat:@"%@月%@日", [arraya objectAtIndex:1], [arraya objectAtIndex:2]];
                [dateStringArray addObject:datestr];
            }
        }
        
        
        [self matchFootball];
	}
}

- (void)pressMenubutton:(UIButton *)sender{
    
    NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
    [allimage addObject:@"caidansssx.png"];
    
    if (lotteryAll == jingcaizuqiuType || lotteryAll == jingcailanqiuType) {
        [allimage addObject:@"shijianxuanzhe.png"];
    }else{
        [allimage addObject:@"shijianxuanzhe.png"];
    }
    
    
    NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
    [alltitle addObject:@"联赛筛选"];
    
    if (lotteryAll == jingcaizuqiuType || lotteryAll == jingcailanqiuType) {
//        [alltitle addObject:@"日期选择"];
        [alltitle addObject:@"期号选择"];
    }else{
//        [alltitle addObject:@"期号选择"];
        [alltitle addObject:@"日期选择"];
    }
    
    
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

- (void)pressIssueButton{
    //选择期数的ui
    
    NSMutableArray * array = [NSMutableArray array];
    
    
    NSString * str = @"时间";
    if (lotteryAll == beijingdanchang) {
        str = @"期号";
    }
    
    
    NSDictionary *dic;
    
    if (lotteryAll == jingcailanqiuType || lotteryAll == jingcaizuqiuType) {
        dic = [NSDictionary dictionaryWithObjectsAndKeys:str,@"title", dateStringArray,@"choose", nil];
    }else{
        dic = [NSDictionary dictionaryWithObjectsAndKeys:str,@"title", issueArray,@"choose", nil];
    }
    
    
    
    if ([kongzhiType count] == 0) {
        NSMutableArray * issarr = [NSMutableArray array];
        for (int i = 0; i < [issueArray count]; i++) {
            NSString * str = [issueArray objectAtIndex:i];
            if ([str isEqualToString:issueString]) {
                [issarr addObject:@"1"];
            }else{
                [issarr addObject:@"0"];
            }
            
        }
        
        NSMutableDictionary * type1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"期号",@"title",issarr,@"choose", nil];
        
        [kongzhiType addObject:type1];
        
    }
    
    
    [array addObject:dic];
    
    NSString * strr = @"时间选择";
    if (lotteryAll == beijingdanchang) {
        strr = @"期号选择";
    }
    
    CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:strr ChangCiTitle:@"" DataInfo:array kongtype:kongzhiType];
    alert2.delegate = self;
    alert2.tag = 20;
    [alert2 show];
    [alert2 release];
    
    
}


- (void)returnSelectIndex:(NSInteger)index{
    NSLog(@"index = %ld", (long)index);
    if (index == 0) {
        
        NSMutableArray *array = [NSMutableArray array];
        //        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSArray arrayWithObjects:@"让球", @"非让球",nil],@"choose", nil];
        
        
        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",[NSArray arrayWithObjects:@"全选",@"仅五大联赛",nil ], @"kongzhi", saiShiArray,@"choose",[NSArray arrayWithObjects:@"英超",@"德甲",@"西甲",@"意甲",@"法甲",@"英  超",@"德  甲",@"西  甲",@"意  甲",@"法  甲",nil] ,@"仅五大联赛", nil];
        
        if ([duoXuanArr count] == 0) {
            //            NSMutableDictionary * type1 = [NSDictionary dictionaryWithObjectsAndKeys:@"让球",@"title",[NSMutableArray arrayWithObjects:@"0", @"0",nil],@"choose", nil];
            
            
            NSMutableArray * countarr = [NSMutableArray array];
            for (int i = 0; i < [saiShiArray count]; i++) {
                [countarr addObject:@"1"];
            }
            
            NSMutableDictionary *type3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"比赛",@"title",countarr,@"choose", nil];
            
            //            [duoXuanArr addObject:type1];
            
            [duoXuanArr addObject:type3];
        }
        NSLog(@"%lu", (unsigned long)[duoXuanArr count]);
        
        //        [array addObject:dic];
        
        [array addObject:dic3];
        NSLog(@"duo = %@", duoXuanArr);
        CP_KindsOfChoose *alert2 = [[CP_KindsOfChoose alloc] initWithTitle:@"赛事筛选" ChangCiTitle:@"" DataInfo:array kongtype:duoXuanArr];
        alert2.delegate = self;
        alert2.tag = 30;
        alert2.duoXuanBool = YES;
        [alert2 show];
        [alert2 release];
        
        
    }else if (index == 1){
        
        [self pressIssueButton];
        
    }
}
- (void)sendButtonFunc:(NSMutableArray * )returnarry kongArray:(NSMutableArray *)kongt cpChooseView:(CP_KindsOfChoose*)chooseView{
    
    
    
    
    
    
}

- (void)CP_KindsOfChooseView:(CP_KindsOfChoose *)chooseView didDismissWithButtonIndex:(NSInteger)buttonIndex returnArray:(NSMutableArray *)returnarry kongtype:(NSMutableArray *)kongt{
    
    if (chooseView.tag == 30) {
        
        if (buttonIndex == 1) {
            
            NSArray * arrayz = [returnarry objectAtIndex:[returnarry count]-1];
            NSMutableArray * zhongjiecell = [NSMutableArray array];
            if ([arrayz count] == 0) {
                [zhongjiecell addObjectsFromArray:allDataArray];
            }else{
                
                for (int i = 0; i < [allDataArray count]; i++) {
                    footballLotterData * btd = [allDataArray objectAtIndex:i];
                    for (int k = 0; k < [arrayz count]; k++) {
                        NSLog(@"btd.event = %@, cell = %@", btd.shortMatchName, [arrayz objectAtIndex:k]);
                        if ([btd.shortMatchName isEqualToString:[arrayz objectAtIndex:k]]) {
                            [zhongjiecell addObject:btd];
                        }
                        
                    }
                }
                
                
            }
            [self shaixuanzidian:zhongjiecell];
            selectButton = @"0";
            [self titleLabelColoerFunc];
            [myTableView reloadData];
            
        }
        
        
    }else{
        
        NSArray * isar = [returnarry objectAtIndex:0];
        NSString * issues = [isar objectAtIndex:0];
        NSInteger countiss = 0;
        
        if (lotteryAll == jingcailanqiuType || lotteryAll == jingcaizuqiuType) {
            for (int i = 0; i < [dateStringArray count]; i++) {
                if ( [[dateStringArray objectAtIndex:i] isEqualToString:issues]) {
                    countiss = i;
                    break;
                }
            }
        }else{
            for (int i = 0; i < [issueArray count]; i++) {
                if ( [[issueArray objectAtIndex:i] isEqualToString:issues]) {
                    countiss = i;
                    break;
                }
            }
        }
        
        
        
        
        issueString = [issueArray objectAtIndex:countiss];
        
        
        NSLog(@"iss = %@", issueString);
        selectButton = @"0";
        [self titleLabelColoerFunc];
        [self matchFootball];//对阵
        
        
        
        
        
        
    }
    
}


- (void)footballRequestFinsh:(ASIHTTPRequest *)request{
    
    NSString *responseString = [request responseString];
    NSLog(@"respon1 = %@", responseString);
     [allDataArray removeAllObjects];
    [dataArray removeAllObjects];
    NSArray *array = [responseString JSONValue];
    if (responseString && [responseString length] > 2) {
        
        
        for (int i = 0; i < [array count]; i++) {//footballLotterData 包footButtonData 包 allOddsData
            footballLotterData * footData = [[footballLotterData alloc] init];
            
            NSDictionary * dict = [array objectAtIndex:i];
            footData.bifen = [dict objectForKey:@"bifen"];
            footData.matchGuestFull = [dict objectForKey:@"matchGuestFull"];
            footData.playid = [dict objectForKey:@"playid"];
            footData.sp_data = [dict objectForKey:@"sp_data"];
            footData.matchHome = [dict objectForKey:@"matchHome"];
            footData.matchHomeFull = [dict objectForKey:@"matchHomeFull"];
            footData.matchGuest = [dict objectForKey:@"matchGuest"];
            footData.shortMatchName = [dict objectForKey:@"shortMatchName"];
            footData.matchNo = [dict objectForKey:@"matchNo"];
            footData.endTime = [dict objectForKey:@"endTime"];
            footData.statatime = [dict objectForKey:@"statatime"];
            footData.rq = [dict objectForKey:@"rq"];
            footData.stop = [dict objectForKey:@"stop"];

//            //假
//            footData.sp_data = @"客6-10^3.55;大分 185.4|小分 184.5|小分 184.5|小分 184.5^1.75;主胜 -2.5|主负 -3.5^1.70;3^1.38";
            
            NSArray * timeArray = [footData.endTime componentsSeparatedByString:@" "];
            if (timeArray.count > 1) {
                footData.timeString = [timeArray objectAtIndex:1];
            }else{
                footData.timeString = @"";
            }
            
            if([footData.matchNo rangeOfString:@"周"].location != NSNotFound){
                footData.weekString = [footData.matchNo substringToIndex:2];
                footData.numString = [footData.matchNo substringWithRange:NSMakeRange(2, [footData.matchNo length] - 2)];
            }else{
                footData.weekString = @"";
                footData.numString = footData.matchNo;
            }
           
                       
            
            
            NSArray * sp_dataArray = [footData.sp_data  componentsSeparatedByString:@";"];
            
            NSMutableArray * shangArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i < [sp_dataArray count]; i++) {
                
                NSString * everData = [sp_dataArray objectAtIndex:i];
                NSArray * peiArray = [everData componentsSeparatedByString:@"^"];
                
                footButtonData * buttonData = [[footButtonData alloc] init];
                if (peiArray.count > 1) {
                  buttonData.peilv = [peiArray objectAtIndex:1];
                }
                
                
                if ([[peiArray objectAtIndex:0] rangeOfString:@"|"].location != NSNotFound) {//按钮多个数据时解析
                    
                    NSString * peilvString = [peiArray objectAtIndex:0];
                    //                NSArray * peilvArray = [peilvString componentsSeparatedByString:@" "];
                    NSArray * allpei = [peilvString componentsSeparatedByString:@"|"];
                    NSMutableArray * xiaArray = [[NSMutableArray alloc] initWithCapacity:0];
                    
                    for (int n = 0; n < [allpei count]; n++) {
                        
                        NSString * allstring = [allpei objectAtIndex:n];
                        NSArray * allPeiLvArr = [allstring componentsSeparatedByString:@"@"];
                        allOddsData * allodds = [[allOddsData alloc] init];
                        if ([allPeiLvArr count] > 1) {
                            allodds.caiguo = [allPeiLvArr objectAtIndex:0];
                            allodds.peilv = [allPeiLvArr objectAtIndex:1];
                        }

                        //                    [buttonData.footButtonArray addObject:allodds];
                        [xiaArray addObject:allodds ];
                        [allodds release];
                        
                    }
                    buttonData.footButtonArray = xiaArray;
                    
                    
                    
                }else{
                    buttonData.bifen = [peiArray objectAtIndex:0];//按钮一个数据时解析
                }
                
                //            [footData.buttonArray addObject:buttonData];
                buttonData.matchGuest = footData.matchGuest;
                buttonData.matchHome = footData.matchHome;
                [shangArray addObject:buttonData];
                [buttonData release];
            }
            
            
            footData.buttonArray = shangArray;
            [shangArray release];
            //        [dataArray addObject:footData];
            [allDataArray addObject:footData];
            
            [footData release];
        }
        
        
        [dataArray removeAllObjects];
        
        [self shaixuanzidian:allDataArray];
        
        
    
    }
    
    if ([array count]>0) {
        [self saiShiScreen];
        tishiLabel.hidden = YES;
    }else{
        tishiLabel.hidden = NO;
    }
    
    [myTableView reloadData];
    
    
}

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableView delegate dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
//    if (buffer[section] == 1) {
        NSMutableArray * allarr = [dataArray objectAtIndex:section];
        
        return [allarr count];
//    }else{
    
//        return 0;
//    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 72;
    return 105;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    
//    UIButton * bgheader = [UIButton buttonWithType:UIButtonTypeCustom];
//    bgheader.tag = section;
//    
//#ifdef isCaiPiaoForIPad
//    bgheader.frame = CGRectMake(0, 0, 390, 28);
//#else
//    bgheader.frame = CGRectMake(0, 0, 320, 28);
//#endif
//    bgheader.backgroundColor = [UIColor clearColor];
//    UIImageView *im = [[UIImageView alloc] initWithFrame:bgheader.frame];
//    im.backgroundColor = [UIColor clearColor];
//    if (buffer[section] == 0) {
//        im.image =[UIImageGetImageFromName(@"DHTY960.png") stretchableImageWithLeftCapWidth:1 topCapHeight:0];
//        
//    }else{
//        im.image =[UIImageGetImageFromName(@"DHTX960.png") stretchableImageWithLeftCapWidth:1 topCapHeight:0];
//        
//    }
//    [bgheader addSubview:im];
//    [im release];
//    [bgheader addTarget:self action:@selector(pressBgHeader:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UILabel * timelabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 294, 28)];
//    timelabel.textColor = [UIColor whiteColor];//[UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
//    timelabel.backgroundColor = [UIColor clearColor];
//    timelabel.textAlignment = NSTextAlignmentLeft;
//    timelabel.font = [UIFont boldSystemFontOfSize:11];
//    [bgheader addSubview:timelabel];
//    [timelabel release];
//    
//    
//    ColorView *yingfuLable = [[ColorView alloc] initWithFrame:CGRectMake(170, 7, 90, 28)];
//    //	yingfuLable.text = [NSString stringWithFormat:@"应付<%@>元,余额<%.2f>元",rengouText.text,[[GC_UserInfo sharedInstance].accountManage.accountBalance floatValue]];
//	yingfuLable.backgroundColor = [UIColor clearColor];
//	yingfuLable.font = [UIFont boldSystemFontOfSize:11];
//    yingfuLable.colorfont =  [UIFont boldSystemFontOfSize:11];
//	yingfuLable.changeColor = [UIColor redColor];
//	[bgheader addSubview:yingfuLable];
//	[yingfuLable release];
//    
//    if (buffer[section] == 0) {
//        timelabel.textColor = [UIColor blackColor];
//        yingfuLable.changeColor = [UIColor redColor];
//        yingfuLable.textColor = [UIColor blackColor];
//        
//    }else{
//        timelabel.textColor = [UIColor whiteColor];
//        yingfuLable.changeColor = [UIColor redColor];
//        yingfuLable.textColor = [UIColor whiteColor];
//    }
//    NSMutableArray * cellArr = [dataArray objectAtIndex:section];
//    footballLotterData * foot = [cellArr objectAtIndex:0];
//    NSArray * kongarr = [foot.endTime componentsSeparatedByString:@" "];
//    
//    NSArray * footArr = [[kongarr objectAtIndex:0] componentsSeparatedByString:@"-"];
//    
//    timelabel.text = [NSString stringWithFormat:@"%@年%@月%@日      %d场比赛", [footArr objectAtIndex:0], [footArr objectAtIndex:1],[footArr objectAtIndex:2], [cellArr count]];
//    
//    NSInteger stopCount = 0;
//    for (int i = 0; i < [cellArr count]; i++) {
//        footballLotterData * stopfoot = [cellArr objectAtIndex:i];
//        if ([stopfoot.stop isEqualToString:@"1"]) {
//            stopCount += 1;
//        }
//    }
//    
//    if (stopCount == [cellArr count]) {
//        yingfuLable.text = [NSString stringWithFormat:@"%d/%d", stopCount, [cellArr count]];
//    }else{
//        yingfuLable.text = [NSString stringWithFormat:@"<%d>/%d", stopCount, [cellArr count]];
//    }
//    
//    
//    return bgheader;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 28;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellid = @"cellid";
    footballLotteryCell * cell = (footballLotteryCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        
        if (lotteryAll == jingcailanqiu) {
            cell = [[[footballLotteryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid lotterType:jingcailanqiuType] autorelease];
            cell.backgroundColor = [UIColor clearColor];
        }else if(lotteryAll == jingcaizuqiu){
            cell = [[[footballLotteryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid lotterType:jingcaizuqiuType] autorelease];
            cell.backgroundColor = [UIColor clearColor];
        }else if(lotteryAll == beijingdanchang){
            cell = [[[footballLotteryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid lotterType:beijingdanchangType] autorelease];
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.delegate = self;
        
    }
    cell.selectIndexPath = indexPath;
    
    cell.selectButton = selectButton;
   
    NSMutableArray * allarray =  [dataArray objectAtIndex:indexPath.section];
    
    cell.footBallData = [allarray objectAtIndex:indexPath.row];
    
    
    
    return cell;
}

#pragma mark didSelectRowAtIndexPath

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)selectButtonReturn:(UIButton *)sender mutableArray:(NSMutableArray *)array index:(NSIndexPath *)index{
    
    self.selectButton = [NSString stringWithFormat:@"%ld", (long)sender.tag-10+1];
    
    [self titleLabelColoerFunc];
    
    UILabel * titleLabel = (UILabel *)[upimageview viewWithTag:sender.tag - 10 + 1];
    titleLabel.textColor = [UIColor whiteColor];
    
    
    footballLotterData * ball = [[dataArray objectAtIndex:index.section] objectAtIndex:index.row];
    ball.saveButton = array;
    
    [myTableView reloadData];
    
    
}

//- (void)pressBgHeader:(UIButton *)sender{
//    
//    
//    if (buffer[sender.tag] == 0) {
//        buffer[sender.tag] = 1;
//    }else{
//        buffer[sender.tag] = 0;
//        
//        
//    }
//    
//    [myTableView reloadData];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [issueDictArray release];
    [dateStringArray release];
    [kongzhiType release];
    [duoXuanArr release];
    [issueArray release];
    [mRequest clearDelegatesAndCancel];
    [mRequest release];
    [dataArray release];
    [allDataArray release];
    [saiShiArray release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    