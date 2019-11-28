//
//  PointViewController.m
//  caibo
//
//  Created by cp365dev on 14-5-9.
//
//

#import "PointViewController.h"
#import "Info.h"
#import "CP_PTButton.h"
#import "PointInfoViewController.h"
#import "ColorView.h"
#import "CP_UIAlertView.h"
#import "GC_HttpService.h"
#import "GC_WinningInfoList.h"
#import "CP_UIAlertView.h"
#import "LotteryNum.h"
#import "ChoujiangJieXi.h"
#import "GC_LotteryUtil.h"
#import <stdlib.h>
#import <time.h>
#import <QuartzCore/QuartzCore.h>
#import "MyPointViewController.h"
#import "ExchangeViewController.h"
#import "FlagRuleViewController.h"
#import "DIZhiJieXi.h"
#import "SharedMethod.h"
#import "CP_PrizeView.h"
#import "caiboAppDelegate.h"
#import "GouCaiViewController.h"
#import "GCHeMaiInfoViewController.h"
@interface PointViewController ()

@end

@implementation PointViewController
@synthesize myRequest,myRequest2,myRequest3,myRequest4;
@synthesize ZhongJiang;
@synthesize btnName;
@synthesize choujiangMes;
@synthesize preTag;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = left;
    self.CP_navigation.titleLabel.text = @"积分";
    
//    [self showChouJiangMessage:@"123" RemoveAfter:10];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBounds:CGRectMake(0, 0, 70, 40)];
    [btn1 addTarget:self action:@selector(pointExplain) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imagevi = [[UIImageView alloc] initWithFrame:CGRectMake(30, 9, 23, 23)];
    imagevi.backgroundColor = [UIColor clearColor];
    imagevi.image = UIImageGetImageFromName(@"GC_icon8.png");
    [btn1 addSubview:imagevi];
    [imagevi release];
    
    UIBarButtonItem *barBtnItem1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    self.CP_navigation.rightBarButtonItem = barBtnItem1;
    [barBtnItem1 release];

    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImage.image = UIImageGetImageFromName(@"point_bg.png");
    backImage.frame = CGRectMake(0, 0, backImage.frame.size.width, backImage.frame.size.height);
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor clearColor];
	[self.view insertSubview:backImage atIndex:0];
    self.mainView.backgroundColor = [UIColor clearColor];
    [backImage release];
    
    //兑换彩金
    duihuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *duihuanTitle = @"兑换彩金 优惠码";
    CGSize size = CGSizeMake(320, 40);
    CGSize size1 = [duihuanTitle sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    [duihuanBtn setTitle:duihuanTitle forState:UIControlStateNormal];
    duihuanBtn.titleLabel.backgroundColor = [UIColor clearColor];
    [duihuanBtn setTitleColor:[UIColor colorWithRed:174/255.0 green:203/255.0 blue:212/255.0 alpha:1] forState:UIControlStateNormal];
    duihuanBtn.hidden = YES;
    duihuanBtn.frame = CGRectMake(205, 0, size1.width, 40);
    [duihuanBtn addTarget:self action:@selector(exChangeCaiJin) forControlEvents:UIControlEventTouchUpInside];
    duihuanBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.mainView addSubview:duihuanBtn];
    
    UIImageView *duihuanBtnxian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 26, size1.width, 1)];
    duihuanBtnxian.backgroundColor = [UIColor colorWithRed:174/255.0 green:203/255.0 blue:212/255.0 alpha:1];
    [duihuanBtn addSubview:duihuanBtnxian];
    [duihuanBtnxian release];
    
    //我的积分
    myPointBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myPointBtn.titleLabel.backgroundColor = [UIColor clearColor];
    [myPointBtn setFrame:CGRectMake(15, 0,100,40)];
    myPointBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [myPointBtn setTitleColor:[UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1] forState:UIControlStateNormal];
    [myPointBtn addTarget:self action:@selector(myJiFenPress) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:myPointBtn];
    
    myjifenImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 100, 30)];
    [myjifenImage setImage:UIImageGetImageFromName(@"myjifen.png")];
    [myPointBtn addSubview:myjifenImage];
    [myjifenImage release];
    
    UILabel *myPointLabel  =[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 50, 30)];
    myPointLabel.backgroundColor = [UIColor clearColor];
    myPointLabel.text = @"我的积分";
    myPointLabel.font = [UIFont systemFontOfSize:12.0];
    myPointLabel.textColor =[UIColor colorWithRed:150/255.0 green:214/255.0 blue:233/255.0 alpha:1];
    [myPointBtn addSubview:myPointLabel];
    [myPointLabel release];
    
    jifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 40, 30)];
    jifenLabel.text = @"0";
    jifenLabel.font = [UIFont systemFontOfSize:12];
    jifenLabel.textColor = [UIColor colorWithRed:150/255.0 green:214/255.0 blue:233/255.0 alpha:1];
    jifenLabel.backgroundColor = [UIColor clearColor];
    [myPointBtn addSubview:jifenLabel];
    [jifenLabel release];
    
    //虚线
    UIImageView *xian1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 1)];
    xian1.backgroundColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
    [self.mainView addSubview:xian1];
    [xian1 release];
    
//    UIImageView *xian2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 86, 320, 1)];
//    [xian2 setImage:UIImageGetImageFromName(@"jifen_xian.png")];
//    [self.mainView addSubview:xian2];
//    [xian2 release];


    //抽奖Btn
    btnBackImage =[[UIImageView alloc] initWithFrame:CGRectMake(15, ORIGIN_Y(xian1)+13, 290, 29)];
    [btnBackImage setImage:UIImageGetImageFromName(@"choujiangBack1.png")];
    btnBackImage.userInteractionEnabled = YES;
    [self.mainView addSubview:btnBackImage];
    [btnBackImage release];
    
    choujiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    choujiangBtn.titleLabel.backgroundColor = [UIColor clearColor];
    [choujiangBtn setTitle:@"抽奖" forState:UIControlStateNormal];
    [choujiangBtn setFrame:CGRectMake(0, 0, 145, 29)];
    [choujiangBtn setTag:101];
    [choujiangBtn addTarget:self action:@selector(ChangeView:) forControlEvents:UIControlEventTouchUpInside];
    [choujiangBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [choujiangBtn setTitleColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:245/255.0 alpha:1] forState:UIControlStateNormal];
    [btnBackImage addSubview:choujiangBtn];
    
    zhongjiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhongjiangBtn setTitle:@"中奖名单" forState:UIControlStateNormal];
    zhongjiangBtn.titleLabel.backgroundColor = [UIColor clearColor];
    [zhongjiangBtn setFrame:CGRectMake(145, 0, 145, 29)];
    [zhongjiangBtn setTag:102];
    [zhongjiangBtn setTitleColor:[UIColor colorWithRed:209/255.0 green:238/255.0 blue:251/255.0 alpha:1] forState:UIControlStateNormal];
    zhongjiangBtn.selected = NO;
    [zhongjiangBtn addTarget:self action:@selector(ChangeView:) forControlEvents:UIControlEventTouchUpInside];
    [zhongjiangBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btnBackImage addSubview:zhongjiangBtn];
    
    
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(btnBackImage)+13, 320, self.mainView.bounds.size.height - ORIGIN_Y(btnBackImage)-13)];
    myScrollView.contentSize = CGSizeMake(640, myScrollView.bounds.size.height);
    [self.mainView addSubview:myScrollView];
    myScrollView.tag = 300;
    myScrollView.pagingEnabled = YES;
    myScrollView.delegate = self;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.backgroundColor = [UIColor clearColor];
    [myScrollView release];
    
    
    xiaohaoLabel = [[ColorView alloc] init];
    xiaohaoLabel.text = @"每次抽奖消耗< - >积分";
    CGSize colorsize1 = CGSizeMake(320, 30);
    CGSize colorsize = [xiaohaoLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:colorsize1 lineBreakMode:NSLineBreakByCharWrapping];
    xiaohaoLabel.backgroundColor = [UIColor clearColor];
    xiaohaoLabel.frame = CGRectMake((320-colorsize.width)/2, 13, colorsize.width+20, 30);
    xiaohaoLabel.font = [UIFont systemFontOfSize:12];
    xiaohaoLabel.colorfont = [UIFont boldSystemFontOfSize:12];
    xiaohaoLabel.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    xiaohaoLabel.changeColor =[UIColor colorWithRed:175/255.0 green:21/255.0 blue:21/255.0 alpha:1];
    [myScrollView addSubview:xiaohaoLabel];
    [xiaohaoLabel release];
    
    //抽奖部分背景
    backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(xiaohaoLabel)-22, 320,217)];
