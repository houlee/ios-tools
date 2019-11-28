//
//  ChampionViewController.m
//  caibo
//
//  Created by houchenguang on 14-5-29.
//
//

#import "ChampionViewController.h"
#import "Info.h"
#import "GC_HttpService.h"
#import "GC_ASIHTTPRequest+Header.h"
#import "caiboAppDelegate.h"
#import "YuJiJinE.h"
#import "GC_ShengfuInfoViewController.h"
#import "Xieyi365ViewController.h"
#import "MobClick.h"


@interface ChampionViewController ()

@end

@implementation ChampionViewController

@synthesize championType, endTime, curIssue, sessionNum, lotteryId;
@synthesize httpRequest, championData, yujirequest;

- (void)dealloc{
    [yujirequest clearDelegatesAndCancel];
    [yujirequest release];
    [championData release];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [lotteryId release];
    [sessionNum release];
    [endTime release];
    [curIssue release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)pressHelpButton:(UIButton *)button{
    
    Xieyi365ViewController * exp = [[Xieyi365ViewController alloc] init];

    if ([lotteryId  isEqualToString:@"20106"]) {
       exp.ALLWANFA = guanjunwanfaxy;
    }else if ([lotteryId  isEqualToString:@"20107"]){
       exp.ALLWANFA = guanyajunwanfaxy;
    }
    
    [self.navigationController pushViewController:exp animated:YES];
    [exp release];
}

- (void)returnSelectIndex:(NSInteger)index{
  if(index == 0){
        
        [self pressHelpButton:nil];
        
    }
}

//菜单按钮
- (void)pressMenubutton:(UIButton *)sender{
    
    NSMutableArray * allimage = [[NSMutableArray alloc] initWithCapacity:0];
    
    [allimage addObject:@"GC_sanjiShuoming.png"];
    
    NSMutableArray * alltitle = [[NSMutableArray alloc] initWithCapacity:0];
    
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


- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tabBarView{
    
   UIView * tabView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainView.frame.size.height - 44, 320, 44)];
    tabView.backgroundColor = [UIColor blackColor];
    
    UIButton * qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    qingbutton.frame = CGRectMake(12, 8, 30, 30);
    [qingbutton setImage:UIImageGetImageFromName(@"sjblajitong.png") forState:UIControlStateNormal];
    [qingbutton setImage:UIImageGetImageFromName(@"sjblajitong_1.png") forState:UIControlStateHighlighted];
    [qingbutton addTarget:self action:@selector(pressQingButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //放图片 图片上放label 显示投多少场
    
    UIImageView *zhubg = [[UIImageView alloc] initWithFrame:CGRectMake(52, 7, 62, 30)];
    zhubg.image = UIImageGetImageFromName(@"jiyuansjb.png");
    zhubg.userInteractionEnabled = YES;

    
    oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 4, 40, 11)];
    oneLabel.backgroundColor = [UIColor clearColor];
    oneLabel.textAlignment = NSTextAlignmentCenter;
    oneLabel.font = [UIFont systemFontOfSize:9];
    oneLabel.textColor = [UIColor blackColor];
    oneLabel.text = @"0";
    
    [zhubg addSubview:oneLabel];

    
    twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 18, 40, 11)];
    twoLabel.backgroundColor = [UIColor clearColor];
    twoLabel.textAlignment = NSTextAlignmentCenter;
    twoLabel.font = [UIFont systemFontOfSize:9];
    twoLabel.textColor = [UIColor blackColor];
    twoLabel.text = @"0";
    
    [zhubg addSubview:twoLabel];
    
    //场字
    UILabel * fieldLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 4, 20, 11)];
    fieldLable.text = @"注";
    fieldLable.textAlignment = NSTextAlignmentCenter;
    fieldLable.font = [UIFont systemFontOfSize:9];
    fieldLable.backgroundColor = [UIColor clearColor];
    fieldLable.textColor = [UIColor blackColor];
    [zhubg addSubview:fieldLable];
    //注字
    UILabel * pourLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 18, 20, 11)];
    pourLable.text = @"元";
    pourLable.textAlignment = NSTextAlignmentCenter;
    pourLable.font = [UIFont systemFontOfSize:9];
    pourLable.backgroundColor = [UIColor clearColor];
    pourLable.textColor = [UIColor blackColor];
    [zhubg addSubview:pourLable];
    
    //投注按钮背景
   
    
    
    //投注按钮
    castButton = [UIButton buttonWithType:UIButtonTypeCustom];
    castButton.frame = CGRectMake(230, 6, 80, 33);
    UIImageView * chuanimage1 = [[UIImageView alloc] initWithFrame:castButton.bounds];
    chuanimage1.backgroundColor = [UIColor clearColor];
    chuanimage1.image = [UIImageGetImageFromName(@"sjbxuanhaole.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [castButton addSubview:chuanimage1];
    [chuanimage1 release];
    [castButton addTarget:self action:@selector(pressCastButton:) forControlEvents:UIControlEventTouchUpInside];
    castButton.enabled = NO;
    castButton.alpha = 0.5;
    
    //按钮上的字
    UILabel * buttonLabel1 = [[UILabel alloc] initWithFrame:castButton.bounds];
    buttonLabel1.text = @"选好了";
    buttonLabel1.textAlignment = NSTextAlignmentCenter;
    buttonLabel1.backgroundColor = [UIColor clearColor];
    buttonLabel1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];

    buttonLabel1.font = [UIFont boldSystemFontOfSize:15];
    
    
    [castButton addSubview:buttonLabel1];
   
    [buttonLabel1 release];
    
    

    [tabView addSubview:zhubg];
    [zhubg release];
    [tabView addSubview:castButton];
    [tabView addSubview:qingbutton];
    [self.mainView addSubview:tabView];
    [tabView release];
    [fieldLable release];
    [pourLable release];

    

    
}