//    [backgroundView setImage:UIImageGetImageFromName(@"jifenBack.png")];
    [backgroundView setTag:101];
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.userInteractionEnabled = YES;
    [myScrollView addSubview:backgroundView];
    [backgroundView release];
    
    
    rectArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    //全部抽奖按钮
    for (int i = 0; i < 9; i ++) {
        
        
        CP_PTButton *btn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
        if(i==0){
        
            btn.frame = CGRectMake(23, 104 , 66, 57);//1列

        }
        else if(i == 1 || i == 2){
        
            btn.frame = CGRectMake(74.5, 14.5 + 60*i , 66, 57);//1列

        }
        else if(i == 3 || i == 4 || i == 5){
            
            btn.frame = CGRectMake(126, 44 + 60* (i-3) , 66, 57);//1列

        }
        else if (i == 6 || i == 7){
        
            btn.frame = CGRectMake(177.5, 14.5 + 60* (i-5) , 66, 57);//1列

        }
        else if(i == 8){
        
            btn.frame = CGRectMake(229,104,66,57);//1列

        }
        
//        if (a%2 == 0) {
//            btn.frame = CGRectMake(23 + (a/2) * 103, 44 + 60* b, 66, 57);//1、3、5列
//        }
//        else {
//            btn.frame = CGRectMake(74.5 + (a/2) * 103, 14.5 + 60* b, 66, 57);//2、4列
//        }
//        
        
        
        
        if(i == 3){
            
            [btn loadButonImage:@"point_choujiang.png" LabelName:nil];
        }else{
            [btn loadButonImage:@"point_choujiang.png" LabelName:nil];

        }
        if (i == 4) {
            
            btn.enabled = NO;

            btn.tag = 1000;
            [btn loadButonImage:@"choujiangBtn.png" LabelName:nil];

            [btn addTarget:self action:@selector(randChoujiang) forControlEvents:UIControlEventTouchUpInside];
        }
        else {

            btn.enabled = NO;
            
        }
        
        if(i>4){

            btn.tag = 399 + i;

        }
        if(i<4){
        
            btn.tag = 400 + i;

        }

        btn.buttonName.textColor = [UIColor colorWithRed:106/255.0 green:34/255.0 blue:8/255.0 alpha:1];
        btn.buttonName.font = [UIFont systemFontOfSize:12];
        btn.buttonName.shadowColor = [UIColor clearColor];
        btn.buttonName.numberOfLines = 0;
        
        [backgroundView addSubview:btn];
        
        if(i != 4){
            
            [rectArray addObject:btn];

        }

    }

    
    UIImageView *infoImage = [[UIImageView alloc] init];
    infoImage.frame = CGRectMake(87, ORIGIN_Y(backgroundView)+23, 146, 33);
    infoImage.image = UIImageGetImageFromName(@"shengyuCJ.png");
    [myScrollView addSubview:infoImage];
    [infoImage release];
    
    infoLabel = [[ColorView alloc] init];
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.frame = CGRectMake(27, 7, 120, 18);
    infoLabel.font = [UIFont systemFontOfSize:12];
    infoLabel.textColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1];
    infoLabel.colorfont = [UIFont boldSystemFontOfSize:12];
    [infoImage addSubview:infoLabel];
    infoLabel.changeColor = [UIColor colorWithRed:230/255.0 green:165/255.0 blue:52/255.0 alpha:1];
    infoLabel.text = @"今天还能抽奖 <0> 次";
    infoLabel.textAlignment = NSTextAlignmentCenter;
    [infoLabel release];

    
    myTableView = [[UITableView alloc] init];
    myTableView.frame = CGRectMake(320, 0, 320, myScrollView.bounds.size.height);
    [myScrollView addSubview:myTableView];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.backgroundColor = [UIColor clearColor];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myTableView release];
    
    biankuangImage = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"jifen_00.png")];
    
    choujFinished = NO;
    chouJFailed = NO;

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getPointInfo];
    [super viewWillAppear:animated];

}
//中奖时间解析
-(void)WinTimeResolve
{
    NSMutableArray *mYearArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *mMouthArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *mDayArray = [[NSMutableArray alloc] initWithCapacity:0];
    mouthArray = [[NSMutableArray alloc] initWithCapacity:0];
    dayArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    ZhongJiangRen *ren = nil;
    
    for(int i = 0;i<self.ZhongJiang.zhongjiangArray.count;i++)
    {
        ren = [self.ZhongJiang.zhongjiangArray objectAtIndex:i];
        NSString *time = ren.ZhongJiangTime;
        
        NSString *year = [time substringWithRange:NSMakeRange(0, 4)];
        NSString *mouth = [time substringWithRange:NSMakeRange(5, 2)];
        mouth = [NSString stringWithFormat:@"%@月",mouth];
        NSString *day = [time substringWithRange:NSMakeRange(8, 2)];
        
        [mYearArray addObject:year];
        [mMouthArray addObject:mouth];
        [mDayArray addObject:day];
        
        [mouthArray addObject:mouth];
        [dayArray addObject:day];
        
        //如果下一个object的日期与前一个object日期相同 则将后者滞空
        if(i>0)
        {
            if([[mYearArray objectAtIndex:i] isEqualToString:[mYearArray objectAtIndex:i-1]] && [[mMouthArray objectAtIndex:i] isEqualToString:[mMouthArray objectAtIndex:i-1]] && [[mDayArray objectAtIndex:i] isEqualToString:[mDayArray objectAtIndex:i-1]])
            {
                [mouthArray replaceObjectAtIndex:i withObject:@""];
                [dayArray replaceObjectAtIndex:i withObject:@""];
            }
        }

    }
    [mYearArray release];
    [mMouthArray release];
    [mDayArray release];
}

//返回
- (void)doBack
{
	[self.navigationController popViewControllerAnimated:YES];
}
//积分说明
-(void)pointExplain
{
    PointInfoViewController *pointinfo = [[PointInfoViewController alloc] init];
    [self.navigationController pushViewController:pointinfo animated:YES];
    [pointinfo release];
//
//    CP_PrizeView *prizeView = [[CP_PrizeView alloc] initWithtitle:@"充30送30\n充30送30充30送30" andBtnName:@"立即充值" returnType:@"1" topPicID:nil lotteryID:nil];
//    prizeView.prizeType = CP_PrizeViewHongBaoType;
//    prizeView.delegate = self;
//    [prizeView show];
//    [prizeView release];
    
}
//我的积分
-(void)myJiFenPress
{
    MyPointViewController *mypoint = [[MyPointViewController alloc] init];
    [self.navigationController pushViewController:mypoint animated:YES];
    [mypoint release];
}
-(void)exChangeCaiJin
{
    ExchangeViewController *exchange = [[ExchangeViewController alloc] init];
    [self.navigationController pushViewController:exchange animated:YES];
    [exchange release];
    
}

//抽奖 、 中奖名单 按钮
-(void)ChangeView:(UIButton *)sender
{
    //抽奖
    if(sender.tag == 101)
    {
        [zhongjiangBtn setTitleColor:[UIColor colorWithRed:209/255.0 green:238/255.0 blue:251/255.0 alpha:1] forState:UIControlStateNormal];
        [choujiangBtn setTitleColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:245/255.0 alpha:1] forState:UIControlStateNormal];
        [myScrollView scrollRectToVisible:CGRectMake(0, 87, 320, self.mainView.bounds.size.height - 87) animated:YES];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView commitAnimations];
    }
    //中奖名单
    if(sender.tag == 102)
    {

        [choujiangBtn setTitleColor:[UIColor colorWithRed:209/255.0 green:238/255.0 blue:251/255.0 alpha:1] forState:UIControlStateNormal];
        [zhongjiangBtn setTitleColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:245/255.0 alpha:1] forState:UIControlStateNormal];
        [myScrollView scrollRectToVisible:CGRectMake(320, 87, 320, self.mainView.bounds.size.height - 87) animated:YES];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView commitAnimations];
    }
    
}
-(void)randChoujiang
{
    
    NSLog(@"111111111111剩余积分：%@ 抽奖次数：%ld",[[Info getInstance] jifen],(long)[[Info getInstance] choujiangcishu]);
    
    //积分不足
    if ([[[Info getInstance] jifen] doubleValue] < [[[Info getInstance] choujiangXiaohao] doubleValue]) {
        if([biankuangImage isDescendantOfView:backgroundView])
        {
            [biankuangImage removeFromSuperview];
        }

        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"温馨提示" message:@"对不起|您的积分不足,不能参与抽奖!" delegate:self cancelButtonTitle:@"赚取积分" otherButtonTitles:@"取消",nil];
        alert.alertTpye = ExchangePointFailType;
        alert.tag = 300;
        [alert show];
        [alert release];
        
        return;
    }
    //已抽奖三次
    if([[Info getInstance] choujiangcishu] == 0)
    {
        if([biankuangImage isDescendantOfView:backgroundView])
        {
            [biankuangImage removeFromSuperview];
        }
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"对不起" message:@"您今天的抽奖次数用完啦,\n明天再来吧!" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        alert.alertTpye = autoRemoveType;
        [alert show];
        [alert release];
        return;
    }
    
    
    //开始抽奖
    [self choujiang];
    
    //抽奖过程中不可再次点击抽奖
    for(CP_PTButton *btn in backgroundView.subviews){
    
        if([btn isKindOfClass:[CP_PTButton class]] && btn.tag == 1000){
        
            btn.enabled = NO;
        }
    }
    
    [self changePic:0];
}


-(void)changePic:(int)_tag{
    static CP_PTButton *hbt = nil;
    if (hbt == nil) {
        hbt = [[ CP_PTButton alloc] initWithFrame:((CP_PTButton *)[rectArray objectAtIndex:0]).frame];
        [hbt loadButonImage:@"jifen_00.png" LabelName:nil];
        [backgroundView addSubview:hbt];
        [hbt setHidden:YES];
    }
    if (hbt.superview != backgroundView) {
        [hbt removeFromSuperview];
        [backgroundView addSubview:hbt];
    }
    if(chouJFailed){
        
        [self.class cancelPreviousPerformRequestsWithTarget:self selector:@selector(changePic:) object:[NSNumber numberWithInteger:0]];
        
        //抽奖失败后抽奖按钮再次可点
        CP_PTButton *randbtn  = (CP_PTButton *)[backgroundView viewWithTag:1000];
        if([randbtn isKindOfClass:[CP_PTButton class]]){
            
            randbtn.enabled = YES;
        }
        //抽奖成功后，最后一个按钮恢复
        CP_PTButton *otherbtn  = (CP_PTButton *)[backgroundView viewWithTag:btnTag];
        if([otherbtn isKindOfClass:[CP_PTButton class]]){
            
            [otherbtn loadButonImage:@"point_choujiang.png" LabelName:[self.btnName objectAtIndex:btnTag-400]];
            
        }
        
        chouJFailed = NO;
        preTag = -1;
        return;
        
    }
    if(_tag >= 24+needPianyi+1 &&  choujFinished){
        
        [self.class cancelPreviousPerformRequestsWithTarget:self selector:@selector(changePic:) object:[NSNumber numberWithInteger:0]];
        
        //抽奖成功后抽奖按钮再次可点
        CP_PTButton *randbtn  = (CP_PTButton *)[backgroundView viewWithTag:1000];
        if([randbtn isKindOfClass:[CP_PTButton class]]){
            
            randbtn.enabled = YES;
            
        }
        //抽奖成功后，最后一个按钮恢复
        CP_PTButton *otherbtn  = (CP_PTButton *)[backgroundView viewWithTag:btnTag];
        if([otherbtn isKindOfClass:[CP_PTButton class]]){
            
            [otherbtn loadButonImage:@"point_choujiang.png" LabelName:[self.btnName objectAtIndex:btnTag-400]];
            
        }
        
        choujFinished = NO;
        
        //抽奖结果
        [self ChouJiangParseWith:self.choujiangMes];
        preTag = -1;
        return;
        
    }
    int pret = preTag;
    int curTag = _tag;
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView animateWithDuration:0.1 animations:^{
        NSArray *numArrat = [NSArray arrayWithObjects:@"403",@"405",@"407",@"406",@"404",@"402",@"400",@"401", nil];
        if (pret != -1) {
            int preNum = pret % 8;
            NSInteger ptag = [[numArrat objectAtIndex:preNum] integerValue];
            
            CP_PTButton *btn = (CP_PTButton *)[rectArray objectAtIndex:ptag-400];
            
            btnTag = (int)btn.tag;
            
            [btn loadButonImage:@"point_choujiang.png" LabelName:[self.btnName objectAtIndex:ptag - 400]];
        }
        int num =_tag%8;
        
        NSInteger tag = [[numArrat objectAtIndex:num] integerValue];
        
        CP_PTButton *btn = (CP_PTButton *)[rectArray objectAtIndex:tag-400];
        
        btnTag = (int)btn.tag;
        
        [btn loadButonImage:@"jifen_00.png" LabelName:[self.btnName objectAtIndex:tag - 400]];
        [hbt setFrame:btn.frame];
        [hbt setHidden:YES];
        hbt.buttonName.text = btn.buttonName.text;
    } completion:^(BOOL finished) {
        
        if (finished) {
            self.preTag = curTag;
            [self changePic:curTag + 1];
        }
        
    }];
    
}


//执行抽奖