- (void)pressQingButton:(UIButton *)sender{//清按钮

    for (int i = 0; i < [self.championData.typeArray count]; i++) {
        [self.championData.typeArray replaceObjectAtIndex:i withObject:@"0"];
    }
    oneLabel.text = @"0";
    twoLabel.text = @"0";
    castButton.enabled = NO;
    castButton.alpha = 0.5;
    [myTableView reloadData];
    
}

- (NSString *)issueInfoReturn{
    
   
    
    if (self.championData && self.championData.typeArray) {
        NSMutableString * str = [[[NSMutableString alloc] init] autorelease];
        
        
            for (int i = 0; i < [self.championData.typeArray count]; i++) {
               
                
                if ([[self.championData.typeArray objectAtIndex:i] isEqualToString:@"1"]) {
                    
                    NSArray * numArray = [self.championData.teamNum componentsSeparatedByString:@","];
                    if ([numArray count] > i) {
                        [str appendString:[numArray objectAtIndex:i]];
                        [str appendString:@":"];
                        [str appendFormat:@"1"];
                        [str appendString:@";"];
                    }
                    
                    
                }
            }
            
     
        NSLog(@"str = %@", str);
        if ([str length] > 0) {
             [str setString:[str substringToIndex:[str length] - 1]];
        }
       
        NSLog(@"str = %@", str);
        return str;
    }
    
    
    return nil;
}

//投注欧赔
- (NSString *)touzhuOpeiReturn{
    NSMutableString * str = [[[NSMutableString alloc] init] autorelease];
    
    
        for (int i = 0; i < [self.championData.typeArray count]; i++) {
            
            if ([[self.championData.typeArray objectAtIndex:i] isEqualToString:@"1"]) {
                NSArray * numArray = [self.championData.teamNum componentsSeparatedByString:@","];
                NSArray * oddsArray = [self.championData.odds componentsSeparatedByString:@" "];
                if ([numArray count] > i && [oddsArray count] > i) {
                    [str appendString:[numArray objectAtIndex:i]];
                    [str appendString:@":"];
                    [str appendFormat:@"%@;", [oddsArray objectAtIndex:i]];
                }
                
            }
        }
    if ([str length] > 0) {
        [str setString:[str substringToIndex:[str length] - 1]];
    }
    
    NSLog(@"str2 = %@", str);
    return str;

}