-(void)choujiang
{

    backgroundView.userInteractionEnabled = NO;

    UIView *backImageV2 = [myScrollView viewWithTag:1111];
    backImageV2.userInteractionEnabled = NO;
    NSMutableData *postData = [[GC_HttpService sharedInstance] choujiangWithUserId:[[Info getInstance] userName]];
    [self.myRequest clearDelegatesAndCancel];
    self.myRequest = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [myRequest setRequestMethod:@"POST"];
    [myRequest addCommHeaders];
    [myRequest setPostBody:postData];
    [myRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myRequest setDelegate:self];
    [myRequest setDidFinishSelector:@selector(reqZhongJiangInfoFinished:)];
    [myRequest setDidFailSelector:@selector(reqZhongJiangFail:)];
    [myRequest performSelector:@selector(startAsynchronous) withObject:nil afterDelay:0.1];
    
}
// 抽奖结果
-(void)reqZhongJiangInfoFinished:(ASIHTTPRequest *)request
{
    backgroundView.userInteractionEnabled = YES;
    
    if([biankuangImage isDescendantOfView:backgroundView])
    {
        [biankuangImage removeFromSuperview];
    }
    
    ChoujiangJieXi *jiexi = [[ChoujiangJieXi alloc] initWithResponseData:[request responseData] WithRequest:request];
    if (jiexi.returnId != 3000){
        
        choujFinished = YES;
        
//        jiexi.JiangPinID = @"1";
        
        if([jiexi.JiangPinID isEqualToString:@"1"]){
        
            needPianyi = 6;
        }
        if([jiexi.JiangPinID isEqualToString:@"2"]){
            
            needPianyi = 7;
        }
        if([jiexi.JiangPinID isEqualToString:@"3"]){
            
            needPianyi = 5;
        }
        if([jiexi.JiangPinID isEqualToString:@"4"]){
            
            needPianyi = 0;
        }
        if([jiexi.JiangPinID isEqualToString:@"5"]){
            
            needPianyi = 4;
        }
        if([jiexi.JiangPinID isEqualToString:@"6"]){
            
            needPianyi = 1;
        }
        if([jiexi.JiangPinID isEqualToString:@"7"]){
            
            needPianyi = 3;
        }
        if([jiexi.JiangPinID isEqualToString:@"8"]){
            
            needPianyi = 2;
        }
        
        self.choujiangMes = jiexi;
        
        
    }
    else{
    
        //异常直接停止抽奖
        chouJFailed = YES;
        return;

    }
    [jiexi release];
    
}
//抽奖失败
- (void)reqZhongJiangFail:(ASIHTTPRequest *)request {
    backgroundView.userInteractionEnabled = YES;
    UIView *backImageV2 = [myScrollView viewWithTag:1111];
    backImageV2.userInteractionEnabled = YES;
    
    chouJFailed = YES;
    
    [[caiboAppDelegate getAppDelegate] showMessage:@"请检查您的网络后重试"];

}

-(void)ChouJiangParseWith:(ChoujiangJieXi *)jiexi{
    
    //抽奖成功后抽奖按钮再次可点
    CP_PTButton *randbtn  = (CP_PTButton *)[backgroundView viewWithTag:1000];
    if([randbtn isKindOfClass:[CP_PTButton class]]){
        
        randbtn.enabled = YES;
        
    }
    //抽奖成功后，最后一个按钮恢复
    CP_PTButton *otherbtn  = (CP_PTButton *)[backgroundView viewWithTag:btnTag];
    if([otherbtn isKindOfClass:[CP_PTButton class]]){
        
        [otherbtn loadButonImage:@"point_choujiang.png" LabelName:[self.btnName objectAtIndex:btnTag-400]];
        
    }
    
    //测试
//    jiexi.ZhongJiaState = @"1";
    if ([jiexi.ZhongJiaState isEqualToString:@"1"]){
        
        int prizeID = [[NSString stringWithFormat:@"%@",jiexi.JiangPinID] intValue];
        //测试
//        jiexi.jiangpinleixing = 2;
        if (jiexi.jiangpinleixing == 2)
        {
            if(prizeID>=1){
            
                NSMutableString *jiangpin = [NSMutableString stringWithFormat:@"%@",[self.btnName objectAtIndex:prizeID-1]];
                if([[jiangpin componentsSeparatedByString:@"\n"] count]==2){
                
                    NSRange range = [jiangpin rangeOfString:@"\n"];
                    if(range.location != NSNotFound){
                        
                        [jiangpin replaceCharactersInRange:range withString:@""];
                    }
                }
                
                [self performSelector:@selector(showjiangpinView:) withObject:jiangpin afterDelay:3];
                
                [self showChouJiangMessage:[NSString stringWithFormat:@"恭喜中奖\n%@",jiangpin] RemoveAfter:3];
            }

        }
        else if(jiexi.jiangpinleixing == 1){
            
            if(prizeID>=1){
                
                
                NSMutableString *jiangpin = [NSMutableString stringWithFormat:@"%@",[self.btnName objectAtIndex:prizeID-1]];
                if([[jiangpin componentsSeparatedByString:@"\n"] count]==2){
                    
                    NSRange range = [jiangpin rangeOfString:@"\n"];
                    if(range.location != NSNotFound){
                        
                        [jiangpin replaceCharactersInRange:range withString:@""];
                    }
                }
            
                [self showChouJiangMessage:[NSString stringWithFormat:@"恭喜中奖\n%@",jiangpin] RemoveAfter:3];
            }
    
        }
        else{
            
            [self showChouJiangMessage:@"谢谢参与" RemoveAfter:3];

        }
    }
    else if ([jiexi.ZhongJiaState isEqualToString:@"2"]) {
        [self showChouJiangMessage:@"谢谢参与" RemoveAfter:3];
    }
    else  {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:jiexi.ZhongJiaMsg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        alert.tag = 101;
        [alert release];
    }
    
    
//    UIView *backImageV2 = [myScrollView viewWithTag:1111];
//    backImageV2.userInteractionEnabled = YES;
//    
//    NSMutableArray *randArray = [GC_LotteryUtil getRandBalls:14 start:1 maxnum:14 IsRanged:NO];
//    NSMutableArray *array = [NSMutableArray arrayWithArray:[jiexi.AllName componentsSeparatedByString:@"&"]];
//    [array addObjectsFromArray:[NSArray arrayWithObjects:@"100积分",@"50积分",@"50积分",@"谢谢参与",@"谢谢参与",@"谢谢参与", nil]];
//    for (int i = 0 ; i < [randArray count]; i ++) {
//        NSInteger a = [[randArray objectAtIndex:i] integerValue];
//        if (a >= 8) {
//            a = a + 1;
//        }
//        CP_PTButton *btn = (CP_PTButton *)[backImageV2 viewWithTag:a + 99];
//        NSLog(@"%d",a + 99);
//        if (i < [array count]) {
//            btn.buttonName.text = [array objectAtIndex:i];
//        }
//        btn.selected = YES;
//    }
    if (jiexi.jifen) {
        Info *info = [Info getInstance];
        info.jifen = jiexi.jifen;
        if ([info.jifen doubleValue] < [[info choujiangXiaohao] doubleValue]) {
            infoLabel.text = @"￼您的积分不足";
        }
        else {
            infoLabel.text = [NSString stringWithFormat:@"今天还能抽奖 <%ld> 次",(long)jiexi.cishu];
            [[Info getInstance] setChoujiangcishu:jiexi.cishu];
        }
        jifenLabel.text = info.jifen;
        
        CGSize jifenSize = CGSizeMake(200, 30);
        CGSize jifenSize1 = [jifenLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:jifenSize lineBreakMode:NSLineBreakByWordWrapping];
        [myPointBtn setFrame:CGRectMake(15, 0,60+jifenSize1.width+5,40)];
        myjifenImage.frame = CGRectMake(0, 5, 60+jifenSize1.width+5, 30);
        jifenLabel.frame = CGRectMake(60, 5, jifenSize1.width, 30);
    }
    else {
        [self getPointInfo];
    }


}

//抽奖后显示结果
- (void)showChouJiangMessage:(NSString *)message RemoveAfter:(NSInteger)time {
    
    
    UIView *blackView = [[UIView alloc] init];
    blackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    blackView.frame = self.mainView.bounds;
    [self.mainView addSubview:blackView];
    [blackView release];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 196, 100, 88)];
    imageView.image = UIImageGetImageFromName(@"point_choujiang.png");
    [blackView addSubview:imageView];
    [imageView release];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:imageView.bounds];
    label.backgroundColor = [UIColor clearColor];
    label.text = message;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:106/255.0 green:34/255.0 blue:8/255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:12];
    [imageView addSubview:label];
    [label release];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        blackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];

    }];
    
    [blackView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:time];

    [self performSelector:@selector(resetChouJiang) withObject:nil afterDelay:time];
}
#pragma mark -
#pragma mark Http Request
//获取中奖列表
-(void)getWinningListWithPage:(int)page
{
    [moreCell spinnerStartAnimating];
    NSMutableData *postData = [[GC_HttpService sharedInstance] ZhongJiangMingDan:page PageCount:20];
    [self.myRequest2 clearDelegatesAndCancel];
    self.myRequest2 = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [myRequest2 setRequestMethod:@"POST"];
    [myRequest2 addCommHeaders];
    [myRequest2 setPostBody:postData];
    [myRequest2 setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myRequest2 setDelegate:self];
    [myRequest2 setDidFinishSelector:@selector(reqZhongjiangFinished:)];
    [myRequest2 startAsynchronous];

}
//获取用户积分
-(void)getPointInfo
{
    NSMutableData *postData2 = [[GC_HttpService sharedInstance] chouCiShuWithUserId:[[Info getInstance] userName]];
    [self.myRequest3 clearDelegatesAndCancel];
    self.myRequest3 = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [myRequest3 setRequestMethod:@"POST"];
    [myRequest3 addCommHeaders];
    [myRequest3 setPostBody:postData2];
    [myRequest3 setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myRequest3 setDelegate:self];
    [myRequest3 setDidFinishSelector:@selector(reqChoujiangCishuFinished:)];
    [myRequest3 startAsynchronous];
}

// 抽奖次数
- (void)reqChoujiangCishuFinished:(ASIHTTPRequest*)request {
    
    if(![request.responseString isEqualToString:@"fail"])
    {
        LotteryNum *jiexi = [[LotteryNum alloc] initWithResponseData:[request responseData] WithRequest:request];
        if (jiexi.returnId != 3000) {
            [[Info getInstance] setChoujiangcishu:jiexi.cishu];
            [[Info getInstance] setJifen:jiexi.jifen];
            [[Info getInstance] setChoujiangXiaohao:jiexi.xiaohao_once];
            Info *info = [Info getInstance];
            info.jifen = jiexi.jifen;
            if ([info.jifen doubleValue] < [jiexi.xiaohao_once doubleValue]) {
                infoLabel.text = @"￼您的积分不足";
            }
            else {
                infoLabel.text = [NSString stringWithFormat:@"今天还能抽奖 <%ld> 次",(long)jiexi.cishu];
            }
            jifenLabel.text = info.jifen;
            CGSize jifenSize = CGSizeMake(200, 30);
            CGSize jifenSize1 = [jifenLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:jifenSize lineBreakMode:NSLineBreakByWordWrapping];
            
            [myPointBtn setFrame:CGRectMake(15, 0,60+jifenSize1.width+5,40)];
            myjifenImage.frame = CGRectMake(0, 5, 60+jifenSize1.width+5, 30);
            jifenLabel.frame = CGRectMake(60, 5, jifenSize1.width, 30);
            
            
            xiaohaoLabel.text = [NSString stringWithFormat:@"每次抽奖消耗< %@ >积分",jiexi.xiaohao_once];
            if(jiexi.isCanExchange && [jiexi.isCanExchange isEqualToString:@"1"]){
                
                duihuanBtn.hidden = NO;
                
            }
            
            for(int i = 0;i<jiexi.allPrizeArray.count;i++){
            
                CP_PTButton *btn  = (CP_PTButton *)[backgroundView viewWithTag:400+i];
                if([btn isKindOfClass:[CP_PTButton class]]){
                
                    NSLog(@"btn.buttonName.text: %@",[jiexi.allPrizeArray objectAtIndex:i]);
                    btn.buttonName.text = [jiexi.allPrizeArray objectAtIndex:i];

                }
            }
            
            CP_PTButton *randbtn  = (CP_PTButton *)[backgroundView viewWithTag:1000];
            if([randbtn isKindOfClass:[CP_PTButton class]]){
                
                randbtn.enabled = YES;

            }

            self.btnName = [NSArray arrayWithArray:jiexi.allPrizeArray];
        }
        [jiexi release];
        
    }
}
#pragma mark -
#pragma mark 网络请求

//完善信息
- (void)reqWanShanFinished:(ASIHTTPRequest *)request {
    DIZhiJieXi *jiexi = [[DIZhiJieXi alloc] initWithResponseData:[request responseData] WithRequest:request];
    if ([jiexi.lingquStuse isEqualToString:@"0000"]) {
        CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"已提交"  message:@"我们会尽快把奖品发出\n请您耐心等待" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
        [self removeJiangPinView];
    }
    [jiexi release];
}
//抽奖后
- (void)resetChouJiang {
    UIView *backImageV2 = [myScrollView viewWithTag:1111];
    for (CP_PTButton *btn in backImageV2.subviews) {
        if ([btn isKindOfClass:[CP_PTButton class]]) {
            btn.selected = NO;
            btn.buttonName.text = @"";
        }
    }
    
    CP_PTButton *randbtn  = (CP_PTButton *)[backgroundView viewWithTag:1000];
    if([randbtn isKindOfClass:[CP_PTButton class]]){
        
        randbtn.enabled = YES;
        
    }
}
// 中奖名单
- (void)reqZhongjiangFinished:(ASIHTTPRequest*)request {
    [moreCell spinnerStopAnimating];
    GC_WinningInfoList *jiexi = [[GC_WinningInfoList alloc] initWithResponseData:[request responseData] WithRequest:request andlistType:POINT_WINNING_TYPE];
    if (jiexi.returnId != 3000)
    {
        if (self.ZhongJiang)
        {
            if (jiexi.curCount > 0 && jiexi.curPage > self.ZhongJiang.curPage) {
                self.ZhongJiang.curPage = jiexi.curPage;
                [self.ZhongJiang.zhongjiangArray addObjectsFromArray:jiexi.zhongjiangArray];
            }
            if ([jiexi.zhongjiangArray count] < 20) {
                [moreCell setInfoText:@"加载完毕"];
                [moreCell setType:MSG_TYPE_LOAD_NODATA];
            }
        }
        else {
            self.ZhongJiang = jiexi;
        }
    }
    [self WinTimeResolve];
    [myTableView reloadData];
    [jiexi release];
}