- (void)requestYujiJangjin{

    NSString * passTypeSet = @"单关@iphone";
    
    NSString * danstring = @"";
    
    if ([lotteryId  isEqualToString:@"20106"]) {
       danstring = @"20106";
    }else if ([lotteryId  isEqualToString:@"20107"]){
       danstring = @"20107";
    }
    
    
    NSMutableData * postData = [[GC_HttpService sharedInstance] reqGetIssueInfo:[self issueInfoReturn] cishu:[oneLabel.text intValue] fangshi:passTypeSet shedan:danstring beishu:1 touzhuxuanxiang:[self touzhuOpeiReturn] lottrey:@"" play:@""];
    
    [yujirequest clearDelegatesAndCancel];
    
    self.yujirequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [yujirequest setRequestMethod:@"POST"];
    [yujirequest addCommHeaders];
    [yujirequest setPostBody:postData];
    [yujirequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [yujirequest setDelegate:self];
    [yujirequest setDidFinishSelector:@selector(yujiJiangjinRequest:)];
    [yujirequest startAsynchronous];
}
- (void)yujiJiangjinRequest:(ASIHTTPRequest *)mrequest{
    if ([mrequest responseData]) {
        
        YuJiJinE * yuji = [[YuJiJinE alloc] initWithResponseData:[mrequest responseData]WithRequest:mrequest];
        
        if (yuji.sysid == 3000) {
            [yuji release];
            return;
        }
        //投注界面
        GC_ShengfuInfoViewController * sheng = [[GC_ShengfuInfoViewController alloc] init];
        sheng.title = self.title;
         sheng.danfushi = 1;
        sheng.matchId = sessionNum;
        if (yuji.maxmoney == nil || [yuji.maxmoney length]== 0) {
            yuji.maxmoney = @"";
        }
        if (yuji.minmoney == nil || [yuji.maxmoney length] == 0) {
            yuji.minmoney = @"";
        }
        
        if ([lotteryId  isEqualToString:@"20106"]) {
            sheng.fenzhong = guanjunwanfa;
        }else if ([lotteryId  isEqualToString:@"20107"]){
            sheng.fenzhong = guanyajunwanfa;
        }
//        sheng.bettingArray = allcellarr;
    
        sheng.championData = championData;
        sheng.moneynum = twoLabel.text;
        sheng.zhushu = [NSString stringWithFormat:@"%d", [twoLabel.text intValue]/2];
//        sheng.jingcai = YES;
//        sheng.zhushudict = zhushuDic;
        sheng.maxmoneystr = yuji.maxmoney;
        sheng.minmoneystr = yuji.minmoney;
        
        [self.navigationController pushViewController:sheng animated:YES];
        [sheng release];
        [yuji release];
        
    }
    
}


- (void)pressCastButton:(UIButton *)sender{//投注按钮
    [self requestYujiJangjin];
    

}

- (void)httpRequestFunc{//请求
    if (!loadview) {
        loadview = [[UpLoadView alloc] init];
    }
    
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    
    NSString * idstring = @"";
    if ([lotteryId  isEqualToString:@"20106"]) {
        idstring = @"43";
    }else if ([lotteryId  isEqualToString:@"20107"]){
        idstring = @"44";
    }
    
    NSMutableData *postData = [[GC_HttpService sharedInstance] championWithLotteryId:idstring];
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [httpRequest setRequestMethod:@"POST"];
    [httpRequest addCommHeaders];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setPostBody:postData];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(reqChampionFinished:)];
    [httpRequest setDidFailSelector:@selector(requestFailed:)];
    [httpRequest startAsynchronous];

}
- (void)requestFailed:(ASIHTTPRequest *)mrequest{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
}