- (void)showjiangpinView:(NSString *)JiangPinName {
    if (jiangpinView) {
        [self removeJiangPinView];
    }
    jiangpinView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.mainView addSubview:jiangpinView];
    jiangpinView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [jiangpinView release];
    
    UIImageView *backImageV = [[UIImageView alloc] init];
    backImageV.image = [UIImageGetImageFromName(@"tanchubeijing.png") stretchableImageWithLeftCapWidth:20 topCapHeight:20];//tanchubeijing.png
    backImageV.frame = CGRectMake(30, 50, 260, 370);
    backImageV.tag = 1000;
    backImageV.center = jiangpinView.center;
    backImageV.userInteractionEnabled = YES;
    [jiangpinView addSubview:backImageV];
    [backImageV release];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 40)];
    [backImageV addSubview:lable];
    lable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    lable.font = [UIFont boldSystemFontOfSize:15];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.backgroundColor = [UIColor clearColor];
    lable.text = @"奖品";
    [lable release];
    
    UIImageView * lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, 260, 1)];
    lineImage2.backgroundColor = [UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1];
    [backImageV addSubview:lineImage2];
    [lineImage2 release];
    
    UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(13, 48, 100, 14)];
    [backImageV addSubview:lable2];
    lable2.textColor = [UIColor  colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:1];
    lable2.font = [UIFont boldSystemFontOfSize:12];
    lable2.textAlignment = NSTextAlignmentLeft;
    lable2.backgroundColor = [UIColor clearColor];
    lable2.text = @"您获得的奖品：";
    [lable2 release];
    
    UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(96, 46, 130, 18)];
    [backImageV addSubview:lable3];
    lable3.textColor = [UIColor  colorWithRed:177/255.0 green:11/255.0 blue:11/255.0 alpha:1];
    lable3.font = [UIFont boldSystemFontOfSize:16];
    lable3.textAlignment = NSTextAlignmentLeft;
    lable3.backgroundColor = [UIColor clearColor];
    lable3.text = JiangPinName;
    [lable3 release];
    
    UILabel *lable4 = [[UILabel alloc] initWithFrame:CGRectMake(13, 70, 260, 12)];
    [backImageV addSubview:lable4];
    lable4.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    lable4.font = [UIFont boldSystemFontOfSize:10];
    lable4.textAlignment = NSTextAlignmentLeft;
    lable4.backgroundColor = [UIColor clearColor];
    lable4.text = @"奖品会快递到您的手中,请填写收奖信息";
    [lable4 release];
    
    UILabel *lable5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 111, 65, 14)];
    [backImageV addSubview:lable5];
    lable5.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    lable5.font = [UIFont boldSystemFontOfSize:12];
    lable5.textAlignment = NSTextAlignmentRight;
    lable5.backgroundColor = [UIColor clearColor];
    lable5.text = @"姓名";
    [lable5 release];
    
    UILabel *lable6 = [[UILabel alloc] initWithFrame:CGRectMake(0, 151, 65, 14)];
    [backImageV addSubview:lable6];
    lable6.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    lable6.font = [UIFont boldSystemFontOfSize:12];
    lable6.textAlignment = NSTextAlignmentRight;
    lable6.backgroundColor = [UIColor clearColor];
    lable6.text = @"手机号码";
    [lable6 release];
    
    UILabel *lable7 = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, 65, 14)];
    [backImageV addSubview:lable7];
    lable7.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    lable7.font = [UIFont boldSystemFontOfSize:12];
    lable7.textAlignment = NSTextAlignmentRight;
    lable7.backgroundColor = [UIColor clearColor];
    lable7.text = @"详细地址";
    [lable7 release];
    
    UILabel *lable8 = [[UILabel alloc] initWithFrame:CGRectMake(0, 283, 65, 14)];
    [backImageV addSubview:lable8];
    lable8.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    lable8.font = [UIFont boldSystemFontOfSize:12];
    lable8.textAlignment = NSTextAlignmentRight;
    lable8.backgroundColor = [UIColor clearColor];
    lable8.text = @"邮编";
    [lable8 release];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 104, 174, 30)];
    [backImageV addSubview:imageView1];
    imageView1.image = [UIImageGetImageFromName(@"jifenshurukuang.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    imageView1.backgroundColor = [UIColor clearColor];
    [imageView1 release];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 144, 174, 30)];
    [backImageV addSubview:imageView2];
    imageView2.image = [UIImageGetImageFromName(@"jifenshurukuang.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    imageView2.backgroundColor = [UIColor clearColor];
    [imageView2 release];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 182, 174, 86)];
    [backImageV addSubview:imageView3];
    imageView3.image = [UIImageGetImageFromName(@"jifenshurukuang.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    imageView3.backgroundColor = [UIColor clearColor];
    [imageView3 release];
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 276, 174, 30)];
    [backImageV addSubview:imageView4];
    imageView4.image = [UIImageGetImageFromName(@"jifenshurukuang.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    imageView4.backgroundColor = [UIColor clearColor];
    [imageView4 release];
    
    UITextField *nameText = [[UITextField alloc] initWithFrame:CGRectMake(74, 112, 165, 14)];
    nameText.font = [UIFont boldSystemFontOfSize:12];
    nameText.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    nameText.backgroundColor = [UIColor clearColor];
    [backImageV addSubview:nameText];
    nameText.delegate = self;
    nameText.tag = 101;
//    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"true_name"] length]) {
//        nameText.text = [[[NSUserDefaults standardUserDefaults] valueForKey:@"true_name"] stringByReplacingOccurrencesOfString:@" " withString:@""];
//    }
    [nameText release];
    
    
    UITextField *mobile = [[UITextField alloc] initWithFrame:CGRectMake(74, 152, 165, 14)];
    mobile.font = [UIFont boldSystemFontOfSize:12];
    mobile.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    mobile.backgroundColor = [UIColor clearColor];
    mobile.delegate = self;
    [backImageV addSubview:mobile];
    mobile.tag = 102;
//    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"userMobile"] length]) {
//        mobile.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"userMobile"];
//    }
    [mobile release];
    
    
    UITextView *dizhi = [[UITextView alloc] initWithFrame:CGRectMake(74, 190, 165, 70)];
    dizhi.font = [UIFont boldSystemFontOfSize:12];
    dizhi.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    dizhi.backgroundColor = [UIColor clearColor];
    dizhi.delegate = self;
    [dizhi scrollRectToVisible:CGRectMake(0, 10, 200, 200) animated:NO];
    [backImageV addSubview:dizhi];
    dizhi.tag = 103;
    [dizhi release];
    
    UITextField *youbian = [[UITextField alloc] initWithFrame:CGRectMake(74, 284, 165, 14)];
    youbian.font = [UIFont boldSystemFontOfSize:12];
    youbian.delegate = self;
    youbian.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    youbian.backgroundColor = [UIColor clearColor];
    [backImageV addSubview:youbian];
    youbian.tag = 104;
    [youbian release];
    
    CP_PTButton *btn = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 326, 130, 44);
    [btn loadButonImage:@"tanchuquxiao.png" LabelName:@"取消"];
    [btn addTarget:self action:@selector(cancelJiang:) forControlEvents:UIControlEventTouchUpInside];
    
    [backImageV addSubview:btn];
    
    CP_PTButton *btn2 = [CP_PTButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(130, 326, 130, 44);
    [btn2 loadButonImage:@"tanchuquxiao.png" LabelName:@"确定"];
    [btn2 addTarget:self action:@selector(sureJiang:) forControlEvents:UIControlEventTouchUpInside];
    [backImageV addSubview:btn2];
    btn2.enabled = NO;
    btn2.buttonName.textColor = [UIColor grayColor];
    btn2.tag = 105;
    
    UIImageView * lineImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(130, backImageV.frame.size.height - 44, 1, 44)];
    lineImage3.image = UIImageGetImageFromName(@"shuxianimage.png");
    [backImageV addSubview:lineImage3];
    [lineImage3 release];
}
- (void)sureJiang:(UIButton *)sender {
    NSString *name = @"", *mobile = @"",*dizhi = @"",*youbian = @"";
    for (int i = 1; i < 5; i ++) {
        UITextField *textF = (UITextField *)[[jiangpinView viewWithTag:1000] viewWithTag:100 + i];
        if ([textF.text length] == 0) {
            CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"信息不全" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
            return;
        }
        else {
            if (i == 1) {
                name = textF.text;
            }
            else if (i == 2) {
                mobile = textF.text;
            }
            else if (i == 3) {
                dizhi = textF.text;
            }
            else if (i == 4) {
                youbian = textF.text;
            }
        }
    }
    NSMutableData *postData2 = [[GC_HttpService sharedInstance] ZhongJiangDiZhiWithUserId:[[Info getInstance] userName] Name:name Mobile:mobile Addreas:dizhi YouBian:youbian Other:@""];
    [self.myRequest4 clearDelegatesAndCancel];
    self.myRequest4 = [ASIHTTPRequest requestWithURL:[GC_HttpService sharedInstance].hostUrl];
    [myRequest4 setRequestMethod:@"POST"];
    [myRequest4 addCommHeaders];
    [myRequest4 setPostBody:postData2];
    [myRequest4 setDefaultResponseEncoding:NSUTF8StringEncoding];
    [myRequest4 setDelegate:self];
    [myRequest4 setDidFinishSelector:@selector(reqWanShanFinished:)];
    [myRequest4 startAsynchronous];
    //    [self removeJiangPinView];
}
- (void)cancelJiang:(UIButton *)sender {
 
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:nil message:@"您确定要放弃所获的奖品?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    
    [alert show];
    alert.tag = 102;
    [alert release];
}

- (void)goBuy {
    
    GouCaiViewController *gou = [[GouCaiViewController alloc] init];
    gou.title = @"购买彩票";
    GouCaiViewController *gou2 = [[GouCaiViewController alloc] init];
    gou2.title = @"购买彩票";
    gou2.fistPage = 1;
    
    GCHeMaiInfoViewController * hemaiinfotwo = [[GCHeMaiInfoViewController alloc] init];
    hemaiinfotwo.hmdtBool = YES;
    hemaiinfotwo.paixustr = @"ADC";
    hemaiinfotwo.goucaibool = YES;
    
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:gou, gou2, hemaiinfotwo, nil];
    NSMutableArray * labearr = [[NSMutableArray alloc] initWithCapacity:0];
    [labearr addObject:@"数字彩"];
    [labearr addObject:@"足篮彩"];
    [labearr addObject:@"合买大厅"];
    
    NSMutableArray * imagestring = [[NSMutableArray alloc] initWithCapacity:0];
    [imagestring addObject:@"goucaishuzibai.png"];
    [imagestring addObject:@"goucaizubai.png"];
    [imagestring addObject:@"goucaihemaibai.png"];
    
    NSMutableArray * imageg = [[NSMutableArray alloc] initWithCapacity:0];
    [imageg addObject:@"tabbg_shuzi.png"];
    [imageg addObject:@"tabbg_zulan.png"];
    [imageg addObject:@"tabbg_hemai.png"];
    
    caiboAppDelegate * aapp = [caiboAppDelegate getAppDelegate];
    
    CP_TabBarViewController * tabarvc = [[CP_TabBarViewController alloc] initWithFrame:CGRectMake(0, 0, 320, aapp.window.frame.size.height - 49) tabBarFrame:CGRectMake(0, aapp.window.frame.size.height-49, 320, 49) Controllers:controllers allButtonImageName:imagestring allLabelString:labearr allSelectImageName:imageg] ;
    tabarvc.goucaibool = YES;
    tabarvc.showXuanZheZhao = YES;
    tabarvc.selectedIndex = 0;
    tabarvc.delegateCP = self;
    
    tabarvc.navigationController.navigationBarHidden = YES;
    tabarvc.backgroundImage.backgroundColor=[UIColor colorWithRed:22/255.0 green:23/255.0 blue:25/255.0 alpha:1];
    [self.navigationController pushViewController:tabarvc animated:YES];
    
    [tabarvc release];
    [imagestring release];
    [labearr release];
    [imageg release];
    [controllers release];
    [gou release];
    [gou2 release];
    [hemaiinfotwo release];
    
    
}