- (void)reqChampionFinished:(ASIHTTPRequest *)request{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    
    if ([request responseData]) {
        ChampionData *footballMatch = [[ChampionData alloc] initWithResponseData:[request responseData]WithRequest:request];
        self.championData = footballMatch;
        jiezhilabel.text = [NSString stringWithFormat:@"投注截止 %@", footballMatch.endTime];
        [footballMatch release];
    }
    [myTableView reloadData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.CP_navigation.image = UIImageGetImageFromName(@"gyjtitleimage.png");
    
  
    
    UIButton *leftItem = [Info imageBtnInitWithStr:@"dobacksjb.png" Text:@"" addTarget:self action:@selector(doBack)];
    [leftItem setImage:UIImageGetImageFromName(@"dobacksjb_1.png") forState:UIControlStateHighlighted];
	UIBarButtonItem *barBtnItem = [[[UIBarButtonItem alloc] initWithCustomView:(leftItem)] autorelease];
    
    
	self.CP_navigation.leftBarButtonItem = barBtnItem;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0, 60, 44);
    
    [btn setImage:UIImageGetImageFromName(@"sjbcaidan_1.png") forState:UIControlStateSelected];
    [btn setImage:UIImageGetImageFromName(@"sjbcaidan.png") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pressMenubutton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    [self.CP_navigation setRightBarButtonItem:rightItem];
    [rightItem release];
    
    UIImageView * bg = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bg.image= UIImageGetImageFromName(@"gyjbgimage.png");
    [self.mainView addSubview:bg];
    [bg release];
    
//    titleJieqi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
//    titleJieqi.backgroundColor = [UIColor clearColor];
//    
//    
//    UIImageView * xian1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 14, 49, 2)];
//    xian1.backgroundColor = [UIColor clearColor];
//    xian1.image = UIImageGetImageFromName(@"SZTG960.png");
//    [titleJieqi addSubview:xian1];
//    [xian1 release];
//    
//    jiezhilabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 180, 30)];
//    jiezhilabel.font = [UIFont systemFontOfSize:12];
//    jiezhilabel.textAlignment = NSTextAlignmentCenter;
//    jiezhilabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
//    jiezhilabel.backgroundColor = [UIColor clearColor];
//    jiezhilabel.text = endTime;
//    [titleJieqi addSubview:jiezhilabel];
//    [jiezhilabel release];
//
//    UIImageView * xian2 = [[UIImageView alloc] initWithFrame:CGRectMake(260, 14, 49, 2)];
//    xian2.backgroundColor = [UIColor clearColor];
//    xian2.image = UIImageGetImageFromName(@"SZTG960.png");
//    [titleJieqi addSubview:xian2];
//    [xian2 release];
//    
//    [self.mainView addSubview:titleJieqi];
//    [titleJieqi release];
    
    
    UIImageView * headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width, 75)];
    headImageView.backgroundColor = [UIColor clearColor];
    headImageView.image = UIImageGetImageFromName(@"sjbguanggaoimage.png");
    
    jiezhilabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, headImageView.frame.size.width, 18)];
    jiezhilabel.font = [UIFont systemFontOfSize:13];
    jiezhilabel.textAlignment = NSTextAlignmentCenter;
    jiezhilabel.textColor = [UIColor colorWithRed:23/255.0 green:128/255.0 blue:53/255.0 alpha:1];
    jiezhilabel.backgroundColor = [UIColor clearColor];
    jiezhilabel.text = endTime;
    [headImageView addSubview:jiezhilabel];
    [jiezhilabel release];
    
    UILabel * labelTwo = [[UILabel alloc] initWithFrame:CGRectMake(0, 38, headImageView.frame.size.width, 18)];
    labelTwo.font = [UIFont systemFontOfSize:13];
    labelTwo.textAlignment = NSTextAlignmentCenter;
    labelTwo.textColor = [UIColor colorWithRed:23/255.0 green:128/255.0 blue:53/255.0 alpha:1];
    labelTwo.backgroundColor = [UIColor clearColor];
    labelTwo.text = @"竞猜2014年巴西世界杯归属,可选择1个或多个队";
    [headImageView addSubview:labelTwo];
    [labelTwo release];

    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height - 44) style:UITableViewStylePlain];
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:myTableView];
    myTableView.tableHeaderView = headImageView;
    [headImageView release];
    [self tabBarView];
    
    [self httpRequestFunc];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (championData) {
        return [championData.typeArray count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([lotteryId  isEqualToString:@"20106"]) {
        return 63;
    }else if ([lotteryId  isEqualToString:@"20107"]){
       return 73;
    }
    
    return 0;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"SCell";
    
    ChampionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[ChampionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.delegate = self;
    cell.cellIndexPath = indexPath;
    if ([lotteryId  isEqualToString:@"20106"]) {
        cell.cellType = championCellTypeShow;
    }else if ([lotteryId  isEqualToString:@"20107"]){
        cell.cellType = championSecondPlaceCellShow;
    }
    cell.championData = championData;
    
    return cell;


}

- (void)championTableViewCell:(ChampionTableViewCell *)cell withData:(ChampionData *)data indexPath:(NSIndexPath *)indexPath selectBool:(BOOL)yesOrNo{

    
     self.championData = data;
    NSInteger count = 0;
    for (int i = 0; i < [data.typeArray count]; i++) {
        if ([[data.typeArray objectAtIndex:i] isEqualToString:@"1"]) {
            count += 1;
        }
    }
    
    if (count < 1) {
        castButton.enabled = NO;
        castButton.alpha = 0.5;
    }else{
        castButton.enabled = YES;
        castButton.alpha = 1;
    }
    
    if (count > 25) {
        caiboAppDelegate *cai = [caiboAppDelegate getAppDelegate];
        [cai showMessage:@"最多选25个结果"];
        [self.championData.typeArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
        [myTableView reloadData];
        return;
    }
   
    oneLabel.text = [NSString stringWithFormat:@"%d", (int)count];
    twoLabel.text = [NSString stringWithFormat:@"%d", (int)count*2];
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    