#pragma mark CP_UIAlertView Delegate
-(void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"alertView : %ld",(long)alertView.tag);
    if (alertView.tag == 300) {
        if(buttonIndex == 0){
            
            [self goBuy];
            
        }
    }

}
- (void)CP_alertView:(CP_UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex returnString:(NSString *)message {
    if (alertView.tag == 101) {
        [self resetChouJiang];
    }
    else if (alertView.tag == 102) {
        if (buttonIndex == 1) {
            [self removeJiangPinView];
        }
    }
}

#pragma mark TextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string length]) {
        CP_PTButton *btn = (CP_PTButton *)[[jiangpinView viewWithTag:1000] viewWithTag:105];
        btn.enabled = YES;
        btn.buttonName.textColor = [UIColor whiteColor];
        for (int i = 1; i < 5; i++) {
            UITextField *textF = (UITextField *)[[jiangpinView viewWithTag:1000] viewWithTag:100+i];
            if ([textField.text length] == 0 & textF != textField) {
                btn.enabled = NO;
                btn.buttonName.textColor = [UIColor greenColor];
            }
        }
    }
    else {
        if ([textField.text length] == 1) {
            CP_PTButton *btn = (CP_PTButton *)[[jiangpinView viewWithTag:1000] viewWithTag:105];
            btn.enabled = NO;
            btn.buttonName.textColor = [UIColor greenColor];
        }
        
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 101) {
        if (jiangpinView) {
            jiangpinView.frame = CGRectMake(0, -90, jiangpinView.bounds.size.width, jiangpinView.bounds.size.height);
        }
    }
    if (textField.tag == 102) {
        if (jiangpinView) {
            jiangpinView.frame = CGRectMake(0, -130, jiangpinView.bounds.size.width, jiangpinView.bounds.size.height);
        }
    }

    if (textField.tag == 104) {
        if (jiangpinView) {
            jiangpinView.frame = CGRectMake(0, -260, jiangpinView.bounds.size.width, jiangpinView.bounds.size.height);
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    jiangpinView.frame = CGRectMake(0, 0, jiangpinView.bounds.size.width, jiangpinView.bounds.size.height);
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (jiangpinView) {
        jiangpinView.frame = CGRectMake(0, -220, jiangpinView.bounds.size.width, jiangpinView.bounds.size.height);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (jiangpinView) {
        jiangpinView.frame = CGRectMake(0, 0, jiangpinView.bounds.size.width, jiangpinView.bounds.size.height);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        CP_PTButton *btn = (CP_PTButton *)[[jiangpinView viewWithTag:1000] viewWithTag:105];
        btn.enabled = YES;
        btn.buttonName.textColor = [UIColor whiteColor];
        for (int i = 1; i < 5; i++) {
            UITextView *textF = (UITextView *)[[jiangpinView viewWithTag:1000] viewWithTag:100+i];
            if ([textView.text length] == 0 & textF != textView) {
                btn.enabled = NO;
                btn.buttonName.textColor = [UIColor grayColor];
            }
        }
        return NO;
    }
    if ([text length]) {
        CP_PTButton *btn = (CP_PTButton *)[[jiangpinView viewWithTag:1000] viewWithTag:105];
        btn.enabled = YES;
        btn.buttonName.textColor = [UIColor whiteColor];
        for (int i = 1; i < 5; i++) {
            UITextView *textF = (UITextView *)[[jiangpinView viewWithTag:1000] viewWithTag:100+i];
            if ([textView.text length] == 0 & textF != textView) {
                btn.enabled = NO;
                btn.buttonName.textColor = [UIColor grayColor];
            }
        }
    }
    else {
        if ([textView.text length] == 1) {
            CP_PTButton *btn = (CP_PTButton *)[[jiangpinView viewWithTag:1000] viewWithTag:105];
            btn.enabled = NO;
            btn.buttonName.textColor = [UIColor grayColor];
        }
        
    }
    return YES;
}

- (void)removeJiangPinView {
    if (jiangpinView) {
        [jiangpinView removeFromSuperview];
        jiangpinView = nil;
    }
    
}

#pragma mark -
#pragma mark - UITableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.ZhongJiang.zhongjiangArray count])
    {
        return [self.ZhongJiang.zhongjiangArray count] +1;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headerView = [[[UIView alloc] init] autorelease];
    headerView.backgroundColor = [SharedMethod getColorByHexString:@"53451c"];
    return headerView;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == [self.ZhongJiang.zhongjiangArray count]) {
        static NSString *CellIdentifier = @"Cell2";
        moreCell = (MoreLoadCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!moreCell) {
            moreCell = [[[MoreLoadCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            [moreCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [moreCell setInfoText:@"加载更多"];
        }
        
        moreCell.backgroundColor = [UIColor clearColor];
        return moreCell;
    }
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        //横线
        UIImageView *xian2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320,1)];
        xian2.tag = 98;
        xian2.backgroundColor = [SharedMethod getColorByHexString:@"53451c"];
        [cell.contentView addSubview:xian2];
        [xian2 release];
        
        //时间
        UILabel *mouthLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 12)];
        mouthLabel.textColor = [SharedMethod getColorByHexString:@"dbd5c0"];
        mouthLabel.font = [UIFont systemFontOfSize:12];
        mouthLabel.backgroundColor = [UIColor clearColor];
        mouthLabel.tag = 104;
        [cell.contentView addSubview:mouthLabel];
        [mouthLabel release];
        
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 26.5, 60, 19.5)];
        dayLabel.tag = 105;
        dayLabel.backgroundColor = [UIColor clearColor];
        dayLabel.textColor = [SharedMethod getColorByHexString:@"dbd5c0"];
        dayLabel.font = [UIFont systemFontOfSize:24];
        [cell.contentView addSubview:dayLabel];
        [dayLabel release];
        
        
        //name
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 100, 52)];
        nameLabel.font = [UIFont systemFontOfSize:15];
        [nameLabel setTag:101];
        nameLabel.textColor = [SharedMethod getColorByHexString:@"dbd5c0"];
        nameLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:nameLabel];
        [nameLabel release];
        
        //奖品
        UILabel *prizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 0, 50, 52)];
        [prizeLabel setTag:102];
        prizeLabel.backgroundColor = [UIColor clearColor];
        prizeLabel.textColor = [SharedMethod getColorByHexString:@"fbc52e"];
        prizeLabel.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:prizeLabel];
        [prizeLabel release];
        
        //类型
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 50, 52)];
        typeLabel.font = [UIFont systemFontOfSize:15];
        [typeLabel setTag:103];
        typeLabel.backgroundColor = [UIColor clearColor];
        typeLabel.textColor = [SharedMethod getColorByHexString:@"bebcb2"];
        typeLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:typeLabel];
        [typeLabel release];
        
        //列线
        UIImageView *xian1 = [[UIImageView alloc] initWithFrame:CGRectMake(59, 0, 1, 52)];
        [xian1 setTag:100];
        [cell.contentView addSubview:xian1];
        [xian1 release];
        
        if(indexPath.row == self.ZhongJiang.zhongjiangArray.count - 1)
        {
            UIImageView *xian22 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 51, 320,1)];
            xian22.tag = 99;
            xian22.backgroundColor = [SharedMethod getColorByHexString:@"53451c"];
            [cell.contentView addSubview:xian22];
            [xian22 release];
        }


        
    }
    cell.backgroundColor = [UIColor clearColor];

    ZhongJiangRen *ren = nil;
    if (indexPath.row < [self.ZhongJiang.zhongjiangArray count]) {
        ren = [self.ZhongJiang.zhongjiangArray objectAtIndex:indexPath.row];
    }

    
    if(![[mouthArray objectAtIndex:indexPath.row] isEqualToString:@""])
    {
        UILabel *mouthLabel = (UILabel *)[cell viewWithTag:104];
        mouthLabel.text = [mouthArray objectAtIndex:indexPath.row];
        
        UILabel *dayLabel = (UILabel *)[cell viewWithTag:105];
        dayLabel.text = [dayArray objectAtIndex:indexPath.row];
        
        UIImageView *xian2 = (UIImageView *)[cell viewWithTag:98];
        xian2.frame =CGRectMake(0, 0, 320,1);
        
    }
    else
    {
        UILabel *mouthLabel = (UILabel *)[cell viewWithTag:104];
        mouthLabel.text = nil;
        
        UILabel *dayLabel = (UILabel *)[cell viewWithTag:105];
        dayLabel.text = nil;
        
        UIImageView *xian2 = (UIImageView *)[cell viewWithTag:98];
        xian2.frame =CGRectMake(60, 0, 320-60,1);
    }

    
    UIImageView *shuxian = (UIImageView *)[cell viewWithTag:100];
    shuxian.backgroundColor = [SharedMethod getColorByHexString:@"53451c"];
    
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:101];
    nameLabel.text = ren.name;
    //将中奖信息分解，例：100积分 分解为100 + 积分
    NSArray *infoAllArray = [ren.zhongJiangInfo componentsSeparatedByString:@" "];
    UILabel *prizeLabel = (UILabel *)[cell viewWithTag:102];
    
    UILabel *typeLabel = (UILabel *)[cell viewWithTag:103];
    
    if(infoAllArray.count == 2)
    {
        prizeLabel.text = [infoAllArray objectAtIndex:1];

        typeLabel.text = [infoAllArray objectAtIndex:0];

    }

    
    return cell;

}
#pragma mark -
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (myTableView.contentSize.height-scrollView.contentOffset.y<=360.0) {
        if (moreCell && moreCell.type != MSG_TYPE_LOAD_NODATA) {
            [moreCell spinnerStartAnimating];
            [self getWinningListWithPage:(int)self.ZhongJiang.curPage + 1];
        }
	}
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 300)
    {
        //抽奖
        if(scrollView.contentOffset.x == 0)
        {
            [btnBackImage setImage:UIImageGetImageFromName(@"choujiangBack1.png")];

            [zhongjiangBtn setTitleColor:[UIColor colorWithRed:209/255.0 green:238/255.0 blue:251/255.0 alpha:1] forState:UIControlStateNormal];
            [choujiangBtn setTitleColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:245/255.0 alpha:1] forState:UIControlStateNormal];

        }
        //中奖名单
        else if(scrollView.contentOffset.x/320.0 == 1)
        {
            [self getWinningListWithPage:1];

            [choujiangBtn setTitleColor:[UIColor colorWithRed:209/255.0 green:238/255.0 blue:251/255.0 alpha:1] forState:UIControlStateNormal];
            [zhongjiangBtn setTitleColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:245/255.0 alpha:1] forState:UIControlStateNormal];

            [btnBackImage setImage:UIImageGetImageFromName(@"choujiangBack2.png")];

        }

    }
}
-(void)dealloc
{
    [myRequest clearDelegatesAndCancel];
    self.myRequest = nil;
    [myRequest2 clearDelegatesAndCancel];
    self.myRequest2 = nil;
    [myRequest3 clearDelegatesAndCancel];
    self.myRequest3 = nil;
    [myRequest4 clearDelegatesAndCancel];
    self.myRequest4 = nil;
    
    [biankuangImage release];
    [mouthArray release];
    [dayArray release];
    [rectArray release];

    [super dealloc];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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